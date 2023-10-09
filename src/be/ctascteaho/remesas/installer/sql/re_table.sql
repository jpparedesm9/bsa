
/* SQL Environment is SQLSERVER      */
/* Environment - Retain case         */
/* Environment - Do not prefix names */
/* Environment - LoadUserDefs        */

use cob_remesas
go

/* CONTROL_BATCH */
print 'TABLA ====> CONTROL_BATCH'
go
CREATE TABLE CONTROL_BATCH (
    CONTROL char(5) not null
)
go

/* ah_tranxofi_tmp */
print 'TABLA ====> ah_tranxofi_tmp'
go
CREATE TABLE ah_tranxofi_tmp (
    Oficina     smallint    null,
    DesOfi      varchar(64) null,
    Cantidad    int         null,
    Efectivo    money       null,
    Cheque      money       null
)
go

/* archivo_salida */
print 'TABLA ====> archivo_salida'
go
CREATE TABLE archivo_salida (
    registro    varchar(5000)   null
)
go

/* area_tcta */
print 'TABLA ====> area_tcta'
go
CREATE TABLE area_tcta (
    ja_area     smallint    null,
    sesion_ar   int         not null
)
go

/* cabecera */
print 'TABLA ====> cabecera'
go
CREATE TABLE cabecera (
    secuencial      int     not null,
    banco_ced       int     not null,
    total_cheques   int     not null,
    valor_total     money   not null,
    tipo            char(1) not null,
    ok              char(1) null
)
go

/* cb_balof_tmp */
print 'TABLA ====> cb_balof_tmp'
go
CREATE TABLE cb_balof_tmp (
    bp_oficina          smallint    null,
    bp_area             smallint    null,
    bp_cuenta           char(14)    null,
    bp_nombre           char(80)    null,
    bp_moneda           tinyint     null,
    bp_movimiento       char(1)     null,
    bp_saldo            money       null,
    bp_debito           money       null,
    bp_credito          money       null,
    bp_saldo_me         money       null,
    bp_debito_me        money       null,
    bp_credito_me       money       null,
    bp_saldo_ant        money       null,
    bp_debito_ant       money       null,
    bp_credito_ant      money       null,
    bp_saldo_me_ant     money       null,
    bp_debito_me_ant    money       null,
    bp_credito_me_ant   money       null
)
go

/* cb_cuenta_mig */
print 'TABLA ====> cb_cuenta_mig'
go
CREATE TABLE cb_cuenta_mig (
    cu_empresa      tinyint         null,
    cu_cuenta       varchar(20)     null,
    cu_cuenta_padre varchar(20)     null,
    cu_nombre       varchar(80)     null,
    cu_descripcion  varchar(255)    null,
    cu_estado       char(1)         null,
    cu_movimiento   char(1)         null,
    cu_nivel_cuenta tinyint         null,
    cu_categoria    char(1)         null,
    cu_fecha_estado datetime        null,
    cu_moneda       tinyint         null,
    cu_sinonimo     varchar(20)     null,
    cu_acceso       char(1)         null
)
go

/* cb_mov_ant */
print 'TABLA ====> cb_mov_ant'
go
CREATE TABLE cb_mov_ant (
    mv_debito   money       null,
    mv_credito  money       null,
    mv_cuenta   varchar(25) null,
    mv_oficina  smallint    null
)
go

/* cb_oficina_tmp */
print 'TABLA ====> cb_oficina_tmp'
go
CREATE TABLE cb_oficina_tmp (
    of_oficina  smallint    null
)
go

/* cc_archivo_cenit */
print 'TABLA ====> cc_archivo_cenit'
go
CREATE TABLE cc_archivo_cenit (
    ac_consecutivo  int         not null,
    ac_fecha_gen    datetime    not null,
    ac_fecha_pro    datetime    not null,
    ac_nom_archivo  varchar(20) not null
)
go

/* cc_chqra_inicial */
print 'TABLA ====> cc_chqra_inicial'
go
CREATE TABLE cc_chqra_inicial (
    ci_cta_banco    varchar(24) not null,
    ci_secuencial   varchar(2)  not null,
    ci_nombre       char(75)    not null,
    ci_codigo       varchar(8)  not null,
    ci_oficina      char(24)    not null,
    ci_inicial      varchar(8)  not null,
    ci_num_chqs     varchar(6)  not null,
    ci_chq_fin      varchar(8)  not null,
    ci_moneda       varchar(2)  not null,
    ci_cod_oficina  char(4)     null
)
go

/* cc_control_archivos */
print 'TABLA ====> cc_control_archivos'
go
CREATE TABLE cc_control_archivos (
    ca_fecha_ejec   datetime    not null,
    ca_nombre_file  varchar(30) not null,
    ca_fec_nombre   int         not null,
    ca_nombre       varchar(20) not null,
    ca_sec          tinyint     not null
)
go

/* cc_exenta_imp */
print 'TABLA ====> cc_exenta_imp'
go
CREATE TABLE cc_exenta_imp (
    ex_producto     tinyint     not null,
    ex_oficina      smallint    not null,
    ex_base         money       not null,
    ex_impuesto     money       not null,
    ex_exenta       money       not null,
    ex_devolucion   money       null
)
go

/* cc_mensaje_estcta */
print 'TABLA ====> cc_mensaje_estcta'
go
CREATE TABLE cc_mensaje_estcta (
    me_fecha        smalldatetime   not null,
    me_prodban      smallint        not null,
    me_oficina      smallint        not null,
    me_linea1       varchar(80)     null,
    me_linea2       varchar(80)     null,
    me_linea3       varchar(80)     null,
    me_linea4       varchar(80)     null,
    me_linea5       varchar(80)     null,
    me_linea6       varchar(80)     null,
    me_fecha_fin    smalldatetime   not null
)
go

/* cc_total_tranmonet */
print 'TABLA ====> cc_total_tranmonet'
go
CREATE TABLE cc_total_tranmonet (
    tm_fecha            datetime    not null,
    tm_oficina          smallint    not null,
    tm_oficina_cta      smallint    null,
    tm_moneda           smallint    not null,
    tm_tipo_tran        smallint    not null,
    tm_causa            varchar(4)  null,
    tm_prod_banc        smallint    null,
    tm_clase_clte       varchar(2)  null,
    tm_indicador        tinyint     null,
    tm_cliente          int         null,
    tm_contador         int         null,
    tm_valor            money       null,
    tm_chq_propios      money       null,
    tm_chq_locales      money       null,
    tm_chq_ot_plazas    money       null,
    tm_efectivo         money       null,
    tm_valor_interes    money       null,
    tm_valor_comision   money       null,
    tm_valor_impuesto   money       null,
    tm_valor_mora       money       null,
    tm_valor_solca      money       null
)
go

/* cl_error */
print 'TABLA ====> cl_error'
go
CREATE TABLE cl_error (
    er_num_error    int             null,
    er_descripcion  varchar(255)    null,
    er_fecha        datetime        null
)
go

/* cl_prueba */
print 'TABLA ====> cl_prueba'
go
CREATE TABLE cl_prueba (
    fecha   datetime    null
)
go

/* cm_cheques */
print 'TABLA ====> cm_cheques'
go
CREATE TABLE cm_cheques (
    cq_banco            smallint    not null,
    cq_fecha            datetime    not null,
    cq_contador         int         not null,
    cq_cuenta           varchar(24) not null,
    cq_cheque           int         not null,
    cq_valor            money       not null,
    cq_clase            char(1)     not null,
    cq_estado           char(1)     not null,
    cq_moneda           tinyint     not null,
    cq_usuario          varchar(14) not null,
    cq_causa            varchar(64) not null,
    cq_oficina          smallint    null,
    cq_tipo_equip       char(1)     null,
    cq_titulo           char(1)     not null,
    cq_fecha_dev        datetime    null,
    cq_num_titulo       varchar(10) null,
    cq_oficina_dest     smallint    null,
    cq_digito46         tinyint     null,
    cq_tipo_compensa    char(1)     null
)
go

/* cm_consolidadora */
print 'TABLA ====> cm_consolidadora'
go
CREATE TABLE cm_consolidadora (
    co_banco        smallint    not null,
    co_num_juzgado  varchar(24) not null,
    co_num_titulo   int         not null,
    co_valor        money       not null,
    co_fecha        datetime    not null,
    co_causal       char(64)    not null,
    co_estad_exist  char(1)     null
)
go

/* cm_errores_camara */
print 'TABLA ====> cm_errores_camara'
go
CREATE TABLE cm_errores_camara (
    em_banco    smallint    null,
    em_fecha    datetime    null,
    em_moneda   tinyint     null,
    em_usuario  varchar(20) null,
    em_cuenta   varchar(24) null,
    em_cheque   int         null,
    em_contador int         null,
    em_mensaje  varchar(60) null
)
go

/* cm_ingreso */
print 'TABLA ====> cm_ingreso'
go
CREATE TABLE cm_ingreso (
    in_banco            smallint    not null,
    in_monto            money       not null,
    in_total_ingresado  money       not null,
    in_diferencia       money       not null,
    in_fecha            datetime    not null,
    in_estado           char(1)     not null,
    in_cheques          int         not null,
    in_moneda           tinyint     not null,
    in_usuario          varchar(14) not null,
    in_tipo_compensa    char(1)     null
)
go

/* comp_temp */
print 'TABLA ====> comp_temp'
go
CREATE TABLE comp_temp (
    comprobante int         not null,
    fecha       datetime    not null,
    oficina     smallint    not null
)
go

/* conceptos */
print 'TABLA ====> conceptos'
go
CREATE TABLE conceptos (
    empresa     tinyint     not null,
    codigo      char(4)     not null,
    tipo        varchar(1)  not null,
    afectacion  char(1)     not null
)
go

/* corte_act */
print 'TABLA ====> corte_act'
go
CREATE TABLE corte_act (
    corte_act   smallint    not null,
    periodo_act smallint    not null
)
go

/* corte_ant */
print 'TABLA ====> corte_ant'
go
CREATE TABLE corte_ant (
    corte_ant1  smallint    not null,
    corte_ant2  smallint    not null,
    periodo_ant smallint    not null
)
go

/* corte_aux */
print 'TABLA ====> corte_aux'
go
CREATE TABLE corte_aux (
    corte       smallint    not null,
    periodo     smallint    not null,
    oficina     smallint    not null,
    cuenta_ini  varchar(25) not null,
    cuenta_fin  varchar(25) not null
)
go

/* corte_def */
print 'TABLA ====> corte_def'
go
CREATE TABLE corte_def (
    corte   smallint    not null,
    periodo smallint    not null,
    fecha   datetime    not null,
    ultimo  char(1)     not null
)
go

/* corte_tmp */
print 'TABLA ====> corte_tmp'
go
CREATE TABLE corte_tmp (
    tmp_corte       int not null,
    tmp_periodo     int not null,
    tmp_empresa     tinyint not null,
    tmp_fecha_ini   datetime    not null,
    tmp_fecha_fin   datetime    not null,
    tmp_estado      char(1) not null,
    tmp_tipo_corte  char(1) not null
)
go

/* cp_tmp_ofi_sobregiros */
print 'TABLA ====> cp_tmp_ofi_sobregiros'
go
CREATE TABLE cp_tmp_ofi_sobregiros (
    os_oficina          smallint    not null,
    os_oficina_padre    smallint    not null,
    os_descripcion      varchar(80) not null
)
go

/* cp_tmp_saldos_sobregiros */
print 'TABLA ====> cp_tmp_saldos_sobregiros'
go
CREATE TABLE cp_tmp_saldos_sobregiros (
    ss_oficina      smallint    not null,
    ss_cuenta       char(14)    null,
    ss_nombre       varchar(80) not null,
    ss_saldo        money   not null,
    ss_saldo_me     money   not null
)
go

/* ct_saldo_tercero_tmp_con */
print 'TABLA ====> ct_saldo_tercero_tmp_con'
go
CREATE TABLE ct_saldo_tercero_tmp_con (
    st_ofi_conex    smallint    not null,
    st_term_conex   char(20)    not null,
    st_ente         int null,
    st_oficina      smallint    null,
    st_area         smallint    null,
    st_cuenta       char(14)    null,
    st_saldo        money   null,
    st_saldo_me     money   null
)
go

/* cuenta_producto */
print 'TABLA ====> cuenta_producto'
go
CREATE TABLE cuenta_producto (
    cp_cuenta           varchar(24) null,
    cp_nombre_cuenta    varchar(40) null,
    cp_producto         int null
)
go

/* det_cheques */
print 'TABLA ====> det_cheques'
go
CREATE TABLE det_cheques (
    sec_cab     int not null,
    sec_chq     int not null,
    banco_ced   int not null,
    banco_duen  int not null,
    ruta        int not null,
    cuenta      varchar(24) not null,
    monto       money   not null,
    num_cheqhe  int not null
)
go

/* devueltos_ctacausa */
print 'TABLA ====> devueltos_ctacausa'
go
CREATE TABLE devueltos_ctacausa (
    dc_cuenta   varchar(24) not null,
    dc_causa    int null,
    dc_contador int null,
    dc_tipo     char(1) null,
    dc_oficina  smallint    null,
    dc_nombre   varchar(64) null
)
go

/* fecha_salter */
print 'TABLA ====> fecha_salter'
go
CREATE TABLE fecha_salter (
    periodo     int not null,
    corte       int not null,
    oficina_i   smallint    not null,
    oficina_f   smallint    not null
)
go

/* fechas */
print 'TABLA ====> fechas'
go
CREATE TABLE fechas (
    fecha_ini   datetime    not null,
    fecha_fin   datetime    not null
)
go

/* mov_aux */
print 'TABLA ====> mov_aux'
go
CREATE TABLE mov_aux (
    fecha_ini   datetime    not null,
    fecha_fin   datetime    not null,
    oficina     smallint    not null,
    cuenta_ini  varchar(25) not null,
    cuenta_fin  varchar(25) not null,
    ente        int null
)
go

/* ofic_tcta */
print 'TABLA ====> ofic_tcta'
go
CREATE TABLE ofic_tcta (
    je_oficina  smallint    null,
    sesion_of   int not null
)
go

/* oficina */
print 'TABLA ====> oficina'
go
CREATE TABLE oficina (
    empresa         tinyint null,
    oficina         smallint    null,
    descripcion     varchar(64) null,
    oficina_padre   smallint    null,
    estado          char(1) null,
    fecha_estado    datetime    null,
    organizacion    tinyint null,
    consolida       char(1) null,
    movimiento      char(1) null,
    codigo          varchar(64) null
)
go

/* oficina_cta */
print 'TABLA ====> oficina_cta'
go
CREATE TABLE oficina_cta (
    oficina     int not null,
    producto    int not null,
    valor       int not null,
    hilo        int not null,
    procesado   char(1) not null
)
go

/* pa_bonificacion_cargos */
print 'TABLA ====> pa_bonificacion_cargos'
go
CREATE TABLE pa_bonificacion_cargos (
    bc_numpq                int not null,
    bc_prod_cobis           tinyint not null,
    bc_prod_bancario        smallint    not null,
    bc_servicio             int not null,
    bc_rubro                varchar(10) not null,
    bc_porc_bonificacion    real    not null,
    bc_fec_alta             datetime    not null,
    bc_fec_ini              datetime    not null,
    bc_fec_vto              datetime    null,
    bc_estado               char(1) not null
)
go

/* pa_gestion_paquete */
print 'TABLA ====> pa_gestion_paquete'
go
CREATE TABLE pa_gestion_paquete (
    gp_numpq            int not null,
    gp_prod_cobis_pq    tinyint not null,
    gp_prod_banc_pq     smallint    not null,
    gp_estado_pq        char(2) not null,
    gp_categoria_pq     varchar(10) not null,
    gp_fecha_alta       datetime    not null,
    gp_oficial          smallint    not null,
    gp_oficina_pq       smallint    not null,
    gp_fecha_canc       datetime    null,
    gp_origen           varchar(3)  null,
    gp_cod_canc         varchar(3)  null,
    gp_ciclo            char(3) not null,
    gp_tipo_dir         char(1) not null,
    gp_direccion_ec     smallint    not null,
    gp_resumen_mag      char(1) not null,
    gp_giro             char(1) not null,
    gp_gerencia         char(1) not null,
    gp_ctahabiente      varchar(2)  not null,
    gp_fecha_proc       datetime    null
)
go

/* pa_integrantes_paquete */
print 'TABLA ====> pa_integrantes_paquete'
go
CREATE TABLE pa_integrantes_paquete (
    ip_numsol   int not null,
    ip_cliente  int not null,
    ip_rol_ent  char(1) not null
)
go

/* pa_negocio_paquete */
print 'TABLA ====> pa_negocio_paquete'
go
CREATE TABLE pa_negocio_paquete (
    np_numpq            int not null,
    np_prod_cobis_pr    tinyint not null,
    np_prod_banc_pr     smallint    not null,
    np_oficina_negocio  smallint    not null,
    np_moneda_negocio   tinyint not null,
    np_negocio          char(20)    not null,
    np_categoria        varchar(3)  null,
    np_cta_cobro        char(1) null,
    np_solidaria        tinyint null,
    np_cuenta           int null,
    np_categoria_ant    char(3) null,
    np_ingresado        char(1) null,
    np_valor_cupo       money   null
)
go

/* pa_param_paquete */
print 'TABLA ====> pa_param_paquete'
go
CREATE TABLE pa_param_paquete (
    pa_prod_cobis       tinyint not null,
    pa_prod_banc        smallint    not null,
    pa_estado           char(1) not null,
    pa_lugar_uso        char(1) null,
    pa_ciclo            char(1) null,
    pa_ciclo_tipo       char(1) null,
    pa_resumen          char(1) null,
    pa_resumen_tipo     char(1) null,
    pa_resumen_mag      char(1) null,
    pa_resumen_mag_tipo char(1) null,
    pa_tipo_cliente     varchar(10) null,
    pa_origen           varchar(10) null,
    pa_origen_tipo      char(1) null,
    pa_delivery         varchar(10) null,
    pa_beneficio        varchar(10) null,
    pa_agrupacion       varchar(10) null,
    pa_seg_legajo       varchar(10) null,
    pa_modo_gen         char(1) null,
    pa_asig_ctas        char(1) null,
    pa_dep_ini          money   null
)
go

/* pa_param_pasivas */
print 'TABLA ====> pa_param_pasivas'
go
CREATE TABLE pa_param_pasivas (
    pp_prod_cobis               tinyint not null,
    pp_prod_banc                smallint    not null,
    pp_prod_cobis_pasiv         tinyint not null,
    pp_prod_banc_pasiv          smallint    not null,
    pp_moneda_prod              tinyint not null,
    pp_categoria                varchar(10) null,
    pp_tctahabiente             varchar(10) null,
    pp_marca_cobro              char(1) null,
    pp_marca_tarjdeb            char(1) null,
    pp_agrupamiento             smallint    null,
    pp_dep_inicial              char(1) null,
    pp_monto_dep_inicial        money   null,
    pp_resumen_mag              char(1) null,
    pp_cobro_primer_manten      char(1) null,
    pp_tipo_chequera_inic       varchar(10) null,
    pp_nro_chq_chequera_inic    smallint    null,
    pp_cant_chequeras           smallint    null,
    pp_def_linea_cr             varchar(10) null,
    pp_dep_chq_ca               char(1) null,
    pp_dep_chq_ca_tipo          char(1) null,
    pp_baja_prod_exis           char(1) null
)
go

/* pa_param_productos */
print 'TABLA ====> pa_param_productos'
go
CREATE TABLE pa_param_productos (
    pr_prod_cobis       tinyint not null,
    pr_prod_banc        smallint    not null,
    pr_prod_cobis_prod  tinyint not null,
    pr_prod_banc_prod   smallint    not null,
    pr_moneda_prod      tinyint not null,
    pr_tabla            varchar(32) null
)
go

/* pa_param_tarjdeb */
print 'TABLA ====> pa_param_tarjdeb'
go
CREATE TABLE pa_param_tarjdeb (
    td_prod_cobis           tinyint not null,
    td_prod_banc            smallint    not null,
    td_tipo_tarj            char(3) null,
    td_prod_cobis_tarj      tinyint not null,
    td_prod_banc_tarj       smallint    not null,
    td_moneda_prod          tinyint not null,
    td_prod_banc_alta       smallint    null,
    td_prod_banc_baja       smallint    null,
    td_grupo_tarj_alta      int null,
    td_grupo_tarj_baja      int null,
    td_gpo_tarj_baja_modif  char(1) null,
    td_adicionales          char(1) null,
    td_adicionales_tipo     char(1) null,
    td_entrega_pin          char(1) null,
    td_entrega_pin_tipo     char(1) null
)
go

/* pa_prod_banc */
print 'TABLA ====> pa_prod_banc'
go
CREATE TABLE pa_prod_banc (
    pb_prod_cobis   tinyint not null,
    pb_prod_banc    smallint    not null,
    pb_descripcion  varchar(64) not null,
    pb_moneda       tinyint not null,
    pb_fecha_cre    datetime    not null,
    pb_estado       char(1) not null
)
go

/* pa_relaciones */
print 'TABLA ====> pa_relaciones'
go
CREATE TABLE pa_relaciones (
    rl_tabla    varchar(6)  not null,
    rl_origen   varchar(10) not null,
    rl_destino  varchar(10) not null,
    rl_estado   char(1) null
)
go

/* pa_solicitud_paquete */
print 'TABLA ====> pa_solicitud_paquete'
go
CREATE TABLE pa_solicitud_paquete (
    sp_numsol   int not null,
    sp_prod_cobis_pq    tinyint not null,
    sp_prod_banc_pq smallint    not null,
    sp_uso_firma    char(3) not null,
    sp_oficina  smallint    not null,
    sp_origen   varchar(3)  not null,
    sp_estado   char(2) not null,
    sp_causa_deneg  varchar(3)  null,
    sp_fecha_alta   datetime    null,
    sp_fecha_aprob  datetime    null,
    sp_fecha_ing_sol    datetime    not null,
    sp_fecha_aper_pq    datetime    null,
    sp_user varchar(14) not null,
    sp_moneda   tinyint not null,
    sp_sector   varchar(10) null,
    sp_residencia   varchar(10) null,
    sp_iva  varchar(4)  null,
    sp_fecha_iva    datetime    null,
    sp_ivaexen  float   null,
    sp_ivareduc float   null,
    sp_fecha_reduc  datetime    null,
    sp_alcanzo  char(1) null,
    sp_fecha_proceso    datetime    null
)
go

/* pd_locales */
print 'TABLA ====> pd_locales'
go
CREATE TABLE pd_locales (
    lc_fecha_ing    datetime    not null,
    lc_oficina  smallint    not null,
    lc_cta_depositada   varchar(20) not null,
    lc_endoso   int null,
    lc_codbanco char(10)    not null,
    lc_cta_girada   varchar(20) not null,
    lc_num_cheque   int not null,
    lc_valor    money   not null,
    lc_producto tinyint not null,
    lc_moneda   tinyint not null,
    lc_status   char(1) not null,
    lc_mensaje  varchar(64) null,
    lc_digito   tinyint not null,
    lc_ssn_branch   int null,
    lc_fecha_proc   datetime    not null
)
go

/* pd_titulos */
print 'TABLA ====> pd_titulos'
go
CREATE TABLE pd_titulos (
    ti_fecha                datetime    not null,
    ti_contador             int not null,
    ti_juzgado              varchar(20) not null,
    ti_titulo               int not null,
    ti_valor                money   not null,
    ti_banco                smallint    not null,
    ti_clase                char(1) not null,
    ti_estado               char(1) not null,
    ti_moneda               tinyint not null,
    ti_usuario              varchar(15) not null,
    ti_causa_dev            varchar(64) null,
    ti_cta_depositada       varchar(20) not null,
    ti_oficina              smallint    not null,
    ti_producto             tinyint not null,
    ti_tipo_equip           char(1) null,
    ti_secuencial_unisys    int null,
    ti_fecha_proceso        datetime    null,
    ti_ofi_dest             smallint    null,
    ti_marca                char(1) null
)
go

