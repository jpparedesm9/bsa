use cobis
go

use cobis
go

declare @w_server varchar(24), 
        @w_path_fuente varchar(255), 
        @w_path_destino varchar(255),
        @w_path_fuente_CCA varchar(255),
        @w_path_destino_CCA varchar(255),
        @w_path_fuente_REG varchar(255),
        @w_path_destino_REG varchar(255),
        @w_sec INT

declare @w_batch  int
        

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

select @w_batch = ba_batch
from cobis..ba_batch
where  ba_arch_fuente like '%sp_gen_buro_act_parciales%'

delete
from cobis..ba_enlace 
where en_sarta = 22
and   en_batch_inicio = @w_batch

delete 
from cobis..ba_enlace 
where en_sarta     = 22
and   en_batch_fin = @w_batch

delete
from cobis..ba_sarta_batch
where  sb_sarta = 22
and    sb_batch = @w_batch

delete
from cobis..ba_parametro
where pa_sarta = 22
and   pa_batch = @w_batch
 

SELECT @w_sec = max(sb_secuencial) FROM cobis..ba_sarta_batch WHERE sb_sarta = 13 
SELECT @w_sec = @w_sec + 1


if not exists(select 1 from ba_sarta_batch where sb_sarta = 13 and sb_batch = @w_batch)
begin
   insert into dbo.ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
                           values (13      , @w_batch,        @w_sec,           25  , 'S'          , 'N'       , 7000   , 2300  , 13            , 'S')
end

if not exists (select 1 from dbo.ba_parametro where pa_sarta = 13 and pa_batch = @w_batch and pa_parametro = 1)
begin
    insert into dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (13, @w_batch, @w_sec, 1, 'FECHA PROCESO', 'D', '09/30/2019')
end

if not exists (select 1 from dbo.ba_parametro where pa_sarta = 13 and pa_batch = @w_batch and pa_parametro = 2)
begin
    insert into dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (13, @w_batch, @w_sec, 2, 'REPROCESO', 'C', 'N')
end

if not exists (select 1 from dbo.ba_parametro where pa_sarta = 0 and pa_batch = @w_batch and pa_parametro = 1)
begin
    insert into dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, @w_batch, 0, 1, 'FECHA PROCESO', 'D', '09/30/2019')
end

if not exists (select 1 from dbo.ba_parametro where pa_sarta = 0 and pa_batch = @w_batch and pa_parametro = 2)
begin
    insert into dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, @w_batch, 0, 2, 'REPROCESO', 'C', 'N')
end

if not exists (select 1 from dbo.ba_enlace where en_sarta = 13 and en_batch_inicio = 28790 and  en_batch_fin = @w_batch)
begin

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio,  en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
               VALUES (13      , 28790          ,                   25,  @w_batch    , @w_sec           , 'D'           , NULL     ,'N')
end

if not exists (select 1 from dbo.ba_enlace where en_sarta = 13 and en_batch_inicio = @w_batch and  en_batch_fin = 0)
begin

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio,  en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
               VALUES (13      , @w_batch       ,               @w_sec,  0           , 0                , 'S'           , NULL     ,'N')
end

-- Actualizacion Sarta 22
delete
from cobis..ba_sarta_batch
where  sb_sarta = 22

INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7000, 1, NULL, 'S', 'N', 450, 360, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 6110, 2, NULL, 'S', 'N', 1845, 360, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 6064, 3, NULL, 'S', 'N', 3315, 360, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 6220, 4, NULL, 'S', 'N', 465, 1410, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 6935, 5, 4, 'S', 'N', 1860, 1350, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7067, 6, NULL, 'S', 'N', 465, 2505, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7071, 7, NULL, 'S', 'N', 8925, 480, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7072, 8, 7, 'S', 'N', 10260, 480, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7075, 9, NULL, 'S', 'N', 8925, 3225, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7072, 10, 9, 'S', 'N', 10260, 3225, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7072, 11, 9, 'S', 'N', 10260, 4140, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7073, 12, NULL, 'S', 'N', 8925, 1395, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7072, 13, 12, 'S', 'N', 10260, 1395, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7076, 14, NULL, 'S', 'N', 8925, 2310, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7072, 15, 14, 'S', 'N', 10260, 2310, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7081, 16, NULL, 'S', 'N', 7575, 1845, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7079, 17, 16, 'S', 'N', 7620, 3270, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 28794, 18, NULL, 'S', 'N', 420, 3585, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36411, 19, NULL, 'S', 'N', 2025, 3600, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36419, 20, NULL, 'S', 'N', 3255, 3555, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36420, 21, NULL, 'S', 'N', 4560, 3540, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36424, 22, NULL, 'S', 'N', 5820, 3600, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36007, 23, NULL, 'S', 'N', 5820, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36008, 24, NULL, 'S', 'N', 6920, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36009, 25, NULL, 'S', 'N', 8020, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36425, 26, NULL, 'S', 'N', 9090, 4650, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7078, 27, NULL, 'S', 'N', 6405, 1830, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7522, 28, NULL, 'S', 'N', 10395, 5280, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7523, 29, NULL, 'S', 'N', 9135, 5610, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7515, 30, NULL, 'S', 'N', 9180, 6525, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7526, 31, NULL, 'S', 'N', 9210, 7425, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7527, 32, NULL, 'S', 'N', 10230, 7410, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7528, 33, NULL, 'S', 'N', 11220, 7410, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7511 , 34, NULL, 'S', 'N', 7995 , 6675, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 7514 , 35, null,   'S', 'N', 7995, 5670, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36426 , 36, NULL, 'S', 'N', 420, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
 VALUES (22, 36427 , 37, null,   'S', 'N', 2025, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 7221, 38, NULL, 'S', 'N', 405, 5640, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 36428, 39, NULL, 'S', 'N', 3255, 4665, 22, 'S')
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (22, 36429, 40, NULL, 'S', 'N', 4700, 360, 22, 'S')


