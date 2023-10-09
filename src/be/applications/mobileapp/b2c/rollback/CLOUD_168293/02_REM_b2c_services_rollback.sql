-- \bsa\src\be\applications\mobileapp\b2c\installer\sql\b2c_services.sql

use cobis
go

delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.QueryOCRInfor')

-- -----
delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.QuerySCORESInfor')

-- -----
delete ad_servicio_autorizado where ts_servicio in ('BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse')
delete cts_serv_catalog where csc_service_id in ('BusinessToConsumer.BioOnboardManagement.InsertFingerIDResponse')

go

