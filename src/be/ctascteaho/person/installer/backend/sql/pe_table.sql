
/* SQL Environment is SQLSERVER      */
/* Environment - Retain case         */
/* Environment - Do not prefix names */
/* Environment - LoadUserDefs        */

use cob_remesas
go

/* pe_basico */
print 'TABLA ====> pe_basico'
go
CREATE TABLE pe_basico (
    ba_mercado  smallint    not null,
    ba_servicio smallint    not null,
    ba_estado   char(1) not null
)
go

/* pe_cambio_costo */
print 'TABLA ====> pe_cambio_costo'
go
CREATE TABLE pe_cambio_costo (
    cc_secuencial                   int not null,
    cc_servicio_per                 smallint    null,
    cc_categoria                    varchar(10) null,
    cc_tipo_rango                   tinyint null,
    cc_grupo_rango                  smallint    null,
    cc_rango                        tinyint null,
    cc_operacion                    char(1) null,
    cc_tipo                         char(1) null,
    cc_val_medio                    real    null,
    cc_minimo                       real    null,
    cc_maximo                       real    null,
    cc_fecha_cambio                 smalldatetime   not null,
    cc_fecha_vigencia               smalldatetime   null,
    cc_en_linea                     char(1) null,
    cc_confirmado                   char(1) null
)
go

/* pe_cambio_val_contr */
print 'TABLA ====> pe_cambio_val_contr'
go
CREATE TABLE pe_cambio_val_contr (
    vv_secuencial       int not null,
    vv_tipo_default     char(1) null,
    vv_rol              char(1) null,
    vv_codigo           int null,
    vv_producto         tinyint null,
    vv_servicio_per     smallint    null,
    vv_categoria        varchar(10) null,
    vv_operacion        char(1) null,
    vv_tipo             char(1) null,
    vv_valor_con        float   null,
    vv_tipo_variacion   char(1) null,
    vv_signo            char(1) null,
    vv_fecha_cambio     datetime    null,
    vv_fecha_apli       datetime    null
)
go

/* pe_capitaliza_profinal */
print 'TABLA ====> pe_capitaliza_profinal'
go
CREATE TABLE pe_capitaliza_profinal (
    cp_profinal             smallint    not null,
    cp_tipo_capitalizacion  char(1) not null,
    cp_tipo_rango           tinyint not null
)
go

/* pe_categoria_profinal */
print 'TABLA ====> pe_categoria_profinal'
go
CREATE TABLE pe_categoria_profinal (
    cp_profinal     smallint    null,
    cp_categoria    char(3) null,
    cp_posteo       char(1) null,
    cp_contractual  char(1) null,
	cp_dias_plazo   int     null 
)
go

/* pe_ciclo_profinal */
print 'TABLA ====> pe_ciclo_profinal'
go
CREATE TABLE pe_ciclo_profinal (
    cp_profinal smallint    not null,
    cp_ciclo    char(1) not null
)
go

/* pe_costo */
print 'TABLA ====> pe_costo'
go
CREATE TABLE pe_costo (
    co_secuencial       int not null,
    co_servicio_per     smallint    not null,
    co_categoria        varchar(10) not null,
    co_tipo_rango       tinyint not null,
    co_grupo_rango      smallint    not null,
    co_rango            tinyint not null,
    co_val_medio        real    not null,
    co_minimo           real    not null,
    co_maximo           real    not null,
    co_fecha_vigencia   smalldatetime   not null,
    co_usuario          varchar(20) null
)
go

/* pe_equiv_serv_trn */
print 'TABLA ====> pe_equiv_serv_trn'
go
CREATE TABLE pe_equiv_serv_trn (
    st_servicio smallint    not null,
    st_rubro    char(5) not null,
    st_trn      smallint    not null,
    st_causal   char(5) not null
)
go

/* pe_limite */
print 'TABLA ====> pe_limite'
go
CREATE TABLE pe_limite (
    li_servicio_per int not null,
    li_categoria    varchar(10) not null,
    li_minimo       real    not null,
    li_maximo       real    not null
)
go

/* pe_mercado */
print 'TABLA ====> pe_mercado'
go
CREATE TABLE pe_mercado (
    me_pro_bancario smallint    not null,
    me_tipo_ente    varchar(10) not null,
    me_mercado      smallint    not null,
    me_estado       char(1) not null,
    me_fecha_estado smalldatetime   not null
)
go

