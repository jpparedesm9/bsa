-----------------------
--CREACION DE OFICINAS
-----------------------
use cobis
go

--OFICINAS
DELETE cobis..cl_oficina WHERE of_oficina IN (2403, 2404, 2377, 1032, 1479, 1053, 1480, 3346)
go

INSERT INTO cl_oficina (
of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 2403, 'OFICINA NEZAHUALCOYOTL', 'NEZAHUALCOYOTL', 714, 'O', 'BCO', 1, 'C', 'U', 15, 0,'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 2404, 'OFICINA ATLACOMULCO', 'ATLACOMULCO', 670, 'O', 'BCO', 1, 'C', 'U', 15, 0,'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 2377, 'OFICINA SANTIAGO TIANGUISTENCO', 'SANTIAGO TIANGUISTENCO', 757, 'O', 'BCO', 1, 'C', 'U', 15, 0,'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 1032, 'OFICINA JOJUTLA', 'JOJUTLA', 906, 'O', 'BCO', 1, 'C', 'U', 17, 0, 'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 1479, 'OFICINA CUERNAVACA', 'CUERNAVACA', 901, 'O', 'BCO', 1, 'C', 'U', 17, 0,'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 1053, 'OFICINA CUAUTLA', 'CUAUTLA', 900, 'O', 'BCO', 1, 'C', 'U', 17,0, 'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 1480, 'OFICINA IGUALA', 'IGUALA', 401, 'O', 'BCO', 1, 'C', 'U', 12, 0,'N')
go

INSERT INTO cl_oficina (of_filial, of_oficina, of_nombre, of_direccion, of_ciudad, of_subtipo, of_area, of_horario, of_tipo_horar, of_sector,  of_provincia, of_sucursal, of_bloqueada)
VALUES (1, 3346, 'OFICINA TAXCO', 'TAXCO', 421, 'O', 'BCO', 1, 'C', 'U', 12, 0,'N')
go

--CATALOGOS
delete cobis..cl_catalogo WHERE tabla=9 AND codigo IN ('2403', '2404', '2377', '1032', '1479', '1053', '1480', '3346')
go

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2403', 'OFICINA NEZAHUALCOYOTL', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2404', 'OFICINA ATLACOMULCO', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '2377', 'OFICINA SANTIAGO TIANGUISTENCO', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1032', 'OFICINA JOJUTLA', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1479', 'OFICINA CUERNAVACA', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1053', 'OFICINA CUAUTLA', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '1480', 'OFICINA IGUALA', 'V')
GO

INSERT INTO [cobis].[dbo].[cl_catalogo]([tabla], [codigo], [valor], [estado])
VALUES(9, '3346', 'OFICINA TAXCO', 'V')
GO

--DEPARTAMENTOS
DELETE cl_departamento WHERE de_departamento = 2 AND de_oficina IN (2403, 2404, 2377, 1032, 1479, 1053, 1480, 3346)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 2403, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 2404, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 2377, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 1032, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 1479, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 1053, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 1480, 'OPERACIONES', 0)
go

INSERT INTO cobis..cl_departamento(de_departamento, de_filial, de_oficina, de_descripcion, de_nivel)
VALUES(2, 1, 3346, 'OPERACIONES', 0)
go

