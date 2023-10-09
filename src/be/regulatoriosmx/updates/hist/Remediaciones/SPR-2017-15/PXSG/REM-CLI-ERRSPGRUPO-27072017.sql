/**********************************************************************************************************************/
--No Bug                     : SI
--Título de la Historia      : CGS-126624 PERMITE CREAR OPERACIONES CON GRUPOS EN ESTADO CANCELADO PRUEBA INTEGRALC
--Fecha                      : 27/07/2017
--Descripción del Problema   : No existe control de errores
--Descripción de la Solución : Agregar el error
--Autor                      : Patricio Samueza
--Instalador                 : 8_sta_error.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Agregar error
--------------------------------------------------------------------------------------------
use cobis
GO

delete cobis..cl_errores
where numero in (103147)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103147, 0, ' Error al iniciar el flujo, el grupo no esta vigente ')
GO