/* pd_transferidos */
print 'TABLA ====> pd_transferidos'
go
CREATE TABLE pd_transferidos (
    tf_banco                smallint    not null,
    tf_fecha                datetime    not null,
    tf_contador             int not null,
    tf_cuenta               varchar(20) not null,
    tf_cheque               int not null,
    tf_valor                money   not null,
    tf_clase                char(1) not null,
    tf_estado               char(1) not null,
    tf_moneda               tinyint not null,
    tf_usuario              varchar(15) not null,
    tf_causa                char(3) null,
    tf_cta_depositada       varchar(20) not null,
    tf_oficina              smallint    not null,
    tf_producto             tinyint not null,
    tf_tipo_equip           char(1) null,
    tf_secuencial_unisys    int null
)
go

/* prodiva */
print 'TABLA ====> prodiva'
go
CREATE TABLE prodiva (
    Cuenta  varchar(30) null,
    DesCuenta   varchar(30) null,
    Debitosm1   money   null,
    Creditosm1  money   null,
    Debitosm2   money   null,
    Creditosm2  money   null,
    Sandresdebm1    money   null,
    Sandrescredm1   money   null,
    Sandresdebm2    money   null,
    Sandrescredm2   money   null,
    Provdebm1   money   null,
    Provcred1   money   null,
    Provdebm2   money   null,
    Provcred2   money   null,
    letdebm1    money   null,
    letcredm1   money   null,
    letdebdm2   money   null,
    letcredm2   money   null,
    Producto    int null,
    Desproducto varchar(30) null
)
go

/* prueba_part */
print 'TABLA ====> prueba_part'
go
CREATE TABLE prueba_part (
    codigo  int not null,
    nombre  varchar(50) not null,
    edad    smallint    not null
)
go

/* re_accion_nc */
print 'TABLA ====> re_accion_nc'
go
CREATE TABLE re_accion_nc (
    an_producto tinyint not null,
    an_causa    varchar(3)  not null,
    an_accion   char(1) not null
)
go

/* re_accion_nd */
print 'TABLA ====> re_accion_nd'
go
CREATE TABLE re_accion_nd (
    an_producto tinyint not null,
    an_causa    varchar(3)  not null,
    an_accion   char(1) not null,
    an_comision char(1) not null,
    an_impuesto char(1) null,
    an_modo char(1) not null,
    an_saldomin char(1) null
)
go

/* re_accion_nd_cca523 */
print 'TABLA ====> re_accion_nd_cca523'
go
CREATE TABLE re_accion_nd_cca523 (
    an_producto tinyint not null,
    an_causa    varchar(3)  not null,
    an_accion   char(1) not null,
    an_comision char(1) not null,
    an_impuesto char(1) null,
    an_modo char(1) not null,
    an_saldomin char(1) null
)
go

/* re_ahtotal_tranmonet */
print 'TABLA ====> re_ahtotal_tranmonet'
go
CREATE TABLE re_ahtotal_tranmonet (
    tm_fecha    datetime    not null,
    tm_oficina  smallint    not null,
    tm_oficina_cta  smallint    null,
    tm_moneda   smallint    not null,
    tm_tipo_tran    smallint    not null,
    tm_causa    varchar(4)  null,
    tm_prod_banc    smallint    null,
    tm_clase_clte   varchar(2)  null,
    tm_indicador    tinyint null,
    tm_cliente  int null,
    tm_contador int null,
    tm_valor    money   null,
    tm_chq_propios  money   null,
    tm_chq_locales  money   null,
    tm_chq_ot_plazas    money   null,
    tm_efectivo money   null,
    tm_impuesto money   null,
    tm_valor_portes money   null,
    tm_interes  money   null,
    tm_saldo_interes    money   null,
    tm_valor_comision   money   null
)
go

/* re_ahtotal_transerv */
print 'TABLA ====> re_ahtotal_transerv'
go
CREATE TABLE re_ahtotal_transerv (
    ts_fecha    datetime    not null,
    ts_oficina  smallint    not null,
    ts_oficina_cta  smallint    not null,
    ts_moneda   smallint    not null,
    ts_tipo_transaccion smallint    not null,
    ts_causa    varchar(4)  null,
    ts_prod_banc    tinyint null,
    ts_clase_clte   varchar(2)  null,
    ts_indicador    tinyint null,
    ts_cliente  int null,
    ts_contador int null,
    ts_valor    money   null,
    ts_saldo    money   null,
    ts_monto    money   null,
    ts_valor_impuesto   money   null,
    ts_impuesto2    money   null,
    ts_interes  money   null
)
go

/* re_aprobacion_camara */
print 'TABLA ====> re_aprobacion_camara'
go
CREATE TABLE re_aprobacion_camara (
    ac_id   int not null,
    ac_oficial  smallint    not null,
    ac_procesado    char(1) not null,
    ac_ofi_recom    smallint    null
)
go

/* re_arch_in_dtn */
print 'TABLA ====> re_arch_in_dtn'
go
CREATE TABLE re_arch_in_dtn (
    aid_registro    varchar(500)    null
)
go

/* re_arch_out_dtn */
print 'TABLA ====> re_arch_out_dtn'
go
CREATE TABLE re_arch_out_dtn (
    aod_registro    varchar(500)    null
)
go

/* re_archivo_alianza */
print 'TABLA ====> re_archivo_alianza'
go
CREATE TABLE re_archivo_alianza (
    ar_secuencial   int not null,
    ar_fecha    datetime    not null,
    ar_tipo_ident   char(2) not null,
    ar_identificacion   varchar(20) not null,
    ar_cliente  int null,
    ar_archivo  varchar(20) not null,
    ar_valor    money   not null,
    ar_concepto varchar(254)    not null,
    ar_regitros int not null,
    ar_error    int null,
    ar_monto_error  money   null,
    ar_procesados   int null,
    ar_monto_procesados money   null,
    ar_estado   char(1) not null,
    ar_mensaje  varchar(254)    null
)
go

/* re_archivo_error */
print 'TABLA ====> re_archivo_error'
go
CREATE TABLE re_archivo_error (
    re_nombre   varchar(250)    not null,
    re_secuencial   int not null,
    re_fecha    datetime    not null,
    re_archivo  int not null,
    re_mensaje  varchar(254)    not null
)
go

/* re_archivo_sobreg */
print 'TABLA ====> re_archivo_sobreg'
go
CREATE TABLE re_archivo_sobreg (
    as_oficina  smallint    null,
    as_nomofi   varchar(64) null,
    as_cta_banco    varchar(24) null,
    as_nomcta   varchar(64) null,
    as_cliente  int null,
    as_clase_clte   char(1) null,
    as_identif  varchar(24) null,
    as_tip_id   char(2) null,
    as_tip_sob  char(1) null,
    as_fec_aut  varchar(12) null,
    as_monto_aut    money   null,
    as_fecha_ven    varchar(12) null,
    as_tgarantia    char(1) null,
    as_califica char(1) null,
    as_calif_ant    char(1) null,
    as_nro_cred varchar(64) null,
    as_fecha_pag    varchar(12) null,
    as_fec_inisob   varchar(12) null,
    as_util_dia money   null,
    as_int_dia  money   null,
    as_dias_sob smallint    null,
    as_dias_acum    smallint    null,
    as_int_acum money   null,
    as_int_causa    money   null,
    as_int_contg    money   null,
    as_monto_sob    money   null,
    as_tasa_int money   null
)
go

/* re_aut_tran_caja */
print 'TABLA ====> re_aut_tran_caja'
go
CREATE TABLE re_aut_tran_caja (
    at_modulo   char(3) not null,
    at_tran int not null,
    at_sucursal smallint    not null,
    at_producto tinyint not null,
    at_categoria    varchar(2)  not null,
    at_autorizada   char(1) not null,
    at_fecha_crea   datetime    not null,
    at_fecha_upd    datetime    null,
    at_estado   char(1) not null
)
go

/* re_autelectronicos */
print 'TABLA ====> re_autelectronicos'
go
CREATE TABLE re_autelectronicos (
    at_nit  char(10)    not null,
    at_nombre   varchar(100)    not null
)
go

/* re_autoriza_ndnc */
print 'TABLA ====> re_autoriza_ndnc'
go
CREATE TABLE re_autoriza_ndnc (
    an_ssn  int not null,
    an_ssn_branch   int not null,
    an_trn  int not null,
    an_producto tinyint not null,
    an_ofi  smallint    not null,
    an_user varchar(30) not null,
    an_moneda   tinyint not null,
    an_cuenta   varchar(24) null,
    an_causa    char(10)    not null,
    an_indicador    tinyint null,
    an_valor    money   not null,
    an_fecha_valor_a    datetime    null,
    an_boleta   varchar(20) null,
    an_nombre_ocx   varchar(20) null,
    an_tabla    varchar(20) null,
    an_concepto varchar(50) null,
    an_fac  char(10)    not null,
    an_estado   char(1) not null,
    an_ssn_ejecucion    int null,
    an_idcaja   int not null,
    an_autorizante  varchar(30) not null,
    an_nchq int null,
    an_ctachq   varchar(18) null,
    an_codbanco varchar(10) null,
    an_tipchq   varchar(20) null
)
go

/* re_auxiliar */
print 'TABLA ====> re_auxiliar'
go
CREATE TABLE re_auxiliar (
    au_secuencial   int null
)
go

/* re_banco */
print 'TABLA ====> re_banco'
go
CREATE TABLE re_banco (
    ba_banco    tinyint not null,
    ba_descripcion  varchar(64) not null,
    ba_estado   char(1) not null,
    ba_filial   tinyint null,
    ba_nit  varchar(13) null,
    ba_ente int null
)
go

/* re_bcocedente */
print 'TABLA ====> re_bcocedente'
go
CREATE TABLE re_bcocedente (
    bc_banco    int not null,
    bc_fecha_crea   datetime    not null,
    bc_lugar_rec_propios    varchar(10) not null,
    bc_lugar_rec_remesas    varchar(10) not null,
    bc_lugar_entrega    varchar(10) not null,
    bc_dias_ent_prop_central    int not null,
    bc_dias_ent_prop    int not null,
    bc_dias_ent_rem_central int not null,
    bc_dias_ent_rem int not null,
    bc_dias_dev int not null,
    bc_dias_dev_central int not null,
    bc_dev_acumulada    char(1) not null,
    bc_com_comp float   not null,
    bc_com_sin_comp float   not null,
    bc_com_minima   money   not null,
    bc_portes_recep money   not null,
    bc_portes_dev   money   not null,
    bc_extracto varchar(10) not null,
    bc_estado   varchar(10) not null,
    bc_usuario  varchar(14) not null,
    bc_oficina  int not null,
    bc_saldo_cedente    money   null,
    bc_saldo_corresp    money   null,
    bc_valor_min_cheque money   null
)
go

/* re_bitacora_camara */
print 'TABLA ====> re_bitacora_camara'
go
CREATE TABLE re_bitacora_camara (
    bc_fecha    datetime    not null,
    bc_centro_compensador   tinyint not null,
    bc_cantidad smallint    not null,
    bc_monto    money   not null,
    bc_aceptado char(1) not null,
    bc_fecha_hoy    datetime    not null
)
go

/* re_boc_diario */
print 'TABLA ====> re_boc_diario'
go
CREATE TABLE re_boc_diario (
    bd_fecha    datetime    not null,
    bd_cuenta   varchar(40) not null,
    bd_oficina  smallint    not null,
    bd_cliente  int not null,
    bd_banco    varchar(24) not null,
    bd_concepto varchar(10) not null,
    bd_val_opera    money   not null,
    bd_val_conta    money   not null
)
go

/* re_borrar_cta */
print 'TABLA ====> re_borrar_cta'
go
CREATE TABLE re_borrar_cta (
    ah_prod char(1) not null,
    ah_cuenta   varchar(24) not null,
    ah_valor1   char(1) not null,
    ah_signo    char(1) not null,
    ah_valor    money   not null
)
go

/* re_cab_cheques */
print 'TABLA ====> re_cab_cheques'
go
CREATE TABLE re_cab_cheques (
    cc_fecha    datetime    not null,
    cc_bco_ced  int not null,
    cc_sec  int not null,
    cc_tipo_chq varchar(10) not null,
    cc_chqs int not null,
    cc_monto    money   not null,
    cc_estado   varchar(10) not null,
    cc_usuario  varchar(14) not null,
    cc_oficina  int not null,
    cc_fec_reg  datetime    null,
    cc_comision money   not null,
    cc_portes   money   not null,
    cc_iva  money   not null,
    cc_fecha_reem   datetime    null
)
go

/* re_cab_dataentry */
print 'TABLA ====> re_cab_dataentry'
go
CREATE TABLE re_cab_dataentry (
    ce_comprobante  int not null,
    ce_fecha    datetime    not null,
    ce_usuario_ing  varchar(14) not null,
    ce_usuario_apr  varchar(14) null,
    ce_monto    money   not null,
    ce_registro tinyint not null,
    ce_estado   char(1) not null,
    ce_moneda   tinyint not null,
    ce_oficina  smallint    not null,
    ce_fecha_apr    datetime    null,
    ce_fecha_trans  datetime    null
)
go

/* re_cabecera_transfer */
print 'TABLA ====> re_cabecera_transfer'
go
CREATE TABLE re_cabecera_transfer (
    ct_secuencial   int not null,
    ct_fecha    datetime    not null,
    ct_cliente  int not null,
    ct_identificacion   varchar(20) not null,
    ct_valor    money   not null,
    ct_signo    char(1) not null,
    ct_cuenta   varchar(20) not null,
    ct_oficina_cta  smallint    not null,
    ct_estado   char(1) not null,
    ct_mensaje  varchar(254)    null
)
go

/* re_caja */
print 'TABLA ====> re_caja'
go
CREATE TABLE re_caja (
    cj_fecha    datetime    not null,
    cj_filial   tinyint not null,
    cj_oficina  smallint    not null,
    cj_rol  smallint    not null,
    cj_operador char(14)    not null,
    cj_moneda   tinyint not null,
    cj_transaccion  int not null,
    cj_causa    varchar(9)  null,
    cj_numero   smallint    not null,
    cj_efectivo money   not null,
    cj_cheque   money   not null,
    cj_chq_locales  money   not null,
    cj_chq_ot_plaza money   not null,
    cj_otros    money   not null,
    cj_interes  money   not null,
    cj_ajuste_int   money   not null,
    cj_ajuste_cap   money   not null,
    cj_nodo char(30)    not null,
    cj_tipo char(2) not null,
    cj_ssn  int not null,
    cj_id_cierre    tinyint not null,
    cj_id_caja  int not null
)
go

/* re_caja_his */
print 'TABLA ====> re_caja_his'
go
CREATE TABLE re_caja_his (
    ch_fecha    datetime    not null,
    ch_filial   tinyint not null,
    ch_oficina  smallint    not null,
    ch_rol  smallint    not null,
    ch_operador char(14)    not null,
    ch_moneda   tinyint not null,
    ch_transaccion  int not null,
    ch_causa    varchar(9)  null,
    ch_numero   smallint    not null,
    ch_efectivo money   not null,
    ch_cheque   money   not null,
    ch_chq_locales  money   not null,
    ch_chq_ot_plaza money   not null,
    ch_otros    money   not null,
    ch_interes  money   not null,
    ch_ajuste_int   money   not null,
    ch_ajuste_cap   money   not null,
    ch_nodo char(30)    not null,
    ch_tipo char(2) not null,
    ch_ssn  int not null,
    ch_id_cierre    tinyint not null,
    ch_id_caja  int not null
)
go

/* re_caja_rol */
print 'TABLA ====> re_caja_rol'
go
CREATE TABLE re_caja_rol (
    cr_filial   tinyint not null,
    cr_tipo_caja    char(1) not null,
    cr_rol  tinyint not null,
    cr_fecha_creacion   datetime    not null,
    cr_usuario  varchar(14) not null,
    cr_fecha_modif  datetime    null,
    cr_estado   char(1) not null
)
go

/* re_cajero */
print 'TABLA ====> re_cajero'
go
CREATE TABLE re_cajero (
    ca_id_caja  int not null,
    ca_operador varchar(32) not null,
    ca_fecha_asig   datetime    not null,
    ca_fecha_fin    datetime    null,
    ca_secuencial   int not null
)
go

/* re_cam_pendiente */
print 'TABLA ====> re_cam_pendiente'
go
CREATE TABLE re_cam_pendiente (
    cp_id   int not null,
    cp_fecha    datetime    not null,
    cp_cuenta   int not null,
    cp_moneda   smallint    not null,
    cp_clase    char(1) not null,
    cp_cheque   int null,
    cp_oficial  smallint    not null,
    cp_oficina  smallint    not null,
    cp_valor    money   not null,
    cp_estado   char(1) not null,
    cp_nodo varchar(30) not null,
    cp_tipo char(1) not null,
    cp_usuario  varchar(14) not null,
    cp_causa    varchar(64) null,
    cp_sob_ocas money   null,
    cp_sob_cont money   null,
    cp_lcr_camara   money   null,
    cp_lcr_remesa   money   null,
    cp_procesado    char(1) not null,
    cp_sob_real money   not null,
    cp_aprob_final  smallint    null
)
go

/* re_camara */
print 'TABLA ====> re_camara'
go
CREATE TABLE re_camara (
    ca_fecha    datetime    not null,
    ca_secuencial   int not null,
    ca_tipo_cheque  char(1) not null,
    ca_cuenta   varchar(24) not null,
    ca_num_cheque   int not null,
    ca_valor    money   not null,
    ca_moneda   tinyint not null,
    ca_estado   char(1) not null,
    ca_oficina  smallint    not null,
    ca_banco    tinyint null,
    ca_mensaje  varchar(64) null,
    ca_cta_dep  varchar(24) null,
    ca_producto tinyint null,
    ca_tipo_error   char(1) null,
    ca_causa_dev    varchar(64) null,
    ca_tipo_equip   char(1) null,
    ca_tipo_tran    int null,
    ca_secuencial_unisys    int null,
    ca_sec_det  int null,
    ca_sec_cab  int null,
    ca_comision money   null,
    ca_portes   money   null,
    ca_iva  money   null,
    ca_portes_dev   money   null,
    ca_iva_dev  money   null,
    ca_procesado    char(1) null,
    ca_bcoced   int null,
    ca_tipo_compensa    char(1) null,
    ca_digito_46    tinyint null,
    ca_oficina_cta  smallint    not null
)
go

/* re_camara_definitiva */
print 'TABLA ====> re_camara_definitiva'
go
CREATE TABLE re_camara_definitiva (
    cd_estado   char(1) not null,
    cd_tipo char(1) not null,
    cd_sucursal smallint    not null,
    cd_ejecucion    char(1) null,
    cd_visacion char(1) null
)
go

/* re_campo_impuesto */
print 'TABLA ====> re_campo_impuesto'
go
CREATE TABLE re_campo_impuesto (
    ci_clase    char(1) not null,
    ci_tipo char(3) not null,
    ci_campo    char(3) not null,
    ci_tipo_dato    char(3) not null,
    ci_longitud tinyint null,
    ci_valor_cero   char(1) null,
    ci_afecta_total char(1) null,
    ci_signo    char(1) null,
    ci_verifica char(1) null,
    ci_referencia   varchar(20) null,
    ci_ref_adic char(1) null,
    ci_orden    tinyint null,
    ci_ref_acep char(1) null
)
go

/* re_canje_anterior */
print 'TABLA ====> re_canje_anterior'
go
CREATE TABLE re_canje_anterior (
    ar_oficina  smallint    not null,
    ar_mes  tinyint not null,
    ar_emitida_cob  money   not null,
    ar_totemi_cob   int not null,
    ar_emitida_neg  money   not null,
    ar_totemi_neg   int not null,
    ar_cedente_otr  money   not null,
    ar_totced_otr   int not null,
    ar_cedente_tra  money   not null,
    ar_totced_tra   int not null,
    ar_iva_neg  money   not null,
    ar_portes_neg   money   not null,
    ar_comision_neg money   not null,
    ar_iva_cob  money   not null,
    ar_portes_cob   money   not null,
    ar_comision_cob money   not null,
    ar_iva_nac  money   not null,
    ar_portes_nac   money   not null,
    ar_comision_nac money   not null,
    ar_iva_cedtranf money   not null,
    ar_portes_cedtranf  money   not null,
    ar_comision_cedtranf    money   not null,
    ar_iva_cedotr   money   not null,
    ar_portes_cedotr    money   not null,
    ar_comision_cedotr  money   not null,
    ar_confimada_neg    money   not null,
    ar_totconf_neg  int not null,
    ar_confimada_cob    money   not null,
    ar_totconf_cob  int not null,
    ar_confimada_ced    money   not null,
    ar_totconf_ced  int not null,
    ar_confimada_tranf  money   not null,
    ar_totconf_tranf    int not null,
    ar_propios  money   not null,
    ar_totpropios   int not null,
    ar_prodevpag    money   not null,
    ar_totdevpag    int not null
)
go

/* re_canje_env */
print 'TABLA ====> re_canje_env'
go
CREATE TABLE re_canje_env (
    ce_oficina  char(4) not null,
    ce_cta_banco    char(7) not null,
    ce_aplicacion   char(1) not null,
    ce_trans    char(2) not null,
    ce_tipod    char(2) not null,
    ce_cheque   char(8) not null,
    ce_vrtot1   char(14)    not null,
    ce_vrcanje1 char(14)    not null,
    ce_oforig   char(4) not null,
    ce_filler1  char(9) not null,
    ce_banco    char(2) not null,
    ce_fecha    char(8) not null,
    ce_filler2  char(2) not null,
    ce_respo    char(3) not null,
    ce_nivel    char(1) not null,
    ce_mvtoant  char(1) not null,
    ce_secuen   char(5) not null,
    ce_correc   char(1) not null,
    ce_filler3  char(12)    not null
)
go

/* re_canje_tmp */
print 'TABLA ====> re_canje_tmp'
go
CREATE TABLE re_canje_tmp (
    ct_fecha    datetime    not null,
    ct_cod_ofi  smallint    not null,
    ct_nom_ofi  varchar(64) null,
    ct_canje_recibido   money   not null,
    ct_canje_enviado    money   not null,
    ct_dev_recibida money   not null,
    ct_dev_enviada  money   not null
)
go

/* re_carga_archivo_ws */
print 'TABLA ====> re_carga_archivo_ws'
go
CREATE TABLE re_carga_archivo_ws (
    rc_tipo_reg char(2) null,
    rc_secuencia    varchar(15) null,
    rc_fecha    varchar(20) null,
    rc_nombre   varchar(60) null,
    rc_tipo_doc char(2) null,
    rc_documento    varchar(16) null,
    rc_valor    money   null,
    rc_tipo_prod    tinyint null,
    rc_cta_banco    char(16)    null,
    rc_login    varchar(16) null,
    rc_estado   char(1) null,
    rc_descripcion  varchar(60) null
)
go

/* re_carga_punto_batch */
print 'TABLA ====> re_carga_punto_batch'
go
CREATE TABLE re_carga_punto_batch (
    cp_codcb    varchar(12) null,
    cp_codigo_punto varchar(10) null,
    cp_nombre   varchar(64) null,
    cp_tipo_ced varchar(3)  null,
    cp_ced_ruc  varchar(20) null,
    cp_cod_depto    varchar(10) null,
    cp_cod_ciudad   varchar(10) null,
    cp_direccion    varchar(64) null
)
go

