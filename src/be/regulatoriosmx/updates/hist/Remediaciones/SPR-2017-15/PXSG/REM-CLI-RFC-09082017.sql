/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : Creación Sp y Servicio para obtener la el RFC del cliente  
--Descripción del Problema   : Cambios a la pantalla de ingreso de datos
--Responsable                : Patricio Samueza
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 7067120
select @w_producto = 2
-- reprocesable
SELECT * FROM cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
SELECT * FROM cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
SELECT * FROM cobis..cl_ttransaccion where tn_trn_code = @w_numero
SELECT * FROM cobis..ad_procedure where pd_procedure = @w_numero

delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_relacion_cliente_cons','cobis','V',getdate(),'sp_re_clien.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga)
values (@w_numero, 'OBTIENE RFC', 'ORFCRL', 'OBTIENE RFC')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())

GO



/**********************************************************************************************************************/
--Incidencia                 : SI
--Fecha                      : 09/08/2017
--Descripción del Problema   : Buscar la calificacion del cliente de la cl_ente
--Descripción de la Solución : Creación de Servicio para encontrar la calificacion del cliente de la cl_ente
--Autor                      : Patricio Samueza
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_services_authorization.sql
/**********************************************************************************************************************/
USE cobis 
GO

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

delete cts_serv_catalog
where csc_service_id in ('CustomerDataManagementService.CustomerManagement.SearchRelationClient')
delete ad_servicio_autorizado
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.SearchRelationClient')

----------------------------------------------------
--Servicio que  Busca RFC de la relacion de un cliente
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchRelationClient', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRelationClient', 'Obtiene el RFC de la relacion de un cliente', 7067120, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchRelationClient', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
go
