use cobis
go

--ACTIVAR VALIDACION SIGUIENTE ETAPA BIO
select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'
delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'
select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'AVUSEB'
go

--CATALOGOS ACTIVIDADES DEPUES DE ESPERA DE GARANTIAS
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_activ_desp_gar_liq'

select @w_id_tabla = codigo from cobis..cl_tabla where tabla = @w_tabla

select * from cl_catalogo_pro where cp_tabla = @w_id_tabla
select * from cl_catalogo where tabla = @w_id_tabla
select * from cl_tabla where codigo = @w_id_tabla

delete cl_catalogo_pro where cp_producto = 'ADM' and cp_tabla = @w_id_tabla
delete cl_catalogo where tabla = @w_id_tabla
delete cl_tabla where codigo = @w_id_tabla

go
