use cobis
go
-- Caso 180130 - Modificaciones SMS Cobranzas
-- 20220811
-- \CLOUD_180130\src\be\activas\cartera\installer\sql\ca_parametros.sql
delete from cl_parametro where pa_nemonico in ('SMSPRE','SMSCOB') and pa_producto = 'CCA'


go


