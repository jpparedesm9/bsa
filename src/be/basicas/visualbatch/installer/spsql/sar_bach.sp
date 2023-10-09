/************************************************************************/
/* Archivo:                sar_bach.sp                                  */
/* Stored procedure:       sp_sar_bach                                  */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     22-Marzo-1994                                */
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
/*       Mantenimiento a la tabla sarta_batch                           */
/*       para las operaciones de creacion y eliminacion                 */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    22-Mar-1994      R. Garces       Emision Inicial                  */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_sarta_batch')
   drop proc sp_sarta_batch

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_sarta_batch   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = 802,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1),
   @i_modo       smallint = null,
   @i_sarta   int = null,
   @i_batch   int = null,
   @i_secuencial     smallint = null,
   @i_dependencia    smallint = null,
   @i_repeticion     char(1) = null,
   @i_critico        char(1) = 'N',
   @i_habilitado     char(1) = 'S',    /* 'S' habilitado por default */
   @i_update_rep       char(1) = null, /* 'S' si modifica repeticion */
   @i_update_cri       char(1) = null  /* 'S' si modifica critico    */
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 
                      no existe = 0 */
   @w_sarta      int,
   @w_batch   int,
   @w_secuencial    smallint,
   @w_dependencia    smallint

select @w_today = getdate()
select @w_sp_name = 'sp_sarta_batch'


if (@t_trn <> 8021 and @i_operacion = 'I') or
   (@t_trn <> 8022 and @i_operacion = 'U') or
   (@t_trn <> 8023 and @i_operacion = 'D') or
   (@t_trn <> 8025 and @i_operacion = 'S') or
   (@t_trn <> 8027 and @i_operacion = 'V') or
   (@t_trn <> 8027 and @i_operacion = 'A') 
begin
   /* Tipo de transaccion no corresponde */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 801077
   return 1
end


/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A' 
begin
   select @w_sarta      = sb_sarta,
          @w_batch      = sb_batch,
          @w_secuencial = sb_secuencial,
          @w_dependencia= sb_dependencia

   from cobis..ba_sarta_batch
   where sb_sarta      = @i_sarta
     and sb_secuencial = @i_secuencial

   if @@rowcount = 0
      select @w_existe = 0
   else
      select @w_existe = 1
end

/* Insercion de la sarta */
/*************************/

if @i_operacion = 'I'
begin

  CREATE TABLE #tparametro    (
   tp_sarta       int NOT NULL,
   tp_batch       int NOT NULL, /*DGU-07-02-1999*/
   tp_ejecucion         smallint NOT NULL,
   tp_parametro                     smallint NOT NULL,
   tp_nombre         varchar(64) NULL,
   tp_tipo           char(1) NOT NULL,
   tp_valor       varchar(64) NULL
) 
       
   if not exists  (select ba_batch
      from ba_batch
      where ba_batch = @i_batch)
   begin
      /* 'Codigo de batch no existe '*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801042
      return 1
   end

   if not exists  (select sa_sarta
      from ba_sarta
      where sa_sarta = @i_sarta)
   begin
      /* 'Codigo de sarta no existe '*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801043
      return 1
   end
   if @i_dependencia is not null
   begin
      if not exists  (select sb_secuencial
         from ba_sarta_batch
         where sb_sarta = @i_sarta
         and sb_secuencial = @i_dependencia
         and sb_secuencial < @i_secuencial
         )
      begin
      /* ' Codigo de dependencia no existe o no es inferior' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 801078
         return 1
      end
   end

   if exists  (select sb_secuencial
      from ba_sarta_batch
      where sb_sarta = @i_sarta
        and sb_secuencial = @i_secuencial)
   begin
           begin tran
              update cobis..ba_sarta_batch 
                 set sb_secuencial = sb_secuencial + 1000
               where sb_sarta = @i_sarta
                 and sb_secuencial >= @i_secuencial
              update cobis..ba_sarta_batch 
                 set sb_secuencial = sb_secuencial - 999
               where sb_sarta = @i_sarta
                 and sb_secuencial >= @i_secuencial
              update cobis..ba_parametro
                 set pa_ejecucion = pa_ejecucion + 1000
               where pa_sarta = @i_sarta
                 and pa_ejecucion >= @i_secuencial
              update cobis..ba_parametro
                 set pa_ejecucion = pa_ejecucion - 999    
               where pa_sarta = @i_sarta
                 and pa_ejecucion >= @i_secuencial
              update cobis..ba_sarta_batch
                 set sb_dependencia = sb_dependencia + 1
               where sb_sarta = @i_sarta
                 and sb_dependencia >= @i_secuencial
           commit tran
   end

   /* Insercion del registro */
   /**************************/

   begin tran
      insert into cobis..ba_sarta_batch
      (sb_sarta,sb_batch,sb_secuencial,sb_dependencia,sb_repeticion,sb_critico,sb_habilitado)
      values (@i_sarta,@i_batch,@i_secuencial,@i_dependencia,@i_repeticion,@i_critico,@i_habilitado)

      if @@error <> 0 
      begin
         /* 'Error en Insercion de la sarta_batch  ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803030
         return 1
      end

   /* Creacion automatica de parametros default para la sarta batch */
                insert into #tparametro
                select *
                from   ba_parametro
                where  pa_sarta = 0
                  and  pa_batch = @i_batch
                  and  pa_ejecucion  = 0

                update #tparametro
                set    tp_sarta = @i_sarta,
                       tp_ejecucion  = @i_secuencial

                insert into ba_parametro
                select *
                from   #tparametro

   /* Transaccion de servicio */
   insert into ts_sarta_batch
   values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
      @i_sarta,@i_batch,@i_secuencial,@i_dependencia)
   if @@error <> 0
   begin
      /* Error en la insercion de transaccion de servicio */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 803032
      return 1
   end
   commit tran 
   return 0
