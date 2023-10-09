use cob_pac
go

if exists (select 1 from sysobjects where name = 'sp_parametro_busin')
   drop proc sp_parametro_busin
go

create proc sp_parametro_busin (
    @s_ssn            int           = NULL,
    @s_user           login         = NULL,
    @s_sesn           int           = NULL,
	@s_term           varchar(32)   = NULL,
	@s_date           datetime      = NULL,
    @s_srv            varchar(30)   = NULL,
    @s_lsrv           varchar(30)   = NULL, 
    @s_rol            smallint      = NULL,     
    @s_ofi            smallint      = NULL,
    @s_org_err        char(1)       = NULL,
    @s_error          int           = NULL,
    @s_sev            tinyint       = NULL,
    @s_msg            descripcion   = NULL,
    @s_org            char(1)       = NULL,
    @t_debug          char(1)       = 'N',
    @t_file           varchar(14)   = null,
    @t_from           varchar(32)   = null, 
    @t_trn            smallint      = NULL,
    @t_show_version   bit           = 0, -- Mostrar la versi¢n del programa
    @i_operacion      char(2),
    @i_modo           tinyint       = null,
    @i_parametro      descripcion   = null,
    @i_nemonico       catalogo      = null,
    @i_tipo           char(1)       = null,
    @i_char           varchar(30)   = null,
    @i_tinyint        tinyint       = null,
    @i_smallint       smallint      = null,
    @i_int            int           = null,
    @i_money          money         = null,  
    @i_datetime       datetime      = null,
    @i_float          float         = null,
    @i_producto       char(3)       = NULL,
    @i_formato_fecha  int           = 101,
    @i_valor          varchar(30)   = NULL,
    @i_criterio       tinyint       = 0,
    @i_rowcount       smallint      = 20
    
)
as

declare  
        @w_return           int,
        @w_sp_name          varchar(32),
        @w_parametro        descripcion,
        @w_nemonico         catalogo,
        @w_tipo             char(1),
        @w_char             char(1),
        @w_tinyint          tinyint,
        @w_smallint         smallint,
        @w_int              int,
        @w_money            money,
        @w_datetime         datetime,
        @w_float            float,
        @w_producto         char(3),
        @v_parametro        descripcion,
        @v_nemonico         catalogo,
        @v_tipo             char(1),
        @v_char             char(1),
        @v_tinyint          tinyint,
        @v_smallint         smallint,
        @v_int              int,
        @v_money            money,
        @v_datetime         datetime, 
        @v_float            float,
        @v_producto         char(3),
        @w_tldc             tinyint,
        @w_valor_parametro  varchar(64),
        @o_nombre_parametro varchar(64), 
        @o_tipo_parametro   varchar(1), 
        @o_valor_parametro  varchar(10)


        
select @w_sp_name  = 'sp_parametro_busin',
       @i_rowcount = isnull(@i_rowcount,20)

if @t_show_version = 1
begin
     print 'Stored procedure sp_parametro_busin, Version 4.0.0.1'
    return 0
end

/*** Tamanio de longitud para descripcion de catalogos ****/

     select @w_tldc=pa_tinyint
     from cobis..cl_parametro
     where pa_producto='ADM' and
     pa_nemonico='TLDC'
     
     if @@rowcount=0
     begin
          /*   No existe Par metro General  */
          select @w_tldc = 60
     end

/********************************************************/


