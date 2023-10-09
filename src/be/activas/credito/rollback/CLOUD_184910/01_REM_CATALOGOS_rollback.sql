----------------------------------------------------------------
-- CATALOGO VARIABLE BURO
----------------------------------------------------------------
use cobis
go

declare 
@w_nom_tabla varchar(30)

select @w_nom_tabla = 'cr_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go

use cobis
go

declare 
@w_nom_tabla varchar(30)


select @w_nom_tabla = 'cr_numero_pagos'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

go
