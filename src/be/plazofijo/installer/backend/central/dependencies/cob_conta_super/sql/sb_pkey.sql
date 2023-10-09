/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_super
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

print '--> Indice: [sb_calendario_proyec].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_calendario_proyec]') and name = N'idx1')
begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[sb_calendario_proyec]([cp_fecha_proc] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [sb_dato_operacion].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_operacion]') and name = N'idx1')
Begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[sb_dato_operacion]([do_banco] ASC, [do_aplicativo] ASC, [do_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [sb_dato_operacion].[idx2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_operacion]') and name = N'idx2')
Begin
   CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[sb_dato_operacion]([do_codigo_cliente] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End 
go

print '--> Indice: [sb_dato_operacion].[idx3]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_operacion]') and name = N'idx3')
begin
   CREATE NONCLUSTERED INDEX [idx3] ON [dbo].[sb_dato_operacion]([do_fecha] ASC, [do_aplicativo] ASC, [do_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [sb_dato_pasivas].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_pasivas]') and name = N'idx1')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [dbo].[sb_dato_pasivas]([dp_banco] ASC, [dp_aplicativo] ASC, [dp_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
End
go

print '--> Indice: [sb_dato_pasivas].[idx2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_pasivas]') and name = N'idx2')
Begin
   CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[sb_dato_pasivas]([dp_cliente] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
End
go

print '--> Indice: [sb_dato_pasivas].[idx3]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_dato_pasivas]') and name = N'idx3')
Begin
   CREATE NONCLUSTERED INDEX [idx3] ON [dbo].[sb_dato_pasivas]([dp_fecha] ASC, [dp_aplicativo] ASC, [dp_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
End
go

print '--> Indice: [sb_equivalencias].[sb_equivalencias_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_equivalencias]') and name = N'sb_equivalencias_Key')
Begin
   CREATE NONCLUSTERED INDEX [sb_equivalencias_Key] ON [dbo].[sb_equivalencias]([eq_catalogo] ASC, [eq_valor_cat] ASC, [eq_estado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_errorlog].[sb_errorlog_1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_errorlog]') and name = N'sb_errorlog_1')
Begin
   CREATE NONCLUSTERED INDEX [sb_errorlog_1] ON [dbo].[sb_errorlog]
   (
   	[er_fecha_proc] ASC,
   	[er_fuente] ASC
   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

