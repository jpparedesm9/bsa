USE cobis
GO

UPDATE cobis..cl_cliente_grupo
SET cg_rol = 'M'
WHERE cg_ente = 1562
AND cg_grupo = 75

go