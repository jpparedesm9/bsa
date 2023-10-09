/************************************************************************/
/*  Archivo           : depart_pais.sp                                  */
/*  Stored procedure  : sp_depart_pais                                  */
/*  Base de datos     : cobis                                           */
/*  Producto          : Administrador                                   */
/*  Disenado por      : Xavier Almache                                  */
/*  Fecha de escritura: 25-Feb-2015                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/*              PROPOSITO                                               */
/*  Este programa procesa las transacciones del stored procedure        */
/*  Busqueda de departamento geografico                                 */
/*              MODIFICACIONES                                          */
/*  FECHA        AUTOR        RAZON                                     */
/*  25-Feb-15    X.Almache    Emision Inicial                           */
/*  08-Jul-15    J.Guamani    Opcion de busqueda 'Q'                    */
/*  21-Feb-18    ALFNSI       Correcciones migracion                    */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_depart_pais')
   drop proc sp_depart_pais 
go

create proc sp_depart_pais  (
       @s_ssn             int         = null,
       @s_user            login       = null,
       @s_sesn            int         = null,
       @s_term            varchar(32) = null,
       @s_date            datetime    = null,
       @s_srv             varchar(30) = null,
       @s_lsrv            varchar(30) = null, 
       @s_rol             smallint    = null,
       @s_ofi             smallint    = null,
       @s_org_err         char(1)     = null,
       @s_error           int         = null,
       @s_sev             tinyint     = null,
       @s_msg             descripcion = null,
       @s_org             char(1)     = null,
       @t_debug           char(1)     = 'N',
       @t_file            varchar(14) = null,
       @t_from            varchar(32) = null,
       @t_trn             smallint    = null,
       @t_show_version    bit         = 0,
       @i_operacion       varchar(2),
       @i_modo            tinyint     = null,
       @i_departamento    catalogo    = null,
       @i_mnemonico       catalogo    = null,
       @i_descripcion     descripcion = null,
       @i_pais            smallint    = null,
       @i_estado          estado      = null,
       @i_tipo            char(5)     = null,
       @i_valor           varchar(64) = null -- Criterio para la busqueda
)
as
declare @w_today          datetime,
        @w_sp_name        varchar(32),
        @w_mnemonico      catalogo,
        @w_descripcion    descripcion,
        @w_pais           smallint,
        @w_estado         estado,
        @w_transaccion    int,
        @w_codigo         int,
        @v_descripcion    descripcion,
        @v_pais           smallint,
        @v_estado         estado,
        @w_return         int,
        @w_codigo_c       varchar(10),
        @v_mnemonico      catalogo,
        @w_numerror       int          --guarda num de errror


select @w_today=@s_date,
       @w_sp_name = 'sp_depart_pais'
    
if @t_show_version = 1
begin
   print 'Stored procedure %1!, Version 4.0.0.3'+ @w_sp_name
   return 0
end

-- Valida codigo de transaccion
if  (@t_trn !=  15395 or @i_operacion not in ('S','Q','H'))
and (@t_trn !=  15393 or @i_operacion     != 'I')
and (@t_trn !=  15394 or @i_operacion     != 'U')
begin
   select @w_return  = 151051
   goto ERROR
end

/* ** Insert ** */
if @i_operacion = 'I'
begin

   /* Verificacion de claves foraneas */
   select @w_codigo = null
     from cl_pais
    where pa_pais = @i_pais 
    
   if @@rowcount = 0
   begin
      select @w_return  = 101018
      goto ERROR
   end
   
   if exists (select dp_departamento  
              from   cl_depart_pais
              where  dp_departamento = @i_departamento )
   begin
      select @w_return  = 157939
      goto ERROR
   end
   
   begin tran
      /* Insert cl_depart_pais */
      insert into cl_depart_pais 
             (dp_departamento, dp_mnemonico,dp_descripcion,
              dp_pais,         dp_estado)
      values (@i_departamento, @i_mnemonico,@i_descripcion,
              @i_pais,         'V')
              
      if @@error != 0
      begin
         select @w_return  = 103004
         goto ERROR
      end
      
      /* transaccion servicio - provincia */
      insert into ts_depart_pais 
             (secuencia,       tipo_transaccion, clase,       fecha,
              oficina_s,       usuario,          terminal_s,  srv,     lsrv,
              departamento,    descripcion,      mnemonico,   pais,    estado)
      values (@s_ssn,          15393,            'N',         @s_date,
              @s_ofi,          @s_user,          @s_term,     @s_srv,  @s_lsrv,
              @i_departamento, @i_descripcion,   @i_mnemonico,@i_pais, 'V')     
          
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   /* Actualizacion de la los datos en el catalogo */
   select @w_codigo_c = convert(varchar(10), @i_departamento)
   exec @w_return = sp_catalogo
        @s_ssn               = @s_ssn,
        @s_user              = @s_user,
        @s_sesn              = @s_sesn,
        @s_term              = @s_term,    
        @s_date              = @s_date,    
        @s_srv               = @s_srv,    
        @s_lsrv              = @s_lsrv,    
        @s_rol               = @s_rol,
        @s_ofi               = @s_ofi,
        @s_org_err           = @s_org_err,
        @s_error             = @s_error,
        @s_sev               = @s_sev,
        @s_msg               = @s_msg,
        @s_org               = @s_org,
        @t_debug             = @t_debug,    
        @t_file              = @t_file,
        @t_from              = @w_sp_name,
        @t_trn               = 584,
        @i_operacion         = 'I',
        @i_tabla             = 'cl_depart_pais',
        @i_codigo            = @w_codigo_c,
        @i_descripcion       = @i_descripcion,
        @i_estado            = 'V'    
       
   if @w_return != 0
      return @w_return
