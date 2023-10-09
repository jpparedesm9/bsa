use cob_cartera 
go 


truncate table ca_lcr_candidatos

IF OBJECT_ID ('dbo.lcr_reporte_candidatos') IS NOT NULL
	DROP TABLE dbo.lcr_reporte_candidatos
GO

CREATE TABLE dbo.lcr_reporte_candidatos
	(
	fecha_liq VARCHAR (255) NOT NULL,
	grupo     VARCHAR (255) NOT NULL,
	oficina   VARCHAR (255) NULL,
	cliente   VARCHAR (255) NULL,
	nombre    VARCHAR (255) NULL,
	asesor    VARCHAR (255) NULL,
	gerente   VARCHAR (255) NULL
	)
GO

