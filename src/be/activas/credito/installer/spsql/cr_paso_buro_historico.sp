
use cob_credito
go

/*************************************************************************/
/*   Archivo:            sp_paso_buro_historico.sp                       */
/*   Stored procedure:   sp_paso_buro_historico                          */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Crèdito                                         */
/*   Disenado por:       Sonia Rojas                                     */
/*   Fecha de escritura: 19/06/2019                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBISCORP', representantes exclusivos para el Ecuador de NCR       */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa pasa tablas de buro a históricos cuando los registros */
/*   se encuentran no vigentes (batch de ejecuciòn diaria)               */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA        AUTOR                       RAZON                      */
/* 19/06/2019   Sonia Rojas    Version Inicial                           */
/* 30/07/2021   ACH            Eliminar reg. de consulta casoERR#162199  */
/* 02/06/2021   ACH            Caso#159312-usuario consulta              */
/*************************************************************************/

IF OBJECT_ID ('dbo.sp_paso_buro_historico') IS NOT NULL
	DROP PROCEDURE dbo.sp_paso_buro_historico
GO

create proc sp_paso_buro_historico (
   @i_param1               datetime = null
)
as
declare
@w_error                int,
@w_msg                  varchar(255),
@w_sp_name              varchar(50),
@w_codigo_producto      int,
@w_rowcount             int

select @w_sp_name = 'sp_buro_historicos'

----ERR#162199-Clientes Consultados Buró
truncate table cr_interface_buro_tmp_consulta

select @w_codigo_producto = pd_producto 
from cobis..cl_producto 
where pd_abreviatura = 'CRE'

create table #interface_buro(
ib_secuencial          int,
ib_cliente             int, 
ib_fecha               datetime,
ib_riesgo              int, 
ib_folio               varchar(64),
ib_usuario             varchar(30)
)


begin tran 

insert into #interface_buro
select ib_secuencial, ib_cliente, ib_fecha, ib_riesgo, ib_folio, ib_usuario
from cr_interface_buro
where ib_estado = 'N'
ORDER BY ib_secuencial ASC


insert into cob_credito_his..cr_interface_buro_his (ibh_cliente, ibh_fecha, ibh_riesgo, ibh_folio, ibh_fecha_paso_his, ibh_usuario)
select ib_cliente, ib_fecha, ib_riesgo, ib_folio, getdate(), ib_usuario from #interface_buro

