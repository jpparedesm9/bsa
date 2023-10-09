-----------------------
--ELIMINACION DE OFICINAS
-----------------------
use cobis
go

--OFICINAS
DELETE cobis..cl_oficina WHERE of_oficina IN (2403, 2404, 2377, 1032, 1479, 1053, 1480, 3346)
go

--CATALOGOS
delete cobis..cl_catalogo WHERE tabla=9 AND codigo IN ('2403', '2404', '2377', '1032', '1479', '1053', '1480', '3346')
go

--DEPARTAMENTOS
DELETE cl_departamento WHERE de_departamento = 2 AND de_oficina IN (2403, 2404, 2377, 1032, 1479, 1053, 1480, 3346)
go

