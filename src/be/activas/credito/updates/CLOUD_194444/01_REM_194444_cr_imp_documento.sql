use cob_credito
go

--antes de modificacion
select * from cob_credito..cr_imp_documento
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('SICREV') 

--modificacion
update cob_credito..cr_imp_documento
set id_estado='C'
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('SICREV') 

--despues de modificacion
select * from cob_credito..cr_imp_documento
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('SICREV') 

go
