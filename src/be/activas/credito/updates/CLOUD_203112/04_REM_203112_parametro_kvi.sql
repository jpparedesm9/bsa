use cobis
go 

-- PARAMETRO TIPO CALIFICACION -- Requerimiento #203112 OT Modelo Aceptación Grupal, BC
--Antes
select * from cl_parametro where pa_nemonico = 'TIPCAL'

delete cl_parametro where pa_nemonico = 'TIPCAL'
insert into cl_parametro values('TIPO CALIFICACION PARA EVALUACION CLIENTE', 'TIPCAL', 'C', 'S', null, null, null, null, null, null, 'CLI')

--Despues
select * from cl_parametro where pa_nemonico = 'TIPCAL'

go

