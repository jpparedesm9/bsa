/**********************************************************************/
/*   Archivo:         si_services_authorization.sql                   */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*       Autorizacion de los servicios de MOVILEINTEGRATION           */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/**********************************************************************/
use cobis
go

-----------------
--BORRANDO DATA
-----------------

delete cts_serv_catalog
where csc_service_id in (
'MobileManagement.MobileManagement.CreateMobile',
'MobileManagement.MobileManagement.UpdateMobile',
'MobileManagement.MobileManagement.DeleteMobile',
'MobileManagement.MobileManagement.SearchMobile',
'MobileManagement.SyncManagement.GroupSync',
'MobileManagement.SyncManagement.CustomerSync',
'TerminalManagement.TerminalManagement.CreateTerminal',
'TerminalManagement.TerminalManagement.DeleteTerminal',
'TerminalManagement.TerminalManagement.QueryTerminal',
'TerminalManagement.TerminalManagement.UpdateTerminal',
'MobileManagement.SyncManagement.CustomerSyncOfficial',
'MobileManagement.SyncManagement.GroupSyncOfficial',
'MobileManagement.SyncManagement.DeviceSync',
'MobileManagement.SyncManagement.SearchSyncData',
'MobileManagement.SyncManagement.UpdateSyncData',
'MobileManagement.MobileManagement.SearchMobileByFilter',
'PaymentsCollect.PaymentsCollect.QueryListCollect',
)

delete ad_servicio_autorizado
where ts_servicio in (
'MobileManagement.MobileManagement.CreateMobile',
'MobileManagement.MobileManagement.UpdateMobile',
'MobileManagement.MobileManagement.DeleteMobile',
'MobileManagement.MobileManagement.SearchMobile',
'MobileManagement.SyncManagement.GroupSync',
'MobileManagement.SyncManagement.CustomerSync',
'TerminalManagement.TerminalManagement.CreateTerminal',
'TerminalManagement.TerminalManagement.DeleteTerminal',
'TerminalManagement.TerminalManagement.QueryTerminal',
'TerminalManagement.TerminalManagement.UpdateTerminal',
'MobileManagement.SyncManagement.CustomerSyncOfficial',
'MobileManagement.SyncManagement.GroupSyncOfficial',
'MobileManagement.SyncManagement.DeviceSync',
'MobileManagement.SyncManagement.SearchSyncData',
'MobileManagement.SyncManagement.UpdateSyncData',
'MobileManagement.MobileManagement.SearchMobileByFilter',
'PaymentsCollect.PaymentsCollect.QueryListCollect'
)

declare @w_rol int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


-------------------------
--SERVICIO CreateMobile
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.MobileManagement.CreateMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'createMobile', '', 1713)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.MobileManagement.CreateMobile',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


-------------------------
--SERVICIO UpdateMobile
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.MobileManagement.UpdateMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'updateMobile', '', 1714)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.MobileManagement.UpdateMobile',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO DeleteMobile
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.MobileManagement.DeleteMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'deleteMobile', '', 1715)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.MobileManagement.DeleteMobile',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO SearchMobile
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.MobileManagement.SearchMobile', 'cobiscorp.ecobis.mobilemanagement.service.IMobileManagement', 'searchMobile', '', 1716)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.MobileManagement.SearchMobile',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO GroupSync
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.SyncManagement.GroupSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'groupSync', '', 0)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.SyncManagement.GroupSync',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO CustomerSync
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('MobileManagement.SyncManagement.CustomerSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'customerSync', '', 0)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('MobileManagement.SyncManagement.CustomerSync',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO CreateTerminal
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('TerminalManagement.TerminalManagement.CreateTerminal', 'cobiscorp.ecobis.mobilemanagement.service.ITerminalManagement', 'createTerminal', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('TerminalManagement.TerminalManagement.CreateTerminal', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO DeleteTerminal
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('TerminalManagement.TerminalManagement.DeleteTerminal', 'cobiscorp.ecobis.mobilemanagement.service.ITerminalManagement', 'deleteTerminal', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('TerminalManagement.TerminalManagement.DeleteTerminal', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO QueryTerminal
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('TerminalManagement.TerminalManagement.QueryTerminal', 'cobiscorp.ecobis.mobilemanagement.service.ITerminalManagement', 'queryTerminal', '', 0, NULL, NULL, NULL)



INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('TerminalManagement.TerminalManagement.QueryTerminal', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO UpdateTerminal
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('TerminalManagement.TerminalManagement.UpdateTerminal', 'cobiscorp.ecobis.mobilemanagement.service.ITerminalManagement', 'updateTerminal', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('TerminalManagement.TerminalManagement.UpdateTerminal', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO CustomerSyncOfficial
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.CustomerSyncOfficial', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'customerSyncOfficial', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.CustomerSyncOfficial', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO GroupSyncOfficial
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.GroupSyncOfficial', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'groupSyncOfficial', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.GroupSyncOfficial', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-------------------------
--SERVICIO DeviceSync
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.DeviceSync', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'deviceSync', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.DeviceSync', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-------------------------
--SERVICIO SearchSyncData
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.SearchSyncData', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'searchSyncData', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.SearchSyncData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO UpdateSyncData
-------------------------

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('MobileManagement.SyncManagement.UpdateSyncData', 'cobiscorp.ecobis.mobilemanagement.service.ISyncManagement', 'updateSyncData', '', 0, NULL, NULL, NULL)


INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('MobileManagement.SyncManagement.UpdateSyncData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-------------------------
--SERVICIO SearchMobileByFilter
-------------------------

insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('MobileManagement.MobileManagement.SearchMobileByFilter','cobiscorp.ecobis.mobilemanagement.service.IMobileManagement','searchMobileByFilter','Consulta dispositivos móviles por filtro',1717)

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('MobileManagement.MobileManagement.SearchMobileByFilter', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-------------------------
--SERVICIO QueryListCollect
-------------------------
delete from cobis..cts_serv_catalog where csc_service_id='PaymentsCollect.PaymentsCollect.QueryListCollect'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('PaymentsCollect.PaymentsCollect.QueryListCollect','cobiscorp.ecobis.mccollect.service.IPaymentsCollect','queryListCollect','obtiene lista de pagos historicos',0)

delete from ad_servicio_autorizado where ts_servicio = 'PaymentsCollect.PaymentsCollect.QueryListCollect' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('PaymentsCollect.PaymentsCollect.QueryListCollect', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-------------------------
--SERVICIO SearchSyncCatalogData
-------------------------
delete from cobis..cts_serv_catalog where csc_service_id='MobileManagement.SyncManagement.SearchSyncCatalogData'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('MobileManagement.SyncManagement.SearchSyncCatalogData','cobiscorp.ecobis.mobilemanagement.service.ISyncManagement','searchSyncCatalogData','obtiene lista de catalogs con fecha de actualizacion',1716)

delete from ad_servicio_autorizado where ts_servicio = 'MobileManagement.SyncManagement.SearchSyncCatalogData' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('MobileManagement.SyncManagement.SearchSyncCatalogData', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


GO