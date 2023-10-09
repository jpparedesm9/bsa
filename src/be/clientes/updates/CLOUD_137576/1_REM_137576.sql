select * from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('ACCEDU')

delete from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('ACCEDU')

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ACTIVAR CELULAR DUPLICADO', 'ACCEDU', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
GO

select * from cobis..cl_parametro 
where pa_producto = 'CLI' and pa_nemonico in ('ACCEDU')
go
