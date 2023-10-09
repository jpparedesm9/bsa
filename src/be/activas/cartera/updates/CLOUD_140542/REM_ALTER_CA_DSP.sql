use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'de_dividendo_vig'
              and  c1.table_name = 'ca_desplazamiento')
begin 
   alter table ca_desplazamiento
   add de_dividendo_vig int
end 
go


