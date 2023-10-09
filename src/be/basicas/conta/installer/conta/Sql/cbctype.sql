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

--CREATE USER DEFINED DATATYPES
--
EXEC sp_addtype 'catalogo', 'varchar(10)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='catalogo')
    PRINT '<<< CREATED DATATYPE catalogo >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE catalogo >>>'
go

EXEC sp_addtype 'cuenta', 'varchar(20)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='cuenta')
    PRINT '<<< CREATED DATATYPE cuenta >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE cuenta >>>'
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

EXEC sp_addtype 'estado', 'char(1)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='estado')
    PRINT '<<< CREATED DATATYPE estado >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE estado >>>'
go

EXEC sp_addtype 'login', 'varchar(14)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='login')
    PRINT '<<< CREATED DATATYPE login >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE login >>>'
go
