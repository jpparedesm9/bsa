use cob_conta
go

declare @w_minimo int

select 'ANTES',* from cob_conta..cb_seqnos_comprobante 
where sc_empresa = 1
and sc_fecha   = '10/11/2018'
and sc_tabla   = 'cb_scomprobante'
and sc_modulo  = 7

select @w_minimo = min(sc_actual)
from cob_conta..cb_seqnos_comprobante 
where sc_empresa = 1
and sc_fecha   = '10/11/2018'
and sc_tabla   = 'cb_scomprobante'
and sc_modulo  = 7

delete from cob_conta..cb_seqnos_comprobante 
where sc_empresa = 1
and sc_fecha   = '10/11/2018'
and sc_tabla   = 'cb_scomprobante'
and sc_modulo  = 7
and sc_actual = @w_minimo


select 'DESPUÉS',* from cob_conta..cb_seqnos_comprobante 
where sc_empresa = 1
and sc_fecha   = '10/11/2018'
and sc_tabla   = 'cb_scomprobante'
and sc_modulo  = 7

go

--Abrir cortes de Octubre
use cob_conta
go

update cb_corte set
co_estado = 'V'
where co_empresa = 1
and co_fecha_ini between '10/01/2018' and '10/16/2018'

update cb_corte set
co_estado = 'C'
where co_empresa = 1
and co_fecha_ini <= '09/30/2018'
and co_estado = 'V'

go




