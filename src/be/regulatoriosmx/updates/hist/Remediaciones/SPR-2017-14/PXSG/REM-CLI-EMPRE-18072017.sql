
 /**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Incidencia 83007
--Fecha                      : 18/07/2017
--Descripción del Problema   : Agregar parametros para validacion de emprendedores integrantes
--Descripción de la Solución : Agregar parametros para validacion de emprendedores integrantes
--Autor                      : PATRICIO SAMUEZA
--Ruta de Instalador		 :$/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Archivo					 : 1_add_campos.sql		
/**********************************************************************************************************************/
 
USE cobis
go
--parametro para numero  de emprendedores --
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'MAXEMP' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_float =20,
	pa_tipo='F'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'MAXEMP'
end
else
begin
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('PORCENTAJE EMPRENDEDORES', 'MAXEMP', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 20, 'CRE')
END


---
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Incidencia 83007
--Fecha                      : 18/07/2017
--Descripción del Problema   : Agregar parametros para validacion de emprendedores integrantes
--Descripción de la Solución : Agregar parametros para validacion de emprendedores integrantes
--Autor                      : PATRICIO SAMUEZA
--Ruta de Instalador		 :$/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Archivo					 : cl_error.sql		
/**********************************************************************************************************************/
USE cobis 
GO

delete from cobis..cl_errores 
where numero in (208923)
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208923, 0, 'VALIDAR NUMERO DE EMPRENDEDORES')
go


   