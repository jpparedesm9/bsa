-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cob_credito
go

IF OBJECT_ID ('cr_orden_eje_cuestionario') IS NOT NULL
	DROP TABLE cr_orden_eje_cuestionario
GO

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cob_credito
go

IF OBJECT_ID ('cr_ej_regla_aplica_cuest') IS NOT NULL
	DROP TABLE cr_ej_regla_aplica_cuest
GO

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_parametro where pa_nemonico = 'CDWCOO' and pa_producto = 'CRE'
delete cl_parametro where pa_nemonico = 'CDWCOO' and pa_producto = 'CRE'

go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
--CATALOGOS ACTIVIDADES CUESITONARIO
use cobis
go

declare @w_id_tabla int, @w_tabla char(30)
select  @w_tabla = 'cr_act_cuestionario'

select @w_id_tabla = codigo from cl_tabla where tabla = @w_tabla
select * from cl_tabla where codigo = @w_id_tabla
select * from cl_catalogo_pro where cp_tabla = @w_id_tabla
select * from cl_catalogo where tabla = @w_id_tabla

delete cl_tabla where codigo = @w_id_tabla
delete cl_catalogo_pro where cp_tabla = @w_id_tabla
delete cl_catalogo where tabla = @w_id_tabla
go

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_errores where numero in (2101172)

delete from cl_errores where numero in (2101172)

-----------***********-----------***********-----------***********-----------***********
-----------***********-----------***********-----------***********-----------***********
use cobis
go

select * from cl_errores where numero in (705080)

delete from cl_errores where numero in (705080)
go
