IF OBJECT_ID ('cargue_niif_errores_tmp') IS NOT NULL
	DROP TABLE cargue_niif_errores_tmp
GO

IF OBJECT_ID ('cb_area') IS NOT NULL
	DROP TABLE cb_area
GO

IF OBJECT_ID ('cb_asiento') IS NOT NULL
	DROP TABLE cb_asiento
GO

IF OBJECT_ID ('cb_banco') IS NOT NULL
	DROP TABLE cb_banco
GO

IF OBJECT_ID ('cb_blcom') IS NOT NULL
	DROP TABLE cb_blcom
GO

IF OBJECT_ID ('cb_campos_banco') IS NOT NULL
	DROP TABLE cb_campos_banco
GO

IF OBJECT_ID ('cb_categoria') IS NOT NULL
	DROP TABLE cb_categoria
GO

IF OBJECT_ID ('cb_comp_tipo') IS NOT NULL
	DROP TABLE cb_comp_tipo
GO

IF OBJECT_ID ('cb_comprobante') IS NOT NULL
	DROP TABLE cb_comprobante
GO

IF OBJECT_ID ('cb_conc_retencion') IS NOT NULL
	DROP TABLE cb_conc_retencion
GO

IF OBJECT_ID ('cb_control') IS NOT NULL
	DROP TABLE cb_control
GO

IF OBJECT_ID ('cb_corte') IS NOT NULL
	DROP TABLE cb_corte
GO

IF OBJECT_ID ('cb_cotizacion') IS NOT NULL
	DROP TABLE cb_cotizacion
GO

IF OBJECT_ID ('cb_cuenta') IS NOT NULL
	DROP TABLE cb_cuenta
GO

IF OBJECT_ID ('cb_cuenta_asociada') IS NOT NULL
	DROP TABLE cb_cuenta_asociada
GO

IF OBJECT_ID ('cb_cuenta_niif') IS NOT NULL
	DROP TABLE cb_cuenta_niif
GO

IF OBJECT_ID ('cb_cuenta_presupuesto') IS NOT NULL
	DROP TABLE cb_cuenta_presupuesto
GO

IF OBJECT_ID ('cb_cuenta_proceso') IS NOT NULL
	DROP TABLE cb_cuenta_proceso
GO

IF OBJECT_ID ('cb_cuenta_proceso_CCA550') IS NOT NULL
	DROP TABLE cb_cuenta_proceso_CCA550
GO

IF OBJECT_ID ('cb_cuenta6004') IS NOT NULL
	DROP TABLE cb_cuenta6004
GO

IF OBJECT_ID ('cb_cuentas_ord_tmp') IS NOT NULL
	DROP TABLE cb_cuentas_ord_tmp
GO

IF OBJECT_ID ('cb_cuentas_ord_tmp_mv') IS NOT NULL
	DROP TABLE cb_cuentas_ord_tmp_mv
GO

IF OBJECT_ID ('cb_cuentas_tmp') IS NOT NULL
	DROP TABLE cb_cuentas_tmp
GO

IF OBJECT_ID ('cb_det_comptipo') IS NOT NULL
	DROP TABLE cb_det_comptipo
GO

IF OBJECT_ID ('cb_det_perfil') IS NOT NULL
	DROP TABLE cb_det_perfil
GO

IF OBJECT_ID ('cb_dinamica') IS NOT NULL
	DROP TABLE cb_dinamica
GO

IF OBJECT_ID ('cb_empresa') IS NOT NULL
	DROP TABLE cb_empresa
GO

IF OBJECT_ID ('cb_exencion_ciudad') IS NOT NULL
	DROP TABLE cb_exencion_ciudad
GO

IF OBJECT_ID ('cb_exencion_producto') IS NOT NULL
	DROP TABLE cb_exencion_producto
GO

IF OBJECT_ID ('cb_general_presupuesto') IS NOT NULL
	DROP TABLE cb_general_presupuesto
GO

IF OBJECT_ID ('cb_ica') IS NOT NULL
	DROP TABLE cb_ica
GO

IF OBJECT_ID ('cb_imptos_deptales') IS NOT NULL
	DROP TABLE cb_imptos_deptales
GO

IF OBJECT_ID ('cb_iva') IS NOT NULL
	DROP TABLE cb_iva
GO

IF OBJECT_ID ('cb_iva_pagado') IS NOT NULL
	DROP TABLE cb_iva_pagado
GO

IF OBJECT_ID ('cb_jerararea') IS NOT NULL
	DROP TABLE cb_jerararea
GO

IF OBJECT_ID ('cb_jerarquia') IS NOT NULL
	DROP TABLE cb_jerarquia
GO

IF OBJECT_ID ('cb_nivel_area') IS NOT NULL
	DROP TABLE cb_nivel_area
GO

IF OBJECT_ID ('cb_nivel_cuenta') IS NOT NULL
	DROP TABLE cb_nivel_cuenta
GO

IF OBJECT_ID ('cb_ofi_org') IS NOT NULL
	DROP TABLE cb_ofi_org
GO

IF OBJECT_ID ('cb_ofic_cont') IS NOT NULL
	DROP TABLE cb_ofic_cont
GO

IF OBJECT_ID ('cb_oficina') IS NOT NULL
	DROP TABLE cb_oficina
GO

IF OBJECT_ID ('cb_oficina_tmp') IS NOT NULL
	DROP TABLE cb_oficina_tmp
GO

IF OBJECT_ID ('cb_ofpagadora') IS NOT NULL
	DROP TABLE cb_ofpagadora
GO

IF OBJECT_ID ('cb_organizacion') IS NOT NULL
	DROP TABLE cb_organizacion
GO

IF OBJECT_ID ('cb_paramdep') IS NOT NULL
	DROP TABLE cb_paramdep
GO

IF OBJECT_ID ('cb_paramdep_cca_479') IS NOT NULL
	DROP TABLE cb_paramdep_cca_479
GO

IF OBJECT_ID ('cb_parametro') IS NOT NULL
	DROP TABLE cb_parametro
GO

IF OBJECT_ID ('cb_paramterceros') IS NOT NULL
	DROP TABLE cb_paramterceros
GO

IF OBJECT_ID ('cb_perfil') IS NOT NULL
	DROP TABLE cb_perfil
GO

IF OBJECT_ID ('cb_periodo') IS NOT NULL
	DROP TABLE cb_periodo
GO

IF OBJECT_ID ('cb_pgcom') IS NOT NULL
	DROP TABLE cb_pgcom
GO

IF OBJECT_ID ('cb_plan_general') IS NOT NULL
	DROP TABLE cb_plan_general
GO

IF OBJECT_ID ('cb_plan_general_presupuesto') IS NOT NULL
	DROP TABLE cb_plan_general_presupuesto
GO

IF OBJECT_ID ('cb_producto') IS NOT NULL
	DROP TABLE cb_producto
GO

IF OBJECT_ID ('cb_regimen_fiscal') IS NOT NULL
	DROP TABLE cb_regimen_fiscal
GO

IF OBJECT_ID ('cb_relofi') IS NOT NULL
	DROP TABLE cb_relofi
GO

IF OBJECT_ID ('cb_relparam') IS NOT NULL
	DROP TABLE cb_relparam
GO

IF OBJECT_ID ('cb_relparam_cca523') IS NOT NULL
	DROP TABLE cb_relparam_cca523
GO

IF OBJECT_ID ('cb_retencion') IS NOT NULL
	DROP TABLE cb_retencion
GO

IF OBJECT_ID ('cb_saldo') IS NOT NULL
	DROP TABLE cb_saldo
GO

IF OBJECT_ID ('cb_saldo_presupuesto') IS NOT NULL
	DROP TABLE cb_saldo_presupuesto
GO

IF OBJECT_ID ('cb_seqnos') IS NOT NULL
	DROP TABLE cb_seqnos
GO

IF OBJECT_ID ('cb_seqnos_comprobante') IS NOT NULL
	DROP TABLE cb_seqnos_comprobante
GO

IF OBJECT_ID ('cb_tipo_area') IS NOT NULL
	DROP TABLE cb_tipo_area
GO

IF OBJECT_ID ('cb_tmp_may') IS NOT NULL
	DROP TABLE cb_tmp_may
GO

IF OBJECT_ID ('cb_tran_servicio') IS NOT NULL
	DROP TABLE cb_tran_servicio
GO

IF OBJECT_ID ('EntesCta') IS NOT NULL
	DROP TABLE EntesCta
GO

IF OBJECT_ID ('sysdiagrams') IS NOT NULL
	DROP TABLE sysdiagrams
GO

IF OBJECT_ID ('tmp_cb_hist_saldo') IS NOT NULL
	DROP TABLE tmp_cb_hist_saldo
GO

IF OBJECT_ID ('tmp_cb_hist_saldo2') IS NOT NULL
	DROP TABLE tmp_cb_hist_saldo2
GO

IF OBJECT_ID ('tmp_cb_saldo_promm') IS NOT NULL
	DROP TABLE tmp_cb_saldo_promm
GO

IF OBJECT_ID ('asientos') IS NOT NULL
	DROP VIEW asientos
GO

IF OBJECT_ID ('cb_cotiz_mon_fechamax') IS NOT NULL
	DROP VIEW cb_cotiz_mon_fechamax
GO

IF OBJECT_ID ('cb_mig_codigo_valor_view') IS NOT NULL
	DROP VIEW cb_mig_codigo_valor_view
GO

IF OBJECT_ID ('cb_mig_cuenta_asociada_view') IS NOT NULL
	DROP VIEW cb_mig_cuenta_asociada_view
GO

IF OBJECT_ID ('cb_mig_cuenta_proceso_view') IS NOT NULL
	DROP VIEW cb_mig_cuenta_proceso_view
GO

IF OBJECT_ID ('cb_mig_cuentas_view') IS NOT NULL
	DROP VIEW cb_mig_cuentas_view
GO

IF OBJECT_ID ('cb_mig_det_perfil_view') IS NOT NULL
	DROP VIEW cb_mig_det_perfil_view
GO

IF OBJECT_ID ('cb_mig_jerararea_view') IS NOT NULL
	DROP VIEW cb_mig_jerararea_view
GO

IF OBJECT_ID ('cb_mig_jerarquia_view') IS NOT NULL
	DROP VIEW cb_mig_jerarquia_view
GO

IF OBJECT_ID ('cb_mig_oficina_view') IS NOT NULL
	DROP VIEW cb_mig_oficina_view
GO

IF OBJECT_ID ('cb_mig_parametro_view') IS NOT NULL
	DROP VIEW cb_mig_parametro_view
GO

IF OBJECT_ID ('cb_mig_perfil_view') IS NOT NULL
	DROP VIEW cb_mig_perfil_view
GO

IF OBJECT_ID ('cb_mig_plan_general_view') IS NOT NULL
	DROP VIEW cb_mig_plan_general_view
GO

IF OBJECT_ID ('cb_mig_relparam_view') IS NOT NULL
	DROP VIEW cb_mig_relparam_view
GO

IF OBJECT_ID ('cb_ult_fecha_cotiz_mon') IS NOT NULL
	DROP VIEW cb_ult_fecha_cotiz_mon
GO

IF OBJECT_ID ('cb_vcorte_mensual') IS NOT NULL
	DROP VIEW cb_vcorte_mensual
GO

IF OBJECT_ID ('cb_vcotizacion') IS NOT NULL
	DROP VIEW cb_vcotizacion
GO

IF OBJECT_ID ('cn_mig_parametro_view') IS NOT NULL
	DROP VIEW cn_mig_parametro_view
GO

IF OBJECT_ID ('comprobantes') IS NOT NULL
	DROP VIEW comprobantes
GO

IF OBJECT_ID ('dsal11050500005') IS NOT NULL
	DROP VIEW dsal11050500005
GO

IF OBJECT_ID ('dsal16871000005') IS NOT NULL
	DROP VIEW dsal16871000005
GO

IF OBJECT_ID ('dsal21651500005') IS NOT NULL
	DROP VIEW dsal21651500005
GO

IF OBJECT_ID ('dsal41159500065') IS NOT NULL
	DROP VIEW dsal41159500065
GO

IF OBJECT_ID ('dsaux16551000015') IS NOT NULL
	DROP VIEW dsaux16551000015
GO

IF OBJECT_ID ('dsaux16551000016') IS NOT NULL
	DROP VIEW dsaux16551000016
GO

IF OBJECT_ID ('dsaux16871500005') IS NOT NULL
	DROP VIEW dsaux16871500005
GO

IF OBJECT_ID ('dsaux16879500056') IS NOT NULL
	DROP VIEW dsaux16879500056
GO

IF OBJECT_ID ('dsaux19879500056') IS NOT NULL
	DROP VIEW dsaux19879500056
GO

IF OBJECT_ID ('dsaux237618') IS NOT NULL
	DROP VIEW dsaux237618
GO

IF OBJECT_ID ('dsaux25450000005') IS NOT NULL
	DROP VIEW dsaux25450000005
GO

IF OBJECT_ID ('dsaux25450500005') IS NOT NULL
	DROP VIEW dsaux25450500005
GO

IF OBJECT_ID ('dsaux25559500015') IS NOT NULL
	DROP VIEW dsaux25559500015
GO

IF OBJECT_ID ('dsaux25959500071') IS NOT NULL
	DROP VIEW dsaux25959500071
GO

IF OBJECT_ID ('dsaux27950500005') IS NOT NULL
	DROP VIEW dsaux27950500005
GO

IF OBJECT_ID ('dsaux28150500005') IS NOT NULL
	DROP VIEW dsaux28150500005
GO

IF OBJECT_ID ('dsaux28959500006') IS NOT NULL
	DROP VIEW dsaux28959500006
GO

IF OBJECT_ID ('dsaux42259500021') IS NOT NULL
	DROP VIEW dsaux42259500021
GO

IF OBJECT_ID ('dsaux51900500005') IS NOT NULL
	DROP VIEW dsaux51900500005
GO

IF OBJECT_ID ('dsaux51904000900') IS NOT NULL
	DROP VIEW dsaux51904000900
GO

IF OBJECT_ID ('movimientos') IS NOT NULL
	DROP VIEW movimientos
