USE cob_cartera_his
GO

IF OBJECT_ID ('dbo.ca_abono') IS NOT NULL
	DROP TABLE dbo.ca_abono
GO

CREATE TABLE dbo.ca_abono
	(
	ab_secuencial_ing          INT NOT NULL,
	ab_secuencial_rpa          INT NOT NULL,
	ab_secuencial_pag          INT NOT NULL,
	ab_operacion               INT NOT NULL,
	ab_fecha_ing               DATETIME NOT NULL,
	ab_fecha_pag               DATETIME NOT NULL,
	ab_cuota_completa          CHAR (1) NOT NULL,
	ab_aceptar_anticipos       CHAR (1) NOT NULL,
	ab_tipo_reduccion          CHAR (1) NOT NULL,
	ab_tipo_cobro              CHAR (1) NOT NULL,
	ab_dias_retencion_ini      INT NOT NULL,
	ab_dias_retencion          INT NOT NULL,
	ab_estado                  CHAR (3) NOT NULL,
	ab_usuario                 VARCHAR (14) NOT NULL,
	ab_oficina                 SMALLINT NOT NULL,
	ab_terminal                VARCHAR (64) NOT NULL,
	ab_tipo                    CHAR (3) NOT NULL,
	ab_tipo_aplicacion         CHAR (1) NOT NULL,
	ab_nro_recibo              INT NOT NULL,
	ab_tasa_prepago            FLOAT,
	ab_dividendo               SMALLINT,
	ab_calcula_devolucion      CHAR (1),
	ab_prepago_desde_lavigente CHAR (1),
	ab_extraordinario          CHAR (1)
	)
GO

CREATE UNIQUE INDEX ca_abono_1
	ON dbo.ca_abono (ab_operacion, ab_secuencial_ing)
GO

CREATE INDEX ca_abono_2
	ON dbo.ca_abono (ab_secuencial_rpa)
GO

CREATE INDEX ca_abono_3
	ON dbo.ca_abono (ab_secuencial_pag)
GO


IF OBJECT_ID ('dbo.ca_abono_det') IS NOT NULL
	DROP TABLE dbo.ca_abono_det
GO

CREATE TABLE dbo.ca_abono_det
	(
	abd_secuencial_ing  INT NOT NULL,
	abd_operacion       INT NOT NULL,
	abd_tipo            CHAR (3) NOT NULL,
	abd_concepto        CHAR (10) NOT NULL,
	abd_cuenta          CHAR (24) NOT NULL,
	abd_beneficiario    CHAR (50) NOT NULL,
	abd_moneda          TINYINT NOT NULL,
	abd_monto_mpg       MONEY NOT NULL,
	abd_monto_mop       MONEY NOT NULL,
	abd_monto_mn        MONEY NOT NULL,
	abd_cotizacion_mpg  MONEY NOT NULL,
	abd_cotizacion_mop  MONEY NOT NULL,
	abd_tcotizacion_mpg CHAR (1) NOT NULL,
	abd_tcotizacion_mop CHAR (1) NOT NULL,
	abd_cheque          INT,
	abd_cod_banco       CHAR (10),
	abd_inscripcion     INT,
	abd_carga           INT
	)
GO

CREATE UNIQUE INDEX ca_abono_det_1
	ON dbo.ca_abono_det (abd_operacion, abd_secuencial_ing, abd_tipo, abd_concepto)
GO


