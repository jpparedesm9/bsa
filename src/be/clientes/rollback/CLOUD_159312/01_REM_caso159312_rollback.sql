use cob_credito
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ib_usuario'
              and  c1.table_name = 'cr_interface_buro')
begin 
    print 'procede a quitar la columna cr_interface_buro'
    alter table cr_interface_buro
    drop column ib_usuario
end 
else
begin
    print 'ya no existe la columna cr_interface_buro'
end
go
--

use cob_credito_his
go

if exists(select 1
              FROM INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'ibh_usuario'
              and  c1.table_name = 'cr_interface_buro_his')
begin 
    print 'procede a eliminar la columna cr_interface_buro_his'
    alter table cr_interface_buro_his
    drop column ibh_usuario
end 
else
begin
    print 'ya no existe la columna cr_interface_buro_his'
end
go
-- 1 minuto