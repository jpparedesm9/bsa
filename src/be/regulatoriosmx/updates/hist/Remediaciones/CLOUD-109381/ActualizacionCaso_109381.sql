
select *
from cob_conta..cb_corte
where co_fecha_ini = '11/08/2018'

update cob_conta..cb_corte
set co_estado = 'V' 
where co_fecha_ini = '11/08/2018'

select *
from cob_conta..cb_corte
where co_fecha_ini = '11/08/2018'

select *
from cob_cartera..ca_desembolso
where dm_operacion in (123216, 123219, 123222, 123225,
                       123228, 123231, 123234, 123237)      
                       
update cob_cartera..ca_desembolso
set dm_oficina_chg = 3345,
    dm_oficina     = 3345
where dm_operacion in (123216, 123219, 123222, 123225,
                       123228, 123231, 123234, 123237)      


select *
from cob_cartera..ca_desembolso
where dm_operacion in (123216, 123219, 123222, 123225,
                       123228, 123231, 123234, 123237)      