--------------------------------------------------------------------------------------------------------------------------------
-- CREACION DE BATCH PARA REPORTE OPERATIVO LCR
--------------------------------------------------------------------------------------------------------------------------------
use cobis
go

declare @w_server            varchar(24),
        @w_path_fuente       varchar(255),
        @w_path_destino      varchar(255)
    
       

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 36


print @w_server          
print @w_path_fuente     
print @w_path_destino   


if not exists (select 1 from cobis..ba_batch where ba_batch = 28795)
begin
   print 'Ingreso a cargar el proceso batch'
   INSERT into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino) 
   VALUES (28795, 'REPORTE OPERATIVO DE CARTERA LCR', 'REPORTE OPERATIVO DE CARTERA LCR', 'SP', getdate(), 36, 'P', 1, null, null, 'cob_conta_super..sp_reporte_operativo_lcr', 10000, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
   
end

if not exists (select 1 from ba_parametro where pa_batch = 28795 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28795, 0, 1, 'FECHA PROCESO', 'D', '07/08/2019')

if not exists(select 1 from ba_parametro where pa_batch = 28795 and pa_nombre = 'PROCESO')
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28795, 0, 2, 'PROCESO', 'I', '28795')

if not exists(select 1 from ba_parametro where pa_batch = 28795 and pa_nombre = 'FORMATO FECHA')
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 28795, 0, 3, 'FORMATO FECHA', 'I', '111')