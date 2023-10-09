-----------<CREACION INDICES>---------------------
use cob_conta
go
 
set nocount on
go
 
print '--> Indice: [cb_area].[cb_area_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_area_Key] ON [dbo].[cb_area](ar_empresa ASC, ar_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_area].[i_ar_area_padre]'
CREATE NONCLUSTERED INDEX [i_ar_area_padre] ON [dbo].[cb_area](ar_area_padre ASC, ar_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_area].[i_ar_nivel]'
CREATE NONCLUSTERED INDEX [i_ar_nivel] ON [dbo].[cb_area](ar_empresa ASC, ar_nivel_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_asiento].[cb_asiento_key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_asiento_key] ON [dbo].[cb_asiento](as_comprobante ASC, as_fecha_tran ASC, as_asiento ASC, as_oficina_orig ASC, as_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [indexgroup];
 
print '--> Indice: [cb_asiento].[cb_asiento_key2]'
CREATE NONCLUSTERED INDEX [cb_asiento_key2] ON [dbo].[cb_asiento](as_cuenta ASC, as_fecha_tran ASC, as_oficina_dest ASC, as_area_dest ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [indexgroup];
 
print '--> Indice: [cb_banco].[cb_banco_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_banco_Key] ON [dbo].[cb_banco](ba_empresa ASC, ba_banco ASC, ba_ctacte ASC, ba_operacion ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_categoria].[cb_categoria_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_categoria_Key] ON [dbo].[cb_categoria](ca_categoria ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_comp_tipo].[cb_comp_tipo_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_comp_tipo_Key] ON [dbo].[cb_comp_tipo](ct_comp_tipo ASC, ct_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_comprobante].[cb_comprobante_key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_comprobante_key] ON [dbo].[cb_comprobante](co_comprobante ASC, co_fecha_tran ASC, co_oficina_orig ASC, co_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [PRIMARY];
 
print '--> Indice: [cb_control].[cb_control_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_control_Key] ON [dbo].[cb_control](cn_empresa ASC, cn_login ASC, cn_oficina ASC, cn_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_corte].[cb_corte_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_corte_Key] ON [dbo].[cb_corte](co_corte ASC, co_periodo ASC, co_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_corte].[cb_corte_Key_fecha]'
CREATE NONCLUSTERED INDEX [cb_corte_Key_fecha] ON [dbo].[cb_corte](co_fecha_ini ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cotizacion].[cb_cotizacion_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_cotizacion_Key] ON [dbo].[cb_cotizacion](ct_moneda ASC, ct_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_cotizacion].[i_cotizacion]'
CREATE NONCLUSTERED INDEX [i_cotizacion] ON [dbo].[cb_cotizacion](ct_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta].[cb_cuenta_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_cuenta_Key] ON [dbo].[cb_cuenta](cu_empresa ASC, cu_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_cuenta].[i_cu_categoria]'
CREATE NONCLUSTERED INDEX [i_cu_categoria] ON [dbo].[cb_cuenta](cu_categoria ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta].[i_cu_cuenta_padre]'
CREATE NONCLUSTERED INDEX [i_cu_cuenta_padre] ON [dbo].[cb_cuenta](cu_cuenta_padre ASC, cu_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta].[i_cu_moneda]'
CREATE NONCLUSTERED INDEX [i_cu_moneda] ON [dbo].[cb_cuenta](cu_moneda ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta].[i_cu_nivel_cuenta]'
CREATE NONCLUSTERED INDEX [i_cu_nivel_cuenta] ON [dbo].[cb_cuenta](cu_empresa ASC, cu_nivel_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta_asociada].[cb_cuenta_asociada_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_cuenta_asociada_Key] ON [dbo].[cb_cuenta_asociada](ca_empresa ASC, ca_cuenta ASC, ca_oficina ASC, ca_area ASC, ca_proceso ASC, ca_secuencial ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =80) ON [PRIMARY];
 
print '--> Indice: [cb_cuenta_niif].[idx1]'
CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[cb_cuenta_niif](cu_cuenta ASC, cu_fecha_ing ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =85) ON [PRIMARY];
 
print '--> Indice: [cb_cuenta_presupuesto].[cb_cuenta_presup_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_cuenta_presup_Key] ON [dbo].[cb_cuenta_presupuesto](cup_empresa ASC, cup_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_cuenta_presupuesto].[i_cup_categoria]'
CREATE NONCLUSTERED INDEX [i_cup_categoria] ON [dbo].[cb_cuenta_presupuesto](cup_categoria ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta_presupuesto].[i_cup_cuenta_padre]'
CREATE NONCLUSTERED INDEX [i_cup_cuenta_padre] ON [dbo].[cb_cuenta_presupuesto](cup_cuenta_padre ASC, cup_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta_presupuesto].[i_cup_nivel_cuenta]'
CREATE NONCLUSTERED INDEX [i_cup_nivel_cuenta] ON [dbo].[cb_cuenta_presupuesto](cup_empresa ASC, cup_nivel_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuenta_proceso].[cb_cuenta_proceso_Key]'
CREATE NONCLUSTERED INDEX [cb_cuenta_proceso_Key] ON [dbo].[cb_cuenta_proceso](cp_proceso ASC, cp_oficina ASC, cp_area ASC, cp_cuenta ASC, cp_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_cuentas_ord_tmp].[cb_cuentas_ord_tmp_idx1]'
CREATE NONCLUSTERED INDEX [cb_cuentas_ord_tmp_idx1] ON [dbo].[cb_cuentas_ord_tmp](sec ASC) 
INCLUDE (cuenta, monto)
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =85) ON [indexgroup];
 
print '--> Indice: [cb_det_comptipo].[i_dct_cuenta]'
CREATE NONCLUSTERED INDEX [i_dct_cuenta] ON [dbo].[cb_det_comptipo](dct_empresa ASC, dct_cuenta ASC, dct_oficina_dest ASC, dct_area_dest ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_dinamica].[cb_dinamica_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_dinamica_Key] ON [dbo].[cb_dinamica](di_empresa ASC, di_cuenta ASC, di_secuencial ASC, di_tipo_dinamica ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_general_presupuesto].[cb_general_pr_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_general_pr_Key] ON [dbo].[cb_general_presupuesto](gp_empresa ASC, gp_oficina_presupuesto ASC, gp_area_presupuesto ASC, gp_cuenta_presupuesto ASC, gp_oficina ASC, gp_area ASC, gp_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_ica].[cb_ica_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_ica_Key] ON [dbo].[cb_ica](ic_empresa ASC, ic_codigo ASC, ic_ciudad ASC, ic_debcred ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_iva].[cb_iva_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_iva_Key] ON [dbo].[cb_iva](iva_empresa ASC, iva_codigo ASC, iva_debcred ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_iva_pagado].[cb_iva_pagado_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_iva_pagado_Key] ON [dbo].[cb_iva_pagado](ip_empresa ASC, ip_codigo ASC, ip_debcred ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_jerararea].[cb_jerararea_2]'
CREATE NONCLUSTERED INDEX [cb_jerararea_2] ON [dbo].[cb_jerararea](ja_area_padre ASC, ja_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_jerararea].[cb_jerararea_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_jerararea_Key] ON [dbo].[cb_jerararea](ja_empresa ASC, ja_area ASC, ja_area_padre ASC, ja_nivel ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_jerarquia].[cb_jerarquia_2]'
CREATE NONCLUSTERED INDEX [cb_jerarquia_2] ON [dbo].[cb_jerarquia](je_oficina_padre ASC, je_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_jerarquia].[cb_jerarquia_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_jerarquia_Key] ON [dbo].[cb_jerarquia](je_empresa ASC, je_oficina ASC, je_oficina_padre ASC, je_nivel ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_nivel_cuenta].[cb_nivel_cuenta_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_nivel_cuenta_Key] ON [dbo].[cb_nivel_cuenta](nc_empresa ASC, nc_nivel_cuenta ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_oficina].[cb_oficina_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_oficina_Key] ON [dbo].[cb_oficina](of_empresa ASC, of_oficina ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_oficina].[i_of_oficina_padre]'
CREATE NONCLUSTERED INDEX [i_of_oficina_padre] ON [dbo].[cb_oficina](of_oficina_padre ASC, of_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_oficina].[i_of_organizacion]'
CREATE NONCLUSTERED INDEX [i_of_organizacion] ON [dbo].[cb_oficina](of_organizacion ASC, of_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_paramterceros].[cb_paramterceros_key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_paramterceros_key] ON [dbo].[cb_paramterceros](pt_oficina ASC, pt_cuenta ASC, pt_ente ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_periodo].[cb_periodo_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_periodo_Key] ON [dbo].[cb_periodo](pe_periodo ASC, pe_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_plan_general].[cb_plan_general_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_plan_general_Key] ON [dbo].[cb_plan_general](pg_cuenta ASC, pg_oficina ASC, pg_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [PRIMARY];
 
print '--> Indice: [cb_plan_general].[i_clave]'
CREATE NONCLUSTERED INDEX [i_clave] ON [dbo].[cb_plan_general](pg_clave ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [indexgroup];
 
print '--> Indice: [cb_plan_general].[i_pg_cuenta]'
CREATE NONCLUSTERED INDEX [i_pg_cuenta] ON [dbo].[cb_plan_general](pg_oficina ASC, pg_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [PRIMARY];
 
print '--> Indice: [cb_plan_general].[i_pg_cuenta2]'
CREATE NONCLUSTERED INDEX [i_pg_cuenta2] ON [dbo].[cb_plan_general](pg_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [PRIMARY];
 
print '--> Indice: [cb_plan_general_presupuesto].[cb_plan_general_pr_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_plan_general_pr_Key] ON [dbo].[cb_plan_general_presupuesto](pgp_empresa ASC, pgp_cuenta ASC, pgp_oficina ASC, pgp_area ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_regimen_fiscal].[cb_regimen_fiscal_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_regimen_fiscal_Key] ON [dbo].[cb_regimen_fiscal](rf_codigo ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_relofi].[cb_relofi_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_relofi_Key] ON [dbo].[cb_relofi](re_filial ASC, re_empresa ASC, re_ofadmin ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_retencion].[cb_retencion_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_retencion_Key] ON [dbo].[cb_retencion](re_comprobante ASC, re_asiento ASC, re_fecha ASC, re_oficina_orig ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [indexgroup];
 
print '--> Indice: [cb_retencion].[idx1]'
CREATE NONCLUSTERED INDEX [idx1] ON [dbo].[cb_retencion](re_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =90) ON [indexgroup];
 
print '--> Indice: [cb_saldo].[cb_saldo_Key]'
CREATE UNIQUE NONCLUSTERED INDEX [cb_saldo_Key] ON [dbo].[cb_saldo](sa_cuenta ASC, sa_oficina ASC, sa_area ASC, sa_corte ASC, sa_periodo ASC, sa_empresa ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =75) ON [indexgroup];
 
print '--> Indice: [cb_saldo_presupuesto].[cb_saldo_presupuesto_Key]'
CREATE UNIQUE CLUSTERED INDEX [cb_saldo_presupuesto_Key] ON [dbo].[cb_saldo_presupuesto](sap_empresa ASC, sap_cuenta ASC, sap_oficina ASC, sap_area ASC, sap_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [PRIMARY];
 
print '--> Indice: [cb_tran_servicio].[cb_trser_Key]'
CREATE NONCLUSTERED INDEX [cb_trser_Key] ON [dbo].[cb_tran_servicio](ts_secuencial ASC, ts_tipo_transaccion ASC, ts_clase ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_tran_servicio].[cb_trser_Key_2]'
CREATE NONCLUSTERED INDEX [cb_trser_Key_2] ON [dbo].[cb_tran_servicio](ts_fecha ASC) 
WITH (PAD_INDEX = OFF, ALLOW_PAGE_LOCKS = ON, ALLOW_ROW_LOCKS = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, SORT_IN_TEMPDB = OFF, FILLFACTOR =100) ON [indexgroup];
 
print '--> Indice: [cb_libromov_dia].[idx1]'
create index idx1 on cb_libromov_dia(ld_secuencia, ld_cuenta)

go
