
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : Requerimiento 116387: Renovaci�n montos PROMO
--Fecha                      : 10/06/2019
--Descripci�n del Problema   : No existen par�metros
--Descripci�n de la Soluci�n : Crear scripts de par�metros
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('TCONT', 'TICTA', 'TRESP', 'FRCPG')

insert into cobis..cl_parametro values ('TIPO CONTRATO PROMO', 'TCONT', 'C', 'CS,PL', null, null, null, null, null, null, 'CRE')
insert into cobis..cl_parametro values ('TIPO CUENTA PROMO', 'TICTA', 'C', 'I', null, null, null, null, null, null, 'CRE')
insert into cobis..cl_parametro values ('TIPO RESPONSABILIDAD PROMO', 'TRESP', 'C', 'I,J', null, null, null, null, null, null, 'CRE')
insert into cobis..cl_parametro values ('FRECUENCIA PAGO PROMO', 'FRCPG', 'C', 'W,K,M', null, null, null, null, null, null, 'CRE')

go

--------------------------------------------------------------------------------------------
-- INSERTAR CAMPO
--------------------------------------------------------------------------------------------

use cob_credito
go

--NIVEL DE RIESGO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'tg_monto_cuenta_ref' and TABLE_NAME = 'cr_tramite_grupal')
begin
   alter table cob_credito..cr_tramite_grupal add tg_monto_cuenta_ref money null
end
else
begin
	alter table cob_credito..cr_tramite_grupal alter column tg_monto_cuenta_ref money null
end

