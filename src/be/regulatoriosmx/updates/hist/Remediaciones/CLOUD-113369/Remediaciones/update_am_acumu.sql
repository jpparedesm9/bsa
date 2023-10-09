
use cob_cartera 
go 


select distinct 
di_operacion,
di_dividendo 
into #cuotas_canceladas
from ca_dividendo, ca_operacion  
where di_operacion = op_operacion 
and  op_toperacion = 'REVOLVENTE'
and  di_estado    = 3    


select 'antes', am_operacion, am_dividendo, am_concepto , am_cuota, am_acumulado, am_pagado, am_estado from ca_amortizacion , #cuotas_canceladas
where am_operacion  = di_operacion 
and   am_dividendo  = di_dividendo
and   am_concepto not in ( 'CAP')
and   am_cuota <> am_pagado  



update ca_amortizacion set 
am_cuota      = am_pagado,
am_acumulado  = am_pagado
from #cuotas_canceladas
where am_operacion  = di_operacion 
and   am_dividendo  = di_dividendo
and   am_concepto not in ( 'CAP')
and   am_cuota <> am_pagado 

select 'despues', am_operacion, am_dividendo, am_concepto , am_cuota, am_acumulado, am_pagado, am_estado from ca_amortizacion , #cuotas_canceladas
where am_operacion  = di_operacion 
and   am_dividendo  = di_dividendo
and   am_concepto not in ( 'CAP')


drop table #cuotas_canceladas 
go 
