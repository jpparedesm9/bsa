use cobis
go

delete cl_parametro  
WHERE  pa_nemonico = 'PPAMCA'
AND pa_producto = 'CLI'

GO

use cobis
go

delete cl_parametro 
where pa_nemonico = 'TMBUCO'
AND pa_producto = 'CLI'

go