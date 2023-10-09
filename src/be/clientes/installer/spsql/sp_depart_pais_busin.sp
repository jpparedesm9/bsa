USE cob_pac
GO
IF OBJECT_ID ('dbo.sp_depart_pais_busin') IS NOT NULL
	DROP PROCEDURE dbo.sp_depart_pais_busin
GO

create proc sp_depart_pais_busin  (
    @s_ssn             int   = NULL,
    @s_user            login = NULL,
    @s_sesn            int = NULL,
    @s_term            varchar(32) = NULL,
    @s_date            datetime = NULL,
    @s_srv             varchar(30) = NULL,
    @s_lsrv            varchar(30) = NULL, 
    @s_rol             smallint = NULL,
    @s_ofi             smallint = NULL,
    @s_org_err         char(1) = NULL,
    @s_error           int = NULL,
    @s_sev             tinyint = NULL,
    @s_msg             descripcion = NULL,
    @s_org             char(1) = NULL,
    @t_debug           char(1) = 'N',
    @t_file            varchar(14) = null,
    @t_from            varchar(32) = null,
    @t_trn             smallint =NULL,
    @t_show_version    bit         = 0,
    @i_operacion       varchar(2),
    @i_modo            tinyint = null,
    @i_departamento    catalogo = null,
    @i_mnemonico       catalogo = NULL,
    @i_descripcion     descripcion = null,
    @i_pais            smallint = null,
    @i_estado          estado  = NULL,
    @i_tipo            CHAR(5) = null,
    @i_valor           varchar(64) = NULL, -- Criterio para la busqueda
    @i_rowcount     tinyint = 20
)
as
declare @w_today   datetime,
    @w_sp_name     varchar(32),
    @w_mnemonico   catalogo,
    @w_descripcion descripcion,
    @w_pais        smallint,
    @w_estado      estado,
    @w_transaccion int,
    @w_codigo      int,
    @v_descripcion descripcion,
    @v_pais        smallint,
    @v_estado      estado,
    @w_return      int,
    @w_codigo_c    varchar(10),
    @v_mnemonico   catalogo,
    @w_numerror    int          --guarda num de errror


select    @w_today=@s_date,
          @w_sp_name = 'sp_depart_pais'
    
if @t_show_version = 1
begin
    print 'Stored procedure %1 !, Version 4.0.0.3'+ @w_sp_name
    return 0
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 15393 
begin
  /* Verificacion de claves foraneas */
  select @w_codigo = null
    from cobis..cl_pais
   where pa_pais = @i_pais 
  if @@rowcount = 0
  begin
     exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 101018
       /*    'No existe pais'*/
     return 1
  end

  if exists (select dp_departamento  from cobis..cl_depart_pais
             where dp_departamento = @i_departamento )
  begin
     exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 157939
       /*    'Ya existe departamento ' */
     return 1
  end

  begin tran
     /* Insert cobis..cl_depart_pais */
     insert into cobis..cl_depart_pais (dp_departamento ,dp_mnemonico,dp_descripcion,
                                 dp_pais,dp_estado)
           values (@i_departamento, @i_mnemonico,@i_descripcion,
                    @i_pais, 'V')
     if @@error <> 0
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103004
          /* 'Error en creacion de departamento'*/
    return 1
     end
     /* transaccion servicio - provincia */

     insert into cobis..ts_depart_pais (secuencia, tipo_transaccion, clase, fecha,
                  oficina_s, usuario, terminal_s, srv, lsrv,
                 departamento, descripcion, mnemonico, pais, estado)
     values (@s_ssn, 15393, 'N', @s_date,
             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
             @i_departamento, @i_descripcion, @i_mnemonico,@i_pais, 'V')     
         
     if @@error <> 0
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
         /* 'Error en creacion de transaccion de servicios'*/
      return 1
     end
  commit tran

    /* Actualizacion de la los datos en el catalogo */
           select @w_codigo_c = convert(varchar(10), @i_departamento)
    exec @w_return = cobis..sp_catalogo
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
        @i_tabla             = 'cobis..cl_depart_pais',
        @i_codigo            = @w_codigo_c,
        @i_descripcion       = @i_descripcion,
        @i_estado            = 'V'    
    if @w_return <> 0
        return @w_return

      return 0
end
else
begin
    exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 15394