/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 576
begin

  /* comprobar que no exista parametros duplicados */
     if exists ( select *     
               from cobis..cl_parametro    
              where    pa_nemonico = @i_nemonico and pa_producto = @i_producto)
     begin
    /* 'Parametro duplicado'*/
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 151046
    return 1
     end

  begin tran

     /* Insertar los datos de entrada */
     insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint,
                               pa_int, pa_money, pa_datetime, pa_float, pa_producto)
                       values (@i_parametro, @i_nemonico, @i_tipo,
                               @i_char, @i_tinyint, @i_smallint,
                               @i_int, @i_money, @i_datetime, @i_float, @i_producto)

     /* Si no se puede insertar error */
     if @@error <> 0
     begin
    /* 'Error en creacion de parametro '*/
    exec cobis..sp_cerror
     
    @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103054 
    return 1
     end

     /* transaccion servicio - nuevo */
     insert into cobis..ts_parametro (secuencia, tipo_transaccion, clase, fecha,
           oficina_s,  usuario, terminal_s, srv, lsrv,
                   parametro, nemonico, tipo,
                   pa_char, pa_tinyint, pa_smallint,
                   pa_int, pa_money, pa_datetime, pa_float, producto)
        values (@s_ssn, 576, 'N', @s_date,
            @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @i_parametro, @i_nemonico, @i_tipo,
                @i_char, @i_tinyint, @i_smallint,
                @i_int, @i_money, @i_datetime, @i_float, @i_producto)

     /* Si no se puede insertar , error */
     if @@error <> 0
     begin
      /* 'Error en creacion de transaccion de servicios'*/
      exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
      return 1
     end
  commit tran
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
if @t_trn = 577
begin

  /* Guardar los datos anteriores */
  select @w_parametro = pa_parametro,
         @w_tipo = pa_tipo,
         @w_char = pa_char,
         @w_tinyint = pa_tinyint,
         @w_smallint = pa_smallint, 
         @w_int = pa_int, 
         @w_money = pa_money, 
         @w_datetime = pa_datetime, 
         @w_float = pa_float,
         @w_producto = pa_producto 
    from cobis..cl_parametro 
   where pa_nemonico = @i_nemonico
          

  if @@rowcount = 0 
  begin
        /* No existe parametro */
    exec cobis..sp_cerror 
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 101077
    return 1
  end

  /* Guardar en transacciones de servicio solo los datos que han cambiado */
  select @v_parametro = @w_parametro,
         @v_tipo = @w_tipo,
         @v_char = @w_char,
         @v_tinyint = @w_tinyint,
         @v_smallint = @w_smallint, 
         @v_int = @w_int, 
         @v_money = @w_money, 
         @v_datetime = @w_datetime, 
         @v_float = @w_float, 
         @v_producto = @w_producto 

  If @w_parametro = @i_parametro
     select @w_parametro = null, @v_parametro = null
  else
     select @w_parametro = @i_parametro

  If @w_tipo = @i_tipo
     select @w_tipo = null, @v_tipo = null
  else
     select @w_tipo = @i_tipo

  If @w_char = @i_char
     select @w_char = null, @v_char = null
  else
     select @w_char = @i_char

  If @w_tinyint = @i_tinyint
     select @w_tinyint = null, @v_tinyint = null
  else
     select @w_tinyint = @i_tinyint

  If @w_smallint = @i_smallint
    
  select @w_smallint = null, @v_smallint = null
  else
     select @w_smallint = @i_smallint

  If @w_int = @i_int
     select @w_int = null, @v_int = null
  else
     select @w_int = @i_int

  If @w_money = @i_money
     select @w_money = null,  @v_money = null
  else
     select @w_money = @i_money

  If @w_datetime = @i_datetime
     select @w_datetime = null, @v_datetime = null
  else
     select @w_datetime = @i_datetime

  If @w_float = @i_float
     select @w_float = null, @v_float = null
  else
     select @w_float = @i_float

  If @w_producto = @i_producto
     select @w_producto = null, @v_producto = null
  else
     select @w_producto = @i_producto
  begin tran

     update cobis..cl_parametro 
        set pa_parametro = @i_parametro,
            pa_tipo = @i_tipo,
            pa_char = @i_char,
            pa_tinyint = @i_tinyint,
            pa_smallint = @i_smallint, 
            pa_int = @i_int, 
            pa_money = @i_money, 
            pa_datetime = @i_datetime, 
            pa_float = @i_float
     where  pa_nemonico = @i_nemonico
        and pa_producto = @i_producto /* ORM: Junio/03/2003 */

     if @@error <> 0
     begin
    /* 'Error en actualizacion '*/
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 155024
    return 1
     end

     /* transaccion servicios - previo */
     insert into cobis..ts_parametro (secuencia, tipo_transaccion, clase, fecha,
           oficina_s, usuario, terminal_s, srv, lsrv,
                   parametro, nemonico, tipo,
                   pa_char, pa_tinyint, pa_smallint,
                   pa_int, pa_money, pa_datetime, pa_float, producto)
        values (@s_ssn, 577 , 'P', @s_date,
            @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @v_parametro, @i_nemonico, @v_tipo,
                @v_char, @v_tinyint, @v_smallint,
                @v_int, @v_money, @v_datetime, @v_float, @v_producto)

     if @@error <> 0
     begin
    /* 'Error en creacion de transaccion de servicios'*/
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
    return 1
     end

     /* transaccion servicios - anterior */
     insert into cobis..ts_parametro (secuencia, tipo_transaccion, clase, fecha,
           oficina_s, usuario, terminal_s, srv, lsrv,
                   parametro, nemonico, tipo,
                   pa_char, pa_tinyint, pa_smallint,
                   pa_int, pa_money, pa_datetime, pa_float, producto)
        values (@s_ssn, 577 , 'A', @s_date,      
        @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                @w_parametro, @i_nemonico, @w_tipo,
                @w_char, @w_tinyint, @w_smallint,
                @w_int, @w_money, @w_datetime, @w_float, @w_producto)

     if @@error <> 0
     
 begin
    /* 'Error en creacion de transaccion de servicios'*/
    exec cobis..sp_cerror
        @t_debug    = @t_debug,
        @t_file        = @t_file,
        @t_from        = @w_sp_name,
        @i_num        = 103005
    return 1
     end
  commit tran

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


