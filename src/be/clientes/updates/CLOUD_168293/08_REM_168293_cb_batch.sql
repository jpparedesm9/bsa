--------------------------------------------------------------------------------------------------------------------------------
-- CREACION DE BATCH PARA REPORTE DE GEOLOCALIZACION 168293 F2
--------------------------------------------------------------------------------------------------------------------------------
use cobis
go

declare @w_batch int,
        @w_fecha datetime

select @w_batch = 36450,
	   @w_fecha = getdate()

if not exists(select 1 from cobis..ba_batch where ba_batch = @w_batch)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (@w_batch, 'GENERACION ARCHIVO GEOLOCALIZACION BANCARIA', 'GENERACION ARCHIVO GEOLOCALIZACION BANCARIA', 'SP', @w_fecha, 36, 'R', 1, 'REGULATORIOS', 'TuiioMovil_geolocalizacion_', 'cob_conta_super..sp_rpt_geolocaliza_b2c', 1, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end 

go
