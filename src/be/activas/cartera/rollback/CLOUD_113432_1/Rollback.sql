use cob_cartera
go

-------------------
--Rollback Script4
-------------------

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='IX_ca_grupos_vencidos' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
     ALTER TABLE [dbo].[ca_grupos_vencidos] DROP CONSTRAINT [IX_ca_grupos_vencidos]
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='PK_ca_grupos_vencidos' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    ALTER TABLE ca_grupos_vencidos DROP CONSTRAINT PK_ca_grupos_vencidos
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_gv_asesor_id' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    DROP INDEX [ix_gv_asesor_id] ON [dbo].[ca_grupos_vencidos]
END
GO

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_gv_coord_id' 
          AND objects.name = 'ca_grupos_vencidos')
BEGIN
    DROP INDEX [ix_gv_coord_id] ON [dbo].[ca_grupos_vencidos]
END
GO

ALTER TABLE ca_grupos_vencidos alter COLUMN gv_referencia VARCHAR (20) NULL
GO	
ALTER TABLE ca_grupos_vencidos alter COLUMN gv_grupo_id int  null
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

---------------------
--Rollback Script9
---------------------
USE [cob_cartera]
GO


IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ca_dividendo_idx3' 
          AND objects.name = 'ca_dividendo')
BEGIN
   drop index ca_dividendo.ca_dividendo_idx3
END
GO

CREATE INDEX ca_dividendo_idx3
	ON dbo.ca_dividendo (di_estado, di_operacion, di_dividendo, di_fecha_ven, di_gracia)
	WITH (FILLFACTOR = 90)
GO


IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_di_fechas' 
          AND objects.name = 'ca_dividendo')
BEGIN
     DROP INDEX [ix_di_fechas] ON [dbo].[ca_dividendo]
END
GO


---------------------
--Rollback Script10
---------------------
use cobis
GO

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='IX_pq_parroquia' 
          AND objects.name = 'cl_parroquia')
BEGIN
    DROP INDEX [IX_pq_parroquia] ON [dbo].[cl_parroquia]
END
GO


---------------------
--Rollback Script 11
---------------------
use cob_credito
GO

IF EXISTS(SELECT * FROM sys.indexes indexes 
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

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='PK_cr_negative_file' 
          AND objects.name = 'cr_negative_file')
BEGIN
    ALTER TABLE [dbo].[cr_negative_file] DROP CONSTRAINT [PK_cr_negative_file]
END
GO

ALTER TABLE dbo.cr_negative_file 
ADD CONSTRAINT PK__cr_negat__924B59195ED2917C PRIMARY KEY NONCLUSTERED (nf_secuencial )
GO

---------------------
--Rollback Script 12
---------------------
use cob_credito
go

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_apellidos_nombre' 
          AND objects.name = 'cr_lista_negra')
BEGIN
    DROP INDEX [ix_apellidos_nombre] ON [dbo].[cr_lista_negra]
END
GO
