select tr_oficial, *
from   cob_credito..cr_tramite
where  tr_tramite = 59675 --@w_tramite

update cob_credito..cr_tramite
set    tr_oficial = 244
where  tr_tramite = 59675 --@w_tramite

select tr_oficial, *
from   cob_credito..cr_tramite
where  tr_tramite = 59675 --@w_tramite
go
