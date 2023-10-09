/*************************************************************************************/
--No Historia                : SOP-96635
--Titulo de la Historia      : ARCHIVO MAESTRO AL 28 DE FEBRERO
--Fecha                      : 20/03/2018
--Descripcion del Problema   : 
--Descripcion de la Solucion : Ejecucion de sp_reporte_operativo
--Autor                      : Jorge Salazar Andrade
--Instalador                 : N/A
--Ruta Instalador            : N/A
/*************************************************************************************/
use cob_conta_super
go

declare @w_error int,
        @w_fecha varchar(10)

select @w_fecha = '02/28/2018'

exec @w_error = sp_reporte_operativo_96635
@i_param1 = @w_fecha,
@i_param2 = 28793,
@i_param3 = 111

if @w_error != 0 print'@w_error: ' + convert(varchar, @w_error)
go

