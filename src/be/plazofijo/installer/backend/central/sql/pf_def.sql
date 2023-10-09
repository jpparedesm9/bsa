/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Default                                     */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

print '*************************************'
print '*****  CREACION DE DEFAULT ******'
print '*************************************'
print ''
print 'Inicio Ejecucion Creacion de Default Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Default: Alterno'
go

create default [dbo].[alterno] as
datepart(hh,getdate())*3600000 +
datepart(mi,getdate())*60000 +
datepart(ss,getdate())*1000 + datepart(ms,getdate())
go

print '-->Default: Fecha'
go

create default [dbo].[fecha] as
convert(datetime,convert(varchar,getdate(),101))
go

print ''
print 'Fin Ejecucion Creacion de Default Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''