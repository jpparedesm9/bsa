use cob_cartera
go

--Borrar tablas
drop table seguros_funeral_net_altas_tmp
go
drop table seguros_funeral_net_bajas_tmp
go

--Elimina parametro
delete from cobis..cl_parametro
where  pa_nemonico = 'DGRFNB'
and    pa_producto = 'CCA' 


--Borrar registro de los batch 7192 y 7193
--batch
DELETE FROM cobis..ba_batch
WHERE ba_batch = 7192 
AND ba_nombre = 'REPORTE SEGUROS FUNERAL NET ALTAS' 
AND ba_producto = 7 

DELETE FROM cobis..ba_batch
WHERE ba_batch = 7193
AND ba_nombre = 'REPORTE SEGUROS FUNERAL NET BAJAS' 
AND ba_producto = 7
GO

--ba_sarta_batch
DELETE FROM cobis..ba_sarta_batch
WHERE sb_sarta = 13 
AND sb_batch = 7192

DELETE FROM cobis..ba_sarta_batch
WHERE sb_sarta = 13 
AND sb_batch = 7193
GO

--ba_parametro
DELETE FROM cobis..ba_parametro
WHERE pa_sarta = 0 
AND pa_batch = 7192

DELETE FROM cobis..ba_parametro
WHERE pa_sarta = 0 
AND pa_batch = 7193

DELETE FROM cobis..ba_parametro
WHERE pa_sarta = 13 
AND pa_batch = 7192

DELETE FROM cobis..ba_parametro
WHERE pa_sarta = 13 
AND pa_batch = 7193
GO

--ba_enlace
DELETE FROM cobis..ba_enlace
WHERE en_sarta = 13 
AND en_batch_inicio = 7192 

DELETE FROM cobis..ba_enlace
WHERE en_sarta = 13 
AND en_batch_inicio = 7193 
GO
