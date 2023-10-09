
--PARA INSTALAR EN AMBIENTE HAY QUE ENCONTRAR EL MAXIMO DE LOS HISTORICOS PARA EVITAR REPETIDO 


select max(nec_codigo_hist) from cob_conta_super..sb_ns_estado_cuenta_hist


use cob_conta_super
go 

IF OBJECT_ID ('dbo.sb_ns_estado_cuenta') IS NOT NULL
	DROP TABLE dbo.sb_ns_estado_cuenta
GO

CREATE TABLE dbo.sb_ns_estado_cuenta
	(
	nec_codigo             int identity(1111180,1) ,  --AQUI REEMPLAZAR EL MAXIMO +1 QUE SE ENCUENTRE EN LA HISTORICA 
	nec_banco              VARCHAR (15) NOT NULL,
	nec_fecha              DATETIME NOT NULL,
	nec_correo             VARCHAR (64) NOT NULL,
	nec_estado             CHAR (1) NOT NULL,
	in_cliente_rfc         VARCHAR (30) NULL,
	in_cliente_buc         VARCHAR (20) NULL,
	in_folio_fiscal        VARCHAR (60) NULL,
	in_certificado         VARCHAR (30) NULL,
	in_sello_digital       VARCHAR (1500) NULL,
	in_sello_sat           VARCHAR (1500) NULL,
	in_num_se_certificado  VARCHAR (30) NULL,
	in_fecha_certificacion DATETIME NULL,
	in_cadena_cer_dig_sat  VARCHAR (1500) NULL,
	in_nombre_archivo      VARCHAR (100) NULL,
	in_observacion         VARCHAR (300) NULL,
	in_fecha_procesamiento DATETIME NULL,
	in_fecha_xml           DATETIME NULL,
	in_rfc_emisor          VARCHAR (30) NULL,
	in_estd_timb           CHAR (1) NULL,
	in_monto_fac           VARCHAR (30) NULL,
	in_toperacion          VARCHAR (10) NULL,
	in_met_fact            VARCHAR (5) NULL     
	)
GO

CREATE UNIQUE CLUSTERED INDEX sb_ns_estado_cuenta_Key
	ON dbo.sb_ns_estado_cuenta (nec_codigo)
GO
