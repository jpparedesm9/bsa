
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Mejora 93282: Reporte Control Mensual
--Fecha                      : 09/01/2018
--Descripción del Problema   : No existen cregistros ni campos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ROLLBACK CREAR TABLA
--------------------------------------------------------------------------------------------

use cob_credito
go

IF OBJECT_ID ('dbo.cr_grupo_promo_inicio') IS NOT NULL
	DROP TABLE dbo.cr_grupo_promo_inicio
GO

--------------------------------------------------------------------------------------------
-- ROLBACK CREAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93452/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_parametro.sql


delete cobis..cl_parametro WHERE pa_nemonico in ('MINEO', 'MAXLF', 'MUL100') 


--------------------------------------------------------------------------------------------
-- ROLBACK sp_var_expe_crediticia
--------------------------------------------------------------------------------------------
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_expe_crediticia')
	drop proc sp_var_expe_crediticia
GO

--------------------------------------------------------------------------------------------
-- ROLBACK sp_var_integrantes_externo
--------------------------------------------------------------------------------------------
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_integrantes_externo')
	drop proc sp_var_integrantes_externo
GO

--------------------------------------------------------------------------------------------
-- ROLBACK sp_var_integrantes_original
--------------------------------------------------------------------------------------------
use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_integrantes_original')
	drop proc sp_var_integrantes_original
GO
