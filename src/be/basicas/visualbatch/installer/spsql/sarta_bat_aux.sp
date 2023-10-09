/************************************************************************/
/* Archivo:                sarta_bat_aux.sp                             */
/* Stored procedure:       sp_sarta_batch_auxiliar                      */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     02-Mayo-2002                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    "MACOSA", representantes exclusivos para el Ecuador de la         */
/*    "NCR CORPORATION".                                                */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                          PROPOSITO                                   */
/*    Realiza operaciones sobre la tabla ba_sarta_batch_exec la cual    */
/*    contiene una copia de los registros de ba_sarta_batch relativos   */
/*    al lote a ser ejecutado                                           */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    02-May-2002    S. Soto         Emision Inicial                    */
/*    14-Abr-2011    S. Soto         Usa null en campo ba_dependiencia  */
/************************************************************************/

use cobis 
go

if exists (select * from sysobjects where name = 'sp_sarta_batch_auxiliar')
   drop proc sp_sarta_batch_auxiliar

go
create proc sp_sarta_batch_auxiliar    (
   @s_ssn         int = null,
   @s_date        datetime = null,
   @s_user        login = null,
   @s_term        descripcion = null,
   @s_corr        char(1) = null,
   @s_ssn_corr    int = null,
        @s_ofi       smallint = null,
   @t_rty         char(1) = null,
        @t_trn       smallint = 601,
   @t_debug    char(1) = 'N',
   @t_file        varchar(14) = null,
   @t_from        varchar(30) = null,
   @i_operacion      char(1),
   @i_modo             smallint = null,
        @i_sarta                int = null,
        @i_batch                int = null,
        @i_secuencial           smallint = null,
        @i_corrida              int = null,
        @i_dependencia          smallint = null,
        @i_repeticion           char(1) = null, 
        @i_critico              char(1) = 'N',
        @i_left                 int = null,
        @i_top                  int = null,
        @i_lote_inicio          smallint = null, 
        @i_habilitado           char(1) = 'S', 
        @i_imprimir             tinyint = 0
)
as 
declare
   @w_sp_name        varchar(30),
   @w_today       datetime,
   @w_fecha_proceso             datetime, 
   @w_secuencial                smallint, 
   @w_resultado                 varchar(255), 
   @w_imprimir                  tinyint


select @w_sp_name = 'sp_sarta_batch_auxiliar'
select @w_today = getdate()
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


if (@t_trn <> 8091 and @i_operacion = 'T')   or --Copia de todos los registros que componen el lote
   (@t_trn <> 8093 and @i_operacion = 'I')   or --Insercion de un registro de proceso
   (@t_trn <> 8095 and @i_operacion = 'U')   or --Actualizacion de un registro de proceso
   (@t_trn <> 8097 and @i_operacion = 'D')      --Eliminacion de un registro de proceso
   begin
     /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file    = @t_file,
     @t_from    = @w_sp_name,
     @i_num  = 601077
     return 1
   end


/* Copia de los registros de procesos a la tabla ba_sarta_batch_exec */
if @t_trn = 8091 and @i_operacion = 'T'   
   begin
     if @i_modo = 0 --Copia los registros de la tabla ba_sarta_batch (Procesos Originales)
        begin
        begin tran
          --Se eliminan datos previos
         --  (day) 
      delete cobis..ba_sarta_batch_exec
      where sb_sarta = @i_sarta
 
          --Insercion de los procesos que componen el lote
          insert into cobis..ba_sarta_batch_exec (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, 
                                             sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, sb_adicionado, sb_imprimir)
            select sb_sarta, sb_batch, sb_secuencial, null, sb_repeticion, 
                 sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado, 'N', 0
                 
                 --compare(isnull(ba_arch_resultado, ' '), ' ')  --1: Se imprime, 0: No 
              from cobis..ba_sarta_batch, cobis..ba_batch
           where sb_batch = ba_batch
                    and sb_sarta = @i_sarta 

           if @@error <> 0 
         begin
              /* Error en la copia a la tabla ba_sarta_batch_exec*/
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808012
           return 1
         end
        commit tran
       end 
     if @i_modo = 1 --Copia los registros de la tabla ba_sarta_batch_log (Corrida espec¡fica)
        begin
        begin tran
          --Se eliminan datos previos
          delete cobis..ba_sarta_batch_exec
      where sb_sarta = @i_sarta

          --Insercion de los procesos que componen el lote de una cierta corrida
          insert into cobis..ba_sarta_batch_exec (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, 
                                                         sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, 
                                                         sb_habilitado, sb_adicionado, sb_id_proceso, sb_imprimir)
            select sb_sarta, sb_batch, sb_secuencial, null, 
                        sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, 
                        sb_habilitado, sb_adicionado, sb_id_proceso, sb_imprimir
              from cobis..ba_sarta_batch_log
           where sb_sarta = @i_sarta 
                    and sb_corrida = @i_corrida

           if @@error <> 0 
         begin
              /* Error en la copia a la tabla ba_sarta_batch_exec */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808012
           return 1
         end
        commit tran
       end 
   end   



