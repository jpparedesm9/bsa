
use cob_conta_super
go
declare @w_fecha datetime

-- Enero 2020 - Comportameinto de Clientes
select @w_fecha = convert(datetime,'02-01-2020',110)
exec sp_rpt_comp_clientes_act
@i_fecha = @w_fecha

-- Enero 2020 - Inventario de Clientes
select @w_fecha = convert(datetime,'02-01-2020',110)
exec sp_rpt_inv_clientes_prosp
@i_fecha = @w_fecha


go

