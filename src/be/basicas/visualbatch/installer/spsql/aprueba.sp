/************************************************************************/
/* Archivo:                aprueba.sp                                   */
/* Stored procedure:       sp_aprueba                                   */
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
/*    Mantenimiento al registro de aprobaciones d parametros            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    25-Abr-2002    G. Jaramillo    Emision Inicial                    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_aprueba')
   drop proc sp_aprueba

go

create proc sp_aprueba   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = 800,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1) = null,
   @i_modo       smallint = null,
   @i_sarta      int  = null,  /*DGU-07-01-1999*/
   @i_sarta1     int  = null,  /*DGU-07-01-1999*/
   @i_fecha1         datetime = null,
   @i_fecha2         datetime = null,
   @i_login   descripcion = null,
   @i_login1     descripcion = null,
   @i_valor   descripcion = null,
        @i_formato_fecha  tinyint = null  /*CY2K DGU-BATB201*/ 

)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 */
   @w_sarta      int,  /*DGU-07-01-1999*/
        @w_fecha  datetime,
   @w_login descripcion,
        @w_impresora   varchar(255)

select @w_today = getdate()
select @w_sp_name = 'sp_aprueba'
select @w_sarta = @i_sarta
select @w_fecha = @i_fecha1

if (@t_trn <> 8085 and @i_operacion = 'I') or
   (@t_trn <> 8086 and @i_operacion = 'U') or
   (@t_trn <> 8087 and @i_operacion = 'D') or
   (@t_trn <> 8084 and @i_operacion = 'S') or
   (@t_trn <> 8088 and @i_operacion = 'F') or
   (@t_trn <> 8089 and @i_operacion = 'Q') 
  
   
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

   select @w_sarta = ap_sarta, 
          @w_login = ap_login, 
          @w_fecha = ap_fecha
   from cobis..ba_aprobacion
   where ap_sarta = @w_sarta
        and   ap_fecha = @w_fecha

   if @@rowcount = 0
      select @w_existe = 0
   else
      select @w_existe = 1


end

/* Insercion de batch */
/*************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1 
   begin
   /* Actualizacion del registro */
   /**************************/

   begin tran
      
                update cobis..ba_aprobacion set ap_login = @i_login 
      where ap_sarta = @w_sarta
         and   ap_fecha = @w_fecha

      if @@error <> 0 
      begin
         /* 'Error en Actualizacion de batch       ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug, 
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808008
         return 1
      end
   commit tran 
   return 0
   end
   
   /* Insercion del registro */
   /**************************/

   begin tran
      insert into cobis..ba_aprobacion (ap_sarta,ap_fecha,ap_login)
      values (@i_sarta,@i_fecha1,@i_login)
      if @@error <> 0 
      begin
         /* 'Error en Insercion de batch       ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug, 

         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 808008
         return 1
      end
   commit tran 
   return 0
end

/* Actualizacion de la cuenta  
*/

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
      /* Codigo del batch a actulizar no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug, 
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 805013
      return 1
   end
        /* Actualizacion del registro */
   begin tran
      update cobis..ba_aprobacion   
      set   ap_sarta          = @i_sarta,
            ap_fecha          = @i_fecha1,
         ap_login          = @i_login 
      where   ap_sarta = @i_sarta
      and     ap_fecha = @i_fecha1
      
      if @@error <> 0 

      begin
         /* Error en la actualizacion del batch */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 805033
         return 1
      end
/*
      insert into ts_aprobacion
      values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
      @w_sarta,@w_fecha,@w_login)
      
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
      insert into ts_batch
      values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
      @w_sarta,@w_fecha,@w_login)
      
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
*/
       commit tran
       return 0
end

/* Eliminacion de batch */

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
      /* Codigo del batch no existe */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807021
      return 1
   end

/* Integridad Referencial */

   begin tran
      delete cobis..ba_aprobacion
      where ap_sarta = @i_sarta
      and   ap_fecha = @i_fecha1

      if @@error <> 0
      begin
         /* Error en la eliminacion batch */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 807024
         return 1
      end

       commit tran
       return 0
end

/* Busqueda de registros */

if @i_operacion = 'S'
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select 'Lote'=ap_sarta,
             'Nombre'=substring(sa_nombre,1,45),
             'Fecha' =ap_fecha,
             'Login' =ap_login
      from cobis..ba_aprobacion, cobis..ba_sarta
      where (ap_sarta = @i_sarta or @i_sarta is null) and
                       ap_sarta = sa_sarta and
                      (ap_fecha between @i_fecha1 and @i_fecha2) and
                      (ap_login = @i_login or @i_login is null)
      order by ap_sarta, ap_fecha, ap_login

      if @@rowcount = 0
      begin
         /* No existen procesos */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801029
    
      return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
      select 'Lote'=ap_sarta,
             'Nombre'=substring(sa_nombre,1,45),
             'Fecha' =ap_fecha,
             'Login' =ap_login
      from cobis..ba_aprobacion, cobis..ba_sarta
      where ((ap_sarta = @i_sarta or @i_sarta is null) and
                       ap_sarta = sa_sarta and
                      (ap_fecha between @i_fecha1 and @i_fecha2) and
                      (ap_login = @i_login or @i_login is null) and
                      (ap_login > @i_login1 and @i_login is null)) or
                      ((ap_sarta = @i_sarta or @i_sarta is null) and
                       (ap_sarta > @i_sarta1 and @i_sarta is null) and
                        ap_sarta = sa_sarta and
                        ap_fecha between @i_fecha1 and @i_fecha2)
      
      order by ap_sarta, ap_fecha, ap_login

      if @@rowcount = 0
      begin
         /* No existen procesos */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801029
         return 1
      end
      set rowcount 0
      return 0
   end
end

if @i_operacion = 'F'
begin
   begin tran
       update cobis..ba_parametro
       set pa_valor = @i_valor
       where pa_sarta = @i_sarta
       and   pa_tipo = 'D'

       if @@error <> 0
       begin
            /* Error en la actualizacion del batch */
            exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 805033
            return 1
  
       end
   commit tran
       return 0
end

if @i_operacion = 'Q'
begin
   select ap_login
   from ba_aprobacion
   where ap_sarta = @i_sarta and
              ap_fecha  = @i_fecha1
     
        return 0
end
                             
go
