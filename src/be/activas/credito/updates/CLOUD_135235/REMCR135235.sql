--------------------------------------------------------------------------------------------
-- INSERTAR CAMPO
--------------------------------------------------------------------------------------------

use cob_credito
go

--NIVEL DE RIESGO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'bd_nivel_riesgo' and TABLE_NAME = 'cr_buro_diario')
begin
   alter table cob_credito..cr_buro_diario add bd_nivel_riesgo varchar(40)
end
else
begin
	alter table cob_credito..cr_buro_diario alter column bd_nivel_riesgo varchar(40)
end

-- RIESGO INDIVIDUAL
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'bd_riesgo_individual' and TABLE_NAME = 'cr_buro_diario')
begin
   alter table cob_credito..cr_buro_diario add bd_riesgo_individual varchar(40)
end
else
begin
	alter table cob_credito..cr_tramite_grupal alter column bd_riesgo_individual varchar(40)
end
