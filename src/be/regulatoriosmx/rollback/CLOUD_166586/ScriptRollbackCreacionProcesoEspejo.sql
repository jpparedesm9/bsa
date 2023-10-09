
use cobis
go

delete  cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NRBCDN'

delete from ba_batch where ba_batch= 36011
delete ba_parametro where pa_batch = 36011

