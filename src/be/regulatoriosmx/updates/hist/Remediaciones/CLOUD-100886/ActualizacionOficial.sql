
select *
from cob_credito..cr_tramite
where tr_tramite = 4269


update cob_credito..cr_tramite
set tr_oficial     = 36,
    tr_usuario     = 'mamorales', 
    tr_usuario_apr = 'mamorales'
where tr_tramite   = 4269

select *
from cob_credito..cr_tramite
where tr_tramite = 4269

select *
from cob_cartera..ca_operacion
where op_tramite = 4269

update cob_cartera..ca_operacion
set op_oficial =  36
where op_tramite = 4269

select *
from cob_cartera..ca_operacion
where op_tramite = 4269