--------------------------------------------------------------------------------
-- DBArtisan Schema Extraction
-- FILE                : cob_interfase
-- DATE                : 02/06/2008 09:35:47.281
-- DATASOURCE          : SRVMIG001 (SQL Server)
-- VERSION             : 09.00.3042
-- TARGET DB           : cob_interfase
--------------------------------------------------------------------------------

--
-- Target Database: cob_interfase
--

use cob_interfase
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

EXEC sp_addtype 'cuenta', 'char(14)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='cuenta')
    PRINT '<<< CREATED DATATYPE cuenta >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE cuenta >>>'
go

EXEC sp_addtype 'descripcion', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='descripcion')
    PRINT '<<< CREATED DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE descripcion >>>'
go

EXEC sp_addtype 'direccion', 'varchar(120)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='direccion')
    PRINT '<<< CREATED DATATYPE direccion >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE direccion >>>'
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

EXEC sp_addtype 'mensaje', 'varchar(240)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='mensaje')
    PRINT '<<< CREATED DATATYPE mensaje >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE mensaje >>>'
go

EXEC sp_addtype 'numero', 'varchar(13)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='numero')
    PRINT '<<< CREATED DATATYPE numero >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE numero >>>'
go

EXEC sp_addtype 'sexo', 'char(1)', 'NULL'
go
IF EXISTS (SELECT * FROM systypes WHERE name='sexo')
    PRINT '<<< CREATED DATATYPE sexo >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE sexo >>>'
go

