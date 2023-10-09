
use cobis
go

delete  cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NRBCDN'


insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RPT BURO CREDITO - NOMBRE REPORTE NUEVO', 'NRBCDN', 'C', 'Santander_Inclusion_N', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
go

select *  
from cobis..cl_parametro
where  pa_producto = 'REC'
and    pa_nemonico = 'NRBCDN'



delete from ba_batch where ba_batch= 36011

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (36011, 'GENERACION DE REPORTE BURO INTF TTJ', 'GENERACION DE REPORTE BURO INTF TTJ', 'SP', getDATE(), 36, 'P', 1, NULL, 'Integracion_COBIS_', 'cob_conta_super..sp_genera_buro_ttj', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

select * from ba_batch where ba_batch= 36011

delete ba_parametro where pa_batch = 36011

if not exists (select 1 from ba_parametro where pa_batch = 36011 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 36011, 0, 1, 'FECHA PROCESO', 'D', '12/01/2020')

select * from ba_parametro where pa_batch = 36011
go