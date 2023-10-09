use cob_credito_his
go

if object_id ('cr_califica_int_mod_his') is not null
   drop table cr_califica_int_mod_his
go

create table cr_califica_int_mod_his
(
   ci_producto     smallint        not null,
   ci_toperacion   catalogo        not null,
   ci_moneda       smallint        not null,
   ci_cliente      int             not null,
   ci_banco        cuenta          not null,
   ci_fecha        smalldatetime   not null,
   ci_nota         tinyint         not null
)
go

create clustered index cr_califica_int_mod_inx1
    on cr_califica_int_mod_his(ci_cliente)

create unique nonclustered index cr_califica_int_mod_inx
    on cr_califica_int_mod_his(ci_banco)
go


if object_id ('cr_tramite_his') is not null
   drop table cr_tramite_his
go

create table cr_tramite_his
(
   tr_tramite              int            not null,
   tr_tipo                 char(1)        not null,
   tr_oficina              smallint       not null,
   tr_usuario              login          not null,
   tr_fecha_crea           datetime       not null,
   tr_oficial              smallint       not null,
   tr_sector               catalogo       not null,
   tr_ciudad               int            not null,
   tr_estado               char(1)        null,
   tr_nivel_ap             tinyint        null,
   tr_fecha_apr            datetime       null,
   tr_usuario_apr          login          null,
   tr_truta                tinyint        not null,
   tr_secuencia            smallint       not null,
   tr_numero_op            int            null,
   tr_numero_op_banco      cuenta         null,
   tr_riesgo               money          null,
   tr_aprob_por            login          null,
   tr_nivel_por            tinyint        null,
   tr_comite               catalogo       null,
   tr_acta                 cuenta         null,
   tr_proposito            catalogo       null,
   tr_razon                catalogo       null,
   tr_txt_razon            varchar(255)   null,
   tr_efecto               catalogo       null,
   tr_cliente              int            null,
   tr_nombre               descripcion    null,
   tr_grupo                int            null,
   tr_fecha_inicio         datetime       null,
   tr_num_dias             smallint       null,
   tr_per_revision         catalogo       null,
   tr_condicion_especial   varchar(255)   null,
   tr_linea_credito        int            null,
   tr_toperacion           catalogo       null,
   tr_producto             catalogo       null,
   tr_monto                money          null,
   tr_moneda               tinyint        null,
   tr_periodo              catalogo       null,
   tr_num_periodos         smallint       null,
   tr_destino              catalogo       null,
   tr_ciudad_destino       int            null,
   tr_cuenta_corriente     cuenta         null,
   tr_renovacion           smallint       null,
   tr_fecha_concesion      datetime       null,
   tr_rent_actual          float          null,
   tr_rent_solicitud       float          null,
   tr_rent_recomend        float          null,
   tr_prod_actual          money          null,
   tr_prod_solicitud       money          null,
   tr_prod_recomend        money          null,
   tr_clase                catalogo       null,
   tr_admisible            money          null,
   tr_noadmis              money          null,
   tr_relacionado          int            null,
   tr_pondera              float          null,
   tr_contabilizado        char(1)        null,
   tr_subtipo              char(1)        null,
   tr_tipo_producto        catalogo       null,
   tr_origen_bienes        catalogo       null,
   tr_localizacion         catalogo       null,
   tr_plan_inversion       catalogo       null,
   tr_naturaleza           catalogo       null,
   tr_tipo_financia        catalogo       null,
   tr_sobrepasa            char(1)        not null,
   tr_elegible             char(1)        null,
   tr_forward              char(1)        null,
   tr_emp_emisora          int            null,
   tr_num_acciones         smallint       null,
   tr_responsable          int            null,
   tr_negocio              cuenta         null,
   tr_reestructuracion     char(1)        null,
   tr_concepto_credito     catalogo       null,
   tr_aprob_gar            catalogo       null,
   tr_cont_admisible       char(1)        null,
   tr_mercado_objetivo     catalogo       null,
   tr_tipo_productor       varchar(24)    null,
   tr_valor_proyecto       money          null,
   tr_sindicado            char(1)        null,
   tr_asociativo           char(1)        null,
   tr_margen_redescuento   float          null,
   tr_fecha_ap_ant         datetime       null,
   tr_llave_redes          cuenta         null,
   tr_incentivo            char(1)        null,
   tr_fecha_eleg           datetime       null,
   tr_op_redescuento       int            null,
   tr_fecha_redes          datetime       null,
   tr_solicitud            int            null,
   tr_montop               money          null,
   tr_monto_desembolsop    money          null,
   tr_mercado              catalogo       null,
   tr_dias_vig             int            null,
   tr_cod_actividad        catalogo       null,
   tr_num_desemb           int            null,
   tr_carta_apr            varchar(64)    null,
   tr_fecha_aprov          datetime       null,
   tr_fmax_redes           datetime       null,
   tr_f_prorroga           datetime       null,
   tr_nlegal_fi            catalogo       null,
   tr_fechlimcum           datetime       null,
   tr_validado             char(1)        null,
   tr_sujcred              catalogo       null,
   tr_fabrica              catalogo       null,
   tr_callcenter           catalogo       null,
   tr_apr_fabrica          catalogo       null,
   tr_monto_solicitado     money          null,
   tr_tipo_plazo           catalogo       null,
   tr_tipo_cuota           catalogo       null,
   tr_plazo                smallint       null,
   tr_cuota_aproximada     money          null,
   tr_fuente_recurso       varchar(10)    null,
   tr_tipo_credito         char(1)        null,
   tr_migrado              varchar(16)    null,
   tr_estado_cont          char(1)        null,
   tr_fecha_fija           char(1)        null,
   tr_dia_pago             tinyint        null,
   tr_tasa_reest           float          null,
   tr_motivo               catalogo       null
)
go

