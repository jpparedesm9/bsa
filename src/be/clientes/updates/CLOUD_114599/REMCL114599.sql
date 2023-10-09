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
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-114599/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql
delete cobis..cl_errores where numero in (103176, 103177)

insert into cobis..cl_errores values (103176, 0, 'Error al iniciar el flujo, el solicitante no es un Grupo.')
insert into cobis..cl_errores values (103177, 0, 'Error al iniciar el flujo, el solicitante debe ser Persona Natural.')