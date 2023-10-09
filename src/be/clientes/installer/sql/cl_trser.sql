
/*      Scrip de creacion de Transacciones de Servicios    */

use cobis
go

/* cl_tran_servicio */
print '=====> cl_tran_servicio'
if exists (select * from sysobjects where name = 'cl_tran_servicio')
    DROP TABLE cl_tran_servicio
go

CREATE TABLE cl_tran_servicio
	(
	monto                        MONEY NULL,
	ts_abreviatura               catalogo NULL,
	ts_actividad                 catalogo NULL,
	ts_activo                    MONEY NULL,
	ts_af                        CHAR (2) NULL,
	ts_antiguedad                INT NULL,
	ts_aplica_mora               CHAR (1) NULL,
	ts_archivo                   VARCHAR (14) NULL,
	ts_asfi                      CHAR (1) NULL,
	ts_asosciada                 catalogo NULL,
	ts_balprome                  VARCHAR (10) NULL,
	ts_barrio                    CHAR (40) NULL,
	ts_bienes                    CHAR (1) NULL,
	ts_calif_cliente             catalogo NULL,
	ts_calificacion              CHAR (15) NULL,
	ts_calificador               CHAR (40) NULL,
	ts_calle                     VARCHAR (80) NULL,
	ts_camara                    catalogo NULL,
	ts_canal_extracto            CHAR (1) NULL,
	ts_carg_pub                  CHAR (1) NULL,
	ts_cargo                     SMALLINT NULL,
	ts_casilla                   VARCHAR (24) NULL,
	ts_categoria                 catalogo NULL,
	ts_ced_discapacidad          VARCHAR (30) NULL,
	ts_cedruc                    numero NULL,
	ts_cir_comunic               VARCHAR (10) NULL,
	ts_ciudad                    INT NULL,
	ts_ciudad_bien               INT NULL,
	ts_ciudad_nac                INT NULL,
	ts_ciudad_ref                INT NULL,
	ts_clase                     CHAR (1) NOT NULL,
	ts_clase_bienes_e            VARCHAR (35) NULL,
	ts_cliente_preferencial      CHAR (1) NULL,
	ts_cobertura                 VARCHAR (30) NULL,
	ts_cod_alterno               INT NULL,
	ts_cod_atr                   TINYINT NULL,
	ts_cod_fie_asf               VARCHAR (10) NULL,
	ts_cod_otro_pais             INT NULL,
	ts_cod_tbl_inf               SMALLINT NULL,
	ts_codigo                    INT NULL,
	ts_codigo_alerta             INT NULL,
	ts_codigo_mr                 INT NULL,
	ts_codigocat                 catalogo NULL,
	ts_codpostal                 VARCHAR (30) NULL,
	ts_colonia                   VARCHAR (10) NULL,
	ts_compania                  VARCHAR (36) NULL,
	ts_costo                     MONEY NULL,
	ts_cuenta                    cuenta NULL,
	ts_cuenta_bancaria           CHAR (16) NULL,
	ts_cupo_usado                MONEY NULL,
	ts_debito_aut                CHAR (1) NULL,
	ts_depart_pais               catalogo NULL,
	ts_departamento              SMALLINT NULL,
	ts_deposini                  VARCHAR (10) NULL,
	ts_derecha                   descripcion NULL,
	ts_des_cta_afi               CHAR (1) NULL,
	ts_des_otros_ingresos        catalogo NULL,
	ts_desc_atr                  descripcion NULL,
	ts_desc_direc                descripcion NULL,
	ts_desc_ingresos             catalogo NULL,
	ts_desc_larga                VARCHAR (255) NULL,
	ts_desc_oingreso             descripcion NULL,
	ts_desc_seguro               VARCHAR (64) NULL,
	ts_desc_tbl_inf              descripcion NULL,
	ts_descmoneda                descripcion NULL,
	ts_descrip_ref_per           VARCHAR (64) NULL,
	ts_descripcion               descripcion NULL,
	ts_dia_pago                  TINYINT NULL,
	ts_dias_gracia               TINYINT NULL,
	ts_digito                    CHAR (1) NULL,
	ts_dinero                    CHAR (1) NULL,
	ts_direc                     direccion NULL,
	ts_direccion                 INT NULL,
	ts_direccion_hip             VARCHAR (60) NULL,
	ts_discapacidad              CHAR (1) NULL,
	ts_dispersion_fondos         CHAR (1) NULL,
	ts_doc_validado              CHAR (1) NULL,
	ts_documento                 INT NULL,
	ts_egresos                   MONEY NULL,
	ts_emp_postal                VARCHAR (24) NULL,
	ts_empresa                   INT NULL,
	ts_ente                      INT NULL,
	ts_ente_externo              INT NULL,
	ts_escritura                 INT NULL,
	ts_estado                    estado NULL,
	ts_estado_civil              catalogo NULL,
	ts_estado_huella             catalogo NULL,
	ts_estado_ref                catalogo NULL,
	ts_estatus                   CHAR (1) NULL,
	ts_exc_por2                  CHAR (1) NULL,
	ts_exc_sipla                 CHAR (1) NULL,
	ts_exonera_estudio           CHAR (1) NULL,
	ts_fec_aut_asf               DATETIME NULL,
	ts_fec_exp_ref               DATETIME NULL,
	ts_fec_inicio                DATETIME NULL,
	ts_fec_vencimiento           DATETIME NULL,
	ts_fecha                     DATETIME NULL,
	ts_fecha_act_huella          DATETIME NULL,
	ts_fecha_constitucion        DATETIME NULL,
	ts_fecha_cov                 CHAR (10) NULL,
	ts_fecha_emision             DATETIME NULL,
	ts_fecha_escritura           DATETIME NULL,
	ts_fecha_exp                 DATETIME NULL,
	ts_fecha_expira              DATETIME NULL,
	ts_fecha_fija                CHAR (1) NULL,
	ts_fecha_hip                 DATETIME NULL,
	ts_fecha_ingreso             DATETIME NULL,
	ts_fecha_mod                 CHAR (10) NULL,
	ts_fecha_modifi              DATETIME NULL,
	ts_fecha_modificacion        DATETIME NULL,
	ts_fecha_nac                 DATETIME NULL,
	ts_fecha_nac_mer             DATETIME NULL,
	ts_fecha_nac1                DATETIME NULL,
	ts_fecha_pago                CHAR (1) NULL,
	ts_fecha_pig                 DATETIME NULL,
	ts_fecha_ref                 CHAR (10) NULL,
	ts_fecha_reg                 DATETIME NULL,
	ts_fecha_reg_huella          DATETIME NULL,
	ts_fecha_registro            DATETIME NULL,
	ts_fecha_ult_mod             DATETIME NULL,
	ts_fecha_valuo               DATETIME NULL,
	ts_fecha_vcto                DATETIME NULL,
	ts_fecha_verificacion        DATETIME NULL,
	ts_fecha_verificacion1       DATETIME NULL,
	ts_filial                    TINYINT NULL,
	ts_finca                     INT NULL,
	ts_folio                     INT NULL,
	ts_forma_des                 catalogo NULL,
	ts_forma_homologa            catalogo NULL,
	ts_fpas_finan                DATETIME NULL,
	ts_fuente_verificacion       VARCHAR (19) NULL,
	ts_funcionario               SMALLINT NULL,
	ts_garantia                  CHAR (1) NULL,
	ts_gmf_banco                 CHAR (1) NULL,
	ts_grado_soc                 catalogo NULL,
	ts_gravada                   MONEY NULL,
	ts_gravamen_afavor           CHAR (30) NULL,
	ts_grp_inf                   catalogo NULL,
	ts_grupo                     INT NULL,
	ts_hora                      DATETIME NULL,
	ts_ifi                       CHAR (1) NULL,
	ts_img_huella                VARCHAR (30) NULL,
	ts_ingre                     VARCHAR (10) NULL,
	ts_ingresos                  MONEY NULL,
	ts_inirelac                  CHAR (4) NULL,
	ts_inss                      VARCHAR (15) NULL,
	ts_izquierda                 descripcion NULL,
	ts_jefe                      SMALLINT NULL,
	ts_jefe_agenc                INT NULL,
	ts_jz                        CHAR (2) NULL,
	ts_libro                     INT NULL,
	ts_licencia                  VARCHAR (30) NULL,
	ts_localidad                 VARCHAR (10) NULL,
	ts_login                     login NULL,
	ts_lsrv                      VARCHAR (30) NULL,
	ts_lugar_doc                 INT NULL,
	ts_mandat                    CHAR (1) NULL,
	ts_mantiene_condiciones      CHAR (1) NULL,
	ts_matricula                 VARCHAR (16) NULL,
	ts_mensaje                   VARCHAR (255) NULL,
	ts_moneda                    TINYINT NULL,
	ts_monto_vencido             MONEY NULL,
	ts_motiv_term                catalogo NULL,
	ts_mpromcre                  VARCHAR (10) NULL,
	ts_mpromdeb                  VARCHAR (10) NULL,
	ts_municipio                 VARCHAR (10) NULL,
	ts_naciona                   INT NULL,
	ts_nacional                  CHAR (1) NULL,
	ts_nacionalidad              descripcion NULL,
	ts_nemdef                    CHAR (6) NULL,
	ts_nemon                     CHAR (6) NULL,
	ts_nit                       numero NULL,
	ts_nit_per                   numero NULL,
	ts_nit_venc                  DATETIME NULL,
	ts_nivel                     TINYINT NULL,
	ts_nivel_egresos             catalogo NULL,
	ts_nivel_estudio             catalogo NULL,
	ts_nom_aval                  CHAR (30) NULL,
	ts_nom_empresa               descripcion NULL,
	ts_nomb_comercial            VARCHAR (128) NULL,
	ts_nombre                    descripcion NULL,
	ts_nombre_completo           VARCHAR (255) NULL,
	ts_nombre_empresa            descripcion NULL,
	ts_nomina                    SMALLINT NULL,
	ts_notaria                   TINYINT NULL,
	ts_nro                       INT NULL,
	ts_ntrancre                  VARCHAR (10) NULL,
	ts_ntrandeb                  VARCHAR (10) NULL,
	ts_num_cargas                TINYINT NULL,
	ts_num_empleados             SMALLINT NULL,
	ts_num_hijos                 TINYINT NULL,
	ts_num_poliza                VARCHAR (36) NULL,
	ts_numero                    TINYINT NULL,
	ts_o_departamento            SMALLINT NULL,
	ts_obs_horario               VARCHAR (120) NULL,
	ts_obserprocta               VARCHAR (10) NULL,
	ts_observacion               VARCHAR (255) NULL,
	ts_observaciondir            VARCHAR (80) NULL,
	ts_observaciones             VARCHAR (255) NULL,
	ts_ofic_vinc                 SMALLINT NULL,
	ts_oficina                   SMALLINT NULL,
	ts_origen                    CHAR (40) NULL,
	ts_origen_ingresos           descripcion NULL,
	ts_otros_ingresos            MONEY NULL,
	ts_p_apellido                descripcion NULL,
	ts_pais                      SMALLINT NULL,
	ts_pais1                     VARCHAR (10) NULL,
	ts_parametro_mul             SMALLINT NULL,
	ts_parroquia                 INT NULL,
	ts_pas_finan                 MONEY NULL,
	ts_pasaporte                 VARCHAR (20) NULL,
	ts_pasivo                    MONEY NULL,
	ts_path_croquis              VARCHAR (50) NULL,
	ts_path_foto                 VARCHAR (50) NULL,
	ts_patrimonio_b              MONEY NULL,
	ts_patrimonio_tec            MONEY NULL,
	ts_periodo                   INT NULL,
	ts_porcentaje_exonera        FLOAT NULL,
	ts_porcentaje_gmfbanco       FLOAT NULL,
	ts_posicion                  catalogo NULL,
	ts_procedure                 INT NULL,
	ts_producto                  CHAR (3) NULL,
	ts_profesion                 catalogo NULL,
	ts_otro_profesion            VARCHAR (30) NULL,
	ts_promedio_ventas           MONEY NULL,
	ts_promotor                  CHAR (10) NULL,
	ts_proposito                 catalogo NULL,
	ts_provincia                 SMALLINT NULL,
	ts_puesto_e                  VARCHAR (10) NULL,
	ts_rango_max                 INT NULL,
	ts_rango_min                 INT NULL,
	ts_rango_nor_max             INT NULL,
	ts_rango_nor_min             INT NULL,
	ts_razon_social              VARCHAR (254) NULL,
	ts_referido                  SMALLINT NULL,
	ts_referidor_ecu             INT NULL,
	ts_reg_nat                   catalogo NULL,
	ts_reg_ope                   catalogo NULL,
	ts_regional                  VARCHAR (10) NULL,
	ts_registro                  INT NULL,
	ts_rel_carg_pub              CHAR (1) NULL,
	ts_release                   VARCHAR (12) NULL,
	ts_rep                       descripcion NULL,
	ts_rep_legal                 INT NULL,
	ts_rep_superban              CHAR (1) NULL,
	ts_restado                   catalogo NULL,
	ts_restringue_uso            CHAR (1) NULL,
	ts_rural_urbano              CHAR (1) NULL,
	ts_s_apellido                descripcion NULL,
	ts_saldo_minimo              MONEY NULL,
	ts_sb                        CHAR (2) NULL,
	ts_sec_huella                INT NULL,
	ts_seccuenta                 INT NULL,
	ts_sector                    catalogo NULL,
	ts_secuencia                 TINYINT NULL,
	ts_secuencial                INT NOT NULL,
	ts_secuencial1               INT NULL,
	ts_segundos_lat              FLOAT NULL,
	ts_segundos_long             FLOAT NULL,
	ts_sexo                      sexo NULL,
	ts_sigla                     VARCHAR (25) NULL,
	ts_signo_spread              CHAR (1) NULL,
	ts_situacion_laboral         VARCHAR (5) NULL,
	ts_sospechoso                catalogo NULL,
	ts_srv                       VARCHAR (30) NULL,
	ts_sub_cargo                 descripcion NULL,
	ts_subemp                    CHAR (10) NULL,
	ts_subemp1                   CHAR (10) NULL,
	ts_subemp2                   CHAR (10) NULL,
	ts_sucursal                  SMALLINT NULL,
	ts_sucursal_ref              VARCHAR (20) NULL,
	ts_suplidores                descripcion NULL,
	ts_tabla                     SMALLINT NULL,
	ts_table                     CHAR (30) NULL,
	ts_tasa_mora                 catalogo NULL,
	ts_tbien                     catalogo NULL,
	ts_tclase                    descripcion NULL,
	ts_telefono                  VARCHAR (14) NULL,
	ts_telefono_1                CHAR (12) NULL,
	ts_telefono_2                CHAR (12) NULL,
	ts_telefono_3                CHAR (12) NULL,
	ts_telefono_ref              VARCHAR (16) NULL,
	ts_term                      VARCHAR (32) NULL,
	ts_terminal                  descripcion NULL,
	ts_tgarantia                 catalogo NULL,
	ts_tiempo_conocido           INT NULL,
	ts_tiempo_reside             INT NULL,
	ts_tip_punt_at               VARCHAR (10) NULL,
	ts_tipo                      catalogo NULL,
	ts_tipo_alerta               catalogo NULL,
	ts_tipo_ced                  CHAR (4) NULL,
	ts_tipo_credito              CHAR (1) NULL,
	ts_tipo_discapacidad         catalogo NULL,
	ts_tipo_dp                   CHAR (1) NULL,
	ts_tipo_empleo               catalogo NULL,
	ts_tipo_horar                VARCHAR (10) NULL,
	ts_tipo_huella               catalogo NULL,
	ts_tipo_link                 CHAR (1) NULL,
	ts_tipo_nit                  CHAR (2) NULL,
	ts_tipo_operador             VARCHAR (10) NULL,
	ts_tipo_producto             TINYINT NULL,
	ts_tipo_recaudador           CHAR (1) NULL,
	ts_tipo_soc                  catalogo NULL,
	ts_tipo_transaccion          SMALLINT NOT NULL,
	ts_tipo_transaccion_producto INT NULL,
	ts_tipo_vinculacion          catalogo NULL,
	ts_tipo_vivienda             catalogo NULL,
	ts_toperacion                CHAR (1) NULL,
	ts_total_activos             MONEY NULL,
	ts_totaliza                  CHAR (1) NULL,
	ts_updlogin                  login NULL,
	ts_user                      login NULL,
	ts_usuario                   login NULL,
	ts_val_aval                  MONEY NULL,
	ts_valor                     descripcion NULL,
	ts_valor_spread              TINYINT NULL,
	ts_verificado                CHAR (1) NULL,
	ts_vinculacion               CHAR (1) NULL,
	ts_zona                      catalogo NULL,
	ts_gar_liquida               CHAR (1) NULL
	)
