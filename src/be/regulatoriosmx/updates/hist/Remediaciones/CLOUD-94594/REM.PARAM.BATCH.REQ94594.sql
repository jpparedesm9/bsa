

use cobis 
go 

declare @w_server varchar(24), 
        @w_path_fuente varchar(255),
        @w_path_destino varchar(255),
        @w_secuencial    int 
        

select @w_path_fuente = pp_path_fuente, @w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 7

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'



select @w_secuencial = max(sb_secuencial) from cobis..ba_sarta_batch
where sb_sarta = 22 
select @w_secuencial = @w_secuencial +1

--CREACION DE PROCESO BATCH 
PRINT 'CREACION DE PROCESO 7221'
if exists (select 1 from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7221) begin 
   delete from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7221 and sb_secuencial = @w_secuencial
end 
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 7221, @w_secuencial, NULL, 'S', 'N', 405, 5640, 22, 'S')


select @w_secuencial = max(en_secuencial_inicio) from  
cobis..ba_enlace where en_sarta = 22
select @w_secuencial = @w_secuencial +1

if exists (select 1 from cobis..ba_enlace where en_batch_inicio = 7221 and en_sarta = 22) begin 
   delete from cobis..ba_enlace where en_batch_inicio = 7221 and en_sarta = 22  
end 
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 7221, @w_secuencial, 0, 0, 'S', NULL, 'N')


if exists (select 1 from cobis..ba_batch where ba_batch = 7221)begin
   delete from cobis..ba_batch where ba_batch = 7221
end 
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7221, 'PASO A HISTORICOS DE CARTERA ', 'PASO A HISTORICOS DE CARTERA', 'SP', getdate(), 7, 'P', 1, 'CARTERA', NULL, 'cob_cartera..sp_pasohis', 1000, NULL, @w_server, 'S', @w_path_fuente, @w_path_destino)


--------login_batch 

if exists (select 1 from cobis..ba_login_batch where lb_sarta = 22 and lb_batch = 7221 and lb_login in ('admuser','usrbatch'))begin 
   delete from cobis..ba_login_batch where lb_sarta = 22 and lb_batch = 7221 and lb_login in ('admuser','usrbatch')
end 

insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select  distinct 'admuser',sb_sarta, sb_batch,getdate(),'V','admuser',getdate() 
from cobis..ba_sarta_batch where sb_sarta = 22 and sb_batch = 7221

insert into cobis..ba_login_batch (lb_login,lb_sarta,lb_batch,lb_fecha_aut,lb_estado,lb_usuario,lb_fecha_ult_mod)
select  distinct 'usrbatch',sb_sarta, sb_batch,getdate(),'V','usrbatch',getdate() 
from cobis..ba_sarta_batch  where sb_sarta = 22 and sb_batch = 7221

