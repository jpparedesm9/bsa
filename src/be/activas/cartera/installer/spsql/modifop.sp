/************************************************************************/
/*      Archivo:                modifop.sp                              */
/*      Stored procedure:       sp_modificar_operacion                  */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           Fabian de la Torre, Rodrigo Garces      */
/*      Fecha de escritura:     Ene. 1998                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA".                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Modifica una operacion de Cartera con sus rubros asociados y su */
/*      tabla de amortizacion                                           */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      LRE  05/Ene/2017                Incluir concepto de Agrupamiento*/
/*                                      de Operaciones                  */
/************************************************************************/

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_modificar_operacion')
    drop proc sp_modificar_operacion
go
create proc sp_modificar_operacion
   @s_user                       login         = null,
   @s_sesn                       int           = null,
   @s_date                       datetime      = null,
   @s_term                       varchar(30)   = null,
   @s_ofi                        smallint      = null,
   @i_calcular_tabla             char(1)       = 'N',
   @i_tabla_nueva                char(1)       = 'S',
   @i_operacionca                int           = null,
   @i_banco                      cuenta        = null,
   @i_anterior                   cuenta        = null,
   @i_migrada                    cuenta        = null,
   @i_tramite                    int           = null,
   @i_cliente                    int           = null,
   @i_nombre                     descripcion   = null,
   @i_sector                     catalogo      = null,
   @i_toperacion                 catalogo      = null,
   @i_oficina                    smallint      = null,
   @i_moneda                     tinyint       = null,
   @i_comentario                 varchar(255)  = null,
   @i_oficial                    smallint      = null,
   @i_fecha_ini                  datetime      = null,
   @i_fecha_fin                  datetime      = null,
   @i_fecha_ult_proceso          datetime      = null,
   @i_fecha_pri_cuot             datetime      = null,
   @i_fecha_liq                  datetime      = null,
   @i_fecha_reajuste             datetime      = null,
   @i_monto                      money         = null,
   @i_monto_aprobado             money         = null,
   @i_destino                    catalogo      = null,
   @i_lin_credito                cuenta        = null,
   @i_ciudad                     int           = null,
   @i_estado                     tinyint       = null,
   @i_periodo_reajuste           smallint      = null,
   @i_reajuste_especial          char(1)       = null,
   @i_tipo                       char(1)       = null,
   @i_forma_pago                 catalogo      = null,
   @i_cuenta                     cuenta        = null,
   @i_dias_anio                  smallint      = null,
   @i_tipo_amortizacion          varchar(10)   = null,
   @i_cuota_completa             char(1)       = null,
   @i_tipo_cobro                 char(1)       = null,
   @i_tipo_reduccion             char(1)       = null,
   @i_aceptar_anticipos          char(1)       = null,
   @i_precancelacion             char(1)       = null,
   @i_tipo_aplicacion            char(1)       = null,
   @i_tplazo                     catalogo      = null,
   @i_plazo                      int           = null,
   @i_tdividendo                 catalogo      = null,
   @i_periodo_cap                int           = null,
   @i_periodo_int                int           = null,
   @i_dist_gracia                char(1)       = null,
   @i_gracia_cap                 int           = null,
   @i_gracia_int                 int           = null,
   @i_dia_fijo                   int           = null,
   @i_cuota                      money         = null,
   @i_evitar_feriados            char(1)       = null,
   @i_num_renovacion             int           = null,
   @i_renovacion                 char(1)       = null,
   @i_mes_gracia                 tinyint       = null,
   @i_formato_fecha              int           = 101,
   @i_upd_clientes               char(1)       = null,
   @i_dias_gracia                smallint      = null,
   @i_reajustable                char(1)       = null,
   @i_dias_clausula              int           = null,
   @i_periodo_crecimiento        smallint      = null,
   @i_tasa_crecimiento           float         = null,
   @i_control_tasa               char(1)       = 'S',
   @i_direccion                  tinyint       = null,
   @i_opcion_cap                 char(1)       = null,
   @i_tasa_cap                   float         = null,
   @i_dividendo_cap              smallint      = null,
   @i_tipo_cap                   char(1)       = null,
   @i_clase_cartera              catalogo      = null,
   @i_tipo_crecimiento           char(1)       = null,
   @i_num_reest                  int           = null,
   @i_base_calculo               char(1)       = null,
   @i_ult_dia_habil              char(1)       = null,
   @i_recalcular                 char(1)       = null,
