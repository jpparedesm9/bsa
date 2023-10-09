use cobis
go

IF EXISTS(SELECT 1 FROM sys.indexes indexes 
          INNER JOIN sys.objects objects ON indexes.object_id = objects.object_id 
          WHERE indexes.name ='IX_pq_parroquia' 
          AND objects.name = 'cl_parroquia')
BEGIN
    DROP INDEX [IX_pq_parroquia] ON [dbo].[cl_parroquia]
END
GO

CREATE NONCLUSTERED INDEX IX_pq_parroquia   
    ON cl_parroquia (pq_parroquia)
go


