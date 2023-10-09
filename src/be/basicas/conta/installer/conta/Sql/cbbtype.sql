--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- FILE                : cob_conta
-- DATE                : 02/10/2008 10:36:14.671
-- DATASOURCE          : BCMPRU01 (SQL Server)
-- VERSION             : 09.00.3054
-- TARGET DB           : cob_conta
--------------------------------------------------------------------------------

--
-- Target Database: cob_conta
--

USE cob_conta
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

IF EXISTS (SELECT * FROM systypes WHERE name='cuenta_contable')
BEGIN
    EXEC sp_droptype 'cuenta_contable'
    IF EXISTS (SELECT * FROM systypes WHERE name='cuenta_contable')
        PRINT '<<< FAILED DROPPING DATATYPE cuenta_contable >>>'
    ELSE
        PRINT '<<< DROPPED DATATYPE cuenta_contable >>>'
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

