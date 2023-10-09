/************************************************************************/
/* Archivo:                paramet.sp                                   */
/* Stored procedure:       sp_parametro1                                */
/* Base de datos:          cobis                                        */
/* Producto:               batch                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     30-Marzo-1994                                */
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
/*    Este programa procesa las transacciones de:                       */
/*    Mantenimiento de la tabla ba_parametro                            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    30-Mar-1994    G. Jaramillo    Emision Inicial                    */
/*    12-Jun-2002    S. Soto         Cambios en campo pa_valor          */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_parametro1')
   drop proc sp_parametro1  

go
create proc sp_parametro1  (
   @s_ssn            int = null,
   @s_date           datetime = null,
   @s_user           login = null,
   @s_term           descripcion = null,
   @s_corr           char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi            smallint = null,
   @t_rty            char(1) = null,
   @t_trn            smallint = 601,
   @t_debug          char(1) = 'N',
   @t_file           varchar(14) = null,
   @t_from           varchar(30) = null,
   @i_operacion      char(1),
   @i_modo           smallint = null,
   @i_sarta          int = null,
   @i_batch          int = null,
   @i_ejecucion      smallint = null,
   @i_parametro      smallint = null,
   @i_nombre         descripcion = null,
   @i_tipo           char(1) = null,
   @i_valor          varchar(255) = null,
   @i_formato_fecha  int = 103
)
as 
declare
   @w_today       datetime,   /* fecha del dia */
   @w_return      int,     /* valor que retorna */
   @w_sp_name     varchar(32),   /* nombre del stored procedure*/
   @w_siguiente   tinyint,
   @w_sarta       int,
   @w_batch       int,
   @w_ejecucion   smallint,
   @w_parametro   smallint,
   @w_nombre      descripcion,
   @w_tipo        char(1) ,
   @w_valor       varchar(255) ,   --SSO 12/06/2002 Upgrade Batch
   @w_aux1        descripcion ,
   @w_aux2        descripcion ,
   @w_count       int,
   @w_existe      int      /* codigo existe = 1 
                              no existe = 0 */
select @w_today = getdate()
select @w_sp_name = 'sp_parametro1'

/************************************************/
/*  Tipo de Transaccion = 803          */

if (@t_trn <> 8031 and @i_operacion = 'I') or
   (@t_trn <> 8032 and @i_operacion = 'U') or
   (@t_trn <> 8033 and @i_operacion = 'D') or
   (@t_trn <> 8035 and @i_operacion = 'S') or
   (@t_trn <> 8036 and @i_operacion = 'Q') 
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 601077
   return 1
end
/************************************************/


/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
   select  @w_sarta  = pa_sarta,
      @w_batch    = pa_batch,
      @w_ejecucion   = pa_ejecucion,
      @w_parametro   = pa_parametro,
      @w_nombre   = pa_nombre,
      @w_tipo  = pa_tipo,
      @w_valor    = pa_valor 
   from cobis..ba_parametro
   where pa_sarta = @i_sarta and
      pa_batch = @i_batch and
      pa_ejecucion = @i_ejecucion and
      pa_parametro = @i_parametro   

   if @@rowcount > 0
      select @w_existe = 1 
   else
      select @w_existe = 0

end


/* Insercion de parametro */
/*************************/

if @i_operacion = 'I'
begin

   if @w_existe = 1 
      begin
         /* 'Codigo de parametro ya existe           ' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 801007
         return 1
      end
   
   /* Insercion del registro */
   /**************************/

   begin tran

   insert into cobis..ba_parametro
      (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,
      pa_nombre,pa_tipo,pa_valor)
      values (@i_sarta,@i_batch,@i_ejecucion,@i_parametro,
         @i_nombre,@i_tipo,@i_valor)
      if @@error <> 0 
      begin
         /* 'Error en insercion de parametro  ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803004
         return 1
      end

      /****************************************/
      /* TRANSACCION DE SERVICIO    */

    insert into ts_batch_param (
      secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina,
      sarta, batch, ejecucion, parametro, nombre, tipo, valor)
    values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
      @i_sarta,@i_batch,@i_ejecucion,@i_parametro,
      @i_nombre,@i_tipo,@i_valor)

    if @@error <> 0
       begin
         /* 'Error en insercion de transaccion de servicio' */
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 803032
         return 1
       end
 
    if @i_sarta = 0 and @i_ejecucion = 0
       begin
          declare cursor_programas cursor
             for select sb_sarta,sb_secuencial
                   from cobis..ba_sarta_batch
                  where sb_batch = @i_batch
          for update

          /* Insertar en todos los lotes existentes */
          open cursor_programas
                fetch cursor_programas into @w_sarta,@w_ejecucion
          while (@@fetch_status = 0)
                begin
                   insert into cobis..ba_parametro
                          (pa_sarta,pa_batch,pa_ejecucion,pa_parametro,
                           pa_nombre,pa_tipo,pa_valor)
                   values (@w_sarta,@i_batch,@w_ejecucion,@i_parametro,
                           @i_nombre,@i_tipo,@i_valor)
          if @@error <> 0 
             begin
                /* 'Error en insercion de parametro  ' */
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file   = @t_file,
                     @t_from   = @w_sp_name,
                     @i_num    = 803004
                return 1
             end
                   fetch cursor_programas into @w_sarta,@w_ejecucion
       end   
       close cursor_programas
       deallocate  cursor_programas
   end
   commit tran
   return 0
