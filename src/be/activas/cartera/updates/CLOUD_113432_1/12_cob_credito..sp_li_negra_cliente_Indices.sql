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

CREATE CLUSTERED INDEX ix_apellidos_nombre
    ON cr_lista_negra (ln_apellidos, ln_nombre)
go



