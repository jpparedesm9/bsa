use cobis
go
-- PARAMETRO PARA LIBERACIÓN CONTROLADA EN "GENERAR Y MODIFICAR CÓDIGO" de B2C
delete cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'ACTOFC'
insert into cl_parametro values('ACTIVAR TODAS LAS OFICINAS', 'ACTOFC', 'C', 'S', null, null, null, null, null, null,'CCA')

go

