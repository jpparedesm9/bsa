
use cob_bvirtual
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'go_estado'
              and  c1.table_name = 'bv_geolocaliza_operacion')
begin 
 ALTER TABLE bv_geolocaliza_operacion ADD go_estado varchar(20) NULL;

end 
go
