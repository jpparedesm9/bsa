USE cob_cartera
GO



IF OBJECT_ID ('ca_comision_diferida') IS NOT NULL
	DROP TABLE ca_comision_diferida
GO


CREATE TABLE ca_comision_diferida
	(
	cd_operacion          INT NOT NULL,
	cd_concepto           catalogo NOT NULL,
	cd_cuota              MONEY NOT NULL,
	cd_acumulado          MONEY  NULL,
	cd_estado             TINYINT NULL,
        cd_cod_valor          INT   NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida1
	ON ca_comision_diferida (cd_operacion,cd_concepto)
GO



IF OBJECT_ID ('ca_comision_diferida_his') IS NOT NULL
	DROP TABLE ca_comision_diferida_his
GO


CREATE TABLE ca_comision_diferida_his
	(	
	cdh_secuencial         INT NOT NULL,
        cdh_operacion          INT NOT NULL,
	cdh_concepto           catalogo NOT NULL,
	cdh_cuota              MONEY NOT NULL,
	cdh_acumulado          MONEY  NULL,
	cdh_estado             TINYINT NULL,
        cdh_cod_valor           INT   NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_comision_diferida_his1
	ON ca_comision_diferida_his (cdh_secuencial,cdh_operacion,cdh_concepto)
GO
