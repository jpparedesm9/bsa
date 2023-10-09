use cobis
go

declare
@w_co_id int

--FGFuncionariosClass
select @w_co_id = co_id from an_component where co_class = 'FGFuncionariosClass' and co_prod_name = 'M-ADM.Seg'

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
	insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiStartEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiApproveMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiDenyMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiFinishEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiGetViews')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiHasMCAuthorization')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ClearMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.getSerializationConfigurations')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)

--FRolesUsuarioClass
select @w_co_id = co_id from an_component where co_class = 'FRolesUsuarioClass' and co_prod_name = 'M-ADM.Seg'

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
	insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiStartEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiApproveMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiDenyMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiFinishEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiGetViews')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiHasMCAuthorization')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ClearMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.getSerializationConfigurations')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)

--FFuncionariosClass
select @w_co_id = co_id from an_component where co_class = 'FFuncionariosClass' and co_prod_name = 'M-ADM.Seg'

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
	insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiStartEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiApproveMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiDenyMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiFinishEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiGetViews')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiHasMCAuthorization')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ClearMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.getSerializationConfigurations')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)
	
--FTran2514Class
select @w_co_id = co_id from an_component where co_class = 'FTran2514Class' and co_prod_name = 'M-ADM.Seg'

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
	insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiStartEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiApproveMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiDenyMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiFinishEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiGetViews')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiHasMCAuthorization')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ClearMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.getSerializationConfigurations')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)
	
--FRolesClass
select @w_co_id = co_id from an_component where co_class = 'FRolesClass' and co_prod_name = 'M-ADM.Seg'

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'HTM.API.HumanTask.CreateProcessInstance')
	insert into an_service_component values (@w_co_id, 'HTM.API.HumanTask.CreateProcessInstance',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiStartEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiStartEnQueue ',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiApproveMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiApproveMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiDenyMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiDenyMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiFinishEnQueue')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiFinishEnQueue',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiGetViews')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiGetViews',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiHasMCAuthorization')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiHasMCAuthorization',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiSaveAuthorizationInfo',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ApiValidateAndPersistMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.ClearMCTransaction')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.ClearMCTransaction',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.DeleteLockedTxByBusinessTransactionId',null)

if not exists (select * from an_service_component where sc_co_id = @w_co_id and sc_csc_service_id = 'COBISCorp.Makerandchecker.getSerializationConfigurations')
	insert into an_service_component values (@w_co_id, 'COBISCorp.Makerandchecker.getSerializationConfigurations',null)
go