-- \bsa\src\be\applications\mobileapp\b2c\installer\sql\b2c_param.sql
use cobis
go

delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('APRDIG')

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) 
VALUES ('ACTIVACION PRODUCTO DIGITAL', 'APRDIG', 'C', 'N', 'CLI')