end


/* Actualizacion de parametro  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
   if @w_existe = 0 
      begin
         /* 'Codigo de Parametro a actualizar NO existe'*/
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 805015
         return 1
      end

   /*  Actualizacion del registro  */
   /********************************/

   begin tran
      update cobis..ba_parametro
      set   pa_nombre = @i_nombre,
         pa_tipo   = @i_tipo,
         pa_valor  = @i_valor 
      where    pa_sarta  = @i_sarta and
         pa_batch  = @i_batch and
         pa_ejecucion = @i_ejecucion and
         pa_parametro = @i_parametro

      if @@error <> 0
         begin
            /* 'Error en Actualizacion de parametro    '*/ 
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 805016
            return 1
         end

      /****************************************/
      /* TRANSACCION DE SERVICIO    */

      insert into ts_batch_param(
         secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina,
         sarta, batch, ejecucion, parametro, nombre, tipo, valor)    
      values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
         @w_sarta,@w_batch,@w_ejecucion,@w_parametro,
         @w_nombre,@w_tipo,@w_valor)

      if @@error <> 0
         begin
            /* 'Error en insercion de transaccion de servicio' */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 803032
            return 1
         end
      
      insert into ts_batch_param(
         secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina,
         sarta, batch, ejecucion, parametro, nombre, tipo, valor)    
      values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
         @i_sarta,@i_batch,@i_ejecucion,@i_parametro,
         @i_nombre,@i_tipo,@i_valor)

      if @@error <> 0
         begin
            /* 'Error en insercion de transaccion de servicio' */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file   = @t_file,
                 @t_from   = @w_sp_name,
                 @i_num    = 803032
            return 1
         end

      if @i_sarta = 0 and @i_ejecucion = 0
         begin
          /* Eliminar en todos los lotes existentes */
          declare cursor_programas cursor
             for select sb_sarta,sb_secuencial
                   from cobis..ba_sarta_batch
                  where sb_batch = @i_batch
          for update

          open cursor_programas
                fetch cursor_programas into @w_sarta,@w_ejecucion
          while (@@fetch_status = 0)
                begin
                   update cobis..ba_parametro
                    set   pa_nombre = @i_nombre,
                          pa_tipo   = @i_tipo,
                          pa_valor  = @i_valor            
                    where pa_sarta  = @w_sarta and
                          pa_batch  = @i_batch and
                          pa_ejecucion = @w_ejecucion and
                          pa_parametro = @i_parametro
                   if @@error <> 0 
                      begin
                         /* 'Error en insercion de parametro  ' */
                         exec cobis..sp_cerror  
                              @t_debug = @t_debug,
                              @t_file   = @t_file,
                              @t_from   = @w_sp_name,
                              @i_num    = 807026
                         return 1
                      end

                   fetch cursor_programas into @w_sarta,@w_ejecucion
                end   
          close cursor_programas
          deallocate  cursor_programas
        end

   commit tran
   return 0
end


/* Eliminacion de parametro  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
   if @w_existe = 0 
      begin
         /* 'Codigo de Parametro a eliminar NO existe ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 807025
      return 1
   end


   /*  Eliminacion del registro  */
   /********************************/

   begin tran
      delete cobis..ba_parametro
      where pa_sarta = @i_sarta and
         pa_batch = @i_batch and
         pa_ejecucion = @i_ejecucion and
         pa_parametro = @i_parametro 

      if @@error <> 0
      begin
         /* 'Error en Eliminacion de parametro ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 807026
         return 1
      end

      update cobis..ba_parametro
      set pa_parametro = pa_parametro - 1
      where pa_sarta = @i_sarta and
         pa_batch = @i_batch and
         pa_ejecucion = @i_ejecucion and
         pa_parametro > @i_parametro


      if @@error <> 0
      begin
         /* 'Error en Eliminacion de parametro ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 807026
         return 1
      end

   /****************************************/
   /* TRANSACCION DE SERVICIO    */

   insert into ts_batch_param(
      secuencial, tipo_transaccion, clase, fecha, usuario, terminal, oficina,
      sarta, batch, ejecucion, parametro, nombre, tipo, valor)
      values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
         @w_sarta,@w_batch,@w_ejecucion,@w_parametro,
         @w_nombre,@w_tipo,@w_valor)

   if @@error <> 0
   begin
      /* 'Error en insercion de transaccion de servicio' */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 803032
      return 1
   end

     if @i_sarta = 0 and @i_ejecucion = 0
        begin
          /* Eliminar en todos los lotes existentes */
           declare cursor_programas cursor
              for select sb_sarta,sb_secuencial
                    from cobis..ba_sarta_batch
                   where sb_batch = @i_batch
           for update

          open cursor_programas
          fetch cursor_programas into @w_sarta,@w_ejecucion
          while (@@fetch_status = 0)
                begin
                  delete cobis..ba_parametro
                   where pa_sarta = @w_sarta and
                         pa_batch = @i_batch and
                         pa_ejecucion = @w_ejecucion and
                         pa_parametro = @i_parametro 
                  if @@error <> 0 
                     begin
                       /* 'Error en insercion de parametro  ' */
                       exec cobis..sp_cerror
                            @t_debug = @t_debug,
                            @t_file   = @t_file,
                            @t_from   = @w_sp_name,
                            @i_num    = 807026
                       return 1
                     end
                  update cobis..ba_parametro
                  set pa_parametro = pa_parametro - 1
                    where pa_sarta = @w_sarta and
                          pa_batch = @i_batch and
                      pa_ejecucion = @w_ejecucion and
                      pa_parametro > @i_parametro

                   fetch cursor_programas into @w_sarta,@w_ejecucion
           end   
           close cursor_programas
           deallocate  cursor_programas
        end
        commit tran
    return 0