delete from ba_parametro
where pa_sarta = 22 

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6110, 2, 1, 'EMPRESA', 'I', '1')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 1, 'EMPRESA', 'I', '1')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 2, 'FECHA INICIAL', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 3, 'FECHA FINAL', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 4, 'NIVEL OFICINA', 'I', '5')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 5, 'OFICINA INICIAL', 'I', '1')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 6, 'OFICINA FINAL', 'I', '9000')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 7, 'CUENTA INICIAL', 'C', '1')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6220, 4, 8, 'CUENTA FINAL', 'C', '9')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6935, 5, 1, 'EMPRESA', 'I', '1')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 6935, 5, 2, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7067, 6, 1, 'FECHA', 'D', '06/22/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7067, 6, 2, 'SUMAR_PADRE', 'C', 'S')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7071, 7, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7071, 7, 2, 'GRUPO', 'I', '0')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7072, 8, 1, 'TIPONOTIF', 'C', 'PFPCO')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7075, 9, 1, 'SARTA', 'I', '4')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7075, 9, 2, 'BATCH', 'I', '7075')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7072, 10, 1, 'TIPONOTIF', 'C', 'PFGVC')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7072, 11, 1, 'TIPONOTIF', 'C', 'PFGVG')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7073, 12, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7073, 12, 2, 'OPERACION', 'C', '')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7072, 13, 1, 'TIPONOTIF', 'C', 'PFIAV')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7076, 14, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7076, 14, 2, 'OPERACION', 'C', '')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7072, 15, 1, 'TIPONOTIF', 'C', 'PFCVE')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7081, 16, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 36007, 23, 1, 'FECHA PROCESO', 'D', '06/22/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 36008, 24, 1, 'FECHA PROCESO', 'D', '06/22/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7078, 27, 1,  'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7527, 32, 1, 'TIPO_REPORTE', 'C', 'D')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7528, 33, 1, 'TIPO_REPORTE', 'C', 'M')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7511, 34, 1, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 7514, 35, 1, 'FECHA_PROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 36428, 39, 1, 'FECHA REPROCESO', 'D', '09/20/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (22, 36429,40, 1, 'FECHA_PROCESO', 'D', '04/01/2018')


delete from ba_enlace
where en_sarta = 22 

INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7000, 1, 6110, 2, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 6110, 2, 6064, 3, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 6220, 4, 6110, 2, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 6220, 4, 6935, 5, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 6935, 5, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7067, 6, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7071, 7, 7072, 8, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7072, 8, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7075, 9, 7072, 10, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7075, 9, 7072, 11, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7072, 10, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7072, 11, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7073, 12, 7072, 13, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7072, 13, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7076, 14, 7072, 15, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7072, 15, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7081, 16, 7071, 7, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7081, 16, 7075, 9, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7081, 16, 7073, 12, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7081, 16, 7076, 14, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7081, 16, 7079, 17, 'D', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7079, 17, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 28794, 18, 36411, 19, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36411, 19, 36419, 20, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36419, 20, 36420, 21, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36420, 21, 36424, 22, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36424, 22, 36007, 23, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36007, 23, 36008, 24, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36008, 24, 36009, 25, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36009, 25, 36425, 26, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36425, 26, 7522, 28, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36425, 26, 7514, 35, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7078, 27, 7081, 16, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7522, 28, 7523, 29, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7523, 29, 7515, 30, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7515, 30, 7526, 31, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7526, 31, 7527, 32, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7527, 32, 7528, 33, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7528, 33, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7511, 34, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 7514, 35, 7511, 34, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36426, 36, 36427, 37, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
 VALUES (22, 36427, 37, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 7221, 38, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 36428, 39, 0, 0, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 6064, 3, 36429, 40, 'S', NULL, 'N')
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (22, 36429, 40, 0, 0, 'S', NULL, 'N')
