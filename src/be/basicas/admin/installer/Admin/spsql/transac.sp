/************************************************************************/
/*	Archivo:		transac.sp				*/
/*	Stored procedure:	sp_transaccion				*/
/*	Base de datos:		cobis					*/
/*	Producto: Administracion					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 27-Nov-1992					*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Insercion de transaccion					*/
/*	Actualizacion del transaccion					*/
/*	Borrado del transaccion						*/
/*	Busqueda del transaccion					*/
/*	Query del transaccion						*/
/*	Ayuda del transaccion						*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/Nov/1992	L. Carvajal	Emision inicial			*/
/*      27/Abr/1993     M. Davila       Este stored procedure afecta a  */
/*					tabla cl_ttransaccion en vez de */
/*					a ad_transaccion		*/
/*	07/Jun/1993	M. Davila	Search sin error		*/
/*	22/Abr/94	F.Espinosa	Parametros tipo "S"		*/
/*					Transacciones de Servicio	*/
/*	08/May/95	S. Vinces       Admin Distribuido    		*/
/*	21/Oct/1998	B.Borja		Nueva version Admin: agregar	*/
/*					, tn_graba_log y                */
/*					tn_off_line			*/
/*	09/Ene/2001	C.Navas		Eliminar el doble insert en la  */
/*					tabla cl_trn_atrib              */
/*	12/Jun/2001	A.Duque		Inclusión del campo ta_tipo de  */
/*					tabla cl_trn_atrib              */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_transaccion')
   drop proc sp_transaccion
go

create proc sp_transaccion (
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
	@i_operacion		varchar(1),
	@i_tipo			varchar(1) = null,
	@i_modo			tinyint = null,
	@i_transaccion		int = null,
	@i_descripcion		descripcion = NULL,
	@i_nemonico		varchar(6) = null,
	@i_desc_larga		varchar (255) = null,
	@i_tipo_ejec		catalogo = null,
	@i_graba_log		char(1) = null,
	@i_off_line		char(1) = null,
	@i_central_transmit     varchar(1) = null,
--ADU: 2001-06-12
	@i_ta_tipo		catalogo = null
--FIN ADU
)
as
declare
	@w_today		datetime,
	@w_sp_name		varchar(32),
	@w_transaccion		int,
	@w_descripcion		descripcion,
	@w_nemonico		char(6),
	@w_desc_larga		varchar (255),
	@w_tipo_ejec		catalogo,
	@w_graba_log		char(1),
	@w_off_line		char(1),
	@v_transaccion		int,
	@v_descripcion		descripcion,
        @v_nemonico		char(6),
	@v_tipo_ejec		catalogo,
	@v_graba_log		char(1),
	@v_off_line		char(1),
	@o_descripcion		descripcion,
        @o_nemonico		char(6),
	@o_desc_larga		varchar (255),
	@o_tipo_ejec		catalogo,
	@o_desc_tejec		descripcion,
	@o_graba_log		char(1),
	@o_off_line		char(1),
	@w_siguiente		int,
	@w_fecha_ult_mod	datetime,
	@v_fecha_ult_mod	datetime,
	@v_desc_larga		varchar (255),
	@w_nt_nombre            varchar(32),
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_cmdtransrv		varchar(60),
	@w_return 		int,
	@w_clave		int,
--ADU: 2001-06-12
	@w_ta_tipo		catalogo,
	@v_ta_tipo		catalogo,
	@o_ta_tipo		catalogo,
	@o_ta_tipo_valor	descripcion
--FIN ADU


select @w_today = @s_date
select @w_sp_name = 'sp_transaccion'


/* Creacion de tabla temporal de nodos a distribuir */
/* Si esta en ambiente UNIX SYBASE                  */
   
if (@i_operacion = 'I' or @i_operacion = 'U' or @i_operacion = 'D' ) and (@i_central_transmit is NULL)
begin
 create table #ad_nodo_reentry_tmp (nt_nombre  varchar(60), nt_bandera char (1))
