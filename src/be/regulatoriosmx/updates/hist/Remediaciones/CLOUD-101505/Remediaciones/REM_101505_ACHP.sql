use cob_credito
go

if not exists (select 1 from cob_credito..cr_documento_digitalizado where dd_inst_proceso = 645 and dd_cliente = 15243 and dd_grupo = 584 and dd_tipo_doc = '007')
insert into cob_credito..cr_documento_digitalizado (dd_inst_proceso, dd_cliente, dd_grupo, dd_fecha, dd_tipo_doc, dd_cargado)
values (645, 15243, 584, 'Jun 20 2018  4:45PM', '007', 'N')
go
