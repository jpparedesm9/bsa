USE cob_cartera
GO

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'tasas_periodos')
	DROP TABLE tasas_periodos
GO
CREATE TABLE tasas_periodos (
tdivi   FLOAT,
periodo FLOAT  
)

go


IF OBJECT_ID ('dbo.ca_control_pago') IS NOT NULL
    DROP TABLE dbo.ca_control_pago
GO

CREATE TABLE dbo.ca_control_pago
    (
    cp_grupo             INT NOT NULL,
    cp_referencia_grupal VARCHAR (15) NOT NULL,
    cp_operacion         INT NOT NULL,
    cp_dividendo_grupal  INT NOT NULL, 
    cp_dividendo         INT NOT NULL,
    cp_cuota_pactada     MONEY NULL,
    cp_saldo_pagar       MONEY NULL,
    cp_saldo_vencido     MONEY NULL,
    cp_pago              MONEY NULL,
    cp_ahorro            MONEY NULL,
    cp_extras            MONEY NULL,
    cp_pago_solidario    MONEY NULL,
    cp_gar_liquida_disp  MONEY NULL,
    cp_pago_gar_liquida  MONEY NULL,
    cp_pago_ahorro       MONEY NULL,
    cp_estado            smallint NULL
    CONSTRAINT pk_ca_control_pago PRIMARY KEY (
    cp_operacion         ,
    cp_referencia_grupal ,
    cp_dividendo_grupal  )
    )
GO






IF OBJECT_ID ('dbo.ca_pago_sostenido') IS NOT NULL
    DROP TABLE dbo.ca_pago_sostenido
GO

CREATE TABLE dbo.ca_pago_sostenido
    (
    ps_operacion               INT NOT NULL,
    ps_estado                  CHAR(1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.venta_archivo') IS NOT NULL
    DROP TABLE dbo.venta_archivo
GO

CREATE TABLE dbo.venta_archivo
    (
    obligacion VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.Totales_sarlaft_tmp') IS NOT NULL
    DROP TABLE dbo.Totales_sarlaft_tmp
GO

CREATE TABLE dbo.Totales_sarlaft_tmp
    (
    t_mensaje    VARCHAR (200),
    t_sec_refinh CHAR (1),
    t_totales    INT
    )
GO

IF OBJECT_ID ('dbo.tmp_transacciones') IS NOT NULL
    DROP TABLE dbo.tmp_transacciones
GO

CREATE TABLE dbo.tmp_transacciones
    (
    Mes           NVARCHAR (30),
    Producto      VARCHAR (1) NOT NULL,
    Trans         VARCHAR (3) NOT NULL,
    Cod_forma_pag catalogo NOT NULL,
    Des_forma_pag descripcion,
    Num_registro  INT,
    Valor         MONEY,
    Estado        VARCHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_totales_pag') IS NOT NULL
    DROP TABLE dbo.tmp_totales_pag
GO

CREATE TABLE dbo.tmp_totales_pag
    (
    operacion   INT NOT NULL,
    concepto    catalogo NOT NULL,
    descripcion descripcion NOT NULL,
    vencido1    MONEY NOT NULL,
    vigente1    MONEY NOT NULL,
    devolucion  MONEY NOT NULL,
    subtotal1   MONEY NOT NULL,
    spid        INT NOT NULL,
    recono      MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_tflexible_inttras') IS NOT NULL
    DROP TABLE dbo.tmp_tflexible_inttras
GO

CREATE TABLE dbo.tmp_tflexible_inttras
    (
    tfi_user          login,
    tfi_operacion     INT,
    tfi_dividendo     SMALLINT,
    tfi_hora          DATETIME,
    tfi_inttras_cta   MONEY,
    tfi_vr_disponible MONEY
    )
GO

CREATE INDEX tmp_tflexible_inttras_ix1
    ON dbo.tmp_tflexible_inttras (tfi_operacion, tfi_user)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.tmp_temp_sus') IS NOT NULL
    DROP TABLE dbo.tmp_temp_sus
GO

CREATE TABLE dbo.tmp_temp_sus
    (
    sc_spid       INT,
    sc_banco      cuenta,
    sc_codvalor   INT,
    sc_concepto   catalogo,
    sc_valor      MONEY,
    sc_valor_me   MONEY,
    sc_estado     INT,
    sc_perfil     catalogo,
    sc_estado_con CHAR (1),
    sc_operacion  INT
    )
GO

CREATE INDEX tmp_temp_sus_I1
    ON dbo.tmp_temp_sus (sc_spid)
GO

IF OBJECT_ID ('dbo.tmp_rubros_op_msv') IS NOT NULL
    DROP TABLE dbo.tmp_rubros_op_msv
GO

CREATE TABLE dbo.tmp_rubros_op_msv
    (
    ro_secuencia   INT,
    ro_concepto    catalogo,
    co_descripcion descripcion,
    ro_valor       MONEY,
    spid           INT
    )
GO

IF OBJECT_ID ('dbo.tmp_rubros_op_i') IS NOT NULL
    DROP TABLE dbo.tmp_rubros_op_i
GO

CREATE TABLE dbo.tmp_rubros_op_i
    (
    ro_concepto    catalogo,
    co_descripcion descripcion,
    ro_valor       MONEY,
    spid           INT
    )
GO

IF OBJECT_ID ('dbo.tmp_rubros_d') IS NOT NULL
    DROP TABLE dbo.tmp_rubros_d
GO

CREATE TABLE dbo.tmp_rubros_d
    (
    rot_concepto   catalogo,
    co_descripcion descripcion,
    rot_valor      MONEY NOT NULL,
    spid           INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_rubros_cr') IS NOT NULL
    DROP TABLE dbo.tmp_rubros_cr
GO

CREATE TABLE dbo.tmp_rubros_cr
    (
    concepto        VARCHAR (10),
    descripcion     VARCHAR (64),
    des_aplicar     VARCHAR (64),
    des_referencial VARCHAR (64),
    base            FLOAT,
    signo           CHAR (1),
    factor          FLOAT,
    total           FLOAT,
    minimo          FLOAT,
    maximo          FLOAT,
    prioridad       TINYINT,
    provisiona      CHAR (1),
    tipo_valor      catalogo,
    modalidad       CHAR (1),
    periodicidad    CHAR (1),
    desc_period     descripcion,
    tipo_rubro      CHAR (1),
    saldo_op        CHAR (1),
    saldo_por_desem CHAR (1),
    decimales       TINYINT,
    tipo_puntos     CHAR (1),
    tipo_tasa       CHAR (1),
    spid            INT
    )
GO

IF OBJECT_ID ('dbo.tmp_plano_msv') IS NOT NULL
    DROP TABLE dbo.tmp_plano_msv
GO

CREATE TABLE dbo.tmp_plano_msv
    (
    cadena VARCHAR (1000) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_plano_liq_msv') IS NOT NULL
    DROP TABLE dbo.tmp_plano_liq_msv
GO

CREATE TABLE dbo.tmp_plano_liq_msv
    (
    cadena VARCHAR (1000) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_plano_car') IS NOT NULL
    DROP TABLE dbo.tmp_plano_car
GO

CREATE TABLE dbo.tmp_plano_car
    (
    orden  INT NOT NULL,
    cadena VARCHAR (2000) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_Operacion_PAgos') IS NOT NULL
    DROP TABLE dbo.tmp_Operacion_PAgos
GO

CREATE TABLE dbo.tmp_Operacion_PAgos
    (
    Fecha               VARCHAR (10),
    [Oficina ]          SMALLINT NOT NULL,
    [Cliente ]          INT,
    [Nombre ]           descripcion,
    Operacion           INT NOT NULL,
    Nro_Obligacion      cuenta NOT NULL,
    Tipo_de_Plazo       catalogo,
    Sec_pago            INT,
    Monto_Pagado        MONEY,
    Valor_Cuota_Ant     MONEY,
    EstadoOp            descripcion,
    Tipo_Cobro          VARCHAR (10) NOT NULL,
    Tipo_Reduccion      VARCHAR (19),
    cantidad_cuotas_PAG INT NOT NULL,
    tasa_interes        FLOAT,
    ultimo_pago         VARCHAR (10),
    proximo_pago        VARCHAR (10),
    saldo_cap           MONEY,
    CAP                 MONEY,
    COMFNGANU           MONEY,
    IMO                 MONEY,
    [INT]               MONEY,
    IVACOMIFNG          MONEY,
    IVAMIPYMES          MONEY,
    MIPYMES             MONEY,
    SALDOSMINI          MONEY,
    SEGDEUVEN           MONEY
    )
GO

IF OBJECT_ID ('dbo.tmp_operacion') IS NOT NULL
    DROP TABLE dbo.tmp_operacion
GO

CREATE TABLE dbo.tmp_operacion
    (
    op_operacion INT NOT NULL,
    op_banco     cuenta NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_mon') IS NOT NULL
    DROP TABLE dbo.tmp_mon
GO

CREATE TABLE dbo.tmp_mon
    (
    tm_moneda TINYINT,
    tm_fecha  DATETIME,
    tm_trm    MONEY,
    tm_dec    TINYINT,
    spid      INT
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

IF OBJECT_ID ('dbo.tmp_interes_amortiza_msv') IS NOT NULL
    DROP TABLE dbo.tmp_interes_amortiza_msv
GO

CREATE TABLE dbo.tmp_interes_amortiza_msv
    (
    cuota    SMALLINT,
    monto    MONEY,
    concepto catalogo,
    tasa     FLOAT,
    spid     INT
    )
GO

IF OBJECT_ID ('dbo.tmp_garantias_tramite') IS NOT NULL
    DROP TABLE dbo.tmp_garantias_tramite
GO

CREATE TABLE dbo.tmp_garantias_tramite
    (
    spid        INT NOT NULL,
    gp_garantia VARCHAR (64),
    cu_tipo     descripcion
    )
GO

IF OBJECT_ID ('dbo.tmp_gar_especiales') IS NOT NULL
    DROP TABLE dbo.tmp_gar_especiales
GO

CREATE TABLE dbo.tmp_gar_especiales
    (
    spid    INT NOT NULL,
    ge_tipo VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.tmp_gar_especial') IS NOT NULL
    DROP TABLE dbo.tmp_gar_especial
GO

CREATE TABLE dbo.tmp_gar_especial
    (
    ge_tipo VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.tmp_fng') IS NOT NULL
    DROP TABLE dbo.tmp_fng
GO

CREATE TABLE dbo.tmp_fng
    (
    orden  INT NOT NULL,
    cadena VARCHAR (2000) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tmp_esalalf') IS NOT NULL
    DROP TABLE dbo.tmp_esalalf
GO

CREATE TABLE dbo.tmp_esalalf
    (
    tmp_oficina         SMALLINT NOT NULL,
    tmp_letra           VARCHAR (1),
    tmp_cliente         INT NOT NULL,
    tmp_nombre_cli      VARCHAR (100),
    tmp_operacion       INT,
    tmp_banco           VARCHAR (24) NOT NULL,
    tmp_num_id          VARCHAR (24),
    tmp_subtipo         VARCHAR (10),
    tmp_fecha_ini       DATETIME NOT NULL,
    tmp_moneda          TINYINT NOT NULL,
    tmp_saldo_cap       MONEY NOT NULL,
    tmp_defecto_gar     MONEY,
    tmp_saldo_int       MONEY NOT NULL,
    tmp_saldo_int_cont  MONEY NOT NULL,
    tmp_saldo_imo       MONEY,
    tmp_saldo_imo_cont  MONEY,
    tmp_prov_cap        MONEY,
    tmp_prov_int        MONEY,
    tmp_prov_cxc        MONEY,
    tmp_fecha_prox_venc DATETIME NOT NULL,
    tmp_dias_venc       INT,
    tmp_calificacion    VARCHAR (10) NOT NULL,
    tmp_dias_causados   INT,
    tmp_tasa_int        FLOAT,
    tmp_tipo_tabla      VARCHAR (10),
    tmp_clausula        VARCHAR (1),
    tmp_tipo_productor  VARCHAR (64),
    tmp_clase_cartera   VARCHAR (10) NOT NULL,
    tmp_des_clase_car   VARCHAR (64),
    tmp_fecha_ult_proc  DATETIME NOT NULL,
    tmp_toperacion      VARCHAR (10),
    tmp_tipo            VARCHAR (10),
    tmp_segvida         VARCHAR (10),
    tmp_segvehi         VARCHAR (10),
    tmp_max_vig_ven     INT,
    tmp_seg_vid_vig     MONEY,
    tmp_seg_vig_ven     MONEY,
    tmp_seg_vid_sig     MONEY,
    tmp_seg_sig         MONEY,
    tmp_gas_jud         MONEY,
    tmp_gas_otr         MONEY
    )
GO

IF OBJECT_ID ('dbo.tmp_en_tmp') IS NOT NULL
    DROP TABLE dbo.tmp_en_tmp
GO

CREATE TABLE dbo.tmp_en_tmp
    (
    en_usuario   login,
    en_terminal  VARCHAR (1),
    en_operacion INT,
    spid         INT
    )
GO

IF OBJECT_ID ('dbo.tmp_dec') IS NOT NULL
    DROP TABLE dbo.tmp_dec
GO

CREATE TABLE dbo.tmp_dec
    (
    letra   CHAR (1),
    num_dec TINYINT,
    spid    INT
    )
GO

IF OBJECT_ID ('dbo.tmp_cursor_operacion') IS NOT NULL
    DROP TABLE dbo.tmp_cursor_operacion
GO

CREATE TABLE dbo.tmp_cursor_operacion
    (
    op_spid              INT,
    op_banco             VARCHAR (24),
    op_operacion         INT,
    op_moneda            TINYINT,
    op_cap_susxcor       MONEY,
    op_estado            TINYINT,
    op_toperacion        VARCHAR (10),
    op_fecha_ult_proceso DATETIME,
    op_suspendio         CHAR (1),
    op_fecha_suspenso    DATETIME,
    op_migrada           cuenta,
    op_naturaleza        CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.tmp_colateral_msv') IS NOT NULL
    DROP TABLE dbo.tmp_colateral_msv
GO

CREATE TABLE dbo.tmp_colateral_msv
    (
    tipo_sub VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.tmp_archivo') IS NOT NULL
    DROP TABLE dbo.tmp_archivo
GO

CREATE TABLE dbo.tmp_archivo
    (
    registro VARCHAR (700)
    )
GO

IF OBJECT_ID ('dbo.temp_planos') IS NOT NULL
    DROP TABLE dbo.temp_planos
GO

CREATE TABLE dbo.temp_planos
    (
    s VARCHAR (255) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.temp_conv') IS NOT NULL
    DROP TABLE dbo.temp_conv
GO

CREATE TABLE dbo.temp_conv
    (
    rep_banco     cuenta NOT NULL,
    rep_opera     INT NOT NULL,
    rep_cedula    VARCHAR (30) NOT NULL,
    rep_nom       descripcion NOT NULL,
    rep_ofi       INT NOT NULL,
    rep_cuota     INT NOT NULL,
    rep_valor_rec MONEY NOT NULL,
    rep_valor_iva MONEY NOT NULL,
    fech_ini      DATETIME NOT NULL,
    fech_venc     DATETIME NOT NULL,
    rep_valor     MONEY NOT NULL,
    rep_conv      INT NOT NULL,
    sec_reg       INT IDENTITY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.tabla_tmp') IS NOT NULL
    DROP TABLE dbo.tabla_tmp
GO

CREATE TABLE dbo.tabla_tmp
    (
    pe_operacion       INT,
    pe_fecha           VARCHAR (10),
    pe_oficina         SMALLINT,
    pe_cliente         INT,
    pe_nombre          VARCHAR (60),
    pe_banco           VARCHAR (24),
    pe_tipo_plazo      VARCHAR (20),
    pe_monto_pago      MONEY,
    pe_valor_cuota     MONEY,
    pe_estado_opera    VARCHAR (20),
    pe_cuota           MONEY,
    pe_tipo_cobro      VARCHAR (20),
    re_tipo_reduccion  VARCHAR (30),
    pe_cuotas_antic    SMALLINT,
    pe_tasa_int        FLOAT,
    pe_fecha_ult_pago  DATETIME,
    pe_fecha_prox_pago DATETIME,
    pe_saldo_cap       MONEY,
    CAP                MONEY,
    COMFNGANU          MONEY,
    HONABO             MONEY,
    IMO                MONEY,
    [INT]              MONEY,
    IVACOMIFNG         MONEY,
    IVAHONOABO         MONEY,
    IVAMIPYMES         MONEY,
    MIPYMES            MONEY,
    SALDOSMINI         MONEY,
    SEGDEUVEN          MONEY,
    SOBRANTE           MONEY
    )
GO

IF OBJECT_ID ('dbo.sec_pago_rv') IS NOT NULL
    DROP TABLE dbo.sec_pago_rv
GO

CREATE TABLE dbo.sec_pago_rv
    (
    pag_oper INT,
    sec_ing  INT
    )
GO

IF OBJECT_ID ('dbo.rubros_tmp') IS NOT NULL
    DROP TABLE dbo.rubros_tmp
GO

CREATE TABLE dbo.rubros_tmp
    (
    fecha         SMALLDATETIME NOT NULL,
    banco         VARCHAR (24) NOT NULL,
    aplicativo    INT NOT NULL,
    saldo_cap     MONEY,
    saldo_int     MONEY,
    saldo_otr     MONEY,
    int_cont      MONEY,
    saldo_cap_cas MONEY,
    saldo_int_cas MONEY,
    saldo_otr_cas MONEY
    )
GO

IF OBJECT_ID ('dbo.reporte0028') IS NOT NULL
    DROP TABLE dbo.reporte0028
GO

CREATE TABLE dbo.reporte0028
    (
    oficina     INT,
    of_nombre   VARCHAR (64),
    pend_des    INT,
    mont_pdes   MONEY,
    num_desem   INT,
    mon_desem   MONEY,
    mora_30ma   MONEY,
    mora_30me   MONEY,
    mora_total  MONEY,
    cart_actn   INT,
    cart_actm   MONEY,
    sol_pendn   INT,
    sol_pendm   MONEY,
    sol_pendren INT,
    sol_pendrem MONEY,
    sol_pentotn INT,
    sol_pentotm MONEY,
    clientes    INT
    )
GO

IF OBJECT_ID ('dbo.reporte_reestruct_tmp') IS NOT NULL
    DROP TABLE dbo.reporte_reestruct_tmp
GO

CREATE TABLE dbo.reporte_reestruct_tmp
    (
    rr_cliente      INT,
    rr_obligacion   VARCHAR (24),
    rr_sld_capital  MONEY,
    rr_nva_fec_vcto VARCHAR (10),
    rr_mot_reest    VARCHAR (100)
    )
GO

IF OBJECT_ID ('dbo.reporte') IS NOT NULL
    DROP TABLE dbo.reporte
GO

CREATE TABLE dbo.reporte
    (
    rep_sec_pag       INT NOT NULL,
    rep_num_div       INT NOT NULL,
    rep_tmp_op        INT NOT NULL,
    rep_fec_ven       DATETIME NOT NULL,
    rep_saldo         MONEY NOT NULL,
    rep_cuota_cap     MONEY NOT NULL,
    rep_cuota_int     MONEY NOT NULL,
    rep_cuota_mor     MONEY NOT NULL,
    rep_porc_int      MONEY NOT NULL,
    rep_porc_mor      MONEY NOT NULL,
    rep_cuota_pymes   MONEY NOT NULL,
    rep_iva_pymes     MONEY NOT NULL,
    rep_fec_ini       DATETIME NOT NULL,
    rep_vlr_int_cau   MONEY NOT NULL,
    rep_valor_otr     MONEY NOT NULL,
    rep_cuota_abierta CHAR (2) NOT NULL,
    rep_acum_cap      MONEY NOT NULL,
    rep_acum_int      MONEY NOT NULL,
    rep_acum_mor      MONEY NOT NULL,
    rep_acum_cond     MONEY NOT NULL,
    rep_acum_pym      MONEY NOT NULL,
    rep_acum_iva_pym  MONEY NOT NULL,
    rep_dias_ret      INT NOT NULL,
    rep_numero        INT NOT NULL,
    rep_abono_cap     MONEY NOT NULL,
    rep_abono_int     MONEY NOT NULL,
    rep_abono_imo     MONEY NOT NULL,
    rep_abono_cond    MONEY NOT NULL,
    rep_abono_pym     MONEY NOT NULL,
    rep_abono_iva_pym MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.rep_prorecpag') IS NOT NULL
    DROP TABLE dbo.rep_prorecpag
GO

CREATE TABLE dbo.rep_prorecpag
    (
    tmp_nro_oper           INT,
    tmp_cod_ofi            SMALLINT,
    tmp_des_ofi            VARCHAR (64),
    tmp_cod_funcionario    SMALLINT,
    tmp_nombre_funcionario VARCHAR (64),
    tmp_fecha_ven          DATETIME,
    tmp_cap                MONEY,
    tmp_int                MONEY,
    tmp_imo                MONEY,
    tmp_mipymes            MONEY,
    tmp_ivamipymes         MONEY,
    tmp_otros              MONEY,
    tmp_valor_total        MONEY
    )
GO

IF OBJECT_ID ('dbo.reloj') IS NOT NULL
    DROP TABLE dbo.reloj
GO

CREATE TABLE dbo.reloj 
(
    programa char(40) NOT NULL,
    proceso  smallint NOT NULL,
    evento   char(10) NOT NULL,
    tiempo   datetime NOT NULL
)
go

IF OBJECT_ID ('dbo.registro_rec') IS NOT NULL
    DROP TABLE dbo.registro_rec
GO

CREATE TABLE dbo.registro_rec
    (
    registro VARCHAR (500)
    )
GO

IF OBJECT_ID ('dbo.recaudos_masivos_tmp3') IS NOT NULL
    DROP TABLE dbo.recaudos_masivos_tmp3
GO

CREATE TABLE dbo.recaudos_masivos_tmp3
    (
    r3_tipo      INT,
    r3_num_rec   INT,
    r3_fecha_pag DATETIME,
    r3_sum_valor MONEY,
    r3_filler    cuenta
    )
GO

IF OBJECT_ID ('dbo.prueba') IS NOT NULL
    DROP TABLE dbo.prueba
GO

CREATE TABLE dbo.prueba
    (
    op_operacion INT,
    op_banco     cuenta,
    op_anterior  cuenta
    )
GO

IF OBJECT_ID ('dbo.pro_cast_cartera') IS NOT NULL
    DROP TABLE dbo.pro_cast_cartera
GO

CREATE TABLE dbo.pro_cast_cartera
    (
    cod_ofi        SMALLINT,
    nombre         VARCHAR (64),
    banco          VARCHAR (24),
    cliente        INT,
    monto          MONEY,
    sald_cap       MONEY,
    sald_inte      MONEY,
    sald_otr       MONEY,
    tipo           VARCHAR (10),
    dias_mora      INT,
    ejecutivo      SMALLINT,
    ejecutivo_ori  SMALLINT,
    actividad      VARCHAR (10),
    fondo          VARCHAR (10),
    blanco         VARCHAR (50),
    blanco_1       VARCHAR (50),
    val_garantia   MONEY,
    estado_cartera INT
    )
GO

IF OBJECT_ID ('dbo.operaciones_tmp') IS NOT NULL
    DROP TABLE dbo.operaciones_tmp
GO

CREATE TABLE dbo.operaciones_tmp
    (
    op_oficina           SMALLINT NOT NULL,
    op_banco             cuenta NOT NULL,
    op_nombre            descripcion,
    op_monto             MONEY NOT NULL,
    op_moneda            TINYINT NOT NULL,
    op_migrada           cuenta NOT NULL,
    op_estado_cobranza   catalogo,
    op_estado            TINYINT NOT NULL,
    op_operacion         INT NOT NULL,
    op_cliente           INT,
    op_fecha_ult_proceso DATETIME NOT NULL,
    op_periodo_int       SMALLINT,
    op_tdividendo        catalogo,
    op_dias_anio         SMALLINT NOT NULL,
    op_base_calculo      CHAR (1),
    op_tipo_cobro        CHAR (1) NOT NULL,
    op_pago_caja         CHAR (1),
    op_naturaleza        CHAR (1),
    op_plazo             SMALLINT
    )
GO

IF OBJECT_ID ('dbo.operaciones_cartera') IS NOT NULL
    DROP TABLE dbo.operaciones_cartera
GO

CREATE TABLE dbo.operaciones_cartera
    (
    consecutivo    SMALLINT NOT NULL,
    operacion      VARCHAR (24) NOT NULL,
    fecha_ven      VARCHAR (10),
    entidad        VARCHAR (100),
    numero_cred    VARCHAR (24),
    numero_entidad VARCHAR (24),
    numero_cuota   SMALLINT,
    concepto       VARCHAR (64),
    valor_monto    MONEY
    )
GO

IF OBJECT_ID ('dbo.operaciones_ca') IS NOT NULL
    DROP TABLE dbo.operaciones_ca
GO

CREATE TABLE dbo.operaciones_ca
    (
    op_banco     cuenta NOT NULL,
    op_operacion INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.operaciones') IS NOT NULL
    DROP TABLE dbo.operaciones
GO

CREATE TABLE dbo.operaciones
    (
    estado    VARCHAR (1) NOT NULL,
    operacion INT
    )
GO

IF OBJECT_ID ('dbo.operacion_tmp') IS NOT NULL
    DROP TABLE dbo.operacion_tmp
GO

CREATE TABLE dbo.operacion_tmp
    (
    banco CHAR (24) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.operac') IS NOT NULL
    DROP TABLE dbo.operac
GO

CREATE TABLE dbo.operac
    (
    op         INT NOT NULL,
    porcentaje FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.opera') IS NOT NULL
    DROP TABLE dbo.opera
GO

CREATE TABLE dbo.opera
    (
    sec   INT IDENTITY NOT NULL,
    opera VARCHAR (24)
    )
GO

IF OBJECT_ID ('dbo.oper_cca') IS NOT NULL
    DROP TABLE dbo.oper_cca
GO

CREATE TABLE dbo.oper_cca
    (
    operacion INT,
    opbanco   cuenta,
    cliente   INT,
    moneda    TINYINT,
    monto     MONEY,
    capital   MONEY,
    interes   MONEY,
    intcont   MONEY,
    otros     MONEY,
    fechaini  DATETIME,
    fechafin  DATETIME,
    diasvto   INT
    )
GO

CREATE UNIQUE INDEX oper_cca_key
    ON dbo.oper_cca (operacion)
GO

IF OBJECT_ID ('dbo.oper_bcafe') IS NOT NULL
    DROP TABLE dbo.oper_bcafe
GO

CREATE TABLE dbo.oper_bcafe
    (
    oper INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.oper') IS NOT NULL
    DROP TABLE dbo.oper
GO

CREATE TABLE dbo.oper
    (
    operacion INT
    )
GO

IF OBJECT_ID ('dbo.mover_masivo_op_cliente') IS NOT NULL
    DROP TABLE dbo.mover_masivo_op_cliente
GO

CREATE TABLE dbo.mover_masivo_op_cliente
    (
    mmc_cliente  INT,
    mmc_ced_ruc  VARCHAR (24),
    mmc_accion   VARCHAR (10),
    mmc_estado   VARCHAR (50),
    mcc_autoriza VARCHAR (20),
    mmc_grupo    SMALLINT
    )
GO

IF OBJECT_ID ('dbo.mipymes') IS NOT NULL
    DROP TABLE dbo.mipymes
GO

CREATE TABLE dbo.mipymes
    (
    migrada cuenta,
    tasa    FLOAT
    )
GO

IF OBJECT_ID ('dbo.info_finagro_archivo') IS NOT NULL
    DROP TABLE dbo.info_finagro_archivo
GO

CREATE TABLE dbo.info_finagro_archivo
    (
    finagro_descripcion VARCHAR (2000)
    )
GO

IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_pag') IS NOT NULL
    DROP TABLE dbo.imp_recibo_pago_masivo_pag
GO

CREATE TABLE dbo.imp_recibo_pago_masivo_pag
    (
    dr_opbanco     cuenta,
    dr_tipo        catalogo,
    dr_concepto    VARCHAR (64),
    dr_cuenta      cuenta,
    dr_moneda      VARCHAR (24),
    dr_monto       MONEY,
    dr_cotizacion  MONEY,
    dr_monto_mop   MONEY,
    dr_descripcion VARCHAR (255),
    dr_num         INT
    )
GO

IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_det') IS NOT NULL
    DROP TABLE dbo.imp_recibo_pago_masivo_det
GO

CREATE TABLE dbo.imp_recibo_pago_masivo_det
    (
    dr_opbanco        cuenta,
    dr_tipo           VARCHAR (3),
    dr_concepto       VARCHAR (24),
    dr_cuenta         INT,
    dr_moneda         VARCHAR (6),
    dr_monto          MONEY,
    dr_descripcion    VARCHAR (6),
    dr_num            INT,
    dr_fecha_ven      VARCHAR (10),
    dr_fecha_ini      VARCHAR (10),
    dr_dias           INT,
    dr_porcentaje     FLOAT,
    dr_referencial    catalogo,
    dr_monto_mn       MONEY,
    dr_dias_ult_pag   INT,
    dr_fecha_ult_pago VARCHAR (10),
    dr_cuota_pago     INT
    )
GO

IF OBJECT_ID ('dbo.imp_recibo_pago_masivo_cab') IS NOT NULL
    DROP TABLE dbo.imp_recibo_pago_masivo_cab
GO

CREATE TABLE dbo.imp_recibo_pago_masivo_cab
    (
    re_opbanco       cuenta,
    re_cliente       INT,
    re_cliente_nomb  VARCHAR (64),
    re_ced_ruc       VARCHAR (24),
    re_toperacion    VARCHAR (64),
    re_moneda        VARCHAR (24),
    re_fechapag      DATETIME,
    re_num           INT,
    re_estado        CHAR (3),
    re_num_recibo    VARCHAR (10),
    re_ref_exterior  VARCHAR (20),
    re_fec_embarque  DATETIME,
    re_fec_dex       DATETIME,
    re_num_deuda_ext VARCHAR (15),
    re_num_comex     VARCHAR (15),
    re_nominal_imo   FLOAT,
    re_nominal_int   FLOAT,
    re_saldo_capital MONEY,
    re_referencia    VARCHAR (64),
    re_signo         CHAR (1),
    re_factor        FLOAT,
    re_oficial       INT,
    re_gerente       VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.gar_especiales') IS NOT NULL
    DROP TABLE dbo.gar_especiales
GO

CREATE TABLE dbo.gar_especiales
    (
    ge_sesion INT,
    ge_tipo   VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.detalle2_Comercial_tmp') IS NOT NULL
    DROP TABLE dbo.detalle2_Comercial_tmp
GO

CREATE TABLE dbo.detalle2_Comercial_tmp
    (
    C_SEC_REFINH          INT,
    C_TIPO_IDEN           CHAR (5),
    C_IDENTIFICAION       CHAR (13),
    C_NOMBRE_LARGO        VARCHAR (100),
    C_ORIGEN_REFINH       VARCHAR (10),
    C_ESTADO_REFINH       VARCHAR (10),
    C_FECHA_REFINH        VARCHAR (20),
    C_AUT_SARLAFT         CHAR (1),
    C_OBSERVACION_SARLAFT VARCHAR (80),
    C_USR_SARLAFT         login,
    C_FECHA_SARLAFT       VARCHAR (20),
    C_AUT_CIAL            CHAR (1),
    C_OBS_CIAL            VARCHAR (80),
    C_USR_CIAL            login,
    C_FECHA_CIAL          VARCHAR (20),
    C_VALIDA_TOTAL        CHAR (1),
    C_OFICINA             SMALLINT
    )
GO

IF OBJECT_ID ('dbo.detalle1_sarlaft_tmp') IS NOT NULL
    DROP TABLE dbo.detalle1_sarlaft_tmp
GO

CREATE TABLE dbo.detalle1_sarlaft_tmp
    (
    S_SEC_REFINH          INT,
    S_TIPO_IDEN           CHAR (5),
    S_IDENTIFICAION       CHAR (13),
    S_NOMBRE_LARGO        VARCHAR (100),
    S_ORIGEN_REFINH       VARCHAR (10),
    S_ESTADO_REFINH       VARCHAR (10),
    S_FECHA_REFINH        VARCHAR (20),
    S_AUT_SARLAFT         CHAR (1),
    S_OBSERVACION_SARLAFT VARCHAR (80),
    S_USR_SARLAFT         login,
    S_FECHA_SARLAFT       VARCHAR (20),
    S_AUT_CIAL            CHAR (1),
    S_OBS_CIAL            VARCHAR (80),
    S_USR_CIAL            login,
    S_FECHA_CIAL          VARCHAR (20),
    S_VALIDA_TOTAL        CHAR (1),
    S_OFICINA             SMALLINT
    )
GO

IF OBJECT_ID ('dbo.detalle_cliente_tmp') IS NOT NULL
    DROP TABLE dbo.detalle_cliente_tmp
GO

CREATE TABLE dbo.detalle_cliente_tmp
    (
    Ente          INT,
    Tipo_Doc      catalogo,
    Documento     CHAR (15),
    Nombre        VARCHAR (100),
    Oficina       INT,
    Actividad     catalogo,
    Des_Actividad VARCHAR (80),
    Nro_Operacion cuenta,
    EstadoOp      catalogo,
    Producto      TINYINT,
    Des_producto  VARCHAR (80),
    Canal         catalogo
    )
GO

IF OBJECT_ID ('dbo.det_desembolso') IS NOT NULL
    DROP TABLE dbo.det_desembolso
GO

CREATE TABLE dbo.det_desembolso
    (
    fecha       VARCHAR (10),
    oficina     INT,
    monto_desem MONEY
    )
GO

IF OBJECT_ID ('dbo.det_condonacion') IS NOT NULL
    DROP TABLE dbo.det_condonacion
GO

CREATE TABLE dbo.det_condonacion
    (
    cn_fecha              VARCHAR (10),
    cn_fecha_contable     VARCHAR (12),
    cn_banco              CHAR (24) NOT NULL,
    cn_nombre             VARCHAR (64),
    cn_ced_ruc            VARCHAR (30),
    cn_anio_castigo       VARCHAR (4),
    cn_fecha_fin          VARCHAR (12),
    cn_fecha_prox_cuota   VARCHAR (12),
    cn_oficina            VARCHAR (15),
    cn_tot_acon           INT NOT NULL,
    cn_valor_cancelado    MONEY,
    cn_capital            INT NOT NULL,
    cn_por_capcon         MONEY,
    cn_valor_cap_con_ven  MONEY,
    cn_porc_cap_con_ven   FLOAT,
    cn_valor_cap_con_vig  MONEY,
    cn_porc_cap_con_vig   FLOAT,
    cn_valor_cap_connoven MONEY,
    cn_porc_cap_connoven  FLOAT,
    cn_valor_cap_ex       MONEY,
    cn_porc_cap_ex        FLOAT,
    cn_int_acon           INT NOT NULL,
    cn_val_int_con        MONEY,
    cn_valor_int_con_ven  MONEY,
    cn_porc_int_con_ven   FLOAT,
    cn_valor_int_con_vig  MONEY,
    cn_porc_int_con_vig   FLOAT,
    cn_valor_int_ex       MONEY,
    cn_porc_int_ex        FLOAT,
    cn_imo_acon           INT NOT NULL,
    cn_imo_cond           MONEY,
    cn_por_imo_cond       FLOAT,
    cn_valor_imo_ex       MONEY,
    cn_porc_imo_ex        FLOAT,
    cn_otros              MONEY,
    cn_usuario            VARCHAR (14) NOT NULL,
    cn_cargo              VARCHAR (49) NOT NULL,
    cn_estado_ant         VARCHAR (22) NOT NULL,
    cn_estado             VARCHAR (64) NOT NULL,
    cn_dmora_acond        INT NOT NULL,
    cn_dmora_dcond        INT NOT NULL,
    cn_autoriza           VARCHAR (1),
    cn_autoriza_rol       TINYINT,
    cn_autoriza_usuario   VARCHAR (24)
    )
GO

IF OBJECT_ID ('dbo.cx_amortizacion') IS NOT NULL
    DROP TABLE dbo.cx_amortizacion
GO

CREATE TABLE dbo.cx_amortizacion
    (
    di_dividendo  INT NOT NULL,
    di_estado     TINYINT NOT NULL,
    di_dias_cuota INT NOT NULL,
    di_fecha_ven  DATETIME NOT NULL,
    ro_concepto   catalogo,
    ro_tipo_rubro CHAR (1) NOT NULL,
    cuota_total   MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.cruce') IS NOT NULL
    DROP TABLE dbo.cruce
GO

CREATE TABLE dbo.cruce
    (
    TRAMITE   INT,
    OPERACION INT,
    CLIENTE   INT,
    BANCO     VARCHAR (24),
    FECHA     DATETIME
    )
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

IF OBJECT_ID ('dbo.cr_reporte_tasas_det') IS NOT NULL
    DROP TABLE dbo.cr_reporte_tasas_det
GO

CREATE TABLE dbo.cr_reporte_tasas_det
    (
    NR_CREDITO        CHAR (24) NOT NULL,
    OFICINA           SMALLINT NOT NULL,
    VALOR_CREDITO     MONEY NOT NULL,
    TASA_CREDITO      FLOAT,
    TIPO_SEGURO1      INT,
    DESCRIPCION_SEG1  VARCHAR (20),
    MONTO_SEG1        MONEY,
    TASA_SEG1         FLOAT,
    DESCRIPCION_SEG_2 VARCHAR (255),
    MONTO_SEG_2       MONEY,
    TASA_SEG_2        FLOAT,
    DESCRIPCION_SEG_3 VARCHAR (255),
    MONTO_SEG_3       MONEY,
    TASA_SEG_3        FLOAT,
    DESCRIPCION_SEG_4 VARCHAR (255),
    MONTO_SEG_4       MONEY,
    TASA_SEG_4        FLOAT
    )
GO

IF OBJECT_ID ('dbo.cr_reporte_tasas_cab') IS NOT NULL
    DROP TABLE dbo.cr_reporte_tasas_cab
GO

CREATE TABLE dbo.cr_reporte_tasas_cab
    (
    rtc_credito      VARCHAR (30),
    rtc_oficina      VARCHAR (30),
    rtc_vr_credito   VARCHAR (30),
    rtc_tasa_credito VARCHAR (30),
    rtc_tipo_seguro  VARCHAR (30),
    rtc_desc_seg1    VARCHAR (30),
    rtc_monto_seg1   VARCHAR (30),
    rtc_tasa_seg1    VARCHAR (30),
    rtc_desc_seg2    VARCHAR (30),
    rtc_monto_seg2   VARCHAR (30),
    rtc_tasa_seg2    VARCHAR (30),
    rtc_desc_seg3    VARCHAR (30),
    rtc_monto_seg3   VARCHAR (30),
    rtc_tasa_seg3    VARCHAR (30),
    rtc_desc_seg4    VARCHAR (30),
    rtc_monto_seg4   VARCHAR (30),
    rtc_tasa_seg4    VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ConceptosMORA') IS NOT NULL
    DROP TABLE dbo.ConceptosMORA
GO

CREATE TABLE dbo.ConceptosMORA
    (
    sec      INT IDENTITY NOT NULL,
    concepto catalogo
    )
GO

IF OBJECT_ID ('dbo.comparar_cobis') IS NOT NULL
    DROP TABLE dbo.comparar_cobis
GO

CREATE TABLE dbo.comparar_cobis
    (
    nit1       cuenta,
    nombre1    descripcion,
    banco1     cuenta,
    migrada1   cuenta,
    linea1     catalogo,
    saldocap1  MONEY,
    saldoint1  MONEY,
    saldoimo1  MONEY,
    saldocont1 MONEY,
    seguro1    MONEY
    )
GO

IF OBJECT_ID ('dbo.capital') IS NOT NULL
    DROP TABLE dbo.capital
GO

CREATE TABLE dbo.capital
    (
    concepto   catalogo,
    secuencia  TINYINT,
    estado     SMALLINT,
    valor_acum MONEY,
    valor_pag  MONEY,
    codigo     INT
    )
GO

IF OBJECT_ID ('dbo.cabecera_tmp_pag_ext') IS NOT NULL
    DROP TABLE dbo.cabecera_tmp_pag_ext
GO

CREATE TABLE dbo.cabecera_tmp_pag_ext
    (
    campo1 VARCHAR (1000)
    )
GO

IF OBJECT_ID ('dbo.cabecera') IS NOT NULL
    DROP TABLE dbo.cabecera
GO

CREATE TABLE dbo.cabecera
    (
    oficina     VARCHAR (30),
    of_nombre   VARCHAR (30),
    pend_des    VARCHAR (30),
    mont_pdes   VARCHAR (30),
    num_desem   VARCHAR (30),
    mon_desem   VARCHAR (30),
    mora_30ma   VARCHAR (30),
    mora_30me   VARCHAR (30),
    mora_total  VARCHAR (30),
    cart_actn   VARCHAR (30),
    cart_actm   VARCHAR (30),
    sol_pendn   VARCHAR (30),
    sol_pendm   VARCHAR (30),
    sol_pendren VARCHAR (30),
    sol_pendrem VARCHAR (30),
    sol_pentotn VARCHAR (30),
    sol_pentotm VARCHAR (30),
    clientes    VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.cab_desembolso') IS NOT NULL
    DROP TABLE dbo.cab_desembolso
GO

CREATE TABLE dbo.cab_desembolso
    (
    fecha   VARCHAR (30),
    oficina VARCHAR (30),
    monto   VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.cab_condonacion') IS NOT NULL
    DROP TABLE dbo.cab_condonacion
GO

CREATE TABLE dbo.cab_condonacion
    (
    obligacion         VARCHAR (30),
    cliente            VARCHAR (30),
    cedula             VARCHAR (30),
    oficina            VARCHAR (30),
    valor_tot_oblig    VARCHAR (30),
    valor_cancelado    VARCHAR (30),
    valor_cap          VARCHAR (30),
    valor_cap_cond     VARCHAR (30),
    valor_int          VARCHAR (30),
    valor_int_cond     VARCHAR (30),
    porce_int          VARCHAR (30),
    valor_mora         VARCHAR (30),
    valor_mora_cond    VARCHAR (30),
    porce_mora         VARCHAR (30),
    otros              VARCHAR (30),
    fecha_cond         VARCHAR (30),
    usuario            VARCHAR (30),
    cargo              VARCHAR (30),
    estado_ant         VARCHAR (30),
    dias_mora_ant      VARCHAR (30),
    dias_mora          VARCHAR (30),
    fecha_contable     VARCHAR (30),
    anio_castigo       VARCHAR (30),
    fecha_fin          VARCHAR (30),
    fecha_prox_cuota   VARCHAR (30),
    valor_cap_con_ven  VARCHAR (30),
    porc_cap_con_ven   VARCHAR (30),
    valor_cap_con_vig  VARCHAR (30),
    porc_cap_con_vig   VARCHAR (30),
    valor_int_vig      VARCHAR (30),
    valor_int_con_vig  VARCHAR (30),
    porc_int_con_vig   VARCHAR (30),
    valor_int_ven      VARCHAR (30),
    valor_int_con_ven  VARCHAR (30),
    porc_int_con_ven   VARCHAR (30),
    autoriza_cond      VARCHAR (30),
    autoriza_rol       VARCHAR (30),
    autoriza_usuario   VARCHAR (30),
    porc_cap_connoven  VARCHAR (30),
    valor_cap_connoven VARCHAR (30),
    porc_cap_ex        VARCHAR (30),
    valor_cap_ex       VARCHAR (30),
    porc_int_ex        VARCHAR (30),
    valor_int_ex       VARCHAR (30),
    porc_imo_ex        VARCHAR (30),
    valor_imo_ex       VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_verificacion') IS NOT NULL
    DROP TABLE dbo.ca_verificacion
GO

CREATE TABLE dbo.ca_verificacion
    (
    ve_operacion       INT,
    ve_saldo_cap_ini   MONEY,
    ve_saldo_int_ini   MONEY,
    ve_saldo_otros_ini MONEY,
    ve_nuevos_cap      MONEY,
    ve_pagos_cap       MONEY,
    ve_causacion_int   MONEY,
    ve_pagos_int       MONEY,
    ve_ing_otros       MONEY,
    ve_pagos_otros     MONEY,
    ve_saldo_cap_hoy   MONEY,
    ve_saldo_int_hoy   MONEY,
    ve_saldo_otros_hoy MONEY,
    ve_cuadra          CHAR (2)
    )
GO

CREATE UNIQUE INDEX ca_verificacion_1
    ON dbo.ca_verificacion (ve_operacion)
GO

IF OBJECT_ID ('dbo.ca_venta_universo') IS NOT NULL
    DROP TABLE dbo.ca_venta_universo
GO

CREATE TABLE dbo.ca_venta_universo
    (
    Id_cliente             VARCHAR (30),
    Nombre_Cliente         VARCHAR (254),
    Tipo_Identificacion    CHAR (2),
    Segmento               VARCHAR (64),
    Ciudad_Desembolso      VARCHAR (64),
    Tipo_Producto          CHAR (10),
    Saldo_capital          MONEY,
    Intereses              MONEY,
    Otros_cargos           MONEY,
    Saldo_deuda_total      MONEY,
    Saldo_Mora             MONEY,
    Fecha_desembolso       VARCHAR (10),
    Valor_desembolso       MONEY,
    Plazo_credito          SMALLINT,
    Fecha_Mora             VARCHAR (10),
    Fecha_Castigo          VARCHAR (10),
    Edad_Mora              INT,
    Numero_Obli_o_Crd      VARCHAR (24),
    Existencia_acuerdo_pag CHAR (1),
    Estado_Cobranza        VARCHAR (64),
    Ciudad_Cred            VARCHAR (64),
    Valor_pagado           MONEY,
    Fecha_Ult_pago         VARCHAR (10),
    Capital_Pagado         MONEY,
    Intereses_pagados      MONEY,
    Otros_concep_pag       MONEY,
    Direccion_Cliente      VARCHAR (254),
    Ciudad                 VARCHAR (64),
    Telefono               VARCHAR (26),
    Fecha_Nacimiento       VARCHAR (10),
    Ingresos               MONEY,
    Egresos                MONEY,
    Estrato                VARCHAR (10),
    Nivel_Estudio          VARCHAR (64),
    Profesion              VARCHAR (64),
    Nota_Interna_Bmia      TINYINT,
    Calificacion_Op        CHAR (1),
    operacion_interna      INT,
    Banca                  CHAR (10),
    Oficina                SMALLINT,
    Cod_CIIU               VARCHAR (10),
    Fecha_Venta            DATETIME,
    Secuencial_Ing_Ven     INT,
    Secuencial_Ing_Vig     INT,
    Secuencial_Ing_Nvig    INT,
    Estado_Venta           CHAR (1),
    Id_Comprador           INT,
    Porc_Venta             FLOAT
    )
GO

CREATE CLUSTERED INDEX ca_venta_universo_idx1
    ON dbo.ca_venta_universo (operacion_interna)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_vencimiento_reajuste_t2') IS NOT NULL
    DROP TABLE dbo.ca_vencimiento_reajuste_t2
GO

CREATE TABLE dbo.ca_vencimiento_reajuste_t2
    (
    sp_id                     INT NOT NULL,
    s_term                    descripcion,
    mo_numero_de_operacion    INT,
    mo_tipo_de_producto       catalogo,
    mo_moneda                 TINYINT,
    mo_numero_de_banco        cuenta,
    mo_monto_desembolso       MONEY,
    mo_cliente                INT,
    mo_nombre_cliente         descripcion,
    mo_fecha_inicio_op        DATETIME,
    mo_numero_cuotas_vencidas INT,
    mo_fecha_prox_vencimiento DATETIME,
    valor_vencido             MONEY,
    mo_fecha_ven_op           DATETIME,
    mo_dias_vencido_op        SMALLINT,
    mo_fecha_de_proceso       DATETIME
    )
GO

CREATE INDEX ca_vencimiento_reajuste_t2_1
    ON dbo.ca_vencimiento_reajuste_t2 (sp_id, s_term)
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
    op_tipo_linea     catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_valores_tmp_rub') IS NOT NULL
    DROP TABLE dbo.ca_valores_tmp_rub
GO

CREATE TABLE dbo.ca_valores_tmp_rub
    (
    vat_operacion INT NOT NULL,
    vat_rubro     catalogo,
    vat_valor     MONEY NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_valores_tmp_rub_1
    ON dbo.ca_valores_tmp_rub (vat_operacion, vat_rubro)
GO

IF OBJECT_ID ('dbo.ca_valores_tmp') IS NOT NULL
    DROP TABLE dbo.ca_valores_tmp
GO

CREATE TABLE dbo.ca_valores_tmp
    (
    vat_operacion INT NOT NULL,
    vat_dividendo INT NOT NULL,
    vat_rubro     catalogo NOT NULL,
    vat_valor     MONEY NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_valores_tmp_1
    ON dbo.ca_valores_tmp (vat_operacion, vat_dividendo, vat_rubro)
GO

IF OBJECT_ID ('dbo.ca_valores_pag') IS NOT NULL
    DROP TABLE dbo.ca_valores_pag
GO

CREATE TABLE dbo.ca_valores_pag
    (
    vp_periodo    INT,
    vp_cliente    INT,
    vp_operacion  INT,
    vp_banco      cuenta,
    vp_oficina    SMALLINT,
    vp_toperacion catalogo,
    vp_int_pag    MONEY,
    vp_imo_pag    MONEY,
    vp_saldo      MONEY
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_valores_pag_key
    ON dbo.ca_valores_pag (vp_periodo, vp_cliente, vp_banco)
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

IF OBJECT_ID ('dbo.ca_valores') IS NOT NULL
    DROP TABLE dbo.ca_valores
GO

CREATE TABLE dbo.ca_valores
    (
    va_operacion INT NOT NULL,
    va_dividendo INT NOT NULL,
    va_rubro     catalogo NOT NULL,
    va_valor     MONEY NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_valores_1
    ON dbo.ca_valores (va_operacion, va_dividendo, va_rubro)
GO

IF OBJECT_ID ('dbo.ca_valor_ts') IS NOT NULL
    DROP TABLE dbo.ca_valor_ts
GO

CREATE TABLE dbo.ca_valor_ts
    (
    vas_fecha_proceso_ts DATETIME NOT NULL,
    vas_fecha_ts         DATETIME NOT NULL,
    vas_usuario_ts       login NOT NULL,
    vas_oficina_ts       SMALLINT NOT NULL,
    vas_terminal_ts      VARCHAR (30) NOT NULL,
    vas_tipo             VARCHAR (10) NOT NULL,
    vas_descripcion      VARCHAR (64) NOT NULL,
    vas_clase            CHAR (1) NOT NULL,
    vas_pit              CHAR (1),
    vas_prime            CHAR (1)
    )
GO

CREATE INDEX ca_valor_ts_1
    ON dbo.ca_valor_ts (vas_fecha_proceso_ts)
GO

CREATE INDEX ca_valor_ts_2
    ON dbo.ca_valor_ts (vas_fecha_ts)
GO

CREATE INDEX ca_valor_ts_3
    ON dbo.ca_valor_ts (vas_usuario_ts)
GO

CREATE INDEX ca_valor_ts_4
    ON dbo.ca_valor_ts (vas_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_valor_referencial_ts') IS NOT NULL
    DROP TABLE dbo.ca_valor_referencial_ts
GO

CREATE TABLE dbo.ca_valor_referencial_ts
    (
    vrs_fecha_proceso_ts DATETIME NOT NULL,
    vrs_fecha_ts         DATETIME NOT NULL,
    vrs_usuario_ts       login NOT NULL,
    vrs_oficina_ts       SMALLINT NOT NULL,
    vrs_terminal_ts      VARCHAR (30) NOT NULL,
    vrs_tipo             VARCHAR (10) NOT NULL,
    vrs_valor            FLOAT NOT NULL,
    vrs_fecha_vig        DATETIME NOT NULL,
    vrs_secuencial       INT NOT NULL
    )
GO

CREATE INDEX ca_valor_referencial_ts_1
    ON dbo.ca_valor_referencial_ts (vrs_fecha_proceso_ts)
GO

CREATE INDEX ca_valor_referencial_ts_2
    ON dbo.ca_valor_referencial_ts (vrs_fecha_ts)
GO

CREATE INDEX ca_valor_referencial_ts_3
    ON dbo.ca_valor_referencial_ts (vrs_usuario_ts)
GO

CREATE INDEX ca_valor_referencial_ts_4
    ON dbo.ca_valor_referencial_ts (vrs_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_valor_referencial_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_valor_referencial_bancamia
GO

CREATE TABLE dbo.ca_valor_referencial_bancamia
    (
    vr_tipo       VARCHAR (10) NOT NULL,
    vr_valor      FLOAT NOT NULL,
    vr_fecha_vig  DATETIME NOT NULL,
    vr_secuencial INT NOT NULL
    )
GO

CREATE CLUSTERED INDEX ca_valor_referencial_1
    ON dbo.ca_valor_referencial_bancamia (vr_tipo, vr_fecha_vig, vr_secuencial)
GO

IF OBJECT_ID ('dbo.ca_valor_det_ts') IS NOT NULL
    DROP TABLE dbo.ca_valor_det_ts
GO

CREATE TABLE dbo.ca_valor_det_ts
    (
    vds_fecha_proceso_ts DATETIME NOT NULL,
    vds_fecha_ts         DATETIME NOT NULL,
    vds_usuario_ts       login NOT NULL,
    vds_oficina_ts       SMALLINT NOT NULL,
    vds_terminal_ts      VARCHAR (30) NOT NULL,
    vds_tipo             VARCHAR (10) NOT NULL,
    vds_sector           catalogo NOT NULL,
    vds_signo_default    CHAR (1),
    vds_valor_default    FLOAT,
    vds_signo_maximo     CHAR (1),
    vds_valor_maximo     FLOAT,
    vds_signo_minimo     CHAR (1),
    vds_valor_minimo     FLOAT,
    vds_referencia       VARCHAR (10),
    vds_tipo_puntos      CHAR (1),
    vds_num_dec          TINYINT
    )
GO

CREATE INDEX ca_valor_det_ts_1
    ON dbo.ca_valor_det_ts (vds_fecha_proceso_ts)
GO

CREATE INDEX ca_valor_det_ts_2
    ON dbo.ca_valor_det_ts (vds_fecha_ts)
GO

CREATE INDEX ca_valor_det_ts_3
    ON dbo.ca_valor_det_ts (vds_usuario_ts)
GO

CREATE INDEX ca_valor_det_ts_4
    ON dbo.ca_valor_det_ts (vds_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_valor_det') IS NOT NULL
    DROP TABLE dbo.ca_valor_det
GO

CREATE TABLE dbo.ca_valor_det
    (
    vd_tipo          VARCHAR (10) NOT NULL,
    vd_sector        catalogo NOT NULL,
    vd_signo_default CHAR (1),
    vd_valor_default FLOAT,
    vd_signo_maximo  CHAR (1),
    vd_valor_maximo  FLOAT,
    vd_signo_minimo  CHAR (1),
    vd_valor_minimo  FLOAT,
    vd_referencia    VARCHAR (10),
    vd_tipo_puntos   CHAR (1),
    vd_num_dec       TINYINT
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_valor_det_1
    ON dbo.ca_valor_det (vd_tipo, vd_sector)
GO

IF OBJECT_ID ('dbo.ca_valor_desbloqueo') IS NOT NULL
    DROP TABLE dbo.ca_valor_desbloqueo
GO

CREATE TABLE dbo.ca_valor_desbloqueo
    (
    vd_vlrinicial MONEY NOT NULL,
    vd_vlrfinal   MONEY NOT NULL,
    vd_tipovalor  CHAR (1) NOT NULL,
    vd_valor      MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_valor_atx') IS NOT NULL
    DROP TABLE dbo.ca_valor_atx
GO

CREATE TABLE dbo.ca_valor_atx
    (
    vx_oficina         INT NOT NULL,
    vx_banco           VARCHAR (24) NOT NULL,
    vx_ced_ruc         VARCHAR (30) NOT NULL,
    vx_nombre          VARCHAR (64) NOT NULL,
    vx_monto           MONEY,
    vx_monto_max       MONEY,
    vx_moneda          TINYINT,
    vx_valor_vencido   MONEY,
    vx_migrada         cuenta,
    vx_estado_cobranza catalogo,
    vx_monto_total     MONEY,
    vx_cuotas          SMALLINT,
    vx_ven_vigente     DATETIME,
    vx_dias_mora       INT,
    vx_cuotas_ven      SMALLINT,
    vx_estado          TINYINT,
    vx_nota            TINYINT,
    CONSTRAINT pk_ca_valor_atx PRIMARY KEY (vx_banco)
    )
GO

CREATE INDEX ca_va_cr
    ON dbo.ca_valor_atx (vx_ced_ruc)
GO

IF OBJECT_ID ('dbo.ca_valor_acumulado_antant') IS NOT NULL
    DROP TABLE dbo.ca_valor_acumulado_antant
GO

CREATE TABLE dbo.ca_valor_acumulado_antant
    (
    va_operacion      INT NOT NULL,
    va_valor_acum     MONEY NOT NULL,
    va_secuencial_ing INT NOT NULL,
    va_secuencia      INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_valor') IS NOT NULL
    DROP TABLE dbo.ca_valor
GO

CREATE TABLE dbo.ca_valor
    (
    va_tipo        VARCHAR (10) NOT NULL,
    va_descripcion VARCHAR (64) NOT NULL,
    va_clase       CHAR (1) NOT NULL,
    va_pit         CHAR (1),
    va_prime       CHAR (1)
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_valor_1
    ON dbo.ca_valor (va_tipo)
GO

IF OBJECT_ID ('dbo.ca_val_oper_finagro_tmp') IS NOT NULL
    DROP TABLE dbo.ca_val_oper_finagro_tmp
GO

CREATE TABLE dbo.ca_val_oper_finagro_tmp
    (
    vo_ced_ruc      numero,
    vo_tipo_ruc     CHAR (2),
    vo_operacion    VARCHAR (25),
    vo_oper_finagro VARCHAR (30),
    vo_num_gar      VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_val_oper_finagro_log') IS NOT NULL
    DROP TABLE dbo.ca_val_oper_finagro_log
GO

CREATE TABLE dbo.ca_val_oper_finagro_log
    (
    vo_operacion    VARCHAR (25),
    vo_ced_ruc      numero,
    vo_tipo_ruc     CHAR (2),
    vo_oper_finagro VARCHAR (30),
    vo_num_gar      VARCHAR (30),
    vo_estado       CHAR (1),
    vo_fecha        DATETIME,
    vo_comentario   VARCHAR (250)
    )
GO

CREATE INDEX ca_val_oper_finagro_log_1
    ON dbo.ca_val_oper_finagro_log (vo_fecha)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX ca_val_oper_finagro_log_2
    ON dbo.ca_val_oper_finagro_log (vo_operacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_val_oper_finagro_1') IS NOT NULL
    DROP TABLE dbo.ca_val_oper_finagro_1
GO

CREATE TABLE dbo.ca_val_oper_finagro_1
    (
    cadena VARCHAR (1000) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_val_oper_finagro') IS NOT NULL
    DROP TABLE dbo.ca_val_oper_finagro
GO

CREATE TABLE dbo.ca_val_oper_finagro
    (
    vo_operacion    VARCHAR (25),
    vo_ced_ruc      numero,
    vo_tipo_ruc     CHAR (2),
    vo_oper_finagro VARCHAR (30),
    vo_num_gar      VARCHAR (30),
    vo_estado       CHAR (1),
    vo_fecha        DATETIME,
    vo_comentario   VARCHAR (250)
    )
GO

IF OBJECT_ID ('dbo.ca_uvr_subir') IS NOT NULL
    DROP TABLE dbo.ca_uvr_subir
GO

CREATE TABLE dbo.ca_uvr_subir
    (
    migrada        cuenta,
    banco          cuenta,
    operacion      INT,
    concepto       catalogo,
    referencial    catalogo,
    signo          CHAR (1),
    porcentaje_nom FLOAT,
    porcentaje_efa FLOAT,
    tipo_puntos    CHAR (1),
    procesado      CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_uvr_proyectado') IS NOT NULL
    DROP TABLE dbo.ca_uvr_proyectado
GO

CREATE TABLE dbo.ca_uvr_proyectado
    (
    up_fecha      DATETIME NOT NULL,
    up_cotizacion FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_universo_venta') IS NOT NULL
    DROP TABLE dbo.ca_universo_venta
GO

CREATE TABLE dbo.ca_universo_venta
    (
    ub_operacion INT,
    ub_estado    CHAR (1),
    ub_intentos  SMALLINT
    )
GO

CREATE INDEX ca_universo_venta_idx1
    ON dbo.ca_universo_venta (ub_operacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_universo_operaciones') IS NOT NULL
    DROP TABLE dbo.ca_universo_operaciones
GO

CREATE TABLE dbo.ca_universo_operaciones
    (
    ub_dato       INT,
    ub_id_carga   INT,
    ub_id_alianza INT,
    ub_estado     CHAR (1),
    ub_intentos   TINYINT,
    ub_tipo_tra   CHAR (1)
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_universo_operaciones (ub_estado, ub_dato, ub_tipo_tra)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_universo_conta') IS NOT NULL
    DROP TABLE dbo.ca_universo_conta
GO

CREATE TABLE dbo.ca_universo_conta
    (
    ub_operacion  INT,
    ub_secuencial INT,
    ub_fecha_mov  SMALLDATETIME,
    ub_fecha_ref  SMALLDATETIME,
    ub_ofi_usu    SMALLINT,
    ub_tran       catalogo,
    ub_estado     VARCHAR (2),
    ub_intentos   TINYINT
    )
GO

CREATE INDEX idx1
    ON dbo.ca_universo_conta (ub_estado, ub_operacion, ub_secuencial)
GO

CREATE INDEX idx2
    ON dbo.ca_universo_conta (ub_operacion, ub_secuencial)
GO

IF OBJECT_ID ('dbo.ca_universo_cartera') IS NOT NULL
    DROP TABLE dbo.ca_universo_cartera
GO

CREATE TABLE dbo.ca_universo_cartera
    (
    uc_cliente        INT,
    uc_documento      VARCHAR (30),
    uc_rol            CHAR (1),
    uc_dias_mora      INT,
    uc_saldo_mora     MONEY,
    uc_valor_aplicado MONEY,
    uc_tipo_op        VARCHAR (10),
    uc_cuenta         INT,
    uc_operacion      VARCHAR (20),
    uc_observacion    VARCHAR (255),
    uc_estado         CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_universo_batch') IS NOT NULL
    DROP TABLE dbo.ca_universo_batch
GO

CREATE TABLE dbo.ca_universo_batch
    (
    ub_operacion INT,
    ub_estado    VARCHAR (2),
    ub_intentos  TINYINT
    )
GO

CREATE INDEX idx1
    ON dbo.ca_universo_batch (ub_estado, ub_operacion)
GO

IF OBJECT_ID ('dbo.ca_ultima_tasa_op') IS NOT NULL
    DROP TABLE dbo.ca_ultima_tasa_op
GO

CREATE TABLE dbo.ca_ultima_tasa_op
    (
    ut_operacion             INT NOT NULL,
    ut_concepto              catalogo NOT NULL,
    ut_referencial           catalogo NOT NULL,
    ut_signo                 CHAR (1) NOT NULL,
    ut_factor                FLOAT NOT NULL,
    ut_reajuste_especial     CHAR (1) NOT NULL,
    ut_tipo_puntos           CHAR (1) NOT NULL,
    ut_fecha_pri_referencial DATETIME NOT NULL,
    ut_fecha_act             DATETIME NOT NULL,
    ut_porcentaje            FLOAT,
    ut_porcentaje_efa        FLOAT
    )
GO

CREATE UNIQUE INDEX ca_ultima_tasa_op_1
    ON dbo.ca_ultima_tasa_op (ut_operacion, ut_concepto)
GO

IF OBJECT_ID ('dbo.ca_trn_oper_ts') IS NOT NULL
    DROP TABLE dbo.ca_trn_oper_ts
GO

CREATE TABLE dbo.ca_trn_oper_ts
    (
    tos_fecha_proceso_ts    DATETIME NOT NULL,
    tos_fecha_ts            DATETIME NOT NULL,
    tos_usuario_ts          login NOT NULL,
    tos_oficina_ts          SMALLINT NOT NULL,
    tos_terminal_ts         VARCHAR (30) NOT NULL,
    tos_tipo_transaccion_ts INT NOT NULL,
    tos_origen_ts           CHAR (1) NOT NULL,
    tos_clase_ts            CHAR (1) NOT NULL,
    tos_toperacion          catalogo NOT NULL,
    tos_tipo_trn            catalogo NOT NULL,
    tos_perfil              catalogo NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_trn_oper_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_trn_oper_bancamia
GO

CREATE TABLE dbo.ca_trn_oper_bancamia
    (
    to_toperacion VARCHAR (10) NOT NULL,
    to_tipo_trn   VARCHAR (10) NOT NULL,
    to_perfil     VARCHAR (10) NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_trn_oper_1
    ON dbo.ca_trn_oper_bancamia (to_toperacion, to_tipo_trn)
GO

IF OBJECT_ID ('dbo.ca_trn_oper') IS NOT NULL
    DROP TABLE dbo.ca_trn_oper
GO

CREATE TABLE dbo.ca_trn_oper
    (
    to_toperacion catalogo NOT NULL,
    to_tipo_trn   catalogo NOT NULL,
    to_perfil     catalogo NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_trn_oper_1
    ON dbo.ca_trn_oper (to_toperacion, to_tipo_trn)
GO

IF OBJECT_ID ('dbo.ca_traslados_cartera') IS NOT NULL
    DROP TABLE dbo.ca_traslados_cartera
GO

CREATE TABLE dbo.ca_traslados_cartera
    (
    trc_fecha_proceso   DATETIME NOT NULL,
    trc_cliente         INT NOT NULL,
    trc_operacion       INT NOT NULL,
    trc_user            login NOT NULL,
    trc_oficina_origen  INT NOT NULL,
    trc_oficina_destino INT NOT NULL,
    trc_estado          CHAR (1) NOT NULL,
    trc_garantias       CHAR (1) NOT NULL,
    trc_credito         CHAR (1) NOT NULL,
    trc_sidac           CHAR (1) NOT NULL,
    trc_fecha_ingreso   DATETIME NOT NULL,
    trc_secuencial_trn  INT,
    trc_oficial_destino SMALLINT NOT NULL,
    trc_oficial_origen  SMALLINT NOT NULL,
    trc_saldo_capital   MONEY NOT NULL
    )
GO

CREATE INDEX ca_traslados_cartera_2
    ON dbo.ca_traslados_cartera (trc_cliente, trc_estado)
GO

CREATE UNIQUE INDEX ca_traslados_cartera_1
    ON dbo.ca_traslados_cartera (trc_fecha_proceso, trc_cliente, trc_operacion)
GO

IF OBJECT_ID ('dbo.ca_traslados') IS NOT NULL
    DROP TABLE dbo.ca_traslados
GO

CREATE TABLE dbo.ca_traslados
    (
    top_operacion         INT NOT NULL,
    top_banco             cuenta,
    top_toperacion        catalogo,
    top_moneda            SMALLINT NOT NULL,
    top_oficina           INT NOT NULL,
    top_tramite           INT NOT NULL,
    tcg_garantia_anterior CHAR (1) NOT NULL,
    top_tipo              CHAR (1) NOT NULL,
    top_oficial           INT NOT NULL,
    top_reestructuracion  CHAR (1) NOT NULL,
    tcg_garantia_nueva    CHAR (1) NOT NULL,
    top_causacion         CHAR (1) NOT NULL,
    top_fecha_ult_proceso DATETIME NOT NULL,
    top_estado            TINYINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_traslado_linea') IS NOT NULL
    DROP TABLE dbo.ca_traslado_linea
GO

CREATE TABLE dbo.ca_traslado_linea
    (
    tl_operacion       INT NOT NULL,
    tl_fecha_traslado  DATETIME,
    tl_linea_origen    catalogo,
    tl_linea_destino   catalogo,
    tl_usuario         login,
    tl_comentario      descripcion,
    tl_estado          CHAR (1),
    tl_sec_transaccion INT
    )
GO

IF OBJECT_ID ('dbo.ca_traslado_interes_ts') IS NOT NULL
    DROP TABLE dbo.ca_traslado_interes_ts
GO

CREATE TABLE dbo.ca_traslado_interes_ts
    (
    tis_fecha_real    DATETIME NOT NULL,
    tis_usuario_ts    VARCHAR (30) NOT NULL,
    tis_operacion     INT NOT NULL,
    tis_cuota_orig    SMALLINT NOT NULL,
    tis_cuota_dest    SMALLINT NOT NULL,
    tis_usuario       VARCHAR (30) NOT NULL,
    tis_fecha_ingreso DATETIME NOT NULL,
    tis_terminal      VARCHAR (30) NOT NULL,
    tis_estado        CHAR (1) NOT NULL,
    tis_monto         MONEY NOT NULL
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

CREATE INDEX ca_traslado_interes_1
    ON dbo.ca_traslado_interes (ti_operacion)
GO

IF OBJECT_ID ('dbo.ca_transaccion_prv') IS NOT NULL
    DROP TABLE dbo.ca_transaccion_prv
GO

CREATE TABLE dbo.ca_transaccion_prv
    (
    tp_fecha_mov      SMALLDATETIME NOT NULL,
    tp_operacion      INT NOT NULL,
    tp_fecha_ref      SMALLDATETIME NOT NULL,
    tp_secuencial_ref INT NOT NULL,
    tp_estado         CHAR (3) NOT NULL,
    tp_comprobante    INT,
    tp_fecha_cont     SMALLDATETIME,
    tp_dividendo      SMALLINT NOT NULL,
    tp_concepto       catalogo,
    tp_codvalor       INT NOT NULL,
    tp_monto          MONEY NOT NULL,
    tp_secuencia      TINYINT NOT NULL
    )
GO

CREATE CLUSTERED INDEX idx1
    ON dbo.ca_transaccion_prv (tp_operacion, tp_fecha_mov)
    WITH (FILLFACTOR = 75)
GO

CREATE INDEX idx2
    ON dbo.ca_transaccion_prv (tp_fecha_mov)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX idx5
    ON dbo.ca_transaccion_prv (tp_fecha_mov, tp_comprobante)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_transaccion_imp_tmp') IS NOT NULL
    DROP TABLE dbo.ca_transaccion_imp_tmp
GO

CREATE TABLE dbo.ca_transaccion_imp_tmp
    (
    td_tran     VARCHAR (10),
    td_fpro     VARCHAR (12),
    td_capi     MONEY,
    td_inte     FLOAT,
    td_mora     FLOAT,
    td_otros    MONEY,
    td_total    MONEY,
    td_user     login,
    td_producto catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_transaccion_bancamia_tmp') IS NOT NULL
    DROP TABLE dbo.ca_transaccion_bancamia_tmp
GO

CREATE TABLE dbo.ca_transaccion_bancamia_tmp
    (
    tr_secuencial       INT,
    tr_fecha_mov        DATETIME,
    tr_toperacion       CHAR (10),
    tr_moneda           TINYINT,
    tr_operacion        INT,
    tr_tran             CHAR (10),
    tr_en_linea         CHAR (1),
    tr_banco            CHAR (24),
    tr_dias_calc        INT,
    tr_ofi_oper         VARCHAR (4),
    tr_ofi_usu          VARCHAR (4),
    tr_usuario          CHAR (14),
    tr_terminal         CHAR (30),
    tr_fecha_ref        DATETIME,
    tr_secuencial_ref   INT,
    tr_estado           CHAR (10),
    tr_observacion      CHAR (62),
    tr_gerente          SMALLINT,
    tr_comprobante      INT,
    tr_fecha_cont       DATETIME,
    tr_gar_admisible    CHAR (1),
    tr_reestructuracion CHAR (1),
    tr_calificacion     CHAR (1),
    tr_fecha_real       DATETIME
    )
GO

CREATE INDEX ca_tran_bancamia_tmp_1
    ON dbo.ca_transaccion_bancamia_tmp (tr_banco, tr_secuencial)
GO

IF OBJECT_ID ('dbo.ca_transaccion_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_transaccion_bancamia
GO

CREATE TABLE dbo.ca_transaccion_bancamia
    (
    tr_secuencial       INT NOT NULL,
    tr_fecha_mov        DATETIME NOT NULL,
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
    tr_fecha_ref        DATETIME NOT NULL,
    tr_secuencial_ref   INT NOT NULL,
    tr_estado           CHAR (10) NOT NULL,
    tr_observacion      CHAR (62) NOT NULL,
    tr_gerente          SMALLINT NOT NULL,
    tr_comprobante      INT NOT NULL,
    tr_fecha_cont       DATETIME NOT NULL,
    tr_gar_admisible    CHAR (1) NOT NULL,
    tr_reestructuracion CHAR (1) NOT NULL,
    tr_calificacion     CHAR (1) NOT NULL,
    tr_fecha_real       DATETIME NOT NULL,
    tr_sector           catalogo DEFAULT ('1') NOT NULL,
    tr_clase            catalogo DEFAULT ('4') NOT NULL,
    tr_op_estado        TINYINT DEFAULT ((1)) NOT NULL,
    tr_ente             INT DEFAULT ((0)) NOT NULL
    )
GO

CREATE INDEX ca_tran_bancamia_1
    ON dbo.ca_transaccion_bancamia (tr_banco, tr_secuencial)
GO

CREATE INDEX ca_tran_bancamia_2
    ON dbo.ca_transaccion_bancamia (tr_fecha_mov, tr_estado, tr_tran)
GO

CREATE INDEX ca_tran_bancamia_3
    ON dbo.ca_transaccion_bancamia (tr_fecha_ref, tr_tran)
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
    tr_fecha_real       DATETIME CONSTRAINT DF_ca_transaccion_tr_fecha_real DEFAULT (getdate())
    )
GO

CREATE INDEX ca_transaccion_3
    ON dbo.ca_transaccion (tr_fecha_mov, tr_tran, tr_ofi_usu)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_transaccion_4
    ON dbo.ca_transaccion (tr_fecha_mov, tr_comprobante)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_transaccion_5
    ON dbo.ca_transaccion (tr_tran, tr_estado, tr_fecha_ref, tr_secuencial, tr_fecha_mov, tr_toperacion, tr_banco, tr_secuencial_ref)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_transaccion_idx6
    ON dbo.ca_transaccion (tr_operacion, tr_secuencial, tr_tran, tr_estado)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_transaccion_1
    ON dbo.ca_transaccion (tr_operacion, tr_secuencial)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_transaccion_2
    ON dbo.ca_transaccion (tr_banco)
    WITH (FILLFACTOR = 90)
GO

CREATE NONCLUSTERED INDEX ca_transaccion_idx7
    ON dbo.ca_transaccion (tr_fecha_mov,tr_operacion,tr_tran,tr_estado)
GO

CREATE NONCLUSTERED INDEX ca_transaccion_idx8 
   ON dbo.ca_transaccion (tr_observacion)
go


IF OBJECT_ID ('dbo.ca_tran_no_conta') IS NOT NULL
    DROP TABLE dbo.ca_tran_no_conta
GO

CREATE TABLE dbo.ca_tran_no_conta
    (
    tnc_secuencial NUMERIC (10) IDENTITY NOT NULL,
    tnc_estado     CHAR (10) NOT NULL,
    tnc_fecha_mov  DATETIME NOT NULL,
    tnc_tipo_tran  catalogo NOT NULL,
    tnc_perfil     catalogo NOT NULL,
    tnc_num_tran   INT NOT NULL
    )
GO

CREATE INDEX ca_tran_no_conta_1
    ON dbo.ca_tran_no_conta (tnc_secuencial)
GO

IF OBJECT_ID ('dbo.ca_TP_tmp') IS NOT NULL
    DROP TABLE dbo.ca_TP_tmp
GO

CREATE TABLE dbo.ca_TP_tmp
    (
    tramite              INT,
    banco                cuenta,
    estado_op            TINYINT,
    eje1_NR              CHAR (1),
    eje2_linea           catalogo,
    eje3_MERCADO_subtipo catalogo,
    eje4_MERCADO_OBJ     catalogo,
    eje5_CLASEcca        catalogo,
    eje6_NIVEL_RIESGO    VARCHAR (10),
    eje7_MONTO           MONEY,
    eje8_PLAZO           INT,
    eje9_NOTA            CHAR (10),
    puntos_hoy           FLOAT,
    tasa_EA_hoy          FLOAT,
    spread               FLOAT,
    signo                CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_totales_trn') IS NOT NULL
    DROP TABLE dbo.ca_totales_trn
GO

CREATE TABLE dbo.ca_totales_trn
    (
    tot_total      INT NOT NULL,
    tot_operacion  INT NOT NULL,
    tot_secuencial INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_totales_hc_conso') IS NOT NULL
    DROP TABLE dbo.ca_totales_hc_conso
GO

CREATE TABLE dbo.ca_totales_hc_conso
    (
    com_fecha_proceso DATETIME,
    com_producto      TINYINT,
    com_moneda        TINYINT,
    com_capital_conso MONEY,
    com_interes_conso MONEY,
    com_otros_conso   MONEY,
    com_sus_conso     MONEY,
    com_capital_hc    MONEY,
    com_interes_hc    MONEY,
    com_otros_hc      MONEY,
    com_sus_hc        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_totales_det') IS NOT NULL
    DROP TABLE dbo.ca_totales_det
GO

CREATE TABLE dbo.ca_totales_det
    (
    tod_total         INT NOT NULL,
    tod_concepto      VARCHAR (30) NOT NULL,
    tod_codvalor      INT NOT NULL,
    tod_moneda        SMALLINT NOT NULL,
    tod_sector        catalogo NOT NULL,
    tod_monto         MONEY NOT NULL,
    tod_cuenta        cuenta NOT NULL,
    tod_gar_admisible VARCHAR (1) NOT NULL,
    tod_calificacion  VARCHAR (1) NOT NULL,
    tod_clase_cart    VARCHAR (1) NOT NULL,
    tod_clase_cust    VARCHAR (1) NOT NULL,
    tod_estado        INT,
    tod_categoria     VARCHAR (2),
    tod_ente          INT,
    tod_banco         VARCHAR (24),
    tod_beneficiario  VARCHAR (64)
    )
GO

CREATE INDEX idx1
    ON dbo.ca_totales_det (tod_banco, tod_total)
GO

IF OBJECT_ID ('dbo.ca_totales') IS NOT NULL
    DROP TABLE dbo.ca_totales
GO

CREATE TABLE dbo.ca_totales
    (
    to_banco       cuenta NOT NULL,
    to_total       INT NOT NULL,
    to_fecha_mov   SMALLDATETIME NOT NULL,
    to_fecha_ref   SMALLDATETIME NOT NULL,
    to_ofi_usu     SMALLINT NOT NULL,
    to_ofi_oper    SMALLINT NOT NULL,
    to_tran        catalogo NOT NULL,
    to_moneda      SMALLINT NOT NULL,
    to_toperacion  catalogo NOT NULL,
    to_estado      catalogo NOT NULL,
    to_comprobante INT NOT NULL,
    to_fecha_cont  SMALLDATETIME NOT NULL
    )
GO

CREATE INDEX idx1
    ON dbo.ca_totales (to_banco, to_total)
GO

IF OBJECT_ID ('dbo.ca_total_prioridad_tmp') IS NOT NULL
    DROP TABLE dbo.ca_total_prioridad_tmp
GO

CREATE TABLE dbo.ca_total_prioridad_tmp
    (
    prioridad INT NOT NULL,
    total     MONEY NOT NULL,
    operacion INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tmp_transaccion') IS NOT NULL
    DROP TABLE dbo.ca_tmp_transaccion
GO

CREATE TABLE dbo.ca_tmp_transaccion
    (
    ttr_operacion   INT NOT NULL,
    ttr_secuencial  INT NOT NULL,
    ttr_fecha_mov   DATETIME NOT NULL,
    ttr_comprobante INT NOT NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_tmp_transaccion_1
    ON dbo.ca_tmp_transaccion (ttr_operacion, ttr_secuencial)
GO

IF OBJECT_ID ('dbo.ca_tmp_seguro') IS NOT NULL
    DROP TABLE dbo.ca_tmp_seguro
GO

CREATE TABLE dbo.ca_tmp_seguro
    (
    tramite  INT,
    garantia VARCHAR (64),
    respaldo MONEY,
    sesion   INT
    )
GO

IF OBJECT_ID ('dbo.ca_tmp_datooper') IS NOT NULL
    DROP TABLE dbo.ca_tmp_datooper
GO

CREATE TABLE dbo.ca_tmp_datooper
    (
    dotc_fecha_proceso          DATETIME,
    dotc_fecha_hora             DATETIME,
    dotc_numero_operacion       INT,
    dotc_numero_operacion_banco cuenta,
    dotc_codigo_cliente         INT,
    dotc_oficina                SMALLINT,
    dotc_moneda                 TINYINT,
    dotc_monto                  MONEY,
    dotc_tasa                   FLOAT,
    dotc_dias_vto_div           INT,
    dotc_saldo_cap              MONEY,
    dotc_saldo_int              MONEY,
    dotc_saldo_otros            MONEY,
    dotc_saldo_int_contingente  MONEY,
    dotc_saldo                  MONEY,
    dotc_estado_contable        TINYINT,
    dotc_estado_desembolso      CHAR (1),
    dotc_estado_terminos        CHAR (1),
    dotc_calificacion           catalogo,
    dotc_edad_mora              INT,
    dotc_valor_mora             MONEY,
    dotc_estado_cartera         TINYINT
    )
GO

IF OBJECT_ID ('dbo.ca_tipo_trn') IS NOT NULL
    DROP TABLE dbo.ca_tipo_trn
GO

CREATE TABLE dbo.ca_tipo_trn
    (
    tt_codigo      CHAR (3) NOT NULL,
    tt_descripcion descripcion NOT NULL,
    tt_reversa     CHAR (1) NOT NULL,
    tt_contable    CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_tipo_plazo') IS NOT NULL
    DROP TABLE dbo.ca_tipo_plazo
GO

CREATE TABLE dbo.ca_tipo_plazo
    (
    tp_codigo      catalogo NOT NULL,
    tp_descripcion descripcion NOT NULL,
    tp_rango       SMALLINT NOT NULL,
    tp_estado      estado NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tipo_linea') IS NOT NULL
    DROP TABLE dbo.ca_tipo_linea
GO

CREATE TABLE dbo.ca_tipo_linea
    (
    cl_codigo      catalogo NOT NULL,
    cl_descripcion descripcion NOT NULL,
    cl_estado      CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tipo_doc_mbs') IS NOT NULL
    DROP TABLE dbo.ca_tipo_doc_mbs
GO

CREATE TABLE dbo.ca_tipo_doc_mbs
    (
    td_tipo_mbs    TINYINT NOT NULL,
    td_tipo_cobis  catalogo,
    td_descripcion descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_timbre') IS NOT NULL
    DROP TABLE dbo.ca_timbre
GO

CREATE TABLE dbo.ca_timbre
    (
    ti_banco        cuenta NOT NULL,
    ti_descripcion1 VARCHAR (80),
    ti_descripcion2 VARCHAR (80),
    ti_descripcion3 VARCHAR (80)
    )
GO

CREATE UNIQUE INDEX ca_timbre_1
    ON dbo.ca_timbre (ti_banco)
GO

IF OBJECT_ID ('dbo.ca_temp_porcentaje') IS NOT NULL
    DROP TABLE dbo.ca_temp_porcentaje
GO

CREATE TABLE dbo.ca_temp_porcentaje
    (
    porcentaje FLOAT NOT NULL,
    operacion  INT NOT NULL
    )
GO

CREATE INDEX ca_temp_porcentaje_Key1
    ON dbo.ca_temp_porcentaje (operacion, porcentaje)
GO

IF OBJECT_ID ('dbo.ca_temp_div_total') IS NOT NULL
    DROP TABLE dbo.ca_temp_div_total
GO

CREATE TABLE dbo.ca_temp_div_total
    (
    count_div_1 FLOAT NOT NULL,
    operacion_1 INT NOT NULL
    )
GO

CREATE INDEX temp_div_total_Key1
    ON dbo.ca_temp_div_total (operacion_1)
GO

IF OBJECT_ID ('dbo.ca_temp_div_parcial') IS NOT NULL
    DROP TABLE dbo.ca_temp_div_parcial
GO

CREATE TABLE dbo.ca_temp_div_parcial
    (
    count_div_2 FLOAT NOT NULL,
    operacion_2 INT NOT NULL
    )
GO

CREATE INDEX temp_div_parcial_Key1
    ON dbo.ca_temp_div_parcial (operacion_2)
GO

IF OBJECT_ID ('dbo.ca_temp_conv_baloto') IS NOT NULL
    DROP TABLE dbo.ca_temp_conv_baloto
GO

CREATE TABLE dbo.ca_temp_conv_baloto
    (
    rep_banco     cuenta NOT NULL,
    rep_cliente   INT NOT NULL,
    rep_sector    catalogo NOT NULL,
    rep_opera     INT NOT NULL,
    rep_cedula    VARCHAR (30) NOT NULL,
    rep_nom       descripcion NOT NULL,
    rep_ofi       INT NOT NULL,
    rep_cuota     INT NOT NULL,
    rep_valor_rec MONEY NOT NULL,
    rep_valor_iva MONEY NOT NULL,
    fech_ini      DATETIME NOT NULL,
    fech_venc     DATETIME NOT NULL,
    rep_valor     MONEY NOT NULL,
    rep_conv      INT NOT NULL,
    sec_reg       INT IDENTITY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tdividendo_virtual') IS NOT NULL
    DROP TABLE dbo.ca_tdividendo_virtual
GO

CREATE TABLE dbo.ca_tdividendo_virtual
    (
    td_tdividendo  catalogo NOT NULL,
    td_descripcion descripcion NOT NULL,
    td_estado      estado,
    td_factor      SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tdividendo') IS NOT NULL
    DROP TABLE dbo.ca_tdividendo
GO

CREATE TABLE dbo.ca_tdividendo
    (
    td_tdividendo  catalogo NOT NULL,
    td_descripcion descripcion NOT NULL,
    td_estado      estado,
    td_factor      SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tasas_pit') IS NOT NULL
    DROP TABLE dbo.ca_tasas_pit
GO

CREATE TABLE dbo.ca_tasas_pit
    (
    tp_operacion      INT NOT NULL,
    tp_fecha          DATETIME NOT NULL,
    tp_tasa_aplicar   catalogo,
    tp_signo          CHAR (1) NOT NULL,
    tp_spread         FLOAT NOT NULL,
    tp_porcentaje     FLOAT NOT NULL,
    tp_porcentaje_efa FLOAT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_tasas_pit_1
    ON dbo.ca_tasas_pit (tp_operacion)
GO

IF OBJECT_ID ('dbo.ca_tasas') IS NOT NULL
    DROP TABLE dbo.ca_tasas
GO

CREATE TABLE dbo.ca_tasas
    (
    ts_operacion         INT NOT NULL,
    ts_dividendo         INT NOT NULL,
    ts_fecha             DATETIME NOT NULL,
    ts_concepto          catalogo NOT NULL,
    ts_porcentaje        FLOAT NOT NULL,
    ts_secuencial        INT NOT NULL,
    ts_porcentaje_efa    FLOAT,
    ts_referencial       catalogo,
    ts_signo             CHAR (1),
    ts_factor            FLOAT,
    ts_valor_referencial FLOAT,
    ts_fecha_referencial DATETIME,
    ts_tasa_ref          catalogo
    )
GO

CREATE CLUSTERED INDEX ca_tasas_I1
    ON dbo.ca_tasas (ts_operacion, ts_dividendo, ts_concepto, ts_fecha)
    WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.ca_tasa_valor_virtual') IS NOT NULL
    DROP TABLE dbo.ca_tasa_valor_virtual
GO

CREATE TABLE dbo.ca_tasa_valor_virtual
    (
    tv_nombre_tasa  catalogo NOT NULL,
    tv_descripcion  descripcion NOT NULL,
    tv_modalidad    CHAR (1) NOT NULL,
    tv_periodicidad CHAR (1) NOT NULL,
    tv_estado       CHAR (1) NOT NULL,
    tv_tipo_tasa    CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_tablas_un_rango') IS NOT NULL
    DROP TABLE dbo.ca_tablas_un_rango
GO

CREATE TABLE dbo.ca_tablas_un_rango
    (
    tur_secuencial INT NOT NULL,
    tur_concepto   catalogo NOT NULL,
    tur_valor_min  MONEY NOT NULL,
    tur_valor_max  MONEY,
    tur_tasa       FLOAT NOT NULL,
    tur_tipo       CHAR (1),
    tur_valor      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_tablas_dos_rangos') IS NOT NULL
    DROP TABLE dbo.ca_tablas_dos_rangos
GO

CREATE TABLE dbo.ca_tablas_dos_rangos
    (
    tdr_secuencial  INT NOT NULL,
    tdr_concepto    catalogo NOT NULL,
    tdr_valor1_min  MONEY NOT NULL,
    tdr_valor1_max  MONEY,
    tdr_valor2_min  MONEY NOT NULL,
    tdr_valor2_max  MONEY,
    tdr_tasa        FLOAT NOT NULL,
    tdr_variable    catalogo,
    tdr_fecha_carga DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_tabla_reporte') IS NOT NULL
    DROP TABLE dbo.ca_tabla_reporte
GO

CREATE TABLE dbo.ca_tabla_reporte
    (
    tr_numero_obligacion          cuenta NOT NULL,
    tr_fecha_proceso              DATETIME NOT NULL,
    tr_tipo_producto              catalogo,
    tr_oficina_obligacion         SMALLINT,
    tr_oficial                    SMALLINT,
    tr_nombre                     descripcion,
    tr_frecuencia_int             SMALLINT,
    tr_modalidad_int              CHAR (10),
    tr_frecuencia_cap             SMALLINT,
    tr_valor_ini_obligacion       MONEY,
    tr_fecha_ini_obligacion       DATETIME,
    tr_calficacion_obligacion     CHAR (1),
    tr_clase_cartera              catalogo,
    tr_reestructuracion           CHAR (1),
    tr_estado_obligacion          descripcion,
    tr_numero_comex               cuenta,
    tr_numero_deuda_ext           VARCHAR (15),
    tr_fecha_embarque             DATETIME,
    tr_fecha_dex                  DATETIME,
    tr_tipo_tasa                  CHAR (1),
    tr_tasa                       FLOAT,
    tr_tasa_referencial           FLOAT,
    tr_spread                     FLOAT,
    tr_signo                      CHAR (1),
    tr_tipo_identificacion        CHAR (2),
    tr_identificacion             numero,
    tr_saldo_cap                  MONEY,
    tr_saldo_int                  MONEY,
    tr_saldo_mora                 MONEY,
    tr_saldo_otros                MONEY,
    tr_valor_causado              MONEY,
    tr_fecha_ult_pago             DATETIME,
    tr_valor_proximo_cuota_a_venc MONEY,
    tr_fecha_proximo_venc         DATETIME,
    tr_dias_vencimiento           SMALLINT,
    tr_provision_cap              MONEY,
    tr_provision_int              MONEY,
    tr_provision_cxc              MONEY,
    tr_valor_total_gar            MONEY,
    tr_interes_contingente        MONEY,
    tr_clase_garantia             VARCHAR (15),
    tr_valor_seguro_vida          MONEY,
    tr_cuenta_asociada            cuenta,
    tr_numero_migracion           cuenta,
    tr_monto_desembolso           MONEY,
    tr_fecha_fin                  DATETIME,
    tr_plazo_total                INT,
    tr_tipo_tabla                 catalogo,
    tr_periodo_gracia_cap         INT,
    tr_periodo_gracia_int         INT,
    tr_cartera_vencida            INT,
    tr_moneda                     TINYINT,
    tr_tasa_efa                   FLOAT,
    tr_valor_ult_pago             MONEY,
    tr_cod_cliente                INT,
    tr_ncuotas_ven                INT,
    tr_ncuotas_pag                INT,
    tr_ncuotas_pac                INT,
    tr_destino                    catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_tabla_flexible_control_ts') IS NOT NULL
    DROP TABLE dbo.ca_tabla_flexible_control_ts
GO

CREATE TABLE dbo.ca_tabla_flexible_control_ts
    (
    tfc_crud               CHAR (1),
    tfc_date               DATETIME,
    tfc_term               VARCHAR (30),
    tfc_ofi                SMALLINT,
    tfc_operacion          INT,
    tfc_version_flujo      SMALLINT,
    tfc_timestamp          DATETIME,
    tfc_user               login,
    tfc_solicitud_tflex    CHAR (1),
    tfc_solicitud_aplicada CHAR (1),
    tfc_fecha_aplicacion   DATETIME
    )
GO

CREATE INDEX ca_tabla_flexible_control_ts_1
    ON dbo.ca_tabla_flexible_control_ts (tfc_operacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_tabla_flexible_control') IS NOT NULL
    DROP TABLE dbo.ca_tabla_flexible_control
GO

CREATE TABLE dbo.ca_tabla_flexible_control
    (
    tfc_operacion          INT,
    tfc_version_flujo      SMALLINT,
    tfc_timestamp          DATETIME,
    tfc_user               login,
    tfc_solicitud_tflex    CHAR (1),
    tfc_solicitud_aplicada CHAR (1),
    tfc_fecha_aplicacion   DATETIME
    )
GO

CREATE UNIQUE INDEX ca_tabla_flexible_control_1
    ON dbo.ca_tabla_flexible_control (tfc_operacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_subtipo_linea') IS NOT NULL
    DROP TABLE dbo.ca_subtipo_linea
GO

CREATE TABLE dbo.ca_subtipo_linea
    (
    si_codigo      catalogo NOT NULL,
    si_descripcion descripcion NOT NULL,
    si_tipo_linea  catalogo NOT NULL,
    si_estado      CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_sobrecausacion_mex') IS NOT NULL
    DROP TABLE dbo.ca_sobrecausacion_mex
GO

CREATE TABLE dbo.ca_sobrecausacion_mex
    (
    scme_operacion      INT NOT NULL,
    scme_secuencial_prv INT NOT NULL,
    scme_dividendo      INT NOT NULL,
    scme_valor_prv      MONEY,
    scme_estado         catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_sin_detalle_rej') IS NOT NULL
    DROP TABLE dbo.ca_sin_detalle_rej
GO

CREATE TABLE dbo.ca_sin_detalle_rej
    (
    operacion INT,
    sec_rej   INT,
    fecha_reg DATETIME
    )
GO

CREATE INDEX ca_sin_detalle_rej_1
    ON dbo.ca_sin_detalle_rej (operacion)
GO

IF OBJECT_ID ('dbo.ca_sin_abono') IS NOT NULL
    DROP TABLE dbo.ca_sin_abono
GO

CREATE TABLE dbo.ca_sin_abono
    (
    oper INT,
    sec  INT
    )
GO

IF OBJECT_ID ('dbo.ca_simula_comp_err') IS NOT NULL
    DROP TABLE dbo.ca_simula_comp_err
GO

CREATE TABLE dbo.ca_simula_comp_err
    (
    sce_terminal    VARCHAR (64) NOT NULL,
    sce_oficina     SMALLINT NOT NULL,
    sce_contador    INT NOT NULL,
    sce_error       INT NOT NULL,
    sce_descripcion VARCHAR (255),
    sce_anexo       VARCHAR (255)
    )
GO

CREATE INDEX ca_simula_comp_err_1
    ON dbo.ca_simula_comp_err (sce_terminal, sce_oficina)
GO

IF OBJECT_ID ('dbo.ca_simula_comp') IS NOT NULL
    DROP TABLE dbo.ca_simula_comp
GO

CREATE TABLE dbo.ca_simula_comp
    (
    sc_terminal     VARCHAR (64) NOT NULL,
    sc_oficina      SMALLINT NOT NULL,
    sc_asiento      INT NOT NULL,
    sc_cuenta       VARCHAR (24) NOT NULL,
    sc_oficina_dest SMALLINT NOT NULL,
    sc_area_dest    INT NOT NULL,
    sc_credito      MONEY NOT NULL,
    sc_debito       MONEY NOT NULL,
    sc_concepto     VARCHAR (10) NOT NULL
    )
GO

CREATE INDEX ca_simula_comp_1
    ON dbo.ca_simula_comp (sc_terminal, sc_oficina)
GO

IF OBJECT_ID ('dbo.ca_sihc_noconso') IS NOT NULL
    DROP TABLE dbo.ca_sihc_noconso
GO

CREATE TABLE dbo.ca_sihc_noconso
    (
    sn_fecha_proceso DATETIME,
    sn_producto      TINYINT,
    sn_moneda        TINYINT,
    sn_banco         cuenta,
    sn_saldo_cap     MONEY,
    sn_saldo_int     MONEY,
    sn_saldo_otros   MONEY,
    sn_suspenso      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_siconso_nohc') IS NOT NULL
    DROP TABLE dbo.ca_siconso_nohc
GO

CREATE TABLE dbo.ca_siconso_nohc
    (
    sc_fecha_proceso DATETIME,
    sc_producto      TINYINT,
    sc_moneda        TINYINT,
    sc_banco         cuenta,
    sc_saldo_cap     MONEY,
    sc_saldo_int     MONEY,
    sc_saldo_otros   MONEY,
    sc_suspenso      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_serlefin') IS NOT NULL
    DROP TABLE dbo.ca_serlefin
GO

CREATE TABLE dbo.ca_serlefin
    (
    os_regional         SMALLINT,
    os_nom_regional     VARCHAR (64),
    os_zona             SMALLINT,
    os_nom_zona         VARCHAR (64),
    os_oficina          SMALLINT NOT NULL,
    os_nom_oficina      VARCHAR (64),
    os_identificacion   numero,
    os_nombre           VARCHAR (64) NOT NULL,
    os_cliente          INT NOT NULL,
    os_banco            cuenta,
    os_saldo_capital    MONEY,
    os_dias_vencidos    INT,
    os_saldo_vencido    MONEY,
    os_reestructurado   CHAR (1) NOT NULL,
    os_modalidad_cobro  VARCHAR (2),
    os_prox_vencimiento VARCHAR (10),
    os_nom_direccion    VARCHAR (254),
    os_ciudad           VARCHAR (64),
    os_telefono         VARCHAR (16),
    os_departamento     VARCHAR (64),
    os_tipo_deudor      catalogo,
    os_toperacion       catalogo,
    os_valor_cuota      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
    DROP TABLE dbo.ca_seguros_his
GO

CREATE TABLE dbo.ca_seguros_his
    (
    seh_secuencial     INT,
    seh_sec_seguro     INT,
    seh_tipo_seguro    INT,
    seh_sec_renovacion INT,
    seh_tramite        INT,
    seh_operacion      INT,
    seh_fec_devolucion DATETIME,
    seh_mto_devolucion MONEY,
    seh_estado         CHAR (1)
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros_his (seh_operacion, seh_secuencial)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
    DROP TABLE dbo.ca_seguros_det_his
GO

CREATE TABLE dbo.ca_seguros_det_his
    (
    sedh_secuencial     INT,
    sedh_operacion      INT,
    sedh_sec_seguro     INT,
    sedh_tipo_seguro    INT,
    sedh_sec_renovacion INT,
    sedh_tipo_asegurado INT,
    sedh_estado         INT,
    sedh_dividendo      INT,
    sedh_cuota_cap      MONEY,
    sedh_pago_cap       MONEY,
    sedh_cuota_int      MONEY,
    sedh_pago_int       MONEY,
    sedh_cuota_mora     MONEY,
    sedh_pago_mora      MONEY,
    sedh_sec_asegurado  INT
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros_det_his (sedh_operacion, sedh_secuencial)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_seguros_det') IS NOT NULL
    DROP TABLE dbo.ca_seguros_det
GO

CREATE TABLE dbo.ca_seguros_det
    (
    sed_operacion      INT,
    sed_sec_seguro     INT,
    sed_tipo_seguro    INT,
    sed_sec_renovacion INT,
    sed_tipo_asegurado INT,
    sed_estado         INT,
    sed_dividendo      INT,
    sed_cuota_cap      MONEY,
    sed_pago_cap       MONEY,
    sed_cuota_int      MONEY,
    sed_pago_int       MONEY,
    sed_cuota_mora     MONEY,
    sed_pago_mora      MONEY,
    sed_sec_asegurado  INT
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros_det (sed_sec_seguro, sed_tipo_seguro, sed_tipo_asegurado, sed_sec_asegurado, sed_sec_renovacion)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX ca_seguros_det_idx2
    ON dbo.ca_seguros_det (sed_operacion, sed_sec_seguro, sed_tipo_seguro, sed_sec_renovacion, sed_tipo_asegurado, sed_estado, sed_dividendo, sed_cuota_cap, sed_pago_cap, sed_cuota_int, sed_pago_int, sed_cuota_mora, sed_pago_mora)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX ca_seguros_det_idx3
    ON dbo.ca_seguros_det (sed_pago_cap, sed_cuota_cap, sed_operacion, sed_dividendo)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
    DROP TABLE dbo.ca_seguros_can_his
GO

CREATE TABLE dbo.ca_seguros_can_his
    (
    sech_secuencial     INT,
    sech_sec_seguro     INT,
    sech_tipo_seguro    INT,
    sech_sec_renovacion INT,
    sech_tramite        INT,
    sech_operacion      INT,
    sech_fec_can        DATETIME,
    sech_sec_pag        INT
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros_can_his (sech_operacion, sech_secuencial)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_seguros_can') IS NOT NULL
    DROP TABLE dbo.ca_seguros_can
GO

CREATE TABLE dbo.ca_seguros_can
    (
    sec_sec_seguro     INT,
    sec_tipo_seguro    INT,
    sec_sec_renovacion INT,
    sec_tramite        INT,
    sec_operacion      INT,
    sec_fec_can        DATETIME,
    sec_sec_pag        INT
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros_can (sec_sec_seguro, sec_tipo_seguro, sec_tramite, sec_sec_renovacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_seguros_base_garantia') IS NOT NULL
    DROP TABLE dbo.ca_seguros_base_garantia
GO

CREATE TABLE dbo.ca_seguros_base_garantia
    (
    sg_tramite       INT NOT NULL,
    sg_fecha_reg     DATETIME NOT NULL,
    sg_tipo_garantia catalogo NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_seguros_base_garantia_1
    ON dbo.ca_seguros_base_garantia (sg_tramite, sg_fecha_reg, sg_tipo_garantia)
GO

IF OBJECT_ID ('dbo.ca_seguros') IS NOT NULL
    DROP TABLE dbo.ca_seguros
GO

CREATE TABLE dbo.ca_seguros
    (
    se_sec_seguro     INT,
    se_tipo_seguro    INT,
    se_sec_renovacion INT,
    se_tramite        INT,
    se_operacion      INT,
    se_fec_devolucion DATETIME,
    se_mto_devolucion MONEY,
    se_estado         CHAR (1)
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_seguros (se_sec_seguro, se_tipo_seguro, se_tramite, se_sec_renovacion)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx_2
    ON dbo.ca_seguros (se_operacion)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_seg_total_b') IS NOT NULL
    DROP TABLE dbo.ca_seg_total_b
GO

CREATE TABLE dbo.ca_seg_total_b
    (
    dtr_concepto_tb catalogo,
    total_tb        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_seg_total_a') IS NOT NULL
    DROP TABLE dbo.ca_seg_total_a
GO

CREATE TABLE dbo.ca_seg_total_a
    (
    dtr_concepto_ta catalogo,
    total_ta        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_seg_reporte_b') IS NOT NULL
    DROP TABLE dbo.ca_seg_reporte_b
GO

CREATE TABLE dbo.ca_seg_reporte_b
    (
    tr_ofi_oper_b  SMALLINT,
    dtr_concepto_b catalogo,
    valor_b        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_seg_reporte_a') IS NOT NULL
    DROP TABLE dbo.ca_seg_reporte_a
GO

CREATE TABLE dbo.ca_seg_reporte_a
    (
    tr_ofi_oper_a  SMALLINT,
    dtr_concepto_a catalogo,
    valor_a        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_secuenciales') IS NOT NULL
    DROP TABLE dbo.ca_secuenciales
GO

CREATE TABLE dbo.ca_secuenciales
    (
    se_operacion  INT NOT NULL,
    se_secuencial INT NOT NULL
    )
GO

CREATE INDEX ca_secuenciales_1
    ON dbo.ca_secuenciales (se_operacion)
GO

IF OBJECT_ID ('dbo.ca_secuencial_atx') IS NOT NULL
    DROP TABLE dbo.ca_secuencial_atx
GO

CREATE TABLE dbo.ca_secuencial_atx
    (
    sa_operacion      cuenta,
    sa_ssn_corr       INT NOT NULL,
    sa_producto       catalogo,
    sa_secuencial_cca INT NOT NULL,
    sa_secuencial_ssn INT,
    sa_oficina        SMALLINT,
    sa_fecha_ing      DATETIME,
    sa_fecha_real     DATETIME,
    sa_estado         CHAR (1),
    sa_ejecutar       CHAR (1),
    sa_valor_efe      MONEY,
    sa_valor_cheq     MONEY,
    sa_error          INT
    )
GO

CREATE UNIQUE INDEX ca_secuencial_atx_1
    ON dbo.ca_secuencial_atx (sa_operacion, sa_secuencial_cca)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_secasunto') IS NOT NULL
    DROP TABLE dbo.ca_secasunto
GO

CREATE TABLE dbo.ca_secasunto
    (
    se_secuencial     INT NOT NULL,
    se_operacion      INT NOT NULL,
    se_banco          cuenta NOT NULL,
    se_fecha_reajuste DATETIME NOT NULL,
    se_estado         CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_saldosfag') IS NOT NULL
    DROP TABLE dbo.ca_saldosfag
GO

CREATE TABLE dbo.ca_saldosfag
    (
    ref_arch           VARCHAR (16),
    nit_intermediario  VARCHAR (10) NOT NULL,
    num_certificado    VARCHAR (18),
    num_identificacion BIGINT,
    llave_credito      VARCHAR (18),
    cod_moneda         VARCHAR (3),
    calificacion       VARCHAR (10),
    reservado          VARCHAR (11),
    capital            INT,
    intereses          INT NOT NULL,
    fecha_corte        VARCHAR (10),
    cuotas_mora        SMALLINT,
    fecha_ing_mora     VARCHAR (8) NOT NULL,
    fecha_can_prestamo VARCHAR (8),
    dias_mora          INT
    )
GO

IF OBJECT_ID ('dbo.ca_saldos_x_toperacion') IS NOT NULL
    DROP TABLE dbo.ca_saldos_x_toperacion
GO

CREATE TABLE dbo.ca_saldos_x_toperacion
    (
    car_nombre         descripcion,
    car_ced_ruc        numero,
    car_banco          cuenta,
    car_toperacion     catalogo,
    car_porcentaje_efa FLOAT NOT NULL,
    car_porcentaje_nom FLOAT NOT NULL,
    car_factor         FLOAT NOT NULL,
    car_referencial    catalogo,
    car_saldo_prv      MONEY NOT NULL,
    car_saldo_tot      MONEY NOT NULL,
    car_sus_front_end  CHAR (1) NOT NULL,
    car_sus_back_end   CHAR (1) NOT NULL,
    car_fecvha_ini     DATETIME NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_saldos_rubros_tmp') IS NOT NULL
    DROP TABLE dbo.ca_saldos_rubros_tmp
GO

CREATE TABLE dbo.ca_saldos_rubros_tmp
    (
    tmp_op_tramite   INT NOT NULL,
    tmp_di_estado    SMALLINT NOT NULL,
    tmp_di_es_estado CHAR (10) NOT NULL,
    tmp_am_concepto  catalogo NOT NULL,
    tmp_am_estado    SMALLINT NOT NULL,
    tmp_am_es_estado CHAR (10) NOT NULL,
    tmp_saldo        MONEY NOT NULL,
    tmp_user         login NOT NULL
    )
GO

CREATE INDEX idx1
    ON dbo.ca_saldos_rubros_tmp (tmp_op_tramite, tmp_user)
GO

IF OBJECT_ID ('dbo.ca_saldos_op_renovar_tmp') IS NOT NULL
    DROP TABLE dbo.ca_saldos_op_renovar_tmp
GO

CREATE TABLE dbo.ca_saldos_op_renovar_tmp
    (
    tmpr_user           login NOT NULL,
    tmpr_tramite_re     INT NOT NULL,
    tmpr_banco          cuenta NOT NULL,
    tmpr_linea          catalogo NOT NULL,
    tmpr_monto_des      MONEY NOT NULL,
    tmpr_saldo_hoy      MONEY NOT NULL,
    tmpr_fecha_liq      DATETIME NOT NULL,
    tmpr_moneda         SMALLINT NOT NULL,
    tmpr_producto       catalogo NOT NULL,
    tmpr_tipo_seleccion CHAR (1) NOT NULL,
    tmpr_saldo_renovar  MONEY NOT NULL
    )
GO

CREATE CLUSTERED INDEX idx
    ON dbo.ca_saldos_op_renovar_tmp (tmpr_user, tmpr_tramite_re)
GO

IF OBJECT_ID ('dbo.ca_saldos_mbs_tmp') IS NOT NULL
    DROP TABLE dbo.ca_saldos_mbs_tmp
GO

CREATE TABLE dbo.ca_saldos_mbs_tmp
    (
    sm_tipo      TINYINT NOT NULL,
    sm_num_doc   cuenta,
    sm_digito    CHAR (1) NOT NULL,
    sm_oficina   SMALLINT NOT NULL,
    sm_banco     cuenta,
    sm_monto     MONEY NOT NULL,
    sm_fecha_ven VARCHAR (10) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_saldos_fin_anio') IS NOT NULL
    DROP TABLE dbo.ca_saldos_fin_anio
GO

CREATE TABLE dbo.ca_saldos_fin_anio
    (
    sfa_fecha_proceso DATETIME NOT NULL,
    sfa_operacion     cuenta NOT NULL,
    sfa_saldo_capital MONEY,
    sfa_saldo_int     MONEY,
    sfa_saldo_imo     MONEY,
    sfa_saldo_seguros MONEY,
    sfa_saldo_otros   MONEY
    )
GO

CREATE INDEX ca_saldos_fin_anio_1
    ON dbo.ca_saldos_fin_anio (sfa_fecha_proceso, sfa_operacion)
GO

IF OBJECT_ID ('dbo.ca_saldos_contables_tmp') IS NOT NULL
    DROP TABLE dbo.ca_saldos_contables_tmp
GO

CREATE TABLE dbo.ca_saldos_contables_tmp
    (
    sc_fecha_proceso DATETIME,
    sc_operacion     INT,
    sc_banco         cuenta,
    sc_toperacion    catalogo,
    sc_moneda        SMALLINT,
    sc_cliente       INT,
    sc_oficina       INT,
    sc_sector        CHAR (1),
    sc_gerente       INT,
    sc_nombre        descripcion,
    sc_concepto      catalogo,
    sc_estado        TINYINT,
    sc_periodo       TINYINT,
    sc_cuenta        cuenta,
    sc_afectacion    TINYINT,
    sc_monto         MONEY,
    sc_debito        MONEY,
    sc_credito       MONEY,
    sc_area          SMALLINT
    )
GO

CREATE INDEX ca_saldos_contables_tmp_1
    ON dbo.ca_saldos_contables_tmp (sc_fecha_proceso, sc_oficina, sc_operacion)
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

CREATE UNIQUE INDEX ca_saldos_cartera_mensual_1
    ON dbo.ca_saldos_cartera_mensual (sc_operacion, sc_codvalor, sc_fecha)
GO

CREATE INDEX ca_saldos_cartera_mensual_2
    ON dbo.ca_saldos_cartera_mensual (sc_fecha, sc_operacion)
GO

IF OBJECT_ID ('dbo.ca_saldos_cartera') IS NOT NULL
    DROP TABLE dbo.ca_saldos_cartera
GO

CREATE TABLE dbo.ca_saldos_cartera
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

CREATE UNIQUE INDEX ca_saldos_cartera_key
    ON dbo.ca_saldos_cartera (sc_operacion, sc_codvalor)
GO

IF OBJECT_ID ('dbo.ca_saldo_operacion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_saldo_operacion_tmp
GO

CREATE TABLE dbo.ca_saldo_operacion_tmp
    (
    sot_operacion        INT NOT NULL,
    sot_estado_dividendo TINYINT NOT NULL,
    sot_concepto         catalogo,
    sot_estado_concepto  TINYINT NOT NULL,
    sot_saldo_acumulado  MONEY NOT NULL,
    sot_saldo_mn         MONEY NOT NULL
    )
GO

CREATE INDEX ca_saldo_operacion_tmp_1
    ON dbo.ca_saldo_operacion_tmp (sot_operacion)
GO

IF OBJECT_ID ('dbo.ca_rubros_recalculo') IS NOT NULL
    DROP TABLE dbo.ca_rubros_recalculo
GO

CREATE TABLE dbo.ca_rubros_recalculo
    (
    re_concepto         catalogo,
    re_nuevo_porcentaje FLOAT,
    re_concepto_IOC     catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_rubros_correccion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_rubros_correccion_tmp
GO

CREATE TABLE dbo.ca_rubros_correccion_tmp
    (
    spid            INT NOT NULL,
    dividendo       SMALLINT NOT NULL,
    concepto        catalogo,
    monto_hoy       MONEY NOT NULL,
    monto_siguiente MONEY NOT NULL,
    estado          TINYINT NOT NULL,
    secuencia       TINYINT NOT NULL,
    periodo         TINYINT NOT NULL,
    tipo_rubro      CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rubro_ts') IS NOT NULL
    DROP TABLE dbo.ca_rubro_ts
GO

CREATE TABLE dbo.ca_rubro_ts
    (
    rus_fecha_proceso_ts     DATETIME NOT NULL,
    rus_fecha_ts             DATETIME NOT NULL,
    rus_usuario_ts           login NOT NULL,
    rus_oficina_ts           SMALLINT NOT NULL,
    rus_terminal_ts          VARCHAR (30) NOT NULL,
    rus_toperacion           catalogo NOT NULL,
    rus_moneda               TINYINT NOT NULL,
    rus_concepto             catalogo NOT NULL,
    rus_prioridad            TINYINT NOT NULL,
    rus_tipo_rubro           catalogo NOT NULL,
    rus_paga_mora            CHAR (1) NOT NULL,
    rus_provisiona           CHAR (1) NOT NULL,
    rus_fpago                CHAR (1) NOT NULL,
    rus_crear_siempre        CHAR (1) NOT NULL,
    rus_tperiodo             catalogo,
    rus_periodo              SMALLINT,
    rus_referencial          catalogo,
    rus_reajuste             catalogo,
    rus_banco                CHAR (1) NOT NULL,
    rus_estado               catalogo NOT NULL,
    rus_concepto_asociado    catalogo,
    rus_redescuento          FLOAT,
    rus_intermediacion       FLOAT,
    rus_principal            CHAR (1),
    rus_saldo_op             CHAR (1),
    rus_saldo_por_desem      CHAR (1),
    rus_pit                  catalogo,
    rus_limite               CHAR (1),
    rus_mora_interes         CHAR (1),
    rus_iva_siempre          CHAR (1),
    rus_monto_aprobado       CHAR (1),
    rus_porcentaje_cobrar    FLOAT,
    rus_tipo_garantia        VARCHAR (64),
    rus_valor_garantia       CHAR (1),
    rus_porcentaje_cobertura CHAR (1),
    rus_tabla                VARCHAR (30),
    rus_saldo_insoluto       CHAR (1),
    rus_calcular_devolucion  CHAR (1),
    rus_tasa_aplicar         CHAR (1),
    rus_valor_max            money,
    rus_valor_min            money,
    rus_afectacion           smallint,
    rus_diferir              char(1),
    rus_tipo_seguro          catalogo,
    rus_tasa_efectiva        char(1)
    )
GO

CREATE INDEX ca_rubro_ts_1
    ON dbo.ca_rubro_ts (rus_fecha_proceso_ts)
GO

CREATE INDEX ca_rubro_ts_2
    ON dbo.ca_rubro_ts (rus_fecha_ts)
GO

CREATE INDEX ca_rubro_ts_3
    ON dbo.ca_rubro_ts (rus_usuario_ts)
GO

CREATE INDEX ca_rubro_ts_4
    ON dbo.ca_rubro_ts (rus_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_rubro_planificador_ts') IS NOT NULL
    DROP TABLE dbo.ca_rubro_planificador_ts
GO

CREATE TABLE dbo.ca_rubro_planificador_ts
    (
    rps_secuencial INT NOT NULL,
    rps_rubro      catalogo NOT NULL,
    rps_porcentaje FLOAT NOT NULL,
    rps_cto_sidac  catalogo NOT NULL,
    rps_usuario    login NOT NULL,
    rps_terminal   VARCHAR (30) NOT NULL,
    rps_fecha      VARCHAR (30) NOT NULL,
    rps_accion     CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rubro_planificador') IS NOT NULL
    DROP TABLE dbo.ca_rubro_planificador
GO

CREATE TABLE dbo.ca_rubro_planificador
    (
    rp_secuencial INT NOT NULL,
    rp_rubro      catalogo NOT NULL,
    rp_porcentaje FLOAT NOT NULL,
    rp_cto_sidac  catalogo NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rubro_op_virtual') IS NOT NULL
    DROP TABLE dbo.ca_rubro_op_virtual
GO

CREATE TABLE dbo.ca_rubro_op_virtual
    (
    ro_operacion   INT NOT NULL,
    ro_concepto    catalogo NOT NULL,
    ro_tipo_rubro  CHAR (1) NOT NULL,
    ro_fpago       CHAR (1) NOT NULL,
    ro_prioridad   TINYINT NOT NULL,
    ro_referencial catalogo,
    ro_valor       MONEY NOT NULL,
    ro_porcentaje  FLOAT NOT NULL,
    ro_num_dec     TINYINT,
    ro_limite      CHAR (1)
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_rubro_op_1
    ON dbo.ca_rubro_op_virtual (ro_operacion, ro_concepto)
GO

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

IF OBJECT_ID ('dbo.ca_rubro_op_tmp') IS NOT NULL
    DROP TABLE dbo.ca_rubro_op_tmp
GO

CREATE TABLE dbo.ca_rubro_op_tmp
    (
    rot_operacion            INT NOT NULL,
    rot_concepto             catalogo NOT NULL,
    rot_tipo_rubro           CHAR (1) NOT NULL,
    rot_fpago                CHAR (1) NOT NULL,
    rot_prioridad            TINYINT NOT NULL,
    rot_paga_mora            CHAR (1) NOT NULL,
    rot_provisiona           CHAR (1) NOT NULL,
    rot_signo                CHAR (1),
    rot_factor               FLOAT,
    rot_referencial          catalogo,
    rot_signo_reajuste       CHAR (1),
    rot_factor_reajuste      FLOAT,
    rot_referencial_reajuste catalogo,
    rot_valor                MONEY NOT NULL,
    rot_porcentaje           FLOAT NOT NULL,
    rot_porcentaje_aux       FLOAT NOT NULL,
    rot_gracia               MONEY,
    rot_concepto_asociado    catalogo,
    rot_redescuento          FLOAT,
    rot_intermediacion       FLOAT,
    rot_principal            CHAR (1) NOT NULL,
    rot_porcentaje_efa       FLOAT,
    rot_garantia             MONEY NOT NULL,
    rot_tipo_puntos          CHAR (1),
    rot_saldo_op             CHAR (1),
    rot_saldo_por_desem      CHAR (1),
    rot_base_calculo         MONEY,
    rot_num_dec              TINYINT,
    rot_limite               CHAR (1),
    rot_iva_siempre          CHAR (1),
    rot_monto_aprobado       CHAR (1),
    rot_porcentaje_cobrar    FLOAT,
    rot_tipo_garantia        VARCHAR (64),
    rot_nro_garantia         cuenta,
    rot_porcentaje_cobertura CHAR (1),
    rot_valor_garantia       CHAR (1),
    rot_tperiodo             catalogo,
    rot_periodo              SMALLINT,
    rot_tabla                VARCHAR (30),
    rot_saldo_insoluto       CHAR (1),
    rot_calcular_devolucion  CHAR (1)
    )
GO

CREATE INDEX idx1
    ON dbo.ca_rubro_op_tmp (rot_operacion, rot_concepto)
    WITH (FILLFACTOR = 70)
GO

CREATE INDEX ca_rubro_op_tmp_idx2
    ON dbo.ca_rubro_op_tmp (rot_operacion, rot_tipo_rubro)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_rubro_op_reest') IS NOT NULL
    DROP TABLE dbo.ca_rubro_op_reest
GO

CREATE TABLE dbo.ca_rubro_op_reest
    (
    ror_operacion            INT NOT NULL,
    ror_concepto             catalogo NOT NULL,
    ror_tipo_rubro           CHAR (1) NOT NULL,
    ror_fpago                CHAR (1) NOT NULL,
    ror_prioridad            TINYINT NOT NULL,
    ror_paga_mora            CHAR (1) NOT NULL,
    ror_provisiona           CHAR (1) NOT NULL,
    ror_signo                CHAR (1),
    ror_factor               FLOAT,
    ror_referencial          catalogo,
    ror_signo_reajuste       CHAR (1),
    ror_factor_reajuste      FLOAT,
    ror_referencial_reajuste catalogo,
    ror_valor                MONEY NOT NULL,
    ror_porcentaje           FLOAT NOT NULL,
    ror_porcentaje_aux       FLOAT NOT NULL,
    ror_gracia               MONEY,
    ror_concepto_asociado    catalogo,
    ror_redescuento          FLOAT,
    ror_intermediacion       FLOAT,
    ror_principal            CHAR (1) NOT NULL,
    ror_porcentaje_efa       FLOAT,
    ror_garantia             MONEY NOT NULL,
    ror_tipo_puntos          CHAR (1),
    ror_saldo_op             CHAR (1),
    ror_saldo_por_desem      CHAR (1),
    ror_base_calculo         MONEY,
    ror_num_dec              TINYINT,
    ror_limite               CHAR (1),
    ror_iva_siempre          CHAR (1),
    ror_monto_aprobado       CHAR (1),
    ror_porcentaje_cobrar    FLOAT,
    ror_tipo_garantia        VARCHAR (64),
    ror_nro_garantia         cuenta,
    ror_porcentaje_cobertura CHAR (1),
    ror_valor_garantia       CHAR (1),
    ror_tperiodo             catalogo,
    ror_periodo              SMALLINT,
    ror_tabla                VARCHAR (30),
    ror_saldo_insoluto       CHAR (1),
    ror_calcular_devolucion  CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_rubro_op_r1
    ON dbo.ca_rubro_op_reest (ror_operacion, ror_concepto)
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

CREATE INDEX ca_rubro_op_his_1
    ON dbo.ca_rubro_op_his (roh_operacion, roh_secuencial)
GO

IF OBJECT_ID ('dbo.ca_rubro_op') IS NOT NULL
    DROP TABLE dbo.ca_rubro_op
GO

CREATE TABLE dbo.ca_rubro_op
    (
    ro_operacion            INT NOT NULL,
    ro_concepto             catalogo NOT NULL,
    ro_tipo_rubro           CHAR (1) NOT NULL,
    ro_fpago                CHAR (1) NOT NULL,
    ro_prioridad            TINYINT NOT NULL,
    ro_paga_mora            CHAR (1) NOT NULL,
    ro_provisiona           CHAR (1) NOT NULL,
    ro_signo                CHAR (1),
    ro_factor               FLOAT,
    ro_referencial          catalogo,
    ro_signo_reajuste       CHAR (1),
    ro_factor_reajuste      FLOAT,
    ro_referencial_reajuste catalogo,
    ro_valor                MONEY NOT NULL,
    ro_porcentaje           FLOAT NOT NULL,
    ro_porcentaje_aux       FLOAT NOT NULL,
    ro_gracia               MONEY,
    ro_concepto_asociado    catalogo,
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
    ro_nro_garantia         cuenta,
    ro_porcentaje_cobertura CHAR (1),
    ro_valor_garantia       CHAR (1),
    ro_tperiodo             catalogo,
    ro_periodo              SMALLINT,
    ro_tabla                VARCHAR (30),
    ro_saldo_insoluto       CHAR (1),
    ro_calcular_devolucion  CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_rubro_op_1
    ON dbo.ca_rubro_op (ro_operacion, ro_concepto)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_rubro_op_idx2
    ON dbo.ca_rubro_op (ro_operacion, ro_tipo_rubro, ro_concepto, ro_porcentaje, ro_fpago)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_rubro_op_idx3
    ON dbo.ca_rubro_op (ro_operacion, ro_provisiona, ro_tipo_rubro, ro_concepto, ro_fpago, ro_valor, ro_porcentaje, ro_concepto_asociado, ro_porcentaje_efa, ro_num_dec)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_rubro_op_idx4
    ON dbo.ca_rubro_op (ro_operacion, ro_paga_mora, ro_concepto, ro_fpago)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_rubro_normalizacion') IS NOT NULL
    DROP TABLE dbo.ca_rubro_normalizacion
GO

CREATE TABLE dbo.ca_rubro_normalizacion
    (
    rn_tipo_norm     INT,
    rn_rubro         VARCHAR (10),
    rn_porcent_cobro FLOAT,
    rn_estado        CHAR (1)
    )
GO

CREATE UNIQUE CLUSTERED INDEX idx2
    ON dbo.ca_rubro_normalizacion (rn_tipo_norm, rn_rubro)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx1
    ON dbo.ca_rubro_normalizacion (rn_tipo_norm)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_rubro_norm_op') IS NOT NULL
    DROP TABLE dbo.ca_rubro_norm_op
GO

CREATE TABLE dbo.ca_rubro_norm_op
    (
    ro_operacion   INT,
    ro_tramite     INT,
    ro_rubro       VARCHAR (10),
    ro_valor_rubro MONEY
    )
GO

CREATE UNIQUE CLUSTERED INDEX idx3
    ON dbo.ca_rubro_norm_op (ro_tramite)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx1
    ON dbo.ca_rubro_norm_op (ro_operacion)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
    ON dbo.ca_rubro_norm_op (ro_tramite)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_rubro_int_tmp') IS NOT NULL
    DROP TABLE dbo.ca_rubro_int_tmp
GO

CREATE TABLE dbo.ca_rubro_int_tmp
    (
    ro_operacion         INT,
    ro_concepto          catalogo,
    ro_porcentaje        FLOAT,
    ro_tipo_rubro        CHAR (1),
    ro_provisiona        CHAR (1),
    ro_fpago             CHAR (1),
    ro_concepto_asociado CHAR (1),
    ro_valor             MONEY,
    ro_num_dec           TINYINT,
    ro_porcentaje_efa    FLOAT
    )
GO

CREATE INDEX ca_rubro_int_tmp_Key
    ON dbo.ca_rubro_int_tmp (ro_operacion)
GO

IF OBJECT_ID ('dbo.ca_rubro_imo_tmp') IS NOT NULL
    DROP TABLE dbo.ca_rubro_imo_tmp
GO

CREATE TABLE dbo.ca_rubro_imo_tmp
    (
    ro_operacion         INT,
    ro_concepto          catalogo,
    ro_porcentaje        FLOAT,
    ro_tipo_rubro        CHAR (1),
    ro_provisiona        CHAR (1),
    ro_fpago             CHAR (1),
    ro_concepto_asociado CHAR (1),
    ro_valor             MONEY,
    ro_num_dec           TINYINT
    )
GO

CREATE INDEX ca_rubro_imo_tmp_Key
    ON dbo.ca_rubro_imo_tmp (ro_operacion)
GO

IF OBJECT_ID ('dbo.ca_rubro_colateral') IS NOT NULL
    DROP TABLE dbo.ca_rubro_colateral
GO

CREATE TABLE dbo.ca_rubro_colateral
    (
    ruc_operacion INT,
    ruc_concepto  VARCHAR (30),
    ruc_tramite   INT,
    ruc_tipo_gar  VARCHAR (30)
    )
GO

CREATE INDEX ca_rubro_colateral
    ON dbo.ca_rubro_colateral (ruc_operacion)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_rubro_col_op') IS NOT NULL
    DROP TABLE dbo.ca_rubro_col_op
GO

CREATE TABLE dbo.ca_rubro_col_op
    (
    ruc_operacion  INT,
    ruc_secuencial INT,
    ruc_concepto   VARCHAR (30),
    ruc_fec_pro_op DATETIME,
    ruc_porcentaje FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_rubro_cca_cre') IS NOT NULL
    DROP TABLE dbo.ca_rubro_cca_cre
GO

CREATE TABLE dbo.ca_rubro_cca_cre
    (
    ru_cca         catalogo NOT NULL,
    ru_cre         CHAR (10) NOT NULL,
    ru_descripcion descripcion NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rubro_calculado_tmp') IS NOT NULL
    DROP TABLE dbo.ca_rubro_calculado_tmp
GO

CREATE TABLE dbo.ca_rubro_calculado_tmp
    (
    rct_operacion  INT,
    rct_concepto   catalogo,
    rct_tipo_rubro CHAR (1),
    rct_rubro_cca  catalogo,
    rct_rubro_cre  CHAR (10),
    rct_fpago      catalogo
    )
GO

CREATE INDEX ca_rubro_calculado_tmp_1
    ON dbo.ca_rubro_calculado_tmp (rct_operacion)
GO

IF OBJECT_ID ('dbo.ca_rubro_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_rubro_bancamia
GO

CREATE TABLE dbo.ca_rubro_bancamia
    (
    ru_toperacion           catalogo NOT NULL,
    ru_moneda               TINYINT NOT NULL,
    ru_concepto             catalogo NOT NULL,
    ru_prioridad            TINYINT NOT NULL,
    ru_tipo_rubro           catalogo NOT NULL,
    ru_paga_mora            CHAR (1) NOT NULL,
    ru_provisiona           CHAR (1) NOT NULL,
    ru_fpago                CHAR (1) NOT NULL,
    ru_crear_siempre        CHAR (1) NOT NULL,
    ru_tperiodo             catalogo,
    ru_periodo              SMALLINT,
    ru_referencial          catalogo,
    ru_reajuste             catalogo,
    ru_banco                CHAR (1) NOT NULL,
    ru_estado               catalogo NOT NULL,
    ru_concepto_asociado    catalogo,
    ru_redescuento          FLOAT,
    ru_intermediacion       FLOAT,
    ru_principal            CHAR (1) NOT NULL,
    ru_saldo_op             CHAR (1),
    ru_saldo_por_desem      CHAR (1),
    ru_pit                  catalogo,
    ru_limite               CHAR (1),
    ru_mora_interes         CHAR (1),
    ru_iva_siempre          CHAR (1),
    ru_monto_aprobado       CHAR (1),
    ru_porcentaje_cobrar    FLOAT,
    ru_tipo_garantia        VARCHAR (64),
    ru_valor_garantia       CHAR (1),
    ru_porcentaje_cobertura CHAR (1),
    ru_tabla                VARCHAR (30),
    ru_saldo_insoluto       CHAR (1),
    ru_calcular_devolucion  CHAR (1)
    )
GO

CREATE CLUSTERED INDEX ca_rubro_1
    ON dbo.ca_rubro_bancamia (ru_toperacion, ru_moneda, ru_concepto)
GO

IF OBJECT_ID ('dbo.ca_rubro') IS NOT NULL
    DROP TABLE dbo.ca_rubro
GO

CREATE TABLE dbo.ca_rubro
    (
    ru_toperacion           catalogo NOT NULL,
    ru_moneda               TINYINT NOT NULL,
    ru_concepto             catalogo NOT NULL,
    ru_prioridad            TINYINT NOT NULL,
    ru_tipo_rubro           catalogo NOT NULL,
    ru_paga_mora            CHAR (1) NOT NULL,
    ru_provisiona           CHAR (1) NOT NULL,
    ru_fpago                CHAR (1) NOT NULL,
    ru_crear_siempre        CHAR (1) NOT NULL,
    ru_tperiodo             catalogo,
    ru_periodo              SMALLINT,
    ru_referencial          catalogo,
    ru_reajuste             catalogo,
    ru_banco                CHAR (1) NOT NULL,
    ru_estado               catalogo NOT NULL,
    ru_concepto_asociado    catalogo,
    ru_redescuento          FLOAT,
    ru_intermediacion       FLOAT,
    ru_principal            CHAR (1),
    ru_saldo_op             CHAR (1),
    ru_saldo_por_desem      CHAR (1),
    ru_pit                  catalogo,
    ru_limite               CHAR (1),
    ru_mora_interes         CHAR (1),
    ru_iva_siempre          CHAR (1),
    ru_monto_aprobado       CHAR (1),
    ru_porcentaje_cobrar    FLOAT,
    ru_tipo_garantia        VARCHAR (64),
    ru_valor_garantia       CHAR (1),
    ru_porcentaje_cobertura CHAR (1),
    ru_tabla                VARCHAR (30),
    ru_saldo_insoluto       CHAR (1),
    ru_calcular_devolucion  CHAR (1),
    ru_tasa_aplicar         CHAR (1),
    ru_valor_max            money,
    ru_valor_min            money,
    ru_afectacion           smallint,
    ru_diferir              char(1),
    ru_tipo_seguro          catalogo,
    ru_tasa_efectiva        char(1)
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_rubro_1
    ON dbo.ca_rubro (ru_toperacion, ru_moneda, ru_concepto)
GO

IF OBJECT_ID ('dbo.ca_rol_condona_ts') IS NOT NULL
    DROP TABLE dbo.ca_rol_condona_ts
GO

CREATE TABLE dbo.ca_rol_condona_ts
    (
    rcs_fecha_proceso_ts DATETIME NOT NULL,
    rcs_fecha_ts         DATETIME NOT NULL,
    rcs_usuario_ts       login NOT NULL,
    rcs_oficina_ts       SMALLINT NOT NULL,
    rcs_terminal_ts      VARCHAR (30) NOT NULL,
    rcs_operacion_ts     CHAR (1) NOT NULL,
    rcs_rol              TINYINT NOT NULL,
    rcs_condonacion      SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rol_condona') IS NOT NULL
    DROP TABLE dbo.ca_rol_condona
GO

CREATE TABLE dbo.ca_rol_condona
    (
    rc_rol         TINYINT NOT NULL,
    rc_condonacion SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rol_autoriza_condona_ts') IS NOT NULL
    DROP TABLE dbo.ca_rol_autoriza_condona_ts
GO

CREATE TABLE dbo.ca_rol_autoriza_condona_ts
    (
    ras_fecha_proceso_ts DATETIME NOT NULL,
    ras_fecha_ts         DATETIME NOT NULL,
    ras_usuario_ts       login NOT NULL,
    ras_oficina_ts       SMALLINT NOT NULL,
    ras_terminal_ts      VARCHAR (30) NOT NULL,
    ras_operacion_ts     CHAR (1) NOT NULL,
    ras_rol_condona      TINYINT NOT NULL,
    ras_rol_autoriza     TINYINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rol_autoriza_condona') IS NOT NULL
    DROP TABLE dbo.ca_rol_autoriza_condona
GO

CREATE TABLE dbo.ca_rol_autoriza_condona
    (
    rac_rol_condona  TINYINT NOT NULL,
    rac_rol_autoriza TINYINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_revisa_prepagos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_revisa_prepagos_tmp
GO

CREATE TABLE dbo.ca_revisa_prepagos_tmp
    (
    fecha_generacion   DATETIME,
    oper_activa        INT,
    oper_pasiva        INT,
    secuencial_prepago INT,
    banco_pas          cuenta,
    estado_registro    CHAR (1),
    cliente            INT,
    valor_prepago      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_revisa_cuota_can') IS NOT NULL
    DROP TABLE dbo.ca_revisa_cuota_can
GO

CREATE TABLE dbo.ca_revisa_cuota_can
    (
    banco     cuenta,
    operacion INT,
    estado_op SMALLINT,
    dividendo INT,
    val_pte   FLOAT,
    estado    CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_revisa_boc') IS NOT NULL
    DROP TABLE dbo.ca_revisa_boc
GO

CREATE TABLE dbo.ca_revisa_boc
    (
    rb_fecha      DATETIME,
    rb_operacion  INT,
    rb_cliente    INT,
    rb_concepto   catalogo,
    rb_diferencia MONEY,
    rb_cuenta     cuenta,
    rb_nombre     VARCHAR (50)
    )
GO

IF OBJECT_ID ('dbo.ca_revfv_masivos') IS NOT NULL
    DROP TABLE dbo.ca_revfv_masivos
GO

CREATE TABLE dbo.ca_revfv_masivos
    (
    rf_banco         cuenta NOT NULL,
    rf_secuencial    INT,
    rf_fecha_val     DATETIME,
    rf_fecha_mov     DATETIME,
    rf_fecha_proceso DATETIME,
    rf_estado_reg    CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_resumen_tmp') IS NOT NULL
    DROP TABLE dbo.ca_resumen_tmp
GO

CREATE TABLE dbo.ca_resumen_tmp
    (
    rt_fecha_proceso DATETIME,
    rt_banco         CHAR (20),
    rt_tipo          CHAR (25),
    rt_valor         MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_RES_HISTORICOS_tmp') IS NOT NULL
    DROP TABLE dbo.ca_RES_HISTORICOS_tmp
GO

CREATE TABLE dbo.ca_RES_HISTORICOS_tmp
    (
    res_secuencial_res INT NOT NULL,
    res_operacion      INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_reproceso_seg_tmp') IS NOT NULL
    DROP TABLE dbo.ca_reproceso_seg_tmp
GO

CREATE TABLE dbo.ca_reproceso_seg_tmp
    (
    re_operacion INT NOT NULL,
    re_op_tipo   CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_reproceso_en_fecha_valor') IS NOT NULL
    DROP TABLE dbo.ca_reproceso_en_fecha_valor
GO

CREATE TABLE dbo.ca_reproceso_en_fecha_valor
    (
    rfv_operacion       INT NOT NULL,
    rfv_fecha_reproceso DATETIME NOT NULL,
    rfv_dividendo       INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_reproceso_asociados') IS NOT NULL
    DROP TABLE dbo.ca_reproceso_asociados
GO

CREATE TABLE dbo.ca_reproceso_asociados
    (
    operacion            INT,
    dividendo            INT,
    rubro                catalogo,
    valor_rubro          MONEY,
    rubro_asociado       catalogo,
    valor_rubro_asociado MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_reporte_temporal_cifras') IS NOT NULL
    DROP TABLE dbo.ca_reporte_temporal_cifras
GO

CREATE TABLE dbo.ca_reporte_temporal_cifras
    (
    FECHA_DESCUENTO  VARCHAR (10),
    NUMERO_REGISTROS INT,
    TOTAL_DESCUENTOS MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_reporte_temporal') IS NOT NULL
    DROP TABLE dbo.ca_reporte_temporal
GO

CREATE TABLE dbo.ca_reporte_temporal
    (
    ID_ORGANIZATION    VARCHAR (4),
    DT_LAST_UPDATE     VARCHAR (10),
    STD_ID_HR          VARCHAR (10),
    ID_DMD             VARCHAR (30),
    ID_DMD_COMPONENT   VARCHAR (30),
    PROJ               INT,
    SCO_DT_ACCRUED     VARCHAR (10),
    SCO_ID_PAY_FREQUEN VARCHAR (3),
    ID_M4_TYPE         INT,
    SCO_VALUE          VARCHAR (20),
    SCO_ID_CURRENCY    VARCHAR (4),
    SCO_DT_EXCHANGE    VARCHAR (10),
    EX_TYPE            VARCHAR (10),
    SCO_ID_REA_CHANG   VARCHAR (3),
    ID_PRIORITY        INT,
    SCO_COMMENT        VARCHAR (254),
    ID_SECUSER         VARCHAR (30),
    ID_APPROLE         VARCHAR (30),
    D_MORA             INT,
    V_MORA             MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_reporte_reest') IS NOT NULL
    DROP TABLE dbo.ca_reporte_reest
GO

CREATE TABLE dbo.ca_reporte_reest
    (
    rr_fecha_tran      DATETIME,
    rr_nombre_cli      descripcion,
    rr_tipo_ide        VARCHAR (4),
    rr_numero_ide      numero,
    rr_olbigacion      VARCHAR (24),
    rr_toperacion      VARCHAR (30),
    rr_oficina         SMALLINT,
    rr_gar_FNG         VARCHAR (1),
    rr_monto_reest     MONEY,
    rr_plazo_reest     INT,
    rr_motivo_reest    descripcion,
    rr_conceptos       descripcion,
    rr_estado_concepto descripcion,
    rr_valor_concepto  MONEY
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

CREATE INDEX ca_reportar_cliente_1
    ON dbo.ca_reportar_cliente (rc_numero_documento)
GO

CREATE INDEX ca_reportar_cliente_2
    ON dbo.ca_reportar_cliente (rc_numero_titular)
GO

IF OBJECT_ID ('dbo.ca_rep_usaid') IS NOT NULL
    DROP TABLE dbo.ca_rep_usaid
GO

CREATE TABLE dbo.ca_rep_usaid
    (
    ru_clasificar    CHAR (1),
    ru_id_unico      VARCHAR (24),
    ru_banco         VARCHAR (24),
    ru_nom_cliente   VARCHAR (100),
    ru_fecha_ini     VARCHAR (10),
    ru_fecha_ven     VARCHAR (10),
    ru_fecha_gar     VARCHAR (10),
    ru_monto_apr     MONEY,
    ru_fecha_cob     VARCHAR (10),
    ru_dias_mora     INT,
    ru_saldo_inicial MONEY,
    ru_desembolso    MONEY,
    ru_pago          MONEY,
    ru_saldo         MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_rep_planif_mensual') IS NOT NULL
    DROP TABLE dbo.ca_rep_planif_mensual
GO

CREATE TABLE dbo.ca_rep_planif_mensual
    (
    rp_oficina       SMALLINT,
    rp_concepto      catalogo,
    rp_num_identidad numero,
    rp_nombre_asesor VARCHAR (100),
    rp_cuenta        cuenta,
    rp_valor_total   MONEY,
    rp_saldo_cxp     MONEY,
    rp_banco         cuenta,
    rp_nomcliente    VARCHAR (100),
    rp_nom_oficina   VARCHAR (50)
    )
GO

IF OBJECT_ID ('dbo.ca_rep_planif_diario') IS NOT NULL
    DROP TABLE dbo.ca_rep_planif_diario
GO

CREATE TABLE dbo.ca_rep_planif_diario
    (
    rp_regional      SMALLINT,
    rp_oficina       SMALLINT,
    rp_concepto      catalogo,
    rp_num_identidad numero,
    rp_nombre_asesor VARCHAR (100),
    rp_cuenta        cuenta,
    rp_valor_total   MONEY,
    rp_banco         cuenta,
    rp_nomcliente    VARCHAR (100),
    rp_nom_regional  VARCHAR (100)
    )
GO

IF OBJECT_ID ('dbo.ca_rep_pagos_reest') IS NOT NULL
    DROP TABLE dbo.ca_rep_pagos_reest
GO

CREATE TABLE dbo.ca_rep_pagos_reest
    (
    rp_fecha_pag       DATETIME NOT NULL,
    rp_nombre_cli      VARCHAR (255) NOT NULL,
    rp_tipo_ide        catalogo,
    rp_numero_ide      cuenta,
    rp_obligacion      VARCHAR (24) NOT NULL,
    rp_toperacion      catalogo,
    rp_oficina         INT NOT NULL,
    rp_valor_pag       MONEY NOT NULL,
    rp_conceptos       catalogo,
    rp_estado_concepto descripcion,
    rp_valor_concepto  MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_rep_coloca_fondos') IS NOT NULL
    DROP TABLE dbo.ca_rep_coloca_fondos
GO

CREATE TABLE dbo.ca_rep_coloca_fondos
    (
    tmp_en_tipo_ced      CHAR (2),
    tmp_des_tipo_ced     descripcion,
    tmp_en_ced_ruc       numero,
    tmp_op_nombre        descripcion,
    tmp_op_banco         cuenta,
    tmp_cod_estrato      VARCHAR (10),
    tmp_des_estrato      descripcion,
    tmp_p_fecha_nac      DATETIME,
    tmp_p_ciudad_nac     INT,
    tmp_nom_ciudad_nac   descripcion,
    tmp_tr_fecha_apr     DATETIME,
    tmp_op_tplazo        catalogo,
    tmp_op_plazo         SMALLINT,
    tmp_pla_meses        SMALLINT,
    tmp_p_sexo           sexo,
    tmp_des_sexo         descripcion,
    tmp_dir_microempresa VARCHAR (254),
    tmp_tel_microempresa VARCHAR (16),
    tmp_op_ciudad        INT,
    tmp_nom_ciudad       descripcion,
    tmp_tas_nominal      FLOAT,
    tmp_edad_deudor      INT,
    tmp_tot_activos      MONEY,
    tmp_op_monto         MONEY,
    tmp_sal_capital      MONEY,
    tmp_nit_empresa      numero,
    tmp_nom_empresa      descripcion,
    tmp_cod_act_eco      catalogo,
    tmp_nom_act_eco      descripcion,
    tmp_cod_sec_eco      catalogo,
    tmp_nom_sec_eco      descripcion,
    tmp_can_tra_emp      INT,
    tmp_fec_liq          DATETIME,
    tmp_tas_efectiva     FLOAT,
    tmp_op_cuota         MONEY,
    tmp_num_cuo_pen      INT,
    tmp_sal_cap_int_imo  MONEY,
    tmp_vlr_com_hon      MONEY,
    tmp_cod_destino      catalogo,
    tmp_des_destino      descripcion,
    tmp_cod_ciu_mic      INT,
    tmp_nom_ciu_mic      descripcion,
    tmp_num_tel_mic      descripcion,
    tmp_cod_lin_cre      catalogo,
    tmp_des_lin_cre      descripcion,
    tmp_cod_ofi_pre      SMALLINT,
    tmp_des_ofi_pre      descripcion,
    tmp_cod_bar_mic      SMALLINT,
    tmp_des_bar_mic      descripcion,
    tmp_vlr_cuot         MONEY,
    tmp_cod_est_ope      TINYINT,
    tmp_des_est_ope      descripcion,
    tmp_com_pym          MONEY,
    tmp_cuo_otr_rub      MONEY,
    tmp_tot_gar_pre      MONEY,
    tmp_num_obl_int      INT,
    tmp_tipo_soc         CHAR (3),
    tmp_fec_desembolso   DATETIME,
    tmp_sector           CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_rep_70') IS NOT NULL
    DROP TABLE dbo.ca_rep_70
GO

CREATE TABLE dbo.ca_rep_70
    (
    cr_oficina    SMALLINT,
    cr_banco      cuenta,
    cr_cedula     VARCHAR (24),
    cr_nombre     VARCHAR (255),
    cr_apellido   VARCHAR (255),
    cr_monto      MONEY,
    cr_plazo      INT,
    cr_saldo      MONEY,
    cr_nota       SMALLINT,
    cr_porcentaje FLOAT,
    cr_antiguedad INT,
    cr_actividad  VARCHAR (64),
    cr_direccion  VARCHAR (255),
    cr_telefono_n VARCHAR (64),
    cr_telefono_c VARCHAR (64),
    cr_ejecutivo  VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.ca_ren_autorizada') IS NOT NULL
    DROP TABLE dbo.ca_ren_autorizada
GO

CREATE TABLE dbo.ca_ren_autorizada
    (
    ra_tramite       INT NOT NULL,
    ra_fecha_sistema DATETIME NOT NULL,
    ra_fecha_real    DATETIME NOT NULL,
    ra_terminal      VARCHAR (30) NOT NULL,
    ra_oficina       SMALLINT NOT NULL,
    ra_usuario       login NOT NULL
    )
GO

CREATE INDEX ca_ren_autorizada_1
    ON dbo.ca_ren_autorizada (ra_fecha_real)
GO

CREATE INDEX ca_ren_autorizada_2
    ON dbo.ca_ren_autorizada (ra_usuario)
GO

IF OBJECT_ID ('dbo.ca_reloj') IS NOT NULL
    DROP TABLE dbo.ca_reloj
GO

CREATE TABLE dbo.ca_reloj
    (
    referencia INT NOT NULL,
    hora       VARCHAR (30) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_relacion_ptmo_ts') IS NOT NULL
    DROP TABLE dbo.ca_relacion_ptmo_ts
GO

CREATE TABLE dbo.ca_relacion_ptmo_ts
    (
    hpts_fecha_proceso_ts DATETIME NOT NULL,
    hpts_fecha_ts         DATETIME NOT NULL,
    hpts_usuario_ts       login NOT NULL,
    hpts_oficina_ts       SMALLINT NOT NULL,
    hpts_terminal_ts      VARCHAR (30) NOT NULL,
    hpts_operacion_ts     CHAR (1) NOT NULL,
    hpts_activa           INT,
    hpts_pasiva           INT,
    hpts_lin_activa       VARCHAR (24),
    hpts_lin_pasiva       VARCHAR (24),
    hpts_fecha_ini        DATETIME,
    hpts_fecha_fin        DATETIME,
    hpts_porcentaje_act   FLOAT,
    hpts_porcentaje_pas   FLOAT,
    hpts_saldo_act        MONEY,
    hpts_saldo_pas        MONEY,
    hpts_fecha_grb        DATETIME,
    hpts_fecha_upd        DATETIME,
    hpts_usuario_grb      login,
    hpts_usuario_upd      login,
    hpts_hora_grb         VARCHAR (10),
    hpts_hora_upd         VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_relacion_ptmo_tmp') IS NOT NULL
    DROP TABLE dbo.ca_relacion_ptmo_tmp
GO

CREATE TABLE dbo.ca_relacion_ptmo_tmp
    (
    rpt_activa         INT,
    rpt_pasiva         INT,
    rpt_lin_activa     VARCHAR (24),
    rpt_lin_pasiva     VARCHAR (24),
    rpt_fecha_ini      DATETIME,
    rpt_fecha_fin      DATETIME,
    rpt_porcentaje_act FLOAT,
    rpt_porcentaje_pas FLOAT,
    rpt_saldo_act      MONEY,
    rpt_saldo_pas      MONEY,
    rpt_fecha_grb      DATETIME,
    rpt_fecha_upd      DATETIME,
    rpt_usuario_grb    login,
    rpt_usuario_upd    login,
    rpt_hora_grb       VARCHAR (10),
    rpt_hora_upd       VARCHAR (10)
    )
GO

CREATE INDEX ca_relacion_ptmo_tmp_1
    ON dbo.ca_relacion_ptmo_tmp (rpt_activa)
GO

IF OBJECT_ID ('dbo.ca_relacion_ptmo_pago_temp') IS NOT NULL
    DROP TABLE dbo.ca_relacion_ptmo_pago_temp
GO

CREATE TABLE dbo.ca_relacion_ptmo_pago_temp
    (
    rp_activa         INT,
    rp_pasiva         INT,
    rp_lin_activa     VARCHAR (24),
    rp_lin_pasiva     VARCHAR (24),
    rp_fecha_ini      DATETIME,
    rp_fecha_fin      DATETIME,
    rp_porcentaje_act FLOAT,
    rp_porcentaje_pas FLOAT,
    rp_saldo_act      MONEY,
    rp_saldo_pas      MONEY,
    rp_fecha_grb      DATETIME,
    rp_fecha_upd      DATETIME,
    rp_usuario_grb    login,
    rp_usuario_upd    login,
    rp_hora_grb       VARCHAR (10),
    rp_hora_upd       VARCHAR (10)
    )
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

CREATE INDEX ca_relacion_ptmo_his_1
    ON dbo.ca_relacion_ptmo_his (hpt_pasiva, hpt_secuencial)
GO

IF OBJECT_ID ('dbo.ca_relacion_ptmo') IS NOT NULL
    DROP TABLE dbo.ca_relacion_ptmo
GO

CREATE TABLE dbo.ca_relacion_ptmo
    (
    rp_activa         INT,
    rp_pasiva         INT,
    rp_lin_activa     VARCHAR (24),
    rp_lin_pasiva     VARCHAR (24),
    rp_fecha_ini      DATETIME,
    rp_fecha_fin      DATETIME,
    rp_porcentaje_act FLOAT,
    rp_porcentaje_pas FLOAT,
    rp_saldo_act      MONEY,
    rp_saldo_pas      MONEY,
    rp_fecha_grb      DATETIME,
    rp_fecha_upd      DATETIME,
    rp_usuario_grb    login,
    rp_usuario_upd    login,
    rp_hora_grb       VARCHAR (10),
    rp_hora_upd       VARCHAR (10)
    )
GO

CREATE INDEX ca_relacion_ptmo_1
    ON dbo.ca_relacion_ptmo (rp_activa, rp_pasiva)
GO

CREATE INDEX ca_relacion_ptmo_2
    ON dbo.ca_relacion_ptmo (rp_pasiva, rp_activa)
GO

IF OBJECT_ID ('dbo.ca_reg_eliminado_his') IS NOT NULL
    DROP TABLE dbo.ca_reg_eliminado_his
GO

CREATE TABLE dbo.ca_reg_eliminado_his
    (
    reh_secuencial     INT,
    reh_max_secuencial INT,
    reh_operacion      INT
    )
GO

IF OBJECT_ID ('dbo.ca_recuperacion_cobranza') IS NOT NULL
    DROP TABLE dbo.ca_recuperacion_cobranza
GO

CREATE TABLE dbo.ca_recuperacion_cobranza
    (
    rc_fecha_proc DATETIME NOT NULL,
    rc_num_op     INT NOT NULL,
    rc_num_op_ext VARCHAR (24) NOT NULL,
    rc_oficina    SMALLINT NOT NULL,
    rc_moneda     TINYINT NOT NULL,
    rc_tipo_trn   CHAR (10) NOT NULL,
    rc_monto      MONEY NOT NULL,
    rc_dias_ven   VARCHAR (24) NOT NULL,
    rc_producto   VARCHAR (24) NOT NULL,
    rc_numero     SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_recfng_mas') IS NOT NULL
    DROP TABLE dbo.ca_recfng_mas
GO

CREATE TABLE dbo.ca_recfng_mas
    (
    cf_ident    cuenta,
    cf_banco    cuenta,
    cf_pago     MONEY NOT NULL,
    cf_est_cob  CHAR (2) NOT NULL,
    cf_producto VARCHAR (20) NOT NULL,
    cf_desmarca CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datosII') IS NOT NULL
    DROP TABLE dbo.ca_recalculo_mipymes_datosII
GO

CREATE TABLE dbo.ca_recalculo_mipymes_datosII
    (
    OFICINA          SMALLINT NOT NULL,
    CLIENTE          INT,
    CEDULA           VARCHAR (30),
    OPERACION        INT NOT NULL,
    OPBANCO          cuenta NOT NULL,
    FECHA_DESEMBOLSO VARCHAR (30),
    VALOR_DESEMBOLSO MONEY,
    PLAZO            INT NOT NULL,
    CUOTAS_PAGADAS   INT NOT NULL,
    CUOTAS_VENCIDAS  INT NOT NULL,
    DIVIDENDO        SMALLINT NOT NULL,
    ESTADO_DIV       TINYINT NOT NULL,
    CONCEPTO         catalogo NOT NULL,
    TASA_OR          FLOAT NOT NULL,
    ESTADO_RUBRO     TINYINT NOT NULL,
    CUOTA_OR         MONEY NOT NULL,
    PAGADO_OR        MONEY NOT NULL,
    ACUMULADO_OR     MONEY NOT NULL,
    PARAMETRO        INT NOT NULL,
    CAPITAL_BASE     MONEY,
    TASA_NUEVA       FLOAT,
    CUOTA_NEW        MONEY,
    ACUMULADO_NEW    MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos_III') IS NOT NULL
    DROP TABLE dbo.ca_recalculo_mipymes_datos_III
GO

CREATE TABLE dbo.ca_recalculo_mipymes_datos_III
    (
    OFICINA          SMALLINT NOT NULL,
    CLIENTE          INT,
    CEDULA           VARCHAR (30),
    OPERACION        INT NOT NULL,
    OPBANCO          cuenta NOT NULL,
    FECHA_DESEMBOLSO VARCHAR (30),
    VALOR_DESEMBOLSO MONEY,
    PLAZO            INT NOT NULL,
    CUOTAS_PAGADAS   INT NOT NULL,
    CUOTAS_VENCIDAS  INT NOT NULL,
    DIVIDENDO        SMALLINT NOT NULL,
    ESTADO_DIV       TINYINT NOT NULL,
    CONCEPTO         catalogo NOT NULL,
    TASA_OR          FLOAT NOT NULL,
    ESTADO_RUBRO     TINYINT NOT NULL,
    CUOTA_OR         MONEY NOT NULL,
    PAGADO_OR        MONEY NOT NULL,
    ACUMULADO_OR     MONEY NOT NULL,
    PARAMETRO        INT NOT NULL,
    CAPITAL_BASE     MONEY,
    TASA_NUEVA       FLOAT,
    CUOTA_NEW        MONEY,
    ACUMULADO_NEW    MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos_369') IS NOT NULL
    DROP TABLE dbo.ca_recalculo_mipymes_datos_369
GO

CREATE TABLE dbo.ca_recalculo_mipymes_datos_369
    (
    OFICINA          SMALLINT NOT NULL,
    CLIENTE          INT,
    CEDULA           VARCHAR (30),
    OPERACION        INT NOT NULL,
    OPBANCO          cuenta NOT NULL,
    FECHA_DESEMBOLSO VARCHAR (30),
    VALOR_DESEMBOLSO MONEY,
    PLAZO            INT NOT NULL,
    CUOTAS_PAGADAS   INT NOT NULL,
    CUOTAS_VENCIDAS  INT NOT NULL,
    DIVIDENDO        SMALLINT NOT NULL,
    ESTADO_DIV       TINYINT NOT NULL,
    CONCEPTO         catalogo NOT NULL,
    TASA_OR          FLOAT NOT NULL,
    ESTADO_RUBRO     TINYINT NOT NULL,
    CUOTA_OR         MONEY NOT NULL,
    PAGADO_OR        MONEY NOT NULL,
    ACUMULADO_OR     MONEY NOT NULL,
    PARAMETRO        INT NOT NULL,
    CAPITAL_BASE     MONEY,
    TASA_NUEVA       FLOAT,
    CUOTA_NEW        MONEY,
    ACUMULADO_NEW    MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_recalculo_mipymes_datos') IS NOT NULL
    DROP TABLE dbo.ca_recalculo_mipymes_datos
GO

CREATE TABLE dbo.ca_recalculo_mipymes_datos
    (
    OFICINA          SMALLINT NOT NULL,
    CLIENTE          INT,
    CEDULA           VARCHAR (30),
    OPERACION        INT NOT NULL,
    OPBANCO          cuenta NOT NULL,
    FECHA_DESEMBOLSO VARCHAR (30),
    VALOR_DESEMBOLSO MONEY,
    PLAZO            INT NOT NULL,
    CUOTAS_PAGADAS   INT NOT NULL,
    CUOTAS_VENCIDAS  INT NOT NULL,
    DIVIDENDO        SMALLINT NOT NULL,
    ESTADO_DIV       TINYINT NOT NULL,
    CONCEPTO         catalogo NOT NULL,
    TASA_OR          FLOAT NOT NULL,
    ESTADO_RUBRO     TINYINT NOT NULL,
    CUOTA_OR         MONEY NOT NULL,
    PAGADO_OR        MONEY NOT NULL,
    ACUMULADO_OR     MONEY NOT NULL,
    PARAMETRO        INT NOT NULL,
    CAPITAL_BASE     MONEY,
    TASA_NUEVA       FLOAT,
    CUOTA_NEW        MONEY,
    ACUMULADO_NEW    MONEY
    )
GO

CREATE INDEX ca_recalculo_idx
    ON dbo.ca_recalculo_mipymes_datos (OPERACION, DIVIDENDO, CONCEPTO)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_rec_pagos_recib') IS NOT NULL
    DROP TABLE dbo.ca_rec_pagos_recib
GO

CREATE TABLE dbo.ca_rec_pagos_recib
    (
    tmp_nro_oper           INT,
    tmp_cod_ofi            SMALLINT,
    tmp_des_ofi            VARCHAR (64),
    tmp_cod_funcionario    SMALLINT,
    tmp_nombre_funcionario VARCHAR (64),
    tmp_cap                MONEY,
    tmp_int                MONEY,
    tmp_imo                MONEY,
    tmp_mipymes            MONEY,
    tmp_ivamipymes         MONEY,
    tmp_otros              MONEY,
    tmp_valor_total        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_reajuste_ts') IS NOT NULL
    DROP TABLE dbo.ca_reajuste_ts
GO

CREATE TABLE dbo.ca_reajuste_ts
    (
    res_fecha_proceso_ts  DATETIME NOT NULL,
    res_fecha_ts          DATETIME NOT NULL,
    res_usuario_ts        login NOT NULL,
    res_oficina_ts        SMALLINT NOT NULL,
    res_terminal_ts       VARCHAR (30) NOT NULL,
    res_secuencial        INT NOT NULL,
    res_operacion         INT NOT NULL,
    res_fecha             DATETIME NOT NULL,
    res_reajuste_especial CHAR (1) NOT NULL,
    res_desagio           CHAR (1),
    res_sec_aviso         INT
    )
GO

CREATE INDEX ca_reajuste_ts_1
    ON dbo.ca_reajuste_ts (res_fecha_proceso_ts)
GO

CREATE INDEX ca_reajuste_ts_2
    ON dbo.ca_reajuste_ts (res_fecha_ts)
GO

CREATE INDEX ca_reajuste_ts_3
    ON dbo.ca_reajuste_ts (res_usuario_ts)
GO

CREATE INDEX ca_reajuste_ts_4
    ON dbo.ca_reajuste_ts (res_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_reajuste_tmp') IS NOT NULL
    DROP TABLE dbo.ca_reajuste_tmp
GO

CREATE TABLE dbo.ca_reajuste_tmp
    (
    re_secuencial        INT NOT NULL,
    re_operacion         INT NOT NULL,
    re_fecha             DATETIME NOT NULL,
    re_reajuste_especial CHAR (1) NOT NULL,
    re_desagio           CHAR (1),
    re_sec_aviso         INT
    )
GO

CREATE UNIQUE INDEX ca_reajuste_tmp_1
    ON dbo.ca_reajuste_tmp (re_operacion, re_fecha)
GO

IF OBJECT_ID ('dbo.ca_reajuste_det_ts') IS NOT NULL
    DROP TABLE dbo.ca_reajuste_det_ts
GO

CREATE TABLE dbo.ca_reajuste_det_ts
    (
    reds_fecha_proceso_ts DATETIME NOT NULL,
    reds_fecha_ts         DATETIME NOT NULL,
    reds_usuario_ts       login NOT NULL,
    reds_oficina_ts       SMALLINT NOT NULL,
    reds_terminal_ts      VARCHAR (30) NOT NULL,
    reds_secuencial       INT NOT NULL,
    red_operacion         INT NOT NULL,
    reds_concepto         catalogo NOT NULL,
    reds_referencial      catalogo,
    reds_signo            CHAR (1),
    reds_factor           FLOAT,
    reds_porcentaje       FLOAT
    )
GO

CREATE INDEX ca_reajuste_det_ts_1
    ON dbo.ca_reajuste_det_ts (reds_fecha_proceso_ts)
GO

CREATE INDEX ca_reajuste_det_ts_2
    ON dbo.ca_reajuste_det_ts (reds_fecha_ts)
GO

CREATE INDEX ca_reajuste_det_ts_3
    ON dbo.ca_reajuste_det_ts (reds_usuario_ts)
GO

CREATE INDEX ca_reajuste_det_ts_4
    ON dbo.ca_reajuste_det_ts (reds_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_reajuste_det_tmp') IS NOT NULL
    DROP TABLE dbo.ca_reajuste_det_tmp
GO

CREATE TABLE dbo.ca_reajuste_det_tmp
    (
    red_secuencial  INT NOT NULL,
    red_operacion   INT NOT NULL,
    red_concepto    catalogo NOT NULL,
    red_referencial catalogo,
    red_signo       CHAR (1),
    red_factor      FLOAT,
    red_porcentaje  FLOAT
    )
GO

CREATE UNIQUE INDEX ca_reajuste_det_tmp_1
    ON dbo.ca_reajuste_det_tmp (red_operacion, red_secuencial, red_concepto)
GO

IF OBJECT_ID ('dbo.ca_reajuste_det') IS NOT NULL
    DROP TABLE dbo.ca_reajuste_det
GO

CREATE TABLE dbo.ca_reajuste_det
    (
    red_secuencial  INT NOT NULL,
    red_operacion   INT NOT NULL,
    red_concepto    catalogo NOT NULL,
    red_referencial catalogo,
    red_signo       CHAR (1),
    red_factor      FLOAT,
    red_porcentaje  FLOAT
    )
GO

CREATE UNIQUE INDEX ca_reajuste_det_1
    ON dbo.ca_reajuste_det (red_operacion, red_secuencial, red_concepto)
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

CREATE CLUSTERED INDEX ca_reajuste_1
    ON dbo.ca_reajuste (re_operacion, re_fecha)
    WITH (FILLFACTOR = 70)
GO

IF OBJECT_ID ('dbo.ca_query_clientes_Plano') IS NOT NULL
    DROP TABLE dbo.ca_query_clientes_Plano
GO

CREATE TABLE dbo.ca_query_clientes_Plano
    (
    COD_CLIENTE           INT,
    TIPO_IDENTIFICACION   catalogo,
    IDENTIFICACION        VARCHAR (30),
    NOMBRE                VARCHAR (65),
    P_APELLIDO            VARCHAR (30),
    S_APELLIDO            VARCHAR (30),
    COD_OFICINA           INT,
    NOM_OFICINA           VARCHAR (64),
    SEXO                  catalogo,
    PRODUCTO              cuenta,
    CODIGO_PROD           SMALLINT,
    NOM_PRODUCTO          VARCHAR (50),
    FECHA_APERTURA        DATETIME,
    EMF                   INT,
    DES_EMF               VARCHAR (64),
    FECHA_PAG_VENCIMIENTO DATETIME,
    TIPO_PRODUCTO         catalogo,
    EXENTO_GMF            CHAR (1),
    MONTO                 MONEY,
    CATEGORIA_AHO         catalogo,
    DES_CATEGORIA         VARCHAR (30),
    CIUDAD                INT,
    DES_CIUDAD            VARCHAR (64),
    RUTAL_URBANO          catalogo,
    TEL_RESIDENCIA        VARCHAR (30),
    TEL_NEGOCIO           VARCHAR (30),
    NUM_REG               INT,
    MINIMA_FECHA          DATETIME,
    TIPO_CLIENTE          VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_proyeccion_recuperacion') IS NOT NULL
    DROP TABLE dbo.ca_proyeccion_recuperacion
GO

CREATE TABLE dbo.ca_proyeccion_recuperacion
    (
    pr_fecha_ven    VARCHAR (10),
    pr_oficina      VARCHAR (20),
    pr_desc_oficina descripcion,
    pr_clase        descripcion,
    pr_capital      VARCHAR (50),
    pr_interes      VARCHAR (50),
    pr_mipymes      VARCHAR (50),
    pr_ivamipymes   VARCHAR (50),
    pr_segdeu       VARCHAR (50),
    pr_fng          VARCHAR (50),
    pr_otros        VARCHAR (50),
    pr_recupera     VARCHAR (50),
    pr_fecha_desde  VARCHAR (10),
    pr_fecha_hasta  VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_proyeccion_caja') IS NOT NULL
    DROP TABLE dbo.ca_proyeccion_caja
GO

CREATE TABLE dbo.ca_proyeccion_caja
    (
    pc_fecha_desde  DATETIME NOT NULL,
    pc_fecha_hasta  DATETIME NOT NULL,
    pc_modulo       CHAR (3) NOT NULL,
    pc_fecha_diaria DATETIME NOT NULL,
    pc_moneda       SMALLINT NOT NULL,
    pc_saldo_cap    MONEY NOT NULL,
    pc_saldo_int    MONEY NOT NULL,
    pc_saldo_otros  MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_prorroga_ts') IS NOT NULL
    DROP TABLE dbo.ca_prorroga_ts
GO

CREATE TABLE dbo.ca_prorroga_ts
    (
    prs_fecha_proceso_ts    DATETIME NOT NULL,
    prs_fecha_ts            DATETIME NOT NULL,
    prs_usuario_ts          login NOT NULL,
    prs_oficina_ts          SMALLINT NOT NULL,
    prs_terminal_ts         VARCHAR (30) NOT NULL,
    prs_tipo_transaccion_ts INT NOT NULL,
    prs_origen_ts           CHAR (1) NOT NULL,
    prs_clase_ts            CHAR (1) NOT NULL,
    prs_operacion           INT NOT NULL,
    prs_nro_cuota           SMALLINT NOT NULL,
    prs_fecha_proc          DATETIME NOT NULL,
    prs_fecha_venc_ini      DATETIME NOT NULL,
    prs_fecha_venc_pr       DATETIME NOT NULL,
    prs_usuario             login
    )
GO

IF OBJECT_ID ('dbo.ca_prorroga') IS NOT NULL
    DROP TABLE dbo.ca_prorroga
GO

CREATE TABLE dbo.ca_prorroga
    (
    pr_operacion      INT NOT NULL,
    pr_nro_cuota      SMALLINT NOT NULL,
    pr_fecha_proc     DATETIME NOT NULL,
    pr_fecha_venc_ini DATETIME NOT NULL,
    pr_fecha_venc_pr  DATETIME NOT NULL,
    pr_usuario        login
    )
GO

CREATE INDEX ca_prorroga_1
    ON dbo.ca_prorroga (pr_operacion, pr_nro_cuota)
GO

IF OBJECT_ID ('dbo.ca_producto_ts') IS NOT NULL
    DROP TABLE dbo.ca_producto_ts
GO

CREATE TABLE dbo.ca_producto_ts
    (
    cps_fecha_proceso_ts    DATETIME NOT NULL,
    cps_fecha_ts            DATETIME NOT NULL,
    cps_usuario_ts          login NOT NULL,
    cps_oficina_ts          SMALLINT NOT NULL,
    cps_terminal_ts         VARCHAR (30) NOT NULL,
    cps_operacion_ts        CHAR (1) NOT NULL,
    cps_producto_ts         catalogo NOT NULL,
    cps_descripcion_ts      descripcion NOT NULL,
    cps_categoria_ts        catalogo NOT NULL,
    cps_moneda_ts           TINYINT,
    cps_codvalor_ts         SMALLINT NOT NULL,
    cps_desembolso_ts       CHAR (1) NOT NULL,
    cps_pago_ts             CHAR (1) NOT NULL,
    cps_atx_ts              CHAR (1) NOT NULL,
    cps_retencion_ts        TINYINT NOT NULL,
    cps_pago_aut_ts         CHAR (1) NOT NULL,
    cps_pcobis_ts           TINYINT,
    cps_producto_reversa_ts catalogo,
    cps_afectacion_ts       CHAR (1),
    cps_estado_ts           CHAR (1),
    cps_act_pas_ts          CHAR (2),
    cps_instrum_SB          INT,
    cps_canal               catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_producto_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_producto_bancamia
GO

CREATE TABLE dbo.ca_producto_bancamia
    (
    cp_producto         catalogo NOT NULL,
    cp_descripcion      descripcion NOT NULL,
    cp_categoria        catalogo NOT NULL,
    cp_moneda           TINYINT NOT NULL,
    cp_codvalor         SMALLINT NOT NULL,
    cp_desembolso       CHAR (1) NOT NULL,
    cp_pago             CHAR (1) NOT NULL,
    cp_atx              CHAR (1) NOT NULL,
    cp_retencion        TINYINT NOT NULL,
    cp_pago_aut         CHAR (1) NOT NULL,
    cp_pcobis           TINYINT,
    cp_producto_reversa catalogo,
    cp_afectacion       CHAR (1),
    cp_estado           CHAR (1) NOT NULL,
    cp_act_pas          CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_producto') IS NOT NULL
    DROP TABLE dbo.ca_producto
GO

CREATE TABLE dbo.ca_producto
    (
    cp_producto         catalogo NOT NULL,
    cp_descripcion      descripcion NOT NULL,
    cp_categoria        catalogo NOT NULL,
    cp_moneda           TINYINT,
    cp_codvalor         SMALLINT NOT NULL,
    cp_desembolso       CHAR (1) NOT NULL,
    cp_pago             CHAR (1) NOT NULL,
    cp_atx              CHAR (1) NOT NULL,
    cp_retencion        TINYINT NOT NULL,
    cp_pago_aut         CHAR (1) NOT NULL,
    cp_pcobis           TINYINT,
    cp_producto_reversa catalogo,
    cp_afectacion       CHAR (1),
    cp_estado           CHAR (1),
    cp_act_pas          CHAR (1),
    cp_instrum_SB       INT,
    cp_canal            catalogo,
    CONSTRAINT PK_ca_producto PRIMARY KEY (cp_producto)
    WITH (FILLFACTOR = 85)
    )
GO

IF OBJECT_ID ('dbo.ca_procesos_contacar_tmp') IS NOT NULL
    DROP TABLE dbo.ca_procesos_contacar_tmp
GO

CREATE TABLE dbo.ca_procesos_contacar_tmp
    (
    proceso       INT NOT NULL,
    estado        CHAR (1) NOT NULL,
    operacion_ini INT NOT NULL,
    operacion_fin INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_procesos_consolidador_tmp') IS NOT NULL
    DROP TABLE dbo.ca_procesos_consolidador_tmp
GO

CREATE TABLE dbo.ca_procesos_consolidador_tmp
    (
    proceso       INT,
    estado        CHAR (1),
    operacion_ini INT,
    operacion_fin INT
    )
GO

IF OBJECT_ID ('dbo.ca_procesos_buserror_tmp') IS NOT NULL
    DROP TABLE dbo.ca_procesos_buserror_tmp
GO

CREATE TABLE dbo.ca_procesos_buserror_tmp
    (
    proceso       INT NOT NULL,
    estado        CHAR (1) NOT NULL,
    operacion_ini INT NOT NULL,
    operacion_fin INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_proc_cam_linea_finagro_copy') IS NOT NULL
    DROP TABLE dbo.ca_proc_cam_linea_finagro_copy
GO

CREATE TABLE dbo.ca_proc_cam_linea_finagro_copy
    (
    pc_archivo        VARCHAR (50),
    pc_tipo_ide       catalogo,
    pc_identificacion VARCHAR (30),
    pc_banco_cobis    VARCHAR (20),
    pc_linea_origen   catalogo,
    pc_linea_destino  catalogo,
    pc_tramite        INT,
    pc_fecha_proc     DATETIME,
    pc_estado         CHAR (1),
    pc_reverso_pagos  SMALLINT,
    pc_reverso_desem  SMALLINT,
    pc_retirar_gar    SMALLINT,
    pc_cambio_linea   SMALLINT,
    pc_desembolso     SMALLINT,
    pc_aplica_pagos   SMALLINT,
    pc_monto_comision MONEY,
    pc_iva_comision   MONEY
    )
GO

CREATE INDEX idx1
    ON dbo.ca_proc_cam_linea_finagro_copy (pc_archivo, pc_banco_cobis)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_proc_cam_linea_finagro') IS NOT NULL
    DROP TABLE dbo.ca_proc_cam_linea_finagro
GO

CREATE TABLE dbo.ca_proc_cam_linea_finagro
    (
    pc_archivo        VARCHAR (50),
    pc_tipo_ide       catalogo,
    pc_identificacion VARCHAR (30),
    pc_banco_cobis    VARCHAR (20),
    pc_linea_origen   catalogo,
    pc_linea_destino  catalogo,
    pc_tramite        INT,
    pc_fecha_proc     DATETIME,
    pc_estado         CHAR (1),
    pc_reverso_pagos  SMALLINT,
    pc_reverso_desem  SMALLINT,
    pc_retirar_gar    SMALLINT,
    pc_cambio_linea   SMALLINT,
    pc_desembolso     SMALLINT,
    pc_aplica_pagos   SMALLINT,
    pc_monto_comision MONEY,
    pc_iva_comision   MONEY
    )
GO

CREATE INDEX idx1
    ON dbo.ca_proc_cam_linea_finagro (pc_archivo, pc_banco_cobis)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_prestamo_pagos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_prestamo_pagos_tmp
GO

CREATE TABLE dbo.ca_prestamo_pagos_tmp
    (
    rubro         VARCHAR (20) NOT NULL,
    vencido       MONEY NOT NULL,
    vigente       MONEY NOT NULL,
    proyectado    MONEY NOT NULL,
    total_x_rubro MONEY NOT NULL,
    operacion_pag INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_prepas_dobles') IS NOT NULL
    DROP TABLE dbo.ca_prepas_dobles
GO

CREATE TABLE dbo.ca_prepas_dobles
    (
    banco_pas     cuenta,
    fecha         DATETIME,
    valor_prepago MONEY,
    dias_int      INT,
    saldo_int     MONEY,
    cuantos       INT
    )
GO

IF OBJECT_ID ('dbo.ca_prepagos_por_reversos') IS NOT NULL
    DROP TABLE dbo.ca_prepagos_por_reversos
GO

CREATE TABLE dbo.ca_prepagos_por_reversos
    (
    pr_fecha_cierre_rev DATETIME,
    pr_fecha_de_pago    DATETIME,
    pr_operacion_activa INT,
    pr_secuencial_pag   INT,
    pr_usuario          login
    )
GO

IF OBJECT_ID ('dbo.ca_prepagos_pasivas') IS NOT NULL
    DROP TABLE dbo.ca_prepagos_pasivas
GO

CREATE TABLE dbo.ca_prepagos_pasivas
    (
    pp_secuencial           INT NOT NULL,
    pp_oficina              INT NOT NULL,
    pp_linea                catalogo NOT NULL,
    pp_codigo_prepago       catalogo NOT NULL,
    pp_banco                cuenta NOT NULL,
    pp_identificacion       cuenta NOT NULL,
    pp_nombre               VARCHAR (35) NOT NULL,
    pp_llave_redescuento    cuenta NOT NULL,
    pp_tramite              INT NOT NULL,
    pp_cliente              INT NOT NULL,
    pp_valor_prepago        MONEY NOT NULL,
    pp_saldo_capital        MONEY NOT NULL,
    pp_monto_desembolso     MONEY NOT NULL,
    pp_fecha_desemboslo     DATETIME NOT NULL,
    pp_saldo_intereses      MONEY NOT NULL,
    pp_fecha_generacion     DATETIME NOT NULL,
    pp_estado_registro      CHAR (1) NOT NULL,
    pp_estado_aplicar       CHAR (1) NOT NULL,
    pp_fecha_aplicar        DATETIME NOT NULL,
    pp_moneda               SMALLINT NOT NULL,
    pp_tasa                 FLOAT NOT NULL,
    pp_dias_de_interes      INT NOT NULL,
    pp_fecha_int_desde      DATETIME NOT NULL,
    pp_fecha_int_hasta      DATETIME NOT NULL,
    pp_formula_tasa         cuenta NOT NULL,
    pp_secuencial_ing       INT NOT NULL,
    pp_tipo_reduccion       CHAR (1) NOT NULL,
    pp_tipo_novedad         CHAR (1) NOT NULL,
    pp_abono_extraordinario CHAR (1) NOT NULL,
    pp_tipo_aplicacion      CHAR (1) NOT NULL,
    pp_comentario           descripcion,
    pp_causal_rechazo       catalogo,
    pp_sec_pagoactiva       INT,
    pp_cotizacion           FLOAT
    )
GO

CREATE UNIQUE INDEX ca_prepagos_pasivas_1
    ON dbo.ca_prepagos_pasivas (pp_banco, pp_secuencial)
GO

CREATE INDEX ca_prepagos_pasivas_3
    ON dbo.ca_prepagos_pasivas (pp_tramite)
GO

CREATE INDEX ca_prepagos_pasivas_4
    ON dbo.ca_prepagos_pasivas (pp_fecha_generacion, pp_codigo_prepago, pp_secuencial)
GO

IF OBJECT_ID ('dbo.ca_pprepgospas_aplicados') IS NOT NULL
    DROP TABLE dbo.ca_pprepgospas_aplicados
GO

CREATE TABLE dbo.ca_pprepgospas_aplicados
    (
    pap_bsegundo_piso     catalogo,
    pap_banco             cuenta,
    pap_operacion         INT,
    pap_secuencial        INT,
    pap_identificacion    numero,
    pap_llave_redescuento cuenta,
    pap_fecha_cont        DATETIME,
    pap_fecha_mov         DATETIME,
    pap_concepto          catalogo,
    pap_estado            catalogo,
    pap_toperacion        catalogo,
    pap_ofi_oper          INT,
    pap_ofi_usu           INT,
    pap_usuario           login,
    pap_monto_cap         MONEY,
    pap_monto_int         MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_planos_baloto') IS NOT NULL
    DROP TABLE dbo.ca_planos_baloto
GO

CREATE TABLE dbo.ca_planos_baloto
    (
    s   VARCHAR (255) NOT NULL,
    pie CHAR (2),
    sec INT IDENTITY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_planoBancoldexJustifica_33') IS NOT NULL
    DROP TABLE dbo.ca_planoBancoldexJustifica_33
GO

CREATE TABLE dbo.ca_planoBancoldexJustifica_33
    (
    pbj_nombre            VARCHAR (50),
    pbj_tipo_doc          CHAR (1),
    pbj_numero_doc        VARCHAR (11),
    pbj_tipo_sociedad     VARCHAR (2),
    pbj_direccion         VARCHAR (50),
    pbj_telefono          VARCHAR (15),
    pbj_ciudad            VARCHAR (5),
    pbj_ciu               VARCHAR (5),
    pbj_empleos_act       VARCHAR (3),
    pbj_empleos_generar   VARCHAR (3),
    pbj_activos           VARCHAR (11),
    pbj_fecha_corte_act   VARCHAR (4),
    pbj_num_obligacion    VARCHAR (12),
    pbj_valor_credito     VARCHAR (11),
    pbj_fecha_desembolso  VARCHAR (8),
    pbj_fecha_vencimiento VARCHAR (8),
    pbj_periodo_gracia    VARCHAR (3),
    pbj_amortizacion      CHAR (1),
    pbj_tasa_interes      VARCHAR (5),
    pbj_margen            VARCHAR (5),
    pbj_saldo_credito     VARCHAR (11),
    pbj_destino1          CHAR (1),
    pbj_monto_destino1    VARCHAR (11),
    pbj_destino2          CHAR (1),
    pbj_monto_destino2    VARCHAR (11),
    pbj_destino3          CHAR (1),
    pbj_monto_destino3    VARCHAR (11),
    pbj_clase_garan_1     VARCHAR (2),
    pbj_valor_garan_1     VARCHAR (11),
    pbj_clase_garan_2     VARCHAR (2),
    pbj_valor_garan_2     VARCHAR (11),
    pbj_clase_garan_3     VARCHAR (2),
    pbj_valor_garan_3     VARCHAR (11)
    )
GO

IF OBJECT_ID ('dbo.ca_planoBancoldexJustifica') IS NOT NULL
    DROP TABLE dbo.ca_planoBancoldexJustifica
GO

CREATE TABLE dbo.ca_planoBancoldexJustifica
    (
    pbj_nombre            VARCHAR (50),
    pbj_tipo_doc          CHAR (1),
    pbj_numero_doc        VARCHAR (11),
    pbj_tipo_sociedad     VARCHAR (2),
    pbj_direccion         VARCHAR (50),
    pbj_telefono          VARCHAR (15),
    pbj_ciudad            VARCHAR (5),
    pbj_ciu               VARCHAR (5),
    pbj_empleos_act       VARCHAR (3),
    pbj_empleos_generar   VARCHAR (3),
    pbj_activos           VARCHAR (11),
    pbj_fecha_corte_act   VARCHAR (4),
    pbj_num_obligacion    VARCHAR (12),
    pbj_valor_credito     VARCHAR (11),
    pbj_fecha_desembolso  VARCHAR (8),
    pbj_fecha_vencimiento VARCHAR (8),
    pbj_periodo_gracia    VARCHAR (3),
    pbj_amortizacion      CHAR (1),
    pbj_tasa_interes      VARCHAR (5),
    pbj_margen            VARCHAR (5),
    pbj_saldo_credito     VARCHAR (11),
    pbj_destino1          CHAR (1),
    pbj_monto_destino1    VARCHAR (11),
    pbj_destino2          CHAR (1),
    pbj_monto_destino2    VARCHAR (11),
    pbj_destino3          CHAR (1),
    pbj_monto_destino3    VARCHAR (11),
    pbj_clase_garan_1     VARCHAR (2),
    pbj_valor_garan_1     VARCHAR (11),
    pbj_clase_garan_2     VARCHAR (2),
    pbj_valor_garan_2     VARCHAR (11),
    pbj_clase_garan_3     VARCHAR (2),
    pbj_valor_garan_3     VARCHAR (11),
    pbj_destino_AECI      VARCHAR (2),
    pbj_genero            CHAR (1),
    pbj_fecha_nacimiento  VARCHAR (8),
    pbj_escolaridad       VARCHAR (2)
    )
GO

IF OBJECT_ID ('dbo.ca_planobancoldex') IS NOT NULL
    DROP TABLE dbo.ca_planobancoldex
GO

CREATE TABLE dbo.ca_planobancoldex
    (
    dato VARCHAR (600)
    )
GO

IF OBJECT_ID ('dbo.ca_plano_ors_959_msg_texto') IS NOT NULL
    DROP TABLE dbo.ca_plano_ors_959_msg_texto
GO

CREATE TABLE dbo.ca_plano_ors_959_msg_texto
    (
    CodCliente     INT,
    TipoIdentifica catalogo,
    Identificacion CHAR (20),
    Celular1       CHAR (20),
    Celular2       CHAR (20),
    Nombres        VARCHAR (45),
    Apellidos      VARCHAR (55),
    NroDiaMora     INT,
    Mensaje        VARCHAR (160)
    )
GO

IF OBJECT_ID ('dbo.ca_plano_ors_959_cabecera') IS NOT NULL
    DROP TABLE dbo.ca_plano_ors_959_cabecera
GO

CREATE TABLE dbo.ca_plano_ors_959_cabecera
    (
    cab_1 CHAR (16),
    cab_2 CHAR (16),
    cab_3 CHAR (16),
    cab_4 CHAR (16),
    cab_5 CHAR (16),
    cab_6 CHAR (16),
    cab_7 CHAR (16),
    cab_8 CHAR (16),
    cab_9 CHAR (16)
    )
GO

IF OBJECT_ID ('dbo.ca_plano_mensual') IS NOT NULL
    DROP TABLE dbo.ca_plano_mensual
GO

CREATE TABLE dbo.ca_plano_mensual
    (
    pm_nit_bac           VARCHAR (15) NOT NULL,
    pm_nombre_bac        VARCHAR (35) NOT NULL,
    pm_reposa1           VARCHAR (19) NOT NULL,
    pm_grupo             INT NOT NULL,
    pm_reposa2           VARCHAR (15) NOT NULL,
    pm_sucursal          INT NOT NULL,
    pm_linea_norlegal    VARCHAR (4) NOT NULL,
    pm_oper_llave_redes  VARCHAR (24) NOT NULL,
    pm_identificacion    VARCHAR (15) NOT NULL,
    pm_nombre            VARCHAR (35) NOT NULL,
    pm_valor_saldo_redes MONEY NOT NULL,
    pm_formula_tasa      VARCHAR (12) NOT NULL,
    pm_modalidad         CHAR (1) NOT NULL,
    pm_tasa_nom          FLOAT NOT NULL,
    pm_valor_int         MONEY NOT NULL,
    pm_fecha_prox_ven    VARCHAR (8) NOT NULL,
    pm_suc_bco_republica INT NOT NULL,
    pm_fecha_redes       VARCHAR (8) NOT NULL,
    pm_nro_redes         INT NOT NULL,
    pm_fecha_proceso     DATETIME,
    pm_mz                CHAR (1)
    )
GO

CREATE INDEX ca_plano_mensual_Key
    ON dbo.ca_plano_mensual (pm_oper_llave_redes, pm_identificacion)
GO

IF OBJECT_ID ('dbo.ca_plano_dia_findeter') IS NOT NULL
    DROP TABLE dbo.ca_plano_dia_findeter
GO

CREATE TABLE dbo.ca_plano_dia_findeter
    (
    pf_num_oper_findeter cuenta,
    pf_beneficiario      CHAR (30),
    pf_departamento      CHAR (20),
    pf_pagare            CHAR (64),
    pf_saldo_capital     MONEY,
    pf_valor_capital     MONEY,
    pf_fecha_desde       DATETIME,
    pf_fecha_hasta       DATETIME,
    pf_dias              INT,
    pf_modalida_pago     CHAR (5),
    pf_tasa_redes        CHAR (20),
    pf_tasa              FLOAT,
    pf_valor_interes     MONEY,
    pf_neto_pagar        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_plano_dia_bancoldex') IS NOT NULL
    DROP TABLE dbo.ca_plano_dia_bancoldex
GO

CREATE TABLE dbo.ca_plano_dia_bancoldex
    (
    pb_linea              cuenta,
    pb_num_oper_bancoldex cuenta,
    pb_ciudad             INT,
    pb_beneficiario       CHAR (30),
    pb_ref_externa        cuenta,
    pb_saldo_capital      MONEY,
    pb_tasa               FLOAT,
    pb_dias               INT,
    pb_valor_interes      MONEY,
    pb_valor_capital      MONEY,
    pb_valor_mora         MONEY,
    pb_neto_pagar         MONEY
    )
GO

CREATE INDEX ca_plano_dia_bancoldex_1
    ON dbo.ca_plano_dia_bancoldex (pb_num_oper_bancoldex)
GO

IF OBJECT_ID ('dbo.ca_plano_cancelads_x_ofi') IS NOT NULL
    DROP TABLE dbo.ca_plano_cancelads_x_ofi
GO

CREATE TABLE dbo.ca_plano_cancelads_x_ofi
    (
    COD_OFICINA    INT,
    NOMBRE_OFI     VARCHAR (64),
    NRO_OBLIGACION cuenta,
    CED_CLIENTE    VARCHAR (30),
    NOMBRE_CLIENTE VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_plano_banco_segundo_piso') IS NOT NULL
    DROP TABLE dbo.ca_plano_banco_segundo_piso
GO

CREATE TABLE dbo.ca_plano_banco_segundo_piso
    (
    bs_registro            VARCHAR (1) NOT NULL,
    bs_fecha_pago          VARCHAR (8) NOT NULL,
    bs_grupo               VARCHAR (2) NOT NULL,
    bs_nit                 VARCHAR (15) NOT NULL,
    bs_modalidad           CHAR (1) NOT NULL,
    bs_fecha_vencimiento   VARCHAR (8) NOT NULL,
    bs_sucursal            VARCHAR (3) NOT NULL,
    bs_linea_norlegal      VARCHAR (4) NOT NULL,
    bs_oper_llave_redes    cuenta NOT NULL,
    bs_identificacion      cuenta NOT NULL,
    bs_nombre              VARCHAR (35) NOT NULL,
    bs_valor_saldo_antes   MONEY NOT NULL,
    bs_abono_capital       MONEY NOT NULL,
    bs_valor_saldo_despues MONEY NOT NULL,
    bs_fecha_ini_int       VARCHAR (8) NOT NULL,
    bs_fecha_ven_int       VARCHAR (8) NOT NULL,
    bs_dias_int            INT NOT NULL,
    bs_formula_tasa        VARCHAR (15) NOT NULL,
    bs_tasa_nom            FLOAT NOT NULL,
    bs_valor_int           MONEY NOT NULL,
    bs_valor_pagar         MONEY NOT NULL,
    bs_residuo             VARCHAR (51) NOT NULL,
    bs_fecha_redescuento   VARCHAR (8),
    bs_z2                  CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_plano_banco_2piso_his') IS NOT NULL
    DROP TABLE dbo.ca_plano_banco_2piso_his
GO

CREATE TABLE dbo.ca_plano_banco_2piso_his
    (
    bsh_registro            VARCHAR (1) NOT NULL,
    bsh_fecha_pago          VARCHAR (8) NOT NULL,
    bsh_grupo               VARCHAR (2) NOT NULL,
    bsh_nit                 VARCHAR (15) NOT NULL,
    bsh_modalidad           CHAR (1) NOT NULL,
    bsh_fecha_vencimiento   VARCHAR (8) NOT NULL,
    bsh_sucursal            VARCHAR (3) NOT NULL,
    bsh_linea_norlegal      VARCHAR (4) NOT NULL,
    bsh_oper_llave_redes    cuenta NOT NULL,
    bsh_identificacion      cuenta NOT NULL,
    bsh_nombre              VARCHAR (35) NOT NULL,
    bsh_valor_saldo_antes   MONEY NOT NULL,
    bsh_abono_capital       MONEY NOT NULL,
    bsh_valor_saldo_despues MONEY NOT NULL,
    bsh_fecha_ini_int       VARCHAR (8) NOT NULL,
    bsh_fecha_ven_int       VARCHAR (8) NOT NULL,
    bsh_dias_int            INT NOT NULL,
    bsh_formula_tasa        VARCHAR (15) NOT NULL,
    bsh_tasa_nom            FLOAT NOT NULL,
    bsh_valor_int           MONEY NOT NULL,
    bsh_valor_pagar         MONEY NOT NULL,
    bsh_residuo             VARCHAR (51) NOT NULL,
    bsh_fecha_redescuento   VARCHAR (8),
    bsh_z2                  CHAR (1),
    bsh_llave               CHAR (5)
    )
GO

IF OBJECT_ID ('dbo.ca_path_adminfo') IS NOT NULL
    DROP TABLE dbo.ca_path_adminfo
GO

CREATE TABLE dbo.ca_path_adminfo
    (
    pa_ruta_archivo VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_pasivas_cobro_juridico') IS NOT NULL
    DROP TABLE dbo.ca_pasivas_cobro_juridico
GO

CREATE TABLE dbo.ca_pasivas_cobro_juridico
    (
    pcj_operacion INT NOT NULL,
    pcj_fecha     DATETIME NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_param_condona_ts') IS NOT NULL
    DROP TABLE dbo.ca_param_condona_ts
GO

CREATE TABLE dbo.ca_param_condona_ts
    (
    pcs_fecha_proceso_ts     DATETIME NOT NULL,
    pcs_fecha_ts             DATETIME NOT NULL,
    pcs_usuario_ts           login NOT NULL,
    pcs_oficina_ts           SMALLINT NOT NULL,
    pcs_terminal_ts          VARCHAR (30) NOT NULL,
    pcs_operacion_ts         CHAR (1) NOT NULL,
    pcs_codigo               SMALLINT NOT NULL,
    pcs_estado               TINYINT NOT NULL,
    pcs_banca                TINYINT NOT NULL,
    pcs_rubro                catalogo NOT NULL,
    pcs_mora_inicial         SMALLINT,
    pcs_mora_final           SMALLINT,
    pcs_ano_castigo          INT,
    pcs_porcentaje_max       FLOAT NOT NULL,
    pcs_valor_maximo         MONEY NOT NULL,
    pcs_valores_vigentes     CHAR (1),
    pcs_control_autorizacion CHAR (1),
    pcs_valores_noven        CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_param_condona_control') IS NOT NULL
    DROP TABLE dbo.ca_param_condona_control
GO

CREATE TABLE dbo.ca_param_condona_control
    (
    tabla  VARCHAR (20),
    estado VARCHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_param_condona') IS NOT NULL
    DROP TABLE dbo.ca_param_condona
GO

CREATE TABLE dbo.ca_param_condona
    (
    pc_codigo               SMALLINT NOT NULL,
    pc_estado               TINYINT NOT NULL,
    pc_banca                TINYINT NOT NULL,
    pc_rubro                catalogo NOT NULL,
    pc_mora_inicial         SMALLINT,
    pc_mora_final           SMALLINT,
    pc_ano_castigo          INT,
    pc_porcentaje_max       FLOAT NOT NULL,
    pc_valor_maximo         MONEY NOT NULL,
    pc_valores_vigentes     CHAR (1),
    pc_control_autorizacion CHAR (1),
    pc_valores_noven        CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_paralelo_tmp') IS NOT NULL
    DROP TABLE dbo.ca_paralelo_tmp
GO

CREATE TABLE dbo.ca_paralelo_tmp
    (
    programa      catalogo,
    proceso       INT NOT NULL,
    estado        CHAR (1) NOT NULL,
    operacion_ini INT NOT NULL,
    operacion_fin INT NOT NULL,
    spid          INT,
    hostprocess   CHAR (8),
    hora          DATETIME,
    reintentos    INT,
    procesados    INT
    )
GO

CREATE INDEX ca_paralelo_tmp_I1
    ON dbo.ca_paralelo_tmp (proceso, programa)
GO

IF OBJECT_ID ('dbo.ca_pagosca_v_tmp') IS NOT NULL
    DROP TABLE dbo.ca_pagosca_v_tmp
GO

CREATE TABLE dbo.ca_pagosca_v_tmp
    (
    oficina_tran   INT NOT NULL,
    oficina_oper   INT NOT NULL,
    fecha_ing      VARCHAR (10) NOT NULL,
    secuencial_rpa INT NOT NULL,
    fecha_valor    VARCHAR (10) NOT NULL,
    banco          VARCHAR (24) NOT NULL,
    operacion      INT NOT NULL,
    t_prestamo     VARCHAR (10) NOT NULL,
    secuencial_apl INT NOT NULL,
    cuota          INT NOT NULL,
    concepto       VARCHAR (24) NOT NULL,
    ref_contable   INT NOT NULL,
    monto          MONEY NOT NULL,
    forma_pago     VARCHAR (10) NOT NULL
    )
GO

CREATE INDEX idx1
    ON dbo.ca_pagosca_v_tmp (fecha_ing)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_pagosca_h_tmp_bcp') IS NOT NULL
    DROP TABLE dbo.ca_pagosca_h_tmp_bcp
GO

CREATE TABLE dbo.ca_pagosca_h_tmp_bcp
    (
    banco             VARCHAR (24) NOT NULL,
    operacion         INT NOT NULL,
    fecha_ing         VARCHAR (10) NOT NULL,
    fecha_valor       VARCHAR (10) NOT NULL,
    t_prestamo        catalogo NOT NULL,
    forma_pago        catalogo NOT NULL,
    secuencial_apl    INT NOT NULL,
    capital           MONEY NOT NULL,
    interes           MONEY NOT NULL,
    mora              MONEY NOT NULL,
    mipymes           MONEY NOT NULL,
    iva_mipymes       MONEY NOT NULL,
    seguro            MONEY NOT NULL,
    otros             MONEY NOT NULL,
    monto_condonado   MONEY NOT NULL,
    subtotal          MONEY NOT NULL,
    honorario         MONEY NOT NULL,
    iva_honorario     MONEY NOT NULL,
    total             MONEY NOT NULL,
    abogado           VARCHAR (60) NOT NULL,
    estado            catalogo NOT NULL,
    porc_honorarios   FLOAT,
    sobrantes         MONEY,
    pago_total        MONEY,
    pago_sin_hon_cond MONEY,
    cod_abogado       INT,
    iden_abogado      VARCHAR (32),
    regimen_abogado   CHAR (5),
    calificacion      CHAR (1),
    oficina_tramite   INT,
    est_cartera_act   SMALLINT,
    est_cartera_ant   SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_pagosca_h_tmp') IS NOT NULL
    DROP TABLE dbo.ca_pagosca_h_tmp
GO

CREATE TABLE dbo.ca_pagosca_h_tmp
    (
    banco             VARCHAR (24) NOT NULL,
    operacion         INT NOT NULL,
    fecha_ing         VARCHAR (10) NOT NULL,
    fecha_valor       VARCHAR (10) NOT NULL,
    t_prestamo        catalogo NOT NULL,
    forma_pago        catalogo NOT NULL,
    secuencial_apl    INT NOT NULL,
    capital           MONEY NOT NULL,
    interes           MONEY NOT NULL,
    mora              MONEY NOT NULL,
    mipymes           MONEY NOT NULL,
    iva_mipymes       MONEY NOT NULL,
    seguro            MONEY NOT NULL,
    otros             MONEY NOT NULL,
    monto_condonado   MONEY NOT NULL,
    subtotal          MONEY NOT NULL,
    honorario         MONEY NOT NULL,
    iva_honorario     MONEY NOT NULL,
    total             MONEY NOT NULL,
    abogado           VARCHAR (60) NOT NULL,
    estado            catalogo NOT NULL,
    porc_honorarios   FLOAT,
    sobrantes         MONEY,
    pago_total        MONEY,
    pago_sin_hon_cond MONEY,
    cod_abogado       INT,
    iden_abogado      VARCHAR (32),
    regimen_abogado   CHAR (5),
    calificacion      CHAR (1),
    oficina_tramite   INT,
    est_cartera_act   SMALLINT,
    est_cartera_ant   SMALLINT
    )
GO

CREATE INDEX idx1
    ON dbo.ca_pagosca_h_tmp (operacion, secuencial_apl)
GO

CREATE INDEX idx2
    ON dbo.ca_pagosca_h_tmp (banco)
GO

CREATE INDEX idx3
    ON dbo.ca_pagosca_h_tmp (cod_abogado)
GO

IF OBJECT_ID ('dbo.ca_pagos_sicredito') IS NOT NULL
    DROP TABLE dbo.ca_pagos_sicredito
GO

CREATE TABLE dbo.ca_pagos_sicredito
    (
    ps_cedula  VARCHAR (30) NOT NULL,
    ps_banco   cuenta NOT NULL,
    ps_oficina INT NOT NULL,
    ps_valor   MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_saldos_minimos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_pagos_saldos_minimos_tmp
GO

CREATE TABLE dbo.ca_pagos_saldos_minimos_tmp
    (
    banco     cuenta,
    operacion INT,
    dividendo SMALLINT,
    fecha_ven DATETIME,
    debe      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_procredito') IS NOT NULL
    DROP TABLE dbo.ca_pagos_procredito
GO

CREATE TABLE dbo.ca_pagos_procredito
    (
    pc_pago             VARCHAR (10) NOT NULL,
    pc_operacion        VARCHAR (16) NOT NULL,
    pc_identificacion   VARCHAR (16) NOT NULL,
    pc_fecha_desbloqueo DATETIME NOT NULL,
    pc_valor_desbloqueo MONEY NOT NULL,
    pc_valor_iva        MONEY NOT NULL,
    pc_estado           VARCHAR (1) NOT NULL,
    pc_fecha_reverso    DATETIME,
    pc_tipo_credito     VARCHAR (1),
    pc_usuario          VARCHAR (16)
    )
GO

CREATE INDEX ca_pagos_procredito_1
    ON dbo.ca_pagos_procredito (pc_operacion, pc_identificacion)
GO

IF OBJECT_ID ('dbo.ca_pagos_mig') IS NOT NULL
    DROP TABLE dbo.ca_pagos_mig
GO

CREATE TABLE dbo.ca_pagos_mig
    (
    pa_operacion  VARCHAR (24) NOT NULL,
    pa_fecha_pago DATETIME NOT NULL,
    pa_monto      MONEY NOT NULL,
    pa_monto_int  MONEY NOT NULL,
    pa_moneda     INT NOT NULL,
    pa_cotizacion FLOAT NOT NULL,
    pa_formapag   VARCHAR (20) NOT NULL,
    pa_numero     INT
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_ing_eventual') IS NOT NULL
    DROP TABLE dbo.ca_pagos_ing_eventual
GO

CREATE TABLE dbo.ca_pagos_ing_eventual
    (
    fecha_pago VARCHAR (10),
    oficina    VARCHAR (24),
    cedula     VARCHAR (24),
    banco      VARCHAR (24),
    forma_pago VARCHAR (10),
    valor_pago MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_fng') IS NOT NULL
    DROP TABLE dbo.ca_pagos_fng
GO

CREATE TABLE dbo.ca_pagos_fng
    (
    pf_num_operacion   VARCHAR (24) NOT NULL,
    pf_nombre_cliente  VARCHAR (255),
    pf_identificacion  VARCHAR (30),
    pf_fecha_abono_fng DATETIME,
    pf_monto_op_fng    MONEY,
    pf_total_pagos_fng MONEY,
    pf_saldos_fng      MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_caja_mbs') IS NOT NULL
    DROP TABLE dbo.ca_pagos_caja_mbs
GO

CREATE TABLE dbo.ca_pagos_caja_mbs
    (
    pc_archivo   VARCHAR (30),
    pc_fecha_ing DATETIME,
    pc_banco     cuenta,
    pc_monto     MONEY,
    pc_forma     CHAR (1),
    pc_ofipag    SMALLINT,
    pc_sec_ing   INT
    )
GO

IF OBJECT_ID ('dbo.ca_pagos_caja') IS NOT NULL
    DROP TABLE dbo.ca_pagos_caja
GO

CREATE TABLE dbo.ca_pagos_caja
    (
    oficina     SMALLINT,
    obligacion  cuenta,
    nombre      VARCHAR (255),
    cedula      VARCHAR (64),
    efectivo    MONEY,
    cheque      MONEY,
    nota_debito MONEY,
    sobrante    MONEY,
    estado_pag  CHAR (4),
    fecha_pag   VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_pago_recono') IS NOT NULL
    DROP TABLE dbo.ca_pago_recono
GO

CREATE TABLE dbo.ca_pago_recono
    (
    pr_operacion      INT NOT NULL,
    pr_banco          cuenta NOT NULL,
    pr_trn            INT NOT NULL,
    pr_fecha          DATETIME NOT NULL,
    pr_fecha_ult_pago DATETIME NOT NULL,
    pr_vlr            MONEY NOT NULL,
    pr_vlr_amort      MONEY NOT NULL,
    pr_estado         CHAR (1) NOT NULL,
    pr_tipo_gar       VARCHAR (30) NOT NULL,
    pr_subtipo_gar    VARCHAR (30) NOT NULL,
    pr_3nivel_gar     VARCHAR (255) NOT NULL,
    pr_vlr_calc_fijo  MONEY NOT NULL,
    pr_div_pend       SMALLINT NOT NULL,
    pr_div_venc       INT
    )
GO

CREATE CLUSTERED INDEX ca_pago_recono_Key
    ON dbo.ca_pago_recono (pr_operacion)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_pago_planificador_ts') IS NOT NULL
    DROP TABLE dbo.ca_pago_planificador_ts
GO

CREATE TABLE dbo.ca_pago_planificador_ts
    (
    pps_operacion         INT NOT NULL,
    pps_secuencial_des    INT NOT NULL,
    pps_tipo_planificador catalogo NOT NULL,
    pps_ente_planificador INT NOT NULL,
    pps_monto             MONEY NOT NULL,
    pps_forma_pago        catalogo NOT NULL,
    pps_referencia        cuenta NOT NULL,
    pps_concepto_cca      catalogo NOT NULL,
    pps_estado            CHAR (1) NOT NULL,
    pps_usuario           login NOT NULL,
    pps_terminal          VARCHAR (30) NOT NULL,
    pps_fecha             VARCHAR (30) NOT NULL,
    pps_cuenta_sidac      INT NOT NULL,
    pps_cuenta_sidac_aux  INT NOT NULL,
    pps_accion            CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_pago_planificador_tmp') IS NOT NULL
    DROP TABLE dbo.ca_pago_planificador_tmp
GO

CREATE TABLE dbo.ca_pago_planificador_tmp
    (
    ppt_usuario           login NOT NULL,
    ppt_operacion         INT NOT NULL,
    ppt_secuencial_des    INT NOT NULL,
    ppt_ente_planificador INT NOT NULL,
    ppt_monto             MONEY NOT NULL,
    ppt_forma_pago        catalogo NOT NULL,
    ppt_referencia        cuenta NOT NULL,
    ppt_concepto_cca      catalogo NOT NULL,
    ppt_porcentaje        FLOAT NOT NULL,
    ppt_cuenta_sidac      INT NOT NULL,
    ppt_cuenta_sidac_aux  INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_pago_planificador') IS NOT NULL
    DROP TABLE dbo.ca_pago_planificador
GO

CREATE TABLE dbo.ca_pago_planificador
    (
    pp_operacion         INT NOT NULL,
    pp_secuencial_des    INT NOT NULL,
    pp_tipo_planificador catalogo NOT NULL,
    pp_ente_planificador INT NOT NULL,
    pp_monto             MONEY NOT NULL,
    pp_forma_pago        catalogo NOT NULL,
    pp_referencia        cuenta NOT NULL,
    pp_concepto_cca      catalogo NOT NULL,
    pp_cuenta_sidac      INT NOT NULL,
    pp_cuenta_sidac_aux  INT NOT NULL,
    pp_estado            CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_paginac') IS NOT NULL
    DROP TABLE dbo.ca_paginac
GO

CREATE TABLE dbo.ca_paginac
    (
    pi_operacion  INT NOT NULL,
    pi_banco      cuenta NOT NULL,
    pi_ctabanco   cuenta NOT NULL,
    pi_cuenta     INT NOT NULL,
    pi_cliente    INT NOT NULL,
    pi_fecha      DATETIME NOT NULL,
    pi_vlr        MONEY NOT NULL,
    pi_est_cob    catalogo NOT NULL,
    pi_sec_ing    INT NOT NULL,
    pi_estado     CHAR (1) NOT NULL,
    pi_error      INT NOT NULL,
    pi_desc_error VARCHAR (100) NOT NULL
    )
GO

CREATE CLUSTERED INDEX ca_paginac_Key
    ON dbo.ca_paginac (pi_fecha, pi_cliente, pi_ctabanco)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_pag_masivos_temp') IS NOT NULL
    DROP TABLE dbo.ca_pag_masivos_temp
GO

CREATE TABLE dbo.ca_pag_masivos_temp
    (
    mg_nro_credito        cuenta,
    mg_fecha_cargue       DATETIME,
    mg_forma_pago         catalogo,
    mg_tipo_aplicacion    CHAR (1),
    mg_tipo_reduccion     CHAR (1),
    mg_monto_pago         MONEY,
    mg_prioridad_concepto catalogo,
    mg_oficina            INT,
    mg_cuenta             cuenta,
    mg_nro_control        INT,
    mg_tipo_trn           SMALLINT,
    mg_posicion_error     INT,
    mg_codigo_error       INT,
    mg_descripcion_error  VARCHAR (150),
    mg_secuencial_ing     INT,
    mg_moneda             SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_otro_cargo') IS NOT NULL
    DROP TABLE dbo.ca_otro_cargo
GO

CREATE TABLE dbo.ca_otro_cargo
    (
    oc_operacion      INT NOT NULL,
    oc_fecha          DATETIME NOT NULL,
    oc_secuencial     INT NOT NULL,
    oc_concepto       catalogo NOT NULL,
    oc_monto          MONEY NOT NULL,
    oc_referencia     descripcion,
    oc_usuario        login NOT NULL,
    oc_oficina        SMALLINT NOT NULL,
    oc_terminal       VARCHAR (20) NOT NULL,
    oc_estado         catalogo NOT NULL,
    oc_div_desde      SMALLINT,
    oc_div_hasta      SMALLINT,
    oc_base_calculo   MONEY,
    oc_secuencial_cxp INT
    )
GO

CREATE UNIQUE INDEX ca_otro_cargo_1
    ON dbo.ca_otro_cargo (oc_operacion, oc_secuencial)
GO

IF OBJECT_ID ('dbo.ca_otras_tasas_ts') IS NOT NULL
    DROP TABLE dbo.ca_otras_tasas_ts
GO

CREATE TABLE dbo.ca_otras_tasas_ts
    (
    ots_fecha_proceso_ts    DATETIME NOT NULL,
    ots_fecha_ts            DATETIME NOT NULL,
    ots_usuario_ts          login NOT NULL,
    ots_oficina_ts          SMALLINT NOT NULL,
    ots_terminal_ts         VARCHAR (30) NOT NULL,
    ots_tipo_transaccion_ts INT NOT NULL,
    ots_origen_ts           CHAR (1) NOT NULL,
    ots_clase_ts            CHAR (1) NOT NULL,
    ots_codigo              catalogo NOT NULL,
    ots_descripcion         descripcion NOT NULL,
    ots_valor               FLOAT NOT NULL,
    ots_categoria_rubro     CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_otras_tasas') IS NOT NULL
    DROP TABLE dbo.ca_otras_tasas
GO

CREATE TABLE dbo.ca_otras_tasas
    (
    ot_codigo          catalogo NOT NULL,
    ot_descripcion     descripcion NOT NULL,
    ot_valor           FLOAT NOT NULL,
    ot_categoria_rubro CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_opercaion_ndaut') IS NOT NULL
    DROP TABLE dbo.ca_opercaion_ndaut
GO

CREATE TABLE dbo.ca_opercaion_ndaut
    (
    ona_fecha_proceso    DATETIME NOT NULL,
    ona_operacion        INT NOT NULL,
    ona_numero_indicador SMALLINT,
    ona_proceso          VARCHAR (30)
    )
GO

CREATE INDEX ca_opercaion_ndaut_1
    ON dbo.ca_opercaion_ndaut (ona_fecha_proceso, ona_operacion)
GO

IF OBJECT_ID ('dbo.ca_operaciones_con_recono_tmp') IS NOT NULL
    DROP TABLE dbo.ca_operaciones_con_recono_tmp
GO

CREATE TABLE dbo.ca_operaciones_con_recono_tmp
    (
    rt_banco         cuenta,
    rt_operacion     INT,
    rt_forma_pago    catalogo,
    rt_feha_recono   DATETIME,
    rt_valor_recono  MONEY,
    rt_valor_amort   MONEY,
    rt_pago_x_recono CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_operacion_virtual') IS NOT NULL
    DROP TABLE dbo.ca_operacion_virtual
GO

CREATE TABLE dbo.ca_operacion_virtual
    (
    op_operacion         INT,
    op_banco             cuenta,
    op_cliente           INT,
    op_nombre            descripcion,
    op_toperacion        catalogo,
    op_moneda            TINYINT,
    op_fecha_ini         DATETIME,
    op_fecha_fin         DATETIME,
    op_fecha_liq         DATETIME,
    op_monto             MONEY,
    op_estado            INT,
    op_cuota_completa    CHAR (1),
    op_tipo_cobro        CHAR (1),
    op_tipo_reduccion    CHAR (1),
    op_aceptar_anticipos CHAR (1),
    op_precancelacion    CHAR (1),
    op_bvirtual          CHAR (1),
    op_tplazo            catalogo,
    op_plazo             SMALLINT
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_operacion_1
    ON dbo.ca_operacion_virtual (op_operacion)
GO

CREATE INDEX ca_operacion_2
    ON dbo.ca_operacion_virtual (op_banco)
GO

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
    ops_desplazamiento          int null    --SRO 140073
    )
GO

CREATE INDEX ca_operacion_ts_idx1
    ON dbo.ca_operacion_ts (ops_operacion)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_operacion_total') IS NOT NULL
    DROP TABLE dbo.ca_operacion_total
GO

CREATE TABLE dbo.ca_operacion_total
    (
    opt_fecha_proceso DATETIME,
    opt_operacion     INT,
    opt_validacion    catalogo,
    opt_estado        TINYINT,
    opt_tipo          CHAR (1),
    opt_maestro       CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_operacion_total_1
    ON dbo.ca_operacion_total (opt_operacion, opt_estado)
GO

CREATE INDEX ca_operacion_total_2
    ON dbo.ca_operacion_total (opt_estado)
GO

IF OBJECT_ID ('dbo.ca_operacion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_operacion_tmp
GO

CREATE TABLE dbo.ca_operacion_tmp
    (
    opt_operacion               INT NOT NULL,
    opt_banco                   cuenta NOT NULL,
    opt_anterior                cuenta,
    opt_migrada                 cuenta,
    opt_tramite                 INT,
    opt_cliente                 INT,
    opt_nombre                  descripcion,
    opt_sector                  catalogo NOT NULL,
    opt_toperacion              catalogo NOT NULL,
    opt_oficina                 SMALLINT NOT NULL,
    opt_moneda                  TINYINT NOT NULL,
    opt_comentario              VARCHAR (255),
    opt_oficial                 SMALLINT NOT NULL,
    opt_fecha_ini               DATETIME NOT NULL,
    opt_fecha_fin               DATETIME NOT NULL,
    opt_fecha_ult_proceso       DATETIME NOT NULL,
    opt_fecha_liq               DATETIME,
    opt_fecha_reajuste          DATETIME,
    opt_monto                   MONEY NOT NULL,
    opt_monto_aprobado          MONEY NOT NULL,
    opt_destino                 catalogo NOT NULL,
    opt_lin_credito             cuenta,
    opt_ciudad                  INT NOT NULL,
    opt_estado                  TINYINT NOT NULL,
    opt_periodo_reajuste        SMALLINT,
    opt_reajuste_especial       CHAR (1),
    opt_tipo                    CHAR (1) NOT NULL,
    opt_forma_pago              catalogo,
    opt_cuenta                  cuenta,
    opt_dias_anio               SMALLINT NOT NULL,
    opt_tipo_amortizacion       VARCHAR (10) NOT NULL,
    opt_cuota_completa          CHAR (1) NOT NULL,
    opt_tipo_cobro              CHAR (1) NOT NULL,
    opt_tipo_reduccion          CHAR (1) NOT NULL,
    opt_aceptar_anticipos       CHAR (1) NOT NULL,
    opt_precancelacion          CHAR (1) NOT NULL,
    opt_tipo_aplicacion         CHAR (1) NOT NULL,
    opt_tplazo                  catalogo,
    opt_plazo                   SMALLINT,
    opt_tdividendo              catalogo,
    opt_periodo_cap             SMALLINT,
    opt_periodo_int             SMALLINT,
    opt_dist_gracia             CHAR (1),
    opt_gracia_cap              SMALLINT,
    opt_gracia_int              SMALLINT,
    opt_dia_fijo                TINYINT,
    opt_cuota                   MONEY,
    opt_evitar_feriados         CHAR (1),
    opt_num_renovacion          TINYINT,
    opt_renovacion              CHAR (1),
    opt_mes_gracia              TINYINT NOT NULL,
    opt_reajustable             CHAR (1) NOT NULL,
    opt_dias_clausula           INT NOT NULL,
    opt_divcap_original         SMALLINT,
    opt_clausula_aplicada       CHAR (1),
    opt_traslado_ingresos       CHAR (1),
    opt_periodo_crecimiento     SMALLINT,
    opt_tasa_crecimiento        FLOAT,
    opt_direccion               TINYINT,
    opt_opcion_cap              CHAR (1),
    opt_tasa_cap                FLOAT,
    opt_dividendo_cap           SMALLINT,
    opt_clase                   catalogo NOT NULL,
    opt_origen_fondos           catalogo,
    opt_calificacion            CHAR (1),
    opt_estado_cobranza         catalogo,
    opt_numero_reest            INT NOT NULL,
    opt_edad                    INT,
    opt_tipo_crecimiento        CHAR (1),
    opt_base_calculo            CHAR (1),
    opt_prd_cobis               TINYINT,
    opt_ref_exterior            cuenta,
    opt_sujeta_nego             CHAR (1),
    opt_dia_habil               CHAR (1),
    opt_recalcular_plazo        CHAR (1),
    opt_usar_tequivalente       CHAR (1),
    opt_fondos_propios          CHAR (1) NOT NULL,
    opt_nro_red                 VARCHAR (24),
    opt_tipo_redondeo           TINYINT,
    opt_sal_pro_pon             MONEY,
    opt_tipo_empresa            catalogo,
    opt_validacion              catalogo,
    opt_fecha_pri_cuot          DATETIME,
    opt_gar_admisible           CHAR (1),
    opt_causacion               CHAR (1),
    opt_convierte_tasa          CHAR (1),
    opt_grupo_fact              INT,
    opt_tramite_ficticio        INT,
    opt_tipo_linea              catalogo,
    opt_subtipo_linea           catalogo,
    opt_bvirtual                CHAR (1),
    opt_extracto                CHAR (1),
    opt_num_deuda_ext           cuenta,
    opt_fecha_embarque          DATETIME,
    opt_fecha_dex               DATETIME,
    opt_reestructuracion        CHAR (1),
    opt_tipo_cambio             CHAR (1),
    opt_naturaleza              CHAR (1),
    opt_pago_caja               CHAR (1),
    opt_nace_vencida            CHAR (1),
    opt_num_comex               cuenta,
    opt_calcula_devolucion      CHAR (1),
    opt_codigo_externo          cuenta,
    opt_margen_redescuento      FLOAT,
    opt_entidad_convenio        catalogo,
    opt_pproductor              CHAR (1),
    opt_fecha_ult_causacion     DATETIME,
    opt_mora_retroactiva        CHAR (1),
    opt_calificacion_ant        CHAR (1),
    opt_cap_susxcor             MONEY,
    opt_prepago_desde_lavigente CHAR (1),
    opt_fecha_ult_mov           DATETIME,
    opt_fecha_prox_segven       DATETIME,
    opt_suspendio               CHAR (1),
    opt_fecha_suspenso          DATETIME,
    opt_honorarios_cobranza     CHAR (1),
    opt_banca                   catalogo,
        opt_promocion               char(1),    --LPO Santander
        opt_acepta_ren              char(1),    --LPO Santander
        opt_no_acepta               char(1000), --LPO Santander
    opt_emprendimiento          char(1),    --LPO Santander
	opt_desplazamiento          int null    --SRO 140073
    )
GO

CREATE INDEX idx1
    ON dbo.ca_operacion_tmp (opt_operacion)
    WITH (FILLFACTOR = 50)
GO

CREATE INDEX idx2
    ON dbo.ca_operacion_tmp (opt_tramite)
    WITH (FILLFACTOR = 50)
GO

IF OBJECT_ID ('dbo.ca_operacion_timbre') IS NOT NULL
    DROP TABLE dbo.ca_operacion_timbre
GO

CREATE TABLE dbo.ca_operacion_timbre
    (
    ot_regional        INT,
    ot_oficina         SMALLINT,
    ot_banco           cuenta,
    ot_dm_beneficiario descripcion,
    ot_dm_fecha        DATETIME,
    ot_dm_monto_mn     MONEY,
    ot_concepto_timbre catalogo,
    ot_monto_timbre    MONEY,
    ot_descripcion     descripcion,
    ot_destino         catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_operacion_mig') IS NOT NULL
    DROP TABLE dbo.ca_operacion_mig
GO

CREATE TABLE dbo.ca_operacion_mig
    (
    opm_migrada           VARCHAR (24) NOT NULL,
    opm_cliente           INT,
    opm_destino           VARCHAR (10) NOT NULL,
    opm_monto             MONEY NOT NULL,
    opm_ciudad            INT NOT NULL,
    opm_toperacion        VARCHAR (10) NOT NULL,
    opm_sector            VARCHAR (10) NOT NULL,
    opm_moneda            SMALLINT NOT NULL,
    opm_fecha_ini         DATETIME NOT NULL,
    opm_tasa              FLOAT NOT NULL,
    opm_fecha_fija        CHAR (1) NOT NULL,
    opm_dia_pago          TINYINT NOT NULL,
    opm_tplazo            VARCHAR (1),
    opm_plazo             SMALLINT NOT NULL,
    opm_tdividendo        VARCHAR (10),
    opm_periodo_cap       SMALLINT NOT NULL,
    opm_periodo_int       SMALLINT NOT NULL,
    opm_gracia_cap        SMALLINT NOT NULL,
    opm_gracia_int        SMALLINT NOT NULL,
    opm_tipo_amortizacion VARCHAR (10) NOT NULL,
    opm_cuota             MONEY NOT NULL,
    opm_evitar_feriados   CHAR (1) NOT NULL,
    opm_reajustable       CHAR (1) NOT NULL,
    opm_periodo_reajuste  TINYINT NOT NULL,
    opm_fecha_reajuste    DATETIME NOT NULL,
    opm_tipo_productor    VARCHAR (10) NOT NULL,
    opm_toperacion_nueva  VARCHAR (10) NOT NULL,
    opm_cupo_credito      VARCHAR (25),
    opm_tipo_identificac  CHAR (2) NOT NULL,
    opm_identificacion    VARCHAR (64) NOT NULL,
    op_oficina            INT NOT NULL,
    opm_estado_mig        INT CONSTRAINT DF__ca_operac__opm_e__2879A833 DEFAULT ((0)) NOT NULL
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

CREATE UNIQUE INDEX ca_operacion_his_1
    ON dbo.ca_operacion_his (oph_operacion, oph_secuencial)
    WITH (FILLFACTOR = 90)
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

CREATE UNIQUE INDEX ca_operacion_hc_1
    ON dbo.ca_operacion_hc (oh_operacion, oh_fecha)
GO

CREATE INDEX ca_operacion_hc_2
    ON dbo.ca_operacion_hc (oh_fecha)
GO

IF OBJECT_ID ('dbo.ca_operacion_control') IS NOT NULL
    DROP TABLE dbo.ca_operacion_control
GO

CREATE TABLE dbo.ca_operacion_control
    (
    oc_operacion     INT NOT NULL,
    oc_dividendo_vig SMALLINT NOT NULL,
    oc_max_dividendo SMALLINT NOT NULL,
    oc_fpago         CHAR (1) NOT NULL,
    oc_cto_int       catalogo NOT NULL,
    oc_saldo_cap     MONEY NOT NULL,
    oc_min_vencido   SMALLINT NOT NULL,
    oc_fecha_vencido DATETIME NOT NULL,
    oc_saldo_ok      SMALLINT NOT NULL,
    oc_ult_sectran   INT
    )
GO

CREATE UNIQUE INDEX ca_operacion_control_1
    ON dbo.ca_operacion_control (oc_operacion)
GO

IF OBJECT_ID ('dbo.ca_operacion_bancamia_tmp') IS NOT NULL
    DROP TABLE dbo.ca_operacion_bancamia_tmp
GO

CREATE TABLE dbo.ca_operacion_bancamia_tmp
    (
    op_ced_ruc  VARCHAR (20),
    op_tipo_doc VARCHAR (5),
    op_clase    VARCHAR (20),
    op_estado   TINYINT,
    op_sector   VARCHAR (26),
    op_banco    VARCHAR (26),
    op_tran     VARCHAR (10),
    op_obs      VARCHAR (255),
    op_arch_ofi VARCHAR (4)
    )
GO

CREATE INDEX ca_op_bancamia_tmp_1
    ON dbo.ca_operacion_bancamia_tmp (op_banco)
GO

IF OBJECT_ID ('dbo.ca_operacion_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_operacion_bancamia
GO

CREATE TABLE dbo.ca_operacion_bancamia
    (
    op_ced_ruc  VARCHAR (20),
    op_tipo_doc VARCHAR (5),
    op_clase    VARCHAR (20),
    op_estado   TINYINT,
    op_sector   VARCHAR (26),
    op_banco    VARCHAR (26),
    op_ente     INT
    )
GO

CREATE INDEX ca_op_bancamia_tmp_1
    ON dbo.ca_operacion_bancamia (op_banco)
GO

CREATE INDEX ca_op_bancamia_tmp_2
    ON dbo.ca_operacion_bancamia (op_ced_ruc)
GO

IF OBJECT_ID ('dbo.ca_operacion_alterna') IS NOT NULL
    DROP TABLE dbo.ca_operacion_alterna
GO

CREATE TABLE dbo.ca_operacion_alterna
    (
    oa_operacion_alterna  INT,
    oa_operacion_original VARCHAR (24),
    oa_monto_alterna      MONEY,
    oa_monto_original     MONEY,
    oa_garantia           VARCHAR (64),
    oa_fpago              VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_operacion') IS NOT NULL
    DROP TABLE dbo.ca_operacion
GO

CREATE TABLE dbo.ca_operacion
    (
    op_operacion               INT NOT NULL,
    op_banco                   cuenta NOT NULL,
    op_anterior                cuenta,
    op_migrada                 cuenta,
    op_tramite                 INT,
    op_cliente                 INT,
    op_nombre                  descripcion,
    op_sector                  catalogo NOT NULL,
    op_toperacion              catalogo NOT NULL,
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
    op_destino                 catalogo NOT NULL,
    op_lin_credito             cuenta,
    op_ciudad                  INT NOT NULL,
    op_estado                  TINYINT NOT NULL,
    op_periodo_reajuste        SMALLINT,
    op_reajuste_especial       CHAR (1),
    op_tipo                    CHAR (1) NOT NULL,
    op_forma_pago              catalogo,
    op_cuenta                  cuenta,
    op_dias_anio               SMALLINT NOT NULL,
    op_tipo_amortizacion       VARCHAR (10) NOT NULL,
    op_cuota_completa          CHAR (1) NOT NULL,
    op_tipo_cobro              CHAR (1) NOT NULL,
    op_tipo_reduccion          CHAR (1) NOT NULL,
    op_aceptar_anticipos       CHAR (1) NOT NULL,
    op_precancelacion          CHAR (1) NOT NULL,
    op_tipo_aplicacion         CHAR (1) NOT NULL,
    op_tplazo                  catalogo,
    op_plazo                   SMALLINT,
    op_tdividendo              catalogo,
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
    op_clase                   catalogo NOT NULL,
    op_origen_fondos           catalogo,
    op_calificacion            CHAR (1),
    op_estado_cobranza         catalogo,
    op_numero_reest            INT NOT NULL,
    op_edad                    INT,
    op_tipo_crecimiento        CHAR (1),
    op_base_calculo            CHAR (1),
    op_prd_cobis               TINYINT,
    op_ref_exterior            cuenta,
    op_sujeta_nego             CHAR (1),
    op_dia_habil               CHAR (1),
    op_recalcular_plazo        CHAR (1),
    op_usar_tequivalente       CHAR (1),
    op_fondos_propios          CHAR (1) NOT NULL,
    op_nro_red                 VARCHAR (24),
    op_tipo_redondeo           TINYINT,
    op_sal_pro_pon             MONEY,
    op_tipo_empresa            catalogo,
    op_validacion              catalogo,
    op_fecha_pri_cuot          DATETIME,
    op_gar_admisible           CHAR (1),
    op_causacion               CHAR (1),
    op_convierte_tasa          CHAR (1),
    op_grupo_fact              INT,
    op_tramite_ficticio        INT,
    op_tipo_linea              catalogo,
    op_subtipo_linea           catalogo,
    op_bvirtual                CHAR (1),
    op_extracto                CHAR (1),
    op_num_deuda_ext           cuenta,
    op_fecha_embarque          DATETIME,
    op_fecha_dex               DATETIME,
    op_reestructuracion        CHAR (1),
    op_tipo_cambio             CHAR (1),
    op_naturaleza              CHAR (1),
    op_pago_caja               CHAR (1),
    op_nace_vencida            CHAR (1),
    op_num_comex               cuenta,
    op_calcula_devolucion      CHAR (1),
    op_codigo_externo          cuenta,
    op_margen_redescuento      FLOAT,
    op_entidad_convenio        catalogo,
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
    op_banca                   catalogo,
        op_promocion               char(1),    --LPO Santander
        op_acepta_ren              char(1),    --LPO Santander
        op_no_acepta               char(1000), --LPO Santander
        op_emprendimiento          char(1)     --LPO Santander
    )
GO

CREATE UNIQUE INDEX ca_operacion_1
    ON dbo.ca_operacion (op_operacion)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_2
    ON dbo.ca_operacion (op_migrada)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_3
    ON dbo.ca_operacion (op_tramite)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_4
    ON dbo.ca_operacion (op_cliente)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_5
    ON dbo.ca_operacion (op_oficial)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_6
    ON dbo.ca_operacion (op_oficina)
    WITH (FILLFACTOR = 80)
GO

CREATE UNIQUE INDEX ca_operacion_7
    ON dbo.ca_operacion (op_banco, op_estado_cobranza)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX ca_operacion_8
    ON dbo.ca_operacion (op_lin_credito)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_operacion_9
    ON dbo.ca_operacion (op_estado, op_fecha_liq, op_tramite, op_oficial)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_operacion_10
    ON dbo.ca_operacion (op_oficial, op_tramite, op_cliente, op_estado)
    WITH (FILLFACTOR = 75)
GO

CREATE INDEX ca_operacion_idx11
    ON dbo.ca_operacion (op_naturaleza, op_fecha_ult_proceso, op_cuenta, op_operacion, op_estado, op_forma_pago)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_opera_finagro_temp') IS NOT NULL
    DROP TABLE dbo.ca_opera_finagro_temp
GO

CREATE TABLE dbo.ca_opera_finagro_temp
    (
    Linea_de_credito                            INT,
    Numero_de_pagare                            VARCHAR (30),
    Fecha_de_inicio_de_la_obligacion            VARCHAR (10),
    Cuidad_de_inversion                         VARCHAR (10),
    Identificacion_del_primer_beneficiario      BIGINT,
    Tipo_de_identificacion                      CHAR (2),
    Nombre_razon_social_del_primer_beneficiario VARCHAR (50),
    Monto_activos                               INT,
    Direccion_beneficiario                      descripcion,
    Plazo                                       INT,
    Fecha_primer_vencimiento                    VARCHAR (10),
    Fecha_vencimiento_final                     VARCHAR (10),
    Frecuencia_capital                          INT,
    Abonos_capital                              INT,
    Periodo_de_gracia                           INT,
    Frecuencia_interes                          INT,
    Abonos_interes                              INT,
    Capital_total                               INT,
    Puntos_calculo_tasa_total                   NUMERIC (4, 2),
    Primera_cuota_desde                         INT,
    Primera_cuota_hasta                         INT,
    Valor_primera_cuota                         INT,
    Costo_inversion_rubro_principal             INT,
    Porcentaje_FAG                              INT,
    Indicativo_FAG                              CHAR (2),
    Tipo_comision                               CHAR (2),
    Valor_activos                               INT,
    Fecha_Balance                               VARCHAR (10),
    Fecha_activos                               VARCHAR (10),
    Ubicacion_predio                            descripcion,
    Codigo_oficina_de_origen                    INT,
    Telefono_beneficiario                       VARCHAR (15),
    Segunda_cuota_desde                         INT,
    Segunda_cuota_hasta                         INT,
    Valor_segunda_cuota                         INT,
    Num_Celular                                 VARCHAR (15),
    Tipo_de_plan                                TINYINT,
    Fecha_1_amortizacion                        VARCHAR (10),
    Valor_1_amortizacion                        INT,
    Tipo_de_cuota_1_amortizacion                TINYINT,
    Fecha_2_amortizacion                        VARCHAR (10),
    Valor_2_amortizacion                        INT,
    Tipo_de_cuota_2_amortizacion                TINYINT,
    Fecha_3_amortizacion                        VARCHAR (10),
    Valor_3_amortizacion                        INT,
    Tipo_de_cuota_3_amortizacion                TINYINT,
    Fecha_4_amortizacion                        VARCHAR (10),
    Valor_4_amortizacion                        INT,
    Tipo_de_cuota_4_amortizacion                TINYINT,
    Fecha_5_amortizacion                        VARCHAR (10),
    Valor_5_amortizacion                        INT,
    Tipo_de_cuota_5_amortizacion                TINYINT,
    Fecha_6_amortizacion                        VARCHAR (10),
    Valor_6_amortizacion                        INT,
    Tipo_de_cuota_6_amortizacion                TINYINT,
    Fecha_7_amortizacion                        VARCHAR (10),
    Valor_7_amortizacion                        INT,
    Tipo_de_cuota_7_amortizacion                TINYINT,
    Fecha_8_amortizacion                        VARCHAR (10),
    Valor_8_amortizacion                        INT,
    Tipo_de_cuota_8_amortizacion                TINYINT,
    Fecha_9_amortizacion                        VARCHAR (10),
    Valor_9_amortizacion                        INT,
    Tipo_de_cuota_9_amortizacion                TINYINT,
    Fecha_10_amortizacion                       VARCHAR (10),
    Valor_10_amortizacion                       INT,
    Tipo_de_cuota_10_amortizacion               TINYINT,
    Fecha_11_amortizacion                       VARCHAR (10),
    Valor_11_amortizacion                       INT,
    Tipo_de_cuota_11_amortizacion               TINYINT,
    Fecha_12_amortizacion                       VARCHAR (10),
    Valor_12_amortizacion                       INT,
    Tipo_de_cuota_12_amortizacion               TINYINT,
    Fecha_13_amortizacion                       VARCHAR (10),
    Valor_13_amortizacion                       INT,
    Tipo_de_cuota_13_amortizacion               TINYINT,
    Fecha_14_amortizacion                       VARCHAR (10),
    Valor_14_amortizacion                       INT,
    Tipo_de_cuota_14_amortizacion               TINYINT,
    Fecha_15_amortizacion                       VARCHAR (10),
    Valor_15_amortizacion                       INT,
    Tipo_de_cuota_15_amortizacion               TINYINT,
    Fecha_16_amortizacion                       VARCHAR (10),
    Valor_16_amortizacion                       INT,
    Tipo_de_cuota_16_amortizacion               TINYINT,
    Fecha_17_amortizacion                       VARCHAR (10),
    Valor_17_amortizacion                       INT,
    Tipo_de_cuota_17_amortizacion               TINYINT,
    Fecha_18_amortizacion                       VARCHAR (10),
    Valor_18_amortizacion                       INT,
    Tipo_de_cuota_18_amortizacion               TINYINT,
    Fecha_19_amortizacion                       VARCHAR (10),
    Valor_19_amortizacion                       INT,
    Tipo_de_cuota_19_amortizacion               TINYINT,
    Fecha_20_amortizacion                       VARCHAR (10),
    Valor_20_amortizacion                       INT,
    Tipo_de_cuota_20_amortizacion               TINYINT,
    Fecha_21_amortizacion                       VARCHAR (10),
    Valor_21_amortizacion                       INT,
    Tipo_de_cuota_21_amortizacion               TINYINT,
    Fecha_22_amortizacion                       VARCHAR (10),
    Valor_22_amortizacion                       INT,
    Tipo_de_cuota_22_amortizacion               TINYINT,
    Fecha_23_amortizacion                       VARCHAR (10),
    Valor_23_amortizacion                       INT,
    Tipo_de_cuota_23_amortizacion               TINYINT,
    Fecha_24_amortizacion                       VARCHAR (10),
    Valor_24_amortizacion                       INT,
    Tipo_de_cuota_24_amortizacion               TINYINT
    )
GO

IF OBJECT_ID ('dbo.ca_opera_finagro') IS NOT NULL
    DROP TABLE dbo.ca_opera_finagro
GO

CREATE TABLE dbo.ca_opera_finagro
    (
    of_ente             INT,
    of_lincre           INT,
    of_pagare           VARCHAR (40),
    of_ini_ope          VARCHAR (10),
    of_ciudad           VARCHAR (10),
    of_iden_cli         BIGINT,
    of_tipo_iden        CHAR (2),
    of_raz_social       VARCHAR (50),
    of_monto_act        INT,
    of_dir_cli          descripcion,
    of_plazo            INT,
    of_fecha_pri_ven    VARCHAR (10),
    of_fecha_ven_final  VARCHAR (10),
    of_abono_cap        INT,
    of_frec_cap         INT,
    of_periodo_gracia   INT,
    of_frec_int         INT,
    of_abono_int        INT,
    of_cap_total        INT,
    of_calc_tasa_tot    NUMERIC (4, 2),
    of_prim_cuota_dsd   INT,
    of_prim_cuota_hst   INT,
    of_valor_prim_cuota INT,
    of_inv_rubro        INT,
    of_porcentaje_fag   INT,
    of_indicativo_fag   CHAR (2),
    of_tipo_comision    CHAR (2),
    of_val_act          INT,
    of_fecha_balance    VARCHAR (10),
    of_fecha_act        VARCHAR (10),
    of_dir_inversion    descripcion,
    of_cod_oficina      INT,
    of_telf_cli         VARCHAR (15),
    of_seg_cuota_dsd    INT,
    of_seg_cuota_hst    INT,
    of_valor_seg_cuota  INT,
    of_telf_cel_cli     VARCHAR (15),
    of_procesado        CHAR (1),
    of_linea_ant        INT
    )
GO

IF OBJECT_ID ('dbo.ca_oper_universo_tmp') IS NOT NULL
    DROP TABLE dbo.ca_oper_universo_tmp
GO

CREATE TABLE dbo.ca_oper_universo_tmp
    (
    secuencial_reg INT IDENTITY NOT NULL,
    fecha_pag      DATETIME,
    oper           INT,
    sec_pag        INT
    )
GO

IF OBJECT_ID ('dbo.ca_Oper_RES_olaInver_tmp') IS NOT NULL
    DROP TABLE dbo.ca_Oper_RES_olaInver_tmp
GO

CREATE TABLE dbo.ca_Oper_RES_olaInver_tmp
    (
    FECHA_PROCESO    VARCHAR (12),
    FECHA_DESEMBOLSO VARCHAR (12),
    FECHa_REESTRUC   VARCHAR (12),
    NRO_CREDITO      cuenta,
    SALDO_CAPITAL    MONEY,
    NRO_REESTRUC     SMALLINT,
    OFICINA          INT
    )
GO

IF OBJECT_ID ('dbo.ca_oper_cambio_linea_FINAGRO') IS NOT NULL
    DROP TABLE dbo.ca_oper_cambio_linea_FINAGRO
GO

CREATE TABLE dbo.ca_oper_cambio_linea_FINAGRO
    (
    tipo_identificacion catalogo,
    identificacion      VARCHAR (30),
    banco_cobis         VARCHAR (20),
    linea_origen        catalogo,
    linea_destino       catalogo
    )
GO

CREATE INDEX idx1
    ON dbo.ca_oper_cambio_linea_FINAGRO (banco_cobis)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_opcobis_nobancoldex') IS NOT NULL
    DROP TABLE dbo.ca_opcobis_nobancoldex
GO

CREATE TABLE dbo.ca_opcobis_nobancoldex
    (
    cb_fecha_proceso        DATETIME,
    cb_linea                cuenta,
    cb_num_oper_cobis       cuenta,
    cb_num_oper_bancoldex   cuenta,
    cb_ciudad               INT,
    cb_beneficiario         CHAR (30),
    cb_ref_externa          cuenta,
    cb_saldo_capital        MONEY,
    cb_tasa                 FLOAT,
    cb_dias                 INT,
    cb_valor_interes        MONEY,
    cb_valor_capital        MONEY,
    cb_valor_mora           MONEY,
    cb_neto_pagar           MONEY,
    cb_oper_bancoldex_plano cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_op_reest_padre_hija') IS NOT NULL
    DROP TABLE dbo.ca_op_reest_padre_hija
GO

CREATE TABLE dbo.ca_op_reest_padre_hija
    (
    ph_op_padre  INT,
    ph_op_hija   INT,
    ph_sec_reest INT,
    ph_fecha     DATETIME
    )
GO

CREATE INDEX ix_1
    ON dbo.ca_op_reest_padre_hija (ph_op_padre)
    WITH (FILLFACTOR = 75)
GO

CREATE INDEX ix_2
    ON dbo.ca_op_reest_padre_hija (ph_op_hija)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_op_cobranza_jud') IS NOT NULL
    DROP TABLE dbo.ca_op_cobranza_jud
GO

CREATE TABLE dbo.ca_op_cobranza_jud
    (
    cj_banco     cuenta,
    cj_nombre_ab VARCHAR (64),
    cj_codigo_ab INT,
    cj_estado_cb CHAR (2)
    )
GO

IF OBJECT_ID ('dbo.ca_op_cobranza') IS NOT NULL
    DROP TABLE dbo.ca_op_cobranza
GO

CREATE TABLE dbo.ca_op_cobranza
    (
    oc_banco   cuenta,
    oc_abogado descripcion,
    oc_oficina VARCHAR (24),
    oc_estado  CHAR (2)
    )
GO

IF OBJECT_ID ('dbo.ca_normalizacion') IS NOT NULL
    DROP TABLE dbo.ca_normalizacion
GO

CREATE TABLE dbo.ca_normalizacion
    (
    nm_tramite           INT,
    nm_cliente           INT,
    nm_tipo_norm         catalogo,
    nm_estado            catalogo,
    nm_fecha_apl         DATETIME,
    nm_fecha_pro_antes   DATETIME,
    nm_fecha_pro_despues DATETIME,
    nm_cuota_pro         SMALLINT
    )
GO

CREATE INDEX idx1
    ON dbo.ca_normalizacion (nm_tramite)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX idx2
    ON dbo.ca_normalizacion (nm_cliente)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_nomina_tmp') IS NOT NULL
    DROP TABLE dbo.ca_nomina_tmp
GO

CREATE TABLE dbo.ca_nomina_tmp
    (
    not_operacion    INT NOT NULL,
    not_dividendo    SMALLINT NOT NULL,
    not_concepto     catalogo NOT NULL,
    not_valor        MONEY NOT NULL,
    not_cod_concepto VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_nomina') IS NOT NULL
    DROP TABLE dbo.ca_nomina
GO

CREATE TABLE dbo.ca_nomina
    (
    no_operacion    INT NOT NULL,
    no_dividendo    SMALLINT NOT NULL,
    no_concepto     catalogo NOT NULL,
    no_valor        MONEY NOT NULL,
    no_cod_concepto VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_nexisten_finagro') IS NOT NULL
    DROP TABLE dbo.ca_nexisten_finagro
GO

CREATE TABLE dbo.ca_nexisten_finagro
    (
    ca_llave          cuenta,
    ca_identificacion cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_nexisten_cobis') IS NOT NULL
    DROP TABLE dbo.ca_nexisten_cobis
GO

CREATE TABLE dbo.ca_nexisten_cobis
    (
    ca_llave          cuenta,
    ca_identificacion cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_msv_proc') IS NOT NULL
    DROP TABLE dbo.ca_msv_proc
GO

CREATE TABLE dbo.ca_msv_proc
    (
    mp_id_carga    INT,
    mp_id_alianza  INT,
    mp_tipo_tr     CHAR (1),
    mp_tramite     INT,
    mp_tipo        CHAR (1),
    mp_banco       cuenta,
    mp_estado      CHAR (1),
    mp_monto       MONEY,
    mp_toperacion  catalogo,
    mp_tasa        FLOAT,
    mp_descripcion VARCHAR (124),
    mp_fecha_proc  DATETIME
    )
GO

CREATE INDEX idx_1
    ON dbo.ca_msv_proc (mp_id_carga, mp_id_alianza, mp_tipo_tr, mp_tramite)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_monitor_1') IS NOT NULL
    DROP TABLE dbo.ca_monitor_1
GO

CREATE TABLE dbo.ca_monitor_1
    (
    Fecha_proceso       VARCHAR (10),
    Oficina             INT,
    Nombre_oficina      descripcion,
    Identificacion      cuenta,
    Nombre_Cliente      descripcion,
    Fecha_Desembolso    VARCHAR (10),
    No_Credito          cuenta,
    Valor_Desembolso    MONEY,
    Valor_Concepto      MONEY,
    Clase_Cartera       SMALLINT,
    Dias_Plazo          INT,
    Tasa_Efectiva_Anual FLOAT,
    Tasa_Nominal        FLOAT,
    Tipo_Prestamo       CHAR (1),
    Forma_Pago          VARCHAR (10),
    Destino_Desembolso  descripcion,
    Beneficiario        cuenta,
    Nombre_Beneficiario descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_mesacambio_temp') IS NOT NULL
    DROP TABLE dbo.ca_mesacambio_temp
GO

CREATE TABLE dbo.ca_mesacambio_temp
    (
    mt_fecha       DATETIME,
    mt_banco       cuenta,
    mt_tran        CHAR (3),
    mt_moneda      SMALLINT,
    mt_monto       MONEY,
    mt_cotizacion  MONEY,
    mt_monto_mn    MONEY,
    mt_en_linea    CHAR (1),
    mt_comprobante INT,
    mt_fecha_cont  DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_mensaje_facturacion') IS NOT NULL
    DROP TABLE dbo.ca_mensaje_facturacion
GO

CREATE TABLE dbo.ca_mensaje_facturacion
    (
    mf_usuario               login NOT NULL,
    mf_fecha                 DATETIME NOT NULL,
    mf_fecha_ini_facturacion DATETIME NOT NULL,
    mf_fecha_fin_facturacion DATETIME NOT NULL,
    mf_sujeto_credito        catalogo,
    mf_tipo_productor        VARCHAR (24),
    mf_tipo_banca            catalogo,
    mf_mercado               catalogo,
    mf_mercado_objetivo      catalogo,
    mf_cod_linea             catalogo,
    mf_destino_economico     catalogo,
    mf_oficina               SMALLINT,
    mf_zona                  SMALLINT,
    mf_regional              SMALLINT,
    mf_estado_op             TINYINT,
    mf_mensaje               VARCHAR (255) NOT NULL
    )
GO

CREATE INDEX ca_mensaje_facturacion_1
    ON dbo.ca_mensaje_facturacion (mf_fecha_ini_facturacion, mf_fecha_fin_facturacion)
GO

IF OBJECT_ID ('dbo.ca_matriz_valor_ts') IS NOT NULL
    DROP TABLE dbo.ca_matriz_valor_ts
GO

CREATE TABLE dbo.ca_matriz_valor_ts
    (
    mvs_user        login,
    mvs_oficina_ts  INT,
    mvs_terminal_ts catalogo,
    mvs_tipo_cambio CHAR (1),
    mvs_fecha_real  SMALLDATETIME,
    mvs_matriz      catalogo,
    mvs_fecha_vig   SMALLDATETIME,
    mvs_rango1      INT,
    mvs_rango2      INT,
    mvs_rango3      INT,
    mvs_rango4      INT,
    mvs_rango5      INT,
    mvs_rango6      INT,
    mvs_rango7      INT,
    mvs_rango8      INT,
    mvs_rango9      INT,
    mvs_rango10     INT,
    mvs_rango11     INT,
    mvs_rango12     INT,
    mvs_rango13     INT,
    mvs_rango14     INT,
    mvs_rango15     INT,
    mvs_valor       FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_matriz_valor_tmp') IS NOT NULL
    DROP TABLE dbo.ca_matriz_valor_tmp
GO

CREATE TABLE dbo.ca_matriz_valor_tmp
    (
    mvt_matriz    catalogo NOT NULL,
    mvt_fecha_vig SMALLDATETIME NOT NULL,
    mvt_rango1    INT NOT NULL,
    mvt_rango2    INT NOT NULL,
    mvt_rango3    INT NOT NULL,
    mvt_rango4    INT NOT NULL,
    mvt_rango5    INT NOT NULL,
    mvt_rango6    INT NOT NULL,
    mvt_rango7    INT NOT NULL,
    mvt_rango8    INT NOT NULL,
    mvt_rango9    INT NOT NULL,
    mvt_rango10   INT NOT NULL,
    mvt_rango11   INT NOT NULL,
    mvt_rango12   INT NOT NULL,
    mvt_rango13   INT NOT NULL,
    mvt_rango14   INT NOT NULL,
    mvt_rango15   INT NOT NULL,
    mvt_valor     FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_matriz_valor') IS NOT NULL
    DROP TABLE dbo.ca_matriz_valor
GO

CREATE TABLE dbo.ca_matriz_valor
    (
    mv_matriz    catalogo NOT NULL,
    mv_fecha_vig SMALLDATETIME NOT NULL,
    mv_rango1    INT NOT NULL,
    mv_rango2    INT NOT NULL,
    mv_rango3    INT NOT NULL,
    mv_rango4    INT NOT NULL,
    mv_rango5    INT NOT NULL,
    mv_rango6    INT NOT NULL,
    mv_rango7    INT NOT NULL,
    mv_rango8    INT NOT NULL,
    mv_rango9    INT NOT NULL,
    mv_rango10   INT NOT NULL,
    mv_rango11   INT NOT NULL,
    mv_rango12   INT NOT NULL,
    mv_rango13   INT NOT NULL,
    mv_rango14   INT NOT NULL,
    mv_rango15   INT NOT NULL,
    mv_valor     FLOAT NOT NULL
    )
GO

CREATE CLUSTERED INDEX ca_matriz_valor_1
    ON dbo.ca_matriz_valor (mv_matriz, mv_fecha_vig, mv_rango1)
GO

IF OBJECT_ID ('dbo.ca_matriz_tmp') IS NOT NULL
    DROP TABLE dbo.ca_matriz_tmp
GO

CREATE TABLE dbo.ca_matriz_tmp
    (
    mat_matriz        catalogo NOT NULL,
    mat_descripcion   VARCHAR (60) NOT NULL,
    mat_fecha_vig     SMALLDATETIME NOT NULL,
    mat_ejes          INT NOT NULL,
    mat_valor_default FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_matriz_plano') IS NOT NULL
    DROP TABLE dbo.ca_matriz_plano
GO

CREATE TABLE dbo.ca_matriz_plano
    (
    mp_matriz  catalogo,
    mp_rango1  INT,
    mp_rango2  INT,
    mp_rango3  INT,
    mp_rango4  INT,
    mp_rango5  INT,
    mp_rango6  INT,
    mp_rango7  INT,
    mp_rango8  INT,
    mp_rango9  INT,
    mp_rango10 INT,
    mp_rango11 INT,
    mp_rango12 INT,
    mp_rango13 INT,
    mp_rango14 INT,
    mp_rango15 INT,
    mp_valor   FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_matriz_consultaD_tmp') IS NOT NULL
    DROP TABLE dbo.ca_matriz_consultaD_tmp
GO

CREATE TABLE dbo.ca_matriz_consultaD_tmp
    (
    md_sec         INT,
    md_fecha       DATETIME,
    md_usuario     catalogo,
    md_accion      CHAR (1),
    md_matriz      catalogo,
    md_eje         INT,
    md_descripcion VARCHAR (20),
    md_rango       INT,
    md_desde       VARCHAR (20),
    md_hasta       VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_matriz_consulta_tmp') IS NOT NULL
    DROP TABLE dbo.ca_matriz_consulta_tmp
GO

CREATE TABLE dbo.ca_matriz_consulta_tmp
    (
    mc_sec     INT,
    mc_fecha   DATETIME,
    mc_hora    DATETIME,
    mc_usuario catalogo,
    mc_accion  CHAR (1),
    mc_matriz  catalogo,
    mc_rango1  VARCHAR (20),
    mc_rango2  VARCHAR (20),
    mc_rango3  VARCHAR (20),
    mc_rango4  VARCHAR (20),
    mc_rango5  VARCHAR (20),
    mc_rango6  VARCHAR (20),
    mc_rango7  VARCHAR (20),
    mc_rango8  VARCHAR (20),
    mc_rango9  VARCHAR (20),
    mc_rango10 VARCHAR (20),
    mc_rango11 VARCHAR (20),
    mc_rango12 VARCHAR (20),
    mc_rango13 VARCHAR (20),
    mc_rango14 VARCHAR (20),
    mc_rango15 VARCHAR (20),
    mc_valor   FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_matriz') IS NOT NULL
    DROP TABLE dbo.ca_matriz
GO

CREATE TABLE dbo.ca_matriz
    (
    ma_matriz        catalogo NOT NULL,
    ma_descripcion   VARCHAR (60) NOT NULL,
    ma_fecha_vig     SMALLDATETIME NOT NULL,
    ma_ejes          INT NOT NULL,
    ma_valor_default FLOAT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_matriz_1
    ON dbo.ca_matriz (ma_matriz, ma_fecha_vig)
GO

IF OBJECT_ID ('dbo.ca_marcarPor_ola_invernal_tmp') IS NOT NULL
    DROP TABLE dbo.ca_marcarPor_ola_invernal_tmp
GO

CREATE TABLE dbo.ca_marcarPor_ola_invernal_tmp
    (
    ol_banco        cuenta NOT NULL,
    ol_operacion    INT NOT NULL,
    ol_cliente      INT NOT NULL,
    ol_toperacion   catalogo,
    ol_fecha_rees   DATETIME,
    ol_calificacion CHAR (1),
    ol_casilla_def  VARCHAR (24),
    ol_fecha_real   DATETIME,
    ol_parametro    INT
    )
GO

IF OBJECT_ID ('dbo.ca_marcarPor_ola_invernal_his') IS NOT NULL
    DROP TABLE dbo.ca_marcarPor_ola_invernal_his
GO

CREATE TABLE dbo.ca_marcarPor_ola_invernal_his
    (
    olh_banco        cuenta NOT NULL,
    olh_operacion    INT NOT NULL,
    olh_cliente      INT NOT NULL,
    olh_toperacion   catalogo,
    olh_fecha_rees   DATETIME,
    olh_calificacion CHAR (1),
    olh_casilla_def  VARCHAR (24),
    olh_fecha_real   DATETIME,
    olh_parametro    INT
    )
GO

IF OBJECT_ID ('dbo.ca_maestro_operaciones_tmp') IS NOT NULL
    DROP TABLE dbo.ca_maestro_operaciones_tmp
GO

CREATE TABLE dbo.ca_maestro_operaciones_tmp
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
    mo_tipo_banca                  VARCHAR (64),
    mo_nombre_codeudor             VARCHAR (35),
    mo_ced_ruc_codeudor            cuenta,
    mo_zona                        INT,
    mo_regional                    INT,
    mo_capitaliza                  CHAR (1),
    mo_tipo_productor              VARCHAR (64),
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
    mo_int_imo_diferido            MONEY,
    mo_oficial_original            SMALLINT NOT NULL,
    mo_oficial_reasignado          SMALLINT
    )
GO

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
    mo_tipo_banca                  VARCHAR (64),
    mo_nombre_codeudor             VARCHAR (35),
    mo_ced_ruc_codeudor            cuenta,
    mo_zona                        INT,
    mo_regional                    INT,
    mo_capitaliza                  CHAR (1),
    mo_tipo_productor              VARCHAR (64),
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
    mo_int_imo_diferido            MONEY,
    mo_oficial_original            SMALLINT NOT NULL,
    mo_oficial_reasignado          SMALLINT
    )
GO

CREATE INDEX ca_maestro_operaciones_1
    ON dbo.ca_maestro_operaciones (mo_fecha_de_proceso, mo_numero_de_operacion)
GO

CREATE INDEX ca_maestro_operaciones_2
    ON dbo.ca_maestro_operaciones (mo_numero_de_operacion)
GO

IF OBJECT_ID ('dbo.ca_log_fecha_valor') IS NOT NULL
    DROP TABLE dbo.ca_log_fecha_valor
GO

CREATE TABLE dbo.ca_log_fecha_valor
    (
    fv_operacion        INT NOT NULL,
    fv_secuencial_retro INT NOT NULL,
    fv_tipo             CHAR (1),
    fv_fecha_valor      DATETIME,
    fv_registro         CHAR (30),
    fv_usuario          login,
    fv_fecha_real       DATETIME NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_llave_redescuento') IS NOT NULL
    DROP TABLE dbo.ca_llave_redescuento
GO

CREATE TABLE dbo.ca_llave_redescuento
    (
    operacion INT,
    pasiva    INT,
    activa    INT,
    codigo    cuenta,
    fecha     DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_llave_finagro') IS NOT NULL
    DROP TABLE dbo.ca_llave_finagro
GO

CREATE TABLE dbo.ca_llave_finagro
    (
    ca_llave             cuenta,
    ca_identificacion    cuenta,
    ca_linea_norlegal    VARCHAR (4),
    ca_valor_saldo_redes MONEY,
    ca_modalidad         CHAR (1),
    ca_tasa_nom          FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_liquida_msv') IS NOT NULL
    DROP TABLE dbo.ca_liquida_msv
GO

CREATE TABLE dbo.ca_liquida_msv
    (
    li_opbanco            cuenta,
    li_regional           VARCHAR (64),
    li_dir_comercial      VARCHAR (254),
    li_telef_comercial    VARCHAR (16),
    li_ciudad_comercial   descripcion,
    li_fecha_naci         DATETIME,
    li_sexo               sexo,
    li_tipo_operacion     catalogo,
    li_seguro_vida        CHAR (3),
    li_otros_seguros      CHAR (3),
    li_recursos           catalogo,
    li_margen_redes       FLOAT,
    li_fecha_ult_pago     DATETIME,
    li_valor_ult_pago     MONEY,
    li_tipo_productor     VARCHAR (24),
    li_actividad          VARCHAR (24),
    li_saldo_actual       MONEY,
    li_pactado            VARCHAR (12),
    li_clase              VARCHAR (24),
    li_tipo_amortizacion  VARCHAR (20),
    li_calificacion       CHAR (1),
    li_cuota              NUMERIC (18),
    li_provisiona         CHAR (3),
    li_fec_calificacion   DATETIME,
    li_aprobado_por       VARCHAR (24),
    li_nomina             CHAR (3),
    li_monto_aprobado     MONEY,
    li_fecha_aprobacion   DATETIME,
    li_matricula          descripcion,
    li_escritura          descripcion,
    li_notaria            descripcion,
    li_tipo_garantia      descripcion,
    li_des_garantia       VARCHAR (255),
    li_vlr_avaluo         FLOAT,
    li_fecha_avaluo       DATETIME,
    li_ubicacion          catalogo,
    li_mun_garantia       INT,
    li_perito_aval        descripcion,
    li_dias_venc          INT,
    li_nom_estado         descripcion,
    li_cuotas_vencidas    INT,
    li_cuotas_pagadas     INT,
    li_cuotas_pendientes  INT,
    li_estado_juridico    VARCHAR (10),
    li_fec_est_juridico   DATETIME,
    li_clausula_aplicada  CHAR (1),
    li_fec_clausula       DATETIME,
    li_reestructuracion   CHAR (1),
    li_anterior           cuenta,
    li_numero_reest       INT,
    li_oficina            SMALLINT,
    li_deudor_otras       CHAR (3),
    li_tasa               FLOAT,
    li_tasa_referencial   VARCHAR (12),
    li_nombre_oficina     descripcion,
    li_banco              cuenta,
    li_nombre             descripcion,
    li_mod_obligacion     descripcion,
    li_periodo_pago       descripcion,
    li_gracia_int         SMALLINT,
    li_nom_estado1        descripcion,
    li_monto              MONEY,
    li_otorgamiento       DATETIME,
    li_fecha_fin          VARCHAR (10),
    li_destino            catalogo,
    li_cedula             VARCHAR (30),
    li_ultimo_pago        DATETIME,
    li_deudor             VARCHAR (255),
    li_codeudor           VARCHAR (255),
    li_moneda_desc        VARCHAR (64),
    li_moneda             TINYINT,
    li_cliente            INT,
    li_fecha_proceso      DATETIME,
    li_neto_cap           MONEY,
    li_neto_deduc         MONEY,
    li_num                INT,
    li_grupo              CHAR (1),
    li_concepto           VARCHAR (100),
    li_valor              MONEY,
    li_moneda1            VARCHAR (64),
    li_cotizacion         INT,
    li_cuenta             cuenta,
    li_beneficiario       VARCHAR (100),
    li_cruze_reestrictivo VARCHAR (100),
    li_rol                CHAR (3),
    li_cliente_bene       INT,
    li_cedula_bene        VARCHAR (30),
    li_pasaporte          VARCHAR (30),
    li_telefono           VARCHAR (16),
    li_direccion          VARCHAR (100),
    li_nombre_bene        VARCHAR (100),
    li_nombre_pdf         VARCHAR (255),
    li_correo             VARCHAR (100),
    li_direc_banco        VARCHAR (100),
    li_ciudad_ofi         VARCHAR (100),
    li_telef_ofi          VARCHAR (20),
    li_alianza            VARCHAR (20),
    li_des_alianza        VARCHAR (100)
    )
GO

IF OBJECT_ID ('dbo.ca_lavado_activos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_lavado_activos_tmp
GO

CREATE TABLE dbo.ca_lavado_activos_tmp
    (
    la_banco          cuenta NOT NULL,
    la_operacion      INT NOT NULL,
    la_secuencial_pag INT NOT NULL,
    la_fecha_pago     VARCHAR (10) NOT NULL,
    la_oficina_or     SMALLINT NOT NULL,
    la_oficina_ad     SMALLINT NOT NULL,
    la_monto_mn       MONEY NOT NULL,
    la_cliente        INT NOT NULL,
    la_nombre         descripcion NOT NULL,
    la_identificacion cuenta NOT NULL,
    la_forma_pago     catalogo NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_lavado_activos') IS NOT NULL
    DROP TABLE dbo.ca_lavado_activos
GO

CREATE TABLE dbo.ca_lavado_activos
    (
    la_banco          cuenta NOT NULL,
    la_operacion      INT NOT NULL,
    la_secuencial_pag INT NOT NULL,
    la_fecha_pago     VARCHAR (10) NOT NULL,
    la_oficina_or     SMALLINT NOT NULL,
    la_oficina_ad     SMALLINT NOT NULL,
    la_monto_mn       MONEY NOT NULL,
    la_cliente        INT NOT NULL,
    la_nombre         descripcion NOT NULL,
    la_identificacion cuenta NOT NULL,
    la_forma_pago     catalogo NOT NULL
    )
GO

CREATE INDEX ca_lavado_activos_1
    ON dbo.ca_lavado_activos (la_fecha_pago)
GO

IF OBJECT_ID ('dbo.ca_justificaciones_err') IS NOT NULL
    DROP TABLE dbo.ca_justificaciones_err
GO

CREATE TABLE dbo.ca_justificaciones_err
    (
    ju_fecha      DATETIME NOT NULL,
    ju_archivo    VARCHAR (12) NOT NULL,
    ju_banco      VARCHAR (15) NOT NULL,
    ju_fecha_liq  DATETIME NOT NULL,
    ju_estado_jus CHAR (1) NOT NULL,
    ju_monto_jus  MONEY NOT NULL,
    ju_error_jus  VARCHAR (60)
    )
GO

IF OBJECT_ID ('dbo.ca_justificaciones') IS NOT NULL
    DROP TABLE dbo.ca_justificaciones
GO

CREATE TABLE dbo.ca_justificaciones
    (
    ju_fecha      DATETIME NOT NULL,
    ju_archivo    VARCHAR (12) NOT NULL,
    ju_banco      VARCHAR (15) NOT NULL,
    ju_fecha_liq  DATETIME NOT NULL,
    ju_estado_jus CHAR (1) NOT NULL,
    ju_monto_jus  MONEY NOT NULL,
    ju_error_jus  VARCHAR (60)
    )
GO

CREATE INDEX idx1
    ON dbo.ca_justificaciones (ju_fecha, ju_archivo, ju_banco)
GO

IF OBJECT_ID ('dbo.ca_justifica_fina') IS NOT NULL
    DROP TABLE dbo.ca_justifica_fina
GO

CREATE TABLE dbo.ca_justifica_fina
    (
    fi_operacion         INT,
    fi_tramite           INT,
    fi_num_obligacion    VARCHAR (24),
    fi_intermediario     VARCHAR (24),
    fi_tipo_nit          catalogo,
    fi_nit               VARCHAR (30),
    fi_nom_beneficiario  VARCHAR (50),
    fi_tipo_sociedad     VARCHAR (14),
    fi_direccion         VARCHAR (50),
    fi_ciudad            VARCHAR (5),
    fi_ciu               CHAR (5),
    fi_empleos           VARCHAR (24),
    fi_empleo_genera     VARCHAR (24),
    fi_activos           VARCHAR (11),
    fi_fecha_corte_act   VARCHAR (10),
    fi_valor_credito     VARCHAR (50),
    fi_destino1          VARCHAR (25),
    fi_monto_destino1    VARCHAR (50),
    fi_destino2          VARCHAR (25),
    fi_monto_destino2    VARCHAR (50),
    fi_destino3          VARCHAR (25),
    fi_monto_destino3    VARCHAR (50),
    fi_fecha_desembolso  VARCHAR (14),
    fi_fecha_vencimiento VARCHAR (14),
    fi_clase_credito     VARCHAR (25),
    fi_periodo_gracia    VARCHAR (12),
    fi_amortizacion      VARCHAR (12),
    fi_margen            VARCHAR (5),
    fi_tasa_interes      VARCHAR (5),
    fi_saldo_credito     VARCHAR (11),
    fi_clase_garan_1     VARCHAR (10),
    fi_valor_garan_1     VARCHAR (64),
    fi_clase_garan_2     VARCHAR (64),
    fi_valor_garan_2     VARCHAR (64),
    fi_clase_garan_3     VARCHAR (64),
    fi_valor_garan_3     VARCHAR (64),
    fi_genero            catalogo,
    fi_nit_intermediario VARCHAR (30),
    fi_linea             CHAR (4),
    fi_telefono          VARCHAR (15),
    fi_fecha_nacimiento  VARCHAR (12),
    fi_escolaridad       VARCHAR (12),
    fi_destino           CHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_interfaz_ndc') IS NOT NULL
    DROP TABLE dbo.ca_interfaz_ndc
GO

CREATE TABLE dbo.ca_interfaz_ndc
    (
    in_secuencial     INT NOT NULL,
    in_operacion      INT NOT NULL,
    in_producto       TINYINT,
    in_banco          cuenta,
    in_moneda_op      SMALLINT,
    in_fecha_proceso  DATETIME,
    in_cliente        INT,
    in_nombre         descripcion,
    in_forma_pago     catalogo,
    in_cuenta         cuenta,
    in_tipo_trn       catalogo,
    in_moneda_pago    TINYINT,
    in_cotizacion     MONEY,
    in_monto_mop      MONEY,
    in_monto_aplicar  MONEY,
    in_monto_aplicado MONEY,
    in_estado         CHAR (1),
    in_error          INT
    )
GO

CREATE INDEX ca_interfaz_ndc_key
    ON dbo.ca_interfaz_ndc (in_operacion, in_secuencial)
GO

IF OBJECT_ID ('dbo.ca_interfaz_mesacambio') IS NOT NULL
    DROP TABLE dbo.ca_interfaz_mesacambio
GO

CREATE TABLE dbo.ca_interfaz_mesacambio
    (
    im_secuencial  INT NOT NULL,
    im_producto    TINYINT NOT NULL,
    im_fecha       DATETIME,
    im_obligacion  cuenta,
    im_deuda_ext   cuenta,
    im_cliente     INT,
    im_base        SMALLINT,
    im_referencia  VARCHAR (30),
    im_tea         FLOAT,
    im_trn         CHAR (3),
    im_saldo_cap   MONEY,
    im_moneda      SMALLINT,
    im_tipo        CHAR (1),
    im_monto       MONEY,
    im_monto_dol   MONEY,
    im_tasa_dol    MONEY,
    im_monto_ml    MONEY,
    im_tasa_ml     MONEY,
    im_estado      CHAR (1),
    im_sec_mesa    INT,
    im_comprobante INT,
    im_fecha_cont  DATETIME
    )
GO

CREATE INDEX ca_mesa_cambio1
    ON dbo.ca_interfaz_mesacambio (im_sec_mesa)
GO

CREATE UNIQUE INDEX ca_mesa_cambio_Key
    ON dbo.ca_interfaz_mesacambio (im_producto, im_secuencial)
GO

IF OBJECT_ID ('dbo.ca_interfaz_mbs') IS NOT NULL
    DROP TABLE dbo.ca_interfaz_mbs
GO

CREATE TABLE dbo.ca_interfaz_mbs
    (
    in_secuencial   INT NOT NULL,
    in_operacion    INT NOT NULL,
    in_producto     TINYINT,
    in_ofi_oper     SMALLINT,
    in_cliente      INT,
    in_forma_pago   catalogo,
    in_cuenta       cuenta,
    in_tipo_trn     catalogo,
    in_moneda       TINYINT,
    in_val_aplicar  MONEY,
    in_banco        cuenta,
    in_val_aplicado MONEY,
    in_estado       CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_interes_proyectado_tmp') IS NOT NULL
    DROP TABLE dbo.ca_interes_proyectado_tmp
GO

CREATE TABLE dbo.ca_interes_proyectado_tmp
    (
    concepto  catalogo,
    valor     MONEY NOT NULL,
    operacion INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_informe_anual_pagos') IS NOT NULL
    DROP TABLE dbo.ca_informe_anual_pagos
GO

CREATE TABLE dbo.ca_informe_anual_pagos
    (
    pa_cliente               INT,
    pa_tramite               INT,
    pa_consecutivo           cuenta,
    pa_tipo_certificado      VARCHAR (15),
    pa_anio_gravable         INT,
    pa_oficina               INT,
    pa_des_ofi               VARCHAR (35),
    pa_ciudad                VARCHAR (35),
    pa_direccion_ofi         VARCHAR (50),
    pa_nombre                VARCHAR (40),
    pa_ced_ruc               cuenta,
    pa_tipo_deudor           VARCHAR (20),
    pa_anio_solicitado       INT,
    pa_banco                 cuenta,
    pa_linea                 VARCHAR (35),
    pa_modalidad             VARCHAR (20),
    pa_monto_desembolsado    MONEY,
    pa_saldo_anio_anterior   MONEY,
    pa_saldo_anio_solicitado MONEY,
    pa_valor_pagado_trubro   MONEY,
    pa_valor_pagado_int      MONEY,
    pa_deducible             MONEY,
    pa_decreto               MONEY
    )
GO

CREATE INDEX ca_informe_anual_pagos_1
    ON dbo.ca_informe_anual_pagos (pa_banco)
GO

IF OBJECT_ID ('dbo.ca_info_extracto') IS NOT NULL
    DROP TABLE dbo.ca_info_extracto
GO

CREATE TABLE dbo.ca_info_extracto
    (
    ie_numero_obligacion     cuenta NOT NULL,
    ie_tipo_producto         VARCHAR (50),
    ie_oficina_obligacion    VARCHAR (20),
    ie_nombre                descripcion,
    ie_direccion             VARCHAR (255),
    ie_ciudad                descripcion,
    ie_fecha_proceso         DATETIME NOT NULL,
    ie_fecha_ult_facturacion DATETIME,
    ie_saldo_cap             MONEY,
    ie_tasa_efectiva         FLOAT,
    ie_tasa_mora_efectiva    FLOAT,
    ie_numero_cuota          SMALLINT,
    ie_saldo_mora_cap        MONEY,
    ie_num_cuotas_enmora     SMALLINT,
    ie_frecuencia_int        VARCHAR (18),
    ie_frecuencia_cap        VARCHAR (18),
    ie_mora_desde            DATETIME,
    ie_referencia            VARCHAR (255),
    ie_abono_capital_ant     MONEY,
    ie_abono_int_ant         MONEY,
    ie_abono_intmora_ant     MONEY,
    ie_seguros_ant           MONEY,
    ie_otros_cargos_ant      MONEY,
    ie_total_abono_ant       MONEY,
    ie_abono_capital         MONEY,
    ie_abono_int             MONEY,
    ie_abono_intmora         MONEY,
    ie_seguros               MONEY,
    ie_otros_cargos          MONEY,
    ie_total_abono           MONEY,
    ie_fecha_ven             DATETIME,
    ie_fecha_liq             DATETIME,
    ie_monto                 MONEY,
    ie_departamento          VARCHAR (20),
    ie_moneda                descripcion,
    ie_total_cuotas          SMALLINT,
    ie_tipo_amortizacion     catalogo,
    ie_formula_tasa          VARCHAR (30),
    ie_cotizacion_pago       FLOAT,
    ie_cuotas_acobrar        CHAR (15),
    ie_plazo_total           catalogo,
    ie_saldo_cap_u           MONEY,
    ie_saldo_mora_cap_u      MONEY,
    ie_abono_capital_ant_u   MONEY,
    ie_abono_int_ant_u       MONEY,
    ie_abono_intmora_ant_u   MONEY,
    ie_seguros_ant_u         MONEY,
    ie_otros_cargos_ant_u    MONEY,
    ie_total_abono_ant_u     MONEY,
    ie_abono_capital_u       MONEY,
    ie_abono_int_u           MONEY,
    ie_abono_intmora_u       MONEY,
    ie_seguros_u             MONEY,
    ie_otros_cargos_u        MONEY,
    ie_total_abono_u         MONEY,
    ie_monto_u               MONEY,
    ie_migrada               cuenta,
    ie_sujeto_credito        catalogo,
    ie_tipo_productor        catalogo,
    ie_tipo_banca            catalogo,
    ie_mercado               catalogo,
    ie_mercado_objetivo      catalogo,
    ie_cod_linea             catalogo,
    ie_destino_economico     catalogo,
    ie_zona                  INT,
    ie_regional              INT,
    ie_estado_op             TINYINT,
    ie_cod_oficina           INT
    )
GO

CREATE INDEX ca_info_extracto_1
    ON dbo.ca_info_extracto (ie_numero_obligacion)
GO

IF OBJECT_ID ('dbo.ca_inf_general_evaluacion') IS NOT NULL
    DROP TABLE dbo.ca_inf_general_evaluacion
GO

CREATE TABLE dbo.ca_inf_general_evaluacion
    (
    ev_regional                descripcion,
    ev_zona                    descripcion,
    ev_oficina                 INT,
    ev_codigo_contable         INT,
    ev_nombre_cliente          descripcion,
    ev_numero_obligacion       cuenta,
    ev_fecha_cliente_desde     DATETIME,
    ev_municipio               descripcion,
    ev_identificacion          numero,
    ev_calif_superiores        CHAR (2),
    ev_num_reestructuraciones  INT,
    ev_motivo_reestructuracion descripcion,
    ev_dias_mora               INT,
    ev_tipo_garantia           descripcion,
    ev_descripcion_garantia    descripcion,
    ev_cubre_acreencias        CHAR (2),
    ev_fecha_avaluo            DATETIME,
    ev_valor_avaluo            MONEY,
    ev_deudas_castigadas       catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_inf_codeu_evaluacion') IS NOT NULL
    DROP TABLE dbo.ca_inf_codeu_evaluacion
GO

CREATE TABLE dbo.ca_inf_codeu_evaluacion
    (
    cd_numero_obligacion cuenta,
    cd_tipo              CHAR (1),
    cd_nombre            descripcion,
    cd_identificacion    VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_impresion_carta') IS NOT NULL
    DROP TABLE dbo.ca_impresion_carta
GO

CREATE TABLE dbo.ca_impresion_carta
    (
    impc_fecha       DATETIME,
    impc_oficina     INT,
    impc_nro_cartas  INT,
    impc_nro_bloques INT,
    impc_bloque      INT,
    impc_ini         INT,
    impc_fin         INT,
    impc_user        login
    )
GO

IF OBJECT_ID ('dbo.ca_homologar') IS NOT NULL
    DROP TABLE dbo.ca_homologar
GO

CREATE TABLE dbo.ca_homologar
    (
    ho_tabla      VARCHAR (20),
    ho_codigo_org VARCHAR (20),
    ho_tipo       CHAR (1),
    ho_texto      VARCHAR (20),
    ho_entero     INT
    )
GO

CREATE CLUSTERED INDEX ca_homologar_1
    ON dbo.ca_homologar (ho_tabla, ho_codigo_org)
    WITH (FILLFACTOR = 70)
GO

IF OBJECT_ID ('dbo.ca_homologa_otros_pag') IS NOT NULL
    DROP TABLE dbo.ca_homologa_otros_pag
GO

CREATE TABLE dbo.ca_homologa_otros_pag
    (
    ho_oficina     VARCHAR (10),
    ho_tipo        VARCHAR (2),
    ho_codigo_org  VARCHAR (20),
    ho_texto       VARCHAR (20),
    ho_descripcion VARCHAR (100),
    ho_cuenta1     VARCHAR (20),
    ho_cuenta2     VARCHAR (20)
    )
GO

CREATE INDEX ca_homologa_otros_pag_1
    ON dbo.ca_homologa_otros_pag (ho_tipo, ho_codigo_org)
GO

CREATE INDEX ca_homologa_otros_pag_2
    ON dbo.ca_homologa_otros_pag (ho_texto, ho_tipo)
GO

IF OBJECT_ID ('dbo.ca_historia_tran') IS NOT NULL
    DROP TABLE dbo.ca_historia_tran
GO

CREATE TABLE dbo.ca_historia_tran
    (
    ht_operacion  INT NOT NULL,
    ht_secuencial INT NOT NULL,
    ht_lugar      TINYINT NOT NULL,
    ht_fecha      DATETIME NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_historia_tran_1
    ON dbo.ca_historia_tran (ht_operacion, ht_secuencial)
GO

IF OBJECT_ID ('dbo.ca_hcuadre') IS NOT NULL
    DROP TABLE dbo.ca_hcuadre
GO

CREATE TABLE dbo.ca_hcuadre
    (
    hc_fecha       DATETIME,
    hc_banco       cuenta,
    hc_saldo_cap   MONEY,
    hc_saldo_int   MONEY,
    hc_saldo_otros MONEY,
    hc_suspenso    MONEY,
    hc_moneda      SMALLINT
    )
GO

CREATE UNIQUE INDEX ca_hcuadre_1
    ON dbo.ca_hcuadre (hc_fecha, hc_banco)
GO

IF OBJECT_ID ('dbo.ca_gracia_seguros') IS NOT NULL
    DROP TABLE dbo.ca_gracia_seguros
GO

CREATE TABLE dbo.ca_gracia_seguros
    (
    gs_operacion          INT,
    gs_fecha_regeneracion DATETIME,
    gs_cuota              INT
    )
GO

CREATE INDEX ca_gracia_seguros_1
    ON dbo.ca_gracia_seguros (gs_operacion)
GO

IF OBJECT_ID ('dbo.ca_gestion_cobranza_palm_tmp') IS NOT NULL
    DROP TABLE dbo.ca_gestion_cobranza_palm_tmp
GO

CREATE TABLE dbo.ca_gestion_cobranza_palm_tmp
    (
    cod_oficina       INT,
    nom_oficina       VARCHAR (64),
    ejecutivo         INT,
    nom_ejecutivo     VARCHAR (64),
    banco             cuenta,
    nom_cliente       VARCHAR (64),
    dias_imo          INT,
    saldo_cap         MONEY,
    saldo_vencido     MONEY,
    saldo_cancelacion MONEY,
    valor_cuota       MONEY,
    estado_Operativo  SMALLINT,
    estado_Cobranza   catalogo,
    indicador_Gestion catalogo,
    gestion           descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_garantias_tramite') IS NOT NULL
    DROP TABLE dbo.ca_garantias_tramite
GO

CREATE TABLE dbo.ca_garantias_tramite
    (
    gp_sesion   INT,
    gp_garantia VARCHAR (64),
    cu_tipo     descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_gar_propuesta_tmp') IS NOT NULL
    DROP TABLE dbo.ca_gar_propuesta_tmp
GO

CREATE TABLE dbo.ca_gar_propuesta_tmp
    (
    gpt_tramite             INT,
    gpt_garantia            VARCHAR (64),
    gpt_clasificacion       CHAR (1),
    gpt_exceso              CHAR (1),
    gpt_monto_exceso        MONEY,
    gpt_abierta             CHAR (1),
    gpt_deudor              INT,
    gpt_est_garantia        CHAR (1),
    gpt_porcentaje          FLOAT,
    gpt_valor_resp_garantia MONEY,
    gpt_fecha_mod           DATETIME,
    gpt_proceso             CHAR (1),
    gpt_procesado           VARCHAR (1),
    gpt_previa              VARCHAR (1),
    gpt_tramite_E           INT
    )
GO

IF OBJECT_ID ('dbo.ca_fval_masivo') IS NOT NULL
    DROP TABLE dbo.ca_fval_masivo
GO

CREATE TABLE dbo.ca_fval_masivo
    (
    fm_banco       cuenta,
    fm_fecha_valor DATETIME NOT NULL,
    fm_usuario     VARCHAR (30) NOT NULL,
    fm_fecha_ing   DATETIME NOT NULL,
    fm_terminal    VARCHAR (30) NOT NULL,
    fm_estado      CHAR (1) NOT NULL
    )
GO

CREATE INDEX ca_fval_Akey
    ON dbo.ca_fval_masivo (fm_banco)
GO

CREATE INDEX ca_fval_Bkey
    ON dbo.ca_fval_masivo (fm_estado)
GO

IF OBJECT_ID ('dbo.ca_formatos_normalizacion_cca') IS NOT NULL
    DROP TABLE dbo.ca_formatos_normalizacion_cca
GO

CREATE TABLE dbo.ca_formatos_normalizacion_cca
    (
    usuario             login,
    tramite             INT,
    tipo_normalizacion  CHAR (1),
    nombre_titular      VARCHAR (64),
    tipoDoc_titular     VARCHAR (2),
    ced_ruc_titular     VARCHAR (30),
    nombre_codeudor     VARCHAR (64),
    tipoDoc_codeudor    VARCHAR (2),
    ced_ruc_codeudor    VARCHAR (30),
    ciudad              VARCHAR (64),
    fecha               DATETIME,
    cod_oficina         INT,
    nombre_oficina      VARCHAR (64),
    nro_operacion1      VARCHAR (20),
    nro_operacion2      VARCHAR (20),
    nro_operacion3      VARCHAR (20),
    nro_operacion_new   VARCHAR (20),
    saldo_new_operacion MONEY,
    tipo_amor_newOp     VARCHAR (15),
    fecha_ven_new_oper  DATETIME,
    tasa_efa_new_oper   FLOAT,
    monto_desembolsado  MONEY,
    fecha_ven_antesPro  VARCHAR (15),
    fecha_ven_despPro   VARCHAR (15)
    )
GO

IF OBJECT_ID ('dbo.ca_fng_devoluciones') IS NOT NULL
    DROP TABLE dbo.ca_fng_devoluciones
GO

CREATE TABLE dbo.ca_fng_devoluciones
    (
    ro_codigo_cliente      INT NOT NULL,
    ro_nombre_cliente      descripcion NOT NULL,
    ro_banco_ren           VARCHAR (24) NOT NULL,
    ro_banco_reest         VARCHAR (24) NOT NULL,
    ro_fecha_liq_ren       DATETIME NOT NULL,
    ro_oficina             INT NOT NULL,
    ro_monto_ren           MONEY NOT NULL,
    ro_comision_fng_ren    MONEY NOT NULL,
    ro_iva_fng_ren         MONEY NOT NULL,
    ro_comision_fng_reest  MONEY NOT NULL,
    ro_iva_fng_reest       MONEY NOT NULL,
    ro_valor_reintegro_fng MONEY NOT NULL,
    ro_aplica_pago_fng     CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_fng_16_tmp') IS NOT NULL
    DROP TABLE dbo.ca_fng_16_tmp
GO

CREATE TABLE dbo.ca_fng_16_tmp
    (
    referencia      VARCHAR (11),
    tipo_mod        CHAR (2),
    nit_intermed    VARCHAR (10),
    cod_sucursal    VARCHAR (10),
    nro_gar_fng     VARCHAR (13),
    id_deudor       CHAR (1),
    evento_cca      CHAR (1),
    even_cca_fecha  CHAR (1),
    municipio_deu   CHAR (1),
    plazo_credito   INT,
    cod_plazo       CHAR (1),
    nro_canones     CHAR (1),
    campo_reserv1   CHAR (1),
    dir_deu         CHAR (1),
    monto           CHAR (1),
    cod_moneda      CHAR (1),
    saldo           CHAR (1),
    nuevo_nit       CHAR (1),
    porc_cober      CHAR (1),
    destino         CHAR (1),
    tipo_recurso    CHAR (1),
    vlor_redes      CHAR (1),
    porce_redes     CHAR (1),
    nit_entidad_r   CHAR (1),
    new_cod_fng     CHAR (1),
    new_cod_sucur   CHAR (1),
    new_referencia  CHAR (1),
    new_cod_pagare  CHAR (1),
    new_tipo_id     CHAR (1),
    new_nro_id      CHAR (1),
    razon_social    CHAR (1),
    tel_deudor      CHAR (1),
    campo_reserv2   CHAR (1),
    cal_riesgo_code CHAR (1),
    per_cobro_comi  CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_findeter') IS NOT NULL
    DROP TABLE dbo.ca_findeter
GO

CREATE TABLE dbo.ca_findeter
    (
    ca_fecha_proceso   DATETIME,
    ca_nro_credito     cuenta,
    ca_beneficiario    VARCHAR (128),
    ca_referencia      cuenta,
    ca_saldo_cap       MONEY,
    ca_capital         MONEY,
    ca_fecha_ini_cuota DATETIME,
    ca_fecha_fin_cuota DATETIME,
    ca_dias            INT,
    ca_modalidad       CHAR (1),
    ca_tasa_redes      VARCHAR (30),
    ca_tasa            FLOAT,
    ca_interes         MONEY,
    ca_neto_pag        MONEY,
    ca_nit             VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_finagro') IS NOT NULL
    DROP TABLE dbo.ca_finagro
GO

CREATE TABLE dbo.ca_finagro
    (
    ca_llave cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_fechas_diff') IS NOT NULL
    DROP TABLE dbo.ca_fechas_diff
GO

CREATE TABLE dbo.ca_fechas_diff
    (
    oper INT NOT NULL,
    sec  INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_fecha_reest_control') IS NOT NULL
    DROP TABLE dbo.ca_fecha_reest_control
GO

CREATE TABLE dbo.ca_fecha_reest_control
    (
    fr_operacion INT NOT NULL,
    fr_fecha     DATETIME
    )
GO

CREATE INDEX idx1
    ON dbo.ca_fecha_reest_control (fr_operacion)
GO

IF OBJECT_ID ('dbo.ca_fecha') IS NOT NULL
    DROP TABLE dbo.ca_fecha
GO

CREATE TABLE dbo.ca_fecha
    (
    fe_fecha VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_facturas_tmp') IS NOT NULL
    DROP TABLE dbo.ca_facturas_tmp
GO

CREATE TABLE dbo.ca_facturas_tmp
    (
    gt_operacion INT NOT NULL,
    gt_usuario   login NOT NULL,
    gt_dividendo SMALLINT NOT NULL,
    gt_fecha_ven DATETIME NOT NULL,
    gt_capital   MONEY,
    gt_int_pag   MONEY,
    gt_int_acum  MONEY,
    gt_mora      MONEY,
    gt_seg       MONEY,
    gt_otros     MONEY
    )
GO

CREATE INDEX facturas_tmp_key
    ON dbo.ca_facturas_tmp (gt_operacion, gt_usuario, gt_dividendo)
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

IF OBJECT_ID ('dbo.ca_facturacion_recaudos_his') IS NOT NULL
    DROP TABLE dbo.ca_facturacion_recaudos_his
GO

CREATE TABLE dbo.ca_facturacion_recaudos_his
    (
    fh_codigo        SMALLINT NOT NULL,
    fh_fecha         DATETIME NOT NULL,
    fh_fecha_ven     DATETIME NOT NULL,
    fh_cedula        VARCHAR (14) NOT NULL,
    fh_banco         cuenta NOT NULL,
    fh_valor         MONEY NOT NULL,
    fh_valor_recaudo MONEY NOT NULL,
    fh_iva_recaudo   MONEY NOT NULL,
    fh_dividendo     SMALLINT NOT NULL,
    fh_operacion     INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_facturacion_recaudos_his
    ON dbo.ca_facturacion_recaudos_his (fh_codigo, fh_fecha, fh_banco)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_f127_masivo') IS NOT NULL
    DROP TABLE dbo.ca_f127_masivo
GO

CREATE TABLE dbo.ca_f127_masivo
    (
    ma_user                login NOT NULL,
    ma_codigo_prepago      catalogo NOT NULL,
    ma_fecha_prepago       DATETIME NOT NULL,
    ma_banco_segundo_piso  catalogo NOT NULL,
    ma_banco               cuenta NOT NULL,
    ma_llave_redes         cuenta NOT NULL,
    ma_tipo_novedad        CHAR (1) NOT NULL,
    ma_cod_ofi_cen         CHAR (3) NOT NULL,
    ma_cod_linea           catalogo NOT NULL,
    ma_fecha_redes         DATETIME NOT NULL,
    ma_consecutivo_fina    catalogo NOT NULL,
    ma_num_novedades       catalogo NOT NULL,
    ma_nombre_cliente      descripcion NOT NULL,
    ma_identificacion      numero NOT NULL,
    ma_tipo_identificacion catalogo NOT NULL,
    ma_num_pagare          descripcion NOT NULL,
    ma_margen_redes        FLOAT NOT NULL,
    ma_modalidad_int       CHAR (1) NOT NULL,
    ma_fecha_prox_pago     DATETIME,
    ma_tipo_reduccion      CHAR (1) NOT NULL,
    ma_valor_prepago       MONEY NOT NULL,
    ma_fecha_generacion    DATETIME NOT NULL,
    ma_sec                 INT,
    ma_valor_saldo         MONEY
    )
GO

CREATE INDEX ca_f127_masivo_1
    ON dbo.ca_f127_masivo (ma_user, ma_codigo_prepago, ma_fecha_generacion, ma_banco_segundo_piso)
GO

IF OBJECT_ID ('dbo.ca_extracto_linea_tmp') IS NOT NULL
    DROP TABLE dbo.ca_extracto_linea_tmp
GO

CREATE TABLE dbo.ca_extracto_linea_tmp
    (
    exl_user              login NOT NULL,
    exl_obligacion        cuenta NOT NULL,
    exl_cliente           INT NOT NULL,
    exl_tipo_deuda        VARCHAR (10) NOT NULL,
    exl_nom_indirectas    VARCHAR (30),
    exl_iden_indirectas   VARCHAR (20),
    exl_linea             catalogo,
    exl_clase_car         VARCHAR (20),
    exl_tasa_pactada      VARCHAR (20),
    exl_calificacion      CHAR (1),
    exl_fecha_desembolso  DATETIME,
    exl_valor_desembolso  MONEY,
    exl_saldo_cap         MONEY,
    exl_saldo_int         MONEY,
    exl_saldo_int_imo     MONEY,
    exl_saldo_int_ctg     MONEY,
    exl_saldo_ctg_imo_int MONEY,
    exl_saldo_otros       MONEY,
    exl_prov_cap          MONEY,
    exl_prov_int          MONEY,
    exl_prov_otros        MONEY,
    exl_dias_vencimiento  INT,
    exl_nom_codeudor      VARCHAR (30),
    exl_iden_codeudor     VARCHAR (20),
    exl_disponible        MONEY,
    exl_fecha_ini_mora    DATETIME,
    exl_tipo_cartera      catalogo NULL,
    exl_subtipo_cartera   catalogo NULL
    )
GO

IF OBJECT_ID ('dbo.ca_extracto_linea_bat') IS NOT NULL
    DROP TABLE dbo.ca_extracto_linea_bat
GO

CREATE TABLE dbo.ca_extracto_linea_bat
    (
    el_fecha_proceso    DATETIME,
    el_corte            INT,
    el_fecha_desde      DATETIME,
    el_fecha_hasta      DATETIME,
    el_cliente          INT,
    el_direccion        VARCHAR (255),
    el_ciudad           INT,
    el_banco            cuenta,
    el_oficina          INT,
    el_fecha_ini_op     DATETIME,
    el_fecha_fin_op     DATETIME,
    el_monto_apr_op     MONEY,
    el_fpago_int        VARCHAR (20),
    el_toperacion       catalogo,
    el_tasa_nominal     FLOAT,
    el_tasa_efa         FLOAT,
    el_tasa_mora        FLOAT,
    el_vlr_prox_couta   MONEY,
    el_vlr_saldo        MONEY,
    el_fecha_prox_cuota DATETIME,
    el_fecha_pago       VARCHAR (10),
    el_fecha_tasa_apl   DATETIME,
    el_periodo          CHAR (2),
    el_tasa_apl         FLOAT,
    el_fecha_tasa_max   DATETIME,
    el_tasa_max_mora    FLOAT,
    el_tasa_max_usura   FLOAT,
    el_mensaje          VARCHAR (255),
    el_banca            catalogo
    )
GO

CREATE INDEX id_x1
    ON dbo.ca_extracto_linea_bat (el_corte, el_fecha_desde, el_fecha_hasta)
GO

IF OBJECT_ID ('dbo.ca_estados_rubro_ts') IS NOT NULL
    DROP TABLE dbo.ca_estados_rubro_ts
GO

CREATE TABLE dbo.ca_estados_rubro_ts
    (
    ers_fecha_proceso_ts DATETIME NOT NULL,
    ers_fecha_ts         DATETIME NOT NULL,
    ers_usuario_ts       login NOT NULL,
    ers_oficina_ts       SMALLINT NOT NULL,
    ers_terminal_ts      VARCHAR (30) NOT NULL,
    ers_toperacion       catalogo NOT NULL,
    ers_concepto         catalogo NOT NULL,
    ers_estado           TINYINT NOT NULL,
    ers_dias_cont        INT NOT NULL,
    ers_dias_fin         INT NOT NULL
    )
GO

CREATE INDEX ca_estados_rubro_ts_1
    ON dbo.ca_estados_rubro_ts (ers_fecha_proceso_ts)
GO

CREATE INDEX ca_estados_rubro_ts_2
    ON dbo.ca_estados_rubro_ts (ers_fecha_ts)
GO

CREATE INDEX ca_estados_rubro_ts_3
    ON dbo.ca_estados_rubro_ts (ers_usuario_ts)
GO

CREATE INDEX ca_estados_rubro_ts_4
    ON dbo.ca_estados_rubro_ts (ers_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_estados_rubro') IS NOT NULL
    DROP TABLE dbo.ca_estados_rubro
GO

CREATE TABLE dbo.ca_estados_rubro
    (
    er_toperacion catalogo NOT NULL,
    er_concepto   catalogo NOT NULL,
    er_estado     TINYINT NOT NULL,
    er_dias_cont  INT NOT NULL,
    er_dias_fin   INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_estados_man_ts') IS NOT NULL
    DROP TABLE dbo.ca_estados_man_ts
GO

CREATE TABLE dbo.ca_estados_man_ts
    (
    ems_fecha_proceso_ts DATETIME NOT NULL,
    ems_fecha_ts         DATETIME NOT NULL,
    ems_usuario_ts       login NOT NULL,
    ems_oficina_ts       SMALLINT NOT NULL,
    ems_terminal_ts      VARCHAR (30) NOT NULL,
    ems_toperacion       catalogo NOT NULL,
    ems_tipo_cambio      CHAR (1) NOT NULL,
    ems_estado_ini       TINYINT NOT NULL,
    ems_estado_fin       TINYINT NOT NULL,
    ems_dias_cont        INT,
    ems_dias_fin         INT NOT NULL
    )
GO

CREATE INDEX ca_estados_man_ts_1
    ON dbo.ca_estados_man_ts (ems_fecha_proceso_ts)
GO

CREATE INDEX ca_estados_man_ts_2
    ON dbo.ca_estados_man_ts (ems_fecha_ts)
GO

CREATE INDEX ca_estados_man_ts_3
    ON dbo.ca_estados_man_ts (ems_usuario_ts)
GO

CREATE INDEX ca_estados_man_ts_4
    ON dbo.ca_estados_man_ts (ems_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_estados_man') IS NOT NULL
    DROP TABLE dbo.ca_estados_man
GO

CREATE TABLE dbo.ca_estados_man
    (
    em_toperacion  catalogo NOT NULL,
    em_tipo_cambio CHAR (1) NOT NULL,
    em_estado_ini  TINYINT NOT NULL,
    em_estado_fin  TINYINT NOT NULL,
    em_dias_cont   INT,
    em_dias_fin    INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_estado_virtual') IS NOT NULL
    DROP TABLE dbo.ca_estado_virtual
GO

CREATE TABLE dbo.ca_estado_virtual
    (
    es_codigo      TINYINT NOT NULL,
    es_descripcion descripcion NOT NULL,
    es_procesa     CHAR (1) NOT NULL,
    es_acepta_pago CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_estado_ts') IS NOT NULL
    DROP TABLE dbo.ca_estado_ts
GO

CREATE TABLE dbo.ca_estado_ts
    (
    ess_fecha_proceso_ts DATETIME NOT NULL,
    ess_fecha_ts         DATETIME NOT NULL,
    ess_usuario_ts       login NOT NULL,
    ess_oficina_ts       SMALLINT NOT NULL,
    ess_terminal_ts      VARCHAR (30) NOT NULL,
    ess_operacion_ts     CHAR (1) NOT NULL,
    ess_codigo           TINYINT NOT NULL,
    ess_descripcion      descripcion NOT NULL,
    ess_procesa          CHAR (1) NOT NULL,
    ess_acepta_pago      CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_estado') IS NOT NULL
    DROP TABLE dbo.ca_estado
GO

CREATE TABLE dbo.ca_estado
    (
    es_codigo      TINYINT NOT NULL,
    es_descripcion descripcion NOT NULL,
    es_procesa     CHAR (1) NOT NULL,
    es_acepta_pago CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_estado_1
    ON dbo.ca_estado (es_codigo)
GO

IF OBJECT_ID ('dbo.ca_errorlog') IS NOT NULL
    DROP TABLE dbo.ca_errorlog
GO

CREATE TABLE dbo.ca_errorlog
    (
    er_fecha_proc  DATETIME NOT NULL,
    er_error       INT,
    er_usuario     login,
    er_tran        INT,
    er_cuenta      cuenta,
    er_descripcion VARCHAR (255),
    er_anexo       VARCHAR (255)
    )
GO

CREATE INDEX ca_errorlog_1
    ON dbo.ca_errorlog (er_fecha_proc, er_cuenta)
GO

IF OBJECT_ID ('dbo.ca_errores_ts') IS NOT NULL
    DROP TABLE dbo.ca_errores_ts
GO

CREATE TABLE dbo.ca_errores_ts
    (
    er_numero     INT,
    er_severidad  INT,
    er_mensaje    VARCHAR (255),
    er_fecha_hora DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_errores_finales') IS NOT NULL
    DROP TABLE dbo.ca_errores_finales
GO

CREATE TABLE dbo.ca_errores_finales
    (
    ef_banco       cuenta,
    ef_error       INT,
    ef_descripcion VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_err_camlinfin') IS NOT NULL
    DROP TABLE dbo.ca_err_camlinfin
GO

CREATE TABLE dbo.ca_err_camlinfin
    (
    Fecha        VARCHAR (10),
    No_Operacion cuenta,
    Mensaje      VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_en_temporales') IS NOT NULL
    DROP TABLE dbo.ca_en_temporales
GO

CREATE TABLE dbo.ca_en_temporales
    (
    en_usuario   login NOT NULL,
    en_terminal  VARCHAR (30) NOT NULL,
    en_operacion INT NOT NULL
    )
GO

CREATE INDEX idx_ca_en_temporales_1
    ON dbo.ca_en_temporales (en_operacion)
GO

IF OBJECT_ID ('dbo.ca_en_fecha_valor') IS NOT NULL
    DROP TABLE dbo.ca_en_fecha_valor
GO

CREATE TABLE dbo.ca_en_fecha_valor
    (
    bi_operacion   INT NOT NULL,
    bi_banco       cuenta NOT NULL,
    bi_fecha_valor DATETIME NOT NULL,
    bi_user        login
    )
GO

CREATE CLUSTERED INDEX ca_en_fecha_valor_Key
    ON dbo.ca_en_fecha_valor (bi_operacion)
GO

IF OBJECT_ID ('dbo.ca_elim_cliente_COfertas_tmp') IS NOT NULL
    DROP TABLE dbo.ca_elim_cliente_COfertas_tmp
GO

CREATE TABLE dbo.ca_elim_cliente_COfertas_tmp
    (
    el_oficina  INT NOT NULL,
    el_tipo_ced CHAR (2) NOT NULL,
    el_ced_ruc  numero NOT NULL,
    el_campana  INT
    )
GO

IF OBJECT_ID ('dbo.ca_EjeRango_Listmp') IS NOT NULL
    DROP TABLE dbo.ca_EjeRango_Listmp
GO

CREATE TABLE dbo.ca_EjeRango_Listmp
    (
    rmt_secuencial INT IDENTITY NOT NULL,
    rmt_eje        INT,
    rmt_rango      INT,
    rmt_desde      VARCHAR (20),
    rmt_hasta      VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_eje_xmatriz_tmp') IS NOT NULL
    DROP TABLE dbo.ca_eje_xmatriz_tmp
GO

CREATE TABLE dbo.ca_eje_xmatriz_tmp
    (
    rmt_secuencial      INT IDENTITY NOT NULL,
    rmt_matriz          catalogo,
    rmt_eje             INT,
    rmt_descripcion     VARCHAR (20),
    rmt_rango           INT,
    rmt_desde           VARCHAR (20),
    rmt_hasta           VARCHAR (20),
    rmt_indicador_rango CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_eje_ts') IS NOT NULL
    DROP TABLE dbo.ca_eje_ts
GO

CREATE TABLE dbo.ca_eje_ts
    (
    ejs_user          login,
    ejs_oficina_ts    INT,
    ejs_terminal_ts   catalogo,
    ejs_tipo_cambio   CHAR (1),
    ejs_fecha_real    SMALLDATETIME,
    ejs_matriz        catalogo,
    ejs_descripcion   VARCHAR (60),
    ejs_fecha_vig     SMALLDATETIME,
    ejs_eje           INT,
    ejs_tipo_dato     CHAR (1),
    ejs_rango         CHAR (1),
    ejs_valor_default VARCHAR (60)
    )
GO

IF OBJECT_ID ('dbo.ca_eje_tmp') IS NOT NULL
    DROP TABLE dbo.ca_eje_tmp
GO

CREATE TABLE dbo.ca_eje_tmp
    (
    ejt_matriz        catalogo NOT NULL,
    ejt_descripcion   VARCHAR (60) NOT NULL,
    ejt_fecha_vig     SMALLDATETIME NOT NULL,
    ejt_eje           INT NOT NULL,
    ejt_tipo_dato     CHAR (1) NOT NULL,
    ejt_rango         CHAR (1) NOT NULL,
    ejt_valor_default VARCHAR (60)
    )
GO

IF OBJECT_ID ('dbo.ca_eje_rango_ts') IS NOT NULL
    DROP TABLE dbo.ca_eje_rango_ts
GO

CREATE TABLE dbo.ca_eje_rango_ts
    (
    ers_user        login,
    ers_oficina_ts  INT,
    ers_terminal_ts catalogo,
    ers_tipo_cambio CHAR (1),
    ers_fecha_real  SMALLDATETIME,
    ers_matriz      catalogo,
    ers_fecha_vig   SMALLDATETIME,
    ers_eje         INT,
    ers_rango       INT,
    ers_rango_desde VARCHAR (20),
    ers_rango_hasta VARCHAR (20)
    )
GO

IF OBJECT_ID ('dbo.ca_eje_rango_tmp') IS NOT NULL
    DROP TABLE dbo.ca_eje_rango_tmp
GO

CREATE TABLE dbo.ca_eje_rango_tmp
    (
    ert_matriz      catalogo NOT NULL,
    ert_fecha_vig   SMALLDATETIME NOT NULL,
    ert_eje         INT NOT NULL,
    ert_rango       INT NOT NULL,
    ert_rango_desde VARCHAR (20) NOT NULL,
    ert_rango_hasta VARCHAR (20) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_eje_rango') IS NOT NULL
    DROP TABLE dbo.ca_eje_rango
GO

CREATE TABLE dbo.ca_eje_rango
    (
    er_matriz      catalogo NOT NULL,
    er_fecha_vig   SMALLDATETIME NOT NULL,
    er_eje         INT NOT NULL,
    er_rango       INT NOT NULL,
    er_rango_desde VARCHAR (20) NOT NULL,
    er_rango_hasta VARCHAR (20) NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_eje_rango_1
    ON dbo.ca_eje_rango (er_matriz, er_fecha_vig, er_eje, er_rango)
GO

IF OBJECT_ID ('dbo.ca_eje') IS NOT NULL
    DROP TABLE dbo.ca_eje
GO

CREATE TABLE dbo.ca_eje
    (
    ej_matriz        catalogo NOT NULL,
    ej_descripcion   VARCHAR (60) NOT NULL,
    ej_fecha_vig     SMALLDATETIME NOT NULL,
    ej_eje           INT NOT NULL,
    ej_tipo_dato     CHAR (1) NOT NULL,
    ej_rango         CHAR (1) NOT NULL,
    ej_valor_default VARCHAR (60)
    )
GO

CREATE UNIQUE INDEX ca_eje_1
    ON dbo.ca_eje (ej_matriz, ej_fecha_vig, ej_eje)
GO

IF OBJECT_ID ('dbo.ca_dpagosa_diario') IS NOT NULL
    DROP TABLE dbo.ca_dpagosa_diario
GO

CREATE TABLE dbo.ca_dpagosa_diario
    (
    cd_concepto catalogo,
    cd_monto    MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_dividendos_rot_tmp') IS NOT NULL
    DROP TABLE dbo.ca_dividendos_rot_tmp
GO

CREATE TABLE dbo.ca_dividendos_rot_tmp
    (
    dir_login     login NOT NULL,
    dir_operacion INT NOT NULL,
    dir_dividendo SMALLINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_dividendo_virtual') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_virtual
GO

CREATE TABLE dbo.ca_dividendo_virtual
    (
    di_operacion   INT NOT NULL,
    di_dividendo   SMALLINT NOT NULL,
    di_fecha_ini   DATETIME NOT NULL,
    di_fecha_ven   DATETIME NOT NULL,
    di_de_capital  CHAR (1) NOT NULL,
    di_de_interes  CHAR (1) NOT NULL,
    di_gracia      SMALLINT NOT NULL,
    di_gracia_disp SMALLINT NOT NULL,
    di_estado      TINYINT NOT NULL,
    di_dias_cuota  INT,
    di_intento     TINYINT,
    di_prorroga    CHAR (1),
    di_fecha_can   SMALLDATETIME NOT NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_dividendo_1
    ON dbo.ca_dividendo_virtual (di_operacion, di_dividendo)
GO

IF OBJECT_ID ('dbo.ca_dividendo_ts') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_ts
GO

CREATE TABLE dbo.ca_dividendo_ts
    (
    dis_fecha_proceso_ts DATETIME NOT NULL,
    dis_fecha_ts         DATETIME NOT NULL,
    dis_usuario_ts       login NOT NULL,
    dis_oficina_ts       SMALLINT NOT NULL,
    dis_terminal_ts      VARCHAR (30) NOT NULL,
    dis_operacion        INT NOT NULL,
    dis_dividendo        SMALLINT NOT NULL,
    dis_fecha_ini        DATETIME NOT NULL,
    dis_fecha_ven        DATETIME NOT NULL,
    dis_de_capital       CHAR (1) NOT NULL,
    dis_de_interes       CHAR (1) NOT NULL,
    dis_gracia           SMALLINT NOT NULL,
    dis_gracia_disp      SMALLINT NOT NULL,
    dis_estado           TINYINT NOT NULL,
    dis_dias_cuota       INT NOT NULL,
    dis_intento          TINYINT NOT NULL,
    dis_prorroga         CHAR (1) NOT NULL,
    dis_fecha_can        SMALLDATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_dividendo_tmp') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_tmp
GO

CREATE TABLE dbo.ca_dividendo_tmp
    (
    dit_operacion   INT NOT NULL,
    dit_dividendo   SMALLINT NOT NULL,
    dit_fecha_ini   DATETIME NOT NULL,
    dit_fecha_ven   DATETIME NOT NULL,
    dit_de_capital  CHAR (1) NOT NULL,
    dit_de_interes  CHAR (1) NOT NULL,
    dit_gracia      SMALLINT NOT NULL,
    dit_gracia_disp SMALLINT NOT NULL,
    dit_estado      TINYINT NOT NULL,
    dit_dias_cuota  INT NOT NULL,
    dit_intento     TINYINT NOT NULL,
    dit_prorroga    CHAR (1) NOT NULL,
    dit_fecha_can   SMALLDATETIME
    )
GO

CREATE INDEX idx1
    ON dbo.ca_dividendo_tmp (dit_operacion, dit_dividendo)
GO

IF OBJECT_ID ('dbo.ca_dividendo_original_tmp') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_original_tmp
GO

CREATE TABLE dbo.ca_dividendo_original_tmp
    (
    dot_operacion INT NOT NULL,
    dot_dividendo INT NOT NULL,
    dot_fecha_ini DATETIME NOT NULL,
    dot_fecha_ven DATETIME NOT NULL
    )
GO

CREATE INDEX ca_dividendo_original_tmp_1
    ON dbo.ca_dividendo_original_tmp (dot_operacion, dot_dividendo)
GO

IF OBJECT_ID ('dbo.ca_dividendo_original') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_original
GO

CREATE TABLE dbo.ca_dividendo_original
    (
    do_operacion INT NOT NULL,
    do_dividendo INT NOT NULL,
    do_fecha_ini DATETIME NOT NULL,
    do_fecha_ven DATETIME NOT NULL
    )
GO

CREATE INDEX ca_dividendo_original_1
    ON dbo.ca_dividendo_original (do_operacion, do_dividendo)
GO

IF OBJECT_ID ('dbo.ca_dividendo_his_plano') IS NOT NULL
    DROP TABLE dbo.ca_dividendo_his_plano
GO

CREATE TABLE dbo.ca_dividendo_his_plano
    (
    dihp_secuencial  INT,
    dihp_operacion   INT,
    dihp_dividendo   SMALLINT,
    dihp_fecha_ini   DATETIME,
    dihp_fecha_ven   DATETIME,
    dihp_de_capital  CHAR (1),
    dihp_de_interes  CHAR (1),
    dihp_gracia      SMALLINT,
    dihp_gracia_disp SMALLINT,
    dihp_estado      TINYINT,
    dihp_dias_cuota  INT,
    dihp_intento     TINYINT,
    dihp_prorroga    CHAR (1),
    dihp_fecha_can   DATETIME
    )
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

CREATE INDEX ca_dividendo_his_1
    ON dbo.ca_dividendo_his (dih_operacion, dih_secuencial)
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

CREATE UNIQUE CLUSTERED INDEX ca_dividendo_1
    ON dbo.ca_dividendo (di_operacion, di_dividendo)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_dividendo_2
    ON dbo.ca_dividendo (di_operacion, di_estado)
    WITH (FILLFACTOR = 90)
GO


CREATE NONCLUSTERED INDEX [ix_di_fechas] ON [dbo].[ca_dividendo]
(
	[di_fecha_ini] ASC,
	[di_fecha_ven] ASC
)
INCLUDE ( [di_operacion], [di_dividendo] ) 
GO

IF OBJECT_ID ('dbo.ca_diff_hc_Vs_conso') IS NOT NULL
    DROP TABLE dbo.ca_diff_hc_Vs_conso
GO

CREATE TABLE dbo.ca_diff_hc_Vs_conso
    (
    vd_fecha_proceso DATETIME,
    vd_producto      TINYINT,
    vd_moneda        TINYINT,
    vd_banco         cuenta,
    vd_cap           MONEY,
    vd_int           MONEY,
    vd_otros         MONEY,
    vd_suspenso      MONEY
    )
GO

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

CREATE INDEX idxh1
    ON dbo.ca_diferidos_his (difh_operacion, difh_secuencial)
GO

IF OBJECT_ID ('dbo.ca_diferidos') IS NOT NULL
    DROP TABLE dbo.ca_diferidos
GO

CREATE TABLE dbo.ca_diferidos
    (
    dif_operacion    INT NOT NULL,
    dif_valor_total  MONEY NOT NULL,
    dif_valor_pagado MONEY NOT NULL,
    dif_concepto     catalogo NOT NULL
    )
GO

CREATE INDEX idx1
    ON dbo.ca_diferidos (dif_operacion)
GO

IF OBJECT_ID ('dbo.ca_diferencias_tmp') IS NOT NULL
    DROP TABLE dbo.ca_diferencias_tmp
GO

CREATE TABLE dbo.ca_diferencias_tmp
    (
    cd_fecha_proceso      DATETIME,
    cd_linea              cuenta,
    cd_num_oper_cobis     cuenta,
    cd_num_oper_bancoldex cuenta,
    cd_ciudad             INT,
    cd_beneficiario       CHAR (30),
    cd_ref_externa        cuenta,
    cd_saldo_capital_c    MONEY,
    cd_saldo_capital_b    MONEY,
    cd_tasa_c             FLOAT,
    cd_tasa_b             FLOAT,
    cd_dias_c             INT,
    cd_dias_b             INT,
    cd_valor_interes_c    MONEY,
    cd_valor_interes_b    MONEY,
    cd_valor_capital_c    MONEY,
    cd_valor_capital_b    MONEY,
    cd_valor_mora_c       MONEY,
    cd_valor_mora_b       MONEY,
    cd_neto_pagar         MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_diferencias_findeter_tmp') IS NOT NULL
    DROP TABLE dbo.ca_diferencias_findeter_tmp
GO

CREATE TABLE dbo.ca_diferencias_findeter_tmp
    (
    cf_beneficiario      CHAR (30),
    cf_departamento      CHAR (20),
    cf_pagare            CHAR (64),
    pf_pagare            CHAR (64),
    cf_fecha_desde       DATETIME,
    cf_fecha_hasta       DATETIME,
    cf_num_oper_findeter cuenta,
    pf_num_oper_findeter cuenta,
    cf_saldo_capital     MONEY,
    pf_saldo_capital     MONEY,
    cf_tasa              FLOAT,
    pf_tasa              FLOAT,
    cf_dias              INT,
    pf_dias              INT,
    cf_valor_interes     MONEY,
    pf_valor_interes     MONEY,
    cf_valor_capital     MONEY,
    pf_valor_capital     MONEY,
    cf_tasa_redes        CHAR (15),
    pf_tasa_redes        CHAR (15)
    )
GO

IF OBJECT_ID ('dbo.ca_diastablamanual') IS NOT NULL
    DROP TABLE dbo.ca_diastablamanual
GO

CREATE TABLE dbo.ca_diastablamanual
    (
    dia_operacion INT NOT NULL,
    dia_num_cuota INT NOT NULL,
    dia_fecha_ini DATETIME,
    dia_fecha_fin DATETIME NOT NULL,
    dia_num_dias  INT
    )
GO

CREATE INDEX ca_diastblmanual
    ON dbo.ca_diastablamanual (dia_operacion, dia_num_cuota)
GO

IF OBJECT_ID ('dbo.ca_dias_aceleratoria') IS NOT NULL
    DROP TABLE dbo.ca_dias_aceleratoria
GO

CREATE TABLE dbo.ca_dias_aceleratoria
    (
    da_dias_dividendo    INT NOT NULL,
    da_dias_aceleratoria INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_dias_aceleratoria_1
    ON dbo.ca_dias_aceleratoria (da_dias_dividendo)
GO

IF OBJECT_ID ('dbo.ca_devolucion_rubro') IS NOT NULL
    DROP TABLE dbo.ca_devolucion_rubro
GO

CREATE TABLE dbo.ca_devolucion_rubro
    (
    dr_operacion     INT NOT NULL,
    dr_forma_pago    catalogo NOT NULL,
    dr_referencia    VARCHAR (24),
    dr_concepto      catalogo NOT NULL,
    dr_monto         MONEY NOT NULL,
    dr_estado        CHAR (3) NOT NULL,
    dr_secuencial_tr INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_deudores_tmp') IS NOT NULL
    DROP TABLE dbo.ca_deudores_tmp
GO

CREATE TABLE dbo.ca_deudores_tmp
    (
    dt_user      login,
    dt_sesion    INT NOT NULL,
    dt_operacion INT NOT NULL,
    dt_banco     cuenta,
    dt_deudor    INT NOT NULL,
    dt_rol       CHAR (1) NOT NULL,
    dt_segvida   CHAR (1) NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_deudores_tmp_1
    ON dbo.ca_deudores_tmp (dt_operacion, dt_deudor)
GO

IF OBJECT_ID ('dbo.ca_deu_segvida') IS NOT NULL
    DROP TABLE dbo.ca_deu_segvida
GO

CREATE TABLE dbo.ca_deu_segvida
    (
    dt_operacion      INT NOT NULL,
    dt_cliente        INT NOT NULL,
    dt_rol            CHAR (1),
    dt_segvida        CHAR (1),
    dt_central_riesgo CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_deu_segvida_1
    ON dbo.ca_deu_segvida (dt_operacion, dt_cliente)
GO

IF OBJECT_ID ('dbo.ca_detalles_garantia_deudor') IS NOT NULL
    DROP TABLE dbo.ca_detalles_garantia_deudor
GO

CREATE TABLE dbo.ca_detalles_garantia_deudor
    (
    dg_user                 login NOT NULL,
    dg_cliente              INT NOT NULL,
    dg_no_garantia          VARCHAR (64),
    dg_tipo_garantia        VARCHAR (30),
    dg_propia               CHAR (2),
    dg_valor                MONEY,
    dg_valor_cobertura      MONEY,
    dg_detalle              VARCHAR (64),
    dg_defecto_garantia     MONEY,
    dg_desc_tipo_garantia   VARCHAR (64),
    dg_desc_clase_garantia  VARCHAR (64),
    dg_desc_garantia        VARCHAR (64),
    dg_fecha_avaluo         DATETIME,
    dg_tramite              INT,
    dg_cobertura_garantias  MONEY,
    dg_porcentaje_cobertura FLOAT,
    dg_tipo_deudor          catalogo,
    dg_estado               catalogo,
    dg_localizacion         catalogo,
    dg_secuencial           INT
    )
GO

IF OBJECT_ID ('dbo.ca_detalle_tmp') IS NOT NULL
    DROP TABLE dbo.ca_detalle_tmp
GO

CREATE TABLE dbo.ca_detalle_tmp
    (
    dividendo     INT NOT NULL,
    fecha         DATETIME NOT NULL,
    pago          MONEY NOT NULL,
    estado        catalogo,
    max_pago      MONEY,
    operacion_det INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_detalle_ejecutivo_pda2') IS NOT NULL
    DROP TABLE dbo.ca_detalle_ejecutivo_pda2
GO

CREATE TABLE dbo.ca_detalle_ejecutivo_pda2
    (
    de_oficial           SMALLINT NOT NULL,
    de_en_ced_ruc        VARCHAR (30) NOT NULL,
    de_nombre_cliente    VARCHAR (64) NOT NULL,
    de_dias_vencimiento  INT NOT NULL,
    de_banco             CHAR (24) NOT NULL,
    de_monto_des         MONEY NOT NULL,
    de_cuotas_total      SMALLINT NOT NULL,
    de_cuotas_vencidas   SMALLINT NOT NULL,
    de_cuotas_por_pagar  SMALLINT NOT NULL,
    de_cuotas_pagadas    SMALLINT NOT NULL,
    de_calif_interna     TINYINT NOT NULL,
    de_total_creditos    INT NOT NULL,
    de_total_saldo_cap   MONEY NOT NULL,
    de_total_deuda       MONEY NOT NULL,
    de_celular           VARCHAR (16) NOT NULL,
    de_barrio            VARCHAR (40) NOT NULL,
    de_telefono_dom      VARCHAR (16) NOT NULL,
    de_telefono_neg      VARCHAR (16) NOT NULL,
    de_estado_sincro     CHAR (3),
    de_secuencial_sincro INT
    )
GO

IF OBJECT_ID ('dbo.ca_detalle_amor') IS NOT NULL
    DROP TABLE dbo.ca_detalle_amor
GO

CREATE TABLE dbo.ca_detalle_amor
    (
    de_dividendo  INT,
    de_fecha_ven  DATETIME,
    de_dias_cuota INT,
    de_pago_cap   MONEY,
    de_pago_int   MONEY,
    de_pago_mora  MONEY,
    de_pago_otr   MONEY,
    de_pago       MONEY,
    de_estado     VARCHAR (64)
    )
GO

IF OBJECT_ID ('dbo.ca_detalle') IS NOT NULL
    DROP TABLE dbo.ca_detalle
GO

CREATE TABLE dbo.ca_detalle
    (
    de_operacion INT,
    de_dividendo INT,
    de_fechaini  DATETIME,
    de_fecha     DATETIME,
    de_pago_cap  MONEY,
    de_pago_int  MONEY,
    de_pago_otr  MONEY,
    de_pago      MONEY,
    de_estado    VARCHAR (64),
    de_max_pago  MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_det_trn_bancamia_tmp') IS NOT NULL
    DROP TABLE dbo.ca_det_trn_bancamia_tmp
GO

CREATE TABLE dbo.ca_det_trn_bancamia_tmp
    (
    dtr_secuencial   INT,
    dtr_banco        VARCHAR (26),
    dtr_dividendo    INT,
    dtr_concepto     VARCHAR (30),
    dtr_estado       TINYINT,
    dtr_periodo      TINYINT,
    dtr_codvalor     INT,
    dtr_monto        MONEY,
    dtr_monto_mn     MONEY,
    dtr_moneda       TINYINT,
    dtr_cotizacion   FLOAT,
    dtr_tcotizacion  CHAR (1),
    dtr_afectacion   CHAR (1),
    dtr_cuenta       CHAR (20),
    dtr_beneficiario CHAR (64),
    dtr_monto_cont   MONEY,
    dtr_fecha_proc   DATETIME,
    dtr_tran         VARCHAR (10),
    dtr_arch_ofi     VARCHAR (4)
    )
GO

CREATE INDEX ca_dtrn_bancamia_tmp_1
    ON dbo.ca_det_trn_bancamia_tmp (dtr_banco, dtr_secuencial)
GO

IF OBJECT_ID ('dbo.ca_det_trn_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_det_trn_bancamia
GO

CREATE TABLE dbo.ca_det_trn_bancamia
    (
    dtr_secuencial   INT NOT NULL,
    dtr_banco        VARCHAR (26) NOT NULL,
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
    dtr_monto_cont   MONEY NOT NULL
    )
GO

CREATE INDEX ca_det_trn_bancamia_1
    ON dbo.ca_det_trn_bancamia (dtr_banco, dtr_secuencial, dtr_concepto)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_det_trn') IS NOT NULL
    DROP TABLE dbo.ca_det_trn
GO

CREATE TABLE dbo.ca_det_trn
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
    dtr_monto_cont   MONEY NOT NULL
    )
GO

CREATE CLUSTERED INDEX ca_det_trn_1
    ON dbo.ca_det_trn (dtr_operacion, dtr_secuencial, dtr_dividendo, dtr_codvalor)
    WITH (FILLFACTOR = 80)
GO

IF OBJECT_ID ('dbo.ca_desmarca_fng_his') IS NOT NULL
    DROP TABLE dbo.ca_desmarca_fng_his
GO

CREATE TABLE dbo.ca_desmarca_fng_his
    (
    df_fecha         DATETIME,
    df_aplicativo    INT,
    df_banco         VARCHAR (24),
    df_garantia      VARCHAR (64),
    df_est_gar_ant   VARCHAR (1),
    df_est_gar_nue   VARCHAR (1),
    df_val_ant       MONEY,
    df_val_nue       MONEY,
    df_admisible_ant VARCHAR (1),
    df_admisible_nue VARCHAR (1),
    df_desmarca      CHAR (1),
    df_marca         CHAR (1)
    )
GO

CREATE INDEX idx1
    ON dbo.ca_desmarca_fng_his (df_banco)
GO

CREATE INDEX idx2
    ON dbo.ca_desmarca_fng_his (df_fecha)
GO

IF OBJECT_ID ('dbo.ca_desembolso_ts') IS NOT NULL
    DROP TABLE dbo.ca_desembolso_ts
GO

CREATE TABLE dbo.ca_desembolso_ts
    (
    dms_fecha_proceso_ts   DATETIME NOT NULL,
    dms_fecha_ts           DATETIME NOT NULL,
    dms_usuario_ts         login NOT NULL,
    dms_oficina_ts         SMALLINT NOT NULL,
    dms_terminal_ts        VARCHAR (30) NOT NULL,
    dms_secuencial         INT NOT NULL,
    dms_operacion          INT NOT NULL,
    dms_desembolso         TINYINT NOT NULL,
    dms_producto           catalogo NOT NULL,
    dms_cuenta             cuenta,
    dms_beneficiario       descripcion,
    dms_oficina_chg        SMALLINT,
    dms_usuario            login NOT NULL,
    dms_oficina            SMALLINT NOT NULL,
    dms_terminal           descripcion NOT NULL,
    dms_dividendo          SMALLINT NOT NULL,
    dms_moneda             TINYINT NOT NULL,
    dms_monto_mds          MONEY NOT NULL,
    dms_monto_mop          MONEY NOT NULL,
    dms_monto_mn           MONEY NOT NULL,
    dms_cotizacion_mds     FLOAT NOT NULL,
    dms_cotizacion_mop     FLOAT NOT NULL,
    dms_tcotizacion_mds    CHAR (1) NOT NULL,
    dms_tcotizacion_mop    CHAR (1) NOT NULL,
    dms_estado             CHAR (3) NOT NULL,
    dms_cod_banco          INT,
    dms_cheque             INT,
    dms_fecha              DATETIME,
    dms_prenotificacion    INT,
    dms_carga              INT,
    dms_concepto           VARCHAR (255),
    dms_valor              MONEY,
    dms_ente_benef         INT,
    dms_idlote             INT,
    dms_pagado             CHAR (1),
    dms_orden_caja         INT,
    dms_cruce_restrictivo  CHAR (1),
    dms_destino_economico  CHAR (1),
    dms_carta_autorizacion CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_desembolso_no') IS NOT NULL
    DROP TABLE dbo.ca_desembolso_no
GO

CREATE TABLE dbo.ca_desembolso_no
    (
    op_banco    cuenta,
    op_cliente  INT,
    en_ced_ruc  VARCHAR (25),
    en_nombre   VARCHAR (255),
    dm_producto VARCHAR (16),
    dm_cuenta   catalogo,
    dm_monto_mn MONEY,
    dm_oficina  SMALLINT,
    dm_fecha    DATETIME,
    op_oficina  SMALLINT,
    op_oficial  SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_desembolso_fag_tmp') IS NOT NULL
    DROP TABLE dbo.ca_desembolso_fag_tmp
GO

CREATE TABLE dbo.ca_desembolso_fag_tmp
    (
    df_certificado       VARCHAR (13) NOT NULL,
    df_llave_redescuento cuenta NOT NULL,
    df_cliente           INT NOT NULL,
    df_pagare            VARCHAR (64) NOT NULL,
    df_plazo             INT NOT NULL,
    df_gracia_cap        INT NOT NULL,
    df_fecha_ini         DATETIME NOT NULL,
    df_valor_credito     MONEY NOT NULL,
    df_porc_cobertura    FLOAT NOT NULL,
    df_valor_garantia    MONEY NOT NULL,
    df_porc_comision     FLOAT NOT NULL,
    df_valor_comision    MONEY NOT NULL,
    df_valor_iva         MONEY NOT NULL,
    df_oficina           INT NOT NULL,
    df_regional          INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_desembolso_conv') IS NOT NULL
    DROP TABLE dbo.ca_desembolso_conv
GO

CREATE TABLE dbo.ca_desembolso_conv
    (
    oficina     CHAR (4),
    cuenta      CHAR (7),
    aplicacion  CHAR (1),
    transaccion CHAR (2),
    tipotrans   CHAR (2),
    nro_docum   CHAR (8),
    vr_total    CHAR (14),
    vr_canje    CHAR (14),
    ofic_origen CHAR (4),
    filler      CHAR (44)
    )
GO

IF OBJECT_ID ('dbo.ca_desembolso') IS NOT NULL
    DROP TABLE dbo.ca_desembolso
GO

CREATE TABLE dbo.ca_desembolso
    (
    dm_secuencial         INT NOT NULL,
    dm_operacion          INT NOT NULL,
    dm_desembolso         TINYINT NOT NULL,
    dm_producto           catalogo NOT NULL,
    dm_cuenta             cuenta,
    dm_beneficiario       descripcion,
    dm_oficina_chg        SMALLINT,
    dm_usuario            login NOT NULL,
    dm_oficina            SMALLINT NOT NULL,
    dm_terminal           descripcion NOT NULL,
    dm_dividendo          SMALLINT NOT NULL,
    dm_moneda             TINYINT NOT NULL,
    dm_monto_mds          MONEY NOT NULL,
    dm_monto_mop          MONEY NOT NULL,
    dm_monto_mn           MONEY NOT NULL,
    dm_cotizacion_mds     FLOAT NOT NULL,
    dm_cotizacion_mop     FLOAT NOT NULL,
    dm_tcotizacion_mds    CHAR (1) NOT NULL,
    dm_tcotizacion_mop    CHAR (1) NOT NULL,
    dm_estado             CHAR (3) NOT NULL,
    dm_cod_banco          INT,
    dm_cheque             INT,
    dm_fecha              DATETIME,
    dm_prenotificacion    INT,
    dm_carga              INT,
    dm_concepto           VARCHAR (255),
    dm_valor              MONEY,
    dm_ente_benef         INT,
    dm_idlote             INT,
    dm_pagado             CHAR (1),
    dm_orden_caja         INT,
    dm_cruce_restrictivo  CHAR (1),
    dm_destino_economico  CHAR (1),
    dm_carta_autorizacion CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_desembolso_1
    ON dbo.ca_desembolso (dm_operacion, dm_secuencial, dm_desembolso)
GO

create index ca_desembolso_2
on ca_desembolso (dm_fecha, dm_estado)
go

IF OBJECT_ID ('dbo.ca_definicion_nomina_tmp') IS NOT NULL
    DROP TABLE dbo.ca_definicion_nomina_tmp
GO

CREATE TABLE dbo.ca_definicion_nomina_tmp
    (
    dnt_operacion      INT NOT NULL,
    dnt_concepto       catalogo NOT NULL,
    dnt_div_inicial    SMALLINT NOT NULL,
    dnt_periodicidad   catalogo NOT NULL,
    dnt_val_inicial    MONEY NOT NULL,
    dnt_por_incremento FLOAT NOT NULL,
    dnt_per_incremento catalogo,
    dnt_por_abono      FLOAT
    )
GO

CREATE UNIQUE INDEX ca_definicion_nomina_tmp_1
    ON dbo.ca_definicion_nomina_tmp (dnt_operacion, dnt_concepto)
GO

IF OBJECT_ID ('dbo.ca_definicion_nomina') IS NOT NULL
    DROP TABLE dbo.ca_definicion_nomina
GO

CREATE TABLE dbo.ca_definicion_nomina
    (
    dn_operacion      INT NOT NULL,
    dn_concepto       catalogo NOT NULL,
    dn_div_inicial    SMALLINT NOT NULL,
    dn_periodicidad   catalogo NOT NULL,
    dn_val_inicial    MONEY NOT NULL,
    dn_por_incremento FLOAT NOT NULL,
    dn_per_incremento catalogo,
    dn_por_abono      FLOAT
    )
GO

CREATE UNIQUE INDEX ca_definicion_nomina_1
    ON dbo.ca_definicion_nomina (dn_operacion, dn_concepto)
GO



IF OBJECT_ID ('dbo.ca_default_toperacion_ts') IS NOT NULL
    DROP TABLE dbo.ca_default_toperacion_ts
GO

CREATE TABLE dbo.ca_default_toperacion_ts
    (
    dts_fecha_proceso_ts        DATETIME NOT NULL,
    dts_fecha_ts                DATETIME NOT NULL,
    dts_usuario_ts              login NOT NULL,
    dts_oficina_ts              SMALLINT NOT NULL,
    dts_terminal_ts             VARCHAR (30) NOT NULL,
    dts_toperacion              catalogo NOT NULL,
    dts_moneda                  TINYINT NOT NULL,
    dts_reajustable             CHAR (1) NOT NULL,
    dts_periodo_reaj            TINYINT,
    dts_reajuste_especial       CHAR (1),
    dts_renovacion              CHAR (1) NOT NULL,
    dts_tipo                    CHAR (1) NOT NULL,
    dts_estado                  catalogo,
    dts_precancelacion          CHAR (1) NOT NULL,
    dts_cuota_completa          CHAR (1) NOT NULL,
    dts_tipo_cobro              CHAR (1) NOT NULL,
    dts_tipo_reduccion          CHAR (1) NOT NULL,
    dts_aceptar_anticipos       CHAR (1) NOT NULL,
    dts_tipo_aplicacion         CHAR (1) NOT NULL,
    dts_tplazo                  catalogo NOT NULL,
    dts_plazo                   SMALLINT NOT NULL,
    dts_tdividendo              catalogo NOT NULL,
    dts_periodo_cap             SMALLINT NOT NULL,
    dts_periodo_int             SMALLINT NOT NULL,
    dts_gracia_cap              SMALLINT NOT NULL,
    dts_gracia_int              SMALLINT NOT NULL,
    dts_dist_gracia             CHAR (1) NOT NULL,
    dts_dias_anio               SMALLINT NOT NULL,
    dts_tipo_amortizacion       catalogo NOT NULL,
    dts_fecha_fija              CHAR (1) NOT NULL,
    dts_dia_pago                TINYINT NOT NULL,
    dts_cuota_fija              CHAR (1) NOT NULL,
    dts_dias_gracia             TINYINT NOT NULL,
    dts_evitar_feriados         CHAR (1) NOT NULL,
    dts_mes_gracia              TINYINT NOT NULL,
    dts_base_calculo            CHAR (1),
    dts_prd_cobis               TINYINT,
    dts_dia_habil               CHAR (1),
    dts_recalcular_plazo        CHAR (1),
    dts_usar_tequivalente       CHAR (1),
    dts_tipo_redondeo           TINYINT,
    dts_causacion               CHAR (1),
    dts_convertir_tasa          CHAR (1),
    dts_tipo_linea              catalogo,
    dts_subtipo_linea           catalogo,
    dts_bvirtual                CHAR (1) NOT NULL,
    dts_extracto                CHAR (1) NOT NULL,
    dts_naturaleza              CHAR (1),
    dts_pago_caja               CHAR (1),
    dts_nace_vencida            CHAR (1),
    dts_calcula_devolucion      CHAR (1),
    dts_categoria               catalogo,
    dts_entidad_convenio        catalogo,
    dts_mora_retroactiva        CHAR (1),
    dts_prepago_desde_lavigente CHAR (1),
    dts_dias_anio_mora          SMALLINT,
    dts_tipo_calif              catalogo,
    dts_plazo_min               SMALLINT,
    dts_plazo_max               SMALLINT,
    dts_monto_min               MONEY,
    dts_monto_max               MONEY,
    dts_clase_sector            catalogo,
    dts_clase_cartera           catalogo,
    dts_gar_admisible           CHAR (1),
    dts_afecta_cupo             CHAR (1),
    dts_control_dia_pago        CHAR (1),
    dts_porcen_colateral        FLOAT,
    dts_subsidio                char(1),
    dts_tipo_prioridad          char(1),
    dts_dia_ppago               tinyint,
    dts_efecto_pago             char(1),
    dts_tpreferencial           char(1),
    dts_modo_reest              char(1),
    dts_cuota_menor             char(1),
    dts_fondos_propios          char(1),
    dts_desplazamiento          int null
    )
GO

CREATE INDEX ca_default_toperacion_ts_1
    ON dbo.ca_default_toperacion_ts (dts_fecha_proceso_ts)
GO

CREATE INDEX ca_default_toperacion_ts_2
    ON dbo.ca_default_toperacion_ts (dts_fecha_ts)
GO

CREATE INDEX ca_default_toperacion_ts_3
    ON dbo.ca_default_toperacion_ts (dts_usuario_ts)
GO

CREATE INDEX ca_default_toperacion_ts_4
    ON dbo.ca_default_toperacion_ts (dts_oficina_ts)
GO

IF OBJECT_ID ('dbo.ca_default_toperacion') IS NOT NULL
    DROP TABLE dbo.ca_default_toperacion
GO

CREATE TABLE dbo.ca_default_toperacion
    (
    dt_toperacion              catalogo NOT NULL,
    dt_moneda                  TINYINT NOT NULL,
    dt_reajustable             CHAR (1) NOT NULL,
    dt_periodo_reaj            TINYINT,
    dt_reajuste_especial       CHAR (1),
    dt_renovacion              CHAR (1) NOT NULL,
    dt_tipo                    CHAR (1) NOT NULL,
    dt_estado                  catalogo,
    dt_precancelacion          CHAR (1) NOT NULL,
    dt_cuota_completa          CHAR (1) NOT NULL,
    dt_tipo_cobro              CHAR (1) NOT NULL,
    dt_tipo_reduccion          CHAR (1) NOT NULL,
    dt_aceptar_anticipos       CHAR (1) NOT NULL,
    dt_tipo_aplicacion         CHAR (1) NOT NULL,
    dt_tplazo                  catalogo NOT NULL,
    dt_plazo                   SMALLINT NOT NULL,
    dt_tdividendo              catalogo NOT NULL,
    dt_periodo_cap             SMALLINT NOT NULL,
    dt_periodo_int             SMALLINT NOT NULL,
    dt_gracia_cap              SMALLINT NOT NULL,
    dt_gracia_int              SMALLINT NOT NULL,
    dt_dist_gracia             CHAR (1) NOT NULL,
    dt_dias_anio               SMALLINT NOT NULL,
    dt_tipo_amortizacion       catalogo NOT NULL,
    dt_fecha_fija              CHAR (1) NOT NULL,
    dt_dia_pago                TINYINT NOT NULL,
    dt_cuota_fija              CHAR (1) NOT NULL,
    dt_dias_gracia             TINYINT NOT NULL,
    dt_evitar_feriados         CHAR (1) NOT NULL,
    dt_mes_gracia              TINYINT NOT NULL,
    dt_base_calculo            CHAR (1),
    dt_prd_cobis               TINYINT,
    dt_dia_habil               CHAR (1),
    dt_recalcular_plazo        CHAR (1),
    dt_usar_tequivalente       CHAR (1),
    dt_tipo_redondeo           TINYINT,
    dt_causacion               CHAR (1),
    dt_convertir_tasa          CHAR (1),
    dt_tipo_linea              catalogo,
    dt_subtipo_linea           catalogo,
    dt_bvirtual                CHAR (1),
    dt_extracto                CHAR (1),
    dt_naturaleza              CHAR (1),
    dt_pago_caja               CHAR (1),
    dt_nace_vencida            CHAR (1),
    dt_calcula_devolucion      CHAR (1),
    dt_categoria               catalogo,
    dt_entidad_convenio        catalogo,
    dt_mora_retroactiva        CHAR (1),
    dt_prepago_desde_lavigente CHAR (1),
    dt_dias_anio_mora          SMALLINT,
    dt_tipo_calif              catalogo,
    dt_plazo_min               SMALLINT,
    dt_plazo_max               SMALLINT,
    dt_monto_min               MONEY,
    dt_monto_max               MONEY,
    dt_clase_sector            catalogo,
    dt_clase_cartera           catalogo,
    dt_gar_admisible           CHAR (1),
    dt_afecta_cupo             CHAR (1),
    dt_control_dia_pago        CHAR (1),
    dt_porcen_colateral        FLOAT,
    dt_subsidio                char(1),
    dt_tipo_prioridad          char(1),
    dt_dia_ppago               tinyint,
    dt_efecto_pago             char(1),
    dt_tpreferencial           char(1),
    dt_modo_reest              char(1),
    dt_cuota_menor             char(1),
    dt_fondos_propios          char(1),
    dt_desplazamiento          smallint null --SRO 140073
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_default_toperacion_1
    ON dbo.ca_default_toperacion (dt_toperacion, dt_moneda)
GO

IF OBJECT_ID ('dbo.ca_decodificador') IS NOT NULL
    DROP TABLE dbo.ca_decodificador
GO

CREATE TABLE dbo.ca_decodificador
    (
    dc_user      login NOT NULL,
    dc_sesn      INT NOT NULL,
    dc_operacion INT NOT NULL,
    dc_fila      INT NOT NULL,
    dc_columna   INT NOT NULL,
    dc_valor     VARCHAR (255) NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_decodificador_1
    ON dbo.ca_decodificador (dc_user, dc_sesn, dc_operacion, dc_fila, dc_columna)
GO

IF OBJECT_ID ('dbo.ca_datos_reestructuraciones_cca') IS NOT NULL
    DROP TABLE dbo.ca_datos_reestructuraciones_cca
GO

CREATE TABLE dbo.ca_datos_reestructuraciones_cca
    (
    res_tramite_cre        INT,
    res_operacion_cca      INT,
    res_saldo_cap_antes    MONEY,
    res_valor_capitalizado MONEY,
    res_saldo_cap_depues   MONEY,
    res_usuario_cca        login,
    res_fecha_final_trn    DATETIME,
    res_secuencial_res     INT,
    res_estado_tran        catalogo,
    res_pagado_CAP         MONEY,
    res_min_div_rees       SMALLINT,
    res_cuota_anterior     MONEY
    )
GO

CREATE UNIQUE INDEX ca_datos_reestructuraciones_cca_1
    ON dbo.ca_datos_reestructuraciones_cca (res_operacion_cca, res_secuencial_res)
GO

IF OBJECT_ID ('dbo.ca_datos_impresion') IS NOT NULL
    DROP TABLE dbo.ca_datos_impresion
GO

CREATE TABLE dbo.ca_datos_impresion
    (
    di_banco     CHAR (20),
    di_valor_ven MONEY,
    di_valor_nov MONEY,
    di_valor_red MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_datos_condonaciones') IS NOT NULL
    DROP TABLE dbo.ca_datos_condonaciones
GO

CREATE TABLE dbo.ca_datos_condonaciones
    (
    con_operacion             INT NOT NULL,
    con_secuencial_pag        INT NOT NULL,
    con_fecha_div_mas_vencido DATETIME,
    con_saldo_cap_antes_cond  MONEY,
    con_deuda_INT             MONEY,
    con_deuda_IMO             MONEY,
    con_deuda_CAP             MONEY,
    con_deuda_otros           MONEY,
    con_tot_CONDONAR          MONEY,
    con_fecha_pag             DATETIME
    )
GO

CREATE UNIQUE INDEX ca_datos_condonaciones_1
    ON dbo.ca_datos_condonaciones (con_operacion, con_secuencial_pag)
GO

IF OBJECT_ID ('dbo.ca_datos_concil_men') IS NOT NULL
    DROP TABLE dbo.ca_datos_concil_men
GO

CREATE TABLE dbo.ca_datos_concil_men
    (
    cma_llave_redescuento cuenta,
    pma_oper_llave_redes  cuenta,
    cma_norma_legal       cuenta,
    pma_linea_norlegal    cuenta,
    cma_saldo_redescuento MONEY,
    pma_valor_saldo_redes MONEY,
    cma_modalidad_pago    CHAR (1),
    pma_modalidad         CHAR (1),
    cma_tasa_nominal      FLOAT,
    pma_tasa_nom          FLOAT,
    cma_identificacion    cuenta,
    pma_identificacion    cuenta,
    cma_banco             cuenta,
    cma_oficina           INT,
    cma_fecha_redescuento DATETIME,
    cma_diferencia        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_datos_concil') IS NOT NULL
    DROP TABLE dbo.ca_datos_concil
GO

CREATE TABLE dbo.ca_datos_concil
    (
    cd_cod_ext_banco     cuenta,
    bs_cod_ext_banco_s   cuenta,
    cd_llave_banco       cuenta,
    bs_llave_banco_s     cuenta,
    cd_norma_legal       cuenta,
    bs_norma_legal_s     cuenta,
    cd_dias_int          INT,
    bs_dias_int_s        INT,
    cd_saldo             MONEY,
    bs_saldo_s           MONEY,
    cd_abono_int         MONEY,
    bs_abono_int_s       MONEY,
    cd_abono_capital     MONEY,
    bs_abono_capital_s   MONEY,
    cd_modalidad_pago    CHAR (1),
    bs_modalidad_pago_s  CHAR (1),
    cd_tasa_nominal      FLOAT,
    bs_tasa_nominal_s    FLOAT,
    cd_nombre            VARCHAR (64),
    bs_nombre_s          VARCHAR (35),
    cd_indentificacion   cuenta,
    bs_indentificacion_s cuenta,
    cd_formula_tasa      VARCHAR (20),
    bs_formula_tasa_s    VARCHAR (15),
    cd_fecha_ven_cuota   DATETIME,
    bs_fecha_ven_cuota_s DATETIME,
    cd_banco             cuenta,
    cd_oficina           SMALLINT,
    cd_fecha_redescuento DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_datos_carta_redes') IS NOT NULL
    DROP TABLE dbo.ca_datos_carta_redes
GO

CREATE TABLE dbo.ca_datos_carta_redes
    (
    dc_fecha DATETIME NOT NULL,
    dc_login login NOT NULL,
    dc_ref_1 descripcion NOT NULL,
    dc_ref_2 descripcion NOT NULL,
    dc_ref_3 VARCHAR (254) NOT NULL,
    dc_ref_4 descripcion NOT NULL,
    dc_ref_5 VARCHAR (254) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_datooperacion_cuadre') IS NOT NULL
    DROP TABLE dbo.ca_datooperacion_cuadre
GO

CREATE TABLE dbo.ca_datooperacion_cuadre
    (
    fecha       DATETIME,
    banco       cuenta,
    saldo_cap   MONEY,
    saldo_int   MONEY,
    saldo_otros MONEY,
    suspenso    MONEY,
    moneda      SMALLINT
    )
GO

CREATE UNIQUE INDEX ca_datooperacion_cuadre_1
    ON dbo.ca_datooperacion_cuadre (fecha, banco)
GO

IF OBJECT_ID ('dbo.ca_data_temp') IS NOT NULL
    DROP TABLE dbo.ca_data_temp
GO

CREATE TABLE dbo.ca_data_temp
    (
    dt_data VARCHAR (1000)
    )
GO

IF OBJECT_ID ('dbo.ca_dat_oper_bv_tmp') IS NOT NULL
    DROP TABLE dbo.ca_dat_oper_bv_tmp
GO

CREATE TABLE dbo.ca_dat_oper_bv_tmp
    (
    bv_cliente         descripcion,
    bv_no_obligacion   cuenta,
    bv_tipo_credito    descripcion,
    bv_oficina         descripcion,
    bv_fecha_consulta  DATETIME,
    bv_fecha_ult_pago  DATETIME,
    bv_monto_inicial   MONEY,
    bv_tef_int         FLOAT,
    bv_tef_mora        FLOAT,
    bv_div_actual      INT,
    bv_fecha_ini       DATETIME,
    bv_fecha_fin       DATETIME,
    bv_saldo_deudor    MONEY,
    bv_saldo_cap       MONEY,
    bv_saldo_int       MONEY,
    bv_saldo_mora      MONEY,
    bv_saldo_otros     MONEY,
    bv_total_pagar     MONEY,
    bv_cuota_completa  CHAR (1),
    bv_tipo_reduccion  CHAR (1),
    bv_aceptar_anticp  CHAR (1),
    bv_precancelar     CHAR (1),
    bv_fecha_prox_pago DATETIME,
    bv_valor_a_pagar   MONEY,
    bv_estado          TINYINT
    )
GO

CREATE INDEX ca_dat_oper_bv_key
    ON dbo.ca_dat_oper_bv_tmp (bv_no_obligacion)
GO

IF OBJECT_ID ('dbo.ca_cxc_no_cartera') IS NOT NULL
    DROP TABLE dbo.ca_cxc_no_cartera
GO

CREATE TABLE dbo.ca_cxc_no_cartera
    (
    cc_user        login NOT NULL,
    cc_cliente     INT NOT NULL,
    cc_referencia  VARCHAR (30),
    cc_valor       MONEY,
    cc_descripcion VARCHAR (60)
    )
GO

CREATE INDEX pkey_ca_cxc_no_cartera_01
    ON dbo.ca_cxc_no_cartera (cc_cliente, cc_user)
GO

IF OBJECT_ID ('dbo.ca_cursor_dividendo_temp') IS NOT NULL
    DROP TABLE dbo.ca_cursor_dividendo_temp
GO

CREATE TABLE dbo.ca_cursor_dividendo_temp
    (
    di_dividendo INT NOT NULL,
    di_fecha_ven DATETIME NOT NULL,
    am_concepto  catalogo NOT NULL,
    am_estado    TINYINT NOT NULL,
    am_secuencia TINYINT NOT NULL,
    am_operacion INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cursor_dividendo_ru_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cursor_dividendo_ru_tmp
GO

CREATE TABLE dbo.ca_cursor_dividendo_ru_tmp
    (
    di_dividendo INT NOT NULL,
    di_fecha_ven DATETIME NOT NULL,
    am_concepto  catalogo NOT NULL,
    am_estado    TINYINT NOT NULL,
    am_secuencia TINYINT NOT NULL,
    am_operacion INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cuota_adicional_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cuota_adicional_tmp
GO

CREATE TABLE dbo.ca_cuota_adicional_tmp
    (
    cat_operacion INT NOT NULL,
    cat_dividendo SMALLINT NOT NULL,
    cat_cuota     MONEY NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_cuota_adicional_tmp_1
    ON dbo.ca_cuota_adicional_tmp (cat_operacion, cat_dividendo)
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

CREATE INDEX ca_cuota_adicional_his_1
    ON dbo.ca_cuota_adicional_his (cah_operacion, cah_secuencial)
GO

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

CREATE UNIQUE INDEX ca_cuota_adicional_1
    ON dbo.ca_cuota_adicional (ca_operacion, ca_dividendo)
GO

CREATE INDEX ca_cuota_adicional_2
    ON dbo.ca_cuota_adicional (ca_operacion, ca_dividendo, ca_cuota)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_cuerpo_carta') IS NOT NULL
    DROP TABLE dbo.ca_cuerpo_carta
GO

CREATE TABLE dbo.ca_cuerpo_carta
    (
    ca_secuencia     INT,
    ca_secuencia_rej INT,
    ca_cuerpo        VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_cuentas_revisoria_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cuentas_revisoria_tmp
GO

CREATE TABLE dbo.ca_cuentas_revisoria_tmp
    (
    valor descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_cuentas_ajuste') IS NOT NULL
    DROP TABLE dbo.ca_cuentas_ajuste
GO

CREATE TABLE dbo.ca_cuentas_ajuste
    (
    ca_cuenta        cuenta NOT NULL,
    ca_cuenta_contra cuenta,
    ca_tipo_oficina  CHAR (2) NOT NULL,
    ca_tipo_area     VARCHAR (10) NOT NULL,
    ca_estado        CHAR (1) NOT NULL,
    ca_fecha         DATETIME NOT NULL,
    ca_usuario       login NOT NULL,
    ca_tipo          VARCHAR (10) NOT NULL,
    ca_producto      SMALLINT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_cuentas_ajuste_1
    ON dbo.ca_cuentas_ajuste (ca_cuenta)
GO

IF OBJECT_ID ('dbo.ca_cuadre_hc_conso_reporte') IS NOT NULL
    DROP TABLE dbo.ca_cuadre_hc_conso_reporte
GO

CREATE TABLE dbo.ca_cuadre_hc_conso_reporte
    (
    cua_naturaleza    CHAR (1),
    cua_tipo_revision CHAR (50),
    cua_fecha_proceso DATETIME,
    cua_producto      TINYINT,
    cua_moneda        TINYINT,
    cua_banco         cuenta,
    cua_capital_conso MONEY,
    cua_interes_conso MONEY,
    cua_otros_conso   MONEY,
    cua_sus_conso     MONEY,
    cua_capital_hc    MONEY,
    cua_interes_hc    MONEY,
    cua_otros_hc      MONEY,
    cua_sus_hc        MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_ctas_no_relaciondas') IS NOT NULL
    DROP TABLE dbo.ca_ctas_no_relaciondas
GO

CREATE TABLE dbo.ca_ctas_no_relaciondas
    (
    fecha         DATETIME,
    fecha_proceso DATETIME,
    operacion     INT,
    banco         cuenta,
    cuenta        cuenta,
    estado        CHAR (1),
    forma_pago    catalogo,
    producto      SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_cpagos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cpagos_tmp
GO

CREATE TABLE dbo.ca_cpagos_tmp
    (
    cpt_faplic    VARCHAR (10) NOT NULL,
    cpt_fefect    VARCHAR (10) NOT NULL,
    cpt_ofi_ori   SMALLINT NOT NULL,
    cpt_ofi_des   SMALLINT NOT NULL,
    cpt_operacion CHAR (24) NOT NULL,
    cpt_forma     catalogo,
    cpt_cta_cta   CHAR (14) NOT NULL,
    cpt_valor     MONEY NOT NULL,
    cpt_cedula    VARCHAR (30) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_correccion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_correccion_tmp
GO

CREATE TABLE dbo.ca_correccion_tmp
    (
    cot_operacion         INT NOT NULL,
    cot_dividendo         SMALLINT NOT NULL,
    cot_concepto          catalogo NOT NULL,
    cot_correccion_mn     MONEY,
    cot_correccion_sus_mn MONEY,
    cot_correc_pag_sus_mn MONEY,
    cot_liquida_mn        MONEY
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

CREATE INDEX ca_co_op_his
    ON dbo.ca_correccion_his (coh_operacion, coh_secuencial, coh_concepto)
GO

IF OBJECT_ID ('dbo.ca_correccion') IS NOT NULL
    DROP TABLE dbo.ca_correccion
GO

CREATE TABLE dbo.ca_correccion
    (
    co_operacion         INT NOT NULL,
    co_dividendo         SMALLINT NOT NULL,
    co_concepto          catalogo NOT NULL,
    co_correccion_mn     MONEY,
    co_correccion_sus_mn MONEY,
    co_correc_pag_sus_mn MONEY,
    co_liquida_mn        MONEY
    )
GO

CREATE INDEX ca_co_op
    ON dbo.ca_correccion (co_operacion, co_concepto)
GO

IF OBJECT_ID ('dbo.ca_conversion') IS NOT NULL
    DROP TABLE dbo.ca_conversion
GO

CREATE TABLE dbo.ca_conversion
    (
    cv_oficina     SMALLINT NOT NULL,
    cv_codigo_ofi  catalogo NOT NULL,
    cv_operacion   INT NOT NULL,
    cv_anio        SMALLINT NOT NULL,
    cv_pago        INT,
    cv_liquidacion INT,
    cv_pago_masivo INT
    )
GO

CREATE CLUSTERED INDEX ca_conversion_1
    ON dbo.ca_conversion (cv_oficina)
GO

IF OBJECT_ID ('dbo.ca_convenios_tmp') IS NOT NULL
    DROP TABLE dbo.ca_convenios_tmp
GO

CREATE TABLE dbo.ca_convenios_tmp
    (
    con_empresa             numero NOT NULL,
    con_subtipo             CHAR (1) NOT NULL,
    con_oficina_cliente     INT NOT NULL,
    con_identificacion      numero NOT NULL,
    con_tipo_identificacion numero NOT NULL,
    con_linea_credito       catalogo NOT NULL,
    con_monto               MONEY NOT NULL,
    con_moneda              TINYINT NOT NULL,
    con_sector              catalogo NOT NULL,
    con_oficina_oper        INT NOT NULL,
    con_oficial             SMALLINT NOT NULL,
    con_destino             catalogo NOT NULL,
    con_ubicacion           INT NOT NULL,
    con_fecha_inicio        DATETIME NOT NULL,
    con_estado_registro     CHAR (1) NOT NULL,
    con_clase_cartera       catalogo NOT NULL,
    con_cupo_linea          cuenta NOT NULL,
    con_error_tramite       INT
    )
GO

IF OBJECT_ID ('dbo.ca_convenio_recaudo') IS NOT NULL
    DROP TABLE dbo.ca_convenio_recaudo
GO

CREATE TABLE dbo.ca_convenio_recaudo
    (
    cr_codigo          SMALLINT NOT NULL,
    cr_tipo_cobro      CHAR (1) NOT NULL,
    cr_valor           MONEY NOT NULL,
    cr_delimit         CHAR (1) NOT NULL,
    cr_moneda          TINYINT NOT NULL,
    cr_cobra_iva       CHAR (1) NOT NULL,
    cr_tipo_iva        VARCHAR (10) NOT NULL,
    cr_anchofijo       CHAR (1) NOT NULL,
    cr_pone_prefijo    CHAR (1),
    cr_prefijo         VARCHAR (24),
    cr_pone_subfijo    CHAR (1),
    cr_subfijo         VARCHAR (24),
    cr_formato_fecha   VARCHAR (10),
    cr_concepto        catalogo,
    cr_tipo_aplicacion CHAR (1),
    cr_tipo_reduccion  CHAR (1)
    )
GO

CREATE UNIQUE INDEX convenio_codigo
    ON dbo.ca_convenio_recaudo (cr_codigo)
GO

IF OBJECT_ID ('dbo.ca_control_trn_manual') IS NOT NULL
    DROP TABLE dbo.ca_control_trn_manual
GO

CREATE TABLE dbo.ca_control_trn_manual
    (
    ct_operacion  INT NOT NULL,
    ct_tran       catalogo NOT NULL,
    ct_fecha_tran DATETIME NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_control_intant') IS NOT NULL
    DROP TABLE dbo.ca_control_intant
GO

CREATE TABLE dbo.ca_control_intant
    (
    con_secuencia_pag INT,
    con_operacion     INT,
    con_dividendo     SMALLINT,
    con_fecha_ini     DATETIME,
    con_fecha_ven     DATETIME,
    con_valor_pagado  MONEY,
    con_dias_cuota    INT,
    con_am_sec        INT
    )
GO

CREATE INDEX ca_control_intant_1
    ON dbo.ca_control_intant (con_operacion, con_secuencia_pag)
GO

IF OBJECT_ID ('dbo.ca_contabiliza_operacion') IS NOT NULL
    DROP TABLE dbo.ca_contabiliza_operacion
GO

CREATE TABLE dbo.ca_contabiliza_operacion
    (
    co_fecha     DATETIME NOT NULL,
    co_operacion INT NOT NULL,
    co_banco     cuenta NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_consutar_transacciones_tmp2') IS NOT NULL
    DROP TABLE dbo.ca_consutar_transacciones_tmp2
GO

CREATE TABLE dbo.ca_consutar_transacciones_tmp2
    (
    c2_fecha_mov   DATETIME,
    c2_ofi_usu     SMALLINT,
    c2_tran        catalogo,
    c2_toperacion  catalogo,
    c2_moneda      SMALLINT,
    c2_banco       cuenta,
    c2_estado      CHAR (10),
    c2_usuario     CHAR (14),
    c2_terminal    CHAR (30),
    c2_observacion VARCHAR (255),
    c2_secuencial  INT,
    c2_operacion   INT,
    c2_user        login NOT NULL,
    c2_comprobante INT
    )
GO

IF OBJECT_ID ('dbo.ca_consutar_transacciones_tmp1') IS NOT NULL
    DROP TABLE dbo.ca_consutar_transacciones_tmp1
GO

CREATE TABLE dbo.ca_consutar_transacciones_tmp1
    (
    c1_fecha_mov   DATETIME,
    c1_ofi_usu     SMALLINT,
    c1_tran        catalogo,
    c1_toperacion  catalogo,
    c1_moneda      SMALLINT,
    c1_banco       cuenta,
    c1_estado      CHAR (10),
    c1_usuario     CHAR (14),
    c1_terminal    CHAR (30),
    c1_observacion VARCHAR (255),
    c1_secuencial  INT,
    c1_operacion   INT,
    c1_user        login NOT NULL,
    c1_comprobante INT
    )
GO

IF OBJECT_ID ('dbo.ca_consultas_prepagos') IS NOT NULL
    DROP TABLE dbo.ca_consultas_prepagos
GO

CREATE TABLE dbo.ca_consultas_prepagos
    (
    rpp_user               login NOT NULL,
    rpp_secuencial         INT NOT NULL,
    rpp_oficina            INT NOT NULL,
    rpp_llave_redescuento  cuenta NOT NULL,
    rpp_banco              cuenta NOT NULL,
    rpp_nombre             VARCHAR (35) NOT NULL,
    rpp_identificacion     cuenta NOT NULL,
    rpp_saldo_capital      MONEY NOT NULL,
    rpp_fecha_int_desde    DATETIME NOT NULL,
    rpp_fecha_int_hasta    DATETIME NOT NULL,
    rpp_dias_de_interes    INT NOT NULL,
    rpp_formula_tasa       cuenta NOT NULL,
    rpp_tasa               FLOAT NOT NULL,
    rpp_valor_prepago      MONEY NOT NULL,
    rpp_saldo_intereses    MONEY NOT NULL,
    rpp_valor_pagado       MONEY NOT NULL,
    rpp_codigo_prepago     catalogo NOT NULL,
    rpp_fecha_generacion   DATETIME NOT NULL,
    rpp_banco_segundo_piso catalogo NOT NULL,
    rpp_estado_aplicar     CHAR (1) NOT NULL,
    rpp_estado_registro    CHAR (1) NOT NULL,
    rpp_comentario         descripcion,
    rpp_causal_rechazo     catalogo
    )
GO

CREATE INDEX ca_consultas_prepagos_1
    ON dbo.ca_consultas_prepagos (rpp_user, rpp_codigo_prepago, rpp_fecha_generacion, rpp_banco_segundo_piso)
GO

IF OBJECT_ID ('dbo.ca_consulta_rec_pago_tmp') IS NOT NULL
    DROP TABLE dbo.ca_consulta_rec_pago_tmp
GO

CREATE TABLE dbo.ca_consulta_rec_pago_tmp
    (
    identifica  CHAR (10) NOT NULL,
    secuencial  INT NOT NULL,
    usuario     cuenta NOT NULL,
    descripcion VARCHAR (64),
    cuota       INT,
    dias        INT,
    fecha_ini   DATETIME,
    fecha_fin   DATETIME,
    monto       MONEY,
    monto_mn    MONEY,
    tasa        FLOAT,
    des_moneda  CHAR (20),
    des_estado  CHAR (20),
    operacion   INT,
    cuenta      cuenta,
    secuencial_pag int
    )
GO

IF OBJECT_ID ('dbo.ca_consulta_pag_mas_tmp') IS NOT NULL
    DROP TABLE dbo.ca_consulta_pag_mas_tmp
GO

create  index ca_consulta_rec_pago_tmp_1 on ca_consulta_rec_pago_tmp (usuario)
go

CREATE TABLE dbo.ca_consulta_pag_mas_tmp
    (
    secuencial         INT,
    estado             VARCHAR (10),
    empleado           VARCHAR (20),
    operacionca        INT,
    num_oper           cuenta,
    moneda             SMALLINT,
    toperacion         catalogo,
    saldo_op           MONEY,
    saldo_capital      MONEY,
    saldo_interes      MONEY,
    saldo_mora         MONEY,
    saldo_seguros      MONEY,
    saldo_otros_cargos MONEY,
    saldo_pagar        MONEY,
    fecha_pago         DATETIME,
    num_cuotas         SMALLINT,
    tramite            INT
    )
GO

IF OBJECT_ID ('dbo.ca_condonacion_ts') IS NOT NULL
    DROP TABLE dbo.ca_condonacion_ts
GO

CREATE TABLE dbo.ca_condonacion_ts
    (
    cos_fecha_proceso_ts DATETIME NOT NULL,
    cos_fecha_ts         DATETIME NOT NULL,
    cos_usuario_ts       login NOT NULL,
    cos_oficina_ts       SMALLINT NOT NULL,
    cos_terminal_ts      VARCHAR (30) NOT NULL,
    cos_operacion_ts     CHAR (1) NOT NULL,
    cos_secuencial       INT,
    cos_operacion        INT NOT NULL,
    cos_fecha_aplica     DATETIME,
    cos_valor            MONEY,
    cos_porcentaje       FLOAT,
    cos_concepto         catalogo,
    cos_estado_concepto  TINYINT,
    cos_usuario          login,
    cos_rol_condona      TINYINT,
    cos_autoriza         TINYINT,
    cos_estado           CHAR (1),
    cos_excepcion        CHAR (1),
    cos_porcentaje_par   FLOAT
    )
GO

IF OBJECT_ID ('dbo.ca_condonacion_autorizacion') IS NOT NULL
    DROP TABLE dbo.ca_condonacion_autorizacion
GO

CREATE TABLE dbo.ca_condonacion_autorizacion
    (
    ca_funcionario SMALLINT NOT NULL,
    ca_concepto    catalogo NOT NULL,
    ca_porcentaje  FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_condonacion') IS NOT NULL
    DROP TABLE dbo.ca_condonacion
GO

CREATE TABLE dbo.ca_condonacion
    (
    co_secuencial      INT,
    co_operacion       INT NOT NULL,
    co_fecha_aplica    DATETIME,
    co_valor           MONEY,
    co_porcentaje      FLOAT,
    co_concepto        catalogo,
    co_estado_concepto TINYINT,
    co_usuario         login,
    co_rol_condona     TINYINT,
    co_autoriza        TINYINT,
    co_estado          CHAR (1),
    co_excepcion       CHAR (1),
    co_porcentaje_par  FLOAT
    )
GO

CREATE INDEX ca_condonacion_idx1
    ON dbo.ca_condonacion (co_operacion, co_fecha_aplica, co_secuencial)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_conciliacion_mensual') IS NOT NULL
    DROP TABLE dbo.ca_conciliacion_mensual
GO

CREATE TABLE dbo.ca_conciliacion_mensual
    (
    cm_fecha_proceso     DATETIME NOT NULL,
    cm_operacion         INT NOT NULL,
    cm_banco             cuenta,
    cm_tramite           INT NOT NULL,
    cm_oficina           INT NOT NULL,
    cm_llave_redescuento cuenta NOT NULL,
    cm_fecha_redescuento DATETIME NOT NULL,
    cm_nombre            VARCHAR (20) NOT NULL,
    cm_tasa_nominal      FLOAT NOT NULL,
    cm_formula_tasa      VARCHAR (40) NOT NULL,
    cm_saldo_redescuento MONEY,
    cm_valor_interes     MONEY,
    cm_modalidad_pago    CHAR (1) NOT NULL,
    cm_norma_legal       cuenta NOT NULL,
    cm_prox_interes      DATETIME,
    cm_valor_capitalizar MONEY,
    cm_banco_sdo_piso    catalogo NOT NULL,
    cm_identificacion    cuenta NOT NULL,
    cm_diferencia        MONEY,
    cm_estado            CHAR (1),
    cm_my                CHAR (1),
    cm_mw                CHAR (1),
    cm_llave_red         FLOAT,
    cm_ident             FLOAT
    )
GO

CREATE INDEX ca_conciliacion_mensual_key
    ON dbo.ca_conciliacion_mensual (cm_llave_redescuento, cm_identificacion)
GO

CREATE INDEX ca_conciliacion_mensual_key1
    ON dbo.ca_conciliacion_mensual (cm_fecha_proceso, cm_banco_sdo_piso)
GO

IF OBJECT_ID ('dbo.ca_conciliacion_diaria_his') IS NOT NULL
    DROP TABLE dbo.ca_conciliacion_diaria_his
GO

CREATE TABLE dbo.ca_conciliacion_diaria_his
    (
    cdh_fecha_proceso     DATETIME NOT NULL,
    cdh_fecha_ven_cuota   DATETIME NOT NULL,
    cdh_banco             cuenta NOT NULL,
    cdh_operacion         INT NOT NULL,
    cdh_tramite           INT,
    cdh_oficina           INT NOT NULL,
    cdh_llave_redescuento cuenta NOT NULL,
    cdh_fecha_redescuento DATETIME NOT NULL,
    cdh_nombre            VARCHAR (20) NOT NULL,
    cdh_dias_interes      INT NOT NULL,
    cdh_tasa_nominal      FLOAT,
    cdh_formula_tasa      VARCHAR (20) NOT NULL,
    cdh_saldo_redescuento MONEY,
    cdh_abono_capital     MONEY,
    cdh_abono_interes     MONEY,
    cdh_modalidad_pago    CHAR (1) NOT NULL,
    cdh_norma_legal       cuenta,
    cdh_prox_interes      DATETIME,
    cdh_valor_capitalizar MONEY,
    cdh_banco_sdo_piso    catalogo NOT NULL,
    cdh_identificacion    cuenta NOT NULL,
    cdh_estado            CHAR (1),
    cdh_dividendo         INT NOT NULL,
    cdh_fecha_desembolso  DATETIME NOT NULL,
    cdh_z1                CHAR (1),
    cdh_w                 CHAR (1),
    cdh_cotizacion        FLOAT
    )
GO

CREATE INDEX ca_conc_diaria_key3
    ON dbo.ca_conciliacion_diaria_his (cdh_fecha_proceso, cdh_operacion)
GO

IF OBJECT_ID ('dbo.ca_conciliacion_diaria') IS NOT NULL
    DROP TABLE dbo.ca_conciliacion_diaria
GO

CREATE TABLE dbo.ca_conciliacion_diaria
    (
    cd_fecha_proceso     DATETIME NOT NULL,
    cd_fecha_ven_cuota   DATETIME NOT NULL,
    cd_banco             cuenta NOT NULL,
    cd_operacion         INT NOT NULL,
    cd_tramite           INT,
    cd_oficina           INT NOT NULL,
    cd_llave_redescuento cuenta NOT NULL,
    cd_fecha_redescuento DATETIME NOT NULL,
    cd_nombre            VARCHAR (64) NOT NULL,
    cd_dias_interes      INT NOT NULL,
    cd_tasa_nominal      FLOAT,
    cd_formula_tasa      VARCHAR (20) NOT NULL,
    cd_saldo_redescuento MONEY,
    cd_abono_capital     MONEY,
    cd_abono_interes     MONEY,
    cd_modalidad_pago    CHAR (1) NOT NULL,
    cd_norma_legal       cuenta,
    cd_prox_interes      DATETIME,
    cd_valor_capitalizar MONEY,
    cd_banco_sdo_piso    catalogo NOT NULL,
    cd_identificacion    cuenta NOT NULL,
    cd_estado            CHAR (1),
    cd_dividendo         INT NOT NULL,
    cd_fecha_desembolso  DATETIME NOT NULL,
    cd_z1                CHAR (1),
    cd_w                 CHAR (1),
    cd_cotizacion        FLOAT
    )
GO

CREATE INDEX ca_conc_diaria_key2
    ON dbo.ca_conciliacion_diaria (cd_operacion, cd_dividendo)
GO

IF OBJECT_ID ('dbo.ca_conciliacion_act_pas') IS NOT NULL
    DROP TABLE dbo.ca_conciliacion_act_pas
GO

CREATE TABLE dbo.ca_conciliacion_act_pas
    (
    cap_fecha_proceso        DATETIME,
    cap_oficina              INT,
    cap_regional             INT,
    cap_llave_redescuento    cuenta,
    cap_obligacion_activa    cuenta,
    cap_obligacion_pasiva    cuenta,
    cap_nombre               descripcion,
    cap_identificacion       cuenta,
    cap_saldo_capital_activa MONEY,
    cap_saldo_capital_pasiva MONEY,
    cap_formula_tactiva      descripcion,
    cap_formula_tpasiva      descripcion,
    cap_tasa_nom_activa      FLOAT,
    cap_tasa_nom_pasiva      FLOAT,
    cap_dias_de_mora         INT,
    cap_tipo_productor       descripcion,
    cap_destino_economico    descripcion,
    cap_normal_legal         VARCHAR (255),
    cap_margen_redescuento   FLOAT,
    cap_valor_desembolso     MONEY,
    cap_fecha_desembolso     DATETIME,
    cap_num_pagare           VARCHAR (64),
    cap_tipo_linea           descripcion,
    cap_pas_sin_act          CHAR (1),
    cap_pas_salmayor_act     CHAR (1),
    cap_act_sin_pas          CHAR (1),
    cap_nomora_saldodif      CHAR (1),
    cap_pas_tasamayo_act     CHAR (1)
    )
GO

CREATE INDEX ca_conciliacion_act_pas_1
    ON dbo.ca_conciliacion_act_pas (cap_pas_sin_act)
GO

CREATE INDEX ca_conciliacion_act_pas_2
    ON dbo.ca_conciliacion_act_pas (cap_pas_salmayor_act)
GO

CREATE INDEX ca_conciliacion_act_pas_3
    ON dbo.ca_conciliacion_act_pas (cap_act_sin_pas)
GO

CREATE INDEX ca_conciliacion_act_pas_4
    ON dbo.ca_conciliacion_act_pas (cap_nomora_saldodif)
GO

IF OBJECT_ID ('dbo.ca_conci_dia_findeter_tmp') IS NOT NULL
    DROP TABLE dbo.ca_conci_dia_findeter_tmp
GO

CREATE TABLE dbo.ca_conci_dia_findeter_tmp
    (
    cdft_fecha_proceso     DATETIME,
    cdft_num_oper_cobis    cuenta,
    cdft_num_oper_findeter cuenta,
    cdft_beneficiario      CHAR (30),
    cdft_departamento      CHAR (20),
    cdft_pagare            CHAR (64),
    cdft_saldo_capital     MONEY,
    cdft_valor_capital     MONEY,
    cdft_fecha_desde       DATETIME,
    cdft_fecha_hasta       DATETIME,
    cdft_dias              INT,
    cdft_modalida_pago     CHAR (5),
    cdft_tasa_redes        CHAR (20),
    cdft_tasa              FLOAT,
    cdft_valor_interes     MONEY,
    cdft_neto_pagar        MONEY,
    cdft_marcar_diff       CHAR (1),
    cdft_no_conciliada     CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_conci_dia_findeter') IS NOT NULL
    DROP TABLE dbo.ca_conci_dia_findeter
GO

CREATE TABLE dbo.ca_conci_dia_findeter
    (
    cf_fecha_proceso     DATETIME,
    cf_num_oper_cobis    cuenta,
    cf_num_oper_findeter cuenta,
    cf_beneficiario      CHAR (30),
    cf_departamento      CHAR (20),
    cf_pagare            CHAR (64),
    cf_saldo_capital     MONEY,
    cf_valor_capital     MONEY,
    cf_fecha_desde       DATETIME,
    cf_fecha_hasta       DATETIME,
    cf_dias              INT,
    cf_modalida_pago     CHAR (5),
    cf_tasa_redes        CHAR (20),
    cf_tasa              FLOAT,
    cf_valor_interes     MONEY,
    cf_neto_pagar        MONEY,
    cf_marcar_diff       CHAR (1),
    cf_no_conciliada     CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_conci_dia_bancoldex') IS NOT NULL
    DROP TABLE dbo.ca_conci_dia_bancoldex
GO

CREATE TABLE dbo.ca_conci_dia_bancoldex
    (
    cb_fecha_proceso      DATETIME,
    cb_linea              cuenta,
    cb_num_oper_cobis     cuenta,
    cb_num_oper_bancoldex cuenta,
    cb_ciudad             INT,
    cb_beneficiario       CHAR (30),
    cb_ref_externa        cuenta,
    cb_saldo_capital      MONEY,
    cb_tasa               FLOAT,
    cb_dias               INT,
    cb_valor_interes      MONEY,
    cb_valor_capital      MONEY,
    cb_valor_mora         MONEY,
    cb_neto_pagar         MONEY,
    cb_marcar_diff        CHAR (1),
    cb_no_conciliada      CHAR (1)
    )
GO

CREATE INDEX ca_conci_dia_bancoldex_1
    ON dbo.ca_conci_dia_bancoldex (cb_fecha_proceso, cb_num_oper_bancoldex)
GO

CREATE INDEX ca_conci_dia_bancoldex_2
    ON dbo.ca_conci_dia_bancoldex (cb_num_oper_bancoldex)
GO

IF OBJECT_ID ('dbo.ca_conceptos_tmp') IS NOT NULL
    DROP TABLE dbo.ca_conceptos_tmp
GO

CREATE TABLE dbo.ca_conceptos_tmp
    (
    secuencial_reg INT IDENTITY NOT NULL,
    fecha_pag      DATETIME,
    dtr_operacion  INT,
    dtr_secuencial INT,
    dtr_concepto   catalogo,
    VlorPAgo       MONEY
    )
GO

IF OBJECT_ID ('dbo.ca_concepto_ts') IS NOT NULL
    DROP TABLE dbo.ca_concepto_ts
GO

CREATE TABLE dbo.ca_concepto_ts
    (
    cos_fecha_proceso_ts    DATETIME NOT NULL,
    cos_fecha_ts            DATETIME NOT NULL,
    cos_usuario_ts          login NOT NULL,
    cos_oficina_ts          SMALLINT NOT NULL,
    cos_terminal_ts         VARCHAR (30) NOT NULL,
    cos_tipo_transaccion_ts INT NOT NULL,
    cos_origen_ts           CHAR (1) NOT NULL,
    cos_clase_ts            CHAR (1) NOT NULL,
    cos_concepto            catalogo NOT NULL,
    cos_descripcion         descripcion NOT NULL,
    cos_codigo              TINYINT NOT NULL,
    cos_categoria           catalogo NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_concepto_bancamia') IS NOT NULL
    DROP TABLE dbo.ca_concepto_bancamia
GO

CREATE TABLE dbo.ca_concepto_bancamia
    (
    co_concepto    VARCHAR (10) NOT NULL,
    co_descripcion VARCHAR (64) NOT NULL,
    co_codigo      INT NOT NULL,
    co_categoria   VARCHAR (10) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_concepto') IS NOT NULL
    DROP TABLE dbo.ca_concepto
GO

CREATE TABLE dbo.ca_concepto
    (
    co_concepto    catalogo NOT NULL,
    co_descripcion descripcion NOT NULL,
    co_codigo      TINYINT NOT NULL,
    co_categoria   catalogo NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_comision_recaudo') IS NOT NULL
    DROP TABLE dbo.ca_comision_recaudo
GO

CREATE TABLE dbo.ca_comision_recaudo
    (
    cr_secuencial_ing INT,
    cr_operacion      INT,
    cr_comision_ban   MONEY,
    cr_comision_can   MONEY,
    cr_iva_comision   MONEY
    )
GO

CREATE INDEX idx1
    ON dbo.ca_comision_recaudo (cr_operacion, cr_secuencial_ing)
GO

IF OBJECT_ID ('dbo.ca_codigos_prepago_ts') IS NOT NULL
    DROP TABLE dbo.ca_codigos_prepago_ts
GO

CREATE TABLE dbo.ca_codigos_prepago_ts
    (
    cps_fecha_proceso_ts    DATETIME NOT NULL,
    cps_fecha_ts            DATETIME NOT NULL,
    cps_usuario_ts          login NOT NULL,
    cps_oficina_ts          SMALLINT NOT NULL,
    cps_terminal_ts         VARCHAR (30) NOT NULL,
    cps_tipo_transaccion_ts INT NOT NULL,
    cps_origen_ts           CHAR (1) NOT NULL,
    cps_clase_ts            CHAR (1) NOT NULL,
    cps_codigo              catalogo NOT NULL,
    cps_descripcion         descripcion NOT NULL,
    cps_capitaliza          CHAR (1) NOT NULL,
    cps_estado              CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_codigos_prepago') IS NOT NULL
    DROP TABLE dbo.ca_codigos_prepago
GO

CREATE TABLE dbo.ca_codigos_prepago
    (
    cp_codigo      catalogo NOT NULL,
    cp_descripcion descripcion NOT NULL,
    cp_capitaliza  CHAR (1) NOT NULL,
    cp_estado      CHAR (1) NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_codigo_prepago_1
    ON dbo.ca_codigos_prepago (cp_codigo)
GO

IF OBJECT_ID ('dbo.ca_cobranza_castigada_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cobranza_castigada_tmp
GO

CREATE TABLE dbo.ca_cobranza_castigada_tmp
    (
    banco          cuenta,
    estado_op      SMALLINT,
    estado_enviado catalogo
    )
GO

IF OBJECT_ID ('dbo.ca_cobis') IS NOT NULL
    DROP TABLE dbo.ca_cobis
GO

CREATE TABLE dbo.ca_cobis
    (
    ca_llave cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_clientes_tmp') IS NOT NULL
    DROP TABLE dbo.ca_clientes_tmp
GO

CREATE TABLE dbo.ca_clientes_tmp
    (
    secuencial         INT,
    estado             VARCHAR (10),
    empleado           VARCHAR (20),
    operacionca        INT,
    num_oper           cuenta,
    moneda             SMALLINT,
    toperacion         catalogo,
    saldo_op           MONEY,
    saldo_capital      MONEY,
    saldo_interes      MONEY,
    saldo_mora         MONEY,
    saldo_seguros      MONEY,
    saldo_otros_cargos MONEY,
    saldo_pagar        MONEY,
    fecha_pago         DATETIME,
    num_cuotas         SMALLINT
    )
GO


create nonclustered index ca_cliente_tmp_2 on ca_cliente_tmp (clt_operacion,clt_cliente,clt_user)
go

IF OBJECT_ID ('dbo.ca_clientes_actualizados') IS NOT NULL
    DROP TABLE dbo.ca_clientes_actualizados
GO

CREATE TABLE dbo.ca_clientes_actualizados
    (
    ca_estado  CHAR (1) NOT NULL,
    ca_cliente INT NOT NULL,
    ca_fecha   DATETIME NOT NULL
    )
GO

CREATE INDEX ca_clientes_actualizados_1
    ON dbo.ca_clientes_actualizados (ca_estado)
GO

CREATE INDEX ca_clientes_actualizados_2
    ON dbo.ca_clientes_actualizados (ca_cliente)
GO

IF OBJECT_ID ('dbo.ca_cliente_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cliente_tmp
GO

CREATE TABLE dbo.ca_cliente_tmp
    (
    clt_user           login NOT NULL,
    clt_sesion         INT NOT NULL,
    clt_operacion      cuenta NOT NULL,
    clt_cliente        INT,
    clt_rol            catalogo NOT NULL,
    clt_ced_ruc        numero,
    clt_titular        INT,
    clt_secuencial     TINYINT NOT NULL,
    clt_central_riesgo CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_cliente_tmp_1
    ON dbo.ca_cliente_tmp (clt_user, clt_sesion, clt_secuencial)
GO

IF OBJECT_ID ('dbo.ca_cli_deudor') IS NOT NULL
    DROP TABLE dbo.ca_cli_deudor
GO

CREATE TABLE dbo.ca_cli_deudor
    (
    tramite INT NOT NULL,
    cliente INT NOT NULL,
    cedula  numero NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cdes_tmp') IS NOT NULL
    DROP TABLE dbo.ca_cdes_tmp
GO

CREATE TABLE dbo.ca_cdes_tmp
    (
    ctm_oficina   SMALLINT NOT NULL,
    ctm_saldo_caj MONEY NOT NULL,
    ctm_des_dia   MONEY NOT NULL,
    ctm_des_ch    MONEY NOT NULL,
    ctm_des_ef    MONEY NOT NULL,
    ctm_des_new   MONEY NOT NULL,
    ctm_des_ren   MONEY NOT NULL,
    ctm_des_pen   MONEY NOT NULL,
    ctm_rec_car   MONEY NOT NULL,
    ctm_proy_rec  MONEY NOT NULL
    )
GO

CREATE INDEX ca_cdes_tmp_akey
    ON dbo.ca_cdes_tmp (ctm_oficina)
GO

IF OBJECT_ID ('dbo.ca_cbte_alineacion') IS NOT NULL
    DROP TABLE dbo.ca_cbte_alineacion
GO

CREATE TABLE dbo.ca_cbte_alineacion
    (
    ca_oficina     SMALLINT NOT NULL,
    ca_fecha       DATETIME NOT NULL,
    ca_producto    TINYINT NOT NULL,
    ca_comprobante INT NOT NULL,
    ca_tipo        VARCHAR (10) NOT NULL,
    ca_estado      CHAR (2) NOT NULL
    )
GO

CREATE INDEX ca_cbte_alineacion_1
    ON dbo.ca_cbte_alineacion (ca_fecha, ca_oficina, ca_tipo)
GO

IF OBJECT_ID ('dbo.ca_categoria_rubro') IS NOT NULL
    DROP TABLE dbo.ca_categoria_rubro
GO

CREATE TABLE dbo.ca_categoria_rubro
    (
    cr_codigo      catalogo NOT NULL,
    cr_descripcion descripcion NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_categoria_rubro_1
    ON dbo.ca_categoria_rubro (cr_codigo)
GO

IF OBJECT_ID ('dbo.ca_castigo_masivo') IS NOT NULL
    DROP TABLE dbo.ca_castigo_masivo
GO

CREATE TABLE dbo.ca_castigo_masivo
    (
    cm_banco         cuenta,
    cm_fecha_castigo DATETIME NOT NULL,
    cm_usuario       VARCHAR (30) NOT NULL,
    cm_fecha_ingreso DATETIME NOT NULL,
    cm_terminal      VARCHAR (30) NOT NULL,
    cm_estado        CHAR (1) NOT NULL,
    cm_acta          catalogo,
    cm_fecha_acta    DATETIME,
    cm_causal        catalogo
    )
GO

CREATE INDEX ca_castigo_masivo_1
    ON dbo.ca_castigo_masivo (cm_estado)
GO

CREATE INDEX ca_castigo_masivo_2
    ON dbo.ca_castigo_masivo (cm_banco)
GO

IF OBJECT_ID ('dbo.ca_carteriza_sobregiros') IS NOT NULL
    DROP TABLE dbo.ca_carteriza_sobregiros
GO

CREATE TABLE dbo.ca_carteriza_sobregiros
    (
    cs_secuencial      INT NOT NULL,
    cs_sesn            INT,
    cs_user            login NOT NULL,
    cs_ofi             SMALLINT NOT NULL,
    cs_date            DATETIME NOT NULL,
    cs_term            VARCHAR (30) NOT NULL,
    cs_cliente         INT NOT NULL,
    cs_toperacion      catalogo NOT NULL,
    cs_oficina         SMALLINT NOT NULL,
    cs_fecha_ini       DATETIME NOT NULL,
    cs_total_sobregiro MONEY NOT NULL,
    cs_lin_credito     cuenta,
    cs_codigo_ext_gar  cuenta NOT NULL,
    cs_dias_vencido    SMALLINT NOT NULL,
    cs_calificacion    CHAR (1) NOT NULL,
    cs_estado_cateriza CHAR (1) NOT NULL,
    cs_estado_batch    CHAR (1) NOT NULL,
    cs_operacion       INT
    )
GO

CREATE UNIQUE INDEX ca_carteriza_sobregiros_1
    ON dbo.ca_carteriza_sobregiros (cs_secuencial)
GO

CREATE INDEX ca_carteriza_sobregiros_2
    ON dbo.ca_carteriza_sobregiros (cs_estado_cateriza, cs_cliente)
GO

IF OBJECT_ID ('dbo.ca_cartera_trasladada_canc') IS NOT NULL
    DROP TABLE dbo.ca_cartera_trasladada_canc
GO

CREATE TABLE dbo.ca_cartera_trasladada_canc
    (
    tc_nro_tramite      INT,
    tc_cod_operacion    VARCHAR (30),
    tc_eje_origen       VARCHAR (30),
    tc_ofc_origen       SMALLINT,
    tc_eje_destino      SMALLINT,
    tc_ofc_destino      SMALLINT,
    tc_cod_cliente      INT,
    tc_fec_cancelacion  DATETIME,
    tc_nota_del_credito TINYINT
    )
GO

CREATE INDEX ca_tras_canc_key
    ON dbo.ca_cartera_trasladada_canc (tc_nro_tramite)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_carta') IS NOT NULL
    DROP TABLE dbo.ca_carta
GO

CREATE TABLE dbo.ca_carta
    (
    ca_secuencial   INT,
    ca_fecha        DATETIME,
    ca_nombre       descripcion,
    ca_direccion    VARCHAR (254),
    ca_ciudad       descripcion,
    ca_asunto       VARCHAR (255),
    ca_cuerpo       VARCHAR (255),
    ca_banco        cuenta,
    ca_nombre_direc descripcion,
    ca_oficina      SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_carga_oper_conflicto_tmp') IS NOT NULL
    DROP TABLE dbo.ca_carga_oper_conflicto_tmp
GO

CREATE TABLE dbo.ca_carga_oper_conflicto_tmp
    (
    oct_tramite INT
    )
GO

IF OBJECT_ID ('dbo.ca_carga_oper_conflicto') IS NOT NULL
    DROP TABLE dbo.ca_carga_oper_conflicto
GO

CREATE TABLE dbo.ca_carga_oper_conflicto
    (
    oc_fecha_proceso      DATETIME,
    oc_banco              VARCHAR (30),
    oc_tramite            INT,
    oc_fecha_calificacion DATETIME,
    oc_calificacion       CHAR (1),
    oc_marca              CHAR (1)
    )
GO

CREATE INDEX idx1
    ON dbo.ca_carga_oper_conflicto (oc_tramite)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_carga_justificaciones') IS NOT NULL
    DROP TABLE dbo.ca_carga_justificaciones
GO

CREATE TABLE dbo.ca_carga_justificaciones
    (
    cj_fecha_carga          DATETIME,
    cj_archivo              VARCHAR (12),
    cj_numero               VARCHAR (15) NOT NULL,
    cj_tasa                 FLOAT NOT NULL,
    cj_fecha_incio          DATETIME NOT NULL,
    cj_fecha_fin            DATETIME NOT NULL,
    cj_linea_jus            VARCHAR (5) NOT NULL,
    cj_monto_jus            MONEY NOT NULL,
    cj_aeci                 CHAR (1),
    cj_destino_bancoldex    CHAR (2),
    cj_fecVence_opBAncoldex DATETIME
    )
GO

CREATE INDEX idx1
    ON dbo.ca_carga_justificaciones (cj_fecha_carga, cj_archivo)
GO

IF OBJECT_ID ('dbo.ca_carga_finagro_tmp') IS NOT NULL
    DROP TABLE dbo.ca_carga_finagro_tmp
GO

CREATE TABLE dbo.ca_carga_finagro_tmp
    (
    fi_fecha_mov       VARCHAR (10),
    fi_indentificacion VARCHAR (30),
    fi_Obligacion      VARCHAR (20),
    fi_valor           MONEY,
    fi_tipo            CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_carga_finagro') IS NOT NULL
    DROP TABLE dbo.ca_carga_finagro
GO

CREATE TABLE dbo.ca_carga_finagro
    (
    fi_fecha_carga    DATETIME,
    fi_secuencia      INT,
    fi_identificacion VARCHAR (20),
    fi_banco          VARCHAR (40),
    fi_valor          INT,
    fi_tipo_ajuste    catalogo,
    fi_diferencia     INT,
    fi_estado_carga   CHAR (1),
    fi_cod_error      INT,
    fi_desc_carga     VARCHAR (256),
    fi_fecha_mov      VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_carga_extractos_aux') IS NOT NULL
    DROP TABLE dbo.ca_carga_extractos_aux
GO

CREATE TABLE dbo.ca_carga_extractos_aux
    (
    cex_corte        INT NOT NULL,
    cex_banca        catalogo,
    cex_ciudad       INT,
    cex_oficina      INT,
    cex_banco        cuenta,
    cex_fecha_desde  DATETIME NOT NULL,
    cex_fecha_hasta  DATETIME NOT NULL,
    cex_mensaje      VARCHAR (255),
    cex_tipo_proceso CHAR (1) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_carga_extractos') IS NOT NULL
    DROP TABLE dbo.ca_carga_extractos
GO

CREATE TABLE dbo.ca_carga_extractos
    (
    ce_corte        INT,
    ce_banca        catalogo,
    ce_ciudad       INT,
    ce_oficina      INT,
    ce_banco        cuenta,
    ce_fecha_desde  DATETIME,
    ce_fecha_hasta  DATETIME,
    ce_mensaje      VARCHAR (255),
    ce_fecha_carga  DATETIME NOT NULL,
    ce_tipo_proceso CHAR (1),
    ce_datos_ok     CHAR (1) NOT NULL
    )
GO

CREATE INDEX id_x1
    ON dbo.ca_carga_extractos (ce_corte)
GO

IF OBJECT_ID ('dbo.ca_capitaliza') IS NOT NULL
    DROP TABLE dbo.ca_capitaliza
GO

CREATE TABLE dbo.ca_capitaliza
    (
    cp_operacion          INT,
    cp_operacion_anterior INT,
    cp_porcentaje         FLOAT,
    cp_total              MONEY,
    cp_capitalizado       MONEY,
    cp_pagado             MONEY,
    cp_pendiente          MONEY,
    cp_moneda             TINYINT,
    cp_estado             TINYINT
    )
GO

CREATE UNIQUE INDEX ca_capitaliza_1
    ON dbo.ca_capitaliza (cp_operacion)
GO

IF OBJECT_ID ('dbo.ca_canceladas_Ext_tmp') IS NOT NULL
    DROP TABLE dbo.ca_canceladas_Ext_tmp
GO

CREATE TABLE dbo.ca_canceladas_Ext_tmp
    (
    oficina     INT,
    nombre_ofi  VARCHAR (64),
    banco       cuenta,
    ced_cliente VARCHAR (30),
    nombre      VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_campos_tablas_rubros') IS NOT NULL
    DROP TABLE dbo.ca_campos_tablas_rubros
GO

CREATE TABLE dbo.ca_campos_tablas_rubros
    (
    ct_concepto   catalogo NOT NULL,
    ct_titulo1    catalogo NOT NULL,
    ct_titulo2    catalogo,
    ct_tipodato1  CHAR (2) NOT NULL,
    ct_tipodato2  CHAR (2),
    ct_titulo3    catalogo,
    ct_nro_rangos SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_campos_errados') IS NOT NULL
    DROP TABLE dbo.ca_campos_errados
GO

CREATE TABLE dbo.ca_campos_errados
    (
    ce_consecutivo       NUMERIC (18) IDENTITY NOT NULL,
    ce_nombre_bd         VARCHAR (32) NOT NULL,
    ce_nombre_tabla      VARCHAR (32) NOT NULL,
    ce_dato_llave1       VARCHAR (50) NOT NULL,
    ce_dato_llave2       VARCHAR (50),
    ce_dato_llave3       VARCHAR (50),
    ce_dato_llave4       VARCHAR (50),
    ce_dato_llave5       VARCHAR (50),
    ce_dato_llave6       VARCHAR (50),
    ce_dato_llave7       VARCHAR (50),
    ce_posicion          INT NOT NULL,
    ce_codigo_error      INT NOT NULL,
    ce_descripcion_error VARCHAR (150),
    ce_tipo_transaccion  INT NOT NULL,
    ce_num_control       INT,
    ce_consec_control    INT
    )
GO

IF OBJECT_ID ('dbo.ca_cambios_treferenciales') IS NOT NULL
    DROP TABLE dbo.ca_cambios_treferenciales
GO

CREATE TABLE dbo.ca_cambios_treferenciales
    (
    ct_fecha_ing   DATETIME NOT NULL,
    ct_referencial VARCHAR (10) NOT NULL,
    ct_valor       FLOAT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cambio_tipo_garantia') IS NOT NULL
    DROP TABLE dbo.ca_cambio_tipo_garantia
GO

CREATE TABLE dbo.ca_cambio_tipo_garantia
    (
    cg_fecha             DATETIME,
    cg_operacion         INT,
    cg_garantia_anterior CHAR (1),
    cg_garantia_nueva    CHAR (1),
    cg_estado            CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_cambio_tipo_garantia_1
    ON dbo.ca_cambio_tipo_garantia (cg_fecha, cg_operacion)
GO

IF OBJECT_ID ('dbo.ca_cambio_fecha') IS NOT NULL
    DROP TABLE dbo.ca_cambio_fecha
GO

CREATE TABLE dbo.ca_cambio_fecha
    (
    cf_operacion  INT NOT NULL,
    cf_dividendo  INT NOT NULL,
    cf_fecha_mov  DATETIME NOT NULL,
    cf_fecha_ref  DATETIME NOT NULL,
    cf_secuencial INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cambio_calificacion_repro') IS NOT NULL
    DROP TABLE dbo.ca_cambio_calificacion_repro
GO

CREATE TABLE dbo.ca_cambio_calificacion_repro
    (
    ccp_fecha                 DATETIME NOT NULL,
    ccp_operacion             INT NOT NULL,
    ccp_calificacion_anterior CHAR (1),
    ccp_calificacion_nueva    CHAR (1),
    ccp_estado_hc             CHAR (1),
    ccp_estado_con            CHAR (1),
    ccp_estado_trc            CHAR (1),
    ccp_estado_mae            CHAR (1),
    ccp_fecha_real            DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_cambio_calificacion') IS NOT NULL
    DROP TABLE dbo.ca_cambio_calificacion
GO

CREATE TABLE dbo.ca_cambio_calificacion
    (
    cc_fecha                 DATETIME NOT NULL,
    cc_operacion             INT NOT NULL,
    cc_calificacion_anterior CHAR (1),
    cc_calificacion_nueva    CHAR (1),
    cc_estado_hc             CHAR (1),
    cc_estado_con            CHAR (1),
    cc_estado_trc            CHAR (1),
    cc_estado_mae            CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_cambio_calificacion_1
    ON dbo.ca_cambio_calificacion (cc_fecha, cc_operacion)
GO

IF OBJECT_ID ('dbo.ca_cabecera_pag') IS NOT NULL
    DROP TABLE dbo.ca_cabecera_pag
GO

CREATE TABLE dbo.ca_cabecera_pag
    (
    oficina     VARCHAR (30) NOT NULL,
    obligacion  VARCHAR (30) NOT NULL,
    nombre      VARCHAR (30) NOT NULL,
    cedula      VARCHAR (30) NOT NULL,
    efectivo    VARCHAR (30) NOT NULL,
    cheque      VARCHAR (30) NOT NULL,
    nota_debito VARCHAR (30) NOT NULL,
    sobrante    VARCHAR (30) NOT NULL,
    estado_pag  VARCHAR (30) NOT NULL,
    fecha_pag   VARCHAR (30) NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_cabecera') IS NOT NULL
    DROP TABLE dbo.ca_cabecera
GO

CREATE TABLE dbo.ca_cabecera
    (
    ca_operacion         INT,
    ca_cliente           INT,
    ca_nombre            descripcion,
    ca_direccion         descripcion,
    ca_nit               cuenta,
    ca_telefono          VARCHAR (16),
    ca_oficina           SMALLINT,
    ca_banco             cuenta,
    ca_fecha_desembol    VARCHAR (10),
    ca_monto             MONEY,
    ca_plazo             VARCHAR (20),
    ca_descripcion_plazo catalogo,
    ca_tipo_amortizacion descripcion,
    ca_cuota             catalogo,
    ca_fecha_vencimiento VARCHAR (10),
    ca_modalidad         CHAR (10),
    ca_toperacion        descripcion,
    ca_tasa_efa          FLOAT,
    ca_moneda            descripcion,
    ca_tasa_ref          catalogo,
    ca_fecha_tasa_ref    VARCHAR (10),
    ca_signo             CHAR (1),
    ca_valor_ref         FLOAT,
    ca_spread            FLOAT,
    ca_monedac           SMALLINT,
    ca_monto_mn          MONEY,
    ca_ciudad            descripcion,
    ca_departamento      descripcion
    )
GO

IF OBJECT_ID ('dbo.ca_buscar_operaciones_tmp') IS NOT NULL
    DROP TABLE dbo.ca_buscar_operaciones_tmp
GO

CREATE TABLE dbo.ca_buscar_operaciones_tmp
    (
    bot_usuario           login,
    bot_operacion         INT,
    bot_moneda            INT,
    bot_fecha_ini         DATETIME,
    bot_lin_credito       cuenta,
    bot_estado            TINYINT,
    bot_migrada           cuenta,
    bot_toperacion        catalogo,
    bot_oficina           SMALLINT,
    bot_oficial           SMALLINT,
    bot_cliente           INT,
    bot_tramite           INT,
    bot_banco             cuenta,
    bot_fecha_reajuste    DATETIME,
    bot_tipo              CHAR (1),
    bot_reajuste_especial CHAR (1),
    bot_reajustable       CHAR (1),
    bot_monto             MONEY,
    bot_monto_aprobado    MONEY,
    bot_anterior          cuenta,
    bot_fecha_ult_proceso DATETIME,
    bot_nro_red           VARCHAR (24),
    bot_ref_exterior      cuenta,
    bot_num_deuda_ext     cuenta,
    bot_num_comex         cuenta,
    bot_tipo_linea        catalogo,
    bot_nombre            descripcion,
    bot_fecha_fin         DATETIME
    )
GO

CREATE INDEX bot_operacion_1
    ON dbo.ca_buscar_operaciones_tmp (bot_operacion)
GO

CREATE INDEX bot_operacion_2
    ON dbo.ca_buscar_operaciones_tmp (bot_usuario)
GO

IF OBJECT_ID ('dbo.ca_bitacora_traslados') IS NOT NULL
    DROP TABLE dbo.ca_bitacora_traslados
GO

CREATE TABLE dbo.ca_bitacora_traslados
    (
    bt_secuencial  INT,
    bt_archivo     VARCHAR (64),
    bt_oficina     INT,
    bt_usuario     VARCHAR (30),
    bt_fecha_carga DATETIME
    )
GO

CREATE INDEX ca_bit_tras_key
    ON dbo.ca_bitacora_traslados (bt_secuencial)
    WITH (FILLFACTOR = 85)
GO

CREATE INDEX ca_bit_tras_key2
    ON dbo.ca_bitacora_traslados (bt_fecha_carga)
    WITH (FILLFACTOR = 85)
GO

IF OBJECT_ID ('dbo.ca_base_rubros_p') IS NOT NULL
    DROP TABLE dbo.ca_base_rubros_p
GO

CREATE TABLE dbo.ca_base_rubros_p
    (
    rp_operacion INT,
    rp_concepto  catalogo,
    rp_dividendo SMALLINT
    )
GO

IF OBJECT_ID ('dbo.ca_base_garantia') IS NOT NULL
    DROP TABLE dbo.ca_base_garantia
GO

CREATE TABLE dbo.ca_base_garantia
    (
    bg_tramite              INT,
    bg_garantia             VARCHAR (64),
    bg_valor_inicial_gar    MONEY,
    bg_porcentaje_cobertura FLOAT,
    bg_base_calculo         MONEY,
    bg_fecha_ult_mod        DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_bancoldex_nocobis') IS NOT NULL
    DROP TABLE dbo.ca_bancoldex_nocobis
GO

CREATE TABLE dbo.ca_bancoldex_nocobis
    (
    bc_fecha_proceso      DATETIME,
    bc_linea              cuenta,
    bc_num_oper_bancoldex cuenta,
    bc_ciudad             INT,
    bc_beneficiario       CHAR (30),
    bc_ref_externa        cuenta,
    bc_saldo_capital      MONEY,
    bc_tasa               FLOAT,
    bc_dias               INT,
    bc_valor_interes      MONEY,
    bc_valor_capital      MONEY,
    bc_valor_mora         MONEY,
    bc_neto_pagar         MONEY,
    bc_oper_cobis         cuenta
    )
GO

IF OBJECT_ID ('dbo.ca_bancoldex') IS NOT NULL
    DROP TABLE dbo.ca_bancoldex
GO

CREATE TABLE dbo.ca_bancoldex
    (
    ca_fecha_proceso  DATETIME,
    ca_operacion      cuenta,
    ca_ciudad         descripcion,
    ca_beneficiario   VARCHAR (128),
    ca_referencia_ext VARCHAR (128),
    ca_saldo          MONEY,
    ca_tasa_redes     VARCHAR (15),
    ca_tasa           FLOAT,
    ca_dias           INT,
    ca_interes        MONEY,
    ca_capital        MONEY,
    ca_total_pag      MONEY,
    ca_nit            VARCHAR (30)
    )
GO

IF OBJECT_ID ('dbo.ca_aviso_cambio_tasas') IS NOT NULL
    DROP TABLE dbo.ca_aviso_cambio_tasas
GO

CREATE TABLE dbo.ca_aviso_cambio_tasas
    (
    act_secuencial     INT NOT NULL,
    act_fecha_proceso  DATETIME NOT NULL,
    act_usuario        login NOT NULL,
    act_fecha_reajuste DATETIME NOT NULL,
    act_asunto         VARCHAR (255) NOT NULL,
    act_parte_cuerpo   VARCHAR (255) NOT NULL,
    act_des_economico  catalogo,
    act_oficina        INT,
    act_linea          catalogo,
    act_generar        CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_autorizacion_condonacion') IS NOT NULL
    DROP TABLE dbo.ca_autorizacion_condonacion
GO

CREATE TABLE dbo.ca_autorizacion_condonacion
    (
    ac_usuario    VARCHAR (64) NOT NULL,
    ac_nombre     VARCHAR (100) NOT NULL,
    ac_rubro      VARCHAR (64) NOT NULL,
    ac_des_rubro  VARCHAR (64) NOT NULL,
    ac_procentaje SMALLINT NOT NULL,
    ac_cargo      INT
    )
GO

IF OBJECT_ID ('dbo.ca_asunto_carta') IS NOT NULL
    DROP TABLE dbo.ca_asunto_carta
GO

CREATE TABLE dbo.ca_asunto_carta
    (
    ca_secuencia     INT,
    ca_secuencia_rej INT,
    ca_asunto        VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.ca_asiento_contable') IS NOT NULL
    DROP TABLE dbo.ca_asiento_contable
GO

CREATE TABLE dbo.ca_asiento_contable
    (
    asiento      INT NOT NULL,
    cuenta       VARCHAR (24) NOT NULL,
    oficina_dest SMALLINT NOT NULL,
    area_dest    INT NOT NULL,
    credito      MONEY NOT NULL,
    debito       MONEY NOT NULL,
    concepto     VARCHAR (10) NOT NULL,
    credito_me   MONEY NOT NULL,
    debito_me    MONEY NOT NULL,
    moneda       INT NOT NULL,
    cotizacion   FLOAT NOT NULL,
    debcred      CHAR (1) NOT NULL,
    moneda_cont  CHAR (1) NOT NULL,
    ente         INT,
    operacion    VARCHAR (24) NOT NULL,
    con_iva      VARCHAR (10) NOT NULL,
    valor_iva    MONEY NOT NULL,
    con_rete     VARCHAR (10) NOT NULL,
    valor_rete   MONEY NOT NULL,
    base         MONEY NOT NULL,
    transaccion  catalogo,
    fecha        DATETIME NOT NULL,
    secuencial   INT NOT NULL,
    oficina      INT NOT NULL,
    codvalor     INT NOT NULL,
    estado       CHAR (10) NOT NULL,
    comprobante  INT,
    fecha_cont   DATETIME
    )
GO

CREATE INDEX ca_asiento_contable_1
    ON dbo.ca_asiento_contable (fecha, operacion, transaccion, secuencial)
GO

IF OBJECT_ID ('dbo.ca_aprob_por_desemb_tmp') IS NOT NULL
    DROP TABLE dbo.ca_aprob_por_desemb_tmp
GO

CREATE TABLE dbo.ca_aprob_por_desemb_tmp
    (
    apd_nombre       descripcion NOT NULL,
    apd_tramite      INT NOT NULL,
    apd_monto        MONEY NOT NULL,
    apd_plazo_meses  SMALLINT NOT NULL,
    apd_cuota        MONEY NOT NULL,
    apd_microseg     MONEY NOT NULL,
    apd_cap_renovar  MONEY NOT NULL,
    apd_int_renovar  MONEY NOT NULL,
    apd_mypimes      MONEY NOT NULL,
    apd_iva_mypimes  MONEY NOT NULL,
    apd_seg_deu_tot  MONEY NOT NULL,
    apd_exequial     MONEY NOT NULL,
    apd_otros_rubros MONEY NOT NULL,
    apd_neto_desemb  MONEY NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_amortizacion_virtual') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_virtual
GO

CREATE TABLE dbo.ca_amortizacion_virtual
    (
    am_operacion INT NOT NULL,
    am_dividendo SMALLINT NOT NULL,
    am_concepto  catalogo NOT NULL,
    am_estado    TINYINT NOT NULL,
    am_periodo   TINYINT NOT NULL,
    am_cuota     MONEY NOT NULL,
    am_gracia    MONEY NOT NULL,
    am_pagado    MONEY NOT NULL,
    am_acumulado MONEY NOT NULL,
    am_secuencia TINYINT NOT NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_amortizacion_1
    ON dbo.ca_amortizacion_virtual (am_operacion, am_dividendo, am_concepto, am_secuencia, am_estado, am_periodo)
GO

IF OBJECT_ID ('dbo.ca_amortizacion_unif') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_unif
GO

CREATE TABLE dbo.ca_amortizacion_unif
    (
    amu_spid      INT NOT NULL,
    amu_operacion INT NOT NULL,
    amu_dividendo SMALLINT NOT NULL,
    amu_concepto  catalogo NOT NULL,
    amu_estado    TINYINT NOT NULL,
    amu_periodo   TINYINT NOT NULL,
    amu_cuota     MONEY NOT NULL,
    amu_gracia    MONEY NOT NULL,
    amu_pagado    MONEY NOT NULL,
    amu_acumulado MONEY NOT NULL,
    amu_secuencia TINYINT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_amortizacion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_tmp
GO

CREATE TABLE dbo.ca_amortizacion_tmp
    (
    amt_operacion INT NOT NULL,
    amt_dividendo SMALLINT NOT NULL,
    amt_concepto  catalogo NOT NULL,
    amt_estado    TINYINT NOT NULL,
    amt_periodo   TINYINT NOT NULL,
    amt_cuota     MONEY NOT NULL,
    amt_gracia    MONEY NOT NULL,
    amt_pagado    MONEY NOT NULL,
    amt_acumulado MONEY NOT NULL,
    amt_secuencia TINYINT NOT NULL
    )
GO

CREATE INDEX idx1
    ON dbo.ca_amortizacion_tmp (amt_operacion, amt_concepto, amt_dividendo)
    WITH (FILLFACTOR = 70)
GO

IF OBJECT_ID ('dbo.ca_amortizacion_resumen') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_resumen
GO

CREATE TABLE dbo.ca_amortizacion_resumen
    (
    am_operacion INT NOT NULL,
    am_dias_mora INT,
    am_saldo     MONEY
    )
GO

CREATE UNIQUE CLUSTERED INDEX idx1
    ON dbo.ca_amortizacion_resumen (am_operacion)
GO

IF OBJECT_ID ('dbo.ca_amortizacion_proyectada') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_proyectada
GO

CREATE TABLE dbo.ca_amortizacion_proyectada
    (
    ap_operacion         INT NOT NULL,
    ap_cuota             SMALLINT NOT NULL,
    ap_dias_calculo      SMALLINT NOT NULL,
    ap_fecha_vencimiento VARCHAR (10) NOT NULL,
    ap_capital           catalogo,
    ap_capital_val       MONEY,
    ap_interes           catalogo,
    ap_interes_val       MONEY,
    ap_mora              catalogo,
    ap_mora_val          MONEY,
    ap_concepto4         catalogo,
    ap_concepto4_val     MONEY,
    ap_concepto5         catalogo,
    ap_concepto5_val     MONEY,
    ap_concepto6         catalogo,
    ap_concepto6_val     MONEY,
    ap_concepto7         catalogo,
    ap_concepto7_val     MONEY,
    ap_valor_cuota       MONEY,
    ap_valor_mn          MONEY,
    ap_estado            catalogo
    )
GO

CREATE INDEX ca_proyectada_1
    ON dbo.ca_amortizacion_proyectada (ap_operacion, ap_cuota)
GO

IF OBJECT_ID ('dbo.ca_amortizacion_his_plano') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_his_plano
GO

CREATE TABLE dbo.ca_amortizacion_his_plano
    (
    amhp_secuencial INT,
    amhp_operacion  INT,
    amhp_dividendo  SMALLINT,
    amhp_concepto   catalogo,
    amhp_estado     TINYINT,
    amhp_periodo    TINYINT,
    amhp_cuota      MONEY,
    amhp_gracia     MONEY,
    amhp_pagado     MONEY,
    amhp_acumulado  MONEY,
    amhp_secuencia  TINYINT
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

CREATE INDEX ca_amortizacion_his_1
    ON dbo.ca_amortizacion_his (amh_operacion, amh_secuencial)
GO

CREATE INDEX ca_amortizacion_his_idx2
    ON dbo.ca_amortizacion_his (amh_secuencial, amh_operacion, amh_dividendo, amh_concepto, amh_estado, amh_periodo, amh_cuota, amh_gracia, amh_pagado, amh_acumulado, amh_secuencia)
    WITH (FILLFACTOR = 85)
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

IF OBJECT_ID ('dbo.ca_amortizacion_ant') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion_ant
GO

CREATE TABLE dbo.ca_amortizacion_ant
    (
    an_secuencial       INT NOT NULL,
    an_operacion        INT NOT NULL,
    an_dividendo        SMALLINT NOT NULL,
    an_estado           TINYINT NOT NULL,
    an_dias_pagados     INT NOT NULL,
    an_valor_pagado     MONEY NOT NULL,
    an_dias_amortizados INT NOT NULL,
    an_valor_amortizado MONEY NOT NULL,
    an_fecha_pago       DATETIME NOT NULL,
    an_tasa_dia         FLOAT NOT NULL,
    an_secuencia        INT NOT NULL
    )
GO

CREATE INDEX ca_amortizacion_ant_1
    ON dbo.ca_amortizacion_ant (an_operacion, an_secuencial, an_dividendo)
GO

IF OBJECT_ID ('dbo.ca_amortizacion') IS NOT NULL
    DROP TABLE dbo.ca_amortizacion
GO

CREATE TABLE dbo.ca_amortizacion
    (
    am_operacion INT NOT NULL,
    am_dividendo SMALLINT NOT NULL,
    am_concepto  catalogo NOT NULL,
    am_estado    TINYINT NOT NULL,
    am_periodo   TINYINT NOT NULL,
    am_cuota     MONEY NOT NULL,
    am_gracia    MONEY NOT NULL,
    am_pagado    MONEY NOT NULL,
    am_acumulado MONEY NOT NULL,
    am_secuencia TINYINT NOT NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_amortizacion_1
    ON dbo.ca_amortizacion (am_operacion, am_dividendo, am_concepto, am_secuencia)
    WITH (FILLFACTOR = 70)
GO

CREATE INDEX ca_amortizacion_idx2
    ON dbo.ca_amortizacion (am_concepto, am_operacion, am_dividendo, am_cuota, am_gracia, am_pagado)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_alternas_tmp') IS NOT NULL
    DROP TABLE dbo.ca_alternas_tmp
GO

CREATE TABLE dbo.ca_alternas_tmp
    (
    alt_operacion      INT,
    alt_banco          VARCHAR (24),
    alt_monto_mn       MONEY,
    alt_fecha_pag      SMALLDATETIME,
    alt_concepto       VARCHAR (10),
    alt_secuencial_pag INT,
    alt_moneda         SMALLINT,
    alt_monto_mpg      MONEY,
    alt_estado         CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_ajuste_finagro') IS NOT NULL
    DROP TABLE dbo.ca_ajuste_finagro
GO

CREATE TABLE dbo.ca_ajuste_finagro
    (
    af_fecha_carga    DATETIME,
    af_identificacion VARCHAR (20),
    af_banco          VARCHAR (40),
    af_valor          MONEY,
    af_tipo_ajuste    catalogo,
    af_diferencia     MONEY,
    af_estado_carga   CHAR (1),
    af_desc_carga     VARCHAR (256),
    af_fecha_mov      VARCHAR (10)
    )
GO

IF OBJECT_ID ('dbo.ca_ahndc_automatica') IS NOT NULL
    DROP TABLE dbo.ca_ahndc_automatica
GO

CREATE TABLE dbo.ca_ahndc_automatica
    (
    nca_operacion     INT,
    nca_banco         VARCHAR (24),
    nca_oficina_op    INT,
    nca_monto_des     MONEY,
    nca_fecha_pago    DATETIME,
    nca_dispo_ant_deb MONEY,
    nca_monto_pago    MONEY,
    nca_intentos_pag  SMALLINT
    )
GO

CREATE INDEX key1
    ON dbo.ca_ahndc_automatica (nca_operacion)
    WITH (FILLFACTOR = 75)
GO

IF OBJECT_ID ('dbo.ca_actualiza_prepagos') IS NOT NULL
    DROP TABLE dbo.ca_actualiza_prepagos
GO

CREATE TABLE dbo.ca_actualiza_prepagos
    (
    app_user             login NOT NULL,
    app_secuencial       INT NOT NULL,
    app_banco            cuenta NOT NULL,
    app_dias_de_interes  INT NOT NULL,
    app_tasa             FLOAT NOT NULL,
    app_fecha_generacion DATETIME NOT NULL,
    app_comentario       descripcion NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_actualiza_llave_tmp') IS NOT NULL
    DROP TABLE dbo.ca_actualiza_llave_tmp
GO

CREATE TABLE dbo.ca_actualiza_llave_tmp
    (
    al_operacion_activa INT NOT NULL,
    al_operacion_pasiva INT NOT NULL,
    al_llave_antes      VARCHAR (64) NOT NULL,
    al_llave_nueva      VARCHAR (64) NOT NULL,
    al_fecha_act        DATETIME NOT NULL,
    al_estado           CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_actualiza_llave_tmp_1
    ON dbo.ca_actualiza_llave_tmp (al_operacion_pasiva)
GO

IF OBJECT_ID ('dbo.ca_actpas_tmp') IS NOT NULL
    DROP TABLE dbo.ca_actpas_tmp
GO

CREATE TABLE dbo.ca_actpas_tmp
    (
    ap_oper_act       cuenta,
    ap_lin_cre_act    VARCHAR (24),
    ap_nom_cli        descripcion,
    ap_oper_pas       cuenta,
    ap_lin_cre_pas    VARCHAR (24),
    ap_entidad_pasiva descripcion,
    ap_fec_ini        DATETIME,
    ap_fec_fin        DATETIME,
    ap_saldo_act      MONEY,
    ap_saldo_pas      MONEY,
    ap_fecha_grb      DATETIME,
    ap_usuario_grb    login,
    ap_fecha_upd      DATETIME,
    ap_usuario_upd    login,
    ap_tipo           CHAR (1),
    ap_fondos_propios CHAR (1),
    ap_origen_fondos  catalogo,
    ap_hora_grb       VARCHAR (10),
    ap_hora_upd       VARCHAR (10),
    ap_moneda         TINYINT
    )
GO

IF OBJECT_ID ('dbo.ca_activas_canceladas') IS NOT NULL
    DROP TABLE dbo.ca_activas_canceladas
GO

CREATE TABLE dbo.ca_activas_canceladas
    (
    can_operacion  INT NOT NULL,
    can_fecha_can  DATETIME NOT NULL,
    can_usuario    login,
    can_tipo       CHAR (1) NOT NULL,
    can_fecha_hora DATETIME NOT NULL
    )
GO

CREATE INDEX ca_activas_canceladas_1
    ON dbo.ca_activas_canceladas (can_operacion, can_fecha_can)
GO

IF OBJECT_ID ('dbo.ca_acciones_ts') IS NOT NULL
    DROP TABLE dbo.ca_acciones_ts
GO

CREATE TABLE dbo.ca_acciones_ts
    (
    acs_fecha_proceso_ts    DATETIME NOT NULL,
    acs_fecha_ts            DATETIME NOT NULL,
    acs_usuario_ts          login NOT NULL,
    acs_oficina_ts          SMALLINT NOT NULL,
    acs_terminal_ts         VARCHAR (30) NOT NULL,
    acs_tipo_transaccion_ts INT NOT NULL,
    acs_origen_ts           CHAR (1) NOT NULL,
    acs_clase_ts            CHAR (1) NOT NULL,
    acs_operacion           INT NOT NULL,
    acs_div_ini             INT NOT NULL,
    acs_div_fin             INT NOT NULL,
    acs_rubro               catalogo NOT NULL,
    acs_valor               MONEY NOT NULL,
    acs_porcentaje          FLOAT NOT NULL,
    acs_divf_ini            INT NOT NULL,
    acs_divf_fin            INT NOT NULL,
    acs_rubrof              catalogo NOT NULL,
    acs_secuencial          INT NOT NULL
    )
GO

IF OBJECT_ID ('dbo.ca_acciones_tmp') IS NOT NULL
    DROP TABLE dbo.ca_acciones_tmp
GO

CREATE TABLE dbo.ca_acciones_tmp
    (
    act_operacion  INT NOT NULL,
    act_div_ini    INT NOT NULL,
    act_div_fin    INT NOT NULL,
    act_rubro      catalogo NOT NULL,
    act_valor      MONEY,
    act_porcentaje FLOAT,
    act_divf_ini   INT NOT NULL,
    act_divf_fin   INT NOT NULL,
    act_rubrof     catalogo NOT NULL,
    act_secuencial INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_acciones_tmp_1
    ON dbo.ca_acciones_tmp (act_operacion, act_div_ini, act_div_fin, act_rubro, act_divf_ini, act_divf_fin, act_rubrof)
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

CREATE INDEX ca_acciones_his_1
    ON dbo.ca_acciones_his (ach_operacion, ach_secuencial_his)
GO

IF OBJECT_ID ('dbo.ca_acciones') IS NOT NULL
    DROP TABLE dbo.ca_acciones
GO

CREATE TABLE dbo.ca_acciones
    (
    ac_operacion  INT NOT NULL,
    ac_div_ini    INT NOT NULL,
    ac_div_fin    INT NOT NULL,
    ac_rubro      catalogo NOT NULL,
    ac_valor      MONEY,
    ac_porcentaje FLOAT,
    ac_divf_ini   INT NOT NULL,
    ac_divf_fin   INT NOT NULL,
    ac_rubrof     catalogo NOT NULL,
    ac_secuencial INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_acciones_1
    ON dbo.ca_acciones (ac_operacion, ac_div_ini, ac_div_fin, ac_rubro, ac_divf_ini, ac_divf_fin, ac_rubrof)
GO

IF OBJECT_ID ('dbo.ca_abonos_voluntarios') IS NOT NULL
    DROP TABLE dbo.ca_abonos_voluntarios
GO

CREATE TABLE dbo.ca_abonos_voluntarios
    (
    av_operacion_activa     INT NOT NULL,
    av_secuencial_pag       INT NOT NULL,
    av_fecha_pago           DATETIME NOT NULL,
    av_forma_pago           catalogo NOT NULL,
    av_llave_redescuento    cuenta NOT NULL,
    av_tipo_reduccion       CHAR (1) NOT NULL,
    av_tipo_novedad         CHAR (1) NOT NULL,
    av_estado_registro      CHAR (1) NOT NULL,
    av_abono_extraordinario CHAR (1) NOT NULL,
    av_dividendo_vencido    INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_abonos_voluntarios_1
    ON dbo.ca_abonos_voluntarios (av_operacion_activa, av_secuencial_pag)
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

CREATE UNIQUE INDEX ca_abonos_masivos_his_d_1
    ON dbo.ca_abonos_masivos_his_d (amhd_lote, amhd_banco)
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

CREATE UNIQUE INDEX ca_abonos_masivos_his_1
    ON dbo.ca_abonos_masivos_his (amh_lote, amh_empresa, amh_fecha_ing)
GO

IF OBJECT_ID ('dbo.ca_abonos_masivos_generales') IS NOT NULL
    DROP TABLE dbo.ca_abonos_masivos_generales
GO

CREATE TABLE dbo.ca_abonos_masivos_generales
    (
    mg_lote               INT NOT NULL,
    mg_fecha_cargue       DATETIME,
    mg_nro_credito        cuenta,
    mg_operacion          INT,
    mg_fecha_pago         DATETIME,
    mg_forma_pago         catalogo,
    mg_tipo_aplicacion    CHAR (1),
    mg_tipo_reduccion     CHAR (1),
    mg_monto_pago         MONEY,
    mg_prioridad_concepto catalogo,
    mg_oficina            INT,
    mg_fecha_proceso      DATETIME,
    mg_estado             CHAR (1),
    mg_cuenta             cuenta,
    mg_nro_control        INT,
    mg_tipo_trn           SMALLINT,
    mg_posicion_error     INT,
    mg_codigo_error       INT,
    mg_descripcion_error  VARCHAR (150),
    mg_secuencial_ing     INT,
    mg_moneda             SMALLINT,
    mg_terminal           descripcion,
    mg_usuario            login
    )
GO

IF OBJECT_ID ('dbo.ca_abonos_masivos_cabecera') IS NOT NULL
    DROP TABLE dbo.ca_abonos_masivos_cabecera
GO

CREATE TABLE dbo.ca_abonos_masivos_cabecera
    (
    mc_total_registros INT NOT NULL,
    mc_fecha_archivo   DATETIME NOT NULL,
    mc_monto_total     MONEY NOT NULL,
    mc_secuencial      INT NOT NULL,
    mc_estado          CHAR (1) NOT NULL,
    mc_lote            INT NOT NULL,
    mc_errores         INT,
    mc_archivo         VARCHAR (100) NOT NULL
    )
GO

CREATE INDEX ca_abonos_masivos_cabecera_1
    ON dbo.ca_abonos_masivos_cabecera (mc_fecha_archivo, mc_secuencial)
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
    ar_concepto     catalogo NOT NULL,
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
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_abono_rubro_idx2
    ON dbo.ca_abono_rubro (ar_secuencial, ar_operacion, ar_concepto, ar_dividendo, ar_monto)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_abono_rev_pag') IS NOT NULL
    DROP TABLE dbo.ca_abono_rev_pag
GO

CREATE TABLE dbo.ca_abono_rev_pag
    (
    ab_secuencial_ing          INT,
    ab_secuencial_rpa          INT,
    ab_secuencial_pag          INT,
    ab_operacion               INT,
    ab_fecha_ing               DATETIME,
    ab_fecha_pag               DATETIME,
    ab_cuota_completa          CHAR (1),
    ab_aceptar_anticipos       CHAR (1),
    ab_tipo_reduccion          CHAR (1),
    ab_tipo_cobro              CHAR (1),
    ab_dias_retencion_ini      INT,
    ab_dias_retencion          INT,
    ab_estado                  CHAR (3),
    ab_usuario                 login,
    ab_oficina                 SMALLINT,
    ab_terminal                descripcion,
    ab_tipo                    CHAR (3),
    ab_tipo_aplicacion         CHAR (1),
    ab_nro_recibo              INT,
    ab_tasa_prepago            FLOAT,
    ab_dividendo               SMALLINT,
    ab_calcula_devolucion      CHAR (1),
    ab_prepago_desde_lavigente CHAR (1),
    ab_extraordinario          CHAR (1)
    )
GO

IF OBJECT_ID ('dbo.ca_abono_renovacion') IS NOT NULL
    DROP TABLE dbo.ca_abono_renovacion
GO

CREATE TABLE dbo.ca_abono_renovacion
    (
    ar_tramite_ren    INT,
    ar_operacion      INT,
    ar_usuario        VARCHAR (30),
    ar_fecha_gra      DATETIME,
    ar_estado_reg     CHAR (1),
    ar_concepto       catalogo,
    ar_estado         TINYINT,
    ar_monto_pago     MONEY,
    ar_secuencial_ing INT,
    ar_fecha_hora_gra DATETIME,
    ar_estado_cuota   TINYINT
    )
GO

CREATE INDEX idx1
    ON dbo.ca_abono_renovacion (ar_tramite_ren)
GO

IF OBJECT_ID ('dbo.ca_abono_prioridad_tmp') IS NOT NULL
    DROP TABLE dbo.ca_abono_prioridad_tmp
GO

CREATE TABLE dbo.ca_abono_prioridad_tmp
    (
    apt_secuencial_ing INT NOT NULL,
    apt_operacion      INT NOT NULL,
    apt_concepto       catalogo NOT NULL,
    apt_prioridad      INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_abono_prioridad_tmp_1
    ON dbo.ca_abono_prioridad_tmp (apt_operacion, apt_secuencial_ing, apt_concepto)
GO

IF OBJECT_ID ('dbo.ca_abono_prioridad') IS NOT NULL
    DROP TABLE dbo.ca_abono_prioridad
GO

CREATE TABLE dbo.ca_abono_prioridad
    (
    ap_secuencial_ing INT NOT NULL,
    ap_operacion      INT NOT NULL,
    ap_concepto       catalogo NOT NULL,
    ap_prioridad      INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_abono_prioridad_1
    ON dbo.ca_abono_prioridad (ap_operacion, ap_secuencial_ing, ap_concepto)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.ca_abono_masivo_prioridad') IS NOT NULL
    DROP TABLE dbo.ca_abono_masivo_prioridad
GO

CREATE TABLE dbo.ca_abono_masivo_prioridad
    (
    amp_secuencial_ing INT NOT NULL,
    amp_operacion      INT NOT NULL,
    amp_concepto       catalogo NOT NULL,
    amp_prioridad      INT NOT NULL
    )
GO

CREATE UNIQUE INDEX ca_abono_masivo_prioridad_1
    ON dbo.ca_abono_masivo_prioridad (amp_operacion, amp_secuencial_ing, amp_concepto)
GO

IF OBJECT_ID ('dbo.ca_abono_masivo_errores') IS NOT NULL
    DROP TABLE dbo.ca_abono_masivo_errores
GO

CREATE TABLE dbo.ca_abono_masivo_errores
    (
    er_lote       INT,
    er_empresa    INT,
    er_cliente    INT,
    er_banco      cuenta,
    er_error      INT,
    er_proceso    VARCHAR (30),
    er_ioperacion CHAR (1),
    er_fecha      DATETIME
    )
GO

IF OBJECT_ID ('dbo.ca_abono_masivo_det') IS NOT NULL
    DROP TABLE dbo.ca_abono_masivo_det
GO

CREATE TABLE dbo.ca_abono_masivo_det
    (
    abmd_secuencial_ing  INT NOT NULL,
    abmd_operacion       INT NOT NULL,
    abmd_tipo            CHAR (3) NOT NULL,
    abmd_concepto        catalogo NOT NULL,
    abmd_cuenta          cuenta NOT NULL,
    abmd_beneficiario    CHAR (50) NOT NULL,
    abmd_moneda          TINYINT NOT NULL,
    abmd_monto_mpg       MONEY NOT NULL,
    abmd_monto_mop       MONEY NOT NULL,
    abmd_monto_mn        MONEY NOT NULL,
    abmd_cotizacion_mpg  MONEY NOT NULL,
    abmd_cotizacion_mop  MONEY NOT NULL,
    abmd_tcotizacion_mpg CHAR (1) NOT NULL,
    abmd_tcotizacion_mop CHAR (1) NOT NULL,
    abmd_cheque          INT,
    abmd_cod_banco       catalogo
    )
GO

CREATE UNIQUE INDEX ca_abono_masivo_det_1
    ON dbo.ca_abono_masivo_det (abmd_operacion, abmd_secuencial_ing, abmd_tipo, abmd_concepto)
GO

IF OBJECT_ID ('dbo.ca_abono_masivo') IS NOT NULL
    DROP TABLE dbo.ca_abono_masivo
GO

CREATE TABLE dbo.ca_abono_masivo
    (
    abm_lote               INT NOT NULL,
    abm_secuencial_ing     INT NOT NULL,
    abm_secuencial_rpa     INT NOT NULL,
    abm_secuencial_pag     INT NOT NULL,
    abm_operacion          INT NOT NULL,
    abm_fecha_ing          DATETIME NOT NULL,
    abm_fecha_pag          DATETIME NOT NULL,
    abm_cuota_completa     CHAR (1) NOT NULL,
    abm_aceptar_anticipos  CHAR (1) NOT NULL,
    abm_tipo_reduccion     CHAR (1) NOT NULL,
    abm_tipo_cobro         CHAR (1) NOT NULL,
    abm_dias_retencion_ini INT NOT NULL,
    abm_dias_retencion     INT NOT NULL,
    abm_estado             CHAR (3) NOT NULL,
    abm_usuario            login NOT NULL,
    abm_oficina            SMALLINT NOT NULL,
    abm_terminal           descripcion NOT NULL,
    abm_tipo               CHAR (3) NOT NULL,
    abm_tipo_aplicacion    CHAR (1) NOT NULL,
    abm_nro_recibo         INT NOT NULL,
    abm_tasa_prepago       FLOAT,
    abm_dividendo          SMALLINT,
    abm_calcula_devolucion CHAR (1)
    )
GO

CREATE UNIQUE INDEX ca_abono_masivo_1
    ON dbo.ca_abono_masivo (abm_operacion, abm_secuencial_ing)
GO

CREATE INDEX ca_abono_masivo_2
    ON dbo.ca_abono_masivo (abm_lote)
GO

IF OBJECT_ID ('dbo.ca_abono_fng') IS NOT NULL
    DROP TABLE dbo.ca_abono_fng
GO

CREATE TABLE dbo.ca_abono_fng
    (
    af_operacion  INT NOT NULL,
    af_fecha      DATETIME NOT NULL,
    af_secuencial INT NOT NULL,
    af_monto      MONEY NOT NULL,
    af_accion     CHAR (3) NOT NULL
    )
GO

CREATE INDEX idx2
    ON dbo.ca_abono_fng (af_fecha)
GO

CREATE UNIQUE INDEX idx1
    ON dbo.ca_abono_fng (af_operacion, af_secuencial)
GO

IF OBJECT_ID ('dbo.ca_abono_det_tmp') IS NOT NULL
    DROP TABLE dbo.ca_abono_det_tmp
GO

CREATE TABLE dbo.ca_abono_det_tmp
    (
    abdt_user            login NOT NULL,
    abdt_sesn            INT NOT NULL,
    abdt_secuencial_ing  INT,
    abdt_operacion       INT,
    abdt_tipo            CHAR (3) NOT NULL,
    abdt_concepto        catalogo NOT NULL,
    abdt_cuenta          cuenta NOT NULL,
    abdt_beneficiario    CHAR (50),
    abdt_moneda          TINYINT NOT NULL,
    abdt_monto_mpg       MONEY NOT NULL,
    abdt_monto_mop       MONEY NOT NULL,
    abdt_monto_mn        MONEY NOT NULL,
    abdt_cotizacion_mpg  MONEY NOT NULL,
    abdt_cotizacion_mop  MONEY NOT NULL,
    abdt_tcotizacion_mpg CHAR (1) NOT NULL,
    abdt_tcotizacion_mop CHAR (1) NOT NULL,
    abdt_cheque          INT,
    abdt_cod_banco       catalogo,
    abdt_inscripcion     INT,
    abdt_carga           INT,
    abdt_porcentaje_con  FLOAT
    )
GO

CREATE UNIQUE INDEX ca_abono_det_tmp_1
    ON dbo.ca_abono_det_tmp (abdt_user, abdt_sesn, abdt_tipo, abdt_concepto)
GO

IF OBJECT_ID ('dbo.ca_abono_det') IS NOT NULL
    DROP TABLE dbo.ca_abono_det
GO

CREATE TABLE dbo.ca_abono_det
    (
    abd_secuencial_ing  INT NOT NULL,
    abd_operacion       INT NOT NULL,
    abd_tipo            CHAR (3) NOT NULL,
    abd_concepto        catalogo NOT NULL,
    abd_cuenta          cuenta NOT NULL,
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
    abd_cod_banco       catalogo,
    abd_inscripcion     INT,
    abd_carga           INT,
    abd_porcentaje_con  FLOAT
    )
GO

CREATE UNIQUE INDEX ca_abono_det_1
    ON dbo.ca_abono_det (abd_operacion, abd_secuencial_ing, abd_tipo, abd_concepto, abd_cuenta)
    WITH (FILLFACTOR = 90)
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
    ab_usuario                 login NOT NULL,
    ab_oficina                 SMALLINT NOT NULL,
    ab_terminal                descripcion NOT NULL,
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

CREATE CLUSTERED INDEX ca_abono_1
    ON dbo.ca_abono (ab_operacion, ab_secuencial_ing)
    WITH (FILLFACTOR = 80)
GO

CREATE INDEX ca_abono_3
    ON dbo.ca_abono (ab_secuencial_pag)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_abono_4
    ON dbo.ca_abono (ab_estado)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_abono_5
    ON dbo.ca_abono (ab_fecha_pag)
    WITH (FILLFACTOR = 90)
GO

CREATE INDEX ca_abono_idx6
    ON dbo.ca_abono (ab_secuencial_rpa, ab_secuencial_ing, ab_operacion, ab_fecha_ing)
    WITH (FILLFACTOR = 90)
GO

IF OBJECT_ID ('dbo.bcp_condonaciones_def') IS NOT NULL
    DROP TABLE dbo.bcp_condonaciones_def
GO

CREATE TABLE dbo.bcp_condonaciones_def
    (
    OBLIGACION        cuenta,
    FECHA             VARCHAR (10),
    NOMBRE            descripcion,
    CEDULA            descripcion,
    USUARIO           login,
    ITEM              catalogo,
    VALOR_CONDONACION VARCHAR (30),
    PORCENTAJE        VARCHAR (30),
    CAPITAL_INI_PER   VARCHAR (30),
    ESTADO            descripcion,
    CARGO             catalogo,
    PAGOS             MONEY,
    SALDO_DESP_CON    MONEY
    )
GO

IF OBJECT_ID ('dbo.bcp_25_reest') IS NOT NULL
    DROP TABLE dbo.bcp_25_reest
GO

CREATE TABLE dbo.bcp_25_reest
    (
    banco         cuenta,
    identifica    VARCHAR (20),
    nombre        descripcion,
    fecha_ini     VARCHAR (10),
    gracia        INT,
    monto_ini     MONEY,
    monto_res     MONEY,
    vlr_garantia  MONEY,
    calificacion  VARCHAR (10),
    dias_mora     INT,
    provision     MONEY,
    tipo          VARCHAR (50),
    clase         VARCHAR (20),
    descripcion   VARCHAR (63),
    fecha_fin     VARCHAR (10),
    fecha_fin_res VARCHAR (10),
    fecha_ini_res VARCHAR (10),
    gracia_res    INT,
    tasa_ini      FLOAT,
    tasa_res      FLOAT
    )
GO

IF OBJECT_ID ('dbo.asiento') IS NOT NULL
    DROP TABLE dbo.asiento
GO

CREATE TABLE dbo.asiento
    (
    asiento      INT NOT NULL,
    cuenta       VARCHAR (24) NOT NULL,
    oficina_dest SMALLINT NOT NULL,
    area_dest    INT NOT NULL,
    credito      MONEY NOT NULL,
    debito       MONEY NOT NULL,
    concepto     VARCHAR (10) NOT NULL,
    credito_me   MONEY NOT NULL,
    debito_me    MONEY NOT NULL,
    moneda       INT NOT NULL,
    cotizacion   FLOAT NOT NULL,
    debcred      CHAR (1) NOT NULL,
    moneda_cont  CHAR (1) NOT NULL,
    ente         INT,
    operacion    VARCHAR (24),
    con_iva      VARCHAR (10),
    valor_iva    MONEY,
    con_rete     VARCHAR (10),
    valor_rete   MONEY,
    base         MONEY,
    descripcion  VARCHAR (255)
    )
GO

IF OBJECT_ID ('dbo.am_saldos') IS NOT NULL
    DROP TABLE dbo.am_saldos
GO

CREATE TABLE dbo.am_saldos
    (
    am_operacion INT NOT NULL,
    am_saldo     MONEY
    )
GO

CREATE INDEX am_operacion_1
    ON dbo.am_saldos (am_operacion)
GO

IF OBJECT_ID ('dbo.ca_oper_cambio_linea_x_mora') IS NOT NULL
    DROP TABLE dbo.ca_oper_cambio_linea_x_mora
GO

CREATE table dbo.ca_oper_cambio_linea_x_mora
    (
     cl_sec_tran       int         null, 
     cl_banco          varchar(25) null,
     cl_ccliente       int         null,
     cl_linea_origen   catalogo    null,
     cl_linea_destino  catalogo    null,
     cl_estado         char(2)     null,
     cl_fecha          datetime    null,
     cl_fecha_upd      datetime    null
     )
GO

if OBJECT_ID ('dbo.ca_cli_emproblemado_tmp') IS NOT NULL
    drop table dbo.ca_cli_emproblemado_tmp
go

create table ca_cli_emproblemado_tmp
(
    cet_fecha           datetime,
    cet_ced_ruc         varchar(30),
    cet_nomlar          varchar(254),
    cet_ejecutor        varchar(30),
    cet_emproblemado    char(1)
)
go

if OBJECT_ID ('dbo.ca_cli_emproblemado') IS NOT NULL
    drop table dbo.ca_cli_emproblemado
go

create table ca_arch_cli_emproblemado
(
    ace_archivo         int,
    ace_nombre_arch     varchar(50),
    ace_usuario         login,
    ace_fec_proceso     datetime,
    ace_fec_act         datetime
)
go

CREATE UNIQUE CLUSTERED INDEX ca_arch_cli_emp_Key
    ON ca_arch_cli_emproblemado (ace_archivo)
GO

if OBJECT_ID ('dbo.ca_arch_cli_emproblemado') IS NOT NULL
    drop table dbo.ca_arch_cli_emproblemado
go

create table ca_cli_emproblemado
(
    ce_cli_emp          int,
    ce_secuencia        int,
    ce_fecha            datetime,
    ce_ced_ruc          varchar(30),
    ce_nomlar           varchar(254),
    ce_ejecutor         varchar(30),
    ce_emproblemado     char(1),
    ce_encontrado       char(1)     null,
    ce_procesado        char(1)     null,
    ce_ente             int         null
)

go

CREATE UNIQUE CLUSTERED INDEX ca_cli_emp_Key
    ON ca_cli_emproblemado (ce_cli_emp, ce_secuencia)
GO

CREATE INDEX ce_fecha_cli_emp_key
    ON ca_cli_emproblemado (ce_fecha)
GO

-- TABLA DE PARAMETRIA DE PROVISIONES EN cob_cuenta_super
IF OBJECT_ID ('cob_conta_super..sb_provisiones') IS NOT NULL
    DROP TABLE cob_conta_super..sb_provisiones
GO

CREATE TABLE cob_conta_super..sb_provisiones
(
    pr_clase_cartera    catalogo,
    pr_tipo_cartera     catalogo NULL,
    pr_subtipo_cartera  catalogo NULL,
    pr_calificacion     CHAR(1) NULL,
    pr_dias_mora_ini    INT,
    pr_dias_mora_fin    INT,
    pr_periodo_mora     INT NULL,
    pr_periodo_cuota    catalogo NULL,
    pr_porcentaje       FLOAT
)
GO

CREATE INDEX pr_cla_subtipo_Key
    ON cob_conta_super..sb_provisiones (pr_clase_cartera, pr_subtipo_cartera)
GO

CREATE INDEX pr_calificacion_Key
    ON cob_conta_super..sb_provisiones (pr_calificacion)
GO

IF OBJECT_ID ('ca_comision_diferida') IS NOT NULL
    DROP TABLE ca_comision_diferida
GO


CREATE TABLE ca_comision_diferida
    (
    cd_operacion          INT NOT NULL,
    cd_concepto           catalogo NOT NULL,
    cd_cuota              MONEY NOT NULL,
    cd_acumulado          MONEY  NULL,
    cd_estado             TINYINT NULL,
        cd_cod_valor          INT   NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida1
    ON ca_comision_diferida (cd_operacion,cd_concepto)
GO

IF OBJECT_ID ('ca_comision_diferida_his') IS NOT NULL
    DROP TABLE ca_comision_diferida_his
GO

CREATE TABLE ca_comision_diferida_his
    (   
    cdh_secuencial         INT NOT NULL,
     cdh_operacion          INT NOT NULL,
    cdh_concepto           catalogo NOT NULL,
    cdh_cuota              MONEY NOT NULL,
    cdh_acumulado          MONEY  NULL,
    cdh_estado             TINYINT NULL,
     cdh_cod_valor           INT   NULL
    )
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida_his1
    ON ca_comision_diferida_his (cdh_operacion,cdh_secuencial,cdh_concepto)
GO

IF OBJECT_ID ('dbo.ca_operacion_ext') IS NOT NULL
    DROP TABLE dbo.ca_operacion_ext
GO


CREATE TABLE dbo.ca_operacion_ext
(
   oe_operacion    INT NOT NULL,
   oe_columna      VARCHAR (30) NOT NULL,
   oe_char         VARCHAR (30) NULL,
   oe_tinyint      TINYINT NULL,
   oe_smallint     SMALLINT NULL,
   oe_int          INT NULL,
   oe_money        MONEY NULL,
   oe_datetime     DATETIME NULL,
   oe_estado       VARCHAR (12) NULL,
   oe_tinyInteger  TINYINT NULL,
   oe_smallInteger INT NULL,
   oe_integer      INT NULL,
   oe_float        FLOAT NULL
)
GO

CREATE UNIQUE NONCLUSTERED INDEX ca_operacion_ext_1
   ON dbo.ca_operacion_ext (oe_operacion, oe_columna)
GO

/*LRE 06/ENE/2016 CREACION DE LA TABLA HISTORICA DE PARAMETROS DE CARTERA */
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

/*LRE 06/ENE/2016 CREACION DE LA TABLA TEMPORAL DE PARAMETROS DE CARTERA */
IF OBJECT_ID ('dbo.ca_operacion_ext_tmp') IS NOT NULL
    DROP TABLE dbo.ca_operacion_ext_tmp
GO

CREATE TABLE dbo.ca_operacion_ext_tmp
(
   oet_operacion     INT NOT NULL,
   oet_columna       VARCHAR (30) NOT NULL,
   oet_char          VARCHAR (30) NULL,
   oet_tinyint       TINYINT NULL,
   oet_smallint      SMALLINT NULL,
   oet_int           INT NULL,
   oet_money         MONEY NULL,
   oet_datetime      DATETIME NULL,
   oet_estado        VARCHAR (12) NULL,
   oet_tinyInteger   TINYINT NULL,
   oet_smallInteger  INT NULL,
   oet_integer       INT NULL,
   oet_float         FLOAT NULL
)
GO

CREATE UNIQUE NONCLUSTERED INDEX ca_operacion_ext_tmp_1
   ON dbo.ca_operacion_ext_tmp (oet_operacion, oet_columna)
GO


--Tabla de ciclos grupales
IF OBJECT_ID ('dbo.ca_ciclo') IS NOT NULL
    DROP TABLE dbo.ca_ciclo
GO
CREATE TABLE dbo.ca_ciclo
(
    ci_grupo             int         NOT NULL,
    ci_operacion         int         NOT NULL,
    ci_ciclo             int         NULL,
    ci_tciclo            char(1)     COLLATE Latin1_General_BIN NULL,
    ci_prestamo          varchar(15) COLLATE Latin1_General_BIN NOT NULL,
    ci_tramite           int         NOT NULL,
    ci_cuenta_aho_grupal varchar(16) COLLATE Latin1_General_BIN NULL,
    ci_titular_cta       int         NULL,
    ci_titular_cta2      int         NULL,
    ci_debito_cta_grupal char(1)     COLLATE Latin1_General_BIN NULL,
    ci_fecha_ini         datetime    NULL
)
go

CREATE UNIQUE NONCLUSTERED INDEX ca_ciclo_1
   ON dbo.ca_ciclo (ci_grupo, ci_ciclo)
GO

--Tabla de detalle de ciclos
IF OBJECT_ID ('dbo.ca_det_ciclo') IS NOT NULL
    DROP TABLE dbo.ca_det_ciclo
GO

CREATE TABLE dbo.ca_det_ciclo
(
    dc_grupo             int         NOT NULL,
    dc_ciclo_grupo       int         NOT NULL,
    dc_cliente           int         NOT NULL,
    dc_operacion         int         NOT NULL,
    dc_referencia_grupal varchar(15) COLLATE Latin1_General_BIN NULL,
    dc_ciclo             int         NULL,
    dc_tciclo            char(1)     COLLATE Latin1_General_BIN NULL,
    dc_saldo_vencido     money       NULL,
    dc_ahorro_ini        money       NULL,
    dc_ahorro_ini_int    money       NULL,
    dc_ahorro_voluntario money       NULL,
    dc_incentivos        money       NULL,
    dc_extras            money       NULL,
    dc_devoluciones      money       NULL
)
go

CREATE UNIQUE NONCLUSTERED INDEX ca_det_ciclo_1
   ON dbo.ca_det_ciclo (dc_grupo, dc_ciclo_grupo, dc_cliente, dc_ciclo)
GO



-- ///////////////////////////////////////////////////////////////////////
-- TABLA PARA LA GENERACION DEL ARCHIVO DE PAGOS DE GRUPALES Y EMERGENTES
if exists (select 1 from sysobjects where name = 'ca_pago_grp_env')
    drop table ca_pago_grp_env
go
create table ca_pago_grp_env(
   pe_fecha_proceso       datetime ,
   pe_fecha_envio         datetime ,
   pe_identificacion      char(24) null,
   pe_tipo_identificacion char(10) null,
   pe_numero_cta_debito   char(16) null,
   pe_tipo_pago           char(10) ,
   pe_operacion           int      ,
   pe_banco               char(16) ,
   pe_valor_debitar       money    null,
   pe_valor_debitado      money    null,
   pe_cuenta_expediente   char(16) null,
   pe_referencia_grupal   char(16) null,
   pe_grupo               int      null,
   pe_dividendo           smallint null,
   pe_fecha_ven           datetime null,
   pe_cliente             int          ,
   pe_entidad             char(10)     ,
   pe_estado              char(10)   )

go
create index idx_1 on ca_pago_grp_env (pe_banco,  pe_fecha_proceso)
create index idx_2 on ca_pago_grp_env (pe_operacion)
go


-- TABLA TEMPORAL PARA RECUPERAR EL ARCHIVO DE PAGOS DE GRUPALES Y EMERGENTES
if exists (select 1 from sysobjects where name = 'tmp_pago_grupal')
    drop table tmp_pago_grupal
go
create table tmp_pago_grupal(
   pt_fecha_proceso       datetime ,
   pt_fecha_envio         datetime ,
   pt_tipo_pago           char(10)  ,
   pt_identificacion      char(24) null,
   pt_tipo_identificacion char(10) null,
   pt_numero_cta_debito   char(16) null,
   pt_cuenta_expediente   char(13) null,
   pt_referencia_grupal   char(15) null,
   pt_operacion           int      ,
   pt_banco               char(16) ,
   pt_valor_debitar       money    null,
   pt_valor_debitado      money    null,
   pt_transaccion_id      varchar(65) null,
   pt_entidad             char(10)  ,
   pt_estado              char(10)   )
go
create index idx_1 on tmp_pago_grupal (pt_banco,  pt_fecha_proceso)
create index idx_2 on tmp_pago_grupal (pt_operacion)
go


-- TABLA PARA RECUPERAR EL ARCHIVO DE PAGOS DE GRUPALES Y EMERGENTES
if exists (select 1 from sysobjects where name = 'ca_pago_grp_apl')
    drop table ca_pago_grp_apl
go
create table ca_pago_grp_apl(
   pa_row_id              int primary key IDENTITY(1,1) NOT NULL,
   pa_fecha_proceso       datetime ,
   pa_fecha_envio         datetime ,
   pa_identificacion      char(24) null,
   pa_tipo_identificacion char(10) null,
   pa_numero_cta_debito   char(16) null,
   pa_tipo_pago           char(1)  , 
   pa_operacion           int      ,
   pa_banco               char(16) ,
   pa_valor_debitar       money    null,
   pa_valor_debitado      money    null,
   pa_transaccion_id      varchar(64) null,
   pa_cuenta_expediente   char(13) null,
   pa_referencia_grupal   char(15) null,
   pa_grupo               int      null,
   pa_dividendo           smallint null,
   pa_fecha_ven           datetime null,
   pa_cliente             int          ,
   pa_entidad             char(10)  ,
   pa_secuencial_ing      int,
   pa_estado              char(10)   )

go
create index idx_1 on ca_pago_grp_apl (pa_banco,  pa_fecha_proceso)
create index idx_2 on ca_pago_grp_apl (pa_operacion)
go


--TABLA PARA ALMACENAR DATOS PARA GENERAR ARCHIVO DE INTERFACE PARA ORDENES DE DEPOSITO
if exists (select 1 from sysobjects 
           where name = 'ca_santander_orden_deposito' 
           and type = 'U')
   drop table ca_santander_orden_deposito
go

create table ca_santander_orden_deposito
(
 sod_fecha        datetime,      --fecha_proceso_archivo
 sod_fecha_real   datetime,      --getdate()
 sod_consecutivo  int,           --consecutivo_ejecucion_archivo
 sod_linea        int,           --[0]: cabecera - [num_linea]: detalle - [ultimo_num_linea+1]: pie
 sod_banco        cuenta,        --'CABECERA'/'PIE'/DETALLE OP_BANCO
 sod_operacion    int,           --OP_OPERACION
 sod_secuencial   int,           --SECUENCIAL DE DESEMBOLSO
 sod_linea_dato   varchar(1000),  --DATOS DE DETALLE (LINEA)
 sod_tipo         varchar(10),     --DES cuando se inserta por desembolso y GAR cuando se inserta por garantia
 sod_monto     	  money,
 sod_cliente      in, 
 sod_cuenta       cuenta,
 sod_fecha_valor  datetime null
)
go

create clustered index ca_santander_orden_deposito1
on ca_santander_orden_deposito (sod_fecha, sod_consecutivo, sod_linea)
go

create index ca_santander_orden_deposito2
on ca_santander_orden_deposito (sod_operacion, sod_secuencial)
go

--TABLA PARA ALMACENAR DATOS PARA GENERAR ARCHIVO DE INTERFACE PARA ORDENES DE RETIRO
if exists (select 1 from sysobjects 
           where name = 'ca_santander_orden_retiro' 
           and type = 'U')
   drop table ca_santander_orden_retiro
go

create table ca_santander_orden_retiro
(
 sor_fecha        datetime,      --fecha_proceso_archivo
 sor_fecha_real   datetime,      --getdate()
 sor_linea        int,           --[0]: cabecera - [num_linea]: detalle - [ultimo_num_linea+1]: pie
 sor_banco        cuenta,        --'CABECERA'/'PIE'/DETALLE OP_BANCO
 sor_operacion    int,           --OP_OPERACION
 sor_linea_dato   varchar(500),  --DATOS DE DETALLE (LINEA)
 sor_consecutivo FLOAT NULL,        -- secuencial del archivo en el dia
 sor_fecha_clave  varchar(32) null, -- campo fecha y hora clave 
 sor_error        varchar(10) null, -- error de domiciliacion
 sor_procesado    varchar(10) null  -- flag para re-envio
 )
go

create clustered index ca_santander_orden_retiro1
on ca_santander_orden_retiro (sor_fecha, sor_linea)
go

CREATE INDEX idx1 ON ca_santander_orden_retiro  (sor_fecha_clave)
GO
CREATE INDEX idx2 ON ca_santander_orden_retiro  (sor_fecha_real)
GO



--TABLA PARA ALMACENAR DATOS PARA GENERAR BCP DE ARCHIVO DE INTERFACE PARA ORDENES DE DEPOSITO Y RETIRO
if exists(select 1 from sysobjects where name = 'ca_santander_archivo' and type = 'U')
   drop table ca_santander_archivo
go

create table ca_santander_archivo 
(
   sa_linea_dato varchar (1000) not null
)
go


-- TABLA AUXILIAR PARA BCP DE PAGOS GRUPALES
if exists (select 1 from sysobjects where name = 'tmp_cadena')
    drop table tmp_cadena
go
create table tmp_cadena(
   ca_cadena varchar(1500) null)

go

-- LGU:  tabla usada por sp de credito
IF OBJECT_ID ('dbo.ca_calif_operacion') IS NOT NULL
    DROP TABLE dbo.ca_calif_operacion
GO

CREATE TABLE dbo.ca_calif_operacion
    (
    ca_operacion     INT NULL,
    ca_dividendo     INT NULL,
    ca_fecha_ven     DATETIME NOT NULL,
    ca_fecha_can     DATETIME NOT NULL,
    ca_dias          INT NOT NULL,
    ca_estado        INT NOT NULL,
    ca_tdividendo    VARCHAR (1) NOT NULL,
    ca_cliente       INT NULL,
    ca_calificacion  FLOAT NULL,
    ca_fecha_proceso DATETIME NOT NULL,
    ca_dias_cuota    INT NULL
    )
GO

CREATE NONCLUSTERED INDEX ca_calif_operacion_Key
    ON dbo.ca_calif_operacion (ca_operacion)
GO


IF OBJECT_ID ('dbo.ca_cliente_calificacion') IS NOT NULL
    DROP TABLE dbo.ca_cliente_calificacion
GO
CREATE TABLE dbo.ca_cliente_calificacion  ( 
    ca_ente             int NOT NULL,
    ca_fecha_calif      datetime NULL,
    ca_puntos_operacion float NULL,
    ca_tipo_cliente     char(5) NULL 
    )
GO


IF OBJECT_ID ('dbo.ca_qr_rubro_tmp') IS NOT NULL
    DROP TABLE dbo.ca_qr_rubro_tmp
GO

CREATE TABLE dbo.ca_qr_rubro_tmp
    (
    qrt_id    INT IDENTITY NOT NULL,
    qrt_pid   INT NULL,
    qrt_rubro catalogo NULL
    )
GO

CREATE NONCLUSTERED INDEX ca_qr_rubro_tmp1
    ON dbo.ca_qr_rubro_tmp (qrt_pid)
GO


IF OBJECT_ID ('dbo.ca_qr_amortiza_tmp') IS NOT NULL
    DROP TABLE dbo.ca_qr_amortiza_tmp
GO

CREATE TABLE dbo.ca_qr_amortiza_tmp
    (
    qat_pid        INT NULL,
    qat_dividendo  INT NULL,
    qat_fecha_ven  DATETIME NULL,
    qat_dias_cuota INT NULL,
    qat_saldo_cap  MONEY NULL,
    qat_rubro1     MONEY NULL,
    qat_rubro2     MONEY NULL,
    qat_rubro3     MONEY NULL,
    qat_rubro4     MONEY NULL,
    qat_rubro5     MONEY NULL,
    qat_rubro6     MONEY NULL,
    qat_rubro7     MONEY NULL,
    qat_rubro8     MONEY NULL,
    qat_rubro9     MONEY NULL,
    qat_rubro10    MONEY NULL,
    qat_rubro11    MONEY NULL,
    qat_rubro12    MONEY NULL,
    qat_rubro13    MONEY NULL,
    qat_rubro14    MONEY NULL,
    qat_rubro15    MONEY NULL,
    qat_cuota      MONEY NULL,
    qat_estado     VARCHAR (10) COLLATE Latin1_General_BIN NULL,
    qat_porroga    CHAR (2) COLLATE Latin1_General_BIN NULL
    )
GO

CREATE NONCLUSTERED INDEX ca_qr_amortiza_tmp1
    ON dbo.ca_qr_amortiza_tmp (qat_pid)
GO


IF OBJECT_ID ('ca_fuente_recurso_mov') IS NOT NULL
    DROP TABLE ca_fuente_recurso_mov
GO

create table ca_fuente_recurso_mov(
fm_fondo_id             int          not null,
fm_secuencial           int          identity(1,1),
fm_banco                cuenta       not null,
fm_operacion            int          not null,
fm_secuencial_trn       int          not null,
fm_dividendo            int          not null,
fm_fecha_mov            datetime     not null,
fm_fecha_val            datetime     not null,
fm_hora                 datetime     not null,
fm_monto                money        not null
)
go

create unique index idx1 on ca_fuente_recurso_mov (fm_fondo_id, fm_secuencial)
go
create index idx2 on ca_fuente_recurso_mov (fm_operacion, fm_secuencial_trn)
go
create index idx3 on ca_fuente_recurso_mov (fm_banco)
go

IF OBJECT_ID ('ca_fuente_recurso') IS NOT NULL
    DROP TABLE ca_fuente_recurso
GO

CREATE TABLE ca_fuente_recurso
(
    fr_fondo_id            int         NOT NULL,
    fr_nombre              varchar(100) NOT NULL,
    fr_fuente              varchar(10) NOT NULL,
    fr_monto               money       NOT NULL,
    fr_saldo               money       NOT NULL,
    fr_utilizado           money       NOT NULL,
    fr_estado              varchar(10) NOT NULL,
    fr_tipo_fuente         char(1)     NULL,
    fr_porcentaje          float       NULL,
    fr_porcentaje_otorgado float       NULL,
    fr_fecha_vig           datetime    NULL,
    fr_reservado           money       NULL
)
go


if exists (select 1 from sysobjects 
    where name = 'ca_pago_en_corresponsal' 
    and type = 'U')
drop table ca_pago_en_corresponsal
go

create table ca_pago_en_corresponsal
(
    pc_grupo_id int,
    pc_fecha_proceso datetime,
    pc_grupo_name varchar(64) null,
    pc_op_fecha_liq datetime,
    pc_op_moneda tinyint,
    pc_op_oficina smallint,
    pc_di_fecha_vig datetime,
    pc_di_dividendo int,
    pc_di_monto money,
    pc_institucion1 varchar(20) null,
    pc_referencia1 varchar(255) null,
    pc_institucion2 varchar(20) null,
    pc_referencia2 varchar(255) null,
    pc_institucion3 varchar(20) null,
    pc_referencia3 varchar(255) null,
    pc_institucion4 varchar(20) null,
    pc_referencia4 varchar(255) null,
    pc_dest_nombre1 varchar(60) null,
    pc_dest_cargo1 varchar(100) null,
    pc_dest_email1 varchar(255) null,
    pc_dest_nombre2 varchar(60) null,
    pc_dest_cargo2 varchar(100) null,
    pc_dest_email2 varchar(255) null,
    pc_dest_nombre3 varchar(60) null,
    pc_dest_cargo3 varchar(100) null,
    pc_dest_email3 varchar(255) null
)
go

create clustered index ca_pago_en_corresponsal1
    on ca_pago_en_corresponsal (pc_grupo_id, pc_fecha_proceso)
go

if exists (select 1 from sysobjects 
    where name = 'ca_grupos_vencidos' 
    and type = 'U')
drop table ca_grupos_vencidos
go

create table ca_grupos_vencidos (
    gv_asesor_id       int,
    gv_asesor_name     varchar(64),
    gv_coord_id        int,
    gv_coord_name      varchar(64) ,
    gv_coord_email     varchar(254),
    gv_gerente_id      int         ,
    gv_gerente_name    varchar(64) ,
    gv_gerente_email   varchar(254),
    gv_grupo_id        int not null,
    gv_grupo_name      varchar(64),
    gv_referencia      varchar(20) not null,
    gv_vencido_desde   int,
    gv_vencido_hasta   int,
    gv_cuotas_vencidas int,
    gv_saldo_exigible  money,
    gv_cuota_actual    money
)
go
--INDICES
ALTER TABLE [dbo].[ca_grupos_vencidos] ADD  CONSTRAINT [IX_ca_grupos_vencidos] UNIQUE NONCLUSTERED 
(
	[gv_gerente_id] ASC,
	[gv_coord_id] ASC,
	[gv_asesor_id] ASC,
	[gv_grupo_id] ASC
)
GO
ALTER TABLE dbo.ca_grupos_vencidos ADD CONSTRAINT PK_ca_grupos_vencidos PRIMARY KEY NONCLUSTERED 
(gv_referencia ASC, gv_grupo_id ASC )
GO
CREATE NONCLUSTERED INDEX [ix_gv_asesor_id] ON [dbo].[ca_grupos_vencidos]
([gv_asesor_id] ASC)
GO
CREATE NONCLUSTERED INDEX [ix_gv_coord_id] ON [dbo].[ca_grupos_vencidos]
( [gv_coord_id] ASC )
GO

if exists (select 1 from sysobjects 
    where name = 'gerentesxml' 
    and type = 'U')
drop table gerentesxml
go

CREATE TABLE gerentesxml
(
    gv_gerente_id    INT,
    gv_gerente_name  VARCHAR (64),
    gv_gerente_email VARCHAR (255)
)
go

if exists (select 1 from sysobjects 
    where name = 'coordinadoresxml' 
    and type = 'U')
drop table coordinadoresxml
go

CREATE TABLE coordinadoresxml
(
    gv_coord_id    INT,
    gv_coord_name  VARCHAR (64),
    gv_coord_email VARCHAR (255)
)
go


if exists (select 1 from sysobjects 
    where name = 'asesoresxml' 
    and type = 'U')
drop table asesoresxml
go


CREATE TABLE asesoresxml
(
    gv_asesor_id   INT,
    gv_asesor_name VARCHAR (255)
)
go

--Vencimiento cuotas: ca_vencimiento_cuotas, ca_vencimiento_cuotas_det
IF OBJECT_ID ('dbo.ca_vencimiento_cuotas_det') IS NOT NULL
	DROP TABLE dbo.ca_vencimiento_cuotas_det
GO

IF OBJECT_ID ('dbo.ca_vencimiento_cuotas') IS NOT NULL
	DROP TABLE dbo.ca_vencimiento_cuotas
GO

create table ca_vencimiento_cuotas
    (
    vc_operacion     INT NOT NULL,
	vc_cliente       INT NOT NULL,
	vc_fecha_proceso DATETIME NOT NULL,
	vc_cliente_name  VARCHAR (100) NOT NULL,
	vc_op_fecha_liq  DATETIME NOT NULL,
	vc_op_moneda     TINYINT NOT NULL,
	vc_op_oficina    SMALLINT NOT NULL,
	vc_di_fecha_vig  DATETIME NOT NULL,
	vc_di_dividendo  INT NOT NULL,
	vc_di_monto      MONEY NOT NULL,
	vc_email         VARCHAR (255) NULL,
	CONSTRAINT PK_ca_vencimiento_cuotas PRIMARY KEY(vc_operacion,vc_cliente) 
    )
go

CREATE TABLE dbo.ca_vencimiento_cuotas_det(
   vcd_operacion             int not null,
   vcd_cliente               int not null,
   vcd_corresponsal          varchar(10) not null,
   vcd_institucion           varchar(20) not null,
   vcd_referencia            varchar(40) not null,
   vcd_convenio              varchar(30) null,
   FOREIGN KEY (vcd_operacion, vcd_cliente) REFERENCES ca_vencimiento_cuotas(vc_operacion, vc_cliente),
   CONSTRAINT pk_ca_vencimiento_cuotas_det PRIMARY KEY (vcd_referencia, vcd_corresponsal)
   )
go
--
if exists (select 1 from sysobjects 
    where name = 'ca_incumplimiento_aval' 
    and type = 'U')
drop table ca_incumplimiento_aval
go

create table ca_incumplimiento_aval
(
    ia_fecha_con      datetime,
    ia_tramite        int,
    ia_operacion      int,
    ia_banco          cuenta,
    ia_dividendo      smallint,
    ia_fecha_ven      datetime,
    ia_tdividendo     catalogo,
    ia_oficial        smallint,
    ia_nom_oficial    descripcion,
    ia_car_oficial    descripcion,
    ia_moneda         smallint,
    ia_simbolo        char(10),
    ia_oficina        smallint,
    ia_nom_oficina    varchar(64),
    ia_dir_oficina    varchar(255),
    ia_ciu_oficina    varchar(64),
    ia_estado         tinyint,
    ia_garante        int,
    ia_nom_garante    varchar(254),
    ia_mail_garante   varchar(254),
    ia_monto_deuda    decimal(18,2)
)
go

create clustered index ca_incumplimiento_aval1
    on ca_incumplimiento_aval (ia_fecha_con, ia_tramite)
go


/* Pagos Corrresponsales */
IF OBJECT_ID ('dbo.ca_corresponsal_trn') IS NOT NULL
    DROP TABLE dbo.ca_corresponsal_trn
GO

CREATE TABLE dbo.ca_corresponsal_trn
    (
    co_secuencial                  INT IDENTITY(1,1),      /* Secuencial */
    co_corresponsal                VARCHAR(16),            /* Codigo Corresponsal  OPEN_PAY */
    co_tipo                        CHAR(1),                /* tipo pago  G garantia,   P pago Presatamo grupal,I pago indiv  */
    co_codigo_interno              INT,                    /* Codigo interno  de la operacion grupal o individual , si */
    co_fecha_proceso               DATETIME,               /* Fecha en que llega el pago  por el servicio   */
    co_fecha_valor                 DATETIME,               /* Fecha valor a la que se aplicara el pago      */
    co_referencia                  VARCHAR(64),            /* Codigo Referencia Base 10   0011230012345P1705220098765X   */
    co_moneda                      TINYINT,                /* Cod Moneda */
    co_monto                       MONEY ,                 /* Monto del Pago    */
    co_trn_id_corresp              varchar(25),            /* Referencia Host to Host*/
    co_accion                      char(1),                /* Accion Ingresar(I) o Reversar(R)*/
    co_status_srv                  VARCHAR(64),            /* Stado de ejecucion del servicio   */
    co_estado                      CHAR(1),                /* Estado Procesado P, I ingresado,  E error   */
    co_error_id                    INT,                    /* Codigo del error proceso*/
    co_error_msg                   VARCHAR(254),           /* Mensaje del error  */
    co_archivo_ref                 VARCHAR(64),            /* Codigo Referencia Base 10   0011230012345P1705220098765X   */
    co_archivo_fecha_corte         datetime,               /* Fecha de corte     */
    co_archivo_carga_usuario       varchar(30),            /* Usuario carga el archivo */
    co_concil_est                  CHAR(1),                /* Estado de la Conciliacion */
    co_concil_motivo               CHAR(2),                /* Motivo de la no Concilaiacion   NE no enviado / NR no recibido*/
    co_concil_user                 VARCHAR(64),            /* Usuario que realiza la conciliacion*/
    co_concil_fecha                DATETIME,               /* Fecha de la conciliacion */ 
    co_concil_obs                  VARCHAR(255),           /* Observacion de la conciliacion*/
    co_login                       login,
    co_terminal                    varchar(30),
    co_fecha_real                  datetime,
	co_linea                       int                     /* linea del archivo para pagos masivos*/
    )
GO

CREATE  INDEX ca_corresponsal_trn_1
	ON dbo.ca_corresponsal_trn (co_referencia)
GO

CREATE  INDEX ca_corresponsal_trn_2
	ON dbo.ca_corresponsal_trn (co_trn_id_corresp)
GO

IF OBJECT_ID ('dbo.ca_corresponsal_det') IS NOT NULL
    DROP TABLE dbo.ca_corresponsal_det
GO

CREATE TABLE ca_corresponsal_det(
cd_operacion          int,
cd_banco              cuenta,
cd_sec_ing            int,
cd_referencia         varchar(64),
cd_secuencial         int  
)

GO

CREATE CLUSTERED INDEX ca_corresponsal_det_1
    ON dbo.ca_corresponsal_det (cd_operacion,cd_referencia,cd_banco)
GO

create index ca_corresponsal_det_2 on ca_corresponsal_det (cd_secuencial)
go

--Conciliacion Manual
IF OBJECT_ID ('dbo.ca_archivo_conciliacion_tmp') IS NOT NULL
    DROP TABLE dbo.ca_archivo_conciliacion_tmp
go

CREATE TABLE dbo.ca_archivo_conciliacion_tmp
(
    ac_login                varchar(30)     not null,
    ac_ssn                  int             not null,
    ac_monto                money           not null,
    ac_referencia           varchar(64)     not null unique,
    ac_corresponsal         varchar(255)    null,
    ac_fecha_pago           datetime        null,
    ac_fecha_carga          datetime        not null,
    ac_nombre_archivo       varchar(255)    not null
)
go

--Log de pagos

IF OBJECT_ID ('dbo.ca_santander_log_pagos') IS NOT NULL
    DROP TABLE dbo.ca_santander_log_pagos
GO

CREATE TABLE dbo.ca_santander_log_pagos
	(
	sl_secuencial      INT NOT NULL,
	sl_fecha_gen_orden DATETIME NOT NULL,
	sl_banco           cuenta NULL,
	sl_cuenta          cuenta NULL,
	sl_monto_pag       MONEY NULL,
	sl_referencia      VARCHAR (64) NULL,
	sl_archivo         VARCHAR (255) NULL,
	sl_tipo_error      CHAR (2) NULL,
	sl_estado          catalogo NULL,
	sl_mensaje_err     VARCHAR (255) NULL,
	sl_ente            INT NULL,
	sl_dividendo       INT NULL,
	sl_secpk           INT IDENTITY NOT NULL
	)
GO
CREATE UNIQUE NONCLUSTERED INDEX PK_ca_santander_log_pagos
	ON dbo.ca_santander_log_pagos (sl_secpk,sl_fecha_gen_orden)
GO

IF OBJECT_ID ('ca_pago_solidario_tmp') IS NOT NULL
	drop table ca_pago_solidario_tmp
GO

create table ca_pago_solidario_tmp(
pst_grupo      int,
pst_fecha      datetime,
pst_cliente    int,
pst_monto      money,
pst_cuenta     cuenta,
pst_proporcion float null
)

CREATE UNIQUE INDEX ca_pago_solidario_tmp_1
	ON ca_pago_solidario_tmp (pst_grupo, pst_fecha, pst_cliente)

IF OBJECT_ID ('ca_pago_solidario_det') IS NOT NULL
    drop table ca_pago_solidario_det
GO

create table ca_pago_solidario_det(
psd_grupo     int,
psd_fecha     datetime,
psd_cliente   int,
psd_monto     money,
psd_cuenta    cuenta,
psd_operacion int,
psd_banco     cuenta
)

CREATE UNIQUE INDEX ca_pago_solidario_det_1
	ON ca_pago_solidario_det (psd_grupo, psd_fecha, psd_cliente, psd_operacion)
	
IF OBJECT_ID ('ca_cobranza_det_tmp') IS NOT NULL
	drop table ca_cobranza_det_tmp
GO
	
create table ca_cobranza_det_tmp (
cdt_grupo          int,
cdt_fecha          datetime,
cdt_operacion      int,
cdt_banco          cuenta,
cdt_cliente        int, 
cdt_monto_exigible money)

CREATE UNIQUE INDEX ca_cobranza_det_tmp_1
	ON ca_cobranza_det_tmp (cdt_grupo, cdt_fecha,cdt_operacion)
    
go

use cob_conta_super
go

if exists (select 1 from sysobjects 
		where name = 'sb_reporte_A_0411' 
		and type = 'U')
	drop table sb_reporte_A_0411
go

create table sb_reporte_A_0411
(
	cliente			varchar(25) null,
	banco			cuenta null,
	toperacion		varchar(25) null,
	cuenta1			varchar(25) null,
	cuenta2			varchar(25) null,
	cuenta3			varchar(25) null,
	cuenta4			varchar(25) null,
	cuenta5			varchar(25) null,
	cuenta6			varchar(25) null,
	cuenta7			varchar(25) null,
	cta_provision	cuenta null,
	val_provision	varchar(25) null,
	calificacion	varchar(25) null,
	porc_riesgo		varchar(40) null
)
go

IF OBJECT_ID ('dbo.ca_ns_garantia_liquida') IS NOT NULL
	DROP TABLE dbo.ca_ns_garantia_liquida
go

CREATE TABLE dbo.ca_ns_garantia_liquida
(
	ngl_tramite			int not null,
	ngl_estado			char(1) not null,
	ngl_operacion       varchar(10) not null
)
go


IF OBJECT_ID ('ca_garantia_liquida') IS NOT NULL
	DROP TABLE ca_garantia_liquida
go

create table ca_garantia_liquida 
( 
gl_id                int identity not null,
gl_grupo             int          not null, 
gl_cliente           int          not null, 
gl_tramite           int          not null,
gl_monto_individual  money        not null, 
gl_monto_garantia    money        not null, 
gl_fecha_vencimiento datetime     not null, 
gl_pag_estado        char(2)      not null,
gl_pag_fecha         datetime     null,
gl_pag_valor         money        null,
gl_dev_estado        char(2)      null,
gl_dev_fecha         datetime     null,
gl_dev_valor         money        null,
gl_forma_pago        varchar(16)  null
) 
go

create unique index ca_garantia_liquida_1 on ca_garantia_liquida (gl_grupo, gl_cliente, gl_tramite, gl_fecha_vencimiento)
go

create index ca_garantia_liquida_2 on ca_garantia_liquida (gl_grupo, gl_tramite)
go

create index ca_garantia_liquida_3 on ca_garantia_liquida (gl_dev_estado)
go

create index ca_garantia_liquida_4 on ca_garantia_liquida (gl_pag_estado)
go



IF OBJECT_ID ('ca_santander_resultado_desembolso') IS NOT NULL
	DROP TABLE ca_santander_resultado_desembolso
go

create table ca_santander_resultado_desembolso
( 
	[rd_nombre_archivo] [varchar](40) NOT NULL,
	[rd_secuencial] [varchar](7) NOT NULL,
	[rd_fecha_transferencia] [varchar](8) NOT NULL,
	[rd_monto] [varchar](15) NOT NULL,
	[rd_cuenta_ordenante] [varchar](20) NOT NULL,
	[rd_nombre_ordenante] [varchar](40) NOT NULL,
	[rd_rfc_ordenante] [varchar](18) NOT NULL,
	[rd_cuenta_beneficiario] [varchar](20) NOT NULL,
	[rd_nombre_beneficiario] [varchar](40) NOT NULL,
	[rd_rfc_beneficiario] [varchar](18) NOT NULL,
	[rd_referencia_servicio] [varchar](40) NOT NULL,
	[rd_referencia_ordenante] [varchar](40) NOT NULL,
	[rd_motivo_devolucion] [varchar](2) NOT NULL,
	[rd_descripcion_referencia] [varchar](30) NOT NULL,
	rd_causa_rechazo          VARCHAR (2) NOT NULL,   -- LGU igualo los instaladores
	[rd_banco] [cuenta] NULL,
	rd_estado_mail           varchar(1) null,
	CONSTRAINT [PK_ca_resultado_desembolso] PRIMARY KEY CLUSTERED 
	(
		[rd_nombre_archivo] ASC,
		[rd_secuencial] ASC
	)
) 
go

IF OBJECT_ID ('ca_incremento_cupo') IS NOT NULL
	DROP table ca_incremento_cupo
go

create table ca_incremento_cupo
	(
	ic_operacion          int not null,
	ic_fecha_proceso      datetime not null,
	ic_monto_aprobado_ini money not null,
	ic_incremento         money not null,
	ic_monto_aprobado_fin money not null,
	ic_secuencial         int
	)
go

create index idx1
	on ca_incremento_cupo (ic_operacion)
go


IF OBJECT_ID ('ca_reporte_pago_tmp') IS NOT NULL
	DROP table ca_reporte_pago_tmp
go

create table ca_reporte_pago_tmp
	(
	rp_region             varchar (64),
	rp_oficina            varchar (64),
	rp_oficina_id         varchar (40),
	rp_gerente            varchar (64),
	rp_coordinador        varchar (64),
	rp_asesor             varchar (64),
	rp_contrato           varchar (40),
	rp_grupo_id           varchar (40),
	rp_grupo              varchar (64),
	rp_cliente_id         varchar (40),
	rp_cliente            varchar (64),
	rp_dia_pago           varchar (64),
	rp_valor_cuota        varchar (40),
	rp_cuotas_pendientes  varchar (40),
	rp_cuotas_en_atraso   varchar (40),
	rp_fecha_trn          varchar (40),
	rp_fecha_valor        varchar (40),
	rp_saldo_cap_antes    varchar (40),
	rp_saldo_cap_ex_antes varchar (40),
	rp_fecha_ult_pago     varchar (40),
	rp_nro_cuota_pagada   varchar (40),
	rp_fecha_cuota_pagada varchar (40),
	rp_eventos_pago       varchar (40),
	rp_importe_tot        varchar (40),
	rp_importe_cap        varchar (40),
	rp_importe_int        varchar (40),
	rp_importe_iva_int    varchar (40),
	rp_importe_imo        varchar (40),
	rp_importe_iva_imo    varchar (40),
	rp_importe_com        varchar (40),
	rp_importe_iva_com    varchar (40),
	rp_importe_sob        varchar (40),
	rp_saldo_cap_desp     varchar (40),
	rp_saldo_cap_ex_desp  varchar (40),
	rp_trn_corresp_id     varchar (40),
	rp_tipo_pago          varchar (40),
	rp_reverso            varchar (40),
	rp_origen_pago        varchar (64),
	rp_usuario            varchar (40)
	)
go

/*copia de la tabla ca_reporte_pago_tmp para comparar informacion */
IF OBJECT_ID ('ca_reporte_pago_tmp_tti') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp_tti
GO

CREATE TABLE ca_reporte_pago_tmp_tti
(
	rp_region             varchar (64),
	rp_oficina            varchar (64),
	rp_oficina_id         varchar (40),
	rp_gerente            varchar (64),
	rp_coordinador        varchar (64),
	rp_asesor             varchar (64),
	rp_contrato           varchar (40),
	rp_grupo_id           varchar (40),
	rp_grupo              varchar (64),
	rp_cliente_id         varchar (40),
	rp_cliente            varchar (64),
	rp_dia_pago           varchar (64),
	rp_valor_cuota        varchar (40),
	rp_cuotas_pendientes  varchar (40),
	rp_cuotas_en_atraso   varchar (40),
	rp_fecha_trn          varchar (40),
	rp_fecha_valor        varchar (40),
	rp_saldo_cap_antes    varchar (40),
	rp_saldo_cap_ex_antes varchar (40),
	rp_fecha_ult_pago     varchar (40),
	rp_nro_cuota_pagada   varchar (40),
	rp_fecha_cuota_pagada varchar (40),
	rp_eventos_pago       varchar (40),
	rp_importe_tot        varchar (40),
	rp_importe_cap        varchar (40),
	rp_importe_int        varchar (40),
	rp_importe_iva_int    varchar (40),
	rp_importe_imo        varchar (40),
	rp_importe_iva_imo    varchar (40),
	rp_importe_com        varchar (40),
	rp_importe_iva_com    varchar (40),
	rp_importe_sob        varchar (40),
	rp_saldo_cap_desp     varchar (40),
	rp_saldo_cap_ex_desp  varchar (40),
	rp_trn_corresp_id     varchar (40),
	rp_tipo_pago          varchar (40),
	rp_reverso            varchar (40),
	rp_origen_pago        varchar (64),
	rp_usuario            varchar (40)
	)
go

/* Tabla de reportes temporal */
IF OBJECT_ID ('dbo.ca_reporte_control_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reporte_control_tmp
GO

create table ca_reporte_control_tmp
	(
	rc_pregunta          varchar (60) NULL,
	rc_respuesta         varchar (40) NULL
	)
GO

--Cuotas Vigentes: ca_gen_ref_cuota_vigente, ca_gen_ref_cuota_vigente_det
IF OBJECT_ID ('dbo.ca_gen_ref_cuota_vigente_det') IS NOT NULL
	DROP TABLE dbo.ca_gen_ref_cuota_vigente_det
GO

IF OBJECT_ID ('ca_gen_ref_cuota_vigente') IS NOT NULL
	DROP TABLE ca_gen_ref_cuota_vigente
go

create table ca_gen_ref_cuota_vigente
(
    grv_grupo_id      INT NOT NULL,
	grv_fecha_proceso DATETIME NOT NULL,
	grv_grupo_name    VARCHAR (64) NULL,
	grv_tramite       INT NULL,
	grv_op_fecha_liq  DATETIME NOT NULL,
	grv_op_moneda     TINYINT NOT NULL,
	grv_op_oficina    SMALLINT NOT NULL,
	grv_di_fecha_vig  DATETIME NOT NULL,
	grv_di_dividendo  INT NOT NULL,
	grv_di_monto      MONEY NOT NULL,
	grv_dest_nombre1  VARCHAR (60) NULL,
	grv_dest_cargo1   VARCHAR (100) NULL,
	grv_dest_email1   VARCHAR (255) NULL,
	grv_dest_nombre2  VARCHAR (60) NULL,
	grv_dest_cargo2   VARCHAR (100) NULL,
	grv_dest_email2   VARCHAR (255) NULL,
	grv_dest_nombre3  VARCHAR (60) NULL,
	grv_dest_cargo3   VARCHAR (100) NULL,
	grv_dest_email3   VARCHAR (255) NULL,
	grv_dest_nombre4  VARCHAR (60) NULL,
	grv_dest_cargo4   VARCHAR (100) NULL,
	grv_dest_email4   VARCHAR (255) NULL,
	grv_dest_nombre5  VARCHAR (60) NULL,
	grv_dest_cargo5   VARCHAR (100) NULL,
	grv_dest_email5   VARCHAR (255) NULL,
	CONSTRAINT PK_ca_gen_ref_cuota_vigente PRIMARY KEY(grv_grupo_id, grv_fecha_proceso) 
)
go

CREATE TABLE dbo.ca_gen_ref_cuota_vigente_det(
   grvd_grupo_id              int not null,
   grvd_fecha_proceso         DATETIME NOT NULL,
   grvd_corresponsal          varchar(10) not null,
   grvd_institucion           varchar(20) not null,
   grvd_referencia            varchar(40) not null,
   grvd_convenio              varchar(30) null,
   FOREIGN KEY (grvd_grupo_id, grvd_fecha_proceso) REFERENCES ca_gen_ref_cuota_vigente(grv_grupo_id, grv_fecha_proceso),
   CONSTRAINT pk_ca_gen_ref_cuota_vigente_det PRIMARY KEY (grvd_referencia,grvd_corresponsal)
   )
go

--Cuotas Cancelacion: ca_precancela_refer, ca_precancela_refer_det
IF OBJECT_ID ('dbo.ca_precancela_refer_det') IS NOT NULL
	DROP TABLE dbo.ca_precancela_refer_det
GO

IF OBJECT_ID ('ca_precancela_refer') IS NOT NULL
    DROP TABLE ca_precancela_refer
GO

CREATE TABLE ca_precancela_refer (
    pr_secuencial     int not null,
	pr_operacion      int not null,
	pr_banco          varchar(32) not null,
	pr_cliente        int not null,
	pr_monto_op       money  not null,
	pr_monto_pre      money  not null,
	pr_monto_seg      money  not null,
	pr_grupo          int not null,
	pr_tramite_grupal int not null,
	pr_fecha_pro      datetime not null,
	pr_fecha_ven      datetime     null,
	pr_user           varchar(32) not null,
	pr_term           varchar(32) not null,
	pr_mail           varchar(255) not null,
	pr_fecha_liq      datetime not null,
	pr_nombre_cl      varchar(100) not null,
	pr_num_abono      smallint not null,
	pr_nombre_of      varchar(100) not null,
	pr_estado         varchar(10) not null,
	CONSTRAINT pk_ca_precancela_refer PRIMARY KEY (pr_operacion,pr_secuencial)
)
CREATE INDEX  idx_ca_precancela_refer_cli on ca_precancela_refer (pr_cliente)   
go

CREATE TABLE dbo.ca_precancela_refer_det(
   prd_secuencial            INT NOT NULL,
   prd_operacion             int not null,
   prd_cliente               int not null,
   prd_corresponsal          varchar(10) not null,
   prd_institucion           varchar(20) not null,
   prd_referencia            varchar(40) not null,
   prd_convenio              varchar(30) null,
   FOREIGN KEY (prd_operacion, prd_secuencial) REFERENCES ca_precancela_refer(pr_operacion, pr_secuencial),
   CONSTRAINT pk_ca_precancela_refer_det PRIMARY KEY (prd_secuencial,prd_referencia, prd_corresponsal)
)

CREATE INDEX  idx_ca_precancela_refer_det_cli on ca_precancela_refer_det (prd_cliente)
go

if exists (select 1 from sysobjects where name = 'ca_seguros_nuevos') 
   drop table ca_seguros_nuevos
go

create table  ca_seguros_nuevos(
sn_nro_poliza          varchar (30) null,
sn_anio_poliza         int          null,
sn_producto            varchar (30) null,
sn_buc                 varchar (20) null, 
sn_sucursal            varchar (70) null,
sn_nro_prestamo        varchar (24) null,
sn_nro_certificado     varchar (36) null,
sn_mes_emision         varchar (2)  null,
sn_fecha_endoso        varchar (10) null,
sn_fecha_efectiva      varchar (10) null,
sn_fecha_expiracion    varchar (10) null,
sn_long_cobertura      int          null,
sn_pais                varchar (10) null,
sn_moneda              varchar (10) null,
sn_vendedor            varchar (10) null,
sn_nombre_asegurado    varchar (40) null,
sn_apellido_paterno    varchar (16) null,
sn_apellido_materno    varchar (16) null,
sn_direccion1          varchar (100)null,
sn_direccion2          varchar (50) null,
sn_ciudad              varchar (64) null,
sn_estado              varchar (64) null,
sn_cod_postal          varchar (30) null,
sn_telefono            varchar (16) null,
sn_email               varchar (254)null,
sn_genero              CHAR (1)     null,
sn_rfc                 varchar (30) null,
sn_edad                int          null,
sn_fecha_nac           varchar (10) null,
sn_nombre_1            varchar (64) null,
sn_rfc_1               varchar (30) null,
sn_fecha_nac_1         varchar (10) null,
sn_sexo_1              varchar (1) null,
sn_porcentaje_1        varchar (45) null,
sn_nombre_2            varchar (64) null,
sn_rfc_2               varchar (30) null,
sn_fecha_nac_2         varchar (10) null,
sn_sexo_2              varchar (1) null,
sn_porcentaje_2        varchar (45) null,
sn_nombre_3            varchar (64) null,
sn_rfc_3               varchar (30) null,
sn_fecha_nac_3         varchar (10) null,
sn_sexo_3              varchar (1) null,
sn_porcentaje_3        varchar (45) null,
sn_cta_banco           varchar (45) null,
sn_seguro_vida         numeric(20,2) null,
sn_seguro_infarto_cer  numeric(20,2) null,
sn_seguro_infarto_mioc numeric(20,2) null,
sn_seguro_cancer       numeric(20,2) null,
sn_monto_prima         numeric(20,2) null,
sn_comision            numeric(20,2) null,
sn_tipo_seguro         varchar(16)   null
)
GO

/* NOTIFICACIONES DE PRECAN */
if exists (select 1 from sysobjects where name = 'ca_ns_precancela_refer') 
   drop table ca_ns_precancela_refer
go
CREATE TABLE ca_ns_precancela_refer
	(
	npr_codigo INT NOT NULL,
	npr_operacion INT NOT NULL,
	npr_estado CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_ns_precancela_refer_Key ON ca_ns_precancela_refer (npr_codigo, npr_operacion)
GO

--ca_seguro_externo
if exists (select 1 from sysobjects where name = 'ca_seguro_externo') 
   drop table ca_seguro_externo
go

CREATE TABLE ca_seguro_externo(
se_operacion          int         NULL,
se_banco              varchar(24) NULL,
se_cliente            int         NULL,
se_fecha_ini          datetime    NULL,
se_fecha_ult_intento  datetime    NULL,
se_monto              money       NULL,
se_estado             char(1)     NULL,
se_fecha_reporte      datetime    NULL,
se_tramite            int         NULL,
se_grupo              int         NULL,
se_monto_pagado       money		  NULL,
se_monto_devuelto  	  money		  NULL,
se_forma_pago         varchar(16) null,
se_tipo_seguro        varchar(16) null,
se_monto_basico       money       null,
se_usuario            varchar(14) null,
se_terminal           varchar(64) null,
se_plazo_asis_med     int         null
)
go
if not exists(
      SELECT 1 
      FROM sys.indexes 
      WHERE name = 'idx_ca_seguro_externo' 
      AND object_id = OBJECT_ID('ca_seguro_externo') 
     ) 
begin 
     create nonclustered index idx_ca_seguro_externo on ca_seguro_externo(se_cliente, se_tramite)
end 

if not exists(select 1 from sys.indexes 
              where name = 'idx_tramite' 
              and object_id = OBJECT_ID('ca_seguro_externo'))
begin              
    create nonclustered index idx_tramite ON ca_seguro_externo (se_tramite)
end 


IF OBJECT_ID ('dbo.seguros_funeral_net_altas_tmp') IS NOT NULL
    DROP TABLE dbo.seguros_funeral_net_altas_tmp
GO

CREATE TABLE dbo.seguros_funeral_net_altas_tmp
( 
 ra_identificador  		varchar(100)    null,
 ra_apellido_paterno   	varchar(100)	null,
 ra_apellido_materno   	varchar(100)	null,
 ra_nombre				varchar(100)	null,
 ra_fecha_de_emision	varchar(100)	null,
 ra_edad				varchar(100)  	null,
 ra_rfc                 varchar(30)     null,
 ra_operacion           varchar(10)     null,
 ra_tipo_plan           varchar(10)     null
)

go

IF OBJECT_ID ('dbo.seguros_funeral_net_bajas_tmp') IS NOT NULL
    DROP TABLE dbo.seguros_funeral_net_bajas_tmp
GO

CREATE TABLE dbo.seguros_funeral_net_bajas_tmp
( 
 ra_identificador  		varchar(100)    null,
 ra_fecha_de_baja		varchar(100)    null
)

IF OBJECT_ID ('dbo.ca_corresponsal') IS NOT NULL
    DROP TABLE dbo.ca_corresponsal
GO

create table ca_corresponsal(
   co_id                    varchar(10) not null,
   co_nombre                varchar(30) not null,
   co_descripcion           varchar(30) not null,
   co_token_validacion      varchar(255) null,
   co_sp_generacion_ref     varchar(50) not null,
   co_sp_validacion_ref     varchar(50) not null,
   co_estado                char(1) not null, --(A)ctivo, (I)nactivo
   co_tiempo_aplicacion_pag_rev int          null,
   
   CONSTRAINT pk_corresponsal PRIMARY KEY (co_id)
)

IF OBJECT_ID ('dbo.ca_pie_pagina_corresp') IS NOT NULL
    DROP TABLE dbo.ca_pie_pagina_corresp
GO

create table ca_pie_pagina_corresp(
   cp_id                    varchar(10) not null,
   cp_pie_pagina            varchar(500) not null,
   co_id                    varchar(10) FOREIGN KEY REFERENCES ca_corresponsal(co_id)
   CONSTRAINT pk_ca_pie_pagina_corresp PRIMARY KEY (cp_id)
	)
	
--Referencias Garantias Liquidas: ca_infogaragrupo, ca_infogaragrupo_det
IF OBJECT_ID ('dbo.ca_infogaragrupo_det') IS NOT NULL
    DROP TABLE dbo.ca_infogaragrupo_det
GO

IF OBJECT_ID ('dbo.ca_infogaragrupo') IS NOT NULL
	DROP TABLE dbo.ca_infogaragrupo
GO
CREATE TABLE dbo.ca_infogaragrupo
	(
	in_grupo_id      INT NOT NULL,
	in_nombre_grupo  VARCHAR (64) NULL,
	in_fecha_proceso DATETIME NOT NULL,
	in_fecha_liq     DATETIME NOT NULL,
	in_fecha_venc    DATETIME NOT NULL,
	in_moneda        TINYINT NOT NULL,
	in_oficina_id    SMALLINT NOT NULL,
	in_num_pago      TINYINT NOT NULL,
	in_monto         MONEY NOT NULL,
	in_dest_nombre1  VARCHAR (64) NULL,
	in_dest_cargo1   VARCHAR (100) NULL,
	in_dest_email1   VARCHAR (255) NULL,
	in_dest_nombre2  VARCHAR (64) NULL,
	in_dest_cargo2   VARCHAR (100) NULL,
	in_dest_email2   VARCHAR (255) NULL,
	in_dest_nombre3  VARCHAR (64) NULL,
	in_dest_cargo3   VARCHAR (100) NULL,
	in_dest_email3   VARCHAR (255) NULL,
	in_tramite       INT NULL
	)
GO

if not exists(select 1 from sys.indexes 
              where name = 'idx_tramite' 
              and object_id = OBJECT_ID('ca_infogaragrupo'))
begin              
    create nonclustered index idx_tramite ON ca_infogaragrupo (in_tramite)
end 

if not exists(select 1 from sys.indexes 
              where name = 'idxin_grupo_id' 
              and object_id = OBJECT_ID('ca_infogaragrupo'))
begin              
    create nonclustered index idxin_grupo_id ON ca_infogaragrupo (in_grupo_id)
end 

create table ca_infogaragrupo_det(
   ind_grupo_id              int not null FOREIGN KEY REFERENCES ca_infogaragrupo(in_grupo_id),
   ind_corresponsal          varchar(10) not null,
   ind_institucion           varchar(20) not null,
   ind_referencia            varchar(40) not null,
   ind_convenio              varchar(30) null,
   ind_tramite               int null
)
go



if not exists(select 1 from sys.indexes 
              where name = 'idx_ind_grupo_id' 
              and object_id = OBJECT_ID('ca_infogaragrupo_det'))
begin              
    create nonclustered index idx_ind_grupo_id ON ca_infogaragrupo_det (ind_grupo_id)
end 

IF OBJECT_ID ('dbo.ca_infosegurogrupo_det') IS NOT NULL
	DROP TABLE dbo.ca_infosegurogrupo_det
GO

CREATE TABLE dbo.ca_infosegurogrupo_det
	(
	isd_cliente            INT NULL,
	isd_nombre_cliente     VARCHAR (500) NULL,
	isd_monto_seguro       MONEY NULL,
	isd_monto_asist_medica MONEY NULL,
	isd_monto_garantia     MONEY NULL,
	isd_grupo              INT NULL,
	isd_tramite            INT NULL
	)
GO

CREATE INDEX idx_isd_grupo
	ON dbo.ca_infosegurogrupo_det (isd_grupo)
GO

CREATE INDEX idx_isd_tramite
	ON dbo.ca_infosegurogrupo_det (isd_tramite)
GO


--Referencias Cuotas Emergentes: ca_gen_notif_emergente, ca_gen_notif_emergente_det
IF OBJECT_ID ('dbo.ca_gen_notif_emergente_det') IS NOT NULL
	DROP TABLE dbo.ca_gen_notif_emergente_det
GO

IF OBJECT_ID ('dbo.ca_gen_notif_emergente') IS NOT NULL
	DROP TABLE dbo.ca_gen_notif_emergente
GO

CREATE TABLE dbo.ca_gen_notif_emergente
	(
	gne_grupo_id      INT NOT NULL,
	gne_fecha_proceso DATETIME NOT NULL,
	gne_grupo_name    VARCHAR (30) NULL,
	gne_op_fecha_liq  DATETIME NOT NULL,
	gne_op_moneda     TINYINT NOT NULL,
	gne_op_oficina    SMALLINT NOT NULL,
	gne_di_fecha_vig  DATETIME NOT NULL,
	gne_di_dividendo  INT NOT NULL,
	gne_di_monto      MONEY NOT NULL,
	gne_dest_nombre1  VARCHAR (60) NULL,
	gne_dest_cargo1   VARCHAR (100) NULL,
	gne_dest_email1   VARCHAR (255) NULL,
	gne_dest_nombre2  VARCHAR (60) NULL,
	gne_dest_cargo2   VARCHAR (100) NULL,
	gne_dest_email2   VARCHAR (255) NULL,
	gne_dest_nombre3  VARCHAR (60) NULL,
	gne_dest_cargo3   VARCHAR (100) NULL,
	gne_dest_email3   VARCHAR (255) NULL,
	CONSTRAINT PK_ca_gen_notif_emergente PRIMARY KEY(gne_grupo_id,gne_fecha_proceso) 
	)
GO

--ca_santander_orden_deposito_fallido
if exists (select 1 from sysobjects where name = 'ca_santander_orden_deposito_fallido') 
   drop table ca_santander_orden_deposito_fallido
go

create table ca_santander_orden_deposito_fallido
( 
	odf_fecha				datetime, 		
	odf_consecutivo			int,
	odf_linea			    int,
	odf_cliente   			int,			
	odf_cuenta				cuenta,     	
	odf_banco				cuenta,
	odf_tipo				varchar(10),
    odf_monto				money, 	
	odf_causa_rechazo		varchar(40), 	
	odf_accion				int 			null,
	odf_accion_fecha   		datetime		null,
	odf_accion_user			varchar(24)		null,
	odf_estado 				varchar(1)      null
)
go

CREATE UNIQUE INDEX ca_santander_orden_deposito_fallido_1
ON ca_santander_orden_deposito_fallido (odf_fecha, odf_consecutivo, odf_linea)
go

CREATE INDEX ca_santander_orden_deposito_fallido_2
ON ca_santander_orden_deposito_fallido (odf_cliente)
go

CREATE INDEX ca_santander_orden_deposito_fallido_3
ON ca_santander_orden_deposito_fallido (odf_cuenta)
go

CREATE INDEX ca_santander_orden_deposito_fallido_4
ON ca_santander_orden_deposito_fallido (odf_banco)

go


CREATE TABLE dbo.ca_gen_notif_emergente_det(
   gned_grupo_id              int not null,
   gned_fecha_proceso         DATETIME NOT NULL,
   gned_corresponsal          varchar(10) not null,
   gned_institucion           varchar(20) not null,
   gned_referencia            varchar(40) not null,
   gned_convenio              varchar(30) null,
   FOREIGN KEY (gned_grupo_id, gned_fecha_proceso) REFERENCES ca_gen_notif_emergente(gne_grupo_id, gne_fecha_proceso),
   CONSTRAINT pk_ca_gen_notif_emergente_det PRIMARY KEY (gned_referencia, gned_corresponsal)
   )
go

IF OBJECT_ID ('dbo.ca_corresponsal_tipo_ref') IS NOT NULL
	DROP TABLE dbo.ca_corresponsal_tipo_ref
GO

create table ca_corresponsal_tipo_ref(
   ctr_id                    int not null,
   ctr_tipo                  varchar(4)  not null,
   ctr_tipo_cobis            char(2)     not null,
   ctr_descripcion           varchar(100) not null,
   ctr_co_id                 varchar(10) not null,
   ctr_convenio              varchar(255) null
   CONSTRAINT pk_corresponsal_tipo_ref PRIMARY KEY (ctr_id),
   FOREIGN KEY (ctr_co_id) REFERENCES ca_corresponsal(co_id)
)

go

if object_id ('ca_corresponsal_limites') is not null
	drop table ca_corresponsal_limites
go

create table ca_corresponsal_limites
(
     cl_corresponsal_id  varchar(10) not null,
     cl_limite_min  money       not null,
     cl_limite_max  money       not null,
     cl_tipo_tran   char(2)     not null
)

if object_id ('ca_corresponsal_err') is not null
	drop table ca_corresponsal_err
go
create table ca_corresponsal_err
(
     ce_corresponsal_id          varchar(10) not null,
     ce_error_cobis              int not null, --codigo de error cobis
     ce_error_codigo             varchar(10)   not null, --codigo de error para el corresponsal
     ce_error_descripcion        varchar(100)     not null -- codigo de error cobis
)
go

IF OBJECT_ID ('dbo.ca_corresponsal_oficina') IS NOT NULL
	DROP TABLE dbo.ca_corresponsal_oficina
GO

create table ca_corresponsal_oficina(
   co_id                     int not null,
   co_oficina_id             int not null,
   co_oficina_desc           varchar(255) not null,
   co_co_id                  varchar(10) not null,
   CONSTRAINT pk_corresponsal_oficina PRIMARY KEY (co_id),
   FOREIGN KEY (co_co_id) REFERENCES ca_corresponsal(co_id)
)

go
IF OBJECT_ID ('dbo.lcr_reporte_candidatos') IS NOT NULL
	DROP TABLE dbo.lcr_reporte_candidatos
GO

CREATE TABLE dbo.lcr_reporte_candidatos
	(
	fecha_liq VARCHAR (255) NOT NULL,
	grupo     VARCHAR (255) NOT NULL,
	oficina   VARCHAR (255) NULL,
	cliente   VARCHAR (255) NULL,
	nombre    VARCHAR (255) NULL,
	asesor    VARCHAR (255) NULL,
	gerente   VARCHAR (255) NULL
	)
GO


if object_id ('dbo.ca_lcr_referencia') is not null
	drop table dbo.ca_lcr_referencia
go

create table dbo.ca_lcr_referencia
	(
	lr_secuencial   int     not  null,
	lr_monto_op     money        null,
	lr_cuota_minima money        null,
	lr_pago_total   money        null,
	lr_operacion    int     not  null,
	lr_banco        varchar (32) null,
	lr_cliente      int not null,
	lr_fecha_pro    datetime not null,
	lr_fecha_corte  datetime not null,
	lr_user         varchar (32) null,
	lr_term         varchar (32) null,
	lr_estado       char(1)      null, 
	lr_fecha_liq    datetime not  null,
	lr_nombre_cl    varchar (100) null,
	lr_mail         varchar (64)  null
	)
go

create nonclustered index lcrx1  on dbo.ca_lcr_referencia (lr_secuencial,lr_operacion)
go

if object_id ('dbo.ca_lcr_referencia_det') is not null
	drop table dbo.ca_lcr_referencia_det
go

create table dbo.ca_lcr_referencia_det
	(
	lrd_secuencial   int          null,
	lrd_operacion    int          null,
	lrd_cliente      int          null,
	lrd_corresponsal varchar (10) null,
	lrd_institucion  varchar (20) null,
	lrd_referencia   varchar (40) null,
	lrd_convenio     varchar (30) null,
	)
go

create nonclustered index lcrx2  on dbo.ca_lcr_referencia_det (lrd_secuencial,lrd_operacion)
go


if object_id ('dbo.ca_ns_lcr_referencia') is not null
	drop table dbo.ca_ns_lcr_referencia
go

create table dbo.ca_ns_lcr_referencia
	(
	nlr_codigo    int      null,
	nlr_operacion int      null,
	nlr_estado    char (1) null
	)
go

create nonclustered index lcrx3  on dbo.ca_ns_lcr_referencia (nlr_codigo,nlr_operacion)


IF OBJECT_ID ('dbo.ca_lcr_candidatos') IS NOT NULL
	DROP TABLE dbo.ca_lcr_candidatos
GO

CREATE TABLE dbo.ca_lcr_candidatos
	(
	cc_fecha_ing    DATETIME NOT NULL,
	cc_fecha_liq    DATETIME NOT NULL,
	cc_grupo        INT NOT NULL,
	cc_nom_grupo    VARCHAR (64) NULL,
	cc_oficina      INT NULL,
	cc_cliente      INT NOT NULL,
	cc_nombre       VARCHAR (255) NULL,
	cc_gerente      login NULL,
	cc_asesor       login NULL,
	cc_user         login NULL,
	cc_date         DATETIME NULL,
	cc_respuesta    catalogo NULL,
	cc_periodicidad catalogo NULL,
	cc_asesor_asig  login NULL,
	cc_descripcion  varchar(600) null,
	cc_promocion    CHAR (1) NULL,
	cc_fecha_descrip DATETIME NULL -- caso#161681
	
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.ca_lcr_candidatos (cc_cliente)
GO

CREATE NONCLUSTERED INDEX idx2
	ON dbo.ca_lcr_candidatos (cc_gerente)
GO



if object_id ('dbo.ca_lcr_bloqueo') is not null
	drop table dbo.ca_lcr_bloqueo
go

create table ca_lcr_bloqueo ( 
lb_operacion        int , 
lb_bloqueo           char(1) ,
lb_fecha_ult_mod    datetime null, 
lb_usuario_ult_mod  login 
) 

create unique nonclustered index idx1 on dbo.ca_lcr_bloqueo (lb_operacion,lb_bloqueo)
go


if object_id ('dbo.ca_lcr_bloqueo_ts') is not null
	drop table dbo.ca_lcr_bloqueo_ts
go


create table ca_lcr_bloqueo_ts (
lbs_fecha_proceso_ts    datetime,
lbs_fecha_ts            datetime,
lbs_oficina_ts          int,
lbs_terminal_ts         descripcion,
lbs_usuario_ts          login,  
lbs_operacion            int , 
lb_bloqueo               char(1) ,
lbs_fecha_ult_mod        datetime null, 
lbs_usuario_ult_mod      login 
) 
CREATE UNIQUE NONCLUSTERED INDEX idx1
	ON dbo.ca_lcr_bloqueo_ts (lbs_fecha_ts,lbs_operacion,lbs_usuario_ult_mod,lbs_fecha_ult_mod)
GO

if object_id ('ca_dividendo_concepto_tmp') is not null begin
	drop table ca_dividendo_concepto_tmp
end

create table ca_dividendo_concepto_tmp
(
  dct_dividendo           int,
  dct_fecha_vencimiento   datetime    null,
  dct_concepto            varchar(10),
  dct_cuota               money       null,
  dct_gracia              money       null,
  dct_pagado              money       null,
  dct_operacion           int         not null,
  CONSTRAINT uc_operacion UNIQUE (dct_operacion,dct_dividendo,dct_concepto)
)


CREATE INDEX ca_dividendo_concepto_tmp_ix1
    ON dbo.ca_dividendo_concepto_tmp (dct_operacion, dct_dividendo,dct_concepto)
GO


IF OBJECT_ID ('dbo.ca_referencia_tmp') IS NOT NULL
	DROP TABLE dbo.ca_referencia_tmp
GO

CREATE TABLE ca_referencia_tmp
    ( 
     num_fila           INT, 
     fecha_valor_pago   varchar(10),
     num_referencia     varchar(64),
     monto_pago         varchar(14),
     forma_pago         varchar(64),
     trn_corresponsal   varchar(8),
     nom_archivo_pago   varchar(255),
     observaciones      varchar(800),
     procesado          char(1) 
    )
go
---------------- CREACION DE LA TABLA CORRESPONSAL -----------------
use cob_conta_super
go

drop index sb_conciliacion_corresponsal.idx_1
drop index sb_conciliacion_corresponsal.idx_2
drop index sb_conciliacion_corresponsal.idx_3
drop index sb_conciliacion_corresponsal.idx_4
drop index sb_conciliacion_corresponsal.idx_5
drop index sb_conciliacion_corresponsal.idx_6
drop index sb_conciliacion_corresponsal.idx_7
drop index sb_conciliacion_corresponsal.idx_8


if exists(select 1 from sysobjects
	where name = 'sb_conciliacion_corresponsal')
	drop table sb_conciliacion_corresponsal
go

create table sb_conciliacion_corresponsal
(
   co_id		      int 			  not null identity(1,1),
   co_aplicativo	  int			  not null, -- 5 - Cartera
   co_corresponsal    varchar(25)     not null,
   co_secuencial      int             null,     --co_relacionados
   co_relacionados    int             null,     -- ocupamos este campo para la opcion conciliar sin accion 
   co_id_trn_corresp  int			  not null,
   co_id_cobis_trn    int		      null, 	-- Secuencial de ca_corresponsal_trn
   co_tipo_trn        varchar(10)     not null, -- Esto indica si es pago grupal(pg),pago garant?pg), pi, cg, 
   co_referencia_pago varchar(25)     not null,
   co_fecha_registro  datetime 		  not null,
   co_usuario_trn     varchar(10)     not null,
   co_fecha_valor     datetime        not null,
   co_monto           money		      not null,
   co_reverso         char(1)         not null, -- Si/NO (S/N)
   co_trn_reverso     int             null,
   co_cliente		  int			  null,
   co_grupo			  int             null,
   co_estado_trn      char(2)         null, 	-- (Procesado / Pendiente /Anulado / Reversado / Error 
   co_estado_conci    char(1)         null, 	-- Si/NO (S/N)
   co_usuario_conci   login           null,
   co_razon_no_conci  char(1)		  null, 	-- Huerfano COBIS (C) / Huerfano Archivo (A)
   co_fecha_conci     datetime        null,
   co_accion_conci    char(2)         null, 	-- Aclarado (AC) / Aplicado (AP) / Reversado (RV)
   co_observaciones   varchar(255)    null,
   co_archivo		  varchar(255)	  not null,
   co_linea			  int			  null,
   co_texto_linea	  varchar(500)	  null
)

create index idx_1 on sb_conciliacion_corresponsal(co_corresponsal)
create index idx_2 on sb_conciliacion_corresponsal(co_tipo_trn)
create index idx_3 on sb_conciliacion_corresponsal(co_fecha_valor)
create index idx_4 on sb_conciliacion_corresponsal(co_id_trn_corresp)
create index idx_5 on sb_conciliacion_corresponsal(co_id_cobis_trn)
create index idx_6 on sb_conciliacion_corresponsal(co_cliente)
create index idx_7 on sb_conciliacion_corresponsal(co_grupo)
create index idx_8 on sb_conciliacion_corresponsal(co_estado_conci)


drop index sb_conciliacion_corresponsal_temp.idx_1
drop index sb_conciliacion_corresponsal_temp.idx_2
drop index sb_conciliacion_corresponsal_temp.idx_3
drop index sb_conciliacion_corresponsal_temp.idx_4
drop index sb_conciliacion_corresponsal_temp.idx_5
drop index sb_conciliacion_corresponsal_temp.idx_6
drop index sb_conciliacion_corresponsal_temp.idx_7
drop index sb_conciliacion_corresponsal_temp.idx_8
drop index sb_conciliacion_corresponsal_temp.idx_9


if exists(select 1 from sysobjects
	where name = 'sb_conciliacion_corresponsal_temp')
	drop table sb_conciliacion_corresponsal_temp
go


create table sb_conciliacion_corresponsal_temp
(
   co_id		      int             not null identity(1,1),
   co_corresponsal    varchar(25)     null,
   co_secuencial      int             null, 
   co_relacionados    int             null,
   co_usuario         login           null,
   co_id_trn_corresp  int			  null,
   co_id_cobis_trn    int		      null, -- Secuencial de ca_corresponsal_trn
   co_tipo_trn        varchar(10)     null, -- Esto indica si es pago grupal(pg),pago garant?pg), pi, cg, 
   co_referencia_pago varchar(25)     null,
   co_fecha_registro  datetime        null,
   co_usuario_trn     varchar(10)     null,
   co_fecha_valor     datetime        null,
   co_monto           money		      null,
   co_reverso         char(1)         null, -- Si/NO (S/N)
   co_trn_reverso     int			  null,
   co_cliente         int			  null,
   co_grupo			  int             null,
   co_estado_trn      char(2)		  null, -- Todos / Aplicados / Ingresados / Error
   co_estado_conci    char(1)	      null, -- Si/NO (S/N)
   co_usuario_conci   login           null,
   co_razon_no_conci  char(1)		  null, -- Huerfano COBIS (C) / Huerfano Archivo (A)
   co_fecha_conci     datetime        null,
   co_accion_conci    char(2)         null, -- Aclarado (AC) / Aplicado (AP) / Reversado (RV) 
   co_observaciones   varchar(255)    null
)

create index idx_1 on sb_conciliacion_corresponsal_temp(co_corresponsal)
create index idx_2 on sb_conciliacion_corresponsal_temp(co_tipo_trn)
create index idx_3 on sb_conciliacion_corresponsal_temp(co_fecha_valor)
create index idx_4 on sb_conciliacion_corresponsal_temp(co_id_trn_corresp)
create index idx_5 on sb_conciliacion_corresponsal_temp(co_id_cobis_trn)
create index idx_6 on sb_conciliacion_corresponsal_temp(co_cliente)
create index idx_7 on sb_conciliacion_corresponsal_temp(co_grupo)
create index idx_8 on sb_conciliacion_corresponsal_temp(co_estado_conci)
create index idx_9 on sb_conciliacion_corresponsal_temp(co_usuario)

-- secuencia para ligar consiliaciones entre si 
CREATE SEQUENCE sb_conciliacion_corresponsal_sq
INCREMENT BY 1
START WITH 1;
go

if object_id ('ca_vigencia_funeral_net') is not null begin
	drop table ca_vigencia_funeral_net
end

create table ca_vigencia_funeral_net
(
 vfn_ente            int              ,
 vfn_buc             varchar(64)  null,
 vfn_operacion       int          null,
 vfn_fecha_inicio    datetime     null,
 vfn_fecha_baja      datetime     null,
 vfn_fecha_vigencia  datetime     null,
 vfn_fecha_pro_baja  datetime     null
)


create index ca_vigencia_funeral_net_key on ca_vigencia_funeral_net(vfn_ente)
go

create index ca_vigencia_funeral_net_key2 on ca_vigencia_funeral_net(vfn_fecha_baja) 
go

IF OBJECT_ID ('dbo.ca_qry_transacciones') IS NOT NULL
	DROP TABLE dbo.ca_qry_transacciones
GO

create table ca_qry_transacciones  (
qt_id                    int     identity, 
qt_transaccion           varchar(10) null,
qt_secuencial            int         null, 
qt_fecha_Trn             varchar(20) null,
qt_fecha_Ref             varchar(20) null,  
qt_oficina               int         null,
qt_monto                 money       null,
qt_moneda                int         null,
qt_corresponsal_id       int         null,  
qt_forma_pago            varchar(30) null,
qt_estado                varchar(3)  null,   
qt_usuario_trn           varchar(30) null,
qt_tramite               int         null,
qt_usuario              varchar(30) null,
)


CREATE CLUSTERED INDEX ca_qry_transacciones_1
	ON dbo.ca_qry_transacciones (qt_id, qt_usuario)
GO

IF OBJECT_ID ('dbo.ca_qry_det_trn') IS NOT NULL
	DROP TABLE dbo.ca_qry_det_trn
GO
  
create table ca_qry_det_trn (
qd_id int          identity,
qd_secuencial_trn  int null,
qd_concepto        varchar(10) null,
qd_estado          varchar(11) null 
qd_cuota           int null,
qd_secuencia       int null,
qd_codigo_valor    int null,
qd_monto           money null
qd_usuario         login null 
)
   
CREATE CLUSTERED INDEX ca_qry_det_trn_1
ON dbo.ca_qry_det_trn (qd_id,qd_usuario)
GO


IF OBJECT_ID ('dbo.ca_qry_consulta_abono') IS NOT NULL
	DROP TABLE dbo.ca_qry_consulta_abono
GO
  

create table ca_qry_consulta_abono (
id_abono           int identity      ,
[Operacion]         int             null, 
[Id_Pago]           int             null,
[secuencial_pag]    int             null,
[Forma de Pago]     varchar(20)     null, 
[Fecha de Ingreso]  datetime        null,
[Fecha Valor]       datetime        null,  
[Oficina]           int             null,
[Monto]             money  			null,
[Moneda]            int    			null, 
[Id_Corresponsal]   varchar(25)     null, 
[Estado]            varchar(10) 	null, 
[Usuario]          varchar(15) 		null ,
[Mensaje]          varchar(255)  	null,
s_user              varchar(15)     null    
)

CREATE CLUSTERED INDEX ca_qry_consulta_abono_1
ON dbo.ca_qry_consulta_abono (id_abono,Usuario)
GO

--modificar del dia sp del dia con truncate 
create  index ca_qry_consulta_abono_2 on ca_qry_consulta_abono (s_user)
go



if OBJECT_ID ('ca_ns_corresponsal_pago') is not null
	drop table ca_ns_corresponsal_pago
go

create table ca_ns_corresponsal_pago
	(
	ncp_banco   cuenta,
  	ncp_estado  char(1)
    )

IF OBJECT_ID ('dbo.ca_reporte_pagos_elavon') IS NOT NULL
	DROP table dbo.ca_reporte_pagos_elavon
go

create table dbo.ca_reporte_pagos_elavon
	(
	rp_usuario            varchar (250),
	rp_nombre_usuario     varchar (250),	
	rp_num_dispositivo    varchar (250),
	rp_num_operacion      varchar (250),
	rp_referencia         varchar (250),
	rp_importe            varchar (250),
	rp_fecha              varchar (250),
	rp_num_afiliacion     varchar (250),
	rp_tipo_operacion     varchar (250),
	rp_tipo_pago          varchar (250)
	)
go



if object_id ('rpt_clientes_no_renuevan') is not null
	drop table rpt_clientes_no_renuevan
go

create table rpt_clientes_no_renuevan
	(
	Oficina                                varchar (255),
	Region                                 varchar (255),
	[Nombre del Gerente]                   varchar (255),
	[Nombre del Coordinador]               varchar (255),
	[Nombre del Asesor]                    varchar (255),
	[Id grupo]                             int,
	[Nombre del grupo]                     varchar (255),
	[Nombre del producto]                  varchar (255),
	[Ciclo individual]                     int,
	[Ciclo grupal]                         int,
	[Apellido Paterno]                     varchar (100),
	[Apellido Materno]                     varchar (100),
	Nombre                                 varchar (100),
	[Nombre 2]                             varchar (100),
	[No. de integrantes]                   int,
	RFC                                    varchar (20),
	BUC                                    varchar (20),
	[Cuenta de deposito]                   varchar (100),
	[Tipo de cuenta]                       varchar (20),
	Genero                                 varchar (30),
	Edad                                   int,
	[Estado civil]                         varchar (30),
	Escolaridad                            varchar (255),
	[Numero celular]                       varchar (20),
	[Nombre corto de la actividad economica] varchar (255),
	[Anios de antigüedad del negocio]      varchar (30),
	[Correo electronico]                   varchar (255),
	[Ingreso mensual]                      money,
	[Gastos mensuales]                     money,
	[Otros ingresos]                       money,
	[Capacidad de pago]                    money,
	[Monto del credito]                    money,
	[Fecha de desembolso]                  varchar (255),
	[Fecha de cancelacion]                 varchar (255),
	[Dias de atraso maximo durante el ciclo] int,
	[Dias de No Renovado]                  int
	)
go

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_cat') IS NOT NULL
	DROP table dbo.ca_cat
go

create table dbo.ca_cat
	(
	ct_tipo_tabla      varchar(10),
	ct_tasa_interes    float,
	ct_tasa_comision   float,
	ct_periodicidad    int,
	ct_cat             float
	)
go

if object_id ('dbo.ca_abono_objetado') is not null
	drop table dbo.ca_abono_objetado
go


create table ca_abono_objetado ( 
ao_operacion   int        not null, 
ao_id_pago     int        null,
ao_sec_ing     int        null, 
ao_sec_rpa     int        null, 
ao_toperacion  catalogo   null,
ao_monto_pago  money      null,
ao_fecha_valor datetime   null,
ao_usuario     login      null
) 

CREATE CLUSTERED INDEX ca_abono_objetado_1
	ON dbo.ca_abono_objetado (ao_operacion,ao_usuario)
GO

 
if object_id ('dbo.ca_qry_abono_objetado') is not null
	drop table dbo.ca_qry_abono_objetado
go


create table ca_qry_abono_objetado ( 
ao_id          int identity   not null, 
ao_operacion   int        not null, 
ao_id_pago     int        null,
ao_id_ing      int        null,
ao_toperacion  catalogo   null,
ao_monto_pago  money      null,
ao_fecha_valor datetime   null,
ao_usuario     login      null
) 

CREATE CLUSTERED INDEX ca_qry_abono_objetado_1
	ON dbo.ca_qry_abono_objetado (ao_id ,ao_operacion,ao_usuario)
GO
if object_id ('ca_devolucion_descuento_1') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_1

if object_id ('ca_devolucion_descuento_2') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_2

if object_id ('ca_devolucion_descuento_3') is not null	
	drop index ca_devolucion_descuento.ca_devolucion_descuento_3

if object_id ('ca_devolucion_descuento_4') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_4

if object_id ('ca_devolucion_descuento_5') is not null
	drop index ca_devolucion_descuento.ca_devolucion_descuento_5

if object_id ('ca_devolucion_descuento') is not null
    drop table ca_devolucion_descuento
go

create table ca_devolucion_descuento
(
	dd_id 				int IDENTITY(1, 1),
	dd_operacion		int,
	dd_operacion_padre	int,
	dd_oficina			int,
	dd_tramite			int,
	dd_monto			money,
	dd_monto_int		money,
	dd_monto_iva		money,
	dd_cuenta			varchar(64),
	dd_fecha_registro	datetime,
	dd_estado_pago		char(1),
	dd_ente				int,
	dd_beneficiario		varchar(64),
	dd_grupo			int,
	dd_estado_notifica  char(1),
	dd_tasa_descuento	float,
	dd_fecha_pago		datetime,
	dd_tipo 			char(1),
)
go

CREATE INDEX ca_devolucion_descuento_1   ON dbo.ca_devolucion_descuento (dd_id)

CREATE INDEX ca_devolucion_descuento_2 ON dbo.ca_devolucion_descuento (dd_operacion, dd_estado_pago)

CREATE INDEX ca_devolucion_descuento_3 ON dbo.ca_devolucion_descuento (dd_operacion_padre)

CREATE INDEX ca_devolucion_descuento_4 ON dbo.ca_devolucion_descuento (dd_operacion_padre,dd_estado_pago, dd_estado_notifica)

CREATE INDEX ca_devolucion_descuento_5 ON dbo.ca_devolucion_descuento (dd_operacion_padre,dd_estado_pago, dd_tipo)
GO

--Tabla para la parametrizacion de seguros

IF OBJECT_ID ('dbo.ca_param_seguro_externo') IS NOT NULL
	DROP table dbo.ca_param_seguro_externo
go

create table cob_cartera..ca_param_seguro_externo
	(
	se_id                   int,
	se_paquete              varchar (16),
	se_descripcion          varchar (64),
	se_formato_consen       varchar (24),
	se_valor                money,
	se_edad_max             int,
	se_estado               char (1),
    se_asistencia_funeraria money,
	se_producto             varchar(10),
	se_mes_inicial          int,
	se_mes_final            int
	)
go

delete from ca_param_seguro_externo

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (1, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12, 75, 'V', 0.50, 'GRUPAL')
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (2, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 210, 80, 'V', 0, 'GRUPAL')
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (3, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0, 'GRUPAL')

--Se a?? lo que esta en prod
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (4, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12, 80, 'V', 0.5, 'ONBOARD-S')
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (5, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 180, 80, 'V', 0, 'ONBOARD-S')
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto)
values (6, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0, 'ONBOARD-S')
go

--por caso#185234 Seguros Individual
insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (7, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12.00, 80, 'V', 0, 'INDIVIDUAL', 1, 6)
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (8, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12.00, 80, 'V', 0, 'INDIVIDUAL', 7, 10)
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (9, 'BASICO', 'Seguro de vida', 'Seguro de vida', 12.00, 80, 'V', 0, 'INDIVIDUAL', 11,11)
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (10, 'BASICO', 'Seguro de vida', 'Seguro de vida', 15.00, 80, 'V', 0, 'INDIVIDUAL', 12, 12)
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (11, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 210, 80, 'V', 0, 'INDIVIDUAL', 1, 1)
go

insert into ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria, se_producto, se_mes_inicial, se_mes_final)
values (12, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0, 'INDIVIDUAL', 1, 1)
go

--TABLA DEL REPORTE DE COBRANZAS POR HORA 129681
if object_id ('dbo.ca_reporte_cobranza_tmp') is not null
	drop table dbo.ca_reporte_cobranza_tmp
go

create table ca_reporte_cobranza_tmp(


rc_contrato        varchar(40)          ,rc_cliente_id           varchar(40)               ,rc_grupo_id           varchar(40),
rc_grupo           varchar(64)          ,rc_fecha_trn            varchar(40)               ,rc_canal_id           varchar(40),
rc_fecha_valor     varchar(40)          ,rc_cuota_abonada        varchar(40)               ,rc_fecha_cuota_pagada varchar(40),
rc_importe_tot     varchar(40)          ,rc_eventos_pago         varchar(40)               ,rc_importe_cap        varchar(40),
rc_importe_int     varchar(40)          ,rc_importe_iva_int      varchar(40)               ,rc_importe_imo        varchar(40),
rc_importe_iva_imo varchar(40)          ,rc_importe_com          varchar(40)               ,rc_importe_iva_com    varchar(40),
rc_importe_sob     varchar(40)          ,rc_saldo_cap_desp       varchar(40)               ,rc_saldo_cap_ex_desp  varchar(40),
rc_trn_id          varchar(40)          ,rc_tipo_pago            varchar(40)               ,rc_reverso            varchar(40),
rc_origen_pago     varchar(40)          ,rc_referencia           varchar(40)               ,rc_pag_estado         varchar(40)    )       


go

--------------------------------------------------------
-------------         COLECTIVOS      ------------------ 
--------------------------------------------------------
if object_id ('dbo.ca_qry_asesor_colectivo') is not null
	drop table dbo.ca_qry_asesor_colectivo
go

create table dbo.ca_qry_asesor_colectivo
	(
	co_id        int identity not null,
	co_colectivo varchar (255) null,
	co_nombre    varchar (255) null,
	co_cliente   varchar (255) null,
	co_direccion varchar (255) null,
	co_celular   varchar (255) null,
	co_email     varchar (255) null,
	co_asesor    varchar (255) null,
	co_user      login null
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'ca_qry_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_qry_asesor_colectivo'))
   create clustered index ca_qry_asesor_colectivo_1
   on dbo.ca_qry_asesor_colectivo (co_id,co_user)
go



if object_id ('dbo.ca_asesor_colectivo') is not null
	drop table dbo.ca_asesor_colectivo
go

create table dbo.ca_asesor_colectivo
	(
	co_id        int identity not null,
	co_colectivo varchar (255) null,
	co_nombre    varchar (255) null,
	co_cliente   varchar (255) null,
	co_direccion varchar (255) null,
	co_celular   varchar (255) null,
	co_email     varchar (255) null,
	co_asesor    varchar (255) null,
	co_user      login null
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'ca_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_asesor_colectivo'))
   create clustered index ca_asesor_colectivo_1
   on dbo.ca_asesor_colectivo (co_id,co_user)
go


if object_id ('dbo.ca_colectivo_cargo') is not null
	drop table dbo.ca_colectivo_cargo
go

create table dbo.ca_colectivo_cargo
(
	cc_colectivo varchar (255),
	cc_oficina   int          ,
	cc_rol       varchar (255),
	cc_funcionario   varchar (255)
	
)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_ca_asesor_colectivo_1' AND object_id = OBJECT_ID('ca_colectivo_cargo'))
    create index idx_ca_asesor_colectivo_1
    on dbo.ca_colectivo_cargo (cc_colectivo,cc_cargo)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_ca_asesor_colectivo_2' AND object_id = OBJECT_ID('ca_colectivo_cargo'))
   create index idx_ca_asesor_colectivo_2
   on dbo.ca_colectivo_cargo (cc_funcionario)
go
															   
																												   

go
--Pagos Solidarios
use cob_cartera
go
if object_id ('dbo.ca_pago_sol_grp_tmp') is not null
	drop table dbo.ca_pago_sol_grp_tmp
go
create table dbo.ca_pago_sol_grp_tmp
	(
	id_contrato    varchar(50),
	id_cliente      int,
	pago_cliente   varchar(50),
	monto_total    varchar(50),
	canal_pago     int
	
	)

go

--Cabecera

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pag_grp_sol') IS NOT NULL
	DROP table dbo.ca_pag_grp_sol
go

create table cob_cartera..ca_pag_grp_sol
	(
	pg_id_grp_sol      int identity not null,
	pg_grp_contrato    varchar (24),
	pg_grp_monto_total money,
	pg_grp_id_pg_canal int,
	pg_fecha_proc_pago datetime,
	pg_fecha_real_pago datetime
	)
go
CREATE INDEX IDX_CAB_OP_CANAL
ON cob_cartera..ca_pag_grp_sol (pg_grp_contrato,pg_grp_id_pg_canal)
go

--Tablas para detalle de pagos de seguros solidario

use cob_cartera
go
IF OBJECT_ID ('dbo.ca_pag_grp_sol_det') IS NOT NULL
	DROP table dbo.ca_pag_grp_sol_det
go

create table cob_cartera..ca_pag_grp_sol_det
	(
	pgs_id_grp_sol_det  int identity not null,
	pgs_contrato_det    varchar (24),
	pgs_cliente_det     int,
	pgs_cliente_monto   money,
	pgs_grp_id_pg_canal int
	)
go
CREATE INDEX IDX_CAB_OP_CANAL
ON cob_cartera..ca_pag_grp_sol_det (pgs_contrato_det,pgs_grp_id_pg_canal)
go     																												   

if object_id ('dbo.ca_cobranza_batch') is not null
	drop table dbo.ca_cobranza_batch
go

create table ca_cobranza_batch(
cb_contrato    varchar(40),
cb_grupo_id    varchar(40),
cb_fecha_pago  varchar(40),
cb_hora_pago   varchar(40),
cb_origen_pago varchar(40),
cb_monto       varchar(40)
)
GO	
--DESPLAZAMIENTOS
IF OBJECT_ID ('dbo.ca_desplazamiento_archivo') IS NOT NULL
	DROP table dbo.ca_desplazamiento_archivo
go
create table cob_cartera..ca_desplazamiento_archivo(
da_banco    varchar(24),
da_cliente  int,
da_cuotas   int,
da_mensaje  varchar(255)
)

create  unique index idx1 on ca_desplazamiento (de_operacion,de_secuencial)
go

create  index idx2 on ca_desplazamiento (de_banco,de_estado)

go

IF OBJECT_ID ('dbo.ca_desplazamiento_archivo_tmp') IS NOT NULL
	DROP table dbo.ca_desplazamiento_archivo_tmp
go
create table cob_cartera..ca_desplazamiento_archivo_tmp(
da_banco_tmp    varchar(24),
da_cliente_tmp  varchar(24),
da_cuotas_tmp   varchar(24),
da_mensaje_tmp  varchar(255)
)

create index idx1 on ca_desplazamiento_archivo_tmp(da_banco_tmp) 

go

if object_id ('dbo.ca_desplazamiento') is not null
	drop table dbo.ca_desplazamiento
go


create table ca_desplazamiento ( 

de_operacion	int       not null, 
de_banco	    cuenta    not null, 
de_cuotas	    int       not null,
de_fecha_ini	datetime  not null,
de_fecha_fin	datetime  not null,
de_archivo      varchar(255) not null,
de_int_dsp	    money      null,
de_fecha_real	datetime   not null,
de_estado	    char(1)    not null,
de_secuencial	int        null,
de_dividendo_vig int       null 

)
create  index idx1 on ca_desplazamiento (de_operacion)
go																											   


-- ===============================================================================
-- 138837 - DESPLAZAMIENTO FASE 2
-- ===============================================================================
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reestructuracion_archivo') IS NOT NULL
	DROP table dbo.ca_reestructuracion_archivo
go
create table ca_reestructuracion_archivo(
ra_secuencial int identity(1,1) not null,
ra_banco   varchar(24),
ra_cliente int,
ra_cuotas  int,
ra_seguro  varchar(2),
ra_archivo varchar(255),
ra_fecha   datetime,
ra_estado  char(1),
ra_mensaje varchar(255)
)
create index idx1 on ca_reestructuracion_archivo(ra_banco) 
go
-- =====

IF OBJECT_ID ('dbo.ca_reestructuracion_archivo_tmp') IS NOT NULL
	DROP table dbo.ca_reestructuracion_archivo_tmp
go
create table ca_reestructuracion_archivo_tmp(
ra_banco_tmp    varchar(24),
ra_cliente_tmp  varchar(24),
ra_cuotas_tmp   varchar(24),
ra_seguro_tmp   varchar(20),
ra_mensaje_tmp  varchar(255)
)
create index idx1 on ca_reestructuracion_archivo_tmp(ra_banco_tmp) 
go

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ca_cobro_seg_res_archivo')
	DROP TABLE ca_cobro_seg_res_archivo
GO
CREATE TABLE ca_cobro_seg_res_archivo (
cs_secuencial	int IDENTITY(1,1), 
cs_banco	    cuenta    not null, 
cs_cliente		int		  not null,
cs_cuotas		int		  not null,
cs_fecha		datetime  null,
cs_archivo      varchar(255) null,
cs_seguro		varchar(5)		null,
cs_estado	    char(1)    null ,
cs_mensaje      varchar(255) null,
)
create index idx1 on ca_cobro_seg_res_archivo(cs_banco) 
go

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ca_cobro_seg_res_archivo_tmp')
	DROP TABLE ca_cobro_seg_res_archivo_tmp
GO
CREATE TABLE ca_cobro_seg_res_archivo_tmp (
cs_banco_tmp	    varchar(30)    not null, 
cs_cliente_tmp		varchar(30)		  not null,
cs_estado_tmp	    varchar(30)    null ,
cs_mensaje_tmp      varchar(255) null,
)
create index idx1 on ca_cobro_seg_res_archivo_tmp(cs_banco_tmp) 
go

use cob_cartera
go
if exists (select 1 from sysobjects where name = 'ca_seguros_coka') 
   drop table ca_seguros_coka
go

create table  ca_seguros_coka(
sc_nro_poliza          varchar (30) null,
sc_anio_poliza         int          null,
sc_producto            varchar (30) null,
sc_buc                 varchar (20) null, 
sc_sucursal            varchar (70) null,
sc_nro_prestamo        varchar (24) null,
sc_nro_certificado     varchar (36) null,
sc_mes_emision         varchar (2)  null,
sc_fecha_endoso        varchar (10) null,
sc_fecha_efectiva      varchar (10) null,
sc_fecha_expiracion    varchar (10) null,
sc_long_cobertura      int          null,
sc_pais                varchar (10) null,
sc_moneda              varchar (10) null,
sc_vendedor            varchar (10) null,
sc_nombre_asegurado    varchar (40) null,
sc_apellido_paterno    varchar (16) null,
sc_apellido_materno    varchar (16) null,
sc_direccion1          varchar (100)null,
sc_direccion2          varchar (50) null,
sc_ciudad              varchar (64) null,
sc_estado              varchar (64) null,
sc_cod_postal          varchar (30) null,
sc_telefono            varchar (16) null,
sc_email               varchar (254)null,
sc_genero              CHAR (1)     null,
sc_rfc                 varchar (30) null,
sc_edad                int          null,
sc_fecha_nac           varchar (10) null,
sc_nombre_1            varchar (64) null,
sc_rfc_1               varchar (30) null,
sc_fecha_nac_1         varchar (10) null,
sc_sexo_1              varchar (1) null,
sc_porcentaje_1        varchar (45) null,
sc_nombre_2            varchar (64) null,
sc_rfc_2               varchar (30) null,
sc_fecha_nac_2         varchar (10) null,
sc_sexo_2              varchar (1) null,
sc_porcentaje_2        varchar (45) null,
sc_nombre_3            varchar (64) null,
sc_rfc_3               varchar (30) null,
sc_fecha_nac_3         varchar (10) null,
sc_sexo_3              varchar (1) null,
sc_porcentaje_3        varchar (45) null,
sc_cta_banco           varchar (45) null,
sc_seguro_vida         numeric(20,2) null,
sc_seguro_infarto_cer  numeric(20,2) null,
sc_seguro_infarto_mioc numeric(20,2) null,
sc_seguro_cancer       numeric(20,2) null,
sc_monto_prima         numeric(20,2) null,
sc_comision            numeric(20,2) null,
sc_tipo_seguro         varchar(16)   null
)
GO

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'ca_seguros_zurich') 
begin
   drop table ca_seguros_zurich
end

CREATE TABLE ca_seguros_zurich (
	sz_nro_poliza varchar(18) NULL,
	sz_anio_poliza int NULL,
	sz_producto varchar(20) NULL,
	sz_buc varchar(8) NULL,
	sz_sucursal varchar(5) NULL,
	sz_nro_prestamo varchar(12) NULL,
	sz_nro_certificado varchar(12) NULL,
	sz_mes_emision varchar(2) NULL,
	sz_fecha_endoso varchar(10) NULL,
	sz_fecha_efectiva varchar(10) NULL,
	sz_fecha_expiracion varchar(10) NULL,
	sz_long_cobertura int NULL,
	sz_pais varchar(6) NULL,
	sz_moneda varchar(3) NULL,
	sz_vendedor varchar(20) NULL,
	sz_nombre_asegurado varchar(20) NULL,
	sz_apellido_paterno varchar(20) NULL,
	sz_apellido_materno varchar(20) NULL,
	sz_direccion1 varchar(40) NULL,
	sz_direccion2 varchar(40) NULL,
	sz_ciudad varchar(40) NULL,
	sz_estado varchar(40) NULL,
	sz_cod_postal varchar(5) NULL,
	sz_telefono varchar(10) NULL,
	sz_email varchar(50) NULL,
	sz_genero varchar(2) NULL,
	sz_rfc varchar(13) NULL,
	sz_edad int NULL,
	sz_fecha_nac varchar(10) NULL,
	sz_nombre_1 varchar(30) NULL,
	sz_rfc_1 varchar(13) NULL,
	sz_fecha_nac_1 varchar(10) NULL,
	sz_sexo_1 varchar(2) NULL,
	sz_porcentaje_1 varchar(2) NULL,
	sz_nombre_2 varchar(30) NULL,
	sz_rfc_2 varchar(13) NULL,
	sz_fecha_nac_2 varchar(10) NULL,
	sz_sexo_2 varchar(2) NULL,
	sz_porcentaje_2 varchar(2) NULL,
	sz_nombre_3 varchar(30) NULL,
	sz_rfc_3 varchar(13) NULL,
	sz_fecha_nac_3 varchar(10) NULL,
	sz_sexo_3 varchar(2) NULL,
	sz_porcentaje_3 varchar(2) NULL,
	sz_cta_banco varchar(45) NULL,
	sz_seguro_vida numeric(10,2) NULL,
	sz_seguro_infarto_cer numeric(10,2) NULL,
	sz_seguro_infarto_mioc numeric(10,2) NULL,
	sz_seguro_cancer numeric(10,2) NULL,
	sz_monto_prima numeric(10,2) NULL,
	sz_comision numeric(6,2) NULL,
	sz_monto_credito numeric(10,2) NULL
)
GO


--TABLA NUEVA PARA SEQNOS
IF OBJECT_ID ('ca_sec_no_truncar') IS NOT NULL
	DROP TABLE ca_sec_no_truncar
GO

DECLARE @w_sec INT,
@w_cmd VARCHAR(255)

SELECT @w_sec = se_secuencial
FROM ca_secuenciales WHERE se_operacion = -1

SELECT @w_sec = @w_sec + 1

SELECT @w_cmd = 'CREATE TABLE ca_sec_no_truncar (sec INT IDENTITY (' + convert(VARCHAR, @w_sec) + ',1), randomico INT)'
EXEC (@w_cmd)
GO

CREATE UNIQUE INDEX idx_ca_sec_no_truncar_1 ON ca_sec_no_truncar (randomico)
GO


if object_id ('dbo.ca_reporte_restructura') is not null
   drop table dbo.ca_reporte_restructura
go

create table dbo.ca_reporte_restructura
(  
rr_credito_original      varchar(24),
rr_credito_destino       varchar(24),
rr_buc                   varchar(20),
rr_fecha_alta            varchar(20),
rr_fecha_formalizacion   varchar(20),
rr_situacion_conta       varchar(30),
rr_clasificacion_dest    varchar(30),
rr_dia_mora              varchar(20),
rr_exigible_origen       varchar(30),
rr_exigible_ori_actual   varchar(30),
rr_importe_refinan       varchar(25),
rr_monto_formalizado     varchar(20),
rr_flag_carencia_int     varchar(30),
rr_inicio_carencia_int   varchar(30),
rr_fin_carencia_int      varchar(30),
rr_flag_carencia_cap     varchar(30),
rr_inicio_carencia_cap   varchar(30),
rr_fin_carencia_cap      varchar(30),
rr_quita_cap_destino     varchar(30),
rr_quita_int_destino     varchar(30),
rr_quita_cap_origen      varchar(30),
rr_quita_int_origen      varchar(30),
rr_fecha_fin_contrato    varchar(25),
rr_monto_pago_cliente    varchar(20),
rr_amortiza_cap_ori      varchar(30),
rr_amortiza_int_ori      varchar(30),
rr_amortiza_cap_des      varchar(30),
rr_amortiza_int_des      varchar(30)
)
go


-- Crecion de las tablas de caso 140636

DROP TABLE ca_ns_sms_cobranzas
CREATE TABLE [dbo].[ca_ns_sms_cobranzas]  ( 
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

create index idx1 on ca_ns_sms_cobranzas(nsc_dia,nsc_operacion,nsc_fecha_env)
create index idx2 on ca_ns_sms_cobranzas(nsc_estado)

GO

DROP TABLE ca_ns_sms_recordatorios
CREATE TABLE [dbo].[ca_ns_sms_recordatorios]  ( 
	[nsr_operacion]    	int NULL,
	[nsr_cliente]      	int NULL,
	[nsr_num_telf]     	varchar(12) NULL,
	[nsr_bloque]       	int NULL,
	[nsr_plantilla]    	varchar(25) NULL,
	[nsr_grupo]        	int NULL,
    [nsr_num_dia]     	int NULL,
	[nsr_fecha_ejec]   	date NULL,
    [nsr_nom_dia]       varchar(25),
	[nsc_fecha_ing]     datetime NULL,
	[nsr_fecha_ven_hab]	date NULL,
	[nsr_rol_cliente]  	varchar(10) NULL,
	[nsr_estado]       	char(1) NULL,
	[nsr_fecha_env]    	datetime NULL 
	)

create index idx1 on ca_ns_sms_recordatorios(nsr_estado)
GO

IF OBJECT_ID ('ca_reporte_devol') IS NOT NULL
	DROP table ca_reporte_devol
go

CREATE TABLE cob_cartera..ca_reporte_devol  ( 
	REGION             	varchar(64) NULL,
	OFICINA            	varchar(64) NULL,
	GRUPO              	varchar(64) NULL,
	ID_COBIS           	varchar(64) NULL,
	CONTRATO           	varchar(24) NULL,
	ID_ASESOR          	varchar(64) NULL,
	ID_COORDINADOR     	varchar(64) NULL,
	ID_GERENTE         	varchar(64) NULL,
	FECHA_DESEMBOLSO   	varchar(64) NULL,
	FECHA_CANCELACION  	varchar(64) NULL,
	FECHA_CREACION     	varchar(64) NULL,
	FECHA_REINTEGRO    	varchar(64) NULL,
	PRODUCTO           	varchar(64) NULL,
	SUB_PRODUCTO       	varchar(64) NULL,
	TASA_INTERES       	varchar(64) NULL,
	DIFERENCIA_TASAS   	varchar(64) NULL,
	PROMOCION          	varchar(64) NULL,
	SUB_PROMOCION      	varchar(64) NULL,
	MONTO_TOTAL_CREDITO	varchar(64) NULL,
	MONTO_DEVUELTO     	varchar(64) NULL,
	MOTIVO_DISPERSION  	varchar(64) NULL,
	mca_operacion_padre	varchar(64) NULL,
	)
GO

IF OBJECT_ID ('ca_reporte_devol_ctl') IS NOT NULL
DROP table ca_reporte_devol_ctl
GO

CREATE TABLE cob_cartera..ca_reporte_devol_ctl  ( 
	NOMBRE_REPORTE             	varchar(80) NULL,
	FECHA_GEN            	    varchar(15) NULL
	)
GO

-- Alta Masiva de Prospectos
IF OBJECT_ID ('dbo.ca_alta_masiva_prosp') IS NOT NULL
    DROP TABLE dbo.ca_alta_masiva_prosp
go

CREATE TABLE dbo.ca_alta_masiva_prosp
(
    am_nombre_archivo   varchar(255) not null,
    am_fecha_carga      datetime     null,
    am_login            login        null,
    am_cant_reg_exito   int          null,
    am_total            int          null,
	am_estado           char(1)      not null -- C=Pendiente; P=Procesado
)
go
CREATE INDEX idx_ca_alta_mas_prosp_1 ON ca_alta_masiva_prosp(am_nombre_archivo)
go



---REQ 166501 TRX SOCIO COMERCIAL
IF OBJECT_ID ('dbo.ca_lcr_referencia_sc') IS NOT NULL
	DROP TABLE dbo.ca_lcr_referencia_sc
GO

CREATE TABLE dbo.ca_lcr_referencia_sc
	(
	co_secuencial            INT IDENTITY NOT NULL,
	co_corresponsal          VARCHAR (16) NULL,
	co_tipo                  CHAR (2) NULL,
	co_codigo_interno        INT NULL,
	co_fecha_proceso         DATETIME NULL,
	co_fecha_valor           DATETIME NULL,
	co_referencia            VARCHAR (64) NULL,
	co_moneda                TINYINT NULL,
	co_monto                 MONEY NULL,
	co_status_srv            VARCHAR (64) NULL,
	co_estado                CHAR (1) NULL,
	co_error_id              INT NULL,
	co_error_msg             VARCHAR (254) NULL,
	co_archivo_ref           VARCHAR (64) NULL,
	co_archivo_fecha_corte   DATETIME NULL,
	co_archivo_carga_usuario VARCHAR (30) NULL,
	co_concil_est            CHAR (1) NULL,
	co_concil_motivo         CHAR (2) NULL,
	co_concil_user           VARCHAR (64) NULL,
	co_concil_fecha          DATETIME NULL,
	co_concil_obs            VARCHAR (255) NULL,
	co_trn_id_corresp        VARCHAR (25) NULL,
	co_accion                CHAR (1) NULL,
	co_login                 login NULL,
	co_terminal              VARCHAR (30) NULL,
	co_fecha_real            DATETIME NULL,
	co_linea                 INT NULL
	)
GO

CREATE NONCLUSTERED INDEX ca_corresponsal_trn_1
	ON dbo.ca_lcr_referencia_sc (co_referencia)
GO



CREATE NONCLUSTERED INDEX idx1_ca_corresponsal_trn_co_tipo
	ON dbo.ca_lcr_referencia_sc (co_tipo,co_codigo_interno,co_estado)
GO


---REQ 166501 TRX SOCIO COMERCIAL
IF OBJECT_ID ('dbo.ca_desembolsos_pendientes') IS NOT NULL
	DROP TABLE dbo.ca_desembolsos_pendientes
GO

CREATE TABLE dbo.ca_desembolsos_pendientes (
	dp_secuencial int IDENTITY(1,1) NOT NULL,
	dp_banco cuenta NULL,
	dp_fecha_proceso datetime NULL,
	dp_estado char(1)  NULL,
	dp_login login  NULL,
	dp_monto_aprobado money NULL,
	dp_monto_compra money NULL,
	dp_comision money NULL,
	dp_iva money NULL,
	dp_error int NULL,
	dp_mensaje_error varchar(255) NULL,
	dp_referencia varchar(100) NULL,
	dp_codido_autorizacion varchar(6) NULL
);
 CREATE NONCLUSTERED INDEX idx_ca_desembolsos_pendientes_1 ON dbo.ca_desembolsos_pendientes (  dp_secuencial ASC  )  
	
 CREATE NONCLUSTERED INDEX idx_ca_desembolsos_pendientes_2 ON dbo.ca_desembolsos_pendientes (  dp_banco ASC  , dp_fecha_proceso ASC  ) 


GO


---REQ 166501 TRX SOCIO COMERCIAL - Log de Auditoria
IF OBJECT_ID ('dbo.ca_lcr_log_socio_comercial') IS NOT NULL
	DROP TABLE dbo.ca_lcr_log_socio_comercial
GO

CREATE TABLE dbo.ca_lcr_log_socio_comercial (
	ls_secuencial              int          null,
	ls_codigo_autorizacion     varchar(6)   null,
	ls_tipo_transaccion        char(1)      null,
	ls_fecha_proceso           datetime     null,
	ls_numero_referencia       varchar(22)  null,
	ls_fecha_referencia        datetime     null,
	ls_estado                  char(1)      null,
	ls_login                   login        null,
	ls_monto_aprobado          money        null,
	ls_monto_compra            money        null,
	ls_monto_total_compra      money        null,
	ls_comision                money        null,
	ls_iva                     money        null,
	ls_error                   int          null,
	ls_mensaje_error           varchar(255) null
) 
GO
 
 /*
---REQ 166501 TRX SOCIO COMERCIAL - Log de Auditoria
IF OBJECT_ID ('dbo.ca_lcr_socio_comercial_log') IS NOT NULL
    DROP TABLE dbo.ca_lcr_socio_comercial_log
go

CREATE TABLE dbo.ca_lcr_socio_comercial_log
(
    sc_fecha_real       datetime     null,
    sc_fecha_proceso    datetime     null,
    sc_usuario          login        null,
    sc_rol              smallint     null,
    sc_actividad        varchar(255) null,
	sc_operacion        varchar(64)  null,
	sc_cliente          int          null,
	sc_canal            catalogo     null
)
go

CREATE INDEX idx_ca_lcr_socio_comercial_log_1 
  ON ca_lcr_socio_comercial_log(sc_fecha_proceso, sc_cliente)
go
*/

IF OBJECT_ID ('dbo.ca_desembolsos_pendientes') IS NOT NULL
	DROP table dbo.ca_desembolsos_pendientes
go

create table dbo.ca_desembolsos_pendientes
	(
	dp_secuencial          int identity not null,
	dp_banco               cuenta,
	dp_fecha_proceso       datetime,
	dp_estado              char (1),
	dp_login               login,
	dp_monto_aprobado      money,
	dp_monto_compra        money,
	dp_comision            money,
	dp_iva                 money,
	dp_error               int,
	dp_mensaje_error       varchar (255),
	dp_referencia          varchar (100),
	dp_codido_autorizacion varchar (6)
	)
go

create index idx_ca_desembolsos_pendientes_1
	on dbo.ca_desembolsos_pendientes (dp_secuencial)
go

create index idx_ca_desembolsos_pendientes_2
	on dbo.ca_desembolsos_pendientes (dp_banco, dp_fecha_proceso)
go


/***********************************************************************/
-- CREACION TABLA CONSENTIMIENTO ZURICH - AUTO-ONBOARDING - REQ.168293--
/***********************************************************************/
use cob_cartera
go

if object_id ('dbo.ca_consentimiento_zurich') is not null
	drop table dbo.ca_consentimiento_zurich
go

create table ca_consentimiento_zurich (
	cz_nombre      varchar(200),
	cz_rfc         varchar(25),
	cz_fechanac    date,
	cz_domicilio   varchar(500),
	cz_colonia     varchar(50),
	cz_codigo      varchar(20),
	cz_email       varchar(200),
	cz_certificado varchar(100),
	cz_fechaini    date,
	cz_fechafin    date,
	cz_poliza      varchar(50),
	cz_contratante varchar(100),
	cz_rfccontra   varchar(25),
	cz_cliente     int,
	cz_primaneta   money,
	cz_derechos    money,
	cz_recargo     money,
	cz_primatotal  money,
	cz_razonsocial varchar(500),
	cz_fechaemi    date,
	cz_meses       int,
	cz_tramite     int
)
go

--porCaso185234
----------->>>>>>>>>>>NUEVAS TABLAS PARA REPORTES FICHA DE PAGO PARA INDIVIDUALES
IF OBJECT_ID ('dbo.ca_infogaracliente_det') IS not null
	DROP TABLE dbo.ca_infogaracliente_det
GO

create table dbo.ca_infogaracliente_det
	(
	ind_cliente_id     int not null,
	ind_corresponsal   varchar (10) not null,
	ind_institucion    varchar (20) not null,
	ind_referencia     varchar (40) not null,
	ind_convenio       varchar (30) null,
    ind_tramite        int null
	)
GO

CREATE INDEX idx_ind_cliente_id
	ON dbo.ca_infogaracliente_det (ind_cliente_id)
GO
------->>>>
IF OBJECT_ID ('dbo.ca_infosegurocliente_det') IS not null
	DROP TABLE dbo.ca_infosegurocliente_det
GO

create table dbo.ca_infosegurocliente_det
	(
	isd_cliente            int,
	isd_nombre_cliente     varchar (500),
	isd_monto_seguro       money,
	isd_monto_asist_medica money,
	isd_monto_garantia     money,
	isd_grupo              int,
	isd_tramite            int
	)
GO

CREATE INDEX idx_isd_cliente
	ON dbo.ca_infosegurocliente_det (isd_cliente)
GO

CREATE INDEX idx_isd_tramite
	ON dbo.ca_infosegurocliente_det (isd_tramite)
GO

------>>>
IF OBJECT_ID ('dbo.ca_infogaracliente') IS not null
	DROP TABLE dbo.ca_infogaracliente
GO

create table dbo.ca_infogaracliente
	(
	in_cliente_id      int not null,
	in_nombre_cliente  varchar (64),
	in_fecha_proceso   datetime not null,
	in_fecha_liq       datetime not null,
	in_fecha_venc      datetime not null,
	in_moneda          tinyint not null,
	in_oficina_id      smallint not null,
	in_num_pago        tinyint not null,
	in_monto           money not null,
	in_dest_nombre1    varchar (64),
	in_dest_cargo1     varchar (100),
	in_dest_email1     varchar (255),
	in_dest_nombre2    varchar (64),
	in_dest_cargo2     varchar (100),
	in_dest_email2     varchar (255),
	in_dest_nombre3    varchar (64),
	in_dest_cargo3     varchar (100),
	in_dest_email3     varchar (255),
	in_tramite         int
	)
GO

CREATE INDEX idx_tramite
	ON dbo.ca_infogaracliente (in_tramite)
GO

CREATE INDEX idxin_cliente_id
	ON dbo.ca_infogaracliente (in_cliente_id)
GO

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Caso188497 tablas para proximo vencimiento de coutas
IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas_det') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas_det
GO

IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas
GO

create table ca_prox_vencimiento_cuotas
    (
    vc_operacion     INT NOT NULL,
	vc_cliente       INT NOT NULL,
	vc_fecha_proceso DATETIME NOT NULL,
	vc_cliente_name  VARCHAR (100) NOT NULL,
	vc_op_fecha_liq  DATETIME NOT NULL,
	vc_op_moneda     TINYINT NOT NULL,
	vc_op_oficina    SMALLINT NOT NULL,
	vc_di_fecha_vig  DATETIME NOT NULL,
	vc_di_dividendo  INT NOT NULL,
	vc_di_monto      MONEY NOT NULL,
	vc_email         VARCHAR (255) NULL,
	CONSTRAINT PK_ca_prox_vencimiento_cuotas PRIMARY KEY(vc_operacion,vc_cliente) 
    )
go

CREATE TABLE dbo.ca_prox_vencimiento_cuotas_det(
   vcd_operacion             int not null,
   vcd_cliente               int not null,
   vcd_corresponsal          varchar(10) not null,
   vcd_institucion           varchar(20) not null,
   vcd_referencia            varchar(40) not null,
   vcd_convenio              varchar(30) null,
   FOREIGN KEY (vcd_operacion, vcd_cliente) REFERENCES ca_prox_vencimiento_cuotas(vc_operacion, vc_cliente),
   CONSTRAINT pk_ca_prox_vencimiento_cuotas_det PRIMARY KEY (vcd_referencia, vcd_corresponsal)
   )
GO

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Caso#196073 Envio de documentos digitales

IF OBJECT_ID ('dbo.ca_gen_ficha_pago_det') IS NOT NULL
	DROP TABLE dbo.ca_gen_ficha_pago_det
GO

IF OBJECT_ID ('ca_gen_ficha_pago') IS NOT NULL
	DROP TABLE ca_gen_ficha_pago
go

create table ca_gen_ficha_pago
(
    gfp_cliente_id      INT NOT NULL,
	gfp_fecha_proceso DATETIME NOT NULL,
	gfp_nombre        VARCHAR (64) NULL,
	gfp_tramite       INT NULL,
	gfp_op_fecha_liq  DATETIME NOT NULL,
	gfp_op_moneda     TINYINT NOT NULL,
	gfp_op_oficina    SMALLINT NOT NULL,
	gfp_di_fecha_vig  DATETIME NOT NULL,
	gfp_di_dividendo  INT NOT NULL,
	gfp_di_monto      MONEY NOT NULL,
	gfp_banco         VARCHAR (255) NOT NULL,
	gfp_operacion     int NOT NULL	
	CONSTRAINT PK_ca_gen_ficha_pago PRIMARY KEY(gfp_cliente_id, gfp_banco)
)
go

CREATE TABLE dbo.ca_gen_ficha_pago_det(
   gfpd_cliente_id              int not null,
   gfpd_fecha_proceso         DATETIME NOT NULL,
   gfpd_corresponsal          varchar(10) not null,
   gfpd_institucion           varchar(20) not null,
   gfpd_referencia            varchar(40) not null,
   gfpd_convenio              varchar(30) null,
   gfpd_banco                 VARCHAR (255) NOT NULL,
   gfpd_operacion             int NOT NULL, 
   FOREIGN KEY (gfpd_cliente_id, gfpd_banco) REFERENCES ca_gen_ficha_pago(gfp_cliente_id, gfp_banco),
   CONSTRAINT pk_ca_gen_ficha_pago_det PRIMARY KEY (gfpd_referencia, gfpd_corresponsal)
   )
go

-->>-->>-->>-->>
IF OBJECT_ID ('dbo.ca_notificacion_reporte') IS NOT NULL
	DROP TABLE dbo.ca_notificacion_reporte
GO

CREATE TABLE dbo.ca_notificacion_reporte(
    nr_tproducto        varchar (20) not null,
	nr_job              varchar (20) not null,	
	nr_tproducto_descp  varchar (256) null,
	nr_subjet_doc       varchar (256) null,
	nr_subjet_pass      varchar (256) null,
)

insert into ca_notificacion_reporte values ('GRUPAL', 'GRAOB', 'CRÉDITO GRUPAL', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('INDIVIDUAL', 'GRAOB', 'CRÉDITO INDIVIDUAL', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('REVOLVENTE', 'GRAOB', 'CRÉDITO LCR', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('ONBOARDING', 'GRAOB', '(CRÉDITO INDIVIDUAL EN CUENTA CORRIENTE/ CRÉDITO SIMPLE TU CREDIITO + NEGOCIO)', 'Documentos Onboarding', 'Contraseña de Documentos Onboarding')

go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

--Caso#197007 Flujo B2B Grupal Paperless Fase 1
if object_id ('dbo.ca_rep_info_des') is not null
	drop table dbo.ca_rep_info_des
go

create table dbo.ca_rep_info_des(
    ri_oficina_desemb_id   varchar (1),
	ri_oficina_desemb_desc varchar (1),
	ri_forma_de_desembolso varchar (1),
	ri_referencia          varchar (1),
	ri_moneda              int,
	ri_moneda_desc         varchar (1),
	ri_cotizacion          int,
	ri_monto               money,
	ri_numero_banco        varchar (24),
	ri_nombre_cliente      varchar (129),
	ri_id_cliente          int,
	ri_fecha_proceso       varchar (10),
	ri_direccion           varchar (246),
	ri_fecha_liquid        varchar (10),
	ri_rol                 varchar (10),
	ri_descrip_rol         varchar (64),
	ri_desplazamiento      int,
	ri_monto_adeudo_previo money,
	ri_monto_cap_trabajo   money,
	ri_monto_a_recibir     money
)

go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

if object_id ('ca_dia_pago') is not null
	drop table ca_dia_pago
go

create table ca_dia_pago(
dp_banco                 varchar(15)  not null,
dp_ini_operacion_tmp  datetime not null,
dp_fecha_dispercion      datetime     null,
dp_fecha_dia_pag         datetime     null,
dp_dias_calc_int         int          null,
dp_dias_regla            int          null,
dp_valor_int             money        null
)

create nonclustered index ca_dia_pago_Key
    on ca_dia_pago(dp_banco)

go


--Requerimiento #190362 Impresion de Ficha PI
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_cartera
go

if object_id ('dbo.ca_gen_ficha_pago_ind_det') is not null
	drop table dbo.ca_gen_ficha_pago_ind_det
go

if object_id ('dbo.ca_gen_ficha_pago_ind') is not null
	drop table dbo.ca_gen_ficha_pago_ind
go

create table ca_gen_ficha_pago_ind
    (
    fpi_operacion      int           not null,
	fpi_cliente        int           not null,
	fpi_fecha_proceso  datetime      not null,
	fpi_cliente_name   varchar (100) not null,
	fpi_op_fecha_liq   datetime      not null,
	fpi_op_moneda      tinyint       not null,
	fpi_op_oficina     smallint      not null,
	fpi_di_fecha_vig   datetime      not null,
	fpi_di_dividendo   int           not null,
	fpi_di_monto       money         not null,
	fpi_email          varchar (255) null,
	fpi_banco          cuenta        not null
    )
go

create nonclustered index fpi_cliente_key
    on ca_gen_ficha_pago_ind(fpi_cliente)
go
create nonclustered index fpi_banco_key
    on ca_gen_ficha_pago_ind(fpi_banco)
go

create table dbo.ca_gen_ficha_pago_ind_det(
   fpid_operacion      int           not null,
   fpid_cliente        int           not null,
   fpid_corresponsal   varchar(10)   not null,
   fpid_institucion    varchar(20)   not null,
   fpid_referencia     varchar(40)   not null,
   fpid_convenio       varchar(30)   null,
   fpid_banco          cuenta        not null
   )
go

create nonclustered index fpid_cliente_key
    on ca_gen_ficha_pago_ind_det(fpid_cliente)
go
create nonclustered index fpid_banco_key
    on ca_gen_ficha_pago_ind_det(fpid_banco)
go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>


if OBJECT_ID ('dbo.ca_operacion_proy') IS NOT NULL
	drop table dbo.ca_operacion_proy
go

create table dbo.ca_operacion_proy
	(
	op_operacion_real int    null,
    op_ficticia       int    null
	)
go

create clustered index ca_operacion_proy_Key on dbo.ca_operacion_proy (op_operacion_real, op_ficticia)


--------->>>>>>>>>REQ#203379 - OT plazos crédito individual 2023
use cob_cartera
go

if object_id ('dbo.ca_plazo_asis_med') is not null
    drop table dbo.ca_plazo_asis_med
go

create table dbo.ca_plazo_asis_med
    (
    pm_producto        varchar(10),
    pm_plazo           int,
    pm_frecuencia      varchar(10),
	pm_valor           money,
    pm_seguro          varchar(16),
    pm_cobertura       varchar(5),  -- Req.207662
    pm_serv_medicos    varchar(16), -- Req.207662
    pm_serv_checkup    varchar(16), -- Req.207662
    pm_serv_dental     varchar(16), -- Req.207662
    pm_linea_embarazo  varchar(5),  -- Req.207662
	pm_linea_diabetes  varchar(5),  -- Req.207662
	pm_linea_violencia varchar(5)   -- Req.207662
    )
go

insert into ca_plazo_asis_med values ('INDIVIDUAL', 3,  'M', 52.5, 'EXTENDIDO', '3',  '2 eventos', '1 evento',  '1 evento',  '4E',  '2E', '2E')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 6,  'M', 52.5, 'EXTENDIDO', '6',  '4 eventos', '2 eventos', '2 eventos', '8E',  '4E', '4E')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 9,  'M', 52.5, 'EXTENDIDO', '9',  '6 eventos', '3 eventos', '3 eventos', '12E', '6E', '6E')
insert into ca_plazo_asis_med values ('INDIVIDUAL', 12, 'M', 52.5, 'EXTENDIDO', '12', '8 eventos', '4 eventos', '4 eventos', '16E', '8E', '8E')
insert into ca_plazo_asis_med values ('GRUPAL',     4,  'M', null, 'EXTENDIDO', '4',  '2 eventos', '1 evento',  '1 evento',  '4E',  '2E', '2E') -- Req.207662
insert into ca_plazo_asis_med values ('GRUPAL',     6,  'M', null, 'EXTENDIDO', '6',  '4 eventos', '2 eventos', '2 eventos', '8E',  '4E', '4E') -- Req.207662
insert into ca_plazo_asis_med values ('RENOVACION', 4,  'M', null, 'EXTENDIDO', '4',  '2 eventos', '1 evento',  '1 evento',  '4E',  '2E', '2E') -- Req.207662
insert into ca_plazo_asis_med values ('RENOVACION', 6,  'M', null, 'EXTENDIDO', '6',  '4 eventos', '2 eventos', '2 eventos', '8E',  '4E', '4E') -- Req.207662
--------->>>>>>>>>Fin REQ#203379 - OT plazos crédito individual 2023


--------->>>>>>>>>REQ#193431 Reporte Cobranza linea
use cob_cartera
go

if OBJECT_ID ('dbo.ca_reporte_cobranza_linea') IS NOT NULL
    drop table dbo.ca_reporte_cobranza_linea
go

create table ca_reporte_cobranza_linea
(
    rc_oficina        varchar(256),
    rc_oficina_id     varchar(256),
    rc_region         varchar(256),
    rc_contrado_grupo varchar(20),
    rc_nombre_grupo_cliente varchar (256), 
    rc_secuencial    varchar(256),
    rc_corresponsal  varchar(16),
    rc_tipo          varchar(256),
    rc_fecha_proceso varchar(256),
    rc_fecha_valor   varchar(256),
    rc_referencia    varchar(256),
    rc_monto         varchar(256),
    rc_estado        varchar(256),
    rc_archivo_ref   varchar(256),
    rc_login         varchar(256),
    rc_fecha_real    varchar(256)
)
--------->>>>>>>>>Fin REQ#193431 Reporte Cobranza linea
go



-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>PorCaso#19322
IF OBJECT_ID ('dbo.ca_datos_simulacion') is not null
	drop table dbo.ca_datos_simulacion
go

create table ca_datos_simulacion(
    ds_ente          int,
    ds_fecha         datetime,
    ds_canal         int,
	ds_monto_sol     money,
	ds_tplazo        catalogo, --frecuencia
	ds_plazo         smallint, --plazo
	ds_valor_cuota   money,
	ds_moneda        int,
    ds_tasa          float,--84
    ds_toperacion    catalogo	
)
go

create index idx_1 on ca_datos_simulacion(ds_ente)
go
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

