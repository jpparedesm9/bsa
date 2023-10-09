/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_sbancarios
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

print '--> Indice: [sb_impresion_lotes].[sb_impresion_lotes_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_impresion_lotes]') and name = N'sb_impresion_lotes_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [sb_impresion_lotes_Key] ON [dbo].[sb_impresion_lotes]([il_secuencial] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [sb_impresion_lotes].[sb_impresion_lotes_FKey1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_impresion_lotes]') and name = N'sb_impresion_lotes_FKey1')
Begin
   CREATE NONCLUSTERED INDEX [sb_impresion_lotes_FKey1] ON [dbo].[sb_impresion_lotes]([il_idlote] ASC, [il_estado] ASC, [il_idseries] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_impresion_lotes].[sb_impresion_lotes_FKey2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_impresion_lotes]') and name = N'sb_impresion_lotes_FKey2')
Begin
   CREATE NONCLUSTERED INDEX [sb_impresion_lotes_FKey2] ON [dbo].[sb_impresion_lotes]([il_oficina_destino] ASC, [il_estado] ASC, [il_fecha_solicitud] ASC, [il_fecha_impresion] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_impresion_lotes].[sb_impresion_lotes_FKey3]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_impresion_lotes]') and name = N'sb_impresion_lotes_FKey3')
Begin
   CREATE NONCLUSTERED INDEX [sb_impresion_lotes_FKey3] ON [dbo].[sb_impresion_lotes]([il_producto] ASC, [il_instrumento] ASC, [il_subtipo] ASC, [il_serie_literal] ASC, [il_serie_numerica] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_impresion_lotes].[sb_impresion_lotes_FKey4]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_impresion_lotes]') and name = N'sb_impresion_lotes_FKey4')
Begin
   CREATE NONCLUSTERED INDEX [sb_impresion_lotes_FKey4] ON [dbo].[sb_impresion_lotes]([il_beneficiario] ASC, [il_estado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_tran_servicio].[sb_tran_servicio_FKey]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_tran_servicio]') and name = N'sb_tran_servicio_FKey')
Begin
   CREATE NONCLUSTERED INDEX [sb_tran_servicio_FKey] ON [dbo].[sb_tran_servicio]([ts_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_tran_servicio].[sb_tran_servicio_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_tran_servicio]') and name = N'sb_tran_servicio_Key')
begin
   CREATE NONCLUSTERED INDEX [sb_tran_servicio_Key] ON [dbo].[sb_tran_servicio]([ts_tipo_transaccion] ASC, [ts_oficina] ASC, [ts_tabla] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [sb_utilizados_ins].[sb_sutilizados_ins_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_utilizados_ins]') and name = N'sb_sutilizados_ins_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [sb_sutilizados_ins_Key] ON [dbo].[sb_utilizados_ins]([ui_sub_tipo] ASC, [ui_serie_literal] ASC, [ui_serie_desde] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [sb_utilizados_ins].[sb_utilizados_ins_FKey1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[sb_utilizados_ins]') and name = N'sb_utilizados_ins_FKey1')
Begin
   CREATE NONCLUSTERED INDEX [sb_utilizados_ins_FKey1] ON [dbo].[sb_utilizados_ins]([ui_fecha_util] ASC, [ui_oficina] ASC, [ui_prod_destino] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
