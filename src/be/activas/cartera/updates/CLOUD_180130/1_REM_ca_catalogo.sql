-- Caso 180130 - Modificaciones SMS Cobranzas
use cobis
go
-- \CLOUD_180130\src\be\activas\cartera\installer\sql\ca_parametros.sql -- 20220811
delete from cl_parametro where pa_nemonico in ('SMSPRE','SMSCOB') and pa_producto = 'CCA'
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SMS PREVENTIVO-CANT MIEMBROS MESA DIRECTIVA A NOTIFICAR(P,T,S)', 'SMSPRE', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'CCA')
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('SMS COBRANZA-CANT MIEMBROS MESA DIRECTIVA A NOTIFICAR(P,T,S)', 'SMSCOB', 'T', NULL, 3, NULL, NULL, NULL, NULL, NULL, 'CCA')


go


