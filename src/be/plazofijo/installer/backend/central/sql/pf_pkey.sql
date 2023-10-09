/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de tablas                                      */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  07/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_pfijo
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
print 'Inicio Ejecucion Creacion de Indices Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''

print '--> Indice: [pf_aut_spread].[pf_aut_spread_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_aut_spread]') and name = N'pf_aut_spread_Key')
   drop index [pf_aut_spread_Key] on [pf_aut_spread] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_aut_spread_Key] ON [dbo].[pf_aut_spread](as_operacion ASC, as_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_autorizacion].[pf_autorizacion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_autorizacion]') and name = N'pf_autorizacion_Key')
   drop index [pf_autorizacion_Key] on [pf_autorizacion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_autorizacion_Key] ON [dbo].[pf_autorizacion](au_operacion ASC, au_autoriza ASC, au_tautorizacion ASC, au_fecha_crea ASC, au_oficial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_auxiliar_tip].[pf_auxiliar_tip_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_auxiliar_tip]') and name = N'pf_auxiliar_tip_Key')
   drop index [pf_auxiliar_tip_Key] on [pf_auxiliar_tip] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_auxiliar_tip_Key] ON [dbo].[pf_auxiliar_tip](at_tipo_deposito ASC, at_moneda ASC, at_tipo ASC, at_valor ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_beneficiario].[pf_beneficiario_B_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_beneficiario]') and name = N'pf_beneficiario_B_Key')
   drop index [pf_beneficiario_B_Key] on [pf_beneficiario] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_beneficiario_B_Key] ON [dbo].[pf_beneficiario](be_operacion ASC, be_rol DESC, be_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go
 
print '--> Indice: [pf_beneficiario].[pf_beneficiario_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_beneficiario]') and name = N'pf_beneficiario_Key')
   drop index [pf_beneficiario_Key] on [pf_beneficiario] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_beneficiario_Key] ON [dbo].[pf_beneficiario](be_operacion ASC, be_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go
 
print '--> Indice: [pf_beneficiario_tmp].[pf_beneficiario_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_beneficiario_tmp]') and name = N'pf_beneficiario_tmp_Key')
   drop index [pf_beneficiario_tmp_Key] on [pf_beneficiario_tmp] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_beneficiario_tmp_Key] ON [dbo].[pf_beneficiario_tmp](bt_usuario ASC, bt_sesion ASC, bt_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_bloqueo_legal].[pf_bloqueo_legal_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_bloqueo_legal]') and name = N'pf_bloqueo_legal_Key')
   drop index [pf_bloqueo_legal_Key] on [pf_bloqueo_legal] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_bloqueo_legal_Key] ON [dbo].[pf_bloqueo_legal](bl_operacion ASC, bl_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cambio_oper].[pf_cambio_oper_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cambio_oper]') and name = N'pf_cambio_oper_Key')
   drop index [pf_cambio_oper_Key] on [pf_cambio_oper] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_cambio_oper_Key] ON [dbo].[pf_cambio_oper](co_secuencial ASC, co_operacion ASC, co_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cancelacion].[pf_cancelacion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cancelacion]') and name = N'pf_cancelacion_Key')
   drop index [pf_cancelacion_Key] on [pf_cancelacion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_cancelacion_Key] ON [dbo].[pf_cancelacion](ca_operacion ASC, ca_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cancelacion_tmp].[pf_cancelacion_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cancelacion_tmp]') and name = N'pf_cancelacion_tmp_Key')
   drop index [pf_cancelacion_tmp_Key] on [pf_cancelacion_tmp] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_cancelacion_tmp_Key] ON [dbo].[pf_cancelacion_tmp](cn_operacion ASC, cn_tsecuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_compensa_mov].[pf_compensa_mov_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_compensa_mov]') and name = N'pf_compensa_mov_Key')
   drop index [pf_compensa_mov_Key] on [pf_compensa_mov] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_compensa_mov_Key] ON [dbo].[pf_compensa_mov](cm_operacion ASC, cm_tran ASC, cm_secuencia ASC, cm_sub_secuencia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_condicion].[pf_condicion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_condicion]') and name = N'pf_condicion_Key')
   drop index [pf_condicion_Key] on [pf_condicion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_condicion_Key] ON [dbo].[pf_condicion](cd_operacion ASC, cd_condicion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_condicion_tmp].[pf_condicion_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_condicion_tmp]') and name = N'pf_condicion_tmp_Key')
   drop index [pf_condicion_tmp_Key] on [pf_condicion_tmp] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_condicion_tmp_Key] ON [dbo].[pf_condicion_tmp](ct_usuario ASC, ct_sesion ASC, ct_operacion ASC, ct_condicion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_conversion].[pf_conversion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_conversion]') and name = N'pf_conversion_Key')
   drop index [pf_conversion_Key] on [pf_conversion] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_conversion_Key] ON [dbo].[pf_conversion](cv_oficina ASC, cv_toperacion ASC, cv_moneda ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_conversion_ticket].[pf_conversion_ticket_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_conversion_ticket]') and name = N'pf_conversion_ticket_Key')
   drop index [pf_conversion_ticket_Key] on [pf_conversion_ticket] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_conversion_ticket_Key] ON [dbo].[pf_conversion_ticket](ct_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cuadre_auxiliar].[pf_cuadre_auxiliar_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cuadre_auxiliar]') and name = N'pf_cuadre_auxiliar_Key')
   drop index [pf_cuadre_auxiliar_Key] on [pf_cuadre_auxiliar] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_cuadre_auxiliar_Key] ON [dbo].[pf_cuadre_auxiliar](ca_fecha_proceso ASC, ca_tipo_deposito ASC, ca_oficina ASC, ca_moneda ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cuotas].[pf_cuotas_B_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cuotas]') and name = N'pf_cuotas_B_Key')
   drop index [pf_cuotas_B_Key] on [pf_cuotas] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_cuotas_B_Key] ON [dbo].[pf_cuotas](cu_fecha_pago ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cuotas].[pf_cuotas_C_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cuotas]') and name = N'pf_cuotas_C_Key')
   drop index [pf_cuotas_C_Key] on [pf_cuotas] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_cuotas_C_Key] ON [dbo].[pf_cuotas](cu_moneda ASC, cu_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_cuotas].[pf_cuotas_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_cuotas]') and name = N'pf_cuotas_Key')
   drop index [pf_cuotas_Key] on [pf_cuotas] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_cuotas_Key] ON [dbo].[pf_cuotas](cu_operacion ASC, cu_cuota ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_det_condicion].[pf_det_condicion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_det_condicion]') and name = N'pf_det_condicion_Key')
   drop index [pf_det_condicion_Key] on [pf_det_condicion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_det_condicion_Key] ON [dbo].[pf_det_condicion](dc_operacion ASC, dc_condicion ASC, dc_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_det_condicion_tmp].[pf_det_condicion_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_det_condicion_tmp]') and name = N'pf_det_condicion_tmp_Key')
   drop index [pf_det_condicion_tmp_Key] on [pf_det_condicion_tmp] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_det_condicion_tmp_Key] ON [dbo].[pf_det_condicion_tmp](dt_usuario ASC, dt_sesion ASC, dt_condicion ASC, dt_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_det_envios_dcv].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_det_envios_dcv]') and name = N'idx1')
   drop index [idx1] on [pf_det_envios_dcv] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [dbo].[pf_det_envios_dcv](de_fecha ASC, de_archivo ASC, de_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_det_lote].[pf_det_lote_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_det_lote]') and name = N'pf_det_lote_Key')
   drop index [pf_det_lote_Key] on [pf_det_lote] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_det_lote_Key] ON [dbo].[pf_det_lote](dl_lote ASC, dl_num_banco ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_det_pago].[pf_det_pago_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_det_pago]') and name = N'pf_det_pago_Key')
   drop index [pf_det_pago_Key] on [pf_det_pago] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_det_pago_Key] ON [dbo].[pf_det_pago](dp_operacion ASC, dp_secuencia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go
 
print '--> Indice: [pf_emision_cheque].[pf_emision_cheque_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_emision_cheque]') and name = N'pf_emision_cheque_Key')
   drop index [pf_emision_cheque_Key] on [pf_emision_cheque] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_emision_cheque_Key] ON [dbo].[pf_emision_cheque](ec_fecha_mov ASC, ec_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_endoso_cond].[pf_endoso_cond_key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_endoso_cond]') and name = N'pf_endoso_cond_key')
   drop index [pf_endoso_cond_key] on [pf_endoso_cond] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_endoso_cond_key] ON [dbo].[pf_endoso_cond](ec_operacion ASC, ec_ente ASC, ec_fecha_crea ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_endoso_prop].[pf_endoso_prop_key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_endoso_prop]') and name = N'pf_endoso_prop_key')
   drop index [pf_endoso_prop_key] on [pf_endoso_prop] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_endoso_prop_key] ON [dbo].[pf_endoso_prop](en_operacion ASC, en_ente ASC, en_fecha_crea ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_envios_dcv].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_envios_dcv]') and name = N'idx1')
   drop index [idx1] on [pf_envios_dcv] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [dbo].[pf_envios_dcv](ed_fecha ASC, ed_archivo ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_equivalencias].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_equivalencias]') and name = N'idx1')
   drop index [idx1] on [pf_equivalencias] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[pf_equivalencias](eq_modulo ASC, eq_tabla ASC, eq_val_pfijo ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_equivalencias].[idx2]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_equivalencias]') and name = N'idx2')
   drop index [idx2] on [pf_equivalencias] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[pf_equivalencias](eq_modulo ASC, eq_tabla ASC, eq_val_pfi_ini ASC, eq_val_pfi_fin ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_errorlog].[pf_errorlog_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_errorlog]') and name = N'pf_errorlog_Key')
   drop index [pf_errorlog_Key] on [pf_errorlog] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_errorlog_Key] ON [dbo].[pf_errorlog](er_fecha_proc ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_estadistica].[pf_estadistica_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_estadistica]') and name = N'pf_errorlog_Key')
   drop index [pf_estadistica_Key] on [pf_estadistica] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_estadistica_Key] ON [dbo].[pf_estadistica](es_tipo_deposito ASC, es_moneda ASC, es_nivel ASC, es_valor_nivel ASC, es_mes ASC, es_anio ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_firmas_autorizadas].[pf_firmas_autorizadas_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_firmas_autorizadas]') and name = N'pf_firmas_autorizadas_Key')
   drop index [pf_firmas_autorizadas_Key] on [pf_firmas_autorizadas] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_firmas_autorizadas_Key] ON [dbo].[pf_firmas_autorizadas](fi_operacion ASC, fi_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_fpago].[pf_fpago_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_fpago]') and name = N'pf_fpago_Key')
   drop index [pf_fpago_Key] on [pf_fpago] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_fpago_Key] ON [dbo].[pf_fpago](fp_mnemonico ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_funcionario].[pf_funcionario_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_funcionario]') and name = N'pf_funcionario_Key')
   drop index [pf_funcionario_Key] on [pf_funcionario] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_funcionario_Key] ON [dbo].[pf_funcionario](fu_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_fusfra].[pf_fusfra_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_fusfra]') and name = N'pf_fusfra_Key')
   drop index [pf_fusfra_Key] on [pf_fusfra] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_fusfra_Key] ON [dbo].[pf_fusfra](fu_operacion ASC, fu_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_his_mensual].[pf_his_mensual_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_his_mensual]') and name = N'pf_his_mensual_Key')
   drop index [pf_his_mensual_Key] on [pf_his_mensual] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_his_mensual_Key] ON [dbo].[pf_his_mensual](hm_fecha ASC, hm_num_banco ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_hist_secuen_ticket].[pf_hist_secuen_ticket_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_hist_secuen_ticket]') and name = N'pf_hist_secuen_ticket_Key')
   drop index [pf_hist_secuen_ticket_Key] on [pf_hist_secuen_ticket] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_hist_secuen_ticket_Key] ON [dbo].[pf_hist_secuen_ticket](hs_operacion ASC, hs_secuencial ASC, hs_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_hist_tasa].[pf_hist_tasa_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_hist_tasa]') and name = N'pf_hist_tasa_Key')
   drop index [pf_hist_tasa_Key] on [pf_hist_tasa] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_hist_tasa_Key] ON [dbo].[pf_hist_tasa](ht_secuencial ASC, ht_tipo_deposito ASC, ht_moneda ASC, ht_tipo_monto ASC, ht_tipo_plazo ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_hist_tasa_variable].[pf_hist_tasa_variable_key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_hist_tasa_variable]') and name = N'pf_hist_tasa_variable_key')
   drop index [pf_hist_tasa_variable_key] on [pf_hist_tasa_variable] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_hist_tasa_variable_key] ON [dbo].[pf_hist_tasa_variable](hv_secuencial ASC, hv_moneda ASC, hv_tipo_monto ASC, hv_tipo_plazo ASC, hv_mnemonico_prod ASC, hv_mnemonico_tasa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_historia].[pf_historia_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_historia]') and name = N'pf_historia_Key')
   drop index [pf_historia_Key] on [pf_historia] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_historia_Key] ON [dbo].[pf_historia](hi_operacion ASC, hi_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_incre_op].[pf_incre_op_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_incre_op]') and name = N'pf_incre_op_Key')
   drop index [pf_incre_op_Key] on [pf_incre_op] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_incre_op_Key] ON [dbo].[pf_incre_op](io_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_incremento].[pf_incremento_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_incremento]') and name = N'pf_incremento_Key')
   drop index [pf_incremento_Key] on [pf_incremento] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_incremento_Key] ON [dbo].[pf_incremento](in_operacion ASC, in_sec_incremento ASC, in_fecha_incremento ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_limite].[pf_limite_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_limite]') and name = N'pf_limite_Key')
   drop index [pf_limite_Key] on [pf_limite] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_limite_Key] ON [dbo].[pf_limite](li_tipo_deposito ASC, li_moneda ASC, li_tipo_reg ASC, li_valor ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_monto].[pf_monto_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_monto]') and name = N'pf_monto_Key')
   drop index [pf_monto_Key] on [pf_monto] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_monto_Key] ON [dbo].[pf_monto](mo_mnemonico ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_mov_monet].[pf_mov_monet_B_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_mov_monet]') and name = N'pf_mov_monet_B_Key')
   drop index [pf_mov_monet_B_Key] on [pf_mov_monet] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_mov_monet_B_Key] ON [dbo].[pf_mov_monet](mm_operacion ASC, mm_secuencia_emis_che ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_mov_monet].[pf_mov_monet_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_mov_monet]') and name = N'pf_mov_monet_Key')
   drop index [pf_mov_monet_Key] on [pf_mov_monet] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_mov_monet_Key] ON [dbo].[pf_mov_monet](mm_operacion ASC, mm_tran ASC, mm_secuencia ASC, mm_sub_secuencia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_mov_monet_prob].[pf_mov_monet_prob_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_mov_monet_prob]') and name = N'pf_mov_monet_prob_Key')
   drop index [pf_mov_monet_prob_Key] on [pf_mov_monet_prob] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_mov_monet_prob_Key] ON [dbo].[pf_mov_monet_prob](pr_operacion ASC, pr_secuencia ASC, pr_subsecuencia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_mov_monet_tmp].[pf_mov_monet_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_mov_monet_tmp]') and name = N'pf_mov_monet_tmp_Key')
   drop index [pf_mov_monet_tmp_Key] on [pf_mov_monet_tmp] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_mov_monet_tmp_Key] ON [dbo].[pf_mov_monet_tmp](mt_usuario ASC, mt_sesion ASC, mt_operacion ASC, mt_sub_secuencia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_npreimpreso].[pf_npreimpreso_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_npreimpreso]') and name = N'pf_npreimpreso_Key')
   drop index [pf_npreimpreso_Key] on [pf_npreimpreso] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_npreimpreso_Key] ON [dbo].[pf_npreimpreso](np_preimpreso ASC, np_preimpreso_cupon ASC, np_toperacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_nueva_renovacion].[pf_nueva_renovacion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_nueva_renovacion]') and name = N'pf_nueva_renovacion_Key')
   drop index [pf_nueva_renovacion_Key] on [pf_nueva_renovacion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_nueva_renovacion_Key] ON [dbo].[pf_nueva_renovacion](re_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_operacion].[pf_operacion_B_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_B_Key')
   drop index [pf_operacion_B_Key] on [pf_operacion] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [pf_operacion_B_Key] ON [dbo].[pf_operacion](op_oficina ASC, op_moneda ASC, op_toperacion ASC, op_num_banco ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_operacion].[pf_operacion_C_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_C_Key')
   drop index [pf_operacion_C_Key] on [pf_operacion] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_operacion_C_Key] ON [dbo].[pf_operacion](op_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_operacion].[pf_operacion_D_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_D_Key')
   drop index [pf_operacion_D_Key] on [pf_operacion] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [pf_operacion_D_Key] ON [dbo].[pf_operacion](op_num_banco ASC, op_oficina ASC, op_estado ASC, op_toperacion ASC, op_accion_sgte ASC, op_moneda ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_operacion].[pf_operacion_E_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_E_Key')
   drop index [pf_operacion_E_Key] on [pf_operacion] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [pf_operacion_E_Key] ON [dbo].[pf_operacion](op_oficina ASC, op_toperacion ASC, op_scontable ASC, op_moneda ASC, op_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_operacion].[pf_operacion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_Key')
   drop index [pf_operacion_Key] on [pf_operacion] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [pf_operacion_Key] ON [dbo].[pf_operacion](op_num_banco ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go
 
print '--> Indice: [pf_operacion].[pf_operacion_idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion]') and name = N'pf_operacion_idx1')
   drop index [pf_operacion_idx1] on [pf_operacion] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_operacion_idx1] ON [dbo].[pf_operacion](op_ente ASC, op_estado ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [PRIMARY];
go
 
print '--> Indice: [pf_operacion_his].[pf_operacion_his_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion_his]') and name = N'pf_operacion_his_Key')
   drop index [pf_operacion_his_Key] on [pf_operacion_his] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_operacion_his_Key] ON [dbo].[pf_operacion_his](oh_num_banco ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go
 
print '--> Indice: [pf_operacion_renov].[pf_operacion_renov_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion_renov]') and name = N'pf_operacion_renov_Key')
   drop index [pf_operacion_renov_Key] on [pf_operacion_renov] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_operacion_renov_Key] ON [dbo].[pf_operacion_renov](or_operacion ASC, or_historia ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_operacion_tmp].[pf_operacion_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_operacion_tmp]') and name = N'pf_operacion_tmp_Key')
   drop index [pf_operacion_tmp_Key] on [pf_operacion_tmp] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_operacion_tmp_Key] ON [dbo].[pf_operacion_tmp](ot_usuario ASC, ot_sesion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_pignoracion].[pf_pignoracion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_pignoracion]') and name = N'pf_pignoracion_Key')
   drop index [pf_pignoracion_Key] on [pf_pignoracion] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_pignoracion_Key] ON [dbo].[pf_pignoracion](pi_operacion ASC, pi_producto ASC, pi_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_plazo].[pf_plazo_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_plazo]') and name = N'pf_plazo_Key')
   drop index [pf_plazo_Key] on [pf_plazo] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_plazo_Key] ON [dbo].[pf_plazo](pl_mnemonico ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_plazo_contable].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_plazo_contable]') and name = N'idx1')
   drop index [idx1] on [pf_plazo_contable] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [dbo].[pf_plazo_contable](pc_plazo_cont ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_plazo_contable].[idx2]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_plazo_contable]') and name = N'idx2')
   drop index [idx2] on [pf_plazo_contable] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [idx2] ON [dbo].[pf_plazo_contable](pc_plazo_min ASC, pc_plazo_max ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_ppago].[pf_ppago_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_ppago]') and name = N'pf_ppago_Key')
   drop index [pf_ppago_Key] on [pf_ppago] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_ppago_Key] ON [dbo].[pf_ppago](pp_codigo ASC, pp_factor_en_meses ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_prorroga_aut].[pf_prorroga_aut_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_prorroga_aut]') and name = N'pf_prorroga_aut_Key')
   drop index [pf_prorroga_aut_Key] on [pf_prorroga_aut] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_prorroga_aut_Key] ON [dbo].[pf_prorroga_aut](pa_operacion ASC, pa_renovacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_prov_dia].[pf_prov_dia_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_prov_dia]') and name = N'pf_prov_dia_Key')
   drop index [pf_prov_dia_Key] on [pf_prov_dia] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_prov_dia_Key] ON [dbo].[pf_prov_dia](pd_operacion ASC, pd_fecha_proceso ASC) 
