


use cob_cuentas
go

IF OBJECT_ID ('ts_cta_cons_bco') IS NOT NULL
                DROP VIEW ts_cta_cons_bco
go
create view ts_cta_cons_bco (
        secuencial,    tipo_tran,           oficina,         usuario,       terminal,
        origen,        nodo,                fecha,           tipo,          banco,
        referencia,    operacion
) as
select  ts_secuencial, ts_tipo_transaccion, ts_oficina,      ts_usuario,    ts_terminal,
        ts_origen,     ts_nodo,             ts_tsfecha,      ts_tipo,       ts_banco,
        ts_referencia, ts_clase
  from  cc_tran_servicio
 where  ts_tipo_transaccion in (696, 697) 
 
go

IF OBJECT_ID ('cc_ts_trasnetobr') IS NOT NULL
	DROP VIEW cc_ts_trasnetobr
GO

Create View cc_ts_trasnetobr (
       secuencial,     alterno,        tipo_tran,           oficina,        usuario,    terminal,
       origen,         nodo,           fechaproceso,        tipo,           valor,      causal,
       clasecli,       prodban,        indicador,           oficdes,        descrip,    moneda
)as
Select ts_secuencial,  ts_cod_alterno, ts_tipo_transaccion, ts_oficina,     ts_usuario, ts_terminal,
       ts_origen,      ts_nodo,        ts_tsfecha,          ts_tipo,        ts_saldo,   ts_causa,
       ts_clase_clte,  ts_prod_banc,   ts_indicador,        ts_oficina_cta, ts_nombre1, ts_moneda
From   cc_tran_servicio
Where  ts_tipo_transaccion in ( 482, 483)
and    ts_causa in ('504','553')

GO