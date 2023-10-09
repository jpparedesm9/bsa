/************************************************************************/
/*      Archivo:                catalogo.sp                             */
/*      Stored procedure:       sp_catalogo                             */
/*      Base de datos:          cobis                                   */
/*      Producto:               Administrador                           */
/*      Disenado por:           Sandra Ortiz                            */
/*      Fecha de documentacion: 17/Nov/93                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este stored procedure procesa:                                   */
/*      Existencia en cl_catalogo                                       */
/*      insercion en cl_catalogo                                        */
/*      modificacion en cl_catalogo                                     */
/*      query de datos de catalogo                                      */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      17/Nov/93       R. Minga V.     documentacion, param @s_ y      */
/*                                      personalizacion                 */
/*      9/Dic/93        P. Martinez     Actualizacion en linea del      */
/*                                      transrv                         */
/*      09/Mar/94       F.Espinosa      Search de Catalogo modos 2, 3   */
/*      25/Abr/94       F.Espinosa      Parametros tipo "S"             */
/*                                      Transacciones de Servicio       */
/*      05/Mar/94       S. Vinces       Cabios para ADMIN distribuido.  */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_catalogo')
	drop proc sp_catalogo
go

create proc sp_catalogo (
	@s_ssn                  int = NULL,
	@s_user                 login = NULL,
	@s_sesn                 int = NULL,
	@s_term                 varchar(30) = NULL,
	@s_date                 datetime = NULL,
	@s_srv                  varchar(30) = NULL,
	@s_lsrv                 varchar(30) = NULL, 
	@s_rol                  smallint = NULL,
	@s_ofi                  smallint = NULL,
	@s_org_err              char(1) = NULL,
	@s_error                int = NULL,
	@s_sev                  tinyint = NULL,
	@s_msg                  descripcion = NULL,
	@s_org                  char(1) = NULL,
	@t_debug                char(1) = 'N',
	@t_file                 varchar(14) = null,
	@t_from                 varchar(32) = null,
	@t_trn                  smallint = null,
	@i_operacion            varchar(2),
	@i_modo                 tinyint = null,
	@i_tabla                descripcion ,
	@i_codigo               varchar(10) = null,
	@i_descripcion          descripcion = null,
	@i_estado               estado = null,
	@i_central_transmit     varchar(1) = null
)
as
declare @w_today        datetime,
	@w_sp_name      descripcion,
	@w_return       int,
	@w_cod_tabla    smallint,
	@w_titulo       descripcion,
	@w_estado       estado,
	@w_valor        descripcion,
	@v_estado       estado,
	@v_valor        char(32),
	@w_nt_nombre	varchar(40),
	@w_cmdtransrv   descripcion, 
	@w_server_logico  varchar(30),
	@w_num_nodos      smallint,
	@w_contador       smallint,
	@w_clave	int


/*  Inicializar variables  */
select  @w_today   = @s_date
select  @w_sp_name = 'sp_catalogo'

/* Averiguar el codigo de la tabla */
select  @w_cod_tabla = codigo,
	@w_titulo    = descripcion
from    cl_tabla
where   tabla = @i_tabla

if @@rowcount = 0
   begin
	/* No existe tabla */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 101003 
	return 1
     end


/*  ** Existencia **  */
if @i_operacion = 'E'
	if exists (select  *
		   from    cobis..cl_catalogo
		   where   tabla = (select  codigo
			   from    cobis..cl_tabla
			    where   tabla = @i_tabla)
		   and     codigo = @i_codigo
		   and  estado = 'V')
		return 0
	else
		return 1



if (@i_operacion = 'I' or @i_operacion = 'U') and (@i_central_transmit is NULL)
	begin
	create table #ad_nodo_reentry_tmp (nt_nombre varchar(60), nt_bandera char(1) ) 
	end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 584
begin

  /* Verificar que exista un codigo y no sea repetido */
  if @i_codigo is not null
  begin
    if exists (select * 
	  
     from cl_catalogo
	     where codigo = @i_codigo 
	       and tabla = @w_cod_tabla )
     begin
	/* Codigo duplicado */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 101104 
	return 1
   end
  end
  else
  begin
	/* No existe codigo */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 101102 
	return 1
  end

  /* Verificar que se ingrese una descripcion */
  if @i_descripcion is null
   begin
	/* No existe 
 descripcion */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 101103 
	return 1
   end

  begin tran
     insert into cl_catalogo (tabla, codigo, valor, estado)
		      values (@w_cod_tabla, @i_codigo, @i_descripcion, 'V')
     if @@error != 0
     begin
	/* Error en creacion de catalogo */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 103015
	return 1
     end

     /* transaccion servicio - catalogo */
   
   insert into ts_catalogo (secuencia, tipo_transaccion, clase, fecha,
			     oficina_s, usuario, terminal_s, srv, lsrv,
			     tabla, codigo, valor, estado)
     values (@s_ssn, 584, 'N', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	      @w_cod_tabla, @i_codigo, @i_descripcion, 'V')
     if @@error != 0
     begin
	  /* Error en transaccion de servicio */
	  exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 103005
	  return 1
     end
  commit tran
