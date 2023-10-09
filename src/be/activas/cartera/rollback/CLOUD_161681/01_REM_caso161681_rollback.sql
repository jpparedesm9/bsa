--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Quitar la columna
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'cc_fecha_descrip'
              and  c1.table_name = 'ca_lcr_candidatos')
begin 
    alter table ca_lcr_candidatos drop column cc_fecha_descrip
end
else
    print 'Ya no existe cc_fecha_descrip'
go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Regesar la data
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

delete ca_lcr_candidatos
from ca_lcr_candidatos C, ca_lcr_candidatos_tmp_cs161681 CT
where C.cc_grupo = CT.cc_grupo
and C.cc_cliente = CT.cc_cliente
and C.cc_fecha_liq = CT.cc_fecha_liq
and C.cc_fecha_ing = CT.cc_fecha_ing
and C.cc_oficina = CT.cc_oficina

INSERT ca_lcr_candidatos
SELECT *
FROM ca_lcr_candidatos_tmp_cs161681

go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
--------->>>>>>>>>Se elimina parametro
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
select * from cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'
delete cobis..cl_parametro where pa_nemonico = 'DDC' and pa_producto = 'CCA'
go

