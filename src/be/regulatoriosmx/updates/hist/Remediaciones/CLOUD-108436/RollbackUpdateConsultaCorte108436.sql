select *
from cob_conta..cb_corte
where co_periodo = 2018
and   co_corte in (295, 302)


update cob_conta..cb_corte
set   co_estado  = 'C'
where co_periodo = 2018
and   co_corte in (295, 302)


select *
from cob_conta..cb_corte
where co_periodo = 2018
and   co_corte in (295, 302)
