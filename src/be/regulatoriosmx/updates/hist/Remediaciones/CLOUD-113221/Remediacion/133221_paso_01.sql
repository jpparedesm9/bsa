use cobis
go

select 'ANTES' , w_fini_domi = pa_datetime, *
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'FDOMI'
and    pa_producto = 'CCA'


UPDATE cobis..cl_parametro SET pa_datetime = '02/10/2019'
where  pa_nemonico = 'FDOMI'
and    pa_producto = 'CCA'

select 'DESPUES' , w_fini_domi = pa_datetime, *
from   cobis..cl_parametro with (nolock)
where  pa_nemonico = 'FDOMI'
and    pa_producto = 'CCA'

go



DELETE FROM cob_cartera..ca_santander_orden_retiro WHERE sor_fecha = '02/13/2019' 
GO
