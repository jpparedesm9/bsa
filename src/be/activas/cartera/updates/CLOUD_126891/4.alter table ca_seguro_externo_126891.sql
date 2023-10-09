
use cob_cartera
go


if not exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'se_tipo_seguro' AND TABLE_NAME = 'ca_seguro_externo')
begin
    alter table ca_seguro_externo
    add se_tipo_seguro varchar(16) null
end



if not exists(
      SELECT 1 
      FROM sys.indexes 
      WHERE name = 'idx_ca_seguro_externo' 
      AND object_id = OBJECT_ID('ca_seguro_externo') 
     ) 
begin 
     create nonclustered index idx_ca_seguro_externo on ca_seguro_externo(se_cliente, se_tramite)
end 



if not exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'sn_tipo_seguro' AND TABLE_NAME = 'ca_seguros_nuevos')
begin
    alter table ca_seguros_nuevos
    add sn_tipo_seguro varchar(16) null
end


