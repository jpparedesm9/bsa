USE cobis
go

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_plazo_grp')
DELETE cl_tabla WHERE tabla = 'cr_plazo_grp'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_gracia_grp')
DELETE cl_tabla WHERE tabla = 'cr_gracia_grp'


go