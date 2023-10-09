

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
if exists (SELECT * FROM cobis..cl_parametro WHERE pa_nemonico = 'URLSA1' AND pa_producto = 'CRE')
BEGIN

    UPDATE cobis..cl_parametro 
    SET pa_char = 'https://cobis-lightweight-gate'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'URLSA1'
end
else
BEGIN

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('URL Santander', 'URLSA1', 'C', 'https://cobis-lightweight-gate', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

END

-----
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'URLSA2' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char = 'way-mxtibimodal-pre.appls.cto1'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'URLSA2'
end
else
BEGIN

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('URL Santander2', 'URLSA2', 'C', 'way-mxtibimodal-pre.appls.cto1', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

END

--
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'URLSA3' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char = '.paas.gsnetcloud.corp'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'URLSA3'
end
else
BEGIN
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('URL Santander3', 'URLSA3', 'C', '.paas.gsnetcloud.corp', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
END

--parametro  IDCSAN --

if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'IDCSA1' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char = '5373cdb8-0bce-4ffb-9998-5ddff3'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'IDCSA1'
end
else
BEGIN
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Santander Cliente id ', 'IDCSA1', 'C', '5373cdb8-0bce-4ffb-9998-5ddff3', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
END

---------
if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'IDCSA2' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char = '8671a8'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'IDCSA2'
end
else
BEGIN
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Santander Cliente id1 ', 'IDCSA2', 'C', '8671a8', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
END
---------
-- cliente id secreto



if exists (SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico = 'SECSAN' AND pa_producto = 'CRE')
begin
    UPDATE cobis..cl_parametro 
    SET pa_char = ';13aFA7s8ocrrG*fhi>1,{eA>JPOvd'
    WHERE pa_producto = 'CRE'
    AND pa_nemonico = 'SECSAN'
end
else
BEGIN
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('Santander secreto del cliente', 'SECSAN', 'C', ';13aFA7s8ocrrG*fhi>1,{eA>JPOvd', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
END

go



