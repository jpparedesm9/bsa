/************************************************************************/
/*	Archivo:		moneddml.sp				*/
/*	Stored procedure:	sp_moneda_dml				*/
/*	Base de datos:		cobis					*/
/*	Producto: Clientes						*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 12-Nov-1992					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones del stored procedure	*/
/*      Insercion de moneda                                             */
/*      Modificacion de moneda                                          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	12/Nov/92	M. Davila	Emision Inicial			*/
/*	14/Ene/93	L. Carvajal	Tabla de errores, variables	*/
/*					de debug			*/
/*      24/Feb/93       M. Davila       Stored Procedure independiente  */
/*                                      de catalogo                     */
/*      24/Nov/93       R. Minga V.     documentacion, param @s_        */
/*                                      Verificacion y validacion       */
/*	26/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*	03/May/95	S. Vinces       Cambio de Admin Distribuido  	*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_moneda_dml')
   drop proc sp_moneda_dml
go

create proc sp_moneda_dml (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
        @i_operacion		varchar(2),
        @i_modo			tinyint = null,
        @i_tipo			varchar(2) = null,
        @i_moneda		tinyint = null,
        @i_descripcion   	descripcion = null,
        @i_pais			smallint = null,
        @i_estado		estado = null,
        @i_decimales     	varchar(1) = null,
	@i_simbolo		varchar (10) = null,
        @i_central_transmit     varchar(1) = null  
)
as
declare @w_codigo	int,
	@w_sp_name	varchar(32),
	@w_descripcion	descripcion,
	@w_pais 	smallint,
	@w_estado	estado,
        @w_decimales    varchar(1),
        @w_return	int,	
        @w_simbolo	varchar(10),	
	@v_descripcion  descripcion,
	@v_pais 	smallint,
	@v_estado	estado,
        @v_decimales    varchar(1),
        @v_simbolo	varchar(10),	
	@o_moneda	tinyint,
	@w_codigo_c	varchar(10), 
	@w_bandera	varchar(1), 
        @w_cmdtransrv   varchar(60),
	@w_server_logico    varchar(10),
	@w_nt_nombre        varchar(30),
	@w_num_nodos    smallint,    
	@w_contador     smallint,
	@w_clave	int

select @w_sp_name = 'sp_moneda_dml'
select @w_bandera = 'N'



if (@i_operacion = 'I' or @i_operacion = 'U') and (@i_central_transmit is NULL) 
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1) )
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 1511
begin
  /* Verificar que exista el pais */
  select @w_codigo = null
    from cl_pais
   where pa_pais = @i_pais

  /* si no existe el pais, error */ 
  if @@rowcount = 0
  begin
       /*'No existe pais'*/
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101018
       return 1
  end
  begin tran
/*     /* encontrar un nuevo secuencial para la moneda */
     exec sp_cseqnos
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_tabla	= 'cl_moneda',
		@o_siguiente	= @o_moneda out
*/
     /* Insert cl_moneda */
     insert into cl_moneda (mo_moneda, mo_descripcion,
			    mo_pais, mo_estado, mo_decimales, mo_simbolo)
		   values ( @i_moneda, @i_descripcion,
			    @i_pais, 'V', @i_decimales, @i_simbolo)

     /* si no se puede insertar, error */
     if @@error != 0
     begin
	/* 'Error en creacion de moneda'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103023
	return 1
     end

     /* transaccion servicio - moneda */
     insert into ts_moneda (secuencia, tipo_transaccion, clase, fecha,
		            oficina_s, usuario, terminal_s, srv, lsrv,
			    moneda, descripcion, pais, estado, decimales,
			    simbolo)
     values (@s_ssn, 1511, 'N', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	     @i_moneda, @i_descripcion, @i_pais, 'V', @i_decimales ,
	     @i_simbolo)

     /* si no se puede insertar transaccion de servicio, error */
     if @@error != 0
     begin
	  /* 'Error en creacion de transaccion de servicios'*/
	  exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	  return 1
     end

  select @w_bandera = 'S'
  commit tran
 
  if @w_bandera = 'S'
    begin

	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_moneda)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 584,
       		@i_operacion		   = 'I',
       		@i_tabla		   = 'cl_moneda',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = 'V'	
	if @w_return != 0
		return @w_return
   end
  /******************************* Para   Unix  *************************/

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
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv  
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_moneda      = @i_moneda,
					@i_descripcion = @i_descripcion,
					@i_pais        = @i_pais,
					@i_estado      = @i_estado,
					@i_decimales   = @i_decimales,
					@i_simbolo     = @i_simbolo,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave out

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
/******************************* Para   Unix  **************************/

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


