/************************************************************************/
/*      Archivo:                reintegra_cta_dtn_ah.sp                 */
/*      Stored procedure:       sp_reintegra_cta_dtn_ah                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:                                                   */
/*      Fecha de escritura:                                             */
/************************************************************************/
/*                               IMPORTANTE                             */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por  escrito de COBISCorp.    */
/*  Este programa esta  protegido  por la ley de   derechos de autor    */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a COBISCorp para    */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*     REINTEGRO DE CUENTAS DTN                                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*    FECHA         AUTOR              RAZON                            */
/*  03/May/2016   Juan Tagle         MigraciÛn a CEN                    */
/************************************************************************/
use cob_ahorros
go

if exists (select 1 from sysobjects where name = 'sp_reintegra_cta_dtn_ah')
   drop proc sp_reintegra_cta_dtn_ah
go

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE proc sp_reintegra_cta_dtn_ah (
       @t_debug          char(1)     = 'N',
       @t_file           varchar(14) = null,
       @t_show_version   bit = 0,
       @i_filial         tinyint     = 1,
       @i_fecha          datetime    = null,
       @i_param1         datetime,   --Fecha Proceso
       @i_param2         char(1),    -- P-Parcial, D-Definitivo
       @i_moneda         int         = 0,
       @i_corresponsal   char(1)     = 'N',  --Req. 381 CB Red Posicionada
       @o_procesadas     int         = 0 out
)
as

declare @w_sp_name            varchar(64),
        @w_return             int,
        @w_hi_cuenta          cuenta,
        @w_fecha_fin          datetime,
        @w_fecha_mm           datetime,
        @w_num_dias           int,
        @w_msg                descripcion,
        @w_ciudad             int,
        @w_ssn                int,
        @w_procesadas         int,
        @w_fecha              datetime,
        @w_cuenta             int,
        @w_fecha_envia        datetime,
        @w_grupo              varchar(2),
        @w_long               int,
        @w_cta_banco          cuenta,
        @w_cedula             varchar(13),
        @w_tipo_cta           tinyint,
        @w_valor              money,
        @w_fecha_act          datetime,
        @w_oficina_cta        int,
        @w_clase_clte         char(1),
        @w_mon                tinyint,
        @w_cliente            int,
        @w_tipocta_super      char(1),
        @w_fecha_aux          datetime,
        @w_error              int,
        @w_ejecucion          char(1),
        @w_fecha_tmp          datetime,
        @w_categoria          char(1),
        @w_prod_banc          int,
        @w_tipocta            varchar(10),
        @w_profinal           smallint,
        @w_dias_fecenv        int,
        @w_interes            money,
        @w_fin_trim_nfs       datetime,
        @w_fecha_r_saldo      datetime,
        @w_dias_pry           int,
        @w_num_dias_desact    int,
        @w_interes_dia        money,
        @w_fecha_ant_act      datetime,
        @w_interes1           money,
        @w_periodo_dtn        smallint,
        @w_prod_bancario      varchar(50) --Req. 381 CB Red Posicionada

/*  Captura nombre de Stored Procedure  */
select @w_sp_name        = 'sp_reintegra_cta_dtn_ah'

---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
 print 'Stored Procedure= ' + @w_sp_name +  ' Version= ' + '4.0.0.0'
 return 0
end

--Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
select @w_prod_bancario = rtrim(cl_catalogo.codigo)
from cobis..cl_catalogo, cobis..cl_tabla
where cl_catalogo.tabla  = cl_tabla.codigo and
      cl_tabla.tabla     = 're_pro_banc_cb'
and   cl_catalogo.estado = 'V'

if @i_param1 is null and @i_fecha is null
begin
   --Falta parametro obligatorio
   exec cobis..sp_cerror
   @i_num       = 101114
   return 101114
end

select @w_dias_fecenv = pa_int
from  cobis..cl_parametro
where pa_nemonico = 'ENVDTN'
and   pa_producto = 'AHO'

if @@rowcount <> 1
begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
    @i_num       = 205031,
    @i_msg       = 'ERROR EN PARAMETRO GENERAL NUMERO DE DIAS PARA ENVIO A DTN'
    return 205031
end

if @i_fecha is null
   select @i_fecha = @i_param1

select @w_ejecucion = @i_param2

--Escoge el parametro de periodo para el envio DTN
select @w_periodo_dtn = pa_smallint
from  cobis..cl_parametro
where pa_nemonico = 'PERDTN'
and   pa_producto = 'AHO'

