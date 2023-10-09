use cobis
go

delete 1 from cts_serv_catalog where csc_service_id = 'LoanGroup.ScannedDocuments.ValidateUploadedFI'

delete 1 from ad_servicio_autorizado where ts_servicio = 'LoanGroup.ScannedDocuments.ValidateUploadedFI'