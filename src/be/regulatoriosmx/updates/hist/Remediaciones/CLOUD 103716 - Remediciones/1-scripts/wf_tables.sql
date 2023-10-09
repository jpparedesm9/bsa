use cob_workflow
go
if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_r_actividades_proc' and b.name='da_canal')
begin
	alter table wf_r_actividades_proc add  da_canal int null
end
go

if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_r_asignacion_act' and b.name='du_canal')
begin
	alter table wf_r_asignacion_act add  du_canal int null
end
go

if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_r_proceso' and b.name='rr_canal')
begin
	alter table wf_r_proceso add  rr_canal int null
end
go

ALTER TABLE [dbo].[wf_r_proceso] ADD CONSTRAINT [DF_dbo_wf_r_proceso_rr_canal] DEFAULT -1 FOR [rr_canal]
GO
update wf_r_proceso
set rr_canal = -1
GO
ALTER TABLE [dbo].[wf_r_proceso] ALTER COLUMN [rr_canal] int NOT NULL
GO


ALTER TABLE [dbo].[wf_r_proceso]
	DROP CONSTRAINT [PK_WF_R_PROCESO]
GO

ALTER TABLE [dbo].[wf_r_proceso]
	ADD CONSTRAINT [PK_WF_R_PROCESO]
	PRIMARY KEY CLUSTERED ([rr_codigo_proceso], [rr_version_proceso], [rr_fecha], [rr_oficina],[rr_canal])
GO

ALTER TABLE [dbo].[wf_r_actividades_proc] ADD CONSTRAINT [DF_dbo_wf_r_actividades_proc_da_canal] DEFAULT -1 FOR [da_canal]
GO
update wf_r_actividades_proc
set da_canal = -1
GO
ALTER TABLE [dbo].[wf_r_actividades_proc] ALTER COLUMN [da_canal] int NOT NULL
GO
ALTER TABLE [dbo].[wf_r_actividades_proc]
	DROP CONSTRAINT [PK_WF_R_ACTIVIDADES_PROC]
GO

ALTER TABLE [dbo].[wf_r_actividades_proc]
	ADD CONSTRAINT [PK_WF_R_ACTIVIDADES_PROC]
	PRIMARY KEY CLUSTERED ([da_codigo_proceso], [da_version_proceso], [da_codigo_actividad], [da_fecha], [da_oficina],[da_canal])
GO



if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_asig_actividad' and b.name='aa_oficina_login')
begin
	alter table wf_asig_actividad add  aa_oficina_login int null
end
go

if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_asig_actividad' and b.name='aa_canal')
begin
	alter table wf_asig_actividad add  aa_canal int null
end
go
if not exists(select 1 from sysobjects a,syscolumns b where a.name = 'wf_inst_proceso' and b.name='io_canal')
begin
	alter table wf_inst_proceso add  io_canal int null
end
go


update wf_inst_proceso
set io_canal = 12