/* re_carga_tarjeta */
print 'TABLA ====> re_carga_tarjeta'
go
CREATE TABLE re_carga_tarjeta (
    registro    char(41)    not null
)
go

/* re_carta */
print 'TABLA ====> re_carta'
go
CREATE TABLE re_carta (
    ct_banco_e  tinyint not null,
    ct_oficina_e    smallint    not null,
    ct_ciudad_e int not null,
    ct_banco_p  tinyint not null,
    ct_oficina_p    smallint    not null,
    ct_ciudad_p int not null,
    ct_fecha_emi    datetime    not null,
    ct_moneda   tinyint not null,
    ct_carta    int not null,
    ct_fecha_efe    datetime    null,
    ct_num_cheques  tinyint null,
    ct_valor    money   null,
    ct_oficina  smallint    not null,
    ct_banco_c  tinyint not null,
    ct_oficina_c    smallint    not null,
    ct_ciudad_c int not null,
    ct_estado   char(1) not null,
    ct_proceso  char(1) null,
    ct_cob  int null,
    ct_comision money   null,
    ct_portes   money   null,
    ct_iva  money   null,
    ct_fecha_cobro  datetime    null,
    ct_totalizado   char(1) null,
    ct_tipo_rem char(1) null
)
go

/* re_catalogo_ofi */
print 'TABLA ====> re_catalogo_ofi'
go
CREATE TABLE re_catalogo_ofi (
    co_index    int IDENTITY(1,1) not null,
    co_tipo char(1) not null,
    co_oficina  smallint    null,
    co_tabla    varchar(30) not null,
    co_cod_tabla    varchar(30) not null,
    co_codigo   varchar(10) not null
)
go

/* re_catalogo_premio */
print 'TABLA ====> re_catalogo_premio'
go
CREATE TABLE re_catalogo_premio (
    pr_categoria    char(10)    not null,
    pr_codigo   smallint    not null,
    pr_descripcion  varchar(64) not null,
    pr_puntos   int null,
    pr_estado   char(1) null,
    pr_usuario  varchar(14) null,
    pr_fecha    datetime    null
)
go

/* re_cctotal_transerv */
print 'TABLA ====> re_cctotal_transerv'
go
CREATE TABLE re_cctotal_transerv (
    ts_fecha    datetime    not null,
    ts_moneda   smallint    not null,
    ts_oficina  smallint    not null,
    ts_oficina_cta  smallint    not null,
    ts_tipo_transaccion smallint    not null,
    ts_prod_banc    smallint    not null,
    ts_clase_clte   varchar(2)  null,
    ts_causa    varchar(5)  null,
    ts_indicador    tinyint null,
    ts_cliente  int null,
    ts_tipo_dias_sob    char(2) null,
    ts_tgarantia    char(1) null,
    ts_tipocta  char(1) null,
    ts_calificacion char(1) null,
    ts_fondos   char(1) null,
    ts_contador int null,
    ts_valor    money   null,
    ts_saldo    money   null,
    ts_monto    money   null,
    ts_contratado   money   null,
    ts_efectivo money   null,
    ts_deposito money   null
)
go

/* re_cheque_rec */
print 'TABLA ====> re_cheque_rec'
go
CREATE TABLE re_cheque_rec (
    cr_cheque_rec   int not null,
    cr_fecha_ing    datetime    not null,
    cr_fecha_efe    datetime    null,
    cr_status   char(1) not null,
    cr_cta_depositada   int not null,
    cr_valor    money   not null,
    cr_codbanco char(12)    null,
    cr_banco_p  tinyint null,
    cr_oficina_p    smallint    null,
    cr_ciudad_p int null,
    cr_cta_girada   varchar(24) null,
    cr_num_cheque   int not null,
    cr_oficina  smallint    not null,
    cr_producto tinyint not null,
    cr_moneda   tinyint not null,
    cr_endoso   int null,
    cr_cau_devolucion   varchar(3)  null,
    cr_procedencia  char(1) not null,
    cr_num_papeleta int null,
    cr_tipo_cheque  char(1) not null,
    cr_mensaje  varchar(64) null,
    cr_estado   char(1) null,
    cr_entregado    char(1) null,
    cr_fecha_entrega    datetime    null,
    cr_hora_entrega datetime    null,
    cr_usuario_entrega  varchar(14) null,
    cr_sec_cab  int null,
    cr_sec_det  int null,
    cr_comision money   null,
    cr_portes   money   null,
    cr_iva  money   null,
    cr_portes_dev   money   null,
    cr_iva_dev  money   null,
    cr_procesado    char(1) null,
    cr_num_titulo   varchar(10) null,
    cr_digito46 tinyint null,
    cr_tipo_compensa    char(1) null
)
go

/* re_cheque_rem */
print 'TABLA ====> re_cheque_rem'
go
CREATE TABLE re_cheque_rem (
    cr_secuencial   int not null,
    cr_oficina  smallint    not null,
    cr_fecha_ing    datetime    not null,
    cr_cta_depositada   varchar(24) not null,
    cr_endoso   int null,
    cr_codbanco char(10)    not null,
    cr_cta_girada   varchar(24) not null,
    cr_num_cheque   int not null,
    cr_valor    money   not null,
    cr_producto tinyint not null,
    cr_moneda   tinyint not null,
    cr_status   char(1) not null,
    cr_mensaje  varchar(64) null,
    cr_tipo_rem char(1) null
)
go

/* re_cheques_remesas */
print 'TABLA ====> re_cheques_remesas'
go
CREATE TABLE re_cheques_remesas (
    cr_secuencial   int not null,
    cr_fecha_emi    datetime    not null,
    cr_fecha_efe    datetime    null,
    cr_oficina  smallint    not null,
    cr_cta_dep  varchar(24) not null,
    cr_banco_p  smallint    not null,
    cr_descrip_ciu  varchar(64) not null,
    cr_ciudad_p int not null,
    cr_oficina_emi  smallint    not null,
    cr_moneda   tinyint not null,
    cr_valor    money   not null,
    cr_producto tinyint not null,
    cr_num_cheque   int not null,
    cr_estado   char(1) not null,
    cr_tipo_rem char(1) null,
    cr_comision money   null,
    cr_portes   money   null,
    cr_iva  money   null,
    cr_portes_dev   money   null,
    cr_iva_dev  money   null,
    cr_causa_dev    varchar(30) null,
    cr_origen   char(1) null
)
go

/* re_chqra_ini_ofi */
print 'TABLA ====> re_chqra_ini_ofi'
go
CREATE TABLE re_chqra_ini_ofi (
    ch_oficina  smallint    not null,
    ch_cantidad int not null
)
go

/* re_cierre */
print 'TABLA ====> re_cierre'
go
CREATE TABLE re_cierre (
    ci_filial   tinyint not null,
    ci_oficina  smallint    not null,
    ci_fecha    datetime    not null,
    ci_id_caja  int not null,
    ci_id_cierre    int not null,
    ci_tipo char(1) not null,
    ci_usuario  varchar(32) not null,
    ci_moneda   tinyint not null,
    ci_hora_ini datetime    not null,
    ci_hora_fin datetime    null,
    ci_efectivo_ini money   not null,
    ci_efectivo_fin money   null
)
go

/* re_cierre_ticket_0241999 */
print 'TABLA ====> re_cierre_ticket_0241999'
go
CREATE TABLE re_cierre_ticket_0241999 (
    ci_filial   tinyint not null,
    ci_oficina  smallint    not null,
    ci_fecha    datetime    not null,
    ci_id_caja  int not null,
    ci_id_cierre    int not null,
    ci_tipo char(1) not null,
    ci_usuario  varchar(32) not null,
    ci_moneda   tinyint not null,
    ci_hora_ini datetime    not null,
    ci_hora_fin datetime    null,
    ci_efectivo_ini money   not null,
    ci_efectivo_fin money   null
)
go

/* re_ciudad_retencion */
print 'TABLA ====> re_ciudad_retencion'
go
CREATE TABLE re_ciudad_retencion (
    cr_ciudad   int not null,
    cr_dias tinyint not null
)
go

/* re_cobro_grav */
print 'TABLA ====> re_cobro_grav'
go
CREATE TABLE re_cobro_grav (
    ci_sec  int not null,
    ci_fecha    datetime    not null,
    ci_fecha_cobro  datetime    not null,
    ci_moneda   tinyint not null,
    ci_cuenta   varchar(24) not null,
    ci_valor    money   not null,
    ci_pendiente    money   not null,
    ci_causa    varchar(3)  not null,
    ci_oficina  smallint    not null,
    ci_cobrado_total    money   not null,
    ci_cobrado_hoy  money   not null
)
go

/* re_codbar_impuesto */
print 'TABLA ====> re_codbar_impuesto'
go
CREATE TABLE re_codbar_impuesto (
    rc_clase    char(1) not null,
    rc_tipo char(3) not null,
    rc_moneda   tinyint not null,
    rc_tipo_cod char(3) not null,
    rc_fecha_ult_mod    datetime    not null,
    rc_usuario  varchar(14) not null
)
go

/* re_codigo_barras */
print 'TABLA ====> re_codigo_barras'
go
CREATE TABLE re_codigo_barras (
    cb_tipo_cod char(3) not null,
    cb_moneda   tinyint not null,
    cb_longitud tinyint not null,
    cb_num_campos   tinyint not null,
    cb_campo1   smallint    not null,
    cb_campo2   smallint    not null,
    cb_campo3   smallint    not null,
    cb_campo4   smallint    not null,
    cb_campo5   smallint    not null,
    cb_campo6   smallint    not null,
    cb_campo7   smallint    not null,
    cb_campo8   smallint    not null,
    cb_campo9   smallint    not null,
    cb_campo10  smallint    not null,
    cb_campo11  smallint    not null,
    cb_campo12  smallint    not null,
    cb_campo13  smallint    not null,
    cb_campo14  smallint    not null,
    cb_campo15  smallint    not null,
    cb_campo16  smallint    not null,
    cb_campo17  smallint    not null,
    cb_campo18  smallint    not null,
    cb_campo19  smallint    not null,
    cb_campo20  smallint    not null,
    cb_fecha_ult_mod    datetime    not null,
    cb_usuario  varchar(14) not null,
    cb_estado   char(1) not null
)
go

/* re_comisiones_rem */
print 'TABLA ====> re_comisiones_rem'
go
CREATE TABLE re_comisiones_rem (
    tr_fecha    datetime    not null,
    tr_tipo_cliente varchar(10) not null,
    tr_oficina  int not null,
    tr_comision_rec money   not null,
    tr_portes_rec   money   not null,
    tr_iva_rec  money   not null,
    tr_comision_pag money   not null,
    tr_portes_pag   money   not null,
    tr_iva_pag  money   not null
)
go

/* re_compensa_ofi */
print 'TABLA ====> re_compensa_ofi'
go
CREATE TABLE re_compensa_ofi (
    co_oficina  smallint    not null,
    co_compensa char(1) not null,
    co_banco    smallint    null,
    co_refer    varchar(15) null
)
go

/* re_conc_dev */
print 'TABLA ====> re_conc_dev'
go
CREATE TABLE re_conc_dev (
    cd_fecha    datetime    not null,
    cd_secuencial   int not null,
    cd_tipo_cheque  char(1) not null,
    cd_cuenta   varchar(24) not null,
    cd_num_cheque   int not null,
    cd_valor    money   not null,
    cd_moneda   tinyint not null,
    cd_estado   char(1) not null,
    cd_oficina  smallint    not null,
    cd_banco    tinyint null,
    cd_mensaje  varchar(64) null,
    cd_cta_dep  varchar(24) null,
    cd_producto tinyint null,
    cd_tipo_error   char(1) null,
    cd_causa_dev    varchar(64) null,
    cd_tipo_equip   char(1) null,
    cd_tipo_tran    int null,
    cd_secuencial_unisys    int null,
    cd_sec_det  int null,
    cd_sec_cab  int null,
    cd_comision money   null,
    cd_portes   money   null,
    cd_iva  money   null,
    cd_portes_dev   money   null,
    cd_iva_dev  money   null,
    cd_procesado    char(1) null,
    cd_bcoced   int null,
    cd_backup   char(1) not null
)
go

/* re_concep_exen_gmf */
print 'TABLA ====> re_concep_exen_gmf'
go
CREATE TABLE re_concep_exen_gmf (
    ce_concepto smallint    not null,
    ce_descripc varchar(65) not null,
    ce_tope char(1) not null,
    ce_vlr_tope money   not null,
    ce_tasa float   not null,
    ce_producto tinyint not null,
    ce_tipo_per char(1) not null,
    ce_titular  char(1) not null,
    ce_otra_exen    char(1) not null,
    ce_nemonico char(5) not null,
    ce_otro_conc    smallint    null
)
go

/* re_concepto_contable */
print 'TABLA ====> re_concepto_contable'
go
CREATE TABLE re_concepto_contable (
    cc_secuencial   int not null,
    cc_producto tinyint not null,
    cc_tipo_tran    smallint    not null,
    cc_causa    varchar(12) null,
    cc_tipo_imp varchar(1)  null,
    cc_credeb   char(1) not null,
    cc_concepto varchar(16) not null,
    cc_indicador    tinyint null,
    cc_campo1   varchar(32) not null,
    cc_campo2   varchar(32) null,
    cc_campo3   varchar(32) null,
    cc_totaliza char(1) not null,
    cc_fecha    datetime    not null,
    cc_tipo char(1) not null,
    cc_estado   char(1) not null
)
go

/* re_concepto_contable_inc */
print 'TABLA ====> re_concepto_contable_inc'
go
CREATE TABLE re_concepto_contable_inc (
    cc_secuencial   int not null,
    cc_producto tinyint not null,
    cc_tipo_tran    smallint    not null,
    cc_causa    varchar(12) null,
    cc_tipo_imp varchar(1)  null,
    cc_credeb   char(1) not null,
    cc_concepto varchar(16) not null,
    cc_indicador    tinyint null,
    cc_campo1   varchar(32) not null,
    cc_campo2   varchar(32) null,
    cc_campo3   varchar(32) null,
    cc_totaliza char(1) not null,
    cc_fecha    datetime    not null,
    cc_tipo char(1) not null,
    cc_estado   char(1) not null
)
go

/* re_concepto_imp */
print 'TABLA ====> re_concepto_imp'
go
CREATE TABLE re_concepto_imp (
    ci_tran int not null,
    ci_causal   varchar(10) not null,
    ci_impuesto char(1) not null,
    ci_concepto char(4) not null,
    ci_producto tinyint not null,
    ci_base1    varchar(25) null,
    ci_base2    varchar(25) null,
    ci_contabiliza  varchar(25) not null,
    ci_fecha    datetime    null
)
go

/* re_consecutivo_paquete */
print 'TABLA ====> re_consecutivo_paquete'
go
CREATE TABLE re_consecutivo_paquete (
    cp_clase    char(1) not null,
    cp_tipo varchar(3)  null,
    cp_oficina  smallint    not null,
    cp_consecutivo  int not null
)
go

/* re_consignacion_pit */
print 'TABLA ====> re_consignacion_pit'
go
CREATE TABLE re_consignacion_pit (
    cp_fecha    datetime    not null,
    cp_sec  int not null,
    cp_producto char(3) not null,
    cp_tran smallint    not null,
    cp_tran_comision    smallint    not null,
    cp_cod_alterno  int not null,
    cp_sec_branch   int not null,
    cp_cuenta   varchar(24) not null,
    cp_monto_tran   money   not null,
    cp_comision money   not null,
    cp_moneda   tinyint not null,
    cp_oficina  smallint    not null,
    cp_ofi_cta  smallint    not null,
    cp_causa    varchar(3)  not null,
    cp_estado   char(1) not null,
    cp_mensaje  varchar(64) null,
    cp_comentario   char(1) null
)
go

/* re_consol_cenit */
print 'TABLA ====> re_consol_cenit'
go
CREATE TABLE re_consol_cenit (
    ce_oficina  smallint    not null,
    ce_trans    smallint    not null,
    ce_estado   char(1) not null,
    ce_producto char(1) not null,
    ce_contador int not null,
    ce_valor    money   null,
    ce_comision money   null,
    ce_iva  money   null
)
go

/* re_consolidado_trn_cb */
print 'TABLA ====> re_consolidado_trn_cb'
go
CREATE TABLE re_consolidado_trn_cb (
    ct_fecha    varchar(12) null,
    ct_cod_red  smallint    null,
    ct_nom_red  varchar(64) null,
    ct_cant_pagos   int null,
    ct_vlr_pagos    money   null,
    ct_cant_cons    int null,
    ct_cant_dep int null,
    ct_vlr_dep  money   null,
    ct_cant_ret int null,
    ct_vlr_ret  money   null,
    ct_estado   char(1) null,
    ct_secuencial   int null,
    ct_usuario  varchar(64) null
)
go

/* re_consulta_trn_cb */
print 'TABLA ====> re_consulta_trn_cb'
go
CREATE TABLE re_consulta_trn_cb (
    ct_fecha    varchar(64) not null,
    ct_hora varchar(64) not null,
    ct_tran varchar(64) not null,
    ct_cod_red  varchar(64) not null,
    ct_nom_red  varchar(64) not null,
    ct_cod_punto    varchar(64) not null,
    ct_nom_punto    varchar(64) not null,
    ct_estado_tran  varchar(64) not null,
    ct_causal   varchar(64) not null,
    ct_des_dec  varchar(64) not null,
    ct_valor    varchar(64) not null,
    ct_secuencial   varchar(64) not null
)
go

/* re_conversion */
print 'TABLA ====> re_conversion'
go
CREATE TABLE re_conversion (
    cv_filial   tinyint not null,
    cv_oficina  smallint    not null,
    cv_producto tinyint not null,
    cv_moneda   tinyint not null,
    cv_tipo char(1) not null,
    cv_tipo_cta smallint    not null,
    cv_codigo_cta   char(6) not null,
    cv_num_actual   int not null,
    cv_cta_anterior varchar(1)  null,
    cv_fin_stock    int null
)
go

/* re_cta_consolidada */
print 'TABLA ====> re_cta_consolidada'
go
CREATE TABLE re_cta_consolidada (
    cc_cta_principal    varchar(24) not null,
    cc_prod_principal   tinyint not null,
    cc_orden    tinyint not null,
    cc_cta_asociada varchar(24) not null,
    cc_prod_asociada    tinyint not null,
    cc_frecuencia   char(1) not null
)
go

/* re_cta_dtn */
print 'TABLA ====> re_cta_dtn'
go
CREATE TABLE re_cta_dtn (
    dt_cta_banco    varchar(24) not null,
    dt_disenio  char(1) not null
)
go

/* re_cta_efectivizacion_esp */
print 'TABLA ====> re_cta_efectivizacion_esp'
go
CREATE TABLE re_cta_efectivizacion_esp (
    ce_producto tinyint not null,
    ce_cuenta   varchar(24) not null,
    ce_fecha    datetime    not null
)
go

/* re_cta_extracto */
print 'TABLA ====> re_cta_extracto'
go
CREATE TABLE re_cta_extracto (
    ex_cta_banco    varchar(24) not null,
    ex_frecuencia   char(1) not null,
    ex_producto tinyint not null
)
go

/* re_cuadre_contable */
print 'TABLA ====> re_cuadre_contable'
go
CREATE TABLE re_cuadre_contable (
    cu_empresa  tinyint not null,
    cu_producto tinyint not null,
    cu_fecha    datetime    not null,
    cu_cuenta   varchar(24) not null,
    cu_oficina  smallint    not null,
    cu_area smallint    not null,
    cu_moneda   tinyint not null,
    cu_val_opera_mn money   null,
    cu_val_opera_me money   null,
    cu_tipo char(1) null,
    cu_perfil   varchar(6)  null
)
go


/* re_cuentas_inactivas */
print 'TABLA ====> re_cuentas_inactivas'
go
CREATE TABLE re_cuentas_inactivas (
    ci_cuenta   varchar(24) null,
    ci_producto tinyint not null
)
go

/* re_cuentas_inactivas_cop */
print 'TABLA ====> re_cuentas_inactivas_cop'
go
CREATE TABLE re_cuentas_inactivas_cop (
    ci_cuenta   varchar(24) null,
    ci_producto tinyint not null
)
go

/* re_cuota_ali */
print 'TABLA ====> re_cuota_ali'
go
CREATE TABLE re_cuota_ali (
    re_identificacion   char(1) not null,
    re_cedula   char(11)    not null,
    re_apellido char(20)    not null,
    re_nombre   char(20)    not null,
    re_tipo char(1) not null,
    re_cuenta   char(12)    not null
)
go

/* re_datos_ahctasa */
print 'TABLA ====> re_datos_ahctasa'
go
CREATE TABLE re_datos_ahctasa (
    dc_oficina  smallint    null,
    dc_prod_banc    smallint    null,
    dc_clase_clte   char(1) null,
    dc_tip_id   char(2) null,
    dc_identif  varchar(24) null,
    dc_nomcta   varchar(64) null,
    dc_direccion    varchar(64) null,
    dc_telefono varchar(16) null,
    dc_ciudad   varchar(64) null,
    dc_cta_banco    varchar(24) null,
    dc_prom_act money   null,
    dc_prom_ant money   null,
    dc_variacion    money   null
)
go

/* re_datos_ahctasi */
print 'TABLA ====> re_datos_ahctasi'
go
CREATE TABLE re_datos_ahctasi (
    dc_oficina  smallint    null,
    dc_prod_banc    smallint    null,
    dc_clase_clte   char(1) null,
    dc_tip_id   char(2) null,
    dc_identif  varchar(24) null,
    dc_nomcta   varchar(64) null,
    dc_direccion    varchar(64) null,
    dc_telefono varchar(16) null,
    dc_ciudad   varchar(64) null,
    dc_cta_banco    varchar(24) null,
    dc_fultmov  varchar(10) null,
    dc_dias_inac    int null
)
go

/* re_datos_ccctasa */
print 'TABLA ====> re_datos_ccctasa'
go
CREATE TABLE re_datos_ccctasa (
    dc_oficina  smallint    null,
    dc_clase_clte   char(1) null,
    dc_tip_id   char(2) null,
    dc_identif  varchar(24) null,
    dc_nomcta   varchar(64) null,
    dc_direccion    varchar(64) null,
    dc_telefono varchar(16) null,
    dc_ciudad   varchar(64) null,
    dc_cta_banco    varchar(24) null,
    dc_prom_act money   null,
    dc_prom_ant money   null,
    dc_variacion    money   null
)
go

/* re_datos_ccctasi */
print 'TABLA ====> re_datos_ccctasi'
go
CREATE TABLE re_datos_ccctasi (
    dc_oficina  smallint    null,
    dc_clase_clte   char(1) null,
    dc_tip_id   char(2) null,
    dc_identif  varchar(24) null,
    dc_nomcta   varchar(64) null,
    dc_direccion    varchar(64) null,
    dc_telefono varchar(16) null,
    dc_ciudad   varchar(64) null,
    dc_cta_banco    varchar(24) null,
    dc_fultmov  varchar(10) null,
    dc_dias_inac    int null
)
go

/* re_definicion_caja */
print 'TABLA ====> re_definicion_caja'
go
CREATE TABLE re_definicion_caja (
    dc_id   int not null,
    dc_filial   tinyint not null,
    dc_oficina  int not null,
    dc_codigo   smallint    not null,
    dc_tipo char(1) null,
    dc_operador varchar(32) null,
    dc_estado   char(1) null,
    dc_placa    varchar(15) null,
    dc_categoria    char(1) not null
)
go

/* re_det_ahocte */
print 'TABLA ====> re_det_ahocte'
go
CREATE TABLE re_det_ahocte (
    dt_cuenta   varchar(24) not null,
    dt_producto smallint    not null,
    procesado   char(1) null
)
go