end

/* ** Update ** */
if @i_operacion = 'U'
begin
   /* Verificacion de claves foraneas */

   select @w_codigo = null
   from   cl_pais
   where  pa_pais = @i_pais 
   
   if @@rowcount = 0
   begin
      select @w_return  = 101018
      goto ERROR
   end

   select @w_mnemonico    = dp_mnemonico,
          @w_descripcion  = dp_descripcion,
          @w_pais         = dp_pais,
          @w_estado       = dp_estado
   from   cl_depart_pais
   where  dp_departamento = @i_departamento

   select @v_mnemonico    = @w_mnemonico
   select @v_descripcion  = @w_descripcion
   select @v_pais         = @w_pais
   select @v_estado       = @w_estado

   if @w_mnemonico = @i_mnemonico
      select @w_mnemonico = null, @v_mnemonico = null
   else
      select @w_mnemonico = @i_mnemonico
   if @w_descripcion = @i_descripcion
      select @w_descripcion = null, @v_descripcion = null
   else
      select @w_descripcion = @i_descripcion
   if @w_pais = @i_pais
      select @w_pais = null, @v_pais = null
   else
      select @w_pais = @i_pais
   if @w_estado = @i_estado
      select @w_estado = null, @v_estado = null
   else
   begin
      if @i_estado = 'C'
      begin
         if exists (select *
                    from   cl_provincia
                    where  pv_depart_pais = @i_departamento)
         begin
            select @w_return  = 101072
            goto ERROR
         end      
      end
      else
      begin
         if exists (select * 
                    from   cl_pais
                    where  pa_pais   = @i_pais
                    and    pa_estado = 'C')
         begin
            select @w_return  = 101074
            goto ERROR
         end
      end
      select @w_estado = @i_estado
   end

   begin tran
      /* Update cl_depart_pais */
      update cl_depart_pais
      set    dp_descripcion = @i_descripcion,
             dp_mnemonico   = @i_mnemonico,
             dp_pais        = @i_pais,
             dp_estado      = @i_estado 
      where  dp_departamento = @i_departamento 
      
      if @@error != 0
      begin
         select @w_return  = 105038
         goto ERROR
      end
      
      /* transaccion servicios - cl_depart_pais */
      insert into ts_depart_pais 
             (secuencia,       tipo_transaccion, clase,        fecha,
              oficina_s,       usuario,          terminal_s,   srv,     lsrv,
              departamento,    descripcion,      mnemonico,    pais,    estado)
      values (@s_ssn,          15394,            'P',          @s_date, 
              @s_ofi,          @s_user,          @s_term,      @s_srv,  @s_lsrv,    
              @i_departamento, @v_descripcion,   @v_mnemonico, @v_pais, @v_estado)
              
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
      
      insert into ts_depart_pais 
             (secuencia,       tipo_transaccion, clase,       fecha,
              oficina_s,       usuario,          terminal_s,  srv,       lsrv,
              departamento,    descripcion,      mnemonico,   pais,      estado)
      values (@s_ssn,          15394,            'A',         @s_date,
              @s_ofi,          @s_user,          @s_term,     @s_srv,    @s_lsrv,    
              @i_departamento, @v_descripcion,  @v_mnemonico, @v_pais,   @v_estado)
      if @@error != 0
      begin
         select @w_return  = 103005
         goto ERROR
      end
   commit tran

   select @w_codigo_c = convert(varchar(10), @i_departamento)
   exec @w_return = sp_catalogo
        @s_ssn               = @s_ssn,
        @s_user              = @s_user,
        @s_sesn              = @s_sesn,
        @s_term              = @s_term,    
        @s_date              = @s_date,    
        @s_srv               = @s_srv,    
        @s_lsrv              = @s_lsrv,    
        @s_rol               = @s_rol,
        @s_ofi               = @s_ofi,
        @s_org_err           = @s_org_err,
        @s_error             = @s_error,
        @s_sev               = @s_sev,
        @s_msg               = @s_msg,
        @s_org               = @s_org,
        @t_debug             = @t_debug,    
        @t_file              = @t_file,
        @t_from              = @w_sp_name,
        @t_trn               = 585,
        @i_operacion         = 'U',
        @i_tabla             = 'cl_depart_pais',
        @i_codigo            = @w_codigo_c,
        @i_descripcion       = @i_descripcion,
        @i_estado            = @i_estado    
        
   if @w_return != 0
      return @w_return
