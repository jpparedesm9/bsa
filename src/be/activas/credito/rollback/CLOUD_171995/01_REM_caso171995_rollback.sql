
--select TOP 100 * from ca_param_seguro_externo
--select TOP 100 * from ca_param_seguro_externo

SELECT TOP 100 * FROM cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'

DELETE cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'

SELECT TOP 100 * FROM cobis..cl_parametro WHERE pa_producto = 'CRE' AND pa_nemonico = 'SEVIDV'
go
