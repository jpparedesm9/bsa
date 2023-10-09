
--agrregando campos al as tablas 

USE cobis
GO

ALTER TABLE cl_ente ADD en_rfc VARCHAR(30) -- agregar campo en_rfc a tabla cl_ente
GO

ALTER TABLE cl_ente ADD p_carg_pub VARCHAR(30) -- agregar campo p_carg_pub a tabla cl_ente
GO

ALTER TABLE cl_ente ADD en_ing_SN CHAR(1)
GO

ALTER TABLE cl_direccion ADD di_nro INT
GO

ALTER TABLE cl_direccion ADD di_nro_residentes INT
GO

ALTER TABLE cl_ente ALTER COLUMN p_carg_pub varchar(10) --cambio de tipo de dato
GO

ALTER TABLE cl_ente ALTER COLUMN p_rel_carg_pub varchar(10)  -- cambio de tipo de dato de char(1) a char(10)
GO

ALTER TABLE cl_direccion ALTER COLUMN di_codpostal varchar(30) --Cambio de tipo de dato de char(5) a varchar(30)
GO


--Agregar catálogo cl_carg_pub
INSERT INTO dbo.cl_tabla (codigo, tabla, descripcion)
VALUES (2429, 'cl_carg_pub', 'Cargo publico')
GO
-- valores agrgados del catalogo cl_carg_pub
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (2429, '1', 'SERVIDOR PÚBLICO', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (2429, '2', 'EMBAJADOR', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (2429, '3', 'OTROS', 'V', NULL, NULL, NULL)
GO



--Agregar catálogo cl_otringr se usa la tabla = cl_fuente_ingreso codigo = 7791

-- se eliminaron los valores existentes en la tabla 

DELETE FROM dbo.cl_catalogo
WHERE tabla = 7791 AND codigo = 'D' AND valor = 'DEPENDIENTE' AND estado = 'V' AND culture IS NULL AND equiv_code IS NULL AND type IS NULL
GO

-- valores agrgados del catalogo cl_carg_pub
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7791, 'EM', 'EMPLEO', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7791, 'TE', 'TERCEROS', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7791, 'RE', 'REMESAS', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7791, 'OT', 'OTROS', 'V', NULL, NULL, NULL)
GO



--Agregar catálogo cl_carg_pub
INSERT INTO dbo.cl_tabla (codigo, tabla, descripcion)
VALUES (7793, 'cl_nacionalidad', 'Nacionalidad')
GO
-- valores agrgados del catalogo cl_carg_pub
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7793, '1', 'MEXICANA', 'V', NULL, NULL, NULL)
GO
INSERT INTO dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (7793, '2', 'EXTRANJERA', 'V', NULL, NULL, NULL)
GO




