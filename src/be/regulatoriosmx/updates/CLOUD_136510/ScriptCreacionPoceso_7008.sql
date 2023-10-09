
use cobis
go

if not exists (select 1 from cobis..ba_batch where ba_batch = 7008)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (7008, 'EJECUCION BOC GENERAR UNIVERSO PARALELO', 'EJECUCION BOC GENERAR UNIVERSO PARALELO', 'SP', '2020-01-07', 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_boc_opt', 1000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', NULL)   
end

if not exists (select 1 from ba_parametro where pa_batch = 7008 and pa_sarta = 0 and pa_parametro = 1)
begin
   insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 7008, 0, 1, 'EMPRESA', 'I', '1')
end 
go


if not exists (select 1 from ba_parametro where pa_batch = 7008 and pa_sarta = 0 and pa_parametro = 2)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 7008, 0, 2, 'FECHA', 'D', '03/09/2020')
end  
go

if not exists (select 1 from ba_parametro where pa_batch = 7008 and pa_sarta = 0 and pa_parametro = 3)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 7008, 0, 3, 'HISTORICO', 'C', 'S')
end    

go

