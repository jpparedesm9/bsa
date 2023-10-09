
use cobis
GO
declare @w_rol integer, @w_producto int

SELECT @w_producto = pd_producto FROM cobis..cl_producto WHERE pd_descripcion = 'CARTERA'
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

----servivio¨Pantalla Alta Masiva de Cliente

if @w_rol is null    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'

----servivio Pantalla Alta Masiva de Prospectos
-- Collective.CollectiveEntity.UpdateProspectsFile
delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.UpdateProspectsFile'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('Collective.CollectiveEntity.UpdateProspectsFile', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'updateProspectsFile', 'updateProspectsFile', 0, null)

delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.UpdateProspectsFile'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.UpdateProspectsFile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-- Collective.CollectiveEntity.ValidateProspectsFile
delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ValidateProspectsFile'
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('Collective.CollectiveEntity.ValidateProspectsFile', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'validateProspectsFile', 'validateProspectsFile', 0, null)

delete cobis..ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ValidateProspectsFile'
insert into cobis..ad_servicio_autorizado values('Collective.CollectiveEntity.ValidateProspectsFile', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

go

