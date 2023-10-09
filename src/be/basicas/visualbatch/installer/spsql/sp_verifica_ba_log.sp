/************************************************************************/
/* Archivo:                sp_verifica_ba_log.sp                        */
/* Stored procedure:       sp_verifica_ba_log                           */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:           Alfonso Duque                                */
/* Fecha de escritura:     21 - Marzo - 2011                            */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    Cobiscorp.                                                        */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Este programa realiza la verificaci¢n de que se haya cambiado el  */
/*    estado del registro asociado de la ba_log                         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    21-Mar-2011    A. Duque        Emision Inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_verifica_ba_log')
   drop proc sp_verifica_ba_log

go
create proc sp_verifica_ba_log (
   @i_operacion  char(1),
   @i_lote       int = null,
   @i_batch      int = null,
   @i_secuencial smallint = null,
   @i_corrida    smallint = null,
   @i_intento    smallint = null
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int         /* valor que retorna */

select @w_today = getdate()

if @i_operacion = 'S'
begin
    if exists (select 1
                from cobis..ba_log
                where lo_sarta = @i_lote
                    and lo_batch = @i_batch
                    and lo_secuencial = @i_secuencial
                    and lo_corrida = @i_corrida
                    and lo_intento = @i_intento
                    and lo_estatus = 'E')
        return 1000
    else
        return 0
end

return 0
go
