use cob_cartera
go

select *
from cob_cartera..ca_desembolso
where dm_operacion = 217305
and   dm_secuencial= 100


update cob_cartera..ca_desembolso
set dm_estado = 'RV'
where dm_operacion = 217305
and   dm_secuencial= 100


select *
from cob_cartera..ca_desembolso
where dm_operacion = 217305
and   dm_secuencial= 100