IF OBJECT_ID ('dbo.ca_abono_det_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_det_his
GO

CREATE TABLE dbo.ca_abono_det_his
	(
	abd_secuencial_ing  INT NOT NULL,
	abd_operacion       INT NOT NULL,
	abd_tipo            CHAR (3) NOT NULL,
	abd_concepto        CHAR (10) NOT NULL,
	abd_cuenta          CHAR (24) NOT NULL,
	abd_beneficiario    CHAR (50) NOT NULL,
	abd_moneda          TINYINT NOT NULL,
	abd_monto_mpg       MONEY NOT NULL,
	abd_monto_mop       MONEY NOT NULL,
	abd_monto_mn        MONEY NOT NULL,
	abd_cotizacion_mpg  MONEY NOT NULL,
	abd_cotizacion_mop  MONEY NOT NULL,
	abd_tcotizacion_mpg CHAR (1) NOT NULL,
	abd_tcotizacion_mop CHAR (1) NOT NULL,
	abd_cheque          INT,
	abd_cod_banco       CHAR (10),
	abd_inscripcion     INT,
	abd_carga           INT
	)
GO


IF OBJECT_ID ('dbo.ca_abono_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_his
GO

CREATE TABLE dbo.ca_abono_his
	(
	ab_secuencial_ing          INT NOT NULL,
	ab_secuencial_rpa          INT NOT NULL,
	ab_secuencial_pag          INT NOT NULL,
	ab_operacion               INT NOT NULL,
	ab_fecha_ing               DATETIME NOT NULL,
	ab_fecha_pag               DATETIME NOT NULL,
	ab_cuota_completa          CHAR (1) NOT NULL,
	ab_aceptar_anticipos       CHAR (1) NOT NULL,
	ab_tipo_reduccion          CHAR (1) NOT NULL,
	ab_tipo_cobro              CHAR (1) NOT NULL,
	ab_dias_retencion_ini      INT NOT NULL,
	ab_dias_retencion          INT NOT NULL,
	ab_estado                  CHAR (3) NOT NULL,
	ab_usuario                 VARCHAR (14) NOT NULL,
	ab_oficina                 SMALLINT NOT NULL,
	ab_terminal                VARCHAR (64) NOT NULL,
	ab_tipo                    CHAR (3) NOT NULL,
	ab_tipo_aplicacion         CHAR (1) NOT NULL,
	ab_nro_recibo              INT NOT NULL,
	ab_tasa_prepago            FLOAT,
	ab_dividendo               SMALLINT,
	ab_calcula_devolucion      CHAR (1),
	ab_prepago_desde_lavigente CHAR (1),
	ab_extraordinario          CHAR (1)
	)
GO


IF OBJECT_ID ('dbo.ca_abono_rubro') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro
GO

CREATE TABLE dbo.ca_abono_rubro
	(
	ar_fecha_pag    DATETIME NOT NULL,
	ar_secuencial   INT NOT NULL,
	ar_operacion    INT NOT NULL,
	ar_dividendo    INT NOT NULL,
	ar_concepto     CHAR (10) NOT NULL,
	ar_estado       TINYINT NOT NULL,
	ar_monto        MONEY NOT NULL,
	ar_monto_mn     MONEY NOT NULL,
	ar_moneda       TINYINT NOT NULL,
	ar_cotizacion   FLOAT NOT NULL,
	ar_afectacion   CHAR (1) NOT NULL,
	ar_tasa_pago    FLOAT,
	ar_dias_pagados INT
	)
GO

CREATE INDEX ca_abono_rubro_1
	ON dbo.ca_abono_rubro (ar_operacion, ar_secuencial)
GO


IF OBJECT_ID ('dbo.ca_abono_rubro_his') IS NOT NULL
	DROP TABLE dbo.ca_abono_rubro_his
GO

CREATE TABLE dbo.ca_abono_rubro_his
	(
	ar_fecha_pag    DATETIME NOT NULL,
	ar_secuencial   INT NOT NULL,
	ar_operacion    INT NOT NULL,
	ar_dividendo    INT NOT NULL,
	ar_concepto     CHAR (10) NOT NULL,
	ar_estado       TINYINT NOT NULL,
	ar_monto        MONEY NOT NULL,
	ar_monto_mn     MONEY NOT NULL,
	ar_moneda       TINYINT NOT NULL,
	ar_cotizacion   FLOAT NOT NULL,
	ar_afectacion   CHAR (1) NOT NULL,
	ar_tasa_pago    FLOAT,
	ar_dias_pagados INT
	)
GO


IF OBJECT_ID ('dbo.ca_abonos_masivos_his') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his
GO

CREATE TABLE dbo.ca_abonos_masivos_his
	(
	amh_lote        INT NOT NULL,
	amh_empresa     INT NOT NULL,
	amh_fecha_ing   DATETIME NOT NULL,
	amh_valor_total MONEY NOT NULL,
	amh_estado      catalogo NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_abonos_masivos_his_d') IS NOT NULL
	DROP TABLE dbo.ca_abonos_masivos_his_d
GO

CREATE TABLE dbo.ca_abonos_masivos_his_d
	(
	amhd_lote      INT NOT NULL,
	amhd_banco     cuenta NOT NULL,
	amhd_valor_pag MONEY NOT NULL,
	amhd_fecha_ing DATETIME NOT NULL,
	amhd_fecha_mod DATETIME NOT NULL,
	amhd_usuario   login NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_acciones_his') IS NOT NULL
	DROP TABLE dbo.ca_acciones_his
GO

CREATE TABLE dbo.ca_acciones_his
	(
	ach_secuencial_his INT NOT NULL,
	ach_operacion      INT NOT NULL,
	ach_div_ini        INT NOT NULL,
	ach_div_fin        INT NOT NULL,
	ach_rubro          catalogo NOT NULL,
	ach_valor          MONEY,
	ach_porcentaje     FLOAT,
	ach_divf_ini       INT NOT NULL,
	ach_divf_fin       INT NOT NULL,
	ach_rubrof         catalogo NOT NULL,
	ach_secuencial     INT NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_amortizacion') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion
GO

CREATE TABLE dbo.ca_amortizacion
	(
	am_operacion INT NOT NULL,
	am_dividendo SMALLINT NOT NULL,
	am_concepto  CHAR (10) NOT NULL,
	am_estado    TINYINT NOT NULL,
	am_periodo   TINYINT NOT NULL,
	am_cuota     MONEY NOT NULL,
	am_gracia    MONEY NOT NULL,
	am_pagado    MONEY NOT NULL,
	am_acumulado MONEY NOT NULL,
	am_secuencia TINYINT NOT NULL
	)
GO

CREATE UNIQUE INDEX ca_amortizacion_1
	ON dbo.ca_amortizacion (am_operacion, am_dividendo, am_concepto, am_secuencia)
GO


IF OBJECT_ID ('dbo.ca_amortizacion_ant_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_ant_his
GO

CREATE TABLE dbo.ca_amortizacion_ant_his
	(
	anh_secuencial       INT NOT NULL,
	anh_operacion        INT NOT NULL,
	anh_dividendo        SMALLINT NOT NULL,
	anh_estado           TINYINT NOT NULL,
	anh_dias_pagados     INT NOT NULL,
	anh_valor_pagado     MONEY NOT NULL,
	anh_dias_amortizados INT NOT NULL,
	anh_valor_amortizado MONEY NOT NULL,
	anh_fecha_pago       DATETIME NOT NULL,
	anh_tasa_dia         FLOAT NOT NULL,
	anh_secuencia        INT NOT NULL,
	anh_secuencial_his   INT
	)
GO


IF OBJECT_ID ('dbo.ca_amortizacion_his') IS NOT NULL
	DROP TABLE dbo.ca_amortizacion_his
GO

CREATE TABLE dbo.ca_amortizacion_his
    (
    amh_secuencial INT NOT NULL,
    amh_operacion  INT NOT NULL,
    amh_dividendo  SMALLINT NOT NULL,
    amh_concepto   catalogo NOT NULL,
    amh_estado     TINYINT NOT NULL,
    amh_periodo    TINYINT NOT NULL,
    amh_cuota      MONEY NOT NULL,
    amh_gracia     MONEY NOT NULL,
    amh_pagado     MONEY NOT NULL,
    amh_acumulado  MONEY NOT NULL,
    amh_secuencia  TINYINT NOT NULL
    )
GO

create index ca_amortizacion_his_1
    on dbo.ca_amortizacion_his (amh_operacion, amh_secuencial)
go

IF OBJECT_ID ('dbo.ca_conci_dia_findeter_his') IS NOT NULL
	DROP TABLE dbo.ca_conci_dia_findeter_his
GO

CREATE TABLE dbo.ca_conci_dia_findeter_his
	(
	cfh_fecha_proceso     DATETIME,
	cfh_num_oper_cobis    cuenta,
	cfh_num_oper_findeter cuenta,
	cfh_beneficiario      CHAR (30),
	cfh_departamento      CHAR (20),
	cfh_pagare            CHAR (64),
	cfh_saldo_capital     MONEY,
	cfh_valor_capital     MONEY,
	cfh_fecha_desde       DATETIME,
	cfh_fecha_hasta       DATETIME,
	cfh_dias              INT,
	cfh_modalida_pago     CHAR (5),
	cfh_tasa_redes        CHAR (20),
	cfh_tasa              FLOAT,
	cfh_valor_interes     MONEY,
	cfh_neto_pagar        MONEY,
	cfh_marcar_diff       CHAR (1),
	cfh_no_conciliada     CHAR (1)
	)
GO


IF OBJECT_ID ('dbo.ca_correccion') IS NOT NULL
	DROP TABLE dbo.ca_correccion
GO

CREATE TABLE dbo.ca_correccion
	(
	co_operacion         INT NOT NULL,
	co_dividendo         SMALLINT NOT NULL,
	co_concepto          CHAR (10) NOT NULL,
	co_correccion_mn     MONEY,
	co_correccion_sus_mn MONEY,
	co_correc_pag_sus_mn MONEY,
	co_liquida_mn        MONEY
	)
GO


IF OBJECT_ID ('dbo.ca_correccion_his') IS NOT NULL
	DROP TABLE dbo.ca_correccion_his
GO

CREATE TABLE dbo.ca_correccion_his
    (
    coh_secuencial        INT NOT NULL,
    coh_operacion         INT NOT NULL,
    coh_dividendo         SMALLINT NOT NULL,
    coh_concepto          catalogo NOT NULL,
    coh_correccion_mn     MONEY,
    coh_correccion_sus_mn MONEY,
    coh_correc_pag_sus_mn MONEY,
    coh_liquida_mn        MONEY
    )
GO
create index ca_co_op_his
    on dbo.ca_correccion_his (coh_operacion, coh_secuencial, coh_concepto)
go
----

IF OBJECT_ID ('dbo.ca_cuota_adicional') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional
GO

CREATE TABLE dbo.ca_cuota_adicional
	(
	ca_operacion INT NOT NULL,
	ca_dividendo SMALLINT NOT NULL,
	ca_cuota     MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_cuota_adicional_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_adicional_his
GO

CREATE TABLE dbo.ca_cuota_adicional_his
	(
	cah_secuencial INT NOT NULL,
	cah_operacion  INT NOT NULL,
	cah_dividendo  SMALLINT NOT NULL,
	cah_cuota      MONEY NOT NULL
	)
GO

create index ca_cuota_adicional_his_1
    on dbo.ca_cuota_adicional_his (cah_operacion, cah_secuencial)
go

IF OBJECT_ID ('dbo.ca_cuota_diff') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff
GO

CREATE TABLE dbo.ca_cuota_diff
	(
	cd_operacion INT NOT NULL,
	cd_dividendo SMALLINT NOT NULL,
	cd_cuota     MONEY NOT NULL,
	cd_acumulado MONEY NOT NULL,
	cd_val_redes MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_cuota_diff_his') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_his
GO

CREATE TABLE dbo.ca_cuota_diff_his
	(
	cdh_secuencial INT NOT NULL,
	cdh_operacion  INT NOT NULL,
	cdh_dividendo  SMALLINT NOT NULL,
	cdh_cuota      MONEY NOT NULL,
	cdh_acumulado  MONEY NOT NULL,
	cdh_val_redes  MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_cuota_diff_tmp') IS NOT NULL
	DROP TABLE dbo.ca_cuota_diff_tmp
GO

CREATE TABLE dbo.ca_cuota_diff_tmp
	(
	cdt_operacion INT NOT NULL,
	cdt_dividendo SMALLINT NOT NULL,
	cdt_cuota     MONEY NOT NULL,
	cdt_acumulado MONEY NOT NULL,
	cdt_val_redes MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_det_trn') IS NOT NULL
	DROP TABLE dbo.ca_det_trn
GO

CREATE TABLE dbo.ca_det_trn
	(
	dtr_secuencial   INT NOT NULL,
	dtr_operacion    INT NOT NULL,
	dtr_dividendo    INT NOT NULL,
	dtr_concepto     CHAR (10) NOT NULL,
	dtr_estado       TINYINT NOT NULL,
	dtr_periodo      TINYINT NOT NULL,
	dtr_codvalor     INT NOT NULL,
	dtr_monto        MONEY NOT NULL,
	dtr_monto_mn     MONEY NOT NULL,
	dtr_moneda       TINYINT NOT NULL,
	dtr_cotizacion   FLOAT NOT NULL,
	dtr_tcotizacion  CHAR (1) NOT NULL,
	dtr_afectacion   CHAR (1) NOT NULL,
	dtr_cuenta       CHAR (20) NOT NULL,
	dtr_beneficiario CHAR (64) NOT NULL,
	dtr_monto_cont   MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_diferidos') IS NOT NULL
	DROP TABLE dbo.ca_diferidos
GO

CREATE TABLE dbo.ca_diferidos
	(
	dif_operacion       INT,
	dif_dividendo       INT,
	dif_concepto        CHAR (10),
	dif_valor_concepto  MONEY,
	dif_valor_pagado    MONEY,
	dif_estado_concepto TINYINT,
	dif_trn_origen      CHAR (10),
	dif_valor_calculado MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO

CREATE TABLE dbo.ca_diferidos_his
	(
	difh_secuencial      INT,
	difh_operacion       INT,
	difh_dividendo       INT,
	difh_concepto        CHAR (10),
	difh_valor_concepto  MONEY,
	difh_valor_pagado    MONEY,
	difh_estado_concepto TINYINT,
	difh_trn_origen      CHAR (10),
	difh_valor_calculado MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_dividendo') IS NOT NULL
	DROP TABLE dbo.ca_dividendo
GO

CREATE TABLE dbo.ca_dividendo
	(
	di_operacion   INT NOT NULL,
	di_dividendo   SMALLINT NOT NULL,
	di_fecha_ini   SMALLDATETIME NOT NULL,
	di_fecha_ven   SMALLDATETIME NOT NULL,
	di_de_capital  CHAR (1) NOT NULL,
	di_de_interes  CHAR (1) NOT NULL,
	di_gracia      SMALLINT NOT NULL,
	di_gracia_disp SMALLINT NOT NULL,
	di_estado      TINYINT NOT NULL,
	di_dias_cuota  INT NOT NULL,
	di_intento     TINYINT NOT NULL,
	di_prorroga    CHAR (1) NOT NULL,
	di_fecha_can   SMALLDATETIME
	)
GO

CREATE UNIQUE INDEX ca_dividendo_1
	ON dbo.ca_dividendo (di_operacion, di_dividendo)
GO


IF OBJECT_ID ('dbo.ca_dividendo_his') IS NOT NULL
	DROP TABLE dbo.ca_dividendo_his
GO

CREATE TABLE dbo.ca_dividendo_his
	(
	dih_secuencial  INT NOT NULL,
	dih_operacion   INT NOT NULL,
	dih_dividendo   SMALLINT NOT NULL,
	dih_fecha_ini   SMALLDATETIME NOT NULL,
	dih_fecha_ven   SMALLDATETIME NOT NULL,
	dih_de_capital  CHAR (1) NOT NULL,
	dih_de_interes  CHAR (1) NOT NULL,
	dih_gracia      SMALLINT NOT NULL,
	dih_gracia_disp SMALLINT NOT NULL,
	dih_estado      TINYINT NOT NULL,
	dih_dias_cuota  INT NOT NULL,
	dih_intento     TINYINT NOT NULL,
	dih_prorroga    CHAR (1) NOT NULL,
	dih_fecha_can   SMALLDATETIME
	)
GO
create index ca_dividendo_his_1
    on dbo.ca_dividendo_his (dih_operacion, dih_secuencial)
go

IF OBJECT_ID ('dbo.ca_facturas') IS NOT NULL
	DROP TABLE dbo.ca_facturas
GO

CREATE TABLE dbo.ca_facturas
	(
	fac_operacion         INT,
	fac_nro_factura       VARCHAR (16),
	fac_nro_dividendo     INT,
	fac_fecha_vencimiento DATETIME,
	fac_valor_negociado   MONEY,
	fac_pagado            MONEY,
	fac_intant            MONEY,
	fac_intant_amo        MONEY,
	fac_estado_factura    SMALLINT,
	fac_dias_factura      INT
	)
GO


IF OBJECT_ID ('dbo.ca_facturas_his') IS NOT NULL
	DROP TABLE dbo.ca_facturas_his
GO

CREATE TABLE dbo.ca_facturas_his
	(
	fach_secuencial        INT,
	fach_operacion         INT,
	fach_nro_factura       VARCHAR (16),
	fach_nro_dividendo     INT,
	fach_fecha_vencimiento DATETIME,
	fach_valor_negociado   MONEY,
	fach_pagado            MONEY,
	fach_intant            MONEY,
	fach_intant_amo        MONEY,
	fach_estado_factura    SMALLINT,
	fach_dias_factura      INT
	)
GO
create index ca_facturas_his_1
  on dbo.ca_facturas_his (fach_secuencial, fach_operacion)
go



IF OBJECT_ID ('dbo.ca_maestro_operaciones') IS NOT NULL
	DROP TABLE dbo.ca_maestro_operaciones
GO

CREATE TABLE dbo.ca_maestro_operaciones
	(
	mo_fecha_de_proceso            VARCHAR (10),
	mo_producto                    SMALLINT,
	mo_tipo_de_producto            catalogo,
	mo_moneda                      SMALLINT,
	mo_numero_de_operacion         INT,
	mo_numero_de_banco             cuenta,
	mo_numero_migrada              cuenta,
	mo_cliente                     INT,
	mo_nombre_cliente              descripcion,
	mo_cupo_credito                cuenta,
	mo_oficina                     INT,
	mo_nombre_oficina              descripcion,
	mo_dias_causados               INT,
	mo_monto                       MONEY,
	mo_monto_desembolso            MONEY,
	mo_tasa                        FLOAT,
	mo_tasa_efectiva               FLOAT,
	mo_plazo_total                 INT,
	mo_modalidad_cobro_int         catalogo,
	mo_fecha_inicio_op             VARCHAR (10),
	mo_fecha_ven_op                VARCHAR (10),
	mo_dias_vencido_op             SMALLINT,
	mo_fecha_fin_min_div_ven       VARCHAR (10),
	mo_reestructurada              catalogo,
	mo_fecha_ult_reest             VARCHAR (10),
	mo_num_reestructuraciones      INT,
	mo_num_cuotas_pagadas          INT,
	mo_num_cuotas_pagadas_reest    INT,
	mo_destino_credito             catalogo,
	mo_clase_cartera               catalogo,
	mo_ciudad                      INT,
	mo_fecha_prox_vencimiento      VARCHAR (10),
	mo_saldo_cuota_prox_venc       MONEY,
	mo_saldo_capital_vigente       MONEY,
	mo_saldo_capital_vencido       MONEY,
	mo_saldo_interes_vigente       MONEY,
	mo_saldo_interes_vencido       MONEY,
	mo_saldo_interes_contingente   MONEY,
	mo_saldo_mora_vigente          MONEY,
	mo_saldo_mora_contingente      MONEY,
	mo_saldo_seguro_vida_vigente   MONEY,
	mo_saldo_seguro_vida_vencido   MONEY,
	mo_saldo_otros_vigente         MONEY,
	mo_saldo_otros_vencidos        MONEY,
	mo_estado_obligacion           descripcion,
	mo_calificacion_obligacion     catalogo,
	mo_frecuencia_pago_int         INT,
	mo_frecuencia_pago_cap         INT,
	mo_edad_vencimiento_cartera    INT,
	mo_fecha_ult_pago              VARCHAR (10),
	mo_valor_ult_pago              MONEY,
	mo_fecha_ult_pago_cap          VARCHAR (10),
	mo_valor_ult_pago_cap          MONEY,
	mo_valor_cuota_tabla           MONEY,
	mo_numero_cuotas_pactadas      INT,
	mo_numero_cuotas_vencidas      INT,
	mo_clase_garantia              CHAR (1),
	mo_tipo_garantia               catalogo,
	mo_descripcion_tipo_garantia   VARCHAR (30),
	mo_fecha_castigo               VARCHAR (10),
	mo_numero_comex                cuenta,
	mo_numero_deuda_externa        cuenta,
	mo_fecha_embarque              VARCHAR (10),
	mo_fecha_dex                   VARCHAR (10),
	mo_tipo_tasa                   CHAR (1),
	mo_tasa_referencial            catalogo,
	mo_signo                       CHAR (1),
	mo_factor                      FLOAT,
	mo_tipo_identificacion         catalogo,
	mo_numero_identificacion       cuenta,
	mo_provision_cap               MONEY,
	mo_provision_int               MONEY,
	mo_provision_cxc               MONEY,
	mo_cuenta_asociada             cuenta,
	mo_forma_de_pago               catalogo,
	mo_tipo_tabla                  catalogo,
	mo_periodo_gracia_cap          INT,
	mo_periodo_gracia_int          INT,
	mo_estado_cobranza             catalogo,
	mo_descripcion_estado_cobranza descripcion,
	mo_tasa_representativa_mercado MONEY,
	mo_reajustable                 CHAR (1),
	mo_descripcion_reajustable     descripcion,
	mo_periodo_reajuste            SMALLINT,
	mo_fecha_prox_reajuste         VARCHAR (10),
	mo_fecha_ult_proceso           VARCHAR (10),
	mo_tipo_soc                    catalogo,
	mo_tipo_puntos                 CHAR (1),
	mo_cobertura_garantia          FLOAT,
	mo_des_tipo_bien               VARCHAR (64),
	mo_tramite                     INT,
	mo_defecto_garantia            MONEY,
	mo_modalidad                   CHAR (3),
	mo_clausula                    CHAR (1),
	mo_naturaleza_linea            CHAR (1),
	mo_tiene_seg_vida              CHAR (1),
	mo_tiene_seg_vehiculo          CHAR (1),
	mo_tiene_seg_todor_maq         CHAR (1),
	mo_tiene_seg_rotura_maq        CHAR (1),
	mo_tiene_seg_vivienda          CHAR (1),
	mo_tiene_seg_extraprima        CHAR (1),
	mo_tiene_incentivo             CHAR (1),
	mo_tipo_banca                  VARCHAR (15),
	mo_nombre_codeudor             VARCHAR (35),
	mo_ced_ruc_codeudor            cuenta,
	mo_zona                        INT,
	mo_regional                    INT,
	mo_capitaliza                  CHAR (1),
	mo_tipo_productor              VARCHAR (30),
	mo_mercado_obj                 VARCHAR (30),
	mo_aprobador                   login,
	mo_llave_redescuento           cuenta,
	mo_condonacion_intereses       MONEY,
	mo_condonacion_capital         MONEY,
	mo_provision_defecto           MONEY,
	mo_margen_redescuento          FLOAT,
	mo_codigo_sector               catalogo,
	mo_dias_base                   SMALLINT,
	mo_provisiona_cap              MONEY,
	mo_provisiona_int              MONEY,
	mo_provisiona_cxc              MONEY,
	mo_norma_legal                 catalogo,
	mo_ind_aprob                   CHAR (1),
	mo_cap_diferido                MONEY,
	mo_int_imo_diferido            MONEY
	)
GO


IF OBJECT_ID ('dbo.ca_operacion') IS NOT NULL
	DROP TABLE dbo.ca_operacion
GO

CREATE TABLE dbo.ca_operacion
	(
	op_operacion               INT NOT NULL,
	op_banco                   CHAR (24) NOT NULL,
	op_anterior                CHAR (24),
	op_migrada                 CHAR (24),
	op_tramite                 INT,
	op_cliente                 INT,
	op_nombre                  VARCHAR (64),
	op_sector                  CHAR (10) NOT NULL,
	op_toperacion              CHAR (10) NOT NULL,
	op_oficina                 SMALLINT NOT NULL,
	op_moneda                  TINYINT NOT NULL,
	op_comentario              VARCHAR (255),
	op_oficial                 SMALLINT NOT NULL,
	op_fecha_ini               DATETIME NOT NULL,
	op_fecha_fin               DATETIME NOT NULL,
	op_fecha_ult_proceso       DATETIME NOT NULL,
	op_fecha_liq               DATETIME,
	op_fecha_reajuste          DATETIME,
	op_monto                   MONEY NOT NULL,
	op_monto_aprobado          MONEY NOT NULL,
	op_destino                 CHAR (10) NOT NULL,
	op_lin_credito             CHAR (24),
	op_ciudad                  INT NOT NULL,
	op_estado                  TINYINT NOT NULL,
	op_periodo_reajuste        SMALLINT,
	op_reajuste_especial       CHAR (1),
	op_tipo                    CHAR (1) NOT NULL,
	op_forma_pago              CHAR (10),
	op_cuenta                  CHAR (24),
	op_dias_anio               SMALLINT NOT NULL,
	op_tipo_amortizacion       VARCHAR (10) NOT NULL,
	op_cuota_completa          CHAR (1) NOT NULL,
	op_tipo_cobro              CHAR (1) NOT NULL,
	op_tipo_reduccion          CHAR (1) NOT NULL,
	op_aceptar_anticipos       CHAR (1) NOT NULL,
	op_precancelacion          CHAR (1) NOT NULL,
	op_tipo_aplicacion         CHAR (1) NOT NULL,
	op_tplazo                  CHAR (10),
	op_plazo                   SMALLINT,
	op_tdividendo              CHAR (10),
	op_periodo_cap             SMALLINT,
	op_periodo_int             SMALLINT,
	op_dist_gracia             CHAR (1),
	op_gracia_cap              SMALLINT,
	op_gracia_int              SMALLINT,
	op_dia_fijo                TINYINT,
	op_cuota                   MONEY,
	op_evitar_feriados         CHAR (1),
	op_num_renovacion          TINYINT,
	op_renovacion              CHAR (1),
	op_mes_gracia              TINYINT NOT NULL,
	op_reajustable             CHAR (1) NOT NULL,
	op_dias_clausula           INT NOT NULL,
	op_divcap_original         SMALLINT,
	op_clausula_aplicada       CHAR (1),
	op_traslado_ingresos       CHAR (1),
	op_periodo_crecimiento     SMALLINT,
	op_tasa_crecimiento        FLOAT,
	op_direccion               TINYINT,
	op_opcion_cap              CHAR (1),
	op_tasa_cap                FLOAT,
	op_dividendo_cap           SMALLINT,
	op_clase                   CHAR (10) NOT NULL,
	op_origen_fondos           CHAR (10),
	op_calificacion            CHAR (1),
	op_estado_cobranza         CHAR (10),
	op_numero_reest            INT NOT NULL,
	op_edad                    INT,
	op_tipo_crecimiento        CHAR (1),
	op_base_calculo            CHAR (1),
	op_prd_cobis               TINYINT,
	op_ref_exterior            CHAR (24),
	op_sujeta_nego             CHAR (1),
	op_dia_habil               CHAR (1),
	op_recalcular_plazo        CHAR (1),
	op_usar_tequivalente       CHAR (1),
	op_fondos_propios          CHAR (1) NOT NULL,
	op_nro_red                 VARCHAR (24),
	op_tipo_redondeo           TINYINT,
	op_sal_pro_pon             MONEY,
	op_tipo_empresa            CHAR (10),
	op_validacion              CHAR (10),
	op_fecha_pri_cuot          DATETIME,
	op_gar_admisible           CHAR (1),
	op_causacion               CHAR (1),
	op_convierte_tasa          CHAR (1),
	op_grupo_fact              INT,
	op_tramite_ficticio        INT,
	op_tipo_linea              CHAR (10),
	op_subtipo_linea           CHAR (10),
	op_bvirtual                CHAR (1),
	op_extracto                CHAR (1),
	op_num_deuda_ext           CHAR (24),
	op_fecha_embarque          DATETIME,
	op_fecha_dex               DATETIME,
	op_reestructuracion        CHAR (1),
	op_tipo_cambio             CHAR (1),
	op_naturaleza              CHAR (1),
	op_pago_caja               CHAR (1),
	op_nace_vencida            CHAR (1),
	op_num_comex               CHAR (24),
	op_calcula_devolucion      CHAR (1),
	op_codigo_externo          CHAR (24),
	op_margen_redescuento      FLOAT,
	op_entidad_convenio        CHAR (10),
	op_pproductor              CHAR (1),
	op_fecha_ult_causacion     DATETIME,
	op_mora_retroactiva        CHAR (1),
	op_calificacion_ant        CHAR (1),
	op_cap_susxcor             MONEY,
	op_prepago_desde_lavigente CHAR (1),
	op_fecha_ult_mov           DATETIME,
	op_fecha_prox_segven       DATETIME,
	op_suspendio               CHAR (1),
	op_fecha_suspenso          DATETIME,
	op_honorarios_cobranza     CHAR (1),
	op_banca                   CHAR (10),
        op_promocion               char(1),    --LPO Santander
        op_acepta_ren              char(1),    --LPO Santander
        op_no_acepta               char(1000), --LPO Santander
        op_emprendimiento          char(1),     --LPO Santander
        op_valor_cat               float       --LGU Santander
	)
GO

CREATE UNIQUE INDEX ca_operacion_1
	ON dbo.ca_operacion (op_operacion)
GO

CREATE INDEX ca_operacion_2
	ON dbo.ca_operacion (op_migrada)
GO

CREATE INDEX ca_operacion_3
	ON dbo.ca_operacion (op_tramite)
GO

CREATE INDEX ca_operacion_4
	ON dbo.ca_operacion (op_cliente)
GO

CREATE INDEX ca_operacion_5
	ON dbo.ca_operacion (op_oficial)
GO

CREATE INDEX ca_operacion_6
	ON dbo.ca_operacion (op_oficina)
GO

CREATE INDEX ca_operacion_7
	ON dbo.ca_operacion (op_banco)
GO

CREATE INDEX ca_oepracion_9
	ON dbo.ca_operacion (op_estado)
GO


IF OBJECT_ID ('dbo.ca_operacion_hc') IS NOT NULL
	DROP TABLE dbo.ca_operacion_hc
GO

CREATE TABLE dbo.ca_operacion_hc
	(
	oh_fecha         DATETIME NOT NULL,
	oh_banco         CHAR (24) NOT NULL,
	oh_operacion     INT NOT NULL,
	oh_oficina       SMALLINT NOT NULL,
	oh_toperacion    CHAR (10) NOT NULL,
	oh_moneda        TINYINT NOT NULL,
	oh_clase         catalogo NOT NULL,
	oh_destino       catalogo NOT NULL,
	oh_calificacion  CHAR (1) NOT NULL,
	oh_gar_admisible CHAR (1) NOT NULL,
	oh_tipo_linea    catalogo NOT NULL,
	oh_estado        INT NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_operacion_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_his
GO

CREATE TABLE dbo.ca_operacion_his
    (
    oph_secuencial              INT NOT NULL,
    oph_operacion               INT NOT NULL,
    oph_banco                   cuenta NOT NULL,
    oph_anterior                cuenta,
    oph_migrada                 cuenta,
    oph_tramite                 INT,
    oph_cliente                 INT,
    oph_nombre                  descripcion,
    oph_sector                  catalogo NOT NULL,
    oph_toperacion              catalogo NOT NULL,
    oph_oficina                 SMALLINT NOT NULL,
    oph_moneda                  TINYINT NOT NULL,
    oph_comentario              VARCHAR (255),
    oph_oficial                 SMALLINT NOT NULL,
    oph_fecha_ini               DATETIME NOT NULL,
    oph_fecha_fin               DATETIME NOT NULL,
    oph_fecha_ult_proceso       DATETIME NOT NULL,
    oph_fecha_liq               DATETIME,
    oph_fecha_reajuste          DATETIME,
    oph_monto                   MONEY NOT NULL,
    oph_monto_aprobado          MONEY NOT NULL,
    oph_destino                 catalogo NOT NULL,
    oph_lin_credito             cuenta,
    oph_ciudad                  INT NOT NULL,
    oph_estado                  TINYINT NOT NULL,
    oph_periodo_reajuste        SMALLINT,
    oph_reajuste_especial       CHAR (1),
    oph_tipo                    CHAR (1) NOT NULL,
    oph_forma_pago              catalogo,
    oph_cuenta                  cuenta,
    oph_dias_anio               SMALLINT NOT NULL,
    oph_tipo_amortizacion       VARCHAR (10) NOT NULL,
    oph_cuota_completa          CHAR (1) NOT NULL,
    oph_tipo_cobro              CHAR (1) NOT NULL,
    oph_tipo_reduccion          CHAR (1) NOT NULL,
    oph_aceptar_anticipos       CHAR (1) NOT NULL,
    oph_precancelacion          CHAR (1) NOT NULL,
    oph_tipo_aplicacion         CHAR (1) NOT NULL,
    oph_tplazo                  catalogo,
    oph_plazo                   SMALLINT,
    oph_tdividendo              catalogo,
    oph_periodo_cap             SMALLINT,
    oph_periodo_int             SMALLINT,
    oph_dist_gracia             CHAR (1),
    oph_gracia_cap              SMALLINT,
    oph_gracia_int              SMALLINT,
    oph_dia_fijo                TINYINT,
    oph_cuota                   MONEY,
    oph_evitar_feriados         CHAR (1),
    oph_num_renovacion          TINYINT,
    oph_renovacion              CHAR (1),
    oph_mes_gracia              TINYINT NOT NULL,
    oph_reajustable             CHAR (1) NOT NULL,
    oph_dias_clausula           INT NOT NULL,
    oph_divcap_original         SMALLINT,
    oph_clausula_aplicada       CHAR (1),
    oph_traslado_ingresos       CHAR (1),
    oph_periodo_crecimiento     SMALLINT,
    oph_tasa_crecimiento        FLOAT,
    oph_direccion               TINYINT,
    oph_opcion_cap              CHAR (1),
    oph_tasa_cap                FLOAT,
    oph_dividendo_cap           SMALLINT,
    oph_clase                   catalogo NOT NULL,
    oph_origen_fondos           catalogo,
    oph_calificacion            CHAR (1),
    oph_estado_cobranza         catalogo,
    oph_numero_reest            INT NOT NULL,
    oph_edad                    INT,
    oph_tipo_crecimiento        CHAR (1),
    oph_base_calculo            CHAR (1),
    oph_prd_cobis               TINYINT,
    oph_ref_exterior            cuenta,
    oph_sujeta_nego             CHAR (1),
    oph_dia_habil               CHAR (1),
    oph_recalcular_plazo        CHAR (1),
    oph_usar_tequivalente       CHAR (1),
    oph_fondos_propios          CHAR (1) NOT NULL,
    oph_nro_red                 VARCHAR (24),
    oph_tipo_redondeo           TINYINT,
    oph_sal_pro_pon             MONEY,
    oph_tipo_empresa            catalogo,
    oph_validacion              catalogo,
    oph_fecha_pri_cuot          DATETIME,
    oph_gar_admisible           CHAR (1),
    oph_causacion               CHAR (1),
    oph_convierte_tasa          CHAR (1),
    oph_grupo_fact              INT,
    oph_tramite_ficticio        INT,
    oph_tipo_linea              catalogo,
    oph_subtipo_linea           catalogo,
    oph_bvirtual                CHAR (1),
    oph_extracto                CHAR (1),
    oph_num_deuda_ext           cuenta,
    oph_fecha_embarque          DATETIME,
    oph_fecha_dex               DATETIME,
    oph_reestructuracion        CHAR (1),
    oph_tipo_cambio             CHAR (1),
    oph_naturaleza              CHAR (1),
    oph_pago_caja               CHAR (1),
    oph_nace_vencida            CHAR (1),
    oph_num_comex               cuenta,
    oph_calcula_devolucion      CHAR (1),
    oph_codigo_externo          cuenta,
    oph_margen_redescuento      FLOAT,
    oph_entidad_convenio        catalogo,
    oph_pproductor              CHAR (1),
    oph_fecha_ult_causacion     DATETIME,
    oph_mora_retroactiva        CHAR (1),
    oph_calificacion_ant        CHAR (1),
    oph_cap_susxcor             MONEY,
    oph_prepago_desde_lavigente CHAR (1),
    oph_fecha_ult_mov           DATETIME,
    oph_fecha_prox_segven       DATETIME,
    oph_suspendio               CHAR (1),
    oph_fecha_suspenso          DATETIME,
    oph_honorarios_cobranza     CHAR (1),
    oph_banca                   catalogo,
    oph_promocion               char(1),    --LPO Santander
    oph_acepta_ren              char(1),    --LPO Santander
    oph_no_acepta               char(1000), --LPO Santander
    oph_emprendimiento          char(1),    --LPO Santander
    oph_valor_cat               float,      --LGU Santander
    oph_desplazamiento          int null    --SRO 140073
    )
GO

create index ca_operacion_his_1
    on dbo.ca_operacion_his (oph_operacion, oph_secuencial) 


IF OBJECT_ID ('dbo.ca_operacion_ts') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ts
GO

CREATE TABLE dbo.ca_operacion_ts
	(
	ops_fecha_proceso_ts        DATETIME NOT NULL,
	ops_fecha_ts                DATETIME NOT NULL,
	ops_usuario_ts              login NOT NULL,
	ops_oficina_ts              SMALLINT NOT NULL,
	ops_terminal_ts             VARCHAR (30) NOT NULL,
	ops_operacion               INT NOT NULL,
	ops_banco                   cuenta NOT NULL,
	ops_anterior                cuenta,
	ops_migrada                 cuenta,
	ops_tramite                 INT,
	ops_cliente                 INT,
	ops_nombre                  descripcion,
	ops_sector                  catalogo NOT NULL,
	ops_toperacion              catalogo NOT NULL,
	ops_oficina                 SMALLINT NOT NULL,
	ops_moneda                  TINYINT NOT NULL,
	ops_comentario              VARCHAR (255),
	ops_oficial                 SMALLINT NOT NULL,
	ops_fecha_ini               DATETIME NOT NULL,
	ops_fecha_fin               DATETIME NOT NULL,
	ops_fecha_ult_proceso       DATETIME NOT NULL,
	ops_fecha_liq               DATETIME,
	ops_fecha_reajuste          DATETIME,
	ops_monto                   MONEY NOT NULL,
	ops_monto_aprobado          MONEY NOT NULL,
	ops_destino                 catalogo NOT NULL,
	ops_lin_credito             cuenta,
	ops_ciudad                  INT NOT NULL,
	ops_estado                  TINYINT NOT NULL,
	ops_periodo_reajuste        SMALLINT,
	ops_reajuste_especial       CHAR (1),
	ops_tipo                    CHAR (1) NOT NULL,
	ops_forma_pago              catalogo,
	ops_cuenta                  cuenta,
	ops_dias_anio               SMALLINT NOT NULL,
	ops_tipo_amortizacion       VARCHAR (10) NOT NULL,
	ops_cuota_completa          CHAR (1) NOT NULL,
	ops_tipo_cobro              CHAR (1) NOT NULL,
	ops_tipo_reduccion          CHAR (1) NOT NULL,
	ops_aceptar_anticipos       CHAR (1) NOT NULL,
	ops_precancelacion          CHAR (1) NOT NULL,
	ops_tipo_aplicacion         CHAR (1) NOT NULL,
	ops_tplazo                  catalogo,
	ops_plazo                   SMALLINT,
	ops_tdividendo              catalogo,
	ops_periodo_cap             SMALLINT,
	ops_periodo_int             SMALLINT,
	ops_dist_gracia             CHAR (1),
	ops_gracia_cap              SMALLINT,
	ops_gracia_int              SMALLINT,
	ops_dia_fijo                TINYINT,
	ops_cuota                   MONEY,
	ops_evitar_feriados         CHAR (1),
	ops_num_renovacion          TINYINT,
	ops_renovacion              CHAR (1),
	ops_mes_gracia              TINYINT NOT NULL,
	ops_reajustable             CHAR (1) NOT NULL,
	ops_dias_clausula           INT NOT NULL,
	ops_divcap_original         SMALLINT,
	ops_clausula_aplicada       CHAR (1),
	ops_traslado_ingresos       CHAR (1),
	ops_periodo_crecimiento     SMALLINT,
	ops_tasa_crecimiento        FLOAT,
	ops_direccion               TINYINT,
	ops_opcion_cap              CHAR (1),
	ops_tasa_cap                FLOAT,
	ops_dividendo_cap           SMALLINT,
	ops_clase                   catalogo NOT NULL,
	ops_origen_fondos           catalogo,
	ops_calificacion            CHAR (1),
	ops_estado_cobranza         catalogo,
	ops_numero_reest            INT NOT NULL,
	ops_edad                    INT,
	ops_tipo_crecimiento        CHAR (1),
	ops_base_calculo            CHAR (1),
	ops_prd_cobis               TINYINT,
	ops_ref_exterior            cuenta,
	ops_sujeta_nego             CHAR (1),
	ops_dia_habil               CHAR (1),
	ops_recalcular_plazo        CHAR (1),
	ops_usar_tequivalente       CHAR (1),
	ops_fondos_propios          CHAR (1) NOT NULL,
	ops_nro_red                 VARCHAR (24),
	ops_tipo_redondeo           TINYINT,
	ops_sal_pro_pon             MONEY,
	ops_tipo_empresa            catalogo,
	ops_validacion              catalogo,
	ops_fecha_pri_cuot          DATETIME,
	ops_gar_admisible           CHAR (1),
	ops_causacion               CHAR (1),
	ops_convierte_tasa          CHAR (1),
	ops_grupo_fact              INT,
	ops_tramite_ficticio        INT,
	ops_tipo_linea              catalogo NOT NULL,
	ops_subtipo_linea           catalogo,
	ops_bvirtual                CHAR (1) NOT NULL,
	ops_extracto                CHAR (1) NOT NULL,
	ops_num_deuda_ext           cuenta,
	ops_fecha_embarque          DATETIME,
	ops_fecha_dex               DATETIME,
	ops_reestructuracion        CHAR (1),
	ops_tipo_cambio             CHAR (1),
	ops_naturaleza              CHAR (1),
	ops_pago_caja               CHAR (1),
	ops_nace_vencida            CHAR (1),
	ops_num_comex               cuenta,
	ops_calcula_devolucion      CHAR (1),
	ops_codigo_externo          cuenta,
	ops_margen_redescuento      FLOAT,
	ops_entidad_convenio        catalogo,
	ops_pproductor              CHAR (1),
	ops_fecha_ult_causacion     DATETIME,
	ops_mora_retroactiva        CHAR (1),
	ops_calificacion_ant        CHAR (1),
	ops_cap_susxcor             MONEY,
	ops_prepago_desde_lavigente CHAR (1),
	ops_fecha_ult_mov           DATETIME,
	ops_fecha_prox_segven       DATETIME,
	ops_suspendio               CHAR (1),
	ops_fecha_suspenso          DATETIME,
	ops_honorarios_cobranza     CHAR (1),
        ops_banca                   catalogo,
        ops_promocion               char(1),    --LPO Santander
        ops_acepta_ren              char(1),    --LPO Santander
        ops_no_acepta               char(1000), --LPO Santander
        ops_emprendimiento          char(1),    --LPO Santander
        ops_valor_cat               float       --LGU Santander

	)
GO


IF OBJECT_ID ('dbo.ca_reajuste') IS NOT NULL
	DROP TABLE dbo.ca_reajuste
GO

CREATE TABLE dbo.ca_reajuste
	(
	re_secuencial        INT NOT NULL,
	re_operacion         INT NOT NULL,
	re_fecha             DATETIME NOT NULL,
	re_reajuste_especial CHAR (1) NOT NULL,
	re_desagio           CHAR (1),
	re_sec_aviso         INT
	)
GO

CREATE INDEX ca_reajuste_1
	ON dbo.ca_reajuste (re_operacion, re_fecha)
GO


IF OBJECT_ID ('dbo.ca_reajuste_det') IS NOT NULL
	DROP TABLE dbo.ca_reajuste_det
GO

CREATE TABLE dbo.ca_reajuste_det
	(
	red_secuencial  INT NOT NULL,
	red_operacion   INT NOT NULL,
	red_concepto    CHAR (10) NOT NULL,
	red_referencial CHAR (10),
	red_signo       CHAR (1),
	red_factor      FLOAT,
	red_porcentaje  FLOAT
	)
GO

CREATE UNIQUE INDEX ca_reajuste_det_1
	ON dbo.ca_reajuste_det (red_operacion, red_secuencial, red_concepto)
GO


IF OBJECT_ID ('dbo.ca_relacion_ptmo_his') IS NOT NULL
	DROP TABLE dbo.ca_relacion_ptmo_his
GO

CREATE TABLE dbo.ca_relacion_ptmo_his
	(
	hpt_secuencial     INT NOT NULL,
	hpt_activa         INT,
	hpt_pasiva         INT,
	hpt_lin_activa     VARCHAR (24),
	hpt_lin_pasiva     VARCHAR (24),
	hpt_fecha_ini      DATETIME,
	hpt_fecha_fin      DATETIME,
	hpt_porcentaje_act FLOAT,
	hpt_porcentaje_pas FLOAT,
	hpt_saldo_act      MONEY,
	hpt_saldo_pas      MONEY,
	hpt_fecha_grb      DATETIME,
	hpt_fecha_upd      DATETIME,
	hpt_usuario_grb    login,
	hpt_usuario_upd    login,
	rp_hora_grb        VARCHAR (10),
	rp_hora_upd        VARCHAR (10)
	)
GO


IF OBJECT_ID ('dbo.ca_reportar_cliente') IS NOT NULL
	DROP TABLE dbo.ca_reportar_cliente
GO

CREATE TABLE dbo.ca_reportar_cliente
	(
	rc_numero_obligacion_cmm   VARCHAR (16) NOT NULL,
	rc_numero_obligacion_repor VARCHAR (16),
	rc_tipo_documento          CHAR (1),
	rc_numero_documento        VARCHAR (16) NOT NULL,
	rc_tipo_obligacion         CHAR (1),
	rc_deudor_codeudor         CHAR (1),
	rc_numero_titular          VARCHAR (16),
	rc_direccion               VARCHAR (60),
	rc_telefono                VARCHAR (16),
	rc_nombres                 VARCHAR (25),
	rc_apellidos               VARCHAR (25),
	rc_valor_obligacion        MONEY,
	rc_fecha_obligacion        DATETIME,
	rc_cuotas_mora             SMALLINT,
	rc_valor_mora              MONEY,
	rc_fecha_ultimo_pago       DATETIME,
	rc_oficina                 CHAR (2),
	rc_analista_responsable    VARCHAR (16),
	rc_codeudor                VARCHAR (16),
	rc_conyugue                VARCHAR (16),
	rc_valor_desbloqueo        MONEY,
	rc_fecha_desbloqueo        DATETIME,
	rc_fecha_reporte_cliente   DATETIME,
	rc_estado                  CHAR (1),
	rc_tipo_pago               CHAR (2)
	)
GO


IF OBJECT_ID ('dbo.ca_reportar_cliente_his') IS NOT NULL
	DROP TABLE dbo.ca_reportar_cliente_his
GO

CREATE TABLE dbo.ca_reportar_cliente_his
	(
	rc_numero_obligacion_cmm   VARCHAR (16) NOT NULL,
	rc_numero_obligacion_repor VARCHAR (16),
	rc_tipo_documento          CHAR (1),
	rc_numero_documento        VARCHAR (16) NOT NULL,
	rc_tipo_obligacion         CHAR (1),
	rc_deudor_codeudor         CHAR (1),
	rc_numero_titular          VARCHAR (16),
	rc_direccion               VARCHAR (60),
	rc_telefono                VARCHAR (16),
	rc_nombres                 VARCHAR (25),
	rc_apellidos               VARCHAR (25),
	rc_valor_obligacion        MONEY,
	rc_fecha_obligacion        DATETIME,
	rc_cuotas_mora             SMALLINT,
	rc_valor_mora              MONEY,
	rc_fecha_ultimo_pago       DATETIME,
	rc_oficina                 CHAR (2),
	rc_analista_responsable    VARCHAR (16),
	rc_codeudor                VARCHAR (16),
	rc_conyugue                VARCHAR (16),
	rc_valor_desbloqueo        MONEY,
	rc_fecha_desbloqueo        DATETIME,
	rc_fecha_reporte_cliente   DATETIME,
	rc_estado                  CHAR (1),
	rc_tipo_pago               CHAR (2)
	)
GO


IF OBJECT_ID ('dbo.ca_rubro_op') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op
GO

CREATE TABLE dbo.ca_rubro_op
	(
	ro_operacion            INT NOT NULL,
	ro_concepto             CHAR (10) NOT NULL,
	ro_tipo_rubro           CHAR (1) NOT NULL,
	ro_fpago                CHAR (1) NOT NULL,
	ro_prioridad            TINYINT NOT NULL,
	ro_paga_mora            CHAR (1) NOT NULL,
	ro_provisiona           CHAR (1) NOT NULL,
	ro_signo                CHAR (1),
	ro_factor               FLOAT,
	ro_referencial          CHAR (10),
	ro_signo_reajuste       CHAR (1),
	ro_factor_reajuste      FLOAT,
	ro_referencial_reajuste CHAR (10),
	ro_valor                MONEY NOT NULL,
	ro_porcentaje           FLOAT NOT NULL,
	ro_porcentaje_aux       FLOAT NOT NULL,
	ro_gracia               MONEY,
	ro_concepto_asociado    CHAR (10),
	ro_redescuento          FLOAT,
	ro_intermediacion       FLOAT,
	ro_principal            CHAR (1) NOT NULL,
	ro_porcentaje_efa       FLOAT,
	ro_garantia             MONEY NOT NULL,
	ro_tipo_puntos          CHAR (1),
	ro_saldo_op             CHAR (1),
	ro_saldo_por_desem      CHAR (1),
	ro_base_calculo         MONEY,
	ro_num_dec              TINYINT,
	ro_limite               CHAR (1),
	ro_iva_siempre          CHAR (1),
	ro_monto_aprobado       CHAR (1),
	ro_porcentaje_cobrar    FLOAT,
	ro_tipo_garantia        VARCHAR (64),
	ro_nro_garantia         CHAR (24),
	ro_porcentaje_cobertura CHAR (1),
	ro_valor_garantia       CHAR (1),
	ro_tperiodo             CHAR (10),
	ro_periodo              SMALLINT,
	ro_tabla                VARCHAR (30),
	ro_saldo_insoluto       CHAR (1),
	ro_calcular_devolucion  CHAR (1)
	)
GO

CREATE UNIQUE INDEX ca_rubro_op_1
	ON dbo.ca_rubro_op (ro_operacion, ro_concepto)
GO


IF OBJECT_ID ('dbo.ca_rubro_op_his') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_his
GO

CREATE TABLE dbo.ca_rubro_op_his
    (
    roh_secuencial           INT NOT NULL,
    roh_operacion            INT NOT NULL,
    roh_concepto             catalogo NOT NULL,
    roh_tipo_rubro           CHAR (1) NOT NULL,
    roh_fpago                CHAR (1) NOT NULL,
    roh_prioridad            TINYINT NOT NULL,
    roh_paga_mora            CHAR (1) NOT NULL,
    roh_provisiona           CHAR (1) NOT NULL,
    roh_signo                CHAR (1),
    roh_factor               FLOAT,
    roh_referencial          catalogo,
    roh_signo_reajuste       CHAR (1),
    roh_factor_reajuste      FLOAT,
    roh_referencial_reajuste catalogo,
    roh_valor                MONEY NOT NULL,
    roh_porcentaje           FLOAT NOT NULL,
    roh_porcentaje_aux       FLOAT NOT NULL,
    roh_gracia               MONEY,
    roh_concepto_asociado    catalogo,
    roh_redescuento          FLOAT,
    roh_intermediacion       FLOAT,
    roh_principal            CHAR (1) NOT NULL,
    roh_porcentaje_efa       FLOAT,
    roh_garantia             MONEY NOT NULL,
    roh_tipo_puntos          CHAR (1),
    roh_saldo_op             CHAR (1),
    roh_saldo_por_desem      CHAR (1),
    roh_base_calculo         MONEY,
    roh_num_dec              TINYINT,
    roh_limite               CHAR (1),
    roh_iva_siempre          CHAR (1),
    roh_monto_aprobado       CHAR (1),
    roh_porcentaje_cobrar    FLOAT,
    roh_tipo_garantia        VARCHAR (64),
    roh_nro_garantia         cuenta,
    roh_porcentaje_cobertura CHAR (1),
    roh_valor_garantia       CHAR (1),
    roh_tperiodo             catalogo,
    roh_periodo              SMALLINT,
    roh_tabla                VARCHAR (30),
    roh_saldo_insoluto       CHAR (1),
    roh_calcular_devolucion  CHAR (1)
    )
GO
create index ca_rubro_op_his_1
    on dbo.ca_rubro_op_his (roh_operacion, roh_secuencial)
go

IF OBJECT_ID ('dbo.ca_rubro_op_ts') IS NOT NULL
	DROP TABLE dbo.ca_rubro_op_ts
GO

CREATE TABLE dbo.ca_rubro_op_ts
	(
	ros_fecha_proceso_ts     DATETIME NOT NULL,
	ros_fecha_ts             DATETIME NOT NULL,
	ros_usuario_ts           login NOT NULL,
	ros_oficina_ts           SMALLINT NOT NULL,
	ros_terminal_ts          VARCHAR (30) NOT NULL,
	ros_operacion            INT NOT NULL,
	ros_concepto             catalogo NOT NULL,
	ros_tipo_rubro           CHAR (1) NOT NULL,
	ros_fpago                CHAR (1) NOT NULL,
	ros_prioridad            TINYINT NOT NULL,
	ros_paga_mora            CHAR (1) NOT NULL,
	ros_provisiona           CHAR (1) NOT NULL,
	ros_signo                CHAR (1),
	ros_factor               FLOAT,
	ros_referencial          catalogo,
	ros_signo_reajuste       CHAR (1),
	ros_factor_reajuste      FLOAT,
	ros_referencial_reajuste catalogo,
	ros_valor                MONEY NOT NULL,
	ros_porcentaje           FLOAT NOT NULL,
	ros_porcentaje_aux       FLOAT NOT NULL,
	ros_gracia               MONEY,
	ros_concepto_asociado    catalogo,
	ros_redescuento          FLOAT,
	ros_intermediacion       FLOAT,
	ros_principal            CHAR (1) NOT NULL,
	ros_porcentaje_efa       FLOAT,
	ros_garantia             MONEY NOT NULL,
	ros_tipo_puntos          CHAR (1),
	ros_saldo_op             CHAR (1),
	ros_saldo_por_desem      CHAR (1),
	ros_base_calculo         MONEY,
	ros_num_dec              TINYINT,
	ros_limite               CHAR (1),
	ros_iva_siempre          CHAR (1),
	ros_monto_aprobado       CHAR (1),
	ros_porcentaje_cobrar    FLOAT,
	ros_tipo_garantia        VARCHAR (64),
	ros_nro_garantia         cuenta,
	ros_porcentaje_cobertura CHAR (1),
	ros_valor_garantia       CHAR (1),
	ros_tperiodo             catalogo,
	ros_periodo              SMALLINT,
	ros_tabla                VARCHAR (30),
	ros_saldo_insoluto       CHAR (1),
	ros_calcular_devolucion  CHAR (1)
	)
GO


IF OBJECT_ID ('dbo.ca_saldos_cartera_mensual') IS NOT NULL
	DROP TABLE dbo.ca_saldos_cartera_mensual
GO

CREATE TABLE dbo.ca_saldos_cartera_mensual
	(
	sc_fecha      DATETIME NOT NULL,
	sc_banco      cuenta,
	sc_codvalor   INT NOT NULL,
	sc_concepto   catalogo,
	sc_valor      MONEY NOT NULL,
	sc_valor_me   MONEY NOT NULL,
	sc_estado     INT NOT NULL,
	sc_perfil     catalogo,
	sc_estado_con CHAR (1) NOT NULL,
	sc_operacion  INT NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_tasas') IS NOT NULL
	DROP TABLE dbo.ca_tasas
GO

CREATE TABLE dbo.ca_tasas
	(
	ts_operacion         INT NOT NULL,
	ts_dividendo         INT NOT NULL,
	ts_fecha             DATETIME NOT NULL,
	ts_concepto          CHAR (10) NOT NULL,
	ts_porcentaje        FLOAT NOT NULL,
	ts_secuencial        INT NOT NULL,
	ts_porcentaje_efa    FLOAT,
	ts_referencial       CHAR (10),
	ts_signo             CHAR (1),
	ts_factor            FLOAT,
	ts_valor_referencial FLOAT,
	ts_fecha_referencial DATETIME,
	ts_tasa_ref          CHAR (10)
	)
GO

CREATE INDEX ca_tasas_I1
	ON dbo.ca_tasas (ts_operacion, ts_dividendo, ts_concepto, ts_fecha)
GO


IF OBJECT_ID ('dbo.ca_transaccion') IS NOT NULL
	DROP TABLE dbo.ca_transaccion
GO

CREATE TABLE dbo.ca_transaccion
	(
	tr_secuencial       INT NOT NULL,
	tr_fecha_mov        SMALLDATETIME NOT NULL,
	tr_toperacion       CHAR (10) NOT NULL,
	tr_moneda           TINYINT NOT NULL,
	tr_operacion        INT NOT NULL,
	tr_tran             CHAR (10) NOT NULL,
	tr_en_linea         CHAR (1) NOT NULL,
	tr_banco            CHAR (24) NOT NULL,
	tr_dias_calc        INT NOT NULL,
	tr_ofi_oper         SMALLINT NOT NULL,
	tr_ofi_usu          SMALLINT NOT NULL,
	tr_usuario          CHAR (14) NOT NULL,
	tr_terminal         CHAR (30) NOT NULL,
	tr_fecha_ref        SMALLDATETIME NOT NULL,
	tr_secuencial_ref   INT NOT NULL,
	tr_estado           CHAR (10) NOT NULL,
	tr_observacion      CHAR (62) NOT NULL,
	tr_gerente          SMALLINT NOT NULL,
	tr_comprobante      INT NOT NULL,
	tr_fecha_cont       DATETIME NOT NULL,
	tr_gar_admisible    CHAR (1) NOT NULL,
	tr_reestructuracion CHAR (1) NOT NULL,
	tr_calificacion     CHAR (1) NOT NULL,
	tr_fecha_real       DATETIME
	)
GO


IF OBJECT_ID ('dbo.ca_traslado_interes') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes
GO

CREATE TABLE dbo.ca_traslado_interes
	(
	ti_operacion     INT NOT NULL,
	ti_cuota_orig    SMALLINT NOT NULL,
	ti_cuota_dest    SMALLINT NOT NULL,
	ti_usuario       VARCHAR (30) NOT NULL,
	ti_fecha_ingreso DATETIME NOT NULL,
	ti_terminal      VARCHAR (30) NOT NULL,
	ti_estado        CHAR (1) NOT NULL,
	ti_monto         MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_traslado_interes_his') IS NOT NULL
	DROP TABLE dbo.ca_traslado_interes_his
GO

CREATE TABLE dbo.ca_traslado_interes_his
	(
	tih_secuencial    INT NOT NULL,
	tih_operacion     INT NOT NULL,
	tih_cuota_orig    SMALLINT NOT NULL,
	tih_cuota_dest    SMALLINT NOT NULL,
	tih_usuario       VARCHAR (30) NOT NULL,
	tih_fecha_ingreso DATETIME NOT NULL,
	tih_terminal      VARCHAR (30) NOT NULL,
	tih_estado        CHAR (1) NOT NULL,
	tih_monto         MONEY NOT NULL
	)
GO


create index ca_traslado_interes_his_1
  on dbo.ca_traslado_interes_his (tih_operacion, tih_secuencial)
go
------
IF OBJECT_ID ('dbo.ca_ultima_tasa_op_his') IS NOT NULL
	DROP TABLE dbo.ca_ultima_tasa_op_his
GO

CREATE TABLE dbo.ca_ultima_tasa_op_his
	(
	uth_secuencial            INT NOT NULL,
	uth_operacion             INT NOT NULL,
	uth_concepto              catalogo NOT NULL,
	uth_referencial           catalogo NOT NULL,
	uth_signo                 CHAR (1) NOT NULL,
	uth_factor                FLOAT NOT NULL,
	uth_reajuste_especial     CHAR (1) NOT NULL,
	uth_tipo_puntos           CHAR (1) NOT NULL,
	uth_fecha_pri_referencial DATETIME NOT NULL,
	uth_fecha_act             DATETIME NOT NULL
	)
GO

CREATE INDEX ca_ultima_tasa_op_his_1
	ON dbo.ca_ultima_tasa_op_his (uth_operacion, uth_secuencial)
GO


IF OBJECT_ID ('dbo.ca_valor_atx_his') IS NOT NULL
	DROP TABLE dbo.ca_valor_atx_his
GO

CREATE TABLE dbo.ca_valor_atx_his
	(
	vxh_fecha_proceso   DATETIME,
	vxh_fecha_operacion DATETIME,
	vxh_operacion       INT,
	vxh_monto           MONEY,
	vxh_monto_max       MONEY,
	vxh_moneda          TINYINT,
	vxh_valor_vencido   MONEY,
	vxh_cotizacion      FLOAT,
	vxh_tipo_cobro      CHAR (1)
	)
GO


IF OBJECT_ID ('dbo.ca_valores') IS NOT NULL
	DROP TABLE dbo.ca_valores
GO

CREATE TABLE dbo.ca_valores
	(
	va_operacion INT NOT NULL,
	va_dividendo INT NOT NULL,
	va_rubro     CHAR (10) NOT NULL,
	va_valor     MONEY NOT NULL
	)
GO


IF OBJECT_ID ('dbo.ca_valores_his') IS NOT NULL
	DROP TABLE dbo.ca_valores_his
GO

CREATE TABLE dbo.ca_valores_his
    (
    vah_secuencial INT NOT NULL,
    vah_operacion  INT NOT NULL,
    vah_dividendo  INT NOT NULL,
    vah_rubro      catalogo NOT NULL,
    vah_valor      MONEY NOT NULL
    )
GO
create index ca_valores_his_1
    on dbo.ca_valores_his (vah_operacion, vah_secuencial)
go

IF OBJECT_ID ('dbo.CONTROL_BATCH') IS NOT NULL
	DROP TABLE dbo.CONTROL_BATCH
GO

CREATE TABLE dbo.CONTROL_BATCH
	(
	CONTROL CHAR (5) NOT NULL
	)
GO


IF OBJECT_ID ('dbo.tmp_interes_amortiza_tmp') IS NOT NULL
	DROP TABLE dbo.tmp_interes_amortiza_tmp
GO

CREATE TABLE dbo.tmp_interes_amortiza_tmp
	(
	cuota    SMALLINT,
	monto    MONEY,
	concepto catalogo,
	tasa     FLOAT,
	spid     INT
	)
GO



IF OBJECT_ID ('dbo.ca_comision_diferida_his') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida_his
GO

CREATE TABLE dbo.ca_comision_diferida_his
	(
	cdh_secuencial INT NOT NULL,
	cdh_operacion  INT NOT NULL,
	cdh_concepto   catalogo NOT NULL,
	cdh_cuota      MONEY NOT NULL,
	cdh_acumulado  MONEY NULL,
	cdh_estado     TINYINT NULL,
	cdh_cod_valor  INT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida_his1
	ON dbo.ca_comision_diferida_his (cdh_operacion,cdh_secuencial,cdh_concepto)
GO


IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_his
GO

CREATE TABLE dbo.ca_seguros_his
	(
	seh_secuencial     INT NULL,
	seh_sec_seguro     INT NULL,
	seh_tipo_seguro    INT NULL,
	seh_sec_renovacion INT NULL,
	seh_tramite        INT NULL,
	seh_operacion      INT NULL,
	seh_fec_devolucion DATETIME NULL,
	seh_mto_devolucion MONEY NULL,
	seh_estado         CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_his (seh_operacion,seh_secuencial)
GO


IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his
GO

CREATE TABLE dbo.ca_seguros_det_his
	(
	sedh_secuencial     INT NULL,
	sedh_operacion      INT NULL,
	sedh_sec_seguro     INT NULL,
	sedh_tipo_seguro    INT NULL,
	sedh_sec_renovacion INT NULL,
	sedh_tipo_asegurado INT NULL,
	sedh_estado         INT NULL,
	sedh_dividendo      INT NULL,
	sedh_cuota_cap      MONEY NULL,
	sedh_pago_cap       MONEY NULL,
	sedh_cuota_int      MONEY NULL,
	sedh_pago_int       MONEY NULL,
	sedh_cuota_mora     MONEY NULL,
	sedh_pago_mora      MONEY NULL,
	sedh_sec_asegurado  INT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_det_his (sedh_operacion,sedh_secuencial)
GO


IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can_his
GO

CREATE TABLE dbo.ca_seguros_can_his
	(
	sech_secuencial     INT NULL,
	sech_sec_seguro     INT NULL,
	sech_tipo_seguro    INT NULL,
	sech_sec_renovacion INT NULL,
	sech_tramite        INT NULL,
	sech_operacion      INT NULL,
	sech_fec_can        DATETIME NULL,
	sech_sec_pag        INT NULL
	)
GO

CREATE NONCLUSTERED INDEX idx_1
	ON dbo.ca_seguros_can_his (sech_operacion,sech_secuencial)
GO




IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his
GO

CREATE TABLE dbo.ca_operacion_ext_his
	(
	oeh_secuencial   INT NOT NULL,
	oeh_operacion    INT NOT NULL,
	oeh_columna      VARCHAR (30) NOT NULL,
	oeh_char         VARCHAR (30) NULL,
	oeh_tinyint      TINYINT NULL,
	oeh_smallint     SMALLINT NULL,
	oeh_int          INT NULL,
	oeh_money        MONEY NULL,
	oeh_datetime     DATETIME NULL,
	oeh_estado       VARCHAR (12) NULL,
	oeh_tinyInteger  TINYINT NULL,
	oeh_smallInteger INT NULL,
	oeh_integer      INT NULL,
	oeh_float        FLOAT NULL
	)
GO

create index ca_operacion_ext_his_1
  on dbo.ca_operacion_ext_his (oeh_operacion, oeh_secuencial)
go
---

IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO

CREATE TABLE dbo.ca_diferidos_his
	(
	difh_secuencial     INT NOT NULL,
	difh_operacion      INT NOT NULL,
	difh_valor_diferido MONEY NOT NULL,
	difh_valor_pagado   MONEY NOT NULL,
	difh_concepto       catalogo NOT NULL
	)
GO

CREATE NONCLUSTERED INDEX idxh1
	ON dbo.ca_diferidos_his (difh_operacion,difh_secuencial)
GO


-- Crecion de las tablas de caso 140636

DROP TABLE ca_ns_sms_cobranzas_his
CREATE TABLE [dbo].[ca_ns_sms_cobranzas_his]  ( 
	[nsc_dia]      	    tinyint NOT NULL,
	[nsc_operacion]	    int NOT NULL,
	[nsc_cliente]  	    int NULL,
	[nsc_num_telf] 	    varchar(12) NULL,
	[nsc_bloque]   	    int NULL,
	[nsc_plantilla]	    varchar(25) NULL,
    [nsc_grupo]	        int NULL,
	[nsc_fecha_ing]		datetime NULL,
    [nsc_fecha_ven]     datetime NULL,
    [nsc_rol_cliente]   varchar(10) NULL,
    [nsc_estado]        char(1) NULL,
    [nsc_fecha_env]     date NULL,

)

create index idx1 on ca_ns_sms_cobranzas_his(nsc_dia,nsc_operacion,nsc_fecha_env)
create index idx2 on ca_ns_sms_cobranzas_his(nsc_estado)



GO

DROP TABLE ca_ns_sms_recordatorios_his
CREATE TABLE [dbo].[ca_ns_sms_recordatorios_his]  ( 
	[nsr_operacion]    	int NULL,
	[nsr_cliente]      	int NULL,
	[nsr_num_telf]     	varchar(12) NULL,
	[nsr_bloque]       	int NULL,
	[nsr_plantilla]    	varchar(25) NULL,
	[nsr_grupo]        	int NULL,
    [nsr_num_dia]     	int NULL,
	[nsr_fecha_ejec]   	date NULL,
    [nsr_nom_dia]       varchar(25),
	[nsr_fecha_ven_hab]	date NULL,
	[nsr_rol_cliente]  	varchar(10) NULL,
	[nsc_fecha_ing]     datetime null,
	[nsr_estado]       	char(1) NULL,
	[nsr_fecha_env]    	datetime NULL 
	)

create index idx1_sms_recordatorio_his on ca_ns_sms_recordatorios_his(nsr_estado,nsc_fecha_ing,nsr_fecha_env,nsr_operacion,nsr_cliente)



GO


if exists (select 1 from sysobjects where name = 'ca_seguro_externo_his')
   drop table ca_seguro_externo_his
go

create table ca_seguro_externo_his (
   seh_secuencial          INT identity (1,1),
   seh_operacion           char(1),
   seh_fecha               datetime,
   seh_usuario             varchar(14),
   seh_terminal            varchar(64),
   seh_banco               varchar(24)  NULL,
   seh_cliente             INT          NULL,
   seh_fecha_ini           DATETIME     NULL,
   seh_fecha_ult_intento   DATETIME     NULL,
   seh_monto               MONEY        NULL,
   seh_estado              CHAR (1)     NULL,
   seh_fecha_reporte       DATETIME     NULL,
   seh_tramite             INT          NULL,
   seh_grupo               INT          NULL,
   seh_monto_pagado        MONEY        NULL,
   seh_monto_devuelto      MONEY        NULL,
   seh_forma_pago          varchar (16) NULL,
   seh_tipo_seguro         varchar (16) NULL,
   seh_monto_basico        MONEY        NULL
   
)


create index idx_1 on ca_seguro_externo_his (seh_tramite, seh_cliente, seh_secuencial)
create index idx_2 on ca_seguro_externo_his (seh_tramite)
go

