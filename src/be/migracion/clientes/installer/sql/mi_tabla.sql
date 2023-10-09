/************************************************************************/
/*    ARCHIVO:         mi_tabla.sql                                     */
/*    NOMBRE LOGICO:   mi_tabla.sql                                     */
/*    PRODUCTO:        CLIENTES                                         */
/************************************************************************/
/*                     IMPORTANTE                                       */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                     PROPOSITO                                        */
/*   Script de creacion de tablas para proceso de migracion de clientes */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR                   RAZON                   */
/*      25/08/2016      Ignacio Yupa            Emision Inicial         */  
/************************************************************************/

USE cob_externos
go

--TABLAS EXT

print '*****  cl_ente_ext'
if not object_id('cl_ente_ext') is null
drop table cl_ente_ext
go

create table cl_ente_ext(
en_ente                 INT NOT NULL,                   
en_nombre               VARCHAR (64) NOT NULL,          
en_subtipo              CHAR (1) NOT NULL,              
en_filial               TINYINT NOT NULL,               
en_oficina              SMALLINT NOT NULL,              
en_ced_ruc              VARCHAR (30),                   
en_fecha_crea           DATETIME,                       
en_fecha_mod            DATETIME NOT NULL,              
en_direccion            TINYINT,                        
en_referencia           TINYINT,                        
en_casilla              TINYINT,                        
en_casilla_def          VARCHAR (24),                   
en_tipo_dp              CHAR (1),                       
en_balance              SMALLINT,                       
en_grupo                INT,                            
en_pais                 SMALLINT,                       
en_oficial              SMALLINT,                       
en_actividad            VARCHAR (10),                   
en_retencion            CHAR (1) NOT NULL,              
en_mala_referencia      CHAR (1) NOT NULL,              
en_comentario           VARCHAR (254),                  
en_cont_malas           SMALLINT,                       
s_tipo_soc_hecho        VARCHAR (10),                   
en_tipo_ced             CHAR (2),                       
en_digito               CHAR (1),                       
en_sector               VARCHAR (10),                   
en_referido             SMALLINT,                       
en_nit                  VARCHAR (30),                   
en_doc_validado         CHAR (1),                       
en_rep_superban         CHAR (1),                       
p_p_apellido            VARCHAR (16),                   
p_s_apellido            VARCHAR (16),                   
p_sexo                  CHAR (1),                       
p_fecha_nac             DATETIME,                       
p_ciudad_nac            INT,                            
p_lugar_doc             INT,                            
p_profesion             VARCHAR (10),                   
p_pasaporte             VARCHAR (20),                   
p_estado_civil          VARCHAR (10),                   
p_num_cargas            TINYINT,                        
p_num_hijos             TINYINT,                        
p_nivel_ing             MONEY,                          
p_nivel_egr             MONEY,                          
p_nivel_estudio         VARCHAR (10),                   
p_tipo_persona          VARCHAR (10),                   
p_tipo_vivienda         VARCHAR (10),                   
p_personal              TINYINT,                        
p_propiedad             TINYINT,                        
p_trabajo               TINYINT,                        
p_soc_hecho             TINYINT,                        
p_fecha_emision         DATETIME,                       
p_fecha_expira          DATETIME,                       
en_asosciada            VARCHAR (10),                   
c_posicion              VARCHAR (10),                   
c_tipo_compania         VARCHAR (10),                   
c_rep_legal             INT,                            
c_es_grupo              CHAR (1),                       
c_capital_social        MONEY,                          
c_fecha_const           DATETIME,                       
en_nomlar               VARCHAR (254),                  
c_plazo                 TINYINT,                        
c_direccion_domicilio   INT,                            
c_fecha_inscrp          DATETIME,                       
c_fecha_aum_capital     DATETIME,                       
c_cap_pagado            MONEY,                          
c_total_activos         MONEY,                          
c_num_empleados         SMALLINT,                       
c_sigla                 VARCHAR (25),                   
c_escritura             VARCHAR (10),                   
c_fecha_exp             DATETIME,                       
c_fecha_vcto            DATETIME,                       
c_registro              INT,                            
c_fecha_registro        DATETIME,                       
c_fecha_modif           DATETIME,                       
c_fecha_verif           DATETIME,                       
c_vigencia              VARCHAR (10),                   
c_verificado            CHAR (10),                      
c_funcionario           VARCHAR (14),                   
en_situacion_cliente    VARCHAR (10),                   
en_patrimonio_tec       MONEY,                          
en_fecha_patri_bruto    DATETIME,                       
en_vinculacion          CHAR (1),                       
en_tipo_vinculacion     VARCHAR (10),                   
en_oficial_sup          SMALLINT,                       
en_cliente              CHAR (1),                       
en_perfil_transaccional MONEY,                          
en_riesgo               CHAR (1),                       
en_estado_mig           CHAR (2)
)
go