/********************************** Para Unix *******************************/
  exec REENTRY...rp_gen_catalogo
  select @w_cmdtransrv = @s_lsrv + '...sp_load_catalogo'
  exec @w_cmdtransrv

	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
    
       from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R' 
           
	   and sg_moneda   = 0             

	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre  = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'    
	        
		set rowcount 0

		update #ad_nodo_reentry_tmp set nt_bandera = 'S'
	         where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv	
					@s_lsrv        = @w_nt_nombre,     
					@t_rty         = 'S',              
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,     
					@i_tabla       = @i_tabla,         
					@i_cod_tabla   = @w_cod_tabla,
				 	@i_titulo      = @w_titulo,
					@i_codigo      = @i_codigo,        
					@i_descripcion = @i_descripcion,   
					@i_estado      = @i_estado ,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out


				if @w_return <> 0
					return @w_return

		 
		exec @w_return = cobis..sp_reentry
					@i_key = @w_clave,
					@i_tipo = 'I'

				if @w_return <> 0
					return @w_return

			select @w_contador = @w_contador + 1
			continue
	end
	delete #ad_nodo_reentry_tmp
/********************************** Para Unix *******************************/
        return 0
end
else
begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	/*  'No corresponde codigo de transaccion' */
	return 1
end
end

/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 585
begin
  select @w_valor   = valor,
	 @w_estado  = estado
    from cl_catalogo
   where tabla  = @w_cod_tabla 
     and codigo = @i_codigo
   if @@rowcount = 0
     begin
	/* No existe dato en catalogo */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 101000
	return 1
     end

  select @v_valor  = @w_valor,
	 @v_estado = @w_estado
  if @w_valor = @i_descripcion
	select @w_valor = null, 
	       @v_valor = null
  else
	select @w_valor = @i_descripcion

  if @w_estado = @i_estado
    select @w_estado = null, 
	   @v_estado = null
  else
    select @w_estado = @i_estado

  begin tran
     update cl_catalogo
     set    valor  = @i_descripcion,

	    estado = @i_estado
     where  tabla = @w_cod_tabla
     and    codigo = @i_codigo
     if @@error != 0
     begin
	/* Error en actualizacion de catalogo */
	exec sp_cerror 
		@t_debug= @t_debug,
		@t_file = @t_file,
		@t_from = @w_sp_name,
		@i_num  = 105000
	return 1
     end
     insert into ts_catalogo (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      tabla, codigo, valor, estado)
     values (@s_ssn, 585, 'P', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	     @w_cod_tabla, @i_codigo, @v_valor, @v_estado)
     if @@error != 0
     begin
		/* Error en transaccion de servicio */
		exec sp_cerror 
			@t_debug= @t_debug,
			@t_file = @t_file,
			@t_from = @w_sp_name,
			@i_num  = 103005 
		return 1
     end
     insert into ts_catalogo (secuencia, tipo_transaccion, clase, fecha,
			      oficina_s, usuario, terminal_s, srv, lsrv,
			      tabla, codigo, valor, estado)
     values (@s_ssn, 585, 'A', @s_date,@s_ofi, 
 @s_user, @s_term, @s_srv, @s_lsrv,
	     @w_cod_tabla, @i_codigo, @w_valor, @w_estado)
     if @@error != 0
     begin
		/* Error en transaccion de servicio */
		exec sp_cerror 
			@t_debug= @t_debug,
			@t_file = @t_file,
			@t_from = @w_sp_name,
			@i_num  = 103005
		return 1
     end
  commit tran

