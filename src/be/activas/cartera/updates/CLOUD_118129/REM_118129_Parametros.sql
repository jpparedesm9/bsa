
USE cobis
go

delete cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'DNOREN'
go


INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('DIAS CLIENTE NO RENOVADO', 'DNOREN', 'I', NULL, NULL, NULL, 90, NULL, NULL, NULL, 'CCA')
GO

SELECT * 
  FROM cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico = 'DNOREN'