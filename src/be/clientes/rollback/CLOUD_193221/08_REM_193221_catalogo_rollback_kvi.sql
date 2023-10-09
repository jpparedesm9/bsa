--Antes
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_tipos_aceptacion')


------------------------------------------------------------------
-- CATALOGO DE TIPOS DE ACEPTACION - R193221 - B2B Grupal Digital
------------------------------------------------------------------
use cobis
go

declare 
@w_nom_tabla varchar(30)

select @w_nom_tabla = 'cl_tipos_aceptacion'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla


--Despues
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_tipos_aceptacion')

go
