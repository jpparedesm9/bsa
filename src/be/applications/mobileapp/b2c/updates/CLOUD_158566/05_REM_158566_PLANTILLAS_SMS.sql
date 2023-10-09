-------------------------------------------------------------------
-- Archivo remediación plantillas sms; enrolamiento, otp e imagen -
-- Req. 158566 - Mejoras enrolamiento B2C
-------------------------------------------------------------------
use cobis
go

delete ns_plantilla_sms where ps_id_plantilla in ('50470', '50471', '50472')

insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50470','TUIIO_Descarga_la_APP_Tuiio_M+ovil_y_maneja_tu_crédito',0,0,1)

insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50471','TUIIO_Clave_de_ingreso_Tuiio_Movil',0,0,1)

insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50472','TUIIO_Se_Cambio_la_imagen_de_bienvenida',0,0,1)
go


update ns_datos_mensaje_detalle set dmd_eliminar = 'N'
update ns_datos_mensaje set dm_descripcion = 'Código del cliente' where dm_codigo = '02'
update ns_datos_mensaje set dm_descripcion = 'Número de teléfono del cliente' where dm_codigo = '03'

delete ns_datos_mensaje_detalle where dmd_codigo in (select dm_codigo from ns_datos_mensaje where dm_item in ( 'REGISTRO', 'CLAVE' ))
delete ns_datos_mensaje where dm_item in ( 'REGISTRO', 'CLAVE' )
delete ns_detalle_plantilla where dp_id_plantilla in ( '50470', '50471' )

--- Creacion datos de ns_datos_mensaje - Enrolamiento
declare 
@w_codigo           varchar(2),
@w_codigo_temp      varchar(2)

select @w_codigo = max(dm_codigo) from ns_datos_mensaje 
select @w_codigo_temp = convert(varchar(2), convert(int, isnull(@w_codigo, 1)) + 1)
select @w_codigo = case when len(@w_codigo_temp) = 1 then '0'+@w_codigo_temp else @w_codigo_temp end

INSERT INTO ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES(@w_codigo,'REGISTRO','REGISTRO ENROLAMIENTO','String')

INSERT INTO ns_datos_mensaje_detalle (dmd_codigo, dmd_id_tabla, dmd_base, dmd_tabla, dmd_columna, dmd_condicion, dmd_relacion, dmd_eliminar) 
VALUES(@w_codigo,1,'cob_bvirtual','bv_b2c_registro_tmp','rt_registro','rt_ente',null, 'S')

insert into ns_detalle_plantilla (dp_id_plantilla, dp_id_mensaje, dp_codigo, dp_id_bloque) 
values('50470', 1 , @w_codigo, 3)

go 

--- Creacion datos de ns_datos_mensaje - OTP
declare 
@w_codigo           varchar(2),
@w_codigo_temp      varchar(2)

select @w_codigo = max(dm_codigo) from ns_datos_mensaje 
select @w_codigo_temp = convert(varchar(2), convert(int, isnull(@w_codigo, 1)) + 1)
select @w_codigo = case when len(@w_codigo_temp) = 1 then '0'+@w_codigo_temp else @w_codigo_temp end

INSERT INTO ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES(@w_codigo,'CLAVE','CLAVE - OTP','String')

INSERT INTO ns_datos_mensaje_detalle (dmd_codigo, dmd_id_tabla, dmd_base, dmd_tabla, dmd_columna, dmd_condicion, dmd_relacion, dmd_eliminar) 
VALUES(@w_codigo,1,'cob_bvirtual','bv_b2c_token_tmp','tt_token','tt_ente',null, 'S')

insert into ns_detalle_plantilla (dp_id_plantilla, dp_id_mensaje, dp_codigo, dp_id_bloque) 
VALUES('50471', 1 , @w_codigo, 4)

GO