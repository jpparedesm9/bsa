/************************************************************************/
/* Archivo:                sarta.sp                                     */
/* Stored procedure:       sp_sarta                                     */
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
/*    Mantenimiento a la sarta de procesos batch                        */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    22-Abr-1994    R. Garces       Emision Inicial                    */
/*    06-Jul-1999    D. Guerrero     CY2K-BATB204 Uso @i_formato_fecha  */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_sarta')
   drop proc sp_sarta

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_sarta   (
   @s_ssn        int = null,
   @s_date       datetime = null,
   @s_user       login = null,
   @s_term       descripcion = null,
   @s_corr       char(1) = null,
   @s_ssn_corr       int = null,
   @s_ofi        smallint = null,
   @t_rty            char(1) = null,
   @t_trn        smallint = null,
   @t_debug   char(1) = 'N',
   @t_file       varchar(14) = null,
   @t_from       varchar(30) = null,
   @i_operacion     char(1),
   @i_modo       smallint = null,
   @i_sarta   int = null,
   @i_nombre     descripcion = null,
   @i_descripcion    varchar(255) = null,
   @i_fecha_creacion datetime = null,
   @i_creador    descripcion = null,
   @i_sarta1         int = null,
   @i_sarta2     int = null,
   @i_batch   int = null,
   @i_producto   tinyint = null,
   @i_dependencia   smallint = null,
   @i_autorizacion     char(1) = null,
   @i_update_aut    char(1) = null, /* Para actualizar autorizacion */
   @i_all_aut    char(1) = null,  /* Para all de autorizaciones */
        @i_formato_fecha  int = null
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 
                      no existe = 0 */
        @w_flag_sarta     smallint,     /* Bandera para busqueda */ 
   @w_nombre_aux     descripcion,
   @w_sarta      int,
   @w_nombre         descripcion,
   @w_descripcion    varchar(255),
   @w_fecha_creacion char(10),
   @w_creador    descripcion,
   @w_producto   tinyint,
   @w_dproduct      descripcion,
   @w_dependencia      smallint,
   @w_secuencial    int,
   @w_salir   int

select @w_today = getdate()
select @w_sp_name = 'sp_sarta'


if (@t_trn <> 8011 and @i_operacion = 'I') or
   (@t_trn <> 8012 and @i_operacion = 'U') or
   (@t_trn <> 8013 and @i_operacion = 'D') or
   (@t_trn <> 8014 and @i_operacion = 'V') or
   (@t_trn <> 8015 and @i_operacion = 'S') or
   (@t_trn <> 8016 and @i_operacion = 'Q') or
   (@t_trn <> 8017 and @i_operacion = 'A') or
   (@t_trn <> 8072 and @i_operacion = 'X') 
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
   select @w_sarta = sa_sarta,
          @w_nombre = sa_nombre,
          @w_descripcion = sa_descripcion,
          @w_fecha_creacion = convert(char(10),sa_fecha_creacion,@i_formato_fecha),
          @w_creador = sa_creador,
          @w_producto = sa_producto,
          @w_dproduct = pd_descripcion,
          @w_dependencia = sa_dependencia
   from cobis..ba_sarta,cobis..cl_producto
   where sa_sarta = @i_sarta and
         sa_producto = pd_producto
   if @@rowcount = 0
      select @w_existe = 0
   else
      select @w_existe = 1
end

/* Insercion de la sarta */
/*************************/

if @i_operacion = 'I'
begin
   if @w_existe = 1 
   begin
      /* 'Codigo de sarta ya existe '*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801005
      return 1
   end

   /* Insercion del registro */
   /**************************/

   begin tran
      insert into cobis..ba_sarta
      (sa_sarta,sa_nombre,sa_descripcion,sa_fecha_creacion,
       sa_creador,sa_producto,sa_dependencia,sa_autorizacion)
      values (@i_sarta,@i_nombre,@i_descripcion,
         @i_fecha_creacion,@i_creador,@i_producto,@i_dependencia,'S')

      if @@error <> 0 
      begin
         /* 'Error en Insercion de la sarta       ' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803003
         return 1
      end
   /* Transaccion de servicio */
   insert into ts_sarta
   values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
      @i_sarta,@i_nombre,@i_descripcion,
      @i_fecha_creacion,@i_creador)
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

/* Actualizacion de la cuenta */

if @i_operacion = 'U'
begin
   if @w_existe = 0
   begin
      /* Codigo de la sarta a actulizar no existe */
      exec cobis..sp_cerror
      @t_debug = @t_debug, 
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 805014
      return 1
   end

   if @i_update_aut = 'S' 
   begin
      update ba_sarta
      set sa_autorizacion = @i_autorizacion
      where sa_sarta = @i_sarta
      if @@error <> 0
      begin
         /* Error en la actualizacion de la sarta */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 805034
         return 1
      end
      return 0
   end

        /* Actualizacion del registro */
   begin tran
      update cobis..ba_sarta
      set   sa_sarta          = @i_sarta,
            sa_nombre         = @i_nombre,
         sa_descripcion    = @i_descripcion,
         sa_fecha_creacion = @i_fecha_creacion,
         sa_creador    = @i_creador,
         sa_producto      = @i_producto,
         sa_dependencia   = @i_dependencia
      where   sa_sarta = @i_sarta
      
      if @@error <> 0
      begin
         /* Error en la actualizacion de la sarta */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 805034
         return 1
      end
      insert into ts_sarta
      values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
      @w_sarta,@w_nombre,@w_descripcion,
      @w_fecha_creacion,@w_creador)
      
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
      insert into ts_sarta
      values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
      @i_sarta,@i_nombre,@i_descripcion,
      @i_fecha_creacion,@i_creador)
      
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
       return 0
end

/* Eliminacion de la sarta */

