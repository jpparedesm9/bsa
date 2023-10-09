use cob_cartera
go

if OBJECT_ID ('dbo.ca_det_ciclo_resp_166473_tmp') is not null
	drop table dbo.ca_det_ciclo_resp_166473_tmp
GO

select *
into ca_det_ciclo_resp_166473_tmp--ca_det_ciclo_resp_166473_tmp_xci
from ca_det_ciclo
go
