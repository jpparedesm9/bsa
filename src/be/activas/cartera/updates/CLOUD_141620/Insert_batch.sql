/*
*   Archivo para crear (insertar) batch de proceso requerimiento 141620
*   Johan castro
*   04/09/2020
*/

use cobis
go

if exists (select 1 from cobis..ba_batch where ba_batch = 7975) 
begin
   delete from cobis..ba_batch where ba_batch = 7975		
end

INSERT INTO cobis.dbo.ba_batch
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES(7975, 'Reporte Seguros Zurich', 'Generación del reporte seguros Zurich', 'SP ', getdate(), 7, 'R', 0, 'cartera', 'SEGUROSZURICH_DDMMYYYY.csv', 'cob_cartera..sp_batch_seguros_zurich', 1000, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\');

go