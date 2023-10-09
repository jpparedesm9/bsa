PRINT 'ca_santander_resultado_desembolso'
GO
use cob_cartera
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'rd_banco' and TABLE_NAME = 'ca_santander_resultado_desembolso')
begin
    alter table ca_santander_resultado_desembolso drop column  rd_banco    
end

go


