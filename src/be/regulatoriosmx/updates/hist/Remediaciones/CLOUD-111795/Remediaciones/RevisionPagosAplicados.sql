

select 'ca_corresponsal_trn'  = 'ca_corresponsal_trn'      ,* 
from cob_cartera..ca_corresponsal_trn 
where co_referencia like '%00' + convert(varchar,1967) + '%'
and   co_estado = 'P'
union
select 'ca_corresponsal_trn'  = 'ca_corresponsal_trn'      ,* 
from cob_cartera..ca_corresponsal_trn 
where co_referencia in (select distinct  op_banco from cob_cartera..ca_operacion,cob_credito..cr_tramite_grupal where op_cliente = 1967 and   op_banco   = tg_referencia_grupal )
and   co_estado = 'P'
order by co_secuencial 