/* ** Search** */
 if @i_operacion = 'S' 
 begin
 if @t_trn = 1580
 begin
     /***** BUSQUEDA POR MNEMONICO *******/
     If @i_criterio=0  
     Begin
         set rowcount 20
         /****** BUSCAR ********/
        if @i_modo = 0
        Begin
            select 
               'Nemonico' = pa_nemonico ,
               'Producto' = pa_producto,
               'Parametro' = substring(pa_parametro, 1, @w_tldc),
               'Valor Char' = pa_char,
               'Valor Tinyint' = pa_tinyint,
               'Valor Smallint' = pa_smallint,
               'Valor Int' = pa_int,  
               'Valor Money' = pa_money, 
               'Valor Float' = pa_float,
               'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
            from  cobis..cl_parametro 
            where pa_nemonico like @i_valor+'%'
                order by pa_producto, pa_nemonico
        End
        /******* SIGUIENTES *********/
        if @i_modo = 1
        Begin
            select 
                'Nemonico' = pa_nemonico ,
                'Producto' = pa_producto,
                'Parametro' = substring(pa_parametro, 1, @w_tldc),
                'Valor Char' = pa_char,
                'Valor Tinyint' = pa_tinyint,
                'Valor Smallint' = pa_smallint,
                'Valor Int' = pa_int,
                'Valor Money' = pa_money, 
                'Valor Float' = pa_float,
                'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
            from  cobis..cl_parametro
                where pa_nemonico like @i_valor+'%' and
                (
                    (pa_producto>@i_producto) or 
                    (pa_producto=@i_producto and pa_nemonico > @i_nemonico)
                )
                order by pa_producto, pa_nemonico

        /******* NO HAY DATOS *********/
            if @@rowcount=0 
            Begin            
                exec cobis..sp_cerror
                    @t_debug=@t_debug,
                    @t_file=@t_file,
                    @t_from=@w_sp_name,
                    @i_num=151121
                set rowcount 0
                return 1
            End
        End
        set rowcount 0
         return 0
     End
     /********* BUSQUEDA POR NOMBRE *********/
     If @i_criterio=1
     Begin
         set rowcount 20
         /******** BUSCAR *******/
        if @i_modo = 0
        Begin
            select 
               'Nemonico' = pa_nemonico ,
               'Producto' = pa_producto,
               'Parametro' = substring(pa_parametro, 1, @w_tldc),
               'Valor Char' = pa_char,
               'Valor Tinyint' = pa_tinyint,
               'Valor Smallint' = pa_smallint,
               'Valor Int' = pa_int,
               'Valor Money' = pa_money,      
               'Valor Float' = pa_float,
               'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
            from  cobis..cl_parametro 
            where pa_parametro like @i_valor+'%'
                order by pa_producto, pa_nemonico
        End
         
