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
   CREATE UNIQUE CLUSTERED INDEX [costo_Key] ON [dbo].[pe_costo]([co_secuencial] ASC, [co_servicio_per] ASC, [co_categoria] ASC, [co_tipo_rango] ASC, [co_grupo_rango] ASC, [co_rango] ASC, [co_fecha_vigencia] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [pa_gestion_paquete].[pa_gestion_paquete_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pa_gestion_paquete]') and name = N'pa_gestion_paquete_key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [pa_gestion_paquete_key] ON [dbo].[pa_gestion_paquete]([gp_numpq] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pa_bonificacion_cargos].[pa_bonificacion_cargos_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pa_bonificacion_cargos]') and name = N'pa_bonificacion_cargos_key')
begin
   CREATE NONCLUSTERED INDEX [pa_bonificacion_cargos_key] ON [dbo].[pa_bonificacion_cargos]([bc_numpq] ASC, [bc_servicio] ASC, [bc_rubro] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
end
go

print '--> Indice: [pe_mercado].[mercado_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_mercado]') and name = N'mercado_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [mercado_Key] ON [dbo].[pe_mercado]([me_mercado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_mercado].[i_mercado]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_mercado]') and name = N'i_mercado')
begin
   CREATE NONCLUSTERED INDEX [i_mercado] ON [dbo].[pe_mercado]([me_tipo_ente] ASC, [me_pro_bancario] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_pro_final].[pro_final_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_pro_final]') and name = N'pro_final_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [pro_final_Key] ON [dbo].[pe_pro_final]([pf_filial] ASC, [pf_sucursal] ASC, [pf_mercado] ASC, [pf_producto] ASC, [pf_moneda] ASC, [pf_tipo] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_pro_final].[i_pro_final]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_pro_final]') and name = N'i_pro_final')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [i_pro_final] ON [dbo].[pe_pro_final]([pf_pro_final] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_rango].[rango_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_rango]') and name = N'rango_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [rango_Key] ON [dbo].[pe_rango]([ra_tipo_rango] ASC, [ra_grupo_rango] ASC, [ra_rango] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_servicio_dis].[servicio_dis_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_servicio_dis]') and name = N'servicio_dis_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [servicio_dis_Key] ON [dbo].[pe_servicio_dis]([sd_servicio_dis] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_servicio_dis].[i_servicio_dis]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_servicio_dis]') and name = N'i_servicio_dis')
begin
   CREATE UNIQUE NONCLUSTERED INDEX [i_servicio_dis] ON [dbo].[pe_servicio_dis]([sd_nemonico] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
End
go

print '--> Indice: [pe_servicio_per].[servicio_per_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_servicio_per]') and name = N'servicio_per_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [servicio_per_Key] ON [dbo].[pe_servicio_per]([sp_pro_final] ASC, [sp_servicio_dis] ASC, [sp_rubro] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_servicio_per].[i_servicio_per]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_servicio_per]') and name = N'i_servicio_per')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [i_servicio_per] ON [dbo].[pe_servicio_per]([sp_servicio_per] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_tipo_rango].[tipo_rango_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_tipo_rango]') and name = N'tipo_rango_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [tipo_rango_Key] ON [dbo].[pe_tipo_rango]([tr_tipo_rango] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_val_contratado].[val_contratado_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_val_contratado]') and name = N'val_contratado_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [val_contratado_Key] ON [dbo].[pe_val_contratado]([vc_secuencial] ASC, [vc_tipo_default] ASC, [vc_rol] ASC, [vc_producto] ASC, [vc_codigo] ASC, [vc_servicio_per] ASC, [vc_categoria] ASC, [vc_tipo_rango] ASC, [vc_grupo_rango] ASC, [vc_rango] ASC, [vc_fecha] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [pe_var_servicio].[var_servicio_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pe_var_servicio]') and name = N'var_servicio_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [var_servicio_Key] ON [dbo].[pe_var_servicio]([vs_servicio_dis] ASC, [vs_rubro] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_banco].[re_banco_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_banco]') and name = N're_banco_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_banco_Key] ON [dbo].[re_banco]([ba_banco] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_caja].[re_caja_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_caja]') and name = N're_caja_Key')
Begin
   CREATE CLUSTERED INDEX [re_caja_Key] ON [dbo].[re_caja]([cj_filial] ASC, [cj_oficina] ASC, [cj_rol] ASC, [cj_operador] ASC, [cj_moneda] ASC, [cj_transaccion] ASC, [cj_id_caja] ASC, [cj_id_cierre] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cheque_rec].[re_cheque_rec_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cheque_rec]') and name = N're_cheque_rec_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_cheque_rec_Key] ON [dbo].[re_cheque_rec]([cr_cta_depositada] ASC, [cr_fecha_ing] ASC, [cr_banco_p] ASC, [cr_cheque_rec] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cheque_rec].[re_cheque_ofi_mone_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cheque_rec]') and name = N're_cheque_ofi_mone_Key')