if @w_ejecucion = 'D' and
   exists(select 1 from cob_remesas..re_tesoro_nacional,
                        cob_remesas..re_reintegro_dtn
          where tn_cuenta   = ri_cta_banco
          and   tn_tipo_cta = 3
          and   ri_fecha_proceso = @i_fecha
          and   tn_estado = 'R')
begin
    /* Error: Proceso batch no Reprocesable */
    print 'EL PROCESO BATCH YA FUE EJECUTADO COMO DEFINITIVO Y NO PUEDE REPROCESARSE'
    exec cobis..sp_cerror
    @i_num       = 251109,
    @i_msg       = 'EL PROCESO BATCH YA FUE EJECUTADO COMO DEFINITIVO Y NO PUEDE REPROCESARSE'
    return 251109
end

-- REQ 322 CUENTAS INACTIVAS
if @w_ejecucion = 'P' -- Ejecucion Parcial
begin
   /* Hallar fin de trimestre mas cercano a la fecha dada */
   exec cob_ahorros..sp_fecha_fin_periodo
   @i_fecha = @i_fecha,
   @i_periodo = @w_periodo_dtn,
   @i_finsemana = 'N',
   @o_fecha_fin = @w_fecha_tmp out
   if @@error <> 0
   begin
       select @w_msg = 'ERROR ENCONTRANDO FECHA FIN DE TRIMESTRE'
       goto ERROR
   end
end

if @w_ejecucion = 'D'   -- Ejecucion Definitiva
begin
   /*** PROYECCION DIAS REINTEGRO DTN ORS 513***/
   select @w_dias_pry = pa_int
   from   cobis..cl_parametro
   where  pa_nemonico = 'RTODTN'
   and    pa_producto = 'AHO'

   if @@rowcount <> 1
   begin
      /* Error: parﬂmetro numero de d›as proyectados para reintegro DTN */
      exec cobis..sp_cerror
      @i_num       = 150006,
      @i_msg       = 'ERROR EN PARAMETRO NUMERO DE DIAS PROYECTADOS PARA REINTEGRO DTN'
      return 205031
   end

   select @i_fecha = dateadd(dd, @w_dias_pry, @i_param1)

   select @w_fecha_tmp = @i_fecha
end

-- FIN REQ 322

exec @w_return = cob_remesas..sp_fecha_habil
@i_fecha       = @w_fecha_tmp,
@i_oficina     = 1,
@i_efec_dia    = 'S',
@i_finsemana   = 'S',
@w_dias_ret    = 1,
@o_fecha_sig   = @w_fecha_aux out

if @w_return <> 0 or @@error <> 0
begin
   --Error al determinar ultimo dia habil del mes
   exec cobis..sp_cerror
   @i_num       = 201163,
   @i_msg       = 'ERROR AL DETERMINAR ULTIMO DIA HABIL DEL MES'
   return 201163
end

/*Validacion de la periodicidad de ejecucion*/
if (datepart(mm,@w_fecha_tmp) % 3) <> 0 or ((datepart(mm,@w_fecha_tmp) % 3) = 0 and convert(varchar(2),(datepart(mm,@w_fecha_aux))) = convert(varchar(2),(datepart(mm,@w_fecha_tmp))))
begin
     select @w_msg = 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE'
     goto FIN
end

/* BORRADO DE REGISTROS SI HAY REPROCESO */

delete cob_remesas..re_reintegro_dtn
where ri_cta_banco in (select tn_cuenta from cob_remesas..re_tesoro_nacional
                       where tn_estado = 'S' and tn_fecha = @w_fecha_tmp)


---------------------------
--| CARGA DE PARAMETROS |--
---------------------------

/*Ciudad Matriz de Reintegro*/

select @w_ciudad = pa_int
from cobis..cl_parametro
where pa_producto = 'CTE'
  and pa_nemonico = 'CMA'

if @@rowcount = 0
begin
   select @w_msg = 'NO SE ENCONTRO PARAMETRO DE CIUDAD MATRIZ DE REINTEGRO'
   goto ERROR
end

/* Encuentra el SSN inicial para la transaccion de servicio*/

begin tran

   select @w_ssn = se_numero
   from cobis..ba_secuencial

   if @@rowcount <> 1
   begin
      /* Error en lectura de SSN */
     select @w_msg = 'ERROR EN LA LECTURA DE SSN'
     goto ERROR
   end

   update cobis..ba_secuencial
   set se_numero = @w_ssn + 1000000

   if @@rowcount <> 1
   begin
      /* Error en actualizacion de SSN */
     select @w_msg = 'ERROR EN LA ACTUALIZACION DEL SSN'
     goto ERROR
   end

