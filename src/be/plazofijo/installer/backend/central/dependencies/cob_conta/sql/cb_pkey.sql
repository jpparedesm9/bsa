/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_conta
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

print '--> Indice: [cb_area].[cb_area_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_area]') and name = N'cb_area_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_area_Key] ON [dbo].[cb_area]([ar_empresa] ASC, [ar_area] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_area].[i_ar_area_padre]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_area]') and name = N'i_ar_area_padre')
Begin
   CREATE NONCLUSTERED INDEX [i_ar_area_padre] ON [dbo].[cb_area]([ar_area_padre] ASC,[ar_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_area].[i_ar_nivel]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_area]') and name = N'i_ar_nivel')
Begin
   CREATE NONCLUSTERED INDEX [i_ar_nivel] ON [dbo].[cb_area]([ar_empresa] ASC, [ar_nivel_area] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_boc].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_boc]') and name = N'idx1')
Begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[cb_boc]([bo_cliente] ASC,[bo_cuenta] ASC,[bo_oficina] ASC,[bo_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
End
go

print '--> Indice: [cb_boc_log].[cb_boc_log_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_boc_log]') and name = N'cb_boc_log_key')
begin
   CREATE NONCLUSTERED INDEX [cb_boc_log_key] ON [dbo].[cb_boc_log]([bl_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_boc_respaldo].[cb_boc_respaldo_idx5]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_boc_respaldo]') and name = N'cb_boc_respaldo_idx5')
Begin
   CREATE NONCLUSTERED INDEX [cb_boc_respaldo_idx5] ON [dbo].[cb_boc_respaldo]([bo_secuencial] ASC, [bo_fecha] ASC, [bo_cuenta] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
End
go

print '--> Indice: [cb_boc_respaldo].[cb_conc_retencion_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_conc_retencion]') and name = N'cb_conc_retencion_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cb_conc_retencion_Key] ON [dbo].[cb_conc_retencion]([cr_empresa] ASC, [cr_codigo] ASC, [cr_tipo] ASC, [cr_debcred] ASC
   )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_corte].[cb_corte_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_corte]') and name = N'cb_corte_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cb_corte_Key] ON [dbo].[cb_corte]([co_empresa] ASC, [co_periodo] ASC, [co_corte] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_corte].[cb_corte_Key_fecha]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_corte]') and name = N'cb_corte_Key_fecha')
Begin
   CREATE NONCLUSTERED INDEX [cb_corte_Key_fecha] ON [dbo].[cb_corte]([co_fecha_ini] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_cotizacion].[cb_cotizacion_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cotizacion]') and name = N'cb_cotizacion_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cb_cotizacion_Key] ON [dbo].[cb_cotizacion]([ct_moneda] ASC, [ct_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End 
go

print '--> Indice: [cb_cotizacion].[i_cotizacion]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cotizacion]') and name = N'i_cotizacion')
Begin
   CREATE NONCLUSTERED INDEX [i_cotizacion] ON [dbo].[cb_cotizacion]([ct_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End 
go

print '--> Indice: [cb_cuenta].[cb_cuenta_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta]') and name = N'cb_cuenta_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_cuenta_Key] ON [dbo].[cb_cuenta]([cu_cuenta] ASC,	[cu_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_cuenta].[i_cu_categoria]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta]') and name = N'i_cu_categoria')
begin
   CREATE NONCLUSTERED INDEX [i_cu_categoria] ON [dbo].[cb_cuenta]([cu_categoria] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_cuenta].[i_cu_cuenta_padre]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta]') and name = N'i_cu_cuenta_padre')
begin
   CREATE NONCLUSTERED INDEX [i_cu_cuenta_padre] ON [dbo].[cb_cuenta]([cu_cuenta_padre] ASC, [cu_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_cuenta].[i_cu_moneda]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta]') and name = N'i_cu_moneda')
begin
   CREATE NONCLUSTERED INDEX [i_cu_moneda] ON [dbo].[cb_cuenta]([cu_moneda] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_cuenta].[i_cu_nivel_cuenta]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta]') and name = N'i_cu_nivel_cuenta')