-- @i_tasa_equivalente           char(1)       = null,
   @i_origen_fondos              catalogo      = null,
   @i_fondos_propios             char(1)       = 'N' ,
   @i_ref_exterior               cuenta        = null,
   @i_sujeta_nego                char(1)       = null,
   @i_num_operacion_cex          cuenta        = null,
   @i_ref_red                    varchar(24)   = null,
   @i_tipo_redondeo              tinyint       = null,
   @i_tipo_empresa               catalogo      = null,
   @i_validacion                 catalogo      = null,
   @i_causacion                  char(1)       = null,
   @i_tramite_ficticio           int           = null,
   @i_grupo_fact                 int           = null,
   @i_convierte_tasa             char(1)       = null,
   @i_usar_tequivalente          char(1)       = null,
   @i_bvirtual                   char(1)       = null,
   @i_extracto                   char(1)       = null,
   @i_fec_embarque               datetime      = null,
   @i_fec_dex                    datetime      = null,
   @i_num_deuda_ext              cuenta        = null,
   @i_num_comex                  cuenta        = null,
   @i_pago_caja                  char(1)       = null,
   @i_nace_vencida               char(1)       = null,
   @i_calcula_devolucion         char(1)       = null,
   @i_oper_pas_ext               varchar(64)   = null,
   @i_reestructuracion           char(1)       = null,
   @i_mora_retroactiva           char(1)       = null,
   @i_prepago_desde_lavigente    char(1)       = null,
   @i_valida_param               char(1)       = null,
   @i_tasa             		      float		     = null,
   @i_grupal                     char(1)       = null     --LRE 06/ENE/2017
as

declare
   @w_sp_name          descripcion,
   @w_return           int,
   @w_error            int,
   @w_toperacion       catalogo, -- LGU para controlar interciclos
   @w_sector_cli       catalogo,
   @w_sector_ger       catalogo,
   @w_concepto_interes catalogo,
   @w_tasa_aplicar     catalogo,
   @w_porcentaje       float,
   @w_tasa_referencial catalogo,
   @w_modalidad        char(1),
   @w_periodicidad     char(1),
   @w_operacionca      int,
   @w_sector           char(1),
   @w_tdividendo       char(1),
   @w_fpago            char(1),
   @w_opt_direccion    tinyint,
   @w_tasa_equivalente char(1),
   @w_est_novigente    smallint,
   @w_estado_op        int

select @w_tasa_equivalente    = null

if @i_fecha_pri_cuot is null
   select @i_fecha_pri_cuot = @i_fecha_ini

-- CODIGO DEL RUBRO INT
select @w_concepto_interes = pa_char
from   cobis..cl_parametro
where  pa_nemonico = 'INT'
and    pa_producto = 'CCA'
set transaction isolation level read uncommitted

-- CARGAR VALORES INICIALES
select @w_sp_name = 'sp_modificar_operacion'

/* ESTADOS DE CARTERA */
exec @w_error = sp_estados_cca
@o_est_novigente  = @w_est_novigente out

--OBTENCION DE LA PRIMERA DIRECCION DEL CLIENTE
set rowcount 1

if @i_direccion is null
   select @w_opt_direccion = opt_direccion
   from ca_operacion_tmp
   where opt_banco = @i_banco

if @w_opt_direccion is not null
   select @i_direccion = @w_opt_direccion
else begin
   select @i_direccion = di_direccion
   from cobis..cl_direccion
   where di_ente   = @i_cliente
   and di_vigencia = 'S'
   order by di_direccion
   set transaction isolation level read uncommitted
end

set rowcount 0

-- CONTROL DE LA TASA IBC ANTES DE CREAR LA OP

select
@w_operacionca      = opt_operacion,
@w_sector           = opt_sector,
@w_tdividendo       = opt_tdividendo,
@w_estado_op        = opt_estado,
@w_toperacion       = opt_toperacion -- LGU para controlar interciclos
from ca_operacion_tmp
where opt_banco      = @i_banco

--LGU-INI: 2017-06-30  levanta control
/**********************
if exists (select 1 from ca_desembolso
           where dm_operacion = @w_operacionca
           and dm_estado      in ('I','NA')) and
   -- LGU para que no valide en el caso de interciclo
   NOT exists(select 1 from cobis..cl_tabla t, cobis..cl_catalogo c where t.tabla = 'ca_interciclo' and t.codigo = c.tabla and c.codigo = @w_toperacion)
begin
   select @w_error = 710473
   goto ERROR
end
********************/

