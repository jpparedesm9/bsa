use cob_cartera
go

select 'antes',* from cob_cartera..ca_operacion
where op_operacion < 0

delete from cob_cartera..ca_operacion
where op_operacion < 0

select 'despues',* from cob_cartera..ca_operacion
where op_operacion < 0

select 'antes',* from cob_cartera..ca_dividendo
where di_operacion < 0

delete from cob_cartera..ca_dividendo
where di_operacion < 0

select 'despues',* from cob_cartera..ca_dividendo
where di_operacion < 0

select 'antes',* from cob_cartera..ca_amortizacion
where am_operacion < 0

delete from cob_cartera..ca_amortizacion
where am_operacion < 0

select 'despues',* from cob_cartera..ca_amortizacion
where am_operacion < 0

select 'antes', * from cob_cartera..ca_rubro_op
where ro_operacion < 0

delete from cob_cartera..ca_rubro_op
where ro_operacion < 0

select 'despues', * from cob_cartera..ca_rubro_op
where ro_operacion < 0

select 'antes', * from cob_cartera..ca_tasas
where ts_operacion < 0

delete from cob_cartera..ca_tasas
where ts_operacion < 0

select 'despues', * from cob_cartera..ca_tasas
where ts_operacion < 0

go
