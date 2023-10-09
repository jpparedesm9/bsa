use cob_conta_super
go


alter table sb_rpt_buro_frmt_act_parc
alter column rf_limit_cred varchar(20) null
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion_tmp')
begin 
    alter table sb_dato_operacion_tmp
    add  do_monto_aprobado money null
end
go


if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'sb_dato_operacion')
begin
    alter table sb_dato_operacion
    add  do_monto_aprobado money null
end
go

update sb_dato_operacion
set do_monto_aprobado = op_monto_aprobado
from cob_cartera..ca_operacion
where do_fecha >= '03/01/2019'
and   op_banco = do_banco
go

alter table sb_reporte_buro_cuentas
alter column [23] varchar(20) null
go

use cob_externos
go


if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'do_monto_aprobado'
              and  c1.table_name = 'ex_dato_operacion')
begin
    alter table ex_dato_operacion
    add  do_monto_aprobado money null
end
go
