/************************************************************************/
/* Archivo:                batch.sp                                     */
/* Stored procedure:       sp_batch                                     */
/* Base de datos:          cobis                                        */
/* Producto:               cobis                                        */
/* Disenado por:                                                        */
/* Fecha de escritura:     22-marzo-94                                  */
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
/*    Mantenimiento al batch                                            */
/************************************************************************/
/*                        MODIFICACIONES                                */
/*    FECHA          AUTOR           RAZON                              */
/*    22-Abr-1994    R. Garces       Emision Inicial                    */
/*    25-Jun-1999    D. Guerrero     Tipo @i_batch de int a smallint    */
/*    05-Jul-1999    D. Guerrero     CY2K BATA201 Uso @i_formato_fecha  */
/*    24-Jun-2002    G. Landazuri    Campo nuevo ba_batch               */
/*    26-Mar-2009    F. Ortega V.    Se cambia la consulta de reportes  */
/*                                   y oficinas autorizadas             */
/*    28-Jul-2011    S. Soto         Homologacion con SQL Server        */
/************************************************************************/



use cobis
go

if exists (select * from sysobjects where name = 'sp_batch')
   drop proc sp_batch

go
create proc sp_batch   (
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
   @i_operacion     char(1),
   @i_modo       smallint = null,
   @i_batch      int  = null,  /*DGU-07-01-1999*/
   @i_nombre         descripcion = null,
   @i_descripcion    varchar(255) = null,
   @i_lenguaje   char(2) = null,
   @i_fecha_creacion datetime = null,
   @i_producto   tinyint = null,
   @i_tipo_batch     char(1) = null,
   @i_sec_corrida    smallint = null,
   @i_ente_procesado descripcion = null,
   @i_arch_resultado descripcion = null, 
   @i_arch_fuente   descripcion = null,
        @i_frec_reg_proc  int = null,
   @i_batch1     int = null,
   @i_batch2     int = null,
   @i_rol        smallint = null,
   @i_login   varchar(10) = null,
   @i_impresora     varchar(255) = null,
        @i_formato_fecha  tinyint = null,  /*CY2K DGU-BATB201*/
        @i_serv_destino   varchar(24) = null ,
   @i_lote       int = null,
   @i_reproceso     char(1) = 'N' ,
   @i_path_fuente   varchar(255) = null,
   @i_path_destino     varchar(255) = null
)
as 
declare
   @w_today    datetime,   /* fecha del dia */
   @w_return   int,     /* valor que retorna */
   @w_sp_name  varchar(32),   /* descripcion del stored procedure*/
   @w_existe   int,     /* codigo existe = 1 
                      no existe = 0 */
        @w_flag_batch     tinyint,      /* Bandera para busqueda */ 
        @w_flag_producto  tinyint,
        @w_flag2_producto tinyint,
   @w_nombre_aux     descripcion,
   @w_tipo_batch_aux char(1),
   @w_batch      int,  /*DGU-07-01-1999*/
   @w_nombre         descripcion,
   @w_descripcion    varchar(255),
   @w_lenguaje   char(2),
   @w_fecha_creacion datetime,
   @w_producto   tinyint,
   @w_tipo_batch     char(1),
   @w_sec_corrida    smallint,
   @w_ente_procesado descripcion,
   @w_arch_resultado descripcion,
        @w_frec_reg_proc  int,
   @w_arch_fuente   descripcion,
        @w_impresora   varchar(255),
   @w_path_fuentes     varchar(255),
   @w_path_destino     varchar(255),
   @w_acceso     tinyint,
   @w_opcion_off_l     tinyint,
   @w_opcion_off_r     tinyint

select @w_today = getdate()
select @w_sp_name = 'sp_batch'

if @i_formato_fecha = 0
  select @i_formato_fecha = 103

