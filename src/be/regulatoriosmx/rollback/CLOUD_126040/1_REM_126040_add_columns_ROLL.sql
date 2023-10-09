/*
AUTOR: RMAESTRE
FECHA: 2019 09 11
CASO:  Mejora 126040
*/

use cob_conta_super
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ec_estado_op'
              and  c1.table_name = 'sb_estcta_cab_tmp_lcr')
begin 
    alter table sb_estcta_cab_tmp_lcr
    drop column ec_estado_op 
end


if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ec_estado_op'
              and  c1.table_name = 'sb_estcta_cab_tmp')
begin 
    alter table sb_estcta_cab_tmp
    drop column ec_estado_op 
end