CREATE UNIQUE CLUSTERED INDEX cl_ente_ext_Key
    ON cl_ente_ext (en_ente)
GO

CREATE INDEX cl_ente_idx1
    ON cl_ente_ext (en_grupo, en_ente, en_ced_ruc, en_tipo_ced)
GO

CREATE UNIQUE INDEX idocIdentidad
    ON cl_ente_ext (en_tipo_ced, en_ced_ruc)
GO

CREATE INDEX ien_fecha_crea
    ON cl_ente_ext (en_oficina, en_fecha_crea, en_filial, en_cliente)
GO

CREATE INDEX ien_nombre
    ON cl_ente_ext (p_p_apellido, p_s_apellido, en_nombre)
GO

CREATE INDEX ien_nomlar
    ON cl_ente_ext (en_nomlar)
GO

CREATE INDEX ien_subtipo
    ON cl_ente_ext (en_subtipo)
GO

CREATE INDEX ien_subtipo_cedruc
    ON cl_ente_ext (en_ced_ruc)
GO

print '*****  cl_direccion_ext' 
if not object_id('cl_direccion_ext') is null
drop table cl_direccion_ext
go

create table cl_direccion_ext(
di_ente                   int            not null,
di_direccion              tinyint        not null,
di_descripcion            varchar(254)   null,
di_parroquia              int            not null,
di_ciudad                 int            null,
di_tipo                   varchar(10)    not null,
di_telefono               tinyint        null,
di_sector                 varchar(10)    null,
di_zona                   varchar(10)    null,
di_oficina                smallint       null,
di_fecha_registro         datetime       not null,
di_fecha_modificacion     datetime       not null,
di_vigencia               varchar(10)    not null,
di_verificado             char(1)        not null,
di_funcionario            varchar(14)    null,
di_fecha_ver              datetime       null,
di_principal              char(1)        null,
di_barrio                 varchar(40)    null,
di_provincia              smallint       null
)
go

CREATE UNIQUE CLUSTERED INDEX cl_direccion_ext_Key
    ON cl_direccion_ext (di_ente, di_direccion)
GO

CREATE INDEX cl_direccion_ext_key3
    ON cl_direccion_ext (di_tipo, di_ciudad, di_parroquia, di_oficina)
GO

CREATE INDEX i_d_parroquia
    ON cl_direccion_ext (di_ciudad, di_parroquia)
GO

print '*****  cl_telefono_ext'
if not object_id('cl_telefono_ext') is null
drop table cl_telefono_ext
go

create table cl_telefono_ext(
te_ente                  int             not null,
te_direccion             tinyint         not null,
te_secuencial            tinyint         not null,
te_valor                 varchar(16)     null,
te_tipo_telefono         char(2)         not null
)
go

CREATE UNIQUE CLUSTERED INDEX cl_telefono_ext_Key
    ON cl_telefono_ext (te_ente, te_direccion, te_secuencial)
GO

CREATE INDEX i_t_tipo_telefono
    ON cl_telefono_ext (te_ente, te_tipo_telefono)
GO


print '*****  cl_ref_personal_ext'
if not object_id('cl_ref_personal_ext') is null
drop table cl_ref_personal_ext
go