/********* SIGUIENTES *********/
        if @i_modo = 1
        Begin
            select 
               'Nemonico' = pa_nemonico ,
               'Producto' = pa_producto,
               'Parametro' = substring(pa_parametro, 1, @w_tldc),
               'Valor Char' = pa_char,
               'Valor Tinyint' = pa_tinyint,
               'Valor Smallint' = pa_smallint,
               'Valor Int' = pa_int,
               'Valor Money' = pa_money, 
               'Valor Float' = pa_float,
               'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
            from  cobis..cl_parametro
                where pa_parametro like @i_valor+'%' and
                (
            (pa_producto>@i_producto) or
                    (pa_producto=@i_producto and pa_nemonico>@i_nemonico)
                )  
               
                order by pa_producto, pa_nemonico

        /******* NO HAY DATOS ********/
            if @@rowcount=0 
            Begin            
                exec cobis..sp_cerror
                    @t_debug=@t_debug,
                    @t_file=@t_file,
                    @t_from=@w_sp_name,
                    @i_num=151121
                set rowcount 0
                return 1
            End
        End
        set rowcount 0
         return 0
     End
     /********* BUSQUEDA POR PRODUCTO *********/
     If @i_criterio=2
     Begin
         set rowcount @i_rowcount
         /******** BUSCAR *******/
        if @i_modo = 0
        Begin
            select 
               'Nemonico' = pa_nemonico ,
               'Producto' = pa_producto,
               'Parametro' = substring(pa_parametro, 1, @w_tldc), 
               'Valor Char' = pa_char,
               'Valor Tinyint' = pa_tinyint,
               'Valor Smallint' = pa_smallint,
               'Valor Int' = pa_int,
               'Valor Money' = pa_money, 
               'Valor Float' = pa_float,        
               'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
            from  cobis..cl_parametro 
            where pa_producto like @i_valor+'%'
                order by pa_producto, pa_nemonico
        End
        /********* SIGUIENTES *********/
        if @i_modo = 1
        Begin
            select 
               'Nemonico' = pa_nemonico ,
               'Producto' = pa_producto,
               'Parametro' = substring(pa_parametro, 1, @w_tldc),

              'Valor Char' = pa_char,
               'Valor Tinyint' = pa_tinyint,
               'Valor Smallint' = pa_smallint,
               'Valor Int' = pa_int,
               'Valor Money' = pa_money, 
               'Valor Float' = pa_float,
               'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha) 
            from  cobis..cl_parametro
                where pa_producto like @i_valor+'%' and
                (
                    (pa_producto > @i_producto) or 
                     (pa_producto=@i_producto and pa_nemonico>@i_nemonico)
                )
                order by pa_producto,pa_nemonico

        /******* NO HAY DATOS ********/
            if @@rowcount=0 
            Begin            
                exec cobis..sp_cerror
                    @t_debug=@t_debug,
                    @t_file=@t_file,

                   @t_from=@w_sp_name,
                    @i_num=151121
      
           set rowcount 0
                return 1

           End
        End
        set rowcount 0
         return 0
     End     
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