create nonclustered index cr_tramite_AKey1
    on cr_tramite_his(tr_migrado)

create nonclustered index cr_tramite_AKey2
    on cr_tramite_his(tr_cliente)

create nonclustered index cr_tramite_AKey3
    on cr_tramite_his(tr_linea_credito)

create unique nonclustered index cr_tramite_Key
    on cr_tramite_his(tr_tramite)
go


if object_id ('cr_ruta_tramite') is not null
   drop table cr_ruta_tramite
go

create table cr_ruta_tramite
(
   rt_tramite        int        not null,
   rt_secuencia      smallint   not null,
   rt_truta          tinyint    not null,
   rt_paso           tinyint    not null,
   rt_etapa          tinyint    not null,
   rt_estacion       smallint   not null,
   rt_llegada        datetime   not null,
   rt_salida         datetime   null,
   rt_estado         int        null,
   rt_paralelo       smallint   null,
   rt_prioridad      tinyint    not null,
   rt_abierto        char(1)    not null,
   rt_asociado       smallint   null,
   rt_etapa_sus      tinyint    null,
   rt_estacion_sus   smallint   null,
   rt_comite         char(1)    null
)
go

if object_id ('cob_credito_his..cr_rfc_int_error_hist') is not null
	drop table cob_credito_his..cr_rfc_int_error_hist
go

create table cob_credito_his..cr_rfc_int_error_hist
	(
	rfc_int_error_hist        varchar (30),
	status_rfc_err_hist       char (1),
	insert_date_rfc_err_hist  datetime,
	process_date_rfc_err_hist datetime
	)
go


--CREACIÓN ESTRUCTURA BURO HISTÓRICO
-- Create schemas
use cob_credito_his
go

IF OBJECT_ID ('dbo.cr_empleo_buro_his') IS NOT NULL
   drop table cr_empleo_buro_his
   
IF OBJECT_ID ('dbo.cr_direccion_buro_his') IS NOT NULL
drop table cr_direccion_buro_his

IF OBJECT_ID ('dbo.cr_buro_encabezado_his') IS NOT NULL
drop table cr_buro_encabezado_his

IF OBJECT_ID ('dbo.cr_buro_cuenta_his') IS NOT NULL
drop table cr_buro_cuenta_his

IF OBJECT_ID ('dbo.cr_consultas_buro_his') IS NOT NULL
drop table cr_consultas_buro_his

IF OBJECT_ID ('dbo.cr_buro_resumen_reporte_his') IS NOT NULL
drop table cr_buro_resumen_reporte_his

IF OBJECT_ID ('dbo.cr_score_buro_his') IS NOT NULL
drop table cr_score_buro_his

IF OBJECT_ID ('dbo.cr_interface_buro_his') IS NOT NULL BEGIN
if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_interface_buro_his' AND object_id = OBJECT_ID(N'cr_interface_buro_his')) begin 
   drop index IX_cr_interface_buro_his ON cr_interface_buro_his
END 
drop table cr_interface_buro_his
end

-- Create tables