GO

IF OBJECT_ID ('retencion') IS NOT NULL
	DROP VIEW retencion
GO

IF OBJECT_ID ('syncobj_0x3433443939344144') IS NOT NULL
	DROP VIEW syncobj_0x3433443939344144
GO

IF OBJECT_ID ('syncobj_0x3732433246344633') IS NOT NULL
	DROP VIEW syncobj_0x3732433246344633
GO

IF OBJECT_ID ('syncobj_0x3838413146313433') IS NOT NULL
	DROP VIEW syncobj_0x3838413146313433
GO

IF OBJECT_ID ('syncobj_0x4244354233453536') IS NOT NULL
	DROP VIEW syncobj_0x4244354233453536
GO

IF OBJECT_ID ('syncobj_0x4542463234314146') IS NOT NULL
	DROP VIEW syncobj_0x4542463234314146
GO

IF OBJECT_ID ('ts_area') IS NOT NULL
	DROP VIEW ts_area
GO

IF OBJECT_ID ('ts_asoc_operaciones') IS NOT NULL
	DROP VIEW ts_asoc_operaciones
GO

IF OBJECT_ID ('ts_asoemp') IS NOT NULL
	DROP VIEW ts_asoemp
GO

IF OBJECT_ID ('ts_banco') IS NOT NULL
	DROP VIEW ts_banco
GO

IF OBJECT_ID ('ts_banco_conci') IS NOT NULL
	DROP VIEW ts_banco_conci
GO

IF OBJECT_ID ('ts_categoria') IS NOT NULL
	DROP VIEW ts_categoria
GO

IF OBJECT_ID ('ts_cbproduc') IS NOT NULL
	DROP VIEW ts_cbproduc
GO

IF OBJECT_ID ('ts_codigo_valor') IS NOT NULL
	DROP VIEW ts_codigo_valor
GO

IF OBJECT_ID ('ts_comp_tipo') IS NOT NULL
	DROP VIEW ts_comp_tipo
GO

IF OBJECT_ID ('ts_comprobante') IS NOT NULL
	DROP VIEW ts_comprobante
GO

IF OBJECT_ID ('ts_conc_retencion') IS NOT NULL
	DROP VIEW ts_conc_retencion
GO

IF OBJECT_ID ('ts_concepto_conci') IS NOT NULL
	DROP VIEW ts_concepto_conci
GO

IF OBJECT_ID ('ts_concica') IS NOT NULL
	DROP VIEW ts_concica
GO

IF OBJECT_ID ('ts_concil_operaciones') IS NOT NULL
	DROP VIEW ts_concil_operaciones
GO

IF OBJECT_ID ('ts_conciva') IS NOT NULL
	DROP VIEW ts_conciva
GO

IF OBJECT_ID ('ts_concivapagado') IS NOT NULL
	DROP VIEW ts_concivapagado
GO

IF OBJECT_ID ('ts_consolid') IS NOT NULL
	DROP VIEW ts_consolid
GO

IF OBJECT_ID ('ts_control') IS NOT NULL
	DROP VIEW ts_control
GO

IF OBJECT_ID ('ts_corte') IS NOT NULL
	DROP VIEW ts_corte
GO

IF OBJECT_ID ('ts_cotizacion') IS NOT NULL
	DROP VIEW ts_cotizacion
GO

IF OBJECT_ID ('ts_cuenta') IS NOT NULL
	DROP VIEW ts_cuenta
GO

IF OBJECT_ID ('ts_cuenta_asociada') IS NOT NULL
	DROP VIEW ts_cuenta_asociada
GO

IF OBJECT_ID ('ts_cuenta_departamento') IS NOT NULL
	DROP VIEW ts_cuenta_departamento
GO

IF OBJECT_ID ('ts_cuenta_presupuesto') IS NOT NULL
	DROP VIEW ts_cuenta_presupuesto
GO

IF OBJECT_ID ('ts_cuenta_proceso') IS NOT NULL
	DROP VIEW ts_cuenta_proceso
GO

IF OBJECT_ID ('ts_departamento') IS NOT NULL
	DROP VIEW ts_departamento
GO

IF OBJECT_ID ('ts_depurado') IS NOT NULL
	DROP VIEW ts_depurado
GO

IF OBJECT_ID ('ts_det_perfil') IS NOT NULL
	DROP VIEW ts_det_perfil
GO

IF OBJECT_ID ('ts_diferido') IS NOT NULL
	DROP VIEW ts_diferido
GO

IF OBJECT_ID ('ts_diferidos') IS NOT NULL
	DROP VIEW ts_diferidos
GO

IF OBJECT_ID ('ts_dinamica') IS NOT NULL
	DROP VIEW ts_dinamica
GO

IF OBJECT_ID ('ts_documento_empresa') IS NOT NULL
	DROP VIEW ts_documento_empresa
GO

IF OBJECT_ID ('ts_empresa') IS NOT NULL
	DROP VIEW ts_empresa
GO

IF OBJECT_ID ('ts_estcta') IS NOT NULL
	DROP VIEW ts_estcta
GO

IF OBJECT_ID ('ts_exenciu') IS NOT NULL
	DROP VIEW ts_exenciu
GO

IF OBJECT_ID ('ts_exenpro') IS NOT NULL
	DROP VIEW ts_exenpro
GO

IF OBJECT_ID ('ts_grupo_gastos') IS NOT NULL
	DROP VIEW ts_grupo_gastos
GO

IF OBJECT_ID ('ts_impdept') IS NOT NULL
	DROP VIEW ts_impdept
GO

IF OBJECT_ID ('ts_impuestos') IS NOT NULL
	DROP VIEW ts_impuestos
GO

IF OBJECT_ID ('ts_item') IS NOT NULL
	DROP VIEW ts_item
GO

IF OBJECT_ID ('ts_nivel_area') IS NOT NULL
	DROP VIEW ts_nivel_area
GO

IF OBJECT_ID ('ts_nivel_cuenta') IS NOT NULL
	DROP VIEW ts_nivel_cuenta
GO

IF OBJECT_ID ('ts_nivel_presupuesto') IS NOT NULL
	DROP VIEW ts_nivel_presupuesto
GO

IF OBJECT_ID ('ts_oficina') IS NOT NULL
	DROP VIEW ts_oficina
GO

IF OBJECT_ID ('ts_oficina_departamento') IS NOT NULL
	DROP VIEW ts_oficina_departamento
GO

IF OBJECT_ID ('ts_opc_item') IS NOT NULL
	DROP VIEW ts_opc_item
GO

IF OBJECT_ID ('ts_opcion') IS NOT NULL
	DROP VIEW ts_opcion
GO

IF OBJECT_ID ('ts_organizacion') IS NOT NULL
	DROP VIEW ts_organizacion
GO

IF OBJECT_ID ('ts_parametrizacion_grupos') IS NOT NULL
	DROP VIEW ts_parametrizacion_grupos
GO

IF OBJECT_ID ('ts_parametro') IS NOT NULL
	DROP VIEW ts_parametro
GO

IF OBJECT_ID ('ts_perfil') IS NOT NULL
	DROP VIEW ts_perfil
GO

IF OBJECT_ID ('ts_periodo') IS NOT NULL
	DROP VIEW ts_periodo
GO

IF OBJECT_ID ('ts_plan_general') IS NOT NULL
	DROP VIEW ts_plan_general
GO

IF OBJECT_ID ('ts_plan_general_presupuesto') IS NOT NULL
	DROP VIEW ts_plan_general_presupuesto
GO

IF OBJECT_ID ('ts_relarea') IS NOT NULL
	DROP VIEW ts_relarea
GO

IF OBJECT_ID ('ts_relofi') IS NOT NULL
	DROP VIEW ts_relofi
GO

IF OBJECT_ID ('ts_relparam') IS NOT NULL
	DROP VIEW ts_relparam
GO

IF OBJECT_ID ('ts_retencion') IS NOT NULL
	DROP VIEW ts_retencion
GO

IF OBJECT_ID ('ts_saldo_presupuesto') IS NOT NULL
	DROP VIEW ts_saldo_presupuesto
GO

IF OBJECT_ID ('ts_seguridad') IS NOT NULL
	DROP VIEW ts_seguridad
GO

IF OBJECT_ID ('ts_tipo_area') IS NOT NULL
	DROP VIEW ts_tipo_area
GO

IF OBJECT_ID ('ts_tipo_documento') IS NOT NULL
	DROP VIEW ts_tipo_documento
GO

IF OBJECT_ID ('ts_tran_interfase') IS NOT NULL
	DROP VIEW ts_tran_interfase
GO

IF OBJECT_ID ('ts_tran_serv_pag_decl') IS NOT NULL
	DROP VIEW ts_tran_serv_pag_decl
GO

IF OBJECT_ID ('v_cb_inmovpro') IS NOT NULL
	DROP VIEW v_cb_inmovpro
GO

IF OBJECT_ID ('vw_cabecera') IS NOT NULL
	DROP VIEW vw_cabecera
GO

CREATE TABLE dbo.cargue_niif_errores_tmp
	(
	ARCHIVO     VARCHAR (30) NULL,
	FECHACARGA  DATETIME NULL,
	CUENTA      VARCHAR (14) NULL,
	NATURALEZA  CHAR (1) NULL,
	MONEDA      CHAR (1) NULL,
	INDICADOR   CHAR (1) NULL,
	DESCRIPCION VARCHAR (100) NULL
	)
GO