end

/* Search */
if @i_operacion = 'S'
begin
   set rowcount 20 -- PES
   select 'CODIGO'      = dp_departamento,
          'DESCRIPCION' = dp_descripcion,
          'PAIS'        = dp_pais,
          'DESCR PAIS'  = pa_descripcion,
          'ESTADO'      = dp_estado,
          'MNEMONICO'   = dp_mnemonico
   from   cl_depart_pais,cl_pais
   where  dp_pais          = pa_pais
   and    ((dp_departamento > @i_departamento and  @i_modo = 1) or @i_modo = 0)
   order by dp_departamento 
    
   if @@rowcount = 0
   begin
      select @w_return  = 101000
      goto ERROR
   end
end

/* Query */

if @i_operacion = 'Q'
begin
   set rowcount 13
 
   select 'CODIGO'      = dp_departamento,
          'DESCRIPCION' = dp_descripcion,
          'PAIS'        = dp_pais,
          'DESCR PAIS'  = pa_descripcion,
          'ESTADO'      = dp_estado,
          'MNEMONICO'   = dp_mnemonico
   from   cl_depart_pais,
          cl_pais
   where  dp_pais          = pa_pais
   and    ((dp_departamento > @i_departamento and @i_modo = 1) or @i_modo = 0)
   order by dp_departamento 
  
   if @@rowcount = 0
   begin
      set rowcount 0
      select @w_return  = 101000
      goto ERROR
   end
   set rowcount 0
end

/* ** Help ** */
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
      set rowcount 20
      select  'CODIGO'      = dp_departamento,
              'DESCRIPCION' = dp_descripcion,
              'PAIS'        = dp_pais,
              'DESCR PAIS'  = pa_descripcion
      from    cl_depart_pais,
              cl_pais
      where   dp_pais          = pa_pais
      and     pa_estado        = 'V'
      and     dp_estado        = 'V'
      and     dp_pais          = @i_pais
      and     ((dp_departamento > @i_departamento and @i_modo = 1) or @i_modo = 0)
      order by dp_pais,dp_departamento 
   
      set rowcount 0
      return 0
   end

   if @i_tipo = 'V'
   begin
      select  convert(char(30),dp_descripcion)
      from    cl_depart_pais,
              cl_pais
      where   dp_pais         = pa_pais
      and     pa_estado       = 'V'
      and     dp_estado       = 'V'
      and     dp_pais         = @i_pais
      and     dp_departamento = @i_departamento
      
      if @@rowcount = 0
      begin
         select @w_return  = 101038
         goto ERROR
      end
      return 0
   end
    
    /*Controla mensajes de error*/
    if @i_departamento is null
       select @w_numerror = 101038
    else
       select @w_numerror = 151121
    
    /*Busqueda de departamentos por descripcion*/
    if @i_tipo = 'Q'
    begin
      set rowcount 20
      select  'CODIGO'      = dp_departamento,
              'DESCRIPCION' = dp_descripcion,
              'PAIS'        = dp_pais,
              'DESCR PAIS'  = pa_descripcion
      from cl_depart_pais,cl_pais
      where dp_pais             = pa_pais
      and   pa_estado           = 'V'
      and   dp_estado           = 'V'
      and   dp_pais             = @i_pais
      and   (dp_descripcion  like @i_valor        or @i_valor        is null)
      and   (dp_departamento    > @i_departamento or @i_departamento is null)
      
      order by dp_departamento,dp_pais  
      if @@rowcount = 0
      begin
         select @w_return  = @w_numerror
         goto ERROR
      end
      set rowcount 0
   end    
end
return 0

ERROR:
   set rowcount 0
   exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = @w_return
   /*  'No corresponde codigo de transaccion' */
   return @w_return
go
