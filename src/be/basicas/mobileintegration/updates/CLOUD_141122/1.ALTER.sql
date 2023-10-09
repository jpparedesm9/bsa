use cob_sincroniza
go
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'di_imei' and TABLE_NAME = 'si_dispositivo')
begin
    alter table si_dispositivo ALTER COLUMN di_imei varchar(45) NULL
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'di_permitir_matricula' and TABLE_NAME = 'si_dispositivo')
begin
    alter table si_dispositivo add di_permitir_matricula char(1) null
end
go
UPDATE si_dispositivo
SET di_permitir_matricula='N'
go