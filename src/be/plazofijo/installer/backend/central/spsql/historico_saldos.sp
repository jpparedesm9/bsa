/************************************************************************/
/*      Archivo:                bt_histsal.sp                           */
/*      Stored procedure:       sp_historico_saldos                     */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo Fijo                              */
/*      Disenado por:           Humberto Ayarza                      	*/
/*      Fecha de documentacion: 28-Jul-2006                             */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*	GLOBAL BANK CORPORATION, creado para el proyecto Avance Global. */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Gerencia del Departamento de Tecnología o su representante.     */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este script crea el procedimiento para el pase historico mensual*/
/*      de la cartera ACT, XACT y VEN del modulo de Plazo Fijo. 	*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA		AUTOR           RAZON                        	*/
/* 	28-Jul-2006	H.Ayarza	Emision Inicial			*/
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists(select 1 from cob_pfijo..sysobjects where name = 'sp_historico_saldos' and type = 'P')
   drop proc sp_historico_saldos
go
create proc sp_historico_saldos(
        @s_ssn                  int         = NULL,
        @s_user                 login       = NULL,
        @s_term                 varchar(30) = NULL,
        @s_date                 datetime    = NULL,
        @s_srv                  varchar(30) = NULL,
        @s_lsrv                 varchar(30) = NULL,
        @s_ofi                  smallint    = NULL,
        @s_rol                  smallint    = NULL,
        @t_debug                char(1)     = NULL,
        @t_file                 varchar(10) = NULL,
        @t_trn                  int         = NULL,
        @i_fecha_proceso        datetime    = NULL
)
with encryption
as
declare
        @w_sp_name              descripcion,
        @w_return               int,
        @w_error                int,
        @w_secuencial           int,
        @w_ssn                  int,
        @w_fecha_hoy            datetime,
        @w_rc_fecha_inicio_dia  datetime,
        @w_rc_fecha_final_dia   datetime,
        @w_rc_fecha_fin_mes     datetime,
        @w_fecha_proceso        datetime,
        @w_formato_fecha        int,
        @w_fecha_laborable      datetime,        
        @w_mensaje              descripcion,
        @w_registros		int,
        @w_rowcount		int

/*---------*/
/*  DEBUG  */
/*---------*/
select @w_sp_name       = 'sp_historico_saldos',
       @s_user          = isnull(@s_user,'sa'),
       @s_term          = isnull(@s_term,'CONSOLA'),
       @s_date          = isnull(@s_date,@i_fecha_proceso),	
       @s_srv           = isnull(@s_srv,@@servername),
       @s_lsrv          = isnull(@s_lsrv,@@servername),
       @s_ofi           = 99,
       @s_rol           = 1,
       @t_debug         ='N',
       @t_file          ='SQR',
       @t_trn           = 14999,
       @i_fecha_proceso = isnull(@i_fecha_proceso,@s_date)

----------------------------
-- Obtener formato de fecha
----------------------------
select @w_formato_fecha = pa_int
  from cobis..cl_parametro
 where pa_nemonico = 'FORF'
   and pa_producto = 'PFI'

select @w_error = 0, @w_return = 0, @w_mensaje = ''


-------------------------------------------------
-- Obtener parametros de la tabla pf_reg_control
-------------------------------------------------
select @w_rc_fecha_final_dia   =  rc_fecha_final_dia,
       @w_rc_fecha_inicio_dia  =  rc_fecha_inicio_dia,
       @w_rc_fecha_fin_mes     =  rc_fecha_fin_mes
  from pf_reg_control

select @w_rc_fecha_final_dia    = convert(datetime,convert(varchar,@w_rc_fecha_final_dia,101)),
       @w_rc_fecha_inicio_dia 	= convert(datetime,convert(varchar,@w_rc_fecha_inicio_dia,101)),
       @w_fecha_proceso 	= convert(datetime,convert(varchar,@i_fecha_proceso,101))

if @w_rc_fecha_inicio_dia  <> @w_fecha_proceso
begin
  select @w_error = 149027
  goto ERROR
end

