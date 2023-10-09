
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : ERROR EN MANTENIMIENTO GRUPOS SOLIDARIOS PRUEBA INTEGRAL
--Fecha                      : 21/07/2017
--Descripción del Problema   : No existe control de errores
--Descripción de la Solución : Agregar el error
--Autor                      : Paúl Ortiz Vera
--Instalador                 : 8_sta_error.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Agregar error
--------------------------------------------------------------------------------------------
use cobis
go

delete cobis..cl_errores
where numero in (103141)


insert into cobis..cl_errores (numero, severidad, mensaje)
values (103141, 0, 'No existe un grupo con ese código ')
go

