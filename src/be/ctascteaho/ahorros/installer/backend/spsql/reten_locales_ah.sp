/************************************************************************/
/*      Archivo:                reten_locales_ah.sp                     */
/*      Stored procedure:       sp_reten_locales_ah                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Jaime Hidalgo                           */
/*      Fecha de escritura:     11-Dic-2002                             */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de :                    */
/*      1).- Consulta de Reservas Locales posibles de Liberar.          */
/*      2).- Liberaci=n Anticipada de Reservas Locales                  */
/*      en Cuentas de Ahorros.                                          */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA              AUTOR                   RAZON                */
/*      11/Dic/2002     J. Hidalgo       Emision Inicial                */
/*      15/Mar/2006     D. Vasquez       Consulta de cheques devueltos  */
/*      02/Mayo/2016    Juan Tagle       Migración a CEN                */
/*      08/Junio/2016   J Baque          Bug; Cuenta en estado G        */
/************************************************************************/

use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reten_locales_ah')
    drop proc sp_reten_locales_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reten_locales_ah (
@s_ssn                  int,
@s_ssn_branch           int= null,
@s_srv                  varchar(30),
@s_lsrv                 varchar(30),
@s_user                 varchar(30),
@s_sesn                 int,
@s_term                 varchar(10),
@s_date                 datetime,
@s_ofi                  smallint,
@s_rol                  smallint = 1,
@s_org_err              char(1)  = null,
@s_error                int      = null,
@s_sev                  tinyint  = null,
@s_msg                  mensaje  = null,
@s_org                  char(1),
@t_debug                char(1) = 'N',
@t_file                 char(1) =  null,
@t_from                 varchar(32) = null,
@t_rty                  char(1) = 'N',
@t_trn                  smallint,
@t_show_version         bit = 0,
@i_operacion            char(1),
@i_cta_banco            cuenta,
@i_formato_fecha        int = 101,
@i_mon                  tinyint,
@i_monto                money = 0,
@i_ciudad               int = null,
@i_fecha_depo           smalldatetime = null,
@i_fecha_efe            smalldatetime = null
) as

declare @w_sp_name              descripcion,
        @w_return               int,
        @w_tipo                 char(1),
        @w_cuenta               int,
        @w_condicion            varchar(255),
        @w_usadeci              char(1),
        @w_numdeci              tinyint,
        @w_dias_dif             int,
        @w_tipocta_super        char(1),
        @w_disponible           money,
        @w_prod_banc            smallint,
        @w_oficina              smallint,
        @w_filial               tinyint,
        @w_producto             tinyint,
        @w_alicuota             float,
        @w_promedio1            money,
        @w_prom_disp            money,
        @w_12h                  money,
        @w_24h                  money,
        @w_48h                  money,
        @w_remesas              money,
        @w_default              int,
        @w_personalizada        char(1),
        @w_valor_ciudad_dep     money,
        @w_dis_alic             money,
        @w_efectivizado         char(1),
        @w_tasa                 money,
        @w_valor_cobro          money,
        @w_tipo_prom            char(1),
        @w_categoria            char(1),
        @w_rol_ente             char(1),
        @w_tipo_def             char(1),
        @w_contable             money,
        @w_tipocta              char(1),
        @w_formato_fecha        varchar(10),
        @w_cuenta1              varchar(20),
        @w_exec                 varchar(1024),
        @w_fecha_proceso        datetime

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_reten_locales_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

select @s_ssn_branch = isnull(@s_ssn_branch,@s_ssn)

/* Validacion de la transaccion */
if @t_trn not in (331, 332)
begin
   /* Error en numero de transaccion */
   exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 151051
   return 1
end

/* Captura de la fecha proceso */
select @w_fecha_proceso = fp_fecha
from   cobis..ba_fecha_proceso

/* Encuentra datos de trabajo de la cuenta */
select @w_cuenta        = ah_cuenta
from   cob_ahorros..ah_cuenta
where  ah_cta_banco  = @i_cta_banco
and    ah_moneda     = @i_mon
and    ah_estado    <> 'G'          /* Cuenta de Gerencia */

if @w_cuenta = null or @w_cuenta = ''
begin
exec cobis..sp_cerror
   @t_debug        = @t_debug,
   @t_file         = @t_file,
   @t_from         = @w_sp_name,
   @i_num          = 357550
   return 1
end
/*Debe ingresar una cuenta diferente a estado Ingresado*/

