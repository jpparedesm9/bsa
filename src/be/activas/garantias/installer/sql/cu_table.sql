USE cob_custodia
GO

IF OBJECT_ID ('dbo.tmp_cliente') IS NOT NULL
	DROP TABLE dbo.tmp_cliente
GO

CREATE TABLE dbo.tmp_cliente
	(
	cedula  VARCHAR (30),
	credito VARCHAR (24)
	)
GO

IF OBJECT_ID ('dbo.garantias') IS NOT NULL
	DROP TABLE dbo.garantias
GO

CREATE TABLE dbo.garantias
	(
	codigo        VARCHAR (64) NOT NULL,
	valor_inicial MONEY NOT NULL,
	valor_actual  MONEY NOT NULL,
	moneda        TINYINT NOT NULL,
	filial        TINYINT NOT NULL,
	sucursal      SMALLINT NOT NULL,
	tipo          VARCHAR (20) NOT NULL,
	custodia      INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_vencimiento_tmp') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento_tmp
GO

CREATE TABLE dbo.cu_vencimiento_tmp
	(
	vt_filial            TINYINT NOT NULL,
	vt_sucursal          SMALLINT NOT NULL,
	vt_tipo_cust         descripcion NOT NULL,
	vt_custodia          INT NOT NULL,
	vt_vencimiento       SMALLINT NOT NULL,
	vt_fecha             DATETIME,
	vt_valor             FLOAT NOT NULL,
	vt_instruccion       VARCHAR (255),
	vt_sujeto_cobro      CHAR (1),
	vt_num_factura       VARCHAR (20),
	vt_cta_debito        ctacliente,
	vt_mora              MONEY,
	vt_comision          MONEY,
	vt_codigo_externo    VARCHAR (64) NOT NULL,
	vt_estado_colateral  CHAR (1),
	vt_fecha_salida      DATETIME,
	vt_fecha_retorno     DATETIME,
	vt_destino_colateral catalogo,
	vt_segmento          catalogo,
	vt_procesado         login,
	vt_cotizacion        FLOAT,
	vt_beneficiario      VARCHAR (64),
	vt_emisor            VARCHAR (64),
	vt_fecha_emision     DATETIME,
	vt_tasa              VARCHAR (10),
	vt_sesion            INT,
	vt_ente              INT
	)
GO

CREATE UNIQUE INDEX cu_vencimiento_tmp_Key
	ON dbo.cu_vencimiento_tmp (vt_codigo_externo, vt_vencimiento)
GO

IF OBJECT_ID ('dbo.cu_vencimiento_mig') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento_mig
GO

CREATE TABLE dbo.cu_vencimiento_mig
	(
	vm_user              login NOT NULL,
	vm_sesn              INT NOT NULL,
	vm_archivo           VARCHAR (30) NOT NULL,
	vm_filial            TINYINT,
	vm_sucursal          SMALLINT NOT NULL,
	vm_tipo_cust         VARCHAR (254) NOT NULL,
	vm_custodia          INT NOT NULL,
	vm_vencimiento       SMALLINT NOT NULL,
	vm_fecha             DATETIME NOT NULL,
	vm_valor             FLOAT NOT NULL,
	vm_instruccion       VARCHAR (255) NOT NULL,
	vm_sujeto_cobro      CHAR (1),
	vm_num_factura       VARCHAR (20),
	vm_cta_debito        VARCHAR (20),
	vm_mora              MONEY,
	vm_comision          MONEY,
	vm_codigo_externo    VARCHAR (64) NOT NULL,
	vm_estado_colateral  CHAR (1),
	vm_fecha_salida      DATETIME,
	vm_fecha_retorno     DATETIME,
	vm_destino_colateral catalogo,
	vm_segmento          catalogo,
	vm_procesado         login,
	vm_cotizacion        FLOAT,
	vm_beneficiario      VARCHAR (64) NOT NULL,
	vm_emisor            VARCHAR (64),
	vm_fecha_emision     DATETIME,
	vm_tasa              VARCHAR (10),
	vm_ente              INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_vencimiento') IS NOT NULL
	DROP TABLE dbo.cu_vencimiento
GO

CREATE TABLE dbo.cu_vencimiento
	(
	ve_filial            TINYINT NOT NULL,
	ve_sucursal          SMALLINT NOT NULL,
	ve_tipo_cust         descripcion NOT NULL,
	ve_custodia          INT NOT NULL,
	ve_vencimiento       SMALLINT NOT NULL,
	ve_fecha             DATETIME,
	ve_valor             FLOAT NOT NULL,
	ve_instruccion       VARCHAR (255),
	ve_sujeto_cobro      CHAR (1),
	ve_num_factura       VARCHAR (20),
	ve_cta_debito        ctacliente,
	ve_mora              MONEY,
	ve_comision          MONEY,
	ve_codigo_externo    VARCHAR (64) NOT NULL,
	ve_estado_colateral  CHAR (1),
	ve_fecha_salida      DATETIME,
	ve_fecha_retorno     DATETIME,
	ve_destino_colateral catalogo,
	ve_segmento          catalogo,
	ve_procesado         login,
	ve_cotizacion        FLOAT,
	ve_beneficiario      VARCHAR (64),
	ve_emisor            VARCHAR (64),
	ve_fecha_emision     DATETIME,
	ve_tasa              VARCHAR (10),
	ve_ente              INT
	)
GO

CREATE UNIQUE INDEX cu_vencimiento_Key
	ON dbo.cu_vencimiento (ve_codigo_externo, ve_vencimiento)
GO

IF OBJECT_ID ('dbo.cu_universo_pagares_col') IS NOT NULL
	DROP TABLE dbo.cu_universo_pagares_col
GO

CREATE TABLE dbo.cu_universo_pagares_col
	(
	un_banco        cuenta NOT NULL,
	un_toperacion   catalogo NOT NULL,
	un_cliente      INT NOT NULL,
	un_oficina      SMALLINT NOT NULL,
	un_monto        MONEY NOT NULL,
	un_tasa         FLOAT NOT NULL,
	un_calificacion VARCHAR (10) NOT NULL,
	un_fecha_ini    DATETIME NOT NULL,
	un_fecha_fin    DATETIME NOT NULL,
	un_saldo_cap    MONEY NOT NULL,
	un_saldo_int    MONEY NOT NULL,
	un_amor_cap     catalogo NOT NULL,
	un_amor_int     catalogo NOT NULL,
	un_ente_pas     INT NOT NULL,
	un_codigo_pas   cuenta NOT NULL,
	un_estado       CHAR (1) NOT NULL,
	un_nueva        CHAR (1) NOT NULL,
	un_orden        INT
	)
GO

CREATE UNIQUE INDEX cu_universo_pagares_col_1
	ON dbo.cu_universo_pagares_col (un_banco)
GO

CREATE INDEX cu_universo_pagares_col_2
	ON dbo.cu_universo_pagares_col (un_ente_pas, un_codigo_pas)
GO

CREATE INDEX cu_universo_pagares_col_3
	ON dbo.cu_universo_pagares_col (un_oficina, un_toperacion)
GO

IF OBJECT_ID ('dbo.cu_transaccion') IS NOT NULL
	DROP TABLE dbo.cu_transaccion
GO

CREATE TABLE dbo.cu_transaccion
	(
	tr_secuencial     INT NOT NULL,
	tr_codigo_externo VARCHAR (64) NOT NULL,
	tr_fecha_tran     DATETIME NOT NULL,
	tr_hora           VARCHAR (8) NOT NULL,
	tr_descripcion    descripcion,
	tr_usuario        login NOT NULL,
	tr_terminal       VARCHAR (30),
	tr_tran           catalogo NOT NULL,
	tr_oficina_orig   SMALLINT NOT NULL,
	tr_oficina_dest   SMALLINT NOT NULL,
	tr_estado         VARCHAR (3) NOT NULL,
	tr_estado_gar     CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_transaccion_Key
	ON dbo.cu_transaccion (tr_codigo_externo, tr_secuencial)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_transaccion_i2
	ON dbo.cu_transaccion (tr_fecha_tran, tr_tran, tr_oficina_orig)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cu_tran_servicio') IS NOT NULL
	DROP TABLE dbo.cu_tran_servicio
GO

CREATE TABLE dbo.cu_tran_servicio
	(
	ts_secuencial       INT NOT NULL,
	ts_tipo_transaccion SMALLINT NOT NULL,
	ts_clase            CHAR (1) NOT NULL,
	ts_fecha            DATETIME,
	ts_usuario          login,
	ts_terminal         descripcion,
	ts_correccion       CHAR (1),
	ts_ssn_corr         INT,
	ts_reentry          CHAR (1),
	ts_origen           CHAR (1),
	ts_nodo             VARCHAR (30),
	ts_remoto_ssn       INT,
	ts_oficina          INT,
	ts_lsrv             VARCHAR (30),
	ts_srv              VARCHAR (30),
	ts_tabla            VARCHAR (255),
	ts_tinyint1         TINYINT,
	ts_tinyint2         TINYINT,
	ts_tinyint3         TINYINT,
	ts_tinyint4         TINYINT,
	ts_tinyint5         TINYINT,
	ts_tinyint6         TINYINT,
	ts_tinyint7         TINYINT,
	ts_smallint1        SMALLINT,
	ts_smallint2        SMALLINT,
	ts_smallint3        SMALLINT,
	ts_smallint4        SMALLINT,
	ts_smallint5        SMALLINT,
	ts_smallint6        SMALLINT,
	ts_int1             INT,
	ts_int2             INT,
	ts_int3             INT,
	ts_int4             INT,
	ts_int5             INT,
	ts_int6             INT,
	ts_int7             INT,
	ts_int8             INT,
	ts_int9             INT,
	ts_int10            INT,
	ts_int11            INT,
	ts_int12            INT,
	ts_int13            INT,
	ts_int14            INT,
	ts_varchar1         VARCHAR (64),
	ts_varchar2         VARCHAR (64),
	ts_varchar3         VARCHAR (64),
	ts_varchar4         VARCHAR (64),
	ts_varchar5         VARCHAR (64),
	ts_varchar6         VARCHAR (64),
	ts_varchar7         VARCHAR (64),
	ts_varchar8         VARCHAR (64),
	ts_varchar9         VARCHAR (64),
	ts_varchar10        VARCHAR (64),
	ts_varchar11        VARCHAR (64),
	ts_varchar12        VARCHAR (64),
	ts_varchar13        VARCHAR (64),
	ts_varchar14        VARCHAR (64),
	ts_varchar15        VARCHAR (64),
	ts_varchar16        VARCHAR (64),
	ts_varchar17        VARCHAR (64),
	ts_varchar18        VARCHAR (64),
	ts_varchar19        VARCHAR (64),
	ts_varchar20        VARCHAR (64),
	ts_varchar21        VARCHAR (64),
	ts_varchar22        VARCHAR (64),
	ts_varchar23        VARCHAR (64),
	ts_varchar24        VARCHAR (64),
	ts_varchar25        VARCHAR (64),
	ts_varchar26        VARCHAR (64),
	ts_varchar27        VARCHAR (64),
	ts_varchar28        VARCHAR (64),
	ts_varchar29        VARCHAR (64),
	ts_varchar30        VARCHAR (64),
	ts_varchar31        VARCHAR (64),
	ts_varchar32        VARCHAR (64),
	ts_varchar33        VARCHAR (64),
	ts_varchar34        VARCHAR (64),
	ts_varchar35        VARCHAR (64),
	ts_varchar36        VARCHAR (64),
	ts_varchar37        VARCHAR (64),
	ts_varchar38        VARCHAR (64),
	ts_char1            CHAR (1),
	ts_char2            CHAR (1),
	ts_char3            CHAR (1),
	ts_char4            CHAR (1),
	ts_char5            CHAR (1),
	ts_char6            CHAR (1),
	ts_char7            CHAR (1),
	ts_char8            CHAR (1),
	ts_char9            CHAR (1),
	ts_char10           CHAR (1),
	ts_char11           CHAR (1),
	ts_char12           CHAR (1),
	ts_char13           CHAR (1),
	ts_char14           CHAR (1),
	ts_char15           CHAR (1),
	ts_char16           CHAR (1),
	ts_char17           CHAR (1),
	ts_money1           MONEY,
	ts_money2           MONEY,
	ts_money3           MONEY,
	ts_money4           MONEY,
	ts_money5           MONEY,
	ts_money6           MONEY,
	ts_money7           MONEY,
	ts_money8           MONEY,
	ts_datetime1        DATETIME,
	ts_datetime2        DATETIME,
	ts_datetime3        DATETIME,
	ts_datetime4        DATETIME,
	ts_datetime5        DATETIME,
	ts_datetime6        DATETIME,
	ts_datetime7        DATETIME,
	ts_datetime8        DATETIME,
	ts_datetime9        DATETIME,
	ts_datetime10       DATETIME,
	ts_datetime11       DATETIME,
	ts_datetime12       DATETIME,
	ts_datetime13       DATETIME,
	ts_datetime14       DATETIME,
	ts_datetime15       DATETIME,
	ts_datetime16       DATETIME,
	ts_datetime17       DATETIME,
	ts_datetime18       DATETIME,
	ts_datetime19       DATETIME,
	ts_datetime20       DATETIME,
	ts_datetime21       DATETIME,
	ts_datetime22       DATETIME,
	ts_datetime23       DATETIME,
	ts_datetime24       DATETIME,
	ts_datetime25       DATETIME,
	ts_datetime26       DATETIME,
	ts_datetime27       DATETIME,
	ts_datetime28       DATETIME,
	ts_datetime29       DATETIME,
	ts_float1           FLOAT,
	ts_float2           FLOAT,
	ts_float3           FLOAT,
	ts_float4           FLOAT,
	ts_float5           FLOAT,
	ts_float6           FLOAT,
	ts_float7           FLOAT,
	ts_float8           FLOAT,
	ts_descripcion1     descripcion,
	ts_descripcion2     descripcion,
	ts_descripcion3     descripcion,
	ts_cuenta1          cuenta,
	ts_cuenta2          cuenta,
	ts_login01          login,
	ts_fecha_real       DATETIME CONSTRAINT DF__cu_tran_s__ts_fe__72C60C4A DEFAULT (getdate())
	)
GO

CREATE INDEX cu_tran_servicio_key1
	ON dbo.cu_tran_servicio (ts_fecha)
GO

IF OBJECT_ID ('dbo.cu_tran_cust') IS NOT NULL
	DROP TABLE dbo.cu_tran_cust
GO

CREATE TABLE dbo.cu_tran_cust
	(
	trc_tran   catalogo NOT NULL,
	trc_perfil catalogo NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_tran_cust_Key
	ON dbo.cu_tran_cust (trc_tran)
GO

IF OBJECT_ID ('dbo.cu_totgar') IS NOT NULL
	DROP TABLE dbo.cu_totgar
GO

CREATE TABLE dbo.cu_totgar
	(
	to_codigo_externo VARCHAR (64) NOT NULL,
	to_tipo_cust      catalogo,
	to_estado         CHAR (1),
	to_valor_inicial  MONEY,
	to_porc_cobertura FLOAT,
	to_ubicacion      catalogo,
	to_desc_ubica     descripcion,
	to_valor_actual   MONEY,
	to_operacion      INT,
	to_op_banco       cuenta,
	to_cliente        INT NOT NULL,
	to_identific      VARCHAR (30),
	to_nombre         VARCHAR (64),
	to_saldo_cap      MONEY,
	to_saldo_xpag     MONEY,
	to_tipo_cobro     CHAR (1),
	to_oficina        INT,
	to_regional       INT,
	to_desc_oficina   descripcion,
	to_desc_regional  descripcion
	)
GO

CREATE INDEX cu_totgar_Akey
	ON dbo.cu_totgar (to_ubicacion, to_oficina, to_regional)
GO

CREATE INDEX cu_totgar_Bkey
	ON dbo.cu_totgar (to_estado)
GO

CREATE INDEX cu_totgar_Ckey
	ON dbo.cu_totgar (to_operacion)
GO

CREATE INDEX cu_totgar_Key
	ON dbo.cu_totgar (to_cliente)
GO

IF OBJECT_ID ('dbo.cu_tmp_valorcart') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valorcart
GO

CREATE TABLE dbo.cu_tmp_valorcart
	(
	tv_codigo_externo VARCHAR (64),
	tv_valor          MONEY,
	tv_clase          CHAR (1),
	tv_oficina        SMALLINT,
	tv_aplica         CHAR (1),
	tv_tipo           catalogo
	)
GO

CREATE INDEX cu_tmp_valorcart_key
	ON dbo.cu_tmp_valorcart (tv_codigo_externo)
GO

IF OBJECT_ID ('dbo.cu_tmp_valoracion') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valoracion
GO

CREATE TABLE dbo.cu_tmp_valoracion
	(
	tv_codigo_externo VARCHAR (64) NOT NULL,
	tv_valor          MONEY,
	tv_clase          CHAR (1),
	tv_oficina        SMALLINT,
	tv_reestruct      CHAR (1),
	tv_aplica         CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_valgarv') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valgarv
GO

CREATE TABLE dbo.cu_tmp_valgarv
	(
	tv_codigo_externo VARCHAR (64),
	tv_valor_ant      MONEY,
	tv_valor_nvo      MONEY,
	tv_ciudad         INT,
	tv_estrato        catalogo,
	tv_porcentaje     FLOAT
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_valgarnv') IS NOT NULL
	DROP TABLE dbo.cu_tmp_valgarnv
GO

CREATE TABLE dbo.cu_tmp_valgarnv
	(
	tv_codigo_externo VARCHAR (64),
	tv_valor_ant      MONEY,
	tv_valor_nvo      MONEY,
	tv_ciudad         INT,
	tv_porcentaje     FLOAT
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_transaccion') IS NOT NULL
	DROP TABLE dbo.cu_tmp_transaccion
GO

CREATE TABLE dbo.cu_tmp_transaccion
	(
	tipo        VARCHAR (10),
	secuencial  INT NOT NULL,
	usuario     VARCHAR (64),
	fecha       DATETIME,
	terminal    VARCHAR (30),
	oficina     SMALLINT,
	tabla       VARCHAR (255) NOT NULL,
	transaccion VARCHAR (64),
	codigo      VARCHAR (64) NOT NULL,
	cliente     INT NOT NULL,
	sesion      INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_transaccion_AKey
	ON dbo.cu_tmp_transaccion (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_prenhi') IS NOT NULL
	DROP TABLE dbo.cu_tmp_prenhi
GO

CREATE TABLE dbo.cu_tmp_prenhi
	(
	oficina        SMALLINT,
	ente           INT,
	cg_nombre      descripcion,
	cu_tipo        VARCHAR (64),
	descripcion    descripcion,
	custodia       INT,
	codigo_externo VARCHAR (64),
	valor_inicial  MONEY,
	fecha_ingreso  VARCHAR (15),
	fecha_vcto     VARCHAR (15),
	estado         descripcion
	)
GO

CREATE INDEX cu_tmp_prenhi_Key
	ON dbo.cu_tmp_prenhi (oficina)
GO

IF OBJECT_ID ('dbo.cu_tmp_operaciones') IS NOT NULL
	DROP TABLE dbo.cu_tmp_operaciones
GO

CREATE TABLE dbo.cu_tmp_operaciones
	(
	to_tramite    INT,
	to_producto   catalogo,
	to_estado     CHAR (1),
	to_agotada    CHAR (1),
	to_tr_origen  INT,
	to_gar_origen VARCHAR (64),
	to_sesion     INT
	)
GO

CREATE INDEX cu_tmp_operaciones_Key
	ON dbo.cu_tmp_operaciones (to_sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_operacion_cerrada') IS NOT NULL
	DROP TABLE dbo.cu_tmp_operacion_cerrada
GO

CREATE TABLE dbo.cu_tmp_operacion_cerrada
	(
	oc_producto      CHAR (3) NOT NULL,
	oc_operacion     VARCHAR (24) NOT NULL,
	oc_moneda        TINYINT NOT NULL,
	oc_valor_inicial MONEY NOT NULL,
	oc_valor_actual  MONEY NOT NULL,
	oc_fecha_venc    DATETIME NOT NULL,
	sesion           INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_operacion_cerrada_key
	ON dbo.cu_tmp_operacion_cerrada (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_obs_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_tmp_obs_inspecci
GO

CREATE TABLE dbo.cu_tmp_obs_inspecci
	(
	to_usuario        login NOT NULL,
	to_sesion         INT NOT NULL,
	to_codigo_externo VARCHAR (64) NOT NULL,
	to_condicion      SMALLINT NOT NULL,
	to_linea          SMALLINT,
	to_texto          VARCHAR (255) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_grupos') IS NOT NULL
	DROP TABLE dbo.cu_tmp_grupos
GO

CREATE TABLE dbo.cu_tmp_grupos
	(
	Ente             INT NOT NULL,
	Producto         VARCHAR (64) NOT NULL,
	Valor            MONEY NOT NULL,
	porcen_cobertura FLOAT NOT NULL,
	sesion           INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_grupos_key
	ON dbo.cu_tmp_grupos (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_garantia') IS NOT NULL
	DROP TABLE dbo.cu_tmp_garantia
GO

CREATE TABLE dbo.cu_tmp_garantia
	(
	tg_codigo_externo  VARCHAR (64),
	tg_estado          catalogo,
	tg_abierta_cerrada CHAR (1),
	tg_agotada         CHAR (1),
	tg_tr_origen       INT,
	tg_sesion          INT
	)
GO

CREATE INDEX cu_tmp_garantia_Key
	ON dbo.cu_tmp_garantia (tg_sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_gar_op') IS NOT NULL
	DROP TABLE dbo.cu_tmp_gar_op
GO

CREATE TABLE dbo.cu_tmp_gar_op
	(
	tgo_ssn          INT,
	tgo_tramite      INT,
	tgo_producto     catalogo,
	tgo_garantia     VARCHAR (64),
	tgo_porcentaje   FLOAT,
	tgo_valor_resp   FLOAT,
	tgo_disponible   FLOAT,
	tgo_pago         CHAR (1),
	tgo_moneda       TINYINT,
	tgo_valor_actual FLOAT
	)
GO

CREATE INDEX cu_tmp_gar_op_key
	ON dbo.cu_tmp_gar_op (tgo_ssn)
GO

CREATE INDEX cu_tmp_gar_op_key_2
	ON dbo.cu_tmp_gar_op (tgo_garantia)
GO

IF OBJECT_ID ('dbo.cu_tmp_gar_adm') IS NOT NULL
	DROP TABLE dbo.cu_tmp_gar_adm
GO

CREATE TABLE dbo.cu_tmp_gar_adm
	(
	garantia  VARCHAR (64),
	admisible CHAR (1),
	valor     MONEY,
	sesion    INT
	)
GO

CREATE INDEX cu_tmp_gar_adm_key
	ON dbo.cu_tmp_gar_adm (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_finagro') IS NOT NULL
	DROP TABLE dbo.cu_tmp_finagro
GO

CREATE TABLE dbo.cu_tmp_finagro
	(
	cu_num_dcto_tmp       VARCHAR (13),
	cu_estado_tmp         catalogo,
	cu_codigo_externo_tmp VARCHAR (64),
	cu_tramite_tmp        INT
	)
GO

CREATE INDEX cu_tmp_finagro_key
	ON dbo.cu_tmp_finagro (cu_tramite_tmp)
GO

CREATE INDEX cu_tmp_finagro_key1
	ON dbo.cu_tmp_finagro (cu_num_dcto_tmp)
GO

IF OBJECT_ID ('dbo.cu_tmp_documentos') IS NOT NULL
	DROP TABLE dbo.cu_tmp_documentos
GO

CREATE TABLE dbo.cu_tmp_documentos
	(
	valor     FLOAT NOT NULL,
	fecha_vto DATETIME,
	moneda    INT,
	fecha_dex DATETIME,
	fecha_bl  DATETIME,
	proveedor INT NOT NULL,
	sesion    INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_documentos_key
	ON dbo.cu_tmp_documentos (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_custodia') IS NOT NULL
	DROP TABLE dbo.cu_tmp_custodia
GO

CREATE TABLE dbo.cu_tmp_custodia
	(
	cu_idconn            INT NOT NULL,
	cu_filial            TINYINT NOT NULL,
	cu_sucursal          SMALLINT NOT NULL,
	cu_custodia          INT NOT NULL,
	cu_tipo              descripcion NOT NULL,
	cu_estado            catalogo,
	cu_fecha_ingreso     DATETIME,
	cu_moneda            TINYINT,
	cu_valor_inicial     FLOAT,
	cu_valor_actual      FLOAT,
	cu_codigo_externo    VARCHAR (64) NOT NULL,
	cu_valor_cobertura   FLOAT,
	cg_ente              INT NOT NULL,
	cg_oficial           INT,
	cg_nombre            VARCHAR (64),
	cu_fecha_desde       DATETIME,
	cu_fecha_hasta       DATETIME,
	cu_oficina           SMALLINT,
	cu_fecha_vencimiento DATETIME
	)
GO

CREATE INDEX cu_tmp_custodia_Key
	ON dbo.cu_tmp_custodia (cu_idconn)
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_monedagar') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_monedagar
GO

CREATE TABLE dbo.cu_tmp_cotizacion_monedagar
	(
	moneda     TINYINT NOT NULL,
	cotizacion FLOAT,
	sesion     INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_cotizacion_moneda_key
	ON dbo.cu_tmp_cotizacion_monedagar (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_moneda06') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_moneda06
GO

CREATE TABLE dbo.cu_tmp_cotizacion_moneda06
	(
	moneda     TINYINT,
	cotizacion MONEY,
	sesion     INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_cotizacion_moneda06_k
	ON dbo.cu_tmp_cotizacion_moneda06 (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_cotizacion_moneda') IS NOT NULL
	DROP TABLE dbo.cu_tmp_cotizacion_moneda
GO

CREATE TABLE dbo.cu_tmp_cotizacion_moneda
	(
	moneda     MONEY NOT NULL,
	cotizacion MONEY NOT NULL,
	sesion     INT NOT NULL
	)
GO

CREATE INDEX cu_tmp_cotizacion_moneda_key
	ON dbo.cu_tmp_cotizacion_moneda (sesion)
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_mes') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_mes
GO

CREATE TABLE dbo.cu_tmp_contagar_mes
	(
	tc_oficina        INT NOT NULL,
	tc_tipo_bien      CHAR (1) NOT NULL,
	tc_op_clase       CHAR (1) NOT NULL,
	tc_moneda         INT NOT NULL,
	tc_calificacion   CHAR (1) NOT NULL,
	tc_clase_custodia CHAR (1) NOT NULL,
	tc_tipo           descripcion,
	tc_codvalor       INT NOT NULL,
	tc_valor          MONEY NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_det_mes') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_det_mes
GO

CREATE TABLE dbo.cu_tmp_contagar_det_mes
	(
	tc_oficina        INT NOT NULL,
	tc_tipo_bien      CHAR (1) NOT NULL,
	tc_op_clase       CHAR (1) NOT NULL,
	tc_moneda         INT NOT NULL,
	tc_calificacion   CHAR (1) NOT NULL,
	tc_clase_custodia CHAR (1) NOT NULL,
	tc_tipo           descripcion,
	tc_codvalor       INT NOT NULL,
	tc_valor          MONEY NOT NULL,
	tc_codigo_externo cuenta
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar_det') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar_det
GO

CREATE TABLE dbo.cu_tmp_contagar_det
	(
	tc_oficina        INT NOT NULL,
	tc_tipo_bien      CHAR (1) NOT NULL,
	tc_op_clase       CHAR (1) NOT NULL,
	tc_moneda         INT NOT NULL,
	tc_calificacion   CHAR (1) NOT NULL,
	tc_clase_custodia CHAR (1) NOT NULL,
	tc_tipo           descripcion,
	tc_codvalor       INT NOT NULL,
	tc_valor          MONEY NOT NULL,
	tc_codigo_externo cuenta
	)
GO

IF OBJECT_ID ('dbo.cu_tmp_contagar') IS NOT NULL
	DROP TABLE dbo.cu_tmp_contagar
GO

CREATE TABLE dbo.cu_tmp_contagar
	(
	tc_oficina        INT NOT NULL,
	tc_tipo_bien      CHAR (1) NOT NULL,
	tc_op_clase       CHAR (1) NOT NULL,
	tc_moneda         INT NOT NULL,
	tc_calificacion   CHAR (1) NOT NULL,
	tc_clase_custodia CHAR (1) NOT NULL,
	tc_tipo           descripcion,
	tc_codvalor       INT NOT NULL,
	tc_valor          MONEY NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_tipo_custodia') IS NOT NULL
	DROP TABLE dbo.cu_tipo_custodia
GO

CREATE TABLE dbo.cu_tipo_custodia
	(
	tc_tipo             VARCHAR (64) NOT NULL,
	tc_tipo_superior    VARCHAR (64),
	tc_descripcion      VARCHAR (255),
	tc_periodicidad     catalogo,
	tc_contabilizar     CHAR (1),
	tc_porcentaje       FLOAT,
	tc_adecuada         CHAR (1),
	tc_porcen_cobertura FLOAT,
	tc_monetaria        CHAR (1),
	tc_tipo_bien        CHAR (1),
	tc_garan_empleado   CHAR (1),
	tc_clase            CHAR (1),
	tc_estado           CHAR (1),
	tc_multimoneda      CHAR (1),
	tc_agotada          CHAR (1),
	tc_ctr_vencimiento  CHAR (1),
	tc_producto			tinyint,
	tc_clase_garantia	catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_tipo_custodia_Key
	ON dbo.cu_tipo_custodia (tc_tipo)
GO

CREATE INDEX cu_tipo_custodia_Key2
	ON dbo.cu_tipo_custodia (tc_tipo_superior)
GO

IF OBJECT_ID ('dbo.cu_solicifagw') IS NOT NULL
	DROP TABLE dbo.cu_solicifagw
GO

CREATE TABLE dbo.cu_solicifagw
	(
	cu_con_codigo_externo VARCHAR (64),
	cu_con_nombre         descripcion,
	cu_con_valorgar       MONEY,
	cu_con_tramite        INT,
	cu_con_porini         FLOAT,
	cu_con_porfin         FLOAT,
	cu_con_estad          CHAR (1),
	cu_con_oficina        SMALLINT
	)
GO

IF OBJECT_ID ('dbo.cu_seqnos_doctos') IS NOT NULL
	DROP TABLE dbo.cu_seqnos_doctos
GO

CREATE TABLE dbo.cu_seqnos_doctos
	(
	sd_sucursal SMALLINT NOT NULL,
	sd_actual   INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_seqnos') IS NOT NULL
	DROP TABLE dbo.cu_seqnos
GO

CREATE TABLE dbo.cu_seqnos
	(
	se_filial    TINYINT NOT NULL,
	se_sucursal  SMALLINT NOT NULL,
	se_tipo_cust descripcion NOT NULL,
	se_actual    INT NOT NULL
	)
GO

CREATE INDEX cu_seqnos_1
	ON dbo.cu_seqnos (se_filial, se_sucursal, se_tipo_cust)
GO

IF OBJECT_ID ('dbo.cu_secuenciales') IS NOT NULL
	DROP TABLE dbo.cu_secuenciales
GO

CREATE TABLE dbo.cu_secuenciales
	(
	se_garantia   VARCHAR (64) NOT NULL,
	se_secuencial INT NOT NULL
	)
GO

CREATE INDEX cu_secuenciales_1
	ON dbo.cu_secuenciales (se_garantia)
GO

IF OBJECT_ID ('dbo.cu_sal_entidad_ext_tmp') IS NOT NULL
	DROP TABLE dbo.cu_sal_entidad_ext_tmp
GO

CREATE TABLE dbo.cu_sal_entidad_ext_tmp
	(
	se_fecha      DATETIME NOT NULL,
	se_ente       INT NOT NULL,
	se_codigo     cuenta NOT NULL,
	se_cobertura  MONEY NOT NULL,
	se_oficinas   VARCHAR (500) NOT NULL,
	se_toperacion VARCHAR (500) NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_sal_entidad_ext_tmp_1
	ON dbo.cu_sal_entidad_ext_tmp (se_ente, se_codigo, se_fecha)
GO

IF OBJECT_ID ('dbo.cu_sal_entidad_ext') IS NOT NULL
	DROP TABLE dbo.cu_sal_entidad_ext
GO

CREATE TABLE dbo.cu_sal_entidad_ext
	(
	se_fecha     DATETIME NOT NULL,
	se_ente      INT NOT NULL,
	se_codigo    cuenta NOT NULL,
	se_cobertura MONEY NOT NULL,
	se_ficticio  CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_sal_entidad_ext_1
	ON dbo.cu_sal_entidad_ext (se_ente, se_codigo, se_fecha)
GO

IF OBJECT_ID ('dbo.cu_revaloriza') IS NOT NULL
	DROP TABLE dbo.cu_revaloriza
GO

CREATE TABLE dbo.cu_revaloriza
	(
	rv_entidad_emisora INT NOT NULL,
	rv_des_entidad     VARCHAR (255) NOT NULL,
	rv_fuente_valor    catalogo NOT NULL,
	rv_des_fuente      VARCHAR (64) NOT NULL,
	rv_valor_accion    MONEY NOT NULL,
	rv_fecha_avaluo    DATETIME NOT NULL,
	rv_estado          CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cu_resultado_si2') IS NOT NULL
	DROP TABLE dbo.cu_resultado_si2
GO

CREATE TABLE dbo.cu_resultado_si2
	(
	descripcion VARCHAR (64),
	estado      VARCHAR (10),
	valor       MONEY,
	margen      MONEY,
	sesion      INT
	)
GO

CREATE INDEX cu_resultado_key
	ON dbo.cu_resultado_si2 (sesion)
GO

IF OBJECT_ID ('dbo.cu_resultado_cred4') IS NOT NULL
	DROP TABLE dbo.cu_resultado_cred4
GO

CREATE TABLE dbo.cu_resultado_cred4
	(
	descripcion VARCHAR (64),
	estado      VARCHAR (10),
	valor       MONEY,
	margen      MONEY,
	sesion      INT
	)
GO

CREATE INDEX cu_resultado_cred4_k1
	ON dbo.cu_resultado_cred4 (sesion)
GO

IF OBJECT_ID ('dbo.cu_resul_abg') IS NOT NULL
	DROP TABLE dbo.cu_resul_abg
GO

CREATE TABLE dbo.cu_resul_abg
	(
	ra_filial         TINYINT NOT NULL,
	ra_sucursal       SMALLINT NOT NULL,
	ra_abogado        catalogo,
	ra_fecha_recep    DATETIME NOT NULL,
	ra_custodia       INT NOT NULL,
	ra_tipo_cust      descripcion NOT NULL,
	ra_fecha_concep   DATETIME NOT NULL,
	ra_sufici_legal   CHAR (1),
	ra_tipo_asig      CHAR (1),
	ra_cobro_juridico CHAR (1),
	ra_fecha_cobro    DATETIME,
	ra_fenvio_carta   DATETIME,
	ra_factura        VARCHAR (20),
	ra_valor_fact     MONEY,
	ra_codigo_externo VARCHAR (64),
	ra_estado_tramite CHAR (1),
	ra_registrado     CHAR (1),
	ra_informe_gral   VARCHAR (255),
	ra_concepto_final VARCHAR (255),
	ra_lote           TINYINT,
	ra_pago           CHAR (1),
	ra_fecha_pago     DATETIME
	)
GO

CREATE UNIQUE INDEX cu_resul_abg_Key
	ON dbo.cu_resul_abg (ra_codigo_externo, ra_fecha_concep)
GO

CREATE INDEX i_cu_resul_abg
	ON dbo.cu_resul_abg (ra_abogado, ra_fenvio_carta, ra_lote)
GO

IF OBJECT_ID ('dbo.cu_rep_venc') IS NOT NULL
	DROP TABLE dbo.cu_rep_venc
GO

CREATE TABLE dbo.cu_rep_venc
	(
	rv_sucursal       INT NOT NULL,
	rv_estado         CHAR (1),
	rv_tipo           catalogo,
	rv_codigo_externo VARCHAR (64) NOT NULL,
	rv_valor_inicial  MONEY,
	rv_vcto_gar       DATETIME,
	rv_vcto_poliza    DATETIME,
	rv_vcto_cert      DATETIME,
	rv_custodia       INT
	)
GO

CREATE INDEX cu_rep_venc_key
	ON dbo.cu_rep_venc (rv_codigo_externo)
GO

IF OBJECT_ID ('dbo.cu_recuperacion') IS NOT NULL
	DROP TABLE dbo.cu_recuperacion
GO

CREATE TABLE dbo.cu_recuperacion
	(
	re_filial            TINYINT NOT NULL,
	re_sucursal          SMALLINT NOT NULL,
	re_tipo_cust         descripcion NOT NULL,
	re_custodia          INT NOT NULL,
	re_recuperacion      SMALLINT NOT NULL,
	re_valor             FLOAT NOT NULL,
	re_vencimiento       SMALLINT NOT NULL,
	re_fecha             DATETIME,
	re_cobro_vencimiento MONEY,
	re_cobro_mora        MONEY,
	re_cobro_comision    MONEY,
	re_codigo_externo    VARCHAR (64) NOT NULL,
	re_saldo             MONEY
	)
GO

CREATE UNIQUE INDEX cu_recuperacion_Key
	ON dbo.cu_recuperacion (re_codigo_externo, re_vencimiento, re_recuperacion)
GO

IF OBJECT_ID ('dbo.cu_por_inspeccionar') IS NOT NULL
	DROP TABLE dbo.cu_por_inspeccionar
GO

CREATE TABLE dbo.cu_por_inspeccionar
	(
	pi_filial         TINYINT NOT NULL,
	pi_sucursal       SMALLINT NOT NULL,
	pi_tipo           descripcion NOT NULL,
	pi_custodia       INT NOT NULL,
	pi_fecha_ant      DATETIME,
	pi_inspector_ant  INT,
	pi_estado_ant     catalogo,
	pi_inspector_asig INT,
	pi_fecha_asig     DATETIME,
	pi_riesgos        MONEY,
	pi_codigo_externo VARCHAR (64) NOT NULL,
	pi_inspeccionado  CHAR (1),
	pi_fecha_insp     DATETIME,
	pi_fenvio_carta   DATETIME,
	pi_frecep_reporte DATETIME,
	pi_lote           TINYINT
	)
GO

CREATE INDEX cu_por_inspeccionar_1
	ON dbo.cu_por_inspeccionar (pi_inspector_asig)
GO

CREATE UNIQUE INDEX cu_por_inspeccionar_Key
	ON dbo.cu_por_inspeccionar (pi_codigo_externo, pi_fecha_insp)
GO

IF OBJECT_ID ('dbo.cu_poliza') IS NOT NULL
	DROP TABLE dbo.cu_poliza
GO

CREATE TABLE dbo.cu_poliza
	(
	po_aseguradora      VARCHAR (20),
	po_poliza           VARCHAR (20) NOT NULL,
	po_fvigencia_inicio DATETIME,
	po_fvigencia_fin    DATETIME,
	po_moneda           TINYINT,
	po_monto_poliza     MONEY,
	po_fecha_endozo     DATETIME,
	po_monto_endozo     MONEY,
	po_cobertura        catalogo,
	po_estado_poliza    catalogo,
	po_descripcion      descripcion,
	po_codigo_externo   VARCHAR (64) NOT NULL,
	po_fendozo_fin      DATETIME,
	po_renovacion       CHAR (1),
	po_renovada         CHAR (1),
	po_frenovacion      DATETIME,
	po_cuenta           cuenta,
	po_tipo_cta         CHAR (3),
	po_comision         MONEY
	)
GO

CREATE INDEX cu_poliza_ix_1
	ON dbo.cu_poliza (po_aseguradora, po_poliza, po_codigo_externo)
GO

CREATE INDEX cu_poliza_ix_2
	ON dbo.cu_poliza (po_codigo_externo, po_estado_poliza)
GO

IF OBJECT_ID ('dbo.cu_plplanificador') IS NOT NULL
	DROP TABLE dbo.cu_plplanificador
GO

CREATE TABLE dbo.cu_plplanificador
	(
	plp_inspector      INT,
	plp_tipo_persono   descripcion,
	plp_fecha_crea     DATETIME,
	plp_especialidad   descripcion,
	plp_nombre         descripcion,
	plp_identifica     VARCHAR (34),
	plp_direccion      descripcion,
	plp_ciudad         descripcion,
	plp_telefono       VARCHAR (20),
	plp_cta_inspector  ctacliente,
	plp_ah_oficina     descripcion,
	plp_regional       catalogo,
	plp_fenvio_carta   DATETIME,
	plp_fecha_insp     DATETIME,
	plp_codigo_externo VARCHAR (64),
	plp_tramite        INT,
	plp_tr_estado      CHAR (1),
	plp_valor_fact     MONEY,
	plp_evaluacion     descripcion,
	plp_custodia       INT,
	plp_fecha_vis      DATETIME,
	plp_op_banco       cuenta
	)
GO

IF OBJECT_ID ('dbo.cu_planavaluador') IS NOT NULL
	DROP TABLE dbo.cu_planavaluador
GO

CREATE TABLE dbo.cu_planavaluador
	(
	pla_inspector      INT,
	pla_tipo_persono   descripcion,
	pla_fecha_crea     DATETIME,
	pla_especialidad   descripcion,
	pla_nombre         descripcion,
	pla_identifica     VARCHAR (34),
	pla_telefono       VARCHAR (20),
	pla_direccion      descripcion,
	pla_ciudad         descripcion,
	pla_cta_inspector  ctacliente,
	pla_ah_oficina     descripcion,
	pla_regional       catalogo,
	pla_fenvio_carta   DATETIME,
	pla_fecha_insp     DATETIME,
	pla_valor_fact     MONEY,
	pla_evaluacion     descripcion,
	pla_codigo_externo VARCHAR (64),
	pla_tramite        INT,
	pla_tr_estado      CHAR (1),
	pla_fecha_vis      DATETIME
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_sin_custodia') IS NOT NULL
	DROP TABLE dbo.cu_pagares_sin_custodia
GO

CREATE TABLE dbo.cu_pagares_sin_custodia
	(
	ps_sec        INT IDENTITY NOT NULL,
	ps_banco      cuenta NOT NULL,
	ps_toperacion catalogo NOT NULL,
	ps_fecha_ini  VARCHAR (10) NOT NULL,
	ps_ced_ruc    VARCHAR (30) NOT NULL,
	ps_nomlar     VARCHAR (254) NOT NULL,
	ps_monto      MONEY NOT NULL,
	ps_saldo      MONEY NOT NULL,
	ps_desc_ofi   descripcion NOT NULL,
	ps_oficina    SMALLINT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_salen') IS NOT NULL
	DROP TABLE dbo.cu_pagares_salen
GO

CREATE TABLE dbo.cu_pagares_salen
	(
	ps_sec        INT NOT NULL,
	ps_banco      cuenta NOT NULL,
	ps_toperacion catalogo NOT NULL,
	ps_fecha_ini  VARCHAR (10) NOT NULL,
	ps_ced_ruc    VARCHAR (30) NOT NULL,
	ps_nomlar     VARCHAR (254) NOT NULL,
	ps_monto      MONEY NOT NULL,
	ps_saldo      MONEY NOT NULL,
	ps_desc_ofi   descripcion NOT NULL,
	ps_oficina    SMALLINT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_resumen') IS NOT NULL
	DROP TABLE dbo.cu_pagares_resumen
GO

CREATE TABLE dbo.cu_pagares_resumen
	(
	pr_cliente   INT NOT NULL,
	pr_nombre    descripcion NOT NULL,
	pr_numero    INT NOT NULL,
	pr_saldo     MONEY NOT NULL,
	pr_fecha_gen VARCHAR (10) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_por_entidad') IS NOT NULL
	DROP TABLE dbo.cu_pagares_por_entidad
GO

CREATE TABLE dbo.cu_pagares_por_entidad
	(
	pe_sec        INT NOT NULL,
	pe_banco      cuenta NOT NULL,
	pe_toperacion catalogo NOT NULL,
	pe_fecha_ini  VARCHAR (10) NOT NULL,
	pe_ced_ruc    VARCHAR (30) NOT NULL,
	pe_nomlar     VARCHAR (254) NOT NULL,
	pe_monto      MONEY NOT NULL,
	pe_saldo      MONEY NOT NULL,
	pe_desc_ofi   descripcion NOT NULL,
	pe_oficina    SMALLINT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_entran') IS NOT NULL
	DROP TABLE dbo.cu_pagares_entran
GO

CREATE TABLE dbo.cu_pagares_entran
	(
	pe_sec        INT NOT NULL,
	pe_banco      cuenta NOT NULL,
	pe_toperacion catalogo NOT NULL,
	pe_fecha_ini  VARCHAR (10) NOT NULL,
	pe_ced_ruc    VARCHAR (30) NOT NULL,
	pe_nomlar     VARCHAR (254) NOT NULL,
	pe_monto      MONEY NOT NULL,
	pe_saldo      MONEY NOT NULL,
	pe_desc_ofi   descripcion NOT NULL,
	pe_oficina    SMALLINT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_pagares_certificado') IS NOT NULL
	DROP TABLE dbo.cu_pagares_certificado
GO

CREATE TABLE dbo.cu_pagares_certificado
	(
	pc_sec          INT NOT NULL,
	pc_banco        cuenta NOT NULL,
	pc_toperacion   catalogo NOT NULL,
	pc_ced_ruc      VARCHAR (30) NOT NULL,
	pc_nomlar       VARCHAR (254) NOT NULL,
	pc_fecha_ini    VARCHAR (10) NOT NULL,
	pc_fecha_fin    VARCHAR (10) NOT NULL,
	pc_monto        MONEY NOT NULL,
	pc_tasa_int     FLOAT NOT NULL,
	pc_amor_cap     catalogo NOT NULL,
	pc_amor_int     catalogo NOT NULL,
	pc_calificacion VARCHAR (10) NOT NULL,
	pc_saldo        MONEY NOT NULL,
	pc_desc_ofi     descripcion NOT NULL,
	pc_oficina      SMALLINT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_ofi_entidad_ext') IS NOT NULL
	DROP TABLE dbo.cu_ofi_entidad_ext
GO

CREATE TABLE dbo.cu_ofi_entidad_ext
	(
	oe_fecha   DATETIME NOT NULL,
	oe_ente    INT NOT NULL,
	oe_codigo  cuenta NOT NULL,
	oe_oficina INT NOT NULL,
	oe_orden   INT
	)
GO

CREATE UNIQUE INDEX cu_ofi_entidad_ext_1
	ON dbo.cu_ofi_entidad_ext (oe_oficina, oe_ente, oe_codigo, oe_fecha)
GO

IF OBJECT_ID ('dbo.cu_observacion_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_observacion_inspecci
GO

CREATE TABLE dbo.cu_observacion_inspecci
	(
	on_codigo_externo VARCHAR (64) NOT NULL,
	on_numero         SMALLINT NOT NULL,
	on_fecha          DATETIME NOT NULL,
	on_usuario        login NOT NULL,
	on_lineas         SMALLINT,
	on_modificar      CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_observacion_inspecci_Key
	ON dbo.cu_observacion_inspecci (on_codigo_externo, on_numero)
GO

IF OBJECT_ID ('dbo.cu_obs_inspecci') IS NOT NULL
	DROP TABLE dbo.cu_obs_inspecci
GO

CREATE TABLE dbo.cu_obs_inspecci
	(
	oi_codigo_externo VARCHAR (64) NOT NULL,
	oi_observacion    SMALLINT NOT NULL,
	oi_linea          SMALLINT,
	oi_texto          VARCHAR (255) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_obs_inspecci_Key
	ON dbo.cu_obs_inspecci (oi_codigo_externo, oi_observacion, oi_linea)
GO

IF OBJECT_ID ('dbo.cu_maestro_error') IS NOT NULL
	DROP TABLE dbo.cu_maestro_error
GO

CREATE TABLE dbo.cu_maestro_error
	(
	err_garantia descripcion NOT NULL,
	err_fecha    DATETIME NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_maestro_custodia') IS NOT NULL
	DROP TABLE dbo.cu_maestro_custodia
GO

CREATE TABLE dbo.cu_maestro_custodia
	(
	mc_regional       INT NOT NULL,
	mc_oficina        SMALLINT NOT NULL,
	mc_desc_oficina   VARCHAR (64) NOT NULL,
	mc_id_cliente     VARCHAR (30) NOT NULL,
	mc_cliente        INT NOT NULL,
	mc_nom_cliente    VARCHAR (40) NOT NULL,
	mc_operacion      VARCHAR (24) NOT NULL,
	mc_valor_des      MONEY NOT NULL,
	mc_f_desemb       VARCHAR (10) NOT NULL,
	mc_tipo           catalogo,
	mc_codigo_externo VARCHAR (64) NOT NULL,
	mc_depend_destino catalogo,
	mc_f_envio        VARCHAR (10),
	mc_f_recep        VARCHAR (10),
	mc_estado         CHAR (3) NOT NULL,
	mc_f_estado       VARCHAR (10) NOT NULL,
	mc_dias           INT NOT NULL,
	mc_usuario        login
	)
GO

IF OBJECT_ID ('dbo.cu_maestro') IS NOT NULL
	DROP TABLE dbo.cu_maestro
GO

CREATE TABLE dbo.cu_maestro
	(
	ma_tipo                 descripcion NOT NULL,
	ma_custodia             INT,
	ma_estado               VARCHAR (20),
	ma_fecha_ingreso        VARCHAR (10),
	ma_valor_inicial        FLOAT,
	ma_valor_actual         FLOAT,
	ma_moneda               TINYINT,
	ma_principal            VARCHAR (100),
	ma_instruccion          VARCHAR (100),
	ma_descripcion          VARCHAR (100),
	ma_inspeccionar         CHAR (1),
	ma_motivo_noinsp        descripcion,
	ma_fuente_valor         catalogo,
	ma_almacenera           SMALLINT,
	ma_direccion_prenda     VARCHAR (100),
	ma_ciudad_prenda        VARCHAR (20),
	ma_telefono_prenda      VARCHAR (20),
	ma_fecha_modif          VARCHAR (10),
	ma_fecha_const          VARCHAR (10),
	ma_periodicidad         VARCHAR (20),
	ma_nro_inspecciones     TINYINT,
	ma_usuario_crea         descripcion,
	ma_usuario_modifica     descripcion,
	ma_codigo_externo       VARCHAR (64) NOT NULL,
	ma_fecha_insp           VARCHAR (10),
	ma_abierta_cerrada      CHAR (1),
	ma_clase_custodia       CHAR (1),
	ma_oficina              VARCHAR (20),
	ma_oficina_contabiliza  VARCHAR (20),
	ma_compartida           CHAR (1),
	ma_valor_compartida     MONEY,
	ma_num_acciones         INT,
	ma_valor_accion         MONEY,
	ma_porcentaje_comp      FLOAT,
	ma_ubicacion            VARCHAR (20),
	ma_estado_credito       VARCHAR (20),
	ma_cuantia              CHAR (1),
	ma_vlr_cuantia          MONEY,
	ma_clase_cartera        CHAR (1),
	ma_fecha_vencimiento    VARCHAR (10),
	ma_porcentaje_cobertura FLOAT,
	ma_fecha_avaluo         VARCHAR (10),
	ma_entidad_emisora      INT,
	ma_fuente_valor_accion  catalogo,
	ma_fecha_accion         VARCHAR (10),
	ma_grado_gar            VARCHAR (20),
	ma_provisiona           CHAR (1),
	ma_disponible           FLOAT,
	ma_siniestro            CHAR (1),
	ma_castigo              CHAR (1),
	ma_agotada              CHAR (1),
	ma_tipo_g               descripcion,
	ma_ced_ruc              VARCHAR (30),
	ma_nomlar               VARCHAR (100),
	ma_casilla_def          VARCHAR (24),
	ma_mercado              VARCHAR (24),
	ma_banca                VARCHAR (20),
	ma_gp_tramite           INT,
	ma_banco                cuenta,
	ma_fecha_liq            VARCHAR (10),
	ma_fecha_fin            VARCHAR (10),
	ma_saldo                MONEY,
	ma_entidad              CHAR (1),
	ma_val_avajud           MONEY,
	ma_contabiliza          CHAR (1),
	ma_notaria              VARCHAR (30),
	ma_escritura            VARCHAR (30),
	ma_certifilib           VARCHAR (30),
	ma_matricula            VARCHAR (30),
	ma_avaluo               VARCHAR (30),
	ma_val_cons             VARCHAR (30),
	ma_val_terr             VARCHAR (30),
	ma_valor_inv            VARCHAR (30),
	ma_ubica_gar            VARCHAR (30),
	ma_fecha_reg            VARCHAR (30),
	ma_fecha_ampliacion     VARCHAR (30),
	ma_seguro               CHAR (1),
	ma_aseguradora          VARCHAR (20),
	ma_fendozo_fin          VARCHAR (10),
	ma_acciones             CHAR (2),
	ma_fecha_accioncon      VARCHAR (10),
	ma_num_dcto             VARCHAR (13),
	ma_fecha_sol_exp        VARCHAR (10),
	ma_fecha_sol_ren        VARCHAR (10),
	ma_fecha_sol_rec        VARCHAR (10),
	ma_calificacion         CHAR (1),
	ma_regional             SMALLINT
	)
GO

IF OBJECT_ID ('dbo.cu_item_custodia_tpm') IS NOT NULL
	DROP TABLE dbo.cu_item_custodia_tpm
GO

CREATE TABLE dbo.cu_item_custodia_tpm
	(
	valor_item     VARCHAR (64),
	item           TINYINT,
	nombre         VARCHAR (64),
	codigo_externo VARCHAR (64),
	tipo_cust      VARCHAR (64),
	proceso        INT NOT NULL
	)
GO

CREATE INDEX cu_item_custodia_tpm_k1
	ON dbo.cu_item_custodia_tpm (proceso)
GO

IF OBJECT_ID ('dbo.cu_item_custodia') IS NOT NULL
	DROP TABLE dbo.cu_item_custodia
GO

CREATE TABLE dbo.cu_item_custodia
	(
	ic_filial         TINYINT NOT NULL,
	ic_sucursal       SMALLINT NOT NULL,
	ic_tipo_cust      descripcion NOT NULL,
	ic_custodia       INT NOT NULL,
	ic_item           TINYINT NOT NULL,
	ic_valor_item     descripcion,
	ic_secuencial     SMALLINT,
	ic_codigo_externo VARCHAR (64) NOT NULL
	)
GO

CREATE INDEX cu_item_custodia_1
	ON dbo.cu_item_custodia (ic_sucursal, ic_tipo_cust, ic_custodia)
GO

CREATE INDEX cu_item_custodia_2
	ON dbo.cu_item_custodia (ic_custodia, ic_sucursal, ic_tipo_cust)
GO

CREATE INDEX cu_item_custodia_Akey
	ON dbo.cu_item_custodia (ic_tipo_cust, ic_item, ic_valor_item)
GO

CREATE UNIQUE INDEX cu_item_custodia_Key
	ON dbo.cu_item_custodia (ic_codigo_externo, ic_secuencial, ic_item)
GO

IF OBJECT_ID ('dbo.cu_item') IS NOT NULL
	DROP TABLE dbo.cu_item
GO

CREATE TABLE dbo.cu_item
	(
	it_tipo_custodia descripcion NOT NULL,
	it_item          TINYINT NOT NULL,
	it_nombre        descripcion,
	it_detalle       descripcion,
	it_tipo_dato     CHAR (1) NOT NULL,
	it_mandatorio    CHAR (1),
	it_numero_fisico CHAR (1)
	)
GO

CREATE INDEX cu_item_Key
	ON dbo.cu_item (it_tipo_custodia, it_item)
GO

CREATE INDEX it_nombre_Key
	ON dbo.cu_item (it_nombre)
GO

IF OBJECT_ID ('dbo.cu_inspector') IS NOT NULL
	DROP TABLE dbo.cu_inspector
GO

CREATE TABLE dbo.cu_inspector
	(
	is_inspector      INT NOT NULL,
	is_cta_inspector  ctacliente,
	is_nombre         descripcion,
	is_especialidad   catalogo,
	is_direccion      descripcion,
	is_telefono       VARCHAR (20),
	is_principal      descripcion,
	is_cargo          descripcion,
	is_cliente_inspec INT,
	is_tipo_cta       VARCHAR (5),
	is_ciudad         INT,
	is_regional       catalogo,
	is_tipo_inspector CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_inspector_Key
	ON dbo.cu_inspector (is_inspector)
GO

IF OBJECT_ID ('dbo.cu_inspeccion') IS NOT NULL
	DROP TABLE dbo.cu_inspeccion
GO

CREATE TABLE dbo.cu_inspeccion
	(
	in_filial         TINYINT NOT NULL,
	in_sucursal       SMALLINT NOT NULL,
	in_tipo_cust      descripcion NOT NULL,
	in_custodia       INT NOT NULL,
	in_fecha_insp     DATETIME NOT NULL,
	in_inspector      INT,
	in_estado         catalogo,
	in_factura        VARCHAR (20),
	in_valor_fact     MONEY,
	in_observaciones  VARCHAR (255),
	in_instruccion    VARCHAR (255),
	in_motivo         catalogo,
	in_valor_avaluo   MONEY,
	in_estado_tramite CHAR (1),
	in_codigo_externo VARCHAR (64) NOT NULL,
	in_registrado     CHAR (1),
	in_lote           TINYINT,
	in_pago           CHAR (1),
	in_fecha_pago     DATETIME,
	in_evaluacion     catalogo,
	in_registro       CHAR (1) NOT NULL
	)
GO

CREATE INDEX cu_inspeccion_Key
	ON dbo.cu_inspeccion (in_codigo_externo)
GO

CREATE INDEX i_cu_inspeccion_i2
	ON dbo.cu_inspeccion (in_filial, in_sucursal, in_tipo_cust, in_custodia)
GO

IF OBJECT_ID ('dbo.cu_historial_custodia') IS NOT NULL
	DROP TABLE dbo.cu_historial_custodia
GO

CREATE TABLE dbo.cu_historial_custodia
	(
	hc_codigo_externo VARCHAR (64) NOT NULL,
	hc_secuencia      INT NOT NULL,
	hc_fecha          DATETIME NOT NULL,
	hc_estado         CHAR (3) NOT NULL,
	hc_dep_origen     catalogo,
	hc_dep_destino    catalogo,
	hc_usuario        login,
	hc_comentario     VARCHAR (255),
	hc_dependencia    catalogo
	)
GO

CREATE INDEX cu_histcus_Akey
	ON dbo.cu_historial_custodia (hc_codigo_externo, hc_secuencia)
GO

IF OBJECT_ID ('dbo.cu_grupos_doctos') IS NOT NULL
	DROP TABLE dbo.cu_grupos_doctos
GO

CREATE TABLE dbo.cu_grupos_doctos
	(
	gd_grupo        INT NOT NULL,
	gd_cliente      INT NOT NULL,
	gd_num_negocio  VARCHAR (64) NOT NULL,
	gd_valor_neg    MONEY NOT NULL,
	gd_fecha_vtoneg DATETIME NOT NULL,
	gd_fecha_inineg DATETIME NOT NULL,
	gd_tramite      INT,
	gd_moneda       TINYINT,
	gd_con_respon   CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_grupos_doctos_Key
	ON dbo.cu_grupos_doctos (gd_grupo, gd_cliente, gd_num_negocio)
GO

IF OBJECT_ID ('dbo.cu_gastos') IS NOT NULL
	DROP TABLE dbo.cu_gastos
GO

CREATE TABLE dbo.cu_gastos
	(
	ga_filial         TINYINT NOT NULL,
	ga_sucursal       SMALLINT NOT NULL,
	ga_tipo_cust      descripcion NOT NULL,
	ga_custodia       INT NOT NULL,
	ga_gastos         SMALLINT NOT NULL,
	ga_descripcion    VARCHAR (64),
	ga_monto          MONEY,
	ga_fecha          DATETIME,
	ga_codigo_externo VARCHAR (64) NOT NULL,
	ga_registrado     CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_gastos_Key
	ON dbo.cu_gastos (ga_codigo_externo, ga_gastos)
GO

IF OBJECT_ID ('dbo.cu_garantias_custodia') IS NOT NULL
	DROP TABLE dbo.cu_garantias_custodia
GO

CREATE TABLE dbo.cu_garantias_custodia
	(
	gc_codigo_externo VARCHAR (64) NOT NULL,
	gc_tipo           catalogo,
	gc_cliente        INT NOT NULL,
	gc_operacion      VARCHAR (24) NOT NULL,
	gc_depend_origen  catalogo,
	gc_depend_destino catalogo,
	gc_estado         CHAR (3) NOT NULL,
	gc_dependencia    catalogo,
	gc_usuario        login,
	gc_oficina        SMALLINT NOT NULL,
	gc_fecha_ingreso  DATETIME NOT NULL,
	gc_descripcion    VARCHAR (255) NOT NULL,
	gc_motivo         catalogo,
	gc_fecha_modif    DATETIME NOT NULL,
	gc_documento      VARCHAR (64) NOT NULL,
	gc_comentario     VARCHAR (255),
	gc_regional       SMALLINT CONSTRAINT DF__cu_garant__gc_re__2077C861 DEFAULT ((0)),
	gc_paquete        INT,
	gc_sec_paq        SMALLINT
	)
GO

CREATE INDEX cu_garantias_custodia_cext
	ON dbo.cu_garantias_custodia (gc_codigo_externo, gc_estado)
GO

CREATE INDEX cu_garantias_custodia_cli
	ON dbo.cu_garantias_custodia (gc_cliente, gc_codigo_externo)
GO

CREATE INDEX cu_garantias_custodia_dep
	ON dbo.cu_garantias_custodia (gc_dependencia, gc_codigo_externo)
GO

CREATE INDEX cu_garantias_custodia_ofi
	ON dbo.cu_garantias_custodia (gc_oficina, gc_codigo_externo)
GO

CREATE INDEX cu_garantias_custodia_oper
	ON dbo.cu_garantias_custodia (gc_operacion, gc_codigo_externo)
GO

CREATE INDEX cu_garantias_custodia_reg
	ON dbo.cu_garantias_custodia (gc_regional, gc_codigo_externo)
GO

IF OBJECT_ID ('dbo.cu_garantia_operacion') IS NOT NULL
	DROP TABLE dbo.cu_garantia_operacion
GO

CREATE TABLE dbo.cu_garantia_operacion
	(
	go_filial            TINYINT NOT NULL,
	go_sucursal          SMALLINT NOT NULL,
	go_tipo_cust         descripcion NOT NULL,
	go_custodia          INT NOT NULL,
	go_operacion         cuenta,
	go_operacion_cartera INT,
	go_fecha             DATETIME,
	go_codigo_externo    descripcion NOT NULL
	)
GO

CREATE INDEX cu_gar_operacion_Key
	ON dbo.cu_garantia_operacion (go_codigo_externo, go_operacion)
GO

IF OBJECT_ID ('dbo.cu_gar_si2') IS NOT NULL
	DROP TABLE dbo.cu_gar_si2
GO

CREATE TABLE dbo.cu_gar_si2
	(
	ga_garantia    VARCHAR (64),
	ga_estado      VARCHAR (10),
	ga_est_credito VARCHAR (10),
	ga_tipo        VARCHAR (10),
	ga_valor       MONEY,
	ga_cobertura   FLOAT,
	ga_margen      MONEY,
	ga_adec_noadec CHAR (1),
	ga_tipo_cl     CHAR (1),
	ga_rol_cl      CHAR (1),
	sesion         INT
	)
GO

CREATE INDEX cu_gar_key
	ON dbo.cu_gar_si2 (sesion)
GO

IF OBJECT_ID ('dbo.cu_gar_municipio') IS NOT NULL
	DROP TABLE dbo.cu_gar_municipio
GO

CREATE TABLE dbo.cu_gar_municipio
	(
	gm_tipo   VARCHAR (64),
	gm_depto  INT,
	gm_ciudad INT
	)
GO

IF OBJECT_ID ('dbo.cu_gar_cred4') IS NOT NULL
	DROP TABLE dbo.cu_gar_cred4
GO

CREATE TABLE dbo.cu_gar_cred4
	(
	ga_garantia    VARCHAR (64),
	ga_estado      VARCHAR (10),
	ga_est_credito VARCHAR (10),
	ga_tipo        VARCHAR (10),
	ga_valor       MONEY,
	ga_cobertura   FLOAT,
	ga_margen      MONEY,
	ga_adec_noadec CHAR (1),
	ga_tipo_cl     CHAR (1),
	ga_rol_cl      CHAR (1),
	sesion         INT
	)
GO

CREATE INDEX cu_gar_cred4_k1
	ON dbo.cu_gar_cred4 (sesion, ga_garantia)
GO

IF OBJECT_ID ('dbo.cu_gar_actividad') IS NOT NULL
	DROP TABLE dbo.cu_gar_actividad
GO

CREATE TABLE dbo.cu_gar_actividad
	(
	ga_tipo      VARCHAR (64),
	ga_actividad VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cu_gar_abogado') IS NOT NULL
	DROP TABLE dbo.cu_gar_abogado
GO

CREATE TABLE dbo.cu_gar_abogado
	(
	ga_filial         TINYINT NOT NULL,
	ga_sucursal       SMALLINT NOT NULL,
	ga_tipo           descripcion NOT NULL,
	ga_custodia       INT NOT NULL,
	ga_codigo_externo VARCHAR (64) NOT NULL,
	ga_fecha_ant      DATETIME,
	ga_abogado_ant    catalogo,
	ga_abogado_asig   catalogo,
	ga_fecha_asig     DATETIME,
	ga_tipo_asig      catalogo NOT NULL,
	ga_revisado       CHAR (1),
	ga_fenvio_carta   DATETIME,
	ga_frecep_reporte DATETIME,
	ga_tipo_asig_ant  catalogo,
	ga_lote           TINYINT,
	ga_valor_anticipo MONEY
	)
GO

CREATE UNIQUE INDEX cu_gar_abogado_Key
	ON dbo.cu_gar_abogado (ga_codigo_externo, ga_fenvio_carta, ga_lote)
GO

IF OBJECT_ID ('dbo.cu_finagro_tmpw_def') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmpw_def
GO

CREATE TABLE dbo.cu_finagro_tmpw_def
	(
	ft_certificadow      VARCHAR (13),
	ft_documentow        descripcion,
	ft_identificacionw   VARCHAR (14),
	ft_estado            CHAR (1),
	ft_fecha_desembolsow VARCHAR (10),
	ft_fecha_vig_gar     VARCHAR (10),
	ft_saldo_credito     VARCHAR (15),
	ft_valor_comision    VARCHAR (15),
	ft_coberturaw        VARCHAR (10),
	ft_valor_desembolsow VARCHAR (15),
	ft_actaw             VARCHAR (10),
	ft_fecha_actaw       VARCHAR (10),
	ft_plazow            VARCHAR (10),
	ft_periodo_graciaw   VARCHAR (10),
	ft_sucursal          VARCHAR (35),
	ft_linea_red         catalogo,
	ft_redescuento       VARCHAR (25),
	ft_valor_garantiaw   VARCHAR (15),
	ft_oficinaw          VARCHAR (24),
	ft_intermediario     VARCHAR (40),
	ft_departamentow     VARCHAR (24),
	ft_tipo_gar          VARCHAR (30),
	ft_nom_cliente       VARCHAR (254)
	)
GO

IF OBJECT_ID ('dbo.cu_finagro_tmpw') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmpw
GO

CREATE TABLE dbo.cu_finagro_tmpw
	(
	ft_certificadow      VARCHAR (13),
	ft_documentow        descripcion,
	ft_identificacionw   VARCHAR (14),
	ft_estado            CHAR (1),
	ft_fecha_desembolsow VARCHAR (10),
	ft_fecha_vig_gar     VARCHAR (10),
	ft_saldo_credito     VARCHAR (15),
	ft_valor_comision    VARCHAR (15),
	ft_coberturaw        VARCHAR (10),
	ft_valor_desembolsow VARCHAR (15),
	ft_actaw             VARCHAR (10),
	ft_fecha_actaw       VARCHAR (10),
	ft_plazow            VARCHAR (10),
	ft_periodo_graciaw   VARCHAR (10),
	ft_sucursal          VARCHAR (35),
	ft_linea_red         catalogo,
	ft_redescuento       VARCHAR (25),
	ft_valor_garantiaw   VARCHAR (15),
	ft_oficinaw          VARCHAR (24),
	ft_intermediario     VARCHAR (40),
	ft_departamentow     VARCHAR (24),
	ft_tipo_gar          VARCHAR (30),
	ft_nom_cliente       VARCHAR (254)
	)
GO

CREATE INDEX cu_finagro_tmpw_key
	ON dbo.cu_finagro_tmpw (ft_certificadow)
GO

IF OBJECT_ID ('dbo.cu_finagro_tmp') IS NOT NULL
	DROP TABLE dbo.cu_finagro_tmp
GO

CREATE TABLE dbo.cu_finagro_tmp
	(
	ft_certificado    VARCHAR (10),
	ft_identificacion VARCHAR (14),
	ft_documento      descripcion,
	ft_acta           VARCHAR (10),
	ft_fecha_acta     DATETIME
	)
GO

IF OBJECT_ID ('dbo.cu_estce') IS NOT NULL
	DROP TABLE dbo.cu_estce
GO

CREATE TABLE dbo.cu_estce
	(
	re_codigo_externo VARCHAR (64),
	re_tipo_gar       VARCHAR (64),
	re_desc_tipo      VARCHAR (64),
	re_oficina        SMALLINT,
	re_cliente        INT,
	re_id_cliente     VARCHAR (30),
	re_estado         VARCHAR (10),
	re_certif         VARCHAR (13),
	re_valor          MONEY,
	re_canpago        catalogo,
	re_desc_cp        descripcion,
	re_canexp         catalogo,
	re_desc_ex        catalogo,
	re_tram_proc      INT,
	re_tram_orig      INT,
	re_desc_est       descripcion
	)
GO

CREATE INDEX cu_estce_Akey
	ON dbo.cu_estce (re_tram_orig)
GO

CREATE INDEX cu_estce_Bkey
	ON dbo.cu_estce (re_tram_proc)
GO

CREATE INDEX cu_estce_Ckey
	ON dbo.cu_estce (re_cliente)
GO

CREATE INDEX cu_estce_key
	ON dbo.cu_estce (re_estado)
GO

IF OBJECT_ID ('dbo.cu_estados_garantia') IS NOT NULL
	DROP TABLE dbo.cu_estados_garantia
GO

CREATE TABLE dbo.cu_estados_garantia
	(
	eg_estado      CHAR (1) NOT NULL,
	eg_descripcion descripcion NOT NULL,
	eg_codvalor    INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_errorlog') IS NOT NULL
	DROP TABLE dbo.cu_errorlog
GO

CREATE TABLE dbo.cu_errorlog
	(
	er_fecha_proc  DATETIME NOT NULL,
	er_usuario     login,
	er_tran        INT,
	er_garantia    VARCHAR (64),
	er_descripcion VARCHAR (255)
	)
GO

IF OBJECT_ID ('dbo.cu_error_valvn') IS NOT NULL
	DROP TABLE dbo.cu_error_valvn
GO

CREATE TABLE dbo.cu_error_valvn
	(
	ev_codigo_externo VARCHAR (64) NOT NULL,
	ev_descripcion    VARCHAR (255) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_error_valv') IS NOT NULL
	DROP TABLE dbo.cu_error_valv
GO

CREATE TABLE dbo.cu_error_valv
	(
	ev_codigo_externo VARCHAR (64) NOT NULL,
	ev_descripcion    VARCHAR (255) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_error_mig') IS NOT NULL
	DROP TABLE dbo.cu_error_mig
GO

CREATE TABLE dbo.cu_error_mig
	(
	em_user      login NOT NULL,
	em_sesn      INT NOT NULL,
	em_date      DATETIME NOT NULL,
	em_num       INT NOT NULL,
	em_msg       VARCHAR (255) NOT NULL,
	em_secuencia INT,
	em_sp        VARCHAR (30) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_error_futuros') IS NOT NULL
	DROP TABLE dbo.cu_error_futuros
GO

CREATE TABLE dbo.cu_error_futuros
	(
	tc_oficina        INT NOT NULL,
	tc_tipo_bien      CHAR (1) NOT NULL,
	tc_op_clase       CHAR (1) NOT NULL,
	tc_moneda         INT NOT NULL,
	tc_calificacion   CHAR (1) NOT NULL,
	tc_clase_custodia CHAR (1) NOT NULL,
	tc_tipo           descripcion,
	tc_codvalor       INT NOT NULL,
	tc_valor          MONEY NOT NULL,
	tc_codigo_externo cuenta
	)
GO

IF OBJECT_ID ('dbo.cu_error_contagar_det') IS NOT NULL
	DROP TABLE dbo.cu_error_contagar_det
GO

CREATE TABLE dbo.cu_error_contagar_det
	(
	ec_fecha_proc   VARCHAR (10) NOT NULL,
	ec_cta_contable VARCHAR (30) NOT NULL,
	ec_cta_final    VARCHAR (30) NOT NULL,
	ec_garantia     VARCHAR (64) NOT NULL,
	ec_error        VARCHAR (255)
	)
GO

CREATE INDEX cu_error_contagar_key
	ON dbo.cu_error_contagar_det (ec_fecha_proc)
GO

IF OBJECT_ID ('dbo.cu_error_contagar') IS NOT NULL
	DROP TABLE dbo.cu_error_contagar
GO

CREATE TABLE dbo.cu_error_contagar
	(
	ec_fecha_proc   VARCHAR (10) NOT NULL,
	ec_cta_contable VARCHAR (30) NOT NULL,
	ec_cta_final    VARCHAR (30) NOT NULL,
	ec_error        VARCHAR (255)
	)
GO

CREATE INDEX cu_error_contagar_key
	ON dbo.cu_error_contagar (ec_fecha_proc)
GO

IF OBJECT_ID ('dbo.cu_error_carga') IS NOT NULL
	DROP TABLE dbo.cu_error_carga
GO

CREATE TABLE dbo.cu_error_carga
	(
	ec_fecha          DATETIME NOT NULL,
	ec_certificado    VARCHAR (13),
	ec_identificacion VARCHAR (14),
	ec_err            VARCHAR (64)
	)
GO

CREATE INDEX cu_error_carga_key
	ON dbo.cu_error_carga (ec_fecha)
GO

IF OBJECT_ID ('dbo.cu_ecarcontrag') IS NOT NULL
	DROP TABLE dbo.cu_ecarcontrag
GO

CREATE TABLE dbo.cu_ecarcontrag
	(
	ec_fecha    DATETIME,
	ec_cuenta   VARCHAR (30),
	ec_producto INT,
	ec_error    VARCHAR (100),
	ec_tipo     CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cu_documentos') IS NOT NULL
	DROP TABLE dbo.cu_documentos
GO

CREATE TABLE dbo.cu_documentos
	(
	do_filial        TINYINT NOT NULL,
	do_sucursal      SMALLINT NOT NULL,
	do_num_negocio   VARCHAR (64) NOT NULL,
	do_num_doc       VARCHAR (16) NOT NULL,
	do_proveedor     INT NOT NULL,
	do_fecha_proc    DATETIME,
	do_tipo_doc      descripcion,
	do_moneda        INT,
	do_valor_bruto   MONEY,
	do_anticipos     MONEY,
	do_por_impuestos FLOAT,
	do_por_retencion FLOAT,
	do_valor_neto    MONEY,
	do_valor_neg     MONEY,
	do_ciudad        INT,
	do_fecha_emision DATETIME,
	do_fecha_vtodoc  DATETIME,
	do_fecha_inineg  DATETIME,
	do_fecha_vtoneg  DATETIME,
	do_fecha_pago    DATETIME,
	do_base_calculo  catalogo,
	do_dias_negocio  INT,
	do_num_dex       VARCHAR (16),
	do_fecha_dex     DATETIME,
	do_cliente       INT,
	do_comprador     INT,
	do_resp_pago     INT,
	do_resp_dscto    INT,
	do_observaciones VARCHAR (255),
	do_estado        catalogo,
	do_agrupado      CHAR (1),
	do_grupo         INT,
	do_fecha_bl      DATETIME
	)
GO

CREATE UNIQUE INDEX cu_documentos_Key
	ON dbo.cu_documentos (do_num_negocio, do_num_doc)
GO

CREATE INDEX i_cu_documentos_i2
	ON dbo.cu_documentos (do_num_doc, do_proveedor)
GO

IF OBJECT_ID ('dbo.cu_doc_garantia') IS NOT NULL
	DROP TABLE dbo.cu_doc_garantia
GO

CREATE TABLE dbo.cu_doc_garantia
	(
	dg_oficina            SMALLINT NOT NULL,
	dg_custodia           INT NOT NULL,
	dg_tipo               VARCHAR (64) NOT NULL,
	dg_documento          MONEY NOT NULL,
	dg_num_operacion      cuenta,
	dg_ubicacion_garantia catalogo,
	dg_usuario_solicita   VARCHAR (255),
	dg_motivo_solicitud   VARCHAR (255),
	dg_numero_folios      VARCHAR (255),
	dg_observaciones      VARCHAR (255),
	dg_fecha_solicitud    DATETIME,
	dg_fecha_recibo       DATETIME,
	dg_fecha_envio        DATETIME,
	dg_estado_doc         catalogo,
	dg_fecha_modif        DATETIME
	)
GO

CREATE UNIQUE INDEX cu_doc_garantia_Key
	ON dbo.cu_doc_garantia (dg_oficina, dg_custodia, dg_tipo, dg_num_operacion, dg_documento, dg_fecha_modif)
GO

IF OBJECT_ID ('dbo.cu_distr_garantia') IS NOT NULL
	DROP TABLE dbo.cu_distr_garantia
GO

CREATE TABLE dbo.cu_distr_garantia
	(
	dg_tramite             INT NOT NULL,
	dg_garantia            VARCHAR (64) NOT NULL,
	dg_clase_cartera       catalogo,
	dg_calificacion        catalogo,
	dg_monto_exceso        MONEY,
	dg_porcentaje          FLOAT,
	dg_valor_resp_garantia MONEY,
	dg_estado_gar          CHAR (1),
	dg_estado_ope          INT
	)
GO

CREATE INDEX cu_distr_garantia_2
	ON dbo.cu_distr_garantia (dg_valor_resp_garantia)
GO

CREATE INDEX cu_distr_garantia_3
	ON dbo.cu_distr_garantia (dg_garantia)
GO

CREATE UNIQUE INDEX cu_distr_garantia_Key
	ON dbo.cu_distr_garantia (dg_tramite, dg_garantia)
GO

IF OBJECT_ID ('dbo.cu_det_trn') IS NOT NULL
	DROP TABLE dbo.cu_det_trn
GO

CREATE TABLE dbo.cu_det_trn
	(
	dtr_secuencial     INT NOT NULL,
	dtr_codigo_externo VARCHAR (64) NOT NULL,
	dtr_codvalor       INT NOT NULL,
	dtr_valor          FLOAT NOT NULL,
	dtr_clase_cartera  catalogo,
	dtr_calificacion   catalogo
	)
GO

CREATE INDEX i_cu_det_trn
	ON dbo.cu_det_trn (dtr_codigo_externo, dtr_secuencial, dtr_clase_cartera, dtr_calificacion)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cu_dependencias') IS NOT NULL
	DROP TABLE dbo.cu_dependencias
GO

CREATE TABLE dbo.cu_dependencias
	(
	de_codigo      catalogo NOT NULL,
	de_descripcion VARCHAR (30) NOT NULL,
	de_estado      catalogo NOT NULL,
	de_ambito      CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_depKey
	ON dbo.cu_dependencias (de_codigo)
GO

IF OBJECT_ID ('dbo.cu_dep_usuario') IS NOT NULL
	DROP TABLE dbo.cu_dep_usuario
GO

CREATE TABLE dbo.cu_dep_usuario
	(
	du_dependencia catalogo NOT NULL,
	du_usuario     login NOT NULL,
	du_descripcion descripcion NOT NULL,
	du_estado      catalogo NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_depuKey
	ON dbo.cu_dep_usuario (du_dependencia, du_usuario)
GO

IF OBJECT_ID ('dbo.cu_custodia_resp_vig') IS NOT NULL
	DROP TABLE dbo.cu_custodia_resp_vig
GO

CREATE TABLE dbo.cu_custodia_resp_vig
	(
	cr_codigo_externo VARCHAR (64),
	cr_contable       cuenta
	)
GO

CREATE INDEX cu_custodia_resp_k1
	ON dbo.cu_custodia_resp_vig (cr_codigo_externo)
GO

CREATE INDEX cu_custodia_resp_k2
	ON dbo.cu_custodia_resp_vig (cr_contable)
GO

IF OBJECT_ID ('dbo.cu_custodia_resp') IS NOT NULL
	DROP TABLE dbo.cu_custodia_resp
GO

CREATE TABLE dbo.cu_custodia_resp
	(
	cr_codigo_externo      VARCHAR (64),
	cr_estado              VARCHAR (1),
	cr_oficina_contabiliza INT,
	cr_moneda              INT,
	cr_tipo                VARCHAR (24),
	cr_valor               MONEY,
	cr_clase_custodia      VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cu_custodia_mig') IS NOT NULL
	DROP TABLE dbo.cu_custodia_mig
GO

CREATE TABLE dbo.cu_custodia_mig
	(
	mcu_abierta_cerrada      CHAR (1),
	mcu_acum_ajuste          MONEY,
	mcu_agotada              CHAR (1),
	mcu_castigo              CHAR (1),
	mcu_ciudad_gar           INT,
	mcu_ciudad_prenda        INT,
	mcu_clase_cartera        CHAR (1),
	mcu_clase_custodia       CHAR (1),
	mcu_compartida           CHAR (1),
	mcu_cuantia              CHAR (1),
	mcu_disponible           FLOAT,
	mcu_estado               catalogo,
	mcu_estado_credito       catalogo,
	mcu_expedido             CHAR (1),
	mcu_fecha_ingreso        DATETIME,
	mcu_fecha_insp           DATETIME,
	mcu_fecha_prox_insp      DATETIME,
	mcu_fecha_reg            DATETIME,
	mcu_fuente_valor         catalogo,
	mcu_inspeccionar         CHAR (1),
	mcu_moneda               TINYINT,
	mcu_nro_inspecciones     TINYINT,
	mcu_num_acciones         INT,
	mcu_num_dcto             VARCHAR (13),
	mcu_oficina              SMALLINT,
	mcu_oficina_contabiliza  SMALLINT,
	mcu_periodicidad         catalogo,
	mcu_porcentaje_cobertura FLOAT,
	mcu_porcentaje_comp      FLOAT,
	mcu_propietario          VARCHAR (64),
	mcu_propuesta            INT,
	mcu_provisiona           CHAR (1),
	mcu_siniestro            CHAR (1),
	mcu_sucursal             SMALLINT,
	mcu_tipo                 descripcion,
	mcu_ubicacion            catalogo,
	mcu_valor_accion         MONEY,
	mcu_valor_actual         FLOAT,
	mcu_valor_cobertura      FLOAT,
	mcu_valor_compartida     MONEY,
	mcu_valor_inicial        FLOAT,
	mcu_valor_original       FLOAT,
	mcu_vlr_cuantia          MONEY,
	mcu_costo1               INT,
	mcu_costo2               INT,
	mcu_estado_err           VARCHAR (50)
	)
GO

CREATE INDEX cu_custodiaxdcto
	ON dbo.cu_custodia_mig (mcu_num_dcto)
GO

IF OBJECT_ID ('dbo.cu_custodia') IS NOT NULL
	DROP TABLE dbo.cu_custodia
GO

CREATE TABLE dbo.cu_custodia
	(
	cu_filial               TINYINT NOT NULL,
	cu_sucursal             SMALLINT NOT NULL,
	cu_tipo                 descripcion NOT NULL,
	cu_custodia             INT NOT NULL,
	cu_propuesta            INT,
	cu_estado               catalogo,
	cu_fecha_ingreso        DATETIME,
	cu_valor_inicial        FLOAT,
	cu_valor_actual         FLOAT,
	cu_moneda               TINYINT,
	cu_garante              INT,
	cu_instruccion          VARCHAR (255),
	cu_descripcion          VARCHAR (255),
	cu_poliza               VARCHAR (20),
	cu_inspeccionar         CHAR (1),
	cu_motivo_noinsp        catalogo,
	cu_suficiencia_legal    CHAR (1),
	cu_fuente_valor         catalogo,
	cu_situacion            CHAR (1),
	cu_almacenera           SMALLINT,
	cu_aseguradora          VARCHAR (20),
	cu_cta_inspeccion       ctacliente,
	cu_tipo_cta             VARCHAR (8),
	cu_direccion_prenda     VARCHAR (255),
	cu_ciudad_prenda        INT,
	cu_telefono_prenda      VARCHAR (20),
	cu_mex_prx_inspec       TINYINT,
	cu_fecha_modif          DATETIME,
	cu_fecha_const          DATETIME,
	cu_porcentaje_valor     FLOAT,
	cu_periodicidad         catalogo,
	cu_depositario          VARCHAR (255),
	cu_posee_poliza         CHAR (1),
	cu_nro_inspecciones     TINYINT,
	cu_intervalo            SMALLINT,
	cu_cobranza_judicial    CHAR (1),
	cu_fecha_retiro         DATETIME,
	cu_fecha_devolucion     DATETIME,
	cu_fecha_modificacion   DATETIME,
	cu_usuario_crea         descripcion,
	cu_usuario_modifica     descripcion,
	cu_estado_poliza        catalogo,
	cu_cobrar_comision      CHAR (1),
	cu_cuenta_dpf           VARCHAR (30),
	cu_codigo_externo       VARCHAR (64) NOT NULL,
	cu_fecha_insp           DATETIME,
	cu_abierta_cerrada      CHAR (1),
	cu_adecuada_noadec      CHAR (1),
	cu_propietario          VARCHAR (64),
	cu_plazo_fijo           VARCHAR (30),
	cu_monto_pfijo          MONEY,
	cu_oficina              SMALLINT,
	cu_oficina_contabiliza  SMALLINT,
	cu_compartida           CHAR (1),
	cu_valor_compartida     MONEY,
	cu_fecha_reg            DATETIME NOT NULL,
	cu_fecha_prox_insp      DATETIME,
	cu_num_acciones         INT,
	cu_valor_accion         MONEY,
	cu_porcentaje_comp      FLOAT,
	cu_ubicacion            catalogo,
	cu_estado_credito       catalogo,
	cu_cuantia              CHAR (1),
	cu_vlr_cuantia          MONEY,
	cu_num_dcto             VARCHAR (13),
	cu_valor_refer_comis    MONEY,
	cu_fecha_desde          DATETIME,
	cu_fecha_hasta          DATETIME,
	cu_fecha_impred         DATETIME,
	cu_clase_cartera        CHAR (1),
	cu_acum_ajuste          MONEY,
	cu_autoriza             VARCHAR (25),
	cu_licencia             VARCHAR (20),
	cu_fecha_vcto           DATETIME,
	cu_fecha_vencimiento    DATETIME,
	cu_porcentaje_cobertura FLOAT,
	cu_fecha_avaluo         DATETIME,
	cu_entidad_emisora      INT,
	cu_fuente_valor_accion  catalogo,
	cu_fecha_accion         DATETIME,
	cu_valor_cobertura      FLOAT,
	cu_entidad_esp          catalogo,
	cu_valor_comision       MONEY,
	cu_grado_gar            catalogo,
	cu_provisiona           CHAR (1) NOT NULL,
	cu_fnro_documento       VARCHAR (16),
	cu_fvalor_bruto         MONEY,
	cu_fanticipos           MONEY,
	cu_fpor_impuestos       FLOAT,
	cu_fpor_retencion       FLOAT,
	cu_fvalor_neto          MONEY,
	cu_ffecha_emision       DATETIME,
	cu_ffecha_vtodoc        DATETIME,
	cu_ffecha_inineg        DATETIME,
	cu_ffecha_vtoneg        DATETIME,
	cu_ffecha_pago          DATETIME,
	cu_fbase_calculo        catalogo,
	cu_fdias_negocio        INT,
	cu_fnum_dex             VARCHAR (16),
	cu_ffecha_dex           DATETIME,
	cu_fproveedor           INT,
	cu_fcomprador           INT,
	cu_fresp_pago           INT,
	cu_fresp_dscto          INT,
	cu_ftasa                FLOAT,
	cu_disponible           FLOAT,
	cu_pago                 CHAR (1),
	cu_siniestro            CHAR (1),
	cu_castigo              CHAR (1),
	cu_agotada              CHAR (1),
	cu_clase_custodia       CHAR (1),
	cu_fecha_sol_exp        DATETIME,
	cu_fecha_apr_pre        DATETIME,
	cu_fecha_apr            DATETIME,
	cu_num_acta_apr_pre     VARCHAR (16),
	cu_num_acta_apr         VARCHAR (16),
	cu_fecha_sol_rec        DATETIME,
	cu_fecha_sol_ren        DATETIME,
	cu_fecha_pro            DATETIME,
	cu_clase_vehiculo       VARCHAR (10),
	cu_expedido             CHAR (1),
	cu_causa_nexp           catalogo,
	cu_ciudad_gar           INT,
	cu_valor_original       FLOAT,
	cu_cuenta_hold           cuenta
	)
GO

CREATE UNIQUE INDEX cu_custodia_Key
	ON dbo.cu_custodia (cu_codigo_externo)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_custodia_i2
	ON dbo.cu_custodia (cu_custodia, cu_tipo, cu_sucursal, cu_filial)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_custodia_i3
	ON dbo.cu_custodia (cu_tipo, cu_custodia)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_custodia_i4
	ON dbo.cu_custodia (cu_oficina)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_custodia_i5
	ON dbo.cu_custodia (cu_garante)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_custodia_i6
	ON dbo.cu_custodia (cu_estado)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cu_cuentas_conta') IS NOT NULL
	DROP TABLE dbo.cu_cuentas_conta
GO

CREATE TABLE dbo.cu_cuentas_conta
	(
	cc_fecha   DATETIME,
	cc_cuenta  VARCHAR (24),
	cc_oficina INT,
	cc_area    VARCHAR (12),
	cc_ente    INT,
	cc_valor   MONEY,
	cc_debcre  CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cu_cuentas_ajuste') IS NOT NULL
	DROP TABLE dbo.cu_cuentas_ajuste
GO

CREATE TABLE dbo.cu_cuentas_ajuste
	(
	ca_cuenta        cuenta,
	ca_cuenta_contra cuenta,
	ca_tipo_oficina  catalogo,
	ca_tipo_area     catalogo,
	ca_estado        catalogo,
	ca_fecha         DATETIME NOT NULL,
	ca_usuario       login,
	ca_producto      SMALLINT NOT NULL,
	ca_tipo          VARCHAR (1) NOT NULL,
	ca_garantia      cuenta
	)
GO

IF OBJECT_ID ('dbo.cu_cotizacion_moneda_si2') IS NOT NULL
	DROP TABLE dbo.cu_cotizacion_moneda_si2
GO

CREATE TABLE dbo.cu_cotizacion_moneda_si2
	(
	moneda     TINYINT,
	cotizacion MONEY,
	sesion     INT
	)
GO

CREATE INDEX cu_cotmoneda_si2_key
	ON dbo.cu_cotizacion_moneda_si2 (sesion)
GO

IF OBJECT_ID ('dbo.cu_cotizacion_moneda') IS NOT NULL
	DROP TABLE dbo.cu_cotizacion_moneda
GO

CREATE TABLE dbo.cu_cotizacion_moneda
	(
	moneda     TINYINT,
	cotizacion MONEY,
	fecha      DATETIME
	)
GO

CREATE INDEX cu_cotizacion_moneda_key
	ON dbo.cu_cotizacion_moneda (fecha)
GO

IF OBJECT_ID ('dbo.cu_cotiz_custo') IS NOT NULL
	DROP TABLE dbo.cu_cotiz_custo
GO

CREATE TABLE dbo.cu_cotiz_custo
	(
	moneda     TINYINT,
	cotizacion MONEY,
	sesion     INT NOT NULL
	)
GO

CREATE INDEX cu_cotiz_custo_key
	ON dbo.cu_cotiz_custo (sesion)
GO

IF OBJECT_ID ('dbo.cu_cot_mon_cred4') IS NOT NULL
	DROP TABLE dbo.cu_cot_mon_cred4
GO

CREATE TABLE dbo.cu_cot_mon_cred4
	(
	moneda     TINYINT,
	cotizacion MONEY,
	sesion     INT
	)
GO

CREATE INDEX cu_cot_mon_cred4_k1
	ON dbo.cu_cot_mon_cred4 (sesion, moneda)
GO

IF OBJECT_ID ('dbo.cu_convenios_garantia') IS NOT NULL
	DROP TABLE dbo.cu_convenios_garantia
GO

CREATE TABLE dbo.cu_convenios_garantia
	(
	cg_tipo_garantia    VARCHAR (64),
	cg_codigo_convenio  VARCHAR (10),
	cg_moneda           SMALLINT,
	cg_monto            MONEY,
	cg_monto_mn         MONEY,
	cg_monto_aumento    MONEY,
	cg_saldo_disponible MONEY,
	cg_valor_utilizado  MONEY,
	cg_valor_reservado  MONEY,
	cg_estado           VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cu_control_inspector') IS NOT NULL
	DROP TABLE dbo.cu_control_inspector
GO

CREATE TABLE dbo.cu_control_inspector
	(
	ci_inspector       INT NOT NULL,
	ci_fenvio_carta    DATETIME NOT NULL,
	ci_frecep_reporte  DATETIME,
	ci_valor_facturado MONEY,
	ci_valor_pagado    MONEY,
	ci_fecha_pago      DATETIME,
	ci_fmaxrecep       DATETIME NOT NULL,
	ci_lote            TINYINT,
	ci_pago            CHAR (1)
	)
GO

CREATE UNIQUE INDEX cu_control_inspector_Key
	ON dbo.cu_control_inspector (ci_inspector, ci_fenvio_carta, ci_lote)
GO

IF OBJECT_ID ('dbo.cu_control_abogado') IS NOT NULL
	DROP TABLE dbo.cu_control_abogado
GO

CREATE TABLE dbo.cu_control_abogado
	(
	ca_abogado         catalogo NOT NULL,
	ca_valor_facturado MONEY,
	ca_valor_pagado    MONEY,
	ca_fecha_pago      DATETIME,
	ca_fenvio_carta    DATETIME,
	ca_frecep_reporte  DATETIME,
	ca_lote            TINYINT,
	ca_pago            CHAR (1)
	)
GO

CREATE UNIQUE INDEX cu_control_abogado_Key
	ON dbo.cu_control_abogado (ca_abogado, ca_fenvio_carta, ca_lote)
GO

IF OBJECT_ID ('dbo.cu_concilia_cert') IS NOT NULL
	DROP TABLE dbo.cu_concilia_cert
GO

CREATE TABLE dbo.cu_concilia_cert
	(
	cc_llave_red      cuenta,
	cc_fecha_red      DATETIME,
	cc_cod_cliente    INT,
	cc_id_cliente     VARCHAR (30),
	cc_nom_cli        VARCHAR (254),
	cc_val_red        MONEY,
	cc_certif         VARCHAR (13),
	cc_est_banco      VARCHAR (10),
	cc_est_fin        CHAR (1),
	cc_desc_fin       VARCHAR (30),
	cc_codigo_externo VARCHAR (64),
	cc_tipo           CHAR (2),
	cc_tramite        INT
	)
GO

CREATE INDEX cu_concilia_cert_key
	ON dbo.cu_concilia_cert (cc_tipo)
GO

IF OBJECT_ID ('dbo.cu_concepto_avaluo') IS NOT NULL
	DROP TABLE dbo.cu_concepto_avaluo
GO

CREATE TABLE dbo.cu_concepto_avaluo
	(
	ca_custodia VARCHAR (64) NOT NULL,
	ca_avaluo   INT NOT NULL,
	ca_concepto VARCHAR (10) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_compartida') IS NOT NULL
	DROP TABLE dbo.cu_compartida
GO

CREATE TABLE dbo.cu_compartida
	(
	co_codigo_externo   VARCHAR (64) NOT NULL,
	co_secuencial       INT NOT NULL,
	co_valor_compartida FLOAT,
	co_entidad          INT,
	co_fecha_comp       DATETIME,
	co_grado_comp       catalogo,
	co_porcentaje_comp  FLOAT,
	co_valor_contable   FLOAT,
	co_porcentaje_banco FLOAT
	)
GO

CREATE UNIQUE INDEX cu_compartida_Key
	ON dbo.cu_compartida (co_codigo_externo, co_secuencial)
GO

IF OBJECT_ID ('dbo.cu_colateral_det_tmp') IS NOT NULL
	DROP TABLE dbo.cu_colateral_det_tmp
GO

CREATE TABLE dbo.cu_colateral_det_tmp
	(
	cdt_ente_pas     INT NOT NULL,
	cdt_codigo_pas   cuenta NOT NULL,
	cdt_banco_act    cuenta NOT NULL,
	cdt_toperacion   catalogo NOT NULL,
	cdt_cliente      INT NOT NULL,
	cdt_oficina      SMALLINT NOT NULL,
	cdt_monto        MONEY NOT NULL,
	cdt_tasa         FLOAT NOT NULL,
	cdt_calificacion VARCHAR (10) NOT NULL,
	cdt_fecha_ini    DATETIME NOT NULL,
	cdt_fecha_fin    DATETIME NOT NULL,
	cdt_saldo_cap    MONEY NOT NULL,
	cdt_saldo_int    MONEY NOT NULL,
	cdt_amor_cap     catalogo NOT NULL,
	cdt_amor_int     catalogo NOT NULL,
	cdt_fecha_proc   DATETIME NOT NULL,
	cdt_accion       CHAR (1) NOT NULL,
	cdt_orden        INT
	)
GO

CREATE UNIQUE INDEX cu_colateral_det_tmp_1
	ON dbo.cu_colateral_det_tmp (cdt_banco_act, cdt_ente_pas, cdt_codigo_pas, cdt_accion, cdt_fecha_proc)
GO

CREATE INDEX cu_colateral_det_tmp_2
	ON dbo.cu_colateral_det_tmp (cdt_ente_pas, cdt_codigo_pas)
GO

IF OBJECT_ID ('dbo.cu_colateral_det') IS NOT NULL
	DROP TABLE dbo.cu_colateral_det
GO

CREATE TABLE dbo.cu_colateral_det
	(
	cd_ente_pas     INT NOT NULL,
	cd_codigo_pas   cuenta NOT NULL,
	cd_banco_act    cuenta NOT NULL,
	cd_toperacion   catalogo NOT NULL,
	cd_cliente      INT NOT NULL,
	cd_oficina      SMALLINT NOT NULL,
	cd_monto        MONEY NOT NULL,
	cd_tasa         FLOAT NOT NULL,
	cd_calificacion VARCHAR (10) NOT NULL,
	cd_fecha_ini    DATETIME NOT NULL,
	cd_fecha_fin    DATETIME NOT NULL,
	cd_saldo_cap    MONEY NOT NULL,
	cd_saldo_int    MONEY NOT NULL,
	cd_amor_cap     catalogo NOT NULL,
	cd_amor_int     catalogo NOT NULL,
	cd_fecha_proc   DATETIME NOT NULL
	)
GO

CREATE UNIQUE INDEX cu_colateral_det_1
	ON dbo.cu_colateral_det (cd_banco_act, cd_ente_pas, cd_codigo_pas, cd_fecha_proc)
GO

CREATE INDEX cu_colateral_det_2
	ON dbo.cu_colateral_det (cd_ente_pas, cd_codigo_pas)
GO

IF OBJECT_ID ('dbo.cu_colat_adic') IS NOT NULL
	DROP TABLE dbo.cu_colat_adic
GO

CREATE TABLE dbo.cu_colat_adic
	(
	ca_codigo_cust VARCHAR (64),
	ca_comparte    CHAR (1)
	)
GO

CREATE INDEX idx1
	ON dbo.cu_colat_adic (ca_codigo_cust)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cu_codigo_valor') IS NOT NULL
	DROP TABLE dbo.cu_codigo_valor
GO

CREATE TABLE dbo.cu_codigo_valor
	(
	cv_codval      INT NOT NULL,
	cv_descripcion VARCHAR (160),
	cv_tipo        VARCHAR (64) NOT NULL,
	cv_estado      CHAR (1)
	)
GO

CREATE UNIQUE INDEX cu_codvalKey
	ON dbo.cu_codigo_valor (cv_tipo, cv_codval, cv_estado)
GO

IF OBJECT_ID ('dbo.cu_cliente_si2') IS NOT NULL
	DROP TABLE dbo.cu_cliente_si2
GO

CREATE TABLE dbo.cu_cliente_si2
	(
	cl_cliente INT,
	cl_tipo    CHAR (1),
	cl_rol     CHAR (1),
	sesion     INT
	)
GO

CREATE INDEX cu_cliente_key
	ON dbo.cu_cliente_si2 (sesion)
GO

IF OBJECT_ID ('dbo.cu_cliente_garantia_mig') IS NOT NULL
	DROP TABLE dbo.cu_cliente_garantia_mig
GO

CREATE TABLE dbo.cu_cliente_garantia_mig
	(
	mcg_sucursal     SMALLINT NOT NULL,
	mcg_tipo_cust    descripcion,
	mcg_num_dcto     INT,
	mcg_principal    CHAR (1),
	mcg_oficial      INT,
	mcg_tipo_garante catalogo,
	mcg_nombre       VARCHAR (64),
	mcg_cedula       VARCHAR (30),
	mcg_tipo_cedula  CHAR (2),
	mcg_costo1       INT,
	mcg_costo2       INT,
	mcg_estado_err   VARCHAR (50)
	)
GO

CREATE INDEX cu_clien_garxdcto
	ON dbo.cu_cliente_garantia_mig (mcg_num_dcto)
GO

IF OBJECT_ID ('dbo.cu_cliente_garantia') IS NOT NULL
	DROP TABLE dbo.cu_cliente_garantia
GO

CREATE TABLE dbo.cu_cliente_garantia
	(
	cg_filial         TINYINT NOT NULL,
	cg_sucursal       SMALLINT NOT NULL,
	cg_tipo_cust      descripcion NOT NULL,
	cg_custodia       INT NOT NULL,
	cg_ente           INT NOT NULL,
	cg_principal      CHAR (1),
	cg_codigo_externo VARCHAR (64) NOT NULL,
	cg_oficial        INT,
	cg_propietario    CHAR (1),
	cg_tipo_garante   catalogo,
	cg_vinculo        catalogo,
	cg_nombre         VARCHAR (64)
	)
GO

CREATE UNIQUE INDEX cu_cliente_garantia_Key
	ON dbo.cu_cliente_garantia (cg_ente, cg_codigo_externo)
	WITH (FILLFACTOR = 75)
GO

CREATE UNIQUE INDEX cu_cliente_garantia_1
	ON dbo.cu_cliente_garantia (cg_ente, cg_codigo_externo)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX cu_cliente_garantia_2
	ON dbo.cu_cliente_garantia (cg_oficial)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX cu_cliente_garantia_3
	ON dbo.cu_cliente_garantia (cg_codigo_externo)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_cliente_garantia_i4
	ON dbo.cu_cliente_garantia (cg_filial, cg_sucursal, cg_tipo_cust, cg_custodia)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_cliente_i2
	ON dbo.cu_cliente_garantia (cg_oficial)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX i_cu_cliente_i3
	ON dbo.cu_cliente_garantia (cg_codigo_externo)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cu_cliente_cred4') IS NOT NULL
	DROP TABLE dbo.cu_cliente_cred4
GO

CREATE TABLE dbo.cu_cliente_cred4
	(
	cl_cliente INT,
	cl_tipo    CHAR (1),
	cl_rol     CHAR (1),
	sesion     INT
	)
GO

CREATE INDEX cu_cliente_cred4_k1
	ON dbo.cu_cliente_cred4 (sesion, cl_cliente)
GO

IF OBJECT_ID ('dbo.cu_clase_vehiculo') IS NOT NULL
	DROP TABLE dbo.cu_clase_vehiculo
GO

CREATE TABLE dbo.cu_clase_vehiculo
	(
	cv_tipo        VARCHAR (64),
	cv_clase       VARCHAR (10),
	cv_descripcion VARCHAR (64)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_clase_vehiculo_Key
	ON dbo.cu_clase_vehiculo (cv_tipo, cv_clase)
GO

IF OBJECT_ID ('dbo.cu_ciudad_porcentaje') IS NOT NULL
	DROP TABLE dbo.cu_ciudad_porcentaje
GO

CREATE TABLE dbo.cu_ciudad_porcentaje
	(
	cp_ciudad     catalogo,
	cp_porcentaje FLOAT
	)
GO

IF OBJECT_ID ('dbo.cu_ciu_porcest') IS NOT NULL
	DROP TABLE dbo.cu_ciu_porcest
GO

CREATE TABLE dbo.cu_ciu_porcest
	(
	cp_ciudad     catalogo,
	cp_estrato    catalogo,
	cp_porcentaje FLOAT
	)
GO

IF OBJECT_ID ('dbo.cu_cifagm') IS NOT NULL
	DROP TABLE dbo.cu_cifagm
GO

CREATE TABLE dbo.cu_cifagm
	(
	cm_regional       INT,
	cm_oficina        INT,
	cm_operacion      INT,
	cm_banco          CHAR (24),
	cm_llave_red      CHAR (24),
	cm_cliente        INT NOT NULL,
	cm_identific      VARCHAR (13),
	cm_nombre         descripcion,
	cm_fecha          DATETIME,
	cm_codigo_externo VARCHAR (64),
	cm_certificado    VARCHAR (13),
	cm_saldo          MONEY,
	cm_porc_resp      FLOAT,
	cm_valor_resp     MONEY,
	cm_val_com        MONEY,
	cm_val_iva        MONEY,
	cm_tramite        INT,
	cm_dividendo      INT
	)
GO

CREATE INDEX cu_cifagm_AKey
	ON dbo.cu_cifagm (cm_operacion, cm_tramite)
GO

CREATE INDEX cu_cifagm_BKey
	ON dbo.cu_cifagm (cm_oficina)
GO

CREATE INDEX cu_cifagm_Key
	ON dbo.cu_cifagm (cm_cliente)
GO

IF OBJECT_ID ('dbo.cu_cifagd') IS NOT NULL
	DROP TABLE dbo.cu_cifagd
GO

CREATE TABLE dbo.cu_cifagd
	(
	co_regional       INT,
	co_oficina        INT,
	co_operacion      INT,
	co_banco          CHAR (24),
	co_llave_red      CHAR (24),
	co_cliente        INT NOT NULL,
	co_identific      VARCHAR (13),
	co_nombre         descripcion,
	co_codigo_externo VARCHAR (64),
	co_tipo_gar       descripcion,
	co_desc_tg        VARCHAR (255),
	co_certificado    VARCHAR (13),
	co_saldo          MONEY,
	co_porc_resp      FLOAT,
	co_valor_resp     MONEY,
	co_val_com        MONEY,
	co_val_iva        MONEY,
	co_tramite        INT
	)
GO

CREATE INDEX cu_cifagd_AKey
	ON dbo.cu_cifagd (co_operacion, co_tramite)
GO

CREATE INDEX cu_cifagd_BKey
	ON dbo.cu_cifagd (co_oficina)
GO

CREATE INDEX cu_cifagd_Key
	ON dbo.cu_cifagd (co_cliente)
GO

IF OBJECT_ID ('dbo.cu_certfag') IS NOT NULL
	DROP TABLE dbo.cu_certfag
GO

CREATE TABLE dbo.cu_certfag
	(
	ce_operacion INT,
	ce_regional  INT,
	ce_oficina   INT,
	ce_banco     cuenta,
	ce_llave_red cuenta,
	ce_fecha_red DATETIME,
	ce_cliente   INT,
	ce_nom_cli   VARCHAR (254),
	ce_pagare    VARCHAR (64),
	ce_valor     MONEY,
	ce_certif    VARCHAR (13),
	ce_cobert    FLOAT,
	ce_norma     VARCHAR (16),
	ce_destino   catalogo,
	ce_plazo     INT,
	ce_teplazo   INT,
	ce_periodo   INT,
	ce_tplazo    catalogo,
	ce_tdiv      catalogo,
	ce_est_gar   CHAR (1),
	ce_tramite   INT,
	ce_tram_act  INT
	)
GO

IF OBJECT_ID ('dbo.cu_carga_contgar58') IS NOT NULL
	DROP TABLE dbo.cu_carga_contgar58
GO

CREATE TABLE dbo.cu_carga_contgar58
	(
	cc_cuenta    VARCHAR (30) NOT NULL,
	cc_documento VARCHAR (64) NOT NULL
	)
GO

CREATE INDEX cu_carga_contgar58_key
	ON dbo.cu_carga_contgar58 (cc_cuenta)
GO

IF OBJECT_ID ('dbo.cu_carga_contgar3') IS NOT NULL
	DROP TABLE dbo.cu_carga_contgar3
GO

CREATE TABLE dbo.cu_carga_contgar3
	(
	cc_cuenta    VARCHAR (30) NOT NULL,
	cc_documento VARCHAR (64) NOT NULL
	)
GO

CREATE INDEX cu_carga_contgar3_key
	ON dbo.cu_carga_contgar3 (cc_cuenta)
GO

IF OBJECT_ID ('dbo.cu_cambios_garantias') IS NOT NULL
	DROP TABLE dbo.cu_cambios_garantias
GO

CREATE TABLE dbo.cu_cambios_garantias
	(
	cg_oficina    INT,
	cg_regional   INT,
	cg_banco      cuenta,
	cg_fecha_liq  DATETIME,
	cg_monto      MONEY,
	cg_cliente    INT,
	cg_id_cliente VARCHAR (64),
	cg_nom_cli    VARCHAR (255),
	cg_gar_act    VARCHAR (64),
	cg_gar_ant    VARCHAR (64),
	cg_porcentaje FLOAT
	)
GO

IF OBJECT_ID ('dbo.cu_cambios_estado') IS NOT NULL
	DROP TABLE dbo.cu_cambios_estado
GO

CREATE TABLE dbo.cu_cambios_estado
	(
	ce_estado_ini  CHAR (1) NOT NULL,
	ce_estado_fin  CHAR (1) NOT NULL,
	ce_contabiliza CHAR (1) NOT NULL,
	ce_tran        catalogo NOT NULL,
	ce_tipo        CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cu_cabecera_custodia') IS NOT NULL
	DROP TABLE dbo.cu_cabecera_custodia
GO

CREATE TABLE dbo.cu_cabecera_custodia
	(
	cc_fecha DATETIME NOT NULL,
	cc_tipo  CHAR (1) NOT NULL
	)
GO

CREATE INDEX aKey
	ON dbo.cu_cabecera_custodia (cc_fecha)
GO

IF OBJECT_ID ('dbo.cu_avaluos') IS NOT NULL
	DROP TABLE dbo.cu_avaluos
GO

CREATE TABLE dbo.cu_avaluos
	(
	av_custodia     VARCHAR (64) NOT NULL,
	av_avaluo       INT NOT NULL,
	av_fec_avaluo   DATETIME NOT NULL,
	av_fec_visita   DATETIME NOT NULL,
	av_comentario   VARCHAR (255),
	av_valor        MONEY NOT NULL,
	av_nombre       VARCHAR (64) NOT NULL,
	av_p_apellido   VARCHAR (16),
	av_s_apellido   VARCHAR (16),
	av_usuario_crea login NOT NULL,
	av_fec_reg      DATETIME NOT NULL,
	av_usuario_mod  login NOT NULL,
	av_fec_mod      DATETIME NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_archivos_cargados_mig') IS NOT NULL
	DROP TABLE dbo.cu_archivos_cargados_mig
GO

CREATE TABLE dbo.cu_archivos_cargados_mig
	(
	ac_archivo VARCHAR (30) NOT NULL,
	ac_user    login NOT NULL,
	ac_date    DATETIME NOT NULL,
	ac_sesn    INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cu_almacenera') IS NOT NULL
	DROP TABLE dbo.cu_almacenera
GO

CREATE TABLE dbo.cu_almacenera
	(
	al_almacenera SMALLINT NOT NULL,
	al_nombre     descripcion,
	al_direccion  descripcion,
	al_telefono   VARCHAR (20),
	al_estado     CHAR (3) NOT NULL,
	al_licencia   VARCHAR (20)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cu_almacenera_Key
	ON dbo.cu_almacenera (al_almacenera)
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta_mig') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta_mig
GO

CREATE TABLE dbo.cr_gar_propuesta_mig
	(
	mgp_abierta             CHAR (1) NOT NULL,
	mgp_est_garantia        CHAR (1) NOT NULL,
	mgp_porcentaje          FLOAT,
	mgp_valor_resp_garantia MONEY,
	mgp_solicitud_mig       VARCHAR (16),
	mgp_num_dcto            VARCHAR (13),
	mgp_costo1              INT,
	mgp_costo2              INT,
	mgp_estado_err          VARCHAR (50)
	)
GO

CREATE INDEX cu_gar_propuestaxoblig
	ON dbo.cr_gar_propuesta_mig (mgp_solicitud_mig)
GO

CREATE INDEX cr_gar_propxdcto
	ON dbo.cr_gar_propuesta_mig (mgp_num_dcto)
GO

IF OBJECT_ID ('dbo.cm_migracion_garantia') IS NOT NULL
	DROP TABLE dbo.cm_migracion_garantia
GO

CREATE TABLE dbo.cm_migracion_garantia
	(
	cm_ente_migracion     INT NOT NULL,
	cm_tipo_migracion     CHAR (2) NOT NULL,
	cm_ced_rucc_migracion VARCHAR (30) NOT NULL,
	cm_garantia           VARCHAR (64) NOT NULL,
	cm_tipo_reico         descripcion NOT NULL,
	cm_tcliente_gar       CHAR (1),
	cm_tgarpropuesta      CHAR (1),
	cm_cobcobisgarantia   VARCHAR (64) NOT NULL,
	cm_cobsecuencial      INT NOT NULL,
	cm_oficialmig         INT,
	cm_nombre             VARCHAR (64)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cm_migracion_garantia_Key
	ON dbo.cm_migracion_garantia (cm_garantia)
GO

IF OBJECT_ID ('dbo.cl_tabla_tmp') IS NOT NULL
	DROP TABLE dbo.cl_tabla_tmp
GO

CREATE TABLE dbo.cl_tabla_tmp
	(
	codigo      SMALLINT NOT NULL,
	tabla       CHAR (30) NOT NULL,
	descripcion VARCHAR (64) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cl_catalogo_tmp') IS NOT NULL
	DROP TABLE dbo.cl_catalogo_tmp
GO

CREATE TABLE dbo.cl_catalogo_tmp
	(
	tabla  SMALLINT NOT NULL,
	codigo CHAR (10) NOT NULL,
	valor  VARCHAR (64) NOT NULL,
	estado CHAR (1) NOT NULL
	)
GO

