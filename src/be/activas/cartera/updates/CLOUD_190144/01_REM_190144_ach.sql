
----------->>>>>>>>>>>PARAMETRIZACION SEGURO
use cob_cartera
go

declare @w_id int, @w_producto varchar(256)
select @w_producto = 'INDIVIDUAL'
---
select 'ini', * from ca_param_seguro_externo where se_paquete = 'EXTENDIDO' order by se_id
---
update ca_param_seguro_externo set se_valor = 210 where se_producto = @w_producto and se_paquete = 'EXTENDIDO'
---
go
----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
----------->>>>>>>>>>>PARAMETRIZACION SEGURO
use cob_cartera
go

declare @w_id int, @w_producto varchar(256)
select @w_producto = 'GRUPAL'
---
update ca_param_seguro_externo set se_valor = 210 where se_producto = @w_producto and se_paquete = 'EXTENDIDO'
---
select 'fin', * from ca_param_seguro_externo where se_paquete = 'EXTENDIDO' order by se_id
go
--4 basicos por los valores de la tabla y un extendido para el valor más el seguro medico
