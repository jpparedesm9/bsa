
USE cobis 
go

UPDATE cobis..cl_cliente_grupo SET
cg_rol = 'M'
WHERE cg_estado = 'C'

go

