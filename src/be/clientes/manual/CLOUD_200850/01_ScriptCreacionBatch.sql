--------------------------------------------------------------------------------------------------------------------------------
-- CREACION DE BATCH PARA REPORTES CONCILIADOR CONTABLE REQ.172199
--------------------------------------------------------------------------------------------------------------------------------
use cobis
go

declare @w_server            varchar(24),
        @w_path_fuente       varchar(255),
        @w_path_destino      varchar(255)		

select @w_server = pa_char -- 'CTSSRV'
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_path_fuente = pp_path_fuente, -- 'C:\Cobis\VBatch\Regulatorios\Objetos\'
       @w_path_destino = pp_path_destino -- 'C:\Cobis\VBatch\Regulatorios\listados\'
from ba_path_pro
where pp_producto = 36

print @w_server          
print @w_path_fuente     
print @w_path_destino   

if not exists(select 1 from cobis..ba_batch where ba_batch = 36452)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36452, 'ARCHIVO COBIS_PROV_REFIN', 'ARCHIVO COBIS_PROV_REFIN', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_PROV_REFIN', 'cob_cartera..sp_cobis_renova', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists (select 1 from ba_parametro where pa_batch = 36452 and pa_nombre = 'FECHA PROCESO' )
  insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values (0, 36452, 0, 1, 'FECHA PROCESO', 'D', '04/09/2021')

if not exists(select 1 from ba_parametro where pa_batch = 36452 and pa_nombre = 'REPROCESO')
  insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) values (0, 36452, 0, 2, 'REPROCESO', 'C', 'N')

--despues de insertar
select * from cobis..ba_batch
where ba_batch in (36452)
--despues de insertar
select * from cobis..ba_parametro
where pa_batch in (36452)

go 
