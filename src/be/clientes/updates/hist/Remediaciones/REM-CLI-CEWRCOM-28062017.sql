
use cobis
go

declare @w_me_id		int,
		@w_moneda 		int,
		@w_producto		int,
		@w_resource     int,
		@w_rol			int


select @w_moneda = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'
   
select @w_producto = pd_producto 
  from cobis..cl_producto 
 where pd_producto =2

  
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'
  
 ---Creación Recursos Contenedor 
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/CSTMR/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/CSTMR/.*')
 END
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/LOANS/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/LOANS/.*')
 END
  
--Autorización recursos al rol Menú por procesos

 --SAnti--
if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/CSTMR/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/CSTMR/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/LOANS/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/LOANS/.*'
end

---AUTORIZACIÓN DE FUNCIONALIDADES DE PROSPECTOS----
---CREACIÓN DE PROSPECTOS---
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_PROSPECTS'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda 
	--creación de prospectos--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.LegalProspectManagement.CreateLegalProspect', @w_producto, 'R', @w_moneda) 
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect', @w_producto, 'R', @w_moneda)
	--Direcciones-
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', @w_producto, 'R', @w_moneda)
	--localización geográfica--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateGeoreferencing', @w_producto, 'R', @w_moneda)
	----teléfonos--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateTelephone', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateTelephone', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteTelephone', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchTelephone', @w_producto, 'R', @w_moneda)
	
	
	
	---------------- 

  delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --creación de prospectos--
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,73936, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,73935, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1288, @w_producto, 'R', @w_moneda)
	 --Direcciones-
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,109, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,110, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1226, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1227, @w_producto, 'R', @w_moneda)
	 --localización geográfica--
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1608, @w_producto, 'R', @w_moneda)--crear Referencia
	--teléfonos
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,111, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,112, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,148, @w_producto, 'R', @w_moneda)
	insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,147, @w_producto, 'R', @w_moneda)

end 
---MENU  BUSQUEDA DE PROSPECTOS --
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_CSTMR_SEACHCUSTOMER'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	 
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.Queries.ReadMinimumAgeParameter', @w_producto, 'R', @w_moneda)--1579
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.Queries.ReadIdExpirationParameter', @w_producto, 'R', @w_moneda)--1579
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.ReadDataCustomer', @w_producto, 'R', @w_moneda)--no existe servicio
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.ReadCustomerInfo', @w_producto, 'R', @w_moneda)--132
	 -------
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateCustomer', @w_producto, 'R', @w_moneda)--104
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CountryManagement.ReadCountry', @w_producto, 'R', @w_moneda)--1553
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.Queries.SearchDocumentTypes', @w_producto, 'R', @w_moneda)--1445
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.OfficialManagement.SearchOfficials', @w_producto, 'R', @w_moneda)--15153
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.Queries.ReadSpouse', @w_producto, 'R', @w_moneda)--1304
	 --actividad economica--
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteEconomicActivity', @w_producto, 'R', @w_moneda)--2439
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateEconomicActivity', @w_producto, 'R', @w_moneda)--2437
	 insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateEconomicActivity', @w_producto, 'R', @w_moneda)--2438
	 --Direcciones-
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', @w_producto, 'R', @w_moneda)
	---Bussines
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', @w_producto, 'R', @w_moneda)--1709--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', @w_producto, 'R', @w_moneda)--1710--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', @w_producto, 'R', @w_moneda)--1711--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', @w_producto, 'R', @w_moneda)--1712--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome', @w_producto, 'R', @w_moneda)--1712--
	
	--references--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateCustomerReference', @w_producto, 'R', @w_moneda)--177--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateCustomerReference', @w_producto, 'R', @w_moneda)--178--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteCustomerReference', @w_producto, 'R', @w_moneda)--1130--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference', @w_producto, 'R', @w_moneda)--178--

	
	--relaciones--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect', @w_producto, 'R', @w_moneda)--1367--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelation', @w_producto, 'R', @w_moneda)--1194--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson', @w_producto, 'R', @w_moneda)--139--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteRelation', @w_producto, 'R', @w_moneda)--1368--
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro en la search costomer las transacciones--
	 
	 ---Busqueda de prospectos----
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1579, @w_producto, 'R', @w_moneda)  
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,132, @w_producto, 'R', @w_moneda) 
	 -------
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,104, @w_producto, 'R', @w_moneda)  
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1553, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1445, @w_producto, 'R', @w_moneda)  
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,15153, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1304, @w_producto, 'R', @w_moneda)  
	
	 ---actividad económica------
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,2439, @w_producto, 'R', @w_moneda)  
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,2437, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,2438, @w_producto, 'R', @w_moneda)
	 -------
	 -----Direcciones----
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,109, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,110, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1226, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1227, @w_producto, 'R', @w_moneda)
	 --------
	---Bussines
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1709, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1710, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1711, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1712, @w_producto, 'R', @w_moneda)
	--references--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,177, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,178, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1130, @w_producto, 'R', @w_moneda) 
	--relaciones--
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1367, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1194, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,139, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1368, @w_producto, 'R', @w_moneda)
	 ---------
