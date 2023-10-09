
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

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='ix_di_fechas' 
          AND objects.name = 'ca_dividendo')
BEGIN
     DROP INDEX [ix_di_fechas] ON [dbo].[ca_dividendo]
END
GO

CREATE NONCLUSTERED INDEX [ix_di_fechas] ON [dbo].[ca_dividendo]
(
	[di_fecha_ini] ASC,
	[di_fecha_ven] ASC
)
INCLUDE ( [di_operacion], [di_dividendo] ) 
GO


