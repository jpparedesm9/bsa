use cobis
go

/****************************************************************************/
/*  Vista con valores randomicos			                               */
/****************************************************************************/

IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'random_val_view')
DROP VIEW random_val_view
GO

PRINT 'CREACION DE VISTA random_val_view'
go

CREATE VIEW random_val_view
AS
SELECT RAND() as  random_value

go