INCLUDE (pd_valor_calc)
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [PRIMARY];
go

print '-->Indice: pf_rango_prorroga_Key'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_rango_prorroga]') and name = N'pf_rango_prorroga_Key')
   drop index [pf_rango_prorroga_Key] on [pf_rango_prorroga] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_rango_prorroga_Key] ON [dbo].[pf_rango_prorroga](rp_tipo_rango ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_renovacion].[pf_renovacion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_renovacion]') and name = N'pf_renovacion_Key')
   drop index [pf_renovacion_Key] on [pf_renovacion] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_renovacion_Key] ON [dbo].[pf_renovacion](re_operacion ASC, re_renovacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_retencion].[pf_retencion_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_retencion]') and name = N'pf_retencion_Key')
   drop index [pf_retencion_Key] on [pf_retencion] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_retencion_Key] ON [dbo].[pf_retencion](rt_operacion ASC, rt_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_sasiento].[pf_sasiento_A_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_sasiento]') and name = N'pf_sasiento_A_Key')
   drop index [pf_sasiento_A_Key] on [pf_sasiento] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_sasiento_A_Key] ON [dbo].[pf_sasiento](sa_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_sasiento].[pf_sasiento_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_sasiento]') and name = N'pf_sasiento_Key')
   drop index [pf_sasiento_Key] on [pf_sasiento] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_sasiento_Key] ON [dbo].[pf_sasiento](sa_comprobante ASC, sa_asiento ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_sasiento_his].[pf_sasiento_his_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_sasiento_his]') and name = N'pf_sasiento_his_Key')
   drop index [pf_sasiento_his_Key] on [pf_sasiento_his] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_sasiento_his_Key] ON [dbo].[pf_sasiento_his](sa_comprobante ASC, sa_asiento ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_scomprobante].[pf_scomprobante_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_scomprobante]') and name = N'pf_scomprobante_Key')
   drop index [pf_scomprobante_Key] on [pf_scomprobante] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_scomprobante_Key] ON [dbo].[pf_scomprobante](sc_comprobante ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_scomprobante_his].[pf_scomprobante_his_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_scomprobante_his]') and name = N'pf_scomprobante_his_Key')
   drop index [pf_scomprobante_his_Key] on [pf_scomprobante_his] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_scomprobante_his_Key] ON [dbo].[pf_scomprobante_his](sc_comprobante ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_secuen_ticket].[pf_secuen_ticket_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_secuen_ticket]') and name = N'pf_secuen_ticket_Key')
   drop index [pf_secuen_ticket_Key] on [pf_secuen_ticket] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_secuen_ticket_Key] ON [dbo].[pf_secuen_ticket](st_operacion ASC, st_secuencial ASC, st_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_secuenciales].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_secuenciales]') and name = N'idx1')
   drop index [idx1] on [pf_secuenciales] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[pf_secuenciales](se_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tasa].[pf_tasa_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tasa]') and name = N'pf_tasa_Key')
   drop index [pf_tasa_Key] on [pf_tasa] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_tasa_Key] ON [dbo].[pf_tasa](ta_tipo_deposito ASC, ta_moneda ASC, ta_tipo_monto ASC, ta_tipo_plazo ASC, ta_tipo ASC, ta_momento ASC, ta_prorroga ASC, ta_ivc ASC, ta_segmento ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tasa_variable].[pf_tasa_variable_key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tasa_variable]') and name = N'pf_tasa_variable_key')
   drop index [pf_tasa_variable_key] on [pf_tasa_variable] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_tasa_variable_key] ON [dbo].[pf_tasa_variable](tv_mnemonico_prod ASC, tv_mnemonico_tasa ASC, tv_tipo_monto ASC, tv_tipo_plazo ASC, tv_moneda ASC, tv_tipo_pago ASC, tv_momento ASC, tv_prorroga ASC, tv_ivc ASC, tv_segmento ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tipo_deposito].[pf_tipo_deposito_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tipo_deposito]') and name = N'pf_tipo_deposito_Key')
   drop index [pf_tipo_deposito_Key] on [pf_tipo_deposito] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [pf_tipo_deposito_Key] ON [dbo].[pf_tipo_deposito](td_mnemonico ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tranperfil].[pf_tranperfil_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tranperfil]') and name = N'pf_tranperfil_Key')
   drop index [pf_tranperfil_Key] on [pf_tranperfil] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [pf_tranperfil_Key] ON [dbo].[pf_tranperfil](tp_tran ASC, tp_estado ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_transaccion].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_transaccion]') and name = N'idx1')
   drop index [idx1] on [pf_transaccion] with (ONLINE = OFF)

