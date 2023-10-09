use cobis
go

declare @w_nom_tabla varchar(30)

select @w_nom_tabla = 'cl_hab_func_consulta_cuenta'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go