end


/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
   select   @w_count = count(*)
   from  cobis..ba_parametro
        where   pa_sarta        = @i_sarta  and
                pa_batch        = @i_batch and
                pa_ejecucion    = @i_ejecucion

   set rowcount 20 
   if @i_modo = 0 begin
      if @w_count > 0 
      begin
         select   'NOMBRE' = substring(pa_nombre,1,35),
                  'TIPO' = pa_tipo,
                  'VALOR' = case pa_tipo 
                            when 'D' then convert(varchar(10),convert(datetime,pa_valor),@i_formato_fecha) 
                            else substring(pa_valor,1,64)  
                            end
         from  cobis..ba_parametro
         where pa_sarta  = @i_sarta  
           and pa_batch = @i_batch 
           and pa_ejecucion = @i_ejecucion
         order by pa_parametro
         
         if @@rowcount = 0
         begin
            /* 'No existen parametros  '*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 801008
            set rowcount 0
            return 1
         end
      end
      else   
      begin
         select  'NOMBRE' = substring(pa_nombre,1,35),
                 'TIPO'   = pa_tipo,
                 'VALOR'  = case pa_tipo 
                            when 'D' then convert(varchar(10),convert(datetime,pa_valor),@i_formato_fecha) 
                            else substring(pa_valor,1,64)  
                            end
           from  cobis..ba_parametro
          where  pa_sarta = 0
            and  pa_batch = @i_batch 
            and  pa_ejecucion = 0
                  order by    
            pa_parametro

         if @@rowcount = 0
         begin
            /* 'No existen parametros  '*/
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 801008
            set rowcount 0
            return 1
         end
      end
      set rowcount 0
      return 0
   end

   if @i_modo = 1
   begin
      if @w_count > 0 
      begin
         select 'NOMBRE' = substring(pa_nombre,1,35),
                'TIPO' = pa_tipo,
                'VALOR' = case pa_tipo 
                          when 'D' then convert(varchar(10),convert(datetime,pa_valor),@i_formato_fecha) 
                          else substring(pa_valor,1,64)  
                          end 
         from  cobis..ba_parametro
         where pa_sarta = @i_sarta 
           and pa_batch = @i_batch 
           and pa_ejecucion = @i_ejecucion 
           and pa_parametro > @i_parametro
         order by 
            pa_parametro
                     
         if @@rowcount = 0
                     begin
            /* 'No existen mas parametros ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 801009
            set rowcount 0
            return 1
         end
      end
      else  
      begin
        select 'NOMBRE' = substring(pa_nombre,1,35),
               'TIPO' = pa_tipo,
               'VALOR' = case pa_tipo 
                            when 'D' then convert(varchar(10),convert(datetime,pa_valor),@i_formato_fecha) 
                            else substring(pa_valor,1,64)  
                            end
          from cobis..ba_parametro
         where pa_sarta = 0 and
               pa_batch = @i_batch and
               pa_ejecucion = 0 and
               pa_parametro    > @i_parametro
         order by
               pa_parametro

        if @@rowcount = 0
          begin
            /* 'No existen mas parametros ' */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file   = @t_file,
            @t_from   = @w_sp_name,
            @i_num    = 801009
            set rowcount 0
            return 1
         end
      end
      set rowcount 0
      return 0
   end
end

if @i_operacion = 'Q'
begin
   select   pa_valor
   from cobis..ba_parametro
   where   pa_sarta = @i_sarta and
      pa_batch = @i_batch and
      pa_ejecucion = @i_ejecucion
   order by pa_parametro

   if @@rowcount = 0
   begin
      return 1
   end
   return 0
end

go