begin
  /* Verificacion de claves foraneas */

   select @w_codigo = null
    from cobis..cl_pais
   where pa_pais = @i_pais 
  if @@rowcount = 0
  begin
     exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 101018
       /*    'No existe pais'*/
     return 1
  end

  select @w_mnemonico    = dp_mnemonico,
         @w_descripcion  = dp_descripcion,
         @w_pais         = dp_pais,
         @w_estado       = dp_estado
    from cobis..cl_depart_pais
   where dp_departamento = @i_departamento

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
        if exists (
            select *
              from cobis..cl_provincia
             where pv_depart_pais = @i_departamento
              )
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file        = @t_file,
                @t_from        = @w_sp_name,
                @i_num        = 101072
              --/* Existe referencia en ciudad*/
            return 1
        end      
    end
    else
    begin
        if exists (
            select * 
              from cobis..cl_pais
             where pa_pais = @i_pais
                           and pa_estado = 'C'
              )
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file        = @t_file,
                @t_from        = @w_sp_name,
                @i_num        = 101074
              /* Pais no vigente */
            return 1
        end
    end
    select @w_estado = @i_estado
  end

  begin tran
     /* Update cobis..cl_depart_pais */
     update cobis..cl_depart_pais
     set    dp_descripcion = @i_descripcion,
            dp_mnemonico   = @i_mnemonico,
            dp_pais        = @i_pais,
            dp_estado      = @i_estado 
     where  dp_departamento = @i_departamento 
     if @@error <> 0
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 105038
        /* 'Error en actualizacion de departamento '*/
    return 1
     end
     /* transaccion servicios - cobis..cl_depart_pais */
     insert into cobis..ts_depart_pais (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
                   departamento, descripcion, mnemonico, pais, estado)
     values (@s_ssn, 15394, 'P', @s_date,
         @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
         @i_departamento,@v_descripcion, @v_mnemonico,@v_pais,@v_estado)
     if @@error <> 0
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
         /* 'Error en creacion de transaccion de servicios'*/
    return 1
     end

     insert into cobis..ts_depart_pais (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
                   departamento, descripcion, mnemonico, pais, estado)
     values (@s_ssn, 15394, 'A', @s_date,
             @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,    
			 --@i_departamento,@v_descripcion, @v_mnemonico,@v_pais,@v_estado)--Inc65758
             @i_departamento,@w_descripcion, @w_mnemonico,@w_pais,@w_estado)
     if @@error <> 0
     begin
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
       /* 'Error en creacion de transaccion de servicios'*/
    return 1
     end
  commit tran

           select @w_codigo_c = convert(varchar(10), @i_departamento)
    exec @w_return = cobis..sp_catalogo
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
        @i_tabla             = 'cobis..cl_depart_pais',
        @i_codigo            = @w_codigo_c,
        @i_descripcion       = @i_descripcion,
        @i_estado            = @i_estado    
    if @w_return <> 0
        return @w_return

      return 0
end
else
begin
    exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 15395
begin
     set rowcount 20 -- PES
     if @i_modo = 0
     select  'CODIGO'      = dp_departamento,
             'DESCRIPCION' = dp_descripcion,
             'PAIS'        = dp_pais,
             'DESCR PAIS'  = pa_descripcion,
             'ESTADO'      = dp_estado,
             'MNEMONICO'   = dp_mnemonico
     from cobis..cl_depart_pais,cobis..cl_pais
     where dp_pais = pa_pais
       AND (Upper(dp_departamento) like @i_departamento +'%' or @i_departamento is null)
       AND (Upper(dp_descripcion)  like @i_descripcion +'%' or @i_descripcion is null)
     ORDER BY dp_departamento 
     else
    if @i_modo = 1
     select  'CODIGO'      = dp_departamento,
             'DESCRIPCION' = dp_descripcion,
             'PAIS'        = dp_pais,
             'DESCR PAIS'  = pa_descripcion,
             'ESTADO'      = dp_estado,
             'MNEMONICO'   = dp_mnemonico
     from cobis..cl_depart_pais,cobis..cl_pais
     where dp_pais = pa_pais
     AND (Upper(dp_descripcion)  like @i_descripcion +'%' or @i_descripcion is null)
     AND   dp_departamento > @i_departamento
     ORDER BY dp_departamento    
   
     if @@rowcount = 0
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 101000
      /*    'No existe dato en catalogo'*/
     set rowcount 0
     return 0
end
else
begin
    exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end

/* Query */