CREATE UNIQUE CLUSTERED INDEX [idx1] ON [dbo].[pf_transaccion](tr_operacion ASC, tr_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_transaccion].[idx3]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_transaccion]') and name = N'idx3')
   drop index [idx3] on [pf_transaccion] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [idx3] ON [dbo].[pf_transaccion](tr_fecha_mov ASC, tr_estado ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_transaccion].[pf_transaccion_idx4]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_transaccion]') and name = N'pf_transaccion_idx4')
   drop index [pf_transaccion_idx4] on [pf_transaccion] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_transaccion_idx4] ON [dbo].[pf_transaccion](tr_fecha_mov ASC, tr_tran ASC) 
INCLUDE (tr_operacion, tr_banco)
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =85) ON [PRIMARY];
go

print '--> Indice: [pf_transaccion_det].[idx1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_transaccion_det]') and name = N'idx1')
   drop index [idx1] on [pf_transaccion_det] with (ONLINE = OFF)

CREATE CLUSTERED INDEX [idx1] ON [dbo].[pf_transaccion_det](td_operacion ASC, td_secuencial ASC, td_concepto ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
go

print '--> Indice: [pf_transferencias_tmp].[pf_transferencias_tmp_Key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_transferencias_tmp]') and name = N'pf_transferencias_tmp_Key')
   drop index [pf_transferencias_tmp_Key] on [pf_transferencias_tmp] with (ONLINE = OFF)

