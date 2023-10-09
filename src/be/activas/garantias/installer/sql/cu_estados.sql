use cob_custodia
go

delete from cob_custodia..cu_estados_garantia
where eg_estado in ('F', 'V', 'X', 'C', 'P', 'A', 'K')

insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('F', 'Vigente Futuros Creditos', 0)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('V', 'Vigente con Obligacion', 1)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('X', 'Vigente por Cancelar', 2)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('C', 'CANCELADO', 3)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('P', 'Propuesta', 6)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('A', 'Anulado', 7)
insert into cob_custodia..cu_estados_garantia (eg_estado,eg_descripcion,eg_codvalor) values('K', 'Castigado', 8)
go

delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'F' and ce_estado_fin = 'V' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'V' and ce_estado_fin = 'F' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'V' and ce_estado_fin = 'X' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'X' and ce_estado_fin = 'V' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'P' and ce_estado_fin = 'A' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'F' and ce_estado_fin = 'A' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'P' and ce_estado_fin = 'F' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'F' and ce_estado_fin = 'X' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'X' and ce_estado_fin = 'F' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'X' and ce_estado_fin = 'V' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'F' and ce_estado_fin = 'P' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'X' and ce_estado_fin = 'C' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'V' and ce_estado_fin = 'X' and ce_tipo = 'M'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'P' and ce_estado_fin = 'V' and ce_tipo = 'A'
delete from cob_custodia..cu_cambios_estado where ce_estado_ini = 'V' and ce_estado_fin = 'C' and ce_tipo = 'A'
go

insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('P', 'V', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('F', 'V', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('V', 'F', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('V', 'X', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('X', 'V', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('P', 'A', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('F', 'A', 'S', 'EST', 'A')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('P', 'F', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('F', 'X', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('X', 'F', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('X', 'V', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('F', 'P', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('X', 'C', 'N', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('V', 'X', 'S', 'EST', 'M')
insert into cob_custodia..cu_cambios_estado(ce_estado_ini, ce_estado_fin, ce_contabiliza, ce_tran, ce_tipo) values('V', 'C', 'N', 'EST', 'A')
go