if @i_operacion = 'SC' 
 begin
 if @t_trn = 1580
 begin
     set rowcount 20
     if @i_modo = 0
    select 'Nemonico' = pa_nemonico ,
           'Producto' = pa_producto,      
           'Parametro' = substring(pa_parametro, 1, @w_tldc),
           'Valor Char' = pa_char,
           'Valor Tinyint' = pa_tinyint,
           'Valor Smallint' = pa_smallint,
           'Valor Int' = pa_int,
           'Valor Money' = pa_money,     
           'Valor Float' = pa_float,
           'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
    from  cobis..cl_parametro 
       where  pa_producto = @i_producto  
        order by pa_nemonico
     if @i_modo = 1
    select 'Nemonico'  = pa_nemonico ,
           'Producto' = pa_producto,
           'Parametro' = substring(pa_parametro, 1, @w_tldc),
           'Valor Char' = pa_char,
           'Valor Tinyint' = pa_tinyint,
           'Valor Smallint' = pa_smallint,
           'Valor Int' = pa_int,
           'Valor Money' = pa_money, 
           'Valor Float' = pa_float,
           'Valor Datetime' = convert(char(10),pa_datetime,@i_formato_fecha)
    from  cobis..cl_parametro
       where  pa_producto = @i_producto
        and   pa_nemonico > @i_nemonico 
        order by pa_nemonico
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

/* ** Query de parametro dado el registro ** */
if @i_operacion in ('Q', 'QS')
begin
if @t_trn = 1579
begin
  if @i_tipo = 'F' /* ORM:  01/07/2003 */
  begin 
    select pa_int
    from cobis..cl_parametro
    where pa_nemonico = @i_nemonico
  end
  else
  begin
        if @i_modo=3
        begin
            select 'Nemonico' = pa_nemonico ,
                   'Parametro' = pa_parametro,
                   'Tipo' = pa_tipo,
                   'Valor Char' = isnull(pa_char,' '),
                   'ValorTinyint' = isnull(pa_tinyint,0),
                   'Valor Smallint' = isnull(pa_smallint,0),
                   'Valor Int' = isnull(pa_int,0),
                   'Valor Money' = isnull(pa_money,0.0), 
                   'Valor Float' = isnull(pa_float,0.0),
                   'Valor Datetime' = pa_datetime,
                   'Cod.Prod.' = pd_producto,
                   'Des.Prod.' = pd_descripcion,
                   'Producto' = pa_producto
            from  cobis..cl_parametro , cobis..cl_producto
                where pa_nemonico = @i_nemonico 
              and pa_producto = @i_producto
              and pa_producto = pd_abreviatura
            return 0
       end

   if @i_modo=4
    
        begin
         select 
           @w_parametro = pa_parametro,
           @w_tipo = pa_tipo
         from  cobis..cl_parametro 
           where pa_nemonico = @i_nemonico 
            and pa_producto = @i_producto
            
    
         select @w_valor_parametro =
         case @w_tipo
         when 'C' then  (select pa_char from cobis..cl_parametro
                  where pa_tipo     = @w_tipo
                  and  pa_nemonico     = @i_nemonico
                  and  pa_producto     = @i_producto)
         when 'T' then  (select convert(varchar,pa_tinyint ) from cobis..cl_parametro
                  where pa_tipo     = @w_tipo
                   and  pa_nemonico    = @i_nemonico
                   and  pa_producto = @i_producto)
         when 'S' then (select convert(varchar ,pa_smallint)  from cobis..cl_parametro
                 where pa_tipo         = @w_tipo
                 and  pa_nemonico     = @i_nemonico
                 and  pa_producto     = @i_producto)
         when 'D' then  (select convert(varchar ,pa_datetime,@i_formato_fecha)  from cobis..cl_parametro
                  where pa_tipo     = @w_tipo
                  and  pa_nemonico    = @i_nemonico
                  and  pa_producto     = @i_producto)      
        when 'F' then (select convert (varchar, pa_float)  from cobis..cl_parametro
                 where pa_tipo         = @w_tipo
                 and  pa_nemonico    = @i_nemonico
                 and  pa_producto     = @i_producto) 
        when 'M' then  (select  convert (varchar,pa_money)  from cobis..cl_parametro
                  where pa_tipo     = @w_tipo
                  and pa_nemonico    = @i_nemonico
                  and  pa_producto     = @i_producto)                     
        when 'I' then  (select convert (varchar ,pa_int)  from cobis..cl_parametro
                  where pa_tipo     =  @w_tipo
                  and pa_nemonico    = @i_nemonico
                  and  pa_producto     = @i_producto) 

       else  '1' 

    end 
        select  @w_parametro , @w_tipo, @w_valor_parametro
        --select @o_nombre_parametro= @w_parametro , @o_tipo_parametro =@w_tipo, @o_valor_parametro = @w_valor_parametro
            return 0
    end    
    else
        begin            
            select  'Nemonico'        = pa_nemonico ,
                    'Parametro'       = pa_parametro,
                    'Tipo'            = pa_tipo,
                    'Valor Char'      = isnull(pa_char,' '),
                    'ValorTinyint'    = isnull(pa_tinyint,0),
                    'Valor Smallint'  = isnull(pa_smallint,0),
                    'Valor Int'       = isnull(pa_int,0),
                    'Valor Money'     = isnull(pa_money,0.0), 
                    'Valor Float'     = isnull(pa_float,0.0),
                    'Valor Datetime'  = Convert(char(10),pa_datetime,101),
                    'Cod.Prod.'       = pd_producto,
                    'Des.Prod.'       = pd_descripcion,
                    'Producto'        = pa_producto
             from  cobis..cl_parametro , cobis..cl_producto
            where pa_nemonico = @i_nemonico 
              and pa_producto = @i_producto
              and pa_producto = pd_abreviatura
            return 0
        end    
        
  end
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

