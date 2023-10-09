use cob_conta_super
go

if not exists(select 1
              from INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'INTEGRANTES_GRUPO'
              and  c1.table_name = 'sb_riesgo_hrc_lcr')
begin 
	alter table sb_riesgo_hrc_lcr
	add INTEGRANTES_GRUPO varchar(10) null
end

if not exists(select 1
              from INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'CICLO_INDIVIDUAL'
              and  c1.table_name = 'sb_riesgo_hrc_lcr')
begin 
	alter table sb_riesgo_hrc_lcr
	add CICLO_INDIVIDUAL varchar(10) null
end

if not exists(select 1
              from INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'Folio_Consulta_Buro'
              and  c1.table_name = 'sb_lcr_riesgo_provision')
begin 
	alter table sb_lcr_riesgo_provision
	add Folio_Consulta_Buro varchar(64) null
end

if not exists(select 1
              from INFORMATION_SCHEMA.COLUMNS AS c1
              where c1.column_name = 'Folio_Consulta_Buro'
              and  c1.table_name = 'sb_riesgo_provision')
begin 
	alter table sb_riesgo_provision
	add Folio_Consulta_Buro varchar(64) null
end

go