if (@t_trn <> 8001 and @i_operacion = 'I') or
   (@t_trn <> 8002 and @i_operacion = 'U') or
   (@t_trn <> 8003 and @i_operacion = 'D') or
   (@t_trn <> 8004 and @i_operacion = 'V') or
   (@t_trn <> 8005 and @i_operacion = 'S') or
   (@t_trn <> 8006 and @i_operacion = 'Q') or
   (@t_trn <> 8007 and @i_operacion = 'A') or
   (@t_trn <> 8007 and @i_operacion = 'R') or
   (@t_trn <> 8007 and @i_operacion = 'H') or
   (@t_trn <> 8008 and @i_operacion = 'L') 
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
   select @w_batch = ba_batch,
          @w_nombre = ba_nombre,
          @w_descripcion = ba_descripcion,
          @w_lenguaje = ba_lenguaje,
          @w_fecha_creacion = ba_fecha_creacion,
          @w_producto = ba_producto,
          @w_tipo_batch = ba_tipo_batch,
          @w_sec_corrida = ba_sec_corrida,
          @w_ente_procesado = ba_ente_procesado,
          @w_arch_resultado = ba_arch_resultado,
          @w_arch_fuente = ba_arch_fuente,
          @w_frec_reg_proc = ba_frec_reg_proc,
          @w_impresora = ba_impresora
   from cobis..ba_batch
   where ba_batch = @i_batch
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
      /* 'Codigo de batch ya existe '*/
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 801004
      return 1
   end
   
   /* Insercion del registro */
   /**************************/
   begin tran
      insert into cobis..ba_batch
      (ba_batch, ba_nombre, ba_descripcion,
       ba_lenguaje, ba_fecha_creacion, ba_producto,
       ba_tipo_batch, ba_sec_corrida, ba_ente_procesado,              
       ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc,               
       ba_impresora, ba_serv_destino, ba_path_fuente,
       ba_path_destino, ba_reproceso)
      values (@i_batch,@i_nombre,@i_descripcion,
         @i_lenguaje,@i_fecha_creacion,
         @i_producto,@i_tipo_batch,
         @i_sec_corrida,@i_ente_procesado,
         @i_arch_resultado,@i_arch_fuente,@i_frec_reg_proc,
                        @i_impresora,@i_serv_destino, @i_path_fuente, 
         @i_path_destino, @i_reproceso)
      if @@error <> 0 
      begin
         /* 'Error en Insercion de batch' */
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file   = @t_file,
         @t_from   = @w_sp_name,
         @i_num    = 803002
         return 1
      end
   /* Transaccion de servicio */
   insert into ts_batch
   values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
      @i_batch,@i_nombre,@i_descripcion,@i_lenguaje,
      @i_fecha_creacion,@i_producto,@i_tipo_batch,
      @i_sec_corrida,@i_ente_procesado,@i_arch_resultado,
      @i_arch_fuente,@i_frec_reg_proc)
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
      update cobis..ba_batch  
      set   ba_batch          = @i_batch,
            ba_nombre         = @i_nombre,
         ba_descripcion    = @i_descripcion,
         ba_lenguaje      = @i_lenguaje,
         ba_fecha_creacion = @i_fecha_creacion,
         ba_producto   = @i_producto,
         ba_tipo_batch     = @i_tipo_batch,  
         ba_ente_procesado = @i_ente_procesado,
         ba_arch_resultado = @i_arch_resultado,
         ba_arch_fuente    = @i_arch_fuente,
         ba_frec_reg_proc  = @i_frec_reg_proc,
         ba_impresora      = @i_impresora,
                        ba_serv_destino   = @i_serv_destino,
         ba_reproceso     = @i_reproceso,
         ba_path_fuente   = @i_path_fuente,
         ba_path_destino     = @i_path_destino   
      where   ba_batch = @i_batch
      
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
      
      /* Actualización del campo sb_repeticion de la tabla ba_sarta_batch */
      update cobis..ba_sarta_batch
         set sb_repeticion = @i_reproceso
       where sb_batch = @i_batch
      
      /* Insertando la Transacción de Servicio */
      insert into ts_batch
      values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
      @w_batch,@w_nombre,@w_descripcion,@w_lenguaje,
      @w_fecha_creacion,@w_producto,@w_tipo_batch,
      @w_sec_corrida,@w_ente_procesado,@w_arch_resultado,
      @w_arch_fuente,@w_frec_reg_proc)
      
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
      @i_batch,@i_nombre,@i_descripcion,@i_lenguaje,
      @i_fecha_creacion,@i_producto,@i_tipo_batch,
      @i_sec_corrida,@i_ente_procesado,@i_arch_resultado,
      @i_arch_fuente,@i_frec_reg_proc)
      
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

   if exists (select pa_batch
        from cobis..ba_parametro       
           where pa_batch = @i_batch
           )
   begin
      /* Existen parametros para este batch */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807023
      return 1
   end

   if exists (select 1
        from cobis..ba_sarta_batch
           where sb_batch = @i_batch
           )
   begin
      /* Este programa esta relacionado a algun lote */
      exec cobis..sp_cerror
      @t_debug   = @t_debug,
      @t_file    = @t_file,
      @t_from    = @w_sp_name,
      @i_num      = 807027
      return 1
   end
   begin tran
      delete cobis..ba_batch
      where ba_batch = @i_batch

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
   
      delete ba_parametro
      where pa_sarta     = 0
      and   pa_batch     = @i_batch
      and   pa_ejecucion = 0
      
      insert into ts_batch
      values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
      @w_batch,@w_nombre,@w_descripcion,@w_lenguaje,
      @w_fecha_creacion,@w_producto,@w_tipo_batch,
      @w_sec_corrida,@w_ente_procesado,@w_arch_resultado,
      @w_arch_fuente,@w_frec_reg_proc)
      
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
   if @i_batch1 is null or @i_batch2 is null
      select @w_flag_batch = 1
   else
      select @w_flag_batch = 0
      
   if @i_producto is null 
      select @w_flag_producto = 1
   else
      select @w_flag_producto = 0
      
   if @i_nombre is null
      select @w_nombre_aux = '%'
   else
      select @w_nombre_aux = @i_nombre
      
   if @i_tipo_batch is null
      select @w_tipo_batch_aux = '%'
   else
      select @w_tipo_batch_aux = @i_tipo_batch

   set rowcount 20
   if @i_modo = 0
   begin
   
      select 'Batch'    = ba_batch,   'Nombre' = substring(ba_nombre,1,45),
             'Producto' = ba_producto,'Tipo'   = ba_tipo_batch
      from cobis..ba_batch
      where ((ba_batch >= @i_batch1 and ba_batch <= @i_batch2) 
                      or (@w_flag_batch = 1))
        and ((ba_producto = @i_producto) or (@w_flag_producto = 1))
        and ba_nombre like @w_nombre_aux
        and ba_tipo_batch like @w_tipo_batch_aux
        and (ba_arch_fuente like @i_arch_fuente or @i_arch_fuente is null)
        order by ba_batch asc

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
      select ba_batch,substring(ba_nombre,1,45),
             ba_producto,ba_tipo_batch
      from cobis..ba_batch
      where ((ba_batch >= @i_batch1 and ba_batch <= @i_batch2) 
                      or (@w_flag_batch = 1))
        and ((ba_producto = @i_producto) or (@w_flag_producto = 1))
        and ba_nombre like @w_nombre_aux
        and ba_tipo_batch like @w_tipo_batch_aux
        and ba_batch > @i_batch
        order by ba_batch asc

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
   /*SSO 28/07/2011, */
   if @i_modo = 3 -- es para buscar un batch especifico, siempre y cuando cumpla con el resto de condiciones de esta @i_operacion
   begin
      select ba_batch,substring(ba_nombre,1,45),
                       ba_producto,ba_tipo_batch
      from cobis..ba_batch
      where ((ba_batch >= @i_batch1 and ba_batch <= @i_batch2) 
                      or (@w_flag_batch = 1))
        and ((ba_producto = @i_producto) or (@w_flag_producto = 1))
        and ba_nombre like @w_nombre_aux
        and ba_tipo_batch like @w_tipo_batch_aux
        and ba_batch = @i_batch
        order by ba_batch asc

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


