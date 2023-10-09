/**********************************************************************************************************************/
--Título Incidencia          : Requerimiento #132723: Cambio de Cuenta de Ahorros
--Fecha                      : 08/01/2020
--Descripción del Problema   : Se requiere permisos para servicio nuevo
--Descripción de la Solución : Agregar permisos de registro para el nuevo servicio
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- AGREGAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------
use cobis
go

if exists (select 1 from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.Queries.SearchAccountPriority')
   update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', csc_method_name = 'searchAccountPriority', csc_description = '', csc_trn = 0 where csc_service_id = 'CustomerDataManagementService.Queries.SearchAccountPriority'
else
   insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('CustomerDataManagementService.Queries.SearchAccountPriority', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'searchAccountPriority', '', 0)
go


declare @w_rol int, @w_producto int

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CREDITO'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.Queries.SearchAccountPriority'
	insert into cobis..ad_servicio_autorizado values('CustomerDataManagementService.Queries.SearchAccountPriority', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado MESA DE OPERACIONES'
end


--------------------------------------------------------------------------------------------
-- Prelacion Cuentas
--------------------------------------------------------------------------------------------

truncate table cob_credito..cr_prelacion_cuenta

insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0056','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('10','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('18','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('05','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('06','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('11','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('07','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0021','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('19','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('09','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('17','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('15','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0057','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('14','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('12','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0053','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0015','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('09','0013','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0020','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0011','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('09','0026','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('09','0024','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0055','N3')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0025','N2')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0060','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0019','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('02','0010','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0083','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0086','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0040','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0023','N4')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01','0058','N4')