CREATE TABLE cr_interface_buro_his
(
  ibh_secuencial INT NOT NULL IDENTITY,
  ibh_cliente INT,
  ibh_fecha datetime,
  ibh_riesgo INT,
  ibh_folio VARCHAR(64),
  ibh_fecha_paso_his datetime,
  ibh_usuario varchar(30) null
  CONSTRAINT pk_interface_buro_his PRIMARY KEY(ibh_secuencial)  
)
if exists (SELECT 1 FROM sys.indexes WHERE Name = N'IX_cr_interface_buro_his' AND object_id = OBJECT_ID(N'cr_interface_buro_his')) begin 
   CREATE INDEX  IX_cr_interface_buro_his  on cr_interface_buro_his (ibh_cliente)
end 

go    
  
CREATE TABLE cr_buro_encabezado_his
(
  beh_secuencial INT NOT NULL IDENTITY,
  beh_ib_secuencial INT NOT NULL,  
  beh_nro_referencia_operador VARCHAR(25),
  beh_clave_pais VARCHAR(2),
  beh_identificador_buro INT,
  beh_clave_otorgante VARCHAR(10),
  beh_clave_retorno_consumidor_principal VARCHAR(1),
  beh_clave_retorno_consumidor_secundario VARCHAR(1),
  beh_numero_control_consulta VARCHAR(9),
  CONSTRAINT pk_buro_encabezado_his PRIMARY KEY(beh_secuencial),
  CONSTRAINT fk_buro_encabezado_his_interface_buro_his FOREIGN KEY (beh_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)
)

go

CREATE TABLE cr_direccion_buro_his
(
  dbh_secuencial INT NOT NULL IDENTITY,
  dbh_ib_secuencial INT NOT NULL,  
  dbh_direccion_uno VARCHAR(150),
  dbh_direccion_dos VARCHAR(150),
  dbh_colonia VARCHAR(150),
  dbh_delegacion VARCHAR(150),
  dbh_ciudad VARCHAR(150),
  dbh_estado VARCHAR(20),
  dbh_codigo_postal VARCHAR(50),
  dbh_numero_telefono VARCHAR(50),
  dbh_tipo_domicilio VARCHAR(1),
  dbh_indicador_especial VARCHAR(1),   
  dbh_codigo_pais VARCHAR(2),
  dbh_fecha_reporte VARCHAR(8),
  CONSTRAINT pk_direccion_buro_his PRIMARY KEY(dbh_secuencial),
  CONSTRAINT fk_direccion_buro_his_interface_buro_his FOREIGN KEY (dbh_ib_secuencial)
    REFERENCES cr_interface_buro_his(ibh_secuencial)
)

go
    
CREATE TABLE cr_empleo_buro_his
(
  ebh_secuencial INT NOT NULL IDENTITY,
  ebh_ib_secuencial INT NOT NULL,  
  ebh_nombre_empresa VARCHAR(40),
  ebh_direccion_uno VARCHAR(40),
  ebh_direccion_dos VARCHAR(40),
  ebh_colonia VARCHAR(40),
  ebh_delegacion VARCHAR(40),
  ebh_ciudad VARCHAR(40),
  ebh_estado VARCHAR(4),
  ebh_codigo_postal VARCHAR(5),
  ebh_numero_telefono VARCHAR(11),
  ebh_extension VARCHAR(8),
  ebh_fax VARCHAR(11),
  ebh_cargo VARCHAR(30),
  ebh_fecha_contratacion VARCHAR(8),
  ebh_clave_moneda VARCHAR(2),
  ebh_salario VARCHAR(9),
  ebh_base_salarial VARCHAR(1),
  ebh_num_empleado VARCHAR(15),
  ebh_fecha_ult_dia VARCHAR(8),
  ebh_codigo_pais VARCHAR(2),
  ebh_fecha_rept_empleo VARCHAR(8),
  ebh_fecha_verificacion VARCHAR(8),
  ebh_modo_verificacion VARCHAR(1),    
  CONSTRAINT pk_empleo_buro_his PRIMARY KEY(ebh_secuencial),
  CONSTRAINT fk_empleo_buro_his_interface_buro_his FOREIGN KEY (ebh_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)
)

go
    