if @i_operacion = 'D'
begin
   if @w_existe = 0
   begin
      /* Codigo de la sarta no existe */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807030
      return 1
   end

/* Integridad Referencial */

   if exists (select sb_sarta
        from cobis..ba_sarta_batch
           where sb_sarta = @i_sarta
           )
   begin
      /* Codigo de la sarta relacionado con sarta batch*/
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807031
      return 1
   end

   if exists (select pa_sarta
        from cobis..ba_parametro   
           where pa_sarta = @i_sarta
           )
   begin
      /* la sarta posee procesos con parametros */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807032
      return 1
   end

   begin tran
      delete cobis..ba_sarta
      where sa_sarta = @i_sarta

      if @@error <> 0
      begin
         /* Error en la eliminacion  de la sarta */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 807033
         return 1
      end

      insert into ts_sarta
      values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
      @w_sarta,@w_nombre,@w_descripcion,
      @w_fecha_creacion,@w_creador)
      
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
       return 0
end

/* Busqueda de registros */

if @i_operacion = 'S'
begin
   if @i_sarta1 is null or @i_sarta2 is null
      select @w_flag_sarta = 1
   else
      select @w_flag_sarta = 0
   if @i_nombre is null 
      select @w_nombre_aux = '%'
   else
      select @w_nombre_aux = @i_nombre

   set rowcount 20
   if @i_modo = 0
   begin
      select 'SARTA'=sa_sarta,
                       'Nombre'=substring(sa_nombre,1,40),         
             'FECHA'=convert(char(10),sa_fecha_creacion,@i_formato_fecha)
      from cobis..ba_sarta
      where ((sa_sarta >= @i_sarta1 and sa_sarta <= @i_sarta2) 
                      or (@w_flag_sarta = 1))
        and sa_nombre like @w_nombre_aux

      if @@rowcount = 0
      begin
         /* No existen sartas */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
      select 'SARTA'=sa_sarta,
             'NOMBRE'=substring(sa_nombre,1,40),         
             'FECHA'=convert(char(10),sa_fecha_creacion,@i_formato_fecha)
      from cobis..ba_sarta
      where ((sa_sarta >= @i_sarta1 and sa_sarta <= @i_sarta2) 
                      or (@w_flag_sarta = 1))
        and sa_nombre like @w_nombre_aux
        and sa_sarta > @i_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
   end
end

/* Busqueda de todos los registros */

if @i_operacion = 'A'
begin
        if @i_all_aut = 'S'
        begin
      set rowcount 20
      if @i_modo = 0
      begin
      select  'LOTE' = sa_sarta,
              'NOMBRE' = substring(sa_nombre,1,45),
              'DEPENDENCIA' = sa_dependencia,
              'AUTORIZACION' = sa_autorizacion
      from cobis..ba_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
      end
      if @i_modo = 1
      begin
      select  'LOTE' = sa_sarta,
              'NOMBRE' = substring(sa_nombre,1,45),
              'DEPENDENCIA' = sa_dependencia,
              'AUTORIZACION' = sa_autorizacion
      from cobis..ba_sarta
      where sa_sarta > @i_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
      end
            return 0
   end
   set rowcount 20
   if @i_modo = 0
   begin
      select  'LOTE' = sa_sarta,
              'NOMBRE' = sa_nombre,
              'DESCRIPCION' = sa_descripcion,
              'PRODUCTO' = sa_producto
      from cobis..ba_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
   end
   if @i_modo = 1
   begin
      select  'LOTE' = sa_sarta,
              'NOMBRE' = sa_nombre,
              'DESCRIPCION' = sa_descripcion,
              'PRODUCTO' = sa_producto
      from cobis..ba_sarta
      where sa_sarta > @i_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
   end
end

/* Busqueda por Query */

if @i_operacion = 'Q'
begin
   if @w_existe = 0
   begin
      /* No existen sartas */
      exec cobis..sp_cerror   
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801030
      return 1
   end
   select @w_sarta,@w_nombre,@w_descripcion,
          @w_fecha_creacion,@w_creador,@w_producto,@w_dproduct,@w_dependencia
   return 0
end

/* Seleccion por valor descripcion */

if @i_operacion = 'V'
begin

   if @w_existe = 0
   begin
      /* No existen sartas   */
      exec cobis..sp_cerror   
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 801030
      return 1
   end
   select @w_sarta,@w_nombre
   return 0
end

if @i_operacion = 'X'
begin
   select @w_producto = sa_producto
   from   cobis..ba_sarta
   where  sa_sarta = @i_sarta

      select @w_secuencial = max(sb_secuencial)
   from   cobis..ba_sarta_batch
   where  sb_sarta = @i_sarta

   select @w_salir = @w_secuencial + 1

   select @w_producto,@w_secuencial,@w_salir
end
      
/**** Busqueda de un determinado Producto ****/
if @i_operacion = 'P'
begin
set rowcount 20

      if @i_modo = 0
      begin
      select   'LOTE'=sa_sarta,
               'NOMBRE'=substring(sa_nombre,1,45),
               'DEPENDENCIA'=sa_dependencia,
               'AUTORIZACION'=sa_autorizacion
      from cobis..ba_sarta
                where sa_producto = @i_producto

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
      end

      if @i_modo = 1
      begin
      select   'LOTE'=sa_sarta,
               'NOMBRE'=substring(sa_nombre,1,45),
               'DEPENDENCIA'=sa_dependencia,
               'AUTORIZACION'=sa_autorizacion
      from cobis..ba_sarta
                where sa_producto = @i_producto
                and sa_sarta > @i_sarta

      if @@rowcount = 0
      begin
         /* No existen sartas   */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 801030
         return 1
      end
      set rowcount 0
      return 0
      end

end
go    
