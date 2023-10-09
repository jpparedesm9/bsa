use cobis
GO

truncate table ns_plantilla_sms
go  

INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('50464','Tuiio_Cuida_Situacion_Financiera',0,0,1)
GO


INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('50463','Tuiio_Pago_Grupal_Proximo',0,0,1)
GO


INSERT INTO cobis..ns_plantilla_sms (ps_id_plantilla,ps_descripcion_plantilla,ps_id_customer_vendor,ps_id_subtp_evento,ps_id_notificacion) 
VALUES('50465','Tuiio_Autorizacion_Biometrica',0,0,1)
GO



--- Creacion datos de ns_datos_mensaje
truncate table ns_datos_mensaje
go 

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('01','Buc','Buc del cliente','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('02','CodCliente','Código del cliente','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('03','Contacto','Número de teléfono del cliente','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('04','Nombre','Nombre completo del cliente','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('05','Email','Correo del cliente','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('06','Monto','Monto de la operacion','String')
GO

INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('07','Fecha','Fecha de inicio de la operacion','String')
GO
INSERT INTO cobis..ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) 
VALUES('08','Operacion','Numero del banco','String')
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

