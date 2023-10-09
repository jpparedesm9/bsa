
/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : Creación Sp y Servicio para obtener la el RFC del cliente  
--Descripción del Problema   : Cambios a la pantalla de ingreso de datos
--Responsable                : Patricio Samueza
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_transac.sql
--Nombre Archivo             : cr_transac.sql
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 21318
select @w_producto = 21

-- reprocesable
delete cobis..ad_procedure where pd_procedure = @w_numero
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto



---- 
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_valida_pep','cob_credito','V',getdate(),'sp_valida.sp')

SELECT * From cobis..ad_procedure WHERE pd_stored_procedure='sp_valida_pep'

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga)
values (@w_numero, 'busca si el cliente es PEP', 'OPEPCL', 'OBTIENE PEP CLIENTE')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

--------
declare @w_rol     smallint,
        @w_moneda  tinyint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1
   
delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (21318)   

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol,  21318,           @w_moneda, getdate(),  1, 'V', getdate())
SELECT * FROM cobis..ad_procedure where pd_procedure = @w_numero
SELECT * FROM cobis..cl_ttransaccion where tn_trn_code = @w_numero
SELECT * FROM cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
SELECT * FROM cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = 1





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
where csc_service_id in ('CustomerDataManagementService.CustomerManagement.SearchPepPerson')
delete ad_servicio_autorizado
where ts_servicio in ('CustomerDataManagementService.CustomerManagement.SearchPepPerson')

----------------------------------------------------
--Servicio que  Busca RFC de la relacion de un cliente
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchPepPerson', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchPepPerson', 'busca si el cliente es una persona PEP',21318, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchPepPerson', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
go
/**********************************************************************************************************************/
--Incidencia                 : SI
--Fecha                      : 09/08/2017
--Descripción del Problema   : actualizar campo en  de la cl_ente
--Descripción de la Solución : aumentar tamano a campo p_carg_pub varchar(200)
--Autor                      : Patricio Samueza
--Instalador                 : 
--Ruta Instalador            : 
/**********************************************************************************************************************/
USE cobis 
GO
ALTER TABLE cobis..cl_ente

ALTER COLUMN p_carg_pub varchar(200)
go


