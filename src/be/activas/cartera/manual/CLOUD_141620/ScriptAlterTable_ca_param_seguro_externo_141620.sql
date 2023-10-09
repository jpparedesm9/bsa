use cob_cartera
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ca_param_seguro_externo' and COLUMN_NAME = 'se_asistencia_funeraria')
begin 
	select 'Columna se_asistencia_funeraria ya existe'
end
else
begin 
	alter table ca_param_seguro_externo 
	add se_asistencia_funeraria money null
end

go