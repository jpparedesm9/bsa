--------------------------------------------------------------------------------------------
-- ELIMINAR ERRORES
--------------------------------------------------------------------------------------------
delete cobis..cl_errores where numero in (103176, 103177, 103196, 103198, 103160)

--------------------------------------------------------------------------------------------
-- QUITAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------
use cobis
go

delete cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
delete cts_serv_catalog where csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'

delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual'
delete cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual'
