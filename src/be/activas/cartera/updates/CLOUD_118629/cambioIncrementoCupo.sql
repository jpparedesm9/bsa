

use cob_cartera
go

if not exists ( select  1 from    syscolumns where id = OBJECT_ID('ca_incremento_cupo')
                and name = 'ic_secuencial' ) 
	alter table ca_incremento_cupo add ic_secuencial int null
go
