/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 14/07/2017
--Descripción del Problema   : Agregar parametros para validacion de integrantes
--Descripción de la Solución : Agregar parametros para validacion de integrantes
--Autor                      : PATRICIO SAMUEZA
--Ruta					     :$/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Archivo					 :1_add_campos.sql
/**********************************************************************************************************************/
USE cobis
go
--parametro para numero maximo de integrantes --
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'MAXIGR' AND pa_producto = 'CLI')
begin
    UPDATE cobis..cl_parametro 
    SET pa_int = 40
    WHERE pa_producto = 'CLI'
    AND pa_nemonico = 'MAXIGR'
end
else
begin
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('NUMERO MAXIMO DE INTEGRANTES', 'MAXIGR', 'I', NULL, NULL, NULL, 40, NULL, NULL, NULL, 'CLI')
END
--parametro para numero minimo de integrantes --
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'MINIGR' AND pa_producto = 'CLI')
begin
    UPDATE cobis..cl_parametro 
    SET pa_int = 7
    WHERE pa_producto = 'CLI'
    AND pa_nemonico = 'MINIGR'
end
else
begin
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO MINIMO DE INTEGRANTES', 'MINIGR', 'I', NULL, NULL, NULL,7, NULL, NULL, NULL, 'CLI')
END
---validacion de parentesco
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'PPGRU' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_float = 40
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'PPGRU'
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('PORCENTAJE DE PARENTESCO', 'PPGRU', 'F', NULL, NULL, NULL,NULL, NULL, NULL,40, 'CRE')
END
---VALIDACION DE CONYUGE--
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'RCONY' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_int=209
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'RCONY'
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('CODIGO RELACION CONYUGE', 'RCONY', 'I', NULL, NULL, NULL,209, NULL, NULL,NULL, 'CRE')
END

---VALIDACION DE MUJERES--
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'PMGRU' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_float=80
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'PMGRU'
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('PORCENTAJE DE MUJERES', 'PMGRU', 'F', NULL, NULL, NULL,NULL, NULL, NULL,80, 'CRE')
END

GO
