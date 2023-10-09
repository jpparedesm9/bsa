use cobis
go

declare 
@w_producto               int

select @w_producto = pd_producto 
from cobis..cl_producto 
where pd_descripcion = 'CLIENTES'

delete cobis..ba_fecha_cierre where fc_producto = @w_producto
delete ba_batch where ba_batch = 5100


go