
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S147297 CC017 Seguros - Digitalizacion
--Fecha                      : 29/11/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Crear TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_table.sql
use cob_cartera
go


IF OBJECT_ID ('dbo.ca_seguro_externo') IS NOT NULL
	DROP TABLE dbo.ca_seguro_externo
GO

CREATE TABLE dbo.ca_seguro_externo
	(
	se_operacion         INT NULL,
	se_banco             VARCHAR (36) NULL,
	se_cliente           INT NULL,
	se_fecha_ini         DATETIME NULL,
	se_fecha_ult_intento DATETIME NULL,
	se_monto             MONEY NULL,
	se_estado            CHAR (1) NULL
	)
GO

