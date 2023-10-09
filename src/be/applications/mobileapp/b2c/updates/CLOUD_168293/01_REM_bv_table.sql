
-- \bsa\src\be\applications\mobileapp\b2c\installer\sql\b2c_table.sql
use cob_bvirtual
go

if (OBJECT_ID('bv_onboard_ocr_sco')) IS NOT NULL
    drop table bv_onboard_ocr_sco
create table bv_onboard_ocr_sco(
    id_expediente  varchar(100),
    id_validas     varchar(100),
    document_type  varchar(100) null,
    field_name     varchar(200) null,
    name           varchar(100) null,
    text           varchar(100) null,
    value          decimal(25,24) null,
    type           varchar(3) null, -- OCR, BIO, DOC
    fecha_registro datetime default getdate()
)
create index bv_onboard_ocr_sco_idx1 on bv_onboard_ocr_sco (id_expediente)
create nonclustered index bv_onboard_ocr_sco_idx2 on bv_onboard_ocr_sco (id_expediente,type)
go

-- FingerID - Guardar la respuesta en el servicio Validate Toke Opaco
if (OBJECT_ID('bv_respuesta_fingerid')) IS NOT NULL
    drop table bv_respuesta_fingerid
create table bv_respuesta_fingerid(
rf_id_cliente     varchar(20) null,
rf_tipo_trx       varchar(50) null,
rf_id_trx         varchar(50) null,
rf_resultado	  varchar(50) null,

rf_codigo_respuesta_minucia int null,
rf_similitud2	  varchar(10) null,
rf_similitud7	  varchar(10) null,
rf_fecha_ini	  varchar(10) null,
rf_fecha_fin	  varchar(10) null,
rf_codigo_err	  varchar(20) null,
-- ---
rf_codigo_respuesta 			int null ,
rf_fecha_hora_peticion 			varchar(30) null ,
rf_indice_solicitud 			varchar(100) null ,
rf_tiempo_procesamiento 		int null ,
rf_codigo_respuesta_datos 		int null ,
rf_is_ocr 						bit null ,
rf_is_numero_emision_credencial bit null ,
rf_is_nombre 					bit null ,
rf_is_curp 						bit null ,
rf_is_clave_elector 			bit null ,
rf_is_apellido_paterno 			bit null ,
rf_is_apellido_materno 			bit null ,
rf_is_anio_emision 				bit null ,
rf_is_anio_registro 			bit null ,
rf_tipo_reporte_robo_extravio 	varchar(100) null ,
rf_tipo_situacion_registral 	varchar(30) null ,
rf_signature_value 				varchar(100) null ,
rf_momento 						varchar(100) null ,
rf_indice 						varchar(100) null ,
rf_numero_serie 				varchar(100) null ,
rf_hash 						varchar(200) null ,
rf_desc_tipo_trx 				varchar(10) null ,
-- ---
-- rf_key_info 					varchar(100) null ,
rf_x_serial_number 			    varchar(100) null ,
-- rf_signed_info 					varchar(100) null ,
rf_metodo_canonicalizacion	    varchar(100) null ,
rf_metodo_firma	                varchar(100) null ,
rf_alg_metodo_digestion         varchar(100) null ,
rf_valor_metodo_digestion       varchar(100) null ,
rf_uri_metodo_digestion         varchar(100) null ,
-- ---
rf_fecha_registro datetime default getdate()
)


create nonclustered index bv_respuesta_fingerid_idx1 on bv_respuesta_fingerid(rf_id_trx,rf_id_cliente)
go


