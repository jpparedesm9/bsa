/**********************************************************************************************************************/
--T�tulo Incidencia          : Error #114599: Sistema permite generar solicitudes de credito revolvente a grupos
--Fecha                      : 19/03/2019
--Descripci�n del Problema   : No existe error
--Descripci�n de la Soluci�n : Agregar error
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR ERRORES
--------------------------------------------------------------------------------------------

delete cobis..cl_errores where numero in (103176, 103177)
