use cob_cartera
go

select * from ca_param_seguro_externo

delete from ca_param_seguro_externo where se_paquete in ('EXTENDIDO', 'NINGUNO')

select * from ca_param_seguro_externo

go