create table cl_ref_personal_ext(
rp_persona             int               not null,
rp_referencia          tinyint           not null,
rp_nombre              varchar(20)       not null,
rp_p_apellido          varchar(20)       not null,
rp_s_apellido          varchar(20)       null,
rp_direccion           direccion         null,
rp_telefono_d          char(12)          null,
rp_telefono_e          char(12)          null,
rp_telefono_o          char(12)          null,
rp_parentesco          char(2)           not null,
rp_fecha_registro      datetime          not null,
rp_fecha_modificacion  datetime          not null,
rp_vigencia            char(1)           not null,
rp_verificacion        char(1)           not null,
rp_funcionario         varchar(14)       null,
rp_descripcion         varchar(64)       null,
rp_fecha_ver           datetime          null,
)

go

CREATE UNIQUE CLUSTERED INDEX cl_ref_personal_ext_Key
    ON cl_ref_personal_ext (rp_persona, rp_referencia)
GO

CREATE INDEX i_rp_parentesco
    ON cl_ref_personal_ext (rp_parentesco)
GO

print '*****  cl_trabajo_ext'
if not object_id('cl_trabajo_ext') is null
drop table cl_trabajo_ext
go

create table cl_trabajo_ext(
tr_persona            int               not null,
tr_trabajo            tinyint           not null,
tr_empresa            int               null,
tr_cargo              varchar(64)       not null,
tr_sueldo             money             null,
tr_moneda             tinyint           null,
tr_tipo               varchar(10)       null,
tr_fecha_registro     datetime          not null,
tr_fecha_modificacion datetime          not null,
tr_vigencia           char(1)           not null,
tr_fecha_ingreso      datetime          null,
tr_fecha_salida       datetime          null,
tr_verificado         char(1)           null,
tr_funcionario        varchar(14)       null,
tr_fecha_verificacion datetime          null
)

go

CREATE UNIQUE CLUSTERED INDEX cl_trabajo_ext_Key
    ON cl_trabajo_ext (tr_persona, tr_trabajo)
GO

print '*****  cl_refinh_ext'
if not object_id('cl_refinh_ext') is null
drop table cl_refinh_ext
go

create table cl_refinh_ext(
    in_codigo           INT NOT NULL,    
    in_ced_ruc      CHAR (13),
    in_nombre       VARCHAR (64) NOT NULL,
    in_fecha_ref    DATETIME NOT NULL,
    in_origen       catalogo NOT NULL,
    in_observacion  VARCHAR (255) NOT NULL,
    in_fecha_mod    DATETIME NOT NULL,
    in_subtipo      CHAR (1) NOT NULL,
    in_p_p_apellido VARCHAR (16),
    in_p_s_apellido VARCHAR (16),
    in_tipo_ced     CHAR (2),
    in_nomlar       CHAR (64),
    in_estado       catalogo,
    in_sexo         CHAR (1),    
    in_entid        INT
)
go

CREATE CLUSTERED INDEX iin_entid
    ON cl_refinh_ext (in_entid, in_codigo)
GO

CREATE INDEX cl_refinh_ext_Key
    ON cl_refinh_ext (in_nomlar, in_codigo)
GO

CREATE INDEX cl_refinh_ext_idx1
    ON cl_refinh_ext (in_nombre, in_fecha_ref, in_origen, in_nomlar, in_estado)
GO

CREATE INDEX iin_ced_ruc
    ON cl_refinh_ext (in_ced_ruc, in_origen DESC, in_fecha_ref, in_nomlar, in_estado)
GO

CREATE INDEX iin_fecha_mod
    ON cl_refinh_ext (in_fecha_mod)
GO

CREATE INDEX iin_in_ced_ruc
    ON cl_refinh_ext (in_ced_ruc)
GO