end

---menu relaciones entre clientes --
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_RLATION_CUSTOMER'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--relaciones--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect', @w_producto, 'R', @w_moneda)--1367--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelation', @w_producto, 'R', @w_moneda)--1194--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson', @w_producto, 'R', @w_moneda)--139--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteRelation', @w_producto, 'R', @w_moneda)--1368--
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las relaciones de clientes en las transacciones--
	--relaciones--
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1367, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1194, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,139, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1368, @w_producto, 'R', @w_moneda)
	 ---------
end
-------------


---menu bussines entre clientes --

------------
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_BUSINESS'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--bussines--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', @w_producto, 'R', @w_moneda)--1709--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', @w_producto, 'R', @w_moneda)--1710--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', @w_producto, 'R', @w_moneda)--1711--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', @w_producto, 'R', @w_moneda)--1712--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome', @w_producto, 'R', @w_moneda)--1712--
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las bussines de clientes en las transacciones--
	--bussines--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1709, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1710, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1711, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1712, @w_producto, 'R', @w_moneda)
	 ---------
end


---Direcciones---
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_ADDRESS'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--Direcciones--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteAddressSan', @w_producto, 'R', @w_moneda)
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', @w_producto, 'R', @w_moneda)
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las Direcciones de clientes en las transacciones--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,109, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,110, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1226, @w_producto, 'R', @w_moneda) 
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1227, @w_producto, 'R', @w_moneda)
	 ---------
end


--Referencias entre clientes--
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_REFERENCES'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--referencias--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.CreateCustomerReference', @w_producto, 'R', @w_moneda)--177--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.UpdateCustomerReference', @w_producto, 'R', @w_moneda)--178--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteCustomerReference', @w_producto, 'R', @w_moneda)--1130--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchCustomerReference', @w_producto, 'R', @w_moneda)--178--
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las referencias de clientes en las transacciones--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,177, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,178, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1130, @w_producto, 'R', @w_moneda)
	 ---------
end
------Creación de Grupos------------


select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_LOANGROUP'

if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--Busqueda de grupos--
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.CreateGroup', @w_producto, 'R', @w_moneda)--800--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.UpdateGroup', @w_producto, 'R', @w_moneda)--800--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.SearchGroup', @w_producto, 'R', @w_moneda)--800--
	
    --Member Group--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.DeleteMember', @w_producto, 'R', @w_moneda)--810--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.CreateMember', @w_producto, 'R', @w_moneda)--810--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.UpdateMember', @w_producto, 'R', @w_moneda)--810--
	---Relaciones--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect', @w_producto, 'R', @w_moneda)--1367--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelation', @w_producto, 'R', @w_moneda)--1194--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson', @w_producto, 'R', @w_moneda)--139--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteRelation', @w_producto, 'R', @w_moneda)--1368--
	
	--
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las referencias de clientes en las transacciones--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,800, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,810, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1367, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1194, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,139, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1368, @w_producto, 'R', @w_moneda)
	 ---------
end
------Busqueda de Grupos------------
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_LOANGROUPUP'
if @w_me_id is not null
begin
    delete cew_menu_service 
    where ms_id_menu = @w_me_id
     and ms_producto = @w_producto
     and ms_moneda = @w_moneda
	  
	--busqueda de grupos--
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.CreateGroup', @w_producto, 'R', @w_moneda)--800--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.UpdateGroup', @w_producto, 'R', @w_moneda)--800--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.GroupMaintenance.SearchGroup', @w_producto, 'R', @w_moneda)--800--
	
    --Member Group--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.DeleteMember', @w_producto, 'R', @w_moneda)--810--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.CreateMember', @w_producto, 'R', @w_moneda)--810--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'LoanGroup.MemberMaintenance.UpdateMember', @w_producto, 'R', @w_moneda)--810--
	---relaciones--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect', @w_producto, 'R', @w_moneda)--1367--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelation', @w_producto, 'R', @w_moneda)--1194--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.SearchRelationPerson', @w_producto, 'R', @w_moneda)--139--
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) values (@w_me_id, 'CustomerDataManagementService.CustomerManagement.DeleteRelation', @w_producto, 'R', @w_moneda)--1368--
	
	--
	
	 delete cew_menu_transaccion
    where mt_id_menu 	= @w_me_id
     and mt_producto 	= @w_producto
     and mt_moneda 	= @w_moneda
	 --- registro de las referencias de clientes en las transacciones--
     insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,800, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,810, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1367, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1194, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,139, @w_producto, 'R', @w_moneda)
	 insert into cew_menu_transaccion (mt_id_menu, mt_transaccion, mt_producto, mt_tipo, mt_moneda) values (@w_me_id,1368, @w_producto, 'R', @w_moneda)
	 ---------
end