/* re_det_canje */
print 'TABLA ====> re_det_canje'
go
CREATE TABLE re_det_canje (
    dc_fecha    datetime    not null,
    dc_secuencial   int not null,
    dc_cta_banco    varchar(24) not null,
    dc_oficina  smallint    null,
    dc_producto tinyint null,
    dc_cat_premio   char(10)    null,
    dc_codigo   smallint    null,
    dc_puntos   int null,
    dc_saldo_ptos   int null,
    dc_usuario  varchar(14) null,
    dc_terminal varchar(15) null,
    dc_estado   char(1) null,
    dc_sec_reversado    int null
)
go

/* re_det_carta */
print 'TABLA ====> re_det_carta'
go
CREATE TABLE re_det_carta (
    dc_banco_e  tinyint not null,
    dc_oficina_e    smallint    not null,
    dc_ciudad_e int not null,
    dc_banco_p  smallint    not null,
    dc_oficina_p    smallint    not null,
    dc_ciudad_p int not null,
    dc_banco_c  smallint    not null,
    dc_fecha_emi    datetime    not null,
    dc_moneda   tinyint not null,
    dc_carta    int not null,
    dc_cheque   int not null,
    dc_valor    money   not null,
    dc_producto tinyint not null,
    dc_num_cheque   int not null,
    dc_status   char(1) not null,
    dc_cta_depositada   varchar(24) not null,
    dc_cta_girada   varchar(24) not null,
    dc_causa_dev    varchar(3)  null,
    dc_fecha_efe    datetime    null,
    dc_tipo_rem char(1) null,
    dc_oficial  smallint    null,
    dc_sec_cab  int null,
    dc_sec_det  int null,
    dc_comision money   null,
    dc_portes   money   null,
    dc_iva  money   null,
    dc_portes_dev   money   null,
    dc_iva_dev  money   null,
    dc_origen   char(1) null,
    dc_fecha_cobro  datetime    null,
    dc_proc_conta   char(1) null,
    dc_bcoced   tinyint null,
    dc_extraviada   char(1) null,
    dc_acuse    char(1) null,
    dc_causa_blo    varchar(2)  null,
    dc_sub_estado   char(2) null
)
go

/* re_det_cheques */
print 'TABLA ====> re_det_cheques'
go
CREATE TABLE re_det_cheques (
    dc_fecha    datetime    not null,
    dc_bco_ced  int not null,
    dc_tipo_chq varchar(10) not null,
    dc_sec_cab  int not null,
    dc_sec_chq  int not null,
    dc_cuenta   varchar(24) not null,
    dc_cheque   int not null,
    dc_valor    money   not null,
    dc_moneda   tinyint null,
    dc_estado   varchar(10) null,
    dc_banco    int not null,
    dc_ruta int not null,
    dc_clase    char(1) not null,
    dc_ubicacion_chq    varchar(10) null,
    dc_carta    int null,
    dc_det_carta    int null,
    dc_fecha_dev    datetime    null,
    dc_fecha_reembolso  datetime    null,
    dc_reembolsado  char(1) null,
    dc_dev  int null,
    dc_causa    char(64)    null,
    dc_oficina  int not null,
    dc_sec_camara   int null,
    dc_tipo_error   varchar(64) null,
    dc_mensaje  varchar(64) null,
    dc_comision money   not null,
    dc_portes   money   not null,
    dc_iva  money   not null,
    dc_portes_dev   money   null,
    dc_iva_dev  money   null
)
go

/* re_det_dataentry */
print 'TABLA ====> re_det_dataentry'
go
CREATE TABLE re_det_dataentry (
    de_comprobante  int not null,
    de_fecha    datetime    not null,
    de_secuencial   smallint    not null,
    de_valor    money   not null,
    de_transaccion  smallint    not null,
    de_causa    varchar(3)  not null,
    de_producto tinyint not null,
    de_moneda   tinyint not null,
    de_cuenta   varchar(24) not null,
    de_oficina  smallint    not null,
    de_estado   char(1) not null,
    de_mensaje  varchar(150)    null,
    de_fecha_apl    datetime    null
)
go

/* re_detalle_cbarras */
print 'TABLA ====> re_detalle_cbarras'
go
CREATE TABLE re_detalle_cbarras (
    rd_tipo_cod char(3) not null,
    rd_posicion smallint    not null,
    rd_num_digitos  smallint    not null,
    rd_valor    varchar(10) null,
    rd_desc_valor   varchar(64) null,
    rd_accion   char(1) null,
    rd_desc_accion  varchar(64) null,
    rd_campo_rec    varchar(64) null
)
go

/* re_detalle_error */
print 'TABLA ====> re_detalle_error'
go
CREATE TABLE re_detalle_error (
    de_codcb    varchar(12) null,
    de_codigo_punto varchar(10) null,
    de_nombre   varchar(64) null,
    de_tipo_ced varchar(3)  null,
    de_ced_ruc  varchar(20) null,
    de_cod_depto    varchar(10) null,
    de_cod_ciudad   varchar(10) null,
    de_direccion    varchar(64) null,
    de_observacion  varchar(255)    null
)
go

/* re_detalle_transfer */
print 'TABLA ====> re_detalle_transfer'
go
CREATE TABLE re_detalle_transfer (
    dt_codigo   int not null,
    dt_secuencial   int not null,
    dt_fecha    datetime    not null,
    dt_cliente  int not null,
    dt_identificacion   varchar(20) not null,
    dt_cuenta   varchar(20) not null,
    dt_valor    money   not null,
    dt_signo    char(1) not null,
    dt_mensaje  varchar(254)    null,
    dt_estado   char(1) not null
)
go

/* re_dev_cobis */
print 'TABLA ====> re_dev_cobis'
go
CREATE TABLE re_dev_cobis (
    dc_fecha    datetime    not null,
    dc_secuencial   int not null,
    dc_tipo_cheque  char(1) not null,
    dc_cuenta   varchar(24) not null,
    dc_num_cheque   int not null,
    dc_valor    money   not null,
    dc_moneda   tinyint not null,
    dc_estado   char(1) not null,
    dc_oficina  smallint    not null,
    dc_banco    tinyint null,
    dc_mensaje  varchar(64) null,
    dc_cta_dep  varchar(24) null,
    dc_producto tinyint null,
    dc_tipo_error   char(1) null,
    dc_causa_dev    varchar(64) null,
    dc_tipo_equip   char(1) null,
    dc_tipo_tran    int null,
    dc_secuencial_unisys    int null,
    dc_sec_det  int null,
    dc_sec_cab  int null,
    dc_comision money   null,
    dc_portes   money   null,
    dc_iva  money   null,
    dc_portes_dev   money   null,
    dc_iva_dev  money   null,
    dc_procesado    char(1) null,
    dc_bcoced   int null
)
go

/* re_dev_rec */
print 'TABLA ====> re_dev_rec'
go
CREATE TABLE re_dev_rec (
    dr_oficina  char(4) not null,
    dr_cta_banco    char(7) not null,
    dr_aplicacion   char(1) not null,
    dr_trans    char(2) not null,
    dr_tipod    char(2) not null,
    dr_cheque   char(8) not null,
    dr_vrtot1   char(14)    not null,
    dr_vrcanje1 char(14)    not null,
    dr_oforig   char(4) not null,
    dr_filler1  char(9) not null,
    dr_banco    char(2) not null,
    dr_fecha    char(8) not null,
    dr_filler2  char(2) not null,
    dr_respo    char(3) not null,
    dr_nivel    char(1) not null,
    dr_mvtoant  char(1) not null,
    dr_secuen   char(5) not null,
    dr_correc   char(1) not null,
    dr_filler3  char(12)    not null
)
go

/* re_dif_caja */
print 'TABLA ====> re_dif_caja'
go
CREATE TABLE re_dif_caja (
    dc_filial   tinyint not null,
    dc_oficina  smallint    not null,
    dc_fecha    datetime    not null,
    dc_id_caja  int not null,
    dc_usuario  varchar(32) not null,
    dc_moneda   tinyint not null,
    dc_saldo_loc    money   not null,
    dc_saldo_cen    money   not null
)
go

/* re_dtn_autorizada */
print 'TABLA ====> re_dtn_autorizada'
go
CREATE TABLE re_dtn_autorizada (
    dt_aut_banco    varchar(24) not null
)
go

/* re_enca_transfer_automatica */
print 'TABLA ====> re_enca_transfer_automatica'
go
CREATE TABLE re_enca_transfer_automatica (
    ta_tipo varchar(10) not null,
    ta_cuenta_dst   char(16)    not null,
    ta_producto_dst varchar(3)  not null,
    ta_nombre_dst   varchar(64) not null,
    ta_comision char(1) not null,
    ta_tasa float   not null,
    ta_base_comision    char(1) not null,
    ta_monto    money   not null,
    ta_monto_total  money   not null,
    ta_periodicidad char(1) not null,
    ta_dia_1    tinyint not null,
    ta_dia_2    tinyint not null,
    ta_fecha_desde  datetime    not null,
    ta_fecha_hasta  datetime    not null,
    ta_estado   char(1) not null,
    ta_codigo   int null,
    ta_usuario_crea varchar(14) null,
    ta_usuario_apro varchar(14) null,
    ta_modificable  varchar(1)  null,
    ta_oficina  int null
)
go

/* re_equivalencia */
print 'TABLA ====> re_equivalencia'
go
CREATE TABLE re_equivalencia (
    eq_secuencial   int null,
    eq_producto int null,
    eq_codbanco int null,
    eq_cta_original varchar(20) null,
    eq_cta_cobis    varchar(15) null
)
go

/* re_equivalencias */
print 'TABLA ====> re_equivalencias'
go
CREATE TABLE re_equivalencias (
    eq_modulo   tinyint not null,
    eq_mod_int  tinyint not null,
    eq_tabla    varchar(16) null,
    eq_val_cfijo    varchar(10) null,
    eq_val_num_ini  varchar(30) null,
    eq_val_num_fin  varchar(30) null,
    eq_val_interfaz varchar(10) null,
    eq_descripcion  varchar(64) null
)
go

/* re_equivalencias_CCA554 */
print 'TABLA ====> re_equivalencias_CCA554'
go
CREATE TABLE re_equivalencias_CCA554 (
    eq_modulo   tinyint not null,
    eq_mod_int  tinyint not null,
    eq_tabla    varchar(16) null,
    eq_val_cfijo    varchar(10) null,
    eq_val_num_ini  varchar(30) null,
    eq_val_num_fin  varchar(30) null,
    eq_val_interfaz varchar(10) null,
    eq_descripcion  varchar(64) null
)
go

/* re_equivalencias_CCA557 */
print 'TABLA ====> re_equivalencias_CCA557'
go
CREATE TABLE re_equivalencias_CCA557 (
    eq_modulo   tinyint not null,
    eq_mod_int  tinyint not null,
    eq_tabla    varchar(16) null,
    eq_val_cfijo    varchar(10) null,
    eq_val_num_ini  varchar(30) null,
    eq_val_num_fin  varchar(30) null,
    eq_val_interfaz varchar(10) null,
    eq_descripcion  varchar(64) null
)
go

/* re_equivalencias_REQ551 */
print 'TABLA ====> re_equivalencias_REQ551'
go
CREATE TABLE re_equivalencias_REQ551 (
    eq_modulo   tinyint not null,
    eq_mod_int  tinyint not null,
    eq_tabla    varchar(16) null,
    eq_val_cfijo    varchar(10) null,
    eq_val_num_ini  varchar(30) null,
    eq_val_num_fin  varchar(30) null,
    eq_val_interfaz varchar(10) null,
    eq_descripcion  varchar(64) null
)
go

/* re_error_batch */
print 'TABLA ====> re_error_batch'
go
CREATE TABLE re_error_batch (
    eb_cuenta   varchar(24) not null,
    eb_mensaje  varchar(64) not null
)
go

/* re_estadistica_chequera */
print 'TABLA ====> re_estadistica_chequera'
go
CREATE TABLE re_estadistica_chequera (
    ec_oficina  smallint    not null,
    ec_nomofi   varchar(30) null,
    ec_num_imp  int null,
    ec_num_rim  int null,
    ec_num_ofi  int null,
    ec_num_cli  int null,
    ec_chqra_ini    char(1) not null
)
go

/* re_eventos */
print 'TABLA ====> re_eventos'
go
CREATE TABLE re_eventos (
    banco   tinyint not null,
    valor   money   not null,
    contador    int not null,
    oficina smallint    not null,
    tipo    char(1) not null,
    evento  varchar(2)  not null,
    fecha   datetime    not null
)
go

/* re_exenta_imp */
print 'TABLA ====> re_exenta_imp'
go
CREATE TABLE re_exenta_imp (
    ex_producto tinyint not null,
    ex_oficina  smallint    not null,
    ex_base money   not null,
    ex_impuesto money   not null,
    ex_exenta   money   not null,
    ex_devolucion   money   not null
)
go

/* re_extraviadas */
print 'TABLA ====> re_extraviadas'
go
CREATE TABLE re_extraviadas (
    ex_fecha    datetime    not null,
    ex_banco    int not null,
    ex_cuenta   varchar(24) not null,
    ex_tipo_cliente varchar(10) not null,
    ex_interno  char(1) not null,
    ex_carta    int not null,
    ex_det_carta    int not null,
    ex_fecha_mod    datetime    null,
    ex_usuario  varchar(14) not null,
    ex_term varchar(10) not null,
    ex_term_mod varchar(10) null,
    ex_bcoced   int null,
    ex_num_cheque   int not null,
    ex_ruta int null,
    ex_valor    money   null
)
go

/* re_fecha_ejecucion */
print 'TABLA ====> re_fecha_ejecucion'
go
CREATE TABLE re_fecha_ejecucion (
    fe_producto tinyint not null,
    fe_fecha    datetime    not null
)
go

/* re_findia_bv */
print 'TABLA ====> re_findia_bv'
go
CREATE TABLE re_findia_bv (
    fd_fecha    datetime    not null,
    fd_accion   char(1) not null
)
go

/* re_fpago_impuesto */
print 'TABLA ====> re_fpago_impuesto'
go
CREATE TABLE re_fpago_impuesto (
    fp_clase    char(1) not null,
    fp_tipo char(3) not null,
    fp_forma_pago   char(3) not null,
    fp_extendido    char(1) null
)
go

/* re_gcontribuyente */
print 'TABLA ====> re_gcontribuyente'
go
CREATE TABLE re_gcontribuyente (
    gc_nit  char(10)    not null,
    gc_nombre   varchar(100)    not null
)
go

/* re_gcontribuyente_1 */
print 'TABLA ====> re_gcontribuyente_1'
go
CREATE TABLE re_gcontribuyente_1 (
    gc_nit  char(10)    not null,
    gc_nombre   varchar(100)    not null
)
go

/* re_gen_monet_bv */
print 'TABLA ====> re_gen_monet_bv'
go
CREATE TABLE re_gen_monet_bv (
    gm_fecha    datetime    not null,
    gm_producto tinyint not null,
    gm_moneda   smallint    not null,
    gm_tipo_tran    int not null,
    gm_causa    varchar(10) not null,
    gm_ofi_org  smallint    not null,
    gm_ofi_dst  smallint    not null,
    gm_prod_banc    smallint    not null,
    gm_clase_clte   char(1) not null,
    gm_signo    char(1) not null,
    gm_correccion   char(1) not null,
    gm_estado_correccion    char(1) not null,
    gm_estado_ejecucion varchar(10) not null,
    gm_ssn_local    int not null,
    gm_ssn_local_alterno    int not null,
    gm_ssn_local_correccion int null,
    gm_valor    money   null,
    gm_efectivo money   null,
    gm_chq_propios  money   null,
    gm_chq_locales  money   null,
    gm_chq_plazas   money   null,
    gm_canal    tinyint null,
    gm_indicador    tinyint null
)
go

/* re_gmf_alianza */
print 'TABLA ====> re_gmf_alianza'
go
CREATE TABLE re_gmf_alianza (
    gm_codigo   int not null,
    gm_fecha    datetime    not null,
    gm_cliente  int not null,
    gm_cuenta   varchar(20) not null,
    gm_moneda   tinyint not null,
    gm_oficina  smallint    not null,
    gm_valor    money   not null,
    gm_estado   char(1) not null
)
go

/* re_grupo */
print 'TABLA ====> re_grupo'
go
CREATE TABLE re_grupo (
    gr_nivel    tinyint not null,
    gr_grupo    tinyint not null,
    gr_descripcion  varchar(20) not null,
    gr_ubicacion    tinyint not null
)
go

/* re_grupo_camara */
print 'TABLA ====> re_grupo_camara'
go
CREATE TABLE re_grupo_camara (
    ca_secuencial   int not null,
    ca_tipo_cheque  char(1) not null,
    ca_cuenta   varchar(24) not null,
    ca_num_cheque   int not null,
    ca_valor    money   not null,
    ca_moneda   tinyint not null,
    ca_oficina  smallint    not null,
    ca_banco    tinyint null,
    ca_cta_dep  varchar(24) null,
    ca_producto tinyint null,
    ca_causa_dev    varchar(64) null,
    ca_tipo_equip   char(1) null,
    ca_cob  int null,
    ca_grupo    tinyint null,
    ca_proceso  char(1) not null,
    ca_tipo_compensa    char(1) null,
    ca_estado   char(1) null
)
go

/* re_his_extracto */
print 'TABLA ====> re_his_extracto'
go
CREATE TABLE re_his_extracto (
    he_producto tinyint not null,
    he_cta_banco    varchar(24) not null,
    he_mes  tinyint not null,
    he_ano  smallint    not null,
    he_cont tinyint not null,
    he_fecha    datetime    not null
)
go

/* re_his_total */
print 'TABLA ====> re_his_total'
go
CREATE TABLE re_his_total (
    to_producto tinyint not null,
    to_moneda   tinyint not null,
    to_tipo_tran    smallint    not null,
    to_causa    varchar(5)  not null,
    to_ofic_orig    smallint    not null,
    to_ofic_dest    smallint    not null,
    to_valor    money   not null,
    to_perfil   varchar(10) not null,
    to_valor_me money   not null,
    to_numtran  int not null,
    to_estado   char(1) not null,
    to_tipo char(1) not null,
    to_prod_banc    tinyint not null,
    to_clase_clte   char(1) not null,
    to_dias_sobregiro   char(2) null,
    to_clase_garantia   char(1) null,
    to_tipo_cta char(3) null,
    to_oficial  smallint    null,
    to_cliente  int null,
    to_base money   null,
    to_tipo_impuesto    char(1) null,
    to_calificacion char(1) null,
    to_procesado    char(1) null,
    to_hora datetime    null,
    to_mensaje  varchar(120)    null,
    to_producto1    char(1) null,
    to_fondos   char(1) null,
    to_tipo_embargo char(1) null,
    to_comprobante  int null,
    to_causa_org    varchar(5)  null
)
go

/* re_impuesto */
print 'TABLA ====> re_impuesto'
go
CREATE TABLE re_impuesto (
    im_secuencial   int not null,
    im_fecha    datetime    not null,
    im_clase    char(1) not null,
    im_tipo varchar(3)  not null,
    im_oficina  smallint    not null,
    im_administracion   char(2) not null,
    im_reciprocidad tinyint not null,
    im_automatico   char(1) null,
    im_redigitacion char(1) not null,
    im_extendido    char(1) not null,
    im_total_cero   char(1) null,
    im_sidunea  char(1) null
)
go

/* re_inurbe */
print 'TABLA ====> re_inurbe'
go
CREATE TABLE re_inurbe (
    in_identificacion   char(8) not null,
    in_codigo   char(1) not null,
    in_descripcion  char(15)    not null,
    in_apellido char(20)    not null,
    in_nonbre   char(20)    not null,
    in_banco    char(20)    not null,
    in_cod_ban  char(2) not null,
    in_fecha    char(8) not null,
    in_meta char(13)    not null,
    in_meta_sv  char(8) not null,
    in_tiempo   char(3) not null,
    in_cuota    char(13)    not null,
    in_depart   char(2) not null,
    in_ciudad   char(3) not null,
    in_saldo    char(13)    not null
)
go

/* re_limite_transaccion */
print 'TABLA ====> re_limite_transaccion'
go
CREATE TABLE re_limite_transaccion (
    lt_transaccion  int not null,
    lt_tipo char(3) not null,
    lt_ilimitado    char(1) not null,
    lt_maximo   money   null,
    lt_ofi_cta  char(1) not null,
    lt_fecha    datetime    not null,
    lt_fecha_mod    datetime    not null,
    lt_usuario  varchar(16) not null
)
go

/* re_limites */
print 'TABLA ====> re_limites'
go
CREATE TABLE re_limites (
    li_id   int not null,
    li_por_oficina  char(1) not null,
    li_filial   tinyint null,
    li_oficina  smallint    null,
    li_subcriterio  char(1) null,
    li_operador varchar(32) null,
    li_tipo_caja    char(1) null,
    li_monto_max    money   null,
    li_monto_min    money   null,
    li_moneda   tinyint not null,
    li_tipo char(1) not null,
    li_conversion   char(1) not null,
    li_observaciones    varchar(64) null
)
go

/* re_liquidacion_intereses */
print 'TABLA ====> re_liquidacion_intereses'
go
CREATE TABLE re_liquidacion_intereses (
    re_secuencial   int not null,
    re_fecha    datetime    not null,
    re_oficina_trx  smallint    not null,
    re_oficina  smallint    not null,
    re_tipo char(1) not null,
    re_fecha_recaudo    datetime    not null,
    re_fecha_traslado   datetime    not null,
    re_valor_extemporaneo   money   not null,
    re_dias_extemp  smallint    not null,
    re_tasa_interes float   not null,
    re_valor_interes    money   not null
)
go

/* re_locales */
print 'TABLA ====> re_locales'
go
CREATE TABLE re_locales (
    lo_fecha    datetime    not null,
    lo_secuencial   int not null,
    lo_tipo_cheque  char(1) not null,
    lo_cuenta   varchar(24) not null,
    lo_num_cheque   int not null,
    lo_valor    money   not null,
    lo_moneda   tinyint not null,
    lo_estado   char(1) not null,
    lo_oficina  smallint    not null,
    lo_banco    tinyint null,
    lo_mensaje  varchar(64) null,
    lo_cta_dep  varchar(24) null,
    lo_producto tinyint null,
    lo_tipo_error   char(1) null,
    lo_causa_dev    varchar(64) null,
    lo_tipo_equip   char(1) null,
    lo_tipo_tran    int null,
    lo_secuencial_unisys    int null
)
go

/* re_logtran_atm */
print 'TABLA ====> re_logtran_atm'
go
CREATE TABLE re_logtran_atm (
    at_secuencial   int not null,
    at_ssn_branch   int not null,
    at_nodo varchar(32) not null,
    at_user varchar(32) not null,
    at_term varchar(16) not null,
    at_date datetime    not null,
    at_ofi  smallint    not null,
    at_rol  smallint    not null,
    at_trn  int not null,
    at_rty  char(1) not null,
    at_stand_in char(1) not null,
    at_correccion   char(1) not null,
    at_signo    char(1) not null,
    at_prod_deb tinyint not null,
    at_cta_deb  varchar(24) not null,
    at_mon_deb  tinyint not null,
    at_val_deb  money   not null,
    at_final_ammount_deb    money   not null,
    at_prod_cre tinyint null,
    at_cta_cre  varchar(24) null,
    at_mon_cre  tinyint null,
    at_mon_org  tinyint null,
    at_val_org  money   null,
    at_final_ammount_org    money   null,
    at_srv_org  char(8) null,
    at_canal    tinyint not null,
    at_tarjeta  varchar(24) not null,
    at_cliente  int not null,
    at_num_trans    int not null,
    at_comision money   null,
    at_tipo_cupo    char(1) null,
    at_saldo_cupo   money   null,
    at_fecha_cupo   datetime    null,
    at_clave_red    varchar(80) not null,
    at_numrefer char(12)    not null,
    at_localidad    varchar(48) null,
    at_estado_correccion    char(1) null,
    at_fecha    datetime    null
)
go

