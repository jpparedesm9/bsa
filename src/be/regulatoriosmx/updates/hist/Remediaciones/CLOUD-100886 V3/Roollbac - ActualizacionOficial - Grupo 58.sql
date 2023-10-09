
select *
from cob_credito..cr_tramite
where tr_tramite = 4265


update cob_credito..cr_tramite
set tr_oficial     = 43,
    tr_usuario     = 'jcorona', 
    tr_usuario_apr = 'jcorona'
where tr_tramite   = 4265

select *
from cob_credito..cr_tramite
where tr_tramite = 4265

select *
from cob_cartera..ca_operacion
where op_tramite = 4265

update cob_cartera..ca_operacion
set op_oficial =  43
where op_tramite = 4265

select *
from cob_cartera..ca_operacion
where op_tramite = 4265