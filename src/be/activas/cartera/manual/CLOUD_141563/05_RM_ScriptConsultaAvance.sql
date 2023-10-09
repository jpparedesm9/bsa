use cob_cartera
go

select co_procesado, count(1)
from ca_condonacion_141115
group by co_procesado