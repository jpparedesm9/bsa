 --Cambios iniciales subido en Changeset 218824 successfully checked in.
/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : Incidencia de oficina
--Descripción del Problema   : Este parametro indica la oficina que vendría si la solicitud es creada desde el movil
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/MobileIntegration/Backend/sql/
--Nombre Archivo             : cl_parametro.sql

USE cobis
GO

if exists (select 1 from cobis..cl_parametro where pa_nemonico = 'MOBOFF' AND pa_producto = 'ADM' )
begin
    UPDATE cl_parametro 
    SET pa_int = 9001
    WHERE pa_nemonico = 'MOBOFF'
    AND pa_producto = 'ADM' 
end
else
begin
    INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
    VALUES ('Oficina de conexion movil para oficiales', 'MOBOFF', 'I', NULL, NULL, NULL, 9001, NULL, NULL, NULL, 'ADM')
end

go