select @w_registros = count(1) from cob_pfijo..pf_operacion
where op_num_banco > '0000'
  and op_estado in ('ACT','XACT','VEN')

begin tran

delete cob_pfijo..pf_his_mensual where hm_fecha = @w_fecha_proceso

insert into pf_his_mensual(
	 hm_fecha,hm_num_banco,hm_operacion,hm_ente
	,hm_toperacion,hm_categoria,hm_estado,hm_producto
	,hm_oficina,hm_moneda,hm_num_dias,hm_base_calculo
	,hm_monto,hm_monto_pg_int,hm_monto_pgdo,hm_monto_blq
	,hm_tasa,hm_tasa_efectiva,hm_int_ganado,hm_int_estimado
	,hm_residuo,hm_int_pagados,hm_int_provision,hm_total_int_ganados
	,hm_total_int_pagados,hm_total_int_estimado,hm_total_int_retenido,hm_total_retencion
	,hm_fpago,hm_ppago,hm_dia_pago,hm_casilla
	,hm_direccion,hm_telefono,hm_historia,hm_duplicados
	,hm_renovaciones,hm_incremento,hm_mon_sgte,hm_pignorado
	,hm_renova_todo,hm_imprime,hm_retenido,hm_retienimp
	,hm_totalizado,hm_tcapitalizacion,hm_oficial,hm_accion_sgte
	,hm_preimpreso,hm_tipo_plazo,hm_tipo_monto,hm_causa_mod
	,hm_descripcion,hm_fecha_valor,hm_fecha_ven,hm_fecha_cancela
	,hm_fecha_ingreso,hm_fecha_pg_int,hm_fecha_ult_pg_int,hm_ult_fecha_calculo
	,hm_fecha_crea,hm_fecha_mod,hm_fecha_total,hm_puntos
	,hm_total_int_acumulado,hm_tasa_mer,hm_ced_ruc,hm_plazo_ant
	,hm_fecven_ant,hm_tot_int_est_ant,hm_fecha_ord_act,hm_mantiene_stock
	,hm_stock,hm_emision_inicial,hm_moneda_pg,hm_impuesto
	,hm_num_imp_orig,hm_impuesto_capital,hm_retiene_imp_capital,hm_ley
	,hm_reestruc,hm_fecha_real,hm_ult_fecha_cal_tasa,hm_num_dias_gracia
	,hm_prorroga_aut,hm_tasa_variable,hm_mnemonico_tasa,hm_modalidad_tasa
	,hm_periodo_tasa,hm_descr_tasa,hm_operador,hm_spread
	,hm_estatus_prorroga,hm_num_prorroga,hm_anio_comercial,hm_flag_tasaefec
	,hm_comision,hm_porc_comision,hm_cupon,hm_categoria_cupon
	,hm_custodia,hm_nueva_tasa,hm_incremento_prorroga,hm_puntos_prorroga
	,hm_scontable,hm_captador,hm_aprobado,hm_bloqueo_legal
	,hm_monto_blqlegal,hm_ult_fecha_calven,hm_prov_pendiente,hm_residuo_prov
	,hm_int_total_prov_vencida,hm_int_prov_vencida,hm_tipo_tasa_var,hm_oficial_principal
	,hm_oficial_secundario,hm_origen_fondos,hm_proposito_cuenta,hm_producto_bancario1
	,hm_producto_bancario2,hm_revision_tasa,hm_dias_reales,hm_plazo_orig
	,hm_sec_incre,hm_renovada,hm_int_ajuste,hm_tasa_ant
	,hm_cambio_tasa,hm_plazo_cont,hm_incre,hm_tasa_min
	,hm_tasa_max,hm_camb_oper,hm_fecha_ult_renov,hm_fecha_ult_pago_int_ant
	,hm_ente_corresp,hm_contador_firma,hm_condiciones,hm_localizado
	,hm_fecha_localizacion,hm_fecha_no_localiza,hm_inactivo,hm_dias_hold
	,hm_sucursal,hm_incremento_suspenso,hm_oficina_apertura,hm_oficial_apertura
	,hm_toperacion_apertura,hm_tipo_plazo_apertura,hm_tipo_monto_apertura
)
select
	 @w_fecha_proceso,op_num_banco,op_operacion,op_ente
	,op_toperacion,op_categoria,op_estado,op_producto
	,op_oficina,op_moneda,op_num_dias,op_base_calculo
	,op_monto,op_monto_pg_int,op_monto_pgdo,op_monto_blq
	,op_tasa,op_tasa_efectiva,op_int_ganado,op_int_estimado
	,op_residuo,op_int_pagados,op_int_provision,op_total_int_ganados
	,op_total_int_pagados,op_total_int_estimado,op_total_int_retenido,op_total_retencion
	,op_fpago,op_ppago,op_dia_pago,op_casilla
	,op_direccion,op_telefono,op_historia,op_duplicados
	,op_renovaciones,op_incremento,op_mon_sgte,op_pignorado
	,op_renova_todo,op_imprime,op_retenido,op_retienimp
	,op_totalizado,op_tcapitalizacion,op_oficial,op_accion_sgte
	,op_preimpreso,op_tipo_plazo,op_tipo_monto,op_causa_mod
	,op_descripcion,op_fecha_valor,op_fecha_ven,op_fecha_cancela
	,op_fecha_ingreso,op_fecha_pg_int,op_fecha_ult_pg_int,op_ult_fecha_calculo
	,op_fecha_crea,op_fecha_mod,op_fecha_total,op_puntos
	,op_total_int_acumulado,op_tasa_mer,op_ced_ruc,op_plazo_ant
	,op_fecven_ant,op_tot_int_est_ant,op_fecha_ord_act,op_mantiene_stock
	,op_stock,op_emision_inicial,op_moneda_pg,op_impuesto
	,op_num_imp_orig,op_impuesto_capital,op_retiene_imp_capital,op_ley
	,op_reestruc,op_fecha_real,op_ult_fecha_cal_tasa,op_num_dias_gracia
	,op_prorroga_aut,op_tasa_variable,op_mnemonico_tasa,op_modalidad_tasa
	,op_periodo_tasa,op_descr_tasa,op_operador,op_spread
	,op_estatus_prorroga,op_num_prorroga,op_anio_comercial,op_flag_tasaefec
	,op_comision,op_porc_comision,op_cupon,op_categoria_cupon
	,op_custodia,op_nueva_tasa,op_incremento_prorroga,op_puntos_prorroga
	,op_scontable,op_captador,op_aprobado,op_bloqueo_legal
	,op_monto_blqlegal,op_ult_fecha_calven,op_prov_pendiente,op_residuo_prov
	,op_int_total_prov_vencida,op_int_prov_vencida,op_tipo_tasa_var,op_oficial_principal
	,op_oficial_secundario,op_origen_fondos,op_proposito_cuenta,op_producto_bancario1
	,op_producto_bancario2,op_revision_tasa,op_dias_reales,op_plazo_orig
	,op_sec_incre,op_renovada,op_int_ajuste,op_tasa_ant
	,op_cambio_tasa,op_plazo_cont,op_incre,op_tasa_min
	,op_tasa_max,op_camb_oper,op_fecha_ult_renov,op_fecha_ult_pago_int_ant
	,op_ente_corresp,op_contador_firma,op_condiciones,op_localizado
	,op_fecha_localizacion,op_fecha_no_localiza,op_inactivo,op_dias_hold
	,op_sucursal,op_incremento_suspenso,op_oficina_apertura,op_oficial_apertura
	,op_toperacion_apertura,op_tipo_plazo_apertura,op_tipo_monto_apertura	
from cob_pfijo..pf_operacion
where op_num_banco > '0000'
  and op_estado in ('ACT','XACT','VEN')

order by op_num_banco

select @w_rowcount = @@RowCount

if @w_rowcount <> @w_registros
begin
	RollBack Tran
	select @w_return = @w_rowcount
	goto ERROR
end

commit tran

ERROR:
        exec sp_errorlog
             @i_fecha    = @s_date,
             @i_error    = @w_error,
             @i_usuario  = @s_user,
             @i_tran     = @t_trn,
             @i_cuenta   = ' '

return @w_return
go