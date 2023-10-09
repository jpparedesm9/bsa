/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Vistas de Dependencias de Plazo Fijo        */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cuentas
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '********************************'
print '*****  CREACION DE VISTAS ******'
print '********************************'
print ''
print 'Inicio Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Vista: cc_gerencia'
if exists (select 1 from sysobjects where name = 'cc_gerencia' and type = 'V')
   drop view cc_gerencia
go

create view cc_gerencia as
select
ge_cuenta            = cq_cuenta,
ge_cheque			 = cq_cheque,
ge_estado_actual	 = cq_estado_actual,
ge_estado_anterior   = cq_estado_anterior,
ge_fecha_emi		 = cq_fecha_reg,
ge_fecha_pago		 = np_fecha_can,
ge_oficina			 = np_oficina,
ge_origen			 = cq_origen,
ge_valor			 = cq_valor,
ge_oficina_pago		 = ge_oficina_pago,
ge_transferido		 = cq_transferido,
ge_hora				 = cq_hora,
ge_tipo_ben			 = ge_tipo_ben,
ge_reclasif			 = df_tdeficiencia
from  cc_cheque
where cq_estado_actual = 'G' or cq_estado_anterior = 'G'
go

print '-->Vista: cc_tsefectivo_caja'
if exists (select 1 from sysobjects where name = 'cc_tsefectivo_caja' and type = 'V')
   drop view cc_tsefectivo_caja
go

create view cc_tsefectivo_caja as
select
secuencial           = ts_secuencial,
ssn_branch			 = ts_ssn_branch,
oficina				 = ts_oficina,
usuario				 = ts_usuario,
terminal			 = ts_terminal,
moneda				 = ts_moneda,
fecha				 = ts_tsfecha,
efectivo			 = ts_valor,
nodo				 = ts_nodo,
tipo				 = ts_origen,
tipo_tran			 = ts_tipo_transaccion,
remoto_ssn			 = ts_remoto_ssn,
prod_banc			 = ts_producto,
categoria			 = ts_categoria
from  cob_cuentas..cc_tran_servicio
where ts_tipo_transaccion = 15
go

print '-->Vista: cc_tsgerencia'
if exists (select 1 from sysobjects where name = 'cc_tsgerencia' and type = 'V')
   drop view cc_tsgerencia
go

create view cc_tsgerencia as
select
secuencial           = ts_secuencial,      
tipo_tran			 = ts_tipo_transaccion,
oficina				 = ts_oficina,
usuario				 = ts_usuario,
terminal			 = ts_terminal,
correccion			 = ts_correccion,
reentry				 = ts_reentry,
origen				 = ts_origen,
nodo				 = ts_nodo,
fecha				 = ts_tsfecha,
cta_banco			 = ts_cta_banco,
valor				 = ts_saldo,
nro_cheque			 = ts_cheque_desde,
departamento		 = ts_departamento,
moneda				 = ts_moneda, 
ssn_corr			 = ts_ssn_corr,
alterno				 = ts_cod_alterno,
beneficiario		 = ts_nombre,
oficina_cta			 = ts_oficina_cta,
hora				 = ts_hora,
ssn_branch			 = ts_ssn_branch,
estado_corr			 = ts_estado_corr,
identificacion		 = ts_referencia,
cta_banco_deb		 = ts_cta_asociada,
producto			 = ts_estado, 
clase_clte			 = ts_clase_clte,
prod_banc			 = ts_prod_banc,
oficial				 = ts_oficial,
indicador			 = ts_indicador,
causa				 = ts_causa,
val_gmf				 = ts_monto,
imp_gmf				 = ts_tipo,
cliente				 = ts_cliente
from  cc_tran_servicio
where ts_tipo_transaccion in (91, 2810)
go

print '-->Vista: cc_tsnopago'
if exists (select 1 from sysobjects where name = 'cc_tsnopago' and type = 'V')
   drop view cc_tsnopago
go

create view cc_tsnopago as
select
secuencial           = ts_secuencial,
tipo_transaccion     = ts_tipo_transaccion,
tsfecha              = ts_tsfecha,
usuario				 = ts_usuario,
terminal			 = ts_terminal,
oficina				 = ts_oficina,
reentry				 = ts_reentry,
origen				 = ts_origen,
cuenta				 = ts_ctacte,
cheque_desde		 = ts_cheque_desde,
cheque_hasta		 = ts_cheque_hasta,
estado_actual		 = ts_estado,
estado_anterior		 = ts_tipo,
fecha_reg			 = ts_fecha,
causa_np			 = ts_causa,
clase_np			 = ts_clase, 
cta_banco			 = ts_cta_banco,
alterno				 = ts_cod_alterno,
moneda				 = ts_moneda,
oficina_cta			 = ts_oficina_cta,
hora				 = ts_hora,
ssn_branch			 = ts_ssn_branch,
estado_corr			 = ts_estado_corr,
prod_banc			 = ts_prod_banc,
clase_clte			 = ts_clase_clte,
oficial				 = ts_oficial,
valor				 = ts_monto,
cliente				 = ts_cliente
from    cc_tran_servicio
where   ts_tipo_transaccion in (28, 29, 2507,2572)
go

print ''
print 'Fin Ejecucion Creacion de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''