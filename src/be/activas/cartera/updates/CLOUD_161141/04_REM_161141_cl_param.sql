
use cobis
GO

delete from cl_parametro where pa_nemonico = 'NIRICL' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('NIVEL DE RIESGO DEL CLIENTE','NIRICL','C','B','CLI')

go

