/**********************************************************************************************************************/
--Título Incidencia          : Error #114599: Sistema permite generar solicitudes de credito revolvente a grupos
--Fecha                      : 19/03/2019
--Descripción del Problema   : No existe error
--Descripción de la Solución : Agregar error
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR ERRORES
--------------------------------------------------------------------------------------------

delete cobis..cl_errores where numero in (103176, 103177)
