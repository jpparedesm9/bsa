--GRUPAL
--sb_estcta_cab_tmp where ec_secuencial = @i_secuencial AND ec_operacion = @i_banco
--sb_info_cre_tmp where ic_secuencial = @i_secuencial
--sb_amortizacion_tmp where am_secuencial = @i_secuencial
--sb_dato_operacion_abono_temp where doa_banco = @i_banco
--sb_movimientos_tmp where mov_secuencial = @i_secuencial --- ParaCaso #148652 + caso #146792, al reejecutar se suma el valor anterior al actual. 

-----------------------------------------------
-----------------------------------------------
USE cob_conta_super
GO
------------------------***********------------------------
------------------------***********------------------------
--sb_estcta_cab_tmp-1
IF OBJECT_ID ('dbo.sb_estcta_cab_tmp') IS NOT NULL
	DROP TABLE dbo.sb_estcta_cab_tmp
GO

CREATE TABLE dbo.sb_estcta_cab_tmp
	(
	ec_secuencial              INT,
	ec_cod_sucursal            INT,
	ec_sucursal                VARCHAR (100),
	ec_producto                VARCHAR (100),
	ec_nombre_cliente          VARCHAR (100),
	ec_cod_grupo               INT,
	ec_nom_grupo               VARCHAR (100),
	ec_rfc                     VARCHAR (30),
	ec_operacion               VARCHAR (30),
	ec_calle                   VARCHAR (70),
	ec_numero                  INT,
	ec_parroquia               VARCHAR (100),
	ec_delegacion              VARCHAR (100),
	ec_codigo_postal           VARCHAR (64),
	ec_estado                  VARCHAR (64),
	ec_fecha_inicio            VARCHAR (10),
	ec_fecha_reporte           VARCHAR (10),
	ec_dia_habil               VARCHAR (10),
	ec_importes                VARCHAR (40),
	ec_folio_fiscal            VARCHAR (1500),
	ec_certificado             VARCHAR (1500),
	ec_sello_digital           VARCHAR (1500),
	ec_sello_sat               VARCHAR (1500),
	ec_no_de_serie_certificado VARCHAR (1500),
	ec_fecha_certificacion     VARCHAR (20),
	ec_cadena_origial_sat      VARCHAR (1500),
	ec_estado_op               VARCHAR (20)
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_estcta_cab_tmp (ec_secuencial)
GO

------------------------***********------------------------
------------------------***********------------------------
--sb_info_cre_tmp
IF OBJECT_ID ('dbo.sb_info_cre_tmp') IS NOT NULL
	DROP TABLE dbo.sb_info_cre_tmp
GO

CREATE TABLE dbo.sb_info_cre_tmp
	(
	ic_secuencial        INT,
	ic_limite_credito    MONEY,
	ic_saldo_inicial     MONEY,
	ic_interes_ordinario MONEY,
	ic_total_credito     MONEY,
	ic_capital           MONEY,
	ic_interes_par       MONEY,
	ic_iva_interes       MONEY,
	ic_total_parcial     MONEY,
	ic_base_calculo      MONEY,
	ic_saldo_final_cap   MONEY,
	ic_estado            VARCHAR (64),
	ic_fecha_inicio      VARCHAR (10),
	ic_fecha_fin         VARCHAR (10),
	ic_frecuencia_pago   VARCHAR (64),
	ic_plazo             INT,
	ic_dia_pago          VARCHAR (30),
	ic_tasa_ordinaria    FLOAT,
	ic_tasa_mensual      FLOAT,
	ic_dep_garantias     MONEY,
	ic_fec_dep_garantias VARCHAR (10),
	ic_cat               FLOAT,
	ic_comisiones        MONEY
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_info_cre_tmp (ic_secuencial)
GO

------------------------***********------------------------
------------------------***********------------------------
--sb_amortizacion_tmp--12
IF OBJECT_ID ('dbo.sb_amortizacion_tmp') IS NOT NULL
	DROP TABLE dbo.sb_amortizacion_tmp
GO

CREATE TABLE dbo.sb_amortizacion_tmp
	(
	am_secuencial     INT,
	am_numero         INT,
	am_fecha          DATETIME,
	am_capital        MONEY,
	am_interes_ordina MONEY,
	am_iva_int        MONEY,
	am_comision_cob   MONEY,
	am_iva_comision   MONEY,
	am_monto_pago     MONEY,
	am_saldo_capital  MONEY,
	am_pago_total     MONEY
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_amortizacion_tmp (am_secuencial)
GO

------------------------***********------------------------
------------------------***********------------------------
--sb_dato_operacion_abono_temp--73
IF OBJECT_ID ('dbo.sb_dato_operacion_abono_temp') IS NOT NULL
	DROP TABLE dbo.sb_dato_operacion_abono_temp
GO

CREATE TABLE dbo.sb_dato_operacion_abono_temp
	(
	doa_sec            INT IDENTITY (0,1) NOT NULL,
	doa_fecha_ope      DATETIME,
	doa_fecha_pac      DATETIME,
	doa_num_pago       INT,
	doa_dias_atra      INT,
	doa_detalle_mov    VARCHAR (100),
	doa_total          MONEY,
	doa_cap            MONEY,
	doa_inte_ord       MONEY,
	doa_gasto_cobranza MONEY,
	doa_saldo_cap      MONEY,
	doa_banco          VARCHAR (32),
	doa_fecha          DATETIME
	)
GO


------------------------***********------------------------
------------------------***********------------------------
--sb_movimientos_tmp
IF OBJECT_ID ('dbo.sb_movimientos_tmp') IS NOT NULL
	DROP TABLE dbo.sb_movimientos_tmp
GO

CREATE TABLE dbo.sb_movimientos_tmp
	(
	mov_secuencial     INT,
	mov_numero         INT,
	mov_fecha          DATETIME,
	mov_fecha_pactada  DATETIME,
	mov_numero_pago    INT,
	mov_dias_atraso    INT,
	mov_detalle_mov    VARCHAR (100),
	mov_total          MONEY,
	mov_capital        MONEY,
	mov_interes_ordina MONEY,
	mov_interes_mora   MONEY,
	mov_iva_int_pag    MONEY,
	mov_iva_imo_pag    MONEY,
	mov_iva_pre_pag    MONEY,
	mov_comision_cob   MONEY,
	mov_otros          MONEY,
	mov_saldo_capital  MONEY,
	mov_dividendo      INT
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_movimientos_tmp (mov_secuencial)
GO

PRINT 'fin creacion tablas temporales grupales'
------------------------***********------------------------
------------------------***********------------------------
-----REVOLVENTE
------------------------***********------------------------
USE cob_conta_super
GO
--sb_estcta_cab_tmp_lcr
--sb_info_cre_tmp_lcr
--sb_resumen_pagos_tmp_lcr
--sb_dato_operacion_abono_temp_lcr
------------------------***********------------------------
------------------------***********------------------------
--sb_estcta_cab_tmp_lcr
IF OBJECT_ID ('dbo.sb_estcta_cab_tmp_lcr') IS NOT NULL
	DROP TABLE dbo.sb_estcta_cab_tmp_lcr
GO

CREATE TABLE dbo.sb_estcta_cab_tmp_lcr
	(
	ec_secuencial              INT,
	ec_cod_sucursal            INT,
	ec_sucursal                VARCHAR (100),
	ec_producto                VARCHAR (100),
	ec_nombre_cliente          VARCHAR (100),
	ec_cod_grupo               INT,
	ec_nom_grupo               VARCHAR (100),
	ec_rfc                     VARCHAR (30),
	ec_operacion               VARCHAR (30),
	ec_calle                   VARCHAR (70),
	ec_numero                  INT,
	ec_parroquia               VARCHAR (100),
	ec_delegacion              VARCHAR (100),
	ec_codigo_postal           VARCHAR (64),
	ec_estado                  VARCHAR (64),
	ec_fecha_inicio            VARCHAR (10),
	ec_fecha_reporte           VARCHAR (10),
	ec_dia_habil               VARCHAR (10),
	ec_importes                VARCHAR (40),
	ec_folio_fiscal            VARCHAR (1500),
	ec_certificado             VARCHAR (1500),
	ec_sello_digital           VARCHAR (1500),
	ec_sello_sat               VARCHAR (1500),
	ec_no_de_serie_certificado VARCHAR (1500),
	ec_fecha_certificacion     VARCHAR (20),
	ec_cadena_origial_sat      VARCHAR (1500),
	ec_estado_op               VARCHAR (20)
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_estcta_cab_tmp_lcr (ec_secuencial)
GO


------------------------***********------------------------
------------------------***********------------------------
--sb_info_cre_tmp_lcr
IF OBJECT_ID ('dbo.sb_info_cre_tmp_lcr') IS NOT NULL
	DROP TABLE dbo.sb_info_cre_tmp_lcr
GO

CREATE TABLE dbo.sb_info_cre_tmp_lcr
	(
	ic_secuencial          INT,
	ic_fecha_inicio        DATETIME,
	ic_fecha_fin           DATETIME,
	ic_linea_credito       MONEY,
	ic_linea_disponible    MONEY,
	ic_capital             MONEY,
	ic_interes_ordinario   MONEY,
	ic_iva_int_ortdinario  MONEY,
	ic_comision_gastos     MONEY,
	ic_iva_comision_gastos MONEY,
	ic_total               MONEY,
	ic_frecuencia_pago     VARCHAR (64),
	ic_plazo               INT,
	ic_dia_pago            VARCHAR (30),
	ic_tasa_ordinaria      FLOAT,
	ic_tasa_mensual        FLOAT,
	ic_base_calc_int       MONEY,
	ic_cat                 FLOAT,
	ic_comisiones          MONEY
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_info_cre_tmp_lcr (ic_secuencial)
GO


------------------------***********------------------------
------------------------***********------------------------
--sb_resumen_pagos_tmp_lcr
IF OBJECT_ID ('dbo.sb_resumen_pagos_tmp_lcr') IS NOT NULL
	DROP TABLE dbo.sb_resumen_pagos_tmp_lcr
GO

CREATE TABLE dbo.sb_resumen_pagos_tmp_lcr
	(
	rt_secuencial            INT,
	rt_total_pagos           MONEY,
	rt_capital               MONEY,
	rt_int_Ord               MONEY,
	rt_iva_Int_Ord           MONEY,
	rt_gastos_cobranza       MONEY,
	rt_iva_gastos_cobranza   MONEY,
	rt_num_disposiciones     INT,
	rt_importe_disposiciones MONEY,
	rt_importe_total_com     MONEY,
	rt_fecha_cobro_cobranza  VARCHAR (10),
	rt_importe_total_dispos  MONEY,
	rt_fecha_cobro_dispos    VARCHAR (10)
	)
GO

CREATE CLUSTERED INDEX idx_1
	ON dbo.sb_resumen_pagos_tmp_lcr (rt_secuencial)
GO


------------------------***********------------------------
------------------------***********------------------------
--sb_dato_operacion_abono_temp_lcr
IF OBJECT_ID ('dbo.sb_dato_operacion_abono_temp_lcr') IS NOT NULL
	DROP TABLE dbo.sb_dato_operacion_abono_temp_lcr
GO

CREATE TABLE dbo.sb_dato_operacion_abono_temp_lcr
	(
	doa_sec              INT IDENTITY NOT NULL,
	doa_fecha_ope        VARCHAR (10),
	doa_fecha_pac        VARCHAR (10),
	doa_detalle_mov      VARCHAR (100),
	doa_cap              MONEY,
	doa_inte_ord         MONEY,
	doa_iva_int          MONEY,
	doa_comision_dis     MONEY,
	doa_iva_comision_dis MONEY,
	doa_comision_cob     MONEY,
	doa_iva_comision_cob MONEY,
	doa_total            MONEY,
	doa_saldo_cap        MONEY,
	doa_banco            VARCHAR (32),
	doa_fecha            DATETIME,
	doa_num_pago         INT,
	doa_tipo_trn         VARCHAR (10)
	)
GO

PRINT 'fin creacion tablas temporales revolventes'