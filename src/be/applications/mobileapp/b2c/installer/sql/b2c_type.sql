USE cob_bvirtual
go

print 'Creacion de types'
IF NOT EXISTS (SELECT 1 FROM systypes WHERE name = 'catalogo')
    EXEC sp_addtype 'catalogo', 'VARCHAR(10)', NULL
GO

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name = 'descripcion')
    EXEC sp_addtype 'descripcion', 'VARCHAR(64)', NULL
GO

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name = 'login')
    EXEC sp_addtype 'login', 'VARCHAR(14)', NULL
GO

IF NOT EXISTS (SELECT 1 FROM systypes WHERE name = 'mensaje')
    EXEC sp_addtype 'mensaje', 'VARCHAR(240)', NULL
GO

IF not EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
	EXEC sp_addtype 'cuenta', 'varchar(24)', 'NULL'
go

