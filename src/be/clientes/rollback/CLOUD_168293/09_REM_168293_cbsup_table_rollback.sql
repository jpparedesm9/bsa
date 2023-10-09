--================ BSA ============================================================
--======= Rollback Caso 158406 - Geolocalización B2C - AutoOnboarding 168293 F2 
--=================================================================================
use cob_conta_super
go

if object_id ('sb_rpt_geolocaliza_b2c') is not null
	drop table sb_rpt_geolocaliza_b2c
go


if exists (select 1 from sysindexes  where name = 'idx_rpt_geolocaliza_b2c')
   drop index idx_rpt_geolocaliza_b2c on sb_rpt_geolocaliza_b2c
go


