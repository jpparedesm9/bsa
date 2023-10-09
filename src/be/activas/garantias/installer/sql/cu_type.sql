use cob_custodia
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
   EXEC sp_addtype 'catalogo', 'varchar(10)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
    PRINT '<<< CREATED DATATYPE catalogo >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE catalogo >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
   EXEC sp_addtype 'ctacliente', 'varchar(20)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
    PRINT '<<< CREATED DATATYPE ctacliente >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE ctacliente >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='ctacontable')
   EXEC sp_addtype 'ctacontable', 'varchar(20)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacontable')
    PRINT '<<< CREATED DATATYPE ctacontable >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE ctacontable >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
   EXEC sp_addtype 'cuenta', 'varchar(24)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
    PRINT '<<< CREATED DATATYPE cuenta >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE cuenta >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
   EXEC sp_addtype 'descripcion', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
    PRINT '<<< CREATED DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE descripcion >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='login')
   EXEC sp_addtype 'login', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
    PRINT '<<< CREATED DATATYPE login >>>'
ELSE
    PRINT '<<< FAILED CREATING DATATYPE login >>>'
go
