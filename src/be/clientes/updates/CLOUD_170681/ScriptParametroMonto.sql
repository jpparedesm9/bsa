use cobis
go

delete cl_parametro
where pa_nemonico = 'VAMOBI'

insert into cl_parametro ( 
pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto) 
values('PARAMETRO PARA VALIDAR MONTOS PARA BIOMETRICO ','VAMOBI','M',18000,'CLI')


select *
from cl_parametro
where pa_nemonico = 'VAMOBI'