/************************************************************************/
/*   Archivo:            remantransf.sp                                 */
/*   Stored procedure:   sp_mant_transfer                               */
/*   Base de datos:      cob_remesas                                    */
/*   Producto:           AHORROS                                        */
/*   Fecha de escritura: Jun. 2014                                      */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno  de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales de propiedad inte-         */
/*   lectual. Su uso no  autorizado dara  derecho a COBISCorp para      */
/*   obtener ordenes  de secuestro o  retencion y para  perseguir       */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*                                                                      */
/*   Procedimiento que realiza el mantenimiento transferencia           */
/*                                                                      */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA            AUTOR             RAZON                           */
/*   24/Jun/2016      R. Sanchez       Migracion COBIS CLOUD MEXICO     */
/************************************************************************/
use cob_remesas
go


if exists (select
             1
           from   sysobjects
           where  name = 'sp_mant_transfer')
  drop proc sp_mant_transfer
go

/****** Object:  StoredProcedure [dbo].[sp_mant_transfer]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_mant_transfer(
    @s_ssn                  int,
    @s_ssn_branch           int     = null,
    @s_srv                  varchar(30)     = null,
    @s_user                 varchar(30)     = null,
    @s_sesn                 int,
    @s_term                 varchar(10),
    @s_date                 datetime,
    @s_org                  char(1),
    @s_ofi                  smallint,       /* Localidad origen transaccion */
    @s_rol                  smallint    = 1,
    @s_org_err              char(1)     = null, /* Origen de error:[A], [S] */
    @s_error                int         = null,
    @s_sev                  tinyint     = null,
    @s_msg                  mensaje     = null,
    @t_debug                char(1)     = 'N',
    @t_file                 varchar(14)     = null,
    @t_from                 varchar(32)     = null,
    @t_rty                  char(1)     = 'N',
    @t_trn                  smallint,
    @t_show_version         bit = 0,
    @i_operacion            char(1),
    @i_tipo_transfer        catalogo    = null,
    @i_cta_banco_dst        cuenta,
    @i_producto_dst         varchar(3)  = null,
    @i_nombre_dst           varchar(64) = null,
    @i_cta_banco_org        cuenta      = null,
    @i_nombre_org           varchar(64) = null,
    @i_producto_org         varchar(3)  = null,
    @i_modo                 tinyint     = 0,
    @i_fecha_desde          datetime    = null,
    @i_fecha_hasta          datetime    = null,
    @i_periodicidad         char(1)     = 'D',
    @i_dia                  tinyint     = 0,
    @i_dia_1        tinyint     = 0,
    @i_dia_2        tinyint     = 0,
    @i_monto                money       = 0,
    @i_formato_fecha        int     = 101, 
    @i_turno            smallint    = null,
    @i_estado       char(1)     = 'N',
    @i_codigo           int             = null,  /* ROL 12202006 */
    @i_contrato             int             = null,
    @i_modificable          varchar(1)      = 'S'
)
as
declare @w_return           int,
    @w_sp_name              varchar(30),
    @w_declarado            char(1),
    @w_estado               char(1),
    @w_moneda_org           tinyint,
    @w_moneda_dst           tinyint,
    @w_fecha_prox_cobro     datetime,
    @w_mes_sig              datetime,
    @w_mes_sigc             varchar(10),
    @w_dia_pri              varchar(10),
    @w_ult_dia_mes          datetime,
    @w_ciudad_matriz        int,
    @w_fecha_ult_cobro      datetime,
    @w_fecha_vigencia       datetime,
    @w_fecha_desde          datetime,
    @w_fecha_proyectada     datetime,
    @w_fecha_1              datetime,
    @w_fecha_2              datetime,
    @w_codigo_pais          char(2)


/* Captura del nombre del Store Procedure */
select @w_sp_name = 'sp_mant_transfer'


  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

select @w_codigo_pais = pa_char 
from   cobis..cl_parametro 
where  pa_nemonico = 'ABPAIS' 
and    pa_producto = 'ADM'

if @w_codigo_pais = 'CO'
   select @i_estado = 'C'

select @s_ssn_branch = isnull(@s_ssn_branch,@s_ssn)

