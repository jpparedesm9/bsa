--------------------------------------------------------------------------------------------
-- AGREGAR CAMPO A TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 
use cob_cartera
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'tp_ofi_oper' and TABLE_NAME = 'ca_transaccion_prv')
begin
    alter table cob_cartera..ca_transaccion_prv drop column tp_ofi_oper
end


if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ub_ofi_oper' and TABLE_NAME = 'ca_universo_conta')
begin
    alter table cob_cartera..ca_universo_conta drop column ub_ofi_oper
end

--------------------------------------------------------------------------------------------
-- AGREGAR TRANSACCIONES
--------------------------------------------------------------------------------------------

delete cob_cartera..ca_tipo_trn where tt_codigo = 'TCO'

delete cob_cartera..ca_trn_oper where to_tipo_trn = 'TCO'


