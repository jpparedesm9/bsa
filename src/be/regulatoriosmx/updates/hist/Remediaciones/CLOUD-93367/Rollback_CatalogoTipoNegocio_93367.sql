
PRINT '--->> Registro de catalogos-cr_tipo_negocios'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_tipo_negocio'

delete from cobis..cl_tabla where  tabla = 'cr_tipo_negocio'
delete from cobis..cl_catalogo_pro where cp_producto = 'CRE' and cp_tabla = @w_tabla 
delete from cobis..cl_catalogo where tabla = @w_tabla

