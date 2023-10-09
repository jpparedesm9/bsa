--////////////////////////////////////////
USE cobis
GO


SELECT ba_lenguaje , ba_nombre FROM cobis..ba_batch WHERE ba_batch = 7221
UPDATE cobis..ba_batch SET ba_lenguaje = 'SP' WHERE ba_batch = 7221
SELECT ba_lenguaje , ba_nombre FROM cobis..ba_batch WHERE ba_batch = 7221




-- MODIFICAR EL 7071

UPDATE cobis..ba_batch SET
	ba_arch_fuente = 'cob_cartera..sp_gen_ref_cuota_vigente'
WHERE ba_batch = 7071

-- BORRAR LOS ENLACES DEL 7091 Y 7072
DELETE FROM cobis..ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 7091 AND en_secuencial_inicio = 39
DELETE FROM cobis..ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 7072 AND en_secuencial_inicio = 40

-- 7221 CAMBIAR LA SECUENCIA DE 41 A 39
UPDATE cobis..ba_enlace SET
	en_secuencial_inicio = 39
WHERE en_sarta = 22 
AND en_batch_inicio = 7221 
AND en_secuencial_inicio = 41


-- 7072 SEC 8 CAMBIAR BATCH FIN Y SEC FIN
UPDATE cobis..ba_enlace SET
	en_batch_fin      = 0,
	en_secuencial_fin = 0
WHERE en_sarta = 22 
AND en_batch_inicio = 7072
AND en_secuencial_inicio = 8


-- 36427 ARREGLAR ESTE QUE HA ESTADO MAL
UPDATE cobis..ba_enlace SET
	en_batch_fin      = 0,
	en_secuencial_fin = 0
WHERE en_sarta = 22 
AND en_batch_inicio = 36427
AND en_secuencial_inicio = 38


DELETE FROM cobis..ba_sarta_batch WHERE sb_sarta = 22 AND sb_batch = 7091 AND sb_secuencial = 39
DELETE FROM cobis..ba_sarta_batch WHERE sb_sarta = 22 AND sb_batch = 7072 AND sb_secuencial = 40

UPDATE cobis..ba_sarta_batch SET
	sb_secuencial = 39
WHERE sb_sarta = 22 
AND sb_batch = 7221 
AND sb_secuencial = 41


DELETE FROM cobis..ba_parametro WHERE pa_sarta = 22 AND pa_batch = 7091 AND pa_ejecucion = 39
DELETE FROM cobis..ba_parametro WHERE pa_sarta = 22 AND pa_batch = 7072 AND pa_ejecucion = 40
DELETE FROM cobis..ba_parametro WHERE pa_sarta = 00 AND pa_batch = 7091 

DELETE FROM cobis..ba_parametro WHERE pa_sarta = 22 AND pa_batch = 7071 AND pa_ejecucion =  7 AND pa_parametro = 2
DELETE FROM cobis..ba_parametro WHERE pa_sarta = 04 AND pa_batch = 7071 AND pa_ejecucion = 37 AND pa_parametro = 2
DELETE FROM cobis..ba_parametro WHERE pa_sarta = 0  AND pa_batch = 7071 AND pa_ejecucion =  0 AND pa_parametro = 2

INSERT INTO cobis..ba_parametro VALUES (0,  7071, 0, 2, 'GRUPO', 'I', '0')
INSERT INTO cobis..ba_parametro VALUES (04, 7071,37, 2, 'GRUPO', 'I', '0')
INSERT INTO cobis..ba_parametro VALUES (22, 7071, 7, 2, 'GRUPO', 'I', '0')

DELETE cobis..ba_batch WHERE ba_batch = 7091


GO


