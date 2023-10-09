use cob_credito
go

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='PK__cr_negat__924B59195ED2917C' 
          AND objects.name = 'cr_negative_file')
BEGIN
    ALTER TABLE [dbo].[cr_negative_file] DROP CONSTRAINT [PK__cr_negat__924B59195ED2917C]
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_nombre' 
          AND objects.name = 'cr_negative_file')
BEGIN
    DROP INDEX [ix_nombre] ON [dbo].[cr_negative_file]
END
GO
CREATE CLUSTERED INDEX ix_nombre
    ON cr_negative_file (nf_ape_paterno, nf_nombre_razon_social)
go



IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='PK_cr_negative_file' 
          AND objects.name = 'cr_negative_file')
BEGIN
    ALTER TABLE [dbo].[cr_negative_file] DROP CONSTRAINT [PK_cr_negative_file]
END
GO

ALTER TABLE [dbo].[cr_negative_file] ADD CONSTRAINT  PK_cr_negative_file PRIMARY KEY  NONCLUSTERED 
(
	[nf_secuencial] ASC
)

go

