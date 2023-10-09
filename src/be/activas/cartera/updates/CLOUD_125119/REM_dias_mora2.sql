
USE cob_cartera
GO

----------
--PARTE 1
----------

UPDATE ca_default_toperacion
SET dt_porcen_colateral = 0
WHERE dt_toperacion = 'GRUPAL'

----------
--PARTE 2
----------

UPDATE ca_operacion
SET op_margen_redescuento = 7
WHERE op_toperacion = 'GRUPAL'

UPDATE ca_operacion_his
SET oph_margen_redescuento = 7
WHERE oph_toperacion = 'GRUPAL'

UPDATE cob_cartera_his..ca_operacion_his
SET oph_margen_redescuento =  7
WHERE oph_toperacion = 'GRUPAL'

GO