-- Solo valida matrices para operaciones en estado por desembolsar -- Cuando este sp es llamado desde FrontEnd
if @w_estado_op != @w_est_novigente
   select @i_valida_param = 'N'

select
@w_tasa_aplicar     = rot_referencial,
@w_porcentaje       = rot_porcentaje,
@w_fpago            = rot_fpago
from ca_rubro_op_tmp
where rot_operacion = @w_operacionca
and   rot_concepto  = @w_concepto_interes

select @w_tasa_referencial = vd_referencia
from ca_valor_det
where vd_tipo   =  @w_tasa_aplicar
and   vd_sector =  @w_sector

select
@w_modalidad         = tv_modalidad,
@w_periodicidad      = tv_periodicidad
from ca_tasa_valor
where tv_nombre_tasa = @w_tasa_referencial
and tv_estado        = 'V'

if @w_tasa_referencial = 'TCERO' begin
   if @w_fpago = 'P'
      select @w_modalidad = 'V'

   if @w_fpago = 'A'
      select @w_modalidad = 'A'

   select  @w_periodicidad = @w_tdividendo
end

exec @w_return    = sp_rubro_control_ibc
@i_operacionca    = @w_operacionca,
@i_concepto       = @w_concepto_interes,
@i_porcentaje     = @w_porcentaje,
@i_periodo_o      = @w_periodicidad,
@i_modalidad_o    = @w_modalidad,
@i_num_periodo_o  = 1

if @w_return != 0 begin
   print 'modifop...Mensaje Informativo Tasa Total de Interes supera el maximo permitido..'
   print '@w_return' + cast(@w_return as varchar(20))
   --select @w_error = 710094
   --goto   ERROR
end


