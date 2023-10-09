/************************************************************************/
/*                 Descripcion                                          */
/*  Script para creacion de Indices Dependencientes de Plazo Fijo       */
/************************************************************************/
/*                                                                      */
/*  Fecha         Autor               Comentario                        */
/*  15/07/2016    Oscar Saavedra      Instalador Version Davivienda     */
/************************************************************************/
use cob_ahorros
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

print '--> Indice: [ah_cuenta].[ah_cuenta_Key]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'ah_cuenta_Key')
begin
   CREATE UNIQUE CLUSTERED INDEX [ah_cuenta_Key] ON [dbo].[ah_cuenta]([ah_cta_banco] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [PRIMARY]
end
go

print '--> Indice: [ah_cuenta].[ah_cuenta_idx1]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'ah_cuenta_idx1')
begin
   CREATE NONCLUSTERED INDEX [ah_cuenta_idx1] ON [dbo].[ah_cuenta]([ah_filial] ASC, [ah_cuenta] ASC)
   INCLUDE (
   [ah_cta_banco],
   [ah_estado],
   [ah_oficina],
   [ah_tipo_promedio],
   [ah_disponible],
   [ah_12h],
   [ah_12h_dif],
   [ah_24h],
   [ah_48h],
   [ah_remesas],
   [ah_saldo_interes],
   [ah_saldo_ult_corte],
   [ah_creditos],
   [ah_debitos],
   [ah_creditos_hoy],
   [ah_debitos_hoy],
   [ah_fecha_ult_upd],
   [ah_prom_disponible],
   [ah_promedio1],
   [ah_promedio2],
   [ah_promedio3],
   [ah_promedio4],
   [ah_promedio5],
   [ah_promedio6],
   [ah_contador_trx],
   [ah_tipocta],
   [ah_prod_banc],
   [ah_min_dispmes],
   [ah_monto_imp],
   [ah_creditos2],
   [ah_creditos3],
   [ah_creditos4],
   [ah_creditos5],
   [ah_creditos6],
   [ah_debitos2],
   [ah_debitos3],
   [ah_debitos4],
   [ah_debitos5],
   [ah_debitos6],
   [ah_num_deb_mes],
   [ah_num_cred_mes],
   [ah_num_con_mes])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
end    
go

print '--> Indice: [ah_cuenta].[ah_cuenta_idx2]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'ah_cuenta_idx2')
Begin
   CREATE NONCLUSTERED INDEX [ah_cuenta_idx2] ON [dbo].[ah_cuenta]([ah_filial] ASC,[ah_oficina] ASC)
   INCLUDE (
   [ah_cuenta],
   [ah_cta_banco],
   [ah_estado],
   [ah_moneda],
   [ah_categoria],
   [ah_tipo_promedio],
   [ah_disponible],
   [ah_12h],
   [ah_12h_dif],
   [ah_24h],
   [ah_48h],
   [ah_remesas],
   [ah_rem_hoy],
   [ah_saldo_ult_corte],
   [ah_creditos],
   [ah_debitos],
   [ah_creditos_hoy],
   [ah_debitos_hoy],
   [ah_fecha_ult_upd],
   [ah_prom_disponible],
   [ah_promedio1],
   [ah_promedio2],
   [ah_promedio3],
   [ah_promedio4],
   [ah_promedio5],
   [ah_promedio6],
   [ah_contador_trx],
   [ah_prod_banc],
   [ah_tasa_hoy],
   [ah_min_dispmes],
   [ah_monto_imp],
   [ah_tipocta_super],
   [ah_creditos2],
   [ah_creditos3],
   [ah_creditos4],
   [ah_creditos5],
   [ah_creditos6],
   [ah_debitos2],
   [ah_debitos3],
   [ah_debitos4],
   [ah_debitos5],
   [ah_debitos6],
   [ah_rem_ayer],
   [ah_num_deb_mes],
   [ah_num_cred_mes],
   [ah_num_con_mes])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
End
go

print '--> Indice: [ah_cuenta].[ah_cuenta_idx3]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'ah_cuenta_idx3')
Begin
   CREATE NONCLUSTERED INDEX [ah_cuenta_idx3] ON [dbo].[ah_cuenta]([ah_filial] ASC,[ah_fecha_prx_corte] ASC)
   INCLUDE (
   [ah_cuenta],
   [ah_cta_banco],
   [ah_estado],
   [ah_oficina],
   [ah_producto],
   [ah_moneda],
   [ah_oficial],
   [ah_cliente],
   [ah_ced_ruc],
   [ah_nombre],
   [ah_ciclo],
   [ah_disponible],
   [ah_12h],
   [ah_24h],
   [ah_48h],
   [ah_remesas],
   [ah_saldo_ult_corte],
   [ah_fecha_ult_mov],
   [ah_fecha_ult_mov_int],
   [ah_fecha_ult_corte],
   [ah_cliente_ec],
   [ah_direccion_ec],
   [ah_descripcion_ec],
   [ah_tipo_dir],
   [ah_parroquia],
   [ah_zona],
   [ah_prom_disponible],
   [ah_promedio1],
   [ah_promedio2],
   [ah_promedio3],
   [ah_promedio4],
   [ah_promedio5],
   [ah_promedio6],
   [ah_contador_trx],
   [ah_tipocta],
   [ah_prod_banc],
   [ah_telefono],
   [ah_tasa_hoy],
   [ah_nombre1],
   [ah_sector],
   [ah_monto_imp])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
end  
go

print '--> Indice: [ah_cuenta].[ah_cuenta_idx4]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'ah_cuenta_idx4')
Begin
   CREATE NONCLUSTERED INDEX [ah_cuenta_idx4] ON [dbo].[ah_cuenta]([ah_estado] ASC,[ah_filial] ASC,[ah_fecha_ult_mov] ASC)
   INCLUDE (
   [ah_cuenta],
   [ah_cta_banco],
   [ah_oficina],
   [ah_moneda],
   [ah_cliente],
   [ah_categoria],
   [ah_disponible],
   [ah_12h],
   [ah_24h],
   [ah_saldo_interes],
   [ah_saldo_ayer],
   [ah_prod_banc],
   [ah_tipocta_super],
   [ah_clase_clte])
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
end
go

print '--> Indice: [ah_cuenta].[i_ah_cliente]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'i_ah_cliente')
Begin
   CREATE NONCLUSTERED INDEX [i_ah_cliente] ON [dbo].[ah_cuenta]([ah_cliente] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
end
go

print '--> Indice: [ah_cuenta].[i_ah_cuenta]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'i_ah_cuenta')
Begin
   CREATE UNIQUE NONCLUSTERED INDEX [i_ah_cuenta] ON [dbo].[ah_cuenta]([ah_cuenta] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
end
go

print '--> Indice: [ah_cuenta].[i_ah_nombre]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'i_ah_nombre')
Begin
   CREATE NONCLUSTERED INDEX [i_ah_nombre] ON [dbo].[ah_cuenta]([ah_nombre] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
End
go

print '--> Indice: [ah_cuenta].[i_ah_oficina]'
if not exists (select 1 from sys.indexes where object_id = OBJECT_ID(N'[dbo].[ah_cuenta]') and name = N'i_ah_oficina')
Begin
   CREATE NONCLUSTERED INDEX [i_ah_oficina] ON [dbo].[ah_cuenta]([ah_oficina] ASC,	[ah_estado] ASC)
   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 75) ON [PRIMARY]
end 
go

print ''
print 'Fin Ejecucion Creacion de Indices de Dependencias de Plazo Fijo : ' + convert(varchar(60),getdate(),109)
print ''