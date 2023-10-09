Use cob_conta
go

IF OBJECT_ID ('dbo.cb_empresa') IS NOT NULL
	DROP TABLE dbo.cb_empresa
GO

CREATE TABLE dbo.cb_empresa
	(
	em_empresa     TINYINT NOT NULL,
	em_ruc         VARCHAR (13) COLLATE Latin1_General_BIN NOT NULL,
	em_descripcion VARCHAR (64) COLLATE Latin1_General_BIN NOT NULL,
	em_replegal    VARCHAR (64) COLLATE Latin1_General_BIN NULL,
	em_contgen     VARCHAR (64) COLLATE Latin1_General_BIN NULL,
	em_moneda_base TINYINT NOT NULL,
	em_abreviatura CHAR (16) COLLATE Latin1_General_BIN NULL,
	em_direccion   VARCHAR (64) COLLATE Latin1_General_BIN NOT NULL,
	em_matcontgen  CHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	em_revisor     VARCHAR (64) COLLATE Latin1_General_BIN NOT NULL,
	em_matrevisor  CHAR (10) COLLATE Latin1_General_BIN NOT NULL,
	em_emp_revisor descripcion NULL,
	em_nit_emprev  VARCHAR (13) COLLATE Latin1_General_BIN NULL,
	em_mat_revisor CHAR (10) COLLATE Latin1_General_BIN NULL
	)
GO



INSERT INTO dbo.cb_empresa (em_empresa, em_ruc, em_descripcion, em_replegal, em_contgen, em_moneda_base, em_abreviatura, em_direccion, em_matcontgen, em_revisor, em_matrevisor, em_emp_revisor, em_nit_emprev, em_mat_revisor)
VALUES (1, '9002150711', 'BANCO DE LAS MICROFINANZAS BANCAMIA S.A', 'MARGARITA HELENA CORREA HENAO', 'RAFAEL OROZCO', 0, 'BANCAMIA', 'CARRERA 9 Nro 66-25', '22016 -T', 'ANDREA CHAVARRO', '88877-T', 'DELLOITE & TOUCHE', '8600005813', '2340')
GO