print '*****  cl_instancia_ext'
if not object_id('cl_instancia_ext') is null
drop table cl_instancia_ext
go
CREATE TABLE cl_instancia_ext
	(
	in_relacion SMALLINT NOT NULL,
	in_ente_i   INT NOT NULL,
	in_ente_d   INT NOT NULL,
	in_fecha    DATETIME NOT NULL
	)
GO
CREATE UNIQUE CLUSTERED INDEX cl_instancia_Key
	ON cl_instancia_ext (in_relacion,in_ente_i,in_ente_d)
GO
CREATE NONCLUSTERED INDEX in_ented_Key
	ON cl_instancia_ext (in_ente_d,in_ente_i)
GO
CREATE NONCLUSTERED INDEX in_entei_Key
	ON cl_instancia_ext (in_ente_i,in_ente_d)
GO




--TABLAS MIG

print '*****  cl_ente_mig'
if not object_id('cl_ente_mig') is null
drop table cl_ente_mig
go

create table cl_ente_mig(
en_ente                 INT NOT NULL,                   
en_nombre               VARCHAR (64) NOT NULL,          
en_subtipo              CHAR (1) NOT NULL,              
en_filial               TINYINT NOT NULL,               
en_oficina              SMALLINT NOT NULL,              
en_ced_ruc              VARCHAR (30),                   
en_fecha_crea           DATETIME,                       
en_fecha_mod            DATETIME NOT NULL,              
en_direccion            TINYINT,                        
en_referencia           TINYINT,                        
en_casilla              TINYINT,                        
en_casilla_def          VARCHAR (24),                   
en_tipo_dp              CHAR (1),                       
en_balance              SMALLINT,                       
en_grupo                INT,                            
en_pais                 SMALLINT,                       
en_oficial              SMALLINT,                       
en_actividad            VARCHAR (10),                   
en_retencion            CHAR (1) NOT NULL,              
en_mala_referencia      CHAR (1) NOT NULL,              
en_comentario           VARCHAR (254),                  
en_cont_malas           SMALLINT,                       
s_tipo_soc_hecho        VARCHAR (10),                   
en_tipo_ced             CHAR (2),                       
en_digito               CHAR (1),                       
en_sector               VARCHAR (10),                   
en_referido             SMALLINT,                       
en_nit                  VARCHAR (30),                   
en_doc_validado         CHAR (1),                       
en_rep_superban         CHAR (1),                       
p_p_apellido            VARCHAR (16),                   
p_s_apellido            VARCHAR (16),                   
p_sexo                  CHAR (1),                       
p_fecha_nac             DATETIME,                       
p_ciudad_nac            INT,                            
p_lugar_doc             INT,                            
p_profesion             VARCHAR (10),                   
p_pasaporte             VARCHAR (20),                   
p_estado_civil          VARCHAR (10),                   
p_num_cargas            TINYINT,                        
p_num_hijos             TINYINT,                        
p_nivel_ing             MONEY,                          
p_nivel_egr             MONEY,                          
p_nivel_estudio         VARCHAR (10),                   
p_tipo_persona          VARCHAR (10),                   
p_tipo_vivienda         VARCHAR (10),                   
p_personal              TINYINT,                        
p_propiedad             TINYINT,                        
p_trabajo               TINYINT,                        
p_soc_hecho             TINYINT,                        
p_fecha_emision         DATETIME,                       
p_fecha_expira          DATETIME,                       
en_asosciada            VARCHAR (10),                   
c_posicion              VARCHAR (10),                   
c_tipo_compania         VARCHAR (10),                   
c_rep_legal             INT,                            
c_es_grupo              CHAR (1),                       
c_capital_social        MONEY,                          
c_fecha_const           DATETIME,                       
en_nomlar               VARCHAR (254),                  
c_plazo                 TINYINT,                        
c_direccion_domicilio   INT,                            
c_fecha_inscrp          DATETIME,                       
c_fecha_aum_capital     DATETIME,                       
c_cap_pagado            MONEY,                          
c_total_activos         MONEY,                          
c_num_empleados         SMALLINT,                       
c_sigla                 VARCHAR (25),                   
c_escritura             VARCHAR (10),                   
c_fecha_exp             DATETIME,                       
c_fecha_vcto            DATETIME,                       
c_registro              INT,                            
c_fecha_registro        DATETIME,                       
c_fecha_modif           DATETIME,                       
c_fecha_verif           DATETIME,                       
c_vigencia              VARCHAR (10),                   
c_verificado            CHAR (10),                      
c_funcionario           VARCHAR (14),                   
en_situacion_cliente    VARCHAR (10),                   
en_patrimonio_tec       MONEY,                          
en_fecha_patri_bruto    DATETIME,                       
en_vinculacion          CHAR (1),                       
en_tipo_vinculacion     VARCHAR (10),                   
en_oficial_sup          SMALLINT,                       
en_cliente              CHAR (1),                       
en_perfil_transaccional MONEY,                          
en_riesgo               CHAR (1),                       
en_estado_mig           CHAR (2),                       
en_ente_mig             INT                             

)
--LOCK DATAROWS
go

