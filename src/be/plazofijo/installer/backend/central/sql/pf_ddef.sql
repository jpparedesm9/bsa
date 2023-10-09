/************************************************************************/
/*                 Descripcion                                          */
/*  Script para eliminacion de Default                                  */
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
print '*****  ELIMINACION DE DEFAULT *******'
print '*************************************'
print ''
print 'Inicio Ejecucion Eliminacion de Default Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '-->Default: Fecha'
if exists (select 1 from sys.objects where object_id = OBJECT_ID(N'[dbo].[fecha]') AND OBJECTPROPERTY(object_id, N'IsDefault') = 1)
   drop default [dbo].[fecha]
go

print '-->Default: Alterno'
if exists (select 1 from sys.objects where object_id = OBJECT_ID(N'[dbo].[alterno]') AND OBJECTPROPERTY(object_id, N'IsDefault') = 1)
   drop default [dbo].[alterno]
go

print ''
print 'Fin Ejecucion Eliminacion de Default Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''