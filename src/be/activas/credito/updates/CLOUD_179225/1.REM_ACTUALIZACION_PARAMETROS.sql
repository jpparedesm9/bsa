USE cobis
GO

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico in ('URLSA1','URLSA2','URLSA3')

UPDATE dbo.cl_parametro
SET  pa_char = 'https://tibimodal.'
WHERE pa_nemonico = 'URLSA1'
GO

UPDATE dbo.cl_parametro
SET  pa_char = 'mx.corp/'
WHERE pa_nemonico = 'URLSA2'
GO

UPDATE dbo.cl_parametro
SET pa_char = 'cobis'	
WHERE pa_nemonico = 'URLSA3'
GO

SELECT * FROM cobis..cl_parametro WHERE pa_nemonico in ('URLSA1','URLSA2','URLSA3')

go