begin tran
   exec @w_return = sp_modificar_operacion_int
   @s_user                      = @s_user,
   @s_sesn                      = @s_sesn,
   @s_date                      = @s_date,
   @s_term                      = @s_term,
   @s_ofi                       = @s_ofi,
   @i_calcular_tabla            = @i_calcular_tabla,
   @i_tabla_nueva               = @i_tabla_nueva,
   @i_operacionca               = @i_operacionca,
   @i_banco                     = @i_banco,
   @i_anterior                  = @i_anterior,
   @i_migrada                   = @i_migrada,
   @i_tramite                   = @i_tramite,
   @i_cliente                   = @i_cliente,
   @i_nombre                    = @i_nombre,
   @i_sector                    = @i_sector,
   @i_toperacion                = @i_toperacion,
   @i_oficina                   = @i_oficina,
   @i_moneda                    = @i_moneda,
   @i_comentario                = @i_comentario,
   @i_oficial                   = @i_oficial,
   @i_fecha_ini                 = @i_fecha_ini,
   @i_fecha_fin                 = @i_fecha_fin,
   @i_fecha_ult_proceso         = @i_fecha_ini,  ----@i_fecha_ult_proceso,
   @i_fecha_liq                 = @i_fecha_liq,
   @i_fecha_reajuste            = @i_fecha_reajuste,
   @i_monto                     = @i_monto,
   @i_monto_aprobado            = @i_monto_aprobado,
   @i_destino                   = @i_destino,
   @i_lin_credito               = @i_lin_credito,
   @i_ciudad                    = @i_ciudad,
   @i_estado                    = @i_estado,
   @i_periodo_reajuste          = @i_periodo_reajuste,
   @i_reajuste_especial         = @i_reajuste_especial,
   @i_tipo                      = @i_tipo,
   @i_forma_pago                = @i_forma_pago,
   @i_cuenta                    = @i_cuenta,
   @i_dias_anio                 = @i_dias_anio,
   @i_tipo_amortizacion         = @i_tipo_amortizacion,
   @i_cuota_completa            = @i_cuota_completa,
   @i_tipo_cobro                = @i_tipo_cobro,
   @i_tipo_reduccion            = @i_tipo_reduccion,
   @i_aceptar_anticipos         = @i_aceptar_anticipos,
   @i_precancelacion            = @i_precancelacion,
   @i_tipo_aplicacion           = @i_tipo_aplicacion,
   @i_tplazo                    = @i_tplazo,
   @i_plazo                     = @i_plazo,
   @i_tdividendo                = @i_tdividendo,
   @i_periodo_cap               = @i_periodo_cap,
   @i_periodo_int               = @i_periodo_int,
   @i_dist_gracia               = @i_dist_gracia,
   @i_gracia_cap                = @i_gracia_cap,
   @i_gracia_int                = @i_gracia_int,
   @i_dia_fijo                  = @i_dia_fijo,
   @i_fecha_pri_cuot            = @i_fecha_pri_cuot,
   @i_cuota                     = @i_cuota,
   @i_evitar_feriados           = @i_evitar_feriados,
   @i_num_renovacion            = @i_num_renovacion,
   @i_renovacion                = @i_renovacion,
   @i_mes_gracia                = @i_mes_gracia,
   @i_formato_fecha             = @i_formato_fecha,
   @i_upd_clientes              = @i_upd_clientes,
   @i_dias_gracia               = @i_dias_gracia,
   @i_reajustable               = @i_reajustable,
   @i_dias_clausula             = @i_dias_clausula,
   @i_periodo_crecimiento       = @i_periodo_crecimiento,
   @i_tasa_crecimiento          = @i_tasa_crecimiento,
   @i_control_tasa              = @i_control_tasa,
   @i_direccion                 = @i_direccion,
   @i_opcion_cap                = @i_opcion_cap,
   @i_tasa_cap                  = @i_tasa_cap,
   @i_dividendo_cap             = @i_dividendo_cap,
   @i_tipo_cap                  = @i_tipo_cap,
   @i_tipo_crecimiento          = @i_tipo_crecimiento,
   @i_num_reest                 = @i_num_reest,
   @i_base_calculo              = @i_base_calculo,
   @i_ult_dia_habil             = @i_ult_dia_habil,
   @i_recalcular                = @i_recalcular,
   @i_tasa_equivalente          = @w_tasa_equivalente,   --@i_tasa_equivalente,
   @i_clase_cartera             = @i_clase_cartera,
   @i_tipo_empresa              = @i_tipo_empresa,
   @i_validacion                = @i_validacion,
   @i_origen_fondos             = @i_origen_fondos,
   @i_fondos_propios            = @i_fondos_propios,
   @i_ref_exterior              = @i_ref_exterior,
   @i_sujeta_nego               = @i_sujeta_nego,
   @i_ref_red                   = @i_ref_red,
   @i_tipo_redondeo             = @i_tipo_redondeo,
   @i_causacion                 = @i_causacion,
   @i_tramite_ficticio          = @i_tramite_ficticio,
   @i_grupo_fact                = @i_grupo_fact,
   @i_convierte_tasa            = @i_convierte_tasa,
-- @i_tasa_equivalente          = @i_tasa_equivalente,
   @i_bvirtual                  = @i_bvirtual,
   @i_extracto                  = @i_extracto,
   @i_fec_embarque              = @i_fec_embarque,
   @i_fec_dex                   = @i_fec_dex,
   @i_num_deuda_ext             = @i_num_deuda_ext,
   @i_num_comex                 = @i_num_comex,
   @i_pago_caja                 = @i_pago_caja,
   @i_nace_vencida              = @i_nace_vencida,
   @i_calcula_devolucion        = @i_calcula_devolucion,
   @i_oper_pas_ext              = @i_oper_pas_ext,
   @i_reestructuracion          = @i_reestructuracion,
   @i_mora_retroactiva          = @i_mora_retroactiva,
   @i_prepago_desde_lavigente   = @i_prepago_desde_lavigente,
   @i_valida_param              = @i_valida_param,
   @i_tasa                      = @i_tasa,
   @i_grupal                    = @i_grupal                 --LRE 06/ENE/2017

   if @w_return != 0 begin
      select @w_error = @w_return
      goto   ERROR
   end

  if not exists(select 1
                from ca_operacion_tmp
                where opt_banco = @i_banco)
   begin
      select @w_error  = 701049
      goto ERROR
   end


commit tran

return 0

ERROR:

exec  cobis..sp_cerror
      @t_debug  = 'N',
      @t_file   = null,
      @t_from   = @w_sp_name,
      @i_num    = @w_error
--      @i_cuenta = @i_banco

return @w_error

go

