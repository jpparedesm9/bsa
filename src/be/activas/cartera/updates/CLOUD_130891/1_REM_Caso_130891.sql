print 'caso'
use cobis
go
declare @w_id_tabla int

select @w_id_tabla =codigo from cobis..cl_tabla
where tabla='cl_institution_barcodes'

SELECT *  from cobis..cl_catalogo
where tabla = @w_id_tabla

update  cobis..cl_catalogo
set     estado = 'B'--b
where   tabla = @w_id_tabla
and     codigo in (2,3) 

SELECT *  from cobis..cl_catalogo
where tabla = @w_id_tabla
go