CREATE TABLE cr_buro_cuenta_his
(
  bch_secuencial INT NOT NULL IDENTITY,
  bch_ib_secuencial INT NOT NULL,  
  bch_fecha_actualizacion VARCHAR(8),
  bch_registro_impugnado VARCHAR(4),
  bch_clave_otorgante VARCHAR(10),
  bch_nombre_otorgante VARCHAR(16),
  bch_numero_telefono_otorgante VARCHAR(11),
  bch_identificador_sociedad_crediticia VARCHAR(11),
  bch_numero_cuenta_actual VARCHAR(25),
  bch_indicador_tipo_responsabilidad VARCHAR(1),
  bch_tipo_cuenta VARCHAR(1),
  bch_tipo_contrato VARCHAR(2),
  bch_clave_unidad_monetaria VARCHAR(2),
  bch_valor_activo_valuacion VARCHAR(9),
  bch_numero_pagos VARCHAR(4),
  bch_frecuencia_pagos VARCHAR(1),
  bch_monto_pagar VARCHAR(9),
  bch_fecha_apertura_cuenta VARCHAR(8),
  bch_fecha_ultimo_pago VARCHAR(8),
  bch_fecha_ultima_compra VARCHAR(8),
  bch_fecha_cierre_cuenta VARCHAR(8),
  bch_fecha_reporte VARCHAR(8),
  bch_modo_reportar VARCHAR(1),
  bch_ultima_fecha_saldo_cero VARCHAR(8),
  bch_garantia VARCHAR(40),
  bch_credito_maximo VARCHAR(9),
  bch_saldo_actual VARCHAR(9),
  bch_limite_credito VARCHAR(9),
  bch_saldo_vencido VARCHAR(9),
  bch_numero_pagos_vencidos VARCHAR(4),
  bch_forma_pago_actual VARCHAR(2),
  bch_historico_pagos VARCHAR(24),
  bch_fecha_mas_reciente_pago_historicos VARCHAR(8),
  bch_fecha_mas_antigua_pago_historicos VARCHAR(8),
  bch_clave_observacion VARCHAR(2),
  bch_total_pagos_reportados VARCHAR(3),
  bch_total_pagos_calificados_mop2 VARCHAR(2),
  bch_total_pagos_calificados_mop3 VARCHAR(2),
  bch_total_pagos_calificados_mop4 VARCHAR(2),
  bch_total_pagos_calificados_mop5 VARCHAR(2),
  bch_importe_saldo_morosidad_hist_mas_grave VARCHAR(9),
  bch_fecha_historica_morosidad_mas_grave VARCHAR(8),
  bch_mop_historico_morosidad_mas_grave VARCHAR(2),
  bch_monto_ultimo_pago VARCHAR(9),
  bch_fecha_inicio_reestructura VARCHAR(8),
  CONSTRAINT pk_buro_cuenta_his PRIMARY KEY(bch_secuencial),
  CONSTRAINT fk_buro_cuenta_his_interface_buro_his FOREIGN KEY (bch_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)
)

go

CREATE TABLE cr_consultas_buro_his
(
  cbh_secuencial          INT NOT NULL IDENTITY,
  cbh_ib_secuencial       INT NOT NULL,  
  cbh_fecha_consulta      VARCHAR (8) NULL,
  cbh_identificacion_buro VARCHAR (4) NULL,
  cbh_clave_otorgante     VARCHAR (10) NULL,
  cbh_nombre_otorgante    VARCHAR (16) NULL,
  cbh_telefono_otorgante  VARCHAR (11) NULL,
  cbh_tipo_contrato       VARCHAR (2) NULL,
  cbh_clave_monetaria     VARCHAR (2) NULL,
  cbh_importe_contrato    VARCHAR (9) NULL,
  cbh_ind_tipo_responsa   CHAR (1) NULL,
  cbh_consumidor_nuevo    CHAR (1) NULL,
  cbh_resultado_final     VARCHAR (25) NULL,
  cbh_identificador_cons  VARCHAR (25) NULL,
  CONSTRAINT pk_consultas_buro_his PRIMARY KEY(cbh_secuencial),
  CONSTRAINT fk_consultas_buro_his_interface_buro_his FOREIGN KEY (cbh_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)
)

