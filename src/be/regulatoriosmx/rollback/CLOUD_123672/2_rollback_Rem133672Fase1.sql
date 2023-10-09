use cob_conta_super
go

IF OBJECT_ID ('dbo.sb_est_complemento_xml') IS NOT NULL
	DROP table dbo.sb_est_complemento_xml
go
go

use cob_credito
go

IF OBJECT_ID ('dbo.cr_complemento_pago_xml') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml
go

use cob_credito_his
go


IF OBJECT_ID ('dbo.cr_complemento_pago_xml_his') IS NOT NULL
	DROP table dbo.cr_complemento_pago_xml_his
go

go

------------------
use cobis
go

if exists(select 1 from cobis..ba_batch where ba_batch = 360081)
begin
   delete cobis..ba_batch where ba_batch = 360081
end
go




