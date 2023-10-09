USE cob_sincroniza
go

-----------------------------------
-- CREATE USER DEFINED DATATYPES --
-----------------------------------
PRINT '<<< INICIALIZACION DEL PROCESO DE CREACION >>>'

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
    EXEC sp_addtype 'descripcion', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
    PRINT '<<< CREADO DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE descripcion >>>'
go

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name='login')
    EXEC sp_addtype 'login', 'varchar(14)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
    PRINT '<<< CREADO DATATYPE login >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE login >>>'
go
