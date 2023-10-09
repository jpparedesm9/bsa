/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_his
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

print '--> Indice: [cb_hist_saldo].[cb_hist_saldo_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_hist_saldo]') and name = N'cb_hist_saldo_key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [cb_hist_saldo_key] ON [dbo].[cb_hist_saldo]([hi_corte] ASC, [hi_periodo] ASC, [hi_oficina] ASC, [hi_area] ASC, [hi_cuenta] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PSc_RangoAno]([hi_periodo])
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