/* pe_oficina_autorizada */
print 'TABLA ====> pe_oficina_autorizada'
go
CREATE TABLE pe_oficina_autorizada (
    oa_producto     tinyint not null,
    oa_prod_banc    smallint    not null,
    oa_oficina      smallint    not null,
    oa_estado       char(1) not null,
    oa_fecha_crea   datetime    not null,
    oa_fecha_modi   datetime    not null,
    oa_fecha_inicio datetime    not null
)
--VERSION BASE
--create nonclustered index idx_oa_oficina on pe_oficina_autorizada(oa_oficina)
go

/* pe_par_comision */
print 'TABLA ====> pe_par_comision'
go
CREATE TABLE pe_par_comision (
    pc_profinal smallint    not null,
    pc_categoria    varchar(3)  not null,
    pc_tipo char(1) not null,
    pc_numtot   smallint    null,
    pc_numcre   smallint    null,
    pc_numdeb   smallint    null,
    pc_numco    smallint    null,
    pc_fechavig datetime    not null,
    pc_estado   char(1) not null
)
go

/* pe_pro_bancario */
print 'TABLA ====> pe_pro_bancario'
go
CREATE TABLE pe_pro_bancario (
    pb_pro_bancario smallint    not null,
    pb_descripcion  varchar(64) not null,
    pb_estado   char(1) null,
    pb_fecha_estado smalldatetime   null
)
go

/* pe_pro_final */
print 'TABLA ====> pe_pro_final'
go
CREATE TABLE pe_pro_final (
    pf_pro_final    smallint    not null,
    pf_filial   tinyint not null,
    pf_sucursal smallint    not null,
    pf_mercado  smallint    not null,
    pf_producto tinyint not null,
    pf_moneda   tinyint not null,
    pf_tipo char(1) not null,
    pf_descripcion  varchar(64) not null,
    pf_depende          varchar(10) null,
    pf_provisiona       char(1)     null,
    pf_cod_rango_edad   tinyint     null
)
go

/* pe_producto_contractual */
print 'TABLA ====> pe_producto_contractual'
go
CREATE TABLE pe_producto_contractual (
    pc_profinal tinyint null,
    pc_categoria    char(1) null,
    pc_plazo    tinyint null,
    pc_plazo_neg    char(1) null,
    pc_cuota    money   null,
    pc_cuota_neg    char(1) null,
    pc_periodicidad varchar(10) null,
    pc_monto_final  money   null,
    pc_dias_max_mora    tinyint null,
    pc_estado   varchar(10) null,
    pc_ptos_premio  float   null,
    pc_fecha_crea   datetime    null,
    pc_fecha_upd    datetime    null,
    pc_plan_pago    char(1) null
)
go

/* pe_rango */
print 'TABLA ====> pe_rango'
go
CREATE TABLE pe_rango (
    ra_tipo_rango   tinyint not null,
    ra_grupo_rango  smallint    not null,
    ra_rango    tinyint not null,
    ra_desde    money   null,
    ra_hasta    money   null,
    ra_estado   varchar(10) null
)
go

/* pe_servicio_contr */
print 'TABLA ====> pe_servicio_contr'
go
CREATE TABLE pe_servicio_contr (
    sc_servicio_dis smallint    not null,
    sc_producto tinyint not null,
    sc_codigo   int not null,
    sc_ciclo    varchar(10) not null,
    sc_tipo char(1) null,
    sc_valor    money   null,
    sc_estado   char(1) not null,
    sc_fecha_estado smalldatetime   null
)
go

/* pe_servicio_dis */
print 'TABLA ====> pe_servicio_dis'
go
CREATE TABLE pe_servicio_dis (
    sd_servicio_dis smallint    not null,
    sd_descripcion  varchar(64) not null,
    sd_nemonico varchar(10) null,
    sd_estado   char(1) not null,
    sd_costo_interno    money   not null,
    sd_num_rubro    tinyint null,
    sd_historico    char(1) null
)
go

/* pe_servicio_per */
print 'TABLA ====> pe_servicio_per'
go
CREATE TABLE pe_servicio_per (
    sp_pro_final    smallint    not null,
    sp_servicio_dis smallint    not null,
    sp_rubro    varchar(10) not null,
    sp_servicio_per smallint    not null,
    sp_tipo_rango   tinyint not null,
    sp_grupo_rango  smallint    not null
)
go

