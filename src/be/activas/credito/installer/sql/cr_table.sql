USE cob_credito
GO

IF OBJECT_ID ('dbo.ts_hono_mora') IS NOT NULL
	DROP TABLE dbo.ts_hono_mora
GO

CREATE TABLE dbo.ts_hono_mora
	(
	hm_secuencial_ts       INT,
	hm_cod_alterno_ts      TINYINT,
	hm_tipo_transaccion_ts SMALLINT,
	hm_clase_ts            CHAR (1),
	hm_fecha_ts            DATETIME,
	hm_usuario_ts          login,
	hm_terminal_ts         VARCHAR (30),
	hm_oficina_ts          SMALLINT,
	hm_tabla_ts            VARCHAR (20),
	hm_fecha_real_ts       DATETIME,
	hm_operacion_ts        CHAR (1),
	hm_codigo_ts           INT,
	hm_estado_cobranza_ts  catalogo,
	hm_dia_inicial_ts      SMALLINT,
	hm_dia_final_ts        SMALLINT,
	hm_anio_castigo_ts     SMALLINT,
	hm_tasa_cobrar_ts      FLOAT,
	hm_tarifa_unica_ts     MONEY
	)
GO

IF OBJECT_ID ('dbo.ts_hono_abogado') IS NOT NULL
	DROP TABLE dbo.ts_hono_abogado
GO

CREATE TABLE dbo.ts_hono_abogado
	(
	ha_secuencial_ts       INT,
	ha_cod_alterno_ts      TINYINT,
	ha_tipo_transaccion_ts SMALLINT,
	ha_clase_ts            CHAR (1),
	ha_fecha_ts            DATETIME,
	ha_usuario_ts          login,
	ha_terminal_ts         VARCHAR (30),
	ha_oficina_ts          SMALLINT,
	ha_tabla_ts            VARCHAR (20),
	ha_fecha_real_ts       DATETIME,
	ha_operacion_ts        CHAR (1),
	ha_id_abogado_ts       catalogo,
	ha_codigo_honorario_ts INT,
	ha_tasa_cobrar_ts      FLOAT,
	ha_tarifa_unica_ts     MONEY
	)
GO

IF OBJECT_ID ('dbo.ts_campana_toperacion') IS NOT NULL
	DROP TABLE dbo.ts_campana_toperacion
GO

CREATE TABLE dbo.ts_campana_toperacion
	(
	ct_secuencial_ts       INT,
	ct_cod_alterno_ts      TINYINT,
	ct_tipo_transaccion_ts SMALLINT,
	ct_clase_ts            CHAR (1),
	ct_fecha_ts            DATETIME,
	ct_usuario_ts          login,
	ct_terminal_ts         VARCHAR (30),
	ct_oficina_ts          SMALLINT,
	ct_tabla_ts            VARCHAR (20),
	ct_fecha_real_ts       DATETIME,
	ct_operacion           CHAR (1),
	ct_campana             INT,
	ct_toperacion          catalogo
	)
GO

IF OBJECT_ID ('dbo.tmp1') IS NOT NULL
	DROP TABLE dbo.tmp1
GO

CREATE TABLE dbo.tmp1
	(
	amm_concepto VARCHAR (10),
	amm_cuota    SMALLINT,
	amm_monto    MONEY,
	ro_fpago     CHAR (1) NOT NULL,
	ro_operacion INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.tiempo') IS NOT NULL
	DROP TABLE dbo.tiempo
GO

CREATE TABLE dbo.tiempo
	(
	Consecutivo INT,
	Texto       NVARCHAR (150),
	FechaHora   DATETIME
	)
GO

IF OBJECT_ID ('dbo.sysdiagrams') IS NOT NULL
	DROP TABLE dbo.sysdiagrams
GO

CREATE TABLE dbo.sysdiagrams
	(
	name         SYSNAME NOT NULL,
	principal_id INT NOT NULL,
	diagram_id   INT IDENTITY NOT NULL,
	version      INT,
	definition   VARBINARY (max),
	PRIMARY KEY (diagram_id),
	CONSTRAINT UK_principal_name UNIQUE (principal_id, name)
	)
GO

IF OBJECT_ID ('dbo.rp_info_financiera') IS NOT NULL
	DROP TABLE dbo.rp_info_financiera
GO

CREATE TABLE dbo.rp_info_financiera
	(
	usuario          login NOT NULL,
	sesion           INT NOT NULL,
	item             INT,
	codigo           INT,
	Nivel            VARCHAR (20),
	DescN1           VARCHAR (50),
	Nivel2           VARCHAR (50),
	DescN2           VARCHAR (50),
	Nivel3           VARCHAR (50),
	DescN3           VARCHAR (50),
	Nivel4           VARCHAR (50),
	DescN4           VARCHAR (50),
	Sumatoria        CHAR (1),
	Descripcion      VARCHAR (50),
	Valor            VARCHAR (50),
	Total            VARCHAR (50),
	id               INT,
	t_dif_secuencial INT,
	t_dif_codigo_var INT,
	Campo1           VARCHAR (50),
	Valor1           VARCHAR (50),
	Campo2           VARCHAR (50),
	Valor2           VARCHAR (50),
	Campo3           VARCHAR (50),
	Valor3           VARCHAR (50),
	Campo4           VARCHAR (50),
	Valor4           VARCHAR (50),
	Campo5           VARCHAR (50),
	Valor5           VARCHAR (50),
	Campo6           VARCHAR (50),
	Valor6           VARCHAR (50),
	Campo7           VARCHAR (50),
	Valor7           VARCHAR (50),
	Campo8           VARCHAR (50),
	Valor8           VARCHAR (50)
	)
GO

CREATE INDEX rp_info_financiera_1
	ON dbo.rp_info_financiera (usuario, sesion)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.rp_costo_merca_vendida') IS NOT NULL
	DROP TABLE dbo.rp_costo_merca_vendida
GO

CREATE TABLE dbo.rp_costo_merca_vendida
	(
	usuario           login NOT NULL,
	sesion            INT NOT NULL,
	t_secuencial      INT NOT NULL,
	t_cod_tipo        INT NOT NULL,
	t_microempresa    INT NOT NULL,
	t_item            descripcion,
	t_unidad          VARCHAR (10),
	t_cantidad        INT,
	t_valor_unit      MONEY,
	t_valor_total     MONEY,
	t_precio          MONEY,
	t_costo_mercancia INT,
	t_producto        descripcion,
	t_ventas          MONEY,
	t_part_ventas     FLOAT,
	t_costo           MONEY,
	t_costo_pond      FLOAT,
	t_precio_unidad   MONEY,
	t_unidad_prod     INT,
	t_precio_venta    MONEY,
	t_costo_var       MONEY,
	t_tipo_costo      CHAR (1),
	id                SMALLINT,
	t_titulo          VARCHAR (50)
	)
GO

CREATE INDEX rp_costo_merca_vendida_1
	ON dbo.rp_costo_merca_vendida (usuario, sesion)
GO

IF OBJECT_ID ('dbo.pivote') IS NOT NULL
	DROP TABLE dbo.pivote
GO

CREATE TABLE dbo.pivote
	(
	a            VARCHAR (50),
	INGRESO      VARCHAR (50),
	CALIFICACION VARCHAR (50),
	APROBACION   VARCHAR (50),
	FINAL        VARCHAR (50),
	sec_p        INT IDENTITY NOT NULL,
	orden        SMALLINT
	)
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

IF OBJECT_ID ('dbo.cr_variables_filtros') IS NOT NULL
	DROP TABLE dbo.cr_variables_filtros
GO

CREATE TABLE dbo.cr_variables_filtros
	(
	vf_filtro            INT,
	vf_variable          INT,
	vf_condicion         INT,
	vf_operador          CHAR (2),
	vf_valor_referencial VARCHAR (64),
	vf_puntaje           catalogo,
	vf_estado            VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cr_var_entrada_mir') IS NOT NULL
	DROP TABLE dbo.cr_var_entrada_mir
GO

CREATE TABLE dbo.cr_var_entrada_mir
	(
	ve_fecha         DATETIME NOT NULL,
	ve_tramite       INT NOT NULL,
	ve_orden         INT NOT NULL,
	ve_tipo          SMALLINT,
	ve_identificador VARCHAR (255),
	ve_valor         VARCHAR (255)
	)
GO

CREATE INDEX cr_var_entrada_mir_idx3
	ON dbo.cr_var_entrada_mir (ve_tramite, ve_orden)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx1
	ON dbo.cr_var_entrada_mir (ve_tramite)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx2
	ON dbo.cr_var_entrada_mir (ve_fecha)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_valor_variables_filtros') IS NOT NULL
	DROP TABLE dbo.cr_valor_variables_filtros
GO

CREATE TABLE dbo.cr_valor_variables_filtros
	(
	vv_ruta             INT,
	vv_etapa            INT,
	vv_filtro           INT,
	vv_ente             INT,
	vv_tramite          INT,
	vv_paso             INT,
	vv_variable         INT,
	vv_valor_obtenido   VARCHAR (64),
	vv_valor_modificado VARCHAR (64),
	vv_fecha_ult_modif  DATETIME,
	vv_login            login,
	vv_dictamen         CHAR (1),
	vv_dictamen_final   CHAR (1)
	)
GO

CREATE CLUSTERED INDEX idx1
	ON dbo.cr_valor_variables_filtros (vv_ruta, vv_etapa)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX idx2
	ON dbo.cr_valor_variables_filtros (vv_tramite)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX idx3
	ON dbo.cr_valor_variables_filtros (vv_ente)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX idx4
	ON dbo.cr_valor_variables_filtros (vv_ruta, vv_etapa, vv_filtro, vv_ente, vv_tramite, vv_dictamen_final)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX cr_valor_variables_filtros_idx5
	ON dbo.cr_valor_variables_filtros (vv_ruta, vv_etapa, vv_filtro, vv_variable, vv_ente, vv_tramite, vv_valor_modificado)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cr_valor_variables_filtros_idx6
	ON dbo.cr_valor_variables_filtros (vv_ruta, vv_etapa, vv_filtro, vv_dictamen, vv_ente, vv_tramite)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX cr_valor_variables_filtros_idx7
	ON dbo.cr_valor_variables_filtros (vv_ente, vv_tramite, vv_ruta, vv_etapa, vv_filtro, vv_paso, vv_variable, vv_valor_obtenido, vv_valor_modificado, vv_fecha_ult_modif, vv_login, vv_dictamen, vv_dictamen_final)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_valor_variables') IS NOT NULL
	DROP TABLE dbo.cr_valor_variables
GO

CREATE TABLE dbo.cr_valor_variables
	(
	vv_tramite  INT NOT NULL,
	vv_variable TINYINT NOT NULL,
	vv_valor    VARCHAR (20)
	)
GO

CREATE UNIQUE INDEX cr_valor_variables_Key
	ON dbo.cr_valor_variables (vv_tramite, vv_variable)
GO

IF OBJECT_ID ('dbo.cr_utiliz') IS NOT NULL
	DROP TABLE dbo.cr_utiliz
GO

CREATE TABLE dbo.cr_utiliz
	(
	s_ssn      INT NOT NULL,
	producto   VARCHAR (10),
	banco      VARCHAR (24),
	toperacion VARCHAR (10),
	monto      MONEY,
	saldo      MONEY,
	moneda     TINYINT,
	tramite    INT,
	nota       TINYINT
	)
GO

CREATE INDEX cr_utiliz_Key
	ON dbo.cr_utiliz (s_ssn, banco, producto)
GO

IF OBJECT_ID ('dbo.cr_truta') IS NOT NULL
	DROP TABLE dbo.cr_truta
GO

CREATE TABLE dbo.cr_truta
	(
	ru_truta       TINYINT NOT NULL,
	ru_descripcion descripcion NOT NULL,
	ru_tipo        CHAR (1),
	ru_directa     CHAR (1),
	ru_sobrepasa   CHAR (1),
	ru_asociativo  CHAR (1),
	ru_estado      catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_truta_Key
	ON dbo.cr_truta (ru_truta)
GO

IF OBJECT_ID ('dbo.cr_transaccion') IS NOT NULL
	DROP TABLE dbo.cr_transaccion
GO

CREATE TABLE dbo.cr_transaccion
	(
	tr_secuencial     INT NOT NULL,
	tr_fecha_mov      DATETIME NOT NULL,
	tr_toperacion     CHAR (10) NOT NULL,
	tr_moneda         TINYINT NOT NULL,
	tr_operacion      INT NOT NULL,
	tr_tran           CHAR (10) NOT NULL,
	tr_en_linea       CHAR (1) NOT NULL,
	tr_banco          CHAR (24) NOT NULL,
	tr_dias_calc      INT NOT NULL,
	tr_ofi_oper       SMALLINT NOT NULL,
	tr_ofi_usu        SMALLINT NOT NULL,
	tr_usuario        CHAR (14) NOT NULL,
	tr_terminal       CHAR (30) NOT NULL,
	tr_fecha_ref      DATETIME NOT NULL,
	tr_secuencial_ref INT NOT NULL,
	tr_estado         CHAR (10) NOT NULL,
	tr_observacion    VARCHAR (255),
	tr_gerente        SMALLINT NOT NULL,
	tr_producto       TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_transaccion_K1
	ON dbo.cr_transaccion (tr_secuencial)
GO

CREATE INDEX cr_transaccion_K2
	ON dbo.cr_transaccion (tr_banco)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_transaccion_K3
	ON dbo.cr_transaccion (tr_fecha_mov, tr_tran, tr_ofi_usu)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_tran_servicio') IS NOT NULL
	DROP TABLE dbo.cr_tran_servicio
GO

CREATE TABLE dbo.cr_tran_servicio
	(
	ts_secuencial       INT,
	ts_cod_alterno      INT,
	ts_tipo_transaccion SMALLINT NOT NULL,
	ts_clase            CHAR (1) NOT NULL,
	ts_fecha            DATETIME,
	ts_usuario          login,
	ts_moneda           TINYINT,
	ts_terminal         descripcion,
	ts_oficina          SMALLINT,
	ts_tabla            VARCHAR (30),
	ts_lsrv             VARCHAR (30),
	ts_srv              VARCHAR (30),
	ts_tinyint01        TINYINT,
	ts_tinyint02        TINYINT,
	ts_tinyint03        TINYINT,
	ts_tinyint04        TINYINT,
	ts_tinyint05        TINYINT,
	ts_tinyint06        TINYINT,
	ts_tinyint07        TINYINT,
	ts_tinyint08        TINYINT,
	ts_tinyint09        TINYINT,
	ts_tinyint10        TINYINT,
	ts_tinyint11        TINYINT,
	ts_tinyint12        TINYINT,
	ts_smallint01       SMALLINT,
	ts_smallint02       SMALLINT,
	ts_smallint03       SMALLINT,
	ts_smallint04       SMALLINT,
	ts_smallint05       SMALLINT,
	ts_smallint06       SMALLINT,
	ts_smallint07       SMALLINT,
	ts_smallint08       SMALLINT,
	ts_smallint09       SMALLINT,
	ts_smallint10       SMALLINT,
	ts_smallint11       SMALLINT,
	ts_smallint12       SMALLINT,
	ts_smallint13       SMALLINT,
	ts_smallint14       SMALLINT,
	ts_int01            INT,
	ts_int02            INT,
	ts_int03            INT,
	ts_int04            INT,
	ts_int05            INT,
	ts_int06            INT,
	ts_int07            INT,
	ts_int08            INT,
	ts_int09            INT,
	ts_int10            INT,
	ts_int11            INT,
	ts_int12            INT,
	ts_int13            INT,
	ts_int14            INT,
	ts_int15            INT,
	ts_int16            INT,
	ts_int17            INT,
	ts_int18            INT,
	ts_int19            INT,
	ts_int20            INT,
	ts_int21            INT,
	ts_int22            INT,
	ts_int23            INT,
	ts_money01          MONEY,
	ts_money02          MONEY,
	ts_money03          MONEY,
	ts_money04          MONEY,
	ts_money05          MONEY,
	ts_money06          MONEY,
	ts_money07          MONEY,
	ts_money08          MONEY,
	ts_money09          MONEY,
	ts_money10          MONEY,
	ts_money11          MONEY,
	ts_money12          MONEY,
	ts_money13          MONEY,
	ts_money14          MONEY,
	ts_money15          MONEY,
	ts_money16          MONEY,
	ts_money17          MONEY,
	ts_money18          MONEY,
	ts_money19          MONEY,
	ts_money20          MONEY,
	ts_money21          MONEY,
	ts_money22          MONEY,
	ts_money23          MONEY,
	ts_money24          MONEY,
	ts_money25          MONEY,
	ts_money26          MONEY,
	ts_money27          MONEY,
	ts_money28          MONEY,
	ts_money29          MONEY,
	ts_money30          MONEY,
	ts_money31          MONEY,
	ts_money32          MONEY,
	ts_money33          MONEY,
	ts_money34          MONEY,
	ts_money35          MONEY,
	ts_money36          MONEY,
	ts_money37          MONEY,
	ts_float01          FLOAT,
	ts_float02          FLOAT,
	ts_float03          FLOAT,
	ts_float04          FLOAT,
	ts_float05          FLOAT,
	ts_float06          FLOAT,
	ts_float07          FLOAT,
	ts_float08          FLOAT,
	ts_float09          FLOAT,
	ts_float10          FLOAT,
	ts_float11          FLOAT,
	ts_float12          FLOAT,
	ts_float13          FLOAT,
	ts_float14          FLOAT,
	ts_float15          FLOAT,
	ts_catalogo01       catalogo,
	ts_catalogo02       catalogo,
	ts_catalogo03       catalogo,
	ts_catalogo04       catalogo,
	ts_catalogo05       catalogo,
	ts_catalogo06       catalogo,
	ts_catalogo07       catalogo,
	ts_catalogo08       catalogo,
	ts_catalogo09       catalogo,
	ts_catalogo10       catalogo,
	ts_catalogo11       catalogo,
	ts_catalogo12       catalogo,
	ts_catalogo13       catalogo,
	ts_catalogo14       catalogo,
	ts_catalogo15       catalogo,
	ts_catalogo16       catalogo,
	ts_catalogo17       catalogo,
	ts_catalogo18       catalogo,
	ts_catalogo19       catalogo,
	ts_catalogo20       catalogo,
	ts_catalogo21       catalogo,
	ts_catalogo22       catalogo,
	ts_catalogo23       catalogo,
	ts_catalogo24       catalogo,
	ts_catalogo25       catalogo,
	ts_catalogo26       catalogo,
	ts_catalogo27       catalogo,
	ts_catalogo28       catalogo,
	ts_catalogo29       catalogo,
	ts_catalogo30       catalogo,
	ts_catalogo31       catalogo,
	ts_catalogo32       catalogo,
	ts_catalogo33       catalogo,
	ts_catalogo34       catalogo,
	ts_catalogo35       catalogo,
	ts_catalogo36       catalogo,
	ts_catalogo37       catalogo,
	ts_catalogo38       catalogo,
	ts_catalogo39       catalogo,
	ts_catalogo40       catalogo,
	ts_descripcion01    descripcion,
	ts_descripcion02    descripcion,
	ts_descripcion03    descripcion,
	ts_descripcion04    descripcion,
	ts_descripcion05    descripcion,
	ts_char101          CHAR (1),
	ts_char102          CHAR (1),
	ts_char103          CHAR (1),
	ts_char104          CHAR (1),
	ts_char105          CHAR (1),
	ts_char106          CHAR (1),
	ts_char107          CHAR (1),
	ts_char108          CHAR (1),
	ts_char109          CHAR (1),
	ts_char110          CHAR (1),
	ts_char111          CHAR (1),
	ts_char113          CHAR (1),
	ts_char114          CHAR (1),
	ts_char115          CHAR (1),
	ts_char116          CHAR (1),
	ts_char117          CHAR (1),
	ts_char118          CHAR (1),
	ts_char119          CHAR (1),
	ts_char120          CHAR (1),
	ts_char121          CHAR (1),
	ts_char122          CHAR (1),
	ts_char123          CHAR (1),
	ts_char124          CHAR (1),
	ts_char125          CHAR (1),
	ts_char126          CHAR (1),
	ts_char127          CHAR (1),
	ts_char128          CHAR (1),
	ts_char129          CHAR (1),
	ts_char130          CHAR (1),
	ts_char131          CHAR (1),
	ts_char132          CHAR (1),
	ts_char133          CHAR (1),
	ts_char134          CHAR (1),
	ts_char135          CHAR (1),
	ts_char136          CHAR (1),
	ts_char137          CHAR (1),
	ts_char138          CHAR (1),
	ts_char139          CHAR (1),
	ts_char140          CHAR (1),
	ts_char141          CHAR (1),
	ts_char142          CHAR (1),
	ts_char143          CHAR (1),
	ts_char144          CHAR (1),
	ts_char201          CHAR (2),
	ts_char301          CHAR (12),
	ts_char302          CHAR (2),
	ts_char303          CHAR (10),
	ts_char304          CHAR (10),
	ts_char401          CHAR (30),
	ts_login01          login,
	ts_login02          login,
	ts_login03          login,
	ts_login04          login,
	ts_login05          login,
	ts_login06          login,
	ts_cuenta01         cuenta,
	ts_cuenta02         cuenta,
	ts_cuenta03         cuenta,
	ts_cuenta04         cuenta,
	ts_texto            VARCHAR (255),
	ts_texto2           VARCHAR (255),
	ts_texto3           VARCHAR (255),
	ts_texto4           VARCHAR (255),
	ts_vchar1001        VARCHAR (10),
	ts_vchar1002        VARCHAR (10),
	ts_vchar1003        VARCHAR (10),
	ts_vchar1004        VARCHAR (10),
	ts_vchar1005        VARCHAR (10),
	ts_vchar1301        VARCHAR (13),
	ts_vchar1401        VARCHAR (14),
	ts_vchar1402        VARCHAR (14),
	ts_vchar2401        VARCHAR (24),
	ts_vchar6401        CHAR (64),
	ts_vchar4001        VARCHAR (40),
	ts_vchar4002        VARCHAR (40),
	ts_fecha01          DATETIME,
	ts_fecha02          DATETIME,
	ts_fecha03          DATETIME,
	ts_fecha04          DATETIME,
	ts_fecha05          DATETIME,
	ts_fecha06          DATETIME,
	ts_fecha07          DATETIME,
	ts_fecha08          DATETIME,
	ts_fecha09          DATETIME,
	ts_fecha10          DATETIME,
	ts_fecha11          DATETIME,
	ts_fecha12          DATETIME,
	ts_fecha13          DATETIME,
	ts_fecha14          DATETIME,
	ts_fecha15          DATETIME,
	ts_fecha16          DATETIME,
	ts_fecha_real       DATETIME
	)
GO

CREATE INDEX cr_tran_servicio_aKey
	ON dbo.cr_tran_servicio (ts_fecha, ts_tabla)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cr_tran_servicio_idx1
	ON dbo.cr_tran_servicio (ts_int01, ts_tipo_transaccion, ts_secuencial)
	WITH (FILLFACTOR = 90)
GO

CREATE UNIQUE INDEX cr_tran_servicio_Key
	ON dbo.cr_tran_servicio (ts_tipo_transaccion, ts_secuencial, ts_cod_alterno, ts_clase)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_tramites_mir') IS NOT NULL
	DROP TABLE dbo.cr_tramites_mir
GO

CREATE TABLE dbo.cr_tramites_mir
	(
	tm_tramite INT
	)
GO

IF OBJECT_ID ('dbo.cr_tramites_gp') IS NOT NULL
	DROP TABLE dbo.cr_tramites_gp
GO

CREATE TABLE dbo.cr_tramites_gp
	(
	tramite         INT NOT NULL,
	operacion       cuenta,
	moneda          TINYINT,
	porcentaje_resp FLOAT,
	valor_resp      MONEY,
	sesion          INT NOT NULL
	)
GO

CREATE INDEX cr_tramites_gp_key
	ON dbo.cr_tramites_gp (sesion)
GO

IF OBJECT_ID ('dbo.cr_tramites_contingencias') IS NOT NULL
	DROP TABLE dbo.cr_tramites_contingencias
GO

CREATE TABLE dbo.cr_tramites_contingencias
	(
	tc_tramite   INT NOT NULL,
	tc_monto     MONEY,
	tc_fuente    VARCHAR (10),
	tc_estado    CHAR (1),
	tc_fecha_apr DATETIME,
	tc_oficina   SMALLINT NOT NULL,
	tc_estado_op TINYINT NOT NULL,
	tc_monto_op  MONEY NOT NULL
	)
GO

CREATE INDEX idx1
	ON dbo.cr_tramites_contingencias (tc_tramite)
GO

IF OBJECT_ID ('dbo.cr_tramite_cajas') IS NOT NULL
	DROP TABLE dbo.cr_tramite_cajas
GO

CREATE TABLE dbo.cr_tramite_cajas
	(
	tc_tramite    INT NOT NULL,
	tc_num_orden  INT NOT NULL,
	tc_valor      MONEY NOT NULL,
	tc_causa      VARCHAR (10) NOT NULL,
	tc_estado     CHAR (1) NOT NULL,
	tc_pago_cobro CHAR (1)
	)
GO

CREATE INDEX cr_tramite_cajas_Key1
	ON dbo.cr_tramite_cajas (tc_tramite, tc_num_orden)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_cajas_Key2
	ON dbo.cr_tramite_cajas (tc_tramite, tc_estado, tc_pago_cobro)
GO

IF OBJECT_ID ('dbo.cr_tramite') IS NOT NULL
	DROP TABLE dbo.cr_tramite
GO

CREATE TABLE dbo.cr_tramite
	(
	tr_tramite            INT NOT NULL,
	tr_tipo               CHAR (1) NOT NULL,
	tr_oficina            SMALLINT NOT NULL,
	tr_usuario            login NOT NULL,
	tr_fecha_crea         DATETIME NOT NULL,
	tr_oficial            SMALLINT NOT NULL,
	tr_sector             catalogo NOT NULL,
	tr_ciudad             INT NOT NULL,
	tr_estado             CHAR (1),
	tr_nivel_ap           TINYINT,
	tr_fecha_apr          DATETIME,
	tr_usuario_apr        login,
	tr_truta              TINYINT NOT NULL,
	tr_secuencia          SMALLINT NOT NULL,
	tr_numero_op          INT,
	tr_numero_op_banco    cuenta,
	tr_riesgo             MONEY,
	tr_aprob_por          login,
	tr_nivel_por          TINYINT,
	tr_comite             catalogo,
	tr_acta               cuenta,
	tr_proposito          catalogo,
	tr_razon              catalogo,
	tr_txt_razon          VARCHAR (255),
	tr_efecto             catalogo,
	tr_cliente            INT,
	tr_nombre             descripcion,
	tr_grupo              INT,
	tr_fecha_inicio       DATETIME,
	tr_num_dias           SMALLINT,
	tr_per_revision       catalogo,
	tr_condicion_especial VARCHAR (255),
	tr_linea_credito      INT,
	tr_toperacion         catalogo,
	tr_producto           catalogo,
	tr_monto              MONEY,
	tr_moneda             TINYINT,
	tr_periodo            catalogo,
	tr_num_periodos       SMALLINT,
	tr_destino            catalogo,
	tr_ciudad_destino     INT,
	tr_cuenta_corriente   cuenta,
	tr_renovacion         SMALLINT,
	tr_fecha_concesion    DATETIME,
	tr_rent_actual        FLOAT,
	tr_rent_solicitud     FLOAT,
	tr_rent_recomend      FLOAT,
	tr_prod_actual        MONEY,
	tr_prod_solicitud     MONEY,
	tr_prod_recomend      MONEY,
	tr_clase              catalogo,
	tr_admisible          MONEY,
	tr_noadmis            MONEY,
	tr_relacionado        INT,
	tr_pondera            FLOAT,
	tr_contabilizado      CHAR (1),
	tr_subtipo            CHAR (1),
	tr_tipo_producto      catalogo,
	tr_origen_bienes      catalogo,
	tr_localizacion       catalogo,
	tr_plan_inversion     catalogo,
	tr_naturaleza         catalogo,
	tr_tipo_financia      catalogo,
	tr_sobrepasa          CHAR (1) NOT NULL,
	tr_elegible           CHAR (1),
	tr_forward            CHAR (1),
	tr_emp_emisora        INT,
	tr_num_acciones       SMALLINT,
	tr_responsable        INT,
	tr_negocio            cuenta,
	tr_reestructuracion   CHAR (1),
	tr_concepto_credito   catalogo,
	tr_aprob_gar          catalogo,
	tr_cont_admisible     CHAR (1),
	tr_mercado_objetivo   catalogo,
	tr_tipo_productor     VARCHAR (24),
	tr_valor_proyecto     MONEY,
	tr_sindicado          CHAR (1),
	tr_asociativo         CHAR (1),
	tr_margen_redescuento FLOAT,
	tr_fecha_ap_ant       DATETIME,
	tr_llave_redes        cuenta,
	tr_incentivo          CHAR (1),
	tr_fecha_eleg         DATETIME,
	tr_op_redescuento     INT,
	tr_fecha_redes        DATETIME,
	tr_solicitud          INT,
	tr_montop             MONEY,
	tr_monto_desembolsop  MONEY,
	tr_mercado            catalogo,
	tr_dias_vig           INT,
	tr_cod_actividad      catalogo,
	tr_num_desemb         INT,
	tr_carta_apr          VARCHAR (64),
	tr_fecha_aprov        DATETIME,
	tr_fmax_redes         DATETIME,
	tr_f_prorroga         DATETIME,
	tr_nlegal_fi          catalogo,
	tr_fechlimcum         DATETIME,
	tr_validado           CHAR (1),
	tr_sujcred            catalogo,
	tr_fabrica            catalogo,
	tr_callcenter         catalogo,
	tr_apr_fabrica        catalogo,
	tr_monto_solicitado   MONEY,
	tr_tipo_plazo         catalogo,
	tr_tipo_cuota         catalogo,
	tr_plazo              SMALLINT,
	tr_cuota_aproximada   MONEY,
	tr_fuente_recurso     VARCHAR (10),
	tr_tipo_credito       CHAR (1),
	tr_migrado            VARCHAR (16),
	tr_estado_cont        CHAR (1),
	tr_fecha_fija         CHAR (1),
	tr_dia_pago           TINYINT,
	tr_tasa_reest         FLOAT,
	tr_motivo             catalogo,
	tr_central            VARCHAR (2),
	tr_devuelto_mir       CHAR (1),
	tr_campana            INT,
	tr_alianza            INT,
	tr_autoriza_central   CHAR (1),
	tr_act_financiar      catalogo,
	tr_negado_mir         CHAR (1),
	tr_num_devri          INT,
    tr_promocion          char(1),    --LPO Santander
    tr_acepta_ren         char(1),    --LPO Santander
    tr_no_acepta          char(1000), --LPO Santander
    tr_emprendimiento     char(1),    --LPO Santander
    tr_porc_garantia      float,       --LPO Santander
    tr_grupal             char (1),     --SMO Santander
	tr_experiencia        char(1),
	tr_monto_max          MONEY,
	tr_monto_min          MONEY,
	tr_periodicidad_lcr   catalogo,
    tr_folio_buro         VARCHAR(64) null,
	tr_cat_caratula		  float null
	)
GO

CREATE CLUSTERED INDEX cr_tramite_AKey2
	ON dbo.cr_tramite (tr_oficina)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey
	ON dbo.cr_tramite (tr_tipo, tr_estado)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey4
	ON dbo.cr_tramite (tr_numero_op_banco)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey5
	ON dbo.cr_tramite (tr_cliente)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey6
	ON dbo.cr_tramite (tr_fecha_crea)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey7
	ON dbo.cr_tramite (tr_migrado)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_AKey8
	ON dbo.cr_tramite (tr_linea_credito)
	WITH (FILLFACTOR = 80)
GO

CREATE UNIQUE INDEX cr_tramite_Key
	ON dbo.cr_tramite (tr_tramite)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_tramite_tr_op_redescuento
	ON dbo.cr_tramite (tr_op_redescuento, tr_tramite)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX cr_tramite_idx10
	ON dbo.cr_tramite (tr_tipo, tr_numero_op, tr_estado)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cr_tramite_idx11
	ON dbo.cr_tramite (tr_tipo, tr_tramite, tr_oficina, tr_usuario, tr_estado)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_toperacion') IS NOT NULL
	DROP TABLE dbo.cr_toperacion
GO

CREATE TABLE dbo.cr_toperacion
	(
	to_toperacion  catalogo NOT NULL,
	to_producto    catalogo NOT NULL,
	to_descripcion descripcion NOT NULL,
	to_estado      catalogo NOT NULL,
	to_riesgo      catalogo,
	to_codigo_sib  catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_toperacion_Key
	ON dbo.cr_toperacion (to_toperacion, to_producto)
GO

IF OBJECT_ID ('dbo.cr_tmp_garfag') IS NOT NULL
	DROP TABLE dbo.cr_tmp_garfag
GO

CREATE TABLE dbo.cr_tmp_garfag
	(
	tg_tipo   VARCHAR (64) NOT NULL,
	tg_sesion INT NOT NULL
	)
GO

CREATE INDEX cr_tmp_garfag_Key
	ON dbo.cr_tmp_garfag (tg_sesion)
GO

IF OBJECT_ID ('dbo.cr_tmp_datooper') IS NOT NULL
	DROP TABLE dbo.cr_tmp_datooper
GO

CREATE TABLE dbo.cr_tmp_datooper
	(
	dot_numero_operacion       INT NOT NULL,
	dot_numero_operacion_banco VARCHAR (24) NOT NULL,
	dot_tipo_operacion         VARCHAR (10) NOT NULL,
	dot_codigo_producto        TINYINT NOT NULL,
	dot_codigo_cliente         INT NOT NULL,
	dot_oficina                SMALLINT NOT NULL,
	dot_sucursal               SMALLINT NOT NULL,
	dot_regional               VARCHAR (10) NOT NULL,
	dot_moneda                 TINYINT NOT NULL,
	dot_monto                  MONEY NOT NULL,
	dot_tasa                   FLOAT,
	dot_periodicidad           SMALLINT,
	dot_modalidad              CHAR (1),
	dot_fecha_concesion        DATETIME NOT NULL,
	dot_fecha_vencimiento      DATETIME NOT NULL,
	dot_dias_vto_div           INT,
	dot_fecha_vto_div          DATETIME,
	dot_reestructuracion       CHAR (1),
	dot_fecha_reest            DATETIME,
	dot_num_cuota_reest        SMALLINT,
	dot_no_renovacion          INT NOT NULL,
	dot_codigo_destino         VARCHAR (10),
	dot_clase_cartera          VARCHAR (10),
	dot_codigo_geografico      INT,
	dot_departamento           SMALLINT NOT NULL,
	dot_tipo_garantias         VARCHAR (10),
	dot_valor_garantias        MONEY,
	dot_fecha_prox_vto         DATETIME,
	dot_saldo_prox_vto         MONEY,
	dot_saldo_cap              MONEY NOT NULL,
	dot_saldo_int              MONEY NOT NULL,
	dot_saldo_otros            MONEY NOT NULL,
	dot_saldo_int_contingente  MONEY NOT NULL,
	dot_saldo                  MONEY NOT NULL,
	dot_estado_contable        TINYINT NOT NULL,
	dot_estado_desembolso      CHAR (1),
	dot_estado_terminos        CHAR (1),
	dot_calificacion           VARCHAR (10),
	dot_linea_credito          VARCHAR (24),
	dot_periodicidad_cuota     SMALLINT,
	dot_edad_mora              INT,
	dot_valor_mora             MONEY,
	dot_fecha_pago             DATETIME,
	dot_valor_cuota            MONEY,
	dot_cuotas_pag             SMALLINT,
	dot_estado_cartera         TINYINT,
	dot_plazo_dias             INT,
	dot_gerente                SMALLINT NOT NULL,
	dot_num_cuotaven           SMALLINT,
	dot_saldo_cuotaven         MONEY,
	dot_admisible              CHAR (1),
	dot_num_cuotas             SMALLINT,
	dot_tipo_tarjeta           CHAR (1),
	dot_clase_tarjeta          VARCHAR (6),
	dot_tipo_bloqueo           CHAR (1),
	dot_fecha_bloqueo          DATETIME,
	dot_fecha_cambio           DATETIME,
	dot_ciclo_fact             DATETIME,
	dot_valor_ult_pago         MONEY,
	dot_fecha_castigo          DATETIME,
	dot_num_acta               VARCHAR (24),
	dot_gracia_cap             SMALLINT,
	dot_gracia_int             SMALLINT,
	dot_probabilidad_default   FLOAT,
	dot_nat_reest              catalogo,
	dot_num_reest              TINYINT,
	dot_acta_cas               catalogo,
	dot_capsusxcor             MONEY,
	dot_intsusxcor             MONEY,
	dot_clausula               CHAR (1),
	dot_moneda_op              TINYINT
	)
GO

CREATE INDEX cr_tmp_datooper_AKey1
	ON dbo.cr_tmp_datooper (dot_codigo_cliente)
GO

CREATE UNIQUE INDEX cr_tmp_datooper_AKey2
	ON dbo.cr_tmp_datooper (dot_numero_operacion, dot_codigo_producto)
GO

CREATE UNIQUE INDEX cr_tmp_datooper_Key
	ON dbo.cr_tmp_datooper (dot_codigo_producto, dot_numero_operacion_banco)
GO

IF OBJECT_ID ('dbo.cr_tmp_concepto') IS NOT NULL
	DROP TABLE dbo.cr_tmp_concepto
GO

CREATE TABLE dbo.cr_tmp_concepto
	(
	cpt_fecha        DATETIME NOT NULL,
	cpt_producto     TINYINT NOT NULL,
	cpt_operacion    INT NOT NULL,
	cpt_num_op_banco VARCHAR (24) NOT NULL,
	cpt_concepto     catalogo NOT NULL,
	cpt_saldo        MONEY NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_tmp_concepto_Key
	ON dbo.cr_tmp_concepto (cpt_producto, cpt_num_op_banco, cpt_concepto)
GO

IF OBJECT_ID ('dbo.cr_tipos_fng_temp') IS NOT NULL
	DROP TABLE dbo.cr_tipos_fng_temp
GO

CREATE TABLE dbo.cr_tipos_fng_temp
	(
	sesion INT NOT NULL,
	tipo   VARCHAR (64) NOT NULL
	)
GO

CREATE INDEX cr_tipos_fng_temp_key
	ON dbo.cr_tipos_fng_temp (sesion)
GO

IF OBJECT_ID ('dbo.cr_tipos_fag_ftemp') IS NOT NULL
	DROP TABLE dbo.cr_tipos_fag_ftemp
GO

CREATE TABLE dbo.cr_tipos_fag_ftemp
	(
	sesion INT,
	tipo   VARCHAR (64)
	)
GO

CREATE INDEX cr_tipos_fag_ftemp_k1
	ON dbo.cr_tipos_fag_ftemp (sesion)
GO

IF OBJECT_ID ('dbo.cr_tipo_tramite') IS NOT NULL
	DROP TABLE dbo.cr_tipo_tramite
GO

CREATE TABLE dbo.cr_tipo_tramite
	(
	tt_tipo        CHAR (1) NOT NULL,
	tt_descripcion descripcion NOT NULL,
	tt_prioridad   TINYINT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_tipo_tramite_Key
	ON dbo.cr_tipo_tramite (tt_tipo)
GO

IF OBJECT_ID ('dbo.cr_tipo_seguro') IS NOT NULL
	DROP TABLE dbo.cr_tipo_seguro
GO

CREATE TABLE dbo.cr_tipo_seguro
	(
	se_tipo_seguro    INT,
	se_descripcion    VARCHAR (255),
	se_estado         catalogo,
	se_fecha_modif    DATETIME,
	se_usuario_modif  login,
	se_terminal_modif VARCHAR (30),
	se_fecha_crea     DATETIME,
	se_usuario_crea   login,
	se_terminal_crea  VARCHAR (30),
	se_tipo_historia  INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_tipo_seguro (se_tipo_historia)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_tipo_seguro (se_tipo_seguro)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_tipo_oficina') IS NOT NULL
	DROP TABLE dbo.cr_tipo_oficina
GO

CREATE TABLE dbo.cr_tipo_oficina
	(
	to_oficina SMALLINT NOT NULL,
	to_nombre  descripcion,
	to_opi     CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_tipo_empresa') IS NOT NULL
	DROP TABLE dbo.cr_tipo_empresa
GO

CREATE TABLE dbo.cr_tipo_empresa
	(
	te_tipo_empresa CHAR (2) NOT NULL,
	te_subtipo      CHAR (1),
	te_valor_ini    INT,
	te_valor_fin    INT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_tipo_empresa_Key
	ON dbo.cr_tipo_empresa (te_tipo_empresa)
GO

IF OBJECT_ID ('dbo.cr_tipo_actual_gp') IS NOT NULL
	DROP TABLE dbo.cr_tipo_actual_gp
GO

CREATE TABLE dbo.cr_tipo_actual_gp
	(
	tipoa  VARCHAR (64) NOT NULL,
	sesion INT NOT NULL
	)
GO

CREATE INDEX cr_tipo_actual_gp_key
	ON dbo.cr_tipo_actual_gp (sesion)
GO

IF OBJECT_ID ('dbo.cr_tinstruccion') IS NOT NULL
	DROP TABLE dbo.cr_tinstruccion
GO

CREATE TABLE dbo.cr_tinstruccion
	(
	ti_codigo      catalogo NOT NULL,
	ti_descripcion descripcion,
	ti_aprobacion  CHAR (1) NOT NULL,
	ti_nivel_ap    catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_tinstruccion_Key
	ON dbo.cr_tinstruccion (ti_codigo)
GO


IF OBJECT_ID ('dbo.cr_temp4_tmp') IS NOT NULL
	DROP TABLE dbo.cr_temp4_tmp
GO

CREATE TABLE dbo.cr_temp4_tmp
	(
	usuario     login,
	sesion      INT,
	por_vencer  MONEY,
	vencido     MONEY,
	tipo_riesgo VARCHAR (12),
	toperacion  VARCHAR (10),
	tramite     INT,
	en_tramite  CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_tarifa_honorarios_FAG') IS NOT NULL
	DROP TABLE dbo.cr_tarifa_honorarios_FAG
GO

CREATE TABLE dbo.cr_tarifa_honorarios_FAG
	(
	thf_monto_desde MONEY NOT NULL,
	thf_monto_hasta MONEY NOT NULL,
	thf_maximo      FLOAT NOT NULL
	)
GO

CREATE INDEX cr_tarifa_honorarios_FAG_Key
	ON dbo.cr_tarifa_honorarios_FAG (thf_monto_desde, thf_monto_hasta)
GO

IF OBJECT_ID ('dbo.cr_tarifa_honorarios') IS NOT NULL
	DROP TABLE dbo.cr_tarifa_honorarios
GO

CREATE TABLE dbo.cr_tarifa_honorarios
	(
	th_monto_desde MONEY NOT NULL,
	th_monto_hasta MONEY NOT NULL,
	th_tarifa      FLOAT NOT NULL,
	th_maximo      MONEY NOT NULL,
	th_etapa       CHAR (10) NOT NULL,
	th_subetapa    CHAR (10) NOT NULL
	)
GO

CREATE INDEX cr_tarifa_honorarios_Key
	ON dbo.cr_tarifa_honorarios (th_etapa, th_subetapa)
GO

IF OBJECT_ID ('dbo.cr_superior_gp_esp') IS NOT NULL
	DROP TABLE dbo.cr_superior_gp_esp
GO

CREATE TABLE dbo.cr_superior_gp_esp
	(
	tipo   VARCHAR (64) NOT NULL,
	sesion INT NOT NULL
	)
GO

CREATE INDEX cr_superior_gp_esp_key
	ON dbo.cr_superior_gp_esp (sesion)
GO

IF OBJECT_ID ('dbo.cr_superior_gp') IS NOT NULL
	DROP TABLE dbo.cr_superior_gp
GO

CREATE TABLE dbo.cr_superior_gp
	(
	tipo   VARCHAR (64) NOT NULL,
	sesion INT NOT NULL
	)
GO

CREATE INDEX cr_superior_gp_k1
	ON dbo.cr_superior_gp (sesion)
GO

IF OBJECT_ID ('dbo.cr_semaforo') IS NOT NULL
	DROP TABLE dbo.cr_semaforo
GO

CREATE TABLE dbo.cr_semaforo
	(
	se_proceso INT,
	se_luz     catalogo
	)
GO

IF OBJECT_ID ('dbo.cr_seguros_tramite') IS NOT NULL
	DROP TABLE dbo.cr_seguros_tramite
GO

CREATE TABLE dbo.cr_seguros_tramite
	(
	st_secuencial_seguro INT,
	st_tipo_seguro       INT,
	st_tramite           INT,
	st_vendedor          INT,
	st_cupo              CHAR (1),
	st_origen            VARCHAR (20)
	)
GO

CREATE INDEX idx1
	ON dbo.cr_seguros_tramite (st_secuencial_seguro, st_tipo_seguro, st_tramite)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2_cr_seguros_tramite
	ON dbo.cr_seguros_tramite (st_tramite)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_seguros_estadistica') IS NOT NULL
	DROP TABLE dbo.cr_seguros_estadistica
GO

CREATE TABLE dbo.cr_seguros_estadistica
	(
	se_fecha         DATETIME,
	se_tipo_seguro   INT,
	se_tipo_seg_desc VARCHAR (100),
	se_codigo_plan   INT,
	se_cod_plan_desc VARCHAR (100),
	se_certificado   VARCHAR (20),
	se_antiguedad    SMALLINT,
	se_oficina       SMALLINT,
	se_zona          SMALLINT,
	se_of_nombre     VARCHAR (64),
	se_banco         VARCHAR (20),
	se_identif_vend  VARCHAR (30),
	se_codigo_vend   SMALLINT,
	se_nombre_vend   VARCHAR (200),
	se_fecha_venta   DATETIME,
	se_fecha_desde   DATETIME,
	se_fecha_hasta   DATETIME,
	se_identif_cli   VARCHAR (30),
	se_tipo_doc_cli  VARCHAR (10),
	se_nombre_cli    VARCHAR (200),
	se_monto_aseg    MONEY,
	se_prima_total   MONEY,
	se_prima_mensual MONEY
	)
GO

CREATE INDEX idx1
	ON dbo.cr_seguros_estadistica (se_fecha, se_banco)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_seguro_plan') IS NOT NULL
	DROP TABLE dbo.cr_seguro_plan
GO

CREATE TABLE dbo.cr_seguro_plan
	(
	sp_codigo INT NOT NULL,
	sp_plan   VARCHAR (24) NOT NULL,
	sp_valor  MONEY NOT NULL,
	sp_estado VARCHAR (10) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_seguro_plan_key
	ON dbo.cr_seguro_plan (sp_plan, sp_estado)
GO

IF OBJECT_ID ('dbo.cr_seguro_parentesco') IS NOT NULL
	DROP TABLE dbo.cr_seguro_parentesco
GO

CREATE TABLE dbo.cr_seguro_parentesco
	(
	sp_codigo       INT NOT NULL,
	sp_parentesco   VARCHAR (10) NOT NULL,
	sp_equivalencia VARCHAR (10) NOT NULL,
	sp_estado       VARCHAR (10) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_seguro_parentesco_key
	ON dbo.cr_seguro_parentesco (sp_parentesco, sp_equivalencia, sp_estado)
GO

IF OBJECT_ID ('dbo.cr_seguro_exequial') IS NOT NULL
	DROP TABLE dbo.cr_seguro_exequial
GO

CREATE TABLE dbo.cr_seguro_exequial
	(
	se_tramite   INT NOT NULL,
	se_cliente   INT NOT NULL,
	se_oficina   INT,
	se_fecha_nac DATETIME,
	se_tel_res   numero,
	se_tel_cel   numero,
	se_pais      SMALLINT,
	se_depto     SMALLINT,
	se_ciudad    INT,
	se_barrio    SMALLINT,
	se_direccion descripcion,
	se_val_mes   MONEY,
	se_val_total MONEY,
	se_fecha_ini DATETIME,
	se_fecha_fin DATETIME,
	se_estado    CHAR (1)
	)
GO

CREATE INDEX cr_seguro_exequial_key
	ON dbo.cr_seguro_exequial (se_tramite, se_cliente)
GO

IF OBJECT_ID ('dbo.cr_secuencia') IS NOT NULL
	DROP TABLE dbo.cr_secuencia
GO

CREATE TABLE dbo.cr_secuencia
	(
	se_tramite   INT NOT NULL,
	se_etapa     TINYINT NOT NULL,
	se_estacion  SMALLINT NOT NULL,
	se_estado    CHAR (1),
	se_secuencia TINYINT,
	se_tipo      CHAR (1),
	se_superior  SMALLINT,
	se_miembro   catalogo,
	se_fecha     DATETIME
	)
GO

CREATE UNIQUE INDEX cr_secuencia_Key
	ON dbo.cr_secuencia (se_tramite, se_etapa, se_estacion)
GO

IF OBJECT_ID ('dbo.cr_ruta_tramite') IS NOT NULL
	DROP TABLE dbo.cr_ruta_tramite
GO

CREATE TABLE dbo.cr_ruta_tramite
	(
	rt_tramite      INT NOT NULL,
	rt_secuencia    SMALLINT NOT NULL,
	rt_truta        TINYINT NOT NULL,
	rt_paso         TINYINT NOT NULL,
	rt_etapa        TINYINT NOT NULL,
	rt_estacion     SMALLINT NOT NULL,
	rt_llegada      DATETIME NOT NULL,
	rt_salida       DATETIME,
	rt_estado       INT,
	rt_paralelo     SMALLINT,
	rt_prioridad    TINYINT NOT NULL,
	rt_abierto      CHAR (1) NOT NULL,
	rt_asociado     SMALLINT,
	rt_etapa_sus    TINYINT,
	rt_estacion_sus SMALLINT,
	rt_comite       CHAR (1)
	)
GO

CREATE CLUSTERED INDEX cr_ruta_tram_AKey4
	ON dbo.cr_ruta_tramite (rt_estacion, rt_salida, rt_comite)
GO

CREATE INDEX cr_ruta_tram_AKey3
	ON dbo.cr_ruta_tramite (rt_etapa, rt_estacion, rt_tramite, rt_salida, rt_paso)
GO

CREATE UNIQUE INDEX cr_ruta_tramite_Key
	ON dbo.cr_ruta_tramite (rt_tramite, rt_secuencia)
GO

CREATE INDEX cr_ruta_tramite_Key2
	ON dbo.cr_ruta_tramite (rt_estacion_sus, rt_salida)
GO

CREATE INDEX cr_ruta_tramite_idx5
	ON dbo.cr_ruta_tramite (rt_salida, rt_estacion_sus, rt_comite, rt_tramite)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_ruta_filtros') IS NOT NULL
	DROP TABLE dbo.cr_ruta_filtros
GO

CREATE TABLE dbo.cr_ruta_filtros
	(
	rf_ruta        INT,
	rf_descripcion VARCHAR (64),
	rf_estado      catalogo
	)
GO

IF OBJECT_ID ('dbo.cr_rub_renovar') IS NOT NULL
	DROP TABLE dbo.cr_rub_renovar
GO

CREATE TABLE dbo.cr_rub_renovar
	(
	rr_tramite      INT NOT NULL,
	rr_concepto     catalogo NOT NULL,
	rr_renovar      CHAR (1) NOT NULL,
	rr_tramite_re   INT,
	rr_estado       TINYINT,
	rr_estado_cuota TINYINT
	)
GO

CREATE UNIQUE INDEX cr_rub_renovar_Key
	ON dbo.cr_rub_renovar (rr_tramite, rr_tramite_re, rr_concepto, rr_estado, rr_estado_cuota)
GO

CREATE INDEX cr_rub_renovar_Key1
	ON dbo.cr_rub_renovar (rr_tramite_re)
GO

IF OBJECT_ID ('dbo.cr_rub_pag_reest') IS NOT NULL
	DROP TABLE dbo.cr_rub_pag_reest
GO

CREATE TABLE dbo.cr_rub_pag_reest
	(
	rp_tramite       INT NOT NULL,
	rp_rubro         catalogo,
	rp_porcent_cobro FLOAT NOT NULL,
	rp_valor_cobro   MONEY NOT NULL,
	rp_valor_pend    MONEY NOT NULL
	)
GO

CREATE CLUSTERED INDEX cr_rub_pag_reest_key
	ON dbo.cr_rub_pag_reest (rp_tramite, rp_rubro)
GO

IF OBJECT_ID ('dbo.cr_resumen_rango_mora') IS NOT NULL
	DROP TABLE dbo.cr_resumen_rango_mora
GO

CREATE TABLE dbo.cr_resumen_rango_mora
	(
	rr_reporte catalogo NOT NULL,
	rr_rango   INT NOT NULL,
	rr_desde   INT NOT NULL,
	rr_hasta   INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_resultado1_temporal') IS NOT NULL
	DROP TABLE dbo.cr_resultado1_temporal
GO

CREATE TABLE dbo.cr_resultado1_temporal
	(
	idconn      INT NOT NULL,
	tipo_riesgo VARCHAR (64),
	por_vencer  MONEY,
	vencido     MONEY,
	disponible  MONEY,
	total       MONEY
	)
GO

CREATE INDEX cr_resultado1_temporal_Key
	ON dbo.cr_resultado1_temporal (tipo_riesgo, por_vencer, vencido, disponible, total, idconn)
GO

IF OBJECT_ID ('dbo.cr_respuestas_det') IS NOT NULL
	DROP TABLE dbo.cr_respuestas_det
GO

CREATE TABLE dbo.cr_respuestas_det
	(
	rd_secuencial INT NOT NULL,
	rd_pregunta   INT NOT NULL,
	rd_respuesta  VARCHAR (30)
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_respuestas_det (rd_secuencial, rd_pregunta)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_respuestas') IS NOT NULL
	DROP TABLE dbo.cr_respuestas
GO

CREATE TABLE dbo.cr_respuestas
	(
	re_formulario INT NOT NULL,
	re_version    INT NOT NULL,
	re_secuencial INT NOT NULL,
	re_cliente    INT NOT NULL,
	re_fecha      DATETIME NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_respuestas (re_secuencial)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_respuestas (re_formulario, re_version)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_respuesta_mir_ws') IS NOT NULL
	DROP TABLE dbo.cr_respuesta_mir_ws
GO

CREATE TABLE dbo.cr_respuesta_mir_ws
	(
	rm_tramite    INT NOT NULL,
	rm_variable   VARCHAR (255),
	rm_valor      VARCHAR (8000),
	rm_fecha_resp DATETIME,
	rm_orden      INT
	)
GO

CREATE INDEX idx1
	ON dbo.cr_respuesta_mir_ws (rm_tramite)
GO

IF OBJECT_ID ('dbo.cr_respuesta_mir') IS NOT NULL
	DROP TABLE dbo.cr_respuesta_mir
GO

CREATE TABLE dbo.cr_respuesta_mir
	(
	re_tramite   INT NOT NULL,
	re_pregunta  INT NOT NULL,
	re_respuesta VARCHAR (255)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_respuesta_mir_ind
	ON dbo.cr_respuesta_mir (re_tramite, re_pregunta)
GO

IF OBJECT_ID ('dbo.cr_res_tplan_tmp') IS NOT NULL
	DROP TABLE dbo.cr_res_tplan_tmp
GO

CREATE TABLE dbo.cr_res_tplan_tmp
	(
	conexion  INT NOT NULL,
	fecha_ini DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	dividendo INT NOT NULL,
	dias      INT NOT NULL
	)
GO

CREATE INDEX cr_res_tplan_tmp_k1
	ON dbo.cr_res_tplan_tmp (conexion)
GO

IF OBJECT_ID ('dbo.cr_req_tramite') IS NOT NULL
	DROP TABLE dbo.cr_req_tramite
GO

CREATE TABLE dbo.cr_req_tramite
	(
	rr_tramite      INT NOT NULL,
	rr_tipo         CHAR (1) NOT NULL,
	rr_etapa        TINYINT NOT NULL,
	rr_requisito    catalogo NOT NULL,
	rr_observacion  descripcion,
	rr_fecha_modif  DATETIME,
	rr_tipo_cliente CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_req_tramite_Key
	ON dbo.cr_req_tramite (rr_tramite, rr_tipo, rr_etapa, rr_requisito, rr_tipo_cliente)
GO

IF OBJECT_ID ('dbo.cr_repuntuacion') IS NOT NULL
	DROP TABLE dbo.cr_repuntuacion
GO

CREATE TABLE dbo.cr_repuntuacion
	(
	re_tramite            INT,
	re_fecha_repuntuacion DATETIME,
	re_tipo_proceso       INT
	)
GO

IF OBJECT_ID ('dbo.cr_reporte064') IS NOT NULL
	DROP TABLE dbo.cr_reporte064
GO

CREATE TABLE dbo.cr_reporte064
	(
	re_cliente         INT,
	re_oficina         INT,
	re_oficial         INT,
	re_monto_credito   FLOAT,
	re_tipo_cliente    VARCHAR (1),
	re_monto_aprobado  FLOAT,
	re_monto_utilizado FLOAT,
	re_plazo           SMALLINT,
	re_cred_canc       SMALLINT,
	re_desc_oficial    descripcion,
	re_desc_oficina    descripcion,
	re_cedula          numero,
	re_nombre_clien    VARCHAR (255),
	re_des_actividad   descripcion,
	re_dir_nego        VARCHAR (255),
	re_tel_nego        VARCHAR (20),
	re_tel_domc        VARCHAR (20),
	re_tiene_micro     CHAR (1),
	re_saldo_vig       MONEY,
	re_dir_casa        VARCHAR (255),
	re_nota_ult_obl    VARCHAR (255),
	re_segmento        catalogo,
	re_desc_segmento   descripcion,
	re_celular         VARCHAR (20),
	re_fecha_pro       DATETIME
	)
GO

CREATE INDEX cr_reporte064_1
	ON dbo.cr_reporte064 (re_oficina, re_oficial)
GO

IF OBJECT_ID ('dbo.cr_rep_archger') IS NOT NULL
	DROP TABLE dbo.cr_rep_archger
GO

CREATE TABLE dbo.cr_rep_archger
	(
	cta_tipo            CHAR (1) NOT NULL,
	cta_oficina         SMALLINT NOT NULL,
	cta_usuario         login NOT NULL,
	cta_fch_crea        VARCHAR (10),
	cta_oficial         SMALLINT NOT NULL,
	cta_sector          catalogo NOT NULL,
	cta_ciudad          INT NOT NULL,
	cta_estado          CHAR (1),
	cta_fch_apr         VARCHAR (10),
	cta_usuario_apr     login,
	cta_truta           INT,
	cta_secuencia       SMALLINT NOT NULL,
	cta_numero_op       INT,
	cta_numero_op_banco cuenta,
	cta_comite          catalogo,
	cta_acta            cuenta,
	cta_proposito       catalogo,
	cta_razon           catalogo,
	cta_txt_razon       VARCHAR (255),
	cta_efecto          catalogo,
	cta_cliente         INT,
	cta_nombre          VARCHAR (64),
	cta_grupo           INT,
	cta_fch_inicio      VARCHAR (10),
	cta_num_dias        SMALLINT,
	cta_per_revision    catalogo,
	cta_lin_cred        INT,
	cta_toperacion      catalogo,
	cta_producto        catalogo,
	cta_monto           VARCHAR (24),
	cta_moneda          INT,
	cta_periodo         catalogo,
	cta_num_period      INT,
	cta_destino         catalogo,
	cta_ciudad_dest     INT,
	cta_renovacion      SMALLINT,
	cta_fch_concesion   VARCHAR (10),
	cta_clase           catalogo,
	cta_contabilizado   CHAR (1),
	cta_subtipo         CHAR (1),
	cta_sobrepasa       CHAR (1),
	cta_reestruct       CHAR (1),
	cta_concepto_cred   catalogo,
	cta_aprob_gar       catalogo,
	cta_asociativo      CHAR (1),
	cta_merc_obj        catalogo,
	cta_tramite         INT,
	cta_cont_admisible  CHAR (1),
	cta_cobranza        catalogo,
	cta_proceso         catalogo NOT NULL,
	cta_etapa           catalogo NOT NULL,
	cta_estado1         catalogo NOT NULL,
	cta_fch_ingr        VARCHAR (10) NOT NULL,
	cta_usuario_ingr    login NOT NULL,
	cta_fch_mod         VARCHAR (10),
	cta_usuario_mod     login,
	cta_situacion       catalogo NOT NULL,
	cta_estado2         catalogo NOT NULL,
	cta_fecha           VARCHAR (10) NOT NULL,
	cta_fecha_fin       VARCHAR (10) NOT NULL,
	cta_cumplimiento    CHAR (1) NOT NULL,
	cta_situacion_ant   catalogo,
	cta_fecha_modif     VARCHAR (10) NOT NULL,
	cta_cod_cobrador    login NOT NULL,
	cta_tipo_cobrador   catalogo NOT NULL,
	cta_cod_cobranza    catalogo NOT NULL,
	cta_cod_cliente     INT,
	cta_fecha_asig      VARCHAR (10),
	cta_id_cliente      VARCHAR (30),
	cta_mes_vto         FLOAT,
	cta_calif_sug       CHAR (1),
	cta_calif_final     CHAR (1),
	cta_saldo_cap       MONEY,
	cta_saldo_int       MONEY,
	cta_saldo_ctasxcob  MONEY,
	cta_xprov_cap       MONEY,
	cta_xprov_int       MONEY,
	cta_xprov_ctasxcob  MONEY,
	cta_prov_cap        MONEY,
	cta_prov_int        MONEY,
	cta_prov_ctasxcob   MONEY,
	cta_prova_cap       MONEY,
	cta_prova_int       MONEY,
	cta_prova_ctasxcob  MONEY,
	cta_fecha_asig1     VARCHAR (10),
	cta_monto_lg        MONEY,
	cta_utilizado_lg    MONEY,
	cta_moneda_lg       SMALLINT,
	cta_reservado_lg    MONEY,
	cta_rt_etapa        INT NOT NULL,
	cta_rt_llegada      INT,
	cta_rt_salida       INT,
	cta_en_subtipo      CHAR (1),
	cta_tipo_productor  catalogo,
	cta_mercado         catalogo
	)
GO

IF OBJECT_ID ('dbo.cr_reno_provi') IS NOT NULL
	DROP TABLE dbo.cr_reno_provi
GO

CREATE TABLE dbo.cr_reno_provi
	(
	rp_tramite       INT NOT NULL,
	rp_banco         cuenta NOT NULL,
	rp_saldo_cap     MONEY NOT NULL,
	rp_saldo_int     MONEY NOT NULL,
	rp_saldo_otros   MONEY NOT NULL,
	rp_xprov_cban    MONEY NOT NULL,
	rp_xprov_iban    MONEY NOT NULL,
	rp_xprov_oban    MONEY NOT NULL,
	rp_prov_cban     MONEY NOT NULL,
	rp_prov_iban     MONEY NOT NULL,
	rp_prov_oban     MONEY NOT NULL,
	rp_prov_cbaa     MONEY NOT NULL,
	rp_prov_ibaa     MONEY NOT NULL,
	rp_prov_obaa     MONEY NOT NULL,
	rp_prov_ccaj     MONEY NOT NULL,
	rp_prov_icaj     MONEY NOT NULL,
	rp_prov_ocaj     MONEY NOT NULL,
	rp_prov_cant     MONEY NOT NULL,
	rp_prov_iant     MONEY NOT NULL,
	rp_prov_oant     MONEY NOT NULL,
	rp_calificacion  CHAR (1),
	rp_saldo_cdr     MONEY NOT NULL,
	rp_saldo_idr     MONEY NOT NULL,
	rp_saldo_odr     MONEY NOT NULL,
	rp_xprovn_cban   MONEY NOT NULL,
	rp_xprovn_iban   MONEY NOT NULL,
	rp_xprovn_oban   MONEY NOT NULL,
	rp_provn_cban    MONEY NOT NULL,
	rp_provn_iban    MONEY NOT NULL,
	rp_provn_oban    MONEY NOT NULL,
	rp_provn_cbaa    MONEY NOT NULL,
	rp_provn_ibaa    MONEY NOT NULL,
	rp_provn_obaa    MONEY NOT NULL,
	rp_provn_ccaj    MONEY NOT NULL,
	rp_provn_icaj    MONEY NOT NULL,
	rp_provn_ocaj    MONEY NOT NULL,
	rp_provn_cant    MONEY NOT NULL,
	rp_provn_iant    MONEY NOT NULL,
	rp_provn_oant    MONEY NOT NULL,
	rp_ncalificacion CHAR (1),
	rp_fecha         DATETIME NOT NULL,
	rp_cancela       CHAR (1)
	)
GO

CREATE UNIQUE INDEX cr_reno_provi_k1
	ON dbo.cr_reno_provi (rp_tramite, rp_banco)
GO

IF OBJECT_ID ('dbo.cr_regla') IS NOT NULL
	DROP TABLE dbo.cr_regla
GO

CREATE TABLE dbo.cr_regla
	(
	re_truta           TINYINT,
	re_paso            TINYINT NOT NULL,
	re_etapa           TINYINT NOT NULL,
	re_regla           SMALLINT NOT NULL,
	re_prioridad       TINYINT NOT NULL,
	re_paso_siguiente  TINYINT NOT NULL,
	re_etapa_siguiente TINYINT NOT NULL,
	re_descripcion     VARCHAR (64),
	re_programa        VARCHAR (40) NOT NULL,
	re_banca           VARCHAR (10),
	re_tipo_regla      CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_regla_Key
	ON dbo.cr_regla (re_truta, re_paso, re_etapa, re_regla)
GO

IF OBJECT_ID ('dbo.cr_reest_gracia') IS NOT NULL
	DROP TABLE dbo.cr_reest_gracia
GO

CREATE TABLE dbo.cr_reest_gracia
	(
	rg_banco            cuenta,
	rg_per_pago_capital INT,
	rg_per_pago_int     INT,
	rg_gracia_capital   INT,
	rg_gracia_int       INT,
	rg_dist_gracia      CHAR (1)
	)
GO

CREATE INDEX ix_cr_reest_gracia_1
	ON dbo.cr_reest_gracia (rg_banco)
GO

IF OBJECT_ID ('dbo.cr_provision_periodo_anterior') IS NOT NULL
	DROP TABLE dbo.cr_provision_periodo_anterior
GO

CREATE TABLE dbo.cr_provision_periodo_anterior
	(
	ppa_anual    CHAR (1) NOT NULL,
	ppa_fecha    SMALLDATETIME NOT NULL,
	ppa_banco    cuenta NOT NULL,
	ppa_concepto VARCHAR (1) NOT NULL,
	ppa_prov     MONEY NOT NULL,
	ppa_provcc   MONEY NOT NULL
	)
GO

CREATE INDEX idx1
	ON dbo.cr_provision_periodo_anterior (ppa_banco, ppa_concepto, ppa_fecha, ppa_anual)
GO

IF OBJECT_ID ('dbo.cr_prov_recu') IS NOT NULL
	DROP TABLE dbo.cr_prov_recu
GO

CREATE TABLE dbo.cr_prov_recu
	(
	cliente      INT NOT NULL,
	provision    MONEY NOT NULL,
	recuperacion MONEY NOT NULL,
	saldo        MONEY NOT NULL
	)
GO

CREATE CLUSTERED INDEX cr_prov_recu_Key
	ON dbo.cr_prov_recu (cliente)
GO

IF OBJECT_ID ('dbo.cr_prospecto_contraoferta') IS NOT NULL
	DROP TABLE dbo.cr_prospecto_contraoferta
GO

CREATE TABLE dbo.cr_prospecto_contraoferta
	(
	pr_cliente       INT,
	pr_operacion     INT,
	pr_fecha_proceso DATETIME
	)
GO

CREATE CLUSTERED INDEX ix_cr_prospecto_contraoferta_Key
	ON dbo.cr_prospecto_contraoferta (pr_cliente, pr_operacion, pr_fecha_proceso)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_procesos_paralelo') IS NOT NULL
	DROP TABLE dbo.cr_procesos_paralelo
GO

CREATE TABLE dbo.cr_procesos_paralelo
	(
	pr_programa   VARCHAR (64) NOT NULL,
	pr_proceso    TINYINT NOT NULL,
	pr_estado     CHAR (1) NOT NULL,
	pr_int_desde  INT,
	pr_int_hasta  INT,
	pr_char_desde VARCHAR (64),
	pr_char_hasta VARCHAR (64),
	pr_inicio     DATETIME,
	pr_fin        DATETIME
	)
GO

CREATE UNIQUE INDEX cr_procesos_paralelo_key
	ON dbo.cr_procesos_paralelo (pr_programa, pr_proceso)
GO

IF OBJECT_ID ('dbo.cr_previa_temporal') IS NOT NULL
	DROP TABLE dbo.cr_previa_temporal
GO

CREATE TABLE dbo.cr_previa_temporal
	(
	pr_idconn      INT NOT NULL,
	pr_toperacion  VARCHAR (10),
	pr_abreviatura VARCHAR (10),
	pr_banco       VARCHAR (24),
	pr_por_vencer  MONEY,
	pr_vencido     MONEY,
	pr_disponible  MONEY,
	pr_tipo_riesgo VARCHAR (10),
	pr_tipo_cl     CHAR (1),
	pr_rol_cl      CHAR (1),
	pr_tipo_op     CHAR (1)
	)
GO

CREATE INDEX cr_previa_temporal_1
	ON dbo.cr_previa_temporal (pr_banco, pr_rol_cl, pr_disponible, pr_tipo_riesgo, pr_por_vencer, pr_vencido, pr_tipo_cl, pr_abreviatura, pr_idconn, pr_tipo_op)
GO

CREATE INDEX idxpr_toperacion
	ON dbo.cr_previa_temporal (pr_idconn, pr_tipo_op, pr_tipo_cl, pr_tipo_riesgo, pr_por_vencer, pr_vencido, pr_disponible, pr_rol_cl, pr_toperacion)
GO

IF OBJECT_ID ('dbo.cr_previa_ricl') IS NOT NULL
	DROP TABLE dbo.cr_previa_ricl
GO

CREATE TABLE dbo.cr_previa_ricl
	(
	pr_idconn      INT,
	pr_toperacion  VARCHAR (10),
	pr_abreviatura VARCHAR (10),
	pr_banco       VARCHAR (24),
	pr_por_vencer  MONEY,
	pr_vencido     MONEY,
	pr_disponible  MONEY,
	pr_tipo_riesgo VARCHAR (10),
	pr_tipo_cl     CHAR (1),
	pr_rol_cl      CHAR (1),
	pr_tipo_op     CHAR (1),
	pr_operacion   INT
	)
GO

CREATE INDEX cr_previa_ricl_1
	ON dbo.cr_previa_ricl (pr_idconn, pr_tipo_riesgo, pr_rol_cl)
GO

IF OBJECT_ID ('dbo.cr_pregunta') IS NOT NULL
	DROP TABLE dbo.cr_pregunta
GO

CREATE TABLE dbo.cr_pregunta
	(
	pr_pregunta       INT NOT NULL,
	pr_descripcion    VARCHAR (80) NOT NULL,
	pr_ayuda          VARCHAR (64) NOT NULL,
	pr_tipo_respuesta VARCHAR (10) NOT NULL,
	pr_catalogo       VARCHAR (30),
	pr_estado         VARCHAR (1) NOT NULL,
	pr_num_min        INT,
	pr_num_max        INT,
	pr_dec_min        FLOAT,
	pr_dec_max        FLOAT,
	pr_date_min       DATETIME,
	pr_date_max       DATETIME
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_pregunta (pr_pregunta)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_politicas_cupos') IS NOT NULL
	DROP TABLE dbo.cr_politicas_cupos
GO

CREATE TABLE dbo.cr_politicas_cupos
	(
	pc_banca         catalogo NOT NULL,
	pc_num_politica  INT NOT NULL,
	pc_nom_politica  catalogo NOT NULL,
	pc_descripcion   VARCHAR (255) NOT NULL,
	pc_clasificacion catalogo NOT NULL,
	pc_programa      VARCHAR (100),
	pc_tipo          CHAR (1) NOT NULL,
	pc_estado        CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ix1_cr_politicas_cupos
	ON dbo.cr_politicas_cupos (pc_num_politica)
GO

CREATE INDEX ix2_cr_politicas_cupos
	ON dbo.cr_politicas_cupos (pc_banca)
GO

IF OBJECT_ID ('dbo.cr_planes') IS NOT NULL
	DROP TABLE dbo.cr_planes
GO

CREATE TABLE dbo.cr_planes
	(
	pl_codigo          INT NOT NULL,
	pl_descripcion     descripcion,
	pl_tipo_seguro     VARCHAR (10) NOT NULL,
	pl_estado          VARCHAR (10) NOT NULL,
	pl_total_asegurado MONEY NOT NULL,
	pl_valor_mes       MONEY NOT NULL,
	pl_valor_ano       MONEY NOT NULL,
	pl_clase           VARCHAR (10)
	)
GO

CREATE INDEX cr_planes_key
	ON dbo.cr_planes (pl_codigo)
GO

IF OBJECT_ID ('dbo.cr_plan_seguros') IS NOT NULL
	DROP TABLE dbo.cr_plan_seguros
GO

CREATE TABLE dbo.cr_plan_seguros
	(
	ps_codigo_plan         INT,
	ps_tipo_seguro         INT,
	ps_descripcion         VARCHAR (255),
	ps_valor_mensual       MONEY,
	ps_tasa_efa            FLOAT,
	ps_estado              catalogo,
	ps_fecha_ini           DATETIME,
	ps_fecha_fin           DATETIME,
	ps_plazo_cobertura_cre INT,
	ps_plazo_cobertura     INT,
	ps_fecha_modif         DATETIME,
	ps_usuario_modif       login,
	ps_terminal_modif      VARCHAR (30),
	ps_fecha_crea          DATETIME,
	ps_usuario_crea        login,
	ps_terminal_crea       VARCHAR (30),
	ps_plan_historia       INT NOT NULL,
	ps_seguro_historia     INT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_plan_seguros (ps_plan_historia)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_plan_seguros (ps_codigo_plan, ps_tipo_seguro)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_peso_rubro') IS NOT NULL
	DROP TABLE dbo.cr_peso_rubro
GO

CREATE TABLE dbo.cr_peso_rubro
	(
	go_peso      INT NOT NULL,
	go_operacion INT NOT NULL,
	go_producto  TINYINT NOT NULL,
	go_concepto  catalogo NOT NULL,
	go_saldo     FLOAT NOT NULL,
	go_cubierto  FLOAT NOT NULL,
	go_mes_vto   FLOAT NOT NULL,
	go_clase     VARCHAR (10) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_peso_rubro_Key
	ON dbo.cr_peso_rubro (go_operacion, go_producto, go_concepto)
GO

IF OBJECT_ID ('dbo.cr_pendte_desembolso') IS NOT NULL
	DROP TABLE dbo.cr_pendte_desembolso
GO

CREATE TABLE dbo.cr_pendte_desembolso
	(
	rt_oficina          SMALLINT,
	rt_zona             SMALLINT,
	rt_regional         SMALLINT,
	rt_tramite          INT,
	rt_cliente          INT,
	rt_tipo             CHAR (1),
	rt_estado           VARCHAR (20),
	rt_fecha_aprobacion DATETIME,
	rt_monto_aprobado   MONEY,
	rt_monto_utilizado  MONEY,
	rt_tipo_garantia    catalogo,
	rt_inversion        catalogo,
	rt_tipo_productor   catalogo,
	rt_linea            catalogo,
	rt_user             login,
	rt_sesn             INT
	)
GO

CREATE INDEX cr_pendte_desembolso_Key
	ON dbo.cr_pendte_desembolso (rt_regional, rt_zona, rt_oficina)
GO

IF OBJECT_ID ('dbo.cr_pasos_filtros') IS NOT NULL
	DROP TABLE dbo.cr_pasos_filtros
GO

CREATE TABLE dbo.cr_pasos_filtros
	(
	pf_ruta  INT,
	pf_paso  INT,
	pf_etapa INT
	)
GO

IF OBJECT_ID ('dbo.cr_pasos') IS NOT NULL
	DROP TABLE dbo.cr_pasos
GO

CREATE TABLE dbo.cr_pasos
	(
	pa_truta           TINYINT NOT NULL,
	pa_paso            TINYINT NOT NULL,
	pa_etapa           TINYINT NOT NULL,
	pa_descripcion     descripcion,
	pa_tiempo_estandar FLOAT,
	pa_tipo            CHAR (1) NOT NULL,
	pa_truta_asoc      TINYINT,
	pa_paso_asoc       TINYINT,
	pa_etapa_asoc      TINYINT,
	pa_picture         CHAR (1),
	pa_fijar_tasa      CHAR (2)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_pasos_Key
	ON dbo.cr_pasos (pa_truta, pa_paso, pa_etapa)
GO

IF OBJECT_ID ('dbo.cr_param_suspension') IS NOT NULL
	DROP TABLE dbo.cr_param_suspension
GO

CREATE TABLE dbo.cr_param_suspension
	(
	ps_clase      CHAR (1) NOT NULL,
	ps_arrastre   catalogo NOT NULL,
	ps_suspension catalogo NOT NULL,
	ps_situacion1 catalogo NOT NULL,
	ps_situacion2 catalogo NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_param_suspension_Key
	ON dbo.cr_param_suspension (ps_clase)
GO

IF OBJECT_ID ('dbo.cr_param_normalizacion') IS NOT NULL
	DROP TABLE dbo.cr_param_normalizacion
GO

CREATE TABLE dbo.cr_param_normalizacion
	(
	nr_secuencial INT,
	nr_estado     catalogo,
	nr_tipo_norm  catalogo,
	nr_momento    catalogo,
	nr_regla      catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx2
	ON dbo.cr_param_normalizacion (nr_tipo_norm, nr_momento, nr_regla)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx1
	ON dbo.cr_param_normalizacion (nr_secuencial)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_param_mensajes') IS NOT NULL
	DROP TABLE dbo.cr_param_mensajes
GO

CREATE TABLE dbo.cr_param_mensajes
	(
	pm_banca   catalogo NOT NULL,
	pm_tipo    CHAR (1) NOT NULL,
	pm_cuotas  TINYINT NOT NULL,
	pm_mensaje VARCHAR (255) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ix_cr_param_mensajes
	ON dbo.cr_param_mensajes (pm_banca, pm_tipo, pm_cuotas)
GO

IF OBJECT_ID ('dbo.cr_param_gar') IS NOT NULL
	DROP TABLE dbo.cr_param_gar
GO

CREATE TABLE dbo.cr_param_gar
	(
	pg_tipo_gar    CHAR (1) NOT NULL,
	pg_desde       INT NOT NULL,
	pg_hasta       INT NOT NULL,
	pg_porc_normal FLOAT NOT NULL,
	pg_porc_estcom FLOAT NOT NULL,
	pg_porc_concor FLOAT NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_param_gar_Key
	ON dbo.cr_param_gar (pg_tipo_gar, pg_desde, pg_hasta)
GO

IF OBJECT_ID ('dbo.cr_param_especiales_norm') IS NOT NULL
	DROP TABLE dbo.cr_param_especiales_norm
GO

CREATE TABLE dbo.cr_param_especiales_norm
	(
	pe_campana            INT,
	pe_tipo_campana       INT,
	pe_tipo_normalizacion INT,
	pe_regla              catalogo,
	pe_tipo_dato          CHAR (1),
	pe_char               CHAR (10),
	pe_tinyint            TINYINT,
	pe_smallint           SMALLINT,
	pe_int                INT,
	pe_money              MONEY,
	pe_datetime           DATETIME,
	pe_float              FLOAT,
	pe_estado             catalogo,
	pe_tipo               CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_param_cont_temp') IS NOT NULL
	DROP TABLE dbo.cr_param_cont_temp
GO

CREATE TABLE dbo.cr_param_cont_temp
	(
	ct_codigo INT,
	ct_clase  catalogo,
	ct_desde  INT,
	ct_hasta  INT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_param_cont_temp_Key
	ON dbo.cr_param_cont_temp (ct_codigo)
GO

CREATE INDEX cr_param_cont_temp_K1
	ON dbo.cr_param_cont_temp (ct_clase)
GO

IF OBJECT_ID ('dbo.cr_param_cob_gar') IS NOT NULL
	DROP TABLE dbo.cr_param_cob_gar
GO

CREATE TABLE dbo.cr_param_cob_gar
	(
	pc_tipo_gar    varchar(20),
	pc_tipo_prod   catalogo,
	pc_monto_desde INT,
	pc_monto_hasta INT,
	pc_porc_desde  FLOAT,
	pc_porc_hasta  FLOAT
	)
GO

IF OBJECT_ID ('dbo.cr_param_calif') IS NOT NULL
	DROP TABLE dbo.cr_param_calif
GO

CREATE TABLE dbo.cr_param_calif
	(
	pc_clase        CHAR (1) NOT NULL,
	pc_calificacion catalogo NOT NULL,
	pc_desde        INT NOT NULL,
	pc_hasta        INT NOT NULL,
	pc_porcentaje   FLOAT NOT NULL,
	pc_porc_intcxc  FLOAT NOT NULL,
	pc_porc_cubier  FLOAT NOT NULL,
	pc_porc_sidac   FLOAT NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_param_calif_Key
	ON dbo.cr_param_calif (pc_clase, pc_calificacion, pc_desde, pc_hasta)
GO

IF OBJECT_ID ('dbo.cr_pa_pregunta_mir') IS NOT NULL
	DROP TABLE dbo.cr_pa_pregunta_mir
GO

CREATE TABLE dbo.cr_pa_pregunta_mir
	(
	pr_pregunta      SMALLINT NOT NULL,
	pr_texto         VARCHAR (255) NOT NULL,
	pr_tipo_resp     CHAR (1) NOT NULL,
	pr_catalogo      VARCHAR (30),
	pr_estado        estado DEFAULT ('V') NOT NULL,
	pr_identificador VARCHAR (32),
	pr_tipo          SMALLINT,
	pr_subtipo_m     VARCHAR (30)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_pa_pregunta_mir_ind
	ON dbo.cr_pa_pregunta_mir (pr_pregunta)
GO

IF OBJECT_ID ('dbo.cr_operacion_cobranza') IS NOT NULL
	DROP TABLE dbo.cr_operacion_cobranza
GO

CREATE TABLE dbo.cr_operacion_cobranza
	(
	oc_cobranza      VARCHAR (10) NOT NULL,
	oc_num_operacion cuenta NOT NULL,
	oc_producto      catalogo NOT NULL,
	oc_oficina       SMALLINT,
	oc_monto         MONEY,
	oc_estado        TINYINT,
	oc_saldo_cap     MONEY,
	oc_dias_vto_div  INT,
	oc_codprod       TINYINT
	)
GO

CREATE INDEX cr_operacion_cobranza_Key
	ON dbo.cr_operacion_cobranza (oc_codprod, oc_num_operacion, oc_cobranza)
GO

CREATE INDEX cr_operacion_cobranza_Key1
	ON dbo.cr_operacion_cobranza (oc_cobranza)
GO

CREATE INDEX cr_ope_cob_i2
	ON dbo.cr_operacion_cobranza (oc_num_operacion, oc_cobranza)
GO

IF OBJECT_ID ('dbo.cr_ope_temporal') IS NOT NULL
	DROP TABLE dbo.cr_ope_temporal
GO

CREATE TABLE dbo.cr_ope_temporal
	(
	op_idconn      INT NOT NULL,
	op_operacion   INT,
	op_banco       VARCHAR (24),
	op_toperacion  VARCHAR (10),
	op_producto    TINYINT,
	op_abreviatura VARCHAR (10),
	op_tipo_riesgo VARCHAR (10),
	op_saldo_cap   MONEY,
	op_saldo_int   MONEY,
	op_saldo_otr   MONEY,
	op_disponible  MONEY,
	op_estado      TINYINT,
	op_tramite     CHAR (1),
	op_estado_tr   CHAR (1),
	op_tipo_cl     CHAR (1),
	op_rol_cl      CHAR (1)
	)
GO

CREATE INDEX cr_ope_temporal_Key
	ON dbo.cr_ope_temporal (op_producto, op_banco, op_toperacion, op_tipo_riesgo, op_disponible, op_saldo_cap, op_saldo_int, op_saldo_otr, op_abreviatura, op_tramite, op_estado, op_estado_tr, op_idconn, op_tipo_cl, op_rol_cl)
GO

IF OBJECT_ID ('dbo.cr_ope_ricl') IS NOT NULL
	DROP TABLE dbo.cr_ope_ricl
GO

CREATE TABLE dbo.cr_ope_ricl
	(
	op_idconn      INT,
	op_operacion   INT,
	op_banco       VARCHAR (24),
	op_toperacion  VARCHAR (10),
	op_producto    TINYINT,
	op_abreviatura VARCHAR (10),
	op_tipo_riesgo VARCHAR (10),
	op_saldo_cap   MONEY,
	op_saldo_int   MONEY,
	op_saldo_otr   MONEY,
	op_disponible  MONEY,
	op_estado      TINYINT,
	op_tramite     CHAR (1),
	op_estado_tr   CHAR (1),
	op_tipo_cl     CHAR (1),
	op_rol_cl      CHAR (1)
	)
GO

CREATE INDEX cr_ope_ricl_1
	ON dbo.cr_ope_ricl (op_idconn, op_tipo_cl)
GO

CREATE INDEX cr_ope_ricl_2
	ON dbo.cr_ope_ricl (op_idconn, op_tramite, op_estado)
GO

CREATE INDEX cr_ope_ricl_Key
	ON dbo.cr_ope_ricl (op_idconn)
GO

IF OBJECT_ID ('dbo.cr_op_renovar') IS NOT NULL
	DROP TABLE dbo.cr_op_renovar
GO

CREATE TABLE dbo.cr_op_renovar
	(
	or_tramite             INT NOT NULL,
	or_num_operacion       cuenta NOT NULL,
	or_producto            catalogo NOT NULL,
	or_abono               MONEY,
	or_moneda_abono        TINYINT,
	or_monto_original      MONEY,
	or_moneda_original     TINYINT,
	or_saldo_original      MONEY,
	or_fecha_concesion     DATETIME,
	or_toperacion          catalogo,
	or_operacion_original  INT,
	or_cancelado           CHAR (1),
	or_monto_inicial       MONEY,
	or_moneda_inicial      TINYINT,
	or_aplicar             CHAR (1),
	or_capitaliza          CHAR (1),
	or_login               login,
	or_fecha_ingreso       DATETIME,
	or_finalizo_renovacion CHAR (1),
	or_sec_prn             INT,
	or_referencia_grupal   cuenta null,  --ref grupal
    or_ciclo_original      int   null,
    or_grupo               int   null 
    or_tasa_ciclo_ant      float null
	)
GO

CREATE UNIQUE INDEX cr_op_renovar_Key
	ON dbo.cr_op_renovar (or_tramite, or_num_operacion)
GO

CREATE INDEX cr_op_renovar_Key2
	ON dbo.cr_op_renovar (or_num_operacion)
GO
create nonclustered index cr_op_renovar_key3  on dbo.cr_op_renovar (or_referencia_grupal)
go
create nonclustered index cr_op_renovar_key4 on dbo.cr_op_renovar (or_ciclo_original) 
go
create nonclustered index cr_op_renovar_key5 on dbo.cr_op_renovar (or_grupo) 
go
create nonclustered index cr_op_renovar_key6  on dbo.cr_op_renovar (or_tasa_ciclo_ant)
go


IF OBJECT_ID ('dbo.cr_observaciones') IS NOT NULL
	DROP TABLE dbo.cr_observaciones
GO

CREATE TABLE dbo.cr_observaciones
	(
	ob_tramite   INT NOT NULL,
	ob_numero    SMALLINT NOT NULL,
	ob_fecha     DATETIME NOT NULL,
	ob_categoria catalogo,
	ob_etapa     TINYINT NOT NULL,
	ob_estacion  SMALLINT NOT NULL,
	ob_usuario   login NOT NULL,
	ob_lineas    SMALLINT,
	ob_oficial   CHAR (1) NOT NULL,
	ob_modificar CHAR (1) NOT NULL,
	ob_rechazo   CHAR (1)
	)
GO

CREATE UNIQUE INDEX cr_observaciones_Key
	ON dbo.cr_observaciones (ob_tramite, ob_numero)
GO

IF OBJECT_ID ('dbo.cr_ob_lineas') IS NOT NULL
	DROP TABLE dbo.cr_ob_lineas
GO

CREATE TABLE dbo.cr_ob_lineas
	(
	ol_tramite     INT NOT NULL,
	ol_observacion SMALLINT NOT NULL,
	ol_linea       SMALLINT,
	ol_texto       VARCHAR (255),
	ol_tipo_dato   CHAR (1),
	ol_valor       VARCHAR (10)
	)
GO

CREATE UNIQUE INDEX cr_ob_lineas_Key
	ON dbo.cr_ob_lineas (ol_tramite, ol_observacion, ol_linea)
GO

IF OBJECT_ID ('dbo.cr_normalizacion') IS NOT NULL
	DROP TABLE dbo.cr_normalizacion
GO

CREATE TABLE dbo.cr_normalizacion
	(
	nm_tramite   INT,
	nm_cliente   INT,
	nm_operacion cuenta,
	nm_tipo_norm catalogo,
	nm_cuota     INT,
	nm_fecha     DATETIME,
	nm_login     login
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx3
	ON dbo.cr_normalizacion (nm_tramite, nm_operacion)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx1
	ON dbo.cr_normalizacion (nm_tramite)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_normalizacion (nm_cliente)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_proc') IS NOT NULL
	DROP TABLE dbo.cr_msv_proc
GO

CREATE TABLE dbo.cr_msv_proc
	(
	mp_id_carga    INT,
	mp_id_Alianza  INT,
	mp_cedula      numero,
	mp_tipo_ced    CHAR (2),
	mp_oficial     SMALLINT,
	mp_tramite     INT,
	mp_tipo        CHAR (1),
	mp_estado      CHAR (1),
	mp_ruta        INT,
	mp_etapa       INT,
	mp_estacion    INT,
	mp_ejecutivo   VARCHAR (30),
	mp_descripcion VARCHAR (124),
	mp_fecha_proc  DATETIME
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_proc (mp_id_carga, mp_id_Alianza, mp_cedula, mp_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx_2
	ON dbo.cr_msv_proc (mp_tramite)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_u_his') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_u_his
GO

CREATE TABLE dbo.cr_msv_crear_u_his
	(
	mtu_id_carga      INT,
	mtu_id_Alianza    INT,
	mtu_cedula        numero,
	mtu_tipo_ced      CHAR (2),
	mtu_oficial       SMALLINT,
	mtu_linea_credito cuenta,
	mtu_toperacion    catalogo,
	mtu_monto         MONEY,
	mtu_tipo_plazo    catalogo,
	mtu_tipo_cuota    catalogo,
	mtu_plazocup      SMALLINT,
	mtu_plazo         SMALLINT,
	mtu_aprob_gar     catalogo,
	mtu_fecha_fija    CHAR (1),
	mtu_dia_pago      TINYINT,
	mtu_fecha_proc    DATETIME
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_u_his (mtu_id_carga, mtu_id_Alianza, mtu_cedula, mtu_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_u') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_u
GO

CREATE TABLE dbo.cr_msv_crear_u
	(
	mtu_id_carga      INT,
	mtu_id_Alianza    INT,
	mtu_cedula        numero,
	mtu_tipo_ced      CHAR (2),
	mtu_oficial       SMALLINT,
	mtu_linea_credito cuenta,
	mtu_toperacion    catalogo,
	mtu_monto         MONEY,
	mtu_tipo_plazo    catalogo,
	mtu_tipo_cuota    catalogo,
	mtu_plazocup      SMALLINT,
	mtu_plazo         SMALLINT,
	mtu_aprob_gar     catalogo,
	mtu_fecha_fija    CHAR (1),
	mtu_dia_pago      TINYINT
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_u (mtu_id_carga, mtu_id_Alianza, mtu_cedula, mtu_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_orig_his') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_orig_his
GO

CREATE TABLE dbo.cr_msv_crear_orig_his
	(
	mto_id_carga   INT,
	mto_id_Alianza INT,
	mto_cedula     numero,
	mto_tipo_ced   CHAR (2),
	mto_oficial    SMALLINT,
	mto_toperacion catalogo,
	mto_monto      MONEY,
	mto_tipo_plazo catalogo,
	mto_tipo_cuota catalogo,
	mto_plazocup   SMALLINT,
	mto_plazo      SMALLINT,
	mto_aprob_gar  catalogo,
	mto_fecha_proc DATETIME,
	mto_fecha_fija CHAR (1),
	mto_dia_pago   TINYINT
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_orig_his (mto_id_carga, mto_id_Alianza, mto_cedula, mto_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_orig') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_orig
GO

CREATE TABLE dbo.cr_msv_crear_orig
	(
	mto_id_carga   INT,
	mto_id_Alianza INT,
	mto_cedula     numero,
	mto_tipo_ced   CHAR (2),
	mto_oficial    SMALLINT,
	mto_toperacion catalogo,
	mto_monto      MONEY,
	mto_tipo_plazo catalogo,
	mto_tipo_cuota catalogo,
	mto_plazocup   SMALLINT,
	mto_plazo      SMALLINT,
	mto_aprob_gar  catalogo,
	mto_fecha_fija CHAR (1),
	mto_dia_pago   TINYINT
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_orig (mto_id_carga, mto_id_Alianza, mto_cedula, mto_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_cupo_his') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_cupo_his
GO

CREATE TABLE dbo.cr_msv_crear_cupo_his
	(
	mtc_id_carga   INT,
	mtc_id_Alianza INT,
	mtc_cedula     numero,
	mtc_tipo_ced   CHAR (2),
	mtc_oficial    SMALLINT,
	mtc_toperacion catalogo,
	mtc_monto      MONEY,
	mtc_tipo_plazo catalogo,
	mtc_tipo_cuota catalogo,
	mtc_plazocup   SMALLINT,
	mtc_plazo      SMALLINT,
	mtc_aprob_gar  catalogo,
	mtc_fecha_proc DATETIME
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_cupo_his (mtc_id_carga, mtc_id_Alianza, mtc_cedula, mtc_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_msv_crear_cupo') IS NOT NULL
	DROP TABLE dbo.cr_msv_crear_cupo
GO

CREATE TABLE dbo.cr_msv_crear_cupo
	(
	mtc_id_carga   INT,
	mtc_id_Alianza INT,
	mtc_cedula     numero,
	mtc_tipo_ced   CHAR (2),
	mtc_oficial    SMALLINT,
	mtc_toperacion catalogo,
	mtc_monto      MONEY,
	mtc_tipo_plazo catalogo,
	mtc_tipo_cuota catalogo,
	mtc_plazocup   SMALLINT,
	mtc_plazo      SMALLINT,
	mtc_aprob_gar  catalogo
	)
GO

CREATE INDEX idx_1
	ON dbo.cr_msv_crear_cupo (mtc_id_carga, mtc_id_Alianza, mtc_cedula, mtc_tipo_ced)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_mov_tramite') IS NOT NULL
	DROP TABLE dbo.cr_mov_tramite
GO

CREATE TABLE dbo.cr_mov_tramite
	(
	mt_tramite     INT,
	mt_etapa       INT,
	mt_estacion    INT,
	mt_tiempo      INT,
	mt_oficial     INT,
	mt_oficina     INT,
	mt_regional    INT,
	mt_territorial INT
	)
GO

IF OBJECT_ID ('dbo.cr_mov_fuente_recurso') IS NOT NULL
	DROP TABLE dbo.cr_mov_fuente_recurso
GO

CREATE TABLE dbo.cr_mov_fuente_recurso
	(
	mf_secuencial INT IDENTITY NOT NULL,
	mf_user       login,
	mf_fuente     VARCHAR (10),
	mf_fecha      DATETIME,
	mf_hora       DATETIME,
	mf_saldo_ini  MONEY,
	mf_valor_inc  MONEY,
	mf_valor_res  MONEY,
	mf_saldo_fin  MONEY,
	mf_banco      cuenta,
	mf_tramite    INT,
	mf_procesado  CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_mov_fuente_recurso (mf_secuencial)
GO

CREATE INDEX idx2
	ON dbo.cr_mov_fuente_recurso (mf_fecha, mf_fuente)
GO

IF OBJECT_ID ('dbo.cr_microempresa') IS NOT NULL
	DROP TABLE dbo.cr_microempresa
GO

CREATE TABLE dbo.cr_microempresa
	(
	mi_secuencial         INT NOT NULL,
	mi_tramite            INT NOT NULL,
	mi_identificacion     numero,
	mi_nombre             descripcion,
	mi_descripcion        descripcion,
	mi_num_trabaj_remu    INT,
	mi_num_trabaj_no_remu INT,
	mi_experiencia        INT NOT NULL,
	mi_experiencia_fecha  DATETIME NOT NULL,
	mi_antiguedad         DATETIME NOT NULL,
	mi_local              VARCHAR (10) NOT NULL,
	mi_arrendador         descripcion,
	mi_telefono           numero,
	mi_referencias        descripcion,
	mi_tipo_empresa       VARCHAR (10) NOT NULL,
	mi_conductor          VARCHAR (10),
	mi_tipo_contrato      VARCHAR (10),
	mi_dias_trabajados    INT,
	mi_pais               SMALLINT,
	mi_departamento       SMALLINT,
	mi_ciudad             INT,
	mi_barrio             SMALLINT,
	mi_extension          INT,
	mi_unidad_extension   VARCHAR (10),
	mi_fecha_inf          DATETIME,
	mi_total_eyb          MONEY,
	mi_total_cxc          MONEY,
	mi_total_mp           MONEY,
	mi_total_pep          MONEY,
	mi_total_pt           MONEY,
	mi_total_prur         MONEY,
	mi_total_af           MONEY,
	mi_total_prc          MONEY,
	mi_total_ofc          MONEY,
	mi_total_opasc        MONEY,
	mi_total_prl          MONEY,
	mi_total_ofl          MONEY,
	mi_total_opasl        MONEY,
	mi_total_vtas         MONEY,
	mi_total_costo        MONEY,
	mi_total_gp           MONEY,
	mi_total_gg           MONEY,
	mi_total_ia           MONEY,
	mi_total_gf           MONEY,
	mi_total_op           MONEY,
	mi_dispuf             MONEY,
	mi_total_com          MONEY,
	mi_migrado            CHAR (1) DEFAULT ('N') NOT NULL,
	mi_cuadre             CHAR (1) CONSTRAINT mi_cuadre_def DEFAULT ('S')
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_microempresa_i1
	ON dbo.cr_microempresa (mi_tramite)
GO

CREATE INDEX cr_microempresa_key
	ON dbo.cr_microempresa (mi_secuencial, mi_tramite)
GO

IF OBJECT_ID ('dbo.cr_micro_seguro_his') IS NOT NULL
	DROP TABLE dbo.cr_micro_seguro_his
GO

CREATE TABLE dbo.cr_micro_seguro_his
	(
	ms_secuencial    INT,
	ms_tramite       INT,
	ms_plazo         SMALLINT,
	ms_director_ofic SMALLINT,
	ms_vendedor      SMALLINT,
	ms_estado        VARCHAR (10),
	ms_fecha_ini     DATETIME,
	ms_fecha_fin     DATETIME,
	ms_fecha_envio   DATETIME,
	ms_cliente_aseg  CHAR (1),
	ms_valor         MONEY,
	ms_pagado        CHAR (1),
	ms_fecha_mod     DATETIME,
	ms_usuario_mod   login
	)
GO

IF OBJECT_ID ('dbo.cr_micro_seguro') IS NOT NULL
	DROP TABLE dbo.cr_micro_seguro
GO

CREATE TABLE dbo.cr_micro_seguro
	(
	ms_secuencial    INT NOT NULL,
	ms_tramite       INT NOT NULL,
	ms_plazo         SMALLINT NOT NULL,
	ms_director_ofic SMALLINT NOT NULL,
	ms_vendedor      SMALLINT NOT NULL,
	ms_estado        VARCHAR (10) NOT NULL,
	ms_fecha_ini     DATETIME,
	ms_fecha_fin     DATETIME,
	ms_fecha_envio   DATETIME,
	ms_cliente_aseg  CHAR (1) NOT NULL,
	ms_valor         MONEY,
	ms_pagado        CHAR (1) DEFAULT ('N') NOT NULL,
	ms_fecha_mod     DATETIME,
	ms_usuario_mod   login,
	ms_cupo          CHAR (1) DEFAULT ('N') NOT NULL,
	ms_clase         VARCHAR (10),
	ms_sec_alterno   INT
	)
GO

CREATE CLUSTERED INDEX cr_micro_seguro_key1
	ON dbo.cr_micro_seguro (ms_secuencial)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_micro_seguro_key
	ON dbo.cr_micro_seguro (ms_tramite, ms_secuencial)
GO

CREATE INDEX idx2
	ON dbo.cr_micro_seguro (ms_secuencial)
GO

CREATE INDEX cr_micro_seguro_idx3
	ON dbo.cr_micro_seguro (ms_estado, ms_tramite)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_matriz_cupos') IS NOT NULL
	DROP TABLE dbo.cr_matriz_cupos
GO

CREATE TABLE dbo.cr_matriz_cupos
	(
	mc_segmento  catalogo NOT NULL,
	mc_politica  INT NOT NULL,
	mc_operador  VARCHAR (2) NOT NULL,
	mc_valor     VARCHAR (20) NOT NULL,
	mc_condicion INT,
	mc_alianza   INT
	)
GO

CREATE UNIQUE CLUSTERED INDEX ix_cr_matriz_cupos
	ON dbo.cr_matriz_cupos (mc_segmento, mc_politica, mc_operador, mc_valor, mc_condicion, mc_alianza)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_linea_tmpp1') IS NOT NULL
	DROP TABLE dbo.cr_linea_tmpp1
GO

CREATE TABLE dbo.cr_linea_tmpp1
	(
	sesion     INT,
	num_banco  cuenta,
	monto      MONEY,
	estado     VARCHAR (15),
	disponible MONEY,
	fecha_vto  DATETIME,
	tramite    INT,
	tipo       CHAR (1),
	nota       TINYINT
	)
GO

CREATE INDEX cr_linea_tmpp1_1
	ON dbo.cr_linea_tmpp1 (sesion, estado)
GO

IF OBJECT_ID ('dbo.cr_linea_tmpp') IS NOT NULL
	DROP TABLE dbo.cr_linea_tmpp
GO

CREATE TABLE dbo.cr_linea_tmpp
	(
	sesion     INT,
	num_banco  cuenta,
	monto      MONEY,
	estado     VARCHAR (15),
	disponible MONEY,
	fecha_vto  DATETIME,
	tramite    INT,
	tipo       CHAR (1),
	nota       TINYINT
	)
GO

CREATE INDEX cr_linea_tmpp_1
	ON dbo.cr_linea_tmpp (sesion, estado)
GO

IF OBJECT_ID ('dbo.cr_linea') IS NOT NULL
	DROP TABLE dbo.cr_linea
GO

CREATE TABLE dbo.cr_linea
	(
	li_numero             INT NOT NULL,
	li_num_banco          cuenta,
	li_oficina            SMALLINT NOT NULL,
	li_tramite            INT NOT NULL,
	li_cliente            INT,
	li_grupo              INT,
	li_original           INT,
	li_fecha_aprob        DATETIME,
	li_fecha_inicio       DATETIME NOT NULL,
	li_per_revision       catalogo,
	li_fecha_vto          DATETIME,
	li_dias               SMALLINT,
	li_condicion_especial VARCHAR (255),
	li_segmento           catalogo,
	li_ult_rev            DATETIME,
	li_prox_rev           DATETIME,
	li_usuario_rev        login,
	li_monto              MONEY NOT NULL,
	li_moneda             TINYINT NOT NULL,
	li_utilizado          MONEY,
	li_rotativa           CHAR (1) NOT NULL,
	li_clase              catalogo,
	li_admisible          MONEY,
	li_noadmis            MONEY,
	li_estado             CHAR (1),
	li_reservado          MONEY,
	li_tipo               CHAR (1),
	li_usuario_mod        login,
	li_fecha_mod          DATETIME,
	li_dias_vig           INT,
	li_num_desemb         INT,
	li_dias_vig_prorroga  INT,
	li_fech_apro_prorroga DATETIME,
	li_acta_prorroga      cuenta,
	li_usu_prorroga       login,
	li_tipo_normal        CHAR (1),
	li_tipo_plazo         catalogo,
	li_tipo_cuota         catalogo,
	li_plazo              SMALLINT,
	li_cuota_aproximada   MONEY,
	li_bloq_manual        CHAR (1) CONSTRAINT cr_linea_defaultBlock DEFAULT ('N') NOT NULL,
	li_tipo_bloq_aut      CHAR (1)
	)
GO

CREATE CLUSTERED INDEX cr_linea_Key_tr
	ON dbo.cr_linea (li_tramite)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_linea_AKey
	ON dbo.cr_linea (li_cliente)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_linea_BKey
	ON dbo.cr_linea (li_num_banco, li_estado)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_linea_CKey
	ON dbo.cr_linea (li_tramite, li_estado)
	WITH (FILLFACTOR = 80)
GO

CREATE UNIQUE INDEX cr_linea_Key
	ON dbo.cr_linea (li_numero)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_linea_Dkey
	ON dbo.cr_linea (li_bloq_manual)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_lin_reservado') IS NOT NULL
	DROP TABLE dbo.cr_lin_reservado
GO

CREATE TABLE dbo.cr_lin_reservado
	(
	lr_tramite    INT NOT NULL,
	lr_cliente    INT NOT NULL,
	lr_numero     INT,
	lr_num_banco  cuenta,
	lr_toperacion catalogo,
	lr_producto   catalogo,
	lr_moneda     TINYINT,
	lr_monto      MONEY,
	lr_reservado  MONEY
	)
GO

CREATE INDEX cr_lin_reservado_2
	ON dbo.cr_lin_reservado (lr_numero, lr_tramite)
GO

CREATE INDEX cr_lin_reservado_3
	ON dbo.cr_lin_reservado (lr_num_banco, lr_tramite)
GO

CREATE INDEX cr_lin_reservado_4
	ON dbo.cr_lin_reservado (lr_cliente, lr_tramite, lr_reservado)
GO

CREATE INDEX cr_lin_reservado_Key
	ON dbo.cr_lin_reservado (lr_tramite, lr_toperacion, lr_moneda)
GO

IF OBJECT_ID ('dbo.cr_lin_ope_moneda') IS NOT NULL
	DROP TABLE dbo.cr_lin_ope_moneda
GO

CREATE TABLE dbo.cr_lin_ope_moneda
	(
	om_linea              INT NOT NULL,
	om_toperacion         catalogo NOT NULL,
	om_producto           catalogo NOT NULL,
	om_moneda             TINYINT,
	om_monto              MONEY,
	om_utilizado          MONEY,
	om_tplazo             catalogo,
	om_plazos             SMALLINT,
	om_condicion_especial VARCHAR (255),
	om_reservado          MONEY,
	om_moneda_ope         TINYINT
	)
GO

CREATE UNIQUE INDEX cr_lin_ope_moneda_Key
	ON dbo.cr_lin_ope_moneda (om_linea, om_toperacion, om_producto, om_moneda)
GO

IF OBJECT_ID ('dbo.cr_lin_grupo') IS NOT NULL
	DROP TABLE dbo.cr_lin_grupo
GO

CREATE TABLE dbo.cr_lin_grupo
	(
	lg_linea     INT NOT NULL,
	lg_cliente   INT NOT NULL,
	lg_monto     MONEY,
	lg_utilizado MONEY,
	lg_moneda    SMALLINT,
	lg_reservado MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_lin_grupo_Key
	ON dbo.cr_lin_grupo (lg_linea, lg_cliente)
GO

IF OBJECT_ID ('dbo.cr_instrucciones') IS NOT NULL
	DROP TABLE dbo.cr_instrucciones
GO

CREATE TABLE dbo.cr_instrucciones
	(
	in_tramite     INT NOT NULL,
	in_numero      SMALLINT NOT NULL,
	in_codigo      catalogo NOT NULL,
	in_estado      CHAR (1),
	in_texto       VARCHAR (255),
	in_parametro   catalogo,
	in_valor       MONEY,
	in_signo       VARCHAR (2),
	in_spread      FLOAT,
	in_fecha_aprob DATETIME,
	in_login_aprob login,
	in_fecha_reg   DATETIME NOT NULL,
	in_login_reg   login NOT NULL,
	in_login_eje   login,
	in_fecha_eje   DATETIME,
	in_aprob_por   login,
	in_forma_pago  catalogo,
	in_cuenta      cuenta,
	in_tipo        CHAR (1),
	in_comite      catalogo,
	in_acta        cuenta,
	in_garantia    VARCHAR (64),
	in_lin_credito cuenta,
	in_respuesta   VARCHAR (255)
	)
GO

IF OBJECT_ID ('dbo.cr_inf_financiera') IS NOT NULL
	DROP TABLE dbo.cr_inf_financiera
GO

CREATE TABLE dbo.cr_inf_financiera
	(
	if_codigo       INT NOT NULL,
	if_nivel1       VARCHAR (16) NOT NULL,
	if_nivel2       VARCHAR (16),
	if_nivel3       VARCHAR (16),
	if_nivel4       VARCHAR (16),
	if_sumatoria    CHAR (1),
	if_microempresa INT NOT NULL,
	if_tramite      INT NOT NULL,
	if_total        MONEY,
	if_descripcion  descripcion,
	if_nivel        TINYINT,
	if_actualizado  CHAR (1) DEFAULT ('N') NOT NULL
	)
GO

CREATE CLUSTERED INDEX cr_inf_finan_1
	ON dbo.cr_inf_financiera (if_tramite, if_microempresa)
	WITH (FILLFACTOR = 75)
GO

CREATE UNIQUE INDEX cr_inf_financiera_ind
	ON dbo.cr_inf_financiera (if_codigo, if_microempresa, if_tramite)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX cr_inf_finan_2
	ON dbo.cr_inf_financiera (if_microempresa)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_impresion_cartas') IS NOT NULL
	DROP TABLE dbo.cr_impresion_cartas
GO

CREATE TABLE dbo.cr_impresion_cartas
	(
	ic_no_operacion   cuenta,
	ic_nombre_cliente descripcion,
	ic_zona           INT,
	ic_oficina        INT,
	ic_carta          VARCHAR (3),
	ic_reimpresiones  INT,
	ic_saldo_vencido  MONEY,
	ic_saldo_capital  MONEY,
	ic_saldo_total    MONEY,
	ic_altura_mora    INT
	)
GO

IF OBJECT_ID ('dbo.cr_imp_documento') IS NOT NULL
	DROP TABLE dbo.cr_imp_documento
GO

CREATE TABLE dbo.cr_imp_documento
	(
	id_documento    SMALLINT 	NOT NULL,
	id_toperacion   catalogo 	NOT NULL,
	id_producto     catalogo 	NOT NULL,
	id_moneda       TINYINT  	NULL,
	id_descripcion  descripcion NOT NULL,
	id_mnemonico    catalogo 	NOT NULL,
	id_tipo_tramite CHAR (4) 	NULL,
	id_template     descripcion NULL,
	id_estado       CHAR (4) 	NULL,
	id_dato         VARCHAR(64) NULL,
	id_medio        CHAR (4) 	NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_imp_documento_Key
	ON dbo.cr_imp_documento (id_documento, id_toperacion)
GO

IF OBJECT_ID ('dbo.cr_hono_mora') IS NOT NULL
	DROP TABLE dbo.cr_hono_mora
GO

CREATE TABLE dbo.cr_hono_mora
	(
	hm_codigo          INT,
	hm_estado_cobranza catalogo,
	hm_dia_inicial     SMALLINT,
	hm_dia_final       SMALLINT,
	hm_anio_castigo    SMALLINT,
	hm_tasa_cobrar     FLOAT,
	hm_tarifa_unica    MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_hono_mora_Key
	ON dbo.cr_hono_mora (hm_codigo, hm_estado_cobranza)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cr_hono_abogado') IS NOT NULL
	DROP TABLE dbo.cr_hono_abogado
GO

CREATE TABLE dbo.cr_hono_abogado
	(
	ha_id_abogado       catalogo,
	ha_codigo_honorario INT,
	ha_tasa_cobrar      FLOAT,
	ha_tarifa_unica     MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_hono_abogado_Key
	ON dbo.cr_hono_abogado (ha_id_abogado, ha_codigo_honorario)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cr_historial_situacion') IS NOT NULL
	DROP TABLE dbo.cr_historial_situacion
GO

CREATE TABLE dbo.cr_historial_situacion
	(
	hs_cliente   INT NOT NULL,
	hs_situacion catalogo,
	hs_causal    catalogo,
	hs_fecha     DATETIME,
	hs_user      login
	)
GO

CREATE INDEX cr_historial_situacion_key
	ON dbo.cr_historial_situacion (hs_cliente, hs_situacion)
GO

IF OBJECT_ID ('dbo.cr_hist_credito') IS NOT NULL
	DROP TABLE dbo.cr_hist_credito
GO

CREATE TABLE dbo.cr_hist_credito
	(
	ho_ente           INT,
	ho_historia       INT NOT NULL,
	ho_toperacion     catalogo,
	ho_producto       catalogo,
	ho_monto          MONEY,
	ho_moneda         TINYINT,
	ho_periodo        catalogo,
	ho_num_periodos   SMALLINT,
	ho_num_tra        INT NOT NULL,
	ho_num_ope        cuenta,
	ho_estado         CHAR (1) NOT NULL,
	ho_fecha_aprob    DATETIME,
	ho_fecha_liq      DATETIME,
	ho_fecha_venc     DATETIME,
	ho_observaciones  VARCHAR (255),
	ho_comportamiento catalogo,
	ho_tipo_tram      CHAR (1),
	ho_admisible      MONEY,
	ho_noadmis        MONEY,
	ho_grupo          INT,
	ho_comite         catalogo,
	ho_acta           cuenta,
	ho_func_aprob     login,
	ho_tasa           FLOAT,
	ho_tperiodicidad  INT,
	ho_tmodalidad     descripcion,
	ho_comision       FLOAT,
	ho_cperiodicidad  INT,
	ho_cmodalidad     descripcion,
	ho_linea          cuenta,
	ho_proposito      catalogo,
	ho_razon          catalogo,
	ho_efecto         catalogo,
	ho_txt_razon      VARCHAR (255)
	)
GO

CREATE INDEX cr_hist_credito_AKey1
	ON dbo.cr_hist_credito (ho_ente, ho_historia)
GO

CREATE INDEX cr_hist_credito_AKey2
	ON dbo.cr_hist_credito (ho_grupo, ho_historia)
GO

CREATE INDEX cr_hist_credito_AKey3
	ON dbo.cr_hist_credito (ho_num_tra)
GO

CREATE UNIQUE INDEX cr_hist_credito_Key
	ON dbo.cr_hist_credito (ho_historia)
GO

IF OBJECT_ID ('dbo.cr_his_calif') IS NOT NULL
	DROP TABLE dbo.cr_his_calif
GO

CREATE TABLE dbo.cr_his_calif
	(
	hc_ente         INT NOT NULL,
	hc_historia     SMALLINT NOT NULL,
	hc_calificacion catalogo NOT NULL,
	hc_fecha_sug    DATETIME,
	hc_usuario_sug  login,
	hc_fecha_conf   DATETIME,
	hc_usuario_conf login,
	hc_fecha_cambio DATETIME NOT NULL,
	hc_comentario   VARCHAR (255)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_his_calif_Key
	ON dbo.cr_his_calif (hc_ente, hc_historia)
GO

IF OBJECT_ID ('dbo.cr_gracia_normalizaciones') IS NOT NULL
	DROP TABLE dbo.cr_gracia_normalizaciones
GO

CREATE TABLE dbo.cr_gracia_normalizaciones
	(
	gn_tramite             INT,
	gn_periodos_gracia_cap INT,
	gn_dist_gracia         CHAR (1),
	gn_tipo_normalizacion  CHAR (1),
	gn_usuario_negocia     login,
	gn_usuario_acepta      login,
	gn_fecha_negocio       DATETIME,
	gn_fecha_acepta        DATETIME,
	gn_gracia_aceptada     CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_gestion_cobro') IS NOT NULL
	DROP TABLE dbo.cr_gestion_cobro
GO

CREATE TABLE dbo.cr_gestion_cobro
	(
	gc_secuencial  INT NOT NULL,
	gc_cedula      VARCHAR (30) NOT NULL,
	gc_nombre      descripcion,
	gc_op_banco    VARCHAR (24),
	gc_tipo        CHAR (1),
	gc_tipo_cobro  VARCHAR (10),
	gc_contacto    VARCHAR (10),
	gc_carta       VARCHAR (10),
	gc_observacion VARCHAR (10),
	gc_comentario  descripcion,
	gc_fecha_ges   DATETIME,
	gc_hora_ges    VARCHAR (5),
	gc_monto_pago  MONEY,
	gc_fecha_comp  DATETIME,
	gc_impresion   SMALLINT,
	gc_tipo_gestor catalogo,
	gc_id_gestor   VARCHAR (32)
	)
GO

CREATE UNIQUE INDEX cr_gestion_cobro_key
	ON dbo.cr_gestion_cobro (gc_secuencial, gc_op_banco)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX idx2
	ON dbo.cr_gestion_cobro (gc_op_banco)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_gestion_campana') IS NOT NULL
	DROP TABLE dbo.cr_gestion_campana
GO

CREATE TABLE dbo.cr_gestion_campana
	(
	gc_campana           INT NOT NULL,
	gc_cliente           INT NOT NULL,
	gc_fecha_campana     DATETIME NOT NULL,
	gc_secuencial        INT NOT NULL,
	gc_gestor            login NOT NULL,
	gc_forma_gestion     catalogo NOT NULL,
	gc_logro_contacto    CHAR (1) NOT NULL,
	gc_contacto_con      catalogo,
	gc_causa_no_contacto catalogo,
	gc_resp_favorable    CHAR (1),
	gc_causa_rechazo     catalogo,
	gc_cerrar_gestion    CHAR (1) NOT NULL,
	gc_causa_cierre      catalogo,
	gc_comentario        VARCHAR (254),
	gc_fecha_gestion     DATETIME NOT NULL,
	gc_hora_gestion      VARCHAR (5) NOT NULL,
	gc_user              login NOT NULL,
	gc_hora_real         DATETIME NOT NULL
	)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cr_gestion_campana (gc_cliente, gc_campana, gc_fecha_campana, gc_secuencial)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_gestion_campana (gc_campana, gc_fecha_campana, gc_secuencial)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx3
	ON dbo.cr_gestion_campana (gc_gestor)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx4
	ON dbo.cr_gestion_campana (gc_fecha_gestion)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_garantias_gp') IS NOT NULL
	DROP TABLE dbo.cr_garantias_gp
GO

CREATE TABLE dbo.cr_garantias_gp
	(
	tramite       INT NOT NULL,
	garantia      VARCHAR (64) NOT NULL,
	clasificacion CHAR (1),
	exceso        CHAR (1),
	monto         MONEY,
	clase         CHAR (1) NOT NULL,
	estado        CHAR (1) NOT NULL,
	avaluador     CHAR (64),
	propietario   CHAR (64),
	porcentaje    FLOAT,
	valor_resp    MONEY,
	sesion        INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_garantia_gp') IS NOT NULL
	DROP TABLE dbo.cr_garantia_gp
GO

CREATE TABLE dbo.cr_garantia_gp
	(
	estado      catalogo,
	credito     catalogo,
	clase       CHAR (1),
	numero      VARCHAR (64) NOT NULL,
	descrip     VARCHAR (64),
	cliente     VARCHAR (64),
	moneda      TINYINT,
	inicial     MONEY,
	actual      MONEY,
	cobertura   FLOAT,
	margen      MONEY,
	fecha       VARCHAR (10),
	avaluador   VARCHAR (64),
	propietario VARCHAR (64),
	sesion      INT NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_gar_propuesta') IS NOT NULL
	DROP TABLE dbo.cr_gar_propuesta
GO

CREATE TABLE dbo.cr_gar_propuesta
	(
	gp_tramite             INT NOT NULL,
	gp_garantia            VARCHAR (64) NOT NULL,
	gp_clasificacion       CHAR (1),
	gp_exceso              CHAR (1),
	gp_monto_exceso        MONEY,
	gp_abierta             CHAR (1) NOT NULL,
	gp_deudor              INT NOT NULL,
	gp_est_garantia        CHAR (1) NOT NULL,
	gp_porcentaje          FLOAT,
	gp_valor_resp_garantia MONEY,
	gp_fecha_mod           DATETIME NOT NULL,
	gp_proceso             CHAR (1),
	gp_procesado           VARCHAR (1),
	gp_previa              VARCHAR (1) DEFAULT ('A')
	)
GO

CREATE UNIQUE INDEX cr_gar_propuesta_Key
	ON dbo.cr_gar_propuesta (gp_tramite, gp_garantia)
GO

CREATE INDEX i_cr_gar_propuesta_i2
	ON dbo.cr_gar_propuesta (gp_garantia)
GO

CREATE INDEX i_cr_gar_propuesta_i3
	ON dbo.cr_gar_propuesta (gp_deudor)
GO

IF OBJECT_ID ('dbo.cr_gar_anteriores') IS NOT NULL
	DROP TABLE dbo.cr_gar_anteriores
GO

CREATE TABLE dbo.cr_gar_anteriores
	(
	ga_tramite             INT NOT NULL,
	ga_gar_anterior        VARCHAR (64),
	ga_gar_nueva           VARCHAR (64),
	ga_operacion           cuenta,
	ga_porcentaje          FLOAT,
	ga_valor_resp_garantia MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_gar_anteriores_Key
	ON dbo.cr_gar_anteriores (ga_tramite, ga_gar_nueva, ga_operacion)
GO

IF OBJECT_ID ('dbo.cr_fuente_recurso_his') IS NOT NULL
	DROP TABLE dbo.cr_fuente_recurso_his
GO

CREATE TABLE dbo.cr_fuente_recurso_his
	(
	fr_fecha               DATETIME,
	fr_codigo_fuente       INT NOT NULL,
	fr_fuente              VARCHAR (10) NOT NULL,
	fr_monto               MONEY NOT NULL,
	fr_saldo               MONEY NOT NULL,
	fr_utilizado           MONEY NOT NULL,
	fr_estado              VARCHAR (10) NOT NULL,
	fr_tipo_fuente         CHAR (1),
	fr_porcentaje          FLOAT,
	fr_porcentaje_otorgado FLOAT,
	fr_reservado           MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_fuente_recurso_his (fr_fecha, fr_fuente)
GO

IF OBJECT_ID ('dbo.cr_fuente_recurso') IS NOT NULL
	DROP TABLE dbo.cr_fuente_recurso
GO

CREATE TABLE dbo.cr_fuente_recurso
	(
	fr_codigo_fuente       INT NOT NULL,
	fr_fuente              VARCHAR (10) NOT NULL,
	fr_monto               MONEY NOT NULL,
	fr_saldo               MONEY NOT NULL,
	fr_utilizado           MONEY NOT NULL,
	fr_estado              VARCHAR (10) NOT NULL,
	fr_tipo_fuente         CHAR (1),
	fr_porcentaje          FLOAT,
	fr_porcentaje_otorgado FLOAT,
	fr_reservado           MONEY
	)
GO

IF OBJECT_ID ('dbo.cr_formato_sib') IS NOT NULL
	DROP TABLE dbo.cr_formato_sib
GO

CREATE TABLE dbo.cr_formato_sib
	(
	fo_clase             TINYINT,
	fo_calificacion      CHAR (1),
	fo_pcalficacion_e    INT,
	fo_banco             cuenta,
	fo_producto          TINYINT,
	fo_cliente_cobis     INT,
	fo_tipo_id           numero,
	fo_nit               numero,
	fo_digito            numero,
	fo_nombre            descripcion,
	fo_oficina           SMALLINT,
	fo_linea             cuenta,
	fo_tcliente          catalogo,
	fo_tvinculacion      descripcion,
	fo_fecha_desembolso  DATETIME,
	fo_fecha_vencimiento DATETIME,
	fo_plazo             FLOAT,
	fo_per_cap           CHAR (1),
	fo_mod_pag_cap       CHAR (1),
	fo_per_int           CHAR (1),
	fo_mod_pag_int       CHAR (1),
	fo_ttasa             catalogo,
	fo_base              catalogo,
	fo_spread            FLOAT,
	fo_tasa_cte          FLOAT,
	fo_tasa_mora         FLOAT,
	fo_monto_des         MONEY,
	fo_saldo_cap         MONEY,
	fo_fecha_ult_pag_cap DATETIME,
	fo_fecha_ult_pag_int DATETIME,
	fo_fecha_ini_mora    DATETIME,
	fo_dias_mora         SMALLINT,
	fo_prov_cap          MONEY,
	fo_saldo_int         MONEY,
	fo_saldo_int_cau     MONEY,
	fo_saldo_corr_mon    MONEY,
	fo_saldo_int_mora    MONEY,
	fo_saldo_int_mora_m  MONEY,
	fo_int_capitalizado  catalogo,
	fo_castigado         catalogo,
	fo_saldo_otros       MONEY,
	fo_int_reest         MONEY,
	fo_prov_int          MONEY,
	fo_prov_otros        MONEY,
	fo_int_sus           MONEY,
	fo_cupo              cuenta,
	fo_tipo_gar          TINYINT,
	fo_val_gar_hip       MONEY,
	fo_proc_cub_hip      FLOAT,
	fo_val_cub_hip       MONEY,
	fo_val_gar_pre       MONEY,
	fo_proc_cub_pre      FLOAT,
	fo_val_cub_pre       MONEY,
	fo_val_gar_otr       MONEY,
	fo_proc_cub_otr      FLOAT,
	fo_val_cub_otr       MONEY,
	fo_valor_avaluo      MONEY,
	fo_fecha_avaluo      DATETIME,
	fo_fecha_ven_gar     DATETIME,
	fo_inf_gar           catalogo,
	fo_nun_suspen        catalogo,
	fo_reestruturada     catalogo,
	fo_num_reest         TINYINT,
	fo_reest_ley         catalogo,
	fo_reest_ext         catalogo,
	fo_concordato        catalogo,
	fo_ciiu              catalogo,
	fo_estado            catalogo,
	fo_nom_oficina       descripcion,
	fo_num_garantia      VARCHAR (128),
	fo_moneda            TINYINT,
	fo_clase_gar         catalogo,
	fo_estado_contable   catalogo,
	fo_val_gar           MONEY,
	fo_saldo_cap_ant     MONEY,
	fo_saldo_int_ant     MONEY,
	fo_saldo_otr_ant     MONEY,
	fo_prov_cap_ant      MONEY,
	fo_prov_int_ant      MONEY,
	fo_prov_otr_ant      MONEY,
	fo_califica_ant      CHAR (1),
	fo_especial          CHAR (1),
	fo_gar_prov          MONEY,
	fo_fecha_reest       DATETIME,
	fo_operacion         INT,
	fo_tramite           INT,
	fo_reestructuracion  CHAR (1),
	fo_fpago             CHAR (1),
	fo_tipo_id_N         numero,
	fo_iden              numero,
	fo_gar_est_deu       CHAR (1),
	fo_situacion         catalogo,
	fo_dc_digito         CHAR (1),
	fo_linea_credito     cuenta,
	fo_estado_op         catalogo,
	fo_int_mas_mora      MONEY,
	fo_saldo_men_sus     MONEY,
	fo_cap_diferido      MONEY,
	fo_int_imo_diferido  MONEY,
	fo_treest            TINYINT,
	fo_caja              TINYINT,
	fo_prov_cap_caja     MONEY,
	fo_prov_int_caja     MONEY,
	fo_prov_otr_caja     MONEY,
	fo_estado_obl        TINYINT
	)
GO

IF OBJECT_ID ('dbo.cr_formato_rfm') IS NOT NULL
	DROP TABLE dbo.cr_formato_rfm
GO

CREATE TABLE dbo.cr_formato_rfm
	(
	fo_clase          TINYINT,
	fo_nit            numero,
	fo_banco          cuenta,
	fo_nombre         descripcion,
	fo_fecha          VARCHAR (8),
	fo_monto_des      CHAR (15),
	fo_modalidad      VARCHAR (1),
	fo_saldo_cap      CHAR (15),
	fo_saldo_cap_corr CHAR (15),
	fo_saldo_int      CHAR (15),
	fo_saldo_otros    CHAR (15),
	fo_saldo          CHAR (15),
	fo_clase_gar      catalogo,
	fo_especial       CHAR (15),
	fo_val_gar        CHAR (15),
	fo_gar_prov       CHAR (15),
	fo_int_sus        CHAR (15),
	fo_prov_cap       CHAR (15),
	fo_prov_cap_corr  CHAR (15),
	fo_prov_int       CHAR (15),
	fo_prov_otros     CHAR (15),
	fo_prov           CHAR (15),
	fo_calificacion   CHAR (1),
	fo_fecha_ini_mora VARCHAR (8),
	fo_dias_mora      SMALLINT,
	fo_estado         VARCHAR (1),
	fo_terr           VARCHAR (1),
	fo_treest         TINYINT,
	fo_caja           TINYINT,
	fo_prov_cap_caja  CHAR (15),
	fo_prov_int_caja  CHAR (15),
	fo_prov_otr_caja  CHAR (15),
	fo_estado_obl     TINYINT,
	fo_producto       TINYINT,
	fo_linea_credito  cuenta
	)
GO

CREATE INDEX cr_formato_rfm_key
	ON dbo.cr_formato_rfm (fo_banco)
GO

IF OBJECT_ID ('dbo.cr_formato_rf') IS NOT NULL
	DROP TABLE dbo.cr_formato_rf
GO

CREATE TABLE dbo.cr_formato_rf
	(
	fo_clase          TINYINT,
	fo_nit            numero,
	fo_banco          cuenta,
	fo_nombre         descripcion,
	fo_fecha          VARCHAR (8),
	fo_monto_des      CHAR (15),
	fo_modalidad      VARCHAR (1),
	fo_saldo_cap      CHAR (15),
	fo_saldo_cap_corr CHAR (15),
	fo_saldo_int      CHAR (15),
	fo_saldo_otros    CHAR (15),
	fo_saldo          CHAR (15),
	fo_clase_gar      catalogo,
	fo_especial       CHAR (15),
	fo_val_gar        CHAR (15),
	fo_gar_prov       CHAR (15),
	fo_int_sus        CHAR (15),
	fo_prov_cap       CHAR (15),
	fo_prov_cap_corr  CHAR (15),
	fo_prov_int       CHAR (15),
	fo_prov_otros     CHAR (15),
	fo_prov           CHAR (15),
	fo_calificacion   CHAR (1),
	fo_fecha_ini_mora VARCHAR (8),
	fo_dias_mora      SMALLINT,
	fo_estado         VARCHAR (1),
	fo_terr           VARCHAR (1),
	fo_treest         TINYINT,
	fo_caja           TINYINT,
	fo_prov_cap_caja  CHAR (15),
	fo_prov_int_caja  CHAR (15),
	fo_prov_otr_caja  CHAR (15),
	fo_estado_obl     TINYINT,
	fo_producto       TINYINT,
	fo_linea_credito  cuenta
	)
GO

CREATE INDEX cr_formato_rf_key
	ON dbo.cr_formato_rf (fo_banco)
GO

IF OBJECT_ID ('dbo.cr_formato_rem') IS NOT NULL
	DROP TABLE dbo.cr_formato_rem
GO

CREATE TABLE dbo.cr_formato_rem
	(
	fo_clase             TINYINT,
	fo_banco             cuenta,
	fo_fecha             VARCHAR (8),
	fo_calificacion_ant  VARCHAR (1),
	fo_calificacion      CHAR (1),
	fo_per_cap           CHAR (1),
	fo_fecha_ult_pag_cap VARCHAR (10),
	fo_saldo_cap_ant     CHAR (15),
	fo_saldo_int_ant     CHAR (15),
	fo_saldo_otr_ant     CHAR (15),
	fo_prov_cap_ant      CHAR (15),
	fo_prov_int_ant      CHAR (15),
	fo_prov_otr_ant      CHAR (15)
	)
GO

IF OBJECT_ID ('dbo.cr_formato_re') IS NOT NULL
	DROP TABLE dbo.cr_formato_re
GO

CREATE TABLE dbo.cr_formato_re
	(
	fo_clase             TINYINT,
	fo_banco             cuenta,
	fo_fecha             VARCHAR (8),
	fo_calificacion_ant  VARCHAR (1),
	fo_calificacion      CHAR (1),
	fo_per_cap           CHAR (1),
	fo_fecha_ult_pag_cap VARCHAR (10),
	fo_saldo_cap_ant     CHAR (15),
	fo_saldo_int_ant     CHAR (15),
	fo_saldo_otr_ant     CHAR (15),
	fo_prov_cap_ant      CHAR (15),
	fo_prov_int_ant      CHAR (15),
	fo_prov_otr_ant      CHAR (15)
	)
GO

IF OBJECT_ID ('dbo.cr_formato_com') IS NOT NULL
	DROP TABLE dbo.cr_formato_com
GO

CREATE TABLE dbo.cr_formato_com
	(
	fo_clase TINYINT,
	fo_banco cuenta,
	fo_nit   cuenta
	)
GO

IF OBJECT_ID ('dbo.cr_formato_co') IS NOT NULL
	DROP TABLE dbo.cr_formato_co
GO

CREATE TABLE dbo.cr_formato_co
	(
	fo_clase TINYINT,
	fo_banco cuenta,
	fo_nit   cuenta
	)
GO

IF OBJECT_ID ('dbo.cr_fogacafe_rep') IS NOT NULL
	DROP TABLE dbo.cr_fogacafe_rep
GO

CREATE TABLE dbo.cr_fogacafe_rep
	(
	fr_regional_des      VARCHAR (40),
	fr_regional          VARCHAR (40),
	fr_oficina_des       VARCHAR (40),
	fr_oficina           SMALLINT,
	fr_pagare_cobis      VARCHAR (40),
	fr_pagare_otrosi     VARCHAR (40),
	fr_pagare_doc        VARCHAR (40),
	fr_banco             VARCHAR (40),
	fr_nombre            VARCHAR (80),
	fr_tipo              catalogo,
	fr_identificacion    VARCHAR (40),
	fr_actividad         catalogo,
	fr_monto             MONEY,
	fr_plazo             SMALLINT,
	fr_gracia_cap        SMALLINT,
	fr_periodo_cap       SMALLINT,
	fr_fecha_liq         VARCHAR (10),
	fr_porcentaje        FLOAT,
	fr_fogacafe          catalogo,
	fr_tasa_comis        FLOAT,
	fr_valor_comis       MONEY,
	fr_val_iva_comis     MONEY,
	fr_total_iva         MONEY,
	fr_cuenta            VARCHAR (30) NOT NULL,
	fr_llave_redescuento VARCHAR (40),
	fr_fecha_ven         VARCHAR (10),
	fr_tasa_int          MONEY,
	fr_saldo             MONEY,
	fr_fecha_mora        VARCHAR (10),
	fr_dias_mora         INT,
	fr_fecha_demanda     VARCHAR (10),
	fr_destino           catalogo
	)
GO

IF OBJECT_ID ('dbo.cr_fng2_tmp') IS NOT NULL
	DROP TABLE dbo.cr_fng2_tmp
GO

CREATE TABLE dbo.cr_fng2_tmp
	(
	ref_archi           CHAR (10),
	nit_inter           VARCHAR (20),
	num_garantia        VARCHAR (20),
	en_ced_ruc          VARCHAR (16),
	ref_credito         VARCHAR (18),
	cod_moneda          VARCHAR (3),
	clif_robli          CHAR (2),
	cam_reser           CHAR (1),
	sal_fec_corte_infor NUMERIC (12),
	sal_total_obli      NUMERIC (12),
	fecha_corte         CHAR (8),
	num_cuotas_mora     INT,
	fec_inicio_mora     CHAR (8),
	fec_cancelacion     CHAR (8)
	)
GO

IF OBJECT_ID ('dbo.cr_fng1_tmp') IS NOT NULL
	DROP TABLE dbo.cr_fng1_tmp
GO

CREATE TABLE dbo.cr_fng1_tmp
	(
	ref_archi         VARCHAR (10),
	nit_inter         VARCHAR (20),
	cod_sucur         VARCHAR (10),
	nomlar            VARCHAR (40),
	tipo_id           VARCHAR (4),
	num_id            VARCHAR (16),
	fec_nac           VARCHAR (8),
	gen_deudor        VARCHAR (1),
	est_ci_deudor     VARCHAR (2),
	nivel_estu        VARCHAR (1),
	dir_deudor        VARCHAR (60),
	tipo_id_rl        VARCHAR (3),
	id_rl             CHAR (1),
	nomlar_rl         VARCHAR (40),
	munic_deudor      VARCHAR (5),
	tel1_deudor       VARCHAR (16),
	tel2_deudor       VARCHAR (16),
	fax_deudor        VARCHAR (16),
	email_deudor      VARCHAR (30),
	ciiu              CHAR (4),
	acti_total        VARCHAR (15),
	pasi_total        NUMERIC (12),
	ing_deudor        NUMERIC (12),
	egr_deudor        NUMERIC (12),
	cam_r1            VARCHAR (1),
	cam_r2            VARCHAR (1),
	ref_credito       VARCHAR (18),
	num_pagare        VARCHAR (18),
	cod_moneda        VARCHAR (3),
	valor_monto       NUMERIC (11),
	num_cup_rot       CHAR (1),
	cam_r3            VARCHAR (1),
	cam_r4            VARCHAR (1),
	fec_desem         VARCHAR (8),
	cod_plazo_o       TINYINT,
	plazo             TINYINT,
	cod_tasa_index    VARCHAR (3),
	signo_puntos      VARCHAR (1),
	puntos_tasa       NUMERIC (5, 2),
	cod_perio_tasa    VARCHAR (2),
	mod_tasa          VARCHAR (1),
	per_amorti        VARCHAR (3),
	calif_r_obli      VARCHAR (2),
	cam_r5            VARCHAR (1),
	per_gra_capi      VARCHAR (3),
	tipo_car          VARCHAR (2),
	desti_credito     VARCHAR (3),
	tipo_recur        VARCHAR (1),
	val_redes         CHAR (1),
	porc_redes        CHAR (1),
	nit_enti_redes    CHAR (1),
	cam_r6            VARCHAR (1),
	cam_r7            VARCHAR (1),
	cam_r8            VARCHAR (1),
	cam_r9            VARCHAR (1),
	val_gar_rea_af    NUMERIC (12),
	fec_val_gar_af    VARCHAR (8),
	desc_gar_af       VARCHAR (60),
	desc_ogar_af      VARCHAR (60),
	cod_prod_gar      VARCHAR (6),
	num_gar_fng       VARCHAR (10),
	porc_cober        FLOAT,
	per_cobr_comi     VARCHAR (2),
	nit_ecap          CHAR (1),
	razsoci_ecap      VARCHAR (40),
	cod_mun_ecap      CHAR (1),
	dir_domi_ecap     VARCHAR (60),
	tipo_id_rl_ecamp  VARCHAR (3),
	id_rl_ecamp       CHAR (1),
	nomlar_rl_ecamp   VARCHAR (40),
	cap_susypag_antes CHAR (1),
	cap_susypag       CHAR (1),
	fec_cap           VARCHAR (8),
	val_aval_inmu     CHAR (1),
	dir_inmu          VARCHAR (60),
	matri_inmu        VARCHAR (18),
	cod_muni_inmu     CHAR (1),
	val_subsidio      CHAR (1),
	estrato           VARCHAR (2),
	tipo_vivienda     CHAR (1),
	porc_finan_vivi   VARCHAR (2),
	cam_r10           VARCHAR (1),
	cam_r11           VARCHAR (1),
	val_finan         CHAR (1),
	cam_r12           VARCHAR (1),
	canon             CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_fng_masivo') IS NOT NULL
	DROP TABLE dbo.cr_fng_masivo
GO

CREATE TABLE dbo.cr_fng_masivo
	(
	fm_fecha             VARCHAR (10) NOT NULL,
	fm_nit_inter         VARCHAR (10) NOT NULL,
	fm_cod_sucur         VARCHAR (9) NOT NULL,
	fm_nomlar            VARCHAR (40) NOT NULL,
	fm_tipo_id           VARCHAR (3) NOT NULL,
	fm_num_id            VARCHAR (16) NOT NULL,
	fm_munic_deudor      VARCHAR (5),
	fm_valor_monto       NUMERIC (9) NOT NULL,
	fm_cod_moneda        VARCHAR (3) NOT NULL,
	fm_desti_credito     VARCHAR (3),
	fm_cod_prod_gar      VARCHAR (6) NOT NULL,
	fm_porcentaje        VARCHAR (6),
	fm_tramite           INT NOT NULL,
	fm_cod_externo       VARCHAR (64) NOT NULL,
	fm_procesado         CHAR (1),
	fm_num_reserva       INT,
	fm_cod_ciiu          catalogo,
	fm_total_activos     MONEY,
	fm_modalidad_cartera VARCHAR (1),
	fm_calif_riesgo      VARCHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_fin_tplan_tmp') IS NOT NULL
	DROP TABLE dbo.cr_fin_tplan_tmp
GO

CREATE TABLE dbo.cr_fin_tplan_tmp
	(
	conexion INT NOT NULL,
	dias     INT NOT NULL,
	contador INT NOT NULL
	)
GO

CREATE INDEX cr_fin_tplan_tmp_k1
	ON dbo.cr_fin_tplan_tmp (conexion)
GO

IF OBJECT_ID ('dbo.cr_filtros') IS NOT NULL
	DROP TABLE dbo.cr_filtros
GO

CREATE TABLE dbo.cr_filtros
	(
	fi_filtro       INT,
	fi_descripcion  VARCHAR (64),
	fi_tipo_persona catalogo,
	fi_etapa        INT
	)
GO

IF OBJECT_ID ('dbo.cr_filtro_tipo_cliente') IS NOT NULL
	DROP TABLE dbo.cr_filtro_tipo_cliente
GO

CREATE TABLE dbo.cr_filtro_tipo_cliente
	(
	ft_filtro       INT,
	ft_tipo_cliente VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cr_ficha') IS NOT NULL
	DROP TABLE dbo.cr_ficha
GO

CREATE TABLE dbo.cr_ficha
	(
	fi_tipo       CHAR (1) NOT NULL,
	fi_cliente    INT NOT NULL,
	fi_secuencial INT NOT NULL,
	fi_fecha_crea DATETIME NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_ficha_Key
	ON dbo.cr_ficha (fi_tipo, fi_cliente, fi_secuencial)
GO

IF OBJECT_ID ('dbo.cr_facturas') IS NOT NULL
	DROP TABLE dbo.cr_facturas
GO

CREATE TABLE dbo.cr_facturas
	(
	fa_tramite     INT NOT NULL,
	fa_grupo       INT NOT NULL,
	fa_valor       MONEY NOT NULL,
	fa_moneda      TINYINT NOT NULL,
	fa_fecini_neg  DATETIME NOT NULL,
	fa_fecfin_neg  DATETIME NOT NULL,
	fa_usada       CHAR (1) NOT NULL,
	fa_dividendo   SMALLINT,
	fa_referencia  VARCHAR (16) NOT NULL,
	fa_porcentaje  MONEY NOT NULL,
	fa_num_negocio VARCHAR (64) NOT NULL,
	fa_proveedor   INT NOT NULL,
	fa_fecha_bl    DATETIME,
	fa_fecha_dex   DATETIME,
	fa_con_respon  CHAR (1),
	fa_tram_prov   INT,
	fa_div_hijo    SMALLINT,
	fa_colchon_re  MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_facturas_Key
	ON dbo.cr_facturas (fa_tramite, fa_grupo, fa_referencia, fa_num_negocio)
GO

IF OBJECT_ID ('dbo.cr_excepciones') IS NOT NULL
	DROP TABLE dbo.cr_excepciones
GO

CREATE TABLE dbo.cr_excepciones
	(
	ex_tramite      INT NOT NULL,
	ex_numero       TINYINT NOT NULL,
	ex_codigo       catalogo NOT NULL,
	ex_clase        CHAR (1),
	ex_texto        VARCHAR (255) NOT NULL,
	ex_estado       CHAR (1) NOT NULL,
	ex_fecha_aprob  DATETIME,
	ex_login_aprob  login,
	ex_fecha_tope   DATETIME,
	ex_fecha_regula DATETIME,
	ex_login_regula login,
	ex_razon_regula VARCHAR (255),
	ex_fecha_reg    DATETIME NOT NULL,
	ex_login_reg    login NOT NULL,
	ex_garantia     VARCHAR (64),
	ex_aprob_por    login,
	ex_accion       CHAR (1),
	ex_comite       catalogo,
	ex_acta         cuenta
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_excepciones_Key
	ON dbo.cr_excepciones (ex_tramite, ex_numero)
GO

CREATE INDEX cr_excepcion_AKey
	ON dbo.cr_excepciones (ex_fecha_aprob, ex_clase)
GO

IF OBJECT_ID ('dbo.cr_etapa_estacion') IS NOT NULL
	DROP TABLE dbo.cr_etapa_estacion
GO

CREATE TABLE dbo.cr_etapa_estacion
	(
	ee_estacion     SMALLINT NOT NULL,
	ee_etapa        TINYINT NOT NULL,
	ee_modifica     CHAR (1),
	ee_estado       CHAR (1),
	ee_estacion_sus SMALLINT,
	ee_ejecutivo    CHAR (1),
	ee_fabrica      CHAR (1),
	ee_master       SMALLINT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_etapa_estacion_Key
	ON dbo.cr_etapa_estacion (ee_estacion, ee_etapa)
GO

CREATE INDEX cr_etapa_estacion_AKey
	ON dbo.cr_etapa_estacion (ee_etapa)
GO

IF OBJECT_ID ('dbo.cr_etapa') IS NOT NULL
	DROP TABLE dbo.cr_etapa
GO

CREATE TABLE dbo.cr_etapa
	(
	et_etapa       TINYINT NOT NULL,
	et_descripcion descripcion NOT NULL,
	et_tipo        CHAR (1) NOT NULL,
	et_asignacion  VARCHAR (40),
	et_tipo_asig   CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_etapa_Key
	ON dbo.cr_etapa (et_etapa)
GO

IF OBJECT_ID ('dbo.cr_estados_concordato') IS NOT NULL
	DROP TABLE dbo.cr_estados_concordato
GO

CREATE TABLE dbo.cr_estados_concordato
	(
	ec_cliente    INT NOT NULL,
	ec_secuencial INT NOT NULL,
	ec_estado     catalogo NOT NULL,
	ec_fecha      DATETIME NOT NULL,
	ec_fecha_fin  DATETIME,
	ec_usuario    login NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_estados_concordato_Key
	ON dbo.cr_estados_concordato (ec_cliente, ec_secuencial)
GO

IF OBJECT_ID ('dbo.cr_estacion') IS NOT NULL
	DROP TABLE dbo.cr_estacion
GO

CREATE TABLE dbo.cr_estacion
	(
	es_estacion     SMALLINT NOT NULL,
	es_descripcion  descripcion,
	es_oficina      SMALLINT NOT NULL,
	es_usuario      login,
	es_nivel        catalogo,
	es_carga        TINYINT,
	es_tipo         CHAR (1),
	es_comite       VARCHAR (10),
	es_estacion_sup SMALLINT,
	es_tope         CHAR (1),
	es_ema          CHAR (1),
	es_master       SMALLINT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_estacion_Key
	ON dbo.cr_estacion (es_estacion)
GO

CREATE INDEX cr_estacion_K1
	ON dbo.cr_estacion (es_oficina)
GO

CREATE INDEX cr_estacion_K2
	ON dbo.cr_estacion (es_usuario)
GO

IF OBJECT_ID ('dbo.cr_especifica_tramites') IS NOT NULL
	DROP TABLE dbo.cr_especifica_tramites
GO

CREATE TABLE dbo.cr_especifica_tramites
	(
	et_tramite   INT NOT NULL,
	et_sujeto    catalogo NOT NULL,
	et_codigo    catalogo NOT NULL,
	et_tipo_dato catalogo NOT NULL,
	et_valor     VARCHAR (255) NOT NULL,
	et_desc_est  descripcion
	)
GO

CREATE UNIQUE INDEX cr_esp_tramite_Key
	ON dbo.cr_especifica_tramites (et_tramite, et_sujeto, et_codigo)
GO

IF OBJECT_ID ('dbo.cr_errorlog') IS NOT NULL
	DROP TABLE dbo.cr_errorlog
GO

CREATE TABLE dbo.cr_errorlog
	(
	er_fecha_proc  DATETIME NOT NULL,
	er_error       INT,
	er_usuario     login,
	er_tran        INT,
	er_cuenta      cuenta,
	er_descripcion VARCHAR (255)
	)
GO

CREATE INDEX cr_errorlog_K1
	ON dbo.cr_errorlog (er_fecha_proc)
GO

IF OBJECT_ID ('dbo.cr_errores_sib') IS NOT NULL
	DROP TABLE dbo.cr_errores_sib
GO

CREATE TABLE dbo.cr_errores_sib
	(
	es_programa    VARCHAR (30) NOT NULL,
	es_descripcion VARCHAR (200),
	es_error       INT,
	es_producto    TINYINT,
	es_operacion   VARCHAR (24),
	es_fecha       DATETIME
	)
GO

CREATE INDEX cr_errores_sib_Key
	ON dbo.cr_errores_sib (es_programa)
GO

IF OBJECT_ID ('dbo.cr_enfermedades_his') IS NOT NULL
	DROP TABLE dbo.cr_enfermedades_his
GO

CREATE TABLE dbo.cr_enfermedades_his
	(
	en_microseg   INT,
	en_asegurado  INT,
	en_enfermedad VARCHAR (10)
	)
GO

IF OBJECT_ID ('dbo.cr_enfermedades') IS NOT NULL
	DROP TABLE dbo.cr_enfermedades
GO

CREATE TABLE dbo.cr_enfermedades
	(
	en_microseg   INT NOT NULL,
	en_asegurado  INT NOT NULL,
	en_enfermedad VARCHAR (10) NOT NULL
	)
GO

CREATE INDEX cr_enfermedades_key
	ON dbo.cr_enfermedades (en_microseg, en_asegurado, en_enfermedad)
GO

IF OBJECT_ID ('dbo.cr_endeudamiento') IS NOT NULL
	DROP TABLE dbo.cr_endeudamiento
GO

CREATE TABLE dbo.cr_endeudamiento
	(
	en_tramite       INT NOT NULL,
	en_op_monto      MONEY,
	en_endeudamiento MONEY,
	en_vivienda      MONEY,
	en_serpubdia     MONEY,
	en_serpubmora    MONEY,
	en_monto_clase   MONEY
	)
GO

CREATE INDEX cr_endeudamiento_K1
	ON dbo.cr_endeudamiento (en_tramite)
GO

IF OBJECT_ID ('dbo.cr_documentos_tmp') IS NOT NULL
	DROP TABLE dbo.cr_documentos_tmp
GO

CREATE TABLE dbo.cr_documentos_tmp
	(
	do_tramite     INT,
	do_grupo       INT,
	do_valor       MONEY,
	do_moneda      TINYINT,
	do_num_negocio VARCHAR (64),
	do_proveedor   INT
	)
GO

CREATE INDEX cr_documentos_tmp_Key
	ON dbo.cr_documentos_tmp (do_tramite)
GO

IF OBJECT_ID ('dbo.cr_documento') IS NOT NULL
	DROP TABLE dbo.cr_documento
GO

CREATE TABLE dbo.cr_documento
	(
	do_tramite         INT NOT NULL,
	do_documento       SMALLINT NOT NULL,
	do_numero          TINYINT NOT NULL,
	do_fecha_impresion DATETIME NOT NULL,
	do_usuario         login NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_documento_Key
	ON dbo.cr_documento (do_tramite, do_documento)
GO

IF OBJECT_ID ('dbo.cr_distribucion_desembolso') IS NOT NULL
	DROP TABLE dbo.cr_distribucion_desembolso
GO

CREATE TABLE dbo.cr_distribucion_desembolso
	(
	dd_tramite       INT NOT NULL,
	dd_toperacion    catalogo NOT NULL,
	dd_fecha_max_des DATETIME NOT NULL,
	dd_secuencial    INT,
	dd_monto         MONEY NOT NULL,
	dd_porcentaje    MONEY NOT NULL,
	dd_tplazo        catalogo NOT NULL,
	dd_plazo         SMALLINT NOT NULL,
	dd_numdes        SMALLINT NOT NULL,
	dd_estado        CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_distribucion_desembolso_Key
	ON dbo.cr_distribucion_desembolso (dd_tramite, dd_fecha_max_des)
GO

IF OBJECT_ID ('dbo.cr_disponibles_tramite') IS NOT NULL
	DROP TABLE dbo.cr_disponibles_tramite
GO

CREATE TABLE dbo.cr_disponibles_tramite
	(
	dt_tramite          INT,
	dt_fecha            DATETIME,
	dt_valor_disponible MONEY,
	dt_valido           CHAR (1),
	dt_operacion_cca    INT,
	dt_dividendo        SMALLINT
	)
GO

CREATE UNIQUE INDEX cr_disponibles_tramite_ix1
	ON dbo.cr_disponibles_tramite (dt_tramite, dt_fecha)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX cr_disponibles_tramite_ix2
	ON dbo.cr_disponibles_tramite (dt_operacion_cca, dt_dividendo)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_deudores') IS NOT NULL
	DROP TABLE dbo.cr_deudores
GO

CREATE TABLE dbo.cr_deudores
	(
	de_tramite   INT NOT NULL,
	de_cliente   INT NOT NULL,
	de_rol       VARCHAR (10) NOT NULL,
	de_ced_ruc   VARCHAR (30),
	de_segvida   CHAR (1),
	de_cobro_cen CHAR (1) CONSTRAINT default_cen DEFAULT ('N') NOT NULL
	)
GO

CREATE INDEX cr_deudores_Key
	ON dbo.cr_deudores (de_tramite, de_cliente)
GO

CREATE INDEX cr_deudores_1
	ON dbo.cr_deudores (de_cliente)
GO

IF OBJECT_ID ('dbo.cr_det_trn') IS NOT NULL
	DROP TABLE dbo.cr_det_trn
GO

CREATE TABLE dbo.cr_det_trn
	(
	dtr_secuencial   INT NOT NULL,
	dtr_operacion    INT NOT NULL,
	dtr_dividendo    INT NOT NULL,
	dtr_concepto     catalogo NOT NULL,
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
	dtr_monto_cont   MONEY NOT NULL,
	dtr_producto     TINYINT NOT NULL,
	dtr_clase_cca    CHAR (1),
	dtr_temporalidad INT
	)
GO

CREATE INDEX cr_det_trn_K1
	ON dbo.cr_det_trn (dtr_secuencial, dtr_codvalor)
GO

IF OBJECT_ID ('dbo.cr_det_inf_financiera') IS NOT NULL
	DROP TABLE dbo.cr_det_inf_financiera
GO

CREATE TABLE dbo.cr_det_inf_financiera
	(
	dif_codigo_var   INT NOT NULL,
	dif_inf_fin      INT NOT NULL,
	dif_secuencial   INT NOT NULL,
	dif_microempresa INT NOT NULL,
	dif_tipo         CHAR (1),
	dif_money        MONEY,
	dif_entero       INT,
	dif_fecha        DATETIME,
	dif_cadena       descripcion,
	dif_float        FLOAT,
	dif_decl_jur     CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_det_inf_financiera_ind
	ON dbo.cr_det_inf_financiera (dif_codigo_var, dif_inf_fin, dif_secuencial, dif_microempresa)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_det_inf_financiera_key
	ON dbo.cr_det_inf_financiera (dif_microempresa, dif_inf_fin, dif_codigo_var, dif_secuencial)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_det_est_financiero') IS NOT NULL
	DROP TABLE dbo.cr_det_est_financiero
GO

CREATE TABLE dbo.cr_det_est_financiero
	(
	def_codigo         INT NOT NULL,
	def_est_fin        INT NOT NULL,
	def_descripcion    descripcion,
	def_tipo_dato      CHAR (1),
	def_mandatorio     CHAR (1),
	def_tabla_catalogo CHAR (30),
	def_calculado      CHAR (1),
	def_estado         CHAR (1),
	def_total          CHAR (1)
	)
GO

CREATE INDEX cr_det_est_financiero_key
	ON dbo.cr_det_est_financiero (def_codigo, def_est_fin, def_tipo_dato)
GO

IF OBJECT_ID ('dbo.cr_destino_tramite') IS NOT NULL
	DROP TABLE dbo.cr_destino_tramite
GO

CREATE TABLE dbo.cr_destino_tramite
	(
	dt_tramite    INT NOT NULL,
	dt_cliente    INT NOT NULL,
	dt_destino    VARCHAR (10) NOT NULL,
	dt_valor      MONEY NOT NULL,
	dt_rol        CHAR (1) NOT NULL,
	dt_unidad     INT,
	dt_costo      MONEY,
	dt_porcentaje FLOAT
	)
GO

CREATE UNIQUE INDEX cr_destino_tramite_Key
	ON dbo.cr_destino_tramite (dt_tramite, dt_destino)
GO

IF OBJECT_ID ('dbo.cr_destino_economico') IS NOT NULL
	DROP TABLE dbo.cr_destino_economico
GO

CREATE TABLE dbo.cr_destino_economico
	(
	de_codigo_inversion    VARCHAR (10) NOT NULL,
	de_descripcion         descripcion NOT NULL,
	de_ciclo_cultivo       catalogo,
	de_unidades_produccion catalogo,
	de_valor_financiacion  MONEY,
	de_porcentaje_maximo   FLOAT,
	de_plazo_maximo        SMALLINT,
	de_clase               catalogo NOT NULL,
	de_finagro             CHAR (1),
	de_incentivo           CHAR (1),
	de_unidades            CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_destino_economico_Key
	ON dbo.cr_destino_economico (de_codigo_inversion)
GO

CREATE INDEX cr_destino_economico_keyA
	ON dbo.cr_destino_economico (de_clase)
GO

IF OBJECT_ID ('dbo.cr_def_variables_filtros') IS NOT NULL
	DROP TABLE dbo.cr_def_variables_filtros
GO

CREATE TABLE dbo.cr_def_variables_filtros
	(
	df_variable    INT,
	df_descripcion VARCHAR (64),
	df_programa    VARCHAR (40),
	df_tipo_var    catalogo,
	df_tipo_dato   CHAR (1),
	df_estado      catalogo
	)
GO

IF OBJECT_ID ('dbo.cr_def_variables') IS NOT NULL
	DROP TABLE dbo.cr_def_variables
GO

CREATE TABLE dbo.cr_def_variables
	(
	df_variable    TINYINT NOT NULL,
	df_descripcion descripcion,
	df_programa    VARCHAR (40) NOT NULL,
	df_sp_ayuda    VARCHAR (40),
	df_tipo        CHAR (1),
	df_uso         CHAR (1),
	df_banca       catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_def_variables_Key
	ON dbo.cr_def_variables (df_variable)
GO

IF OBJECT_ID ('dbo.cr_dec_jurada') IS NOT NULL
	DROP TABLE dbo.cr_dec_jurada
GO

CREATE TABLE dbo.cr_dec_jurada
	(
	dj_secuencial  INT NOT NULL,
	dj_codigo_mic  INT NOT NULL,
	dj_tipo_bien   VARCHAR (10) NOT NULL,
	dj_tipo_activo VARCHAR (10) NOT NULL,
	dj_descripcion descripcion,
	dj_valor_bien  MONEY NOT NULL,
	dj_cantidad    INT NOT NULL,
	dj_total_bien  MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_dec_jur_1
	ON dbo.cr_dec_jurada (dj_codigo_mic, dj_secuencial)
GO

IF OBJECT_ID ('dbo.cr_datos_tramites') IS NOT NULL
	DROP TABLE dbo.cr_datos_tramites
GO

CREATE TABLE dbo.cr_datos_tramites
	(
	dt_tramite    INT NOT NULL,
	dt_toperacion catalogo NOT NULL,
	dt_producto   catalogo NOT NULL,
	dt_dato       VARCHAR (24) NOT NULL,
	dt_valor      VARCHAR (255) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_datos_tramites_Key
	ON dbo.cr_datos_tramites (dt_tramite, dt_toperacion, dt_producto, dt_dato)
GO

IF OBJECT_ID ('dbo.cr_dato_operacion_rubro') IS NOT NULL
	DROP TABLE dbo.cr_dato_operacion_rubro
GO

CREATE TABLE dbo.cr_dato_operacion_rubro
	(
	dr_fecha           SMALLDATETIME NOT NULL,
	dr_banco           VARCHAR (24) NOT NULL,
	dr_toperacion      VARCHAR (10) NOT NULL,
	dr_aplicativo      TINYINT NOT NULL,
	dr_concepto        VARCHAR (24) NOT NULL,
	dr_valor_vigente   MONEY NOT NULL,
	dr_valor_suspenso  MONEY NOT NULL,
	dr_valor_castigado MONEY NOT NULL,
	dr_valor_diferido  MONEY NOT NULL
	)
GO

CREATE INDEX idx1
	ON dbo.cr_dato_operacion_rubro (dr_banco, dr_toperacion, dr_fecha, dr_concepto)
GO

CREATE INDEX idx2
	ON dbo.cr_dato_operacion_rubro (dr_fecha, dr_aplicativo)
GO

CREATE INDEX idx3
	ON dbo.cr_dato_operacion_rubro (dr_aplicativo)
GO

IF OBJECT_ID ('dbo.cr_dato_operacion') IS NOT NULL
	DROP TABLE dbo.cr_dato_operacion
GO

CREATE TABLE dbo.cr_dato_operacion
	(
	do_fecha                  DATETIME NOT NULL,
	do_tipo_reg               CHAR (1) NOT NULL,
	do_numero_operacion       INT NOT NULL,
	do_numero_operacion_banco VARCHAR (24) NOT NULL,
	do_tipo_operacion         VARCHAR (10) NOT NULL,
	do_codigo_producto        TINYINT NOT NULL,
	do_codigo_cliente         INT NOT NULL,
	do_oficina                SMALLINT NOT NULL,
	do_sucursal               SMALLINT NOT NULL,
	do_regional               VARCHAR (10) NOT NULL,
	do_moneda                 TINYINT NOT NULL,
	do_monto                  MONEY NOT NULL,
	do_tasa                   FLOAT,
	do_periodicidad           SMALLINT,
	do_modalidad              CHAR (1),
	do_fecha_concesion        DATETIME NOT NULL,
	do_fecha_vencimiento      DATETIME NOT NULL,
	do_dias_vto_div           INT,
	do_fecha_vto_div          DATETIME,
	do_reestructuracion       CHAR (1),
	do_fecha_reest            DATETIME,
	do_num_cuota_reest        SMALLINT,
	do_no_renovacion          INT NOT NULL,
	do_codigo_destino         VARCHAR (10) NOT NULL,
	do_clase_cartera          VARCHAR (10) NOT NULL,
	do_codigo_geografico      INT NOT NULL,
	do_departamento           SMALLINT NOT NULL,
	do_tipo_garantias         VARCHAR (10),
	do_valor_garantias        MONEY,
	do_fecha_prox_vto         DATETIME,
	do_saldo_prox_vto         MONEY,
	do_saldo_cap              MONEY NOT NULL,
	do_saldo_int              MONEY NOT NULL,
	do_saldo_otros            MONEY NOT NULL,
	do_saldo_int_contingente  MONEY NOT NULL,
	do_saldo                  MONEY NOT NULL,
	do_estado_contable        TINYINT NOT NULL,
	do_estado_desembolso      CHAR (1) NOT NULL,
	do_estado_terminos        CHAR (1) NOT NULL,
	do_calificacion           VARCHAR (10),
	do_calif_reest            catalogo,
	do_reportado              CHAR (1),
	do_linea_credito          VARCHAR (24),
	do_suspenso               CHAR (1),
	do_suspenso_ant           CHAR (1),
	do_periodicidad_cuota     SMALLINT,
	do_edad_mora              INT,
	do_valor_mora             MONEY,
	do_fecha_pago             DATETIME,
	do_valor_cuota            MONEY,
	do_cuotas_pag             SMALLINT,
	do_estado_cartera         TINYINT,
	do_plazo_dias             INT,
	do_freest_ant             DATETIME,
	do_gerente                SMALLINT NOT NULL,
	do_num_cuotaven           SMALLINT,
	do_saldo_cuotaven         MONEY,
	do_admisible              CHAR (1),
	do_num_cuotas             SMALLINT,
	do_tipo_tarjeta           CHAR (1),
	do_clase_tarjeta          VARCHAR (6),
	do_tipo_bloqueo           CHAR (1),
	do_fecha_bloqueo          DATETIME,
	do_fecha_cambio           DATETIME,
	do_ciclo_fact             DATETIME,
	do_valor_ult_pago         MONEY,
	do_fecha_castigo          DATETIME,
	do_num_acta               VARCHAR (24),
	do_gracia_cap             SMALLINT,
	do_gracia_int             SMALLINT,
	do_probabilidad_default   FLOAT,
	do_nat_reest              catalogo,
	do_num_reest              TINYINT,
	do_acta_cas               catalogo,
	do_capsusxcor             MONEY,
	do_intsusxcor             MONEY,
	do_clausula               CHAR (1),
	do_moneda_op              TINYINT
	)
GO

CREATE UNIQUE INDEX cr_dato_operacion_Akey1
	ON dbo.cr_dato_operacion (do_tipo_reg, do_codigo_producto, do_numero_operacion_banco)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_dato_operacion_Akey2
	ON dbo.cr_dato_operacion (do_codigo_cliente)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_dato_operacion_Akey3
	ON dbo.cr_dato_operacion (do_numero_operacion_banco, do_fecha, do_tipo_operacion, do_codigo_producto)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_dato_operacion_Akey4
	ON dbo.cr_dato_operacion (do_numero_operacion)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_dato_operacion_Akey5
	ON dbo.cr_dato_operacion (do_fecha, do_tipo_reg, do_codigo_producto, do_estado_contable, do_numero_operacion_banco, do_codigo_cliente, do_oficina, do_monto, do_dias_vto_div, do_saldo_cap)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX idx3
	ON dbo.cr_dato_operacion (do_codigo_producto)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_dato_garantia_otras') IS NOT NULL
	DROP TABLE dbo.cr_dato_garantia_otras
GO

CREATE TABLE dbo.cr_dato_garantia_otras
	(
	dg_operacion         INT,
	dg_banco             cuenta,
	dg_producto          TINYINT,
	dg_garantia          VARCHAR (64),
	dg_tipo              CHAR (1),
	dg_cliente           INT,
	dg_monto_distribuido FLOAT,
	dg_clase             VARCHAR (10),
	dg_gar_est_deu       CHAR (1),
	dg_calif_final       CHAR (1),
	dg_sitc              catalogo,
	dg_monto_gar         MONEY,
	dg_saldo_cap         MONEY
	)
GO

IF OBJECT_ID ('dbo.cr_dato_garantia') IS NOT NULL
	DROP TABLE dbo.cr_dato_garantia
GO

CREATE TABLE dbo.cr_dato_garantia
	(
	dg_operacion         INT NOT NULL,
	dg_banco             cuenta NOT NULL,
	dg_producto          TINYINT NOT NULL,
	dg_garantia          VARCHAR (64) NOT NULL,
	dg_tipo              CHAR (1) NOT NULL,
	dg_cliente           INT NOT NULL,
	dg_monto_distribuido FLOAT NOT NULL,
	dg_clase             VARCHAR (10) NOT NULL,
	dg_gar_est_deu       CHAR (1) NOT NULL,
	dg_calif_final       CHAR (1) NOT NULL,
	dg_porc_resp         FLOAT NOT NULL,
	dg_valor_resp        MONEY NOT NULL,
	dg_sitc              catalogo,
	dg_monto_distr_ini   FLOAT NOT NULL,
	dg_pdi               FLOAT
	)
GO

CREATE INDEX cr_dato_garantia_K1
	ON dbo.cr_dato_garantia (dg_cliente)
GO

CREATE INDEX cr_dato_garantia_K2
	ON dbo.cr_dato_garantia (dg_producto, dg_operacion)
GO

CREATE UNIQUE INDEX cr_dato_garantia_Key
	ON dbo.cr_dato_garantia (dg_garantia, dg_producto, dg_operacion)
GO

IF OBJECT_ID ('dbo.cr_dato_cliente') IS NOT NULL
	DROP TABLE dbo.cr_dato_cliente
GO

CREATE TABLE dbo.cr_dato_cliente
	(
	dc_fecha         DATETIME NOT NULL,
	dc_tipo_reg      CHAR (1) NOT NULL,
	dc_cliente       INT NOT NULL,
	dc_nombre        descripcion NOT NULL,
	dc_tipo_id       CHAR (2) NOT NULL,
	dc_iden          numero NOT NULL,
	dc_digito        CHAR (1) NOT NULL,
	dc_actividad     VARCHAR (10) NOT NULL,
	dc_tipo_compania VARCHAR (10) NOT NULL,
	dc_tipo_soc      VARCHAR (10) NOT NULL,
	dc_situacion     VARCHAR (10) NOT NULL,
	dc_estado        VARCHAR (10) NOT NULL,
	dc_fecha_estado  DATETIME NOT NULL,
	dc_val_activos   MONEY,
	dc_tipo_cliente  CHAR (1)
	)
GO

CREATE UNIQUE INDEX cr_dato_cliente_Key
	ON dbo.cr_dato_cliente (dc_tipo_reg, dc_cliente)
GO

IF OBJECT_ID ('dbo.cr_cuentas_ajuste') IS NOT NULL
	DROP TABLE dbo.cr_cuentas_ajuste
GO

CREATE TABLE dbo.cr_cuentas_ajuste
	(
	ca_cuenta        cuenta,
	ca_cuenta_contra cuenta,
	ca_tipo_area     VARCHAR (10),
	ca_estado        CHAR (1),
	ca_fecha         DATETIME,
	ca_usuario       login,
	ca_producto      SMALLINT NOT NULL,
	ca_tipo          VARCHAR (10),
	ca_oficina       CHAR (10) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_ctrl_cupo_asoc') IS NOT NULL
	DROP TABLE dbo.cr_ctrl_cupo_asoc
GO

CREATE TABLE dbo.cr_ctrl_cupo_asoc
	(
	ca_num_cupo         INT NOT NULL,
	ca_secuencial       INT NOT NULL,
	ca_porcentaje       FLOAT NOT NULL,
	ca_plazo            INT NOT NULL,
	ca_acta             cuenta,
	ca_fecha_desembolso DATETIME,
	ca_estado           catalogo
	)
GO

CREATE INDEX cr_ctrl_cupo_asoc_AKey
	ON dbo.cr_ctrl_cupo_asoc (ca_num_cupo, ca_secuencial)
GO

IF OBJECT_ID ('dbo.cr_cotizacion') IS NOT NULL
	DROP TABLE dbo.cr_cotizacion
GO

CREATE TABLE dbo.cr_cotizacion
	(
	cz_moneda        TINYINT NOT NULL,
	cz_fecha         DATETIME NOT NULL,
	cz_valor         MONEY NOT NULL,
	cz_fecha_modif   DATETIME,
	cz_usuario_modif login
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_cotizacion_Key
	ON dbo.cr_cotizacion (cz_moneda, cz_fecha)
GO

IF OBJECT_ID ('dbo.cr_costos_produccion') IS NOT NULL
	DROP TABLE dbo.cr_costos_produccion
GO

CREATE TABLE dbo.cr_costos_produccion
	(
	cp_actividad     catalogo NOT NULL,
	cp_departamento  catalogo,
	cp_tipo_costo    catalogo,
	cp_inversion     catalogo,
	cp_unidad        catalogo,
	cp_cantidad      INT,
	cp_presio_unidad MONEY,
	cp_porc_part     FLOAT,
	cp_total         MONEY,
	cp_observacion   VARCHAR (255)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_costos_produccion_Key
	ON dbo.cr_costos_produccion (cp_actividad)
GO

IF OBJECT_ID ('dbo.cr_costos') IS NOT NULL
	DROP TABLE dbo.cr_costos
GO

CREATE TABLE dbo.cr_costos
	(
	cs_cobranza             VARCHAR (10) NOT NULL,
	cs_costo                SMALLINT NOT NULL,
	cs_codigo               catalogo,
	cs_valor                MONEY,
	cs_moneda               TINYINT,
	cs_fecha_registro       DATETIME NOT NULL,
	cs_fecha_confirmacion   DATETIME,
	cs_usuario_confirmacion login,
	cs_valor_pagado         MONEY,
	cs_fecha_pago           DATETIME
	)
GO

CREATE UNIQUE INDEX cr_costos_Key
	ON dbo.cr_costos (cs_cobranza, cs_costo)
GO

IF OBJECT_ID ('dbo.cr_costo_tipo_detalle') IS NOT NULL
	DROP TABLE dbo.cr_costo_tipo_detalle
GO

CREATE TABLE dbo.cr_costo_tipo_detalle
	(
	ctd_secuencial   INT NOT NULL,
	ctd_cod_tipo     INT NOT NULL,
	ctd_microempresa INT NOT NULL,
	ctd_item         descripcion NOT NULL,
	ctd_unidad       VARCHAR (10),
	ctd_cantidad     FLOAT,
	ctd_valor_unit   MONEY,
	ctd_valor_total  MONEY,
	ctd_precio       MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cp_secuencial_key
	ON dbo.cr_costo_tipo_detalle (ctd_secuencial, ctd_cod_tipo, ctd_microempresa)
GO

CREATE INDEX cp_secuencial_i1
	ON dbo.cr_costo_tipo_detalle (ctd_microempresa)
GO

IF OBJECT_ID ('dbo.cr_costo_tipo') IS NOT NULL
	DROP TABLE dbo.cr_costo_tipo
GO

CREATE TABLE dbo.cr_costo_tipo
	(
	ct_secuencial      INT NOT NULL,
	ct_costo_mercancia INT NOT NULL,
	ct_microempresa    INT NOT NULL,
	ct_producto        descripcion NOT NULL,
	ct_ventas          MONEY,
	ct_part_ventas     FLOAT,
	ct_costo           MONEY,
	ct_costo_pond      FLOAT,
	ct_precio_unidad   MONEY,
	ct_unidad_prod     INT,
	ct_precio_venta    MONEY,
	ct_costo_var       MONEY,
	ct_tipo_costo      CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX ct_secuencial_key
	ON dbo.cr_costo_tipo (ct_secuencial, ct_tipo_costo, ct_microempresa)
GO

CREATE INDEX ct_secuencial_i1
	ON dbo.cr_costo_tipo (ct_microempresa)
GO

IF OBJECT_ID ('dbo.cr_costo_mercancia') IS NOT NULL
	DROP TABLE dbo.cr_costo_mercancia
GO

CREATE TABLE dbo.cr_costo_mercancia
	(
	cm_secuencial   INT NOT NULL,
	cm_microempresa INT NOT NULL,
	cm_prod_ventas  MONEY,
	cm_prod_costo   MONEY,
	cm_com_ventas   MONEY,
	cm_com_costo    MONEY,
	cm_carn_ventas  MONEY,
	cm_carn_costo   MONEY,
	cm_serv_ventas  MONEY,
	cm_serv_costo   MONEY
	)
GO

CREATE UNIQUE CLUSTERED INDEX cp_secuencial_key
	ON dbo.cr_costo_mercancia (cm_secuencial, cm_microempresa)
GO

CREATE INDEX cp_secuencial_i1
	ON dbo.cr_costo_mercancia (cm_microempresa)
GO

IF OBJECT_ID ('dbo.cr_corresp_sib') IS NOT NULL
	DROP TABLE dbo.cr_corresp_sib
GO

CREATE TABLE dbo.cr_corresp_sib
	(
	codigo          catalogo NOT NULL,
	tabla           VARCHAR (24) NOT NULL,
	codigo_sib      catalogo NOT NULL,
	descripcion_sib VARCHAR (100),
	limite_inf      INT,
	limite_sup      INT,
	monto_inf       MONEY,
	monto_sup       MONEY
	)
GO

CREATE INDEX cr_corresp_sib_Akey
	ON dbo.cr_corresp_sib (codigo_sib)
GO

CREATE UNIQUE INDEX cr_corresp_sib_key
	ON dbo.cr_corresp_sib (codigo, tabla)
GO

CREATE INDEX cr_corresp_sib_idx1
	ON dbo.cr_corresp_sib (tabla, codigo_sib)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cr_consolidador_tramite_tmp') IS NOT NULL
	DROP TABLE dbo.cr_consolidador_tramite_tmp
GO

CREATE TABLE dbo.cr_consolidador_tramite_tmp
	(
	tt_fecha   DATETIME NOT NULL,
	tt_tramite INT NOT NULL
	)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cr_consolidador_tramite_tmp (tt_fecha, tt_tramite)
GO

CREATE INDEX idx2
	ON dbo.cr_consolidador_tramite_tmp (tt_tramite)
GO

IF OBJECT_ID ('dbo.cr_consolidador_tramite') IS NOT NULL
	DROP TABLE dbo.cr_consolidador_tramite
GO

CREATE TABLE dbo.cr_consolidador_tramite
	(
	ct_fecha   DATETIME NOT NULL,
	ct_tramite INT NOT NULL,
	ct_estado  CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cr_consolidador_tramite (ct_fecha, ct_tramite)
GO

CREATE INDEX idx2
	ON dbo.cr_consolidador_tramite (ct_tramite)
GO

IF OBJECT_ID ('dbo.cr_condonaciones_tmp') IS NOT NULL
	DROP TABLE dbo.cr_condonaciones_tmp
GO

CREATE TABLE dbo.cr_condonaciones_tmp
	(
	cn_fecha        VARCHAR (10),
	cn_cargo        VARCHAR (155),
	cn_usuario      VARCHAR (155),
	cn_rubro        descripcion,
	cn_monto        VARCHAR (15),
	cn_porcentaje   VARCHAR (4),
	vn_vlr_cancelar VARCHAR (15),
	cn_cosecha      VARCHAR (4)
	)
GO

IF OBJECT_ID ('dbo.cr_concordato') IS NOT NULL
	DROP TABLE dbo.cr_concordato
GO

CREATE TABLE dbo.cr_concordato
	(
	cn_cliente       INT NOT NULL,
	cn_situacion     catalogo,
	cn_estado        catalogo,
	cn_fecha         DATETIME,
	cn_fecha_fin     DATETIME,
	cn_cumplimiento  CHAR (1),
	cn_situacion_ant catalogo,
	cn_fecha_modif   DATETIME,
	cn_acta_cas      catalogo,
	cn_fecha_cas     DATETIME,
	cn_causal        catalogo
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_concordato_Key
	ON dbo.cr_concordato (cn_cliente)
GO

IF OBJECT_ID ('dbo.cr_comision') IS NOT NULL
	DROP TABLE dbo.cr_comision
GO

CREATE TABLE dbo.cr_comision
	(
	co_tipo_cobrador    VARCHAR (10) NOT NULL,
	co_porcen_min_recup FLOAT NOT NULL,
	co_porcen_max_recup FLOAT NOT NULL,
	co_comision         MONEY NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_comision_Key
	ON dbo.cr_comision (co_tipo_cobrador, co_porcen_min_recup, co_porcen_max_recup)
GO

IF OBJECT_ID ('dbo.cr_cobranza') IS NOT NULL
	DROP TABLE dbo.cr_cobranza
GO

CREATE TABLE dbo.cr_cobranza
	(
	co_cobranza          VARCHAR (10) NOT NULL,
	co_cliente           INT NOT NULL,
	co_estado            catalogo NOT NULL,
	co_proceso           catalogo NOT NULL,
	co_etapa             catalogo NOT NULL,
	co_ab_interno        login,
	co_fecha_ab_interno  DATETIME,
	co_abogado           catalogo,
	co_fecha_abogado     DATETIME,
	co_fecha_documentos  DATETIME,
	co_fecha_demanda     DATETIME,
	co_juzgado           catalogo,
	co_num_juicio        cuenta,
	co_informe           SMALLINT,
	co_fecha_ingr        DATETIME NOT NULL,
	co_usuario_ingr      login NOT NULL,
	co_fecha_mod         DATETIME,
	co_usuario_mod       login,
	co_oficina           SMALLINT NOT NULL,
	co_secuencial        INT NOT NULL,
	co_cob_externo       login,
	co_fecha_cob_externo DATETIME,
	co_observa           VARCHAR (254),
	co_fecha_judicial    DATETIME
	)
GO

CREATE INDEX cr_cobranza_AKey
	ON dbo.cr_cobranza (co_cliente, co_cobranza)
	WITH (FILLFACTOR = 90)
GO

CREATE UNIQUE INDEX cr_cobranza_Key
	ON dbo.cr_cobranza (co_cobranza, co_cliente, co_estado)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_cobertura_planes') IS NOT NULL
	DROP TABLE dbo.cr_cobertura_planes
GO

CREATE TABLE dbo.cr_cobertura_planes
	(
	cp_codigo_plan        INT,
	cp_codigo_cobertura   INT,
	cp_descripcion_amparo VARCHAR (255),
	cp_valor_cobertura    MONEY,
	cp_estado             catalogo,
	cp_fecha_modif        DATETIME,
	cp_usuario_modif      login,
	cp_terminal_modif     VARCHAR (30),
	cp_cober_historia     INT NOT NULL,
	cp_plan_historia      INT NOT NULL,
	cp_fecha_crea         DATETIME,
	cp_usuario_crea       login,
	cp_terminal_crea      VARCHAR (30)
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_cobertura_planes (cp_cober_historia)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
	ON dbo.cr_cobertura_planes (cp_codigo_plan, cp_codigo_cobertura)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_cliente_temporal') IS NOT NULL
	DROP TABLE dbo.cr_cliente_temporal
GO

CREATE TABLE dbo.cr_cliente_temporal
	(
	cl_idconn  INT NOT NULL,
	cl_cliente INT,
	cl_tipo    CHAR (1)
	)
GO

CREATE INDEX cr_cliente_temporal_1
	ON dbo.cr_cliente_temporal (cl_idconn, cl_tipo)
GO

IF OBJECT_ID ('dbo.cr_cliente_ricl') IS NOT NULL
	DROP TABLE dbo.cr_cliente_ricl
GO

CREATE TABLE dbo.cr_cliente_ricl
	(
	cl_idconn  INT,
	cl_cliente INT,
	cl_tipo    CHAR (1)
	)
GO

CREATE INDEX cr_cliente_ricl_Key
	ON dbo.cr_cliente_ricl (cl_idconn)
GO

IF OBJECT_ID ('dbo.cr_cliente_campana') IS NOT NULL
	DROP TABLE dbo.cr_cliente_campana
GO

CREATE TABLE dbo.cr_cliente_campana
	(
	cc_cliente             INT NOT NULL,
	cc_campana             INT,
	cc_tipo_pref           catalogo NOT NULL,
	cc_fecha               DATETIME NOT NULL,
	cc_oficina             INT NOT NULL,
	cc_estado              CHAR (1) NOT NULL,
	cc_acepta_contraoferta CHAR (1),
	cc_asignado_a          login,
	cc_asignado_por        login,
	cc_encuesta            CHAR (1),
	cc_fecha_cierre        DATETIME,
	cc_fecha_fin           DATETIME,
	cc_fecha_ini           DATETIME,
	cc_tramite             INT
	)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cr_cliente_campana (cc_cliente, cc_campana, cc_fecha, cc_estado)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX ix_cr_cliente_campana_1
	ON dbo.cr_cliente_campana (cc_campana)
GO

CREATE INDEX ix_cr_cliente_campana_2
	ON dbo.cr_cliente_campana (cc_fecha, cc_estado)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX ix_cr_cliente_campana_3
	ON dbo.cr_cliente_campana (cc_oficina, cc_estado)
GO

CREATE INDEX idx2
	ON dbo.cr_cliente_campana (cc_tramite)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx3
	ON dbo.cr_cliente_campana (cc_asignado_a)
	WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx4
	ON dbo.cr_cliente_campana (cc_encuesta)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_cau_tramite') IS NOT NULL
	DROP TABLE dbo.cr_cau_tramite
GO

CREATE TABLE dbo.cr_cau_tramite
	(
	cr_tramite   INT NOT NULL,
	cr_etapa     TINYINT NOT NULL,
	cr_requisito catalogo NOT NULL,
	cr_tipo      catalogo NOT NULL
	)
GO

CREATE INDEX cr_cau_tramite_Key
	ON dbo.cr_cau_tramite (cr_tramite)
GO

IF OBJECT_ID ('dbo.cr_cau_etapa') IS NOT NULL
	DROP TABLE dbo.cr_cau_etapa
GO

CREATE TABLE dbo.cr_cau_etapa
	(
	cq_etapa        TINYINT NOT NULL,
	cq_tipo_tramite CHAR (1) NOT NULL,
	cq_causal       catalogo NOT NULL,
	cq_tipo         catalogo NOT NULL
	)
GO

CREATE INDEX cr_cau_etapa_k1
	ON dbo.cr_cau_etapa (cq_etapa)
GO

IF OBJECT_ID ('dbo.cr_carga_campana_log') IS NOT NULL
	DROP TABLE dbo.cr_carga_campana_log
GO

CREATE TABLE dbo.cr_carga_campana_log
	(
	cl_oficina     INT NOT NULL,
	cl_campana     INT,
	cl_cliente     INT,
	cl_id          VARCHAR (30),
	cl_tipo_id     CHAR (2),
	cl_descripcion VARCHAR (250),
	cl_fecha_carga DATETIME,
	cl_origen      CHAR (3) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_campana_toperacion') IS NOT NULL
	DROP TABLE dbo.cr_campana_toperacion
GO

CREATE TABLE dbo.cr_campana_toperacion
	(
	ct_campana    INT NOT NULL,
	ct_toperacion catalogo NOT NULL
	)
GO

CREATE UNIQUE INDEX ix_cr_campana_toperacion
	ON dbo.cr_campana_toperacion (ct_campana, ct_toperacion)
GO

IF OBJECT_ID ('dbo.cr_campana') IS NOT NULL
	DROP TABLE dbo.cr_campana
GO

CREATE TABLE dbo.cr_campana
	(
	ca_codigo           INT NOT NULL,
	ca_nombre           VARCHAR (50) NOT NULL,
	ca_descripcion      descripcion,
	ca_modalidad        catalogo NOT NULL,
	ca_clientesc        catalogo NOT NULL,
	ca_estado           CHAR (1) NOT NULL,
	ca_vig_ini          DATETIME,
	ca_vig_fin          DATETIME,
	ca_detalle          VARCHAR (250),
	ca_altura_mora      INT,
	ca_dias_de_vigencia INT,
	ca_tipo_campana     INT
	)
GO

CREATE UNIQUE INDEX ix_cr_campana
	ON dbo.cr_campana (ca_codigo)
GO

CREATE INDEX ix_cr_camapana_1
	ON dbo.cr_campana (ca_clientesc, ca_estado)
GO

IF OBJECT_ID ('dbo.cr_cambio_estados') IS NOT NULL
	DROP TABLE dbo.cr_cambio_estados
GO

CREATE TABLE dbo.cr_cambio_estados
	(
	ce_cobranza    VARCHAR (10) NOT NULL,
	ce_secuencial  INT NOT NULL,
	ce_estado_ant  catalogo NOT NULL,
	ce_estado_act  catalogo NOT NULL,
	ce_funcionario login NOT NULL,
	ce_fecha       DATETIME NOT NULL
	)
GO

CREATE INDEX cr_cambio_estados_Key
	ON dbo.cr_cambio_estados (ce_cobranza, ce_secuencial)
GO

IF OBJECT_ID ('dbo.cr_calificaciones_op') IS NOT NULL
	DROP TABLE dbo.cr_calificaciones_op
GO

CREATE TABLE dbo.cr_calificaciones_op
	(
	co_operacion     INT NOT NULL,
	co_producto      TINYINT NOT NULL,
	co_tcalificacion VARCHAR (10) NOT NULL,
	co_calif         CHAR (1) NOT NULL,
	co_usuario       login NOT NULL,
	co_fecha         DATETIME NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_calificaciones_op_Key
	ON dbo.cr_calificaciones_op (co_operacion, co_producto, co_tcalificacion)
GO

IF OBJECT_ID ('dbo.cr_calificaciones_cl') IS NOT NULL
	DROP TABLE dbo.cr_calificaciones_cl
GO

CREATE TABLE dbo.cr_calificaciones_cl
	(
	cl_cod_cliente   INT NOT NULL,
	cl_tcalificacion VARCHAR (10) NOT NULL,
	cl_calif         CHAR (1) NOT NULL,
	cl_clase         catalogo,
	cl_usuario       login NOT NULL,
	cl_fecha         DATETIME NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_calificaciones_cl_Key
	ON dbo.cr_calificaciones_cl (cl_cod_cliente, cl_clase, cl_tcalificacion)
GO

IF OBJECT_ID ('dbo.cr_calificacion_provision') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_provision
GO

CREATE TABLE dbo.cr_calificacion_provision
	(
	cp_operacion  INT NOT NULL,
	cp_num_banco  VARCHAR (24) NOT NULL,
	cp_producto   TINYINT NOT NULL,
	cp_concepto   catalogo NOT NULL,
	cp_saldo      MONEY NOT NULL,
	cp_xprov      MONEY NOT NULL,
	cp_prov       MONEY NOT NULL,
	cp_prov1      MONEY NOT NULL,
	cp_prova      MONEY,
	cp_prova1     MONEY,
	cp_prov_ant   MONEY,
	cp_fecha      DATETIME NOT NULL,
	cp_prov_old   MONEY,
	cp_prova_old  MONEY,
	cp_provc      MONEY,
	cp_provc1     MONEY,
	cp_provc_old  MONEY,
	cp_provcc     MONEY,
	cp_provcc1    MONEY,
	cp_provcc_ant MONEY,
	cp_provcc_mrc FLOAT
	)
GO

CREATE INDEX cr_calificacion_provision_K2
	ON dbo.cr_calificacion_provision (cp_num_banco, cp_producto, cp_concepto)
GO

CREATE INDEX cr_calificacion_provision_K3
	ON dbo.cr_calificacion_provision (cp_operacion, cp_producto)
GO

CREATE INDEX cr_calificacion_provision_K4
	ON dbo.cr_calificacion_provision (cp_producto, cp_operacion)
GO

IF OBJECT_ID ('dbo.cr_calificacion_orig') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_orig
GO

CREATE TABLE dbo.cr_calificacion_orig
	(
	cm_tramite      INT NOT NULL,
	cm_fecha_resp   DATETIME,
	cm_calificacion CHAR (1),
	cm_modo_calif   VARCHAR (10),
	cm_valor        FLOAT,
	cm_usuario      login
	)
GO

CREATE INDEX idx1
	ON dbo.cr_calificacion_orig (cm_tramite)
GO

IF OBJECT_ID ('dbo.cr_calificacion_op_rep') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_op_rep
GO

CREATE TABLE dbo.cr_calificacion_op_rep
	(
	co_producto       TINYINT NOT NULL,
	co_toperacion     catalogo NOT NULL,
	co_moneda         TINYINT NOT NULL,
	co_cod_cliente    INT NOT NULL,
	co_operacion      INT NOT NULL,
	co_num_op_banco   VARCHAR (24) NOT NULL,
	co_clase          VARCHAR (10) NOT NULL,
	co_tgarantia      VARCHAR (10) NOT NULL,
	co_cobertura      FLOAT NOT NULL,
	co_oficina        SMALLINT NOT NULL,
	co_calif_ant      CHAR (1) NOT NULL,
	co_mes_vto        FLOAT NOT NULL,
	co_calif_sug      CHAR (1) NOT NULL,
	co_calif_final    CHAR (1) NOT NULL,
	co_saldo_cap      MONEY NOT NULL,
	co_saldo_int      MONEY NOT NULL,
	co_saldo_ctasxcob MONEY NOT NULL,
	co_xprov_cap      MONEY NOT NULL,
	co_xprov_int      MONEY NOT NULL,
	co_xprov_ctasxcob MONEY NOT NULL,
	co_prov_cap       MONEY NOT NULL,
	co_prov_int       MONEY NOT NULL,
	co_prov_ctasxcob  MONEY NOT NULL,
	co_prova_cap      MONEY,
	co_prova_int      MONEY,
	co_prova_ctasxcob MONEY,
	co_usuario        VARCHAR (14) NOT NULL,
	co_fecha          DATETIME NOT NULL,
	co_observacion    descripcion,
	co_tipo_reg       CHAR (1) NOT NULL,
	co_reproceso      CHAR (1) NOT NULL,
	co_calificado     CHAR (1),
	co_oficina_ant    SMALLINT,
	co_mes_vto_ant    FLOAT,
	co_procad         CHAR (1),
	co_gerente        SMALLINT,
	co_gerente_ant    SMALLINT,
	co_calif_hom      CHAR (2),
	co_tipo_empresa   CHAR (2),
	co_pdi            FLOAT
	)
GO

CREATE INDEX cr_calificacion_op_rep_Key1
	ON dbo.cr_calificacion_op_rep (co_fecha, co_producto, co_num_op_banco)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX cr_calificacion_op_rep_Key2
	ON dbo.cr_calificacion_op_rep (co_producto, co_operacion)
	WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.cr_calificacion_op') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_op
GO

CREATE TABLE dbo.cr_calificacion_op
	(
	co_producto       TINYINT NOT NULL,
	co_toperacion     catalogo NOT NULL,
	co_moneda         TINYINT NOT NULL,
	co_cod_cliente    INT NOT NULL,
	co_operacion      INT NOT NULL,
	co_num_op_banco   VARCHAR (24) NOT NULL,
	co_clase          VARCHAR (10) NOT NULL,
	co_tgarantia      VARCHAR (10) NOT NULL,
	co_cobertura      FLOAT NOT NULL,
	co_oficina        SMALLINT NOT NULL,
	co_calif_ant      CHAR (1) NOT NULL,
	co_mes_vto        FLOAT NOT NULL,
	co_calif_sug      CHAR (1) NOT NULL,
	co_calif_final    CHAR (1) NOT NULL,
	co_saldo_cap      MONEY NOT NULL,
	co_saldo_int      MONEY NOT NULL,
	co_saldo_ctasxcob MONEY NOT NULL,
	co_xprov_cap      MONEY NOT NULL,
	co_xprov_int      MONEY NOT NULL,
	co_xprov_ctasxcob MONEY NOT NULL,
	co_prov_cap       MONEY NOT NULL,
	co_prov_int       MONEY NOT NULL,
	co_prov_ctasxcob  MONEY NOT NULL,
	co_prova_cap      MONEY,
	co_prova_int      MONEY,
	co_prova_ctasxcob MONEY,
	co_usuario        VARCHAR (14) NOT NULL,
	co_fecha          DATETIME NOT NULL,
	co_observacion    descripcion,
	co_reproceso      CHAR (1) NOT NULL,
	co_calificado     CHAR (1),
	co_oficina_ant    SMALLINT,
	co_mes_vto_ant    FLOAT,
	co_procad         CHAR (1),
	co_gerente        SMALLINT,
	co_gerente_ant    SMALLINT,
	co_calif_hom      CHAR (2),
	co_tipo_empresa   CHAR (2),
	co_pdi            FLOAT,
	co_pi_matriz_a    FLOAT,
	co_pi_matriz_b    FLOAT,
	co_tipo_otras     CHAR (20),
	co_pdi_otras      FLOAT,
	co_dias_incum     FLOAT
	)
GO

CREATE INDEX cr_calificacion_op_K1
	ON dbo.cr_calificacion_op (co_producto, co_num_op_banco)
GO

CREATE INDEX cr_calificacion_op_K2
	ON dbo.cr_calificacion_op (co_cod_cliente, co_operacion, co_producto)
GO

CREATE INDEX cr_calificacion_op_K3
	ON dbo.cr_calificacion_op (co_clase, co_operacion, co_producto)
GO

IF OBJECT_ID ('dbo.cr_calificacion_cl_rep') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_cl_rep
GO

CREATE TABLE dbo.cr_calificacion_cl_rep
	(
	cl_cod_cliente INT NOT NULL,
	cl_id_cliente  numero NOT NULL,
	cl_calif_ant   CHAR (1) NOT NULL,
	cl_calif_mayor CHAR (1) NOT NULL,
	cl_usuario     VARCHAR (14) NOT NULL,
	cl_fecha       DATETIME NOT NULL,
	cl_observacion VARCHAR (255),
	cl_tipo_reg    CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_calificacion_cl_rep_Key
	ON dbo.cr_calificacion_cl_rep (cl_fecha, cl_cod_cliente)
GO

IF OBJECT_ID ('dbo.cr_calificacion_cl') IS NOT NULL
	DROP TABLE dbo.cr_calificacion_cl
GO

CREATE TABLE dbo.cr_calificacion_cl
	(
	cl_cod_cliente INT NOT NULL,
	cl_id_cliente  numero NOT NULL,
	cl_calif_ant   CHAR (1) NOT NULL,
	cl_calif_mayor CHAR (1) NOT NULL,
	cl_usuario     VARCHAR (14) NOT NULL,
	cl_fecha       DATETIME NOT NULL,
	cl_observacion VARCHAR (255)
	)
GO

CREATE UNIQUE INDEX cr_calificacion_cl_Key
	ON dbo.cr_calificacion_cl (cl_cod_cliente)
GO

IF OBJECT_ID ('dbo.cr_califica_interna') IS NOT NULL
	DROP TABLE dbo.cr_califica_interna
GO

CREATE TABLE dbo.cr_califica_interna
	(
	ci_tipo_calif VARCHAR (10) NOT NULL,
	ci_dias_hasta INT NOT NULL,
	ci_nota       SMALLINT NOT NULL,
	ci_estado     VARCHAR (10) NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_califica_interna_key
	ON dbo.cr_califica_interna (ci_tipo_calif, ci_dias_hasta, ci_nota, ci_estado)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_califica_int_mod') IS NOT NULL
	DROP TABLE dbo.cr_califica_int_mod
GO

CREATE TABLE dbo.cr_califica_int_mod
	(
	ci_producto   SMALLINT NOT NULL,
	ci_toperacion catalogo NOT NULL,
	ci_moneda     SMALLINT NOT NULL,
	ci_cliente    INT NOT NULL,
	ci_banco      cuenta NOT NULL,
	ci_fecha      SMALLDATETIME NOT NULL,
	ci_nota       TINYINT NOT NULL
	)
GO

CREATE UNIQUE INDEX cr_califica_int_mod_inx
	ON dbo.cr_califica_int_mod (ci_banco)
	WITH (FILLFACTOR = 80)
GO

CREATE INDEX cr_califica_int_mod_inx1
	ON dbo.cr_califica_int_mod (ci_cliente)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_califica_int_manual') IS NOT NULL
	DROP TABLE dbo.cr_califica_int_manual
GO

CREATE TABLE dbo.cr_califica_int_manual
	(
	cim_banco VARCHAR (24),
	cim_tipo  CHAR (1),
	cim_nota  SMALLINT
	)
GO

CREATE INDEX idx1
	ON dbo.cr_califica_int_manual (cim_banco)
GO

IF OBJECT_ID ('dbo.cr_cal_tplan_tmp') IS NOT NULL
	DROP TABLE dbo.cr_cal_tplan_tmp
GO

CREATE TABLE dbo.cr_cal_tplan_tmp
	(
	conexion  INT NOT NULL,
	fecha_ini DATETIME NOT NULL,
	fecha_fin DATETIME NOT NULL,
	dividendo INT NOT NULL
	)
GO

CREATE INDEX cr_cal_tplan_tmp_k1
	ON dbo.cr_cal_tplan_tmp (conexion)
GO

IF OBJECT_ID ('dbo.cr_beneficiarios') IS NOT NULL
	DROP TABLE dbo.cr_beneficiarios
GO

CREATE TABLE dbo.cr_beneficiarios
	(
	be_secuencial_seguro INT,
	be_sec_asegurado     INT,
	be_sec_benefic       INT,
	be_apellidos         VARCHAR (255),
	be_nombres           VARCHAR (255),
	be_tipo_ced          catalogo,
	be_ced_ruc           VARCHAR (30),
	be_lugar_exp         INT,
	be_fecha_exp         DATETIME,
	be_ciudad_nac        INT,
	be_fecha_nac         DATETIME,
	be_sexo              VARCHAR (1),
	be_estado_civil      catalogo,
	be_parentesco        catalogo,
	be_ocupacion         catalogo,
	be_direccion         VARCHAR (255),
	be_telefono          VARCHAR (16),
	be_ciudad            INT,
	be_correo_elec       VARCHAR (255),
	be_celular           VARCHAR (16),
	be_correspondencia   VARCHAR (255),
	be_fecha_modif       DATETIME,
	be_usuario_modif     login,
	be_porcentaje        FLOAT,
	be_ente              CHAR (1)
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_beneficiarios (be_secuencial_seguro, be_sec_asegurado, be_sec_benefic)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_benefic_micro_aseg_his') IS NOT NULL
	DROP TABLE dbo.cr_benefic_micro_aseg_his
GO

CREATE TABLE dbo.cr_benefic_micro_aseg_his
	(
	bm_microseg       INT,
	bm_asegurado      INT,
	bm_secuencial     INT,
	bm_tipo_iden      VARCHAR (10),
	bm_identificacion numero,
	bm_nombre_comp    descripcion,
	bm_fecha_nac      DATETIME,
	bm_genero         VARCHAR (10),
	bm_lugar_nac      INT,
	bm_estado_civ     VARCHAR (10),
	bm_ocupacion      VARCHAR (10),
	bm_parentesco     VARCHAR (10),
	bm_direccion      descripcion,
	bm_telefono       numero,
	bm_porcentaje     FLOAT
	)
GO

IF OBJECT_ID ('dbo.cr_benefic_micro_aseg') IS NOT NULL
	DROP TABLE dbo.cr_benefic_micro_aseg
GO

CREATE TABLE dbo.cr_benefic_micro_aseg
	(
	bm_microseg       INT NOT NULL,
	bm_asegurado      INT NOT NULL,
	bm_secuencial     INT NOT NULL,
	bm_tipo_iden      VARCHAR (10) NOT NULL,
	bm_identificacion numero NOT NULL,
	bm_nombre_comp    descripcion NOT NULL,
	bm_fecha_nac      DATETIME NOT NULL,
	bm_genero         VARCHAR (10),
	bm_lugar_nac      INT,
	bm_estado_civ     VARCHAR (10),
	bm_ocupacion      VARCHAR (10),
	bm_parentesco     VARCHAR (10),
	bm_direccion      descripcion,
	bm_telefono       numero,
	bm_porcentaje     FLOAT
	)
GO

CREATE INDEX cr_benefic_micro_aseg_key
	ON dbo.cr_benefic_micro_aseg (bm_microseg, bm_asegurado, bm_secuencial)
GO

IF OBJECT_ID ('dbo.cr_ben_redes') IS NOT NULL
	DROP TABLE dbo.cr_ben_redes
GO

CREATE TABLE dbo.cr_ben_redes
	(
	br_tramite INT,
	br_ide_ben numero,
	br_doc_ben CHAR (1),
	br_nom_ben VARCHAR (80),
	br_tip_ben catalogo,
	br_sub_ben catalogo,
	br_act_ben MONEY,
	br_dir_ben VARCHAR (250),
	br_tel_ben VARCHAR (12)
	)
GO

CREATE INDEX cr_ben_redes_k1
	ON dbo.cr_ben_redes (br_tramite)
GO

IF OBJECT_ID ('dbo.cr_asignacion_cob') IS NOT NULL
	DROP TABLE dbo.cr_asignacion_cob
GO

CREATE TABLE dbo.cr_asignacion_cob
	(
	ac_cod_cobrador         login NOT NULL,
	ac_tipo_cobrador        VARCHAR (10),
	ac_cod_cobranza         VARCHAR (10) NOT NULL,
	ac_cod_cliente          INT NOT NULL,
	ac_fecha_asig           DATETIME,
	ac_fecha_corte          DATETIME,
	ac_num_obligacion       INT NOT NULL,
	ac_num_banco_obl        cuenta NOT NULL,
	ac_producto             TINYINT NOT NULL,
	ac_saldo_obligacion     MONEY,
	ac_saldo_cap_obl        MONEY,
	ac_dias_vcto            SMALLINT,
	ac_num_cuotaven         SMALLINT,
	ac_saldo_cuotaven       MONEY,
	ac_estado_oblg          TINYINT NOT NULL,
	ac_oficina              SMALLINT NOT NULL,
	ac_fecha_corte_ant      DATETIME,
	ac_saldo_obligacion_ant MONEY,
	ac_saldo_cap_obl_ant    MONEY,
	ac_dias_vcto_ant        SMALLINT,
	ac_num_cuotaven_ant     SMALLINT,
	ac_saldo_cuotaven_ant   MONEY,
	ac_estado_oblg_ant      TINYINT,
	ac_sector               catalogo,
	ac_ofi_gte              SMALLINT,
	ac_moneda               TINYINT,
	ac_toperacion           catalogo NOT NULL,
	ac_saldo_intv           MONEY,
	ac_saldo_morv           MONEY,
	ac_coutas_vcap          INT,
	ac_saldo_otrv           MONEY,
	ac_frec_cap             INT,
	ac_frec_int             INT,
	ac_clase                CHAR (1),
	ac_amortiza             catalogo,
	ac_usuario_asig         login,
	ac_saldo_intp           MONEY,
	ac_saldo_morp           MONEY,
	ac_saldo_otrp           MONEY,
	ac_saldo_capv           MONEY,
	ac_coutas_pcap          INT
	)
GO

CREATE INDEX cr_asignacion_cob_AKey
	ON dbo.cr_asignacion_cob (ac_cod_cliente, ac_num_obligacion, ac_cod_cobranza)
GO

CREATE UNIQUE INDEX cr_asignacion_cob_Key
	ON dbo.cr_asignacion_cob (ac_cod_cobranza, ac_producto, ac_num_banco_obl)
GO

IF OBJECT_ID ('dbo.cr_asignacion_campana') IS NOT NULL
	DROP TABLE dbo.cr_asignacion_campana
GO

CREATE TABLE dbo.cr_asignacion_campana
	(
	ac_campana          INT,
	ac_cliente          INT,
	ac_usuario_asigna   login,
	ac_fecha_asigna     DATETIME,
	ac_usuario_reasigna login,
	ac_fecha_reasigna   DATETIME
	)
GO

CREATE INDEX cr_asignacion_campana_idx1
	ON dbo.cr_asignacion_campana (ac_campana, ac_cliente)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_asegurados_estadistica') IS NOT NULL
	DROP TABLE dbo.cr_asegurados_estadistica
GO

CREATE TABLE dbo.cr_asegurados_estadistica
	(
	ae_fecha       DATETIME,
	ae_certificado VARCHAR (20),
	ae_tipo_doc    VARCHAR (10),
	ae_identif     VARCHAR (30),
	ae_nombre      VARCHAR (200),
	ae_genero      CHAR (1),
	ae_fecha_nac   DATETIME,
	ae_fecha_venta DATETIME
	)
GO

CREATE INDEX idx1
	ON dbo.cr_asegurados_estadistica (ae_fecha, ae_certificado)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_asegurados') IS NOT NULL
	DROP TABLE dbo.cr_asegurados
GO

CREATE TABLE dbo.cr_asegurados
	(
	as_secuencial_seguro   INT,
	as_sec_asegurado       INT,
	as_tipo_aseg           INT,
	as_apellidos           VARCHAR (255),
	as_nombres             VARCHAR (255),
	as_tipo_ced            catalogo,
	as_ced_ruc             VARCHAR (30),
	as_lugar_exp           INT,
	as_fecha_exp           DATETIME,
	as_ciudad_nac          INT,
	as_fecha_nac           DATETIME,
	as_sexo                VARCHAR (1),
	as_estado_civil        catalogo,
	as_parentesco          catalogo,
	as_ocupacion           catalogo,
	as_direccion           VARCHAR (255),
	as_telefono            VARCHAR (16),
	as_ciudad              INT,
	as_correo_elec         VARCHAR (255),
	as_celular             VARCHAR (16),
	as_correspondencia     VARCHAR (255),
	as_plan                INT,
	as_fecha_modif         DATETIME,
	as_usuario_modif       login,
	as_observaciones       VARCHAR (255),
	as_act_economica       catalogo,
	as_ente                CHAR (1),
	as_fecha_ini_cobertura DATETIME,
	as_fecha_fin_cobertura DATETIME
	)
GO

CREATE UNIQUE CLUSTERED INDEX idx1
	ON dbo.cr_asegurados (as_secuencial_seguro, as_sec_asegurado)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_asegura_tmp') IS NOT NULL
	DROP TABLE dbo.cr_asegura_tmp
GO

CREATE TABLE dbo.cr_asegura_tmp
	(
	at_banco      VARCHAR (20) NOT NULL,
	at_cliente    numero,
	at_p_apellido VARCHAR (50) NOT NULL,
	at_nombre     VARCHAR (50) NOT NULL,
	at_fecha_nac  VARCHAR (10) NOT NULL,
	at_fecha_liq  VARCHAR (10) NOT NULL,
	at_monto      MONEY NOT NULL,
	at_saldo_cap  MONEY NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_aseg_microseguro_his') IS NOT NULL
	DROP TABLE dbo.cr_aseg_microseguro_his
GO

CREATE TABLE dbo.cr_aseg_microseguro_his
	(
	am_microseg       INT,
	am_secuencial     INT,
	am_tipo_iden      VARCHAR (10),
	am_tipo_aseg      VARCHAR (10),
	am_lugar_exp      INT,
	am_identificacion numero,
	am_nombre_comp    descripcion,
	am_fecha_exp      DATETIME,
	am_fecha_nac      DATETIME,
	am_genero         VARCHAR (10),
	am_lugar_nac      INT,
	am_estado_civ     VARCHAR (10),
	am_ocupacion      VARCHAR (10),
	am_parentesco     VARCHAR (10),
	am_direccion      descripcion,
	am_derecho_acrec  CHAR (1),
	am_plan           INT,
	am_valor_plan     MONEY,
	am_telefono       numero,
	am_observaciones  descripcion,
	am_principal      CHAR (1)
	)
GO

IF OBJECT_ID ('dbo.cr_aseg_microseguro') IS NOT NULL
	DROP TABLE dbo.cr_aseg_microseguro
GO

CREATE TABLE dbo.cr_aseg_microseguro
	(
	am_microseg       INT NOT NULL,
	am_secuencial     INT NOT NULL,
	am_tipo_iden      VARCHAR (10) NOT NULL,
	am_tipo_aseg      VARCHAR (10) NOT NULL,
	am_lugar_exp      INT NOT NULL,
	am_identificacion numero NOT NULL,
	am_nombre_comp    descripcion NOT NULL,
	am_fecha_exp      DATETIME NOT NULL,
	am_fecha_nac      DATETIME NOT NULL,
	am_genero         VARCHAR (10) NOT NULL,
	am_lugar_nac      INT NOT NULL,
	am_estado_civ     VARCHAR (10) NOT NULL,
	am_ocupacion      VARCHAR (10) NOT NULL,
	am_parentesco     VARCHAR (10),
	am_direccion      descripcion NOT NULL,
	am_derecho_acrec  CHAR (1) NOT NULL,
	am_plan           INT NOT NULL,
	am_valor_plan     MONEY NOT NULL,
	am_telefono       numero NOT NULL,
	am_observaciones  descripcion,
	am_principal      CHAR (1)
	)
GO

CREATE CLUSTERED INDEX cr_aseg_microseguro_key
	ON dbo.cr_aseg_microseguro (am_microseg, am_secuencial)
GO

CREATE INDEX cr_aseg_microseguro_key2
	ON dbo.cr_aseg_microseguro (am_identificacion, am_microseg)
	WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.cr_archivo_redescuento') IS NOT NULL
	DROP TABLE dbo.cr_archivo_redescuento
GO

CREATE TABLE dbo.cr_archivo_redescuento
	(
	re_estado              CHAR (1),
	re_tramite             INT,
	re_operacion           cuenta,
	re_fecha_envio         DATETIME,
	re_cliente             INT,
	re_llave_redescuento   cuenta,
	re_cod_entidad         CHAR (3),
	re_toperacion          catalogo,
	re_num_pagare          VARCHAR (25),
	re_fecha_suscripcion   DATETIME,
	re_fecha_redes         DATETIME,
	re_rubro_economico     catalogo,
	re_ciudad_inversion    INT,
	re_nit_deudor          numero,
	re_ide_ben_1           numero,
	re_doc_ben_1           CHAR (1),
	re_nom_ben_1           VARCHAR (80),
	re_tip_ben_1           catalogo,
	re_sub_ben_1           catalogo,
	re_act_ben_1           MONEY,
	re_dir_ben_1           VARCHAR (250),
	re_tel_ben_1           VARCHAR (12),
	re_ide_ben_2           numero,
	re_doc_ben_2           CHAR (1),
	re_nom_ben_2           VARCHAR (80),
	re_tip_ben_2           catalogo,
	re_sub_ben_2           catalogo,
	re_act_ben_2           MONEY,
	re_dir_ben_2           VARCHAR (200),
	re_tel_ben_2           VARCHAR (12),
	re_ide_ben_3           numero,
	re_doc_ben_3           CHAR (1),
	re_nom_ben_3           VARCHAR (80),
	re_tip_ben_3           catalogo,
	re_sub_ben_3           catalogo,
	re_act_ben_3           MONEY,
	re_dir_ben_3           VARCHAR (200),
	re_tel_ben_3           VARCHAR (12),
	re_ide_ben_4           numero,
	re_doc_ben_4           CHAR (1),
	re_nom_ben_4           VARCHAR (80),
	re_tip_ben_4           catalogo,
	re_sub_ben_4           catalogo,
	re_act_ben_4           MONEY,
	re_dir_ben_4           VARCHAR (200),
	re_tel_ben_4           VARCHAR (12),
	re_acta                cuenta,
	re_codigo_ciiu         catalogo,
	re_oficina             INT,
	re_nom_oficina         VARCHAR (24),
	re_ofi_pagare          INT,
	re_nom_oficina_pagare  VARCHAR (24),
	re_cod_aseguradora     VARCHAR (20),
	re_cod_poliza          VARCHAR (24),
	re_cob_poliza          catalogo,
	re_fecha_vig_poliza    DATETIME,
	re_cod_almacenadora    SMALLINT,
	re_nom_almacenadora    descripcion,
	re_cant_unidades       INT,
	re_valor_x_unidad      MONEY,
	re_valor_total         MONEY,
	re_sist_almacenamiento catalogo,
	re_num_cdm             VARCHAR (20),
	re_tipo_tenencia       VARCHAR (20),
	re_cod_mun_almacen     INT,
	re_dir_almacen         descripcion,
	re_margen_red_gar      FLOAT,
	re_tipo_plan           VARCHAR (2),
	re_tipo_tasa           CHAR (1),
	re_plazo               SMALLINT,
	re_fecha_vto_ini       DATETIME,
	re_fecha_vto_fin       DATETIME,
	re_frec_cap            SMALLINT,
	re_abonos_cap          INT,
	re_periodo_gracia      SMALLINT,
	re_frec_int            SMALLINT,
	re_abonos_int          INT,
	re_porc_cap_1          FLOAT,
	re_fecha_hasta_cap     DATETIME,
	re_porc_cap_2          FLOAT,
	re_margen_redescuento  FLOAT,
	re_capital             MONEY,
	re_puntos_tasa         FLOAT,
	re_valor_redescuento   MONEY,
	re_num_deudores        SMALLINT,
	re_num_finagro         INT,
	re_fact_ben_1          DATETIME,
	re_pas_ben_1           MONEY,
	re_fpas_ben_1          DATETIME,
	re_num_desemb          INT,
	re_tnum_desemb         INT,
	re_com_fag             CHAR (1),
	re_fag                 CHAR (1),
	re_revisado            CHAR (1),
	re_porcentaje_fag      FLOAT
	)
GO

CREATE INDEX cr_archivo_redescuento_AKey
	ON dbo.cr_archivo_redescuento (re_llave_redescuento)
GO

CREATE UNIQUE INDEX cr_archivo_redescuento_Key
	ON dbo.cr_archivo_redescuento (re_tramite)
GO

CREATE INDEX cr_archivo_redescuento_Key1
	ON dbo.cr_archivo_redescuento (re_fecha_redes)
GO

CREATE INDEX cr_archivo_redescuento_k1
	ON dbo.cr_archivo_redescuento (re_operacion)
GO

IF OBJECT_ID ('dbo.cr_arch_redes_tamortiz') IS NOT NULL
	DROP TABLE dbo.cr_arch_redes_tamortiz
GO

CREATE TABLE dbo.cr_arch_redes_tamortiz
	(
	re_tramite              INT,
	re_operacion            cuenta,
	re_fecha_envio          DATETIME,
	re_cliente              INT,
	re_cuota_desde_1        SMALLINT,
	re_cuota_hasta_1        SMALLINT,
	re_valor_cuota_1        MONEY,
	re_cuota_desde_2        SMALLINT,
	re_cuota_hasta_2        SMALLINT,
	re_valor_cuota_2        MONEY,
	re_cuota_desde_3        SMALLINT,
	re_cuota_hasta_3        SMALLINT,
	re_valor_cuota_3        MONEY,
	re_cuota_desde_4        SMALLINT,
	re_cuota_hasta_4        SMALLINT,
	re_valor_cuota_4        MONEY,
	re_cuota_desde_5        SMALLINT,
	re_cuota_hasta_5        SMALLINT,
	re_valor_cuota_5        MONEY,
	re_cuota_desde_6        SMALLINT,
	re_cuota_hasta_6        SMALLINT,
	re_valor_cuota_6        MONEY,
	re_cuota_desde_7        SMALLINT,
	re_cuota_hasta_7        SMALLINT,
	re_valor_cuota_7        MONEY,
	re_cuota_desde_8        SMALLINT,
	re_cuota_hasta_8        SMALLINT,
	re_valor_cuota_8        MONEY,
	re_cuota_desde_9        SMALLINT,
	re_cuota_hasta_9        SMALLINT,
	re_valor_cuota_9        MONEY,
	re_cuota_desde_10       SMALLINT,
	re_cuota_hasta_10       SMALLINT,
	re_valor_cuota_10       MONEY,
	re_fecha_amor_1         DATETIME,
	re_valor_amor_1         MONEY,
	re_tipo_amor_1          SMALLINT,
	re_fecha_amor_2         DATETIME,
	re_valor_amor_2         MONEY,
	re_tipo_amor_2          SMALLINT,
	re_fecha_amor_3         DATETIME,
	re_valor_amor_3         MONEY,
	re_tipo_amor_3          SMALLINT,
	re_fecha_amor_4         DATETIME,
	re_valor_amor_4         MONEY,
	re_tipo_amor_4          SMALLINT,
	re_fecha_amor_5         DATETIME,
	re_valor_amor_5         MONEY,
	re_tipo_amor_5          SMALLINT,
	re_fecha_amor_6         DATETIME,
	re_valor_amor_6         MONEY,
	re_tipo_amor_6          SMALLINT,
	re_fecha_amor_7         DATETIME,
	re_valor_amor_7         MONEY,
	re_tipo_amor_7          SMALLINT,
	re_fecha_amor_8         DATETIME,
	re_valor_amor_8         MONEY,
	re_tipo_amor_8          SMALLINT,
	re_fecha_amor_9         DATETIME,
	re_valor_amor_9         MONEY,
	re_tipo_amor_9          SMALLINT,
	re_fecha_amor_10        DATETIME,
	re_valor_amor_10        MONEY,
	re_tipo_amor_10         SMALLINT,
	re_fecha_amor_11        DATETIME,
	re_valor_amor_11        MONEY,
	re_tipo_amor_11         SMALLINT,
	re_fecha_amor_12        DATETIME,
	re_valor_amor_12        MONEY,
	re_tipo_amor_12         SMALLINT,
	re_fecha_amor_13        DATETIME,
	re_valor_amor_13        MONEY,
	re_tipo_amor_13         SMALLINT,
	re_fecha_amor_14        DATETIME,
	re_valor_amor_14        MONEY,
	re_tipo_amor_14         SMALLINT,
	re_fecha_amor_15        DATETIME,
	re_valor_amor_15        MONEY,
	re_tipo_amor_15         SMALLINT,
	re_fecha_amor_16        DATETIME,
	re_valor_amor_16        MONEY,
	re_tipo_amor_16         SMALLINT,
	re_fecha_amor_17        DATETIME,
	re_valor_amor_17        MONEY,
	re_tipo_amor_17         SMALLINT,
	re_fecha_amor_18        DATETIME,
	re_valor_amor_18        MONEY,
	re_tipo_amor_18         SMALLINT,
	re_fecha_amor_19        DATETIME,
	re_valor_amor_19        MONEY,
	re_tipo_amor_19         SMALLINT,
	re_fecha_amor_20        DATETIME,
	re_valor_amor_20        MONEY,
	re_tipo_amor_20         SMALLINT,
	re_fecha_amor_21        DATETIME,
	re_valor_amor_21        MONEY,
	re_tipo_amor_21         SMALLINT,
	re_fecha_amor_22        DATETIME,
	re_valor_amor_22        MONEY,
	re_tipo_amor_22         SMALLINT,
	re_fecha_amor_23        DATETIME,
	re_valor_amor_23        MONEY,
	re_tipo_amor_23         SMALLINT,
	re_fecha_amor_24        DATETIME,
	re_valor_amor_24        MONEY,
	re_tipo_amor_24         SMALLINT,
	re_fecha_amor_25        DATETIME,
	re_valor_amor_25        MONEY,
	re_tipo_amor_25         SMALLINT,
	re_fecha_amor_26        DATETIME,
	re_valor_amor_26        MONEY,
	re_tipo_amor_26         SMALLINT,
	re_fecha_amor_27        DATETIME,
	re_valor_amor_27        MONEY,
	re_tipo_amor_27         SMALLINT,
	re_fecha_amor_28        DATETIME,
	re_valor_amor_28        MONEY,
	re_tipo_amor_28         SMALLINT,
	re_fecha_amor_29        DATETIME,
	re_valor_amor_29        MONEY,
	re_tipo_amor_29         SMALLINT,
	re_fecha_amor_30        DATETIME,
	re_valor_amor_30        MONEY,
	re_tipo_amor_30         SMALLINT,
	re_fecha_amor_31        DATETIME,
	re_valor_amor_31        MONEY,
	re_tipo_amor_31         SMALLINT,
	re_fecha_amor_32        DATETIME,
	re_valor_amor_32        MONEY,
	re_tipo_amor_32         SMALLINT,
	re_fecha_amor_33        DATETIME,
	re_valor_amor_33        MONEY,
	re_tipo_amor_33         SMALLINT,
	re_fecha_amor_34        DATETIME,
	re_valor_amor_34        MONEY,
	re_tipo_amor_34         SMALLINT,
	re_fecha_amor_35        DATETIME,
	re_valor_amor_35        MONEY,
	re_tipo_amor_35         SMALLINT,
	re_fecha_amor_36        DATETIME,
	re_valor_amor_36        MONEY,
	re_tipo_amor_36         SMALLINT,
	re_fecha_amor_37        DATETIME,
	re_valor_amor_37        MONEY,
	re_tipo_amor_37         SMALLINT,
	re_fecha_amor_38        DATETIME,
	re_valor_amor_38        MONEY,
	re_tipo_amor_38         SMALLINT,
	re_fecha_amor_39        DATETIME,
	re_valor_amor_39        MONEY,
	re_tipo_amor_39         SMALLINT,
	re_fecha_amor_40        DATETIME,
	re_valor_amor_40        MONEY,
	re_tipo_amor_40         SMALLINT,
	re_fecha_amor_41        DATETIME,
	re_valor_amor_41        MONEY,
	re_tipo_amor_41         SMALLINT,
	re_fecha_amor_42        DATETIME,
	re_valor_amor_42        MONEY,
	re_tipo_amor_42         SMALLINT,
	re_fecha_amor_43        DATETIME,
	re_valor_amor_43        MONEY,
	re_tipo_amor_43         SMALLINT,
	re_fecha_amor_44        DATETIME,
	re_valor_amor_44        MONEY,
	re_tipo_amor_44         SMALLINT,
	re_fecha_amor_45        DATETIME,
	re_valor_amor_45        MONEY,
	re_tipo_amor_45         SMALLINT,
	re_fecha_amor_46        DATETIME,
	re_valor_amor_46        MONEY,
	re_tipo_amor_46         SMALLINT,
	re_fecha_amor_47        DATETIME,
	re_valor_amor_47        MONEY,
	re_tipo_amor_47         SMALLINT,
	re_fecha_amor_48        DATETIME,
	re_valor_amor_48        MONEY,
	re_tipo_amor_48         SMALLINT,
	re_fecha_amor_49        DATETIME,
	re_valor_amor_49        MONEY,
	re_tipo_amor_49         SMALLINT,
	re_fecha_amor_50        DATETIME,
	re_valor_amor_50        MONEY,
	re_tipo_amor_50         SMALLINT,
	re_fecha_amor_51        DATETIME,
	re_valor_amor_51        MONEY,
	re_tipo_amor_51         SMALLINT,
	re_fecha_amor_52        DATETIME,
	re_valor_amor_52        MONEY,
	re_tipo_amor_52         SMALLINT,
	re_fecha_amor_53        DATETIME,
	re_valor_amor_53        MONEY,
	re_tipo_amor_53         SMALLINT,
	re_fecha_amor_54        DATETIME,
	re_valor_amor_54        MONEY,
	re_tipo_amor_54         SMALLINT,
	re_fecha_amor_55        DATETIME,
	re_valor_amor_55        MONEY,
	re_tipo_amor_55         SMALLINT,
	re_fecha_amor_56        DATETIME,
	re_valor_amor_56        MONEY,
	re_tipo_amor_56         SMALLINT,
	re_fecha_amor_57        DATETIME,
	re_valor_amor_57        MONEY,
	re_tipo_amor_57         SMALLINT,
	re_fecha_amor_58        DATETIME,
	re_valor_amor_58        MONEY,
	re_tipo_amor_58         SMALLINT,
	re_fecha_amor_59        DATETIME,
	re_valor_amor_59        MONEY,
	re_tipo_amor_59         SMALLINT,
	re_fecha_amor_60        DATETIME,
	re_valor_amor_60        MONEY,
	re_tipo_amor_60         SMALLINT,
	re_cod_rubro_ppal       CHAR (6),
	re_cant_unid_finan_ppal INT,
	re_costo_inv_rubro_ppal MONEY,
	re_valor_fin_rubro_ppal MONEY,
	re_cod_rubro_2          CHAR (6),
	re_cant_unid_finan_2    INT,
	re_costo_inv_rubro_2    MONEY,
	re_valor_fin_rubro_2    MONEY,
	re_cod_rubro_3          CHAR (6),
	re_cant_unid_finan_3    INT,
	re_costo_inv_rubro_3    MONEY,
	re_valor_fin_rubro_3    MONEY,
	re_cod_rubro_4          CHAR (6),
	re_cant_unid_finan_4    INT,
	re_costo_inv_rubro_4    MONEY,
	re_valor_fin_rubro_4    MONEY,
	re_cod_rubro_5          CHAR (6),
	re_cant_unid_finan_5    INT,
	re_costo_inv_rubro_5    MONEY,
	re_valor_fin_rubro_5    MONEY,
	re_codesamo             TINYINT,
	re_covalgir             TINYINT,
	re_copermue             TINYINT
	)
GO

CREATE INDEX cr_arch_redes_tamortiz_AKey
	ON dbo.cr_arch_redes_tamortiz (re_fecha_envio)
GO

CREATE UNIQUE INDEX cr_arch_redes_tamortiz_Key
	ON dbo.cr_arch_redes_tamortiz (re_tramite)
GO

IF OBJECT_ID ('dbo.cr_altura_mora') IS NOT NULL
	DROP TABLE dbo.cr_altura_mora
GO

CREATE TABLE dbo.cr_altura_mora
	(
	am_fecha            DATETIME,
	am_banco            cuenta,
	am_codigo_honorario INT,
	am_estado_cobranza  catalogo,
	am_dias_mora        SMALLINT,
	am_anio_castigo     SMALLINT
	)
GO

IF OBJECT_ID ('dbo.cr_agenda') IS NOT NULL
	DROP TABLE dbo.cr_agenda
GO

CREATE TABLE dbo.cr_agenda
	(
	ag_oficial             SMALLINT NOT NULL,
	ag_ente                INT NOT NULL,
	ag_visita              INT NOT NULL,
	ag_fecha_desde         DATETIME,
	ag_fecha_hasta         DATETIME,
	ag_fecha_visita        DATETIME,
	ag_comentarios         SMALLINT,
	ag_conclusiones        SMALLINT,
	ag_fecha_reporte       DATETIME,
	ag_fecha_conf          DATETIME,
	ag_usuario_conf        login,
	ag_categoria           catalogo,
	ag_planificador        catalogo,
	ag_tramite             INT,
	ag_fecha_ini_proyecto  DATETIME,
	ag_valor_visita        MONEY,
	ag_op_operacion        INT,
	ag_op_banco            CHAR (24),
	ag_en_ced_ruc          VARCHAR (30),
	ag_descripcion_negocio VARCHAR (254),
	ag_di_barrio_neg       VARCHAR (40),
	ag_te_valor_negocio    VARCHAR (16),
	ag_te_valor_resid      VARCHAR (16),
	ag_fecha_solic_cancel  DATETIME,
	ag_fecha_captura_dom   DATETIME,
	ag_ejecutivo_dom       SMALLINT,
	ag_concepto_visita_dom VARCHAR (250),
	ag_fecha_captura_neg   DATETIME,
	ag_ejecutivo_neg       SMALLINT,
	ag_concepto_visita_neg VARCHAR (250),
	ag_no_renueva          TINYINT
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_agenda_Key
	ON dbo.cr_agenda (ag_oficial, ag_ente, ag_visita)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX cr_agenda_AKey
	ON dbo.cr_agenda (ag_ente, ag_fecha_visita)
GO

IF OBJECT_ID ('dbo.cr_adicmir_bcp71') IS NOT NULL
	DROP TABLE dbo.cr_adicmir_bcp71
GO

CREATE TABLE dbo.cr_adicmir_bcp71
	(
	da_banco      VARCHAR (30),
	da_tramite    INT,
	da_fecha_ini  DATETIME,
	da_cliente    INT,
	da_cedula     VARCHAR (30),
	da_activos    MONEY,
	da_patromonio MONEY,
	da_otrosingre MONEY,
	da_gastosfami MONEY,
	da_tiempo_neg INT,
	da_nota       TINYINT
	)
GO

IF OBJECT_ID ('dbo.cr_acuerdo_vencimiento_tmp') IS NOT NULL
	DROP TABLE dbo.cr_acuerdo_vencimiento_tmp
GO

CREATE TABLE dbo.cr_acuerdo_vencimiento_tmp
	(
	av_usuario login NOT NULL,
	av_sesion  INT NOT NULL,
	av_acuerdo INT NOT NULL,
	av_fecha   DATETIME NOT NULL,
	av_monto   MONEY NOT NULL,
	av_hono    MONEY NOT NULL,
	av_neto    MONEY NOT NULL,
	av_gracia  INT NOT NULL,
	av_estado  CHAR (2) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_acuerdo_vencimiento_his') IS NOT NULL
	DROP TABLE dbo.cr_acuerdo_vencimiento_his
GO

CREATE TABLE dbo.cr_acuerdo_vencimiento_his
	(
	av_acuerdo      INT NOT NULL,
	av_fecha        DATETIME NOT NULL,
	av_monto        MONEY NOT NULL,
	av_hono         MONEY NOT NULL,
	av_neto         MONEY NOT NULL,
	av_gracia       INT NOT NULL,
	av_estado       CHAR (2) NOT NULL,
	av_fecha_estado DATETIME,
	av_usario       login NOT NULL,
	av_oficina      INT NOT NULL,
	av_fecha_mod    DATETIME NOT NULL,
	av_hora         DATETIME NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_acuerdo_vencimiento') IS NOT NULL
	DROP TABLE dbo.cr_acuerdo_vencimiento
GO

CREATE TABLE dbo.cr_acuerdo_vencimiento
	(
	av_acuerdo      INT NOT NULL,
	av_fecha        DATETIME NOT NULL,
	av_monto        MONEY NOT NULL,
	av_hono         MONEY NOT NULL,
	av_neto         MONEY NOT NULL,
	av_gracia       INT NOT NULL,
	av_estado       CHAR (2) NOT NULL,
	av_fecha_estado DATETIME
	)
GO

CREATE INDEX idx1
	ON dbo.cr_acuerdo_vencimiento (av_acuerdo, av_fecha)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cr_acuerdo_his') IS NOT NULL
	DROP TABLE dbo.cr_acuerdo_his
GO

CREATE TABLE dbo.cr_acuerdo_his
	(
	ac_acuerdo             INT NOT NULL,
	ac_tacuerdo            CHAR (1) NOT NULL,
	ac_banco               cuenta NOT NULL,
	ac_producto            INT NOT NULL,
	ac_usr_ingreso         login NOT NULL,
	ac_fecha_ingreso       DATETIME NOT NULL,
	ac_usr_modif           login,
	ac_fecha_modif         DATETIME,
	ac_fecha_proy          DATETIME NOT NULL,
	ac_cuotas_vencidas     INT NOT NULL,
	ac_dias_mora           INT NOT NULL,
	ac_saldo_cap           MONEY NOT NULL,
	ac_saldo_int           MONEY NOT NULL,
	ac_saldo_imo           MONEY NOT NULL,
	ac_saldo_honabo        MONEY NOT NULL,
	ac_saldo_ivahonabo     MONEY NOT NULL,
	ac_saldo_otros         MONEY NOT NULL,
	ac_saldo_int_pry       MONEY NOT NULL,
	ac_saldo_imo_pry       MONEY NOT NULL,
	ac_saldo_honabo_pry    MONEY NOT NULL,
	ac_saldo_ivahonabo_pry MONEY NOT NULL,
	ac_saldo_otros_pry     MONEY NOT NULL,
	ac_secuencial_rpa      INT,
	ac_cap_cond            MONEY NOT NULL,
	ac_int_cond            MONEY NOT NULL,
	ac_imo_cond            MONEY NOT NULL,
	ac_otr_cond            MONEY NOT NULL,
	ac_int_cond_pry        MONEY NOT NULL,
	ac_imo_cond_pry        MONEY NOT NULL,
	ac_otr_cond_pry        MONEY NOT NULL,
	ac_porc_cond_cap       FLOAT NOT NULL,
	ac_porc_cond_int       FLOAT NOT NULL,
	ac_porc_cond_imo       FLOAT NOT NULL,
	ac_porc_cond_otr       FLOAT NOT NULL,
	ac_max_dias_ac         SMALLINT NOT NULL,
	ac_tipo_cobro_org      CHAR (1) NOT NULL,
	ac_estado              CHAR (1) NOT NULL,
	ac_usario              login NOT NULL,
	ac_oficina             INT NOT NULL,
	ac_fecha_mod           DATETIME NOT NULL,
	ac_hora                DATETIME NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_acuerdo') IS NOT NULL
	DROP TABLE dbo.cr_acuerdo
GO

CREATE TABLE dbo.cr_acuerdo
	(
	ac_acuerdo             INT NOT NULL,
	ac_tacuerdo            CHAR (1) NOT NULL,
	ac_banco               cuenta NOT NULL,
	ac_producto            INT NOT NULL,
	ac_usr_ingreso         login NOT NULL,
	ac_fecha_ingreso       DATETIME NOT NULL,
	ac_usr_modif           login,
	ac_fecha_modif         DATETIME,
	ac_fecha_proy          DATETIME NOT NULL,
	ac_cuotas_vencidas     INT NOT NULL,
	ac_dias_mora           INT NOT NULL,
	ac_saldo_cap           MONEY NOT NULL,
	ac_saldo_int           MONEY NOT NULL,
	ac_saldo_imo           MONEY NOT NULL,
	ac_saldo_honabo        MONEY NOT NULL,
	ac_saldo_ivahonabo     MONEY NOT NULL,
	ac_saldo_otros         MONEY NOT NULL,
	ac_saldo_int_pry       MONEY NOT NULL,
	ac_saldo_imo_pry       MONEY NOT NULL,
	ac_saldo_honabo_pry    MONEY NOT NULL,
	ac_saldo_ivahonabo_pry MONEY NOT NULL,
	ac_saldo_otros_pry     MONEY NOT NULL,
	ac_secuencial_rpa      INT,
	ac_cap_cond            MONEY NOT NULL,
	ac_int_cond            MONEY NOT NULL,
	ac_imo_cond            MONEY NOT NULL,
	ac_otr_cond            MONEY NOT NULL,
	ac_int_cond_pry        MONEY NOT NULL,
	ac_imo_cond_pry        MONEY NOT NULL,
	ac_otr_cond_pry        MONEY NOT NULL,
	ac_porc_cond_cap       FLOAT NOT NULL,
	ac_porc_cond_int       FLOAT NOT NULL,
	ac_porc_cond_imo       FLOAT NOT NULL,
	ac_porc_cond_otr       FLOAT NOT NULL,
	ac_max_dias_ac         SMALLINT NOT NULL,
	ac_tipo_cobro_org      CHAR (1) NOT NULL,
	ac_estado              CHAR (1) NOT NULL,
	ac_pago_cubierto       CHAR (1)
	)
GO

CREATE INDEX idx1
	ON dbo.cr_acuerdo (ac_acuerdo)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX idx2
	ON dbo.cr_acuerdo (ac_banco)
	WITH (FILLFACTOR = 75)
GO

CREATE INDEX idx3
	ON dbo.cr_acuerdo (ac_fecha_ingreso)
	WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.cr_act_financiar') IS NOT NULL
	DROP TABLE dbo.cr_act_financiar
GO

CREATE TABLE dbo.cr_act_financiar
	(
	af_mercado       catalogo NOT NULL,
	af_desc_mercado  VARCHAR (60) NOT NULL,
	af_destino       catalogo NOT NULL,
	af_desc_destino  VARCHAR (60) NOT NULL,
	af_act_financiar catalogo NOT NULL,
	af_desc_act      VARCHAR (60) NOT NULL,
	af_estado        CHAR (1) NOT NULL,
	af_usuario       login NOT NULL
	)
GO

CREATE UNIQUE INDEX i_idx_cr_act_financiar
	ON dbo.cr_act_financiar (af_mercado, af_destino, af_act_financiar)
	WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.cr_acciones') IS NOT NULL
	DROP TABLE dbo.cr_acciones
GO

CREATE TABLE dbo.cr_acciones
	(
	ac_cobranza    VARCHAR (10) NOT NULL,
	ac_numero      INT,
	ac_taccion     catalogo NOT NULL,
	ac_proceso     catalogo NOT NULL,
	ac_etapa       catalogo NOT NULL,
	ac_estado      catalogo NOT NULL,
	ac_descripcion VARCHAR (255),
	ac_fecha       DATETIME,
	ac_funcionario login NOT NULL,
	ac_fecha_rev   DATETIME,
	ac_abogado     VARCHAR (20),
	ac_monto_compr MONEY,
	ac_fecha_compr DATETIME,
	ac_tipo_gestor catalogo,
	ac_id_gestor   VARCHAR (32)
	)
GO

CREATE INDEX cr_acciones_AKey
	ON dbo.cr_acciones (ac_cobranza, ac_estado, ac_proceso, ac_etapa, ac_numero)
GO

CREATE UNIQUE INDEX cr_acciones_Key
	ON dbo.cr_acciones (ac_cobranza, ac_numero)
GO

CREATE INDEX idx3
	ON dbo.cr_acciones (ac_fecha, ac_cobranza)
GO

IF OBJECT_ID ('dbo.cr_abogado') IS NOT NULL
	DROP TABLE dbo.cr_abogado
GO

CREATE TABLE dbo.cr_abogado
	(
	ab_abogado       catalogo NOT NULL,
	ab_cliente       INT,
	ab_tipo          CHAR (1) NOT NULL,
	ab_nombre        descripcion,
	ab_direccion     VARCHAR (255),
	ab_ciudad        INT NOT NULL,
	ab_login         login,
	ab_cuenta        cuenta,
	ab_tipo_cuenta   VARCHAR (5),
	ab_tarjeta       VARCHAR (64),
	ab_especialidad  catalogo,
	ab_clase_interno catalogo,
	ab_calificacion  CHAR (1),
	ab_fecha_cal     DATETIME,
	ab_tasa          FLOAT,
	ab_id_abogado    VARCHAR (32)
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_abogado_Key
	ON dbo.cr_abogado (ab_abogado)
GO

CREATE INDEX cr_abogado_AKey
	ON dbo.cr_abogado (ab_cliente)
GO

IF OBJECT_ID ('dbo.cl_val_arch') IS NOT NULL
	DROP TABLE dbo.cl_val_arch
GO

CREATE TABLE dbo.cl_val_arch
	(
	registros VARCHAR (255)
	)
GO


IF OBJECT_ID ('dbo.cr_situacion_cliente') IS NOT NULL
 DROP TABLE dbo.cr_situacion_cliente
GO
CREATE TABLE dbo.cr_situacion_cliente  (
	sc_tramite       	int NULL,
	sc_usuario       	login NULL,
	sc_secuencia     	int NULL,
	sc_tipo_con      	char(1) NULL,
	sc_cliente_con   	int NULL,
	sc_cliente       	int NULL,
	sc_identico      	int NULL,
	sc_rol           	char(1) NULL,
	sc_nombre_cliente	varchar(254) NULL
	)
GO


IF OBJECT_ID ('dbo.cr_deud1_tmp') IS NOT NULL
 DROP TABLE dbo.cr_deud1_tmp
GO
CREATE TABLE [dbo].[cr_deud1_tmp]  (
	[spid]              	smallint NULL,
	[cliente]           	int NOT NULL,
	[producto]          	varchar(10) NOT NULL,
	[tipo_operacion]    	varchar(10) NOT NULL,
	[desc_tipo_op]      	varchar(64) NULL,
	[operacion]         	varchar(24) NULL,
	[linea]             	varchar(24) NULL,
	[tramite]           	int NOT NULL,
	[fecha_apt]         	char(10) NOT NULL,
	[fecha_vto]         	char(10) NOT NULL,
	[desc_moneda]       	varchar(10) NULL,
	[monto_orig]        	money NULL,
	[saldo_vencido]     	money NOT NULL,
	[saldo_cuota]       	money NOT NULL,
	[subtotal]          	money NOT NULL,
	[saldo_capital]     	money NOT NULL,
	[valorcontrato]     	money NOT NULL,
	[saldo_total]       	money NOT NULL,
	[saldo_ml]          	money NOT NULL,
	[tasa]              	varchar(12) NOT NULL,
	[refinanciamiento]  	char(2) NULL,
	[prox_fecha_pag_int]	char(10) NULL,
	[ult_fecha_pg]      	char(10) NULL,
	[estado_conta]      	varchar(64) NOT NULL,
	[clasificacion]     	varchar(64) NULL,
	[estado]            	varchar(64) NULL,
	[tipocar]           	char(1) NOT NULL,
	[moneda]            	tinyint NULL,
	[rol]               	char(1) NULL,
	[cod_estado]        	varchar(10) NULL,
	[nombre_cliente]    	varchar(254) NOT NULL,
	[tipo_deuda]        	char(1) NOT NULL,
	[dias_atraso]       	int NOT NULL,
	[plazo]             	int NULL,
	[motivo_credito]    	varchar(64) NULL,
	[tipo_plazo]        	varchar(64) NULL,
	[restructuracion]   	char(1) NULL,
	[fecha_cancelacion] 	datetime NULL,
	[refinanciado]      	char(1) NULL,
	[calificacion]      	char(1) NULL,
	[etapa_act]         	varchar(255) NULL,
	[id_inst_act]       	int NULL,
	[codigo_alterno]    	varchar(50) NULL
	)
GO



IF OBJECT_ID ('dbo.cr_gar_tmp') IS NOT NULL
 DROP TABLE dbo.cr_gar_tmp
GO
CREATE TABLE dbo.cr_gar_tmp  (
	spid             	smallint NULL,
	CLIENTE          	int NOT NULL,
	TIPO_GAR         	varchar(10) NOT NULL,
	DESC_GAR         	varchar(255) NOT NULL,
	CODIGO           	varchar(64) NOT NULL,
	MONEDA           	varchar(10) NOT NULL,
	VALOR_INI        	money NOT NULL,
	VALOR_ACT        	money NOT NULL,
	VALOR_ACT_ML     	money NOT NULL,
	PORCENTAJE       	float NOT NULL,
	MRC              	money NOT NULL,
	ESTADO           	char(1) NOT NULL,
	PLAZO_FIJO       	varchar(30) NULL,
	TIPO_CTA         	varchar(64) NOT NULL,
	FIADOR           	varchar(64) NOT NULL,
	ID_FIADOR        	varchar(30) NOT NULL,
	CUSTODIA         	int NOT NULL,
	nombre_cliente   	varchar(254) NOT NULL,
	fechaCancelacion 	datetime NULL,
	fechaActivacion  	datetime NULL,
	VALOR_REALIZACION	money NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_gar_p_tmp') IS NOT NULL
 DROP TABLE dbo.cr_gar_p_tmp
GO
CREATE TABLE dbo.cr_gar_p_tmp  (
	spid            	smallint NULL,
	CLIENTE         	int NOT NULL,
	TIPO_GAR        	varchar(15) NOT NULL,
	DESC_GAR        	varchar(64) NOT NULL,
	CODIGO          	varchar(64) NOT NULL,
	MONEDA          	varchar(10) NOT NULL,
	VALOR_INI       	money NOT NULL,
	VALOR_ACT       	money NOT NULL,
	VALOR_ACT_ML    	money NOT NULL,
	PORCENTAJE      	float NOT NULL,
	MRC             	money NOT NULL,
	ESTADO          	char(1) NOT NULL,
	PLAZO_FIJO      	varchar(30) NOT NULL,
	TIPO_CTA        	varchar(64) NOT NULL,
	FIADOR          	varchar(64) NOT NULL,
	ID_FIADOR       	varchar(30) NOT NULL,
	nombre_cliente  	varchar(254) NOT NULL,
	fechaCancelacion	datetime NOT NULL,
	fechaActivacion 	datetime NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_deudas') IS NOT NULL
 DROP TABLE dbo.cr_situacion_deudas
GO
CREATE TABLE dbo.cr_situacion_deudas  (
	sd_cliente          	int NULL,
	sd_usuario          	login NULL,
	sd_secuencia        	int NULL,
	sd_tipo_con         	char(1) NULL,
	sd_cliente_con      	int NULL,
	sd_identico         	int NULL,
	sd_categoria        	catalogo NULL,
	sd_desc_categoria   	varchar(64) NULL,
	sd_producto         	catalogo NULL,
	sd_tipo_op          	catalogo NULL,
	sd_desc_tipo_op     	varchar(64) NULL,
	sd_tramite          	int NULL,
	sd_numero_operacion 	cuenta NULL,
	sd_operacion        	int NULL,
	sd_tasa             	float NULL,
	sd_fecha_apr        	datetime NULL,
	sd_fecha_vct        	datetime NULL,
	sd_monto            	money NULL,
	sd_saldo_vencido    	money NULL,
	sd_saldo_x_vencer   	money NULL,
	sd_monto_ml         	money NULL,
	sd_moneda           	tinyint NULL,
	sd_prox_pag_int     	datetime NULL,
	sd_ult_fecha_pg     	datetime NULL,
	sd_val_utilizado    	money NULL,
	sd_val_utilizado_ml 	money NULL,
	sd_limite_credito   	money NULL,
	sd_total_cargos     	money NULL,
	sd_saldo_promedio   	money NULL,
	sd_ult_fecha_mov    	datetime NULL,
	sd_aprobado         	char(1) NULL,
	sd_tarjeta_visa     	cuenta NULL,
	sd_tramite_d        	int NULL,
	sd_subtipo          	catalogo NULL,
	sd_tipo_deuda       	char(1) NULL,
	sd_calificacion     	descripcion NULL,
	sd_estado           	descripcion NULL,
	sd_fechas_embarque  	descripcion NULL,
	sd_monto_riesgo     	money NULL,
	sd_beneficiario     	descripcion NULL,
	sd_tipo_garantia    	catalogo NULL,
	sd_descrip_gar      	descripcion NULL,
	sd_monto_orig       	money NULL,
	sd_tipoop_car       	char(1) NULL,
	sd_contrato_act     	money NULL,
	sd_rol              	char(1) NULL,
	sd_dias_atraso      	int NULL,
	sd_tipo_plazo       	descripcion NULL,
	sd_plazo            	int NULL,
	sd_motivo_credito   	descripcion NULL,
	sd_tipo_tramite     	char(1) NULL,
	sd_fecha_cancelacion	datetime NULL,
	sd_refinanciamiento 	char(1) NULL,
	sd_restructuracion  	char(1) NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_inversiones') IS NOT NULL
 DROP TABLE dbo.cr_situacion_inversiones
GO
CREATE TABLE [dbo].[cr_situacion_inversiones]  (
	[si_cliente]          	int NULL,
	[si_tramite]          	int NULL,
	[si_usuario]          	login NULL,
	[si_secuencia]        	int NULL,
	[si_tipo_con]         	char(1) NULL,
	[si_cliente_con]      	int NULL,
	[si_identico]         	int NULL,
	[si_categoria]        	catalogo NULL,
	[si_desc_categoria]   	varchar(64) NULL,
	[si_producto]         	catalogo NULL,
	[si_tipo_op]          	catalogo NULL,
	[si_desc_tipo_op]     	varchar(64) NULL,
	[si_numero_operacion] 	cuenta NULL,
	[si_tasa]             	float NULL,
	[si_fecha_apt]        	datetime NULL,
	[si_fecha_vct]        	datetime NULL,
	[si_moneda]           	tinyint NULL,
	[si_saldo]            	money NULL,
	[si_saldo_ml]         	money NULL,
	[si_saldo_promedio]   	money NULL,
	[si_interes_acumulado]	money NULL,
	[si_valor_garantia]   	money NULL,
	[si_fecha_ult_mov]    	datetime NULL,
	[si_fecha_prox_p_int] 	datetime NULL,
	[si_fecha_utl_p_int]  	datetime NULL,
	[si_val_nominal]      	float NULL,
	[si_precio_mercado]   	float NULL,
	[si_valor_mercado]    	float NULL,
	[si_monto_prendado]   	float NULL,
	[si_precio_compra]    	float NULL,
	[si_monto_compra]     	float NULL,
	[si_valor_mercado_ml] 	float NULL,
	[si_operacion]        	int NULL,
	[si_estado]           	catalogo NULL,
	[si_desc_estado]      	descripcion NULL,
	[si_login]            	login NULL,
	[si_rol]              	char(1) NULL,
	[si_bloqueos]         	money NULL,
	[si_plazo]            	int NULL,
	[si_fecha_can]        	datetime NULL,
	[si_oficina]          	smallint NULL,
	[si_desc_oficina]     	descripcion NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_lineas') IS NOT NULL
 DROP TABLE dbo.cr_situacion_lineas
GO
CREATE TABLE dbo.cr_situacion_lineas  (
	sl_cliente        	int NULL,
	sl_usuario        	login NULL,
	sl_secuencia      	int NULL,
	sl_tipo_con       	char(1) NULL,
	sl_cliente_con    	int NULL,
	sl_identico       	int NULL,
	sl_producto       	catalogo NULL,
	sl_tramite        	int NULL,
	sl_sector         	catalogo NULL,
	sl_numero_op_banco	varchar(64) NULL,
	sl_linea          	int NULL,
	sl_fecha_apr      	datetime NULL,
	sl_fecha_vct      	datetime NULL,
	sl_val_utilizado  	money NULL,
	sl_limite_credito 	money NULL,
	sl_moneda         	tinyint NULL,
	sl_utilizado_ml   	money NULL,
	sl_tipo          	catalogo NULL,
	sl_desc_tipo      	descripcion NULL,
	sl_tramite_d      	int NULL,
	sl_disponible     	money NULL,
	sl_disponible_ml  	money NULL,
	sl_tasa           	float NULL,
	sl_execeso        	money NULL,
	sl_tipo_deuda     	char(1) NULL,
	sl_valor_contrato 	money NULL,
	sl_monto_factoring	money NULL,
	sl_saldo_capital  	money NULL,
	sl_monto_riesgo   	money NULL,
	sl_emisor         	descripcion NULL,
	sl_estado         	catalogo NULL,
	sl_desc_estado    	descripcion NULL,
	sl_frecuencia     	varchar(64) NULL,
	sl_plazo          	int NULL,
	sl_rol            	varchar(25) NULL,
	sl_tipo_rotativo  	varchar(25) NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_otras') IS NOT NULL
 DROP TABLE dbo.cr_situacion_otras
GO
CREATE TABLE dbo.cr_situacion_otras  (
	so_cliente         	int NULL,
	so_usuario         	login NULL,
	so_secuencia       	int NULL,
	so_tipo_con        	char(1) NULL,
	so_cliente_con     	int NULL,
	so_identico        	int NULL,
	so_categoria       	catalogo NULL,
	so_desc_categoria  	varchar(64) NULL,
	so_producto        	catalogo NULL,
	so_tipo_op         	catalogo NULL,
	so_desc_tipo_op    	varchar(64) NULL,
	so_tramite         	int NULL,
	so_numero_operacion	cuenta NULL,
	so_operacion       	int NULL,
	so_tasa            	float NULL,
	so_fecha_apr       	datetime NULL,
	so_fecha_vct       	datetime NULL,
	so_monto           	money NULL,
	so_saldo_vencido   	money NULL,
	so_saldo_x_vencer  	money NULL,
	so_monto_ml        	money NULL,
	so_moneda          	tinyint NULL,
	so_prox_pag_int    	datetime NULL,
	so_ult_fecha_pg    	datetime NULL,
	so_val_utilizado   	money NULL,
	so_val_utilizado_ml	money NULL,
	so_limite_credito  	money NULL,
	so_total_cargos    	money NULL,
	so_saldo_promedio  	money NULL,
	so_ult_fecha_mov   	datetime NULL,
	so_aprobado        	char(1) NULL,
	so_tarjeta_visa    	cuenta NULL,
	so_tramite_d       	int NULL,
	so_subtipo         	catalogo NULL,
	so_tipo_deuda      	char(1) NULL,
	so_calificacion    	descripcion NULL,
	so_estado          	descripcion NULL,
	so_fechas_embarque 	descripcion NULL,
	so_monto_riesgo    	money NULL,
	so_beneficiario    	descripcion NULL,
	so_clase_garantia  	varchar(10) NULL,
	so_rol             	varchar(25) NULL
	)
GO
IF OBJECT_ID ('dbo.cb_cotizaciones') IS NOT NULL
 DROP TABLE dbo.cb_cotizaciones
GO
CREATE TABLE dbo.cb_cotizaciones  (
	ct_fecha 	datetime NULL,
	ct_moneda	tinyint NULL,
	ct_valor 	float NOT NULL,
	ct_compra	float NULL,
	ct_venta 	float NULL
	)
GO
IF OBJECT_ID ('dbo.cr_situacion_gar') IS NOT NULL
 DROP TABLE dbo.cr_situacion_gar
GO
CREATE TABLE dbo.cr_situacion_gar  (
	sg_cliente         	int NULL,
	sg_tramite         	int NULL,
	sg_usuario         	login NULL,
	sg_secuencia       	int NULL,
	sg_tipo_con        	char(1) NULL,
	sg_cliente_con     	int NULL,
	sg_identico        	int NULL,
	sg_producto        	catalogo NULL,
	sg_tipo_gar        	catalogo NULL,
	sg_desc_gar        	varchar(255) NULL,
	sg_codigo          	varchar(64) NULL,
	sg_moneda          	tinyint NULL,
	sg_valor_ini       	money NULL,
	sg_valor_act       	money NULL,
	sg_valor_act_ml    	money NULL,
	sg_estado          	char(1) NULL,
	sg_pfijo           	varchar(30) NULL,
	sg_fiador          	varchar(60) NULL,
	sg_id_fiador       	numero NULL,
	sg_tramite_gar     	int NULL,
	sg_porc_mrc        	float NULL,
	sg_valor_mrc       	money NULL,
	sg_custodia        	int NULL,
	sg_fechaCancelacion	datetime NULL,
	sg_fechaActivacion 	datetime NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_gar_p') IS NOT NULL
 DROP TABLE dbo.cr_situacion_gar_p
GO
CREATE TABLE dbo.cr_situacion_gar_p  (
	sg_p_cliente       	int NULL,
	sg_p_tramite       	int NULL,
	sg_p_usuario       	login NULL,
	sg_p_secuencia     	int NULL,
	sg_p_tipo_con      	char(1) NULL,
	sg_p_cliente_con   	int NULL,
	sg_p_identico      	int NULL,
	sg_p_producto      	catalogo NULL,
	sg_p_tipo_gar      	catalogo NULL,
	sg_p_desc_gar      	varchar(255) NULL,
	sg_p_codigo        	varchar(64) NULL,
	sg_p_moneda        	tinyint NULL,
	sg_p_valor_ini     	money NULL,
	sg_p_valor_act     	money NULL,
	sg_p_valor_act_ml  	money NULL,
	sg_p_estado        	char(1) NULL,
	sg_p_fijo          	varchar(30) NULL,
	sg_p_fiador        	varchar(60) NULL,
	sg_p_id_fiador     	numero NULL,
	sg_p_tramite_gar   	int NULL,
	sg_p_porc_mrc      	float NULL,
	sg_p_valor_mrc     	money NULL,
	sg_fechaCancelacion	datetime NULL,
	sg_fechaActivacion 	datetime NULL
	)
GO

IF OBJECT_ID ('dbo.cr_errorlog') IS NOT NULL
 DROP TABLE dbo.cr_errorlog
GO
CREATE TABLE dbo.cr_errorlog
 (
 er_fecha_proc  DATETIME NOT NULL,
 er_error       INT NULL,
 er_usuario     login NULL,
 er_tran        INT NULL,
 er_cuenta      cuenta NULL,
 er_descripcion VARCHAR (255) NULL
 )
GO
CREATE NONCLUSTERED INDEX cr_errorlog_K1
 ON dbo.cr_errorlog (er_fecha_proc)
GO

IF OBJECT_ID ('dbo.cr_oper_cons') IS NOT NULL
 DROP TABLE dbo.cr_oper_cons
GO
CREATE TABLE dbo.cr_oper_cons
 (
 os_producto        TINYINT NOT NULL,
 os_operacion       VARCHAR (24) NOT NULL,
 os_cliente         INT NOT NULL,
 os_toperacion      VARCHAR (10) NOT NULL,
 os_moneda          TINYINT NOT NULL,
 os_estado_contable TINYINT NOT NULL,
 os_saldo           MONEY NULL,
 os_clase           catalogo NOT NULL
 )
GO
CREATE NONCLUSTERED INDEX cr_oper_cons_key1
 ON dbo.cr_oper_cons (os_operacion)
GO

IF OBJECT_ID ('dbo.cr_tramite_grupal') IS NOT NULL
 DROP TABLE dbo.cr_tramite_grupal
GO
CREATE TABLE dbo.cr_tramite_grupal
 (
 tg_tramite           INT NOT NULL,
 tg_grupo             INT NOT NULL,
 tg_cliente           INT NOT NULL,
 tg_monto             MONEY NOT NULL,
 tg_grupal            CHAR (1) NOT NULL,
 tg_operacion         INT          not NULL,
 tg_prestamo          VARCHAR (15) not NULL,
 tg_referencia_grupal VARCHAR (15) not NULL,
 tg_cuenta            VARCHAR (45) NULL,
 tg_cheque            INT NULL,
 tg_participa_ciclo   CHAR (1) NULL,
 tg_monto_aprobado    MONEY NULL,
 tg_ahorro            MONEY NULL,
 tg_monto_max         MONEY NULL,
 tg_bc_ln             CHAR (10) NULL,
 tg_incremento        numeric(8,4) NULL,
 tg_monto_ult_op      money NULL,
 tg_monto_max_calc    MONEY NULL,
 tg_nueva_op          int,
 tg_monto_min_calc    MONEY NULL,
 tg_monto_cuenta_ref  money null
 )
GO
CREATE CLUSTERED INDEX idx1
 ON dbo.cr_tramite_grupal (tg_tramite,tg_cliente)
GO
CREATE NONCLUSTERED INDEX idx2
 ON dbo.cr_tramite_grupal (tg_cliente,tg_grupo)
GO

if not exists(select 1 from sys.indexes 
              where name = 'idx4' 
              and object_id = OBJECT_ID('cr_tramite_grupal'))
begin              
    create nonclustered index idx4 ON cr_tramite_grupal (tg_grupo, tg_tramite)
end 




IF OBJECT_ID ('dbo.cr_errorlog') IS NOT NULL
 DROP TABLE dbo.cr_errorlog
GO
CREATE TABLE dbo.cr_errorlog
 (
 er_fecha_proc  DATETIME NOT NULL,
 er_error       INT NULL,
 er_usuario     login NULL,
 er_tran        INT NULL,
 er_cuenta      cuenta NULL,
 er_descripcion VARCHAR (255) NULL
 )
GO
CREATE NONCLUSTERED INDEX cr_errorlog_K1
 ON dbo.cr_errorlog (er_fecha_proc)
GO

IF OBJECT_ID ('dbo.cr_oper_cons') IS NOT NULL
 DROP TABLE dbo.cr_oper_cons
GO
CREATE TABLE dbo.cr_oper_cons
 (
 os_producto        TINYINT NOT NULL,
 os_operacion       VARCHAR (24) NOT NULL,
 os_cliente         INT NOT NULL,
 os_toperacion      VARCHAR (10) NOT NULL,
 os_moneda          TINYINT NOT NULL,
 os_estado_contable TINYINT NOT NULL,
 os_saldo           MONEY NULL,
 os_clase           catalogo NOT NULL
 )
GO
CREATE NONCLUSTERED INDEX cr_oper_cons_key1
 ON dbo.cr_oper_cons (os_operacion)
GO

IF OBJECT_ID ('dbo.campos') IS NOT NULL
	DROP TABLE dbo.campos
GO

CREATE TABLE dbo.campos
	(
	campo VARCHAR (50) NOT NULL,
	sec   INT IDENTITY NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cabecera') IS NOT NULL
	DROP TABLE dbo.cabecera
GO

CREATE TABLE dbo.cabecera
	(
	cadena VARCHAR (255)
	)
GO

IF OBJECT_ID ('dbo.ca_vencimiento_reajuste_t1') IS NOT NULL
	DROP TABLE dbo.ca_vencimiento_reajuste_t1
GO

CREATE TABLE dbo.ca_vencimiento_reajuste_t1
	(
	sp_id             INT NOT NULL,
	s_term            descripcion,
	op_operacion      INT,
	op_toperacion     catalogo,
	op_moneda         TINYINT,
	op_banco          cuenta,
	op_monto          MONEY,
	op_cliente        INT,
	op_nombre         descripcion,
	op_fecha_ini      DATETIME,
	di_dividendo      SMALLINT,
	di_fecha_ven      DATETIME,
	op_cuota          MONEY,
	op_fecha_fin      DATETIME,
	op_fecha_reajuste DATETIME,
	op_tipo_linea     catalogo,
	vr_plazo          VARCHAR (30),
	vr_oficial        VARCHAR (30),
	vr_saldo_cap      MONEY,
	ci_nota           TINYINT,
	di_dir_dom        VARCHAR (254),
	te_tel_dom        VARCHAR (16),
	te_tel_neg        VARCHAR (16)
	)
GO

IF OBJECT_ID ('dbo.ca_error_log') IS NOT NULL
	DROP TABLE dbo.ca_error_log
GO

CREATE TABLE dbo.ca_error_log
	(
	el_cod_modulo        INT NOT NULL,
	el_cod_archivo       INT NOT NULL,
	el_nbr_campo         VARCHAR (100) NOT NULL,
	el_campo_llave       VARCHAR (255) NOT NULL,
	el_cod_error         INT NOT NULL,
	el_msg_error         VARCHAR (132) NOT NULL,
	el_fecha             DATETIME NOT NULL,
	el_nbr_archivo_banco VARCHAR (64) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_situacion_poliza') IS NOT NULL
	DROP TABLE dbo.cr_situacion_poliza
GO

CREATE TABLE dbo.cr_situacion_poliza
	(
	sp_cliente          INT NULL,
	sp_tramite          INT NULL,
	sp_usuario          login NULL,
	sp_secuencia        INT NULL,
	sp_tipo_con         CHAR (1) NULL,
	sp_cliente_con      INT NULL,
	sp_identico         INT NULL,
	sp_producto         catalogo NULL,
	sp_poliza           cuenta NULL,
	sp_tramite_d        INT NULL,
	sp_estado           descripcion NULL,
	sp_comentario       descripcion NULL,
	sp_aseguradora      descripcion NULL,
	sp_tipo_pol         catalogo NULL,
	sp_desc_pol         VARCHAR (64) NULL,
	sp_fecha_ven        VARCHAR (10) NULL,
	sp_anualidad        MONEY NULL,
	sp_endoso           MONEY NULL,
	sp_endoso_ml        MONEY NULL,
	sp_codigo           VARCHAR (64) NULL,
	sp_moneda           TINYINT NULL,
	sp_sec_poliza       INT NULL,
	sp_tipo_deuda       CHAR (1) NULL,
	sp_avaluo           CHAR (1) NULL,
	sp_fechaCancelacion DATETIME NULL,
	sp_fechaActivacion  DATETIME NULL
	)
GO

IF OBJECT_ID ('dbo.cr_clientes_tmp') IS NOT NULL
	DROP TABLE dbo.cr_clientes_tmp
GO

CREATE TABLE dbo.cr_clientes_tmp
	(
	spid           SMALLINT NOT NULL,
	ct_tramite     INT NULL,
	ct_usuario     login NULL,
	ct_ssn         INT NULL,
	ct_tipo_con    CHAR (1) NULL,
	ct_cliente_con INT NULL,
	ct_cliente     INT NULL,
	ct_relacion    CHAR (1) NULL,
	ct_identico    INT NULL
	)
GO


IF OBJECT_ID ('dbo.cr_poliza_tmp') IS NOT NULL
	DROP TABLE dbo.cr_poliza_tmp
GO

CREATE TABLE dbo.cr_poliza_tmp
	(
	spid              SMALLINT NULL,
	CLIENTE           INT NULL,
	POLIZA            cuenta NULL,
	TRAMITE           INT NULL,
	COMENTARIO        descripcion NULL,
	ASEGURADORA       descripcion NULL,
	ESTADO            descripcion NULL,
	TIPO_POLIZA       descripcion NULL,
	FECHA_VEN         VARCHAR (10) NULL,
	ANUALIDAD         MONEY NULL,
	VAL_ENDOSO        MONEY NULL,
	VAL_ENDOSO_ML     MONEY NULL,
	GARANTIA          cuenta NULL,
	AVALUO            CHAR (1) NULL,
	SEC_POL           INT NULL,
	SEC               NUMERIC (18) NULL,
	nombre_cliente    VARCHAR (254) NULL,
	fecha_cancelacion DATETIME NULL,
	fecha_activacion  DATETIME NULL
	)
GO

IF OBJECT_ID ('dbo.cr_cotiz3_tmp') IS NOT NULL
	DROP TABLE dbo.cr_cotiz3_tmp
GO

CREATE TABLE dbo.cr_cotiz3_tmp
	(
	spid       SMALLINT NOT NULL,
	moneda     TINYINT NULL,
	cotizacion FLOAT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_ope1_tmp') IS NOT NULL
	DROP TABLE dbo.cr_ope1_tmp
GO

CREATE TABLE dbo.cr_ope1_tmp
	(
	spid            SMALLINT NOT NULL,
	cliente         INT NULL,
	tramite         INT NULL,
	numero_op       INT NULL,
	numero_op_banco VARCHAR (24) NULL,
	producto        VARCHAR (10) NULL,
	tipo_riesgo     VARCHAR (16) NULL,
	tipo_tr         CHAR (1) NULL,
	estado          CHAR (1) NULL,
	monto           MONEY NULL,
	moneda          TINYINT NULL,
	toperacion      VARCHAR (10) NULL,
	opestado        TINYINT NULL,
	monto_des       MONEY NULL,
	tipoop          CHAR (1) NULL,
	usuario         login NULL,
	secuencia       INT NULL,
	tipo_con        CHAR (1) NULL,
	cliente_con     INT NULL,
	identico        INT NULL,
	tramite_d       INT NULL,
	fecha_nip       DATETIME NULL,
	fecha_lip       DATETIME NULL,
	linea           cuenta NULL,
	mrc             MONEY NULL,
	fecha_apt       DATETIME NULL,
	anticipo        INT NULL,
	rol             CHAR (1) NULL,
	plazo           INT NULL,
	frecuencia_pago VARCHAR (50) NULL,
	motivo_credito  VARCHAR (64) NULL
	)
GO

IF OBJECT_ID ('dbo.cr_tr_datos_adicionales') IS NOT NULL
	DROP TABLE dbo.cr_tr_datos_adicionales
GO

CREATE TABLE dbo.cr_tr_datos_adicionales
	(
	tr_tramite                 INT NULL,
	tr_tipo_cartera            catalogo NULL,
	tr_mes_cic                 INT NULL,
	tr_anio_cic                INT NULL,
	tr_patrimonio              MONEY NULL,
	tr_ventas                  MONEY NULL,
	tr_num_personal_ocupado    INT NULL,
	tr_indice_tamano_actividad FLOAT NULL,
	tr_tipo_credito            catalogo NULL,
	tr_objeto                  catalogo NULL,
	tr_actividad               catalogo NULL,
	tr_descripcion_oficial     descripcion NULL,
	tr_destino_descripcion     descripcion NULL,
	tr_ventas_anuales          MONEY NULL,
	tr_activos_productivos     MONEY NULL,
	tr_nivel_endeuda           CHAR (1) NULL,
	tr_convenio                CHAR (1) NULL,
	tr_codigo_convenio         VARCHAR (10) NULL,
	tr_observacion_reprog      VARCHAR (255) NULL,
	tr_motivo_uno              VARCHAR (255) NULL,
	tr_motivo_dos              VARCHAR (255) NULL,
	tr_motivo_rechazo          catalogo NULL,
	tr_tamano_empresa          VARCHAR (5) NULL,
	tr_en_aprobacion           CHAR (1) NULL,
	tr_producto_fie            catalogo NULL,
	tr_num_viviendas           TINYINT NULL,
	tr_tipo_calificacion       catalogo NULL,
	tr_calificacion            catalogo NULL,
	tr_es_garantia_destino     CHAR (1) NULL,
	tr_es_deudor_propietario   CHAR (1) NULL
	)
GO


IF OBJECT_ID ('dbo.cr_soli_rechazadas_tmp') IS NOT NULL
	DROP TABLE dbo.cr_soli_rechazadas_tmp
GO

CREATE TABLE dbo.cr_soli_rechazadas_tmp
	(
	spid             SMALLINT NOT NULL,
	numero_id        VARCHAR (35) NOT NULL,
	fecha_carga      VARCHAR (35) NOT NULL,
	numero_operacion VARCHAR (24) NULL,
	fecha_rechazo    VARCHAR (35) NULL,
	motivo           VARCHAR (150) NULL,
	usuario          VARCHAR (150) NOT NULL,
	modulo           VARCHAR (10) NULL
	)
GO


IF OBJECT_ID ('dbo.cr_solicitudes_rechazadas') IS NOT NULL
	DROP TABLE dbo.cr_solicitudes_rechazadas
GO

CREATE TABLE dbo.cr_solicitudes_rechazadas
	(
	sr_numero_id        VARCHAR (35) NULL,
	sr_fecha_carga      VARCHAR (35) NULL,
	sr_numero_operacion VARCHAR (24) NULL,
	sr_fecha_rechazo    VARCHAR (35) NULL,
	sr_motivo           VARCHAR (150) NULL,
	sr_usuario          VARCHAR (150) NULL
	)
GO

IF OBJECT_ID ('dbo.cr_verifica_datos') IS NOT NULL
    DROP TABLE dbo.cr_verifica_datos
GO

CREATE TABLE dbo.cr_verifica_datos (
      vd_tramite        INT NOT NULL,
      vd_cliente        INT NOT NULL,
      vd_respuesta      VARCHAR(200) NOT NULL,
      vd_resultado      INT NOT NULL,
	  vd_fecha          DATETIME
    )
GO

ALTER TABLE cr_verifica_datos ADD CONSTRAINT pk_vd_tramite
PRIMARY KEY (vd_tramite, vd_cliente)
GO

IF OBJECT_ID ('dbo.cr_pregunta_ver_dat') IS NOT NULL
    DROP TABLE dbo.cr_pregunta_ver_dat
GO

CREATE TABLE dbo.cr_pregunta_ver_dat (
      pr_tipo           char(1) NOT NULL,
	  pr_codigo         INT NOT NULL,
      pr_descripcion    varchar(1000) NOT NULL
    )
GO

ALTER TABLE cr_pregunta_ver_dat ADD CONSTRAINT pk_pr_codigo
PRIMARY KEY (pr_tipo, pr_codigo)
GO

use cobis
go

IF OBJECT_ID ('dbo.cl_orden_consulta_ext') IS NOT NULL
	DROP TABLE dbo.cl_orden_consulta_ext
GO

CREATE TABLE dbo.cl_orden_consulta_ext
	(
	oc_secuencial      INT IDENTITY NOT NULL,
	oc_tipo_ced        CHAR (2) NOT NULL,
	oc_ced_ruc         numero NOT NULL,
	oc_p_apellido      VARCHAR (16),
	oc_ente            INT,
	oc_tconsulta       catalogo NOT NULL,
	oc_fecha_ing       DATETIME NOT NULL,
	oc_fecha_resp      DATETIME,
	oc_usuario         login,
	oc_oficina         SMALLINT,
	oc_intentos        TINYINT,
	oc_estado          CHAR (3),
	oc_fecha_real_ing  DATETIME,
	oc_fecha_real_resp DATETIME,
	oc_sec_ejec        INT,
	oc_observacion     VARCHAR (255)
	)
GO

CREATE INDEX cl_orden_consulta_ext_idx6
	ON dbo.cl_orden_consulta_ext (oc_tconsulta, oc_estado, oc_secuencial, oc_tipo_ced, oc_ced_ruc, oc_ente, oc_usuario, oc_intentos, oc_sec_ejec)
	WITH (FILLFACTOR = 90)
GO

CREATE UNIQUE INDEX idx1
	ON dbo.cl_orden_consulta_ext (oc_secuencial)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx2
	ON dbo.cl_orden_consulta_ext (oc_tipo_ced, oc_ced_ruc, oc_tconsulta)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx3
	ON dbo.cl_orden_consulta_ext (oc_ente)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx4
	ON dbo.cl_orden_consulta_ext (oc_estado)
	WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx5
	ON dbo.cl_orden_consulta_ext (oc_fecha_resp)
	WITH (FILLFACTOR = 90)
GO


use cob_credito
go


PRINT '<<<<< DROPPING TABLE cob_credito..cr_interface_buro >>>>>'

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'cr_interface_buro' AND u.name = 'dbo' AND o.type = 'U')
    DROP TABLE cr_interface_buro 
GO

PRINT '<<<<< CREATING TABLE "cob_credito..cr_interface_buro" >>>>>'
GO

CREATE TABLE cr_interface_buro  (
    ib_secuencial int         not null,
    ib_cliente	  int      	  NOT NULL,
    ib_fecha      DATETIME    NULL,
    ib_riesgo     int         NULL,
	ib_folio      varchar(64) NULL,
	ib_estado     varchar(4)  null,
	ib_usuario    varchar(30) null
    CONSTRAINT pk_interface_buro PRIMARY KEY ( ib_cliente )
)
GO

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_cliente' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin
   CREATE INDEX idx_cliente
   ON cr_interface_buro (ib_cliente)
end

if not exists (SELECT 1 FROM sys.indexes WHERE Name = N'idx_estado' AND object_id = OBJECT_ID(N'cr_interface_buro')) begin
   CREATE INDEX idx_estado
   ON cr_interface_buro (ib_estado)
end

GO

PRINT '<<<<< CREATING TABLE "cob_credito..cr_documento_digitalizado" >>>>>'
GO

use cob_credito
go

IF OBJECT_ID ('dbo.cr_verifica_xml_tmp') IS NOT NULL
	DROP TABLE dbo.cr_verifica_xml_tmp
GO

CREATE TABLE dbo.cr_verifica_xml_tmp
	(
	vt_x_tramite    INT NOT NULL,
	vt_x_cliente    INT NOT NULL,
	vt_x_codigo     INT NOT NULL,
	vt_x_secuencial INT NOT NULL,
	vt_x_preg_dato  CHAR (1000) NOT NULL,
	vt_x_respuesta  VARCHAR (10) NOT NULL
	)
GO

IF OBJECT_ID ('dbo.cr_documento_digitalizado') IS NOT NULL
	DROP TABLE dbo.cr_documento_digitalizado
GO

CREATE TABLE cr_documento_digitalizado
    (
    dd_inst_proceso    	int not null,
    dd_cliente     	   	int not null,
    dd_grupo  		   	int not null,
    dd_fecha   			datetime not null,
    dd_tipo_doc   		char (10) not null,
    dd_cargado     		char (1) null,
	dd_extension		char(8) null
    )
go

create nonclustered index cr_documento_digitalizado_key 
on cr_documento_digitalizado(dd_inst_proceso, dd_cliente, dd_grupo, dd_tipo_doc)
go
IF OBJECT_ID ('dbo.cr_monto_cliente_grupo') IS NOT NULL
	DROP TABLE dbo.cr_monto_cliente_grupo
GO
CREATE TABLE dbo.cr_monto_cliente_grupo
(
    mc_tramite int          NOT NULL,
    mc_cliente int          NOT NULL,
    mc_monto   varchar(254)  NULL
)
go
CREATE nonclustered INDEX cr_monto_cliente_grupo_key
	ON dbo.cr_monto_cliente_grupo (mc_tramite,mc_cliente)
GO

--------------------
--CR_TR_SINCRONIZAR
--------------------
IF OBJECT_ID ('dbo.cr_tr_sincronizar') IS NOT NULL
    DROP TABLE dbo.cr_tr_sincronizar
GO

CREATE TABLE cr_tr_sincronizar(
ti_tramite         INT,
ti_seccion         VARCHAR(30) NULL,-- nombre de la actividad en el flujo
ti_sincroniza      CHAR(1)     NULL -- sincronizaciOn en el mOvil S/N
)

CREATE nonclustered INDEX cr_tr_sincronizar
    ON dbo.cr_tr_sincronizar (ti_tramite)
GO

IF OBJECT_ID ('dbo.cr_lista_negra') IS NOT NULL
    DROP TABLE dbo.cr_lista_negra
GO

create table cr_lista_negra
(
    ln_id                   int             IDENTITY(1,1) not null,
    ln_fecha_reg            datetime        not null,
    ln_id_lista             varchar(25)     not null,
    ln_nombre               varchar(100)	NULL,
    ln_apellido_paterno     varchar(100)	NULL,
    ln_apellido_materno     varchar(100)	NULL,
    ln_curp                 varchar(20)		NULL,
    ln_rfc                  varchar(15)		NULL,
    ln_fecha_nac            varchar(10)		NULL,
    ln_tipo_lista           varchar(10)		NULL,
    ln_estado               varchar(20)		NULL,
    ln_dependencia          varchar(200)	NULL,
    ln_puesto               varchar(200)	NULL,
    ln_iddispo              varchar(10)		NULL,
    ln_curp_ok              varchar(8)		NULL,
    ln_id_rel               varchar(25)		NULL,
    ln_parentesco           varchar(20)		NULL,
    ln_razon_social         varchar(250)	NULL,
    ln_rfc_moral            varchar(15)		NULL,
    ln_num_seg_social       varchar(50)		NULL,
    ln_imss                 varchar(50)		NULL,
    ln_ingresos             varchar(20)		NULL,
    ln_nom_completo         varchar(300)	NULL,
    ln_apellidos            varchar(200)	NULL,
    ln_entidad              varchar(50)		NULL,
    ln_sexo                 varchar(10)		NULL,
    ln_area                 varchar(200)	NULL
)
go

CREATE nonclustered INDEX cr_lista_negra_key
	ON dbo.cr_lista_negra (ln_id)
go
CREATE nonclustered INDEX cr_lista_negra_iden_key
	ON dbo.cr_lista_negra (ln_curp, ln_rfc)
go
CREATE nonclustered INDEX cr_lista_negra_nom_key
	ON dbo.cr_lista_negra (ln_nombre, ln_apellido_paterno, ln_apellido_materno)
go
ALTER TABLE dbo.cr_lista_negra ADD  CONSTRAINT [DF_cr_lista_negra_ln_fecha_reg]  DEFAULT (getdate()) FOR [ln_fecha_reg]
GO

CREATE CLUSTERED INDEX ix_apellidos_nombre
    ON cr_lista_negra (ln_apellidos, ln_nombre)
GO	
-- --------------------------------------------
if object_id ('dbo.cr_estado_cta_enviado') is not null
    drop table dbo.cr_estado_cta_enviado
go
create table cr_estado_cta_enviado(
   ec_id_cliente	int		     ,   
	ec_nombre_arch	varchar(100) null,
	ec_estado		varchar(1)  null, 
	ec_fecha_proc	datetime	null
)
create clustered index cr_estado_cta_enviado_fk
	on cr_estado_cta_enviado (ec_id_cliente)
go

-- --------------------------------------------
if object_id ('dbo.cr_resultado_xml') is not null
    drop table dbo.cr_resultado_xml
go
create table cr_resultado_xml(
	linea            xml,
	file_name        varchar(64),
    id_ente          int          null,
	status           char(1)      null,
	rfc_ente         varchar(30)  null,
	num_operation    varchar(24)  null,
	insert_date      datetime     null,
	processing_date  datetime   null ,
	rx_cuota_desde   int,
	rx_cuota_hasta   int,
	rx_int_rep       money,
	rx_com_rep       money,
	rx_int_ant       money,
	rx_iva           money,
	rx_met_fact      varchar(3),
	rx_form_pag      varchar(2),
	rx_fecha_ult_compl date,
	rx_pago_compl      money,
	rx_fecha_env_email date,
	rx_tipo_operacion  varchar(10),
	rx_total_saldo_ant money,
	rx_folio_ref     varchar(50),
    rx_deuda_pagar   money,
    rx_total_saldo   money,
    rx_fecha_fin_mes datetime 
    rx_pago_mes      money,
    rx_pago_mes_ant  money,
    rx_pag_compl_ant money,
    rx_com_acum 	 money,
	rx_sec_id        int,
	rx_pago_compl_fin money,
	rx_genera_cmpl   char(1))
go

IF NOT  EXISTS (SELECT name FROM sys.indexes WHERE name = N'indx_cr_resultado_xml_num_operation')  
            BEGIN
                CREATE NONCLUSTERED INDEX [indx_cr_resultado_xml_num_operation]
                ON [dbo].[cr_resultado_xml] ([num_operation])
            END

go

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'indx_cr_resultado_xml_fecha_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin

create index indx_cr_resultado_xml_fecha_fin_mes
on cob_credito..cr_resultado_xml (rx_fecha_fin_mes)
	
end
go


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'indx_cr_resultado_xml_operation_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito..cr_resultado_xml'))
begin

create index indx_cr_resultado_xml_operation_fin_mes
on cob_credito..cr_resultado_xml (num_operation, rx_fecha_fin_mes)
	
end
go



PRINT 'TABLE cr_buro_cuenta'
IF OBJECT_ID ('cr_buro_cuenta') IS NOT NULL
	DROP TABLE cr_buro_cuenta
GO

CREATE TABLE cr_buro_cuenta
	(
	[bc_secuencial]    int identity NOT NULL,
	[bc_ib_secuencial] int  NOT NULL, 
	[bc_fecha_actualizacion] [varchar](8) NULL,
	[bc_registro_impugnado] [varchar](4) NULL,
	[bc_clave_otorgante] [varchar](10) NULL,
	[bc_nombre_otorgante] [varchar](16) NULL,
	[bc_numero_telefono_otorgante] [varchar](11) NULL,
	[bc_identificador_sociedad_crediticia] [varchar](11) NULL,
	[bc_numero_cuenta_actual] [varchar](25) NULL,
	[bc_indicador_tipo_responsabilidad] [varchar](1) NULL,
	[bc_tipo_cuenta] [varchar](1) NULL,
	[bc_tipo_contrato] [varchar](2) NULL,
	[bc_clave_unidad_monetaria] [varchar](2) NULL,
	[bc_valor_activo_valuacion] [varchar](9) NULL,
	[bc_numero_pagos] [varchar](4) NULL,
	[bc_frecuencia_pagos] [varchar](1) NULL,
	[bc_monto_pagar] [varchar](9) NULL,
	[bc_fecha_apertura_cuenta] [varchar](8) NULL,
	[bc_fecha_ultimo_pago] [varchar](8) NULL,
	[bc_fecha_ultima_compra] [varchar](8) NULL,
	[bc_fecha_cierre_cuenta] [varchar](8) NULL,
	[bc_fecha_reporte] [varchar](8) NULL,
	[bc_modo_reportar] [varchar](1) NULL,
	[bc_ultima_fecha_saldo_cero] [varchar](8) NULL,
	[bc_garantia] [varchar](40) NULL,
	[bc_credito_maximo] [varchar](9) NULL,
	[bc_saldo_actual] [varchar](9) NULL,
	[bc_limite_credito] [varchar](9) NULL,
	[bc_saldo_vencido] [varchar](9) NULL,
	[bc_numero_pagos_vencidos] [varchar](4) NULL,
	[bc_forma_pago_actual] [varchar](2) NULL,
	[bc_historico_pagos] [varchar](24) NULL,
	[bc_fecha_mas_reciente_pago_historicos] [varchar](8) NULL,
	[bc_fecha_mas_antigua_pago_historicos] [varchar](8) NULL,
	[bc_clave_observacion] [varchar](2) NULL,
	[bc_total_pagos_reportados] [varchar](3) NULL,
	[bc_total_pagos_calificados_mop2] [varchar](2) NULL,
	[bc_total_pagos_calificados_mop3] [varchar](2) NULL,
	[bc_total_pagos_calificados_mop4] [varchar](2) NULL,
	[bc_total_pagos_calificados_mop5] [varchar](2) NULL,
	[bc_importe_saldo_morosidad_hist_mas_grave] [varchar](9) NULL,
	[bc_fecha_historica_morosidad_mas_grave] [varchar](8) NULL,
	[bc_mop_historico_morosidad_mas_grave] [varchar](2) NULL,
	[bc_monto_ultimo_pago] [varchar](9) NULL,
	[bc_fecha_inicio_reestructura] [varchar](8) NULL,
	CONSTRAINT pk_buro_cuenta PRIMARY KEY (bc_secuencial),
	CONSTRAINT FK_cr_buro_cuenta_cr_interface_buro FOREIGN KEY (bc_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
	)
GO



PRINT 'TABLE cr_buro_resumen_reporte'
IF OBJECT_ID ('cr_buro_resumen_reporte') IS NOT NULL
	DROP TABLE cr_buro_resumen_reporte
GO

CREATE TABLE cr_buro_resumen_reporte
	(
	[br_secuencial]                           int           identity not null,
	[br_ib_secuencial]                        int           not null, 
	[br_fecha_ingreso_bd]                     [varchar](8) NULL,
	[br_numero_mop7]                          [varchar](2) NULL,
	[br_numero_mop6]                          [varchar](2) NULL,
	[br_numero_mop5]                          [varchar](2) NULL,
	[br_numero_mop4]                          [varchar](2) NULL,
	[br_numero_mop3]                          [varchar](2) NULL,
	[br_numero_mop2]                          [varchar](2) NULL,
	[br_numero_mop1]                          [varchar](2) NULL,
	[br_numero_mop0]                          [varchar](2) NULL,
	[br_numero_mop_ur]                        [varchar](2) NULL,
	[br_numero_cuentas]                       [varchar](4) NULL,
	[br_cuentas_pagos_fijos_hipotecas]        [varchar](4) NULL,
	[br_cuentas_revolventes_abiertas]         [varchar](4) NULL,
	[br_cuentas_cerradas]                     [varchar](4) NULL,
	[br_cuentas_negativas_actuales]           [varchar](4) NULL,
	[br_cuentas_claves_historia_negativa]     [varchar](4) NULL,
	[br_cuentas_disputa]                      [varchar](2) NULL,
	[br_numero_solicitudes_ultimos_6_meses]   [varchar](2) NULL,
	[br_nueva_direccion_reportada_ultimos_60_dias] [varchar](1) NULL,
	[br_mensajes_alerta] [varchar](8) NULL,
	[br_existencia_declaraciones_consumidor] [varchar](1) NULL,
	[br_tipo_moneda] [varchar](2) NULL,
	[br_total_creditos_maximos_revolventes] [varchar](9) NULL,
	[br_total_limites_credito_revolventes] [varchar](9) NULL,
	[br_total_saldos_actuales_revolventes] [varchar](10) NULL,
	[br_total_saldos_vencidos_revolventes] [varchar](9) NULL,
	[br_total_pagos_revolventes] [varchar](9) NULL,
	[br_pct_limite_credito_utilizado_revolventes] [varchar](3) NULL,
	[br_total_creditos_maximos_pagos_fijos] [varchar](9) NULL,
	[br_total_saldos_actuales_pagos_fijos] [varchar](10) NULL,
	[br_total_saldos_vencidos_pagos_fijos] [varchar](9) NULL,
	[br_total_pagos_pagos_fijos] [varchar](9) NULL,
	[br_numero_mop96] [varchar](2) NULL,
	[br_numero_mop97] [varchar](2) NULL,
	[br_numero_mop99] [varchar](2) NULL,
	[br_fecha_apertura_cuenta_mas_antigua] [varchar](8) NULL,
	[br_fecha_apertura_cuenta_mas_reciente] [varchar](8) NULL,
	[br_total_solicitudes_reporte] [varchar](2) NULL,
	[br_fecha_solicitud_reporte_mas_reciente] [varchar](8) NULL,
	[br_numero_total_cuentas_despacho_cobranza] [varchar](2) NULL,
	[br_fecha_apertura_cuenta_mas_reciente_despacho_cobranza] [varchar](8) NULL,
	[br_numero_total_solicitudes_despachos_cobranza] [varchar](2) NULL,
	[br_fecha_solicitud_mas_reciente_despacho_cobranza] [varchar](8) NULL,
    CONSTRAINT pk_buro_resumen_reporte PRIMARY KEY (br_secuencial),
	CONSTRAINT fk_buro_resumen_reporte_interface_buro FOREIGN KEY (br_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
	)
GO


PRINT 'TABLE cr_desembolso_chequeo'
IF OBJECT_ID ('cr_desembolso_chequeo') IS NOT NULL
	DROP TABLE cr_desembolso_chequeo
GO

create table cr_desembolso_chequeo
 (
    dc_nombre_documento			char(28) not null,
	dc_tipo_registro    		char(2) not null,
    dc_num_secuencia     	   	char(7) not null,
    dc_cod_operacion  		   	char(2) not null,
    dc_num_banco   				char(3) not null,
    dc_sentido  				char(1) not null,
    dc_servicio     			char(2) not null,
	dc_num_bloque				char(7) not null,
	dc_fecha_presentacion		char(8) not null,
	dc_cod_divisa				char(2) not null,
	dc_causa_rechazo			char(2) not null,
	dc_modalidad				char(1) not null
  )

alter table cr_desembolso_chequeo
add constraint PK_DESEMBOLSO_CHEQUEO primary key nonclustered (dc_nombre_documento)
GO

PRINT 'Drop table cr_prelacion_cuenta'
IF OBJECT_ID ('dbo.cr_prelacion_cuenta') IS NOT NULL
	DROP TABLE dbo.cr_prelacion_cuenta
GO

PRINT 'Drop table cr_prelacion_nivel'
IF OBJECT_ID ('dbo.cr_prelacion_nivel') IS NOT NULL
	DROP TABLE dbo.cr_prelacion_nivel
GO

PRINT 'Create table cr_prelacion_nivel'
CREATE TABLE dbo.cr_prelacion_nivel
	(
	pn_nivel     CHAR (2) NOT NULL,
	pn_prioridad TINYINT NOT NULL,
	CONSTRAINT PK_cr_prelacion_nivel PRIMARY KEY (pn_nivel),
	CONSTRAINT IX_cr_prelacion_nivel UNIQUE (pn_prioridad)
	)
GO

PRINT 'Create table cr_prelacion_cuenta'
CREATE TABLE dbo.cr_prelacion_cuenta
	(
	pc_producto    CHAR (2) NOT NULL,
	pc_subproducto CHAR (4) NOT NULL,
	pc_nivel       CHAR (2) NOT NULL,
	CONSTRAINT PK_cr_prelacion_cuenta PRIMARY KEY (pc_producto, pc_subproducto),
	CONSTRAINT FK_cr_prelacion_cuenta_cr_prelacion_nivel FOREIGN KEY (pc_nivel) REFERENCES dbo.cr_prelacion_nivel (pn_nivel)
	)
GO
PRINT 'Drop table cr_catalogo_buro'
IF OBJECT_ID ('dbo.cr_catalogo_buro') IS NOT NULL
	DROP TABLE dbo.cr_catalogo_buro
GO

PRINT 'Create table cr_catalogo_buro'
CREATE TABLE dbo.cr_catalogo_buro
	(
	cb_tabla        int           not null,
	cb_codigo       char(4)       not null, 
    cb_descripcion  varchar(255)  not null
	)
GO

create index IX_cr_catalogo_buro
	on dbo.cr_catalogo_buro(cb_tabla)
go


PRINT 'Drop table cr_score_buro'
IF OBJECT_ID ('dbo.cr_score_buro') IS NOT NULL
	DROP TABLE dbo.cr_score_buro
GO

PRINT 'Create table cr_score_buro'
CREATE TABLE dbo.cr_score_buro
	(
	sb_secuencial      int           identity not null,
	sb_ib_secuencial   int           not null, 
	sb_nombre          varchar(30)   null,
	sb_codigo          varchar(3)    null, 
    sb_valor           varchar(4)    null,   
	sb_codigo_razon    varchar(3)    null,  
	sb_codigo_error    varchar(2)    null ,
	CONSTRAINT pk_score_buro PRIMARY KEY (sb_secuencial),
	CONSTRAINT fk_score_buro_interface_buro FOREIGN KEY (sb_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
	)
GO


PRINT 'Drop table cr_empleo_buro'
IF OBJECT_ID ('dbo.cr_empleo_buro') IS NOT NULL
	DROP TABLE dbo.cr_empleo_buro
GO

PRINT 'Create table cr_empleo_buro'
CREATE TABLE dbo.cr_empleo_buro
	(
	eb_secuencial          int               identity not null,
	eb_ib_secuencial       int               not null, 
	eb_nombre_empresa      varchar(40)       null,
    eb_direccion_uno       varchar(40)       null,
    eb_direccion_dos       varchar(40)       null,
    eb_colonia             varchar(40)       null,
    eb_delegacion          varchar(40)       null,
    eb_ciudad              varchar(40)       null,
    eb_estado              varchar(4)        null,
    eb_codigo_postal       varchar(5)        null,
    eb_numero_telefono     varchar(11)       null,
    eb_extension           varchar(8)        null,
    eb_fax                 varchar(11)       null,
    eb_cargo               varchar(30)       null,
    eb_fecha_contratacion  varchar(8)        null,
    eb_clave_moneda        varchar(2)        null,
    eb_salario             varchar(9)        null,
    eb_base_salarial	   varchar(1)        null,
    eb_num_empleado 	   varchar(15)       null,
    eb_fecha_ult_dia 	   varchar(8)        null,
    eb_codigo_pais 	       varchar(2)        null,
    eb_fecha_rept_empleo   varchar(8)        null,
    eb_fecha_verificacion  varchar(8)        null,
    eb_modo_verificiacion    char(1)         null,
	CONSTRAINT pk_empleo_buro PRIMARY KEY (eb_secuencial),
	CONSTRAINT fk_empleo_buro_interface_buro FOREIGN KEY (eb_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
	)
GO

IF OBJECT_ID ('dbo.cr_buro_encabezado') IS NOT NULL
	DROP TABLE dbo.cr_buro_encabezado
GO

CREATE TABLE cr_buro_encabezado
(
  be_ib_secuencial INT NOT NULL IDENTITY,
  be_secuencial INT NOT NULL,
  be_nro_referencia_operador VARCHAR(25),
  be_clave_pais VARCHAR(2),
  be_identificador_buro INT,
  be_clave_otorgante VARCHAR(10),
  be_clave_retorno_consumidor_principal VARCHAR(1),
  be_clave_retorno_consumidor_secundario VARCHAR(1),
  be_numero_control_consulta VARCHAR(9),
  CONSTRAINT pk_buro_encabezado PRIMARY KEY (eb_secuencial),
  CONSTRAINT fk_buro_encabezado_interface_buro FOREIGN KEY (be_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
)

go

IF OBJECT_ID ('dbo.cr_direccion_buro') IS NOT NULL
	DROP TABLE dbo.cr_direccion_buro
GO

CREATE TABLE dbo.cr_direccion_buro
	(
	db_secuencial         INT IDENTITY NOT NULL
	db_ib_secuencial      INT NULL,
	db_direccion_uno      VARCHAR (150) NULL,
	db_direccion_dos      VARCHAR (150) NULL,
	db_colonia            VARCHAR (150) NULL,
	db_delegacion         VARCHAR (150) NULL,
	db_ciudad             VARCHAR (150) NULL,
	db_estado             VARCHAR (20) NULL,
	db_codigo_postal      VARCHAR (50) NULL,
	db_numero_telefono    VARCHAR (50) NULL,
	db_tipo_domicilio     VARCHAR (10) NULL,
	db_indicador_especial VARCHAR (10) NULL,
	db_codigo_pais        VARCHAR (10) NULL,
	db_fecha_reporte      VARCHAR (20) NULL,
	CONSTRAINT pk_direccion_buro PRIMARY KEY (db_secuencial),
	CONSTRAINT fk_direccion_buro_interface_buro FOREIGN KEY (db_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)
	)
GO


PRINT 'Drop table cr_consultas_buro'
IF OBJECT_ID ('dbo.cr_consultas_buro') IS NOT NULL
	DROP TABLE dbo.cr_consultas_buro
GO

PRINT 'Create table cr_consultas_buro'
CREATE TABLE dbo.cr_consultas_buro
	(
	ce_secuencial          int               identity not null,
	ce_ib_secuencial       int               not null, 
	ce_fecha_consulta      varchar(8)        null,
	ce_identificacion_buro varchar(4)        null,
	ce_clave_otorgante     varchar(10)       null,
	ce_nombre_otorgante    varchar(16)       null,
	ce_telefono_otorgante  varchar(11)       null,
	ce_tipo_contrato       varchar(2)        null, 
	ce_clave_monetaria     varchar(2)        null, 
	ce_importe_contrato    varchar(9)        null, 
	ce_ind_tipo_responsa   char(1)           null, 
	ce_consumidor_nuevo    char(1)           null, 
	ce_resultado_final     varchar(25)       null, 
    ce_identificador_cons  varchar(25)       null,
	CONSTRAINT pk_consultas_buro PRIMARY KEY (ce_secuencial),
	CONSTRAINT fk_consultas_buro_interface_buro FOREIGN KEY (ce_ib_secuencial) REFERENCES cr_interface_buro(ib_secuencial)	
    
	)
GO


print 'Registro tabla cr_negative_file_carg_ini'

IF OBJECT_ID ('dbo.cr_negative_file_carg_ini') IS NOT NULL
	DROP TABLE dbo.cr_negative_file_carg_ini
GO

create table cr_negative_file_carg_ini
	(
        nfi_tipo_documento        varchar(300),
        nfi_rfc_pasaporte         varchar(300),
        nfi_genero                varchar(300),
        nfi_ape_paterno           varchar(300),
        nfi_ape_materno           varchar(300),
        nfi_apellidos             varchar(300),
        nfi_nombre_razon_social   varchar(300),
        nfi_fecha_nac             varchar(300),
        nfi_alias                 varchar(300),
        nfi_relacionado_con       varchar(300),
        nfi_codigo_negative       varchar(300),
        nfi_tipologia_operacion   varchar(300),
        nfi_vinculacion_operacion varchar(300),
        nfi_entidad_reportada     varchar(300),
        nfi_fuente_nf             varchar(300),
        nfi_zona_geografica       varchar(300),
        nfi_fecha_inclusion       varchar(300),
        nfi_fecha_vencimiento     varchar(300),
        nfi_fecha_inhabilitacion  varchar(300),
        nfi_fecha_rehabilitacion  varchar(300),
        nfi_fecha_veredicto       varchar(300),
        nfi_fecha_envio           varchar(300),
        nfi_datos_identificacion  varchar(300),
        nfi_acciones              varchar(300)	
	)
GO

print 'Registro tabla cr_negative_file'

IF OBJECT_ID ('dbo.cr_negative_file') IS NOT NULL
	DROP TABLE dbo.cr_negative_file
GO

CREATE TABLE cr_negative_file
	(
		nf_secuencial            int identity not null,
		nf_fecha_ultima_carga    datetime,
        nf_tipo_documento        varchar(300),
        nf_rfc_pasaporte         varchar(300),
        nf_genero                varchar(300),
        nf_ape_paterno           varchar(300),
        nf_ape_materno           varchar(300),
        nf_apellidos             varchar(300),
        nf_nombre_razon_social   varchar(300),
        nf_fecha_nac             varchar(300),
        nf_alias                 varchar(300),
        nf_relacionado_con       varchar(300),
        nf_codigo_negative       varchar(300),
        nf_tipologia_operacion   varchar(300),
        nf_vinculacion_operacion varchar(300),
        nf_entidad_reportada     varchar(300),
        nf_fuente_nf             varchar(300),
        nf_zona_geografica       varchar(300),
        nf_fecha_inclusion       varchar(300),
        nf_fecha_vencimiento     varchar(300),
        nf_fecha_inhabilitacion  varchar(300),
        nf_fecha_rehabilitacion  varchar(300),
        nf_fecha_veredicto       varchar(300),
        nf_fecha_envio           varchar(300),
        nf_datos_identificacion  varchar(300),
        nf_acciones              varchar(300)

		PRIMARY KEY (nf_secuencial)			
	)
GO

CREATE CLUSTERED INDEX ix_nombre
    ON cr_negative_file (nf_ape_paterno, nf_nombre_razon_social)
go

ALTER TABLE [dbo].[cr_negative_file] ADD CONSTRAINT  PK_cr_negative_file PRIMARY KEY  NONCLUSTERED 
(
	[nf_secuencial] ASC
)
GO


/* GUARDADO DE GRUPOS PROMO */
IF OBJECT_ID ('dbo.cr_grupo_promo_inicio') IS NOT NULL
	DROP TABLE dbo.cr_grupo_promo_inicio
GO

create table cr_grupo_promo_inicio
	(
	gpi_tramite int not null,
	gpi_grupo   int not null,
	gpi_ente    int not null 
	)
GO
--tabla que contiene rfc invalidos por Interfactura
IF OBJECT_ID ('dbo.cr_rfc_int_error') IS NOT NULL
	DROP TABLE dbo.cr_rfc_int_error
GO

CREATE TABLE dbo.cr_rfc_int_error
	(
	rfc_int_error        varchar(30) not null,
	status_rfc_err       char(1)     null,
	insert_date_rfc_err  datetime    null,
	process_date_rfc_err datetime    null
	)
GO

IF OBJECT_ID ('dbo.cr_ns_rechaza_lcr') IS NOT NULL
	DROP table dbo.cr_ns_rechaza_lcr
go

create table dbo.cr_ns_rechaza_lcr
	(
	nl_tramite          int not null,
	nl_fecha_reg        datetime not null,
	nl_cliente          int not null,
	nl_nombre           varchar (100),
	nl_apellido_paterno varchar (100),
	nl_apellido_materno varchar (100),
	nl_correo           varchar (255) not null,
	nl_observaciones    varchar (1000) not null,
	nl_estado           char (1)
	)
go


if exists (select 1 from sysobjects where type = 'U' and name = 'cr_b2c_registro')
    drop table cr_b2c_registro
go

create table cr_b2c_registro(
rb_registro_id               cuenta,--consultar tamaÒo
rb_id_inst_proc              int,
rb_cliente                   int,
rb_fecha_ingreso             datetime,
rb_fecha_vigencia            datetime,
rb_fecha_reg_exitoso         datetime
)
go

create unique index idx1 on cr_b2c_registro (rb_registro_id)
create index idx2 on cr_b2c_registro (rb_cliente)
go


---------------------------------------------------------------------------
-------------------Crear tabla cr_ns_rechaza_lcr -------------------
---------------------------------------------------------------------------
IF OBJECT_ID ('dbo.cr_ns_rechaza_lcr') IS NOT NULL
    DROP TABLE dbo.cr_ns_rechaza_lcr
GO

create table cr_ns_rechaza_lcr
(
    nl_tramite              int             not null,
    nl_fecha_reg            datetime        not null,
    nl_cliente              int             not null,
    nl_nombre               varchar(100)	null,
    nl_apellido_paterno     varchar(100)	null,
    nl_apellido_materno     varchar(100)	null,
    nl_correo               varchar (255)   not null,
    nl_observaciones        varchar(1000)   not null,
    nl_estado               char (1)        null
)
go

CREATE nonclustered INDEX cr_ns_rechaza_lcr_key
	ON dbo.cr_ns_rechaza_lcr (nl_tramite)
GO 

---------------------------------------------------------------------------
-------------------Crear tabla cr_ns_creacion_lcr -------------------
---------------------------------------------------------------------------
	DROP table dbo.cr_ns_creacion_lcr
go

create table dbo.cr_ns_creacion_lcr
	(
	nc_tramite          int not null,
	nc_fecha_reg        datetime not null,
	nc_cliente          int not null,
	nc_nombre           varchar (100)  null,
	nc_apellido_paterno varchar (100) null,
	nc_apellido_materno varchar (100) null,
	nc_correo           varchar (255) not null,
	nc_digito           varchar (100) null,
	nc_estado           char (1) null
	)
go

create nonclustered index cr_ns_creacion_lcr_key
	on dbo.cr_ns_creacion_lcr (nc_tramite)
go

/* TABLAS NUEVAS PARA MATRIZ DE RIESGO */
IF OBJECT_ID ('dbo.cr_matriz_riesgo_cli') IS NOT NULL
	DROP TABLE dbo.cr_matriz_riesgo_cli
GO

print 'Creacion de tabla para cr_matriz_riesgo_cli'
CREATE TABLE cr_matriz_riesgo_cli(
    mr_cliente  INT NOT NULL,
    mr_variable VARCHAR(25) NOT NULL,
    mr_nivel    VARCHAR(25) NOT NULL,
    mr_puntaje  INT NOT NULL
)

CREATE NONCLUSTERED INDEX cr_documento_digitalizado_key
	ON dbo.cr_matriz_riesgo_cli (mr_cliente,mr_variable)
GO

--cr_monto_num_riesgo
IF OBJECT_ID ('dbo.cr_monto_num_riesgo') IS NOT NULL
	DROP TABLE dbo.cr_monto_num_riesgo
GO

print 'Creacion de tabla para cr_monto_num_riesgo'
create table cr_monto_num_riesgo
	(
	mnr_ente                int not null,
	mnr_num_op_env          varchar(30),
	mnr_mont_op_env         varchar(30),
	mnr_num_op_rec          varchar(30),
	mnr_mont_op_rec         varchar(30),
	mnr_num_dep_efec        varchar(30),
	mnr_mont_dep_efec       varchar(30),
	mnr_num_dep_noefec      varchar(30),
	mnr_mont_dep_noefec     varchar(30),
	mnr_contrapartes 		varchar(30) null,
	mnr_canal_contratacion 	varchar(30) null,
	mnr_fecha_nac 			varchar(30) null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cr_monto_num_riesgo_Key
	ON dbo.cr_monto_num_riesgo (mnr_ente)
GO



IF OBJECT_ID ('dbo.cr_cuenta_buc_santander_job') IS NOT NULL
	DROP TABLE dbo.cr_cuenta_buc_santander_job
go

CREATE TABLE dbo.cr_cuenta_buc_santander_job
	(
	cbs_ente              INT not null,
	cbs_tramite           INT not null,
	cbs_intentos          INT not null,
	cbs_fecha_ult_intento DATETIME not null,
	cbs_estado            CHAR (1) not null,
	constraint UQ_tramite_cuenta_buc_santander_job unique(cbs_tramite)
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_cbs_estado' AND object_id = OBJECT_ID('cr_cuenta_buc_santander_job'))
   CREATE INDEX idx_cbs_estado
   ON cr_cuenta_buc_santander_job (cbs_estado)

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_cbs_intentos' AND object_id = OBJECT_ID('cr_cuenta_buc_santander_job'))
   CREATE INDEX idx_cbs_intentos
   ON cr_cuenta_buc_santander_job (cbs_intentos)
go


IF OBJECT_ID ('dbo.cr_buro_ln_nf_job') IS NOT NULL
	DROP TABLE dbo.cr_buro_ln_nf_job
go

CREATE TABLE dbo.cr_buro_ln_nf_job
	(
	bj_ente              INT not null,
	bj_tramite           INT not null,
	bj_fecha_ingreso     DATETIME not null,
	bj_novedades_ln_nf   varchar(2),
	bj_estado            CHAR (1) not null,
	constraint UQ_tramite_buro_ln_nf_job unique(bj_tramite)
	)

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_bj_estado' AND object_id = OBJECT_ID('cr_buro_ln_nf_job'))
   CREATE INDEX idx_bj_estado
   ON cr_buro_ln_nf_job (cbs_estado)

go

if object_id ('dbo.cr_buro_diario') is not null
	drop table dbo.cr_buro_diario
go
create table cr_buro_diario(
bd_cod_cliente       varchar(40),
bd_tipo_cliente      varchar(40),
bd_nombre            varchar(40),
bd_buc               varchar(40),
bd_fecha_act         varchar(40),
bd_forma_pago        varchar(40),
bd_hist_pagos        varchar(40),
bd_saldo_vencido     varchar(40),
bd_tipo_contrato     varchar(40),
bd_fecha_cierre      varchar(40),
bd_clave_obs         varchar(40),
bd_clave_otorgante   varchar(40),
bd_tipo_cuenta       varchar(40),
bd_tipo_respon       varchar(40),
bd_fecha_apert_cta   varchar(40),
bd_credito_max       varchar(40),
bd_saldo_act         varchar(40),
bd_frec_pago         varchar(40),
bd_nombre_otorgante  varchar(40),
bd_nivel_riesgo  	 varchar(40),
bd_riesgo_individual varchar(40)
)
GO

IF OBJECT_ID ('dbo.cr_complemento_pago_xml') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml
go

create table dbo.cr_complemento_pago_xml
	(
	linea            nvarchar(max),
	file_name        varchar (64),
	id_ente          int,
	status           char (1),
	rfc_ente         varchar (30),
	num_operation    varchar (24),
	insert_date      datetime,
	processing_date  datetime,
	tipo_operacion   varchar (10),
	in_fecha_fin_mes datetime,
	rx_saldo_inso    money,
    rx_cuota_ini     int,
    rx_cuota_hasta   int,
    rx_deuda_pagar   money,
    rx_folio_ref     varchar(50),
	rx_saldo_inso_fin money,
	rx_sec_id         int,
	rx_tipo_compl     char(1),
	rx_id_documento   varchar(60),
	rx_fe_mes_afecta  datetime
	
	)
go

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'operacion_complemento'
                  AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin

create index operacion_complemento 
on cob_credito..cr_complemento_pago_xml(num_operation) 
	
end


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'complemento_banco_folio'
                  AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin

create index complemento_banco_folio
on cob_credito..cr_complemento_pago_xml (num_operation, rx_folio_ref)
	
end

go
if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'complemento_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito..cr_complemento_pago_xml'))
begin

create index complemento_fin_mes
on cob_credito..cr_complemento_pago_xml (in_fecha_fin_mes)
	
end

--->>>>>>>>>>>>>>>>>>>REQ#162288 Cambios Simple F1
use cob_credito
go

if OBJECT_ID ('dbo.cr_plazo_ind') is not null
	drop table dbo.cr_plazo_ind
go

create table dbo.cr_plazo_ind (
    pi_frecuencia char(10),
    pi_plazo int
)

insert into cr_plazo_ind values ('W', 12)
insert into cr_plazo_ind values ('W', 25)
insert into cr_plazo_ind values ('W', 38)
insert into cr_plazo_ind values ('W', 51)

insert into cr_plazo_ind values ('BW', 6)
insert into cr_plazo_ind values ('BW', 12)
insert into cr_plazo_ind values ('BW', 19)
insert into cr_plazo_ind values ('BW', 25)

insert into cr_plazo_ind values ('M', 3)
insert into cr_plazo_ind values ('M', 6)
insert into cr_plazo_ind values ('M', 9)
insert into cr_plazo_ind values ('M', 12)

go

--caso#162199
if OBJECT_ID ('dbo.cr_interface_buro_tmp_consulta') is not null
	drop table dbo.cr_interface_buro_tmp_consulta
GO

create table dbo.cr_interface_buro_tmp_consulta (
    tc_cliente int,
    tc_estado char(1),
    tc_fecha datetime
)
go


--->>>>>>>>>>>>>>>>>>>REQ#123670 Tabla para manejo de estados - solicitud modificacion datos
use cob_credito
go

print 'CREACION TABLA: cr_estados_sol_mod_dat'
if object_id ('dbo.cr_estados_sol_mod_dat') is not null
	drop table dbo.cr_estados_sol_mod_dat
go

create table dbo.cr_estados_sol_mod_dat (
    es_ente        int         null,
    es_estado_dir  char(1)     null,
	es_estado_mail char(1)     null,
	es_fecha       datetime    null
)
go

print 'CREACION INDEX: cr_estados_sol_mod_dat_Key'
if exists (select name from sysindexes where name='cr_estados_sol_mod_dat_Key')
    drop index cr_estados_sol_mod_dat.cr_estados_sol_mod_dat_Key
go
    create NONCLUSTERED index cr_estados_sol_mod_dat_Key on cob_credito..cr_estados_sol_mod_dat(es_ente)
go


--->>>>>>>>>>>>>>>>>>>REQ#180604 Tabla de documentos excluidos - etapa VERIFICAR Y DIGITALIZAR
use cob_credito
go

print 'CREACION TABLA: cr_documentos_excluidos'
if object_id ('dbo.cr_documentos_excluidos') is not null
	drop table dbo.cr_documentos_excluidos
go

create table dbo.cr_documentos_excluidos (
    de_toperacion   catalogo(10),
    de_tabla        char(30),   
	de_codigo       char(10)
)
go


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo AceptaciOn Grupal, BC
use cob_credito
go

print 'CREACION TABLA: cr_vigencia_tipo_calif'
if object_id ('dbo.cr_vigencia_tipo_calif') is not null
	drop table dbo.cr_vigencia_tipo_calif
go

create table dbo.cr_vigencia_tipo_calif(
    vg_ente         int,
    vg_oficina      smallint,   
	vg_canal        int,
	vg_vigencia     int,
	vg_tipo_calif   varchar(10),
	vg_usuario      varchar(14),
	vg_fecha_reg    datetime,
	vg_fecha_proc   datetime,
	vg_evaluo_buro  char(1), -- S consulto a buro
	vg_result_eval  varchar(256) -- Resultado evalua reglas
)
go


--->>>>REQ#168293 Flujo de originaciOn Auto onboarding
IF OBJECT_ID ('dbo.cr_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_reporte_on_boarding
go

create table cr_reporte_on_boarding(
    ra_cod_documento            varchar(10),
	ra_nombre_archivo_jasper    varchar(256),
	ra_nombre_archivo_presentar varchar(256),
	ra_est_gen                  char(1),
    ra_est_envio                char(1),
    ra_toperacion               varchar(10),
    ra_nombre_archivo_term      varchar(10),
	ra_est_des_alfresco         char(1),
	ra_canal                    int,
	ra_carpeta                  varchar(10),
	ra_codigo_tipo_doc          smallint,
	ra_est_carga_alfresco       char (1),
	ra_est_eliminar_doc         char (1),
	ra_tiempo_vig_doc           int,
	ra_cod_tipo_doc_cstmr       char (10),
	ra_estado                   char (1),
	ra_grp_unif                 char (2),
	ra_orden_unif               int
)
GO

--AutoOnboarding
insert into cr_reporte_on_boarding values ('100', 'contratoCredSimpleIndividualAutoOnboard.jasper',  'CONTRATO CR…DITO SIMPLE',                     'S', 'S', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('101', 'tablaAmortizacionSimpleIndAutoOnboard.jasper',    'TABLA DE AMORTIZACI”N TU CR…DITO + NEGOCIO',  'S', 'S', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('102', 'caratulaCreditoSimpleAutoOnboard.jasper',         'CAR√ÅTULA CR…DITO SIMPLE',                     'S', 'S', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('103', 'ConsentimientoZurichSimpleIndAutoOnboard.jasper', 'CERTIFICADO CONSENTIMIENTO',                  'S', 'N', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('104', 'kYCAutoOnboard.jasper',                           'FORMULARIO KYC',                              'S', 'N', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('105', 'autorizacionBuroSimpleAutoOnboard.jasper',        'SOLICITUD AMORTIZACI”N BURO DE CR…DITO',      'S', 'N', 'INDIVIDUAL', '_cr',  'N', 3, null,       null, 'N', 'N', null, null,  'V', null, null)
--Grupal - REQ 196073
insert into cr_reporte_on_boarding values ('109', null,                                              'CONTRATO GRUPAL',                             'N', 'S', 'GRUPAL',     '_gr',  'S', 4, 'Inbox',    2,    'N', 'N', null, null,  'I', null, null)
insert into cr_reporte_on_boarding values ('110', null,                                              'CARATULA DE CREDITO GRUPAL',                  'N', 'S', 'GRUPAL',     '_gr',  'S', 4, 'Inbox',    11,   'N', 'N', null, null,  'I', null, null)
insert into cr_reporte_on_boarding values ('111', null,                                              'TABLA DE AMORTIZACION GRUPAL',                'N', 'S', 'GRUPAL',     '_gr',  'S', 4, 'Inbox',    10,   'N', 'N', null, null,  'I', null, null)
insert into cr_reporte_on_boarding values ('112', null,                                              'SOLICITUD DE CREDITO COMPLEMENTARIA',         'N', 'N', 'GRUPAL',     '_gr',  'N', 4, 'Customer', null, 'N', 'N', null, '009', 'I', null, null)
insert into cr_reporte_on_boarding values ('113', 'PagoCorresponsal.jasper',                         'FICHA DE PAGO GRUPAL',                        'S', 'S', 'GRUPAL',     '_gr',  'N', 4, null,       null, 'N', 'N', null, null,  'V', 1,    4)
--Revolvente - REQ 196073
insert into cr_reporte_on_boarding values ('114', null,                                              'CONTRATO DE LINEA DE CREDITO REVOLVENTE LCR', 'N', 'S', 'REVOLVENTE', '_lcr', 'S', 4, 'Inbox',    15,   'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('115', null,                                              'CARATULA LCR',                                'N', 'S', 'REVOLVENTE', '_lcr', 'S', 4, 'Inbox',    14,   'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('116', null,                                              'SOLICITUD COMPLEMENTARIA LCR',                'N', 'N', 'REVOLVENTE', '_lcr', 'N', 4, 'Inbox',    30,   'N', 'N', null, null,  'V', null, null)
--Individual - REQ 196073
insert into cr_reporte_on_boarding values ('117', null,                                              'CONTRATO DE INCLUSION INDIVIDUAL',            'N', 'S', 'INDIVIDUAL', '_in',  'S', 4, 'Inbox',    8,    'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('118', null,                                              'CARATULA DE CREDITO INDIVIDUAL',              'N', 'S', 'INDIVIDUAL', '_in',  'S', 4, 'Inbox',    6,    'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('119', null,                                              'TABLA DE AMORTIZACION GRUPAL',                'N', 'S', 'INDIVIDUAL', '_in',  'S', 4, 'Inbox',    10,   'N', 'N', null, null,  'V', null, null)
insert into cr_reporte_on_boarding values ('120', null,                                              'SOLICITUD DE CREDITO COMPLEMENTARIA',         'N', 'N', 'INDIVIDUAL', '_in',  'N', 4, 'Customer', null, 'N', 'N', null, '006', 'V', null, null)
insert into cr_reporte_on_boarding values ('121', 'PagoCorresponsal.jasper',                         'FICHA DE PAGO INDIVIDUAL',                    'S', 'S', 'INDIVIDUAL', '_in',  'N', 4, null,       null, 'N', 'N', null, null,  'V', null, null)
--Grupal - REQ 197007
insert into cr_reporte_on_boarding values ('122', 'contratoCreditoInclusion.jasper',                 'CONTRATO GRUPAL',                             'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Inbox',    2,    'S', 'N', 90,   null,  'V', '1',  1)
insert into cr_reporte_on_boarding values ('123', 'caratulaCreditoGrupal.jasper',                    'CARATULA DE CREDITO GRUPAL',                  'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Inbox',    11,   'S', 'N', 90,   null,  'V', '1',  2)
insert into cr_reporte_on_boarding values ('124', 'tablaAmortizacion.jasper',                        'TABLA DE AMORTIZACION GRUPAL',                'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Inbox',    10,   'S', 'N', 90,   null,  'V', '1',  3)
insert into cr_reporte_on_boarding values ('125', 'kYCSimplificado.jasper',                          'FORMULARIO KYC',                              'S', 'N', 'GRUPAL',     '_gr',  'N', 4, 'Customer', null, 'S', 'N', 90,   '013', 'V', null, null)
insert into cr_reporte_on_boarding values ('126', 'ConsentimientoZurich.jasper',                     'CERTIFICADO CONSENTIMIENTO',                  'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Customer', null, 'S', 'N', 90,   '010', 'V', '2',  1)
insert into cr_reporte_on_boarding values ('127', 'ConsentSecurityBasic.jasper',                     'CERTIFICADO ASISTENCIA MEDICA',               'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Customer', null, 'S', 'N', 90,   '012', 'V', '2',  3)
insert into cr_reporte_on_boarding values ('128', 'asistenciaFuneraria.jasper',                      'CERTIFICADO ASISTENCIA FUNERARIA',            'S', 'S', 'GRUPAL',     '_gr',  'N', 4, 'Customer', null, 'S', 'N', 90,   '011', 'V', '2',  2)

go


IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding
go

create table cr_cli_reporte_on_boarding(
    co_ente int, -- relacionado con el otro    
	co_buc varchar(20),
	co_banco varchar(24),
	co_tramite int,
	co_email varchar(256),
	co_est_zip char(1),
	co_fecha_zip datetime,
	co_est_envio char(1),
	co_fecha_envio datetime,
	co_ruta_zip varchar(256),
	co_estd_clv_co varchar(1),
	co_fecha_reg   datetime 
)
go

CREATE INDEX cr_cli_reporte_on_boarding_AKey1
    ON cr_cli_reporte_on_boarding (co_ente)
GO

CREATE UNIQUE INDEX cr_cli_reporte_on_boarding_AKey2
    ON cr_cli_reporte_on_boarding (co_ente, co_banco)
GO

IF OBJECT_ID ('dbo.cr_cli_reporte_on_boarding_det') IS NOT NULL
    DROP TABLE cr_cli_reporte_on_boarding_det
go

create table cr_cli_reporte_on_boarding_det(
    cod_ente               int,
	cod_buc                varchar(20),
	cod_banco              varchar(24),
	cod_tramite            int,
	cod_cod_documento      varchar(10),
	cod_est_gen            char(1),
    cod_fecha_gen          datetime,
    cod_enviar_correo      char(1),
	cod_ruta_gen           varchar(256),
	cod_est_des_alfresco   char(1),
	cod_canal              int,
	cod_id_inst_proc       int,
	cod_grupo              int,
	cod_carpeta            varchar(10),
	cod_nombre_doc         varchar(255),
	cod_codigo_tipo_doc    smallint,
	cod_est_carga_alfresco char (1),
	cod_est_eliminar_doc   char (1),
	cod_id_inst_act        int,
	cod_cod_tipo_doc_cstmr char (10),
	cod_grp_unif           char (2),
	cod_orden_unif         int,
	cod_fecha_reg          datetime 
)
go

CREATE INDEX cr_cli_reporte_on_boarding_det_AKey1
    ON cr_cli_reporte_on_boarding_det (cod_ente)
GO

CREATE UNIQUE INDEX cr_cli_reporte_on_boarding_det_AKey2
    ON cr_cli_reporte_on_boarding_det (cod_ente, cod_banco, cod_cod_documento)
GO

go

-----------***********-----------***********-----------***********-----------***********
-----------REQ 200142 AplicaciOn Cuestionario
-----------***********-----------***********-----------***********-----------***********
IF OBJECT_ID ('cr_orden_eje_cuestionario') IS NOT NULL
	DROP TABLE cr_orden_eje_cuestionario
GO

create table cr_orden_eje_cuestionario (
    oe_tproducto varchar(10),
	oe_nemonico_regla varchar(10),
	oe_nombre_regla varchar(256),
	oe_orden int,
	oe_id_rol_wf int,
	oe_estado char(1),
	CONSTRAINT PK_cr_orden_eje_cuestionario PRIMARY KEY(oe_tproducto, oe_nemonico_regla, oe_orden)
)
--oe_id_rol_wf codigo de rol en la tabla cob_workflow..wf_rol
insert into cr_orden_eje_cuestionario values ('RENOVACION', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('GRUPAL', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('INDIVIDUAL', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')
insert into cr_orden_eje_cuestionario values ('REVOLVENTE', 'CUESGERT', 'CUESTIONARIO GERENTE', 1, 2, 'V')

insert into cr_orden_eje_cuestionario values ('RENOVACION', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('GRUPAL', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('INDIVIDUAL', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
insert into cr_orden_eje_cuestionario values ('REVOLVENTE', 'CUESCOOR', 'CUESTIONARIO COORDINADOR', 2, 4, 'V')
go

-----------***********
IF OBJECT_ID ('cr_ej_regla_aplica_cuest') IS NOT NULL
	DROP TABLE cr_ej_regla_aplica_cuest
GO

create table cr_ej_regla_aplica_cuest (
    er_id_inst_proc    int,
    er_tramite         int,	
	er_cliente         int, --integrante(s) en la solicitud
	er_tproducto       varchar(20),	
	er_aplica          char(1),
	er_orden           int,
	er_login           login, -- rol workflow	
	er_rol_w           int, -- rol workflow
	er_nemonico_regla  char(10),
	er_fecha_evalua    datetime,
	er_valores_reglas  varchar(256),
	er_in_etapa        char(1),
	er_est_en_cred     char(1)
)

create index cr_ej_regla_aplica_cuest_key
    on cob_credito..cr_ej_regla_aplica_cuest (er_id_inst_proc, er_cliente, er_tproducto)
go
