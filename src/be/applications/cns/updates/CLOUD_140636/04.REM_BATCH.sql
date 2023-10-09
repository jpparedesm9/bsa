use cobis
GO

delete cobis..ba_batch 
where ba_producto = 7
and   ba_batch = 7978

INSERT INTO cobis..ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,ba_frec_reg_proc,ba_impresora,ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino) 
VALUES(7978,'GENERACION SMS COBRANZAS','GENERACION SMS COBRANZAS','SP ',GETDATE(),7,'R',1,'CARTERA',null,'cob_cartera..sp_batch_env_sms_cobranza',10000,null,'CTSSRV','S','C:\Cobis\VBatch\Cartera\Objetos\','C:\Cobis\VBatch\Cartera\listados\')
GO

delete cobis..ba_batch 
where ba_producto = 7
and   ba_batch = 7979

INSERT INTO cobis..ba_batch (ba_batch,ba_nombre,ba_descripcion,ba_lenguaje,ba_fecha_creacion,ba_producto,ba_tipo_batch,ba_sec_corrida,ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,ba_frec_reg_proc,ba_impresora,ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino) 
VALUES(7979,'GENERACION SMS RECORDTORIOS','GENERACION SMS RECORDATORIOS','SP ',GETDATE(),7,'R',1,'CARTERA',null,'cob_cartera..sp_batch_env_sms_recordatorios',10000,null,'CTSSRV','S','C:\Cobis\VBatch\Cartera\Objetos\','C:\Cobis\VBatch\Cartera\listados\')
GO