commit tran


/* Hallar ultimo dia habil del trimestre sin contar fin de semana*/
exec cob_ahorros..sp_fecha_fin_periodo
@i_fecha = @w_fecha_tmp,
@i_periodo = @w_periodo_dtn,
@o_fecha_fin = @w_fin_trim_nfs out
if @@error <> 0
begin
    select @w_msg = 'ERROR ENCONTRANDO FECHA FIN DE TRIMESTRE SIN FIN DE SEMANA'
    goto ERROR
end

exec @w_return = cob_remesas..sp_fecha_habil
@i_fecha       = @w_fin_trim_nfs,
@i_oficina     = 1,
@i_efec_dia    = 'S',
@i_finsemana   = 'S',
@w_dias_ret    = @w_dias_fecenv,
@o_fecha_sig   = @w_fecha_envia out

if @w_return <> 0 or @@error <> 0
begin
   --Error al determinar fecha de envio a dtn
   exec cobis..sp_cerror
   @i_num       = 201163,
   @i_msg       = 'ERROR AL DETERMINAR FECHA DE ENVIO A DTN'
   return 201163
end

/* Cursor que Reintegra las cuentas de la DTN*/

-- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
if @i_corresponsal = 'N'
begin
   declare cuentas_dtn cursor
   for select ah_cuenta,
       ah_cta_banco,
       ah_oficina,
       tn_ced_ruc,
       tn_tipo_cta,
       tn_grupo,
       tn_saldo_inicial,
       tn_fecha,
       ah_clase_clte,
       ah_moneda,
       ah_cliente,
       ah_tipocta_super,
       ah_categoria,
       ah_prod_banc,
       ah_tipocta,
       max(tn_fecha_act),
       tn_fecha_r_saldo
   from cob_ahorros..ah_cuenta,
       cob_remesas..re_tesoro_nacional
   where ah_cta_banco = tn_cuenta
   and ah_ced_ruc = tn_ced_ruc
   and ah_estado in ('A','C')
   and ah_filial = 1
   and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
   and ah_moneda = 0
   and tn_estado = 'S'
   and tn_fecha_act between (dateadd(mm,-3,@i_fecha)) and @i_fecha
   group by ah_cuenta, ah_cta_banco, ah_oficina, tn_ced_ruc, tn_tipo_cta, tn_grupo, tn_saldo_inicial, tn_fecha, ah_clase_clte, ah_moneda, ah_cliente, ah_tipocta_super,  ah_categoria, ah_prod_banc, ah_tipocta, tn_fecha_r_saldo
   /* Abrir el cursor para almacenar la cuentas sujetas a reintegrar de la DTN */
   /* Ubicar el primer registro para el cursor */
end
else
begin
   declare cuentas_dtn cursor
   for select ah_cuenta,
       ah_cta_banco,
       ah_oficina,
       tn_ced_ruc,
       tn_tipo_cta,
       tn_grupo,
       tn_saldo_inicial,
       tn_fecha,
       ah_clase_clte,
       ah_moneda,
       ah_cliente,
       ah_tipocta_super,
       ah_categoria,
       ah_prod_banc,
       ah_tipocta,
       max(tn_fecha_act),
       tn_fecha_r_saldo
   from cob_ahorros..ah_cuenta,
       cob_remesas..re_tesoro_nacional
   where ah_cta_banco = tn_cuenta
   and ah_ced_ruc = tn_ced_ruc
   and ah_estado in ('A','C')
   and ah_filial = 1
   and ah_moneda = 0
   and tn_estado = 'S'
   and tn_fecha_act between (dateadd(mm,-3,@i_fecha)) and @i_fecha
   group by ah_cuenta, ah_cta_banco, ah_oficina, tn_ced_ruc, tn_tipo_cta, tn_grupo, tn_saldo_inicial, tn_fecha, ah_clase_clte, ah_moneda, ah_cliente, ah_tipocta_super,  ah_categoria, ah_prod_banc, ah_tipocta, tn_fecha_r_saldo
   /* Abrir el cursor para almacenar la cuentas sujetas a reintegrar de la DTN */
   /* Ubicar el primer registro para el cursor */
end

