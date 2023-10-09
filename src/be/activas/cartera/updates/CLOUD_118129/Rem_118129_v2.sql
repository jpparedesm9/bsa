USE cobis
go

delete from cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico = 'DANORE'

go

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS ATRASO NO RENOVADO', 'DANORE', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CCA')
GO



go

use cobis
go

Update cobis..cl_parametro
set pa_int=1
where  pa_producto = 'CCA'
and    pa_nemonico = 'DNOREN'
go

SELECT * 
FROM cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico = 'DANORE'

SELECT * 
FROM cobis..cl_parametro
where pa_producto = 'CCA'
and pa_nemonico = 'DNOREN'