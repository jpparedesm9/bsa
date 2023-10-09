
-- \\bsa\src\be\activas\cartera\installer\sql\ca_parametros.sql
use cobis
go
delete from cl_parametro where pa_nemonico='LOREVR' and pa_producto='CCA'
insert into cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_smallint,pa_producto)
values('LONGITUD CAMPO REFERENCIA EN VALIDAR REFERENCIA','LOREVR','S',22,'CCA')
go

