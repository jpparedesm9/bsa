--CASO 108156
USE cob_credito
go

update cob_credito..cr_tramite
set   tr_estado = 'P'
where tr_tramite = 23111
go
