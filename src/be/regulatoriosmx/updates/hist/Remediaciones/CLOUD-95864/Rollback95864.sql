---------------------------
--ROLLBACK DE LOS SERVICIOS
---------------------------
use cobis
go


IF EXISTS(SELECT 1 FROM ServicioTmp)
   DROP table ad_servicio_autorizado

SELECT * INTO ad_servicio_autorizado
FROM ServicioTmp
