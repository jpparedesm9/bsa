use cobis
go



declare @w_rol int, @w_producto int, @w_moneda tinyint

select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'GARANTIA'

if @w_producto is null
	select @w_producto = 7
	
--cts_serv_catalog
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralMaintenance.GuaranteeLiberation'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Guarantee.Custody.GetAllCustodyItem'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Guarantee.Custody.GetSearchCustodyItem'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Custody.DecodingCodeComposedOfGuarantee'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Guarantee.Item.InsertNewItem'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Guarantee.Item.UpdateNewItem'
delete from cts_serv_catalog where csc_service_id = 'LoanRequest.Guarantee.Custody.DeleteCustodyItem'
delete from cts_serv_catalog where csc_service_id = 'Collateral.SharedEntities.InsertSharedEntities'
delete from cts_serv_catalog where csc_service_id = 'Collateral.Custody.ReadGuarantee'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralMaintenance.ChangeValue'
delete from cts_serv_catalog where csc_service_id = 'Collateral.TypeGuarantee.ReadTypeGuarantee'
delete from cts_serv_catalog where csc_service_id = 'Collateral.Transactions.ReadTransaction'
delete from cts_serv_catalog where csc_service_id = 'Collateral.SearchDeposit.SearchAccount'
delete from cts_serv_catalog where csc_service_id = 'Collateral.SearchDeposit.QueryAccount'
delete from cts_serv_catalog where csc_service_id = 'Collateral.SharedEntities.GetEntities'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralQuery.SearchCollateral'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralQuery.ReadCollateral'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralQuery.SearchAllPolicy'
delete from cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralMaintenance.UpdateCollateral'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralMaintenance.InsertCustomerCollateral'
delete from cts_serv_catalog where csc_service_id = 'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralQuery.SearchCollateralType'
delete from cts_serv_catalog where csc_service_id = 'Collateral.CollateralMaintenance.InsertCollateral'


