use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'mnr_contrapartes' and TABLE_NAME = 'cr_monto_num_riesgo')
begin
    alter table cr_monto_num_riesgo add mnr_contrapartes varchar(30) null
end

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'mnr_canal_contratacion' and TABLE_NAME = 'cr_monto_num_riesgo')
begin
    alter table cr_monto_num_riesgo add mnr_canal_contratacion varchar(30) null
end

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'mnr_fecha_nac' and TABLE_NAME = 'cr_monto_num_riesgo')
begin
    alter table cr_monto_num_riesgo add mnr_fecha_nac varchar(30) null
end
go

