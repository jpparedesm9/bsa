/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_externos
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

print '--> Indice: [ex_dato_deudores].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ex_dato_deudores]') and name = N'idx1')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [dbo].[ex_dato_deudores]([de_banco] ASC, [de_cliente] ASC, [de_fecha] ASC, [de_aplicativo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [ex_dato_transaccion].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ex_dato_transaccion]') and name = N'idx1')
begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[ex_dato_transaccion]([dt_fecha] ASC, [dt_aplicativo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [ex_dato_transaccion_det].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ex_dato_transaccion_det]') and name = N'idx1')
begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[ex_dato_transaccion_det]([dd_fecha] ASC, [dd_aplicativo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''