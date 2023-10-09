








/*************************************************************************************/
--No Historia                : 97129
--Titulo de la Historia      : ERROR EN ARCHIVO DE PROVISIONES
--Fecha                      : 04/04/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Inclusion de parametro FECHA REPROCESO (RollBack)
--                             Proceso 36428: GENERACION ARCHIVO RIESGOS MORA
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cb_batch.sql
--Ruta Instalador            : $/ASP/CLOUD/Main/CLOUD/Activas/Cartera/Backend/sql/Param_Conta_MX
/*************************************************************************************/
use cobis
go

DELETE FROM ba_parametro WHERE pa_sarta = 22 AND pa_batch = 36428
DELETE FROM ba_parametro WHERE pa_sarta = 0  AND pa_batch = 36428
GO

