IF OBJECT_ID ('ca_reporte_devol') IS NOT NULL
	DROP table ca_reporte_devol
go

CREATE TABLE cob_cartera..ca_reporte_devol  ( 
	REGION             	varchar(64) NULL,
	OFICINA            	varchar(64) NULL,
	GRUPO              	varchar(64) NULL,
	ID_COBIS           	varchar(64) NULL,
	CONTRATO           	varchar(24) NULL,
	ID_ASESOR          	varchar(64) NULL,
	ID_COORDINADOR     	varchar(64) NULL,
	ID_GERENTE         	varchar(64) NULL,
	FECHA_DESEMBOLSO   	varchar(64) NULL,
	FECHA_CANCELACION  	varchar(64) NULL,
	FECHA_CREACION     	varchar(64) NULL,
	FECHA_REINTEGRO    	varchar(64) NULL,
	PRODUCTO           	varchar(64) NULL,
	SUB_PRODUCTO       	varchar(64) NULL,
	TASA_INTERES       	varchar(64) NULL,
	DIFERENCIA_TASAS   	varchar(64) NULL,
	PROMOCION          	varchar(64) NULL,
	SUB_PROMOCION      	varchar(64) NULL,
	MONTO_TOTAL_CREDITO	varchar(64) NULL,
	MONTO_DEVUELTO     	varchar(64) NULL,
	MOTIVO_DISPERSION  	varchar(64) NULL,
	mca_operacion_padre	varchar(64) NULL,
	)
GO

	IF OBJECT_ID ('ca_reporte_devol_ctl') IS NOT NULL
		DROP table ca_reporte_devol_ctl
	GO

	CREATE TABLE cob_cartera..ca_reporte_devol_ctl  ( 
		NOMBRE_REPORTE             	varchar(80) NULL,
		FECHA_GEN            	    varchar(15) NULL
		)
	GO