go
 
    
CREATE TABLE cr_buro_resumen_reporte_his
(
  brh_secuencial INT NOT NULL IDENTITY,
  brh_ib_secuencial INT NOT NULL,    
  brh_fecha_ingreso_bd VARCHAR(8),
  brh_numero_mop7 VARCHAR(2),
  brh_numero_mop6 VARCHAR(2),
  brh_numero_mop5 VARCHAR(2),
  brh_numero_mop4 VARCHAR(2),
  brh_numero_mop3 VARCHAR(2),
  brh_numero_mop2 VARCHAR(2),
  brh_numero_mop1 VARCHAR(2),
  brh_numero_mop0 VARCHAR(2),
  brh_numero_mop_ur VARCHAR(2),
  brh_numero_cuentas VARCHAR(4),
  brh_cuentas_pagos_fijos_hipotecas VARCHAR(4),
  brh_cuentas_revolventes_abiertas VARCHAR(4),
  brh_cuentas_cerradas VARCHAR(4),
  brh_cuentas_negativas_actuales VARCHAR(4),
  brh_cuentas_claves_historia_negativa VARCHAR(4),
  brh_cuentas_disputa VARCHAR(4),
  brh_numero_solicitudes_ultimos_6_meses VARCHAR(2),
  brh_nueva_direccion_reportada_ultimos_60_dias VARCHAR(1),
  brh_mensajes_alerta VARCHAR(8),
  brh_existencia_declaraciones_consumidor VARCHAR(1),
  brh_tipo_moneda VARCHAR(2),
  brh_total_creditos_maximos_revolventes VARCHAR(9),
  brh_total_limites_credito_revolventes VARCHAR(9),
  brh_total_saldos_actuales_revolventes VARCHAR(10),
  brh_total_saldos_vencidos_revolventes VARCHAR(10),
  brh_total_pagos_revolventes VARCHAR(9),
  brh_pct_limite_credito_utilizado_revolventes VARCHAR(3),
  brh_total_creditos_maximos_pagos_fijos VARCHAR(9),
  brh_total_saldos_actuales_pagos_fijos VARCHAR(10),
  brh_total_saldos_vencidos_pagos_fijos VARCHAR(9),
  brh_total_pagos_pagos_fijos VARCHAR(9),
  brh_numero_mop96 VARCHAR(2),
  brh_numero_mop97 VARCHAR(2),
  brh_numero_mop99 VARCHAR(2),
  brh_fecha_apertura_cuenta_mas_antigua VARCHAR(8),
  brh_fecha_apertura_cuenta_mas_reciente VARCHAR(8),
  brh_total_solicitudes_reporte VARCHAR(2),
  brh_fecha_solicitud_reporte_mas_reciente VARCHAR(8),
  brh_numero_total_cuentas_despacho_cobranza VARCHAR(2),
  brh_fecha_apertura_cuenta_mas_reciente_despacho_cobranza VARCHAR(8),
  brh_numero_total_solicitudes_despachos_cobranza VARCHAR(2),
  brh_fecha_solicitud_mas_reciente_despacho_cobranza VARCHAR(8),
  CONSTRAINT pk_buro_resumen_reporte_his PRIMARY KEY(brh_secuencial),
  CONSTRAINT fk_buro_resumen_reporte_his_interface_buro_his FOREIGN KEY (brh_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)
 )

go

CREATE TABLE cr_score_buro_his
(
  sbh_secuencial INT NOT NULL IDENTITY,
  sbh_ib_secuencial INT NOT NULL, 
  sbh_nombre       VARCHAR (30) NULL,
  sbh_codigo       VARCHAR (3) NULL,
  sbh_valor        VARCHAR (4) NULL,
  sbh_codigo_razon VARCHAR (3) NULL,
  sbh_codigo_error VARCHAR (2) NULL,
  CONSTRAINT pk_score_buro_his PRIMARY KEY(sbh_secuencial),
  CONSTRAINT fk_score_buro_his_interface_buro_his FOREIGN KEY (sbh_ib_secuencial)
  REFERENCES cr_interface_buro_his(ibh_secuencial)

)

-------------------tabla cr_resultado_xml_his para historicos de de generación de xml SAT
if object_id ('dbo.cr_resultado_xml_his') is not null
    drop table dbo.cr_resultado_xml_his
go
create table cr_resultado_xml_his( 
	linea            xml,
    file_name         varchar(64),
    id_ente           int  null,
	status            char(1)  null,
	rfc_ente          varchar(30)  null,
	num_operation     varchar(24)  NULL,
	insert_date       DATETIME     NULL,
    processing_date   DATETIME null),
	rxh_cuota_desde   int,
	rxh_cuota_hasta   int,
	rxh_int_rep       money,
	rxh_com_rep       money,
	rxh_int_ant       money,
	rxh_iva           money,
	rxh_met_fact      varchar(3),
	rxh_form_pag      varchar(2),
	rxh_fecha_ult_compl date,
	rxh_pago_compl      money,
	rxh_fecha_env_email date,
	rxh_tipo_operacion  varchar(10),
	rxh_total_saldo_ant money,
	rxh_folio_ref     varchar(50),
    rxh_deuda_pagar   money,
    rxh_total_saldo   money,
    rxh_fecha_fin_mes datetime 
    rxh_pago_mes      money,
    rxh_pago_mes_ant  money,
    rxh_pag_compl_ant money,
    rxh_com_acum      money,
	rxh_sec_id         int,
    rxh_pago_compl_fin money,
    rxh_genera_cmpl    char(1)	)
