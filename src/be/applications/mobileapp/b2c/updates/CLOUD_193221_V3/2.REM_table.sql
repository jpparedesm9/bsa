
-- Instalador: \src\be\applications\mobileapp\b2c\installer\sql\b2c_table.sql

-- CLOUD_191122_707383_vulnerabilidades\src\be\applications\mobileapp\b2c\updates\CLOUD_191122_688882\01_REM_bv_table.sql
use cob_bvirtual
go

if (OBJECT_ID('bv_otp_seguridad')) IS NOT NULL
    drop table bv_otp_seguridad
go
create table bv_otp_seguridad(
   se_tipo               varchar   (10) not null,
   se_codigo             int            not null,
   se_canal              varchar   (10) not null,
   se_num_mail           varchar   (70) not null,
   se_fecha_ingreso      datetime       not null,
   se_fecha_vencimiento  datetime       null
)
go

-- CLOUD_191122_707383_vulnerabilidades\src\be\clientes\updates\CLOUD_191122_707383\1. REM_cl_table.sql
use cob_bvirtual
go

--TABLA DETALLE PROCESO
IF OBJECT_ID('bv_trans_detalle_proceso') IS NOT NULL
    DROP TABLE bv_trans_detalle_proceso
CREATE TABLE bv_trans_detalle_proceso (
    tdp_id int null, -- ente
    tdp_id_proceso int NULL,
    tdp_id_actividad int NULL,
    tdp_id_pantalla int NULL, -- revisar tipo de dato
    tdp_estado char(1) NULL,
    tdp_fecha_ingreso datetime NULL,
    tdp_fecha_terminado datetime NULL,
	tdp_fecha_proceso datetime NULL,
)

--TABLA DETALLE CONSULTA
IF OBJECT_ID('bv_trans_detalle_consulta') IS NOT NULL
    DROP TABLE bv_trans_detalle_consulta
CREATE TABLE bv_trans_detalle_consulta (
    tdc_id int IDENTITY(1,1) PRIMARY KEY,
    tdc_id_actividad int NULL,
	tdc_id_sp  int,
	tdc_fecha_ingreso datetime NULL,
	)
	
	insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (1, 1, getdate()) -- Captura domicilio
	insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (2, 2, getdate()) -- Captura domicilio
	insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (3, 0, getdate()) -- Captura domicilio
	insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (4, 0, getdate()) -- Captura domicilio
	insert into bv_trans_detalle_consulta(tdc_id_actividad, tdc_id_sp, tdc_fecha_ingreso) values (5, 0, getdate()) -- Captura domicilio







--TABLA ACTIVIDADES
IF OBJECT_ID('bv_trans_actividades') IS NOT NULL
    DROP TABLE bv_trans_actividades
CREATE TABLE bv_trans_actividades(
    ta_id int IDENTITY(1,1) PRIMARY KEY, -- Secuencial
    ta_actividad varchar(250) NULL
)

--INSERT ACTIVIDADES - inserta la actividades principales del documento 
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Captura domicilio')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Formulario KYC')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Oferta Producto + Simulación')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Autorización Buro + Toma de Huellas')
INSERT INTO cob_bvirtual.dbo.bv_trans_actividades(ta_actividad) VALUES('Datos Generales + Selección cuenta Altair')


-- TABLA PANTALLAS
IF OBJECT_ID('bv_trans_pantallas') IS NOT NULL
    DROP TABLE bv_trans_pantallas
CREATE TABLE bv_trans_pantallas(
    tpa_id int IDENTITY(1,1) PRIMARY KEY,
    tpa_pantalla varchar(250) NULL
)

--INSERT PANTALLAS
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Captura domicilio')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Formulario KYC')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Oferta producto')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Simulacion')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Autorizacion Buro')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Toma Huellas - Buro')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Resultado de evaluacion')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Datos Generales')
INSERT INTO bv_trans_pantallas(tpa_pantalla)VALUES('Captura cuenta Altair')


-- TABLA PROCESOS
IF OBJECT_ID('bv_trans_procesos') IS NOT NULL
    DROP TABLE bv_trans_procesos
CREATE TABLE bv_trans_procesos(
    tp_id int , -- Secuencial
    tp_id_cliente int NULL,
	tp_fecha_ini datetime NULL,
	tp_fecha_fin datetime NULL
)

IF OBJECT_ID('bv_trans_sp') IS NOT NULL
    DROP TABLE bv_trans_sp
CREATE TABLE bv_trans_sp(
    ts_id int IDENTITY(1,1) PRIMARY KEY,
    ts_nombre_sp varchar(250) NULL,
    ts_base_datos varchar(128) NULL
)

INSERT INTO bv_trans_sp(ts_nombre_sp,ts_base_datos)VALUES('sp_consulta_datos_cliente','cobis')
INSERT INTO bv_trans_sp(ts_nombre_sp,ts_base_datos)VALUES('sp_consulta_kyc','cobis')

--TABLA pantalla - actividad --  relacionar las pantallas con las actividades
IF OBJECT_ID('bv_trans_detalle_pantalla_actividad') IS NOT NULL
    DROP TABLE bv_trans_detalle_pantalla_actividad
CREATE TABLE bv_trans_detalle_pantalla_actividad (
    tdpa_id int IDENTITY(1,1) PRIMARY KEY,
    tdpa_id_actividad int NULL,
	tdpa_act_anterior int null,
    tdpa_id_pantalla varchar(20) NULL,
	tdpa_orden  smallint null
	
)


-- Actividad 1    Captura domicilio
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (1, 0, 1,  1) -- Captura domicilio
-- Actividad 2    Formulario KYC
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (2, 1, 2,  1) -- Formulario KYC
-- Actividad 3    Oferta Producto + Simulación
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (3, 2, 3,  1) -- Oferta producto
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (3, 2, 4,  2) -- Simulacion
-- Actividad 4    Autorización Buro + Toma de Huellas
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 5,  1) -- Autorizacion Buro
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 6,  2) -- Toma Huellas - Buro
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (4, 3, 7,  3) -- Resultado de evaluacion
-- Actividad 5    Datos Generales + Selección cuenta Altair
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (5, 4, 8,  1) -- Datos Generales
insert into bv_trans_detalle_pantalla_actividad(tdpa_id_actividad, tdpa_act_anterior, tdpa_id_pantalla,  tdpa_orden) values (5, 4, 9,  2) -- Captura cuenta Altair

go

