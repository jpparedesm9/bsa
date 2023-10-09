use cob_cartera
go

update ca_operacion set op_desplazamiento = 0 where op_desplazamiento is null

go