------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
--Se realiza el caso 203621 en 193221
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>>PARAMETRO CONSULTA RENAPO
use cobis
go

select 'ini', * from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico = 'ACRXCR'

delete cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico = 'ACRXCR'

------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>> SERVICIO INVOCAR A RENAPO POR CURP
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
use cobis
go

declare @w_rol int,
        @w_producto int

select @w_producto = pd_producto 
from cl_producto
where pd_descripcion = 'CLIENTES'

------>>>>>>
select 'ini', * from cts_serv_catalog where csc_service_id = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp'
delete from cts_serv_catalog where csc_service_id = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp'

------>>>>>>	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR'

select 'ini' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol

------>>>>>>
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

select 'ini' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
go
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>> SERVICIO INVOCAR A RENAPO POR CURP
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
use cobis
go

declare @w_codigo int

select @w_codigo  = codigo
from cl_tabla 
where tabla= 'cl_provincia'
   
select * from cl_catalogo where tabla = @w_codigo and codigo in ('101', '102')

delete from cl_catalogo where tabla = @w_codigo and codigo in ('101', '102')
go

------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>> EQUIVALENCIAS
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
use cob_conta_super
go

select * from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')

delete from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')
