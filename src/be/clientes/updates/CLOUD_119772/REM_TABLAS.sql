-----------------------------------------------------------------------------------
-- REMEDIACIONES COLECTIVOS - 
-----------------------------------------------------------------------------------
use cobis
go

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_colectivo'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   add ea_colectivo VARCHAR(64) null
end

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_nivel_colectivo'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   add ea_nivel_colectivo VARCHAR(64) null
end

go

if not exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_asesor_ext'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   add ea_asesor_ext int null
end

use cob_credito
go

IF OBJECT_ID ('dbo.cr_cuenta_buc_santander_job') IS NOT NULL
	DROP TABLE dbo.cr_cuenta_buc_santander_job
go

CREATE TABLE dbo.cr_cuenta_buc_santander_job
	(
	cbs_ente              INT not null,
	cbs_tramite           INT not null,
	cbs_intentos          INT not null,
	cbs_fecha_ult_intento DATETIME not null,
	cbs_estado            CHAR (1) not null,
	constraint UQ_tramite_cuenta_buc_santander_job unique(cbs_tramite)
	)
go


IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_cbs_estado' AND object_id = OBJECT_ID('cr_cuenta_buc_santander_job'))
   CREATE INDEX idx_cbs_estado
   ON cr_cuenta_buc_santander_job (cbs_estado)

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_cbs_intentos' AND object_id = OBJECT_ID('cr_cuenta_buc_santander_job'))
   CREATE INDEX idx_cbs_intentos
   ON cr_cuenta_buc_santander_job (cbs_intentos)


IF OBJECT_ID ('dbo.cr_buro_ln_nf_job') IS NOT NULL
	DROP TABLE dbo.cr_buro_ln_nf_job
go

CREATE TABLE dbo.cr_buro_ln_nf_job
	(
	bj_ente              INT not null,
	bj_tramite           INT not null,
	bj_fecha_ingreso     DATETIME not null,
	bj_novedades_ln_nf   varchar(2),
	bj_estado            CHAR (1) not null,
	constraint UQ_tramite_buro_ln_nf_job unique(bj_tramite)
	)
go

IF NOT EXISTS(SELECT 1 FROM sys.indexes WHERE name = 'idx_bj_estado' AND object_id = OBJECT_ID('cr_buro_ln_nf_job'))
   CREATE INDEX idx_bj_estado
   ON cr_buro_ln_nf_job (bj_estado)

go