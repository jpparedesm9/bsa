
SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'PPREPR'
SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'PPREPC'
SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'PPREPL' -- se quita y se reemplza por PPREPC

----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>----------------------------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>
--Este PPREPC en lugar de este PPREPL
delete cobis..cl_parametro WHERE pa_nemonico = 'PPREPL'

if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PPREPC' and pa_producto = 'CRE')
    update cobis..cl_parametro set pa_char = 'JUR-963-(062021)' where pa_nemonico = 'PPREPC' and pa_producto = 'CRE'
else
    insert into cl_parametro values ('PIE PERIODO RENOVACIONES CONTRATO', 'PPREPC', 'C', 'JUR-963-(062021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
	
if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PPREPR' and pa_producto = 'CRE')
    update cobis..cl_parametro set pa_char = '-(062021)' where pa_nemonico = 'PPREPR' and pa_producto = 'CRE'
else
    insert into cl_parametro values ('PIE PERIODO RENOVACIONES', 'PPREPR', 'C', '-(062021)', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go
