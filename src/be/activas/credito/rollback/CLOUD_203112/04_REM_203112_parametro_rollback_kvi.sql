use cobis
go 

-- PARAMETRO TIPO CALIFICACION -- Requerimiento #203112 OT Modelo Aceptaci�n Grupal, BC
--Antes
select * from cl_parametro where pa_nemonico = 'TIPCAL'

delete cl_parametro where pa_nemonico = 'TIPCAL'

--Despues
select * from cl_parametro where pa_nemonico = 'TIPCAL'

go

