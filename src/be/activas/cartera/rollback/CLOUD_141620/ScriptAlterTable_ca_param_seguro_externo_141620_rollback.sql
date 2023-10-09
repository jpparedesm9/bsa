use cob_cartera
go

if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'ca_param_seguro_externo' and COLUMN_NAME = 'se_asistencia_funeraria')
begin 
	alter table ca_param_seguro_externo 
	drop column se_asistencia_funeraria
end

select *
from cob_cartera..ca_param_seguro_externo

delete cob_cartera..ca_param_seguro_externo

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado)
values (1, 'BASICO', 'Seguro de vida', 'Seguro de vida', 0, 80, 'V')

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado)
values (2, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 180, 80, 'V')

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado)
values (3, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V')

select *
from cob_cartera..ca_param_seguro_externo


go
