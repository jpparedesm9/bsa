use cobis
go


-----------------------------------------------------------------------------------------------
-- Creacion de campo ba_departamento y eliminacion de ba_distrito
-----------------------------------------------------------------------------------------------

if exists (select * from cl_errores where numero = 157095)
begin	
	update cl_errores
	set mensaje = 'Barrio ya existe en esta Ciudad'
	where numero = 157095
end 
go

