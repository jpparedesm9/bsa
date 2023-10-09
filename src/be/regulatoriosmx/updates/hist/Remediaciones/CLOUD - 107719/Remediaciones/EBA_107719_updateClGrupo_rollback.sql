--PRESIDENTE ACTUAL : ANAKAREN PRADO HERNANDEZ ID 17275 
--NUEVA PRESIDENTA : BLANCA ESTELA CARRILLO SALAZAR ID 18513

USE cobis
go


UPDATE cl_cliente_grupo SET
cg_rol = 'P'
WHERE cg_ente = 17275
AND cg_grupo = 681

--SELECT TOP 10 * FROM
UPDATE cl_cliente_grupo SET
cg_rol = 'M'
WHERE cg_ente = 18513
AND cg_rol = 'P'
AND cg_grupo = 681

