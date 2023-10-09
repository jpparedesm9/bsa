
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : Requerimiento 118331: Auditoria Riesgos Geolocalizacion
--Fecha                      : 07/08/2019
--Descripci�n del Problema   : Se debe modificar catalogos
--Descripci�n de la Soluci�n : Crear scripts de instalaci�n
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ROLLBACK DE PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('FILSAN','PAISGE','DISGEO','RADGEO','URLGEO','PRTGEO','SERGEO')
go

--------------------------------------------------------------------------------------------
-- ELIMINAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------

use cobis
go

if exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference')
    delete cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'

if exists(select 1 from cobis..ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference')
	delete ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'

--------------------------------------------------------------------------------------------
-- BORRAR FUNCION
--------------------------------------------------------------------------------------------
use cob_credito
go

IF OBJECT_ID ('dbo.fn_CalculaDistancia') IS NOT NULL
	DROP FUNCTION dbo.fn_CalculaDistancia
GO