if  @t_trn not in (713, 717, 718)
begin
   -- Error en codigo de transaccion 
   exec cobis..sp_cerror
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_num       = 201048
   return 1
end  

if @i_turno is null
    select @i_turno = @s_rol


if @i_operacion = 'I' or @i_operacion = 'U'
   begin

   if @w_codigo_pais <> 'CO'
   begin
       /* Verificar si la persona que ejecuta esta definida como ejecutor */
       if not exists (select *  from cobis..cl_funcionario,
                      cob_remesas..re_funcionario_autoriz
                      where fu_funcionario = fa_ejecutor
                        and fu_login = @s_user
                        and fa_tipo = 'D')
          begin
              exec cobis..sp_cerror
                  @t_debug        = @t_debug,
                  @t_file         = @t_file,
                  @t_from      = @w_sp_name,
                  @i_num          = 201330
             return 1
          end   ---- HASTA DEFINIR SI LA PANTALLA DE PARAMETRIZACION DE FUNCIONARIOS A AUTORIZAR SE HABILITA PARA EL CASO
   end
   /* validaciones de vigencia de cuenta  y la misma moneda */

  /* Cuenta origen  */
  if @i_producto_org = 'CTE'
            exec cob_interfase..sp_icte_select_cc_ctacte
                @i_cuenta = @i_cta_banco_org,
                @o_estado      = @w_estado out,
                @o_moneda      = @w_moneda_org  out

  else
     select @w_estado = ah_estado,
            @w_moneda_org = ah_moneda
       from cob_ahorros..ah_cuenta
      where ah_cta_banco = @i_cta_banco_org


  if @w_estado <> 'A'
     begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 201088
    return 1
     end


  /* Cuenta destino  */
  if @i_producto_dst = 'CTE'
     exec cob_interfase..sp_icte_select_cc_ctacte
     @i_cuenta = @i_cta_banco_dst,
     @o_estado = @w_estado      out,
     @o_moneda = @w_moneda_dst  out
  else
     select @w_estado = ah_estado,
            @w_moneda_dst = ah_moneda
     from  cob_ahorros..ah_cuenta
     where ah_cta_banco = @i_cta_banco_dst


   if @w_estado not in ('A','G')
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201088
      return 1
   end
  
   /*  Verifica que las cuentas tengan la misma moneda */
   if @w_moneda_org <> @w_moneda_dst
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201217
      return 1
   end

/******

   /*  Verifica que exista un registro de encabezado, definicion de cuentas destino */
   if not exists(select ta_tipo 
                   from cob_remesas..re_enca_transfer_automatica 
                  where ta_codigo           = @i_codigo
                    and ta_tipo     = @i_tipo_transfer
                    and ta_cuenta_dst   = @i_cta_banco_dst)
      begin

        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 201275
        return 1
      end

******/


   /* Verifica que no exista un registro anterior */
   if exists(select ta_tipo 
               from cob_remesas..re_transfer_automatica 
              where ta_codigo           = @i_codigo
                and ta_tipo         = @i_tipo_transfer
                and ta_cuenta_dst   = @i_cta_banco_dst
                and ta_cuenta_org   = @i_cta_banco_org) and @i_operacion = 'I'
      begin
    exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 351098
    return 1
      end

-- Obtencion del codigo de la ciudad de  feriados nacionales para el 
-- calculo de la fecha de proximo cobro                             

   select @w_ciudad_matriz = pa_int
     from cobis..cl_parametro
    where pa_producto = 'CTE'
      and pa_nemonico = 'CMA'

   if @@rowcount <> 1
      begin
        exec cobis..sp_cerror
             @i_num       = 111020,
             @i_msg       = 'ERROR EN PARAMETRO DE CIUDAD'
        return 111020
      end