/* re_logtran_bcp */
print 'TABLA ====> re_logtran_bcp'
go
CREATE TABLE re_logtran_bcp (
    lb_srv_local    varchar(16) not null,
    lb_oficina  smallint    not null,
    lb_ssn_local    int not null,
    lb_ssn_host int null
)
go

/* re_mal_remitido */
print 'TABLA ====> re_mal_remitido'
go
CREATE TABLE re_mal_remitido (
    mr_fecha    datetime    not null,
    mr_secuencial   int not null,
    mr_tipo_cheque  char(1) not null,
    mr_cuenta   varchar(24) not null,
    mr_num_cheque   int not null,
    mr_valor    money   not null,
    mr_moneda   tinyint not null,
    mr_estado   char(1) not null,
    mr_oficina  smallint    not null,
    mr_banco    tinyint null,
    mr_mensaje  varchar(64) null,
    mr_cta_dep  varchar(24) null,
    mr_producto tinyint null,
    mr_tipo_error   char(1) null,
    mr_causa_dev    varchar(64) null,
    mr_tipo_equip   char(1) null,
    mr_tipo_tran    int null
)
go

/* re_mantenimiento_cb */
print 'TABLA ====> re_mantenimiento_cb'
go
CREATE TABLE re_mantenimiento_cb (
    mc_cod_cb   smallint    not null,
    mc_ente int not null,
    mc_cod_red  varchar(30) not null,
    mc_estado   char(1) not null,
    mc_num_contrato varchar(100)    not null,
    mc_cta_banco    varchar(24) not null,
    mc_cta_comision varchar(24) null,
    mc_fecha_ven_con    datetime    not null,
    mc_usuario  varchar(14) not null,
    mc_fecha_ing    datetime    not null,
    mc_fecha_mod    datetime    null,
    mc_oficina  smallint    not null
)
go

/* re_mantenimiento_cupo_cb */
print 'TABLA ====> re_mantenimiento_cupo_cb'
go
CREATE TABLE re_mantenimiento_cupo_cb (
    cc_cta_banco    varchar(24) not null,
    cc_valor_cupo   money   not null,
    cc_dias_vigencia    smallint    not null,
    cc_fecha_vencimiento    datetime    not null,
    cc_tipo_mov char(1) not null,
    cc_oficina_reg  smallint    not null,
    cc_usuario_reg  varchar(14) not null,
    cc_fecha_ingreso    datetime    not null,
    cc_hora_ingreso datetime    not null
)
go

/* re_marcacion_cuentas */
print 'TABLA ====> re_marcacion_cuentas'
go
CREATE TABLE re_marcacion_cuentas (
    mc_producto char(3) not null,
    mc_cuenta   varchar(24) not null,
    mc_servicio varchar(10) not null,
    mc_habilitado   char(1) not null,
    mc_fecha_ing    datetime    null,
    mc_observacion  varchar(32) null,
    mc_login    varchar(14) null,
    mc_fecha_mod    datetime    null,
    mc_comercio varchar(15) null,
    mc_num_celular  varchar(13) null,
    mc_tipo_operador    varchar(3)  null
)
go

/* re_masiva */
print 'TABLA ====> re_masiva'
go
CREATE TABLE re_masiva (
    ma_secuencial   int not null,
    ma_filial   tinyint not null,
    ma_oficina  smallint    not null,
    ma_oficial  smallint    not null,
    ma_fecha_ap datetime    not null,
    ma_cedruc   varchar(30) not null,
    ma_cliente  int null,
    ma_clase_clte   char(1) not null,
    ma_direc    tinyint null,
    ma_ciclo    char(1) not null,
    ma_categoria    char(1) not null,
    ma_producto tinyint not null,
    ma_moneda   tinyint not null,
    ma_tipo_prom    char(1) not null,
    ma_nombre   varchar(64) not null,
    ma_prod_banc    smallint    not null,
    ma_tipo_dir char(1) null,
    ma_origen   varchar(3)  null,
    ma_sueldo   money   null,
    ma_cta  varchar(24) null,
    ma_tarj varchar(24) null,
    ma_procesada_tarj   char(1) null,
    ma_funcionario  tinyint null,
    ma_tipo_tarj    char(3) not null,
    ma_genera_tarj  char(1) not null,
    ma_subtipo_per  char(1) not null,
    ma_tipo_doc char(3) not null,
    ma_nombres_per  varchar(64) not null,
    ma_p_apellido   varchar(16) not null,
    ma_s_apellido   varchar(16) null,
    ma_dep_dir  char(1) not null,
    ma_ciu_dir  int not null,
    ma_descrip_dir  varchar(254)    not null,
    ma_convenio varchar(13) not null,
    ma_contragarantia   char(12)    not null,
    ma_tipo_convenio    char(1) not null,
    ma_nombre_con   varchar(64) not null,
    ma_periocidad   smallint    not null,
    ma_fecha_vigencia   datetime    not null,
    ma_fecha_ven    datetime    not null,
    ma_tipo_monto   char(1) not null,
    ma_estado_conv  char(1) null,
    ma_principal    char(1) not null,
    ma_cta_conv varchar(24) null,
    ma_producto_con char(1) null,
    ma_causa_conv   char(1) null,
    ma_mensaje_conv varchar(100)    null
)
go

/* re_medio_amb */
print 'TABLA ====> re_medio_amb'
go
CREATE TABLE re_medio_amb (
    md_estado   char(1) not null,
    md_cedruc   char(8) not null,
    md_nonbre   char(40)    not null,
    md_depart   char(2) not null,
    md_ciudad   char(3) not null,
    md_cuenta   char(7) not null,
    md_cta_banco    char(12)    not null,
    md_cod_ban  char(2) not null,
    md_fecha    char(8) not null,
    md_saldo    char(13)    not null
)
go

/* re_movimientos_caja */
print 'TABLA ====> re_movimientos_caja'
go
CREATE TABLE re_movimientos_caja (
    mc_id   int not null,
    mc_filial   tinyint not null,
    mc_fecha_org    datetime    not null,
    mc_fecha_dest   datetime    null,
    mc_hora_org datetime    not null,
    mc_hora_dest    datetime    null,
    mc_tipo char(1) not null,
    mc_moneda   tinyint not null,
    mc_causa    int null,
    mc_valor    money   not null,
    mc_id_caja_org  int not null,
    mc_usuario_org  varchar(32) not null,
    mc_oficina_org  smallint    not null,
    mc_id_caja_des  int null,
    mc_usuario_des  varchar(32) null,
    mc_oficina_des  smallint    not null,
    mc_estado   char(1) not null,
    mc_cliente  int null,
    mc_id_caja_bli  int null,
    mc_oficina_bli  smallint    null,
    mc_usuario_bli  varchar(32) null,
    mc_id_caja_acp  int null,
    mc_oficina_acp  smallint    null,
    mc_usuario_acp  varchar(32) null,
    mc_rol_org  smallint    null
)
go

/* re_ndc_auto_cabecera */
print 'TABLA ====> re_ndc_auto_cabecera'
go
CREATE TABLE re_ndc_auto_cabecera (
    na_fecha    datetime    not null,
    na_sec  int not null,
    na_empresa  int not null,
    na_producto char(3) not null,
    na_moneda   tinyint not null,
    na_operacion    char(1) not null,
    na_valor    money   not null,
    na_causa    varchar(3)  not null,
    na_comentario   varchar(64) null,
    na_estado   char(1) not null,
    na_cuadrado char(1) not null,
    na_oficina  smallint    not null,
    na_valor_fijo   money   not null
)
go

/* re_ndc_automatica */
print 'TABLA ====> re_ndc_automatica'
go
CREATE TABLE re_ndc_automatica (
    na_fecha    datetime    not null,
    na_sec  int not null,
    na_sec_empresa  int not null,
    na_empresa  int not null,
    na_producto char(3) not null,
    na_moneda   tinyint not null,
    na_cuenta   varchar(24) not null,
    na_operacion    char(1) not null,
    na_valor    money   not null,
    na_causa    varchar(3)  not null,
    na_estado   char(1) not null,
    na_mensaje  varchar(64) null,
    na_comentario   varchar(64) null,
    na_oficina  smallint    not null,
    na_ind_nomina   char(1) null
)
go

/* re_ndc_judiciales */
print 'TABLA ====> re_ndc_judiciales'
go
CREATE TABLE re_ndc_judiciales (
    dj_fecha    datetime    not null,
    dj_sec  int not null,
    dj_sec_empresa  int not null,
    dj_empresa  int not null,
    dj_producto char(3) not null,
    dj_moneda   tinyint not null,
    dj_cuenta   varchar(24) not null,
    dj_operacion    char(1) not null,
    dj_valor    money   not null,
    dj_causa    varchar(3)  not null,
    dj_estado   char(1) not null,
    dj_mensaje  varchar(64) null,
    dj_comentario   varchar(64) null,
    dj_oficina  smallint    not null
)
go

/* re_nombre_bcogirado */
print 'TABLA ====> re_nombre_bcogirado'
go
CREATE TABLE re_nombre_bcogirado (
    nb_codigo   smallint    not null,
    nb_descripcion  varchar(64) not null,
    nb_estado   char(1) null,
    nb_banco    tinyint not null
)
go

/* re_numcta_extracto */
print 'TABLA ====> re_numcta_extracto'
go
CREATE TABLE re_numcta_extracto (
    secuencial  numeric not null,
    ex_cta_extracto varchar(24) not null,
    ex_frecuencia   char(1) not null,
    ex_procesada    char(1) not null
)
go

/* re_ofi_banco */
print 'TABLA ====> re_ofi_banco'
go
CREATE TABLE re_ofi_banco (
    ob_banco    tinyint not null,
    ob_oficina  smallint    not null,
    ob_ciudad   int not null,
    ob_descripcion  varchar(64) not null,
    ob_fecha    datetime    null,
    ob_direccion    varchar(120)    null,
    ob_telefono varchar(12) null,
    ob_ofi_cobis    smallint    null,
    ob_identificacion   varchar(8)  null
)
go

/* re_ofi_personal */
print 'TABLA ====> re_ofi_personal'
go
CREATE TABLE re_ofi_personal (
    op_oficial  smallint    not null
)
go

/* re_ofi_safe */
print 'TABLA ====> re_ofi_safe'
go
CREATE TABLE re_ofi_safe (
    co_oficina  smallint    not null,
    co_estado   char(1) not null,
    co_off_line char(1) not null
)
go

/* re_ofibco_canjdir */
print 'TABLA ====> re_ofibco_canjdir'
go
CREATE TABLE re_ofibco_canjdir (
    rp_banco    tinyint null,
    rp_oficina  smallint    null,
    rp_fecha    datetime    null,
    rp_semana   datetime    null,
    rp_pagcobs  money   null,
    rp_devenv1  money   null,
    rp_devrec1  money   null,
    rp_canenv1  money   null,
    rp_canrec1  money   null,
    rp_pagcob1  money   null,
    rp_devenv2  money   null,
    rp_devrec2  money   null,
    rp_canenv2  money   null,
    rp_canrec2  money   null,
    rp_pagcob2  money   null,
    rp_devenv3  money   null,
    rp_devrec3  money   null,
    rp_canenv3  money   null,
    rp_canrec3  money   null,
    rp_pagcob3  money   null,
    rp_devenv4  money   null,
    rp_devrec4  money   null,
    rp_canenv4  money   null,
    rp_canrec4  money   null,
    rp_pagcob4  money   null,
    rp_devenv5  money   null,
    rp_devrec5  money   null,
    rp_canenv5  money   null,
    rp_canrec5  money   null,
    rp_pagcob5  money   null
)
go

/* re_oficina_canje */
print 'TABLA ====> re_oficina_canje'
go
CREATE TABLE re_oficina_canje (
    oc_oficina  smallint    not null,
    oc_tipo_canje   char(1) not null,
    oc_descr_tipo   varchar(30) not null,
    oc_fecha_mod    datetime    not null,
    oc_competencia  char(1) null
)
go

/* re_oficina_virtual */
print 'TABLA ====> re_oficina_virtual'
go
CREATE TABLE re_oficina_virtual (
    ov_oficina  smallint    not null,
    ov_regional smallint    not null,
    ov_estado   char(1) not null,
    ov_canal    varchar(10) null,
    ov_nombre   varchar(64) null
)
go

/* re_orden_caja */
print 'TABLA ====> re_orden_caja'
go
CREATE TABLE re_orden_caja (
    oc_idorden  int not null,
    oc_cliente  int null,
    oc_tipodoc  varchar(10) null,
    oc_numdoc   varchar(30) null,
    oc_tipo char(1) not null,
    oc_causa    varchar(10) not null,
    oc_valor    money   not null,
    oc_ref1 int null,
    oc_ref2 int null,
    oc_ref3 varchar(30) null,
    oc_estado   char(1) not null,
    oc_fecha_reg    datetime    not null,
    oc_usuario  varchar(14) null,
    oc_fecha_cambio datetime    null,
    oc_usuar_cambio varchar(14) null,
    oc_oficina  smallint    null
)
go

/* re_orden_pago_cobro */
print 'TABLA ====> re_orden_pago_cobro'
go
CREATE TABLE re_orden_pago_cobro (
    re_idregistro   int not null,
    re_secuencial   varchar(30) null,
    re_fecha_ext    datetime    null,
    re_tipo_aplica  char(1) null,
    re_tipodoc  varchar(10) null,
    re_numdoc   varchar(30) null,
    re_nombre   varchar(30) null,
    re_tipo_mov char(1) null,
    re_causal   varchar(10) null,
    re_valor    money   null,
    re_oficina  smallint    null,
    re_ref1 int null,
    re_ref2 int null,
    re_estado   char(1) null,
    re_idorden  int null,
    re_est_ejecu    char(1) null,
    re_mje  varchar(255)    null,
    re_fecha_proceso    datetime    null,
    re_fecha_real   datetime    null
)
go

/* re_paquete */
print 'TABLA ====> re_paquete'
go
CREATE TABLE re_paquete (
    pa_secuencial   int not null,
    pa_fecha    datetime    not null,
    pa_oficina  smallint    not null,
    pa_clase    char(1) not null,
    pa_tipo varchar(3)  not null,
    pa_administracion   char(2) not null,
    pa_horario  char(1) not null,
    pa_inicial  char(15)    not null,
    pa_final    char(15)    not null,
    pa_estado   char(1) not null,
    pa_cinta    int null,
    pa_usuario  varchar(20) null,
    pa_total    money   null,
    pa_fecha_desembolso datetime    null,
    pa_numero   int null,
    pa_sidunea  char(1) null,
    pa_tipo_cont    char(1) null,
    pa_documentos   smallint    null
)
go

/* re_param_ex */
print 'TABLA ====> re_param_ex'
go
CREATE TABLE re_param_ex (
    pe_prod_banc    smallint    null,
    pe_tipo_per char(1) null,
    pe_periodicidad char(1) null,
    pe_verifi_saldo char(1) null,
    pe_saldo_prom   money   null
)
go

/* re_parametro_extracto */
print 'TABLA ====> re_parametro_extracto'
go
CREATE TABLE re_parametro_extracto (
    pe_codigo   tinyint not null,
    pe_producto tinyint not null,
    pe_prodbanc tinyint not null,
    pe_valor    tinyint not null,
    pe_login    varchar(14) not null,
    pe_fecha    datetime    not null,
    pe_fecha_mod    datetime    null,
    pe_categoria    char(1) null
)
go

/* re_perfil_exepcion */
print 'TABLA ====> re_perfil_exepcion'
go
CREATE TABLE re_perfil_exepcion (
    pe_perfil   varchar(10) not null,
    pe_concepto varchar(10) not null,
    pe_perfil_nuevo varchar(10) not null
)
go

/* re_peticiones_efectivo */
print 'TABLA ====> re_peticiones_efectivo'
go
CREATE TABLE re_peticiones_efectivo (
    pe_id   int not null,
    pe_filial   tinyint not null,
    pe_oficina  smallint    not null,
    pe_fecha_ini    datetime    not null,
    pe_fecha_asg    datetime    null,
    pe_id_caja_org  int not null,
    pe_id_caja_asg  int null,
    pe_moneda   tinyint not null,
    pe_valor    money   not null,
    pe_usuario_org  varchar(32) not null,
    pe_superv_rec   varchar(32) not null,
    pe_usuario_asg  varchar(32) null,
    pe_superv_aut   varchar(32) null,
    pe_estado   char(1) not null
)
go

/* re_procesa_cenit */
print 'TABLA ====> re_procesa_cenit'
go
CREATE TABLE re_procesa_cenit (
    pc_fecha    datetime    not null,
    pc_cuenta   varchar(24) not null,
    pc_producto char(1) not null,
    pc_trn  smallint    not null,
    pc_operacion    char(1) not null,
    pc_sfi  int not null,
    pc_ssn  int null,
    pc_oficina  smallint    not null,
    pc_banco    char(4) not null,
    pc_tipo_id  char(2) not null,
    pc_documento    char(15)    null,
    pc_flag char(1) null,
    pc_valor    money   null,
    pc_comision money   null,
    pc_iva  money   null,
    pc_tipo_prod    char(3) null,
    pc_descripcion  varchar(100)    null,
    pc_causa    varchar(3)  null,
    pc_error    int null,
    pc_mensaje  char(64)    null,
    pc_estado   char(1) not null,
    pc_oficta   smallint    null,
    pc_tipo_cta tinyint null,
    pc_bloqueo  int null
)
go

/* re_procesar_pagos_bv */
print 'TABLA ====> re_procesar_pagos_bv'
go
CREATE TABLE re_procesar_pagos_bv (
    pp_fecha    datetime    not null,
    pp_pago_id  int not null,
    pp_cta_origen   varchar(24) null,
    pp_prod_origen  tinyint null,
    pp_mon_origen   smallint    null,
    pp_ofi_cta_origen   smallint    null,
    pp_oficina_trn  smallint    not null,
    pp_cta_destino  varchar(24) null,
    pp_prod_destino tinyint null,
    pp_mon_destino  smallint    null,
    pp_valor    money   not null,
    pp_tipo char(1) not null,
    pp_concepto varchar(64) not null,
    pp_error    int not null,
    pp_msg_error    varchar(64) not null,
    pp_referencia   int not null,
    pp_estado   char(1) not null
)
go

/* re_prodbanc_rep */
print 'TABLA ====> re_prodbanc_rep'
go
CREATE TABLE re_prodbanc_rep (
    rp_oficina  smallint    null,
    rp_estado   char(1) null,
    rp_prod_banc    smallint    null,
    rp_clase_client char(1) null,
    rp_tipocta  char(1) null,
    rp_num_ctas int null,
    rp_val_ctas money   null,
    rp_producto smallint    null
)
go

/* re_producto_cliente */
print 'TABLA ====> re_producto_cliente'
go
CREATE TABLE re_producto_cliente (
    pc_tipo_relacion    char(1) not null,
    pc_cliente  int null,
    pc_producto smallint    not null,
    pc_cantidad int not null
)
go

/* re_propiedad_ndc */
print 'TABLA ====> re_propiedad_ndc'
go
CREATE TABLE re_propiedad_ndc (
    pr_producto tinyint not null,
    pr_causa    varchar(10) not null,
    pr_signo    char(1) not null,
    pr_impresion    char(1) not null,
    pr_act_fecha    char(1) not null,
    pr_camara   char(1) null,
    pr_cau_aju  varchar(10) null
)
go

/* re_propiedad_ndc_cca523 */
print 'TABLA ====> re_propiedad_ndc_cca523'
go
CREATE TABLE re_propiedad_ndc_cca523 (
    pr_producto tinyint not null,
    pr_causa    varchar(10) not null,
    pr_signo    char(1) not null,
    pr_impresion    char(1) not null,
    pr_act_fecha    char(1) not null,
    pr_camara   char(1) null,
    pr_cau_aju  varchar(10) null
)
go

/* re_punto_red_cb */
print 'TABLA ====> re_punto_red_cb'
go
CREATE TABLE re_punto_red_cb (
    pr_codigo_cb    smallint    not null,
    pr_codigo_punto varchar(10) not null,
    pr_nombre   varchar(64) not null,
    pr_tipo_ced varchar(3)  not null,
    pr_ced_ruc  varchar(15) not null,
    pr_cod_depto    varchar(10) not null,
    pr_cod_ciudad   varchar(10) not null,
    pr_direccion    varchar(64) not null,
    pr_estado   char(1) not null,
    pr_tipo_p   char(1) not null
)
go

/* re_punto_red_cb_tmp */
print 'TABLA ====> re_punto_red_cb_tmp'
go
CREATE TABLE re_punto_red_cb_tmp (
    pr_secuencial   int null,
    pr_codigo_cb    smallint    null,
    pr_codigo_punto varchar(64) null,
    pr_nombre   varchar(64) null,
    pr_tipo_ced varchar(64) null,
    pr_ced_ruc  varchar(64) null,
    pr_cod_depto    varchar(64) null,
    pr_depto_desc   varchar(64) null,
    pr_cod_ciudad   varchar(64) null,
    pr_ciudad_desc  varchar(64) null,
    pr_direccion    varchar(64) null,
    pr_estado   varchar(64) null,
    pr_tipo_p   varchar(64) null,
    pr_usuario  varchar(64) null
)
go

/* re_rechazo_tran */
print 'TABLA ====> re_rechazo_tran'
go
CREATE TABLE re_rechazo_tran (
    rh_secuencial   int null,
    rh_oficina  smallint    null,
    rh_oficina_cta  smallint    null,
    rh_moneda   tinyint null,
    rh_transacion   smallint    null,
    rh_causa    varchar(5)  null,
    rh_prod_banc    tinyint null,
    rh_producto tinyint null,
    rh_clase_clte   varchar(2)  null,
    rh_indicador    tinyint null,
    rh_campo    varchar(20) null,
    rh_valor    money   null,
    rh_fecha    datetime    null,
    rh_cliente  int null,
    rh_base money   null,
    rh_procesado    char(1) null,
    rh_contador int null,
    rh_tipo_cta char(2) null,
    rh_garantia char(2) null,
    rh_calificacion char(1) null,
    rh_fondos   char(1) null,
    rh_dias_sob char(2) null,
    rh_tipo char(1) not null
)
go

/* re_reclasificados */
print 'TABLA ====> re_reclasificados'
go
CREATE TABLE re_reclasificados (
    re_fecha    datetime    not null,
    re_secuencial   int not null,
    re_tipo_cheque  char(1) not null,
    re_cuenta   varchar(24) not null,
    re_num_cheque   int not null,
    re_valor    money   not null,
    re_moneda   tinyint not null,
    re_estado   char(1) not null,
    re_oficina  smallint    not null,
    re_banco    tinyint null,
    re_mensaje  varchar(64) null,
    re_cta_dep  varchar(24) null,
    re_producto tinyint null,
    re_tipo_error   char(1) null,
    re_causa_dev    varchar(64) null,
    re_tipo_equip   char(1) null,
    re_tipo_tran    int null,
    re_secuencial_unisys    int null
)
go

/* re_reg_equivalencia */
print 'TABLA ====> re_reg_equivalencia'
go
CREATE TABLE re_reg_equivalencia (
    re_fecha    datetime    not null,
    re_cuenta_origen    varchar(24) null,
    re_cuenta_cobis varchar(24) null,
    re_valor    money   not null,
    re_oficina  smallint    not null,
    re_banco    tinyint not null
)
go

