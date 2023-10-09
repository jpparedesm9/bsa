use cobis
go

alter table cl_ente 
alter column p_s_nombre varchar(30)

go

use cob_externos
go

alter table cambio_nombre_tmp
alter column p_s_nombre varchar(30)

go