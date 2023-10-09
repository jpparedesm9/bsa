/*	
	Script de creacion de los tipos de datos de usuario para
	el sistema de REMESAS.
	10MAY2016
*/

use cob_remesas
go

print '******** CREACION DE TIPOS DE DATOS *********'
/*	
**	Creacion de tipos de datos de usuario 
*/
print 'Tipo de dato:  cuenta'
if not exists (select * from systypes where name = 'cuenta')
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go

print 'Tipo de dato:  catalogo'
if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print 'Tipo de dato:  estado'
if exists (select * from systypes where name = 'estado')
    exec sp_droptype estado
go
    exec sp_addtype estado, 'char(1)', 'null'
go
--if object_id ('estado') != null
--    create rule estado as @var_estado in ('V', 'E', 'C')
--go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(240)', 'null'
go

use cob_remesas_his
go

print '******** CREACION DE TIPOS DE DATOS *********'
/*	
	Creacion de tipos de datos de usuario 
*/

print 'Tipo de dato:  cuenta'
if exists (select * from systypes where name = 'cuenta')
    exec sp_droptype cuenta
go
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print 'Tipo de dato:  descripcion'
if exists (select * from systypes where name = 'descripcion')
    exec sp_droptype descripcion
go
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go
    
print 'Tipo de dato:  catalogo'
if exists (select * from systypes where name = 'catalogo')
    exec sp_droptype catalogo
go
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print 'Tipo de dato:  estado'
if exists (select * from systypes where name = 'estado')
    exec sp_droptype estado
go
    exec sp_addtype estado, 'char(1)', 'null'
go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(240)', 'null'
go

--if object_id ('estado') != null
--    create rule estado as @var_estado in ('V', 'E', 'C')
--go