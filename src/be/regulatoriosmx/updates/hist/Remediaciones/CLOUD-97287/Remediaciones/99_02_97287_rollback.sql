-- Facturación en día inhábil

USE cob_cartera
GO


--///////////////////////////////////////////////////////////
DECLARE @w_field INT 
SELECT @w_field = dc_fields_id FROM cob_fpm..fp_dictionaryfields WHERE dc_description = 'Base de cálculo'

UPDATE cob_fpm..fp_generalparametershistory
SET gph_description = 'Comercial', gph_value = 'E' WHERE dc_fields_idfk = @w_field AND gph_inheritedfrom = 'GRUPAL'

UPDATE cob_cartera..ca_default_toperacion 
set dt_base_calculo = 'E' WHERE dt_toperacion = 'GRUPAL'


--///////////////////////////////////////////////////////////
DECLARE @w_field2 INT 

SELECT @w_field2 = dc_fields_id FROM cob_fpm..fp_dictionaryfields WHERE dc_description = 'Generar evitando feriados'


UPDATE cob_fpm..fp_generalparametershistory
SET gph_description = 'No', gph_value = 'N' WHERE dc_fields_idfk = @w_field2 AND gph_inheritedfrom = 'GRUPAL'

UPDATE cob_cartera..ca_default_toperacion 
set dt_evitar_feriados = 'N' WHERE dt_toperacion = 'GRUPAL'


SELECT gph_description , gph_value , *
FROM cob_fpm..fp_generalparametershistory
WHERE dc_fields_idfk IN ( @w_field , @w_field2) AND gph_inheritedfrom = 'GRUPAL'
ORDER BY dc_fields_idfk

GO

SELECT dt_evitar_feriados, dt_base_calculo,* FROM cob_cartera..ca_default_toperacion
WHERE dt_toperacion = 'GRUPAL' 

GO