open cuentas_dtn
fetch cuentas_dtn into
      @w_cuenta,
      @w_cta_banco,
      @w_oficina_cta,
      @w_cedula,
      @w_tipo_cta,
      @w_grupo,
      @w_valor,
      @w_fecha,
      @w_clase_clte,
      @w_mon,
      @w_cliente,
      @w_tipocta_super,
      @w_categoria,
      @w_prod_banc,
      @w_tipocta,
      @w_fecha_act,
      @w_fecha_r_saldo

/*Validacion del estado del cursor*/

if @@fetch_status = -2
begin
   close cuentas_dtn
   deallocate cuentas_dtn

   select @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS A REINTEGRAR'
   goto ERROR
end

if @@fetch_status = -1
begin
   close cuentas_dtn
   deallocate cuentas_dtn
   return 0
end

while @@fetch_status = 0
begin

  if exists ( select 1 from cob_remesas..re_reintegro_dtn
                 where ri_cuenta        = @w_cuenta
                   and ri_producto      = 4
                   and ri_fecha_corte   = @w_fecha)

     goto LEER

   select  @w_grupo   = rtrim(ltrim(@w_grupo))
   select  @w_long   = isnull(datalength(@w_grupo), 0)

   if  @w_long  = 1
       select @w_grupo = '0' + @w_grupo

   begin tran

      /* REQ 322 Obtener codigo DTN */
      exec @w_return = cob_ahorros..sp_ahcoddtn
      @i_cuenta         = @w_cta_banco,
      @i_oficina        = @w_oficina_cta,
      @i_prod_banc      = @w_prod_banc,
      @i_categoria      = @w_categoria,
      @i_tipocta        = @w_tipocta,
      @o_codigo_dtn     = @w_grupo out,
      @o_profinal       = @w_profinal out
      if @w_return <> 0
      begin
         /* Cerrar y liberar cursor */
         close cuentas_dtn
         deallocate cuentas_dtn

         /* Error en consulta de codigo para dtn */
         select @w_msg = 'ERROR CONSULTA DE CODIGO PARA DTN'
         goto ERROR
      end

      print 'calcint'
      print '@w_fecha_r_saldo ' + cast(@w_fecha_r_saldo as varchar)

      select @w_fecha_ant_act = dateadd(dd, -1, @w_fecha_r_saldo)

      print '@w_fecha_ant_act ' + cast(@w_fecha_ant_act as varchar)
      print '@w_fecha ' + cast(@w_fecha as varchar)

     -- /* INTERESES CAUSADOS DURANTE INACTIVIDAD */
     -- select @w_interes1 = isnull(sum(isnull(sd_int_hoy,0)),0)
     -- from cob_ahorros_his..ah_saldo_diario
     -- where sd_cuenta = @w_cuenta
     -- and   sd_fecha between dateadd(dd,1,@w_fecha) and @w_fecha_ant_act
     --
     -- print '@w_interes1 ' + cast(@w_interes1 as varchar)
     --
     -- select @w_interes_dia = isnull((isnull(sd_int_hoy, 0)/isnull(sd_dias,1)),0)
     -- from cob_ahorros_his..ah_saldo_diario
     -- where sd_cuenta = @w_cuenta
     -- and   sd_fecha = @w_fecha_ant_act

      select @w_num_dias_desact = datediff(dd, @w_fecha_ant_act, @w_fecha_tmp)

      select @w_interes = 0 --SOLICITUD PERIODO 4 2012

      print '@w_fecha_tmp ' + cast(@w_fecha_tmp as varchar)
      print '@w_num_dias_desact ' + cast(@w_num_dias_desact as varchar)
      print '@w_interes_dia ' + cast(@w_interes_dia as varchar)
      print '@w_interes ' + cast(@w_interes as varchar)

      insert cob_remesas..re_reintegro_dtn
             (ri_cuenta,  ri_producto,           ri_cta_banco,     ri_cedula, ri_tipo_cta, ri_grupo, ri_fecha_corte,
              ri_valor,   ri_interes,            ri_fecha_proceso, ri_estado)
      values ( @w_cuenta, 4,                     @w_cta_banco,     @w_cedula, @w_tipo_cta, @w_grupo, @w_fecha,
               @w_valor,  @w_interes,            @i_fecha,         'N')

      if @@error <> 0
      begin
         select @w_error = 257077, @w_msg = 'ERROR EN LA INSERCION EN TABLA DE REINTEGRO'
         goto ERROR1
      end /* Fin Error al insertar*/

