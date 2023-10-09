

use cob_cartera_his 
go 

DROP INDEX idxh1 ON ca_diferidos_his 
GO
DROP INDEX idx_1 ON ca_seguros_can_his
GO
DROP INDEX idx_1 ON ca_seguros_det_his 
GO
DROP INDEX idx_1 ON ca_seguros_his
GO
DROP INDEX ca_comision_diferida_his1 ON ca_comision_diferida_his 
GO

IF OBJECT_ID ('dbo.ca_comision_diferida_his') IS NOT NULL
	DROP TABLE dbo.ca_comision_diferida_his
GO

IF OBJECT_ID ('dbo.ca_seguros_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_his
GO

IF OBJECT_ID ('dbo.ca_seguros_det_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_det_his
GO

IF OBJECT_ID ('dbo.ca_seguros_can_his') IS NOT NULL
	DROP TABLE dbo.ca_seguros_can_his
GO

IF OBJECT_ID ('dbo.ca_operacion_ext_his') IS NOT NULL
	DROP TABLE dbo.ca_operacion_ext_his
GO

IF OBJECT_ID ('dbo.ca_diferidos_his') IS NOT NULL
	DROP TABLE dbo.ca_diferidos_his
GO