/* re_reintegro_dtn */
print 'TABLA ====> re_reintegro_dtn'
go
CREATE TABLE re_reintegro_dtn (
    ri_cta_banco    varchar(24) not null,
    ri_cuenta   int not null,
    ri_producto int not null,
    ri_cedula   char(13)    not null,
    ri_tipo_cta tinyint not null,
    ri_grupo    char(2) not null,
    ri_fecha_corte  datetime    not null,
    ri_valor    money   not null,
    ri_interes  money   not null,
    ri_fecha_proceso    datetime    not null,
    ri_estado   char(1) not null
)
go

/* re_relacion_cta_canal */
print 'TABLA ====> re_relacion_cta_canal'
go
CREATE TABLE re_relacion_cta_canal (
    rc_cuenta   char(16)    not null,
    rc_cliente  int null,
    rc_tel_celular  varchar(15) not null,
    rc_tarj_debito  varchar(20) null,
    rc_canal    varchar(6)  null,
    rc_motivo   varchar(50) null,
    rc_estado   char(1) not null,
    rc_fecha    datetime    not null,
    rc_fecha_mod    datetime    null,
    rc_usuario  varchar(14) not null,
    rc_subtipo  char(3) null,
    rc_tipo_operador    varchar(10) null,
    rc_oficina  int null
)
go

/* re_relacion_cta_canal_CCA557 */
print 'TABLA ====> re_relacion_cta_canal_CCA557'
go
CREATE TABLE re_relacion_cta_canal_CCA557 (
    rc_cuenta   char(16)    not null,
    rc_cliente  int null,
    rc_tel_celular  varchar(15) not null,
    rc_tarj_debito  varchar(20) null,
    rc_canal    varchar(6)  null,
    rc_motivo   varchar(50) null,
    rc_estado   char(1) not null,
    rc_fecha    datetime    not null,
    rc_fecha_mod    datetime    null,
    rc_usuario  varchar(14) not null,
    rc_subtipo  char(3) null,
    rc_tipo_operador    varchar(10) null
)
go

/* re_relacion_cta_canal_ors_001209 */
print 'TABLA ====> re_relacion_cta_canal_ors_001209'
go
CREATE TABLE re_relacion_cta_canal_ors_001209 (
    rc_cuenta   char(16)    not null,
    rc_cliente  int null,
    rc_tel_celular  varchar(15) not null,
    rc_tarj_debito  varchar(20) null,
    rc_canal    varchar(6)  null,
    rc_motivo   varchar(50) null,
    rc_estado   char(1) not null,
    rc_fecha    datetime    not null,
    rc_fecha_mod    datetime    null,
    rc_usuario  varchar(14) not null,
    rc_subtipo  char(3) null,
    rc_tipo_operador    varchar(10) null
)
go

/* re_relacion_cta_canal_respaldo */
print 'TABLA ====> re_relacion_cta_canal_respaldo'
go
CREATE TABLE re_relacion_cta_canal_respaldo (
    rc_cuenta   char(16)    not null,
    rc_cliente  int null,
    rc_tel_celular  varchar(15) not null,
    rc_tarj_debito  varchar(20) null,
    rc_canal    varchar(6)  null,
    rc_motivo   varchar(50) null,
    rc_estado   char(1) not null,
    rc_fecha    datetime    not null,
    rc_fecha_mod    datetime    null,
    rc_usuario  varchar(14) not null,
    rc_subtipo  char(3) null,
    rc_tipo_operador    varchar(10) null
)
go

/* re_rembolso_bcocedente */
print 'TABLA ====> re_rembolso_bcocedente'
go
CREATE TABLE re_rembolso_bcocedente (
    rb_fecha    datetime    not null,
    rb_banco    int not null,
    rb_fecha_reem   datetime    null,
    rb_fecha_reem_central   datetime    null,
    rb_chqs int not null,
    rb_vr_consigna  money   not null,
    rb_comision money   not null,
    rb_portes   money   not null,
    rb_iva  money   not null,
    rb_chqs_dev int not null,
    rb_valor_dev    money   not null,
    rb_portes_dev   money   not null,
    rb_iva_dev  money   not null,
    rb_chqs_otdev   int not null,
    rb_valor_otdev  money   not null,
    rb_portes_otdev money   not null,
    rb_iva_otdev    money   not null,
    rb_valor_reem   money   not null,
    rb_confirmada   char(1) not null,
    rb_fecha_conf   datetime    null,
    rb_sec_ctapag   int not null,
    rb_cob  int not null
)
go

/* re_rembolso_bcocedente_tmp */
print 'TABLA ====> re_rembolso_bcocedente_tmp'
go
CREATE TABLE re_rembolso_bcocedente_tmp (
    rb_fecha    datetime    not null,
    rb_banco    int not null,
    rb_fecha_reem   datetime    null,
    rb_fecha_reem_central   datetime    null,
    rb_chqs int not null,
    rb_vr_consigna  money   not null,
    rb_comision money   not null,
    rb_portes   money   not null,
    rb_iva  money   not null,
    rb_chqs_dev int not null,
    rb_valor_dev    money   not null,
    rb_portes_dev   money   not null,
    rb_iva_dev  money   not null,
    rb_chqs_otdev   int not null,
    rb_valor_otdev  money   not null,
    rb_portes_otdev money   not null,
    rb_iva_otdev    money   not null,
    rb_valor_reem   money   not null,
    rb_confirmada   char(1) not null,
    rb_fecha_conf   datetime    null
)
go

/* re_rembolso_corresponsal */
print 'TABLA ====> re_rembolso_corresponsal'
go
CREATE TABLE re_rembolso_corresponsal (
    rc_fecha    datetime    not null,
    rc_banco    int not null,
    rc_fecha_reem   datetime    null,
    rc_fecha_reem_central   datetime    null,
    rc_chqs int not null,
    rc_vr_consigna  money   not null,
    rc_comision money   not null,
    rc_portes   money   not null,
    rc_iva  money   not null,
    rc_chqs_dev int not null,
    rc_valor_dev    money   not null,
    rc_portes_dev   money   not null,
    rc_iva_dev  money   not null,
    rc_chqs_otdev   int not null,
    rc_valor_otdev  money   not null,
    rc_portes_otdev money   not null,
    rc_iva_otdev    money   not null,
    rc_valor_reem   money   not null,
    rc_confirmada   char(1) not null,
    rc_fecha_conf   datetime    null,
    rc_sec_ctacob   int not null,
    rc_cob  int not null
)
go

/* re_remesa_mensual */
print 'TABLA ====> re_remesa_mensual'
go
CREATE TABLE re_remesa_mensual (
    rm_sucursal smallint    not null,
    rm_oficina  smallint    not null,
    rm_fecha    smalldatetime   not null,
    rm_cant_efec    int null,
    rm_valor_efec   money   null,
    rm_cant_abo int null,
    rm_valor_abo    money   null
)
go

/* re_remisoria */
print 'TABLA ====> re_remisoria'
go
CREATE TABLE re_remisoria (
    re_fecha    datetime    not null,
    re_oficina_e    int not null,
    re_fecha_reg    datetime    null,
    re_banco    int null,
    re_cta_depo varchar(24) not null,
    re_producto tinyint null,
    re_cta_gir  varchar(24) null,
    re_valor    money   not null,
    re_numchq   int not null,
    re_ruta int not null,
    re_causal_dev   varchar(32) null,
    re_oficina_cta  int null,
    re_oficina_c    int null,
    re_num_titulo   varchar(10) null
)
go

/* re_rep_int_ctas_dtn_cab */
print 'TABLA ====> re_rep_int_ctas_dtn_cab'
go
CREATE TABLE re_rep_int_ctas_dtn_cab (
    ric_cuenta  varchar(64) null,
    ric_valor_int   varchar(64) null
)
go

/* re_rep_int_ctas_dtn_det */
print 'TABLA ====> re_rep_int_ctas_dtn_det'
go
CREATE TABLE re_rep_int_ctas_dtn_det (
    ric_cuenta  varchar(64) null,
    ric_valor_int   varchar(64) null
)
go

/* re_rep_reint_gmf */
print 'TABLA ====> re_rep_reint_gmf'
go
CREATE TABLE re_rep_reint_gmf (
    re_fecha    varchar(10) null,
    re_alianza  int null,
    re_nom_alianza  varchar(255)    null,
    re_cta_alianza  varchar(24) null,
    re_val_reintegro    money   null,
    re_ofi_reintegro    smallint    null,
    re_porc float   null
)
go

/* re_reporte_servicios_cab */
print 'TABLA ====> re_reporte_servicios_cab'
go
CREATE TABLE re_reporte_servicios_cab (
    rsc_sucursal    varchar(30) null,
    rsc_servicios   varchar(30) null,
    rsc_desc_serv   varchar(30) null,
    rsc_rango   varchar(30) null,
    rsc_desc_rango  varchar(30) null,
    rsc_pro_final   varchar(30) null,
    rsc_desc_pro_final  varchar(30) null,
    rsc_categoria   varchar(30) null,
    rsc_desc_categoria  varchar(30) null,
    rsc_grupo_rango varchar(30) null,
    rsc_tipo_rango  varchar(30) null,
    rsc_valor_max   varchar(30) null,
    rsc_valor_min   varchar(30) null,
    rsc_valor_medio varchar(30) null,
    rsc_fecha   varchar(30) null
)
go

/* re_reporte_servicios_cab_vigente */
print 'TABLA ====> re_reporte_servicios_cab_vigente'
go
CREATE TABLE re_reporte_servicios_cab_vigente (
    rsdv_sucursal   varchar(30) null,
    rsdv_servicios  varchar(30) null,
    rsdv_desc_serv  varchar(30) null,
    rsdv_tipo_rango varchar(30) null,
    rsdv_desc_tipo_rango    varchar(30) null,
    rsdv_pro_final  varchar(30) null,
    rsdv_desc_pro_final varchar(30) null,
    rsdv_categoria  varchar(30) null,
    rsdv_desc_categoria varchar(30) null,
    rsdv_grupo  varchar(30) null,
    rsdv_rango  varchar(30) null,
    rsdv_base   varchar(30) null,
    rsdv_minimo varchar(30) null,
    rsdv_maximo varchar(30) null
)
go

/* re_reporte_servicios_det */
print 'TABLA ====> re_reporte_servicios_det'
go
CREATE TABLE re_reporte_servicios_det (
    rsd_sucursal    smallint    not null,
    rsd_servicios   smallint    not null,
    rsd_desc_serv   varchar(64) not null,
    rsd_tipo_rango  tinyint not null,
    rsd_desc_trango varchar(64) null,
    rsd_pro_final   smallint    not null,
    rsd_desc_pro_final  varchar(64) not null,
    rsd_categoria   varchar(10) not null,
    rsd_desc_categoria  varchar(64) null,
    rsd_grupo   smallint    not null,
    rsd_rango   tinyint not null,
    rsd_valor_max   real    not null,
    rsd_valor_min   real    not null,
    rsd_valor_medio real    not null,
    rsd_fecha   smalldatetime   not null
)
go

/* re_reporte_servicios_det_vigente */
print 'TABLA ====> re_reporte_servicios_det_vigente'
go
CREATE TABLE re_reporte_servicios_det_vigente (
    rsdv_sucursal   smallint    not null,
    rsdv_servicios  smallint    not null,
    rsdv_desc_serv  varchar(35) null,
    rsdv_tipo_rango tinyint not null,
    rsdv_desc_tipo_rango    varchar(35) null,
    rsdv_pro_final  smallint    not null,
    rsdv_desc_pro_final varchar(35) null,
    rsdv_categoria  varchar(10) not null,
    rsdv_desc_categoria varchar(35) null,
    rsdv_grupo  smallint    not null,
    rsdv_rango  tinyint not null,
    rsdv_base   real    not null,
    rsdv_minimo real    not null,
    rsdv_maximo real    not null
)
go

/* re_reporte_tdebito_cab */
print 'TABLA ====> re_reporte_tdebito_cab'
go
CREATE TABLE re_reporte_tdebito_cab (
    rtc_oficina varchar(64) null,
    rtc_desc_oficina    varchar(64) null,
    rtc_usuario varchar(64) null,
    rtc_producto    varchar(64) null,
    rtc_tarj_debito varchar(64) null,
    rtc_tcliente    varchar(64) null,
    rtc_merc_objetivo   varchar(64) null,
    rtc_vr_suspenso varchar(64) null,
    rtc_cuotas_cobradas varchar(64) null,
    rtc_productos_act   varchar(64) null,
    rtc_productos_inact varchar(64) null,
    rtc_estado_td   varchar(64) null,
    rtc_estado_ah   varchar(64) null,
    rtc_fecha_asignacion    varchar(64) null,
    rtc_fecha_primer_pos    varchar(64) null,
    rtc_fecha_primer_atm    varchar(64) null,
    rtc_fecha_ult_pos   varchar(64) null,
    rtc_fecha_ult_atm   varchar(64) null,
    rtc_valor_ult_pos   varchar(64) null,
    rtc_valor_ult_atm   varchar(64) null,
    rtc_valor_prom_pos  varchar(64) null,
    rtc_valor_prom_atm  varchar(64) null,
    rtc_tran_diarias    varchar(64) null,
    rtc_telf_tdebito    varchar(64) null,
    rtc_ced_ruc varchar(64) null,
    rtc_nombre  varchar(64) null,
    rtc_cancelacion varchar(64) null
)
go

/* re_reporte_tdebito_det */
print 'TABLA ====> re_reporte_tdebito_det'
go
CREATE TABLE re_reporte_tdebito_det (
    rtd_oficina int null,
    rtd_desc_oficina    varchar(64) null,
    rtd_usuario varchar(64) null,
    rtd_producto    varchar(64) null,
    rtd_tarj_debito varchar(20) null,
    rtd_tcliente    varchar(64) null,
    rtd_merc_objetivo   varchar(64) null,
    rtd_vr_suspenso money   null,
    rtd_cuotas_cobradas tinyint null,
    rtd_productos_act   varchar(64) null,
    rtd_productos_inact varchar(64) null,
    rtd_estado_td   varchar(20) null,
    rtd_estado_ah   varchar(20) null,
    rtd_fecha_asignacion    varchar(20) null,
    rtd_fecha_primer_pos    varchar(20) null,
    rtd_fecha_primer_atm    varchar(20) null,
    rtd_fecha_ult_pos   varchar(20) null,
    rtd_fecha_ult_atm   varchar(20) null,
    rtd_valor_ult_pos   money   null,
    rtd_valor_ult_atm   money   null,
    rtd_valor_prom_pos  money   null,
    rtd_valor_prom_atm  money   null,
    rtd_tran_diarias    smallint    null,
    rtd_telf_tdebito    varchar(20) null,
    rtd_ced_ruc varchar(16) null,
    rtd_nombre  varchar(64) null,
    rtd_cancelacion varchar(64) null
)
go

/* re_reporte_tdebito_mensual_cab */
print 'TABLA ====> re_reporte_tdebito_mensual_cab'
go
CREATE TABLE re_reporte_tdebito_mensual_cab (
    rmc_oficina varchar(64) null,
    rmc_desc_oficina    varchar(64) null,
    rmc_tarj_entregadas varchar(64) null,
    rmc_trn_atm varchar(64) null,
    rmc_prom_retiro varchar(64) null,
    rmc_trn_pos varchar(64) null,
    rmc_prom_compras    varchar(64) null,
    rmc_cuotas_cobradas varchar(64) null,
    rmc_treexpedidas    varchar(64) null,
    rmc_tcanceladas varchar(64) null
)
go

/* re_reporte_tdebito_mensual_det */
print 'TABLA ====> re_reporte_tdebito_mensual_det'
go
CREATE TABLE re_reporte_tdebito_mensual_det (
    rmd_oficina int null,
    rmd_desc_oficina    varchar(64) null,
    rmd_tarj_entregadas smallint    null,
    rmd_trn_atm smallint    null,
    rmd_prom_retiro money   null,
    rmd_trn_pos smallint    null,
    rmd_prom_compras    money   null,
    rmd_cuotas_cobradas int null,
    rmd_treexpedidas    smallint    null,
    rmd_tcanceladas smallint    null
)
go

/* re_retencion */
print 'TABLA ====> re_retencion'
go
CREATE TABLE re_retencion (
    re_cliente  int not null,
    re_producto char(3) not null,
    re_fecha    datetime    not null,
    re_cuenta   varchar(24) not null,
    re_iva  money   not null,
    re_base_iva money   not null,
    re_rtefte   money   not null,
    re_base_rtefte  money   not null,
    re_2x1000   money   not null,
    re_base_2x1000  money   not null
)
go

/* re_ruta */
print 'TABLA ====> re_ruta'
go
CREATE TABLE re_ruta (
    oficina int not null,
    moneda  int not null,
    cuenta  varchar(60) not null
)
go

/* re_saldo_bcocedente */
print 'TABLA ====> re_saldo_bcocedente'
go
CREATE TABLE re_saldo_bcocedente (
    sb_banco    int not null,
    sb_fecha    datetime    not null,
    sb_saldo_ant    money   not null,
    sb_num_regs int not null,
    sb_num_chqs int not null,
    sb_vr_consig    money   not null,
    sb_comision money   not null,
    sb_portes   money   not null,
    sb_iva  money   not null,
    sb_devolucion   money   not null,
    sb_nchqs_dev    int not null,
    sb_portes_dev   money   not null,
    sb_iva_dev  money   not null,
    sb_reembolso    money   not null,
    sb_ajustes  money   not null,
    sb_saldo    money   not null,
    sb_cob  smallint    not null
)
go

/* re_saldo_contable */
print 'TABLA ====> re_saldo_contable'
go
CREATE TABLE re_saldo_contable (
    sc_empresa  tinyint not null,
    sc_producto tinyint not null,
    sc_prod_banc    tinyint not null,
    sc_estado   char(1) not null,
    sc_clase    char(1) null,
    sc_cuenta   varchar(24) not null,
    sc_tipo_calif   char(1) null,
    sc_tipo_cta char(1) null,
    sc_garantia char(1) null,
    sc_calificacion char(1) null
)
go

/* re_saldo_corresponsales */
print 'TABLA ====> re_saldo_corresponsales'
go
CREATE TABLE re_saldo_corresponsales (
    sc_banco    int not null,
    sc_fecha    datetime    not null,
    sc_saldo_ant    money   not null,
    sc_num_regs int not null,
    sc_num_chqs int not null,
    sc_vr_consig    money   not null,
    sc_comision money   not null,
    sc_portes   money   not null,
    sc_iva  money   not null,
    sc_devolucion   money   not null,
    sc_nchqs_dev    int not null,
    sc_portes_dev   money   not null,
    sc_iva_dev  money   not null,
    sc_reembolso    money   not null,
    sc_ajustes  money   not null,
    sc_saldo    money   not null,
    sc_cob  smallint    not null
)
go

/* re_saldo_cuenta */
print 'TABLA ====> re_saldo_cuenta'
go
CREATE TABLE re_saldo_cuenta (
    sc_producto char(3) not null,
    sc_cuenta   int not null,
    sc_saldo_sob    money   not null,
    sc_sob_real money   null,
    sc_girar    money   null
)
go

/* re_saldos_caja */
print 'TABLA ====> re_saldos_caja'
go
CREATE TABLE re_saldos_caja (
    sc_filial   tinyint not null,
    sc_oficina  smallint    not null,
    sc_id   int not null,
    sc_moneda   tinyint not null,
    sc_saldo    money   not null
)
go

/* re_saldos_caja_ticket_0248636 */
print 'TABLA ====> re_saldos_caja_ticket_0248636'
go
CREATE TABLE re_saldos_caja_ticket_0248636 (
    sc_filial   tinyint not null,
    sc_oficina  smallint    not null,
    sc_id   int not null,
    sc_moneda   tinyint not null,
    sc_saldo    money   not null
)
go

/* re_sec_paquete */
print 'TABLA ====> re_sec_paquete'
go
CREATE TABLE re_sec_paquete (
    se_oficina  smallint    not null,
    se_numero   int not null
)
go

/* re_ssn_batch */
print 'TABLA ====> re_ssn_batch'
go
CREATE TABLE re_ssn_batch (
    sb_ssn  int not null,
    sb_alterno  int not null
)
go

/* re_supervisor */
print 'TABLA ====> re_supervisor'
go
CREATE TABLE re_supervisor (
    su_oficina  smallint    not null,
    su_login    varchar(14) not null,
    su_funcionario  smallint    not null,
    su_password varchar(30) not null
)
go

