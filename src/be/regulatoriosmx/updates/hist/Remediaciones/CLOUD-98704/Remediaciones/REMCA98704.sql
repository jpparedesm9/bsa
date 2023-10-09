/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento #98704: Descarga de información de forma ofuscada
--Fecha                      : 06/08/2018
--Descripción del Problema   : No existen registros ni campos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Alexander Inca S.
/**********************************************************************************************************************/

-- Creación de registro en cobis..ba_batch

if not exists (select 1 from cobis..ba_batch where ba_nombre = 'GENERACION ARCHIVO DRP')

begin

declare @w_id_ba INT,
        @fecha_creacion DATETIME

SELECT @fecha_creacion = GETDATE(); 
SELECT @w_id_ba =  max(ba_batch)+1 from cobis..ba_batch

INSERT INTO cobis..ba_batch(ba_batch,ba_nombre,ba_descripcion,ba_lenguaje, 
                            ba_fecha_creacion,ba_producto,ba_tipo_batch,ba_sec_corrida, 
                            ba_ente_procesado,ba_arch_resultado,ba_arch_fuente,ba_frec_reg_proc, 
                            ba_impresora,ba_serv_destino,ba_reproceso,ba_path_fuente,ba_path_destino) 
                     VALUES(@w_id_ba, 'GENERACION ARCHIVO DRP', 'GENERACION ARCHIVO DRP', 'SP', 
                            @fecha_creacion, 8, 'R', 1, 
                            NULL,'DataOfuscada.properties', 'cobis..sp_batch_data_ofuscada', 1000, 
                            NULL, 'CTSSRV', 'S', NULL, '\\192.168.33.43\dataofuscada')
end

-- Creación de registro en cobis..ba_sarta

if not exists (select 1 from cobis..ba_sarta where sa_sarta = 80)
begin

declare @w_fecha DATETIME
select @w_fecha=GETDATE();
INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion,
                             sa_creador, sa_producto, sa_dependencia, sa_autorizacion) 
	                  VALUES(80,'RESPALDO DATA OFUSCADA', 'RESPALDO DATA OFUSCADA', @w_fecha,
                             'admuser', 8, NULL, NULL)
end

-- Creación de registro en cobis..ba_sarta_batch

if not exists (select 1 from cobis..ba_sarta_batch where sb_sarta = 80)
begin

declare @w_sb_bat int
select @w_sb_bat =  ba_batch from cobis..ba_batch 
where ba_nombre = 'GENERACION ARCHIVO DRP'

INSERT INTO cobis..ba_sarta_batch(sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion,
                                  sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
	                       VALUES(80, @w_sb_bat, 1, NULL, 'S', 'N', 500, 550, 80, 'S')
end

-- Creación de registro en cobis..ba_enlace
if not exists(select 1 from cobis..ba_enlace where en_sarta=80)
begin

declare @w_en_bat int
select @w_en_bat =  ba_batch from cobis..ba_batch 
where ba_nombre = 'GENERACION ARCHIVO DRP'

INSERT INTO cobis..ba_enlace(en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes) 
VALUES (80, @w_en_bat, 1, 0, 0, 'S', NULL, 'N')
end

