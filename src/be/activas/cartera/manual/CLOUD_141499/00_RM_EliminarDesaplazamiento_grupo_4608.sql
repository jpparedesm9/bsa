use cob_cartera
go

select *
from cob_cartera..ca_desplazamiento
where de_operacion in (1219671, 1219674, 1219677, 1219668, 1219665, 1219662, 1219680, 1219686, 1219683)
and   de_estado = 'I'
and   de_fecha_ini = '06/16/2020'


delete cob_cartera..ca_desplazamiento
where de_operacion in (1219671, 1219674, 1219677, 1219668, 1219665, 1219662, 1219680, 1219686, 1219683)
and   de_estado = 'I'
and   de_fecha_ini = '06/16/2020'


select *
from cob_cartera..ca_desplazamiento
where de_operacion in (1219671, 1219674, 1219677, 1219668, 1219665, 1219662, 1219680, 1219686, 1219683)
and   de_estado = 'I'
and   de_fecha_ini = '06/16/2020'