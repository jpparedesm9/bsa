/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta_tercero
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

print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_saldo_tercero]') and name = N'ct_saldo_tercero_Key')
begin
   CREATE UNIQUE NONCLUSTERED INDEX [ct_saldo_tercero_Key] ON [dbo].[ct_saldo_tercero]([st_corte] ASC, [st_periodo] ASC, [st_cuenta] ASC, [st_oficina] ASC, [st_area] ASC, [st_ente] ASC, [st_empresa] ASC) INCLUDE ([st_saldo])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
GO

print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key_cuenta]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_saldo_tercero]') and name = N'ct_saldo_tercero_Key_cuenta')
Begin
   CREATE NONCLUSTERED INDEX [ct_saldo_tercero_Key_cuenta] ON [dbo].[ct_saldo_tercero]([st_cuenta] ASC, [st_periodo] ASC, [st_corte] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [ct_saldo_tercero].[ct_saldo_tercero_Key_ente]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_saldo_tercero]') and name = N'ct_saldo_tercero_Key_ente')
begin
   CREATE NONCLUSTERED INDEX [ct_saldo_tercero_Key_ente] ON [dbo].[ct_saldo_tercero]([st_ente] ASC, [st_periodo] ASC, [st_corte] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [ct_sasiento].[ct_sasiento_AKey0]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_sasiento]') and name = N'ct_sasiento_AKey0')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ct_sasiento_AKey0] ON [dbo].[ct_sasiento]([sa_comprobante] ASC, [sa_fecha_tran] ASC, [sa_producto] ASC, [sa_asiento] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [ct_sasiento].[ct_sasiento_AKey1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_sasiento]') and name = N'ct_sasiento_AKey1')
Begin
   CREATE NONCLUSTERED INDEX [ct_sasiento_AKey1] ON [dbo].[ct_sasiento]([sa_ente] ASC, [sa_cuenta] ASC, [sa_fecha_tran] ASC, [sa_oficina_dest] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [ct_sasiento].[ct_sasiento_AKey2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_sasiento]') and name = N'ct_sasiento_AKey2')
begin
   CREATE NONCLUSTERED INDEX [ct_sasiento_AKey2] ON [dbo].[ct_sasiento]([sa_cuenta] ASC, [sa_fecha_tran] ASC, [sa_oficina_dest] ASC) INCLUDE ([sa_ente], [sa_debito], [sa_credito], [sa_empresa], [sa_producto], [sa_comprobante])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
End
go

print '--> Indice: [ct_sasiento_tmp].[ct_sasiento_tmp_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_sasiento_tmp]') and name = N'ct_sasiento_tmp_Key')
Begin
   CREATE NONCLUSTERED INDEX [ct_sasiento_tmp_Key] ON [dbo].[ct_sasiento_tmp]([sa_fecha_tran] ASC, [sa_producto] ASC, [sa_comprobante] ASC, [sa_asiento] ASC, [sa_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante].[ct_scomprobante_AKey1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante]') and name = N'ct_scomprobante_AKey1')
Begin
   CREATE NONCLUSTERED INDEX [ct_scomprobante_AKey1] ON [dbo].[ct_scomprobante]([sc_estado] ASC, [sc_fecha_tran] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante].[ct_scomprobante_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante]') and name = N'ct_scomprobante_Key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ct_scomprobante_Key] ON [dbo].[ct_scomprobante]([sc_fecha_tran] ASC, [sc_producto] ASC, [sc_comprobante] ASC, [sc_empresa] ASC) INCLUDE ([sc_estado])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante].[ct_scomprobante_idx5]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante]') and name = N'ct_scomprobante_idx5')
Begin
   CREATE NONCLUSTERED INDEX [ct_scomprobante_idx5] ON [dbo].[ct_scomprobante]([sc_estado] ASC, [sc_fecha_tran] ASC) INCLUDE ([sc_producto], [sc_comprobante], [sc_empresa], [sc_oficina_orig], [sc_fecha_gra], [sc_comp_definit])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante].[i_ct_scomp_1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante]') and name = N'i_ct_scomp_1')
Begin
   CREATE NONCLUSTERED INDEX [i_ct_scomp_1] ON [dbo].[ct_scomprobante]([sc_fecha_tran] ASC, [sc_producto] ASC, [sc_oficina_orig] ASC, [sc_area_orig] ASC, [sc_perfil] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante]') and name = N'idx1')
Begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[ct_scomprobante]([sc_fecha_tran] ASC, [sc_mayorizado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante_tmp].[ct_scomprobante_tmp_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante_tmp]') and name = N'ct_scomprobante_tmp_Key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [ct_scomprobante_tmp_Key] ON [dbo].[ct_scomprobante_tmp]([sc_fecha_tran] ASC, [sc_producto] ASC, [sc_comprobante] ASC, [sc_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [ct_scomprobante_tmp].[idx2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ct_scomprobante_tmp]') and name = N'idx2')
Begin
   CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[ct_scomprobante_tmp]([sc_oficina_orig] ASC, [sc_fecha_tran] ASC, [sc_producto] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''