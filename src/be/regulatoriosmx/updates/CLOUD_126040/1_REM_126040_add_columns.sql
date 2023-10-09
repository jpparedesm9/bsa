/*
AUTOR: RMAESTRE
FECHA: 2019 09 11
CASO:  Mejora 126040
*/
use cob_conta_super
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS 
                where COLUMN_NAME = 'ec_estado_op' 
                  and TABLE_NAME  = 'sb_estcta_cab_tmp_lcr')
begin
    alter table cob_conta_super..sb_estcta_cab_tmp_lcr add ec_estado_op varchar (20) null
end

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS 
                where COLUMN_NAME = 'ec_estado_op' 
                  and TABLE_NAME  = 'sb_estcta_cab_tmp')
begin
    alter table cob_conta_super..sb_estcta_cab_tmp add ec_estado_op varchar (20) null
end
    