if @@error <> 0 begin
   select
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cob_credito_his..cr_interface_buro_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_buro_cuenta_his(
bch_ib_secuencial,
bch_fecha_actualizacion,
bch_registro_impugnado,
bch_clave_otorgante,
bch_nombre_otorgante,
bch_numero_telefono_otorgante,
bch_identificador_sociedad_crediticia,
bch_numero_cuenta_actual,
bch_indicador_tipo_responsabilidad,
bch_tipo_cuenta,
bch_tipo_contrato,
bch_clave_unidad_monetaria,
bch_valor_activo_valuacion,
bch_numero_pagos,
bch_frecuencia_pagos,
bch_monto_pagar,
bch_fecha_apertura_cuenta,
bch_fecha_ultimo_pago,
bch_fecha_ultima_compra,
bch_fecha_cierre_cuenta,
bch_fecha_reporte,
bch_modo_reportar,
bch_ultima_fecha_saldo_cero,
bch_garantia,
bch_credito_maximo,
bch_saldo_actual,
bch_limite_credito,
bch_saldo_vencido,
bch_numero_pagos_vencidos,
bch_forma_pago_actual,
bch_historico_pagos,
bch_fecha_mas_reciente_pago_historicos,
bch_fecha_mas_antigua_pago_historicos,
bch_clave_observacion,
bch_total_pagos_reportados,
bch_total_pagos_calificados_mop2,
bch_total_pagos_calificados_mop3,
bch_total_pagos_calificados_mop4,
bch_total_pagos_calificados_mop5,
bch_importe_saldo_morosidad_hist_mas_grave,
bch_fecha_historica_morosidad_mas_grave,
bch_mop_historico_morosidad_mas_grave,
bch_monto_ultimo_pago,
bch_fecha_inicio_reestructura)
select 
C.ibh_secuencial,
A.bc_fecha_actualizacion,
A.bc_registro_impugnado,
A.bc_clave_otorgante,
A.bc_nombre_otorgante,
A.bc_numero_telefono_otorgante,
A.bc_identificador_sociedad_crediticia,
A.bc_numero_cuenta_actual,
A.bc_indicador_tipo_responsabilidad,
A.bc_tipo_cuenta,
A.bc_tipo_contrato,
A.bc_clave_unidad_monetaria,
A.bc_valor_activo_valuacion,
A.bc_numero_pagos,
A.bc_frecuencia_pagos,
A.bc_monto_pagar,
A.bc_fecha_apertura_cuenta,
A.bc_fecha_ultimo_pago,
A.bc_fecha_ultima_compra,
A.bc_fecha_cierre_cuenta,
A.bc_fecha_reporte,
A.bc_modo_reportar,
A.bc_ultima_fecha_saldo_cero,
A.bc_garantia,
A.bc_credito_maximo,
A.bc_saldo_actual,
A.bc_limite_credito,
A.bc_saldo_vencido,
A.bc_numero_pagos_vencidos,
A.bc_forma_pago_actual,
A.bc_historico_pagos,
A.bc_fecha_mas_reciente_pago_historicos,
A.bc_fecha_mas_antigua_pago_historicos,
A.bc_clave_observacion,
A.bc_total_pagos_reportados,
A.bc_total_pagos_calificados_mop2,
A.bc_total_pagos_calificados_mop3,
A.bc_total_pagos_calificados_mop4,
A.bc_total_pagos_calificados_mop5,
A.bc_importe_saldo_morosidad_hist_mas_grave,
A.bc_fecha_historica_morosidad_mas_grave,
A.bc_mop_historico_morosidad_mas_grave,
A.bc_monto_ultimo_pago,
A.bc_fecha_inicio_reestructura
from cr_buro_cuenta A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.bc_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY A.bc_ib_secuencial asc

if @@error <> 0 begin
   select
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_buro_cuenta_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_direccion_buro_his(   
dbh_ib_secuencial,
dbh_direccion_uno,
dbh_direccion_dos,
dbh_colonia,
dbh_delegacion,
dbh_ciudad,
dbh_estado,
dbh_codigo_postal,
dbh_numero_telefono,
dbh_tipo_domicilio,
dbh_indicador_especial,
dbh_codigo_pais,
dbh_fecha_reporte)   
select 
C.ibh_secuencial,
A.db_direccion_uno,
A.db_direccion_dos,
A.db_colonia,
A.db_delegacion,
A.db_ciudad,
A.db_estado,
A.db_codigo_postal,
A.db_numero_telefono,
A.db_tipo_domicilio,
A.db_indicador_especial,
A.db_codigo_pais,
A.db_fecha_reporte
from  cr_direccion_buro A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.db_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY db_ib_secuencial asc

if @@error <> 0 begin
   select
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_direccion_buro_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_empleo_buro_his(
ebh_ib_secuencial,
ebh_nombre_empresa,
ebh_direccion_uno,
ebh_direccion_dos,
ebh_colonia,
ebh_delegacion,
ebh_ciudad,
ebh_estado,
ebh_codigo_postal,
ebh_numero_telefono,
ebh_extension,
ebh_fax,
ebh_cargo,
ebh_fecha_contratacion,
ebh_clave_moneda,
ebh_salario,
ebh_base_salarial,
ebh_num_empleado,
ebh_fecha_ult_dia,
ebh_codigo_pais,
ebh_fecha_rept_empleo,
ebh_fecha_verificacion,
ebh_modo_verificacion)
select
C.ibh_secuencial,
A.eb_nombre_empresa,
A.eb_direccion_uno,
A.eb_direccion_dos,
A.eb_colonia,
A.eb_delegacion,
A.eb_ciudad,
A.eb_estado,
A.eb_codigo_postal,
A.eb_numero_telefono,
A.eb_extension,
A.eb_fax,
A.eb_cargo,
A.eb_fecha_contratacion,
A.eb_clave_moneda,
A.eb_salario,
A.eb_base_salarial,
A.eb_num_empleado,
A.eb_fecha_ult_dia,
A.eb_codigo_pais,
A.eb_fecha_rept_empleo,
A.eb_fecha_verificacion,
A.eb_modo_verificiacion   
from  cr_empleo_buro A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.eb_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY eb_ib_secuencial asc

