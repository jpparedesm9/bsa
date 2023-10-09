/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 10/10/2017
--Descripción del Problema   : Agregar parametros a la pantalla de Prospectos
--Descripción de la Solución : Agregar parametros a la pantalla de Prospectos
--Autor                      : MARIA JOSE TACO
/**********************************************************************************************************************/

use cobis
go

--PARAMETRO DE EDAD MAXIMA
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'EMAX' and pa_producto= 'CLI')
begin
   INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('MAYORIA DE EDAD MAX', 'EMAX', 'T', NULL, 98, NULL, NULL, NULL, NULL, NULL, 'CLI')
end
--PARAMETRO DE RELACION DE PADRE
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'PAD' and pa_producto= 'CLI')
begin
   INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('RELACION PADRE', 'PAD', 'T', NULL, 211 , NULL, NULL, NULL, NULL, NULL, 'CLI')
END
--PARAMETRO DE RELACION DE HIJO
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'HIJ' and pa_producto= 'CLI' )
begin
   INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('RELACION HIJO', 'HIJ', 'T', NULL, 210, NULL, NULL, NULL, NULL, NULL, 'CLI')
END
--PARAMETRO DE RELACION DE CONYUGUE
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'CONY' and pa_producto= 'CLI')
begin
   INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
   VALUES ('RELACION CONYUGUE', 'CONY', 'T', NULL, 209, NULL, NULL, NULL, NULL, NULL, 'CLI')
end
--PARAMETRO DE ESTADO CIVIL UNION LIBRE
if not exists (select 1 from cobis..cl_parametro where pa_nemonico = 'UNL' and pa_producto= 'CLI')
begin
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO CIVIL UNION LIBRE', 'UNL', 'C', 'UN', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
END


GO
