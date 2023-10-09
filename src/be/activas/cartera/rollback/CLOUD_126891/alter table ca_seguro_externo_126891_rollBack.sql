
use cob_cartera
go


if exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'se_tipo_seguro' AND TABLE_NAME = 'ca_seguro_externo')
begin
    ALTER TABLE ca_seguro_externo DROP COLUMN se_tipo_seguro
end




if exists (select 1
               from INFORMATION_SCHEMA.COLUMNS
               where COLUMN_NAME = 'sn_tipo_seguro' AND TABLE_NAME = 'ca_seguros_nuevos')
begin
    ALTER TABLE ca_seguros_nuevos DROP COLUMN sn_tipo_seguro
end


