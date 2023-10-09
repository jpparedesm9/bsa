
use cob_conta
go


select *
from cob_conta..cb_corte
where co_fecha_ini >= '08/28/2018'       
and co_fecha_fin<= '08/31/2018'


update  cob_conta..cb_corte
set co_estado = 'V'
where co_fecha_ini >= '08/28/2018'       
and co_fecha_fin<= '08/31/2018'

select *
from cob_conta..cb_corte
where co_fecha_ini >= '08/28/2018'       
and co_fecha_fin<= '08/31/2018'