use cobis
go

update cobis..cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.ILoanTransaction' 
WHERE csc_class_name = 'cobiscorp.ecobis.loan.service.ILoanTransaction'

go


