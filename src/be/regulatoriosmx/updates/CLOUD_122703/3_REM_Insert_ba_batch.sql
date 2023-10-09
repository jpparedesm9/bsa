--------------------------------------------------------------------------------------------
-- AGREGAR BATCH
--------------------------------------------------------------------------------------------
use cobis
declare @w_servidor varchar(24), @w_batch_id int

select @w_servidor = pa_char from cobis..cl_parametro where pa_nemonico = 'SRVR'
select @w_batch_id = 36432

if not exists(select * from cobis..ba_batch where ba_batch = @w_batch_id)
begin
   insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)								
   values (@w_batch_id, 'GENERACION REPORTE APERTURA CUENTAS N4', 'GENERACION REPORTE APERTURA CUENTAS N4', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'Aperturas', 'cob_conta_super..sp_rpt_apertura_cuentas',  1, null, @w_servidor,  'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'D:\WorkFolder\Apertura de Cuentas N4\listados\')		
end
go