CREATE UNIQUE CLUSTERED INDEX cl_ente_mig_Key
    ON cl_ente_mig (en_ente)
GO

CREATE INDEX en_estado_mig_key
    ON cl_ente_mig (en_estado_mig)
GO

CREATE INDEX cl_ente_idx1
    ON cl_ente_mig (en_grupo, en_ente, en_ced_ruc, en_tipo_ced)
GO

CREATE UNIQUE INDEX idocIdentidad
    ON cl_ente_mig (en_tipo_ced, en_ced_ruc)
GO

CREATE INDEX ien_fecha_crea
    ON cl_ente_mig (en_oficina, en_fecha_crea, en_filial, en_cliente)
GO

CREATE INDEX ien_nombre
    ON cl_ente_mig (p_p_apellido, p_s_apellido, en_nombre)
GO

CREATE INDEX ien_nomlar
    ON cl_ente_mig (en_nomlar)
GO

CREATE INDEX ien_subtipo
    ON cl_ente_mig (en_subtipo)
GO

CREATE INDEX ien_subtipo_cedruc
    ON cl_ente_mig (en_ced_ruc)
GO

print '*****  cl_direccion_mig' 
if not object_id('cl_direccion_mig') is null
drop table cl_direccion_mig
go

create table cl_direccion_mig(
di_ente                   int            not null,
di_direccion              tinyint        not null,
di_descripcion            varchar(254)   null,
di_parroquia              int            not null,
di_ciudad                 int            null,
di_tipo                   varchar(10)    not null,
di_telefono               tinyint        null,
di_sector                 varchar(10)    null,
di_zona                   varchar(10)    null,
di_oficina                smallint       null,
di_fecha_registro         datetime       not null,
di_fecha_modificacion     datetime       not null,
di_vigencia               varchar(10)    not null,
di_verificado             char(1)        not null,
di_funcionario            varchar(14)    null,
di_fecha_ver              datetime       null,
di_principal              char(1)        null,
di_barrio                 varchar(40)    null,
di_provincia              smallint       null,
di_estado_mig             char(2)        null,
di_ente_mig               int            null       
)
go

CREATE UNIQUE CLUSTERED INDEX cl_direccion_mig_Key
    ON cl_direccion_mig (di_ente, di_direccion)
GO

CREATE INDEX di_estado_mig_key
    ON cl_direccion_mig (di_estado_mig)
GO

CREATE INDEX cl_direccion_mig_key3
    ON cl_direccion_mig (di_tipo, di_ciudad, di_parroquia, di_oficina)
GO

CREATE INDEX i_d_parroquia
    ON cl_direccion_mig (di_ciudad, di_parroquia)
GO

print '*****  cl_telefono_mig'
if not object_id('cl_telefono_mig') is null
drop table cl_telefono_mig
go

create table cl_telefono_mig(
te_ente                  int             not null,
te_direccion             tinyint         not null,
te_secuencial            tinyint         not null,
te_valor                 varchar(16)     null,
te_tipo_telefono         char(2)         not null,
te_estado_mig            char(2)         null,
te_ente_mig               int            null
)
go

