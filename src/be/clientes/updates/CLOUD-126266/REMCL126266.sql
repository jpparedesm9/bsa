
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : Error 126266
--Fecha                      : 18/09/2019
--Descripci�n del Problema   : El parametro es incorrecto
--Descripci�n de la Soluci�n : Modificar el par�metro
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('PAISGE')

insert into cobis..cl_parametro values ('PAIS DE GEOLOCALIZACION', 'PAISGE', 'C', 'MX', null, null, null, null, null, null, 'CLI')
go