-- Busca fecha de proximo cobro
   if @i_periodicidad = 'M'         -- mensual
   begin
      /* Se encuentra una fecha fija */

      if datepart(dd,@i_fecha_desde) >= @i_dia_1
      begin
         select @w_mes_sig  = dateadd(mm,1,@i_fecha_desde)
         select @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)

        -- Validacion de Fechas

        if datepart(mm,@w_mes_sigc) in (4, 6, 9, 11) and @i_dia_1 > 30
            select @i_dia_1 = 30

        if datepart(mm,@w_mes_sigc) in (1, 3, 5, 7, 8, 10, 12) and @i_dia_1 > 31
 select @i_dia_1 = 31

        -- Tipo de a±o
        if (datepart(mm, @w_mes_sigc) in (2)) 
            if ((datepart(yy, @w_mes_sigc) %4 ) = 0) and @i_dia_1 > 29
            select @i_dia_1 = 29

        if ((datepart(yy, @w_mes_sigc) %4 ) <> 0) and @i_dia_1 > 28
            select @i_dia_1 = 28

        if @i_dia_1 < 10
               select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia_1) +
                                     substring(@w_mes_sigc,6,5)
            else
               select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia_1) +
                                     substring(@w_mes_sigc,6,5)
            select  @w_ult_dia_mes = @w_dia_pri
     end
     else
     begin
        select  @w_mes_sigc = convert(varchar(10),@i_fecha_desde,101)

        -- Validacion de Fechas

        if datepart(mm,@w_mes_sigc) in (4, 6, 9, 11) and @i_dia_1 > 30
            select @i_dia_1 = 30

        if datepart(mm,@w_mes_sigc) in (1, 3, 5, 7, 8, 10, 12) and @i_dia_1 > 31
            select @i_dia_1 = 31

        -- Tipo de a±o
        if (datepart(mm, @w_mes_sigc) in (2)) 
        begin
            if ((datepart(yy, @w_mes_sigc) %4 ) = 0) and @i_dia_1 > 29
                select @i_dia_1 = 29

            if ((datepart(yy, @w_mes_sigc) %4 ) <> 0) and @i_dia_1 > 28
                select @i_dia_1 = 28
        end

            if @i_dia_1 < 10
                select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia_1) +
                                    substring(@w_mes_sigc,6,5)
            else
                    select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia_1) +
                                        substring(@w_mes_sigc,6,5)
            select  @w_ult_dia_mes = @w_dia_pri
          end  
      end
    else    
      begin
        if @i_periodicidad = 'D'    -- Diaria
           begin


        select @i_dia = datepart(dd,@i_fecha_desde)

            if datepart(dd,@i_fecha_desde) > @i_dia
            begin

                    select  @w_mes_sig = dateadd(mm,1,@i_fecha_desde)
                select  @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)
                
            if @i_dia < 10
                        select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia) +
                                            substring(@w_mes_sigc,6,5)
                else
                        select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia) +
                                            substring(@w_mes_sigc,6,5)
                select  @w_ult_dia_mes = @w_dia_pri


            end
            else
            begin
               select  @w_mes_sigc = convert(varchar(10),@i_fecha_desde,101)

               if @i_dia < 10
                       select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia) +
                                           substring(@w_mes_sigc,6,5)
               else
                       select  @w_dia_pri  =   substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia) +
                                           substring(@w_mes_sigc,6,5)
               select  @w_ult_dia_mes = @w_dia_pri
            end  
         end
         else
         begin
            if @i_periodicidad = 'Q'    -- Quincenal
            begin
               select  @w_fecha_1 = dateadd(mm, 1, @i_fecha_desde),
                       @w_fecha_2 = dateadd(mm, 1, @i_fecha_desde)
               
               /* Si el primer dia a aplicar es mayor o igual a la fecha desde, usar ese dia como dia de aplicacion*/
               if @i_dia_1 >= datepart(dd,@i_fecha_desde) 
               begin
                  select  @w_mes_sigc = convert(varchar(10),@i_fecha_desde,101)

                  if @i_dia_1 < 10
                     select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia_1) +
                                           substring(@w_mes_sigc,6,5)
                  else
                     select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia_1) +
                                           substring(@w_mes_sigc,6,5)
                  select  @w_ult_dia_mes = @w_dia_pri
                  select  @w_fecha_1     = @w_ult_dia_mes
               end
               else
               begin 
                  /* si el primer dia a aplicar no entra en la fecha de vigencia, aplicar por el segundo dia */   
                  select  @w_mes_sig  = dateadd(mm,1,@i_fecha_desde)
                  select  @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)
                  select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '01' + substring(@w_mes_sigc,6,5)
                  select  @w_fecha_1  = dateadd(dd,(@i_dia_1-1),@w_dia_pri)
                  select  @w_ult_dia_mes  = @w_fecha_1
                
                  if @i_dia_2 >= datepart(dd,@i_fecha_desde) --Si el dia ingresado es mayor que el ultimo dia, tomar el ultimo dia del mes                
                  begin
                     select  @w_mes_sigc = convert(varchar(10),@i_fecha_desde,101)
                     if @i_dia_2 < 10
                        select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia_2) +
                                              substring(@w_mes_sigc,6,5)
                     else
                        select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia_2) +
                                              substring(@w_mes_sigc,6,5)
                     select @w_ult_dia_mes = @w_dia_pri
                     select  @w_fecha_2    = @w_ult_dia_mes
                  end
               end

               if @w_fecha_1 <= @w_fecha_2
                  select @w_ult_dia_mes = @w_fecha_1
               else
                  select @w_ult_dia_mes = @w_fecha_2

            end -- @i_periodicidad = 'Q'
         end
      end

      -- Dias calendario, para calculo de las nuevas fechas
      if @i_periodicidad = 'M'
          select @w_fecha_proyectada = @w_ult_dia_mes

      -- Revisa feriados nacionales
      while 1 = 1
      begin
         if exists (select 1 from cobis..cl_dias_feriados
                    where df_ciudad  = @w_ciudad_matriz
                    and   df_fecha   = @w_ult_dia_mes)
            select @w_ult_dia_mes = dateadd(dd, 1, @w_ult_dia_mes)
         else
            break
      end
      select @w_fecha_prox_cobro = @w_ult_dia_mes

     if @w_fecha_prox_cobro > @i_fecha_hasta
     begin
        -- Error en fechas
        exec cobis..sp_cerror
        @t_debug   = @t_debug,
        @t_file    = @t_file,
        @t_from    = @w_sp_name,
        @i_num     = 201333
        return 201333
     end

     -- Dias calendario, para calculo de las nuevas fechas
     if @i_periodicidad <> 'M'
        select @w_fecha_proyectada = @w_ult_dia_mes
  end  /*  Fin de @i_operacion = 'I' or @i_operacion = 'U'  */

  if @i_operacion = 'I'
  begin
     begin tran
     insert into cob_remesas..re_transfer_automatica 
            (ta_codigo ,ta_tipo, ta_cuenta_dst, ta_producto_dst, ta_nombre_dst, 
             ta_cuenta_org, ta_producto_org, ta_nombre_org, ta_periodicidad, ta_dia, ta_monto,
             ta_fecha_desde, ta_fecha_hasta, ta_fecha_ult_cobro, ta_moneda, ta_fecha_prox_cobro,
             ta_total_debitado, ta_error, ta_fecha_proyectada)
     values (@i_codigo,@i_tipo_transfer, @i_cta_banco_dst, @i_producto_dst, @i_nombre_dst,
             @i_cta_banco_org, @i_producto_org, @i_nombre_org, @i_periodicidad, @i_dia, @i_monto, 
             @i_fecha_desde, @i_fecha_hasta, '01/01/1900', @w_moneda_org,  @w_fecha_prox_cobro,
              0, 0, @w_fecha_proyectada)

     if @@error != 0
     begin
        -- Error en creacion de registro de transferencia
        exec cobis..sp_cerror
        @t_debug   = @t_debug,
        @t_file    = @t_file,
        @t_from    = @w_sp_name,
        @i_num     = 203071
        return 203071
    end

    -- Insercion de transaccion de servicio
    insert into  cob_interfase..cc_tstran_servicio
          (ts_secuencial,    ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,     ts_usuario,    
           ts_terminal,      ts_reentry,    ts_oficina,          ts_origen,      ts_cta_banco, 
           ts_nombre,        ts_moneda,     ts_estado,           ts_oficina_cta, ts_monto,
           ts_prod_banc,     ts_categoria,  ts_cta_asociada,     ts_nombre1,     ts_fecha_uso, 
           ts_fecha_ven,     ts_fecha_aper)
    values(@s_ssn,           @s_ssn_branch, @t_trn,              @s_date,        @s_user,          
           @s_term,          @t_rty,        @s_ofi,              @s_org,         @i_cta_banco_org, 
           @i_nombre_org,    @w_moneda_org, null,                null,           @i_monto,
           null,             null,          @i_cta_banco_dst,    @i_nombre_dst,  @i_fecha_desde, 
           @i_fecha_hasta,   @w_fecha_prox_cobro)

   if @@error != 0
   begin
      -- Error en creacion de transaccion de servicio
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 203005
      return 203005
   end

   -- Actualizacion del Estado en Tabla de Cabecera
   if @i_estado = 'I' or @i_estado = 'N'
   begin
      update cob_remesas..re_enca_transfer_automatica
      set   ta_estado       = @i_estado,
            ta_usuario_crea = @s_user
      where ta_codigo     = @i_codigo
      and   ta_tipo       = @i_tipo_transfer
      and   ta_cuenta_dst = @i_cta_banco_dst

      if @@error != 0 or @@rowcount <> 1
      begin
         -- Error en actualizaci¾n de estado de la cabecera
         exec cobis..sp_cerror
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 201334
         return 201334
      end
   end
   commit tran
   return 0
