/************************************************************************/
/* Archivo:                execbatc.sp                                  */
/* Stored procedure:       sp_execbatch                                 */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:           Sandro Soto                                  */
/* Fecha de escritura:     04-Mayo-2009                                 */
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
/*    Este programa realiza las transacciones sobre la tabla ba_log y   */
/*    ba_sarta_batch_exec manejadas por el componente execbatch         */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    04-May-2009    S. Soto         Emision Inicial                    */
/*    28-Ene-2010    S. Soto         Uso de with(rowlock)               */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_execbatch')
   drop proc sp_execbatch

go
create proc sp_execbatch (
   @i_operacion  char(1),
   @i_modo       smallint = null,
   @i_lote       int = null,
   @i_batch      int = null,
   @i_secuencial smallint = null,
   @i_corrida    smallint = null,
   @i_intento    smallint = null,
   @i_usuario    varchar(64) = null,
   @i_estado     char(1)  = null,
   @i_fecproc    datetime = null,
   @i_razon      varchar(255)  = null,
   @i_lispar     varchar(255)  = null, 
   @i_idproc     integer = null
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int         /* valor que retorna */

select @w_today = getdate()

if @i_operacion = 'I'
begin
   insert into cobis..ba_log (lo_sarta, lo_batch, lo_secuencial,lo_corrida, lo_operador, lo_fecha_inicio, lo_fecha_terminacion, 
                              lo_num_reg_proc, lo_estatus, lo_razon, lo_fecha_proceso, lo_parametro, lo_intento)
                       values(@i_lote, @i_batch, @i_secuencial, @i_corrida, @i_usuario, @w_today, NULL, 
                              NULL, 'E', '-', @i_fecproc, @i_lispar, @i_intento)
   if @@error <> 0 
      return 1  
end

if @i_operacion = 'U'
begin
   if @i_modo = 1
      begin
        update cobis..ba_log with(rowlock)
           set lo_fecha_terminacion = getdate(),
               lo_estatus	    = @i_estado,
               lo_razon		    = @i_razon
         where lo_sarta	        = @i_lote
           and lo_batch	        = @i_batch
           and lo_secuencial	= @i_secuencial
           and lo_corrida	= @i_corrida
           and lo_intento	= @i_intento
           and ((lo_estatus = 'E' and lo_fecha_terminacion is null and @i_estado in ('A', 'F')) or @i_estado = 'K')

        if @@error <> 0 
           return 11  
   end

   if @i_modo = 2
      begin
        update cobis..ba_sarta_batch_exec with(rowlock)
           set sb_id_proceso	= @i_idproc
         where sb_sarta	        = @i_lote
           and sb_batch	        = @i_batch
           and sb_secuencial    = @i_secuencial

        if @@error <> 0 
           return 21  
      end
end

return 0 
go

