/************************************************************************/
/*      Archivo:                func_aut.sp                             */
/*      Stored procedure:       sp_funcionario_Aut                      */
/*      Base de datos:          cob_pfijo                               */
/*      Producto:               Plazo_fijo                              */
/*      Disenado por:           Carolina Alvarado                       */
/*      Fecha de documentacion: 9/Ago/95                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa el mantenimiento de la tabla              */
/*      de funcionarios autorizados pf_funcionario                      */
/*      Insercion de pf_funcionario                                     */
/*      Eliminacion de pf_funcionario                                   */
/*      Help a la tabla pf_funcionario                                  */
/*                                                                      */
/*                                                                      */
/************************************************************************/
use cob_pfijo
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects where name = 'sp_funcionario_aut')
   drop proc sp_funcionario_aut
go

create proc sp_funcionario_aut (
   @s_ssn                int         = NULL,
   @s_user               login       = NULL,
   @s_term               varchar(30) = NULL,
   @s_date               datetime    = NULL,
   @s_srv                varchar(30) = NULL,
   @s_lsrv               varchar(30) = NULL,
   @s_ofi                smallint    = NULL,
   @s_rol                smallint    = NULL,
   @t_debug              char(1)     = 'N',
   @t_file               varchar(10) = NULL,
   @t_from               varchar(32) = NULL,
   @t_trn                smallint    = NULL,
   @i_operacion          char(1),
   @i_tipo               char(1)     = NULL,
   @i_funcionario        login       = NULL,
   @i_tautorizacion      catalogo    = '%',
   @i_func_relacionado   login       = NULL, /*ESP. DP00157*/
   @i_modo               smallint    = 0,
   @i_formato_fecha      int         = 0,     /* GESCY2K B264 */
   @i_siguiente	         int         = 0,
   @i_secuencial	     int	     = NULL,
   @i_nivel              varchar(10) = null,
   @i_valor_nivel        varchar(10) = null,
   @i_fecha_ini          varchar(50) = '',
   @i_fecha_fin          varchar(50) = '',
   @i_tipo_aut           varchar(50) = '',
   @i_rol                varchar(50) = ''
)
with encryption
as
declare @w_sp_name            varchar(32),
        @w_funcionario        login,      
        @w_func_relacionado   login,        
        @w_tautorizacion      catalogo,   
        @w_fecha_crea         datetime,
        @w_fecha_mod          datetime,
        @w_estado             char(1),
	@w_siguiente	      int,
	@w_secuencial	      int,
	@w_return	      int,
	@w_criterio           varchar(3000),
	@w_criterio_c         varchar(3000),
	@w_columnas           varchar(1000),
	@w_tablas             varchar(1000),
	@w_ordenamiento       varchar(250), 
	@w_login              varchar(30),
	@w_tipo_aut 	      varchar(30),
        @w_comando	      varchar(5000),
        @w_oficina  	      varchar(30),
        @w_ciudad             varchar(30)
        
select @w_sp_name = 'sp_funcionario_aut'

if (@t_trn <> 14133 or @i_operacion <> 'I') and
   (@t_trn <> 14333 or @i_operacion <> 'D') and
   (@t_trn <> 14633 or @i_operacion <> 'H')

begin
   exec cobis..sp_cerror
        @t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 141112
   return 1
end


