/************************************************************************/
/*    Archivo:        ad_dtype.sql                                      */
/*    Base de datos:  cobis y cob_distrib                               */
/*    Producto:       Admin                                             */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'COBISCORP'                                                       */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de COBISCORP o su representante.            */
/************************************************************************/
/*                PROPOSITO                                             */
/*    Este script crea los tipos de datos propios y reglas asociadas    */
/*    tanto para la base de datos cobis como para la cob_distrib        */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA         AUTOR       RAZON                                   */
/*  14-04-2016      BBO         Migracion SYB-SQL FAL                   */
/************************************************************************/

use tempdb
go

print 'Tipos de datos sobre BDD tempdb'
go

print 'Tipo de dato ---> mensaje'
go

if exists (select * from systypes where name = 'mensaje')
   exec sp_droptype mensaje
go
exec sp_addtype mensaje, 'varchar(255)', 'null'
go


print 'Tipo de dato ---> sexo'
go

if exists (select * from systypes where name = 'sexo')
   exec sp_droptype sexo
go

exec sp_addtype sexo, 'char(1)', 'null'
go

if object_id('rsexo') is not null
   drop rule rsexo
go

create rule rsexo as @var_sexo in ('F', 'M')

go


print 'Tipo de dato ---> numero'
go

if exists (select * from systypes where name = 'numero')
   exec sp_droptype numero
go

exec sp_addtype numero, 'varchar(30)', 'null'
go

if object_id('rnumero') is not null
   drop rule rnumero
go


print 'Tipo de dato ---> descripcion'
go

if exists (select * from systypes where name = 'descripcion')
    exec sp_droptype descripcion
go

exec sp_addtype descripcion, 'varchar(64)', 'null'
go
    

print 'Tipo de dato ---> direccion'
go

if exists (select * from systypes where name = 'direccion')
    exec sp_droptype  direccion
go

exec sp_addtype direccion, 'varchar(255)', 'null'
go


print 'Tipo de dato ---> estado'
go

if exists (select * from systypes where name = 'estado')
   exec sp_droptype estado
go

exec sp_addtype estado, 'char(1)', 'null'
go

if object_id('restado') is not null
   drop rule restado
go

create rule restado as @var_estado in ('V', 'E', 'C')
go


print 'Tipo de dato ---> login'
go

if exists (select * from systypes where name = 'login')
    exec sp_droptype login
go

exec sp_addtype login, 'varchar(14)', 'null'
go

--RZ

print 'Tipo de dato ---> descripcioncryp'
go

if exists (select * from systypes where name = 'descripcioncryp')
    exec sp_droptype descripcioncryp
go

exec sp_addtype descripcioncryp, 'varchar(255)', 'null'
go

print 'Tipo de dato:  catalogo'
go

if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go


/* BDD: cobis */

use cobis
go

print 'Tipo de dato:  mensaje'
if not exists (select * from systypes where name = 'mensaje')
    exec sp_addtype mensaje, 'varchar(255)', 'null'
go

print 'Tipo de dato:  sexo'
if not exists (select * from systypes where name = 'sexo')
    exec sp_addtype sexo, 'char(1)', 'null'
go

if exists (select * from sysobjects where name = 'sexo')
        drop rule sexo
go
    create rule sexo as @var_sexo in ('F', 'M')
go

print 'Tipo de dato:  numero'
if not exists (select * from systypes where name = 'numero')
    exec sp_addtype numero, 'varchar(30)', 'null'
go

print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go
    
print 'Tipo de dato:  direccion'
if not exists (select * from systypes where name = 'direccion')
    exec sp_addtype direccion, 'varchar(255)', 'null'

print 'Tipo de dato:  estado'
if not exists (select * from systypes where name = 'estado')
    exec sp_addtype estado, 'char(1)', 'null'
go

if exists (select * from sysobjects where name = 'r_estado')
        drop rule r_estado
go
    create rule r_estado as @var_estado in ('V','E','C','B','F')
go

print 'Tipo de dato:  login'
if not exists (select * from systypes where name = 'login')
    exec sp_addtype login, 'varchar(14)', 'null'
go

print 'Tipo de dato:  catalogo'
if not exists (select * from systypes where name = 'catalogo')
    exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print 'Tipo de dato:  cuenta'
if not exists (select * from systypes where name = 'cuenta')
    exec sp_addtype cuenta, 'varchar(24)', 'null'
go


/* BDD: cob_distrib */

use cob_distrib
go

print 'Tipo de dato:  login'
if not exists (select * from systypes where name = 'login')
    exec sp_addtype login, 'varchar(14)', 'null'
go

print 'Tipo de dato:  descripcion'
if not exists (select * from systypes where name = 'descripcion')
    exec sp_addtype descripcion, 'varchar(64)', 'null'
go

/****** ADMIN WEB ******/

use cobis
go

print 'Tipo de dato: url'
if not exists (select * from systypes where name = 'url')
    exec sp_addtype url, 'varchar(255)', 'null'
go

/******* FIN ADMIN WEB ******/
