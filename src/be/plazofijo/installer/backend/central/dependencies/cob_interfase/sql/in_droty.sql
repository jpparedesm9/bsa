/************************************************************************/
/*                 Descripcion                                          */
/*  Script para eliminacion de Tipos de Datos                           */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '*******************************************'
print '*****  ELIMINACION DE TIPOS DE DATOS ******'
print '*******************************************'
print ''
print 'Inicio Ejecucion Eliminacion de Tipos de Datos Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Tipo de Dato: Sexo'
if exists (select 1 from systypes where name = 'sexo')
   exec sp_droptype sexo
go

if exists (select 1 from sysobjects where name = 'sexo' and type = 'R')
   drop rule sexo  
go 

print '-->Tipo de Dato: Numero'
if exists (select 1 from systypes where name = 'numero')
   exec sp_droptype numero
go

if exists (select 1 from sysobjects where name = 'numero' and type = 'R')
   drop rule numero  
go 

print '-->Tipo de Dato: Descripcion'
if exists (select 1 from systypes where name = 'descripcion')
   exec sp_droptype descripcion
go
    
print '-->Tipo de Dato: Direccion'
if exists (select 1 from systypes where name = 'direccion')
   exec sp_droptype direccion
go

print '-->Tipo de Dato: Estado'
if exists (select 1 from systypes where name = 'estado')
   exec sp_droptype estado
go

if exists (select 1 from sysobjects where name = 'estado' and type = 'R')
   drop rule estado  
go 

print '-->Tipo de Dato: Login'
if exists (select 1 from systypes where name = 'login')
   exec sp_droptype login
go

print '-->Tipo de Dato: Catalogo'
if exists (select 1 from systypes where name = 'catalogo')
   exec sp_droptype catalogo
go

print '-->Tipo de Dato: Cuenta'
if exists (select 1 from systypes where name = 'cuenta')
   exec sp_droptype cuenta
go

print '-->Tipo de Dato: Ctacliente'
if exists (select 1 from systypes where name = 'ctacliente')
   exec sp_droptype ctacliente
go

print '-->Tipo de Dato: Mensaje'
if exists (select 1 from systypes where name = 'mensaje')
   exec sp_droptype mensaje
go

print '-->Tipo de Dato: Alterno'
if exists (select 1 from systypes where name = 'alterno')
   exec sp_droptype alterno
go

print '-->Tipo de Dato: Fecha'
if exists (select 1 from systypes where name = 'fecha')
   exec sp_droptype fecha
go

print '-->Tipo de Dato: url'
if exists (select 1 from systypes where name = 'url')
   exec sp_droptype url
go

print ''
print 'Fin Ejecucion eliminacion de Tipos de Datos Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''