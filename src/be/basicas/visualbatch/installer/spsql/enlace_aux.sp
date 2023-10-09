/************************************************************************/
/* Archivo:                enlace_aux.sp                                */
/* Stored procedure:       sp_enlace_auxiliar                           */
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
/*                         MODIFICACIONES                               */
/*    FECHA          AUTOR            RAZON                             */
/*    02-May-2002    S. Soto          Emision Inicial                   */
/************************************************************************/

use cobis 
go

if exists (select * from sysobjects where name = 'sp_enlace_auxiliar')
   drop proc sp_enlace_auxiliar

go
create proc sp_enlace_auxiliar    (
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
        @i_batch_inicio         integer = null,
        @i_secuencial_inicio    smallint = null,
        @i_batch_fin            integer = null,
        @i_secuencial_fin       smallint = null,
        @i_corrida              int = null,
        @i_tipo_enlace          char(1) = 'S',
        @i_puntos               varchar(50) = null
)
as 
declare
   @w_sp_name        varchar(30),
   @w_today       datetime,
   @w_fecha_proceso             datetime


select @w_sp_name = 'sp_enlace_auxiliar'
select @w_today = getdate()
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


if (@t_trn <> 8092 and @i_operacion = 'T') or  --Copia de todos los enlaces que componen el lote
   (@t_trn <> 8094 and @i_operacion = 'I') or  --Inserci¢n de registro de un enlace
   (@t_trn <> 8096 and @i_operacion = 'U') or  --Actualizacion de un registro de enlace 
   (@t_trn <> 8098 and @i_operacion = 'D')     --Eliminacion de un registro de enlace  
   begin
     /* 'Tipo de transaccion no corresponde' */
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file    = @t_file,
     @t_from    = @w_sp_name,
     @i_num  = 601077
     return 1
   end


if (@t_trn = 8092 and @i_operacion = 'T') 
   begin
     if @i_modo = 0 --Copia los enlaces 
        begin
          begin tran
         --Elimina datos previos
           -- (day) 
      delete cobis..ba_enlace_exec
      where en_sarta = @i_sarta

           --Insercion de los enlaces que componen el lote 
         insert into cobis..ba_enlace_exec(en_sarta, en_batch_inicio, en_secuencial_inicio, 
                                             en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos)
         select en_sarta, en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos
           from cobis..ba_enlace 
            where en_sarta = @i_sarta
   
         if @@error <> 0 
         begin
              /* 'Error en Insercion de los enlaces  ' */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808013
           return 1
         end
        commit tran
   end
     if @i_modo = 1 --Copia los enlaces de un lote dentro de una corrida especifica
        begin
          begin tran
         --Elimina datos previos
           delete cobis..ba_enlace_exec
            where en_sarta = @i_sarta
           
           --Insercion de los enlaces que componen el lote
         insert into cobis..ba_enlace_exec(en_sarta, en_batch_inicio, en_secuencial_inicio, 
                                             en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos)                       
         select en_sarta, en_batch_inicio, en_secuencial_inicio, 
                  en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos
           from cobis..ba_enlace_log
            where en_sarta = @i_sarta
                   and en_corrida = @i_corrida  

         if @@error <> 0 
         begin
              /* 'Error en Insercion de los enlaces  ' */
           exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 808013
           return 1
         end
        commit tran
   end
   end


/* Inserci¢n de registro */
if @t_trn = 8094 and @i_operacion = 'I'   
   begin
     begin tran
       --Si existe un registro de enlace en donde conste el batch inicio pero no se tenga el fin, entonces se actualiza este registro
       if exists(select * from cobis..ba_enlace_exec 
                  where en_sarta = @i_sarta
                    and en_batch_inicio = @i_batch_inicio
                    and en_batch_fin = 0
                    and en_tipo_enlace = 'N') 
          begin
            update cobis..ba_enlace_exec 
               set en_batch_fin      = @i_batch_fin,
                   en_secuencial_fin = @i_secuencial_fin,
                   en_tipo_enlace    = @i_tipo_enlace, 
                   en_puntos         = @i_puntos
             where en_sarta = @i_sarta
               and en_batch_inicio = @i_batch_inicio
               and en_batch_fin = 0                 
               and en_tipo_enlace = 'N'
          end
       --Caso contrario se inserta un nuevo registro
       else
          begin 
            insert into cobis..ba_enlace_exec (en_sarta, en_batch_inicio, en_secuencial_inicio, 
                                               en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos)
            values (@i_sarta, 
                    @i_batch_inicio,
                    @i_secuencial_inicio,
                    @i_batch_fin,
                    @i_secuencial_fin,
                    @i_tipo_enlace,
                    @i_puntos)
          end

       if @@error <> 0 
        begin
        /* 'Error en Insercion del enlace' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808014
        return 1
        end 
     commit tran
   end


/* Actualizacion de registro */
if @t_trn = 8096 and @i_operacion = 'U'   
   begin
     begin tran 
        --Actualiza en tabla de ejecuci¢n
        update cobis..ba_enlace_exec
           set en_tipo_enlace = @i_tipo_enlace, 
               en_puntos      = @i_puntos
         where en_sarta = @i_sarta
           and en_batch_inicio = @i_batch_inicio
           and en_batch_fin = @i_batch_fin

   if @@error <> 0 
         begin
        /* 'Error en actualizacion del enlace' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808015
        return 1
         end   
     commit tran
   end


/* Eliminacion de registro */
if @t_trn = 8098 and @i_operacion = 'D'
   begin
     begin tran 
        delete cobis..ba_enlace_exec
         where en_sarta = @i_sarta
           and en_batch_inicio = @i_batch_inicio
           and en_batch_fin = @i_batch_fin

   if @@error <> 0 
         begin
        /* 'Error en eliminacion del enlace' */
        exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 808016
        return 1
         end   
     commit tran
   end

return 0
go
