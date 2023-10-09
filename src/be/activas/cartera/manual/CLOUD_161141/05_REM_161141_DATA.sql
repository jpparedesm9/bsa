use cob_credito
go

update cob_credito..cr_tramite 
set   tr_destino = '01' 
where tr_destino = 1

go