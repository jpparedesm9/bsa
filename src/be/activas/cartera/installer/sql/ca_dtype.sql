--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- FILE                : ca_dtype.sql
-- DATE                : 03/12/2008 17:06:00.656
-- DATASOURCE          : SQLMIG002 (SQL Server)
-- VERSION             : 09.00.1399
-- TARGET DB           : cob_cartera
--------------------------------------------------------------------------------

--
-- Target Database: cob_cartera
--

USE cob_cartera
go

--
--DROP USER DEFINED DATATYPES
--
IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
BEGIN
    EXEC sp_droptype 'catalogo'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
        PRINT '<<< FAILED DROPPING DATATYPE catalogo >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE catalogo >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
BEGIN
    EXEC sp_droptype 'ctacliente'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
        PRINT '<<< FAILED DROPPING DATATYPE ctacliente >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE ctacliente >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
BEGIN
    EXEC sp_droptype 'cuenta'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
        PRINT '<<< FAILED DROPPING DATATYPE cuenta >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE cuenta >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
BEGIN
    EXEC sp_droptype 'descripcion'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
        PRINT '<<< FAILED DROPPING DATATYPE descripcion >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE descripcion >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
BEGIN
    EXEC sp_droptype 'direccion'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
        PRINT '<<< FAILED DROPPING DATATYPE direccion >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE direccion >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
BEGIN
    EXEC sp_droptype 'estado'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
        PRINT '<<< FAILED DROPPING DATATYPE estado >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE estado >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
BEGIN
    EXEC sp_droptype 'login'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
        PRINT '<<< FAILED DROPPING DATATYPE login >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE login >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
BEGIN
    EXEC sp_droptype 'mensaje'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
        PRINT '<<< FAILED DROPPING DATATYPE mensaje >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE mensaje >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
BEGIN
    EXEC sp_droptype 'numero'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
        PRINT '<<< FAILED DROPPING DATATYPE numero >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE numero >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
BEGIN
    EXEC sp_droptype 'sexo'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
        PRINT '<<< FAILED DROPPING DATATYPE sexo >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE sexo >>>'
END
go