-- OUS Agregada Operacion de Busqueda para ser usada por el Servicio
if @i_operacion = 'SS' 
begin
   set rowcount 20
   if @i_modo = 0
   begin
      select 'Nemonico' = pa_nemonico ,
             'Producto' = pa_producto,
             'Parametro' = convert(varchar,pa_parametro),
             'Valor Char' = pa_char,
             'Valor Tinyint' = pa_tinyint,
             'Valor Smallint' = pa_smallint,
             'Valor Int' = pa_int,
             'Valor Money' = pa_money, 
             'Valor Float' = pa_float,
             'Valor Datetime' = pa_datetime,
             'Tipo Dato' = pa_tipo
      from cobis..cl_parametro 
      where pa_producto = @i_producto  
      order by pa_nemonico
          
      if @@rowcount = 0
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num = 601157
         return 1
      end
   end
   
   if @i_modo = 1
   begin
      select
      'Nemonico' = pa_nemonico ,     
      'Producto' = pa_producto,
      'Parametro' = convert(varchar,pa_parametro),
      'Valor Char' = pa_char,
      'Valor Tinyint' = pa_tinyint,
      'Valor Smallint' = pa_smallint,
      'Valor Int' = pa_int,
      'Valor Money' = pa_money,      
      'Valor Float' = pa_float,
      'Valor Datetime' = pa_datetime,
      'Tipo Dato' = pa_tipo
      from cobis..cl_parametro
      where pa_producto = @i_producto
      and pa_nemonico > @i_nemonico 
      order by pa_nemonico
        
      if @@rowcount = 0 
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file = @t_file,
         @t_from = @w_sp_name,
         @i_num = 601157
         return 1
      end
   end    
   if @i_modo = 2
   begin
      set rowcount 0 

      select
      'Nemonico' = pa_nemonico ,
      'Producto' = pa_producto,
      'Parametro' = pa_parametro,
      'Valor Char' = pa_char,
      'Valor Tinyint' = pa_tinyint,
      'Valor Smallint' = pa_smallint,
      'Valor Int' = pa_int,  
      'Valor Money' = pa_money, 
      'Valor Float' = pa_float,
      'Valor Datetime' = pa_datetime,
      'Tipo Dato' = pa_tipo
      from cobis..cl_parametro
      where pa_producto = @i_producto
      and pa_nemonico like @i_nemonico 
      order by pa_nemonico
   end    
   set rowcount 0
   return 0
end
GO
