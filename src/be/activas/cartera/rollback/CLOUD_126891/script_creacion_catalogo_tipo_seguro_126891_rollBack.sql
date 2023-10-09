use cobis
go


declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

SELECT @w_producto = pd_abreviatura FROM cobis..cl_producto 
WHERE pd_descripcion = 'CARTERA'

delete cl_catalogo where tabla in (select codigo from cl_tabla where  tabla in ('ca_tipo_seguro'))
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where  tabla in ('ca_tipo_seguro'))
delete cl_tabla where  tabla in ('ca_tipo_seguro')

use cobis
go

select * from cobis..cl_parametro where pa_nemonico = 'NDEDAD'
delete cobis..cl_parametro where pa_nemonico = 'NDEDAD'
select * from cobis..cl_parametro where pa_nemonico = 'NDEDAD'



