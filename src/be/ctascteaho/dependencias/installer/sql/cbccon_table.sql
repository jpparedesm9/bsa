use cob_ccontable
go


IF OBJECT_ID ('dbo.cco_error_conaut') IS NOT NULL
	DROP TABLE dbo.cco_error_conaut
GO

CREATE TABLE dbo.cco_error_conaut(
	ec_secuencial  numeric(8, 0) IDENTITY(1,1) NOT NULL,
	ec_empresa     tinyint NOT NULL,
	ec_producto    tinyint NOT NULL,
	ec_fecha_conta datetime NOT NULL,
	ec_numerror    int NOT NULL,
	ec_fecha       datetime NOT NULL,
	ec_tran_modulo varchar(20) NOT NULL,
	ec_asiento     int NOT NULL,
	ec_mensaje     descripcion NOT NULL,
	ec_perfil      varchar(20) NULL,
	ec_oficina     smallint NULL,
	ec_valor       money NULL,
	ec_comprobante int NULL
) 
go

