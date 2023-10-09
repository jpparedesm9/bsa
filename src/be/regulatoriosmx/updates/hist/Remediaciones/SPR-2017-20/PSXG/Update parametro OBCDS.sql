
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
--parametro URL --
if exists (SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'OBCDS' AND pa_producto = 'CRE')
BEGIN

    UPDATE cobis..cl_parametro 
    SET pa_int = 1
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'OBCDS'
end
else
BEGIN

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OBTENER BURO DE CREDITO DESDE SERVICIO', 'OBCDS', 'I', NULL, NULL, NULL, 1, NULL, NULL, NULL, 'CRE')
END