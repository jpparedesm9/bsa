-----------------------
--CASO 109457 ROLLBACK
-----------------------
use cobis
go


UPDATE cobis..cl_grupo 
SET gr_gar_liquida = 'S'
WHERE gr_grupo = 1177


go

