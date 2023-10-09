use cobis
go

declare @w_me_id		int,
		@w_moneda 		int,
		@w_producto		int,
		@w_resource		int,
		@w_rol			int


select @w_moneda = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'
   
select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'GARANTIA'
 
 if @w_producto is null
 select @w_producto = 7
 
 
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'

 
 ---Creación Recursos Contenedor 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/collateral/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/collateral/.*')
 end
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views//collateral/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views//collateral/.*')
 end
 
  if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/WRRNT/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/WRRNT/.*')
 end

 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/businessprocess/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/businessprocess/.*')
 end
 
 
 
--Autorización recursos al rol Menú por procesos
if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/collateral/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/collateral/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views//collateral/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views//collateral/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/WRRNT/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/WRRNT/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/businessprocess/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/businessprocess/.*'
end


--Servicios, Transacciones y Recursos Creación Garantías
 
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_WARR_MANT_CREATION'


if @w_me_id is not null
begin
	delete cew_menu_service 
	where ms_id_menu 	= @w_me_id
	and ms_producto 	= @w_producto
	and ms_moneda 	= @w_moneda
	
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	values (@w_me_id,'CEW.Official.GetOfficialInfo', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Menu.getMenuByRole', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Preferences.getUserPreferences', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Favorites.getUserFavorites', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Busin.Service.GetCatalogByStoredProcedure', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.checkColumnExist', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.ReadCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SharedEntities.GetEntities', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchAllPolicy', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Custody.ReadGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetSearchCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Item.InsertNewItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Item.UpdateNewItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.getGroupsByParameters', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.InsertCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.GuaranteeLiberation', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetAllCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Custody.DecodingCodeComposedOfGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.DeleteCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SharedEntities.InsertSharedEntities', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.ChangeValue', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.TypeGuarantee.ReadTypeGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Transactions.ReadTransaction', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.SearchDeposit.SearchAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SearchDeposit.QueryAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.CollateralQuery.SearchCollateralType', @w_producto, 'R', @w_moneda)
	
	delete cew_menu_resource 
	where mr_id_menu 	= @w_me_id
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views//collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/WRRNT/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern ='/cobis/web/views/businessprocess/.*'))
end 

--Servicios, Transacciones y Recursos Modificación Garantías
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_WARR_MANT_MODIFICATION'

if @w_me_id is not null
begin
	delete cew_menu_service 
	where ms_id_menu 	= @w_me_id
	and ms_producto 	= @w_producto
	and ms_moneda 	= @w_moneda
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	values (@w_me_id,'CEW.Official.GetOfficialInfo', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Menu.getMenuByRole', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Preferences.getUserPreferences', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Favorites.getUserFavorites', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Busin.Service.GetCatalogByStoredProcedure', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.checkColumnExist', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.ReadCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SharedEntities.GetEntities', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchAllPolicy', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Custody.ReadGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetSearchCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Item.InsertNewItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Item.UpdateNewItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.UpdateCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.InsertCustomerCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.getGroupsByParameters', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.GuaranteeLiberation', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetAllCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Custody.DecodingCodeComposedOfGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.DeleteCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SharedEntities.InsertSharedEntities', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.ChangeValue', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.TypeGuarantee.ReadTypeGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Transactions.ReadTransaction', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.SearchDeposit.SearchAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SearchDeposit.QueryAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.CollateralQuery.SearchCollateralType', @w_producto, 'R', @w_moneda)
	
	delete cew_menu_resource 
	where mr_id_menu 	= @w_me_id
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views//collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/WRRNT/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern ='/cobis/web/views/businessprocess/.*'))
end

--Servicios, Transacciones y Recursos Consulta Garantías
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_WARRANTIESQUERY_GENERAL'

if @w_me_id is not null
begin
	delete cew_menu_service 
	where ms_id_menu 	= @w_me_id
	and ms_producto 	= @w_producto
	and ms_moneda 	= @w_moneda
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda) 
	values (@w_me_id,'CEW.Official.GetOfficialInfo', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Menu.getMenuByRole', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Preferences.getUserPreferences', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CEW.Favorites.getUserFavorites', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Busin.Service.GetCatalogByStoredProcedure', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.checkColumnExist', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.ReadCollateral', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SharedEntities.GetEntities', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralQuery.SearchAllPolicy', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Custody.ReadGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetSearchCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'CustomerService.getGroupsByParameters', @w_producto, 'R', @w_moneda)
		
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.CollateralMaintenance.GuaranteeLiberation', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Guarantee.Custody.GetAllCustodyItem', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'LoanRequest.Custody.DecodingCodeComposedOfGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.TypeGuarantee.ReadTypeGuarantee', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.Transactions.ReadTransaction', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.SearchDeposit.SearchAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id, 'Collateral.SearchDeposit.QueryAccount', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData', @w_producto, 'R', @w_moneda)
	
	insert into cew_menu_service (ms_id_menu, ms_servicio, ms_producto, ms_tipo, ms_moneda)
	values (@w_me_id,'Collateral.CollateralQuery.SearchCollateralType', @w_producto, 'R', @w_moneda)
	
	delete cew_menu_resource 
	where mr_id_menu 	= @w_me_id
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views//collateral/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern = '/cobis/web/views/WRRNT/.*'))
	
	insert into cew_menu_resource (mr_id_menu, mr_id_resource)
	values(@w_me_id, (select re_id from cew_resource where re_pattern ='/cobis/web/views/businessprocess/.*'))
end
go
