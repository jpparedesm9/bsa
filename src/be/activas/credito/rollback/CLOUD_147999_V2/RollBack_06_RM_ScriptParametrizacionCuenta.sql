use cob_conta
go

delete cob_conta..cb_plan_general
where   pg_cuenta =   '140115'      
                  
insert into cob_conta..cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
values (1, '140115', 9002, 1010, '14011590021010')



select *
from cb_relparam
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'

update cb_relparam set
re_substring ='14019004'
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'

select *
from cb_relparam
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'