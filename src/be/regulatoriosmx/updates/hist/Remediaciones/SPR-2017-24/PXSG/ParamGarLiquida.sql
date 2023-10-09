
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 21/09/2017
--Instalador                 : cu_param.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Garantias/Backend/sql
--Autor                      : PATRICIO SAMUEZA
/**********************************************************************************************************************/
USE cobis
go
--parametro Garantia liquida--
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'GARLIQ' AND pa_producto = 'GAR')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char ='AHORRO'
    WHERE pa_producto = 'GAR'
    AND pa_nemonico = 'GARLIQ'
end
else
begin
    INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO GARANTIA LIQUIDA', 'GARLIQ', 'C', 'AHORRO', NULL, NULL, NULL, NULL, NULL, NULL, 'GAR')

END
