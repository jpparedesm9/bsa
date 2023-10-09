/*************************************************************************************/
--No Historia                : SOP-96635
--Titulo de la Historia      : ARCHIVO MAESTRO AL 28 DE FEBRERO
--Fecha                      : 20/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Eliminacion de sp_reporte_operativo_96635
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
use cob_conta_super
go

if not object_id('sp_reporte_operativo_96635') is null
   drop proc sp_reporte_operativo_96635
go

