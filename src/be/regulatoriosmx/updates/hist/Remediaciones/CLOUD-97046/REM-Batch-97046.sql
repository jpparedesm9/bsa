USE cobis
go

UPDATE cobis..ba_parametro SET pa_valor='PFGVC' WHERE pa_sarta=22 AND pa_batch=7072 AND pa_ejecucion=10 
UPDATE cobis..ba_parametro SET pa_valor='PFGVG' WHERE pa_sarta=22 AND pa_batch=7072 AND pa_ejecucion=11 
UPDATE cobis..ba_parametro SET pa_valor='PFIAV' WHERE pa_sarta=22 AND pa_batch=7072 AND pa_ejecucion=13
UPDATE cobis..ba_parametro SET pa_valor='PFCVE' WHERE pa_sarta=22 AND pa_batch=7072 AND pa_ejecucion=15
SELECT * FROM cobis..ba_sarta WHERE sa_sarta=22

SELECT * FROM cobis..ba_sarta_batch WHERE sb_sarta =22 AND  sb_batch IN (7071,7072,7073,7075,7076)
SELECT * FROM cobis..ba_parametro WHERE pa_sarta=22 AND pa_batch IN (7072)

go