/* Busqueda de registros */

if @i_operacion = 'L'
begin
   if exists (select * from ba_lectura_reporte where lr_login = @i_login or lr_rol = @i_rol)
      select @w_acceso = 1 -- SI tiene acceso a lectura de reportes generados por batch
   else 
      select @w_acceso = 0

   if @w_acceso = 0
      begin
         -- ERROR NO TIENE ACCESO 
         /* No existen procesos */
         exec cobis..sp_cerror   
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 808058
         return 1
      end
   else
      begin
         if not exists (select * from ba_lectura_reporte where lr_login = @i_login)
           select @i_login = null --es para que tome lo que está autorizado directamente al rol y sin especificar usuario

         set rowcount 20
         if @i_modo = 0
         begin
            select 
               'Batch'     = a.ba_batch,
               'Nombre'    = substring(a.ba_nombre,1,45),
               'Producto'  = a.ba_producto,
               'Tipo'      = a.ba_tipo_batch,
               'Listado'   = substring(a.ba_arch_resultado,1,patindex('%.%',a.ba_arch_resultado)-1),
               'Path Destino'     = a.ba_path_destino,
               'Servidor Destino' = a.ba_serv_destino
            from  cobis..ba_batch a
            where a.ba_producto = @i_producto
              and a.ba_tipo_batch = @i_tipo_batch --R para reportes
              and exists (select * from ba_lectura_reporte b
                          where a.ba_batch = b.lr_batch
                            and (b.lr_rol = @i_rol and b.lr_login = @i_login)
                          )
              and patindex('%.%',a.ba_arch_resultado)>0
            order by a.ba_batch

         end

      if @i_modo = 1
      begin
         select 
            'Batch'     = a.ba_batch,
            'Nombre'    = substring(a.ba_nombre,1,45),
            'Producto'  = a.ba_producto,
            'Tipo'      = a.ba_tipo_batch,
            'Listado'   = substring(a.ba_arch_resultado,1,patindex('%.%',a.ba_arch_resultado)-1),
            'Path Destino'     = a.ba_path_destino,
            'Servidor Destino' = a.ba_serv_destino
         from  cobis..ba_batch a
         where a.ba_producto = @i_producto
           and a.ba_tipo_batch = @i_tipo_batch --R para reportes
           and exists (select * from ba_lectura_reporte b
                       where a.ba_batch = b.lr_batch
                         and (b.lr_rol = @i_rol and b.lr_login = @i_login)
                         and a.ba_batch > @i_batch
                       )
           and patindex('%.%',a.ba_arch_resultado)>0
           order by a.ba_batch

      end
   end -- if @w_acceso = 1

   -- CONSULTA DE OFICINAS PERMITIDAS
   if @w_acceso = 1
   begin

      set rowcount 0

      if exists (select * from ba_lectura_oficina where lo_login = @i_login)
          select distinct lo_oficina
          from  ba_lectura_oficina
          where (lo_rol = @i_rol   and   lo_login = @i_login)
          order by lo_oficina
      else
          select distinct lo_oficina
          from  ba_lectura_oficina
          where lo_rol = @i_rol
          order by lo_oficina
   end
   return
