use cob_cuentas
go

if object_id ('cc_tsnopago') is not null
	drop view cc_tsnopago
go

create view cc_tsnopago (
   secuencial,      tipo_transaccion, tsfecha,
   usuario,         terminal,          oficina,      reentry, origen,
   cuenta,          cheque_desde,      cheque_hasta, estado_actual,
   estado_anterior, fecha_reg,         causa_np,     clase_np, 
   cta_banco,       alterno,           moneda,       oficina_cta,hora,
   ssn_branch,      estado_corr,       prod_banc,    clase_clte, 
   oficial,         valor,             cliente
) as
select    
   ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
   ts_usuario,    ts_terminal,         ts_oficina,      ts_reentry, ts_origen,
   ts_ctacte,     ts_cheque_desde,     ts_cheque_hasta, ts_estado,
   ts_tipo,       ts_fecha,            ts_causa,        ts_clase, 
   ts_cta_banco,  ts_cod_alterno,      ts_moneda,       ts_oficina_cta,ts_hora,
   ts_ssn_branch, ts_estado_corr,      ts_prod_banc,    ts_clase_clte,
   ts_oficial,    ts_monto,            ts_cliente
from    cc_tran_servicio
where   ts_tipo_transaccion in (28, 29, 2507,2572)
go


if object_id ('cc_tsbloqueo_valor') is not null
	drop view cc_tsbloqueo_valor
go

create view cc_tsbloqueo_valor (
    secuencial, tipo_transaccion, tsfecha,
    usuario, terminal,  oficina, reentry, origen,
    cta_banco, fecha, valor, accion, causa,
    autorizante, alterno, moneda, hora, 
    solicitante, fecha_vencim,oficina_cta,
    ssn_branch, estado_corr,
    oficio_crea, demanda, oficio_levanta,
    prod_banc, clase_clte, oficial, 
    indicador
) as
select    ts_secuencial, ts_tipo_transaccion, ts_tsfecha,
    ts_usuario, ts_terminal, ts_oficina, ts_reentry, ts_origen,
    ts_cta_banco, ts_fecha, ts_valor, ts_tipo, ts_causa,
    ts_autorizante, ts_cod_alterno, ts_moneda, ts_fecha_uso, 
    ts_autoriz_aut, ts_fecha_ven,ts_oficina_cta,
    ts_ssn_branch,  ts_estado_corr,
    ts_oficio, ts_agente, ts_oficio_lev,
    ts_prod_banc, ts_clase_clte,
    ts_oficial, 
    ts_indicador
from    cc_tran_servicio
where   ts_tipo_transaccion in (9, 10)
go

