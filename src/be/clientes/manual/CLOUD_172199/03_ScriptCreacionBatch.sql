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


if not exists(select 1 from cobis..ba_batch where ba_batch = 36439)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36439, 'ARCHIVO S1DQ0140', 'ARCHIVO S1DQ0140', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'S1DQ0140_COBIS_D_', 'cob_conta_super..sp_rep_s1d_cobis_d', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36439 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36439, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36440)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36440, 'ARCHIVO ESTRUCTURA', 'ARCHIVO ESTRUCTURA', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'Estructura_COBIS_D_', 'cob_conta_super..sp_estructura_cobis', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36440 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36440, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36441)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36441, 'ARCHIVO CUENTA', 'ARCHIVO CUENTA', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_CUENTA', 'cob_conta_super..sp_cobis_cuenta', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36441 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36441, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36442)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36442, 'ARCHIVO CENTRO', 'ARCHIVO CENTRO', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_CENTRO', 'cob_conta_super..sp_cobis_centro', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36442 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36442, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36443)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36443, 'ARCHIVO EMPRESA', 'ARCHIVO EMPRESA', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_EMPRESA', 'cob_conta_super..sp_cobis_empresa', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36443 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36443, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36444)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36444, 'ARCHIVO CLACON', 'ARCHIVO CLACON', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_CLACON_D_', 'cob_conta_super..sp_cobis_clacon', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36444 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36444, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36445)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36445, 'ARCHIVO SO', 'ARCHIVO SO', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_SO_', 'cob_conta_super..sp_cobis_so', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36445 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36445, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36446)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36446, 'ARCHIVO MOV', 'ARCHIVO MOV', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_MOV_', 'cob_conta_super..sp_cobis_mov', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36446 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36446, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36447)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36447, 'ARCHIVO SM', 'ARCHIVO SM', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_SM_', 'cob_conta_super..sp_rep_cobis_sm', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36447 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36447, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36448)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36448, 'ARCHIVO SDOLAR', 'ARCHIVO SDOLAR', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_SDOLAR_', 'cob_conta_super..sp_cobis_sdolar', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36448 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36448, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

if not exists (select 1 from cobis..ba_batch where ba_batch = 36449)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36449, 'ARCHIVO MOVLAR', 'ARCHIVO MOVLAR', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'COBIS_MOVLAR_', 'cob_conta_super..sp_cobis_movlar', 1, null, @w_server, 'S', @w_path_fuente, @w_path_destino)
end

if not exists(select * from cobis..ba_parametro where pa_batch = 36449 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 36449, 0, 1, 'FECHA PROCESO', 'D', '04/04/2022')
end

--despues de insertar
select * from cobis..ba_batch
where ba_batch in (36439, 36440, 36441, 36442, 36443, 36444, 36445, 36446, 36447, 36448, 36449)

select * from cobis..ba_parametro 
where pa_batch in (36439, 36440, 36441, 36442, 36443, 36444, 36445, 36446, 36447, 36448, 36449)
and pa_sarta = 0

go 