GO

CREATE NONCLUSTERED INDEX idx1
	ON dbo.cl_tran_servicio (ts_fecha,ts_ente)
go


CREATE VIEW ts_viabilidad (
       secuencial,         tipo_transaccion,      clase,          fecha,
       usuario,            terminal,              srv,            lsrv,
       codigo,             resultado,             viable,         estado,
       ponderacion

)
as
select ts_secuencial,         ts_tipo_transaccion,   ts_clase,       ts_fecha,
       ts_usuario,            ts_terminal,           ts_srv,         ts_lsrv,
       ts_codigo,             ts_profesion,          ts_tipo_ced,    ts_estado_civil,
       ts_grupo

from   cl_tran_servicio
where  ts_tipo_transaccion = 1070
or     ts_tipo_transaccion = 1071

go


CREATE VIEW ts_traslado_producto(
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente,det_producto,cod_producto,fecha_modificacion,subtipo,tipo_persona,tipo_sociedad
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv, ts_ente,
       ts_codigo,ts_producto,ts_fecha_modificacion,ts_digito,ts_categoria,ts_tipo_soc
from   cl_tran_servicio
where  ts_tipo_transaccion = 1109

go

CREATE VIEW ts_traslado_alerta (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    sospechoso,observacion,
    fecha_registro,oficina,oficial
    )
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario,    ts_terminal, ts_srv, ts_lsrv,
       ts_sospechoso,ts_observacion,
       ts_fecha_registro,ts_oficina,ts_login
from   cl_tran_servicio
where  ts_tipo_transaccion = 184

go

CREATE VIEW ts_trabajo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, trabajo, empresa, cargo, moneda, sueldo, tipo,
    verificado, vigencia, fecha_ingreso, fecha_salida,
    fecha_modificacion, fecha_registro,fecha_verificacion,
    nom_empresa
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente, ts_tabla, ts_empresa, ts_nombre, ts_secuencia,
       ts_ingresos, ts_tipo, ts_posicion, ts_tipo_dp,
       ts_fecha_nac, ts_fecha_reg, ts_fecha_modificacion,
       ts_fecha_registro,ts_fec_inicio, ts_nom_empresa

from   cl_tran_servicio
where  ts_tipo_transaccion = 181
or     ts_tipo_transaccion = 182
or     ts_tipo_transaccion = 1230

go

CREATE VIEW ts_tplan (
        secuencial,    tipo_transaccion,    clase,        fecha,
        usuario,       terminal,            srv,          lsrv,
        tbalance,      cuenta,              alterno
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase,     ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,       ts_lsrv,
        ts_codigocat,  ts_departamento,     ts_cod_alterno
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1145
    or  ts_tipo_transaccion = 1146
    or  ts_tipo_transaccion = 1147

go


CREATE VIEW ts_tipos_de_documentos
    ( secuencial,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      srv,
      lsrv,
      codigo,
      sexo,
      subtipo,
      descripcion,
      mascara,
      estado,
      valida_fecha_exp,
      valor_exp,
      num_dijitos_docu,
      campo_incluido,
      formato_fecha,
      rango_campo_inclu,
      valor_cade_campo_inclu,
      tipo_dato,
      longitud_unica,
      num_dijitos_docu_max,
      valida_nit,
      valida_nui,
      rango_nui,
      fecha_exp
      )  AS
   SELECT  ts_secuencial,
           ts_tipo_transaccion,
           ts_clase,
           ts_fecha,
           ts_usuario,
           ts_terminal,
           ts_srv,
           ts_lsrv,
           ts_telefono,
           ts_sexo,
           ts_garantia,
           ts_nombre,
           ts_descrip_ref_per,
           ts_estado,
           ts_exc_sipla,
           ts_ciudad_bien,
           ts_escritura,
           ts_vinculacion,
           ts_sucursal_ref,
           ts_compania,
           ts_matricula,
           ts_nacional,
           ts_estatus,
           ts_registro,
           ts_toperacion ,
           ts_mandat,
           ts_observaciones,
           ts_fecha_nac
   FROM    cl_tran_servicio
   WHERE ( ts_tipo_transaccion = 1113 ) OR
         ( ts_tipo_transaccion = 1111 ) OR
         ( ts_tipo_transaccion = 1112 )


go


CREATE VIEW ts_telefono (
        secuencial,       alterno,         tipo_transaccion,
        clase,            fecha,           usuario,
        terminal,         srv,             lsrv,
        ente,             direccion,       telefono,
        valor,            tipo,            tipo_operador
) as
select  ts_secuencial,    ts_cod_alterno,  ts_tipo_transaccion,
        ts_clase,         ts_fecha,        ts_usuario,
        ts_terminal,      ts_srv,          ts_lsrv,
        ts_ente,          ts_direccion,    ts_codigo,
        ts_valor,         ts_tipo,         ts_tipo_operador
from    cl_tran_servicio
where   ts_tipo_transaccion = 111
or      ts_tipo_transaccion = 112
or      ts_tipo_transaccion = 148


go

CREATE VIEW ts_tbl_inf (
        secuencial, tipo_transaccion, clase, fecha,
        usuario,    terminal,         srv,   lsrv,
        grp_inf,    cod_tbl_inf,      desc_tbl_inf

) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,   ts_lsrv,
        ts_grp_inf,    ts_cod_tbl_inf,      ts_desc_tbl_inf
from cl_tran_servicio
where   ts_tipo_transaccion = 1331

go

CREATE VIEW ts_tbalance
AS
SELECT ts_secuencial AS secuencial,    ts_tipo_transaccion AS tipo_transaccion, ts_clase    AS clase,
       ts_fecha      AS fecha,         ts_usuario          AS usuario,
       ts_terminal   AS terminal,      ts_srv              AS srv,              ts_lsrv     AS lsrv,
       ts_codigocat  AS tbalance,      ts_valor            AS descripcion,      ts_estado   AS estado,
       ts_izquierda  AS col_izquierda, ts_derecha          AS col_derecha,      ts_totaliza AS totaliza,
       ts_estatus    AS automatico,    ts_toperacion       AS tcliente
FROM   cl_tran_servicio
WHERE  (ts_tipo_transaccion = 1142) OR
       (ts_tipo_transaccion = 1143) OR
       (ts_tipo_transaccion = 1144)

go


CREATE VIEW ts_soc_hecho (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    persona, sociedad, nombre, tipo_soc_hecho,
    ruc,vigencia,verificado
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_ente, ts_secuencia, ts_nombre, ts_tipo,
    ts_cedruc,ts_posicion, ts_tipo_dp

from    cl_tran_servicio
where   ts_tipo_transaccion = 1243
or      ts_tipo_transaccion = 1244
or  ts_tipo_transaccion = 1249

go

/* ELA MAYO/2001 BANCA DOMICILIARIA*/
/* ts_servicio_bandom */

CREATE VIEW ts_servicio_bandom (secuencial,tipo_transaccion,clase,fecha,
                       usuario,terminal,srv,lsrv,ente,
               codigo,descripcion,producto,
                           valor,cau_cte,cau_aho,estado
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,
       ts_usuario,ts_terminal,ts_srv,ts_lsrv,ts_ente,
       ts_codigocat,ts_descripcion,ts_cod_atr,
       ts_ingresos,ts_actividad,ts_posicion,ts_estado
from  cl_tran_servicio
where  ts_tipo_transaccion = 1415
    or ts_tipo_transaccion = 1416
    or ts_tipo_transaccion = 1417

go


/* ts_sectoreco */
CREATE VIEW ts_sectoreco (
        secuencial, tipo_transaccion, clase, fecha,
        usuario, terminal, srv, lsrv,
        sectoreco,descripcion,estado
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_sector, ts_izquierda, ts_estado
from   cl_tran_servicio
where  ts_tipo_transaccion = 1400
or     ts_tipo_transaccion = 1401
or     ts_tipo_transaccion = 1403

go

CREATE VIEW ts_sector (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    zona,sector,descripcion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_zona, ts_sector, ts_izquierda

from   cl_tran_servicio
where  ts_tipo_transaccion = 1150
or     ts_tipo_transaccion = 1151
or     ts_tipo_transaccion = 1152

go

CREATE VIEW ts_relacion_inter (
    secuencial,          tipo_transaccion, clase,                 fecha,
    usuario,             terminal,         srv,                   lsrv,
    relacion,            ente,             institucion,           tipo_relacionm,
    descripcion,         fecha_desde,      pais,                  fecha_registro,
    fecha_modificacion,  fecha_ver,        vigencia,              verificado,
    funcionario,         monto
) as
select  ts_secuencial,   ts_tipo_transaccion, ts_clase,           ts_fecha,
        ts_usuario,      ts_terminal,         ts_srv,             ts_lsrv,
        ts_grupo,        ts_ente,             ts_descrip_ref_per, ts_tipo,
        ts_descripcion,  ts_fecha_emision,    ts_pais,            ts_fecha_ingreso,
        ts_fecha_modifi, ts_fecha_cov,        ts_tipo_dp,         ts_estatus,
        ts_login     ,   ts_valor
from    cl_tran_servicio
where   ts_tipo_transaccion = 1307
or      ts_tipo_transaccion = 1308
or      ts_tipo_transaccion = 1309

go


CREATE VIEW ts_relacion (
       secuencial,    tipo_transaccion,    clase,        fecha,
       usuario,       terminal,            srv,          lsrv,
       relacion,      descripcion,         izquierda,    derecha
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase,     ts_fecha,
       ts_usuario,    ts_terminal,         ts_srv,       ts_lsrv,
       ts_codigo,     ts_descripcion,      ts_izquierda, ts_derecha
from   cl_tran_servicio
where  ts_tipo_transaccion = 1137
or     ts_tipo_transaccion = 1138
or     ts_tipo_transaccion = 1139

go

CREATE VIEW ts_refinh (
       secuencial,        tipo_transaccion,         clase,           fecha,
       usuario,           terminal,                 srv,             lsrv,
       estado,            ced_ruc,                  nombre,          fecha_ref,
       origen,            observacion,              codigo,          documento,
       fecha_mod,         p_apellido,               s_apellido,      tipo_ced,
       ref_estado        )
as
select ts_secuencial,     ts_tipo_transaccion,      ts_clase,        ts_fecha,
       ts_usuario,        ts_terminal,              ts_srv,          ts_lsrv,
       ts_estado,         ts_cedruc,                ts_nombre,       ts_fecha_ref,
       ts_codigocat,      ts_observaciones,         ts_codigo_mr,    ts_documento,
       ts_fecha_mod,      ts_p_apellido,            ts_s_apellido,   ts_tipo_ced,
       ts_restado
from   cl_tran_servicio
where  ts_tipo_transaccion = 1280
or     ts_tipo_transaccion = 1281
or     ts_tipo_transaccion = 1282
or     ts_tipo_transaccion = 1028

go

CREATE VIEW ts_referenciacion (
       secuencial,         tipo_transaccion,      clase,          fecha,
       usuario,            terminal,              srv,            lsrv,
       producto,           tipo_persona,          grupo_inf,      viabilidad,
       estado,             fecha_ing,             fecha_mod
)
as
select ts_secuencial,         ts_tipo_transaccion,   ts_clase,       ts_fecha,
       ts_usuario,            ts_terminal,           ts_srv,         ts_lsrv,
       ts_tipo_alerta,        ts_tipo_ced,           ts_sospechoso,  ts_restado,
       ts_estado_civil,       ts_fecha_ingreso,      ts_fecha_modifi
from   cl_tran_servicio
where  ts_tipo_transaccion = 1066
or     ts_tipo_transaccion = 1067

go

CREATE VIEW ts_referencia (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, referencia, tipo, tipo_cifras, numero_cifras,
    calificacion, verificacion, fecha_ver, institucion,
    banco,cuenta,fecha_registro,fecha_modificacion,
    vigencia,observacion,fecha_ingr_en_inst,toperacion,tclase,fec_inicio,
    fec_vencimiento,estatus,fecha_apert, tipo_cta, moneda, monto,
    fec_exp_ref, garantia, cupo_usado, monto_vencido, nacional,
    ciudad, sucursal, estado, telefono, bancoint
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente,ts_secuencia,ts_tipo,ts_tbien,ts_nivel,
       ts_codigocat,ts_dinero,ts_fecha_nac,ts_nombre,
       ts_sector,ts_table,ts_fecha_registro,ts_fecha_modificacion,
       ts_tipo_dp,ts_observacion, ts_fecha_reg,ts_toperacion,ts_tclase,
    ts_fec_inicio, ts_fec_vencimiento, ts_estatus,ts_fecha_cov,
    ts_posicion,ts_ingresos, monto, ts_fec_exp_ref,
    ts_garantia, ts_cupo_usado, ts_monto_vencido, ts_nacional,
    ts_ciudad_ref, ts_sucursal_ref, ts_estado_ref, ts_telefono_ref,
    ts_empresa

from   cl_tran_servicio
where  ts_tipo_transaccion = 179
or     ts_tipo_transaccion = 115
or     ts_tipo_transaccion = 116

go

CREATE VIEW ts_ref_personal (
    secuencial,     tipo_transaccion,   clase,          fecha,
    usuario,        terminal,           srv,            lsrv,
    persona,        referencia,         nombre,         p_apellido,
    s_apellido,     direccion,          telefono_d,     telefono_e,
    telefono_o,     parentesco,         vigencia,       descripcion,
    verificacion,   departamento,       ciudad,         barrio,
    calle,          numero,             colonia,        localidad,
    municipio,      estado,             codpostal,      pais,
    tiempo
)
as
select
    ts_secuencial,  ts_tipo_transaccion,ts_clase,       ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,         ts_lsrv,
    ts_ente,        ts_tabla,           ts_nombre,      ts_p_apellido,
    ts_s_apellido,  ts_direc,           ts_telefono_1,  ts_telefono_2,
    ts_telefono_3,  ts_tipo,            ts_posicion,    ts_descrip_ref_per,
    ts_dinero,      ts_sector,          ts_tipo_soc,    ts_zona,
    ts_calle,       ts_nro,             ts_colonia,     ts_localidad,
    ts_municipio,   ts_estado,          ts_codpostal,   ts_pais1,
    ts_tiempo_conocido
from   cl_tran_servicio
where  ts_tipo_transaccion = 177
or     ts_tipo_transaccion = 178
or     ts_tipo_transaccion = 1130


go

CREATE VIEW ts_rango_tipo_doc (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    codigo,
    sexo,
    rangoini,
    rangofi
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_camara,
    ts_sexo,
    ts_nit,
    ts_cedruc
from    cl_tran_servicio
where   ts_tipo_transaccion = 1113
or      ts_tipo_transaccion = 1111
or      ts_tipo_transaccion = 1112

go

CREATE VIEW ts_rango_empleo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    tipo_empleo, rango_min, rango_max, parametro_mul,
        rango_nor_min, rango_nor_max, fecha_registro,
    fecha_modificacion)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_tipo_empleo, ts_rango_min, ts_rango_max, ts_parametro_mul,
        ts_rango_nor_min, ts_rango_nor_max, ts_fecha_registro,
    ts_fecha_modificacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1451
or     ts_tipo_transaccion = 1452
or     ts_tipo_transaccion = 1453
or     ts_tipo_transaccion = 1454
or     ts_tipo_transaccion = 1455

go

CREATE VIEW ts_rango_actividad (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    tipo_actividad, rango_min, rango_max, parametro_mul,
        rango_nor_min, rango_nor_max, promedio_ventas,fecha_registro,
    fecha_modificacion)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_tipo_empleo, ts_rango_min, ts_rango_max, ts_parametro_mul,
        ts_rango_nor_min, ts_rango_nor_max, ts_promedio_ventas,
    ts_fecha_registro,ts_fecha_modificacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1456
or     ts_tipo_transaccion = 1457
or     ts_tipo_transaccion = 1458
or     ts_tipo_transaccion = 1459
or     ts_tipo_transaccion = 1460

go
CREATE VIEW ts_propiedad (
    secuencial,     tipo_transaccion,   clase,      fecha,
    usuario,        terminal,       srv,        lsrv,
    persona,        propiedad,      descripcion,    verificado,
    moneda,         valor,          tbien,      tgarantia,
    fecha_avaluo,   gravada,        nom_aval,   val_aval,
    gravamen_afavor,    ciudad_bien,        notaria,    matricula,
    escritura,      fecha_escritura,    ciudad_inm,     porcentaje,
    saldo_deuda,    dpto_inm,           dpto_not,   afect_familiar,
    vigencia
)
as
select
    ts_secuencial,  ts_tipo_transaccion,    ts_clase,   ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,     ts_lsrv,
    ts_ente,        ts_codigo,      ts_observacion, ts_posicion,
    ts_secuencia,   ts_valor,       ts_tbien,   ts_tgarantia,
    ts_fecha_valuo,     ts_gravada,     ts_nom_aval,    ts_val_aval,
    ts_gravamen_afavor, ts_ciudad_bien,     ts_notaria,     ts_matricula,
    ts_escritura,   ts_fecha_escritura, ts_ciudad,  ts_profesion,
    ts_cupo_usado,  ts_categoria,       ts_tipo_empleo, ts_origen,
    ts_tipo_alerta
from    cl_tran_servicio
where   ts_tipo_transaccion = 113
or      ts_tipo_transaccion = 114
or      ts_tipo_transaccion = 197


go

CREATE VIEW ts_promedio_producto
   (secuencial,       tipo_transaccion,   clase,
    fecha,            usuario,            terminal,
    srv,              lsrv,               cliente,
    producto,         promedio,           valor_promedio,
    fecha_registro,   fecha_revision
   )
as
select ts_secuencial,     ts_tipo_transaccion,  ts_clase,
       ts_fecha,          ts_usuario,           ts_terminal,
       ts_srv,            ts_lsrv,              ts_ente,
       ts_producto,       ts_totaliza,          ts_promedio_ventas,
       ts_fecha_registro, ts_fecha_modificacion
from  cl_tran_servicio
where ts_tipo_transaccion = 189
or    ts_tipo_transaccion = 190
or    ts_tipo_transaccion = 191

go

CREATE VIEW ts_plan (
        secuencial,    tipo_transaccion,    clase,    fecha,
        usuario,       terminal,            srv,      lsrv,
        cliente,       balance,             cuenta,   valor,
        alterno
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,   ts_lsrv,
        ts_ente,       ts_pais,             ts_grupo, ts_ingresos,
        ts_cod_alterno
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1188
    or  ts_tipo_transaccion = 129
    or  ts_tipo_transaccion = 130
    or  ts_tipo_transaccion = 128

go


CREATE VIEW ts_persona (
        secuencial,            tipo_transaccion,      alterno,            clase,             fecha,
        usuario,               terminal,              srv,                lsrv,              persona,
        nombre,                p_apellido,            s_apellido,         sexo,              cedula,
        pasaporte,             tipo_ced,              pais,               profesion,         estado_civil, actividad,
        num_cargas,            nivel_ing,             nivel_egr,          tipo,              filial,
        oficina,               casilla_def,           tipo_dp,            fecha_nac,         grupo,
        oficial,               mala_referencia,       comentario,         retencion,         fecha_mod,
        fecha_emision,         fecha_expira,          asosciada,          referido,          sector,
        nit_per,               ciudad_nac,            lugar_doc,          nivel_estudio,     tipo_vivienda,
        calif_cliente,         doc_validado,          rep_superban,       vinculacion,       tipo_vinculacion,
        exc_sipla,             exc_por2,              digito,             depa_nac,          pais_emi,
        depa_emi,              categoria,             pasivo,             pensionado,        num_empleados,
        pas_finan,             fpas_finan,            opinternac,         tipo_empleo,       ts_accion,
        ts_estrato,            ts_fecha_negocio,      ts_ofi_prod,        ts_procedencia,    ts_num_hijos,
        recur_pub,             influencia,            pers_pub,           victima,           vigencia,
        oficial_asig,          tipo_asig,             oficial_geo,        carga_dir,         oficina_prod,
        num_hijos
) as
select  ts_secuencial,         ts_tipo_transaccion,   ts_cod_alterno,     ts_clase,          ts_fecha,
        ts_usuario,            ts_terminal,           ts_srv,             ts_lsrv,           ts_ente,
        ts_nombre,             ts_p_apellido,         ts_s_apellido,      ts_sexo,           ts_cedruc,
        ts_pasaporte,          ts_tipo_ced,           ts_pais,            ts_profesion,      ts_estado_civil, ts_actividad,
        ts_num_cargas,         ts_ingresos,           ts_egresos,         ts_tipo,           ts_filial,
        ts_oficina,            ts_casilla,            ts_tipo_dp,         ts_fecha_nac,      ts_grupo,
        ts_funcionario,        ts_dinero,             ts_observacion,     ts_posicion,       ts_fecha_modificacion,
        ts_fecha_emision,      ts_fecha_expira,       ts_asosciada,       ts_referido,       ts_sector,
        ts_nit_per,            ts_ciudad_nac,         ts_lugar_doc,       ts_nivel_estudio,  ts_tipo_vivienda,
        ts_calif_cliente,      ts_doc_validado,       ts_rep_superban,    ts_vinculacion,    ts_tipo_vinculacion,
        ts_exc_sipla,          ts_exc_por2,           ts_digito,          ts_cod_tbl_inf,    ts_ofic_vinc,
        ts_departamento,       ts_categoria,          ts_gravada,         ts_mandat,         ts_num_empleados,
        ts_pas_finan,          ts_fpas_finan,         ts_garantia,        ts_tipo_empleo,    ts_abreviatura,
        ts_estado_ref,         ts_fec_inicio,         ts_o_departamento,  ts_origen,         ts_numero,
        ts_toperacion,         ts_estatus,            ts_nacional,        ts_rural_urbano,   ts_tipo_alerta,
        ts_codigo_mr,          ts_jz,                 ts_derecha,         ts_nivel,          ts_registro,
        ts_num_hijos
from cl_tran_servicio
where   ts_tipo_transaccion = 103
or      ts_tipo_transaccion = 104
or      ts_tipo_transaccion = 192
or      ts_tipo_transaccion = 1288
or      ts_tipo_transaccion = 15424


go


CREATE VIEW ts_otros_ingresos (
       secuencial,       tipo_transaccion,    clase,       fecha,
       usuario,          terminal,            srv,         lsrv,
       ente,             tipo,                valor,       descripcion,
       compania,         num_poliza,          moneda,      usuario2,
       fecha_ingreso,    fecha_modifi,        estado,      cdescr
) as
select ts_secuencial,    ts_tipo_transaccion, ts_clase,    ts_fecha,
       ts_usuario,       ts_terminal,         ts_srv,      ts_lsrv,
       ts_ente,          ts_toperacion,       monto,       ts_descripcion,
       ts_rep,           ts_matricula,        ts_filial,   ts_login,
       ts_fecha_ingreso, ts_fecha_modifi,     ts_posicion, ts_codigocat
from   cl_tran_servicio
where  ts_tipo_transaccion = 1319
or     ts_tipo_transaccion = 1320
or     ts_tipo_transaccion = 1321

go

CREATE VIEW ts_origen_fondos
(
    secuencial,             tipo_transaccion,       clase,          fecha,
    usuario,                terminal,               srv,            lsrv,
    ente,                   origen_fondos,          producto,       numero,
    fecha_registro,         fecha_modificacion,     funcionario,    vigencia
)
as
select
    ts_secuencial,      ts_tipo_transaccion,    ts_clase,       ts_fecha,
    ts_usuario,         ts_terminal,            ts_srv,         ts_lsrv,
    ts_ente,            ts_observacion,         ts_producto,    ts_casilla,
    ts_fecha_ingreso,   ts_fecha_modifi,        ts_login,   ts_tipo_alerta
from    cl_tran_servicio
where   ts_tipo_transaccion = 156
or      ts_tipo_transaccion = 157
or      ts_tipo_transaccion = 158


go

CREATE VIEW ts_oficna_ente
           (secuencial,    tipo_transaccion,    clase,
            fecha,         usuario,             terminal,
            srv,           lsrv,            ente,
            oficina,       fecha_mod
           )
  as select ts_secuencial, ts_tipo_transaccion, ts_clase,
            ts_fecha,      ts_usuario,          ts_terminal,
            ts_srv,        ts_lsrv,             ts_ente,
            ts_oficina,    ts_fecha_modifi
from  cl_tran_servicio
where ts_tipo_transaccion = 1009

go


CREATE VIEW ts_objeto_tmp (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    compania, secuencial2, linea, usuario2, terminal2
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_empresa, ts_num_cargas, ts_observacion, ts_login, ts_descripcion
from cl_tran_servicio
where   ts_tipo_transaccion = 121

go

CREATE VIEW ts_objeto_com (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    compania
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_ente
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1157
    or  ts_tipo_transaccion = 1158

go

CREATE VIEW ts_objeto (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    compania
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_empresa
from   cl_tran_servicio
where  ts_tipo_transaccion = 1157
or     ts_tipo_transaccion = 1158

go

/* ts_natjur */
CREATE VIEW ts_natjur (
        secuencial, tipo_transaccion, clase, fecha,
        usuario, terminal, srv, lsrv,
        codigo, descripcion, tnatjur, estado
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
        ts_tbien, ts_descripcion, ts_mandat, ts_estado
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1386
    or  ts_tipo_transaccion = 1387
    or  ts_tipo_transaccion = 1388

go

CREATE VIEW ts_narcos (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,nombre,cedula,pasaporte,nacionalidad,
    circular,fecha_na,provincia,juzgado,juicio,codigo)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_nombre, ts_cedruc, ts_pasaporte, ts_nacionalidad, ts_telefono_1,
       ts_telefono_2, ts_casilla,ts_telefono_3,ts_fecha_cov,ts_codigo
from   cl_tran_servicio
where  ts_tipo_transaccion = 1263
or     ts_tipo_transaccion = 1264
or     ts_tipo_transaccion = 1265

go


CREATE VIEW ts_mercado_objetivo_cliente (
       secuencial,         tipo_transaccion,      clase,          fecha,
       usuario,            terminal,              srv,            lsrv,
       ente,               mercado,               subtipo,        banca,
       fecha_modificacion, segmento,              microsegmento,  actprincipal,
       actividad1,         actividad2
)
as
select ts_secuencial,         ts_tipo_transaccion,   ts_clase,       ts_fecha,
       ts_usuario,            ts_terminal,           ts_srv,         ts_lsrv,
       ts_ente,               ts_tipo,               ts_actividad,   ts_posicion,
       ts_fecha_modificacion, ts_categoria,          ts_restado,     ts_tipo_empleo,
       ts_tipo_alerta,        ts_sospechoso
from   cl_tran_servicio
where  ts_tipo_transaccion = 1495
or     ts_tipo_transaccion = 1496

go

CREATE VIEW ts_mercado (
       secuencial, tipo_transaccion, clase,       fecha,
       usuario,    terminal,         srv,         lsrv,
       estado,     ced_ruc,          nombre,      fecha_ref,
       origen,     calificador,      calificacion,observacion,
       codigo,     documento,  ref_estado)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_estado, ts_cedruc, ts_nombre, ts_fecha_nac,ts_origen,ts_calificador,
       ts_calificacion, ts_observaciones,
       ts_codigo_mr,ts_documento,ts_restado
from   cl_tran_servicio
where  ts_tipo_transaccion = 1285
or     ts_tipo_transaccion = 1286
or     ts_tipo_transaccion = 1287

go


CREATE VIEW ts_mala_ref (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, mala_ref, treferencia, fecha_registro,
    observacion, login
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente, ts_nomina, ts_telefono_1, ts_fecha_reg,
       ts_observacion, ts_login
from   cl_tran_servicio
where  ts_tipo_transaccion = 1148
or     ts_tipo_transaccion = 1149

go


CREATE VIEW ts_instancia (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    relacion, ente_i, ente_d,
    lado, fecha2
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario,    ts_terminal, ts_srv,  ts_lsrv,
       ts_grupo,      ts_ente, ts_codigo,
       ts_garantia,   ts_fecha_emision
from  cl_tran_servicio
where ts_tipo_transaccion = 1367
or    ts_tipo_transaccion = 1368

go

CREATE VIEW ts_historico_vinculos (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
        codigo_cliente, codigo_producto,numero_operacion,
        fecha_terminacion,fecha_inicio,motivo_terminacion,
        tipo_vinculacion,login,oficina_vinculacion)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
        ts_ente, ts_filial,ts_compania,
        ts_fecha_expira,ts_fecha_emision,ts_motiv_term,
        ts_mandat,ts_usuario,ts_ofic_vinc
from    cl_tran_servicio
where   ts_tipo_transaccion = 1342

go

CREATE VIEW ts_grupo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    grupo, nombre, representante,
    ruc, oficial,compania
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_grupo, ts_nombre, ts_rep_legal,
    ts_cedruc, ts_funcionario,ts_ente
from    cl_tran_servicio
where   ts_tipo_transaccion = 107
or      ts_tipo_transaccion = 108
or      ts_tipo_transaccion = 194


go

CREATE VIEW ts_forma_homologa (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    producto, forma_homologa, estado, fecha_registro,
    fecha_modificacion)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_producto, ts_forma_homologa, ts_estado,
        ts_fecha_registro, ts_fecha_modificacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1464
or     ts_tipo_transaccion = 1465
or     ts_tipo_transaccion = 1466
or     ts_tipo_transaccion = 1467

go

CREATE VIEW ts_forma_extractos(
secuencial,     tipo_transaccion,    clase,
fecha,          usuario,             terminal,
srv,            lsrv,                ente,
forma_ext,      codigo,              oficina,
fecha_registro, observacion)
as
select
ts_secuencial,  ts_tipo_transaccion, ts_clase,
ts_fecha,       ts_usuario,          ts_terminal,
ts_srv,         ts_lsrv,             ts_ente,
ts_tipo,        ts_codigo,           ts_oficina,
ts_fecha_reg,   ts_observaciondir
from    cl_tran_servicio
where   ts_tipo_transaccion = 1609


go

CREATE VIEW ts_fecha_tipo_doc (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    codigo,
    sexo,
    signo,
    valor
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_camara,
    ts_sexo,
    ts_telefono,
    ts_codigo
from    cl_tran_servicio
where   ts_tipo_transaccion = 1113
or      ts_tipo_transaccion = 1111
or      ts_tipo_transaccion = 1112

go

CREATE VIEW ts_familia (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    persona, nombre, p_apellido, s_apellido,
    sexo, fecha_nac, cedruc, tipo_ced,
    vigencia,verificado, fecha_verificacion, funcionario,

    fecha_emision,      ocupacio,   dir_empresa

)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente, ts_nombre, ts_p_apellido, ts_s_apellido,
       ts_sexo, ts_fecha_nac, ts_cedruc, ts_tipo_ced,
       ts_tipo, ts_posicion, ts_fecha_modificacion, ts_observacion,

    ts_fecha_escritura, ts_camara,  ts_desc_direc

from   cl_tran_servicio
where  ts_tipo_transaccion = 1301
or     ts_tipo_transaccion = 1302
or     ts_tipo_transaccion = 1303
or     ts_tipo_transaccion = 1304
or     ts_tipo_transaccion = 1305

go

CREATE VIEW ts_estatuto_com (
        secuencial,    tipo_transaccion,    clase,    fecha,
        usuario,       terminal,            srv,      lsrv,
        compania
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,   ts_lsrv,
        ts_ente
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1155
    or  ts_tipo_transaccion = 1156

go

CREATE VIEW ts_estatuto (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    compania
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_empresa
from   cl_tran_servicio
where  ts_tipo_transaccion = 1155
or     ts_tipo_transaccion = 1156

go

/*
CREATE VIEW ts_direccion (
        secuencial,    tipo_transaccion,    clase,             fecha,
        usuario,       terminal,            srv,               lsrv,
        ente,          direccion,           descripcion,       vigencia,
        sector,        zona,                parroquia,         ciudad,
        tipo,          oficina,             verificado,        barrio,
        provincia,     rural_urbano,        observacion,       georeferenciar,
        extracto_c012
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase,          ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,            ts_lsrv,
        ts_ente,       ts_direccion,        ts_descripcion,    ts_posicion,
        ts_sector,     ts_zona,             ts_parroquia,      ts_ciudad,
        ts_tipo,       ts_sucursal,         ts_tipo_dp,        ts_barrio,
        ts_provincia,  ts_rural_urbano,     ts_observaciondir, ts_estado,
        ts_canal_extracto
from    cl_tran_servicio
where   ts_tipo_transaccion = 109
or      ts_tipo_transaccion = 110
or      ts_tipo_transaccion = 1226
or      ts_tipo_transaccion = 1217
*/

go

CREATE VIEW ts_det_embargo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, secuencial2, sec_interno, fecha2,
    producto, subproducto, monto, tipo_bloqueo,
    estado_levantamiento, fecha_levantamiento, observacion,
    num_cuenta, procesa_cheque, sec_depjud
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente, ts_empresa, ts_grupo, ts_fecha_emision,
       ts_rep_legal, ts_direccion, monto, ts_num_cargas,
       ts_tipo, ts_fec_exp_ref, ts_descripcion,
       ts_casilla,ts_garantia, ts_codigo
from   cl_tran_servicio
where  ts_tipo_transaccion = 1430
or     ts_tipo_transaccion = 1442
or     ts_tipo_transaccion = 1445
or     ts_tipo_transaccion = 1423

go


CREATE VIEW ts_def_tablas (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    grp_inf, cod_tbl_inf,desc_tbl_inf)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_grp_inf, ts_cod_tbl_inf, ts_desc_tbl_inf
from    cl_tran_servicio
where   ts_tipo_transaccion = 1322
or      ts_tipo_transaccion = 1323
or      ts_tipo_transaccion = 1324
or      ts_tipo_transaccion = 1325

go

CREATE VIEW ts_def_campos (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    grp_inf, cod_tbl_inf,cod_atr,desc_atr,mandat)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_grp_inf, ts_cod_tbl_inf, ts_cod_atr,ts_desc_atr,ts_mandat
from    cl_tran_servicio
where   ts_tipo_transaccion = 1326
or      ts_tipo_transaccion = 1327
or      ts_tipo_transaccion = 1328
or      ts_tipo_transaccion = 1329

go

CREATE VIEW ts_dat_merc_ente (
        secuencial,    tipo_transaccion,    clase,          fecha,
        usuario,       terminal,            srv,            lsrv,
        ente,          grp_inf,             cod_tbl_inf,
        cod_atrib_inf, cod_vlr,             fecha2
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase,       ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,         ts_lsrv,
        ts_ente,       ts_grp_inf,          ts_cod_tbl_inf,
        ts_cod_atr,    ts_referido,         ts_fecha_exp
from    cl_tran_servicio
where   ts_tipo_transaccion = 1332
or      ts_tipo_transaccion = 1333
or      ts_tipo_transaccion = 1334

go

CREATE VIEW ts_cuenta (
    secuencial, tipo_transaccion, clase,     fecha,
    usuario,    terminal,         srv,       lsrv,
    cuenta,     descripcion,      categoria, estado
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,   ts_lsrv,
        ts_empresa,    ts_valor,            ts_tipo,  ts_estado
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1180
    or  ts_tipo_transaccion = 1220
    or  ts_tipo_transaccion = 1221

go

CREATE VIEW ts_covinco (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    estado, ced_ruc, nombre, af,jz,sb,fecha_cov,codigo)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_estado, ts_cedruc, ts_nombre, ts_af, ts_jz, ts_sb, ts_fecha_cov,
       ts_codigo
from   cl_tran_servicio
where  ts_tipo_transaccion = 1258
or     ts_tipo_transaccion = 1259
or     ts_tipo_transaccion = 1260

go

-- Ajustar vista


CREATE VIEW ts_contacto (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, contacto, nombre, cargo, telefono,
    direccioi, verificado, fecha_ver, funcionario,
    direccion, email, registrado, modificado
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario,    ts_terminal, ts_srv, ts_lsrv,
       ts_ente,       ts_num_cargas, ts_nombre, ts_compania, ts_telefono_ref,
       ts_direc,      ts_doc_validado, ts_fecha_vcto, ts_login,
       ts_observacion, ts_descripcion, ts_fecha_ingreso, ts_fecha_modifi
from  cl_tran_servicio
where ts_tipo_transaccion = 1354

go

CREATE VIEW ts_compania (
    secuencial,     tipo_transaccion,   clase,          fecha,
    usuario,        terminal,       srv,            lsrv,
    compania,       nombre,         ruc,            actividad,
    posicion,       grupo,          rep_legal,      activo,
    pasivo,         tipo,           filial,         pais,
    oficina,        casilla_def,        tipo_dp,        es_grupo,
    retencion,      fecha_mod,      mala_referencia,    comentario,
    oficial,        capital_social,     reserva_legal,      fecha_const,
    nombre_completo,    plazo,          direccion_domicilio,    fecha_inscrp,
    fecha_aum_capital,  asosciada,      referido,       sector,
    tipo_nit,       tipo_soc,       fecha_emision,      lugar_doc,
    total_activos,  num_empleados,      sigla,          rep_superban,
    doc_validado,   escritura,      notaria,        ciudad,
    fecha_exp,      fecha_vcto,         camara,         registro,
    grado_soc,      vinculacion,        tipo_vinculacion,   exc_sipla,
    nivel_ing,      nivel_egr,      exc_por2,       categoria,
    pasivo1,        pas_finan,      fpas_finan,         opinternac,
    numsuc,     vigilada,       vigencia

)
as
select
    ts_secuencial,  ts_tipo_transaccion,    ts_clase,       ts_fecha,
    ts_usuario,     ts_terminal,        ts_srv,         ts_lsrv,
    ts_ente,        ts_nombre,      ts_cedruc,      ts_actividad,
    ts_posicion,    ts_grupo,       ts_rep_legal,       ts_activo,
    ts_pasivo,      ts_tipo,        ts_filial,      ts_pais,


    ts_oficina,     ts_casilla,         ts_tipo_dp,         ts_dinero,
    ts_estado_civil,    ts_fecha_modificacion,  ts_abreviatura,     ts_observacion,
    ts_funcionario, ts_saldo_minimo,    ts_costo,       ts_fecha_nac,
    ts_nombre_completo, ts_numero,      ts_direccion,       ts_fecha_reg,
    ts_fecha_emision,   ts_asosciada,       ts_referido,        ts_sector,
    ts_tipo_nit,    ts_tipo_soc,        ts_fecha_emision,   ts_lugar_doc,
    ts_total_activos,   ts_num_empleados,   ts_sigla,       ts_rep_superban,
    ts_doc_validado,    ts_escritura,       ts_notaria,         ts_ciudad_bien,
    ts_fecha_exp,   ts_fecha_vcto,      ts_camara,      ts_registro,
    ts_grado_soc,   ts_vinculacion,     ts_tipo_vinculacion,    ts_exc_sipla,
    ts_ingresos,    ts_egresos,     ts_exc_por2,        ts_categoria,
    ts_gravada,     ts_pas_finan,       ts_fpas_finan,      ts_garantia,
    ts_num_cargas,  ts_estado_ref,      ts_tipo_alerta
from    cl_tran_servicio
where   ts_tipo_transaccion = 105
or      ts_tipo_transaccion = 106
or      ts_tipo_transaccion = 193
or      ts_tipo_transaccion = 1240


go


CREATE VIEW ts_CNB (
        secuencial,            tipo_transaccion,      alterno,            clase,             fecha,
        usuario,               terminal,              srv,                lsrv,              persona,
        nombre,                p_apellido,            s_apellido,         ofiCNB,            Estado,
        fecha_mod,             oficina_org
        )
as
select  ts_secuencial,         ts_tipo_transaccion,   ts_cod_alterno,     ts_clase,          ts_fecha,
        ts_usuario,            ts_terminal,           ts_srv,             ts_lsrv,           ts_ente,
        ts_nombre,             ts_p_apellido,         ts_s_apellido,      ts_oficina,        ts_asosciada,
        ts_fecha_escritura,    ts_ciudad
from cl_tran_servicio
where   ts_tipo_transaccion = 100
or      ts_tipo_transaccion = 167
or      ts_tipo_transaccion = 172


go

CREATE VIEW ts_cliente_grupo (
    secuencial,tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    grupo, ente, fecha_reg)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_grupo, ts_ente, ts_fecha_reg
from   cl_tran_servicio
where  ts_tipo_transaccion = 1160
or     ts_tipo_transaccion = 1317

go

CREATE VIEW ts_cia_liquidacion (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    codigo, nombre, tipo, problema, referencia, ced_ruc, fecha_reg)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_ente, ts_nombre, ts_tipo, ts_actividad, ts_descripcion,
    ts_cedruc, ts_fecha_nac
from    cl_tran_servicio
where   ts_tipo_transaccion = 1270
or      ts_tipo_transaccion = 1271
or      ts_tipo_transaccion = 1272

go

/* ts_categoria */
CREATE VIEW ts_categoria (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    categoria, descripcion, pcategoria, estado
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_tipo, ts_desc_atr, ts_cod_atr, ts_estado
   from cl_tran_servicio
 where  ts_tipo_transaccion = 1410
    or  ts_tipo_transaccion = 1411
    or  ts_tipo_transaccion = 1412

go

CREATE VIEW ts_casilla (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, casilla, valor, tipo, ciudad,
    provincia, sucursal, emp_postal
)
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
       ts_ente, ts_tabla, ts_valor, ts_tipo, ts_ciudad,
       ts_provincia,ts_sucursal, ts_emp_postal

from   cl_tran_servicio
where  ts_tipo_transaccion = 173
or     ts_tipo_transaccion = 174
or     ts_tipo_transaccion = 1128

go

CREATE VIEW ts_cab_embargo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    ente, secuencial2, fecha2, ts_fecha_ofi,
    oficio, solicitante, demandante, monto,
    estado, tipo_proceso, autorizante, saldo_pdte,
    debita_cta, oficina, tipo_persona, juzgado,
    concepto, oficina_destino, tipo_doc_demandante, numero_doc_demandante,
    nombre_demandante, apellido_demandante, cuenta_especifica, nro_cta_especifica,
    reversado, sec_depjud, fecha_reversa, usuario_rev,
    observacion, tipo_doc_solicitante, numero_doc_solicitante, producto, mmi
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_ente, ts_registro, ts_fecha_exp, ts_fecha_vcto,
    ts_matricula, ts_rep, ts_descripcion, monto,
    ts_asosciada, ts_codigocat, ts_login, ts_val_aval,
    ts_rep_superban, ts_oficina, ts_garantia, ts_telefono,
    ts_sector, ts_tipo_soc, ts_tipo, ts_pasaporte,
    ts_casilla, ts_num_poliza, ts_mandat, ts_emp_postal,
    ts_doc_validado, ts_empresa, ts_fecha_ingreso, ts_sucursal_ref,
    ts_nombre, ts_reg_ope, ts_telefono_ref, ts_sigla, ts_desc_ingresos
from cl_tran_servicio
where   ts_tipo_transaccion = 1423
or ts_tipo_transaccion = 1432
or ts_tipo_transaccion = 1435
or ts_tipo_transaccion = 1442
or ts_tipo_transaccion = 1445
or ts_tipo_transaccion = 1447
or ts_tipo_transaccion = 1471

go

/* ts_bandom */
CREATE VIEW ts_bandom (
            secuencial,tipo_transaccion,clase,fecha,
            usuario,terminal,srv,lsrv,ente,
            servicio,fecha_modificacion,funcionario
)
as
select ts_secuencial,ts_tipo_transaccion,ts_clase,ts_fecha,
       ts_usuario,ts_terminal,ts_srv,ts_lsrv,ts_ente,
       ts_tipo,ts_fecha_modifi,ts_login
from  cl_tran_servicio
where  ts_tipo_transaccion = 1437
    or ts_tipo_transaccion = 1438
    or ts_tipo_transaccion = 1439

go


CREATE VIEW ts_balance_tmp (
        secuencial,    tipo_transaccion,    clase,         fecha,
        usuario,       terminal,            srv,           lsrv,
        tbalance,      cliente,             anio,          usuario2,
        term,          clase2,              fecha_corte,   alterno
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase,      ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,        ts_lsrv,
        ts_producto,   ts_ente,             ts_pais,       ts_login,
        ts_compania,   ts_garantia,         ts_fecha_vcto, ts_cod_alterno
from    cl_tran_servicio
where   ts_tipo_transaccion = 1166

go

CREATE VIEW ts_balance (
        secuencial,    tipo_transaccion,    clase,       fecha,
        usuario,       terminal,            srv,         lsrv,
        oficina,       cliente,             balance,     tbalance,
        anio,          clase_ba,            fecha_corte, alterno
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase,     ts_fecha,
        ts_usuario,    ts_terminal,         ts_srv,       ts_lsrv,
        ts_oficina,    ts_ente,             ts_pais,      ts_codigocat,
        ts_ciudad,     ts_tipo_dp,          ts_fecha_reg, ts_cod_alterno
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1159
    or  ts_tipo_transaccion = 1212
    or  ts_tipo_transaccion = 1213

go

CREATE VIEW ts_aut_sarlaft_lista (
       secuencial,           tipo_transaccion,         clase,           fecha,
       usuario,              terminal,                 srv,             lsrv,
       tipo_documento,       ced_ruc,                  nombre,          fecha_ref,
       origen,               estado,                   tipo_aprobacion, Descr_aprobacion,
       estado_autorizacion,  descr_autorizacion,       observacion,     fecha_mod,
       ref_estado ,          oficina )
as
select ts_secuencial,        ts_tipo_transaccion,      ts_tclase,        ts_fecha,
       ts_usuario,           ts_terminal,              ts_srv,           ts_lsrv,
       ts_tipo_ced,          ts_cedruc,                ts_nombre,        ts_fecha_ref,
       ts_origen,            ts_estado_ref,            ts_tipo ,         ts_descripcion,
       ts_clase,             ts_calificacion,          ts_observaciones, ts_fecha_mod,
       ts_restado ,          ts_oficina
from   cl_tran_servicio
where  ts_tipo_transaccion = 1046
or     ts_tipo_transaccion = 1047
or     ts_tipo_transaccion = 1048

go

CREATE VIEW ts_atributo (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    filial, servicio, perfil,
    atributo, minimo, maximo
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_filial, ts_cargo, ts_provincia,
    ts_compania, ts_descripcion, ts_desc_atr
from  cl_tran_servicio
where ts_tipo_transaccion = 1165
or    ts_tipo_transaccion = 1204

go

CREATE VIEW ts_at_relacion (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    relacion, atributo, descripcion, tdato
) as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
    ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_cod_alterno, ts_secuencia, ts_descripcion, ts_compania
from  cl_tran_servicio
where ts_tipo_transaccion = 1164
or    ts_tipo_transaccion = 1200

go

CREATE VIEW ts_at_instancia (
       secuencial,    tipo_transaccion,    clase,     fecha,
       usuario,       terminal,            srv,       lsrv,
       relacion,      ente_i,              ente_d,    atributo,
       valor
) as
select ts_secuencial, ts_tipo_transaccion, ts_clase,  ts_fecha,
       ts_usuario,    ts_terminal,         ts_srv,    ts_lsrv,
       ts_grupo,      ts_ente,             ts_codigo, ts_secuencia,
       ts_observacion
from  cl_tran_servicio
where ts_tipo_transaccion = 1161
or    ts_tipo_transaccion = 1162
or    ts_tipo_transaccion = 1163

go

CREATE VIEW ts_area_inf (
    secuencial, tipo_transaccion, fecha,
    usuario,    terminal,         srv,
    lsrv,       clase,            oficina,
    ciudad,     oficina_par,      descripcion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_fecha,
       ts_usuario,    ts_terminal,         ts_srv,
       ts_lsrv,       ts_clase,            ts_oficina,
       ts_izquierda,  ts_derecha,          ts_observacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1030
or     ts_tipo_transaccion = 1031

go


/* ts_aplica_tipo_persona */
CREATE VIEW ts_aplica_tipo_persona (
        secuencial, tipo_transaccion, clase, fecha,
        usuario, terminal, srv, lsrv,
        tipo_persona, nombre_obj, tipo, aplica, sec_interno,tipo_objeto
)
as
select  ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
        ts_usuario, ts_terminal, ts_srv, ts_lsrv,
        ts_tbien,ts_descripcion, ts_mandat, ts_estado, ts_notaria, ts_totaliza
  from  cl_tran_servicio
 where  ts_tipo_transaccion = 1405
    or  ts_tipo_transaccion = 1406
    or  ts_tipo_transaccion = 1407

go

CREATE VIEW ts_alianza (
secuencial,          tipo_transaccion,   cod_alterno,
clase,               fecha,              usuario,
terminal,            srv,                lsrv,
ente,                nemonico,           tipo_alianza,
fecha_creacion,      fecha_fija,         fecha_inicio,
fecha_fin,           estado_alianza,     tipo_credito,
restringue_uso ,     num_uso,            monto_promedio,
tipo_recaudador,     aplica_mora,        dias_gracia,
tasa_mora,           signo_spread,       valor_spread,
cuenta_bancaria,     debito_aut,         dispersion_fondos,
forma_des,           des_cta_afi,        gmf_banco,
porcentaje_gmfbanco, fecha_pago,         dia_pago,
exonera_estudio,     porcentaje_exonera, mantiene_condiciones,
observacion_alianza
) as
select
ts_secuencial,          ts_tipo_transaccion,   ts_cod_alterno,
ts_clase,               ts_fecha,              ts_usuario,
ts_terminal,            ts_srv,                ts_lsrv,
ts_ente,                ts_abreviatura,        ts_tipo,
ts_fecha_emision,       ts_fecha_fija,         ts_fecha_ingreso,
ts_fecha_expira,        ts_estado,             ts_tipo_credito,
ts_restringue_uso,      ts_num_cargas,         monto,
ts_tipo_recaudador,     ts_aplica_mora,        ts_dias_gracia,
ts_tasa_mora,           ts_signo_spread,       ts_valor_spread,
ts_cuenta_bancaria,     ts_debito_aut,         ts_dispersion_fondos,
ts_forma_des,           ts_des_cta_afi,        ts_gmf_banco,
ts_porcentaje_gmfbanco, ts_fecha_pago,         ts_dia_pago,
ts_exonera_estudio,     ts_porcentaje_exonera, ts_mantiene_condiciones,
ts_observacion
from cl_tran_servicio
where  ts_tipo_transaccion = 1338  --insercion
or     ts_tipo_transaccion =  1339  --modificacion


go

CREATE VIEW ts_alertas_zonal (
       of_oficina, of_nombre,     of_zona,           of_cob,           of_regional,
       al_cliente, al_sospechoso, al_fecha_registro, al_fecha_revision
    )
as
select of_oficina, of_nombre,     of_zona,           of_cob,           of_regional,
       al_cliente, al_sospechoso, al_fecha_registro, al_fecha_revision
from   cobis..cl_alerta,
       cobis..cl_ente,
       cobis..cl_oficina
where al_cliente = en_ente
and   en_oficina = of_oficina

go

CREATE VIEW ts_alerta (
    secuencial, tipo_transaccion, clase, fecha,
    usuario, terminal, srv, lsrv,
    codigo,cliente,tipo_alerta,sospechoso,observacion,
    fecha_registro,fecha_revision
    )
as
select ts_secuencial, ts_tipo_transaccion, ts_clase, ts_fecha,
       ts_usuario, ts_terminal, ts_srv, ts_lsrv,
    ts_codigo,ts_ente,ts_tipo_alerta,ts_sospechoso,ts_observacion,
    ts_fecha_registro,ts_fecha_modificacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1461
or     ts_tipo_transaccion = 1462
or     ts_tipo_transaccion = 1463

go


CREATE VIEW ts_actividad_sector (
    secuencial, tipo_transaccion, fecha,
    usuario,    terminal,         srv,
    lsrv,       clase,            oficina,
    actividad,  descripcion
)
as
select ts_secuencial, ts_tipo_transaccion, ts_fecha,
       ts_usuario,    ts_terminal,         ts_srv,
       ts_lsrv,       ts_clase,            ts_oficina,
       ts_actividad,  ts_observacion
from   cl_tran_servicio
where  ts_tipo_transaccion = 1031
or     ts_tipo_transaccion = 1032
or     ts_tipo_transaccion = 1033

go