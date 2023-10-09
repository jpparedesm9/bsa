
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 116387: Renovación montos PROMO
--Fecha                      : 10/06/2019
--Descripción del Problema   : No existen parámetros
--Descripción de la Solución : Crear scripts de parámetros
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('TCONT', 'TICTA', 'TRESP', 'FRCPG')

go

--------------------------------------------------------------------------------------------
-- INSERTAR CAMPO
--------------------------------------------------------------------------------------------

use cob_credito
go

--NIVEL DE RIESGO
if exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'tg_monto_cuenta_ref' and TABLE_NAME = 'cr_tramite_grupal')
begin
   alter table cob_credito..cr_tramite_grupal drop column tg_monto_cuenta_ref
end

