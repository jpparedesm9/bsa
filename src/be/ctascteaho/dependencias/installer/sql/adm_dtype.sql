
use tempdb
go

if not exists (select * from systypes where name = 'sexo')
   create type sexo from char(1) null

if not exists (select * from systypes where name = 'numero')
   create type numero from varchar(13) null

if not exists (select * from systypes where name = 'mensaje')
   create type mensaje from varchar(240) null

if not exists (select * from systypes where name = 'login')
   create type login from varchar(14) null

if not exists (select * from systypes where name = 'estado')
    create type estado from char(1) null

if not exists (select * from systypes where name = 'direccion')
    create type direccion from varchar(120) null

if not exists (select * from systypes where name = 'descripcion')
    create type descripcion from varchar(64) null

if not exists (select * from systypes where name = 'cuenta')
   create type cuenta from varchar(24) null

if not exists (select * from systypes where name = 'catalogo')
   create type catalogo from varchar(10) null
go