/* re_tesoro_nacional */
print 'TABLA ====> re_tesoro_nacional'
go
CREATE TABLE re_tesoro_nacional (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_tesoro_nacional_ors_1132_1 */
print 'TABLA ====> re_tesoro_nacional_ors_1132_1'
go
CREATE TABLE re_tesoro_nacional_ors_1132_1 (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_tesoro_nacional_ors_1132_2 */
print 'TABLA ====> re_tesoro_nacional_ors_1132_2'
go
CREATE TABLE re_tesoro_nacional_ors_1132_2 (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_tesoro_nacional_ors_1288 */
print 'TABLA ====> re_tesoro_nacional_ors_1288'
go
CREATE TABLE re_tesoro_nacional_ors_1288 (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_tesoro_nacional_ors_1295 */
print 'TABLA ====> re_tesoro_nacional_ors_1295'
go
CREATE TABLE re_tesoro_nacional_ors_1295 (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_tesoro_nacional_ors_1295_re */
print 'TABLA ====> re_tesoro_nacional_ors_1295_re'
go
CREATE TABLE re_tesoro_nacional_ors_1295_re (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* re_total */
print 'TABLA ====> re_total'
go
CREATE TABLE re_total (
    to_producto tinyint not null,
    to_moneda   tinyint not null,
    to_tipo_tran    smallint    not null,
    to_causa    varchar(5)  not null,
    to_ofic_orig    smallint    not null,
    to_ofic_dest    smallint    not null,
    to_valor    money   not null,
    to_perfil   varchar(10) not null,
    to_valor_me money   not null,
    to_numtran  int not null,
    to_estado   char(1) not null,
    to_tipo char(1) not null,
    to_prod_banc    tinyint not null,
    to_clase_clte   char(1) not null,
    to_dias_sobregiro   char(2) null,
    to_clase_garantia   char(1) null,
    to_tipo_cta char(3) null,
    to_oficial  smallint    null,
    to_cliente  int null,
    to_base money   null,
    to_tipo_impuesto    char(1) null,
    to_calificacion char(1) null,
    to_procesado    char(1) null,
    to_hora datetime    null,
    to_mensaje  varchar(120)    null,
    to_producto1    char(1) null,
    to_fondos   char(1) null,
    to_tipo_embargo char(1) null,
    to_comprobante  int null,
    to_causa_org    varchar(5)  null,
    to_referencia   varchar(15) null
)
go

/* re_total_auxilio */
print 'TABLA ====> re_total_auxilio'
go
CREATE TABLE re_total_auxilio (
    to_producto tinyint not null,
    to_moneda   tinyint not null,
    to_tipo_tran    smallint    not null,
    to_causa    varchar(5)  not null,
    to_ofic_orig    smallint    not null,
    to_ofic_dest    smallint    not null,
    to_valor    money   not null,
    to_perfil   varchar(10) not null,
    to_valor_me money   not null,
    to_numtran  int not null,
    to_estado   char(1) not null,
    to_tipo char(1) not null,
    to_prod_banc    tinyint not null,
    to_clase_clte   char(1) not null,
    to_dias_sobregiro   char(2) null,
    to_clase_garantia   char(1) null,
    to_tipo_cta char(3) null,
    to_oficial  smallint    null,
    to_cliente  int null,
    to_base money   null,
    to_tipo_impuesto    char(1) null,
    to_calificacion char(1) null,
    to_procesado    char(1) null,
    to_hora datetime    null,
    to_mensaje  varchar(120)    null,
    to_producto1    char(1) null,
    to_fondos   char(1) null,
    to_tipo_embargo char(1) null,
    to_comprobante  int null,
    to_causa_org    varchar(5)  null,
    to_referencia   varchar(15) null
)
go

/* re_total_bv */
print 'TABLA ====> re_total_bv'
go
CREATE TABLE re_total_bv (
    to_producto tinyint not null,
    to_moneda   tinyint not null,
    to_tipo_tran    smallint    not null,
    to_causa    varchar(5)  not null,
    to_ofic_orig    smallint    not null,
    to_ofic_dest    smallint    not null,
    to_valor    money   not null,
    to_perfil   varchar(10) not null,
    to_valor_me money   not null,
    to_numtran  int not null,
    to_estado   char(1) not null,
    to_tipo char(1) not null,
    to_prod_banc    tinyint not null,
    to_clase_clte   char(1) not null,
    to_dias_sobregiro   char(2) null,
    to_clase_garantia   char(1) null,
    to_tipo_cta char(3) null,
    to_oficial  smallint    null,
    to_cliente  int null,
    to_base money   null,
    to_tipo_impuesto    char(1) null,
    to_calificacion char(1) null,
    to_procesado    char(1) null,
    to_estado_trn   char(2) null
)
go

/* re_total_rem */
print 'TABLA ====> re_total_rem'
go
CREATE TABLE re_total_rem (
    tr_fecha    datetime    not null,
    tr_tipo_cliente varchar(10) not null,
    tr_oficina  int not null,
    tr_numchq_rec   int not null,
    tr_vr_rec   money   not null,
    tr_numchq_con   int not null,
    tr_vr_con   money   not null,
    tr_numchq_dev   int not null,
    tr_vr_dev   money   not null
)
go

/* re_totales_canje */
print 'TABLA ====> re_totales_canje'
go
CREATE TABLE re_totales_canje (
    tc_oficina  smallint    not null,
    tc_fecha    datetime    not null,
    tc_tipo char(1) not null,
    tc_banco    smallint    not null,
    tc_devrec_num   int not null,
    tc_devuelto_rec money   not null,
    tc_camrec_num   int not null,
    tc_camara_rec   money   not null,
    tc_devenv_num   int not null,
    tc_devuelto_env money   not null,
    tc_camenv_num   int not null,
    tc_camara_env   money   not null
)
go

/* re_totales_remesas */
print 'TABLA ====> re_totales_remesas'
go
CREATE TABLE re_totales_remesas (
    tr_oficina  smallint    not null,
    tr_mes  tinyint not null,
    tr_emitida_cob  money   not null,
    tr_totemi_cob   int not null,
    tr_emitida_neg  money   not null,
    tr_totemi_neg   int not null,
    tr_cedente_otr  money   not null,
    tr_totced_otr   int not null,
    tr_cedente_tra  money   not null,
    tr_totced_tra   int not null,
    tr_iva_neg  money   not null,
    tr_portes_neg   money   not null,
    tr_comision_neg money   not null,
    tr_iva_cob  money   not null,
    tr_portes_cob   money   not null,
    tr_comision_cob money   not null,
    tr_iva_nac  money   not null,
    tr_portes_nac   money   not null,
    tr_comision_nac money   not null,
    tr_iva_cedtranf money   not null,
    tr_portes_cedtranf  money   not null,
    tr_comision_cedtranf    money   not null,
    tr_iva_cedotr   money   not null,
    tr_portes_cedotr    money   not null,
    tr_comision_cedotr  money   not null,
    tr_confimada_neg    money   not null,
    tr_totconf_neg  int not null,
    tr_confimada_cob    money   not null,
    tr_totconf_cob  int not null,
    tr_confimada_ced    money   not null,
    tr_totconf_ced  int not null,
    tr_confimada_tranf  money   not null,
    tr_totconf_tranf    int not null,
    tr_propios  money   not null,
    tr_totpropios   int not null,
    tr_prodevpag    money   not null,
    tr_totdevpag    int not null
)
go

/* re_tran_conta */
print 'TABLA ====> re_tran_conta'
go
CREATE TABLE re_tran_conta (
    tc_producto tinyint not null,
    tc_moneda   tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa    varchar(3)  not null,
    tc_descripcion  varchar(64) not null
)
go

/* re_tran_contable */
print 'TABLA ====> re_tran_contable'
go
CREATE TABLE re_tran_contable (
    tc_secuencial   int not null,
    tc_producto tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa_dst    varchar(12) not null,
    tc_prod_banc    tinyint not null,
    tc_indice   smallint    not null,
    tc_credeb   char(1) not null,
    tc_perfil   varchar(16) not null,
    tc_contabiliza  varchar(32) not null,
    tc_indicador    tinyint not null,
    tc_causa_org    varchar(12) not null,
    tc_descripcion  varchar(64) not null,
    tc_fecha    datetime    not null,
    tc_estado   char(1) not null,
    tc_clase    char(1) not null,
    tc_totaliza char(1) not null
)
go

/* re_tran_contable_bck_camara */
print 'TABLA ====> re_tran_contable_bck_camara'
go
CREATE TABLE re_tran_contable_bck_camara (
    tc_secuencial   int not null,
    tc_producto tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa_dst    varchar(12) not null,
    tc_prod_banc    tinyint not null,
    tc_indice   smallint    not null,
    tc_credeb   char(1) not null,
    tc_perfil   varchar(16) not null,
    tc_contabiliza  varchar(32) not null,
    tc_indicador    tinyint not null,
    tc_causa_org    varchar(12) not null,
    tc_descripcion  varchar(64) not null,
    tc_fecha    datetime    not null,
    tc_estado   char(1) not null,
    tc_clase    char(1) not null,
    tc_totaliza char(1) not null
)
go

/* re_tran_contable_tmp_ins */
print 'TABLA ====> re_tran_contable_tmp_ins'
go
CREATE TABLE re_tran_contable_tmp_ins (
    sec int null,
    fecha   varchar(10) null
)
go

/* re_tran_equiv_bv */
print 'TABLA ====> re_tran_equiv_bv'
go
CREATE TABLE re_tran_equiv_bv (
    te_canal    tinyint not null,
    te_trn_bvi  int not null,
    te_prd_org  tinyint not null,
    te_prd_dst  tinyint not null,
    te_trn_org  int null,
    te_trn_dst  int null,
    te_cau_org  varchar(10) null,
    te_cau_dst  varchar(10) null,
    te_signo_org    char(1) not null,
    te_signo_dst    char(1) null,
    te_srv_local    varchar(16) not null
)
go

/* re_tran_interfase */
print 'TABLA ====> re_tran_interfase'
go
CREATE TABLE re_tran_interfase (
    ti_empresa  tinyint not null,
    ti_producto tinyint not null,
    ti_moneda   tinyint not null,
    ti_tipo_tran    smallint    not null,
    ti_causa    varchar(3)  not null,
    ti_ofic_orig    smallint    not null,
    ti_ofic_dest    smallint    not null,
    ti_ctadeb   char(20)    not null,
    ti_ctacre   char(20)    not null,
    ti_ctadeb_int   char(20)    null,
    ti_ctacre_int   char(20)    null,
    ti_ctadeb_des   char(20)    null,
    ti_ctacre_des   char(20)    null,
    ti_descripcion  varchar(64) not null
)
go

/* re_tran_monet_atm */
print 'TABLA ====> re_tran_monet_atm'
go
CREATE TABLE re_tran_monet_atm (
    tm_fecha    datetime    not null,
    tm_hora datetime    not null,
    tm_filial   tinyint not null,
    tm_producto tinyint not null,
    tm_cta_banco    char(24)    null,
    tm_srv_local    varchar(16) null,
    tm_srv_host varchar(16) null,
    tm_ssn_local    int not null,
    tm_ssn_local_alterno    int not null,
    tm_ssn_host int null,
    tm_oficina  smallint    not null,
    tm_usuario  varchar(16) not null,
    tm_terminal varchar(32) null,
    tm_correccion   char(1) not null,
    tm_estado_correccion    char(1) null,
    tm_ssn_local_correccion int null,
    tm_tipo_ejecucion   varchar(3)  null,
    tm_estado_ejecucion varchar(3)  null,
    tm_clave_reentry    int null,
    tm_autorizada   char(1) null,
    tm_login_aut    varchar(32) null,
    tm_tipo_tran    int not null,
    tm_moneda   tinyint null,
    tm_signo    char(1) null,
    tm_indicador    tinyint null,
    tm_causa    varchar(3)  null,
    tm_departamento smallint    null,
    tm_oficina_cta  smallint    null,
    tm_prod_bancario_cta    smallint    null,
    tm_cta_banco_d  char(24)    null,
    tm_producto_d   tinyint null,
    tm_tipo_transf  char(4) null,
    tm_banco    smallint    null,
    tm_cheque   int null,
    tm_control  int null,
    tm_tarjeta_atm  varchar(32) null,
    tm_concepto varchar(128)    null,
    tm_valor    money   null,
    tm_efectivo money   null,
    tm_chq_propios  money   null,
    tm_chq_locales  money   null,
    tm_chq_ot_plazas    money   null,
    tm_saldo_contable   money   null,
    tm_saldo_disponible money   null,
    tm_saldo_lib    money   null,
    tm_saldo_interes    money   null,
    tm_interes  money   null,
    tm_fecha1   datetime    null,
    tm_fecha2   datetime    null,
    tm_fecha3   datetime    null,
    tm_fecha4   datetime    null,
    tm_fecha5   datetime    null,
    tm_campo1   varchar(64) null,
    tm_campo2   varchar(64) null,
    tm_campo3   varchar(32) null,
    tm_campo4   varchar(32) null,
    tm_campo5   varchar(32) null,
    tm_campo6   varchar(255)    null,
    tm_monto1   money   null,
    tm_monto2   money   null,
    tm_monto3   money   null,
    tm_monto4   money   null,
    tm_monto5   money   null,
    tm_monto6   money   null,
    tm_monto7   money   null,
    tm_monto8   money   null,
    tm_monto9   money   null,
    tm_monto10  money   null,
    tm_tasa1    money   null,
    tm_tasa2    money   null,
    tm_tasa3    money   null,
    tm_tasa4    money   null,
    tm_int1 int null,
    tm_int2 int null,
    tm_int3 int null,
    tm_int4 int null,
    tm_int5 int null,
    tm_rol  smallint    not null,
    tm_tsn  int null,
    tm_detalle_pdp  char(1) null,
    tm_diferido char(1) null,
    tm_canal    tinyint not null,
    tm_idcierre int not null,
    tm_monto_reverso    money   null,
    tm_procesado    char(1) not null,
    tm_fecha_proceso    datetime    not null
)
go

/* re_tran_monet_bv */
print 'TABLA ====> re_tran_monet_bv'
go
CREATE TABLE re_tran_monet_bv (
    tm_fecha    datetime    not null,
    tm_hora datetime    not null,
    tm_filial   tinyint not null,
    tm_producto tinyint not null,
    tm_cta_banco    char(24)    null,
    tm_srv_local    varchar(16) null,
    tm_srv_host varchar(16) null,
    tm_ssn_local    int not null,
    tm_ssn_local_alterno    int not null,
    tm_ssn_host int null,
    tm_oficina  smallint    not null,
    tm_usuario  varchar(16) null,
    tm_terminal varchar(32) null,
    tm_correccion   char(1) not null,
    tm_estado_correccion    char(1) null,
    tm_ssn_local_correccion int null,
    tm_tipo_ejecucion   varchar(3)  null,
    tm_estado_ejecucion varchar(3)  null,
    tm_clave_reentry    int null,
    tm_autorizada   char(1) null,
    tm_login_aut    varchar(32) null,
    tm_tipo_tran    int not null,
    tm_moneda   tinyint null,
    tm_signo    char(1) null,
    tm_indicador    tinyint null,
    tm_causa    varchar(3)  null,
    tm_departamento smallint    null,
    tm_oficina_cta  smallint    null,
    tm_prod_bancario_cta    smallint    null,
    tm_cta_banco_d  char(24)    null,
    tm_producto_d   tinyint null,
    tm_tipo_transf  char(4) null,
    tm_banco    smallint    null,
    tm_cheque   int null,
    tm_control  int null,
    tm_tarjeta_atm  varchar(32) null,
    tm_concepto varchar(128)    null,
    tm_valor    money   null,
    tm_efectivo money   null,
    tm_chq_propios  money   null,
    tm_chq_locales  money   null,
    tm_chq_ot_plazas    money   null,
    tm_saldo_contable   money   null,
    tm_saldo_disponible money   null,
    tm_saldo_lib    money   null,
    tm_saldo_interes    money   null,
    tm_interes  money   null,
    tm_fecha1   datetime    null,
    tm_fecha2   datetime    null,
    tm_fecha3   datetime    null,
    tm_fecha4   datetime    null,
    tm_fecha5   datetime    null,
    tm_campo1   varchar(64) null,
    tm_campo2   varchar(64) null,
    tm_campo3   varchar(32) null,
    tm_campo4   varchar(32) null,
    tm_campo5   varchar(32) null,
    tm_campo6   varchar(255)    null,
    tm_monto1   money   null,
    tm_monto2   money   null,
    tm_monto3   money   null,
    tm_monto4   money   null,
    tm_monto5   money   null,
    tm_monto6   money   null,
    tm_monto7   money   null,
    tm_monto8   money   null,
    tm_monto9   money   null,
    tm_monto10  money   null,
    tm_tasa1    money   null,
    tm_tasa2    money   null,
    tm_tasa3    money   null,
    tm_tasa4    money   null,
    tm_int1 int null,
    tm_int2 int null,
    tm_int3 int null,
    tm_int4 int null,
    tm_int5 int null,
    tm_rol  smallint    not null,
    tm_tsn  int null,
    tm_detalle_pdp  char(1) null,
    tm_diferido char(1) null,
    tm_canal    tinyint not null,
    tm_idcierre int not null
)
go

/* re_tran_monet_tmp_atm */
print 'TABLA ====> re_tran_monet_tmp_atm'
go
CREATE TABLE re_tran_monet_tmp_atm (
    tm_fecha    datetime    not null,
    tm_hora datetime    not null,
    tm_filial   tinyint not null,
    tm_producto tinyint not null,
    tm_cta_banco    char(24)    null,
    tm_srv_local    varchar(16) null,
    tm_srv_host varchar(16) null,
    tm_ssn_local    int not null,
    tm_ssn_local_alterno    int not null,
    tm_ssn_host int null,
    tm_oficina  smallint    not null,
    tm_usuario  varchar(16) not null,
    tm_terminal varchar(32) null,
    tm_correccion   char(1) not null,
    tm_estado_correccion    char(1) null,
    tm_ssn_local_correccion int null,
    tm_tipo_ejecucion   varchar(3)  null,
    tm_estado_ejecucion varchar(3)  null,
    tm_clave_reentry    int null,
    tm_autorizada   char(1) null,
    tm_login_aut    varchar(32) null,
    tm_tipo_tran    int not null,
    tm_moneda   tinyint null,
    tm_signo    char(1) null,
    tm_indicador    tinyint null,
    tm_causa    varchar(3)  null,
    tm_departamento smallint    null,
    tm_oficina_cta  smallint    null,
    tm_prod_bancario_cta    smallint    null,
    tm_cta_banco_d  char(24)    null,
    tm_producto_d   tinyint null,
    tm_tipo_transf  char(4) null,
    tm_banco    smallint    null,
    tm_cheque   int null,
    tm_control  int null,
    tm_tarjeta_atm  varchar(32) null,
    tm_concepto varchar(128)    null,
    tm_valor    money   null,
    tm_efectivo money   null,
    tm_chq_propios  money   null,
    tm_chq_locales  money   null,
    tm_chq_ot_plazas    money   null,
    tm_saldo_contable   money   null,
    tm_saldo_disponible money   null,
    tm_saldo_lib    money   null,
    tm_saldo_interes    money   null,
    tm_interes  money   null,
    tm_fecha1   datetime    null,
    tm_fecha2   datetime    null,
    tm_fecha3   datetime    null,
    tm_fecha4   datetime    null,
    tm_fecha5   datetime    null,
    tm_campo1   varchar(64) null,
    tm_campo2   varchar(64) null,
    tm_campo3   varchar(32) null,
    tm_campo4   varchar(32) null,
    tm_campo5   varchar(32) null,
    tm_campo6   varchar(255)    null,
    tm_monto1   money   null,
    tm_monto2   money   null,
    tm_monto3   money   null,
    tm_monto4   money   null,
    tm_monto5   money   null,
    tm_monto6   money   null,
    tm_monto7   money   null,
    tm_monto8   money   null,
    tm_monto9   money   null,
    tm_monto10  money   null,
    tm_tasa1    money   null,
    tm_tasa2    money   null,
    tm_tasa3    money   null,
    tm_tasa4    money   null,
    tm_int1 int null,
    tm_int2 int null,
    tm_int3 int null,
    tm_int4 int null,
    tm_int5 int null,
    tm_rol  smallint    not null,
    tm_tsn  int null,
    tm_detalle_pdp  char(1) null,
    tm_diferido char(1) null,
    tm_canal    tinyint not null,
    tm_idcierre int not null
)
go

/* re_tran_punto */
print 'TABLA ====> re_tran_punto'
go
CREATE TABLE re_tran_punto (
    tp_fecha    datetime    not null,
    tp_trn  smallint    not null,
    tp_cta_banco    varchar(24) not null,
    tp_producto tinyint not null,
    tp_prod_banc    smallint    not null,
    tp_puntos   int not null
)
go

/* re_tran_servicio */
print 'TABLA ====> re_tran_servicio'
go
CREATE TABLE re_tran_servicio (
    ts_secuencial   int null,
    ts_tipo_transaccion int null,
    ts_clase    char(1) null,
    ts_tsfecha  datetime    null,
    ts_operador varchar(64) null,
    ts_terminal varchar(64) null,
    ts_origen   char(1) null,
    ts_nodo varchar(30) null,
    ts_oficina  smallint    null,
    ts_char1    char(1) null,
    ts_char2    char(1) null,
    ts_char3    char(1) null,
    ts_char4    char(1) null,
    ts_char5    char(3) null,
    ts_char6    char(1) null,
    ts_char7    char(1) null,
    ts_char8    char(3) null,
    ts_char9    char(3) null,
    ts_varchar1 varchar(8)  null,
    ts_varchar2 varchar(16) null,
    ts_varchar3 varchar(32) null,
    ts_varchar4 varchar(16) null,
    ts_varchar5 varchar(24) null,
    ts_varchar6 varchar(32) null,
    ts_varchar7 varchar(255)    null,
    ts_varchar8 varchar(16) null,
    ts_varchar9 varchar(16) null,
    ts_descripcion1 varchar(64) null,
    ts_descripcion2 varchar(64) null,
    ts_tinyint1 tinyint null,
    ts_tinyint2 tinyint null,
    ts_tinyint3 tinyint null,
    ts_tinyint4 tinyint null,
    ts_tinyint5 tinyint null,
    ts_smallint1    smallint    null,
    ts_smallint2    smallint    null,
    ts_smallint3    smallint    null,
    ts_smallint4    smallint    null,
    ts_smallint5    smallint    null,
    ts_smallint6    smallint    null,
    ts_int1 int null,
    ts_int2 int null,
    ts_int3 int null,
    ts_int4 int null,
    ts_int5 int null,
    ts_int6 int null,
    ts_int7 int null,
    ts_money1   money   null,
    ts_money2   money   null,
    ts_money3   money   null,
    ts_money4   money   null,
    ts_money5   money   null,
    ts_cuenta1  varchar(24) null,
    ts_cuenta2  varchar(24) null,
    ts_datetime1    datetime    null,
    ts_datetime2    datetime    null,
    ts_datetime3    datetime    null,
    ts_datetime4    datetime    null,
    ts_datetime5    datetime    null,
    ts_datetime6    datetime    null,
    ts_datetime7    datetime    null,
    ts_datetime8    datetime    null,
    ts_datetime9    datetime    null,
    ts_login    varchar(14) null,
    ts_login1   varchar(14) null
)
go

/* re_trans_alerta */
print 'TABLA ====> re_trans_alerta'
go
CREATE TABLE re_trans_alerta (
    ta_transaccion  smallint    not null,
    ta_fecha_cre    datetime    not null,
    ta_fecha_mod    datetime    null,
    ta_alerta   char(1) not null,
    ta_oficina  smallint    not null,
    ta_usuario  varchar(14) not null,
    ta_estado   char(1) not null
)
go

/* re_transfer_automatica */
print 'TABLA ====> re_transfer_automatica'
go
CREATE TABLE re_transfer_automatica (
    ta_tipo char(10)    not null,
    ta_cuenta_dst   char(16)    not null,
    ta_producto_dst varchar(3)  not null,
    ta_nombre_dst   varchar(64) not null,
    ta_contrato int null,
    ta_cuenta_org   char(16)    not null,
    ta_producto_org varchar(3)  not null,
    ta_nombre_org   varchar(64) not null,
    ta_periodicidad char(1) not null,
    ta_dia  tinyint not null,
    ta_monto    money   not null,
    ta_fecha_desde  datetime    not null,
    ta_fecha_hasta  datetime    not null,
    ta_fecha_ult_cobro  datetime    not null,
    ta_moneda   tinyint not null,
    ta_fecha_prox_cobro datetime    not null,
    ta_total_debitado   money   not null,
    ta_error    int not null,
    ta_fecha_proyectada datetime    null,
    ta_codigo   int null
)
go

/* re_transito */
print 'TABLA ====> re_transito'
go
CREATE TABLE re_transito (
    tn_nombre   smallint    not null,
    tn_banco_p  tinyint not null,
    tn_oficina_p    smallint    not null,
    tn_ciudad_p int not null,
    tn_banco_c  tinyint null,
    tn_oficina_c    smallint    null,
    tn_ciudad_c int null,
    tn_num_dias tinyint not null,
    tn_secuencial   int not null,
    tn_causa_contab varchar(3)  not null
)
go

/* re_traslado */
print 'TABLA ====> re_traslado'
go
CREATE TABLE re_traslado (
    tr_secuencial   int not null,
    tr_cta_banco    varchar(24) null,
    tr_fecha_tras   datetime    not null,
    tr_oficina_ori  smallint    null,
    tr_oficina_des  smallint    not null,
    tr_producto tinyint null,
    tr_moneda   tinyint null,
    tr_usuario  varchar(15) not null,
    tr_fecha    datetime    not null,
    tr_oficina_tra  smallint    not null,
    tr_estado   char(1) not null,
    tr_tipo char(1) not null,
    tr_terminal varchar(20) not null
)
go

/* re_trn_causa_atm */
print 'TABLA ====> re_trn_causa_atm'
go
CREATE TABLE re_trn_causa_atm (
    tc_red  varchar(16) not null,
    tc_trn_atm  int not null,
    tc_correccion   char(1) not null,
    tc_signo    char(1) not null,
    tc_producto tinyint null,
    tc_trn  int not null,
    tc_causa    varchar(3)  not null,
    tc_causa_com    varchar(3)  not null,
    tc_causa_com_pnd    varchar(3)  null,
    tc_causa_rty    varchar(3)  not null,
    tc_causa_com_rty    varchar(3)  not null,
    tc_trn_com  int null
)
go

/* re_trn_causa_bvirtual */
print 'TABLA ====> re_trn_causa_bvirtual'
go
CREATE TABLE re_trn_causa_bvirtual (
    cb_servicio tinyint not null,
    cb_trn_bv   int not null,
    cb_signo    char(1) not null,
    cb_prod tinyint not null,
    cb_trn  int not null,
    cb_causa    varchar(3)  not null,
    cb_causa_com    varchar(3)  null,
    cb_causa_com_pnd    varchar(3)  null,
    cb_causa_rty    varchar(3)  null,
    cb_causa_com_rty    varchar(3)  null
)
go

/* re_trn_contable */
print 'TABLA ====> re_trn_contable'
go
CREATE TABLE re_trn_contable (
    tc_secuencial   int not null identity,
    tc_producto tinyint not null,
    tc_moneda   tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa    varchar(5)  null,
    tc_ofic_orig    smallint    not null,
    tc_ofic_dest    smallint    not null,
    tc_perfil   varchar(10) not null,
    tc_concepto varchar(10) not null,
    tc_valor    money   not null,
    tc_valor_me money   not null,
    tc_numtran  int not null,
    tc_tipo char(1) not null,
    tc_prod_banc    tinyint not null,
    tc_clase_clte   char(1) not null,
    tc_tipo_cta varchar(3)  null,
    tc_cliente  int null,
    tc_base money   null,
    tc_tipo_impuesto    varchar(1)  null,
    tc_concepto_imp varchar(10) null,
    tc_referencia   varchar(15) null,
    tc_fecha    datetime    null,
    tc_estcta   char(1) null,
    tc_estado   char(3) null,
    tc_comprobante  int null,
    tc_mensaje  varchar(120)    null,
    tc_cuenta1  varchar(24) null,
    tc_cuenta2  varchar(24) null,
    tc_hora datetime    null
)
go

/* re_trn_contable_inc */
print 'TABLA ====> re_trn_contable_inc'
go
CREATE TABLE re_trn_contable_inc (
    tc_secuencial   int not null,
    tc_producto tinyint not null,
    tc_moneda   tinyint not null,
    tc_tipo_tran    smallint    not null,
    tc_causa    varchar(5)  null,
    tc_ofic_orig    smallint    not null,
    tc_ofic_dest    smallint    not null,
    tc_perfil   varchar(10) not null,
    tc_concepto varchar(10) not null,
    tc_valor    money   not null,
    tc_valor_me money   not null,
    tc_numtran  int not null,
    tc_tipo char(1) not null,
    tc_prod_banc    tinyint not null,
    tc_clase_clte   char(1) not null,
    tc_tipo_cta varchar(3)  null,
    tc_cliente  int null,
    tc_base money   null,
    tc_tipo_impuesto    varchar(1)  null,
    tc_concepto_imp varchar(10) null,
    tc_referencia   varchar(15) null,
    tc_fecha    datetime    null,
    tc_estcta   char(1) null,
    tc_estado   char(3) null,
    tc_comprobante  int null,
    tc_mensaje  varchar(120)    null,
    tc_cuenta1  varchar(24) null,
    tc_cuenta2  varchar(24) null,
    tc_hora datetime    null
)
go

/* re_trn_grupo */
print 'TABLA ====> re_trn_grupo'
go
CREATE TABLE re_trn_grupo (
    tg_nivel    tinyint not null,
    tg_grupo    tinyint not null,
    tg_transaccion  smallint    not null,
    tg_afecta_efectivo  char(1) not null,
    tg_afecta_signo char(1) not null,
    tg_indicador    tinyint not null,
    tg_tabla_catalogo   varchar(30) null
)
go

/* re_trn_perfil */
print 'TABLA ====> re_trn_perfil'
go
CREATE TABLE re_trn_perfil (
    tp_secuencial   smallint    not null,
    tp_producto tinyint not null,
    tp_tipo_tran    smallint    not null,
    tp_perfil   varchar(10) not null,
    tp_tipo varchar(10) not null
)
go

/* re_valida_datos_offline */
print 'TABLA ====> re_valida_datos_offline'
go
CREATE TABLE re_valida_datos_offline (
    vd_idvalidacion int not null,
    vd_oficina_sol  smallint    not null,
    vd_func_sol varchar(14) not null,
    vd_producto tinyint null,
    vd_cuenta   varchar(24) null,
    vd_idcliente_sol    varchar(30) null,
    vd_rol_clte_sol char(1) null,
    vd_fecha_sol    datetime    null,
    vd_hora_sol datetime    null,
    vd_estado_fun   char(1) null,
    vd_mensaje_fun  varchar(60) null,
    vd_estado_clte  char(1) null,
    vd_mensaje_clte varchar(60) null
)
go

/* re_validacion_monto */
print 'TABLA ====> re_validacion_monto'
go
CREATE TABLE re_validacion_monto (
    va_transaccion  int not null,
    va_tipo char(3) not null,
    va_maximo   money   null,
    va_minimo   money   null,
    va_moneda   tinyint not null,
    va_online   char(1) not null
)
go

/* reexpresion_saldo */
print 'TABLA ====> reexpresion_saldo'
go
CREATE TABLE reexpresion_saldo (
    sa_oficina  smallint    null,
    sa_area smallint    null,
    sa_saldo    money   null,
    sa_saldo_me money   null
)
go

/* saldo */
print 'TABLA ====> saldo'
go
CREATE TABLE saldo (
    empresa tinyint null,
    cuenta  char(20)    null,
    oficina smallint    null,
    area    smallint    null,
    corte   int null,
    periodo int null,
    saldo   money   null,
    saldo_me    money   null,
    debito  money   null,
    credito money   null,
    debito_me   money   null,
    credito_me  money   null
)
go

/* saldo_pago_declar_ret_tmp */
print 'TABLA ====> saldo_pago_declar_ret_tmp'
go
CREATE TABLE saldo_pago_declar_ret_tmp (
    ts_corte    smallint    null,
    ts_periodo  smallint    null,
    ts_oficina_pag  smallint    null,
    ts_area smallint    null,
    ts_cuenta   char(14)    null,
    ts_empresa  tinyint null,
    ts_saldo    money   null,
    ts_saldo_me money   null,
    ts_cod_declar   smallint    null,
    ts_ente int null,
    ts_tip_reg  char(1) null
)
go

/* saldoiva */
print 'TABLA ====> saldoiva'
go
CREATE TABLE saldoiva (
    Cuenta  varchar(30) null,
    Nombre  varchar(30) null,
    Mes1    money   null,
    Mes2    money   null,
    Bimestre    money   null,
    SAndres money   null,
    SProvidencia    money   null,
    SLeticia    money   null,
    Movimiento  varchar(2)  null,
    Producto    int null,
    Desproducto varchar(30) null
)
go

/* saldos_aux */
print 'TABLA ====> saldos_aux'
go
CREATE TABLE saldos_aux (
    corte   smallint    not null,
    periodo smallint    not null,
    oficina_ini smallint    not null,
    oficina_fin smallint    not null
)
go

/* salter_def */
print 'TABLA ====> salter_def'
go
CREATE TABLE salter_def (
    st_empresa  tinyint not null,
    st_saldo    money   not null,
    st_saldo_me money   not null,
    st_mov_debito   money   not null,
    st_mov_credito  money   not null,
    st_mov_debito_me    money   not null,
    st_mov_credito_me   money   not null,
    st_oficina  smallint    not null,
    st_area smallint    not null,
    st_ente int not null,
    st_cuenta   char(25)    not null,
    st_estado   char(1) not null
)
go

/* sysdiagrams */
print 'TABLA ====> sysdiagrams'
go
CREATE TABLE sysdiagrams (
    name    nvarchar    not null,
    principal_id    int not null,
    diagram_id  int not null,
    version int null,
    definition  varbinary   null
)
go

/* t_reexp */
print 'TABLA ====> t_reexp'
go
CREATE TABLE t_reexp (
    empresa tinyint null,
    periodo int null,
    corte   int null
)
go

/* temporal_cb_asiento */
print 'TABLA ====> temporal_cb_asiento'
go
CREATE TABLE temporal_cb_asiento (
    as_fecha_tran   datetime    not null,
    as_comprobante  int not null,
    as_empresa  tinyint not null,
    as_asiento  int not null,
    as_cuenta   char(14)    not null,
    as_oficina_dest smallint    not null,
    as_area_dest    smallint    not null,
    as_credito  money   null,
    as_debito   money   null,
    as_concepto varchar(64) null,
    as_credito_me   money   null,
    as_debito_me    money   null,
    as_cotizacion   money   null,
    as_mayorizado   char(1) not null,
    as_tipo_doc char(1) not null,
    as_tipo_tran    char(1) not null,
    as_moneda   tinyint null,
    as_opcion   tinyint null,
    as_fecha_est    datetime    null,
    as_detalle  smallint    null,
    as_consolidado  char(1) null,
    as_oficina_orig smallint    not null
)
go

/* tmp_cb_hist_saldo */
print 'TABLA ====> tmp_cb_hist_saldo'
go
CREATE TABLE tmp_cb_hist_saldo (
    th_empresa  tinyint null,
    th_cuenta   varchar(24) null,
    th_oficina  smallint    null,
    th_nombre   varchar(80) null,
    th_prom_act money   null,
    th_prom_ant money   null,
    th_var_abs  money   null,
    th_var_rel  money   null
)
go

/* tmp_cb_hist_saldo2 */
print 'TABLA ====> tmp_cb_hist_saldo2'
go
CREATE TABLE tmp_cb_hist_saldo2 (
    ta_empresa  tinyint null,
    ta_cuenta   varchar(24) null,
    ta_oficina  smallint    null,
    ta_prom_ant money   null
)
go

/* tmp_cb_saldo_promm */
print 'TABLA ====> tmp_cb_saldo_promm'
go
CREATE TABLE tmp_cb_saldo_promm (
    sp_empresa  tinyint null,
    sp_cuenta   varchar(24) null,
    sp_oficina  smallint    null,
    sp_nombre   varchar(80) null,
    sp_corte_ini    int null,
    sp_corte_fin    int null,
    sp_saldo_prom   money   null,
    sp_saldo_prom_me    money   null
)
go

/* tmp_cb_saldo_ter */
print 'TABLA ====> tmp_cb_saldo_ter'
go
CREATE TABLE tmp_cb_saldo_ter (
    ts_empresa  int null,
    ts_cuenta   varchar(24) null,
    ts_oficina  smallint    not null,
    ts_ente int null,
    ts_nombre   varchar(80) null,
    ts_tipo char(2) null,
    ts_ced_ruc  varchar(20) null,
    ts_sal_ant_mn   money   null,
    ts_debito_ant_mn    money   null,
    ts_credito_ant_mn   money   null,
    ts_sal_act_mn   money   null,
    ts_sal_ant_me   money   null,
    ts_debito_ant_me    money   null,
    ts_credito_ant_me   money   null,
    ts_sal_act_me   money   null
)
go

/* tmp_cb_saldo_ter2 */
print 'TABLA ====> tmp_cb_saldo_ter2'
go
CREATE TABLE tmp_cb_saldo_ter2 (
    tt_empresa  int null,
    tt_cuenta   varchar(24) null,
    tt_oficina  smallint    not null,
    tt_ente int null,
    tt_sal  money   null,
    tt_debito_mn    money   null,
    tt_credito_mn   money   null,
    tt_sal_me   money   null,
    tt_debito__me   money   null,
    tt_credito__me  money   null
)
go

/* tmp_comp_asientos */
print 'TABLA ====> tmp_comp_asientos'
go
CREATE TABLE tmp_comp_asientos (
    sa_cuenta   char(14)    not null,
    sa_ente int null,
    sa_producto tinyint null,
    sa_debito   money   null,
    sa_credito  money   null,
    sa_oficina_dest smallint    null,
    sa_empresa  tinyint null,
    sc_perfil   varchar(20) null,
    sc_comp_origen  int null,
    sc_comprobante  int null,
    sc_comp_definit int null,
    sc_oficina_orig smallint    null,
    sc_reversado    char(1) null,
    sa_concepto varchar(64) null,
    sc_descripcion  varchar(64) null,
    sa_fecha_tran   datetime    null,
    cu_nombre   varchar(255)    null,
    en_ced_ruc  varchar(30) null,
    en_nomlar   varchar(255)    null,
    en_tipo_ced char(2) null
)
go

/* tmp_cuentas */
print 'TABLA ====> tmp_cuentas'
go
CREATE TABLE tmp_cuentas (
    cuenta  varchar(24) null
)
go

/* tmp_cuentas_re */
print 'TABLA ====> tmp_cuentas_re'
go
CREATE TABLE tmp_cuentas_re (
    cuenta_re   varchar(24) null
)
go

/* tmp_limites_caja */
print 'TABLA ====> tmp_limites_caja'
go
CREATE TABLE tmp_limites_caja (
    lc_nom_ofi  varchar(64) null,
    lc_oficina  smallint    null,
    lc_tipo char(1) null,
    lc_monto_min    money   null,
    lc_monto_max    money   null,
    lc_control  char(1) null,
    lc_observaciones    varchar(64) null
)
go

/* tmp_paralelo */
print 'TABLA ====> tmp_paralelo'
go
CREATE TABLE tmp_paralelo (
    tp_proceso  smallint    not null,
    tp_tabla    varchar(64) not null,
    tp_sentencia    varchar(255)    not null
)
go

/* tmp_re_tesoro_nacional */
print 'TABLA ====> tmp_re_tesoro_nacional'
go
CREATE TABLE tmp_re_tesoro_nacional (
    tn_cuenta   varchar(24) not null,
    tn_ced_ruc  char(13)    not null,
    tn_tipo_cta tinyint not null,
    tn_grupo    char(2) not null,
    tn_saldo_inicial    money   not null,
    tn_remuneracion money   not null,
    tn_fecha    datetime    not null,
    tn_estado   char(1) not null,
    tn_valor_rv money   null,
    tn_fecha_r_saldo    smalldatetime   null,
    tn_oficina_r    smallint    null,
    tn_fecha_act    smalldatetime   null,
    tn_forma_pg char(10)    null,
    tn_nombre_rt    varchar(30) null,
    tn_autorizante  varchar(14) null,
    tn_usuario_pg   varchar(14) null,
    tn_oficina  smallint    null,
    tn_identificacion_rt    varchar(13) null,
    tn_causa    varchar(3)  null,
    tn_secuencial   int null,
    tn_fecha_proceso    smalldatetime   null,
    tn_interes_re   money   null,
    tn_fecha_envio  datetime    null
)
go

/* tmp_saldo_traslado */
print 'TABLA ====> tmp_saldo_traslado'
go
CREATE TABLE tmp_saldo_traslado (
    ts_corte    int not null,
    ts_periodo  int not null,
    ts_oficina_pag  smallint    not null,
    ts_oficina_aso  smallint    not null,
    ts_area smallint    not null,
    ts_cuenta   char(14)    null,
    ts_empresa  tinyint not null,
    ts_saldo    money   not null,
    ts_saldo_me money   not null,
    ts_saldo_ant    money   not null,
    ts_saldo_ant_me money   not null,
    ts_cod_declar   char(2) not null,
    ts_ente int null
)
go

/* tmp_sasiento */
print 'TABLA ====> tmp_sasiento'
go
CREATE TABLE tmp_sasiento (
    sa_fecha_tran   datetime    null,
    sa_producto tinyint null,
    sa_comprobante  int null,
    sa_asiento  int null,
    sa_cuenta   varchar(20) null,
    sa_debito   money   null,
    sa_credito  money   null,
    sa_debito_me    money   null,
    sa_credito_me   money   null,
    sa_con_rete char(4) null,
    sa_con_iva  char(4) null,
    sa_con_ica  char(4) null,
    sa_con_timbre   char(4) null,
    sa_con_ivapagado    char(4) null,
    sa_base money   null,
    spid    int null,
    fecha   smalldatetime   null
)
go

/* tmp_siento_comp */
print 'TABLA ====> tmp_siento_comp'
go
CREATE TABLE tmp_siento_comp (
    sa_fecha_tran   datetime    null,
    sc_comp_definit int null,
    sa_asiento  int null,
    sa_cuenta   varchar(20) null,
    sa_debito   money   null,
    sa_credito  money   null,
    sa_debito_me    money   null,
    sa_credito_me   money   null,
    sa_con_rete char(4) null,
    sa_con_iva  char(4) null,
    sa_con_ica  char(4) null,
    sa_con_timbre   char(4) null,
    sa_con_ivapagado    char(4) null,
    sa_base money   null,
    sc_digitador    varchar(255)    null,
    sa_producto tinyint null,
    sa_comprobante  int null,
    sc_automatico   int null,
    sc_fecha_gra    datetime    null,
    spid    int null,
    indice  numeric null,
    fecha   smalldatetime   null
)
go

/* tmp_tran_ter */
print 'TABLA ====> tmp_tran_ter'
go
CREATE TABLE tmp_tran_ter (
    sa_fecha_tran   datetime    null,
    sc_comp_definit int null,
    sa_asiento  int null,
    sa_cuenta   varchar(20) null,
    sa_debito   money   null,
    sa_credito  money   null,
    sa_debito_me    money   null,
    sa_credito_me   money   null,
    sa_con_rete char(4) null,
    sa_con_iva  char(4) null,
    sa_con_ica  char(4) null,
    sa_con_timbre   char(4) null,
    sa_con_ivapagado    char(4) null,
    sa_base money   null,
    sc_digitador    varchar(255)    null,
    sa_producto tinyint null,
    sa_comprobante  int null,
    sc_automatico   int null,
    sc_fecha_gra    datetime    null,
    spid    int null,
    indice  numeric not null
)
go

/* tmp_trn_mes_bk */
print 'TABLA ====> tmp_trn_mes_bk'
go
CREATE TABLE tmp_trn_mes_bk (
    Fecha   varchar(10) null,
    Oficina varchar(30) null,
    Transaccion varchar(50) null,
    Causa   varchar(50) null,
    Cantidad    varchar(50) null,
    Efectivo    varchar(50) null,
    Cheque  varchar(50) null,
    Usuario varchar(14) null
)
go

/* total_res_ah */
print 'TABLA ====> total_res_ah'
go
CREATE TABLE total_res_ah (
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null
)
go

/* total_res_ahmon */
print 'TABLA ====> total_res_ahmon'
go
CREATE TABLE total_res_ahmon (
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null
)
go

/* total_res_ahterc */
print 'TABLA ====> total_res_ahterc'
go
CREATE TABLE total_res_ahterc (
    lr_producto smallint    not null,
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null,
    lr_cliente  int null,
    lr_base money   null,
    lr_tipo_imp char(1) null
)
go

/* total_res_cc */
print 'TABLA ====> total_res_cc'
go
CREATE TABLE total_res_cc (
    lr_fecha    datetime    not null,
    lr_producto smallint    not null,
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null,
    lr_garantia varchar(2)  null,
    lr_dias_sobregiro   char(3) null,
    lr_tipo_cta char(1) null,
    lr_referencia   varchar(15) null
)
go

/* total_res_cc_te */
print 'TABLA ====> total_res_cc_te'
go
CREATE TABLE total_res_cc_te (
    lr_producto smallint    not null,
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null,
    lr_garantia varchar(2)  null,
    lr_dias_sobregiro   char(3) null,
    lr_tipo_cta char(1) null,
    lr_cliente  int null,
    lr_calificacion char(1) null,
    lr_fecha    datetime    null,
    lr_producto1    char(3) null,
    lr_fondos   char(1) null,
    lr_tipo_embargo char(1) null,
    lr_base money   null,
    lr_tipo_imp char(1) null
)
go

/* total_res_moncc */
print 'TABLA ====> total_res_moncc'
go
CREATE TABLE total_res_moncc (
    lr_moneda   tinyint not null,
    lr_tipo_tran    smallint    not null,
    lr_causa    varchar(5)  not null,
    lr_ofic_orig    smallint    not null,
    lr_ofic_dest    smallint    not null,
    lr_valor    money   not null,
    lr_perfil   varchar(10) not null,
    lr_valor_me money   not null,
    lr_numtran  int not null,
    lr_estado   char(1) not null,
    lr_prod_banc    smallint    not null,
    lr_tipo_persona varchar(2)  not null,
    lr_causa_org    varchar(5)  not null
)
go

/* ts_regimen_fiscal */
print 'TABLA ====> ts_regimen_fiscal'
go
CREATE TABLE ts_regimen_fiscal (
    ts_secuencial   int not null,
    ts_transaccion  smallint    not null,
    ts_clase_tran   char(1) not null,
    ts_fecha    datetime    not null,
    ts_usuario  varchar(14) not null,
    ts_terminal varchar(64) not null,
    ts_oficina  smallint    not null,
    ts_empresa  tinyint null,
    ts_codigo   varchar(10) not null,
    ts_descripcion  varchar(64) not null,
    ts_iva  char(1) not null,
    ts_timbre   char(1) not null,
    ts_renta    char(1) not null,
    ts_ica  char(1) not null,
    ts_iva_des  char(1) not null,
    ts_iva_cobrado  char(1) not null,
    ts_estampillas  char(1) not null,
    ts_3xm  char(1) not null,
    ts_estado   char(1) not null,
    ts_retencion_iva    char(1) not null,
    ts_naturaleza   char(1) not null,
    ts_grancontribuyente    char(1) not null,
    ts_autorretenedor   char(1) not null
)
go

/* ts_tran_serv_pag_decl */
print 'TABLA ====> ts_tran_serv_pag_decl'
go
CREATE TABLE ts_tran_serv_pag_decl (
    ts_secuencial   int not null,
    ts_tipo_tran    int not null,
    ts_clase    char(1) not null,
    ts_fecha    datetime    not null,
    ts_usuario  varchar(14) null,
    ts_terminal varchar(64) null,
    ts_empresa  tinyint not null,
    ts_oficina_tran smallint    not null,
    ts_oficina  smallint    not null,
    ts_cod_declaracion  char(2) null,
    ts_fecha_orden  datetime    null,
    ts_fecha_corte  datetime    null,
    ts_ente int null
)
go

/* re_cuenta_contractual */
print 'TABLA ====> re_cuenta_contractual'
go

CREATE TABLE re_cuenta_contractual
	(
	cc_modulo          TINYINT NOT NULL,
	cc_profinal        TINYINT NOT NULL,
	cc_cta_banco       VARCHAR (24) NOT NULL,
	cc_plazo           TINYINT NOT NULL,
	cc_cuota           MONEY NOT NULL,
	cc_periodicidad    VARCHAR (10) NOT NULL,
	cc_monto_final     MONEY NULL,
	cc_intereses       MONEY NULL,
	cc_ptos_premio     FLOAT NULL,
	cc_estado          CHAR (1) NOT NULL,
	cc_categoria       CHAR (1) NOT NULL,
	cc_fecha_crea      DATETIME NULL,
	cc_periodos_incump TINYINT NULL,
	cc_prodbanc        TINYINT NULL
	)
GO

/* re_detalle_cheque */
print 'TABLA ====> re_detalle_cheque'
go
create table re_detalle_cheque
       (dc_filial       tinyint      not null,
        dc_oficina      smallint     not null,
        dc_fecha        date         not null,
        dc_fecha_efe    date         null,
        dc_id           smallint     null,
        dc_trn          smallint     null,
        dc_numctrl      int          null,
        dc_secuencial   smallint     not null,
        dc_ssn          int          null,
        dc_ssn_branch   int          null,
        dc_cta_banco    cuenta       null,
        dc_producto     tinyint      null,
        dc_tipo         catalogo     null,
        dc_tipo_chq     catalogo     null,
        dc_co_banco     smallint     null,
        dc_no_banco     varchar(50)  null,
        dc_cta_cheque   varchar(50)  null,
        dc_num_cheque   int          null,
        dc_valor        money        null,
        dc_moneda       tinyint      null,
        dc_fechaemision date         null,
        dc_estado       char(1)      null,
        dc_user         login        null,
        dc_hora         datetime     null,
		dc_detalle      varchar(128) null,		
		dc_factor           float    null,
        dc_cotizacion       float    null,
        dc_valor_convertido   money  null,
        dc_mon_destino      tinyint  null
		
		)
go
