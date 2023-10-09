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

--
--CREATE USER DEFINED DATATYPES
--
EXEC sp_addtype 'catalogo', 'varchar(10)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='catalogo')
    PRINT '<<< CREATED DATATYPE catalogo >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE catalogo >>>'
go

EXEC sp_addtype 'cuenta_contable', 'char(14)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='cuenta_contable')
    PRINT '<<< CREATED DATATYPE cuenta_contable >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE cuenta_contable >>>'
go

EXEC sp_addtype 'descripcion', 'varchar(160)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='descripcion')
    PRINT '<<< CREATED DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE descripcion >>>'
go

