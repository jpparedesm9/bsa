use cob_credito
go 

--Antes
select * from cob_credito..cr_imp_documento
order by id_toperacion


--Individual
update cob_credito..cr_imp_documento
set id_estado = 'P'
where id_toperacion = 'INDIVIDUAL'
and id_documento = 11

delete from cob_credito..cr_imp_documento where id_toperacion = 'INDIVIDUAL' and id_documento = 13


--Grupal
update cob_credito..cr_imp_documento
set id_estado = 'P'
where id_toperacion = 'GRUPAL'
and id_documento = 7

delete from cob_credito..cr_imp_documento where id_toperacion = 'GRUPAL' and id_documento = 13


--Renovacion
update cob_credito..cr_imp_documento
set id_estado = 'P'
where id_toperacion = 'RENOVACION'
and id_documento = 6

delete from cob_credito..cr_imp_documento where id_toperacion = 'RENOVACION' and id_documento = 10


--Despues
select * from cob_credito..cr_imp_documento
order by id_toperacion  

go