go

IF NOT  EXISTS (SELECT name FROM sys.indexes WHERE name = N'indx_cr_resultado_xml_his_num_operation')  
            BEGIN
                CREATE NONCLUSTERED INDEX [indx_cr_resultado_xml_his_num_operation]
                ON [dbo].[cr_resultado_xml_his] ([num_operation])
            END

go


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'indx_cr_resultado_xml_his_fecha_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin

create index indx_cr_resultado_xml_his_fecha_fin_mes
on cob_credito_his..cr_resultado_xml_his (rxh_fecha_fin_mes)
	
end
go

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'indx_cr_resultado_xml_his_operation_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito_his..cr_resultado_xml_his'))
begin

create index indx_cr_resultado_xml_his_operation_fin_mes
on cob_credito_his..cr_resultado_xml_his (num_operation, rxh_fecha_fin_mes)
	
end

go

IF OBJECT_ID ('dbo.cr_complemento_pago_xml_his') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml_his
go
create table dbo.cr_complemento_pago_xml_his
	(
	linea_his             nvarchar(max),
	file_name_his         varchar (64),
	id_ente_his           int,
	status_his            char (1),
	rfc_ente_his          varchar (30),
	num_operation_his     varchar (24),
	insert_date_his       datetime,
	processing_date_his   datetime,
	tipo_operacion_his    varchar (10),
	in_fecha_fin_mes_his  datetime,
	rxh_saldo_inso        money,
    rxh_cuota_ini         int,
    rxh_cuota_hasta       int,
    rxh_deuda_pagar       money,
    rxh_folio_ref         varchar(50),
    rxh_saldo_inso_fin    money,
    rxh_sec_id            int,
    rxh_tipo_compl        char(1),
    rxh_id_documento      varchar(60),
    rxh_fe_mes_afecta     datetime	
	)
go


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'operacion_complemento_his'
                  AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin

create index operacion_complemento_his 
on cr_complemento_pago_xml_his (num_operation_his) 
	
end
go

if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'complemento_his_banco_folio'
                  AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin

create index complemento_his_banco_folio
on cob_credito_his..cr_complemento_pago_xml_his (num_operation_his, rxh_folio_ref)
	
end
go


if not exists (SELECT 1 
                 FROM sys.indexes 
                WHERE Name = N'complemento_his_fin_mes'
                  AND Object_ID = Object_ID(N'cob_credito_his..cr_complemento_pago_xml_his'))
begin

create index complemento_his_fin_mes
on cob_credito_his..cr_complemento_pago_xml_his (in_fecha_fin_mes_his)
	
end

go


--->>>>>>>>>>>>>>>>>>>Requerimiento #203112 OT Modelo Aceptación Grupal, BC
use cob_credito_his
go

print 'CREACION TABLA: cr_vigencia_tipo_calif_his'
if object_id ('dbo.cr_vigencia_tipo_calif_his') is not null
	drop table dbo.cr_vigencia_tipo_calif_his
go

create table dbo.cr_vigencia_tipo_calif_his(
    vgh_ente           int,
    vgh_oficina        smallint,   
	vgh_canal          int,
	vgh_vigencia       int,
	vgh_tipo_calif     varchar(10),
	vgh_usuario        varchar(14),
	vgh_fecha_reg      datetime,
	vgh_fecha_proc     datetime,
	vgh_fecha_paso_his datetime,
	vgh_evaluo_buro    char(1), -- S consulto a buro
	vgh_result_eval    varchar(256) -- Resultado evalua reglas
)
go


IF OBJECT_ID ('dbo.cr_b2c_registro_his') IS NOT NULL
	DROP table dbo.cr_b2c_registro_his
go

create table dbo.cr_b2c_registro_his
	(
	rbh_registro_id       cuenta,
	rbh_id_inst_proc      int,
	rbh_cliente           int,
	rbh_fecha_ingreso     datetime,
	rbh_fecha_vigencia    datetime,
	rbh_fecha_reg_exitoso datetime
)
go

create index idx on dbo.cr_b2c_registro_his (rbh_cliente)
	
go

