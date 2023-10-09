use cobis
GO

delete from cobis..ns_plantilla_sms where ps_id_plantilla = '304162'
INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('304162','Tuiio_Cuida_Situacion_Financiera',1240,2845,2)
GO

delete from cobis..ns_plantilla_sms where ps_id_plantilla = '304837'
INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('304837','Tuiio_Pago_Grupal_Proximo',1240,3855,2)
GO

delete from cobis..ns_plantilla_sms where ps_id_plantilla = '304660'
INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('304660','Tuiio_Autorizacion_Biometrica',1348,3565,1)
GO


delete ns_plantilla_sms where ps_id_plantilla in ('50470', '50471', '50472')

insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50470','TUIIO_Descarga_la_APP_Tuiio_M+ovil_y_maneja_tu_crédito',0,0,1)
insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50471','TUIIO_Clave_de_ingreso_Tuiio_Movil',0,0,1)
insert into ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
values('50472','TUIIO_Se_Cambio_la_imagen_de_bienvenida',0,0,1)
go



--- Creacion datos de ns_datos_mensaje
INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('01','Buc','Buc del cliente')
GO
INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('02','CodCliente','Código del cliente')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('03','Contacto','Número de teléfono del cliente')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('04','Nombre','Nombre completo del cliente')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('05','Email','Correo del cliente')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('06','Monto','Monto de la operacion')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('07','Fecha','Fecha de inicio de la operacion')
GO
INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion) 
VALUES('08','Operacion','Numero del banco')
GO
INSERT INTO ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('09','REGISTRO','REGISTRO ENROLAMIENTO','String')
GO
INSERT INTO ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('10','CLAVE','CLAVE - OTP','String')
GO

-- Creación del detalle de datos y mensajes 
use cobis
go

truncate table ns_datos_mensaje_detalle

INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('01',1,'cobis','cl_ente','en_banco','en_ente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('02',1,'cobis','cl_ente','en_ente','en_ente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('03',1,'cobis','cl_telefono','te_valor','te_ente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('04',1,'cobis','cl_ente','en_nomlar','en_ente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('05',1,'cobis','cl_direccion','di_descripcion','di_ente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('06',1,'cob_cartera','ca_operacion','op_monto','op_cliente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('07',1,'cob_cartera','ca_operacion','op_fecha_liq','op_cliente',null)
GO
INSERT INTO cobis..ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion) 
VALUES('08',1,'cob_cartera','ca_operacion','op_banco','op_cliente',null)
GO
INSERT INTO ns_datos_mensaje_detalle (dmd_codigo, dmd_id_tabla, dmd_base, dmd_tabla, dmd_columna, dmd_condicion, dmd_relacion, dmd_eliminar) 
VALUES('09',1,'cob_bvirtual','bv_b2c_registro_tmp','rt_registro','rt_ente',null, 'S')
GO
INSERT INTO ns_datos_mensaje_detalle (dmd_codigo, dmd_id_tabla, dmd_base, dmd_tabla, dmd_columna, dmd_condicion, dmd_relacion, dmd_eliminar) 
VALUES('10',1,'cob_bvirtual','bv_b2c_token_tmp','tt_token','tt_ente',null, 'S')
GO

use cobis
go

truncate table ns_detalle_plantilla
insert into ns_detalle_plantilla (dp_id_plantilla, dp_id_mensaje, dp_codigo, dp_id_bloque) 
values('50470', 1 , '09', 3)
insert into ns_detalle_plantilla (dp_id_plantilla, dp_id_mensaje, dp_codigo, dp_id_bloque) 
VALUES('50471', 1 , '10', 4)

go