if @@error <> 0 begin
   select
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_empleo_buro_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_consultas_buro_his(
cbh_ib_secuencial,
cbh_fecha_consulta,     
cbh_identificacion_buro, 
cbh_clave_otorgante,     
cbh_nombre_otorgante,    
cbh_telefono_otorgante,  
cbh_tipo_contrato,       
cbh_clave_monetaria,     
cbh_importe_contrato,    
cbh_ind_tipo_responsa,   
cbh_consumidor_nuevo,    
cbh_resultado_final,     
cbh_identificador_cons
)
select 
C.ibh_secuencial,
A.ce_fecha_consulta,     
A.ce_identificacion_buro, 
A.ce_clave_otorgante,     
A.ce_nombre_otorgante,    
A.ce_telefono_otorgante,  
A.ce_tipo_contrato,       
A.ce_clave_monetaria,     
A.ce_importe_contrato,    
A.ce_ind_tipo_responsa,   
A.ce_consumidor_nuevo,    
A.ce_resultado_final,     
A.ce_identificador_cons
from  cr_consultas_buro A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.ce_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY ce_ib_secuencial asc

if @@error <> 0 begin
   select 
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_consultas_buro_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_score_buro_his(
sbh_ib_secuencial, 
sbh_nombre,     
sbh_codigo,     
sbh_valor,      
sbh_codigo_razon,
sbh_codigo_error)
select 
C.ibh_secuencial,
A.sb_nombre,       
A.sb_codigo,       
A.sb_valor,        
A.sb_codigo_razon, 
A.sb_codigo_error
from  cr_score_buro A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.sb_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY sb_ib_secuencial asc

if @@error <> 0 begin
   select 
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_score_buro_his'
   goto ERROR_PROCESO
end

