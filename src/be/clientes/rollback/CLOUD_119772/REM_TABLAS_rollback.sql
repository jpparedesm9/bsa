-----------------------------------------------------------------------------------
-- REMEDIACIONES COLECTIVOS - 
-----------------------------------------------------------------------------------
use cobis
go

if exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_colectivo'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   drop column ea_colectivo
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_nivel_colectivo'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   drop column ea_nivel_colectivo 
end

go


use cob_credito
go

if exists (SELECT 1 FROM sys.columns WHERE Name = 'ea_asesor_ext'
               AND Object_ID = Object_ID('cobis..cl_ente_aux')) begin
   alter table cl_ente_aux
   drop column ea_asesor_ext
end


if exists (SELECT 1 FROM sys.columns WHERE Name = 'pr_estado'
               AND Object_ID = Object_ID('cob_credito..cr_pregunta_ver_dat')) begin
   ALTER TABLE cr_pregunta_ver_dat
   drop column pr_estado
END

if exists (SELECT 1 FROM sys.columns WHERE Name = 'pr_codigo_dep'
               AND Object_ID = Object_ID('cob_credito..cr_pregunta_ver_dat')) begin
   ALTER TABLE cr_pregunta_ver_dat
   drop column pr_codigo_dep
end


if exists (SELECT 1 FROM sys.columns WHERE Name = 'pr_tipo_dep'
               AND Object_ID = Object_ID('cob_credito..cr_pregunta_ver_dat')) begin
   ALTER TABLE cr_pregunta_ver_dat
   drop column pr_tipo_dep
end

if exists (SELECT 1 FROM sys.columns WHERE Name = 'pr_valor_dep'
               AND Object_ID = Object_ID('cob_credito..cr_pregunta_ver_dat')) begin
   ALTER TABLE cr_pregunta_ver_dat
   drop column pr_valor_dep
end

if  exists (SELECT 1 FROM sys.columns WHERE Name = 'pr_campo'
               AND Object_ID = Object_ID('cob_credito..cr_pregunta_ver_dat')) begin
   ALTER TABLE cr_pregunta_ver_dat
   drop column pr_campo
end

IF OBJECT_ID ('dbo.cr_cuenta_buc_santander_job') IS NOT NULL
	DROP TABLE dbo.cr_cuenta_buc_santander_job

IF OBJECT_ID ('dbo.cr_buro_ln_nf_job') IS NOT NULL
	DROP TABLE dbo.cr_buro_ln_nf_job
go

