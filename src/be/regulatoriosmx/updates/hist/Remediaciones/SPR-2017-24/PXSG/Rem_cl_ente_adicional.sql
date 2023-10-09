/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S146493 Proceso Batch Listas Negras
--Descripción del Problema   : Crear de la tabla temporal para listas negras
--Responsable                : Patricio Samueza
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_table.sql
--Nombre Archivo             : cl_table.sql
/*----------------------------------------------------------------------------------------------------------------*/

USE cobis 

GO 

IF OBJECT_ID ('cobis..cl_ente_adicional') IS NOT NULL
	DROP TABLE cobis..cl_ente_adicional
GO

CREATE TABLE cobis..cl_ente_adicional
	(
	ea_ente     VARCHAR (50) NULL,
	ea_columna  VARCHAR (30) NULL,
	ea_char     VARCHAR (30) NULL,
	ea_tinyint  TINYINT NULL,
	ea_smallint SMALLINT NULL,
	ea_int      INT NULL,
	ea_money    MONEY NULL,
	ea_datetime DATETIME NULL,
	ea_float    FLOAT NULL
	)
GO

CREATE CLUSTERED INDEX ea_ente
	ON cobis..cl_ente_adicional (ea_ente,ea_columna)
GO