insert into cob_credito_his..cr_buro_resumen_reporte_his(
brh_ib_secuencial,
brh_fecha_ingreso_bd,
brh_numero_mop7,
brh_numero_mop6, 
brh_numero_mop5,
brh_numero_mop4,
brh_numero_mop3,
brh_numero_mop2,
brh_numero_mop1,
brh_numero_mop0,
brh_numero_mop_ur,
brh_numero_cuentas,
brh_cuentas_pagos_fijos_hipotecas,
brh_cuentas_revolventes_abiertas,
brh_cuentas_cerradas,
brh_cuentas_negativas_actuales,
brh_cuentas_claves_historia_negativa,
brh_cuentas_disputa,
brh_numero_solicitudes_ultimos_6_meses,
brh_nueva_direccion_reportada_ultimos_60_dias,
brh_mensajes_alerta,
brh_existencia_declaraciones_consumidor,
brh_tipo_moneda,
brh_total_creditos_maximos_revolventes,
brh_total_limites_credito_revolventes,
brh_total_saldos_actuales_revolventes,
brh_total_saldos_vencidos_revolventes,
brh_total_pagos_revolventes,
brh_pct_limite_credito_utilizado_revolventes,
brh_total_creditos_maximos_pagos_fijos,
brh_total_saldos_actuales_pagos_fijos,
brh_total_saldos_vencidos_pagos_fijos,
brh_total_pagos_pagos_fijos,
brh_numero_mop96,
brh_numero_mop97,
brh_numero_mop99,
brh_fecha_apertura_cuenta_mas_antigua,
brh_fecha_apertura_cuenta_mas_reciente,
brh_total_solicitudes_reporte,
brh_fecha_solicitud_reporte_mas_reciente,
brh_numero_total_cuentas_despacho_cobranza,
brh_fecha_apertura_cuenta_mas_reciente_despacho_cobranza,
brh_numero_total_solicitudes_despachos_cobranza,
brh_fecha_solicitud_mas_reciente_despacho_cobranza
)
select
C.ibh_secuencial, 
A.br_fecha_ingreso_bd,
A.br_numero_mop7,
A.br_numero_mop6,
A.br_numero_mop5,
A.br_numero_mop4,
A.br_numero_mop3,
A.br_numero_mop2,
A.br_numero_mop1,
A.br_numero_mop0,
A.br_numero_mop_ur,
A.br_numero_cuentas,
A.br_cuentas_pagos_fijos_hipotecas,
A.br_cuentas_revolventes_abiertas,
A.br_cuentas_cerradas,
A.br_cuentas_negativas_actuales,
A.br_cuentas_claves_historia_negativa,
A.br_cuentas_disputa,
A.br_numero_solicitudes_ultimos_6_meses,
A.br_nueva_direccion_reportada_ultimos_60_dias,
A.br_mensajes_alerta,
A.br_existencia_declaraciones_consumidor,
A.br_tipo_moneda,
A.br_total_creditos_maximos_revolventes,
A.br_total_limites_credito_revolventes,
A.br_total_saldos_actuales_revolventes,
A.br_total_saldos_vencidos_revolventes,
A.br_total_pagos_revolventes,
A.br_pct_limite_credito_utilizado_revolventes,
A.br_total_creditos_maximos_pagos_fijos,
A.br_total_saldos_actuales_pagos_fijos,
A.br_total_saldos_vencidos_pagos_fijos,
A.br_total_pagos_pagos_fijos,
A.br_numero_mop96,
A.br_numero_mop97,
A.br_numero_mop99,
A.br_fecha_apertura_cuenta_mas_antigua,
A.br_fecha_apertura_cuenta_mas_reciente,
A.br_total_solicitudes_reporte,
A.br_fecha_solicitud_reporte_mas_reciente,
A.br_numero_total_cuentas_despacho_cobranza,
A.br_fecha_apertura_cuenta_mas_reciente_despacho_cobranza,
A.br_numero_total_solicitudes_despachos_cobranza,
A.br_fecha_solicitud_mas_reciente_despacho_cobranza   
from  cr_buro_resumen_reporte A WITH (NOLOCK),
#interface_buro B,
cob_credito_his..cr_interface_buro_his C WITH (NOLOCK)
where A.br_ib_secuencial = B.ib_secuencial
AND   B.ib_cliente       = C.ibh_cliente
ORDER BY br_ib_secuencial asc

if @@error <> 0 begin
   select 
   @w_error = @@error,
   @w_msg   = 'Error al insertar en la tabla cr_buro_resumen_reporte_his'
   goto ERROR_PROCESO
end


delete cr_empleo_buro where eb_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_direccion_buro where db_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_buro_encabezado where be_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_buro_cuenta where bc_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_consultas_buro where ce_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_buro_resumen_reporte where br_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_score_buro where sb_ib_secuencial in (select ib_secuencial from #interface_buro)
delete cr_interface_buro where ib_secuencial in (select ib_secuencial from #interface_buro)

commit tran

ERROR_PROCESO:

if @@trancount > 0 begin
  rollback tran
end

exec sp_error_batch        
@i_fecha        = @i_param1,
@i_error        = @w_error,
@i_programa     = @w_sp_name,
@i_producto     = @w_codigo_producto,
@i_operacion    = '',
@i_descripcion  = @w_msg


return @w_error
go
