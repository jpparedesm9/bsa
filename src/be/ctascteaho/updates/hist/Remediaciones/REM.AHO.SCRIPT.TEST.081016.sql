/*************************************************/
---No Bug: N/A
---Título de la Historia: Falta objeto cc_tstran_servicio en Sustaining
---Fecha: 10/Ago/2016
--Descripción del la Historia:  Pantalla Transferencias automaticas entre cuentas
--Descripción de la Solución: Se crea la vista cc_tstran_servicio
--Autor: Walther Toledo
/*************************************************/

print 'CAMBIANDO A BD cob_interfase'
go                          
use cob_interfase
go

print 'cc_tstran_servicio'
go
if object_id ('cc_tstran_servicio') is not null
   drop view cc_tstran_servicio
go

create view cc_tstran_servicio 
(
    ts_secuencial,  ts_ssn_branch,     ts_cod_alterno,   ts_tipo_transaccion,
    ts_tsfecha,     ts_oficina,        ts_usuario,       ts_terminal, 
    ts_correccion,  ts_sec_correccion, ts_reentry,       ts_origen,
    ts_nodo,        ts_fecha,          ts_cta_banco,     ts_valor, 
    ts_indicador,   ts_cheque,         ts_moneda,        ts_oficina_cta, 
    ts_causa,       ts_prod_banc,      ts_categoria,     ts_estado,
    ts_servicio,    ts_autorizante,    
    ts_monto,       ts_propietario,    ts_saldo,         ts_cta_banco_dep, 
    ts_carta,       ts_default,        ts_hora,          ts_nombre,
    ts_tasa,        ts_vale,           ts_cta_asociada,  ts_clase,
    ts_nombre1,     ts_fecha_uso,      ts_fecha_ven,     
    ts_fecha_aper,  ts_producto,       ts_autorizacion,  ts_ssn_corr,
    ts_ctacte,      ts_oficial,        ts_filial,        ts_banco, 
    ts_tipo,        ts_cod_banco,      ts_agente)     
as
select 
    ts_secuencial,  ts_ssn_branch,      ts_cod_alterno,     ts_tipo_transaccion,
    ts_tsfecha,     ts_oficina,         ts_usuario,         ts_terminal,
    ts_correccion,  ts_sec_correccion,  ts_reentry,         ts_origen,
    ts_nodo,        ts_fecha,           ts_cta_banco,       ts_valor,  
    ts_indicador,   ts_cheque,          ts_moneda,              ts_oficina_cta,
    ts_causa,   	ts_prod_banc,       ts_categoria,       ts_estado,
    ts_servicio,    ts_autorizante,     
    ts_monto,       ts_propietario,     ts_saldo,           ts_cta_banco_dep,
    ts_carta,       ts_default,         ts_hora,            ts_nombre,
    ts_tasa,        ts_vale,            ts_cta_asociada,    ts_clase,
    ts_nombre1,     ts_fecha_uso,       ts_fecha_ven,       
    ts_fecha_aper,  ts_producto,        ts_autorizacion,    ts_ssn_corr,
    ts_ctacte,      ts_oficial,         ts_filial,          ts_banco,
    ts_tipo,        ts_cod_banco,       ts_agente
from  cob_cuentas..cc_tran_servicio
where ts_tipo_transaccion in (2519,2520)
go