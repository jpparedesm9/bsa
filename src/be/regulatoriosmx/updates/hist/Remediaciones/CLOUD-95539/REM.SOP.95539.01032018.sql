/*************************************************************************************/
--No Historia                : SOP-95539
--Titulo de la Historia      : REPROCESO DE ARCHIVO CONTABLE
--Fecha                      : 01/03/2018
--Descripcion del Problema   : REPROCESO DE ARCHIVO CONTABLE
--Descripcion de la Solucion : Ejecucion de sp_riesgo_mora_95539
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
use cob_conta_super
go

declare @w_error int

exec @w_error = sp_riesgo_mora_95539
@i_fecha_ini = '12/21/2017',
@i_fecha_fin = '02/28/2018'

if @w_error != 0 print'@w_error: ' + convert(varchar, @w_error)
go

