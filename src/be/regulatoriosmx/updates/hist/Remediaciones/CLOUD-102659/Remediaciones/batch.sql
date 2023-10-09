use cobis
go
declare @w_server varchar(24),
        @w_path_fuente varchar(255),
        @w_path_destino varchar(255),
        @w_secuencial    int

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 36


select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'


select @w_secuencial = max(sb_secuencial) from cobis..ba_sarta_batch
where sb_sarta = 22
select @w_secuencial = @w_secuencial +1

if exists (select 1 from cobis..ba_batch where ba_batch = 7529)begin
   delete from cobis..ba_batch where ba_batch = 7529
end
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7529, 'ARCHIVO ODS-9 RIESGOS BDI', 'ARCHIVO ODS-9 RIESGOS BDI', 'SP', getdate(), 36, 'P', 1, 'REGULATORIOS', 'BMXP_MOVIMIENTOS_COB', 'cob_conta_super..sp_ods_bdi', 1, NULL, @w_server, 'S', @w_path_fuente, @w_path_destino)

if exists (select 1 from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7529) begin
   delete from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7529
end
INSERT INTO ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
VALUES (22, 7529,  @w_secuencial, null, 'S', 'N', 1400, 2505, 22, 'S')



if exists (select 1 from cobis..ba_enlace where en_batch_inicio = 7529 and en_sarta = 22) begin
   delete from cobis..ba_enlace where en_batch_inicio = 7529 and en_sarta = 22 
end

INSERT INTO ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
VALUES (22, 7529,  @w_secuencial, 0, 0, 'S', NULL, 'N')

if exists (select 1 from cobis..ba_parametro where  pa_batch = 7529) begin
   delete from cobis..ba_parametro where  pa_batch = 7529 
end
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)VALUES (0, 7529, 0, 1, 'FECHA PROCESO', 'D', '05/30/2018')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)VALUES (0, 7529, 0, 2, 'BATCH', 'I', '7529')

insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)VALUES (22, 7529, @w_secuencial, 1, 'FECHA PROCESO', 'D', '05/30/2018')
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)VALUES (22, 7529, @w_secuencial, 2, 'BATCH', 'I', '7529')
GO