end

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 561
begin
 /* chequeo de claves foraneas */
  if (@i_descripcion is NULL OR @i_transaccion is NULL OR @i_nemonico is null)
 begin exec sp_cerror
           @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

 /*  Verifica que las claves sean unicas  */
 select	@w_transaccion = tn_trn_code,
	@w_nemonico = tn_nemonico
  from	cl_ttransaccion
 where	tn_trn_code = @i_transaccion
    or	tn_nemonico = @i_nemonico
 if @w_transaccion = @i_transaccion
 begin
	/*  Codigo de transaccion ya existe  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 151036
	return 1
 end
 else
 begin
	if @w_nemonico is not null
	begin
		/*  Nemonico de transaccion ya existe  */
		exec cobis..sp_cerror
			@t_debug= @t_debug,
			@t_file	= @t_file,
			@t_from	= @w_sp_name,
			@i_num	= 151037
		return 1
	end
 end

  begin tran
  /* @i_transaccion es de input */
    insert into cl_ttransaccion (tn_trn_code, tn_descripcion,
				 tn_nemonico, tn_desc_larga)
			values (@i_transaccion, @i_descripcion,
				@i_nemonico, @i_desc_larga)

--ADU: 2001-06-12
    insert into cl_trn_atrib (  ta_transaccion, ta_tipo_ejec,
				ta_graba_log, ta_off_line, ta_tipo)
			values ( @i_transaccion, @i_tipo_ejec,
				 @i_graba_log, @i_off_line, @i_ta_tipo)
--FIN ADU

   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153024
	   /*  'Error en insercion transaccion' */
	return 1
    end

   /* transaccion de servicio */
   insert into ts_transaccion (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       transaccion, descripcion, nemonico, 
			       desc_larga, tipo_ejec, graba_log, 
			       off_line, tipo)		--ADU: 2002-05-09
		       values (@s_ssn, 561, 'N', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_transaccion, @i_descripcion, @i_nemonico,
			       @i_desc_larga, @i_tipo_ejec, @i_graba_log,
			       @i_off_line, @i_ta_tipo)	--ADU: 2002-05-09
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end

  commit tran

  /******************************* Para   Unix  **************************/

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
					@i_transaccion = @i_transaccion,   
					@i_descripcion = @i_descripcion,   
					@i_nemonico    = @i_nemonico,
					@i_desc_larga  = @i_desc_larga,
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
if @t_trn = 562
begin
 /* control de campos de input */
  if (@i_transaccion is NULL OR @i_descripcion is NULL OR @i_nemonico is null)
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

--ADU: 2001-06-12
   select @w_descripcion = tn_descripcion,
         @w_nemonico    = tn_nemonico,
	 @w_desc_larga	= tn_desc_larga,
	 @w_tipo_ejec   = ta_tipo_ejec,
	 @w_graba_log   = ta_graba_log,
	 @w_off_line	= ta_off_line,
	 @w_ta_tipo	= ta_tipo
    from cl_ttransaccion, cl_trn_atrib
   where tn_trn_code = @i_transaccion
     and tn_trn_code = ta_transaccion
--FIN ADU

  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151007
	   /*  'No existe transaccion' */
	return 1
  end
  
  /* verificacion de campos a actualizar */
  select @v_descripcion = @w_descripcion,
	 @v_nemonico    = @w_nemonico,
	 @v_desc_larga	= @w_desc_larga,
	 @v_tipo_ejec   = @w_tipo_ejec,
	 @v_graba_log	= @w_graba_log,
	 @v_off_line	= @w_off_line,
	 @v_ta_tipo	= @w_ta_tipo
	 

  if @w_descripcion = @i_descripcion
   select @w_descripcion = null, @v_descripcion = null
  else
   select @w_descripcion = @i_descripcion
  if @w_nemonico = @i_nemonico
   select @w_nemonico = null, @v_nemonico = null
  else
   select @w_nemonico = @i_nemonico
  if @w_desc_larga = @i_desc_larga
   select @w_desc_larga = null, @v_desc_larga = null
  else
   select @w_desc_larga = @i_desc_larga
  if @w_tipo_ejec = @i_tipo_ejec
   select @w_tipo_ejec = null, @v_tipo_ejec = null
  else
   select @w_tipo_ejec = @i_tipo_ejec
  if @w_graba_log = @i_graba_log
   select @w_graba_log = null, @v_graba_log = null
  else
   select @w_graba_log = @i_graba_log
  if @w_off_line = @i_off_line
   select @w_off_line = null, @v_off_line = null
  else
   select @w_off_line = @i_off_line
  if @w_ta_tipo = @i_ta_tipo
   select @w_ta_tipo = null, @v_ta_tipo = null
  else
   select @w_ta_tipo = @i_ta_tipo


  begin tran
   Update cl_ttransaccion
      set tn_descripcion = @i_descripcion,
	  tn_nemonico    = @i_nemonico,
	  tn_desc_larga	 = @i_desc_larga
   where tn_trn_code = @i_transaccion
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155009
	   /*  'Error en actualizacion de transaccion' */
	return 1
    end