/* pe_tipo_rango */
print 'TABLA ====> pe_tipo_rango'
go
CREATE TABLE pe_tipo_rango (
    tr_tipo_rango   tinyint not null,
    tr_descripcion  varchar(64) not null,
    tr_tipo_atributo    varchar(10) null,
    tr_moneda   tinyint null,
    tr_estado   char(1) null
)
go

/* pe_tope_oficina */
print 'TABLA ====> pe_tope_oficina'
go
CREATE TABLE pe_tope_oficina (
    to_secuencia     int not null identity,
    to_tipo_prod     int not null,
    to_cantidad      int not null,
    to_mar_efec      char(1) null,
    to_mar_chq       char(1) null,
    to_vlr_efec      money   null,
    to_vlr_chq       money   null,
    to_login         varchar(14) not null,
    to_fecha_reg     datetime    not null,
    to_mar_chq_otra  char(1) null,
    to_mar_efec_otra char(1) null,
    to_vlr_chq_otra  money   null,
    to_vlr_efec_otra money   null
)
go

/* pe_val_contratado */
print 'TABLA ====> pe_val_contratado'
go
CREATE TABLE pe_val_contratado (
    vc_secuencial   int not null,
    vc_tipo_default char(1) not null,
    vc_rol  char(1) not null,
    vc_producto tinyint not null,
    vc_codigo   int not null,
    vc_servicio_per smallint    not null,
    vc_categoria    varchar(10) not null,
    vc_tipo_rango   tinyint not null,
    vc_grupo_rango  smallint    not null,
    vc_rango    tinyint not null,
    vc_valor_con    real    not null,
    vc_tipo_variacion   char(1) not null,
    vc_signo    char(1) null,
    vc_fecha    smalldatetime   not null,
    vc_fecha_venc   smalldatetime   not null,
    vc_estado   char(1) null
)
go

/* pe_var_servicio */
print 'TABLA ====> pe_var_servicio'
go
CREATE TABLE pe_var_servicio (
    vs_servicio_dis smallint    not null,
    vs_rubro    varchar(10) not null,
    vs_descripcion  varchar(64) not null,
    vs_estado   char(1) not null,
    vs_signo    char(1) null,
    vs_tipo_dato    char(1) not null
)
go

/* pe_causales_restringidas */
print 'TABLA ====> pe_causales_restringidas'
go
CREATE TABLE pe_causales_restringidas (
    cr_causal       char(3) null,
    cr_origen       char(10)    null,
    cr_especie      char(10)    null,
    cr_tipo_tran    char(1) null
)
go

/* pe_costo_especial */
print 'TABLA ====> pe_costo_especial'
go
CREATE TABLE pe_costo_especial (
    ce_servicio_dis     smallint    not null,
    ce_rubro            varchar(10) not null,
    ce_tipo_dato        char(1) not null,
    ce_descripcion      varchar(64) not null,
    ce_tipo_rango       tinyint not null,
    ce_grupo_rango      smallint    not null,
    ce_rango            tinyint not null,
    ce_minimo           money   not null,
    ce_base             money   not null,
    ce_maximo           money   not null,
    ce_fecha_ing        datetime    not null,
    ce_fecha_mod        datetime    null,
    ce_fecha_vigencia   datetime    null,
    ce_fecha_aprob      datetime    null,
    ce_aprobado         char(1) null,
    ce_en_linea         char(1) null
)
go

/* pe_costo_especial_per */
print 'TABLA ====> pe_costo_especial_per'
go
CREATE TABLE pe_costo_especial_per (
    cp_secuencial       int not null,
    cp_tipo_costo       char(1) not null,
    cp_tipo_per         char(1) not null,
    cp_servicio_dis     smallint    not null,
    cp_rubro            varchar(10) null,
    cp_tipo_dato        char(1) null,
    cp_cuenta           varchar(24) null,
    cp_cliente          int null,
    cp_oficina          smallint    null,
    cp_producto         tinyint null,
    cp_tipo_rango       tinyint null,
    cp_grupo_rango      smallint    null,
    cp_rango            tinyint null,
    cp_valor_per        money   null,
    cp_minimo           money   null,
    cp_maximo           money   null,
    cp_tipo_aplic       char(1) null,
    cp_fecha_ing        datetime    not null,
    cp_fecha_vigencia   datetime    null,
    cp_en_linea         char(1) null
)
go

