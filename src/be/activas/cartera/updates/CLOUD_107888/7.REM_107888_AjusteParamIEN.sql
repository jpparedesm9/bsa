use cob_ien
go

declare @w_agent int

select  @w_agent= ftd_id FROM ree_ien_file_transfer_def
    WHERE ftd_description = 'CONCILIACION AUTOMATICA SANTANDER'

update ree_ien_column_file_def
set cftd_property_name = '[ns1:cobiscorp.ecobis.integrationengine.conciliation.service.dto][TransactionDetail%ns1.TransactionDetailDTO%trnCorrespondent]'
where cftd_name = 'FOLIO BANCO' and ftd_id= @w_agent

update ree_ien_column_file_def
set cftd_property_name = NULL
where cftd_name = 'REFERENCIA INTERBANCARIA' and ftd_id= @w_agent

update ree_ien_agent_file_def
set afd_name_expression = 'H2H_43009668_\d{8}_\d{6}_\.edocta.copy'
where afd_transaction_type = 'APCDT' and afd_app = 'CDT'

go
