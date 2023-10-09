---version 2
select * from cobis..cl_parametro 
where pa_producto = 'CRE' and pa_nemonico in ('ACOVIT')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ACTIVAR CAMBIO POR COVIT', 'ACOVIT', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go