end

/* Eliminacion de la sarta */

if @i_operacion = 'D'
begin
  begin tran
    if @i_modo <> 1
    begin 
   if @w_existe = 0
   begin
      /* Codigo de la sarta_batch no existe */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807040
      return 1
   end


   if exists (select sb_secuencial
         from ba_sarta_batch
         where sb_dependencia = @i_secuencial
                     and sb_sarta = @i_sarta)
   begin
   /* Existen procesos batch que dependen del registro a eliminar */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807044
      return 1
   end

      delete cobis..ba_sarta_batch
      where sb_sarta      = @i_sarta
        and sb_batch      = @i_batch
        and sb_secuencial = @i_secuencial

      if @@error <> 0
      begin
         /* Error en la eliminacion  de la sarta_batch */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 807041
         return 1
      end
      
      update ba_sarta_batch
      set sb_secuencial = sb_secuencial - 1
      where sb_sarta = @i_sarta
        and sb_secuencial > @i_secuencial

      if @@error <> 0
      begin
         /* Error en la actualizacion de los registros */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 807042
         return 1
      end

                delete ba_parametro
      where pa_batch = @i_batch and pa_sarta = @i_sarta
        and pa_ejecucion = @i_secuencial

                update ba_parametro
                set    pa_ejecucion = pa_ejecucion - 1
                where  pa_sarta     = @i_sarta
                  and  pa_ejecucion > @i_secuencial

              update cobis..ba_sarta_batch
                 set sb_dependencia = sb_dependencia - 1
               where sb_sarta = @i_sarta
                 and sb_dependencia > @i_secuencial

      insert into ts_sarta_batch
      values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
      @w_sarta,@w_batch,@w_secuencial,@w_dependencia)
      
                if @@error <> 0
      begin
         /* Error en la insercion de transaccion de servicio*/
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 803032
         return 1
      end
    end
    else
    begin
    delete ba_sarta_batch
    where sb_sarta = @i_sarta
    and   sb_secuencial >= @i_secuencial

    delete  ba_parametro
    where pa_sarta = @i_sarta
    and   pa_ejecucion >= @i_secuencial
    end
  commit tran
return 0
end

/* Busqueda de todos los registros */

