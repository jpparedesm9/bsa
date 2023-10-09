use cobis
if exists (select 1 from cobis..ba_batch where ba_batch = 36432)
   delete cobis..ba_batch where ba_batch = 36432
go

insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (36432, 'ACTUALIZA EXPERIENCIA CRED', 'ACTUALIZA EXPERIENCIA DE CREDITICIA', 'SP', getdate(), 36, 'P', 1, null, null, 'cob_conta_super..sp_act_experiencia_cred', 10000, null, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
GO


