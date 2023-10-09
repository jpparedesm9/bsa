use cob_cartera
go

--Todas las sentencias
ALTER TABLE ca_grupos_vencidos ALTER COLUMN gv_referencia VARCHAR (20) NOT NULL
GO	
ALTER TABLE ca_grupos_vencidos ALTER COLUMN gv_grupo_id int NOT NULL
GO

--[IX_ca_grupos_vencidos]
IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='IX_ca_grupos_vencidos' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
     ALTER TABLE [dbo].[ca_grupos_vencidos] DROP CONSTRAINT [IX_ca_grupos_vencidos]
END
GO

ALTER TABLE [dbo].[ca_grupos_vencidos] ADD  CONSTRAINT [IX_ca_grupos_vencidos] UNIQUE NONCLUSTERED 
(
	[gv_gerente_id] ASC,
	[gv_coord_id] ASC,
	[gv_asesor_id] ASC,
	[gv_grupo_id] ASC
)
GO


--[PK_ca_grupos_vencidos]

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='PK_ca_grupos_vencidos' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    ALTER TABLE ca_grupos_vencidos DROP CONSTRAINT PK_ca_grupos_vencidos
END
GO

ALTER TABLE dbo.ca_grupos_vencidos 
ADD CONSTRAINT PK_ca_grupos_vencidos PRIMARY KEY NONCLUSTERED (gv_referencia ASC, gv_grupo_id ASC )
GO

--[ix_gv_asesor_id]
IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_gv_asesor_id' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    DROP INDEX [ix_gv_asesor_id] ON [dbo].[ca_grupos_vencidos]
END
GO

CREATE NONCLUSTERED INDEX [ix_gv_asesor_id] ON [dbo].[ca_grupos_vencidos]
(
	[gv_asesor_id] ASC
)
GO

--[ix_gv_coord_id]
IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_gv_coord_id' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    DROP INDEX [ix_gv_coord_id] ON [dbo].[ca_grupos_vencidos]
END
GO

CREATE NONCLUSTERED INDEX [ix_gv_coord_id] ON [dbo].[ca_grupos_vencidos]
( [gv_coord_id] ASC )
GO



USE [cob_conta_super] 
GO
--NONCLUSTERED
IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='sb_equivalencias_Key' 
          AND objects.name = 'sb_equivalencias')
BEGIN
    DROP INDEX [sb_equivalencias_Key] ON [dbo].[sb_equivalencias]
END
GO

CREATE CLUSTERED INDEX [sb_equivalencias_Key] ON [dbo].[sb_equivalencias]
(
	[eq_catalogo] ASC,
	[eq_valor_cat] ASC,
	[eq_estado] ASC
)
GO


