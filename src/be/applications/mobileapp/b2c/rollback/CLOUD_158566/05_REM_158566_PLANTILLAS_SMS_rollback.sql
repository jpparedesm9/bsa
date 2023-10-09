-------------------------------------------------------------------
-- Archivo remediación plantillas sms; enrolamiento, otp e imagen -
-- Req. 158566 - Mejoras enrolamiento B2C
-------------------------------------------------------------------
use cobis
go

--- Rollback datos de ns_datos_mensaje - Enrolamiento
delete ns_plantilla_sms where ps_id_plantilla in ('50470', '50471', '50472')
delete ns_datos_mensaje_detalle where dmd_codigo in (select dm_codigo from ns_datos_mensaje where dm_item in ( 'REGISTRO', 'CLAVE' ))
delete ns_datos_mensaje where dm_item in ( 'REGISTRO', 'CLAVE' )
delete ns_detalle_plantilla where dp_id_plantilla in ( '50470', '50471' )


GO