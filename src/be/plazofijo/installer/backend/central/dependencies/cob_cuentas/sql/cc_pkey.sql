/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_cuentas
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

print '--> Indice: [cc_cheque].[cc_cheque_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_cheque]') and name = N'cc_cheque_Key')
   CREATE UNIQUE CLUSTERED INDEX [cc_cheque_Key] ON [dbo].[cc_cheque]([cq_cuenta] ASC, [cq_fecha_reg] ASC, [cq_cheque] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_cheque].[icq_estado_cheque]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_cheque]') and name = N'icq_estado_cheque')
   CREATE UNIQUE NONCLUSTERED INDEX [icq_estado_cheque] ON [dbo].[cc_cheque]([cq_cuenta] ASC, [cq_cheque] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_cheque].[icq_estado_fecha]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_cheque]') and name = N'icq_estado_fecha')
   CREATE NONCLUSTERED INDEX [icq_estado_fecha] ON [dbo].[cc_cheque]([cq_estado_actual] ASC, [cq_estado_anterior] ASC, [cq_fecha_reg] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_chequera].[cc_chequera_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_chequera]') and name = N'cc_chequera_Key')
   CREATE UNIQUE CLUSTERED INDEX [cc_chequera_Key] ON [dbo].[cc_chequera]
   (
   	[ch_cuenta] ASC,
   	[ch_chequera] ASC
   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_chequera].[cc_cheqestadoKey]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_chequera]') and name = N'cc_cheqestadoKey')
   CREATE NONCLUSTERED INDEX [cc_cheqestadoKey] ON [dbo].[cc_chequera]([ch_cuenta] ASC, [ch_estado] ASC, [ch_inicial] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_chequera].[cc_chqr_imprenta_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_chequera]') and name = N'cc_chqr_imprenta_Key')
   CREATE NONCLUSTERED INDEX [cc_chqr_imprenta_Key] ON [dbo].[cc_chequera]([ch_ofi_emision] ASC, [ch_estado] ASC, [ch_cuenta] ASC, [ch_inicial] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_chequera].[i_ch_tchequera]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_chequera]') and name = N'i_ch_tchequera')
   CREATE NONCLUSTERED INDEX [i_ch_tchequera] ON [dbo].[cc_chequera]([ch_tipo_chequera] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_chq_beneficiario].[cc_chq_beneficiario_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_chq_beneficiario]') and name = N'cc_chq_beneficiario_Key')
   CREATE UNIQUE CLUSTERED INDEX [cc_chq_beneficiario_Key] ON [dbo].[cc_chq_beneficiario]([cb_cuenta] ASC, [cb_cheque] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_ctacte].[cc_ctacte_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_ctacte]') and name = N'cc_ctacte_Key')
   CREATE UNIQUE CLUSTERED INDEX [cc_ctacte_Key] ON [dbo].[cc_ctacte]
   (
   	[cc_cta_banco] ASC
   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_ctacte].[i_cc_cliente]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_ctacte]') and name = N'i_cc_cliente')
   CREATE NONCLUSTERED INDEX [i_cc_cliente] ON [dbo].[cc_ctacte]([cc_cliente] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_ctacte].[i_cc_ctacte]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_ctacte]') and name = N'i_cc_ctacte')
   CREATE UNIQUE NONCLUSTERED INDEX [i_cc_ctacte] ON [dbo].[cc_ctacte]([cc_ctacte] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_ctacte].[i_cc_servicio]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_ctacte]') and name = N'i_cc_servicio')
   CREATE NONCLUSTERED INDEX [i_cc_servicio] ON [dbo].[cc_ctacte]
   (
   	[cc_filial] ASC,
   	[cc_oficina] ASC,
   	[cc_moneda] ASC
   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_fecha_valor].[cc_fecha_valor_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_fecha_valor]') and name = N'cc_fecha_valor_Key')
   CREATE UNIQUE NONCLUSTERED INDEX [cc_fecha_valor_Key] ON [dbo].[cc_fecha_valor]([fv_transaccion] ASC, [fv_cuenta] ASC, [fv_referencia] ASC, [fv_rubro] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_ofi_safe].[cc_ofi_safe_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_ofi_safe]') and name = N'cc_ofi_safe_Key')
   CREATE UNIQUE CLUSTERED INDEX [cc_ofi_safe_Key] ON [dbo].[cc_ofi_safe]([co_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
go

print '--> Indice: [cc_tran_servicio].[cc_tran_servicio_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_tran_servicio]') and name = N'cc_tran_servicio_Key')
   CREATE UNIQUE NONCLUSTERED INDEX [cc_tran_servicio_Key] ON [dbo].[cc_tran_servicio]([ts_tipo_transaccion] ASC, [ts_clase] ASC, [ts_secuencial] ASC, [ts_cod_alterno] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
go

print '--> Indice: [cc_tran_servicio].[cc_tran_servicio_branch]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_tran_servicio]') and name = N'cc_tran_servicio_branch')
   CREATE NONCLUSTERED INDEX [cc_tran_servicio_branch] ON [dbo].[cc_tran_servicio]([ts_ssn_branch] ASC, [ts_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
go

print '--> Indice: [cc_tran_servicio].[cc_tran_servicio_tran]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cc_tran_servicio]') and name = N'cc_tran_servicio_tran')
   CREATE NONCLUSTERED INDEX [cc_tran_servicio_tran] ON [dbo].[cc_tran_servicio]([ts_oficina] ASC, [ts_moneda] ASC, [ts_tipo_transaccion] ASC, [ts_secuencial] ASC, [ts_cod_alterno] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
go

