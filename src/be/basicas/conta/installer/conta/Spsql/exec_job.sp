/************************************************************************/
/*  Archivo:            exec_job.sp                                     */
/*  Stored procedure:   sp_exec_job                                     */
/*  Base de datos:      cob_conta_super                                 */
/*  Producto:           Admin                                           */
/*  Disenado por:                                                       */
/*  Fecha de escritura: 30/04/2010                                      */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA", representantes exclusivos para el Ecuador de la           */
/*  "NCR CORPORATION".                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*              PROPOSITO                                               */
/*  Ejecuta el comando sp_start_job para visual batch                   */
/************************************************************************/
/*              MODIFICACIONES                                          */
/************************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_exec_job')
   drop proc sp_exec_job
go

create proc sp_exec_job (
   @i_param1      varchar(50)
)
as
declare    @w_return   int

print 'Ejecutando Job: '+ @i_param1 + '...'

exec @w_return = msdb..sp_start_job @i_param1

if @w_return <> 0 begin
   print 'error en ejecución sp_start_job.'
   return 1
end
else
   print 'sp_start_job ejecutado satisfactoriamente.'

return 0

go