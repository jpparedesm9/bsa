
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 21/09/2017
--Descripción del Problema   : Agregar parametros para MESES VIGENTES INFORMACION
--Descripción de la Solución : Agregar parametros para MESES VIGENTES INFORMACION
--Autor                      : PATRICIO SAMUEZA
/**********************************************************************************************************************/
USE cobis
go
--parametro para numero maximo de integrantes --
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'MV' AND pa_producto = 'CLI')
begin
    UPDATE cobis..cl_parametro 
    SET pa_int = 6
    WHERE pa_producto = 'MV'
    AND pa_nemonico = 'CLI'
end
else
begin
    INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES VIGENTES INFORMACION', 'MV', 'I', 'MV', NULL, NULL, 6, NULL, NULL, NULL, 'CLI')

END


