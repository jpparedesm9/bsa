--Disposiciones B2C -- Caso #162334
use cobis
go

delete cl_parametro where pa_nemonico in ('MSCCTA', 'CHRSEP')

insert into cobis..cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('MASCARA CUENTA', 'MSCCTA', 'C', 'X', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')


INSERT INTO cl_parametro 
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES 
('CARACTERES SEPARACION', 'CHRSEP', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
go