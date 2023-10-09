--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Respaldo ca_lcr_candidatos
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

if object_id ('ca_lcr_candidatos_tmp_cs161681') is not null
	drop table ca_lcr_candidatos_tmp_cs161681
go

select * 
into ca_lcr_candidatos_tmp_cs161681
from ca_lcr_candidatos
go

--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Se agrega la columna
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'cc_fecha_descrip'
              and  c1.table_name = 'ca_lcr_candidatos')
begin 
    alter table ca_lcr_candidatos add cc_fecha_descrip datetime null
end
else
    print 'Ya existe cc_fecha_descrip'
go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Se agrega parametro
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
select * from cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'
delete cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('DIAS DESCARTAR CANDIDATO', 'DDC', 'S', NULL, NULL, 30, NULL, NULL, NULL, NULL, 'CCA')
go
