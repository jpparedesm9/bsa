
use cob_bvirtual
go

select * from bv_geolocaliza_operacion
if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'go_estado'
              and  c1.table_name = 'bv_geolocaliza_operacion')
begin 
 ALTER TABLE bv_geolocaliza_operacion drop COLUMN go_estado;
end 

go
