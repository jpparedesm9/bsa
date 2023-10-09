
use cob_conta
go

select cu_cuenta 
into #tmp_cuentas
from cb_cuenta 

select cu_cuenta_padre
into #tmp_cuentas_padres
from cb_cuenta
where isnull(cu_cuenta_padre, '') != ''

delete #tmp_cuentas
from #tmp_cuentas_padres
where #tmp_cuentas.cu_cuenta = #tmp_cuentas_padres.cu_cuenta_padre

update cb_cuenta
set cu_movimiento = 'N'

update cb_cuenta
set cu_movimiento = 'S'
from cb_cuenta, #tmp_cuentas
where cb_cuenta.cu_cuenta = #tmp_cuentas.cu_cuenta

go

