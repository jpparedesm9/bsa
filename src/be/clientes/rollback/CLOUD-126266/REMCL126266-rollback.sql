
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Error 126266
--Fecha                      : 18/08/2019
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ROLLBACK DE PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('PAISGE')

insert into cobis..cl_parametro values ('PAIS DE GEOLOCALIZACION', 'PAISGE', 'C', 'SHORT_NAME:MX,TYPES:[COUNTRY', null, null, null, null, null, null, 'CLI')
go
