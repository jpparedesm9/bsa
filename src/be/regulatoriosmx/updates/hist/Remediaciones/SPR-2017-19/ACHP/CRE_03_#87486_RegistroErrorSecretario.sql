/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : #87486 - CREACI�N GRUPAL/ASIGNACI�N COMIT� - APP
--Descripci�n del Problema   : Se a�ade un error
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripci�n abajo
--Nombre Archivo             : Descripci�n abajo
/*----------------------------------------------------------------------------------------------------------------*/
 
--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql


use cobis
go

delete dbo.cl_errores where numero = 208924
insert into cobis..cl_errores 
values (208924,0, 'Error al ejecutar Bur�, no existen todos los par�metros requeridos para el cliente')
go

delete dbo.cl_errores where numero = 208925
INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (208925, 0, 'VALIDACION COMITE')
GO

delete dbo.cl_errores where numero = 208926
INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (208926, 0, 'EL GRUPO DEBE TENER UN SECRETARIO')
GO

delete cobis..cl_parametro where pa_nemonico = 'TEMFU' and pa_producto = 'ADM'
INSERT INTO cobis..cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) 
VALUES ('TIPO EMAIL FUNC','TEMFU', 'C','0','ADM')
go
