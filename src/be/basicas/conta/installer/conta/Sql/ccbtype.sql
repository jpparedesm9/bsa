--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- FILE                : cob_ccontable
-- DATE                : 02/06/2008 09:35:47.281
-- DATASOURCE          : SRVMIG001 (SQL Server)
-- VERSION             : 09.00.3042
-- TARGET DB           : cob_ccontable
--------------------------------------------------------------------------------

--
-- Target Database: cob_ccontable
--

USE cob_ccontable
go


--
--DROP USER DEFINED DATATYPES
--
IF EXISTS (SELECT * FROM systypes WHERE name='catalogo')
BEGIN
    EXEC sp_droptype 'catalogo'
    IF EXISTS (SELECT * FROM systypes WHERE name='catalogo')
        PRINT '<<< FAILED DROPPING DATATYPE catalogo >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE catalogo >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='cuenta')
BEGIN
    EXEC sp_droptype 'cuenta'
    IF EXISTS (SELECT * FROM systypes WHERE name='cuenta')
        PRINT '<<< FAILED DROPPING DATATYPE cuenta >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE cuenta >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='descripcion')
BEGIN
    EXEC sp_droptype 'descripcion'
    IF EXISTS (SELECT * FROM systypes WHERE name='descripcion')
        PRINT '<<< FAILED DROPPING DATATYPE descripcion >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE descripcion >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='direccion')
BEGIN
    EXEC sp_droptype 'direccion'
    IF EXISTS (SELECT * FROM systypes WHERE name='direccion')
        PRINT '<<< FAILED DROPPING DATATYPE direccion >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE direccion >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='estado')
BEGIN
    EXEC sp_droptype 'estado'
    IF EXISTS (SELECT * FROM systypes WHERE name='estado')
        PRINT '<<< FAILED DROPPING DATATYPE estado >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE estado >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='login')
BEGIN
    EXEC sp_droptype 'login'
    IF EXISTS (SELECT * FROM systypes WHERE name='login')
        PRINT '<<< FAILED DROPPING DATATYPE login >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE login >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='mensaje')
BEGIN
    EXEC sp_droptype 'mensaje'
    IF EXISTS (SELECT * FROM systypes WHERE name='mensaje')
        PRINT '<<< FAILED DROPPING DATATYPE mensaje >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE mensaje >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='numero')
BEGIN
    EXEC sp_droptype 'numero'
    IF EXISTS (SELECT * FROM systypes WHERE name='numero')
        PRINT '<<< FAILED DROPPING DATATYPE numero >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE numero >>>'
END
go

IF EXISTS (SELECT * FROM systypes WHERE name='sexo')
BEGIN
    EXEC sp_droptype 'sexo'
    IF EXISTS (SELECT * FROM systypes WHERE name='sexo')
        PRINT '<<< FAILED DROPPING DATATYPE sexo >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE sexo >>>'
END
go

