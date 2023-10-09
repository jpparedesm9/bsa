USE cobis
go

INSERT INTO ns_datos_mensaje_detalle (dmd_codigo,dmd_id_tabla,dmd_base,dmd_tabla,dmd_columna,dmd_condicion,dmd_relacion,dmd_eliminar) VALUES (11,1,'cob_bvirtual','bv_otp_seguridad','se_codigo','se_num_mail',null,'N')
GO

INSERT INTO ns_detalle_plantilla (dp_id_plantilla,dp_id_mensaje,dp_codigo,dp_id_bloque) VALUES('50471','1','11',5)
GO

INSERT INTO ns_datos_mensaje (dm_codigo,dm_item,dm_descripcion,dm_tipo) VALUES('11','CLAVE','CLAVE - OTP - GENERICA','String')
GO