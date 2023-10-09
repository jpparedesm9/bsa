/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_remesas
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

print '*********************************'
print '*****  CREACION DE INDICES ******'
print '*********************************'
print ''
print 'Inicio Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '--> Indice: [pe_costo].[costo_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_costo]') and name = N'costo_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [costo_Key] ON [dbo].[pe_costo]([co_secuencial] ASC, [co_servicio_per] ASC, [co_categoria] ASC, [co_tipo_rango] ASC, [co_grupo_rango] ASC, [co_rango] ASC, [co_val_medio] ASC, [co_minimo] ASC, [co_maximo] ASC, [co_fecha_vigencia] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end

go





