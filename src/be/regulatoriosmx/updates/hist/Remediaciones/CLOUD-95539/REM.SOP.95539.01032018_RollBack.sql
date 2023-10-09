/*************************************************************************************/
--No Historia                : SOP-95539
--Titulo de la Historia      : REPROCESO DE ARCHIVO CONTABLE
--Fecha                      : 01/03/2018
--Descripcion del Problema   : REPROCESO DE ARCHIVO CONTABLE
--Descripcion de la Solucion : Eliminacion de sp_riesgo_mora_95539
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
use cob_conta_super
go

if exists (select 1 from sysobjects where name = 'sp_riesgo_mora_95539')
   drop proc sp_riesgo_mora_95539
go

