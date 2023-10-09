--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- FILE                : conta_tercero
-- DATE                : 02/10/2008 10:17:08.750
-- DATASOURCE          : BCMPRU01 (SQL Server)
-- VERSION             : 09.00.3054
-- TARGET DB           : cob_conta_tercero
--------------------------------------------------------------------------------

--
-- Target Database: cob_conta_tercero
--

USE cob_conta_tercero
go


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