end


/* Busqueda de todos los registros */

if @i_operacion = 'A'
begin
   if @i_producto is null
      select @w_flag2_producto = 1
   else
      select @w_flag2_producto = 0

   set rowcount 20
   if @i_modo = 0
   begin
      select 'CODIGO' = ba_batch,
             'NOMBRE DE PROGRAMA' = ba_nombre
      from cobis..ba_batch
      where (ba_producto = @i_producto or @w_flag2_producto = 1)
      order by ba_batch

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
      select ba_batch,ba_nombre
      from cobis..ba_batch
      where (ba_producto = @i_producto or @w_flag2_producto = 1)
        and ba_batch > @i_batch
      order by ba_batch

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

/* Busqueda de todos los registros F5*/

if @i_operacion = 'R'
begin

   set rowcount 20
   if @i_modo = 0
   begin
      select 'CODIGO' = ba_batch, 
             'NOMBRE DE PROGRAMA' = ba_nombre
      from cobis..ba_batch                
      order by ba_batch

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
      select ba_batch,ba_nombre
      from cobis..ba_batch
      where ba_batch > @i_batch
      order by ba_batch

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

/* Busqueda de todos los registros de un lote especifico  F5*/

if @i_operacion = 'H'
begin
    set rowcount 0
    select distinct
        tmp_batch = ba_batch, 
        tmp_nombre = ba_nombre, 
        tmp_secuencial=identity(int)
    into #tmp_01
    from cobis..ba_sarta_batch, cobis..ba_batch
    where (sb_sarta = @i_lote or @i_lote is null)  -- para retornar todos los programas existentes o de un lote específico
      and ba_batch = sb_batch
    order by ba_batch

    set rowcount 20
    select  'CODIGO' = tmp_batch, 
            'NOMBRE DE PROGRAMA' = tmp_nombre, 
            'SECUENCIAL' = tmp_secuencial
      from #tmp_01
     where tmp_secuencial > @i_batch1 or @i_batch1 is null -- cuando @i_batch1 es diferente de null equivale a buscar sigueintes

    if @@rowcount = 0
    begin           /* No existen procesos */
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


/* Busqueda por Query */

if @i_operacion = 'Q'
begin
   select   ba_batch,   
      ba_nombre,  
      ba_descripcion,
      ba_lenguaje,
      valor,         -- 5
            convert(char(10),ba_fecha_creacion,@i_formato_fecha),
      ba_producto,
      pd_descripcion,
            ba_tipo_batch, 
      ba_ente_procesado,   -- 10
      ba_arch_resultado,   
      ba_arch_fuente,   
      ba_frec_reg_proc,
                  ba_impresora,
      ba_serv_destino,  -- 15
      ba_reproceso,
      ba_path_fuente,
      ba_path_destino   
      
   from  cobis..ba_batch,
      cobis..cl_tabla,
      cobis..cl_catalogo,
         cobis..cl_producto
   where ba_batch = @i_batch
     and cobis..cl_tabla.tabla = 'ba_lenguaje'
     and cobis..cl_catalogo.codigo = ba_lenguaje
     and cobis..cl_tabla.codigo = cobis..cl_catalogo.tabla
     and pd_producto = ba_producto

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

   if @i_lote is not null
   begin
      select sa_nombre
      from  ba_sarta
      where sa_sarta = @i_lote

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
   end
   return 0
end

/* Seleccion por valor descripcion */

if @i_operacion = 'V'
begin
   select ba_batch,ba_nombre
   from cobis..ba_batch
   where ba_batch = @i_batch

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
   return 0
end

/**** Busqueda de un determinado Producto ****/
if @i_operacion = 'P'
begin


      if @i_modo = 0
      begin
      select ba_batch,ba_nombre
      from cobis..ba_batch
      where ba_producto = @i_producto

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

go

      
      
