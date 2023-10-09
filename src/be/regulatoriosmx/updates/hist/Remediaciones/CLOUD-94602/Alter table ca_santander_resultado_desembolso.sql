
PRINT 'ca_santander_resultado_desembolso'
GO
use cob_cartera
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'rd_banco' and TABLE_NAME = 'ca_santander_resultado_desembolso')
begin
    alter table cob_cartera..ca_santander_resultado_desembolso add rd_banco cuenta null 
end
else
begin
	alter table cob_cartera..ca_santander_resultado_desembolso alter column rd_banco cuenta null 
end
go