end

if @i_operacion = 'D'    -- Delete
begin
   begin tran
   -- Verifica que el registro exista
   if exists(select ta_tipo 
             from cob_remesas..re_transfer_automatica 
             where ta_codigo     = @i_codigo
             and   ta_tipo       = @i_tipo_transfer
             and   ta_cuenta_dst = @i_cta_banco_dst
             and   ta_cuenta_org = @i_cta_banco_org)
   begin
      delete cob_remesas..re_transfer_automatica 
      where  ta_codigo  = @i_codigo
      and    ta_tipo = @i_tipo_transfer
      and    ta_cuenta_dst = @i_cta_banco_dst
      and    ta_cuenta_org = @i_cta_banco_org

    if @@error != 0
    begin
       -- Error en eliminacion de registro de transferencia
       exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file  = @t_file,
       @t_from  = @w_sp_name,
       @i_num   = 207030
       return 203066
    end

      -- Insercion de transaccion de servicio
      insert into  cob_interfase..cc_tstran_servicio
           (ts_secuencial, ts_ssn_branch, ts_tipo_transaccion, ts_tsfecha,
           ts_usuario, ts_terminal, ts_reentry, ts_oficina, ts_origen,
           ts_cta_banco, ts_nombre, ts_moneda, ts_estado, ts_oficina_cta, ts_monto,
           ts_prod_banc, ts_categoria, ts_cta_asociada,ts_nombre1, ts_fecha_uso, ts_fecha_ven, 
           --ts_capitalizacion, ts_turno,
           ts_carta)
      values (@s_ssn, @s_ssn_branch, @t_trn, @s_date,
           @s_user, @s_term, @t_rty, @s_ofi, @s_org,
           @i_cta_banco_org, @i_nombre_org, @w_moneda_org, null, null, @i_monto,
           null, null, @i_cta_banco_dst, @i_nombre_dst, @i_fecha_desde, @i_fecha_hasta, 
           --@i_periodicidad, @i_turno,
           @i_codigo)

      if @@error != 0
      begin
        -- Error en creacion de transaccion de servicio
         exec cobis..sp_cerror
         @t_debug     = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 203005
         return 203005
      end

      -- Actualizacion del Estado en Tabla de Cabecera
      update cob_remesas..re_enca_transfer_automatica
      set    ta_estado = @i_estado
      where  ta_codigo = @i_codigo
      and    ta_tipo       = @i_tipo_transfer
      and    ta_cuenta_dst = @i_cta_banco_dst

      if @@error != 0 or @@rowcount <> 1
      begin
         -- Error en actualizaci¾n de estado de la cabecera
         exec cobis..sp_cerror
         @t_debug   = @t_debug,
         @t_file    = @t_file,
         @t_from    = @w_sp_name,
         @i_num     = 201334
         return 201334
      end
   end
   else
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201278
      return 1
   end
   commit tran
   return 0
