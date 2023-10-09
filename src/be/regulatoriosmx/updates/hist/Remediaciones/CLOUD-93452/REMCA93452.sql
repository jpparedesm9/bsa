
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 93452: Grupo Promocion
--Fecha                      : 02/05/2018
--Descripción del Problema   : No existe tabla ni parametros
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- CREAR TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93452/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_table.sql

use cob_credito
go

IF OBJECT_ID ('dbo.cr_grupo_promo_inicio') IS NOT NULL
	DROP TABLE dbo.cr_grupo_promo_inicio
GO

create table cr_grupo_promo_inicio
	(
	gpi_tramite int not null,
	gpi_grupo   int not null,
	gpi_ente    int not null 
	)
GO


--------------------------------------------------------------------------------------------
-- CREAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93452/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_parametro.sql

use cobis
go

delete cobis..cl_parametro WHERE pa_nemonico in ('MINEO', 'MAXLF', 'MUL100')


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MINIMO INTEGRANTES ENTIDAD ORIGNIAL', 'MINEO', 'T', NULL, 6, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAXIMO INTEGRANTES LLEGAN FUERA', 'MAXLF', 'T', NULL, 2, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MULTIPLO PARA RENOVACIONES', 'MUL100', 'M', NULL, NULL, NULL, NULL, 100, NULL, NULL, 'CCA')
GO