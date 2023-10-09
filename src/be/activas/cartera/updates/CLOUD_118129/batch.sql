use cobis
go
 
declare @w_server varchar(24),
        @w_path_fuente_CON varchar(255),
        @w_path_destino_CON varchar(255)
 
select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_CON = pp_path_fuente, 
       @w_path_destino_CON = pp_path_destino
from ba_path_pro
where pp_producto = 7

--BATCH
if exists (select 1 from ba_batch where ba_batch =  7532 and ba_nombre = 'REPORTE CLIENTES NO RENUEVAN' )
begin
   delete ba_batch where ba_batch =  7532 and ba_nombre = 'REPORTE CLIENTES NO RENUEVAN'
end
insert into cobis..ba_batch 
(ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7532,  'REPORTE CLIENTES NO RENUEVAN', 'REPORTE CLIENTES NO RENUEVAN','SP', getdate(), 7, 'P', 1, 'CARTERA',null,'cob_cartera..sp_reporte_renovaciones', 1,   null, @w_server, 'S', @w_path_fuente_CON, @w_path_destino_CON)

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = 7532)
begin
   delete  ba_parametro where pa_batch = 7532
end
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 7532, 0, 1, 'param1', 'D', '09/19/2017')
 