CREATE UNIQUE CLUSTERED INDEX cl_telefono_mig_Key
    ON cl_telefono_mig (te_ente, te_direccion, te_secuencial)
GO

CREATE INDEX te_estado_mig_key
    ON cl_telefono_mig (te_estado_mig)
GO

CREATE INDEX i_t_tipo_telefono
    ON cl_telefono_mig (te_ente, te_tipo_telefono)
GO

print '*****  cl_ref_personal_mig'
if not object_id('cl_ref_personal_mig') is null
drop table cl_ref_personal_mig
go

create table cl_ref_personal_mig(
rp_persona             int               not null,
rp_referencia          tinyint           not null,
rp_nombre              varchar(20)       not null,
rp_p_apellido          varchar(20)       not null,
rp_s_apellido          varchar(20)       null,
rp_direccion           direccion         null,
rp_telefono_d          char(12)          null,
rp_telefono_e          char(12)          null,
rp_telefono_o          char(12)          null,
rp_parentesco          char(2)           not null,
rp_fecha_registro      datetime          not null,
rp_fecha_modificacion  datetime          not null,
rp_vigencia            char(1)           not null,
rp_verificacion        char(1)           not null,
rp_funcionario         varchar(14)       null,
rp_descripcion         varchar(64)       null,
rp_fecha_ver           datetime          null,
rp_estado_mig          char(2)           null,
rp_ente_mig               int            null
)
go

CREATE UNIQUE CLUSTERED INDEX cl_ref_personal_mig_Key
    ON cl_ref_personal_mig (rp_persona, rp_referencia)
GO

CREATE INDEX rp_estado_mig_key
    ON cl_ref_personal_mig (rp_estado_mig)
GO

CREATE INDEX i_rp_parentesco
    ON cl_ref_personal_mig (rp_parentesco)
GO

print '*****  cl_trabajo_mig'
if not object_id('cl_trabajo_mig') is null
drop table cl_trabajo_mig
go

create table cl_trabajo_mig(
tr_persona            int               not null,
tr_trabajo            tinyint           not null,
tr_empresa            int               null,
tr_cargo              varchar(64)       not null,
tr_sueldo             money             null,
tr_moneda             tinyint           null,
tr_tipo               varchar(10)       null,
tr_fecha_registro     datetime          not null,
tr_fecha_modificacion datetime          not null,
tr_vigencia           char(1)           not null,
tr_fecha_ingreso      datetime          null,
tr_fecha_salida       datetime          null,
tr_verificado         char(1)           null,
tr_funcionario        varchar(14)       null,
tr_fecha_verificacion datetime          null,
tr_estado_mig         varchar(2)        null,
tr_ente_mig               int            null
)
go

CREATE UNIQUE CLUSTERED INDEX cl_trabajo_mig_Key
    ON cl_trabajo_mig (tr_persona, tr_trabajo)
GO

CREATE INDEX tr_estado_mig_key
    ON cl_trabajo_mig (tr_estado_mig)
GO

print '*****  cl_refinh_mig'
if not object_id('cl_refinh_mig') is null
drop table cl_refinh_mig
go

create table cl_refinh_mig(
    in_codigo           INT NOT NULL,    
    in_ced_ruc      CHAR (13),
    in_nombre       VARCHAR (64) NOT NULL,
    in_fecha_ref    DATETIME NOT NULL,
    in_origen       catalogo NOT NULL,
    in_observacion  VARCHAR (255) NOT NULL,
    in_fecha_mod    DATETIME NOT NULL,
    in_subtipo      CHAR (1) NOT NULL,
    in_p_p_apellido VARCHAR (16),
    in_p_s_apellido VARCHAR (16),
    in_tipo_ced     CHAR (2),
    in_nomlar       CHAR (64),
    in_estado       catalogo,
    in_sexo         CHAR (1),    
    in_entid        INT,
    in_estado_mig   char(2)
)
go