/*** Operacion S y R ***/
if @i_operacion = 'S' or @i_operacion = 'R'
begin
   if @i_operacion = 'S'
   begin
      select @w_condicion = 'cd_fecha_efe >= ''' + convert(varchar(10), @s_date, 101) + ''''
   end
   else
   begin
      select @w_condicion = 'cd_fecha_efe > ''' + convert(varchar(10), @s_date, 101) + ''''
   end

   select @w_formato_fecha = convert (varchar(10), @i_formato_fecha)
   select @w_cuenta1 = convert (varchar(20), @w_cuenta)

   select @w_exec = ('select ''FECHA DEPOSITO''= convert (char(10), cd_fecha_depo, ' + @w_formato_fecha +  '),' +
   '''VALOR DEPOSITO''= cd_valor,'+
   '''VALOR A EFECTIVIZAR''= cd_valor_efe,'+
   '''FECHA LIBERACION''= convert (char(10), cd_fecha_efe, ' + @w_formato_fecha + '),' +
   '''CIUDAD''= cd_ciudad '+
   'from cob_ahorros..ah_ciudad_deposito ' +
   'where cd_cuenta = ' + @w_cuenta1 + " " +
   'and ' + @w_condicion + ' ' +
   'and (cd_efectivizado = ''N''  or cd_efectivizado is null or cd_efectivizado = ''S'') ' +
   'order by cd_fecha_depo, cd_fecha_efe')

--   print @w_exec
   exec (@w_exec)

   /*Consulta los cheques devueltos */
   select 'FECHA' = convert(char(10),cr_fecha_ing,@i_formato_fecha),
          'VALOR' = cr_valor,
          'BANCO' = (select substring(ba_descripcion,1,25) from cob_remesas..re_banco where ba_banco = x.cr_banco_p),
          'CUENTA CHEQUE' = cr_cta_girada,
          'CHEQUE' = cr_num_cheque,
          'CAUSA DEVOLUCION' = (select b.valor from cobis..cl_tabla a,cobis..cl_catalogo b
                     where a.tabla = 'cc_causa_dev'
                     and a.codigo = b.tabla
                     and b.codigo = x.cr_cau_devolucion)
   from cob_remesas..re_cheque_rec x
   where cr_cta_depositada = @w_cuenta
   and cr_tipo_cheque = 'L'
   and cr_producto = 4
   and cr_fecha_ing >= (select min(cd_fecha_depo) from cob_ahorros..ah_ciudad_deposito
                        where cd_cuenta = x.cr_cta_depositada
                        and (cd_efectivizado is null or cd_efectivizado = 'S'))
end

/*** Operacion L ***/
if @i_operacion = 'L'
begin
   /* Validacion de Fechas*/
   if @i_fecha_efe < @i_fecha_depo
   begin
      /* Cheque ya fue efectivizado */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 201291
      return 1
   end

   /* Encuentra parametro de decimales */
   select @w_usadeci = mo_decimales
   from  cobis..cl_moneda
   where mo_moneda = @i_mon
   if @w_usadeci = 'S'
   begin
      select @w_numdeci = pa_tinyint
        from cobis..cl_parametro
       where pa_producto = 'CTE'
         and pa_nemonico = 'DCI'
      if @@rowcount <> 1
      begin
         exec cobis..sp_cerror
              @t_debug     = @t_debug,
              @t_file      = @t_file,
              @t_from      = @w_sp_name,
              @i_num       = 201196
         return 201196
      end
   end
   else select @w_numdeci = 0

   /* Numero de dias entre las fechas actual y de efectivizacion*/
   select @w_dias_dif = datediff (dd, @s_date, @i_fecha_efe)

   select @w_cuenta        = ah_cuenta,
           @w_12h          = ah_12h,
           @w_24h          = ah_24h,
           @w_48h          = ah_48h,
           @w_remesas      = ah_remesas,
           @w_disponible   = ah_disponible,
           @w_tipo_prom    = ah_tipo_promedio,
           @w_promedio1    = ah_promedio1,
           @w_prom_disp    = ah_prom_disponible,
           @w_categoria    = ah_categoria,
           @w_prod_banc    = ah_prod_banc,
           @w_producto     = ah_producto,
           @w_tipo         = ah_tipo,
           @w_default      = ah_default,
           @w_personalizada= ah_personalizada,
           @w_filial       = ah_filial,
           @w_oficina      = ah_oficina,
           @w_rol_ente     = ah_rol_ente,
           @w_tipo_def     = ah_tipo_def,
           @w_tipocta      = ah_tipocta,
           @w_tipocta_super = ah_tipocta_super
   from cob_ahorros..ah_cuenta
   where ah_cuenta = @w_cuenta

   select @w_contable = @w_12h + @w_24h + @w_remesas +
                        @w_disponible + @w_48h

   if @i_monto > @w_24h
   begin
     /* Error */
     exec cobis..sp_cerror
     @t_debug   = @t_debug,
     @t_file    = @t_file,
     @t_from    = @w_sp_name,
     @i_num     = 201292
     return 1
   end


   select @w_valor_ciudad_dep = cd_valor_efe
   from cob_ahorros..ah_ciudad_deposito
   where cd_cuenta         = @w_cuenta
   and cd_ciudad           = @i_ciudad
   and cd_fecha_depo       = @i_fecha_depo
   and cd_fecha_efe        = @i_fecha_efe
   and cd_valor_efe        >= @i_monto
   and (cd_efectivizado    = 'N'
   or cd_efectivizado      is null)

   if @@rowcount = 0
   begin
      /* Error */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 201231
      return 1
   end

   /*Busqueda de la alicuota para el promedio*/
   select @w_alicuota = fp_alicuota
   from cob_ahorros..ah_fecha_promedio
   where fp_tipo_promedio  = @w_tipo_prom
   and fp_fecha_inicio     = @s_date


   begin tran

   /* Actualizar maestro de cuentas */
   select @w_dis_alic = convert (money, round((@i_monto * @w_alicuota), @w_numdeci))

   if @i_fecha_efe <> @w_fecha_proceso
      select @w_24h = @w_24h - @i_monto


   if @i_fecha_efe = @w_fecha_proceso
      select @w_12h = @w_12h - @i_monto


   update ah_cuenta
   set ah_disponible           = @w_disponible + @i_monto,
       ah_12h                  = @w_12h,
       ah_24h                  = @w_24h,
       ah_promedio1            = @w_promedio1 + @w_dis_alic,
       ah_prom_disponible      = @w_prom_disp + @w_dis_alic
   where ah_cuenta = @w_cuenta

   if @@error <> 0
   begin
      /* Error */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 205001
      return 1
   end

   /* Actualizar ciudad deposito */

   if @w_valor_ciudad_dep = @i_monto
      select @w_efectivizado = 'S'
   else
      select @w_efectivizado = 'N'

   update ah_ciudad_deposito
   set    cd_valor_efe    = cd_valor_efe - @i_monto
   where  cd_cuenta         = @w_cuenta
   and    cd_ciudad           = @i_ciudad
   and    cd_fecha_depo       = @i_fecha_depo
   and    cd_fecha_efe        = @i_fecha_efe
   and    cd_valor_efe        >= @i_monto
   and    (cd_efectivizado    = 'N' or cd_efectivizado     is null)

   if @@error <> 0
   begin
      /* Error */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 205052
      return 1
   end

   /* Cobrar Comision */
   exec @w_return = cob_remesas..sp_genera_costos
   @i_fecha        = @s_date,
   @i_categoria    = @w_categoria,
   @i_tipo_ente    = @w_tipocta,
   @i_rol_ente     = @w_rol_ente,
   @i_tipo_def     = @w_tipo_def,
   @i_prod_banc    = @w_prod_banc,
   @i_producto     = @w_producto,
   @i_moneda       = @i_mon,
   @i_tipo         = @w_tipo,
   @i_codigo       = @w_default,
   @i_servicio     = 'LIRE',
   @i_rubro        = '46',
   @i_disponible   = @w_disponible,
   @i_contable     = @w_contable,
   @i_promedio     = @w_promedio1,
   @i_prom_disp    = @w_prom_disp,
   @i_personaliza  = @w_personalizada,
   @i_filial       = @w_filial,
   @i_oficina      = @w_oficina,
   @o_valor_total  = @w_tasa  out

   if @w_return <> 0
       return @w_return

   --select @w_valor_cobro = @i_monto * @w_tasa * @w_dias_dif  lgr
   select @w_valor_cobro = @i_monto * @w_tasa


   /* Debito de la comision */
   if @w_valor_cobro > 0
   begin
      exec @w_return = cob_ahorros..sp_ahndc_automatica
      @s_ssn          = @s_ssn,
      @s_ssn_branch   = @s_ssn_branch,
      @s_srv          = @s_srv,
      @s_ofi          = @s_ofi,
      @s_user         = @s_user,
      @s_term         = @s_term,
      @s_rol          = @s_rol,
      @t_trn          = 264,
      @i_cta          = @i_cta_banco,
      @i_val          = @w_valor_cobro,
      @i_cau          = '5',
      @i_mon          = @i_mon,
      @i_fecha        = @s_date,
      @i_imp          = 'S'
      if @w_return <> 0
         return @w_return
   end

   /*Insercion de Transaccion de Servicio*/
   insert into ah_tran_servicio (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,
           ts_tsfecha,ts_usuario,ts_terminal,ts_ctacte,ts_cta_banco,
           ts_filial, ts_valor, ts_saldo,
           ts_moneda, ts_oficina, ts_oficina_cta,
           ts_prod_banc, ts_categoria,
           ts_tipocta_super)
   values (@s_ssn, @s_ssn_branch, @t_trn,
           @s_date,@s_user,@s_term,@w_cuenta,@i_cta_banco,
           @w_filial, @i_monto, @w_valor_ciudad_dep - @i_monto,
           @i_mon, @w_oficina, @w_oficina,
           @w_prod_banc, @w_categoria,
           @w_tipocta_super)

   if @@error <> 0
   begin
      /* Error en creacion de registro en ah_tran_servicio */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num     = 203005
      return 1
   end
   commit tran
end
return 0

go

