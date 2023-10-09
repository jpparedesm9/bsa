declare @w_codigo_oficial  int
 

select  @w_codigo_oficial = oc_oficial
from  cobis..cc_oficial,
      cobis..cl_funcionario
where  fu_login         = 'hvalle'
and  fu_funcionario   = oc_funcionario
  
  
select *
from cob_credito..cr_tramite
where tr_tramite = 4265


update cob_credito..cr_tramite
set tr_oficial     = @w_codigo_oficial,
    tr_usuario     = 'hvalle', 
    tr_usuario_apr = 'hvalle'
where tr_tramite   = 4265

select *
from cob_credito..cr_tramite
where tr_tramite = 4265

select *
from cob_cartera..ca_operacion
where op_tramite = 4265

update cob_cartera..ca_operacion
set op_oficial =  @w_codigo_oficial
where op_tramite = 4265

select *
from cob_cartera..ca_operacion
where op_tramite = 4265