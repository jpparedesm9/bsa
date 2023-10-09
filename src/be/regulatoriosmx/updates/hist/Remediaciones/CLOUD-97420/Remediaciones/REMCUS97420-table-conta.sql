--------------------------------------------------------------------------------------------
-- AGREGAR CAMPO A TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 
use cob_cartera
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'tp_ofi_oper' and TABLE_NAME = 'ca_transaccion_prv')
begin
    alter table cob_cartera..ca_transaccion_prv add tp_ofi_oper smallint null 
end
else
begin
 	alter table cob_cartera..ca_transaccion_prv alter column tp_ofi_oper smallint null
end


if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ub_ofi_oper' and TABLE_NAME = 'ca_universo_conta')
begin
    alter table cob_cartera..ca_universo_conta add ub_ofi_oper smallint null 
end
else
begin
 	alter table cob_cartera..ca_universo_conta alter column ub_ofi_oper smallint null
end

--------------------------------------------------------------------------------------------
-- ACTUALIZAR REGISTROS DE OFICINA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 
use cob_cartera
go

update cob_cartera..ca_transaccion_prv
set tp_ofi_oper = op_oficina
from cob_cartera..ca_operacion
where op_operacion = tp_operacion
and tp_ofi_oper is null

--------------------------------------------------------------------------------------------
-- AGREGAR TRANSACCIONES
--------------------------------------------------------------------------------------------

delete cob_cartera..ca_tipo_trn where tt_codigo = 'TCO'


insert into cob_cartera..ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
values ('TCO', 'TRASLADO CONTABLE DE OFICINAS', 'S', 'S')
go



delete cob_cartera..ca_trn_oper where to_tipo_trn = 'TCO'

insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil)
values ('GRUPAL    ', 'TCO', 'CCA_EST')
go

insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil)
values ('INDIVIDUAL', 'TCO', 'CCA_EST')
go

insert into cob_cartera..ca_trn_oper (to_toperacion, to_tipo_trn, to_perfil)
values ('INTERCICLO', 'TCO', 'CCA_EST')
go