if @i_operacion = 'Q'
begin
if @t_trn = 15395
begin
     set rowcount 13
     if @i_modo = 0
     select  'CODIGO'      = dp_departamento,
             'DESCRIPCION' = dp_descripcion,
             'PAIS'        = dp_pais,
             'DESCR PAIS'  = pa_descripcion,
             'ESTADO'      = dp_estado,
             'MNEMONICO'   = dp_mnemonico
     from cobis..cl_depart_pais,cobis..cl_pais
     where dp_pais = pa_pais
     ORDER BY dp_departamento 
     else
    if @i_modo = 1
     select  'CODIGO'      = dp_departamento,
             'DESCRIPCION' = dp_descripcion,
             'PAIS'        = dp_pais,
             'DESCR PAIS'  = pa_descripcion,
             'ESTADO'      = dp_estado,
             'MNEMONICO'   = dp_mnemonico
     from cobis..cl_depart_pais,cobis..cl_pais
     where dp_pais = pa_pais
     AND   dp_departamento > @i_departamento
     ORDER BY dp_departamento   
     if @@rowcount = 0
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 101000
      /*    'No existe dato en catalogo'*/
     set rowcount 0
     return 0
end
else
begin
    exec cobis..sp_cerror
       @t_debug     = @t_debug,
       @t_file     = @t_file,
       @t_from     = @w_sp_name,
       @i_num     = 151051
       /*  'No corresponde codigo de transaccion' */
    return 1
end
end
/* ** Help ** */
if @i_operacion = 'H'
begin
if @t_trn = 15395
begin
    if @i_tipo = 'A'
    begin
    set rowcount @i_rowcount
    if @i_modo = 0    /* los primeros 20 */
        select  'CODIGO'      = dp_departamento,
                'DESCRIPCION' = dp_descripcion,
                'PAIS'        = dp_pais,
                'DESCR PAIS'  = pa_descripcion
        from cobis..cl_depart_pais,cobis..cl_pais
        where dp_pais = pa_pais
        and   pa_estado = 'V'
        and   dp_estado = 'V'
        and   dp_pais   = @i_pais
        AND (Upper(dp_departamento) like @i_departamento +'%' or @i_departamento is null)
        AND (Upper(dp_descripcion)  like @i_descripcion +'%' or @i_descripcion is null)
        order by dp_pais,dp_departamento 
     
    else
    if @i_modo = 1   /* los siguientes 20 */
        select  'CODIGO'      = dp_departamento,
                'DESCRIPCION' = dp_descripcion,
                'PAIS'        = dp_pais,
                'DESCR PAIS'  = pa_descripcion
        from cobis..cl_depart_pais,cobis..cl_pais
        where dp_pais = pa_pais
        and   pa_estado = 'V'
        and   dp_estado = 'V'
        and   dp_pais   = @i_pais
        and dp_departamento > @i_departamento
        AND (Upper(dp_descripcion)  like @i_descripcion +'%' or @i_descripcion is null)
        order by dp_pais,dp_departamento 
    set rowcount 0
    return 0
    end

    if @i_tipo = 'V'
    begin
        select  convert(char(30),dp_descripcion)
        from cobis..cl_depart_pais,cobis..cl_pais
        where dp_pais = pa_pais
        and   pa_estado = 'V'
        and   dp_estado = 'V'
        and   dp_pais   = @i_pais
        and   dp_departamento = @i_departamento
        
        if @@rowcount = 0
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 101038
            return 1 
        end
        return 0
    end
    
    /*Controla mensajes de error*/
    if @i_departamento = null
       select @w_numerror = 101038
    else
       select @w_numerror = 151121
    
    /*Busqueda de departamentos por descripcion*/
    if @i_tipo = 'Q'
    begin
    set rowcount @i_rowcount
        select  'CODIGO'      = dp_departamento,
                'DESCRIPCION' = dp_descripcion,
                'PAIS'        = dp_pais,
                'DESCR PAIS'  = pa_descripcion
        from cobis..cl_depart_pais,cobis..cl_pais
        where dp_pais = pa_pais
        and   pa_estado = 'V'
        and   dp_estado = 'V'
        and   dp_pais   = @i_pais
        and   (dp_descripcion  like @i_valor or @i_valor=null)
        and   (dp_departamento > @i_departamento or @i_departamento = null)
        order by dp_departamento,dp_pais  
        if @@rowcount = 0
        begin
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = @w_numerror
            return 1 
        end
    set rowcount 0
    return 0
    end    
    
end 
end

GO

