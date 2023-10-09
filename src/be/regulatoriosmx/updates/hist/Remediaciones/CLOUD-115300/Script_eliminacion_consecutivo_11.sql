use cob_cartera
go

select *
from ca_santander_orden_deposito 
where sod_consecutivo = 11
and   sod_fecha       = '03/25/2019'
and   sod_fecha_real >= '03/25/2019 18:20'

delete
from ca_santander_orden_deposito 
where sod_consecutivo = 11
and   sod_fecha       = '03/25/2019'
and   sod_fecha_real >= '03/25/2019 18:20'


select *
from ca_santander_orden_deposito 
where sod_consecutivo = 11
and   sod_fecha       = '03/25/2019'
and   sod_fecha_real >= '03/25/2019 18:20'