CREATE UNIQUE NONCLUSTERED INDEX [pf_transferencias_tmp_Key] ON [dbo].[pf_transferencias_tmp](tr_cod_operacion ASC, tr_cod_transf ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tasas_masivas].[pf_tasas_masivas_key]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tasas_masivas]') and name = N'pf_tasas_masivas_key')
   drop index [pf_tasas_masivas_key] on [pf_tasas_masivas] with (ONLINE = OFF)

CREATE NONCLUSTERED INDEX [pf_tasas_masivas_key] ON [dbo].[pf_tasas_masivas](tm_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
go

print '--> Indice: [pf_tasas_error].[pf_tasas_error_key1]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tasas_error]') and name = N'pf_tasas_error_key1')
   drop index [pf_tasas_error_key1] on [pf_tasas_error] with (ONLINE = OFF)
   
CREATE NONCLUSTERED INDEX [pf_tasas_error_key1] ON [dbo].[pf_tasas_error]([te_secuencial] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
go

print '--> Indice: [pf_tasas_error].[pf_tasas_error_key2]'
if exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[pf_tasas_error]') and name = N'pf_tasas_error_key2')
   drop index [pf_tasas_error_key2] on [pf_tasas_error] with (ONLINE = OFF)
   
CREATE NONCLUSTERED INDEX [pf_tasas_error_key2] ON [dbo].[pf_tasas_error]([te_hora] ASC)
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
go

print ''
print 'Fin Ejecucion Creacion de Indices Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''