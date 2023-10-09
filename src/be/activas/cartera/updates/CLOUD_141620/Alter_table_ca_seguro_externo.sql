/*
*    Se arega campo para controlar el valor basico del seguro REQ#141620
*/
use cob_cartera
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ca_seguro_externo' and COLUMN_NAME = 'se_monto_basico')
begin 
	select 'Columna se_monto_basico ya existe'
end
else
begin 
	alter table ca_seguro_externo 
	add se_monto_basico money
end

go
