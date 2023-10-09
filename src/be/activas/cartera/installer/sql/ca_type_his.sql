USE cob_cartera_his
go

PRINT '<<< INICIALIZACION DEL PROCESO DE BORRADO >>>'
			
IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
BEGIN
    EXEC sp_droptype 'catalogo'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE catalogo >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
BEGIN
    EXEC sp_droptype 'ctacliente'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE ctacliente >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
BEGIN
    EXEC sp_droptype 'cuenta'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE cuenta >>>'
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
BEGIN
    EXEC sp_droptype 'descripcion'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE descripcion >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
BEGIN
    EXEC sp_droptype 'direccion'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE direccion >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
BEGIN
    EXEC sp_droptype 'estado'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE estado >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
BEGIN
    EXEC sp_droptype 'login'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE login >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
BEGIN
    EXEC sp_droptype 'mensaje'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE mensaje >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
BEGIN
    EXEC sp_droptype 'numero'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE numero >>>'    
END
go

IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
BEGIN
    EXEC sp_droptype 'sexo'
    IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
        PRINT '<<< FALLO EL BORRADO DEL DATATYPE sexo >>>'    
END
go

PRINT '<<< FINALIZACION DEL PROCESO DE BORRADO >>>'


			-----------------------------------
			-- CREATE USER DEFINED DATATYPES --
			-----------------------------------
PRINT '<<< INICIALIZACION DEL PROCESO DE CREACION >>>'
			
			
EXEC sp_addtype 'catalogo', 'varchar(10)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='catalogo')
    PRINT '<<< CREADO DATATYPE catalogo >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE catalogo >>>'
go

EXEC sp_addtype 'ctacliente', 'varchar(20)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='ctacliente')
    PRINT '<<< CREADO DATATYPE ctacliente >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE ctacliente >>>'
go

EXEC sp_addtype 'cuenta', 'varchar(24)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='cuenta')
    PRINT '<<< CREADO DATATYPE cuenta >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE cuenta >>>'
go

EXEC sp_addtype 'descripcion', 'varchar(64)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='descripcion')
    PRINT '<<< CREADO DATATYPE descripcion >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE descripcion >>>'
go

EXEC sp_addtype 'direccion', 'varchar(255)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='direccion')
    PRINT '<<< CREADO DATATYPE direccion >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE direccion >>>'
go

EXEC sp_addtype 'estado', 'char(1)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='estado')
    PRINT '<<< CREADO DATATYPE estado >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE estado >>>'
go

EXEC sp_addtype 'login', 'varchar(14)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='login')
    PRINT '<<< CREADO DATATYPE login >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE login >>>'
go

EXEC sp_addtype 'mensaje', 'varchar(255)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='mensaje')
    PRINT '<<< CREADO DATATYPE mensaje >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE mensaje >>>'
go

EXEC sp_addtype 'numero', 'varchar(13)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='numero')
    PRINT '<<< CREADO DATATYPE numero >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE numero >>>'
go

EXEC sp_addtype 'sexo', 'char(1)', 'NULL'
go
IF EXISTS (SELECT 1 FROM systypes WHERE name='sexo')
    PRINT '<<< CREADO DATATYPE sexo >>>'
ELSE
    PRINT '<<< FALLO LA CREACION DEL DATATYPE sexo >>>'
go

PRINT '<<< FINALIZACION DEL PROCESO DE CREACION >>>'
go