/* Inserci¢n de registro */
if @t_trn = 8093 and @i_operacion = 'I'   
   begin
     begin tran
        --Consulta el siguiente secuencial
        if @i_sarta > 0 
           begin
              select @w_secuencial = isnull(max(sb_secuencial), 0) + 1
                from cobis..ba_sarta_batch_exec 
               where sb_sarta = @i_sarta
           end
        else
           begin
              select @w_secuencial = 0

              --Eliminar registros del proceso y enlaces cuando es ejecuci¢n independiente del lote
              delete cobis..ba_sarta_batch_exec
               where sb_sarta = @i_sarta

              delete cobis..ba_enlace_exec
               where en_sarta = @i_sarta
           end 

        --Consulta si el proceso tiene un reporte asociado, para determinar si se imprime o no
        select @w_imprimir = 0
        
       -- compare(isnull(ba_arch_resultado, ' '), ' ')
          from cobis..ba_batch
         where ba_batch = @i_batch
         and ba_arch_resultado = ' '
         
        --Inserta el registro del proceso
        insert into cobis..ba_sarta_batch_exec (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion,
                                                sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado,
                                                sb_adicionado, sb_id_proceso, sb_imprimir)
      values (@i_sarta, @i_batch, @w_secuencial,null, @i_repeticion,
                        @i_critico, @i_left, @i_top, @i_lote_inicio, 'S', 'S', null, @w_imprimir)

        --Inserta el registro del enlace sin destino
        insert into cobis..ba_enlace_exec (en_sarta, en_batch_inicio, en_secuencial_inicio,
                                           en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos)
        values (@i_sarta, @i_batch, @w_secuencial, 0, 0, 'N', null)
 
   if @@error <> 0
         begin
        /* Error en la insercion del proceso en ba_sarta_batch_exec */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808017
        return 1
         end   

        --Devuelve el secuencial del nodo a¤adido y la bandera de impresion
        select @w_secuencial, @w_imprimir

     commit tran
   end


/* Actualizacion de registro */
if @t_trn = 8095 and @i_operacion = 'U'   
   begin
     begin tran
        select @w_resultado = ba_arch_resultado 
          from cobis..ba_batch
         where ba_batch = @i_batch 

        if @w_resultado is null and @i_imprimir = 1 
           begin
        /* No existe archivo de resultado adjunto al proceso */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808007
        return 1
           end
        --Actualiza en la tabla de ejecucion
        update cobis..ba_sarta_batch_exec
           set sb_habilitado = @i_habilitado,
               sb_imprimir = @i_imprimir,
               sb_top = @i_top,
               sb_left = @i_left
         where sb_sarta = @i_sarta
           and sb_batch = @i_batch 
      and sb_secuencial = @i_secuencial

   if @@error <> 0 
         begin
        /* Error en la actualizacion del proceso en ba_sarta_batch_exec */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808018
        return 1
         end   

        --Actualiza en la tabla de log
        update cobis..ba_sarta_batch_log
           set sb_habilitado = @i_habilitado,
               sb_imprimir = @i_imprimir,
               sb_top = @i_top,
               sb_left = @i_left
         where sb_sarta = @i_sarta
           and sb_batch = @i_batch 
      and sb_secuencial = @i_secuencial
      and sb_corrida = @i_corrida

   if @@error <> 0 
         begin
        /* Error en la actualizacion del proceso en ba_sarta_batch_exec */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808018
        return 1
         end   
         
    
     commit tran
   end 


/* Eliminacion de registro */
if @t_trn = 8097 and @i_operacion = 'D'   
   begin
     begin tran 
        --Elimina los enlaces del proceso
        delete cobis..ba_enlace_exec
         where en_sarta = @i_sarta
           and (en_batch_inicio = @i_batch
             or en_batch_fin = @i_batch)
                
        --Elimina el proceso
        delete cobis..ba_sarta_batch_exec
         where sb_sarta = @i_sarta
           and sb_batch = @i_batch 

   if @@error <> 0 
         begin
        /* 'Error en la eliminacion del proceso en ba_sarta_batch_exec' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808019
        return 1
         end   
     commit tran
   end 

return 0
go