--ADU: 2001-06-12
   Update cl_trn_atrib
      set ta_tipo_ejec	 = @i_tipo_ejec,
	  ta_graba_log	 = @i_graba_log,
	  ta_off_line	 = @i_off_line,
	  ta_tipo	 = @i_ta_tipo
   where ta_transaccion   = @i_transaccion
--FIN ADU

   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 155009
	   /*  'Error en actualizacion de transaccion' */
	return 1
    end

  /* transaccion de servicio */
   insert into ts_transaccion (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       transaccion, descripcion, nemonico,
			       tipo_ejec, graba_log, off_line, tipo)			--ADU: 2002-05-09
		       values (@s_ssn, 562, 'P', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_transaccion, @v_descripcion, @v_nemonico,
			       @v_tipo_ejec, @v_graba_log, @v_off_line, @v_ta_tipo)	--ADU: 2002-05-09
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end

   /* transaccion de servicio */
   insert into ts_transaccion (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       transaccion, descripcion, nemonico,
			       desc_larga,tipo_ejec, graba_log, off_line, tipo)				--ADU: 2002-05-09
		       values (@s_ssn, 562, 'A', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_transaccion, @w_descripcion, @w_nemonico,
			       @w_desc_larga, @w_tipo_ejec, @w_graba_log, @w_off_line, @w_ta_tipo)	--ADU: 2002-05-09
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end
  commit tran

  /******************************* Para   Unix  **************************/

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
					@i_transaccion = @i_transaccion,   
					@i_descripcion = @i_descripcion,   
					@i_nemonico    = @i_nemonico,
					@i_desc_larga  = @i_desc_larga,
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


/* ** Delete ** */
if @i_operacion = 'D'
begin
if @t_trn = 563
begin
 /* chequeo de claves foraneas */
  if (@i_transaccion is NULL )
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151001
	   /*  'No se llenaron todos los campos' */
	return 1
  end

  select  @w_descripcion = tn_descripcion,
	  @w_nemonico    = tn_nemonico,
	  @w_desc_larga  = tn_desc_larga,
	  @w_tipo_ejec   = ta_tipo_ejec,
	  @w_graba_log   = ta_graba_log,
 	  @w_off_line	 = ta_off_line,
 	  @w_ta_tipo	 = ta_tipo			--ADU: 2002-05-09
    from cl_ttransaccion, cl_trn_atrib
   where tn_trn_code 	= @i_transaccion
     and ta_transaccion = tn_trn_code

  if @@rowcount = 0
  begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151007
	   /*  'No existe transaccion' */
	return 1
  end

  /* deteccion de referencias */
   if exists (
	select pt_transaccion
	  from ad_pro_transaccion
	 where pt_transaccion = @i_transaccion
	   and pt_estado = 'V')
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157020
	   /*  'Existe referencia de producto transaccion' */
	return 1
   end

  /* borrado de transaccion */
  begin tran
    Delete cl_ttransaccion
     where tn_trn_code = @i_transaccion

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157021
	   /*  'Error en eliminacion de transaccion' */
	return 1
   end

    Delete cl_trn_atrib
     where ta_transaccion = @i_transaccion

    if @@error != 0
    begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 157021
	   /*  'Error en eliminacion de transaccion' */
	return 1
   end

  /* transaccion de servicio */
   insert into ts_transaccion (secuencia, tipo_transaccion, clase, fecha,
		               oficina_s, usuario, terminal_s, srv, lsrv,
			       transaccion, descripcion, nemonico,
			       desc_larga,tipo_ejec, graba_log, 
			       off_line, tipo)				--ADU: 2002-05-09
		       values (@s_ssn, 563, 'B', @s_date,
		               @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
			       @i_transaccion, @w_descripcion, @w_nemonico,
			       @w_desc_larga, @w_tipo_ejec, @w_graba_log, 
			       @w_off_line, @w_ta_tipo) 		--ADU: 2002-05-09
   if @@error != 0
   begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 153023
	   /*  'Error en creacion de transaccion de servicio' */
	return 1
   end
  commit tran

  /******************************* Para   Unix  **************************/

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
					@i_transaccion = @i_transaccion,   
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