/**************** BLOQUE ELIMINADO POR COMPENSACION DE CUENTAS CONTABLES ENTRE INACTIVAS Y TRASLADADAS ******************/
--      if @w_ejecucion = 'D'
--      begin
--         /* INTERESES */
--
--
--         /* Creacion de la transacicon de servicio para el traslado*/
--         insert into ah_tran_servicio
--         (ts_secuencial,   ts_tipo_transaccion, ts_tsfecha,      ts_usuario,     ts_terminal,
--          ts_cta_banco,    ts_filial,           ts_valor,        ts_interes,     ts_oficina,
--          ts_oficina_cta,  ts_prod_banc,        ts_causa,        ts_cod_alterno, ts_cliente,
--          ts_moneda,       ts_clase_clte,       ts_tipocta_super)
--         values
--         (@w_ssn,          376,                 @i_fecha,        'opbatch',      'consola',
--          @w_cta_banco,    @i_filial,           @w_valor * -1,   @w_interes * -1, @w_oficina_cta,
--          @w_oficina_cta,  4,                   'I',             1,               @w_cliente,
--          @w_mon,          @w_clase_clte,       @w_tipocta_super)
--
--         if @@error <> 0
--         begin
--            select @w_error = 257078, @w_msg = 'ERROR EN GRABACION TS1'
--            goto ERROR1
--         end
--
--         insert into ah_tran_servicio
--         (ts_secuencial,   ts_tipo_transaccion, ts_tsfecha, ts_usuario,     ts_terminal,
--          ts_cta_banco,    ts_filial,           ts_valor,   ts_interes,     ts_oficina,
--          ts_oficina_cta,  ts_prod_banc,        ts_causa,   ts_cod_alterno, ts_cliente,
--          ts_moneda,       ts_clase_clte,       ts_tipocta_super)
--         values
--         (@w_ssn,          377,                 @i_fecha,   'opbatch',     'consola',
--          @w_cta_banco,    @i_filial,           @w_valor,   @w_interes,     @w_oficina_cta,
--          @w_oficina_cta,  4,                   'T',        2,              @w_cliente,
--          @w_mon,          @w_clase_clte,       @w_tipocta_super)
--
--         if @@error <> 0
--         begin
--            select @w_error = 257077, @w_msg = 'ERROR EN GRABACION TS1'
--            goto ERROR1
--         end
--      end
/**************** BLOQUE ELIMINADO POR COMPENSACION DE CUENTAS CONTABLES ENTRE INACTIVAS Y TRASLADADAS ******************/
   commit tran

ERROR1:
    exec cob_ahorros..sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = 376,
    @i_cuenta      = @w_cta_banco,
    @i_descripcion = @w_msg,
    @i_rollback    = 'S'

/* Localizar el siguiente registro del cursor */
LEER:

   select @w_ssn = @w_ssn + 1
   select @w_procesadas = @w_procesadas + 1


fetch cuentas_dtn into
      @w_cuenta,
      @w_cta_banco,
      @w_oficina_cta,
      @w_cedula,
      @w_tipo_cta,
      @w_grupo,
      @w_valor,
      @w_fecha,
      @w_clase_clte,
      @w_mon,
      @w_cliente,
      @w_tipocta_super,
      @w_categoria,
      @w_prod_banc,
      @w_tipocta,
      @w_fecha_act,
      @w_fecha_r_saldo

   if @@fetch_status = -2
   begin
        close cuentas_dtn
        deallocate cuentas_dtn

        select @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
        goto ERROR
   end


end  /* Fin del While */

/* Cerrar y liberar cursor */

close cuentas_dtn
deallocate cuentas_dtn

if @w_ejecucion = 'D'
begin
   update cob_remesas..re_tesoro_nacional
   set    tn_estado           = 'R' ,
          tn_fecha_r_saldo    = @w_fecha_envia
   from   cob_remesas..re_tesoro_nacional,
          cob_remesas..re_reintegro_dtn
   where tn_cuenta   = ri_cta_banco
   and   tn_tipo_cta = 3
--   and   ri_fecha_corte = @w_fecha se comenta solo por este envio 4 periodo 2012

   if @@error <> 0
   begin
      select @w_msg = 'ERROR EN ACTUALIZACION DE ESTADO EN LA TABLA MAESTRA DE LA DTN'
      goto ERROR
   end
end

select @o_procesadas = @w_procesadas

FIN:
return 0

ERROR:

exec sp_errorlog
@i_fecha   = @i_fecha,
@i_error   = 1,
@i_usuario = 'opbatch',
@i_tran    = 0,
@i_cuenta  = '',
@i_descripcion = @w_msg

return 1

go