end

if @i_operacion = 'S'   -- Consulta
begin
   --Busqueda de transferencias registradas
   set rowcount 20
   if @i_modo = 0
   begin
      select  
      'PRODUCTO'       = ta_producto_org,
      'CUENTA DESTINO' = ta_cuenta_org,
      'NOMBRE'         = ta_nombre_org,
      'VALOR'          = ta_monto,
      'PROX. COBRO'    = convert(varchar(10),ta_fecha_prox_cobro,@i_formato_fecha),
--    'ULTIMO COBRO'   = convert(varchar(10),ta_fecha_ult_cobro,@i_formato_fecha),
      'ULTIMO COBRO'   = 
          CASE
             WHEN ta_fecha_ult_cobro = '01/01/1900' THEN ''
             ELSE convert(varchar(10),ta_fecha_ult_cobro,@i_formato_fecha)
          END,  
      'TOTAL DEBITADO' = ta_total_debitado,
      'No. DE ERROR '  = ta_error
      from  cob_remesas..re_transfer_automatica a
      where ta_codigo       = @i_codigo
      and   ta_cuenta_dst   = @i_cta_banco_dst
      and   ta_tipo         = @i_tipo_transfer
      order by ta_tipo, ta_cuenta_dst, ta_cuenta_org
   end
   else
   begin
      select  
      'PRODUCTO'        = ta_producto_org,
      'CUENTA DESTINO'  = ta_cuenta_org,
      'NOMBRE'          = ta_nombre_org,
      'VALOR'           = ta_monto,
      'PROX. COBRO'     = convert(varchar(10),ta_fecha_prox_cobro,@i_formato_fecha),
