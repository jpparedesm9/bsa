USE cob_cartera
GO
 
ALTER DATABASE cob_cartera 
SET RECOVERY SIMPLE
GO
 
DBCC SHRINKFILE (cob_cartera_log)
GO
 
ALTER DATABASE cob_cartera 
SET RECOVERY FULL
GO

USE cob_credito
GO
 
ALTER DATABASE cob_credito 
SET RECOVERY SIMPLE
GO
 
DBCC SHRINKFILE (cob_credito_log)
GO
 
ALTER DATABASE cob_credito 
SET RECOVERY FULL
GO

USE cob_remesas
GO
 
ALTER DATABASE cob_remesas
SET RECOVERY SIMPLE
GO
 
DBCC SHRINKFILE (cob_remesas_log)
GO
 
ALTER DATABASE cob_remesas
SET RECOVERY FULL
GO

USE cobis
GO
 
ALTER DATABASE cobis
SET RECOVERY SIMPLE
GO
 
DBCC SHRINKFILE (cobis_log)
GO
 
ALTER DATABASE cobis
SET RECOVERY FULL
GO

USE cob_ahorros
GO
 
ALTER DATABASE cob_ahorros 
SET RECOVERY SIMPLE
GO
 
DBCC SHRINKFILE (cob_ahorros_log)
GO
 
ALTER DATABASE cob_ahorros 
SET RECOVERY FULL
GO

