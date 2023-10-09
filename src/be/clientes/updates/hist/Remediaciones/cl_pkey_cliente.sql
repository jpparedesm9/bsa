USE cobis
go


print '=====> cl_cliente_Key'
go
CREATE UNIQUE CLUSTERED INDEX cl_cliente_Key ON cl_cliente
(
    cl_cliente ,
    cl_det_producto 
)
go