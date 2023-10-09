USE cob_cartera
GO
--Cliente 4434 en el grupo 933
DECLARE
@w_operacionca  int,
@w_secuencial   int,
@w_valor_ajuste money

SELECT 
@w_operacionca  = 45405,  --->Aqui Poner el numero del Prestamo
@w_secuencial   = 95,     --->Aqui poner el secuencial del pago que queremos reversar contablemente
@w_valor_ajuste = 0.01    --->Aqui poner el valor que vamos ajustar a los rubro de 'VAC0','CAP'

--Insertar registro en la  ca_transaccion su reverso
insert into cob_cartera..ca_transaccion(
tr_secuencial,       tr_fecha_mov,        tr_toperacion,
tr_moneda,           tr_operacion,        tr_tran,
tr_en_linea,         tr_banco,            tr_dias_calc,
tr_ofi_oper,         tr_ofi_usu,          tr_usuario,
tr_terminal,         tr_fecha_ref,        tr_secuencial_ref,
tr_estado,           tr_observacion,      tr_gerente,
tr_gar_admisible,    tr_reestructuracion,
tr_calificacion,     tr_fecha_cont,       tr_comprobante)
select 
-1 * tr_secuencial,      tr_fecha_mov,  tr_toperacion,
tr_moneda,               tr_operacion,             tr_tran,
tr_en_linea,             tr_banco,                 tr_dias_calc,
tr_ofi_oper,             tr_ofi_usu,               tr_usuario,
tr_terminal,             tr_fecha_ref,             tr_secuencial,
'ING',                   'AJUSTE DE CENTAVO',      tr_gerente,
tr_gar_admisible,        tr_reestructuracion,
tr_calificacion,         tr_fecha_cont,            tr_comprobante
from   cob_cartera..ca_transaccion
where  tr_operacion   = @w_operacionca
and    tr_secuencial  = @w_secuencial

--Insertar registro en la  ca_det_trn su reverso
insert into cob_cartera..ca_det_trn(
dtr_secuencial,     dtr_operacion,    dtr_dividendo,
dtr_concepto,       dtr_estado,       dtr_periodo,
dtr_codvalor,       dtr_monto,        dtr_monto_mn,
dtr_moneda,         dtr_cotizacion,   dtr_tcotizacion,
dtr_afectacion,     dtr_cuenta,       dtr_beneficiario, dtr_monto_cont)
select 
-1*dtr_secuencial,  dtr_operacion, dtr_dividendo,
dtr_concepto,
dtr_estado,         dtr_periodo,                  dtr_codvalor,
dtr_monto,          dtr_monto_mn,                 dtr_moneda,
dtr_cotizacion,     isnull(dtr_tcotizacion,''),   dtr_afectacion,
dtr_cuenta,         dtr_beneficiario,             0
from   cob_cartera..ca_transaccion, cob_cartera..ca_det_trn 
where  tr_operacion    = @w_operacionca
and    tr_secuencial   = @w_secuencial
and    tr_secuencial   = dtr_secuencial
and    tr_operacion    = dtr_operacion


--Actualizo tr_estado 'ING'  en la ca_transaccion
UPDATE cob_cartera..ca_transaccion SET tr_estado='ING'
WHERE  tr_operacion   = @w_operacionca
and    tr_secuencial  = @w_secuencial

--Actualizo el detalle ca_det_trn aumentandole  un centavo where dtr_concepto =  'VAC0'
UPDATE cob_cartera..ca_det_trn
SET dtr_monto     = dtr_monto    + @w_valor_ajuste,
    dtr_monto_mn  = dtr_monto_mn + @w_valor_ajuste
FROM  cob_cartera..ca_transaccion   
WHERE  tr_operacion    = @w_operacionca
and    tr_secuencial   = @w_secuencial
and    tr_secuencial   = dtr_secuencial
and    tr_operacion    = dtr_operacion
and    dtr_concepto    IN ( 'VAC0','CAP')

GO
