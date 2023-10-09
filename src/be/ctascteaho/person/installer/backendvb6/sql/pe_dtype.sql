/*	
**	Script de creacion de los tipos de datos de usuario para
**	el sistema de REMESAS.
**	10MAY2016
*/

use cob_remesas
go

print '******** CREACION DE TIPOS DE DATOS *********'
/*	
**	Creacion de tipos de datos de usuario 
*/

print 'Tipo de dato:  catalogo'
if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print 'Tipo de dato:  cuenta'
if not exists (select * from systypes where name = 'cuenta')
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print 'Tipo de dato:  cuenta_contable'
if not exists (select * from systypes where name = 'cuenta_contable')
    exec sp_addtype cuenta_contable, 'char(14)', 'null'
go

print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go

print 'Tipo de dato:  direccion'
if not exists (select * from systypes where name = 'direccion')
    exec sp_addtype direccion, 'varchar(120)', 'null'
go

print 'Tipo de dato:  estado'
if not exists (select * from systypes where name = 'estado')
    exec sp_addtype estado, 'char(1)', 'null'
go

print 'Tipo de dato:  login'
if not exists (select * from systypes where name = 'login')
    exec sp_addtype login, 'varchar(14)', 'null'
go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(240)', 'null'
go

print 'Tipo de dato:  numero'
if not exists (select * from systypes where name = 'numero')
    exec sp_addtype numero, 'varchar(13)', 'null'
go

print 'Tipo de dato:  sexo'
if not exists (select * from systypes where name = 'sexo')
    exec sp_addtype sexo, 'char(1)', 'null'
go

