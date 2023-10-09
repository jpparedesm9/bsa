--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go 

--Antes
select 'antes',* from ca_param_seguro_externo
where se_paquete = 'BASICO'
and se_producto = 'INDIVIDUAL'

update ca_param_seguro_externo
set se_valor = 15
where se_paquete = 'BASICO'
and se_producto = 'INDIVIDUAL'
and se_id in (8, 9)

--Despues
select 'despues',* from ca_param_seguro_externo
where se_paquete = 'BASICO'
and se_producto = 'INDIVIDUAL'

go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
