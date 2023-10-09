
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Mejora 93282: Reporte Control Mensual
--Fecha                      : 09/01/2018
--Descripción del Problema   : ROLLBACK
--Descripción de la Solución : ROLLBACK
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ELIMINAR TABLA
--------------------------------------------------------------------------------------------

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_control_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reporte_control_tmp
GO

--------------------------------------------------------------------------------------------
-- ELIMINAR BATCH
--------------------------------------------------------------------------------------------

use cobis
go

------
--BA_BATCH
DELETE cobis..ba_batch WHERE ba_batch= 7084

--BA_PARAMETRO
DELETE ba_parametro WHERE pa_batch = 7084 

--BA_SARTA_BATCH
DELETE ba_sarta_batch WHERE sb_batch = 7084 AND sb_sarta = 13

--BA_ENLACE
DELETE ba_enlace WHERE en_batch_inicio = 7080 AND en_batch_fin = 7084


--------------------------------------------------------------------------------------------
-- ELIMINAR SP
--------------------------------------------------------------------------------------------

use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_reporte_control')
    drop proc sp_reporte_control
go