CREATE CLUSTERED INDEX iin_entid
    ON cl_refinh_mig (in_entid, in_codigo)
GO

CREATE INDEX in_estado_mig_key
    ON cl_refinh_mig (in_estado_mig)
GO

CREATE INDEX cl_refinh_mig_Key
    ON cl_refinh_mig (in_nomlar, in_codigo)
GO

CREATE INDEX cl_refinh_mig_idx1
    ON cl_refinh_mig (in_nombre, in_fecha_ref, in_origen, in_nomlar, in_estado)
GO

CREATE INDEX iin_ced_ruc
    ON cl_refinh_mig (in_ced_ruc, in_origen DESC, in_fecha_ref, in_nomlar, in_estado)
GO

CREATE INDEX iin_fecha_mod
    ON cl_refinh_mig (in_fecha_mod)
GO

CREATE INDEX iin_in_ced_ruc
    ON cl_refinh_mig (in_ced_ruc)
GO

-- Estructura que almacena el log de los errores que se han generado
print '*****  cl_log_mig'
if not object_id('cl_log_mig') is null
drop table cl_log_mig
go

create table cl_log_mig(
   lm_id_reg        varchar(50)     not null,
   lm_tabla         varchar(30)     not null,
   lm_fuente        varchar(30)     not null,
   lm_columna       varchar(30)     not null,  --nombre de la columna   
   lm_dato          varchar(255)    null,
   lm_error         int             not null,
   lm_operacion     int             null
)
go

-- Estructura que almacena los errores 
print '*****  cl_errores_mig'
if not object_id('cl_errores_mig') is null
drop table cl_errores_mig
go

create table cl_errores_mig(
   er_cod          int            not null,
   er_des          varchar(150)   null,
)
--LOCK DATAROWS
go

-- Estructura que almacena los rangos de datos a validar 
print '*****  cl_rango_mig'
if not object_id('cl_rango_mig') is null
drop table cl_rango_mig
go

create table cl_rango_mig(
   rm_tabla          varchar(30)     not null,
   rm_modulo         varchar(30)     null,
   rm_ciclos         smallint        not null,
   rm_valor_rango    int             not null,
   rm_valor_regis    int             not null,
   rm_cant_reg_val   int             null,
   rm_fec_ini_val    datetime        null,
   rm_fec_fin_val    datetime        null,
   rm_cant_reg_cobis int             null, 
   rm_total          int             not null
)

print '*****  cl_instancia_mig'
if not object_id('cl_instancia_mig') is null
drop table cl_instancia_mig
go
CREATE TABLE cl_instancia_mig
	(
	in_relacion     SMALLINT NOT NULL,
	in_ente_i       INT NOT NULL,
	in_ente_d       INT NOT NULL,
	in_lado         CHAR (1) NOT NULL,
	in_fecha        DATETIME NOT NULL,
    in_estado_mig   char(2) NULL
	)
GO
CREATE UNIQUE CLUSTERED INDEX cl_instancia_Key
	ON cl_instancia_mig (in_relacion,in_ente_i,in_ente_d)
GO
CREATE NONCLUSTERED INDEX in_ented_Key
	ON cl_instancia_mig (in_ente_d,in_ente_i)
GO
CREATE NONCLUSTERED INDEX in_entei_Key
	ON cl_instancia_mig (in_ente_i,in_ente_d)
GO



use cobis
go

-- Estructura que almacena el log de los errores que se han generado
print '*****  cl_ente_adicional'
if not object_id('cl_ente_adicional') is null
drop table cl_ente_adicional
go

create table cl_ente_adicional(
    ea_ente        varchar(50),
    ea_columna     varchar(30),
    ea_char        VARCHAR (30),
    ea_tinyint     TINYINT,
    ea_smallint    SMALLINT,
    ea_int         INT,
    ea_money       MONEY,
    ea_datetime    DATETIME,
    ea_float       FLOAT
)

CREATE CLUSTERED INDEX ea_ente
    ON cl_ente_adicional (ea_ente,ea_columna)
GO


