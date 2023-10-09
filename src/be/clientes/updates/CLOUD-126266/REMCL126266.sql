
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Error 126266
--Fecha                      : 18/09/2019
--Descripción del Problema   : El parametro es incorrecto
--Descripción de la Solución : Modificar el parámetro
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('PAISGE')

insert into cobis..cl_parametro values ('PAIS DE GEOLOCALIZACION', 'PAISGE', 'C', 'MX', null, null, null, null, null, null, 'CLI')
go
