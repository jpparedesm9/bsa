/*Script de remediación para el requerimiento 140073*/

use cobis 
go
 
delete 
from cl_parametro 
where pa_nemonico = 'RECASG'

update cl_parametro
set   pa_char     = '14795-439-028351/01-01227-0420'
where pa_nemonico = 'RDRECA'

insert into cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('REPORTE DATO RECA OP SIN GRACIA', 'RECASG', 'C', '14795-439-028351/02-00343-0119', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

delete from cl_parametro where pa_nemonico in ( 'OFEPRO', 'RGASE1', 'RGASE2')

insert into cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('OFERTA PRODUCTO', 'OFEPRO', 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('REPORTE CARATULA GRUPAL ASEGURADORA 1', 'RGASE1', 'C', 'ZURICH SANTANDER SEGUROS', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro
(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values 
('REPORTE CARATULA GRUPAL ASEGURADORA 2', 'RGASE2', 'C', ' MEXICO, S.A.', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go