select * from cob_cartera..ca_operacion where op_tramite = 16584
and op_operacion = 79598 and op_cliente = 1501

update cob_cartera..ca_operacion
set op_tramite = 16584 -- antes 16584
where op_tramite = -16584 
and op_operacion = 79598 and op_cliente = 1501

select * from cob_cartera..ca_operacion where op_tramite = 16584
and op_operacion = 79598 and op_cliente = 1501

go
