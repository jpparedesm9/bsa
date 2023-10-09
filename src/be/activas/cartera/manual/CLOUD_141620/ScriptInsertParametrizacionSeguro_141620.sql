use cob_cartera
go

select *
from cob_cartera..ca_param_seguro_externo

delete cob_cartera..ca_param_seguro_externo

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria)
values (1, 'BASICO', 'Seguro de vida', 'Seguro de vida', 0, 80, 'V', 0)
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria)
values (2, 'EXTENDIDO', 'Seguro de Vida y Complementario', 'Seguro Complementario', 180, 80, 'V', 0)
go

insert into dbo.ca_param_seguro_externo (se_id, se_paquete, se_descripcion, se_formato_consen, se_valor, se_edad_max, se_estado, se_asistencia_funeraria)
values (3, 'NINGUNO', 'Sin Seguro', 'Ninguno', 0, 99, 'V', 0)
go



select *
from cob_cartera..ca_param_seguro_externo