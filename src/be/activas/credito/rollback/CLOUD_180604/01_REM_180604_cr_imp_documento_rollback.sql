use cob_credito
go

--antes de modificacion
select * from cob_credito..cr_imp_documento
where id_toperacion = 'INDIVIDUAL'
and id_mnemonico in ('CREIND','FAUTAIND','APRIND','PAGIND') 

--modificacion
update cob_credito..cr_imp_documento
set id_estado='P'
where id_mnemonico in ('CREIND','FAUTAIND','APRIND','PAGIND') 
and id_toperacion = 'INDIVIDUAL'

--despues de insercion
select * from cob_credito..cr_imp_documento
where id_toperacion = 'INDIVIDUAL'
and id_mnemonico in ('CREIND','FAUTAIND','APRIND','PAGIND') 

go