/* ** search ** */
if @i_operacion = 'S'
begin
If @t_trn = 15072
begin
     set rowcount 20
     if @i_modo = 0
     begin

--ADU: 2001-06-12
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 20),
		'Mnemonico' = tn_nemonico,
		'Tipo Ejec' = ta_tipo_ejec,
		'Graba Log' = ta_graba_log,
		'Off line' = ta_off_line,
		'Tipo'      = ta_tipo
         from   cl_ttransaccion, cl_trn_atrib
	where   ta_transaccion = tn_trn_code 
        order   by tn_trn_code
--FIN ADU

       set rowcount 0
     end
     if @i_modo = 1
     begin

--ADU: 2001-06-12
        select  'Codigo' = tn_trn_code,
                'Descripcion' = substring(tn_descripcion, 1, 20),
		'Mnemonico' = tn_nemonico,
		'Tipo Ejec' = ta_tipo_ejec,
		'Graba Log' = ta_graba_log,
		'Off line' = ta_off_line,
		'Tipo'      = ta_tipo
         from   cl_ttransaccion, cl_trn_atrib
	where   ta_transaccion = tn_trn_code 
		and tn_trn_code > @i_transaccion
	
        order   by tn_trn_code
--FIN ADU
       set rowcount 0
     end
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

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15073
begin
--ADU: 2001-06-12
	select	@o_descripcion = tn_descripcion,	
		@o_nemonico    = tn_nemonico,
		@o_desc_larga  = tn_desc_larga,	
		@o_tipo_ejec   = ta_tipo_ejec,
		@o_graba_log   = ta_graba_log,	
		@o_off_line    = ta_off_line,
		@o_ta_tipo     = ta_tipo
         from   cl_ttransaccion, cl_trn_atrib
	where   ta_transaccion = tn_trn_code 
		and tn_trn_code = @i_transaccion
--FIN ADU

	if @@rowcount = 0	
	begin	 exec sp_cerror
	   @t_debug	 = @t_debug,	
	   @t_file	 = @t_file,	
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151007	   /*  'No existe transaccion' */	
	 return 1	
	end
	select @o_desc_tejec  = substring(valor,1,20)	
	 from cl_tabla a, cl_catalogo b
	where a.tabla = 'cl_tipo_ejecucion'	
	  and a.codigo = b.tabla
	  and b.codigo = @o_tipo_ejec

	select @o_ta_tipo_valor  = substring(valor,1,20)	
	 from cl_tabla c, cl_catalogo d
	where c.tabla = 'ta_tipo'	
	  and c.codigo = d.tabla
	  and d.codigo = @o_ta_tipo 


	select @i_transaccion,
	 @o_descripcion, 
	 @o_nemonico,
	 @o_desc_larga,
         @o_tipo_ejec,
         @o_desc_tejec,
         @o_graba_log,
         @o_off_line,
        @o_ta_tipo ,
        @o_ta_tipo_valor

         return 0
	end
	else
	begin
	exec sp_cerror	   @t_debug	 = @t_debug,	
	 		   @t_file	 = @t_file,
 			   @t_from	 = @w_sp_name,	
			   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */	
	return 1
	end
end


/* ** help ** */
if @i_operacion = 'H'
begin
If @t_trn = 15074
begin
 if @i_tipo = 'A'
 begin
	 select   tn_trn_code, substring(tn_descripcion,1, 20),
		  tn_desc_larga
	   from	  cl_ttransaccion
	   order  by tn_trn_code
 end
 if @i_tipo = 'V'
 begin
	 select   tn_descripcion,
		  tn_desc_larga
	   from	  cl_ttransaccion
	  where   tn_trn_code = @i_transaccion
	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151007
	     /* 'No existe transaccion' */
	     return 1
	 end
 end

 if @i_tipo = 'H'
 begin
	 select   tn_trn_code, tn_nemonico,tn_descripcion
	 from	  cl_ttransaccion
	 order  by tn_trn_code

	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151007
	     /* 'No existe transaccion' */
	     return 1
	 end
 end

 if @i_tipo = 'J'
 begin
	select tn_nemonico,tn_descripcion
	from cl_ttransaccion
	where tn_trn_code = @i_transaccion

	 if @@rowcount = 0
	 begin
	   exec sp_cerror
	     @t_debug	  = @t_debug,
	     @t_file	  = @t_file,
	     @t_from	  = @w_sp_name,
	     @i_num	  = 151007
	     /* 'No existe transaccion' */
	     return 1
	 end
 end
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
