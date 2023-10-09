------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
--Se realiza el caso 203621 en 193221
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>>PARAMETRO CONSULTA RENAPO
use cobis
go

select 'ini', * from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico = 'ACRXCR'

delete cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico = 'ACRXCR'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ACTIVAR CONSULTA RENAPO POR CURP', 'ACRXCR', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

select 'fin', * from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico = 'ACRXCR'
go

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
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', 'com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl.IOrchestationRenapoService', 'renapoQueryByCurp', 'Consultar Servicio RENAPO POR CURP', NULL, 'N')

select 'fin', * from cts_serv_catalog where csc_service_id = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp'
------>>>>>>	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR'

select 'ini' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
select 'fin' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
------>>>>>>
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

select 'ini' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
delete from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
select 'fin' ,* from ad_servicio_autorizado where ts_servicio = 'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp' and ts_rol = @w_rol
go

------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>> CATALOGO
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
use cobis
go

declare @w_codigo int

select @w_codigo  = codigo
from cl_tabla 
where tabla= 'cl_provincia'
   
select * from cl_catalogo where tabla = @w_codigo and codigo in ('101', '102')

delete from cl_catalogo where tabla = @w_codigo and codigo in ('101', '102')

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '101', 'Serv. Exterior Mexicano', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_codigo, '102', 'Nacido en el Extranjero', 'V', NULL, NULL, NULL)
go

------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
------>>>>>> EQUIVALENCIAS
------>>>>>>------>>>>>>------>>>>>>------>>>>>>------>>>>>>
use cob_conta_super
go

select * from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')

delete from sb_equivalencias where eq_catalogo = 'ENT_FED' and eq_valor_arch in ('101','102')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('ENT_FED', '101', '101', 'Serv. Exterior Mexicano', 'V')

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('ENT_FED', '102', '102', 'Nacido en el Extranjero', 'V')
go