insert into cts_serv_catalog values ('Collateral.CollateralMaintenance.GuaranteeLiberation','cobiscorp.ecobis.collateral.service.ICollateralMaintenance','guaranteeLiberation', '', 19624, null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Guarantee.Custody.GetAllCustodyItem','cobiscorp.ecobis.collateral.service.ICustodyItem','getAllCustodyItem', '', 19056, null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Guarantee.Custody.GetSearchCustodyItem','cobiscorp.ecobis.collateral.service.ICustodyItem','getSearchCustodyItem', '', 19054,null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Custody.DecodingCodeComposedOfGuarantee','cobiscorp.ecobis.collateral.service.ICustody','decodingCodeComposedOfGuarantee',  '', 19245,null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Guarantee.Item.InsertNewItem','cobiscorp.ecobis.collateral.service.IItem','insertNewItem',  '',19750,null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Guarantee.Item.UpdateNewItem','cobiscorp.ecobis.collateral.service.IItem','updateNewItem',  '',19751,null, null, null)
insert into cts_serv_catalog values ('LoanRequest.Guarantee.Custody.DeleteCustodyItem','cobiscorp.ecobis.collateral.service.ICustodyItem','deleteCustodyItem', '', 19052,null, null, null)
insert into cts_serv_catalog values ('Collateral.SharedEntities.InsertSharedEntities','cobiscorp.ecobis.collateral.service.ISharedEntities','insertSharedEntities', '', 19874,null, null, null)
insert into cts_serv_catalog values ('Collateral.Custody.ReadGuarantee', 'cobiscorp.ecobis.collateral.service.ICustody', 'readGuarantee', 'Consulta de Garantía', 7052 ,null, null, null)
insert into cts_serv_catalog values ('Collateral.CollateralMaintenance.ChangeValue', 'cobiscorp.ecobis.collateral.service.ICollateralMaintenance', 'changeValue', 'Cambio de valor', 19863,null, null, null)
insert into cts_serv_catalog values ('Collateral.TypeGuarantee.ReadTypeGuarantee', 'cobiscorp.ecobis.collateral.service.ITypeGuarantee', 'readTypeGuarantee', 'Consulta Tipo Garantia', 19125,null, null, null)
insert into cts_serv_catalog values ('Collateral.Transactions.ReadTransaction', 'cobiscorp.ecobis.collateral.service.ITransactions', 'readTransaction', 'Consulta Transaccion', 19125,null, null, null)
insert into cts_serv_catalog values ('Collateral.SearchDeposit.SearchAccount','cobiscorp.ecobis.collateral.service.ISearchDeposit','searchAccount',  '',0,null, null, null)
insert into cts_serv_catalog values ('Collateral.SearchDeposit.QueryAccount','cobiscorp.ecobis.collateral.service.ISearchDeposit','queryAccount', '', 220,null, null, null)
insert into cts_serv_catalog values ('Collateral.CollateralQuery.SearchCollateral', 'cobiscorp.ecobis.collateral.service.ICollateralQuery', 'searchCollateral', 'searchCollateral', 19304,null, null, null)
insert into cts_serv_catalog values ('Collateral.CollateralQuery.ReadCollateral', 'cobiscorp.ecobis.collateral.service.ICollateralQuery', 'readCollateral', '', 19095, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.SharedEntities.GetEntities', 'cobiscorp.ecobis.collateral.service.ISharedEntities', 'getEntities', 'getEntities', 0, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.CollateralQuery.SearchAllPolicy', 'cobiscorp.ecobis.collateral.service.ICollateralQuery', 'searchAllPolicy', '', 19103, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IDebtorsManagment', 'queryDebtor', 'queryDebtor', NULL, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.CollateralMaintenance.InsertCustomerCollateral', 'cobiscorp.ecobis.collateral.service.ICollateralMaintenance', 'insertCustomerCollateral', 'insertCustomerCollateral', 19040, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.CollateralMaintenance.UpdateCollateral', 'cobiscorp.ecobis.collateral.service.ICollateralMaintenance', 'updateCollateral', 'updateCollateral', 19091, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.TypeGuarantee.GetQueryTypeGuaranteeData', 'cobiscorp.ecobis.collateral.service.ITypeGuarantee', 'getQueryTypeGuaranteeData', 'getQueryTypeGuaranteeData', 19125, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.CollateralQuery.SearchCollateralType', 'cobiscorp.ecobis.collateral.service.ICollateralQuery', 'searchCollateralType', 'searchCollateralType', 19127, NULL, NULL, NULL)
insert into cts_serv_catalog values ('Collateral.CollateralMaintenance.InsertCollateral', 'cobiscorp.ecobis.collateral.service.ICollateralMaintenance', 'insertCollateral', 'insertCollateral', 19090, NULL, NULL, NULL)
--ad_servicio_autorizado
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralMaintenance.GuaranteeLiberation' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Guarantee.Custody.GetAllCustodyItem' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Guarantee.Custody.GetSearchCustodyItem' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Custody.DecodingCodeComposedOfGuarantee' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Guarantee.Item.InsertNewItem' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Guarantee.Item.UpdateNewItem' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'LoanRequest.Guarantee.Custody.DeleteCustodyItem' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.SharedEntities.InsertSharedEntities' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.Custody.ReadGuarantee' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralMaintenance.ChangeValue' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.TypeGuarantee.ReadTypeGuarantee' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.Transactions.ReadTransaction' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.SearchDeposit.SearchAccount' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.SearchDeposit.QueryAccount' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.SharedEntities.GetEntities' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralQuery.SearchCollateral' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralQuery.ReadCollateral' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralQuery.SearchAllPolicy' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralMaintenance.UpdateCollateral' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralMaintenance.InsertCustomerCollateral' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralQuery.SearchCollateralType' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.TypeGuarantee.GetQueryTypeGuaranteeData' and ts_rol = @w_rol  and ts_moneda = @w_moneda
delete from ad_servicio_autorizado where ts_servicio = 'Collateral.CollateralMaintenance.InsertCollateral' and ts_rol = @w_rol  and ts_moneda = @w_moneda

insert into ad_servicio_autorizado values ('Collateral.CollateralMaintenance.GuaranteeLiberation', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Guarantee.Custody.GetAllCustodyItem', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Guarantee.Custody.GetSearchCustodyItem', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Custody.DecodingCodeComposedOfGuarantee', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Guarantee.Item.InsertNewItem', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Guarantee.Item.UpdateNewItem', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('LoanRequest.Guarantee.Custody.DeleteCustodyItem', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.SharedEntities.InsertSharedEntities', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.Custody.ReadGuarantee', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())	
insert into ad_servicio_autorizado values ('Collateral.CollateralMaintenance.ChangeValue', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())	
insert into ad_servicio_autorizado values ('Collateral.TypeGuarantee.ReadTypeGuarantee', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())	
insert into ad_servicio_autorizado values ('Collateral.Transactions.ReadTransaction', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate())	
insert into ad_servicio_autorizado values ('Collateral.SearchDeposit.SearchAccount', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.SearchDeposit.QueryAccount', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.SharedEntities.GetEntities',  @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralQuery.SearchCollateral', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralQuery.ReadCollateral', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralQuery.SearchAllPolicy', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralMaintenance.UpdateCollateral', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralMaintenance.InsertCustomerCollateral', @w_rol, @w_producto, 'R', @w_moneda, getdate(), 'V', getdate() )
insert into ad_servicio_autorizado values ('Collateral.CollateralQuery.SearchCollateralType', 3, 7, 'R', 0, getdate(), 'V', getdate())
insert into ad_servicio_autorizado values ('Collateral.TypeGuarantee.GetQueryTypeGuaranteeData', 3, 7, 'R', 0, getdate(), 'V', getdate())
insert into ad_servicio_autorizado values ('Collateral.CollateralMaintenance.InsertCollateral', 3, 7, 'R', 0, getdate(), 'V', getdate())
go
