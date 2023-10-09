use cob_compensacion
go

-----------------------------------
-- CREATE USER DEFINED DATATYPES --
-----------------------------------
PRINT '<<< INICIALIZACION DEL PROCESO DE CREACION >>>'
			
			
IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
   EXEC sp_addtype 'catalogo', 'varchar(10)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
    PRINT '<<< CREADO DATATYPE catalogo >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE catalogo >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
   EXEC sp_addtype 'ctacliente', 'varchar(20)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
    PRINT '<<< CREADO DATATYPE ctacliente >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE ctacliente >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
   EXEC sp_addtype 'cuenta', 'varchar(24)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
    PRINT '<<< CREADO DATATYPE cuenta >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE cuenta >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
   EXEC sp_addtype 'descripcion', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
    PRINT '<<< CREADO DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE descripcion >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
   EXEC sp_addtype 'direccion', 'varchar(255)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
    PRINT '<<< CREADO DATATYPE direccion >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE direccion >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='estado')
   EXEC sp_addtype 'estado', 'char(1)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
    PRINT '<<< CREADO DATATYPE estado >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE estado >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='login')
   EXEC sp_addtype 'login', 'varchar(14)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
    PRINT '<<< CREADO DATATYPE login >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE login >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
   EXEC sp_addtype 'mensaje', 'varchar(255)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
    PRINT '<<< CREADO DATATYPE mensaje >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE mensaje >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='numero')
   EXEC sp_addtype 'numero', 'varchar(13)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
    PRINT '<<< CREADO DATATYPE numero >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE numero >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
   EXEC sp_addtype 'sexo', 'char(1)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
    PRINT '<<< CREADO DATATYPE sexo >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE sexo >>>'
go

PRINT '<<< FINALIZACION DEL PROCESO DE CREACION >>>'
go