/* pe_limites_restrictivos */
print 'TABLA ====> pe_limites_restrictivos'
go
CREATE TABLE pe_limites_restrictivos (
    lr_tabla                int null,
    lr_tipo_tran            char(1) null,
    lr_origen               char(10)    null,
    lr_especie              char(10)    null,
    lr_nro_transacciones    smallint    null,
    lr_monto_transacciones  money       null,
    lr_id                   smallint    identity
)
go

/* pe_par_com_trn */
print 'TABLA ====> pe_par_com_trn'
go
CREATE TABLE pe_par_com_trn (
    pct_profinal    smallint    null,
    pct_categoria   varchar(3)  null,
    pct_transaccion int null,
    pct_numtrn      int null,
    pct_canal       varchar(10) null,
    pct_causa       varchar(10) null,
    pct_estado      char(1) null,
    pct_fecha_crea  datetime    null,
    pct_fecha_mod   datetime    null,
    pct_monto       money   null
)
go


/* pe_servicio_ws */
print 'TABLA ====> pe_servicio_ws'
go
CREATE TABLE pe_servicio_ws (
    sw_canal    smallint    not null,
    sw_transaccion  int not null,
    sw_tran_causal  char(3) null,
    sw_servicio varchar(10) not null,
    sw_com_causal   char(3) null
)
go

/* pe_var_servicio_CCA554 */
print 'TABLA ====> pe_var_servicio_CCA554'
go
CREATE TABLE pe_var_servicio_CCA554 (
    vs_servicio_dis smallint    not null,
    vs_rubro    varchar(10) not null,
    vs_descripcion  varchar(64) not null,
    vs_estado   char(1) not null,
    vs_signo    char(1) null,
    vs_tipo_dato    char(1) not null
)
go

/* pe_pro_rango_edad */
print 'TABLA ====> pe_pro_rango_edad'
go

CREATE TABLE pe_pro_rango_edad
	(
	re_codigo      SMALLINT NOT NULL,
	re_descripcion descripcion NOT NULL,
	re_rango_ini   INT NOT NULL,
	re_rango_fin   INT NOT NULL,
	re_estado      CHAR (1)
	)
GO

USE cob_remesas_his
go


print 'Creando tabla re_camara_hist'
IF EXISTS (select 1 from sysobjects where name = 're_camara_hist')
   DROP TABLE re_camara_hist
go

CREATE TABLE re_camara_hist (
    ca_fecha             DATETIME NOT NULL,
    ca_secuencial        INT NOT NULL,
    ca_tipo_cheque       CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_cuenta            VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
    ca_num_cheque        INT NOT NULL,
    ca_valor             MONEY NOT NULL,
    ca_moneda            TINYINT NOT NULL,
    ca_estado            CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_oficina           SMALLINT NOT NULL,
    ca_banco             TINYINT NULL,
    ca_mensaje           VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_cta_dep           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
    ca_producto          TINYINT NULL,
    ca_tipo_error        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_causa_dev         VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_tipo_equip        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_tipo_tran         INT NULL,
    ca_secuencial_unisys INT NULL,
    ca_sec_det           INT NULL,
    ca_sec_cab           INT NULL,
    ca_comision          MONEY NULL,
    ca_portes            MONEY NULL,
    ca_iva               MONEY NULL,
    ca_portes_dev        MONEY NULL,
    ca_iva_dev           MONEY NULL,
    ca_procesado         VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_bcoced            INT NULL,
    ca_tipo_compensa     VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_digito_46         TINYINT NULL,
    ca_oficina_cta       SMALLINT NULL
    )
go


if exists (select 1 from sysobjects where name = 're_contrato_producto')
begin
    drop table cob_remesas..re_contrato_producto
end
go

create table cob_remesas..re_contrato_producto
(
    cp_producto           tinyint       null,
    cp_prod_banc           smallint     not null,
    cp_tipo_persona     char(1)       null,
    cp_titularidad      char(1)       null,
    cp_estado           char(1)       not null,
    cp_plantilla          varchar(20) not null,
    cp_descripcion         varchar(60) not null,
    cp_es_especial      char(2)     null

)
go