if @i_operacion = 'A'
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select 
         'BATCH'  = ba_batch,
         'NOMBRE'    = ba_nombre,
         'DEPENDENCIA'  = sb_dependencia,
         'REPETICION'   = sb_repeticion,
         'LEFT'      = sb_left,
         'TOP'       = sb_top,
         'LOTE ORIGEN'  = sb_lote_inicio,
         'SECUENCIAL'   = sb_secuencial
      from  cobis..ba_batch,
         cobis..ba_sarta_batch
      where sb_sarta    = @i_sarta 
                  and   sb_batch    = ba_batch
      order by    
         sb_secuencial 

      if @@rowcount = 0
      begin
         /* No existen batch asociados a esta sarta */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801031
         return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
      select
         'BATCH'  = ba_batch,
         'NOMBRE'    = ba_nombre,
         'DEPENDENCIA'  = sb_dependencia,
         'REPETICION'   = sb_repeticion,
         'LEFT'      = sb_left,
         'TOP'       = sb_top,
         'LOTE ORIGEN'  = sb_lote_inicio,
         'SECUENCIAL'   = sb_secuencial
      from  cobis..ba_batch,  
         cobis..ba_sarta_batch
      where    sb_sarta    = @i_sarta 
                  and   sb_batch    = ba_batch
        and    sb_secuencial  > @i_secuencial
      order by 
         sb_secuencial

      if @@rowcount = 0
      begin
         /* No existen mas batch  */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801032
         return 1
      end
      set rowcount 0
      return 0
   end
end

if @i_operacion = 'U'
begin 
   if @w_existe = 0
   begin
      /* Codigo de la sarta_batch no existe */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807040
      return 1
   end
        if @i_update_rep = 'S'
        begin
            update ba_sarta_batch
      set   sb_repeticion = @i_repeticion
      where sb_sarta = @i_sarta
        and sb_secuencial = @i_secuencial

      if @@error <> 0
      begin
         /* Error en la actualizacion del registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 805035
         return 1
      end
      return 0
   end
        if @i_update_cri = 'S'
        begin
            update ba_sarta_batch
      set   sb_critico    = @i_critico
      where sb_sarta = @i_sarta
        and sb_secuencial = @i_secuencial

      if @@error <> 0
      begin
         /* Error en la actualizacion del registro */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 805035
         return 1
      end
      return 0
   end
   if @i_dependencia is not null
   begin
      if not exists  (select sb_secuencial
         from ba_sarta_batch
         where sb_sarta = @i_sarta
         and sb_secuencial = @i_dependencia
         and sb_secuencial < @i_secuencial
         )
      begin
      /* ' Codigo de dependencia no existe o no es inferior' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 801078
         return 1
      end

   end
        
   /* Actualizacion del registro */
   begin tran
   update ba_sarta_batch
   set sb_sarta = @i_sarta,
       sb_batch = @i_batch,
       sb_secuencial = @i_secuencial,
       sb_dependencia = @i_dependencia,
       sb_repeticion = @i_repeticion
   where sb_sarta = @i_sarta                                 
          and sb_batch = @i_batch
          and sb_secuencial = @i_secuencial
   
   if @@error <> 0
   begin
      /* Error en la actualizacion del registro */
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 805035
      return 1
   end
   insert into ts_sarta_batch
   values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
   @w_sarta,@w_batch,@w_secuencial,@w_dependencia)

        if @@error <> 0
   begin
      /* Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 803032
      return 1
   end

   insert into ts_sarta_batch
   values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
   @i_sarta,@i_batch,@i_secuencial,@i_dependencia)

        if @@error <> 0
   begin
      /* Error en la insercion de transaccion de servicio*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 803032
      return 1
   end
       commit tran
end


if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select sb_sarta,sb_batch,sb_secuencial,sb_dependencia,
         ba_arch_fuente,ba_arch_resultado,ba_lenguaje
      from cobis..ba_sarta_batch,cobis..ba_batch
      where sb_sarta = @i_sarta and
         sb_batch = ba_batch
      
      if @@rowcount = 0
      begin
         return 1
      end
   end
   else begin
      select sb_sarta,sb_batch,sb_secuencial,sb_dependencia
         ba_arch_fuente,ba_arch_resultado,ba_lenguaje
      from cobis..ba_sarta_batch,cobis..ba_batch
      where sb_sarta = @i_sarta and
         sb_secuencial > @i_secuencial and
         sb_batch = ba_batch
      
      if @@rowcount = 0
      begin
         return 1
      end
   end
   return 0

end

/*   Verificacion de un proceso especifico en la sarta    */

if @i_operacion = 'V'
begin
    select ba_nombre
      from cobis..ba_sarta_batch, cobis..ba_batch
     where sb_sarta = @i_sarta
       and sb_batch = @i_batch
       and ba_batch = sb_batch   

    if @@rowcount = 0
    begin    /*    El codigo del lote_batch no existe   */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 807040
        return 1
    end
    return 0
end

go


      