begin
   CREATE NONCLUSTERED INDEX [i_cu_nivel_cuenta] ON [dbo].[cb_cuenta]([cu_empresa] ASC, [cu_nivel_cuenta] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end 
GO

print '--> Indice: [cb_cuenta_proceso].[cb_cuenta_proceso_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_cuenta_proceso]') and name = N'cb_cuenta_proceso_Key')
begin
   CREATE NONCLUSTERED INDEX [cb_cuenta_proceso_Key] ON [dbo].[cb_cuenta_proceso]([cp_proceso] ASC, [cp_oficina] ASC, [cp_area] ASC, [cp_cuenta] ASC, [cp_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
GO

print '--> Indice: [cb_det_perfil].[cb_det_perfil_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_det_perfil]') and name = N'cb_det_perfil_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_det_perfil_Key] ON [dbo].[cb_det_perfil]([dp_empresa] ASC, [dp_producto] ASC, [dp_perfil] ASC, [dp_asiento] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_det_perfil].[cb_det_perfil_Key2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_det_perfil]') and name = N'cb_det_perfil_Key2')
begin
   CREATE NONCLUSTERED INDEX [cb_det_perfil_Key2] ON [dbo].[cb_det_perfil]([dp_perfil] ASC, [dp_codval] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_ica].[cb_ica_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_ica]') and name = N'cb_ica_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_ica_Key] ON [dbo].[cb_ica]([ic_empresa] ASC, [ic_codigo] ASC, [ic_ciudad] ASC, [ic_debcred] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_iva].[cb_iva_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_iva]') and name = N'cb_iva_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_iva_Key] ON [dbo].[cb_iva]([iva_empresa] ASC, [iva_codigo] ASC, [iva_debcred] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end 
go

print '--> Indice: [cb_iva_pagado].[cb_iva_pagado_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_iva_pagado]') and name = N'cb_iva_pagado_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_iva_pagado_Key] ON [dbo].[cb_iva_pagado]([ip_empresa] ASC, [ip_codigo] ASC, [ip_debcred] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end 
go

print '--> Indice: [cb_oficina].[cb_oficina_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_oficina]') and name = N'cb_oficina_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_oficina_Key] ON [dbo].[cb_oficina]([of_empresa] ASC, [of_oficina] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_oficina].[i_of_oficina_padre]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_oficina]') and name = N'i_of_oficina_padre')
begin
   CREATE NONCLUSTERED INDEX [i_of_oficina_padre] ON [dbo].[cb_oficina]([of_oficina_padre] ASC, [of_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_oficina].[i_of_organizacion]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_oficina]') and name = N'i_of_organizacion')
begin
   CREATE NONCLUSTERED INDEX [i_of_organizacion] ON [dbo].[cb_oficina]([of_organizacion] ASC, [of_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_parametro].[cb_parametro_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_parametro]') and name = N'cb_parametro_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cb_parametro_Key] ON [dbo].[cb_parametro]([pa_empresa] ASC, [pa_parametro] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_perfil].[cb_perfil_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_perfil]') and name = N'cb_perfil_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_perfil_Key] ON [dbo].[cb_perfil]([pe_empresa] ASC, [pe_producto] ASC, [pe_perfil] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_periodo].[cb_periodo_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_periodo]') and name = N'cb_periodo_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_periodo_Key] ON [dbo].[cb_periodo]([pe_empresa] ASC, [pe_periodo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_regimen_fiscal].[cb_regimen_fiscal_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_regimen_fiscal]') and name = N'cb_regimen_fiscal_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_regimen_fiscal_Key] ON [dbo].[cb_regimen_fiscal]([rf_codigo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_relofi].[cb_relofi_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_relofi]') and name = N'cb_relofi_Key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [cb_relofi_Key] ON [dbo].[cb_relofi]([re_filial] ASC, [re_empresa] ASC, [re_ofadmin] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_relparam].[cb_relparam_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_relparam]') and name = N'cb_relparam_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [cb_relparam_Key] ON [dbo].[cb_relparam]([re_empresa] ASC, [re_parametro] ASC, [re_clave] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [cb_saldo].[cb_saldo_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_saldo]') and name = N'cb_saldo_Key')
begin
   CREATE UNIQUE NONCLUSTERED INDEX [cb_saldo_Key] ON [dbo].[cb_saldo]([sa_cuenta] ASC, [sa_oficina] ASC, [sa_area] ASC, [sa_corte] ASC, [sa_periodo] ASC, [sa_empresa] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
End
go

print '--> Indice: [cb_seqnos_comprobante].[cb_seqnos_comprobante_01]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_seqnos_comprobante]') and name = N'cb_seqnos_comprobante_01')
Begin
   CREATE NONCLUSTERED INDEX [cb_seqnos_comprobante_01] ON [dbo].[cb_seqnos_comprobante]([sc_empresa] ASC, [sc_fecha] ASC, [sc_tabla] ASC, [sc_modulo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cb_tipo_area].[cb_tipo_area_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cb_tipo_area]') and name = N'cb_tipo_area_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cb_tipo_area_Key] ON [dbo].[cb_tipo_area]([ta_empresa] ASC, [ta_producto] ASC, [ta_tiparea] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''
