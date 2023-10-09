/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cartera
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

print '--> Indice: [ca_desembolso].[ca_desembolso_1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_desembolso]') and name = N'ca_desembolso_1')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ca_desembolso_1] ON [dbo].[ca_desembolso]([dm_operacion] ASC, [dm_secuencial] ASC, [dm_desembolso] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_1')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ca_operacion_1] ON [dbo].[ca_operacion]([op_operacion] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_10]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_10')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_10] ON [dbo].[ca_operacion]([op_oficial] ASC) INCLUDE ([op_tramite], [op_cliente], [op_estado])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_2')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_2] ON [dbo].[ca_operacion]([op_migrada] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_3]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_3')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_3] ON [dbo].[ca_operacion]([op_tramite] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_4]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_4')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_4] ON [dbo].[ca_operacion]([op_cliente] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
End 
go

print '--> Indice: [ca_operacion].[ca_operacion_5]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_5')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_5] ON [dbo].[ca_operacion]([op_oficial] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
end 
go

print '--> Indice: [ca_operacion].[ca_operacion_6]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_6')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_6] ON [dbo].[ca_operacion]([op_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
end
go

print '--> Indice: [ca_operacion].[ca_operacion_2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_7')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ca_operacion_7] ON [dbo].[ca_operacion]([op_banco] ASC) INCLUDE ([op_estado_cobranza])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ca_operacion].[ca_operacion_8]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_8')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_8] ON [dbo].[ca_operacion]([op_lin_credito] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
end
go

print '--> Indice: [ca_operacion].[ca_operacion_9]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_9')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_9] ON [dbo].[ca_operacion]([op_estado] ASC, [op_fecha_liq] ASC) INCLUDE ([op_tramite], [op_oficial])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
end 
go

print '--> Indice: [ca_operacion].[ca_operacion_idx11]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_operacion]') and name = N'ca_operacion_idx11')
Begin
   CREATE NONCLUSTERED INDEX [ca_operacion_idx11] ON [dbo].[ca_operacion]([op_naturaleza] ASC, [op_fecha_ult_proceso] ASC, [op_cuenta] ASC) INCLUDE ([op_operacion], [op_estado], [op_forma_pago])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
end 
go

print '--> Indice: [ca_estado].[ca_estado_1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ca_estado]') and name = N'ca_estado_1')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ca_estado_1] ON [dbo].[ca_estado]([es_codigo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end 
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''