/** Insert **/
if @i_operacion = 'I'
begin
   if exists (select fu_funcionario from pf_funcionario
	       where fu_funcionario      = @i_funcionario 
                 and fu_func_relacionado = @i_func_relacionado
                 and fu_tautorizacion    = @i_tautorizacion
                 and fu_estado = 'A')
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141113
      return 1
   end

   if ltrim(rtrim(@i_funcionario)) = ''
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141113
      return 1
   end

   begin tran

	--CCR SEQNOS
	exec @w_return = cobis..sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'pf_funcionario',
		@o_siguiente	= @w_siguiente out
	if @w_return <> 0
	begin
		exec cobis..sp_cerror
			@t_debug	= @t_debug,
			@t_file		= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 149095
		return 1
	end
	
      insert into pf_funcionario (fu_secuencial,
				fu_funcionario,
                                  fu_tautorizacion,
                                  fu_func_relacionado,
   	                          fu_fecha_crea,
   	                          fu_fecha_elim,
   	                          fu_estado)
                          values (@w_siguiente,
				@i_funcionario,
   	                          @i_tautorizacion,
                                  @i_func_relacionado,
   	                          @s_date,
   	                          null,
   	                          'A')

      /* si no se puede insertar, error */
      if @@error <> 0
      begin
	 exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143033
	 return 1
      end

      /* Transaccion de servicio  */
      insert into ts_funcionario (secuencial, tipo_transaccion, clase, fecha,
   	                          usuario, terminal, srv, lsrv,
   	                          funcionario,func_relacionado,tautorizacion, fecha_crea,
   	                          fecha_elim,estado, seqnos)
                          values (@s_ssn, @t_trn, 'N', @s_date,
	                          @s_user, @s_term, @s_srv, @s_lsrv,
	                          @i_funcionario,@i_func_relacionado,@i_tautorizacion,@s_date,
                                  @s_date,'A', @w_siguiente)

      /* si no se puede insertar transaccion de servicio, error */
      if @@error <> 0
      begin
	 exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143005
              /*'Error en insercion de transaccion de servicio'*/
	 return 1
      end
   commit tran

   return 0
end


/** Delete **/
if @i_operacion = 'D'
begin
   /* valores para transaccion de servicios */
   select @w_tautorizacion = fu_tautorizacion,
	  @w_estado        = fu_estado,
	  @w_fecha_crea    = fu_fecha_crea,
	  @w_fecha_mod     = fu_fecha_elim,
	@w_secuencial	= fu_secuencial,
	@w_funcionario	= fu_funcionario,
	@w_func_relacionado	= fu_func_relacionado
     from pf_funcionario
    where	fu_secuencial	= @i_secuencial
	and	fu_estado	= 'A'

   if @@rowcount = 0
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 141114
      return 1    
   end

   begin tran
      /* cambia de estado en la tabla pf_funcionario */
      update pf_funcionario 
         set fu_estado = 'E',
             fu_fecha_elim  = @s_date
       where	fu_secuencial	= @i_secuencial
	and	fu_estado	= 'A'
    
      if @@error <> 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 147033
         return 1    
      end 
   
      insert into ts_funcionario (secuencial, tipo_transaccion, clase, fecha,
   	                          usuario, terminal, srv, lsrv,
                                  funcionario,func_relacionado, tautorizacion,fecha_crea,
                                  fecha_elim,estado, seqnos)
                          values (@s_ssn, @t_trn, 'B', @s_date,
                                  @s_user, @s_term, @s_srv, @s_lsrv,
                                  @w_funcionario, @w_func_relacionado, @w_tautorizacion,@w_fecha_crea,
                                  @w_fecha_mod,@w_estado, @w_secuencial)

      /* si no se puede insertar, error */
      if @@error <> 0 
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 143005
         return 1    
      end 

   commit tran
   return 0
end /* end de if operacion = D */


/*  Search  */
if @i_operacion = 'S'
begin
   set rowcount 20

   if @i_modo = 0
   begin
      select 'FUNCIONARIO'    = b.fu_funcionario,
             'NOMBRE'         = substring(a.fu_nombre,1,30),
             'DESCRIPCION'    = substring(d.valor,1,30),
             'AUTORIZACION'   = b.fu_tautorizacion,
             'FECHA CREACION' = convert (char(10),b.fu_fecha_crea, @i_formato_fecha)  /* GESCY2K B265 */
        from cobis..cl_funcionario a, 
             pf_funcionario b, 
             cobis..cl_tabla c,
             cobis..cl_catalogo d
       where b.fu_estado      = 'A'
         and b.fu_funcionario = a.fu_login
         and c.tabla  = 'pf_tipo_aut' 
         and c.codigo = d.tabla
         and d.codigo = b.fu_tautorizacion
       order by b.fu_funcionario , b.fu_tautorizacion
   end

   if @i_modo = 1
   begin
      select 'FUNCIONARIO'    = b.fu_funcionario,
             'NOMBRE'         = substring(a.fu_nombre,1,30),
             'DESCRIPCION'    = substring(d.valor,1,30),
             'AUTORIZACION'   = b.fu_tautorizacion,
             'FECHA CREACION' = convert (char(10),b.fu_fecha_crea, @i_formato_fecha)  /* GESCY2K B266 */
        from cobis..cl_funcionario a, 
             pf_funcionario b, 
             cobis..cl_tabla c,
             cobis..cl_catalogo d
       where b.fu_estado = 'A'
         and b.fu_funcionario > @i_funcionario
         and b.fu_funcionario = a.fu_login
         and c.tabla  = 'pf_tipo_aut'
         and c.codigo = d.tabla
         and d.codigo = b.fu_tautorizacion
       order by b.fu_funcionario , b.fu_tautorizacion
   end

   set rowcount 0
   return 0