CREATE TABLE dbo.cb_area
	(
	ar_empresa      TINYINT NOT NULL,
	ar_area         SMALLINT NOT NULL,
	ar_descripcion  descripcion NOT NULL,
	ar_area_padre   SMALLINT NULL,
	ar_estado       CHAR (1) NOT NULL,
	ar_fecha_estado DATETIME NULL,
	ar_nivel_area   TINYINT NOT NULL,
	ar_consolida    CHAR (1) NOT NULL,
	ar_movimiento   CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_area_Key
	ON dbo.cb_area (ar_empresa,ar_area)
GO

CREATE NONCLUSTERED INDEX i_ar_area_padre
	ON dbo.cb_area (ar_area_padre,ar_empresa)
GO

CREATE NONCLUSTERED INDEX i_ar_nivel
	ON dbo.cb_area (ar_empresa,ar_nivel_area)
GO

CREATE TABLE dbo.cb_asiento
	(
	as_fecha_tran     DATETIME NOT NULL,
	as_comprobante    INT NOT NULL,
	as_empresa        TINYINT NOT NULL,
	as_asiento        INT NOT NULL,
	as_cuenta         cuenta_contable NOT NULL,
	as_oficina_dest   SMALLINT NOT NULL,
	as_area_dest      SMALLINT NOT NULL,
	as_credito        MONEY NULL,
	as_debito         MONEY NULL,
	as_concepto       descripcion NULL,
	as_credito_me     MONEY NULL,
	as_debito_me      MONEY NULL,
	as_cotizacion     MONEY NULL,
	as_mayorizado     CHAR (1) NOT NULL,
	as_tipo_doc       CHAR (1) NOT NULL,
	as_tipo_tran      CHAR (1) NOT NULL,
	as_moneda         TINYINT NULL,
	as_opcion         TINYINT NULL,
	as_fecha_est      DATETIME NULL,
	as_detalle        SMALLINT NULL,
	as_consolidado    CHAR (1) NULL,
	as_oficina_orig   SMALLINT NOT NULL,
	as_mes_fecha_tran TINYINT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_asiento_key
	ON dbo.cb_asiento (as_comprobante,as_fecha_tran,as_asiento,as_oficina_orig,as_empresa)
GO

CREATE NONCLUSTERED INDEX cb_asiento_key2
	ON dbo.cb_asiento (as_cuenta,as_fecha_tran,as_oficina_dest,as_area_dest)
GO

CREATE TABLE dbo.cb_banco
	(
	ba_empresa   TINYINT NOT NULL,
	ba_banco     VARCHAR (3) NOT NULL,
	ba_nombre    descripcion NOT NULL,
	ba_cuenta    CHAR (20) NOT NULL,
	ba_ctacte    VARCHAR (20) NOT NULL,
	ba_operacion CHAR (4) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_banco_Key
	ON dbo.cb_banco (ba_empresa,ba_banco,ba_ctacte,ba_operacion)
GO

CREATE TABLE dbo.cb_blcom
	(
	bl_empresa    TINYINT NULL,
	bl_cuenta     cuenta NULL,
	bl_nombre     descripcion NULL,
	bl_oficina    SMALLINT NULL,
	bl_saldo_ant  MONEY NULL,
	bl_saldo_act  MONEY NULL,
	bl_diferencia MONEY NULL,
	bl_porcentaje MONEY NULL
	)
GO

CREATE TABLE dbo.cb_campos_banco
	(
	cb_codigo        CHAR (3) NOT NULL,
	cb_nombre        CHAR (40) NOT NULL,
	cb_tipo_registro TINYINT NULL
	)
GO

CREATE TABLE dbo.cb_categoria
	(
	ca_categoria CHAR (1) NOT NULL,
	ca_nombre    descripcion NOT NULL,
	ca_signo     CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_categoria_Key
	ON dbo.cb_categoria (ca_categoria)
GO

CREATE TABLE dbo.cb_comp_tipo
	(
	ct_comp_tipo    INT NOT NULL,
	ct_empresa      TINYINT NOT NULL,
	ct_modificable  CHAR (1) NOT NULL,
	ct_concepto     VARCHAR (255) NULL,
	ct_oficina_orig SMALLINT NOT NULL,
	ct_area_orig    SMALLINT NOT NULL,
	ct_porcentual   CHAR (1) NULL,
	ct_referencia   VARCHAR (10) NULL,
	ct_detalles     INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_comp_tipo_Key
	ON dbo.cb_comp_tipo (ct_comp_tipo,ct_empresa)
GO

CREATE TABLE dbo.cb_comprobante
	(
	co_comprobante    INT NOT NULL,
	co_empresa        TINYINT NOT NULL,
	co_fecha_tran     DATETIME NOT NULL,
	co_oficina_orig   SMALLINT NOT NULL,
	co_area_orig      SMALLINT NOT NULL,
	co_fecha_dig      DATETIME NOT NULL,
	co_fecha_mod      DATETIME NOT NULL,
	co_digitador      descripcion NOT NULL,
	co_descripcion    descripcion NULL,
	co_mayorizado     CHAR (1) NOT NULL,
	co_comp_tipo      INT NULL,
	co_detalles       INT NOT NULL,
	co_tot_debito     MONEY NOT NULL,
	co_tot_credito    MONEY NOT NULL,
	co_tot_debito_me  MONEY NOT NULL,
	co_tot_credito_me MONEY NOT NULL,
	co_automatico     INT NULL,
	co_reversado      CHAR (1) NOT NULL,
	co_autorizado     CHAR (1) NOT NULL,
	co_autorizante    descripcion NULL,
	co_referencia     VARCHAR (10) NULL,
	co_causa_anula    CHAR (2) NULL,
	co_tipo_compro    CHAR (1) NULL,
	co_estado         CHAR (1) NULL,
	co_traslado       CHAR (1) NULL,
	co_mes_fecha_tran TINYINT NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_comprobante_key
	ON dbo.cb_comprobante (co_comprobante,co_fecha_tran,co_oficina_orig,co_empresa)
GO

CREATE TABLE dbo.cb_conc_retencion
	(
	cr_empresa     TINYINT NOT NULL,
	cr_codigo      CHAR (4) NOT NULL,
	cr_descripcion VARCHAR (30) NOT NULL,
	cr_base        MONEY NULL,
	cr_porcentaje  FLOAT NULL,
	cr_debcred     CHAR (1) NOT NULL,
	cr_tipo        CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_conc_retencion_Key
	ON dbo.cb_conc_retencion (cr_empresa,cr_codigo,cr_tipo,cr_debcred)
GO

CREATE TABLE dbo.cb_control
	(
	cn_empresa TINYINT NOT NULL,
	cn_login   VARCHAR (14) NOT NULL,
	cn_oficina SMALLINT NOT NULL,
	cn_area    SMALLINT NOT NULL,
	cn_tipo    CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_control_Key
	ON dbo.cb_control (cn_empresa,cn_login,cn_oficina,cn_area)
GO

CREATE TABLE dbo.cb_corte
	(
	co_corte      INT NOT NULL,
	co_periodo    INT NOT NULL,
	co_empresa    TINYINT NOT NULL,
	co_fecha_ini  DATETIME NOT NULL,
	co_fecha_fin  DATETIME NOT NULL,
	co_estado     CHAR (1) NOT NULL,
	co_tipo_corte TINYINT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_corte_Key
	ON dbo.cb_corte (co_corte,co_periodo,co_empresa)
GO

CREATE NONCLUSTERED INDEX cb_corte_Key_fecha
	ON dbo.cb_corte (co_fecha_ini)
GO

CREATE TABLE dbo.cb_cotizacion
	(
	ct_moneda  TINYINT NOT NULL,
	ct_fecha   DATETIME NOT NULL,
	ct_valor   MONEY NULL,
	ct_compra  MONEY NOT NULL,
	ct_venta   MONEY NOT NULL,
	ct_factor1 FLOAT NULL,
	ct_factor2 FLOAT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_cotizacion_Key
	ON dbo.cb_cotizacion (ct_moneda,ct_fecha)
GO

CREATE NONCLUSTERED INDEX i_cotizacion
	ON dbo.cb_cotizacion (ct_fecha)
GO

CREATE TABLE dbo.cb_cuenta
	(
	cu_empresa      TINYINT NOT NULL,
	cu_cuenta       cuenta_contable NOT NULL,
	cu_cuenta_padre cuenta_contable NULL,
	cu_nombre       CHAR (80) NOT NULL,
	cu_descripcion  CHAR (255) NULL,
	cu_estado       CHAR (1) NOT NULL,
	cu_movimiento   CHAR (1) NOT NULL,
	cu_nivel_cuenta TINYINT NOT NULL,
	cu_categoria    CHAR (1) NOT NULL,
	cu_fecha_estado DATETIME NULL,
	cu_moneda       TINYINT NOT NULL,
	cu_sinonimo     CHAR (20) NULL,
	cu_acceso       CHAR (1) NULL,
	cu_presupuesto  CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_cuenta_Key
	ON dbo.cb_cuenta (cu_empresa,cu_cuenta)
GO

CREATE NONCLUSTERED INDEX i_cu_categoria
	ON dbo.cb_cuenta (cu_categoria)
GO

CREATE NONCLUSTERED INDEX i_cu_cuenta_padre
	ON dbo.cb_cuenta (cu_cuenta_padre,cu_empresa)
GO

CREATE NONCLUSTERED INDEX i_cu_moneda
	ON dbo.cb_cuenta (cu_moneda)
GO

CREATE NONCLUSTERED INDEX i_cu_nivel_cuenta
	ON dbo.cb_cuenta (cu_empresa,cu_nivel_cuenta)
GO

CREATE TABLE dbo.cb_cuenta_asociada
	(
	ca_empresa         TINYINT NOT NULL,
	ca_cuenta          cuenta_contable NOT NULL,
	ca_oficina         SMALLINT NULL,
	ca_area            SMALLINT NULL,
	ca_proceso         SMALLINT NOT NULL,
	ca_secuencial      SMALLINT NOT NULL,
	ca_condicion       SMALLINT NOT NULL,
	ca_cta_asoc        cuenta_contable NULL,
	ca_oficina_destino SMALLINT NULL,
	ca_area_destino    SMALLINT NULL,
	ca_debcred         CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_cuenta_asociada_Key
	ON dbo.cb_cuenta_asociada (ca_empresa,ca_cuenta,ca_oficina,ca_area,ca_proceso,ca_secuencial)
GO

CREATE TABLE dbo.cb_cuenta_niif
	(
	cu_fecha_ing    DATETIME NOT NULL,
	cu_cuenta       cuenta_contable NOT NULL,
	cu_cuenta_padre cuenta_contable NULL,
	cu_nivel_cuenta TINYINT NOT NULL,
	cu_categoria    CHAR (1) NOT NULL,
	cu_moneda       TINYINT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.cb_cuenta_niif (cu_cuenta,cu_fecha_ing)
GO

CREATE TABLE dbo.cb_cuenta_presupuesto
	(
	cup_empresa      TINYINT NOT NULL,
	cup_cuenta       cuenta_contable NOT NULL,
	cup_cuenta_padre cuenta_contable NULL,
	cup_nombre       descripcion NOT NULL,
	cup_descripcion  VARCHAR (255) NULL,
	cup_nivel_cuenta TINYINT NOT NULL,
	cup_categoria    CHAR (1) NOT NULL,
	cup_movimiento   CHAR (1) NOT NULL,
	cup_estado       CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_cuenta_presup_Key
	ON dbo.cb_cuenta_presupuesto (cup_empresa,cup_cuenta)
GO

CREATE NONCLUSTERED INDEX i_cup_categoria
	ON dbo.cb_cuenta_presupuesto (cup_categoria)
GO

CREATE NONCLUSTERED INDEX i_cup_cuenta_padre
	ON dbo.cb_cuenta_presupuesto (cup_cuenta_padre,cup_empresa)
GO

CREATE NONCLUSTERED INDEX i_cup_nivel_cuenta
	ON dbo.cb_cuenta_presupuesto (cup_empresa,cup_nivel_cuenta)
GO

CREATE TABLE dbo.cb_cuenta_proceso
	(
	cp_proceso   INT NOT NULL,
	cp_empresa   TINYINT NOT NULL,
	cp_cuenta    cuenta_contable NOT NULL,
	cp_oficina   SMALLINT NULL,
	cp_area      SMALLINT NULL,
	cp_imprima   CHAR (1) NULL,
	cp_condicion CHAR (4) NULL,
	cp_texto     descripcion NULL,
	cp_quiebre   CHAR (10) NULL
	)
GO

CREATE NONCLUSTERED INDEX cb_cuenta_proceso_Key
	ON dbo.cb_cuenta_proceso (cp_proceso,cp_oficina,cp_area,cp_cuenta,cp_empresa)
GO

CREATE TABLE dbo.cb_cuenta_proceso_CCA550
	(
	cp_proceso   INT NOT NULL,
	cp_empresa   TINYINT NOT NULL,
	cp_cuenta    cuenta_contable NOT NULL,
	cp_oficina   SMALLINT NULL,
	cp_area      SMALLINT NULL,
	cp_imprima   CHAR (1) NULL,
	cp_condicion CHAR (4) NULL,
	cp_texto     descripcion NULL,
	cp_quiebre   CHAR (10) NULL
	)
GO

CREATE TABLE dbo.cb_cuenta6004
	(
	proceso     INT NOT NULL,
	cuenta      cuenta_contable NOT NULL,
	oficina     CHAR (4) NOT NULL,
	area        CHAR (4) NOT NULL,
	condicion   CHAR (4) NULL,
	imprima     CHAR (1) NULL,
	descripcion descripcion NULL,
	texto       descripcion NULL
	)
GO

CREATE TABLE dbo.cb_cuentas_ord_tmp
	(
	cuenta INT NULL,
	monto  MONEY NULL,
	sec    INT NULL
	)
GO

CREATE NONCLUSTERED INDEX cb_cuentas_ord_tmp_idx1
	ON dbo.cb_cuentas_ord_tmp (sec)
GO

CREATE TABLE dbo.cb_cuentas_ord_tmp_mv
	(
	cuenta VARCHAR (30) NULL,
	monto  MONEY NULL,
	sec    INT NULL
	)
GO

CREATE TABLE dbo.cb_cuentas_tmp
	(
	tmp_secuencia     INT NULL,
	tmp_cuenta        VARCHAR (20) NULL,
	tmp_estado        CHAR (1) NULL,
	tmp_multiplicador TINYINT NULL
	)
GO

CREATE TABLE dbo.cb_det_comptipo
	(
	dct_empresa      TINYINT NOT NULL,
	dct_comp_tipo    INT NOT NULL,
	dct_asiento      SMALLINT NOT NULL,
	dct_cuenta       cuenta_contable NOT NULL,
	dct_oficina_dest SMALLINT NOT NULL,
	dct_area_dest    SMALLINT NOT NULL,
	dct_debe         MONEY NULL,
	dct_haber        MONEY NULL,
	dct_debe_me      MONEY NULL,
	dct_haber_me     MONEY NULL,
	dct_cotizacion   MONEY NULL,
	dct_concepto     VARCHAR (255) NULL,
	dct_tipo_doc     CHAR (1) NOT NULL,
	dct_tipo_tran    CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX i_dct_cuenta
	ON dbo.cb_det_comptipo (dct_empresa,dct_cuenta,dct_oficina_dest,dct_area_dest)
GO

CREATE TABLE dbo.cb_det_perfil
	(
	dp_empresa     TINYINT NOT NULL,
	dp_producto    TINYINT NOT NULL,
	dp_perfil      VARCHAR (20) NOT NULL,
	dp_asiento     SMALLINT NOT NULL,
	dp_cuenta      VARCHAR (40) NULL,
	dp_area        VARCHAR (10) NOT NULL,
	dp_debcred     CHAR (1) NOT NULL,
	dp_codval      INT NOT NULL,
	dp_tipo_tran   CHAR (1) NOT NULL,
	dp_origen_dest CHAR (1) NULL,
	dp_constante   VARCHAR (3) NULL,
	dp_fuente      CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_det_perfil_Key
	ON dbo.cb_det_perfil (dp_empresa,dp_producto,dp_perfil,dp_asiento)
GO

CREATE NONCLUSTERED INDEX cb_det_perfil_Key2
	ON dbo.cb_det_perfil (dp_perfil,dp_codval)
GO

CREATE TABLE dbo.cb_dinamica
	(
	di_empresa       TINYINT NOT NULL,
	di_cuenta        CHAR (20) NOT NULL,
	di_secuencial    SMALLINT NOT NULL,
	di_tipo_dinamica CHAR (1) NOT NULL,
	di_texto         TEXT NOT NULL,
	di_disp_legal    VARCHAR (64) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_dinamica_Key
	ON dbo.cb_dinamica (di_empresa,di_cuenta,di_secuencial,di_tipo_dinamica)
GO

CREATE TABLE dbo.cb_empresa
	(
	em_empresa     TINYINT NOT NULL,
	em_ruc         VARCHAR (13) NOT NULL,
	em_descripcion VARCHAR (64) NOT NULL,
	em_replegal    VARCHAR (64) NULL,
	em_contgen     VARCHAR (64) NULL,
	em_moneda_base TINYINT NOT NULL,
	em_abreviatura CHAR (16) NULL,
	em_direccion   VARCHAR (64) NOT NULL,
	em_matcontgen  CHAR (10) NOT NULL,
	em_revisor     VARCHAR (64) NOT NULL,
	em_matrevisor  CHAR (10) NOT NULL,
	em_emp_revisor descripcion NULL,
	em_nit_emprev  VARCHAR (13) NULL,
	em_mat_revisor CHAR (10) NULL
	)
GO

CREATE TABLE dbo.cb_exencion_ciudad
	(
	ec_empresa  TINYINT NOT NULL,
	ec_impuesto CHAR (1) NOT NULL,
	ec_concepto CHAR (4) NOT NULL,
	ec_debcred  CHAR (1) NOT NULL,
	ec_ciudad   INT NOT NULL,
	ec_ofi_orig CHAR (1) NULL,
	ec_ofi_dest CHAR (1) NULL
	)
GO

CREATE TABLE dbo.cb_exencion_producto
	(
	ep_empresa  TINYINT NOT NULL,
	ep_regimen  catalogo NOT NULL,
	ep_producto TINYINT NOT NULL,
	ep_impuesto CHAR (1) NOT NULL,
	ep_concepto CHAR (4) NOT NULL
	)
GO

CREATE TABLE dbo.cb_general_presupuesto
	(
	gp_empresa             TINYINT NOT NULL,
	gp_oficina_presupuesto SMALLINT NOT NULL,
	gp_area_presupuesto    INT NOT NULL,
	gp_cuenta_presupuesto  cuenta_contable NOT NULL,
	gp_oficina             SMALLINT NOT NULL,
	gp_area                INT NOT NULL,
	gp_cuenta              cuenta_contable NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_general_pr_Key
	ON dbo.cb_general_presupuesto (gp_empresa,gp_oficina_presupuesto,gp_area_presupuesto,gp_cuenta_presupuesto,gp_oficina,gp_area,gp_cuenta)
GO

CREATE TABLE dbo.cb_ica
	(
	ic_empresa     TINYINT NOT NULL,
	ic_codigo      CHAR (4) NOT NULL,
	ic_descripcion VARCHAR (255) NOT NULL,
	ic_base        MONEY NULL,
	ic_porcentaje  FLOAT NULL,
	ic_ciudad      INT NULL,
	ic_debcred     CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_ica_Key
	ON dbo.cb_ica (ic_empresa,ic_codigo,ic_ciudad,ic_debcred)
GO

CREATE TABLE dbo.cb_imptos_deptales
	(
	id_empresa     TINYINT NOT NULL,
	id_codigo      catalogo NOT NULL,
	id_debcred     CHAR (1) NOT NULL,
	id_depto       INT NOT NULL,
	id_descripcion descripcion NOT NULL,
	id_base_ini    MONEY NOT NULL,
	id_base_fin    MONEY NOT NULL,
	id_porcentaje  FLOAT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_imptos_deptales_Key
	ON dbo.cb_imptos_deptales (id_empresa,id_codigo,id_debcred,id_depto)
GO

CREATE TABLE dbo.cb_iva
	(
	iva_empresa     TINYINT NOT NULL,
	iva_codigo      CHAR (4) NOT NULL,
	iva_descripcion VARCHAR (150) NOT NULL,
	iva_base        MONEY NULL,
	iva_porcentaje  FLOAT NULL,
	iva_descontado  CHAR (1) NULL,
	iva_des_porcen  FLOAT NULL,
	iva_debcred     CHAR (1) NOT NULL,
	iva_porc_espec  FLOAT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_iva_Key
	ON dbo.cb_iva (iva_empresa,iva_codigo,iva_debcred)
GO

CREATE TABLE dbo.cb_iva_pagado
	(
	ip_empresa     TINYINT NOT NULL,
	ip_codigo      CHAR (4) NOT NULL,
	ip_descripcion VARCHAR (150) NOT NULL,
	ip_porcentaje  FLOAT NULL,
	ip_debcred     CHAR (1) NOT NULL,
	ip_base        MONEY NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_iva_pagado_Key
	ON dbo.cb_iva_pagado (ip_empresa,ip_codigo,ip_debcred)
GO

CREATE TABLE dbo.cb_jerararea
	(
	ja_empresa    TINYINT NOT NULL,
	ja_area       SMALLINT NULL,
	ja_area_padre SMALLINT NULL,
	ja_nivel      TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_jerararea_Key
	ON dbo.cb_jerararea (ja_empresa,ja_area,ja_area_padre,ja_nivel)
GO

CREATE NONCLUSTERED INDEX cb_jerararea_2
	ON dbo.cb_jerararea (ja_area_padre,ja_area)
GO

CREATE TABLE dbo.cb_jerarquia
	(
	je_empresa       TINYINT NOT NULL,
	je_oficina       SMALLINT NULL,
	je_oficina_padre SMALLINT NULL,
	je_nivel         TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_jerarquia_Key
	ON dbo.cb_jerarquia (je_empresa,je_oficina,je_oficina_padre,je_nivel)
GO

CREATE NONCLUSTERED INDEX cb_jerarquia_2
	ON dbo.cb_jerarquia (je_oficina_padre,je_oficina)
GO

CREATE TABLE dbo.cb_nivel_area
	(
	na_empresa     TINYINT NOT NULL,
	na_nivel_area  TINYINT NOT NULL,
	na_descripcion descripcion NOT NULL
	)
GO

CREATE TABLE dbo.cb_nivel_cuenta
	(
	nc_empresa      TINYINT NOT NULL,
	nc_nivel_cuenta TINYINT NOT NULL,
	nc_longitud     TINYINT NOT NULL,
	nc_descripcion  descripcion NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_nivel_cuenta_Key
	ON dbo.cb_nivel_cuenta (nc_empresa,nc_nivel_cuenta)
GO

CREATE TABLE dbo.cb_ofi_org
	(
	nivel   TINYINT NULL,
	oficina SMALLINT NULL
	)
GO

CREATE TABLE dbo.cb_ofic_cont
	(
	oc_empresa   TINYINT NULL,
	oc_oficina   SMALLINT NULL,
	oc_area      SMALLINT NULL,
	oc_ofi_cons  SMALLINT NULL,
	oc_ofi_padre SMALLINT NULL,
	oc_ofi_reg   SMALLINT NULL,
	oc_ofi_cob   SMALLINT NULL,
	oc_ofi_zona  SMALLINT NULL,
	oc_ofi_age   SMALLINT NULL
	)
GO

CREATE TABLE dbo.cb_oficina
	(
	of_empresa       TINYINT NOT NULL,
	of_oficina       SMALLINT NOT NULL,
	of_descripcion   descripcion NOT NULL,
	of_oficina_padre SMALLINT NULL,
	of_estado        CHAR (1) NOT NULL,
	of_fecha_estado  DATETIME NULL,
	of_organizacion  TINYINT NOT NULL,
	of_consolida     CHAR (1) NOT NULL,
	of_movimiento    CHAR (1) NOT NULL,
	of_codigo        descripcion NULL,
	CONSTRAINT pk_cb_oficina PRIMARY KEY (of_empresa,of_oficina)
	)
GO

CREATE NONCLUSTERED INDEX i_of_organizacion
	ON dbo.cb_oficina (of_organizacion,of_empresa)
GO

CREATE NONCLUSTERED INDEX i_of_oficina_padre
	ON dbo.cb_oficina (of_oficina_padre,of_empresa)
GO

CREATE TABLE dbo.cb_oficina_tmp
	(
	of_oficina SMALLINT NULL
	)
GO

CREATE TABLE dbo.cb_ofpagadora
	(
	of_oficina_consolida SMALLINT NOT NULL,
	of_cod_declaracion   CHAR (2) NOT NULL,
	of_declaracion       VARCHAR (60) NOT NULL,
	of_icareteica        CHAR (1) NOT NULL,
	of_valadxofi         MONEY NULL,
	of_fpagobomberil     CHAR (2) NULL,
	of_vlabomberil       INT NULL,
	of_porbomberil       FLOAT NULL,
	of_cuenta            VARCHAR (20) NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_ofpagadora_key
	ON dbo.cb_ofpagadora (of_oficina_consolida,of_cod_declaracion)
GO

CREATE TABLE dbo.cb_organizacion
	(
	or_empresa      TINYINT NOT NULL,
	or_organizacion TINYINT NOT NULL,
	or_descripcion  descripcion NOT NULL
	)
GO

CREATE TABLE dbo.cb_paramdep
	(
	pd_empresa   TINYINT NOT NULL,
	pd_tabla     VARCHAR (50) NOT NULL,
	pd_tipo      CHAR (1) NOT NULL,
	pd_campo     VARCHAR (50) NOT NULL,
	pd_campo1    VARCHAR (50) NULL,
	pd_basedatos VARCHAR (50) NULL,
	pd_estado    CHAR (1) NOT NULL,
	pd_tipo_dep  CHAR (1) NOT NULL
	)
GO

CREATE TABLE dbo.cb_paramdep_cca_479
	(
	pd_empresa   TINYINT NOT NULL,
	pd_tabla     VARCHAR (50) NOT NULL,
	pd_tipo      CHAR (1) NOT NULL,
	pd_campo     VARCHAR (50) NOT NULL,
	pd_campo1    VARCHAR (50) NULL,
	pd_basedatos VARCHAR (50) NULL,
	pd_estado    CHAR (1) NOT NULL,
	pd_tipo_dep  CHAR (1) NOT NULL
	)
GO

CREATE TABLE dbo.cb_parametro
	(
	pa_empresa     TINYINT NOT NULL,
	pa_parametro   VARCHAR (10) NOT NULL,
	pa_descripcion descripcion NOT NULL,
	pa_stored      VARCHAR (20) NOT NULL,
	pa_transaccion INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_parametro_Key
	ON dbo.cb_parametro (pa_empresa,pa_parametro)
GO

CREATE TABLE dbo.cb_paramterceros
	(
	pt_secuencial NUMERIC (10) NOT NULL,
	pt_empresa    TINYINT NOT NULL,
	pt_oficina    SMALLINT NOT NULL,
	pt_ente       INT NOT NULL,
	pt_cuenta     cuenta NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_paramterceros_key
	ON dbo.cb_paramterceros (pt_oficina,pt_cuenta,pt_ente)
GO

CREATE TABLE dbo.cb_perfil
	(
	pe_empresa     TINYINT NOT NULL,
	pe_producto    TINYINT NOT NULL,
	pe_perfil      VARCHAR (20) NOT NULL,
	pe_descripcion descripcion NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_perfil_Key
	ON dbo.cb_perfil (pe_empresa,pe_producto,pe_perfil)
GO

CREATE TABLE dbo.cb_periodo
	(
	pe_periodo      INT NOT NULL,
	pe_empresa      TINYINT NOT NULL,
	pe_fecha_inicio DATETIME NOT NULL,
	pe_fecha_fin    DATETIME NOT NULL,
	pe_estado       CHAR (1) NOT NULL,
	pe_tipo_periodo CHAR (10) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_periodo_Key
	ON dbo.cb_periodo (pe_periodo,pe_empresa)
GO

CREATE TABLE dbo.cb_pgcom
	(
	pg_empresa    TINYINT NULL,
	pg_cuenta     cuenta NULL,
	pg_nombre     descripcion NULL,
	pg_oficina    SMALLINT NULL,
	pg_saldo_ant  MONEY NULL,
	pg_saldo_act  MONEY NULL,
	pg_diferencia MONEY NULL,
	pg_porcentaje MONEY NULL
	)
GO

CREATE TABLE dbo.cb_plan_general
	(
	pg_empresa TINYINT NOT NULL,
	pg_cuenta  cuenta_contable NOT NULL,
	pg_oficina SMALLINT NOT NULL,
	pg_area    SMALLINT NOT NULL,
	pg_clave   VARCHAR (30) NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_plan_general_Key
	ON dbo.cb_plan_general (pg_cuenta,pg_oficina,pg_area)
GO

CREATE NONCLUSTERED INDEX i_clave
	ON dbo.cb_plan_general (pg_clave)
GO

CREATE NONCLUSTERED INDEX i_pg_cuenta
	ON dbo.cb_plan_general (pg_oficina,pg_area)
GO

CREATE NONCLUSTERED INDEX i_pg_cuenta2
	ON dbo.cb_plan_general (pg_area)
GO

CREATE TABLE dbo.cb_plan_general_presupuesto
	(
	pgp_empresa TINYINT NOT NULL,
	pgp_cuenta  cuenta_contable NOT NULL,
	pgp_oficina SMALLINT NOT NULL,
	pgp_area    SMALLINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_plan_general_pr_Key
	ON dbo.cb_plan_general_presupuesto (pgp_empresa,pgp_cuenta,pgp_oficina,pgp_area)
GO

CREATE TABLE dbo.cb_producto
	(
	pr_empresa   TINYINT NOT NULL,
	pr_producto  TINYINT NOT NULL,
	pr_online    CHAR (1) NOT NULL,
	pr_estado    CHAR (1) NOT NULL,
	pr_resumen   CHAR (1) NOT NULL,
	pr_fecha_mod DATETIME NOT NULL
	)
GO

CREATE TABLE dbo.cb_regimen_fiscal
	(
	rf_codigo            catalogo NOT NULL,
	rf_descripcion       descripcion NOT NULL,
	rf_iva               CHAR (1) NOT NULL,
	rf_timbre            CHAR (1) NOT NULL,
	rf_renta             CHAR (1) NOT NULL,
	rf_ica               CHAR (1) NOT NULL,
	rf_iva_des           CHAR (1) NOT NULL,
	rf_iva_cobrado       CHAR (1) NOT NULL,
	rf_estampillas       CHAR (1) NOT NULL,
	rf_3xm               CHAR (1) NOT NULL,
	rf_estado            CHAR (1) NOT NULL,
	rf_retencion_iva     CHAR (1) NOT NULL,
	rf_naturaleza        CHAR (1) NOT NULL,
	rf_grancontribuyente CHAR (1) NOT NULL,
	rf_autorretenedor    CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_regimen_fiscal_Key
	ON dbo.cb_regimen_fiscal (rf_codigo)
GO

CREATE TABLE dbo.cb_relofi
	(
	re_filial  TINYINT NOT NULL,
	re_empresa TINYINT NOT NULL,
	re_ofadmin SMALLINT NOT NULL,
	re_ofconta SMALLINT NOT NULL,
	CONSTRAINT pk_cb_relofi PRIMARY KEY (re_filial,re_empresa,re_ofadmin)
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_relofi_Key
	ON dbo.cb_relofi (re_filial,re_empresa,re_ofadmin)
GO

CREATE TABLE dbo.cb_relparam
	(
	re_empresa     TINYINT NOT NULL,
	re_parametro   VARCHAR (10) NOT NULL,
	re_clave       VARCHAR (20) NOT NULL,
	re_substring   cuenta NOT NULL,
	re_producto    TINYINT NULL,
	re_tipo_area   VARCHAR (10) NULL,
	re_origen_dest CHAR (1) NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_relparam_Key
	ON dbo.cb_relparam (re_empresa,re_parametro,re_clave)
GO

CREATE TABLE dbo.cb_relparam_cca523
	(
	re_empresa     TINYINT NOT NULL,
	re_parametro   VARCHAR (10) NOT NULL,
	re_clave       VARCHAR (20) NOT NULL,
	re_substring   cuenta NOT NULL,
	re_producto    TINYINT NULL,
	re_tipo_area   VARCHAR (10) NULL,
	re_origen_dest CHAR (1) NULL
	)
GO

CREATE TABLE dbo.cb_retencion
	(
	re_comprobante         INT NOT NULL,
	re_empresa             TINYINT NOT NULL,
	re_asiento             INT NOT NULL,
	re_identifica          CHAR (13) NULL,
	re_tipo                CHAR (2) NULL,
	re_ente                INT NULL,
	re_fecha               DATETIME NOT NULL,
	re_cuenta              cuenta_contable NOT NULL,
	re_concepto            CHAR (4) NULL,
	re_base                MONEY NULL,
	re_valret              MONEY NULL,
	re_valor_asiento       MONEY NULL,
	re_valor_iva           MONEY NULL,
	re_valor_ica           MONEY NULL,
	re_iva_retenido        MONEY NULL,
	re_con_iva             CHAR (4) NULL,
	re_con_iva_reten       CHAR (4) NULL,
	re_con_timbre          CHAR (4) NULL,
	re_valor_timbre        MONEY NULL,
	re_retencion_calculado MONEY NULL,
	re_iva_calculado       MONEY NULL,
	re_ica_calculado       MONEY NULL,
	re_timbre_calculado    MONEY NULL,
	re_codigo_regimen      CHAR (4) NULL,
	re_con_ica             CHAR (4) NULL,
	re_con_ivapagado       CHAR (4) NULL,
	re_valor_ivapagado     MONEY NULL,
	re_ivapagado_calculado MONEY NULL,
	re_documento           CHAR (24) NULL,
	re_oficina_orig        SMALLINT NOT NULL,
	re_con_dptales         CHAR (4) NULL,
	re_valor_dptales       MONEY NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_retencion_Key
	ON dbo.cb_retencion (re_comprobante,re_asiento,re_fecha,re_oficina_orig)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.cb_retencion (re_fecha)
GO

CREATE TABLE dbo.cb_saldo
	(
	sa_empresa    TINYINT NOT NULL,
	sa_cuenta     cuenta_contable NOT NULL,
	sa_oficina    SMALLINT NOT NULL,
	sa_area       SMALLINT NOT NULL,
	sa_corte      INT NOT NULL,
	sa_periodo    INT NOT NULL,
	sa_saldo      MONEY NULL,
	sa_saldo_me   MONEY NULL,
	sa_debito     MONEY NULL,
	sa_credito    MONEY NULL,
	sa_debito_me  MONEY NULL,
	sa_credito_me MONEY NULL
	)
GO

CREATE UNIQUE NONCLUSTERED INDEX cb_saldo_Key
	ON dbo.cb_saldo (sa_cuenta,sa_oficina,sa_area,sa_corte,sa_periodo,sa_empresa)
GO

CREATE TABLE dbo.cb_saldo_presupuesto
	(
	sap_empresa     TINYINT NOT NULL,
	sap_cuenta      cuenta_contable NOT NULL,
	sap_oficina     SMALLINT NOT NULL,
	sap_area        SMALLINT NOT NULL,
	sap_fecha       DATETIME NOT NULL,
	sap_presupuesto MONEY NULL,
	sap_real        MONEY NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_saldo_presupuesto_Key
	ON dbo.cb_saldo_presupuesto (sap_empresa,sap_cuenta,sap_oficina,sap_area,sap_fecha)
GO

CREATE TABLE dbo.cb_seqnos
	(
	bdatos    VARCHAR (30) NULL,
	tabla     VARCHAR (30) NOT NULL,
	siguiente INT NULL,
	pkey      VARCHAR (30) NULL,
	empresa   TINYINT NULL
	)
GO

CREATE TABLE dbo.cb_seqnos_comprobante
	(
	sc_empresa TINYINT NOT NULL,
	sc_fecha   DATETIME NOT NULL,
	sc_tabla   VARCHAR (30) NOT NULL,
	sc_actual  INT NOT NULL,
	sc_modulo  TINYINT NOT NULL,
	sc_oficina SMALLINT NULL
	)
GO

CREATE NONCLUSTERED INDEX cb_seqnos_comprobante_01
	ON dbo.cb_seqnos_comprobante (sc_empresa,sc_fecha,sc_tabla,sc_modulo)
GO

CREATE TABLE dbo.cb_tipo_area
	(
	ta_empresa       TINYINT NOT NULL,
	ta_producto      TINYINT NOT NULL,
	ta_tiparea       VARCHAR (10) NOT NULL,
	ta_utiliza_valor CHAR (1) NOT NULL,
	ta_area          SMALLINT NULL,
	ta_descripcion   descripcion NULL,
	ta_ofi_central   SMALLINT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_tipo_area_Key
	ON dbo.cb_tipo_area (ta_empresa,ta_producto,ta_tiparea)
GO

CREATE TABLE dbo.cb_tmp_may
	(
	secuencial      NUMERIC (10) IDENTITY NOT NULL,
	co_empresa      TINYINT NOT NULL,
	co_cuenta       cuenta_contable NOT NULL,
	co_fecha_tran   DATETIME NOT NULL,
	co_oficina_dest SMALLINT NOT NULL,
	co_area_dest    SMALLINT NOT NULL,
	co_debito       MONEY NOT NULL,
	co_credito      MONEY NOT NULL,
	co_debito_me    MONEY NOT NULL,
	co_credito_me   MONEY NOT NULL,
	co_estado       CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_tmp_may_Key
	ON dbo.cb_tmp_may (secuencial)
GO

CREATE TABLE dbo.cb_tran_servicio
	(
	ts_secuencial          INT NOT NULL,
	ts_tipo_transaccion    SMALLINT NOT NULL,
	ts_clase               CHAR (1) NOT NULL,
	ts_fecha               DATETIME NULL,
	ts_usuario             login NULL,
	ts_terminal            descripcion NULL,
	ts_correccion          CHAR (1) NULL,
	ts_ssn_corr            INT NULL,
	ts_reentry             CHAR (1) NULL,
	ts_origen              CHAR (1) NULL,
	ts_nodo                VARCHAR (30) NULL,
	ts_remoto_ssn          INT NULL,
	ts_oficina             SMALLINT NULL,
	ts_descripcion         descripcion NULL,
	ts_tipo_plan           CHAR (2) NULL,
	ts_estado              CHAR (1) NULL,
	ts_cuenta              cuenta_contable NULL,
	ts_movimiento          CHAR (1) NULL,
	ts_categoria           CHAR (10) NULL,
	ts_nivel_cuenta        TINYINT NULL,
	ts_longitud            SMALLINT NULL,
	ts_empresa             TINYINT NULL,
	ts_ruc                 CHAR (13) NULL,
	ts_replegal            descripcion NULL,
	ts_contgen             descripcion NULL,
	ts_moneda              TINYINT NULL,
	ts_usa_cc              CHAR (1) NULL,
	ts_direccion           CHAR (120) NULL,
	ts_centro_costo        CHAR (16) NULL,
	ts_tipo_doc            CHAR (10) NULL,
	ts_numero_actual       SMALLINT NULL,
	ts_periodo             INT NULL,
	ts_fecha_ini           DATETIME NULL,
	ts_fecha_fin           DATETIME NULL,
	ts_corte               INT NULL,
	ts_comprobante         INT NULL,
	ts_concepto            CHAR (255) NULL,
	ts_comp_tipo           INT NULL,
	ts_tot_debito          MONEY NULL,
	ts_tot_credito         MONEY NULL,
	ts_tot_debito_me       MONEY NULL,
	ts_tot_credito_me      MONEY NULL,
	ts_cod_oficina         SMALLINT NULL,
	ts_oficina_padre       SMALLINT NULL,
	ts_area                SMALLINT NULL,
	ts_departamento        TINYINT NULL,
	ts_proceso             INT NULL,
	ts_ctaasoc             cuenta_contable NULL,
	ts_causa               CHAR (3) NULL,
	ts_ofic_orig           SMALLINT NULL,
	ts_ofic_dest           SMALLINT NULL,
	ts_ctadeb              cuenta_contable NULL,
	ts_ctacre              cuenta_contable NULL,
	ts_ctadeb_int          cuenta_contable NULL,
	ts_ctacre_int          cuenta_contable NULL,
	ts_ctadeb_des          cuenta_contable NULL,
	ts_ctacre_des          cuenta_contable NULL,
	ts_tipo_tran           SMALLINT NULL,
	ts_login               VARCHAR (10) NULL,
	ts_asiento             SMALLINT NULL,
	ts_cuenta_terc         cuenta_contable NULL,
	ts_base                MONEY NULL,
	ts_retencion           MONEY NULL,
	ts_codigo_conc         CHAR (4) NULL,
	ts_descripcion_conc    VARCHAR (50) NULL,
	ts_base_conc           MONEY NULL,
	ts_porcentaje_conc     FLOAT NULL,
	ts_presupuesto         CHAR (1) NULL,
	ts_iva                 CHAR (1) NULL,
	ts_ret                 CHAR (1) NULL,
	ts_ica                 CHAR (1) NULL,
	ts_descontado          CHAR (1) NULL,
	ts_des_porcen          FLOAT NULL,
	ts_ciudad_ica          INT NULL,
	ts_fecha_reg           DATETIME NULL,
	ts_valor_dif           MONEY NULL,
	ts_amort_acum          MONEY NULL,
	ts_control             CHAR (1) NULL,
	ts_porc_espec          FLOAT NULL,
	ts_empresa_subsidiaria TINYINT NULL,
	ts_regimen             catalogo NULL,
	ts_producto            TINYINT NULL,
	ts_impuesto            CHAR (1) NULL,
	ts_apl_ofi_orig        CHAR (1) NULL,
	ts_apl_ofi_dest        CHAR (1) NULL,
	ts_banco               CHAR (3) NULL,
	ts_oper_ent            CHAR (4) NULL,
	ts_oper_bco            CHAR (6) NULL,
	ts_operacion           CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX cb_trser_Key
	ON dbo.cb_tran_servicio (ts_secuencial,ts_tipo_transaccion,ts_clase)
GO

CREATE NONCLUSTERED INDEX cb_trser_Key_2
	ON dbo.cb_tran_servicio (ts_fecha)
GO

CREATE TABLE dbo.EntesCta
	(
	st_ente   INT NOT NULL,
	st_cuenta CHAR (14) NOT NULL,
	st_saldo  MONEY NULL,
	Procesado VARCHAR (1) NOT NULL
	)
GO

CREATE TABLE dbo.sysdiagrams
	(
	name         SYSNAME NOT NULL,
	principal_id INT NOT NULL,
	diagram_id   INT IDENTITY NOT NULL,
	version      INT NULL,
	definition   VARBINARY (1) NULL
	)
GO

CREATE TABLE dbo.tmp_cb_hist_saldo
	(
	th_empresa  TINYINT NULL,
	th_cuenta   cuenta NULL,
	th_oficina  SMALLINT NULL,
	th_nombre   VARCHAR (80) NULL,
	th_prom_act MONEY NULL,
	th_prom_ant MONEY NULL,
	th_var_abs  MONEY NULL,
	th_var_rel  MONEY NULL
	)
GO

CREATE NONCLUSTERED INDEX tmp_cb_hist_saldo
	ON dbo.tmp_cb_hist_saldo (th_empresa,th_cuenta,th_oficina)
GO

CREATE TABLE dbo.tmp_cb_hist_saldo2
	(
	ta_empresa  TINYINT NULL,
	ta_cuenta   cuenta NULL,
	ta_oficina  SMALLINT NULL,
	ta_prom_ant MONEY NULL
	)
GO

CREATE NONCLUSTERED INDEX tmp_cb_hist_saldo2
	ON dbo.tmp_cb_hist_saldo2 (ta_empresa,ta_cuenta,ta_oficina)
GO

CREATE TABLE dbo.tmp_cb_saldo_promm
	(
	sp_empresa       TINYINT NULL,
	sp_cuenta        cuenta NULL,
	sp_oficina       SMALLINT NULL,
	sp_nombre        VARCHAR (80) NULL,
	sp_corte_ini     INT NULL,
	sp_corte_fin     INT NULL,
	sp_saldo_prom    MONEY NULL,
	sp_saldo_prom_me MONEY NULL
	)
GO

CREATE NONCLUSTERED INDEX tmp_cb_saldo_promm
	ON dbo.tmp_cb_saldo_promm (sp_oficina,sp_cuenta)
GO

--Adaptive Server has expanded all '*' elements in the following statement

create view asientos as                        
select cob_conta..cb_asiento.as_fecha_tran, cob_conta..cb_asiento.as_comprobante, cob_conta..cb_asiento.as_empresa, cob_conta..cb_asiento.as_asiento, cob_conta..cb_asiento.as_cuenta, cob_conta..cb_asiento.as_oficina_dest, cob_conta..cb_asiento.as_area_dest, cob_conta..cb_asiento.as_credito, cob_conta..cb_asiento.as_debito, cob_conta..cb_asiento.as_concepto, cob_conta..cb_asiento.as_credito_me, cob_conta..cb_asiento.as_debito_me, cob_conta..cb_asiento.as_cotizacion, cob_conta..cb_asiento.as_mayorizado, cob_conta..cb_asiento.as_tipo_doc, cob_conta..cb_asiento.as_tipo_tran, cob_conta..cb_asiento.as_moneda, cob_conta..cb_asiento.as_opcion, cob_conta..cb_asiento.as_fecha_est, cob_conta..cb_asiento.as_detalle, cob_conta..cb_asiento.as_consolidado, cob_conta..cb_asiento.as_oficina_orig from cob_conta..cb_asiento
		where as_fecha_tran =  (select fecha  from cob_conta..corte_def)
                and as_comprobante > 0
		and as_asiento >0
		and as_empresa = 1

GO

create view cb_cotiz_mon_fechamax (
	cv_moneda, 
	cv_fecha_max
)
as
select  ct_moneda, 
	max(ct_fecha)
from cob_conta..cb_cotizacion, cobis..ba_fecha_proceso
where ct_fecha <= fp_fecha
group by ct_moneda

GO

CREATE VIEW dbo.cb_mig_codigo_valor_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_codigo_valor')

GO

CREATE VIEW dbo.cb_mig_cuenta_asociada_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_cuenta_asociada')

GO

CREATE VIEW dbo.cb_mig_cuenta_proceso_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_cuenta_proceso')

GO

CREATE VIEW dbo.cb_mig_cuentas_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_cuentasl')

GO

CREATE VIEW dbo.cb_mig_det_perfil_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_det_perfil')

GO

CREATE VIEW dbo.cb_mig_jerararea_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_jerararea')

GO

CREATE VIEW dbo.cb_mig_jerarquia_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_jerarquia')

GO

CREATE VIEW dbo.cb_mig_oficina_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_oficina')

GO

CREATE VIEW dbo.cb_mig_parametro_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_parametro')

GO

CREATE VIEW dbo.cb_mig_perfil_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_perfil')

GO

CREATE VIEW dbo.cb_mig_plan_general_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_plan_general')

GO

CREATE VIEW dbo.cb_mig_relparam_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_relparam')

GO

create view cb_ult_fecha_cotiz_mon (
	cv_moneda,
	cv_ult_fecha,
	cv_ult_valor
)
as
select ct_moneda,
       ct_fecha, 
       ct_valor
from cb_cotiz_mon_fechamax
     lEFT OUTER JOIN cb_cotizacion ON
     cv_moneda =  ct_moneda 
and  cv_fecha_max = ct_fecha

GO

create view cb_vcorte_mensual 
     ( cm_empresa,cm_periodo,cm_corte,cm_mes) 
    as
select co_empresa,co_periodo, max(co_corte) , datepart(mm,co_fecha_fin)
  from cb_corte
 where datepart(mm,co_fecha_fin) in (1,2,3,4,5,6,7,8,9,10,11,12)
 group by co_empresa, co_periodo, datepart(mm,co_fecha_fin)

GO

create view cb_vcotizacion 
     ( cv_fecha,cv_moneda,cv_valor) 
    as
select ct_fecha,ct_moneda,ct_valor
  from cb_cotizacion

GO

CREATE VIEW dbo.cn_mig_parametro_view
AS
SELECT     ce_posicion AS Registro, ce_nombre_bd AS [Base de Datos], ce_nombre_tabla AS Tabla, ce_dato_llave1 AS Identificacion, ce_dato_llave4 AS Proceso, 
                      ce_dato_llave5 AS [Campo Errado], ce_descripcion_error AS Descripcion
FROM         dbo.cb_mig_campos_errados
WHERE     (ce_nombre_tabla = 'cb_mig_parametro')

GO

--Adaptive Server has expanded all '*' elements in the following statement


create view comprobantes as         
select cob_conta..cb_comprobante.co_comprobante, cob_conta..cb_comprobante.co_empresa, cob_conta..cb_comprobante.co_fecha_tran, cob_conta..cb_comprobante.co_oficina_orig, cob_conta..cb_comprobante.co_area_orig, cob_conta..cb_comprobante.co_fecha_dig, cob_conta..cb_comprobante.co_fecha_mod, cob_conta..cb_comprobante.co_digitador, cob_conta..cb_comprobante.co_descripcion, cob_conta..cb_comprobante.co_mayorizado, cob_conta..cb_comprobante.co_comp_tipo, cob_conta..cb_comprobante.co_detalles, cob_conta..cb_comprobante.co_tot_debito, cob_conta..cb_comprobante.co_tot_credito, cob_conta..cb_comprobante.co_tot_debito_me, cob_conta..cb_comprobante.co_tot_credito_me, cob_conta..cb_comprobante.co_automatico, cob_conta..cb_comprobante.co_reversado, cob_conta..cb_comprobante.co_autorizado, cob_conta..cb_comprobante.co_autorizante, cob_conta..cb_comprobante.co_referencia, cob_conta..cb_comprobante.co_causa_anula, cob_conta..cb_comprobante.co_tipo_compro, cob_conta..cb_comprobante.co_estado, cob_conta..cb_comprobante.co_traslado 
from cob_conta..cb_comprobante
where 	co_fecha_tran = (select fecha  from cob_conta..corte_def)
and co_comprobante > 0
and co_empresa = 1

GO

create view dsal11050500005                                    as select    of_oficina, hi_cuenta,
                     hi_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                     hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),                
                     sum(isnull(hi_saldo,0)) hi_saldo,
                     sum(isnull(hi_saldo_me,0)) hi_saldo_me   from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia   where  hi_empresa  = 1   and    hi_periodo  = 2013   and    hi_corte    >= 32   and    hi_corte    <= 59   and    hi_cuenta  like '11050500005%'   and    of_empresa  = 1   and    of_oficina = je_oficina_padre   and    je_empresa  = 1   and    of_oficina  = 7008   and    hi_oficina = je_oficina
                         group by of_oficina,hi_cuenta, hi_corte, hi_periodo

GO

create view dsal16871000005                                    as select    of_oficina, hi_cuenta,
                     hi_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                     hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),                
                     sum(isnull(hi_saldo,0)) hi_saldo,
                     sum(isnull(hi_saldo_me,0)) hi_saldo_me   from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia   where  hi_empresa  = 1   and    hi_periodo  = 2010   and    hi_corte    >= 1   and    hi_corte    <= 365   and    hi_cuenta  like '16871000005%'   and    of_empresa  = 1   and    of_oficina = je_oficina_padre   and    je_empresa  = 1   and    hi_oficina = je_oficina
                         group by of_oficina,hi_cuenta, hi_corte, hi_periodo

GO

create view dsal21651500005                                    as select hi_oficina,
                 hi_cuenta,
                 sa_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                 hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),
                 sum(isnull(hi_saldo,0)) hi_saldo,
                 sum(isnull(hi_saldo_me,0)) hi_saldo_me   from cob_conta_his..cb_hist_saldo   where  hi_empresa  = 1   and    hi_periodo  = 2012   and    hi_corte    >= 61   and    hi_corte    <= 91   and    hi_cuenta  like '21651500005%'   and    hi_oficina  in (    select je_oficina from cob_conta..cb_jerarquia  where je_empresa =  1  and   (je_oficina =   255  or je_oficina_padre =  255 ))group by hi_oficina,hi_cuenta,hi_corte, hi_periodo

GO

create view dsal41159500065                                    as select    of_oficina, hi_cuenta,
                     hi_nombre = (select cu_nombre from cob_conta..cb_cuenta where cu_cuenta = hi_cuenta),
                     hi_fecha = (select co_fecha_ini from cob_conta..cb_corte where co_corte = hi_corte and co_periodo = hi_periodo),                
                     sum(isnull(hi_saldo,0)) hi_saldo,
                     sum(isnull(hi_saldo_me,0)) hi_saldo_me   from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia   where  hi_empresa  = 1   and    hi_periodo  = 2012   and    hi_corte    >= 182   and    hi_corte    <= 182   and    hi_cuenta  like '41159500065%'   and    of_empresa  = 1   and    of_oficina = je_oficina_padre   and    je_empresa  = 1   and    of_oficina  = 255   and    hi_oficina = je_oficina
                         group by of_oficina,hi_cuenta, hi_corte, hi_periodo

GO

create view dsaux16551000015                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '10/25/2012'   and sc_fecha_tran <=  '10/25/2012'   and sc_empresa =   1   and sa_cuenta  like '16551000015%'

GO

create view dsaux16551000016                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '10/25/2012'   and sc_fecha_tran <=  '10/25/2012'   and sc_empresa =   1   and sa_cuenta  like '16551000016%'

GO

create view dsaux16871500005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '09/01/2011'   and sc_fecha_tran <=  '09/30/2011'   and sc_empresa =   1   and sa_cuenta  like '16871500005%'
GO

create view dsaux16879500056                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '09/01/2011'   and sc_fecha_tran <=  '09/30/2011'   and sc_empresa =   1   and sa_cuenta  like '16879500056%'
GO

create view dsaux19879500056                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '09/01/2011'   and sc_fecha_tran <=  '09/30/2011'   and sc_empresa =   1   and sa_cuenta  like '19879500056%'
GO

create view dsaux237618                                        as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '08/01/2011'   and sc_fecha_tran <=  '08/31/2011'   and sc_empresa =   1   and sa_ente = 237618
GO

create view dsaux25450000005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '09/01/2011'   and sc_fecha_tran <=  '09/30/2011'   and sc_empresa =   1   and sa_cuenta  like '25450000005%'
GO

create view dsaux25450500005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '10/01/2011'   and sc_fecha_tran <=  '10/31/2011'   and sc_empresa =   1   and sa_cuenta  like '25450500005%'
GO

create view dsaux25559500015                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '10/01/2011'   and sc_fecha_tran <=  '10/31/2011'   and sc_empresa =   1   and sa_cuenta  like '25559500015%'
GO

create view dsaux25959500071                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '08/01/2011'   and sc_fecha_tran <=  '08/31/2011'   and sc_empresa =   1   and sa_cuenta  like '25959500071%'
GO

create view dsaux27950500005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sa_oficina_dest = 7013   and sc_fecha_tran >=  '08/01/2011'   and sc_fecha_tran <=  '08/31/2011'   and sc_empresa =   1   and sa_cuenta  like '27950500005%'   and sa_ente = 927334
GO

create view dsaux28150500005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '08/30/2011'   and sc_fecha_tran <=  '08/30/2011'   and sc_empresa =   1   and sa_cuenta  like '28150500005%'
GO

create view dsaux28959500006                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sa_oficina_dest = 255   and sc_fecha_tran >=  '11/29/2011'   and sc_fecha_tran <=  '11/30/2011'   and sc_empresa =   1   and sa_cuenta  like '28959500006%'   and sa_ente = 345785
GO

create view dsaux42259500021                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '10/14/2011'   and sc_fecha_tran <=  '10/14/2011'   and sc_empresa =   1   and sa_cuenta  like '42259500021%'   and sa_ente = 996143
GO

create view dsaux51900500005                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sc_fecha_tran >=  '09/01/2011'   and sc_fecha_tran <=  '09/30/2011'   and sc_empresa =   1   and sa_cuenta  like '51900500005%'
GO

create view dsaux51904000900                                   as select  sc_producto, sc_comprobante, sc_fecha_tran, sc_oficina_orig, sc_area_orig, sc_descripcion, sc_tot_debito, sc_tot_credito, sc_mayorizado, sc_comp_definit, sc_tran_modulo, sa_asiento, sa_cuenta, sa_oficina_dest, sa_area_dest, sa_credito, sa_debito, sa_credito_me, sa_debito_me, sa_moneda, sa_ente, sa_tipo_doc = (select en_tipo_ced from cobis..cl_ente where en_ente = sa_ente), sa_ced_ruc = (select en_ced_ruc from cobis..cl_ente where en_ente = sa_ente), sa_nombre = (select en_nomlar from cobis..cl_ente where en_ente = sa_ente), sa_con_rete, sa_base, sa_valret, sa_mayorizado,  sa_debcred,  sa_documento, sa_cheque, sa_doc_banco   from  cob_conta_tercero..ct_scomprobante , cob_conta_tercero..ct_sasiento   where  sc_empresa = sa_empresa  and  sc_producto = sa_producto   and sc_comprobante = sa_comprobante  and sc_fecha_tran = sa_fecha_tran and sc_estado =   'P'   and sa_oficina_dest = 255   and sc_fecha_tran >=  '11/01/2011'   and sc_fecha_tran <=  '11/30/2011'   and sc_empresa =   1   and sa_cuenta  like '51904000900%'
GO

create view movimientos as                        
select  as_comprobante,
		as_asiento,
		as_fecha_tran,
                as_oficina_orig
from cob_conta..cb_asiento,cob_conta..cb_cuenta_proceso,cob_conta..cb_diferidos
where as_fecha_tran = (select fecha  from cob_conta..corte_def)
		and as_comprobante > 0 
		and as_asiento >0
		and as_empresa = 1
		and cp_empresa = as_empresa
		and cp_proceso = 6980
		and cp_cuenta = as_cuenta
		and di_empresa = as_empresa
		and di_comprobante  = as_comprobante
		and di_asiento = as_asiento
		and di_amorti_acum <> di_amorti_saldo

GO

--Adaptive Server has expanded all '*' elements in the following statement
	
create view retencion as          
select cob_conta..cb_retencion.re_comprobante, cob_conta..cb_retencion.re_empresa, cob_conta..cb_retencion.re_asiento, cob_conta..cb_retencion.re_identifica, cob_conta..cb_retencion.re_tipo, cob_conta..cb_retencion.re_ente, cob_conta..cb_retencion.re_fecha, cob_conta..cb_retencion.re_cuenta, cob_conta..cb_retencion.re_concepto, cob_conta..cb_retencion.re_base, cob_conta..cb_retencion.re_valret, cob_conta..cb_retencion.re_valor_asiento, cob_conta..cb_retencion.re_valor_iva, cob_conta..cb_retencion.re_valor_ica, cob_conta..cb_retencion.re_iva_retenido, cob_conta..cb_retencion.re_con_iva, cob_conta..cb_retencion.re_con_iva_reten, cob_conta..cb_retencion.re_con_timbre, cob_conta..cb_retencion.re_valor_timbre, cob_conta..cb_retencion.re_retencion_calculado, cob_conta..cb_retencion.re_iva_calculado, cob_conta..cb_retencion.re_ica_calculado, cob_conta..cb_retencion.re_timbre_calculado, cob_conta..cb_retencion.re_codigo_regimen, cob_conta..cb_retencion.re_con_ica, cob_conta..cb_retencion.re_con_ivapagado, cob_conta..cb_retencion.re_valor_ivapagado, cob_conta..cb_retencion.re_ivapagado_calculado, cob_conta..cb_retencion.re_documento, cob_conta..cb_retencion.re_oficina_orig, cob_conta..cb_retencion.re_con_dptales, cob_conta..cb_retencion.re_valor_dptales 
from cob_conta..cb_retencion
where 	re_empresa = 1
and re_comprobante > 0
and re_asiento > 0
and re_fecha =  (select fecha  from cob_conta..corte_def)

GO

create view [dbo].[syncobj_0x3433443939344144]as select  [iva_empresa],[iva_codigo],[iva_descripcion],[iva_base],[iva_porcentaje],[iva_descontado],[iva_des_porcen],[iva_debcred],[iva_porc_espec]  from  [dbo].[cb_iva]  where permissions(1397580017) & 1 = 1
GO

create view [dbo].[syncobj_0x3732433246344633]as select  [re_filial],[re_empresa],[re_ofadmin],[re_ofconta]  from  [dbo].[cb_relofi]  where permissions(242099903) & 1 = 1 
GO

create view [dbo].[syncobj_0x3838413146313433]as select  [of_empresa],[of_oficina],[of_descripcion],[of_oficina_padre],[of_estado],[of_fecha_estado],[of_organizacion],[of_consolida],[of_movimiento],[of_codigo]  from  [dbo].[cb_oficina]  where permissions(1989582126) & 1 = 1 
GO

create view [dbo].[syncobj_0x4244354233453536]as select  [ec_empresa],[ec_impuesto],[ec_concepto],[ec_debcred],[ec_ciudad],[ec_ofi_orig],[ec_ofi_dest]  from  [dbo].[cb_exencion_ciudad]  where permissions(1157579162) & 1 = 1 
GO

create view [dbo].[syncobj_0x4542463234314146]as select  [rf_codigo],[rf_descripcion],[rf_iva],[rf_timbre],[rf_renta],[rf_ica],[rf_iva_des],[rf_iva_cobrado],[rf_estampillas],[rf_3xm],[rf_estado],[rf_retencion_iva],[rf_naturaleza],[rf_grancontribuyente],[rf_autorretenedor]  from  [dbo].[cb_regimen_fiscal]  where permissions(210099789) & 1 = 1 
GO

create view [dbo].[ts_area] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cod_area,area_padre,descripcion,
	estado,nivel_area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,ts_oficina_padre,
 	ts_descripcion,ts_estado,ts_nivel_cuenta
from   cb_tran_servicio
where  ts_tipo_transaccion = 6511 or
	ts_tipo_transaccion = 6512 or
	ts_tipo_transaccion = 6513


GO

create view ts_asoc_operaciones(
       secuencial,tipo_transaccion,clase,fecha,usuario,terminal,
       oficina,empresa,banco,operacion_ent,operacion_bco,descripcion,operacion)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,ts_terminal,
       ts_oficina,ts_empresa,ts_banco,ts_oper_ent,ts_oper_bco,ts_descripcion,ts_operacion
from   cb_tran_servicio
where  ts_tipo_transaccion = 6244 or
       ts_tipo_transaccion = 6245 or
       ts_tipo_transaccion = 6247

GO

create view [dbo].[ts_asoemp] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa
from   cb_tran_servicio
where  ts_tipo_transaccion = 6261


GO

create view [dbo].[ts_banco] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,banco,nombre,cuenta, operacion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_ctaasoc,ts_descripcion,ts_cuenta, ts_oper_ent
from   cb_tran_servicio
where   ts_tipo_transaccion = 6741 or
	ts_tipo_transaccion = 6742 or
	ts_tipo_transaccion = 6743


GO

create view ts_banco_conci (empresa, secuencial, tipo_transaccion, clase, fecha_tran,usuario,
	terminal,oficina, fecha, banco, cuenta)
as select  ts_empresa,  ts_secuencial, ts_tipo_transaccion, 
          ts_clase, ts_fecha,ts_usuario,  ts_terminal,ts_oficina, ts_fecha_ini,  ts_causa, ts_descripcion_conc
from cb_tran_servicio
where   ts_tipo_transaccion = 6769 or
ts_tipo_transaccion =  6770 or
ts_tipo_transaccion = 6774

GO

create view [dbo].[ts_categoria] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,categoria,nombre,signo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_categoria,ts_descripcion,ts_movimiento
from   cb_tran_servicio
where  ts_tipo_transaccion = 6521 or
	ts_tipo_transaccion = 6522 or
	ts_tipo_transaccion = 6523


GO

/* CBPRODUC */

create view ts_cbproduc(
	secuencial, tipo_transaccion, clase, fecha, usuario,terminal,
	oficina, producto, estado, enlinea, resumen, hoy, empresa
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha, ts_usuario, ts_terminal,
       ts_oficina, ts_nivel_cuenta, ts_estado, ts_movimiento, ts_usa_cc, ts_fecha_ini, ts_empresa

from   cb_tran_servicio
where  ts_tipo_transaccion = 6041 or
       ts_tipo_transaccion = 6042 or
       ts_tipo_transaccion = 6043

GO

create view ts_codigo_valor (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,producto,codval,descripcion
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_moneda,ts_remoto_ssn,ts_descripcion
from   cb_tran_servicio
where   ts_tipo_transaccion > 6941 and
	ts_tipo_transaccion < 6950

GO

create view ts_comp_tipo (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	comp_tipo,empresa,modificable,concepto,oficina_orig,
	area_orig,porcentual,detalles
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_comp_tipo,ts_empresa,ts_movimiento,
	ts_concepto,ts_cod_oficina,ts_area,ts_usa_cc,ts_longitud
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6121 or
	ts_tipo_transaccion = 6122 or
	ts_tipo_transaccion = 6123

GO

create view ts_comprobante (
        secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
        empresa,oficina_dest,comprobante,oficina_orig,departamento,
        fecha_tran,descripcion,comp_tipo,
        detalles,tot_debito,tot_credito,tot_debito_me,tot_credito_me
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
        ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,
        ts_comprobante,ts_oficina_padre,ts_ofic_dest,
        ts_fecha_ini,ts_concepto,ts_comp_tipo,ts_longitud,ts_tot_debito,
        ts_tot_credito,ts_tot_debito_me,ts_tot_credito_me
from   cb_tran_servicio
where  ts_tipo_transaccion = 6342 or
       ts_tipo_transaccion = 6112 or
       ts_tipo_transaccion = 6113

GO

create view ts_conc_retencion (
        empresa,			/* JCG10 */
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion, base, porcentaje,
	debcred, tipo			/* JCG10 */
)
as select ts_empresa,			/* JCG10 */ 
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_base_conc, ts_porcentaje_conc,
	  ts_control, ts_origen		/* JCG10 */
from   cb_tran_servicio
where  ts_tipo_transaccion = 6954 or
       ts_tipo_transaccion = 6955 or
       ts_tipo_transaccion = 6956 or
       ts_tipo_transaccion = 6957 or
       ts_tipo_transaccion = 6958 or
       ts_tipo_transaccion = 6580 or
       ts_tipo_transaccion = 6587 or
       ts_tipo_transaccion = 6959

GO

create view ts_concepto_conci (empresa, secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina, concepto, descripcion, operacion, banco)
as select ts_empresa,  ts_secuencial, ts_tipo_transaccion, 
          ts_clase, ts_fecha,ts_usuario,  ts_terminal,ts_oficina,
          ts_categoria, ts_descripcion, ts_movimiento, ts_origen 
from cb_tran_servicio
where   ts_tipo_transaccion = 6829 or
ts_tipo_transaccion = 6830 or
ts_tipo_transaccion = 6831

GO

create view [dbo].[ts_concica] (
        empresa,			/* JCG10 */
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion, base, porcentaje, ciudad,
	debcred				/* JCG10 */
)
as select ts_empresa,			/* JCG10 */ 
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_base_conc, ts_porcentaje_conc, ts_ciudad_ica,
	  ts_control			/* JCG10 */
from   cb_tran_servicio
where   ts_tipo_transaccion > 6968 and
        ts_tipo_transaccion < 6971


GO

create view ts_concil_operaciones(
       secuencial,tipo_transaccion,clase,fecha,usuario,
       terminal,oficina,empresa,operacion_bco,campo)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_empresa,ts_oper_bco,ts_oper_ent
from   cb_tran_servicio
where  ts_tipo_transaccion = 6757 or
       ts_tipo_transaccion = 6758

GO

CREATE VIEW [dbo].[ts_conciva] (
empresa,			
secuencial, tipo_transaccion, clase, fecha,usuario,
terminal,oficina,
codigo, descripcion, base, porcentaje, 
descontado, des_porcen,
debcred, porc_espec		
)
as select ts_empresa,			
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_base_conc, ts_porcentaje_conc,
	  ts_descontado, ts_des_porcen,
	  ts_control, ts_porc_espec	
from   cb_tran_servicio
where   ts_tipo_transaccion >= 6964 and
	ts_tipo_transaccion < 6967


GO

create view [dbo].[ts_concivapagado] (
        empresa,			 
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion, porcentaje, 
	debcred				
)
as select ts_empresa,			 
	  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_codigo_conc, ts_descripcion_conc, ts_porcentaje_conc,
	  ts_control			
from   cb_tran_servicio
where   ts_tipo_transaccion > 6288 and
	ts_tipo_transaccion < 6294


GO

create view ts_consolid (
	secuencial, tipo_transaccion, clase, fecha, usuario,terminal,
	oficina,empresa_cons,empresa_sub,cuenta_cons, cuenta_sub
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa, ts_empresa_subsidiaria, ts_cuenta,
    	ts_ctaasoc
from   cb_tran_servicio
where  ts_tipo_transaccion = 6798 or
       ts_tipo_transaccion = 6740

GO

create view [dbo].[ts_control] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,login,ofic,area,tipo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
      ts_terminal,ts_oficina,ts_empresa,ts_login,ts_ofic_orig,ts_area,ts_estado
from   cb_tran_servicio
where  ts_tipo_transaccion = 6731 or
	ts_tipo_transaccion = 6733


GO

create view [dbo].[ts_corte] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	corte,periodo,empresa,fecha_ini,fecha_fin,tipo  
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_corte,ts_periodo,ts_empresa,ts_fecha_ini,
	ts_fecha_fin,ts_estado
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6101 or
	ts_tipo_transaccion = 6102 or
	ts_tipo_transaccion = 6103


GO

create view [dbo].[ts_cotizacion] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	fecha_cotz,moneda,valor,compra,venta                 
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_fecha_ini,ts_moneda,ts_tot_debito,
	ts_tot_debito_me,ts_tot_credito_me
from   cb_tran_servicio
where  ts_tipo_transaccion = 6141 or
	ts_tipo_transaccion = 6142 or
	ts_tipo_transaccion = 6143


GO

/* FS001 */
create view ts_cuenta (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,descripcion,estado,movimiento,categoria,acceso,
	presupuesto
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
	ts_movimiento,ts_categoria,ts_causa,ts_presupuesto
from   cb_tran_servicio
where  ts_tipo_transaccion = 6011 or
	ts_tipo_transaccion = 6012 or
	ts_tipo_transaccion = 6013

GO

create view [dbo].[ts_cuenta_asociada] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	cod_oficina,empresa,proceso,cuenta,oficina,numero,
	cta_asoc,condicion,debcred
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_proceso,ts_cuenta,
	ts_cod_oficina,ts_ofic_orig,ts_ctaasoc,ts_area,
	ts_movimiento
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6231 or
	ts_tipo_transaccion = 6232 or
	ts_tipo_transaccion = 6233


GO

create view ts_cuenta_departamento (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cuenta,departamento
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_departamento 
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6251 or
	ts_tipo_transaccion = 6253

GO

create view ts_cuenta_presupuesto (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,descripcion,estado,movimiento,categoria
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_descripcion,ts_estado,
	ts_movimiento,ts_categoria
from   cb_tran_servicio
where  ts_tipo_transaccion = 6561 or
	ts_tipo_transaccion = 6562 or
	ts_tipo_transaccion = 6563

GO

create view [dbo].[ts_cuenta_proceso] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	cod_oficina,empresa,proceso,cuenta,oficina,texto,condicion,imprime
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_proceso,ts_cuenta,
	ts_cod_oficina,ts_descripcion,ts_causa,ts_estado
from   cb_tran_servicio
where  ts_tipo_transaccion = 6221 or
	ts_tipo_transaccion = 6222 or
	ts_tipo_transaccion = 6223


GO

create view ts_departamento (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,departamento,departamento_padre,
	descripcion,nivel
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,
	ts_departamento,ts_oficina_padre,ts_descripcion,ts_nivel_cuenta
from   cb_tran_servicio
where  ts_tipo_transaccion = 6191 or
	ts_tipo_transaccion = 6192 or
	ts_tipo_transaccion = 6193

GO

create view ts_depurado as select * from cob_conta..cb_depurar where cbd_fecha_depura >= 'Jul 20 2010  9:26AM'
GO

create view ts_det_perfil (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,producto,perfil,asiento,cuenta,debcred,
        codval,tipo_tran,origen_dest,constante
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_moneda,ts_ruc,ts_area,
        ts_cuenta,ts_movimiento,ts_longitud,ts_tipo_doc,ts_estado,ts_causa
from   cb_tran_servicio
where   ts_tipo_transaccion > 6911 and
	ts_tipo_transaccion < 6920

GO

create view ts_diferido (
        secuencial, tipo_transaccion, clase, fecha,usuario,
        terminal,oficina,
	fecha_reg,fecha_ini,fecha_fin,comprob,valor_dif,amort_acum,control
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
          ts_terminal,ts_oficina,
	  ts_fecha_reg,ts_fecha_ini,ts_fecha_fin,
 	  ts_comprobante,ts_valor_dif,ts_amort_acum,ts_control

from   cb_tran_servicio
where   ts_tipo_transaccion = 6611 or
        ts_tipo_transaccion = 6756

GO

create view ts_diferidos (empresa, secuencial, tipo_transaccion, clase, fecha_tran, usuario,
	terminal,oficina, comprobante, fecha_reg,  oficina_orig, descripcion, valor_dif, fecha_inicio, 
        fecha_final, saldo_dias, dias_base, concepto, dias_amortizados, amorti_acum, amorti_saldo, 
        valor_mes_sig, valor_dia, control, estado, ajus_infl, depr_mes, asiento, ajus_infl_deprec, oficina_conta)
as select ts_empresa,  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,  
        ts_terminal,ts_oficina, ts_comprobante, ts_fecha_reg, ts_cod_oficina, ts_descripcion, ts_valor_dif, ts_fecha_ini, 
        ts_fecha_fin,  ts_numero_actual, ts_longitud, ts_tipo_doc, ts_oficina_padre,  ts_tot_debito,  ts_tot_credito,
        ts_tot_debito_me, ts_amort_acum, ts_origen,  ts_estado, ts_retencion, ts_base_conc,  ts_proceso,  ts_base,  ts_area
from cb_tran_servicio
where   ts_tipo_transaccion = 6617

GO

create view [dbo].[ts_dinamica] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cuenta,siguiente,tipo_dinamica,texto,
	disp_legal
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,
	ts_numero_actual,ts_estado,ts_concepto,ts_descripcion
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6201 or
	ts_tipo_transaccion = 6202 or
	ts_tipo_transaccion = 6203


GO

create view ts_documento_empresa (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,tipo_doc,numero_actual
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_tipo_doc,ts_numero_actual
from   cb_tran_servicio
where  ts_tipo_transaccion = 608

GO

create view [dbo].[ts_empresa] (
	secuencial,     tipo_transaccion,        clase,        fecha,
        usuario,        terminal,                oficina,      empresa,
        ruc,            descripcion,             replegal,     contgen,
        moneda,         direccion,               empresarev,   nitrev, 
        matrevisoria
)
as
select  ts_secuencial,  ts_tipo_transaccion,     ts_clase,            ts_fecha,
        ts_usuario,    	ts_terminal,             ts_oficina,          ts_empresa,   
        ts_ruc,         ts_descripcion,          ts_replegal,         ts_contgen,     
        ts_moneda,      ts_direccion,            ts_descripcion_conc, ts_cuenta,
        ts_categoria
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6031 or
	ts_tipo_transaccion = 6032 or
	ts_tipo_transaccion = 6033


GO

create view ts_estcta (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,banco,fecha_est,saldo_ini,saldo_fin
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_ctaasoc,ts_fecha_ini,
	ts_tot_debito,ts_tot_credito
from   cb_tran_servicio
where   ts_tipo_transaccion = 6771 or
	ts_tipo_transaccion = 6772 or
	ts_tipo_transaccion = 6773

GO

create view ts_exenciu (
	secuencial, tipo_transaccion, clase, fecha, usuario,terminal,
	oficina,empresa, impuesto, concepto, debcred, ciudad,
        apl_ofi_orig, apl_ofi_dest
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_empresa, ts_impuesto, ts_usa_cc, ts_concepto, ts_ciudad_ica,
       ts_apl_ofi_orig, ts_apl_ofi_dest

from   cb_tran_servicio
where  ts_tipo_transaccion = 6249 or
       ts_tipo_transaccion = 6248

GO

create view ts_exenpro (
	secuencial, tipo_transaccion, clase, fecha, usuario,terminal,
	oficina,empresa, regimen, producto, impuesto, concepto
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_empresa, ts_regimen, ts_producto,
       ts_impuesto, ts_concepto

from   cb_tran_servicio
where  ts_tipo_transaccion = 6259 or
	ts_tipo_transaccion = 6258

GO

CREATE VIEW ts_grupo_gastos 
     (secuencial,       tipo_transaccion,     clase,   
      fecha,            usuario,              terminal,   
      oficina,          codigo,               descripcion, 
      clasificacion
     )
AS SELECT 
      ts_secuencial,    ts_tipo_transaccion,  ts_clase,
      ts_fecha,         ts_usuario,           ts_terminal,
      ts_oficina,       ts_concepto,          ts_descripcion,
      ts_categoria
FROM  cb_tran_servicio
WHERE ts_tipo_transaccion BETWEEN 6190 AND 6193

GO

create view ts_impdept (
        empresa,			 
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	codigo, descripcion,  base_ini, base_fin,  porcentaje,  
	debcred, depto				
)
as select ts_empresa,  ts_secuencial, ts_tipo_transaccion, 
          ts_clase, ts_fecha,ts_usuario,  ts_terminal,ts_oficina,
	  ts_categoria, ts_concepto, ts_base,  ts_base_conc, ts_porcentaje_conc,
	  ts_control, ts_departamento		
from   cb_tran_servicio
where   ts_tipo_transaccion =  6252 or
	ts_tipo_transaccion = 6253 or
	ts_tipo_transaccion = 6254

GO

create view ts_impuestos (
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina, iva, retencion, ica, descontado
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,ts_iva, ts_ret, ts_ica, ts_descontado
from   cb_tran_servicio
where   ts_tipo_transaccion > 6960 and
	ts_tipo_transaccion < 6963

GO

create view ts_item (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,item,nombre
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_longitud,ts_contgen
from   cb_tran_servicio
where   ts_tipo_transaccion = 6791 or
	ts_tipo_transaccion = 6792 or
	ts_tipo_transaccion = 6793

GO

create view [dbo].[ts_nivel_area] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,nivel,descripcion
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6501 or
	ts_tipo_transaccion = 6502 or
	ts_tipo_transaccion = 6503


GO

create view [dbo].[ts_nivel_cuenta] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,nivel_cuenta,descripcion,longitud
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion,
	ts_longitud
from   cb_tran_servicio
where  ts_tipo_transaccion = 6021 or
	ts_tipo_transaccion = 6022 or
	ts_tipo_transaccion = 6023


GO

create view ts_nivel_presupuesto (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,nivel_cuenta,descripcion,longitud
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion,
	ts_longitud
from   cb_tran_servicio
where  ts_tipo_transaccion = 6541 or
	ts_tipo_transaccion = 6542 or
	ts_tipo_transaccion = 6543

GO

create view [dbo].[ts_oficina] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cod_oficina,oficina_padre,descripcion,
	estado,organizacion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,ts_oficina_padre,
 	ts_descripcion,ts_estado,ts_nivel_cuenta
from   cb_tran_servicio
where  ts_tipo_transaccion = 6151 or
	ts_tipo_transaccion = 6152 or
	ts_tipo_transaccion = 6153


GO

create view ts_oficina_departamento (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,empresa,cod_oficina,departamento,num_actual
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina,ts_departamento,
 	ts_comprobante
from   cb_tran_servicio
where  ts_tipo_transaccion = 6241 or
	ts_tipo_transaccion = 6242 or
	ts_tipo_transaccion = 6243

GO

create view ts_opc_item (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,opcion,debcred,item
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_longitud,ts_movimiento,ts_moneda
from   cb_tran_servicio
where   ts_tipo_transaccion = 6801 or
	ts_tipo_transaccion = 6803

GO

create view ts_opcion (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,opcion,debcred,nombre
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_longitud,ts_movimiento,
	ts_contgen
from   cb_tran_servicio
where   ts_tipo_transaccion = 6781 or
	ts_tipo_transaccion = 6782 or
	ts_tipo_transaccion = 6783

GO

create view [dbo].[ts_organizacion]  (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,organizacion,descripcion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_nivel_cuenta,ts_descripcion 
from   cb_tran_servicio
where  	ts_tipo_transaccion = 6051 or
	ts_tipo_transaccion = 6052 or
	ts_tipo_transaccion = 6053


GO

CREATE VIEW ts_parametrizacion_grupos
     (secuencial,       tipo_transaccion,     clase,   
      fecha,            usuario,              terminal,   
      oficina,          codigo,               cuenta, 
      signo,            porcentaje,           calculo
     )
AS SELECT 
      ts_secuencial,    ts_tipo_transaccion,  ts_clase,
      ts_fecha,         ts_usuario,           ts_terminal,
      ts_oficina,       ts_concepto,          ts_cuenta,
      ts_categoria,     ts_porc_espec ,       ts_numero_actual
FROM  cb_tran_servicio
WHERE ts_tipo_transaccion BETWEEN 6194 AND 6197

GO

create view ts_parametro (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,parametro,descripcion,stored,transaccion
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_descripcion,ts_categoria,ts_proceso
from   cb_tran_servicio
where   ts_tipo_transaccion > 6921 and
	ts_tipo_transaccion < 6930

GO

create view ts_perfil (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,producto,perfil,descripcion
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_moneda,ts_cuenta,ts_descripcion
from   cb_tran_servicio
where   ts_tipo_transaccion > 6901 and
	ts_tipo_transaccion < 6910

GO

create view ts_periodo (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	periodo,empresa,fecha_ini,fecha_fin,estado,tipo
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_periodo,ts_empresa,ts_fecha_ini,
	ts_fecha_fin,ts_estado,ts_tipo_doc
from   cb_tran_servicio
where  ts_tipo_transaccion = 6091 or
	ts_tipo_transaccion = 6092 or
	ts_tipo_transaccion = 6093

GO

create view [dbo].[ts_plan_general] (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,cod_oficina,area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_cod_oficina,ts_area
from   cb_tran_servicio
where  ts_tipo_transaccion = 6071 or
	ts_tipo_transaccion = 6072 or
	ts_tipo_transaccion = 6073


GO

create view ts_plan_general_presupuesto (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta_presu,cuenta,oficina_plan,area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,ts_ctaasoc,
	ts_ofic_orig,ts_area
from   cb_tran_servicio
where  ts_tipo_transaccion = 6591 or
	ts_tipo_transaccion = 6592 or
	ts_tipo_transaccion = 6593

GO

/* RELAREA */


create view ts_relarea(
	secuencial, tipo_transaccion, clase, fecha, usuario,terminal,
	oficina,filial, empresa, gerente, area
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_empresa_subsidiaria, ts_empresa, 
       ts_cod_oficina, ts_ciudad_ica

from   cb_tran_servicio
where  ts_tipo_transaccion = 6847 or
       ts_tipo_transaccion = 6848

GO

create view [dbo].[ts_relofi] (
        secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
        empresa,ofic
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
        ts_terminal,ts_oficina,ts_empresa,ts_ofic_orig
from   cb_tran_servicio
where  ts_tipo_transaccion = 6843 or
       ts_tipo_transaccion = 6844


GO

create view ts_relparam (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,parametro,clave,substring
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_ruc,ts_cuenta,ts_categoria
from   cb_tran_servicio
where   ts_tipo_transaccion > 6931 and
	ts_tipo_transaccion < 6940

GO

create view ts_retencion (
	secuencial, tipo_transaccion, clase, fecha,usuario,
	terminal,oficina,
	empresa, comprobante, asiento, concepto, 
	base, retencion, cuenta
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	  ts_terminal,ts_oficina,
	  ts_empresa, ts_comprobante, ts_asiento,ts_concepto, 
	  ts_base, ts_retencion, ts_cuenta_terc
from   cb_tran_servicio
where   ts_tipo_transaccion > 6129 and
	ts_tipo_transaccion < 6136

GO

create view ts_saldo_presupuesto (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,cuenta,oficina_pre,area,presupuesto,real
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cuenta,
	ts_ofic_orig,ts_area,ts_tot_debito,ts_tot_credito
from   cb_tran_servicio
where  ts_tipo_transaccion = 6601 or
	ts_tipo_transaccion = 6602 or
	ts_tipo_transaccion = 6603

GO

create view ts_seguridad (
	secuencial, tipo_transaccion, clase, fecha, usuario,
	terminal, oficina, empresa, cuenta, cod_oficina, area
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha, ts_usuario,
	  ts_terminal, ts_oficina, ts_empresa, ts_cuenta, ts_cod_oficina, ts_area
from   cb_tran_servicio
where   ts_tipo_transaccion = 6736 or
        ts_tipo_transaccion = 6737

GO

create view ts_tipo_area (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,oficina,
	empresa,producto,tiparea,descripcion
)
as select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_moneda,ts_login,ts_descripcion
from   cb_tran_servicio
where   ts_tipo_transaccion > 6891 and
	ts_tipo_transaccion < 6890

GO

create view ts_tipo_documento (
	secuencial, tipo_transaccion, clase, fecha,usuario,terminal,
	oficina,tipo_doc,nombre,estado
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_categoria,ts_descripcion,ts_movimiento
from   cb_tran_servicio
where  ts_tipo_transaccion = 6551 or
	ts_tipo_transaccion = 6552 or
	ts_tipo_transaccion = 6553

GO

create view ts_tran_interfase (
	secuencial,tipo_transaccion,clase,fecha,usuario,terminal,
	oficina,empresa,producto,moneda,tipo_tran,causa,ofic_orig,
	ofic_dest,ctadeb,ctacre,ctadeb_int,ctacre_int,ctadeb_des,
	ctacre_des,descripcion)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,ts_usuario,
       ts_terminal,ts_oficina,ts_empresa,ts_longitud,ts_moneda,
       ts_tipo_tran,ts_causa,ts_ofic_orig,ts_ofic_dest,
       ts_ctadeb,ts_ctacre,ts_ctadeb_int,ts_ctacre_int,
       ts_ctadeb_des,ts_ctacre_des,ts_contgen

from   cb_tran_servicio
where  ts_tipo_transaccion = 6401 or
       ts_tipo_transaccion = 6403 or
       ts_tipo_transaccion = 6405 or
       ts_tipo_transaccion = 6406

GO

create view ts_tran_serv_pag_decl (
	ts_secuencial, ts_tipo_tran, ts_clase, ts_fecha,ts_usuario,ts_terminal,ts_oficina,
	ts_empresa,ts_oficina_tran, ts_cod_declaracion,	ts_fecha_orden,	ts_fecha_corte	
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,ts_usuario,
    	ts_terminal,ts_oficina,ts_empresa,ts_cod_oficina, ts_ciudad_ica, ts_fecha_ini, ts_fecha_fin
from   cb_tran_servicio
where   ts_tipo_transaccion = 6315 or
	ts_tipo_transaccion = 6316 or
	ts_tipo_transaccion = 6317


GO

create view v_cb_inmovpro
as select in_cuenta, in_nombre_cta, in_fecha_tran, in_area_destino, 
          in_oficina_destino,  in_comp_definit, in_oficina_ori, in_area_ori, 
          in_nit, in_tercero, in_concepto, in_cod_concepto, in_saldo_ini,  
          in_mov_deb, in_mov_cred, (in_mov_deb - in_mov_cred) neto, in_saldo_final, in_asiento, in_empresa          
        from cb_inmovpro

GO

create view vw_cabecera as select * from cob_conta_super..sb_condonacion_aho where ca_fecha = 'Nov  9 2015 12:00AM'
GO

