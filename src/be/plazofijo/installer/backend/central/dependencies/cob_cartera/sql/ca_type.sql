/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Tipos de Datos                              */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cartera
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '****************************************'
print '*****  CREACION DE TIPOS DE DATOS ******'
print '****************************************'
print ''
print 'Inicio Ejecucion Creacion de Tipos de Datos Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tipo de Dato: Sexo'
if not exists (select 1 from systypes where name = 'sexo')
   exec sp_addtype sexo, 'char(1)', 'null'
go

if exists(select 1 from sysobjects where name = 'sexo' and type = 'R')
   drop rule sexo
go
  
create rule sexo as @var_sexo in ('F', 'M')
go

print '-->Tipo de Dato: Numero'
if not exists (select 1 from systypes where name = 'numero')
   exec sp_addtype numero, 'varchar(13)', 'null'
go

if exists(select 1 from sysobjects where name = 'numero' and type = 'R')
   drop rule numero
go
  
create rule numero as @var_numero like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
go

print '-->Tipo de Dato: Descripcion'
if not exists (select 1 from systypes where name = 'descripcion')
   exec sp_addtype descripcion, 'varchar(64)', 'null'
go
    
print '-->Tipo de Dato: Direccion'
if not exists (select 1 from systypes where name = 'direccion')
   exec sp_addtype direccion, 'varchar(120)', 'null'
go

print '-->Tipo de Dato: Estado'
if not exists (select 1 from systypes where name = 'estado')
    exec sp_addtype estado, 'char(1)', 'null'
go

if exists(select 1 from sysobjects where name = 'estado' and type = 'R')
   drop rule estado
go
  
create rule estado as @var_estado in ('V', 'E', 'C')
go

print '-->Tipo de Dato: Login'
if not exists (select 1 from systypes where name = 'login')
   exec sp_addtype login, 'varchar(14)', 'null'
go

print '-->Tipo de Dato: Catalogo'
if not exists (select 1 from systypes where name = 'catalogo')
   exec sp_addtype catalogo, 'varchar(10)', 'null'
go

print '-->Tipo de Dato: Cuenta'
if not exists (select 1 from systypes where name = 'cuenta')
   exec sp_addtype cuenta, 'varchar(24)', 'null'
go

print '-->Tipo de Dato: Mensaje'
if not exists (select 1 from systypes where name = 'mensaje')
   exec sp_addtype mensaje, 'varchar(240)', 'null'
go

print '-->Tipo de Dato: Alterno'
if not exists (select 1 from systypes where name = 'alterno')
   exec sp_addtype alterno, 'int','null'
go

print '-->Tipo de Dato: Fecha'
if not exists (select 1 from systypes where name = 'fecha')
   exec sp_addtype fecha, 'datetime','null'
go

print ''
print 'Fin Ejecucion Creacion de Tipos de Datos Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''