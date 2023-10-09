use cob_credito
go

--antes de modificacion
select 'antes',* from cob_credito..cr_imp_documento
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('KYCLCR') 

--modificacion
update cob_credito..cr_imp_documento
set id_template = 'kYCSimplificado'
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('KYCLCR')

--despues de modificacion
select 'despues',* from cob_credito..cr_imp_documento
where id_toperacion = 'REVOLVENTE'
and id_mnemonico in ('KYCLCR') 

go