/* ** Update ** */
if @i_operacion = 'U'
begin
if @t_trn = 1512
begin
  /* Verificar que exista el pais */
  select @w_codigo = null
    from cl_pais
   where pa_pais = @i_pais

  /* si no existe el pais error */
  if @@rowcount = 0
  begin
       /* 'No existe pais'*/
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101018
       return 1
  end

  /* guardar los datos que se modificaran */
  select @w_descripcion  = mo_descripcion,
	 @w_pais	 = mo_pais,
	 @w_estado	 = mo_estado,
         @w_decimales    = mo_decimales,
	 @w_simbolo	 = mo_simbolo
    from cl_moneda
   where mo_moneda =  @i_moneda

  if @@rowcount = 0
  begin
       /* 'No existe moneda'*/
       exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 101045
       return 1
  end

  select @v_descripcion = @w_descripcion
  select @v_pais	= @w_pais
  select @v_estado	= @w_estado
  select @v_decimales	= @w_decimales
  select @v_simbolo	= @w_simbolo

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
     select @w_estado = @i_estado

  if @w_decimales = @i_decimales
     select @w_decimales = null, @v_decimales = null
  else
     select @w_decimales = @i_decimales

  if @w_simbolo = @i_simbolo
     select @w_simbolo = null, @v_simbolo = null
  else
     select @w_simbolo = @i_simbolo
  
begin tran
     /* Update moneda */
     update cl_moneda
     set    mo_descripcion = @i_descripcion,
	    mo_pais        = @i_pais,
	    mo_estado      = @i_estado,
            mo_decimales   = @i_decimales,
	    mo_simbolo	   = @i_simbolo
     where  mo_moneda = @i_moneda

     /* si no se puede modificar, error */
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 105023
	    /* 'Error en actualizacion de moneda'*/
	return 1
     end

     /* transaccion servicios - moneda */
     insert into ts_moneda (secuencia, tipo_transaccion, clase, fecha,
		            oficina_s, usuario, terminal_s, srv, lsrv,
			    moneda, descripcion, pais, estado, decimales,
			    simbolo)
     values (@s_ssn, 1512, 'P', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	     @i_moneda, @v_descripcion, @v_pais, @v_estado, @v_decimales,
	     @i_simbolo)

     /* si no se puede insertar, error */
     if @@error != 0
     begin
	/* 'Error en creacion de transaccion de servicios'*/
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	return 1
     end

     /* transaccion servicio - moneda */
     insert into ts_moneda (secuencia, tipo_transaccion, clase, fecha,
		            oficina_s, usuario, terminal_s, srv, lsrv,
			    moneda, descripcion, pais, estado, decimales,
			    simbolo)
     values (@s_ssn ,1512 , 'A', @s_date,
	     @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	     @i_moneda, @w_descripcion, @w_pais, @w_estado, @w_decimales,
	     @i_simbolo)

     /* si no se puede insertar, error */
     if @@error != 0
     begin
	exec sp_cerror
		@t_debug	= @t_debug,
		@t_file		= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 103005
	   /* 'Error en creacion de transaccion de servicios'*/
	return 1
     end

  select @w_bandera = 'S'
  commit tran

  if @w_bandera = 'S'
    begin
	/* Actualizacion de la los datos en el catalogo */
       	select @w_codigo_c = convert(varchar(10), @i_moneda)
	exec @w_return = sp_catalogo
		@s_ssn			   = @s_ssn,
		@s_user			   = @s_user,
		@s_sesn			   = @s_sesn,
		@s_term			   = @s_term,	
		@s_date			   = @s_date,	
		@s_srv			   = @s_srv,	
		@s_lsrv			   = @s_lsrv,	
		@s_rol			   = @s_rol,
		@s_ofi			   = @s_ofi,
		@s_org_err		   = @s_org_err,
		@s_error		   = @s_error,
		@s_sev			   = @s_sev,
		@s_msg			   = @s_msg,
		@s_org			   = @s_org,
		@t_debug		   = @t_debug,	
		@t_file			   = @t_file,
		@t_from		           = @w_sp_name,
		@t_trn			   = 585,
       		@i_operacion		   = 'U',
       		@i_tabla		   = 'cl_moneda',
       		@i_codigo		   = @w_codigo_c,
       		@i_descripcion 		   = @i_descripcion,
       		@i_estado	     	   = @i_estado	
	if @w_return != 0
		return @w_return
    end
/******************************* Para   Unix  ***************************/

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
		update #ad_nodo_reentry_tmp  set  nt_bandera = 'S'
		where nt_nombre  = @w_nt_nombre
	
		exec @w_return = @w_cmdtransrv  
					@t_trn         = @t_trn,           
					@i_operacion   = @i_operacion,
					@i_moneda      = @i_moneda,
					@i_descripcion = @i_descripcion,
					@i_pais        = @i_pais,
					@i_estado      = @i_estado,
					@i_decimales   = @i_decimales,
					@i_simbolo     = @i_simbolo,
					@i_central_transmit = 'S',
					@o_clave        = @w_clave out

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
/****************************** Para   Unix  **************************/

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
