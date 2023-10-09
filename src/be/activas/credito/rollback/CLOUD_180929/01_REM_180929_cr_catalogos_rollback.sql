----------------------------------------------------------------
-- ROLLBACK CATALOGO DE ETAPAS QUE PUEDEN CONSULTAR A BURO
----------------------------------------------------------------
use cobis
go

declare 
@w_nom_tabla varchar(30)

select @w_nom_tabla = 'cr_etapa_si_cons_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go
