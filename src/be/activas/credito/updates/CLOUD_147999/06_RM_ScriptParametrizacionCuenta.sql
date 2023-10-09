use cob_conta
go
insert into cb_plan_general (pg_empresa, pg_cuenta, pg_oficina, pg_area, pg_clave)
select 
pg_empresa,
'140115'  ,
pg_oficina,
pg_area   ,
pg_clave   = '140115' + convert(varchar,pg_oficina) + convert(varchar,pg_area)
from cob_conta..cb_plan_general a
where pg_cuenta= '14019004'
and   not exists (select 1
                  from cob_conta..cb_plan_general n
                  where pg_cuenta= '140115'
                  and   a.pg_oficina = n.pg_oficina
                  and a.pg_area=n.pg_area) 



select *
from cb_relparam
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'

update cb_relparam set
re_substring ='140115'
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'

select *
from cb_relparam
where re_parametro = 'F_PAGO'
and re_clave = 'RENOVACION'