use cobis
go

-------------------------------------------
--- ROLLBACK SERVICIO OBTENER ESTADOS -----
-------------------------------------------
delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchState'
delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchState'

-----------------------------------------------
--- ROLLBACK SERVICIO ACTUALIZAR ESTADOS  -----
-----------------------------------------------
delete cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateState'
delete ad_servicio_autorizado  where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateState'

go
