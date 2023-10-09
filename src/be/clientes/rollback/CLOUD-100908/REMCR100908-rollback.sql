
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 96425: Mejoras al kit de crédito
--Fecha                      : 04/05/2018
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ELIMINA TABLA
--------------------------------------------------------------------------------------------

use cobis
go

IF OBJECT_ID ('dbo.cl_clientes_calif_c') IS NOT NULL
	DROP TABLE dbo.cl_clientes_calif_c
GO

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('DIAREX', /*'SVEREX', 'CNFREX',*/ 'CREREX', 'CANREX')

--------------------------------------------------------------------------------------------
-- BORRAR ERRORES
--------------------------------------------------------------------------------------------

delete cobis..cl_errores where numero in (103167, 103168)

--------------------------------------------------------------------------------------------
-- BORRAR SP sp_riesgo_ind_externo - sp_var_limite_intg_cond - sp_var_validacion_santander
--------------------------------------------------------------------------------------------
use cobis
go

if exists(select 1 from sysobjects where name ='sp_riesgo_ind_externo')
	drop proc sp_riesgo_ind_externo
go

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_limite_intg_cond')
	drop proc sp_var_limite_intg_cond
go

if exists(select 1 from sysobjects where name ='sp_var_validacion_santander')
	drop proc sp_var_validacion_santander
go