end

/** Help **/
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
      set rowcount 20

      if @i_modo = 0
      begin
         select 
         'FUNCIONARIO'   	   = b.fu_funcionario,
	     'NOMBRE'                   = substring(a.fu_nombre,1,30),
         'DESCRIPCION'              = substring(d.valor,1,30),
	     'AUTORIZACION'	           = b.fu_tautorizacion,
	     'FUNC. RELACIONADO'	   = b.fu_func_relacionado,
	     'NOMBRE FUNC. RELACIONADO' = substring(e.fu_nombre,1,30),
             'OFICINA'                    = a.fu_oficina,
	     'SECUENCIAL'		= b.fu_secuencial
         from cobis..cl_funcionario a
         inner join pf_funcionario b on
            b.fu_funcionario = a.fu_login
            inner join cobis..cl_catalogo d on
               d.codigo = b.fu_tautorizacion
               inner join cobis..cl_tabla c on
                  c.codigo = d.tabla
                  left outer join cobis..cl_funcionario e on
                     b.fu_func_relacionado = e.fu_login
         where b.fu_estado      = 'A'
         and b.fu_tautorizacion like @i_tautorizacion
         and c.tabla  = 'pf_tipo_aut'
         order by b.fu_secuencial          
      end

      if @i_modo = 1
      begin
         select 
         'FUNCIONARIO'   	   = b.fu_funcionario,
	     'NOMBRE'                   = substring(a.fu_nombre,1,30),
         'DESCRIPCION'              = substring(d.valor,1,30),
	     'AUTORIZACION'	           = b.fu_tautorizacion,
	     'FUNC. RELACIONADO'	   = b.fu_func_relacionado,
	     'NOMBRE FUNC. RELACIONADO' = substring(e.fu_nombre,1,30),
             'OFICINA'                    = a.fu_oficina,
		 'SECUENCIAL'		= b.fu_secuencial
         from cobis..cl_funcionario a
         inner join pf_funcionario b on
            b.fu_funcionario = a.fu_login
            inner join cobis..cl_catalogo d on
               d.codigo = b.fu_tautorizacion
               inner join cobis..cl_tabla c on
                  c.codigo = d.tabla
                  left outer join cobis..cl_funcionario e on
                     b.fu_func_relacionado = e.fu_login
         where b.fu_estado      = 'A'
         and b.fu_secuencial > @i_siguiente
         and b.fu_tautorizacion like @i_tautorizacion
         and c.tabla  = 'pf_tipo_aut'
         order by b.fu_secuencial          
      end

      set rowcount 0 
      return 0   
   end
   
   if @i_tipo = 'V'
   begin
      select fu_nombre 
        from cobis..cl_funcionario a, 
             pf_funcionario b
       where b.fu_funcionario   = @i_funcionario
         and b.fu_tautorizacion = @i_tautorizacion
         and b.fu_funcionario   = a.fu_login
         and b.fu_estado        = 'A'
   
      if @@rowcount = 0
      begin
	     exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 141134
              /* 'No existe dato solicitado ' */
         return 1
      end
      return 0
   end

   if @i_tipo = 'E' -- Especial
   begin


      -------------------------------------------------------------------------
      -- ARMA LA CADENA CON LAS COLUMNAS
      -------------------------------------------------------------------------
      select @w_columnas = --'select * '

         'select
         ''FUNCIONARIO''   	        = b.fu_funcionario,
	 ''NOMBRE''                     = substring(a.fu_nombre,1,30),
         ''DESCRIPCION''    	        = (select substring(C.valor,1,50) from cobis..cl_tabla T, cobis..cl_catalogo C where T.codigo = C.tabla and T.tabla = ''pf_tipo_aut'' and C.codigo = b.fu_tautorizacion),
         ''AUTORIZACION''	        = b.fu_tautorizacion,
	 ''FUNC. RELACIONADO''	        = b.fu_func_relacionado,
	 ''NOMBRE FUNC. RELACIONADO''   = substring(e.fu_nombre,1,30),
         ''OFICINA''                    = e.fu_oficina,
         ''SECUENCIAL''		        = b.fu_secuencial
         '

      -------------------------------------------------------------------------
      -- ARMA LA CADENA CON LAS TABLAS
      -------------------------------------------------------------------------

      select @w_tablas  = 


         ' from cobis..cl_funcionario a '			+
         ' inner join cob_pfijo..pf_funcionario b on '		+
         '    b.fu_funcionario = a.fu_login '                   

         if @i_rol is not null and @i_rol <> ''
      	    select @w_tablas  =  @w_tablas + ' inner join cobis..ad_usuario_rol r on ' +    
                                             '    a.fu_login = r.ur_login '

      select @w_tablas  =  @w_tablas + 

         ' left outer join cobis..cl_funcionario e on '   	+
         '    b.fu_func_relacionado = e.fu_login '        	+
         ' left outer join cobis..cl_oficina o on '		+
         '    e.fu_oficina = o.of_oficina '                   	

      -------------------------------------------------------------------------
      -- ARMA LA CADENA CON LOS CRITERIOS
      -------------------------------------------------------------------------

      select @w_login 	        = '%',
	     @w_tipo_aut 	= '%',
             @w_oficina  	= '%'

      if @i_nivel = 'F'
         select @w_login = @i_valor_nivel
      if @i_nivel = 'O'
         select @w_oficina = @i_valor_nivel
      if @i_nivel = 'TA'
         select @w_tipo_aut = @i_valor_nivel

      select @w_criterio = 

         ' where b.fu_estado      = ''A'''     + 
         ' and	a.fu_login like ''' 	       + @w_login    + 
         ''' and  b.fu_tautorizacion like '''  + @w_tipo_aut +
         ''' and  a.fu_oficina like '''        + @w_oficina  + ''''


      if  ( @i_fecha_ini is not null and @i_fecha_ini <> '') and ( @i_fecha_fin is null or @i_fecha_fin = '')
         select @w_criterio = @w_criterio + ' and  b.fu_fecha_crea  = '''        + @i_fecha_ini  + ''''

      if ( @i_fecha_ini is not null and @i_fecha_ini <> '')  and (@i_fecha_fin is not null and @i_fecha_fin <> '')
         select @w_criterio = @w_criterio + ' and  b.fu_fecha_crea  between '''    + @i_fecha_ini  + ''' and ''' + @i_fecha_fin  + ''''

     if @i_tipo_aut <> '' and @i_tipo_aut is not null 
         select @w_criterio = @w_criterio + ' and  b.fu_tautorizacion = '''   + @i_tipo_aut  + ''''
     
     if @i_nivel = 'R'
        select @w_criterio = @w_criterio + ' and of_regional = ' + @i_valor_nivel 
	
     if @i_nivel = 'Z'
        select @w_criterio = @w_criterio + ' and of_zona = ' + @i_valor_nivel 

     if @i_nivel = 'C'
        select @w_criterio = @w_criterio + ' and of_ciudad = ' + @i_valor_nivel 


     if @i_rol is not null and @i_rol <> ''
        select @w_criterio = @w_criterio + ' and r.ur_rol = ' + @i_rol 

      if @i_modo = 1        
         select @w_criterio = @w_criterio + ' and b.fu_secuencial > ' + convert(varchar(50),@i_siguiente)

     
      -------------------------------------------------------------------------
      -- ORDENAMIENTO
      -------------------------------------------------------------------------

      SELECT @w_ordenamiento = ' ORDER BY b.fu_secuencial'

      -------------------------------------------------------------------------
      -- EJECUCION DE COMANDO COMPLETO
      -------------------------------------------------------------------------

      select @w_comando = @w_columnas + @w_tablas + @w_criterio + @w_ordenamiento
  
if @t_debug = 'S'  print 'comando ' + cast( @w_comando as varchar(1000))

      set rowcount 20
   
      execute (@w_comando)

   end

end

go

