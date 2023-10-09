use cob_credito
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ib_usuario'
              and  c1.table_name = 'cr_interface_buro')
begin 
    print 'procede a anadir la columna cr_interface_buro'
    alter table cr_interface_buro
    add ib_usuario varchar(30) null
end 
else
begin
    print 'ya existe la columna cr_interface_buro'
end
go
--

use cob_credito_his
go

if not exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ibh_usuario'
              and  c1.table_name = 'cr_interface_buro_his')
begin 
    print 'procede a anadir la columna cr_interface_buro_his'
    alter table cr_interface_buro_his
    add ibh_usuario varchar(30) null
end 
else
begin
    print 'ya existe la columna cr_interface_buro_his'
end
go
-- 1 minuto