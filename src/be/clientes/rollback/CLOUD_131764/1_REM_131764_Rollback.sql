use cobis
go
--CREACION DE MENU
declare @w_me_id int
select @w_me_id= me_id from cew_menu where me_name = 'MNU_EXCLUSION_LIST'    

DELETE cew_menu_role where mro_id_menu = @w_me_id

DELETE FROM dbo.cew_menu WHERE me_id = @w_me_id
GO

--CREACION DE TABLA
IF OBJECT_ID ('dbo.cl_lista_exclusion') IS NOT NULL
	DROP TABLE dbo.cl_lista_exclusion
GO


--CREACION DE TRANSACCION PARA SP
if exists (select 1 from ad_procedure 
           where pd_procedure = 2173 )
	delete ad_procedure where pd_procedure = 2173
go


--CREACION DE CODIGO DE TRANSACCION PROCEDIMIENTO AUTORIZADO
if exists (select 1 from ad_pro_transaccion where pt_producto = 2 and pt_procedure = 2173 )
	delete ad_pro_transaccion where pt_producto = 2 and pt_procedure = 2173
go

--CREACION DE TRANSACCION
if exists (select 1 from cl_ttransaccion where tn_trn_code in (610,611,612))
	delete cl_ttransaccion where tn_trn_code in (610,611,612)
go

--CREACION DE TRANSACCION AUTORIZADA
declare @codigo int, 
        @w_moneda int
select @codigo = ro_rol from ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

select @w_moneda = pa_tinyint
from cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
if exists (select 1 from ad_tr_autorizada where ta_producto = 2 and ta_rol = @codigo and ta_transaccion in(610,611,612))
	delete ad_tr_autorizada where ta_producto = 2 and ta_rol = @codigo and ta_transaccion in(610,611,612)
GO
	

if exists(select 1 from cl_errores where numero IN (201050, 201051, 201052, 201053, 201054))
   delete cl_errores where numero in(201050, 201051, 201052, 201053, 201054)
 
---------------------------
--REGISTRAR LOS SERVICIOS
---------------------------

IF EXISTS (SELECT 1 FROM cts_serv_catalog WHERE csc_trn IN (610,611,612))
BEGIN
   DELETE cts_serv_catalog WHERE csc_trn IN (610,611,612)
END



IF EXISTS (SELECT 1 FROM cobis..ad_servicio_autorizado WHERE ts_servicio IN (
			'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
			'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
			'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
			'CustomerDataManagementService.CustomerManagement.SearchExclusionList'))
BEGIN
   DELETE cobis..ad_servicio_autorizado WHERE ts_servicio IN (
			'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
			'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
			'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
			'CustomerDataManagementService.CustomerManagement.SearchExclusionList')
end		 