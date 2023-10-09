

--Modificacion del catalogo cl_calif_cliente
--SELECT DE LA TABLA cl_tabla y cuya tabla es cl_calif_cliente
SELECT * FROM cl_tabla WHERE tabla='cl_calif_cliente'
--SELECT DE LA TABLA cl_tabla y cuya tabla es 7775
SELECT * FROM cl_catalogo WHERE tabla=7775
-- ACTUALIZACION DEL CATALOGO cl_calif_cliente CAMBIADO LA DESCRIPCION  DE ALTO POR VERDE
UPDATE dbo.cl_catalogo
SET valor='VERDE'
WHERE codigo = 'A'
AND tabla=7775
GO
-- ACTUALIZACION DEL CATALOGO cl_calif_cliente CAMBIADO LA DESCRIPCION  DE MEDIO POR AMARILLO
UPDATE dbo.cl_catalogo
SET valor='AMARILLO'
WHERE codigo = 'M'
AND tabla=7775
GO
-- ACTUALIZACION DEL CATALOGO cl_calif_cliente CAMBIADO LA DESCRIPCION  DE BAJO POR ROJO
UPDATE dbo.cl_catalogo
SET valor='ROJO'
WHERE codigo = 'B'
AND tabla=7775
GO
--CREACION DE CATALOGO cl_lugar_reunion--
--obtengo el codigo maximo de la cl_tabla--
SELECT MAX(codigo) FROM cobis..cl_tabla

--inserto el nuevo catalogo una vez que encontre el maximo codigo--
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES (7797, 'cl_lugar_reunion', 'Lugar de Reunion')
GO

--inserto los valores al catalogo anteriormente creado--
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7797, 'D', 'DOMICILIO', 'V', NULL, NULL, NULL)
GO

INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7797, 'N', 'NEGOCIO', 'V', NULL, NULL, NULL)
GO
--select del nuevo catalogo creado--
SELECT * FROM cl_catalogo WHERE tabla=7797