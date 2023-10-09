/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : 93534
--Fecha                      : 24/01/2018
--Descripción del Problema   : Cambio de parametros
--Descripción de la Solución : Actualizar los parametros solicitados
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ROLBACK de men� y permisos
--------------------------------------------------------------------------------------------

use cobis
go

DECLARE @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int 

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'


SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_ASSETS'
SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

if @w_menu_parent_id is not null
begin
    
    --MENU ADMINISTRACION DE DISPOSITIVOS M�VILES
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
	begin 
		select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ACCOUNT_STATUS'    
		if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
		begin
		    delete cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol
		end
		if exists (select 1 from cew_menu where me_name = 'MNU_ACCOUNT_STATUS')
		begin
			delete cew_menu where me_name = 'MNU_ACCOUNT_STATUS'
		end    
	end
	else
	begin
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		select @w_menu_id = me_id from cew_menu where me_name = 'MNU_ACCOUNT_STATUS'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        delete cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol
	    end
	    if exists (select 1 from cew_menu where me_name = 'MNU_ACCOUNT_STATUS')
	    begin
			delete cew_menu where me_name = 'MNU_ACCOUNT_STATUS'
	    end    
	end
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go



--------------------------------------------------------------------------------------------
-- ROLLBACK DE SERVICIOS
--------------------------------------------------------------------------------------------

use cobis
go

if exists (select * from cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.SearchAccountStatus')
begin
	delete cts_serv_catalog where csc_service_id = 'Loan.LoanMaintenance.SearchAccountStatus'
end

if exists (select * from cobis..ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus')
begin
	delete cobis..ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus'
end

---------------------------------------------------------------------------------------
-------------------------ROLBACK de tabla de estado de cuenta--------------------------
---------------------------------------------------------------------------------------

use cob_conta_super
go


IF OBJECT_ID ('dbo.sb_ns_estado_cuenta') IS NOT NULL
	DROP TABLE dbo.sb_ns_estado_cuenta
go


--------------------------------------------------------------------------------------------
-- ROLBACK de Insertar en tabla de secuenciales
--------------------------------------------------------------------------------------------

use cobis
go

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_ns_estado_cuenta'

--------------------------------------------------------------------------------------------
-- ROLBACK  -REGISTRO SP - SEGURIDADES -- activa/credito   --sp_estado_cuenta 
--------------------------------------------------------------------------------------------

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36006
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero AND tn_trn_code = @w_numero+1
delete cobis..ad_procedure where pd_procedure = @w_numero



--------------------------------------------------------------------------------------------
-- ROLBACK  del SP sp_estado_cuenta 
--------------------------------------------------------------------------------------------
use cob_conta_super
go

if exists(select 1 from sysobjects where name ='sp_estado_cuenta')
	drop proc sp_estado_cuenta
go