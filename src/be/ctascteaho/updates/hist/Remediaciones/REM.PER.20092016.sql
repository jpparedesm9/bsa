USE cob_remesas
GO

IF EXISTS (SELECT 1 FROM  cob_remesas..pe_rango WHERE ra_tipo_rango = 1 AND ra_grupo_rango = 1 AND ra_rango = 1)
BEGIN

UPDATE  cob_remesas..pe_rango
SET ra_hasta = 999999999.99
WHERE ra_tipo_rango = 1
AND ra_grupo_rango = 1
AND ra_rango = 1

END

go