EXEC cob_cartera.dbo.sp_santander_gen_orden_dep

SELECT TOP 10 * FROM cob_cartera.dbo.ca_santander_orden_deposito
WHERE sod_consecutivo = 181

SELECT COUNT(*) FROM cob_cartera.dbo.ca_santander_orden_deposito

TRUNCATE TABLE cob_cartera.dbo.ca_santander_orden_deposito

SELECT * FROM cob_cartera.dbo.ca_santander_orden_deposito

SELECT DISTINCT sod_consecutivo FROM cob_cartera.dbo.ca_santander_orden_deposito

SELECT TOP 10 dm_estado, dm_fecha, * FROM cob_cartera.dbo.ca_desembolso
WHERE dm_fecha BETWEEN '20161002' AND '20161003' 

SELECT COUNT(*) FROM cob_cartera.dbo.ca_desembolso
WHERE dm_fecha BETWEEN '20161002' AND '20161003' 

SELECT DISTINCT dm_fecha FROM cob_cartera.dbo.ca_desembolso

SELECT COUNT(*) FROM cob_cartera.dbo.ca_desembolso
WHERE dm_estado = 'A' 

SELECT COUNT(*) FROM cob_cartera.dbo.ca_desembolso
WHERE dm_estado = 'N' 

UPDATE cob_cartera.dbo.ca_desembolso
SET dm_estado = 'N'
WHERE dm_fecha > '20161003'

SELECT COUNT(*) FROM cob_cartera.dbo.ca_desembolso
WHERE dm_fecha > '20161002' 

SELECT DISTINCT dm_estado
FROM cob_cartera.dbo.ca_desembolso

UPDATE cob_cartera.dbo.ca_desembolso
SET dm_estado = 'A'
WHERE dm_fecha BETWEEN '20161002' AND '20161003' 
