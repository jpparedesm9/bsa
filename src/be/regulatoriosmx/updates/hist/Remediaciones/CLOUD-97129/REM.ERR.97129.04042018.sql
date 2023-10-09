/*************************************************************************************/
--No Historia                : 97129
--Titulo de la Historia      : ERROR EN ARCHIVO DE PROVISIONES
--Fecha                      : 04/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Inclusion de parametro FECHA REPROCESO
--                             Proceso 36428: GENERACION ARCHIVO RIESGOS MORA
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cb_batch.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Cartera/Backend/sql/Param_Conta_MX
/*************************************************************************************/
use cobis
go

declare @w_secuencial int

DELETE FROM ba_parametro WHERE pa_sarta = 22 AND pa_batch = 36428
DELETE FROM ba_parametro WHERE pa_sarta = 0  AND pa_batch = 36428

SELECT @w_secuencial = sb_secuencial from ba_sarta_batch where sb_sarta = 22 AND sb_batch = 36428

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (22, 36428, @w_secuencial, 1, 'FECHA REPROCESO', 'D', '09/20/2017')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES ( 0, 36428, 0, 1, 'FECHA REPROCESO', 'D', '09/20/2017')
go