Begin
   CREATE NONCLUSTERED INDEX [re_cheque_ofi_mone_Key] ON [dbo].[re_cheque_rec]([cr_oficina] ASC, [cr_moneda] ASC, [cr_cta_depositada] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cheque_rec].[re_cheque_rec_cheq]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cheque_rec]') and name = N're_cheque_rec_cheq')
begin
   CREATE NONCLUSTERED INDEX [re_cheque_rec_cheq] ON [dbo].[re_cheque_rec]([cr_cheque_rec] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cheque_rec].[re_fecha_efe_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cheque_rec]') and name = N're_fecha_efe_Key')
begin
   CREATE NONCLUSTERED INDEX [re_fecha_efe_Key] ON [dbo].[re_cheque_rec]([cr_fecha_efe] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cierre].[re_cierre_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cierre]') and name = N're_cierre_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_cierre_Key] ON [dbo].[re_cierre]([ci_filial] ASC, [ci_oficina] ASC, [ci_id_caja] ASC, [ci_fecha] ASC, [ci_id_cierre] ASC, [ci_moneda] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_concep_exen_gmf].[re_concep_exen_gmf_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_concep_exen_gmf]') and name = N're_concep_exen_gmf_key')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [re_concep_exen_gmf_key] ON [dbo].[re_concep_exen_gmf]([ce_concepto] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_cuenta_contractual].[idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_cuenta_contractual]') and name = N'idx1')
Begin
   CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[re_cuenta_contractual]([cc_cta_banco] ASC, [cc_estado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
End
go

print '--> Indice: [re_ofi_banco].[re_ofi_banco_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_ofi_banco]') and name = N're_ofi_banco_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_ofi_banco_Key] ON [dbo].[re_ofi_banco]([ob_banco] ASC, [ob_oficina] ASC, [ob_ciudad] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_ofi_banco].[i_ob_ofi_cobis]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_ofi_banco]') and name = N'i_ob_ofi_cobis')
Begin
   CREATE NONCLUSTERED INDEX [i_ob_ofi_cobis] ON [dbo].[re_ofi_banco]([ob_ofi_cobis] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_saldos_caja].[re_saldos_caja_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_saldos_caja]') and name = N're_saldos_caja_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_saldos_caja_Key] ON [dbo].[re_saldos_caja]([sc_filial] ASC, [sc_oficina] ASC, [sc_id] ASC, [sc_moneda] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_trans_alerta].[re_trans_alerta_key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_trans_alerta]') and name = N're_trans_alerta_key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_trans_alerta_key] ON [dbo].[re_trans_alerta]([ta_transaccion] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [re_trn_grupo].[re_trn_grupo_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[re_trn_grupo]') and name = N're_trn_grupo_Key')
Begin
   CREATE UNIQUE CLUSTERED INDEX [re_trn_grupo_Key] ON [dbo].[re_trn_grupo]([tg_nivel] ASC, [tg_grupo] ASC, [tg_transaccion] ASC, [tg_indicador] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 60) ON [PRIMARY]
End
go

print '--> Indice: [cm_ingreso].[cm_ingreso_Key1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cm_ingreso]') and name = N'cm_ingreso_Key1')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cm_ingreso_Key1] ON [cm_ingreso] (in_banco, in_fecha, in_moneda, in_usuario)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cm_cheques].[cm_cheques_Key1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cm_cheques]') and name = N'cm_cheques_Key1')
Begin
   CREATE UNIQUE CLUSTERED INDEX [cm_cheques_Key1] ON [cm_cheques] (cq_banco, cq_fecha, cq_contador, cq_moneda, cq_usuario)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print '--> Indice: [cm_cheques].[cm_cheques_cta_Key1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[cm_cheques]') and name = N'cm_cheques_cta_Key1')
Begin
   CREATE INDEX [cm_cheques_cta_Key1] ON [cm_cheques] (cq_cuenta, cq_oficina, cq_fecha)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
End
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''