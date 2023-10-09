use cob_cartera
go

--Instalador en  \bsa\src\be\activas\cartera\installer\sql\ca_table.sql
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_seguro_externo' and column_name = 'se_tramite'   ) 
begin  
	alter table ca_seguro_externo add se_tramite int
end
 
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_seguro_externo' and column_name = 'se_grupo'   ) 
begin  
	alter table ca_seguro_externo add se_grupo int
end

if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_seguro_externo' and column_name = 'se_monto_pagado'   ) 
begin	
	alter table ca_seguro_externo add se_monto_pagado money
end

if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_seguro_externo' and column_name = 'se_monto_devuelto'   ) 
begin
	alter table ca_seguro_externo add se_monto_devuelto money
end 

if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_seguro_externo' and column_name = 'se_forma_pago'   ) 
begin
	alter table ca_seguro_externo add se_forma_pago varchar(16) null
end 

--Instalador en  \bsa\src\be\activas\cartera\installer\sql\ca_table.sql
if not exists (select 1  from   INFORMATION_SCHEMA.COLUMNS  where  table_name = 'ca_garantia_liquida' and column_name = 'gl_forma_pago'   ) 
begin  
	alter table ca_garantia_liquida add gl_forma_pago varchar(16) null
end
 
go


