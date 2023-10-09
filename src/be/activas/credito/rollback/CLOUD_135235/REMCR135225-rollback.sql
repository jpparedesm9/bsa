use cob_credito
go

--NIVEL DE RIESGO
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'bd_nivel_riesgo' and TABLE_NAME = 'cr_buro_diario')
begin
   alter table cob_credito..cr_buro_diario drop column bd_nivel_riesgo
end
--RIESGO INDIVIDUAL
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'bd_riesgo_individual' and TABLE_NAME = 'cr_buro_diario')
begin
   alter table cob_credito..cr_buro_diario drop column bd_riesgo_individual
end

