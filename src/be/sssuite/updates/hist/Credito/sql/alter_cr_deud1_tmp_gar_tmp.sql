use cob_credito
go
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [desc_tipo_op] varchar(64) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [linea] varchar(24) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [desc_moneda] varchar(10) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [monto_orig] money NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [refinanciamiento] char(2) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [prox_fecha_pag_int] char(10) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [clasificacion] varchar(64) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [moneda] tinyint NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [cod_estado] varchar(10) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [motivo_credito] varchar(64) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [fecha_cancelacion] datetime NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [calificacion] char(1) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [etapa_act] varchar(255) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [id_inst_act] int NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [codigo_alterno] varchar(50) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [ult_fecha_pg] char(10) NULL
GO
ALTER TABLE [dbo].[cr_deud1_tmp] ALTER COLUMN [tipo_plazo] varchar(64) NULL
GO
ALTER TABLE [dbo].[cr_gar_tmp] ALTER COLUMN [PLAZO_FIJO] varchar(30) NULL
GO
ALTER TABLE [dbo].[cr_gar_tmp] ALTER COLUMN [fechaCancelacion] datetime NULL
GO
ALTER TABLE [dbo].[cr_gar_tmp] ALTER COLUMN [fechaActivacion] datetime NULL
GO



