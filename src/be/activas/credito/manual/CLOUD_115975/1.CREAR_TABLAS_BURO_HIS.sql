--CREACIÓN ESTRUCUTURA BURO HISTÓRICO
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

go