--    'ULTIMO COBRO'    = convert(varchar(10),ta_fecha_ult_cobro,@i_formato_fecha),
      'ULTIMO COBRO'    = 
          CASE
             WHEN ta_fecha_ult_cobro = '01/01/1900' THEN ''
             ELSE convert(varchar(10),ta_fecha_ult_cobro,@i_formato_fecha)
          END,  
      'TOTAL DEBITADO '   = ta_total_debitado,
      'No. DE ERROR '     = ta_error
      from  cob_remesas..re_transfer_automatica
      where ta_codigo     = @i_codigo
      and   ta_tipo       = @i_tipo_transfer
      and   ta_cuenta_dst = @i_cta_banco_dst
      and ta_cuenta_org > @i_cta_banco_org
      or (ta_cuenta_dst = @i_cta_banco_dst and ta_cuenta_org > @i_cta_banco_org)
      order by ta_tipo, ta_cuenta_dst, ta_cuenta_org
   end
   set rowcount 0
   return 0
end

if @i_operacion = 'U'    -- Update
begin
   select @w_fecha_ult_cobro = ta_fecha_ult_cobro, 
          @w_fecha_vigencia  = ta_fecha_desde
   from cob_remesas..re_transfer_automatica 
   where ta_codigo   = @i_codigo
     and ta_tipo = @i_tipo_transfer
     and ta_cuenta_dst = @i_cta_banco_dst
     and ta_cuenta_org = @i_cta_banco_org

   if @@rowcount <> 1
   begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 201278
      return 1
   end

   if @w_fecha_ult_cobro = '01-01-1900'
      select @w_fecha_desde = @w_fecha_vigencia
   else
      select @w_fecha_desde = @w_fecha_ult_cobro
   
   -- Busca fecha de proximo cobro
   if @i_periodicidad = 'M'        -- mensual
   begin
      select  @w_mes_sig = dateadd(mm,1,@w_fecha_desde)
 select  @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)
      select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '01' +
                            substring(@w_mes_sigc,6,5)
      select  @w_ult_dia_mes = dateadd(dd,-1,convert(datetime,@w_dia_pri))

   end
   else     --  Periodicidad Diaria, el FE garantiza solo estas dos opciones M/D
   begin
      if datepart(dd,@w_fecha_desde)  > @i_dia
      begin
         select  @w_mes_sig = dateadd(mm,1,@w_fecha_desde)
         select  @w_mes_sigc = convert(varchar(10),@w_mes_sig,101)
         if @i_dia < 10
             select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia) +
                           substring(@w_mes_sigc,6,5)
         else
             select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia) +
                           substring(@w_mes_sigc,6,5)
         select  @w_ult_dia_mes = @w_dia_pri
      end
      else
      begin
         select  @w_mes_sigc = convert(varchar(10),@w_fecha_desde,101)
         if @i_dia < 10
             select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + '0' + convert(varchar(1),@i_dia) +
                           substring(@w_mes_sigc,6,5)
         else
             select  @w_dia_pri  = substring(@w_mes_sigc,1,3) + convert(varchar(2),@i_dia) +
                           substring(@w_mes_sigc,6,5)
         select  @w_ult_dia_mes = @w_dia_pri
      end  
   end

    -- Revisa feriados nacionales
    while 1 = 1
    begin
       if exists (select 1 from cobis..cl_dias_feriados
                  where df_ciudad  = @w_ciudad_matriz
                  and   df_fecha   = @w_ult_dia_mes)
          select @w_ult_dia_mes = dateadd(dd, 1, @w_ult_dia_mes)
       else
          break
    end
    select @w_fecha_prox_cobro = @w_ult_dia_mes

    begin tran
  
       update cob_remesas..re_transfer_automatica 
       set 
           ta_nombre_dst =  @i_nombre_dst,
           ta_nombre_org =  @i_nombre_org,
           ta_contrato   =  @i_contrato,
           ta_fecha_desde = @i_fecha_desde,
           ta_fecha_hasta = @i_fecha_hasta,
           ta_periodicidad = @i_periodicidad,
           ta_dia          = @i_dia,
           ta_monto        = @i_monto,
           ta_fecha_prox_cobro = @w_fecha_prox_cobro
       where ta_codigo     = @i_codigo    /*  ROL 12202006 */ 
       and   ta_tipo       = @i_tipo_transfer
       and   ta_cuenta_dst = @i_cta_banco_dst
       and   ta_cuenta_org = @i_cta_banco_org

       if @@error != 0
       begin
          -- Error en actualizaci=n de registro de transferencia
          exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 207030
          return 203066
       end


       -- Actualizacion el usuario que realizo el cambio
       update cob_remesas..re_enca_transfer_automatica
       set   ta_usuario_crea = @s_user
       where ta_codigo = @i_codigo
       and   ta_tipo   = @i_tipo_transfer
       and   ta_cuenta_dst = @i_cta_banco_dst

       if @@error != 0 or @@rowcount <> 1
       begin
          -- Error en actualizaci¾n de estado de la cabecera
          exec cobis..sp_cerror
          @t_debug   = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 201334
          return 201334
       end

       -- Insercion de transaccion de servicio
       insert into  cob_interfase..cc_tstran_servicio
           (ts_secuencial,   ts_ssn_branch,  ts_tipo_transaccion, ts_tsfecha,       ts_clase,
           ts_usuario,       ts_terminal,    ts_reentry,          ts_oficina,       ts_origen,
           ts_cta_banco,     ts_nombre,      ts_moneda,           ts_estado,        ts_oficina_cta, 
           ts_monto,         ts_prod_banc,   ts_categoria,        ts_cta_asociada,  ts_nombre1, 
           ts_fecha_uso,     ts_fecha_ven,  ts_fecha_aper,       ts_carta)         
       values(@s_ssn,           @s_ssn_branch,  @t_trn,              @s_date,          'U',
           @s_user,          @s_term,        @t_rty,              @s_ofi,           @s_org,
           @i_cta_banco_org, @i_nombre_org,  @w_moneda_org,       null,             null, 
           @i_monto,         null,           null,                @i_cta_banco_dst, @i_nombre_dst, 
           @i_fecha_desde,   @i_fecha_hasta, @w_fecha_prox_cobro, @i_codigo)  /* ROL 12202006  SE AGREGO @i_codigo */

       if @@error != 0
       begin
          -- Error en creacion de transaccion de servicio
          exec cobis..sp_cerror
          @t_debug   = @t_debug,
          @t_file    = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 203005
          return 203005
       end
   commit tran
   return 0
end



go

