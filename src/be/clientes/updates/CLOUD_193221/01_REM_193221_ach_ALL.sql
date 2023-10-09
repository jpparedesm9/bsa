------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
use cob_cartera 
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ca_datos_simulacion' and COLUMN_NAME = 'ds_subtipo')
begin
    alter table cob_cartera..ca_datos_simulacion
    add ds_subtipo varchar(50)
end

go
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>