/************************ Paara   Unix    ***************************/
  
  exec REENTRY...rp_gen_catalogo
  select @w_cmdtransrv = @s_lsrv + '...sp_load_catalogo'
  exec @w_cmdtransrv
 
	insert into #ad_nodo_reentry_tmp
	select nl_nombre,'N'
          from ad_nodo_oficina,ad_server_logico
	 where nl_nombre <> @s_lsrv          
	   and nl_filial   = sg_filial_i   
	   and nl_oficina  = sg_oficina_i 
	   and nl_nodo     = sg_nodo_i    
	   and sg_producto = 1             
	   and sg_tipo     = 'R'           
	   and sg_moneda   = 0             

                                                   
	select @w_num_nodos = count(*) from #ad_nodo_reentry_tmp

	select @w_contador = 1
	while @w_contador <= @w_num_nodos
         begin
		set rowcount 1
		select @w_cmdtransrv = 'REENTRY' + '.' + nt_nombre + '.cobis.' + @w_sp_name,@w_nt_nombre = nt_nombre
		  from #ad_nodo_reentry_tmp
		  where nt_bandera = 'N'
		  set rowcount 0
	        update #ad_nodo_reentry_tmp set nt_bandera = 'S'
		where nt_nombre = @w_nt_nombre

		exec @w_return = @w_cmdtransrv	
					@s_lsrv        = @w_nt_nombre,     
					@t_trn         = @t_trn,           
					@t_rty	       = 'S',
					@i_operacion   = @i_operacion,     
					@i_tabla       = @i_tabla,          
					@i_cod_tabla   = @w_cod_tabla,
					@i_titulo      = @w_titulo,
					@i_codigo      = @i_codigo,        
					@i_descripcion = @i_descripcion,   
					@i_estado      = @i_estado ,
					@i_central_transmit = 'S',
					@o_clave	= @w_clave out

			if @w_return <> 0
				return @w_return
			exec @w_return = cobis..sp_reentry
			        @i_key = @w_clave,
                                @i_tipo = 'I'

			if @w_return <> 0
				return @w_return

			select @w_contador = @w_contador + 1
 
			continue
	end
	delete #ad_nodo_reentry_tmp
/************************ Paara   Unix    ***************************/
  return 0
end
else
begin
	exec sp_cerror
	   @t_debug      = @t_debug,
	   @t_file       = @t_file,
	   @t_from       = @w_sp_name,
	   @i_num        = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end
/* Search */
if @i_operacion = 'S'
begin
if @t_trn = 1564
begin
     set rowcount 20
     if @i_modo = 0
     begin
	/* enviar cabecera */
	select 'Codigo', rtrim(@w_titulo)'        ', 'Estado'
	select  codigo,
		valor,
		estado
	from    cl_catalogo
	where   tabla = @w_cod_tabla
	order   by codigo
     end
     
     if @i_modo = 1
     begin
	/* enviar cabecera */
	
--	select 'Codigo', rtrim(@w_titulo)'           ', 'Estado'       ARO 2 de Junio del 2000
	select codigo, 
	       valor,
	       estado
	from   cl_catalogo
	where  tabla = @w_cod_tabla
	and       codigo > @i_codigo
	order  by codigo

	/* ARO: 2 de Junio del 2000: Corrección Siguientes */        
        if @@rowcount=0
        Begin      
   		exec sp_cerror
	   		@t_debug	= @t_debug,
	   		@t_file		= @t_file,
	   		@t_from		= @w_sp_name,
	   		@i_num	       	= 101000
        	set rowcount 0
        	return 1
        End
        /* Fin ARO */
	
     end
     
     if @i_modo = 2
     begin
	/* enviar cabecera */
	select 'Codigo',rtrim(@w_titulo)'            '

	select  substring(codigo, 1, 5),
		valor
	from    cl_catalogo
	where   tabla = @w_cod_tabla
	  and   estado = 'V'
	order   by convert(smallint, codigo)
	select count(*) from cl_catalogo where tabla = @w_cod_tabla
     end
	
     if @i_modo = 3
     begin
	select  substring(codigo, 1, 5),
	       'valor         '=valor
	from   cl_catalogo
	where  tabla = @w_cod_tabla
	  and  convert(smallint,codigo) > convert(smallint,@i_codigo)
	  and  estado = 'V'
	order   by convert(smallint, codigo)
     end
     set rowcount 0
     return 0
end
else
begin
 
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end

/* Query */
if @i_operacion = 'Q'
begin
if @t_trn = 1563
begin
     /*  
enviar cabecera */
     select 'Codigo', rtrim(@w_titulo)'       '
     /* enviar datos de 20 en 20 */
     set rowcount 20
     if @i_modo = 0
     begin
	select  codigo,
		valor
	from    cl_catalogo
	where   tabla = @w_cod_tabla
	and     estado = 'V'
	order by codigo
	select count(*) from cl_catalogo where tabla = @w_cod_tabla
     end
     else
	if @i_modo = 1
	begin
	   select codigo,
		  valor
	   from   cl_catalogo
	   where  tabla = @w_cod_tabla
	   and    codigo > @i_codigo
	   and    estado = 'V'
	    
order  by codigo
	end
     set rowcount 0
     return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
end
go