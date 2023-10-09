/******************************************************************************/
/* Archivo:            b2c_enrola.sp                                          */
/* Stored procedure:   sp_b2c_enrola                                          */
/* Producto:           VIRTUAL BANKING                                        */
/******************************************************************************/
/*                                 IMPORTANTE                                 */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.   */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier       */
/* alteracion o agregado hecho por alguno de usuarios sin el debido           */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp        */
/* o su representante.                                                        */
/******************************************************************************/
/*                                PROPOSITO                                   */
/* Valida que el clienteno tenga un login creado, inserta la información del  */
/* cliente  para el autoenrolamiento                                          */
/******************************************************************************/
/*                                MODIFICACIONES                              */
/******************************************************************************/
/* FECHA        VERSION  AUTOR               RAZON                            */
/******************************************************************************/
/* 22-Nov-2018           ERA              Emision inicial                     */
/* 05-Feb-2019           ERA              Se actualiza                        */
/* 18-Oct-2019           Jonathan R       Agrega registro log B2C             */
/******************************************************************************/
use cob_bvirtual
go
if object_id('sp_b2c_enrola') is not null
    drop proc sp_b2c_enrola
go
create proc sp_b2c_enrola(
	@s_ssn           int          = null,
	@s_sesn          int          = null,
	@s_date          datetime     = null,
	@s_user          varchar(14)  = null,
	@s_term          varchar(30)  = null,
	@s_ofi           smallint     = null,
	@s_srv           varchar(30)  = null,
	@s_lsrv          varchar(30)  = null,
	@s_rol           smallint     = null,
	@s_org           varchar(15)  = null,
	@s_culture       varchar(15)  = null,
	@t_rty           char(1)      = null,
	@t_debug         char(1)      = 'N',
	@t_file          varchar(14)  = null,
	@t_trn           int          = null,
	@i_dir_origen    varchar(128) = null,
	@i_enente        int,
	@i_password      varchar(64),
	@i_telefono      varchar(30),
	@i_servicio      tinyint      = null,
	@i_cultura       varchar(15)  = null,
	@i_telefono_ant  varchar(16)  = null,
	--
	@i_marca_telef   varchar(255) = null,
	@i_modelo_telef	 varchar(255) = null,
	@i_version_os    varchar(255) = null,
	@i_carrier		 varchar(255) = null,	
	--
	@o_siguiente     int          = null out
	)
	as
	declare @w_return         int,
		@w_sp_name            varchar(30),
        @w_version            char(8),
		@w_fecha_proceso      datetime,
		@w_login              varchar(64), 
		@w_tipo				  char(60),
		@w_cedularuc          varchar (30),
		@w_fecha_ingreso      varchar (10),
		@w_nombre             varchar (64),
        @w_fechanac           datetime ,
        @w_categoria          varchar (10),
        @w_sector             varchar (10),
        @w_lenguaje           varchar (10),
        @w_oficina            smallint,
        @w_notificacion       char (1),
        @w_oficial            smallint,
        @w_autorizado         char(1),
        @w_uso_convenio       varchar(10),
        @w_direccion          varchar(64),
        @w_pnombre            varchar(32),
        @w_papellido          varchar(32),
        @w_sapellido          varchar(32),
        @w_segmento           varchar(10),
        @w_linea_negocio      varchar(10),
        @w_apoderado          int,
        @w_tipo_autorizacion  char(1),
		@w_origen_ente        char(1),
		@w_grupo              int,
		@w_sec_telef          int,
		@w_ente               int
		
			
	select @w_sp_name = 'sp_enrolamiento_bv',
           @w_version  = '1.0.0.0'
	
	------- INTERNACIONALIZACION ------
	EXEC cobis..sp_ad_establece_cultura
	@o_culture = @s_culture OUT
	-----------------------------------
	
	select @i_cultura = isnull(@s_culture, @i_cultura )
	select @s_user = isnull('b2cuser',@s_user)
	select @w_fecha_proceso = fp_fecha
	from cobis..ba_fecha_proceso
	
	select @w_ente = en_ente
	from cob_bvirtual..bv_ente 
	where en_ente_mis = @i_enente

	select @w_login = lo_login
	from cob_bvirtual..bv_login, cob_bvirtual..bv_ente 
	where lo_ente   = en_ente 
	and en_ente_mis = @i_enente
	and lo_servicio = @i_servicio
	and lo_estado = 'A'

	if @@rowcount > = 1  
	begin
			/*
		exec cobis..sp_cerror --Se comenta po9r pedido del cliente.
		@t_from       = @w_sp_name,
		@i_num        = 1850065
		set rowcount 0
		return 1 */
		update cob_bvirtual..bv_login
		set lo_estado ='B'
		where lo_ente =  @w_ente
		and lo_servicio = @i_servicio
		and lo_estado = 'A'
    end 
	
	select 
	    @w_tipo               = en_subtipo,
		@w_cedularuc          = en_ced_ruc,
		@w_nombre             = en_nombre,
        @w_fechanac           = p_fecha_nac,
        @w_categoria          = en_categoria,
        @w_sector             = en_sector,
        @w_lenguaje           = @s_culture,
        @w_oficina            = en_oficina,
        @w_notificacion       = 'S',
        @w_oficial            = en_oficial,
        @w_autorizado         = 'S',
        @w_uso_convenio       = 'N',
        @w_direccion          = en_direccion,
        @w_pnombre            = p_s_nombre,
        @w_papellido          = p_p_apellido,
        @w_sapellido          = p_s_apellido,
        @w_segmento           = c_segmento,
        @w_linea_negocio      = null,
        @w_apoderado          = null,
        @w_tipo_autorizacion  = null,
		@w_origen_ente        = 'B',
		@w_grupo              = en_grupo
	from cobis..cl_ente
	where en_ente = @i_enente
	
	if @@rowcount = 0  
	begin
		exec cobis..sp_cerror
		@t_from       = @w_sp_name,
		@i_num        = 70218
		set rowcount 0
		return 1
    end 
	/*
	if exists (select 1
				from cob_bvirtual..bv_ente
				where en_ente_mis = @i_enente
				and en_tipo     =  @w_tipo
				and @w_tipo <> 'G')
	begin
		/* Ente ya registrado */
	/*	exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1850119
		return 1850119
	end
    */
	if exists (select 1
				from cob_bvirtual..bv_ente
				where en_ced_ruc = @w_cedularuc
				and en_origen_ente is null
		and @w_tipo <> 'G')
	begin
	/* Ente ya registrado */
	    exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1850119
		return 1850119
	end

  
	if exists (select 1
				from cob_bvirtual..bv_ente
				where en_ente_mis = @i_enente
				or en_ced_ruc = @w_cedularuc)
	begin
	/* Ente ya registrado */
	    exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1850119
		return 1850119
	end
*/
	if len(rtrim(ltrim(@i_telefono))) !=10 --Numero de digitos de celular en Mexico
	begin
	/* Telefono no válido */
	    exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1890016
		return 1890016
	end
	

	
	begin tran 
			
		if @i_telefono_ant is not null 
		begin
			update cobis..cl_telefono
			set te_valor = @i_telefono
			where te_tipo_telefono = 'C'
			and te_ente = @i_enente
			and te_valor = @i_telefono_ant
			
			if @@error != 0
			begin
			  /*Error en la actualizacion de telefono*/
			  rollback tran
			  exec cobis..sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 105035
			  return 105035
			end
		end
		else
		begin
			select @w_sec_telef = isnull(max(te_secuencial), 0) + 1 from cobis..cl_telefono where te_ente = @i_enente
			if not exists (Select 1 from cobis..cl_telefono where te_tipo_telefono = 'C'
				and te_ente = @i_enente
				and te_valor = @i_telefono_ant) 
			begin
				insert into cobis..cl_telefono (te_valor, te_tipo_telefono, te_ente, te_direccion, te_secuencial)
				values (@i_telefono,'C', @i_enente, 2, @w_sec_telef)
				if @@error != 0
				begin
				  /*Error en la actualizacion de telefono*/
				  rollback tran
				  exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 105035
				  return 105035
				end
				
			end
		end
		if @w_ente is not null 
		begin --Cliente recuperacion de ente
			update bv_ente
			set en_nombre          = @w_nombre,
				en_pnombre         = @w_pnombre,
				en_papellido       = @w_papellido,
				en_sapellido       = @w_sapellido,
				en_fecha_mod       = @s_date,
				en_fecha_nac       = @w_fechanac,
				en_ced_ruc         = @w_cedularuc,
				en_categoria       = @w_categoria,
				en_tipo            = @w_tipo,
				en_sector          = @w_sector,
				en_lenguaje        = @w_lenguaje,
				en_oficina         = @w_oficina,
				en_notificaciones  = @w_notificacion, 
				en_oficial         = @w_oficial,
				en_autorizado      = @w_autorizado,
				en_origen_ente     = @w_origen_ente,
				en_uso_convenio    = @w_uso_convenio,
				en_email           = @w_direccion,
				en_grupo           = @w_grupo,
				en_segmento        = @w_segmento,
				en_linea_negocio   = @w_linea_negocio,
				en_apoderado_legal = @w_apoderado,
				en_tipo_autoriza   = @w_tipo_autorizacion
			where en_ente_mis = @i_enente
			if @@error != 0  
			begin  
			  -- Error en la actualizacion en bv_ente
			  exec cobis..sp_cerror 
			  @t_from  = @w_sp_name,  
			  @i_num   = 1850031 
			  rollback tran
			  return 1  
			end  
			
			insert into ts_ente (  
			   secuencial, tipo_transaccion, clase,  
			   fecha, usuario, terminal,  
			   oficina, tabla, lsrv,  
			   srv, ente, ente_mis,  
			   nombre, fecha_mod,  
			   fecha_nac, ced_ruc, categoria,  
			   tipo, sector, lenguaje, 
			   oficina_ente, notificacion, oficial, 
			   autorizado, origen_ente, uso_convenio)  
			   values (  
			   @s_ssn, @t_trn, 'U',  
			   @s_date, @s_user, @s_term,  
			   0, 'bv_ente', @s_lsrv,  
			   @s_srv, @w_ente, @i_enente,  
			   @w_nombre, @s_date,  
			   @w_fechanac, @w_cedularuc, @w_categoria,  
			   @w_tipo, @w_sector, @w_lenguaje, 
			   @w_oficina, @w_notificacion, @w_oficial, 
			   @w_autorizado, @w_origen_ente, 'N')
			if @@error != 0  
			begin  
			  -- Error en la insercion en la tabla de servicio
			  exec cobis..sp_cerror  
				  @t_from  = @w_sp_name,  
				  @i_num   = 1850034  
			  rollback tran
			  return 1850034  
			end 

			if exists (select 1
								from bv_login, bv_ente
								where lo_ente = en_ente
								and en_ente_mis = @i_enente
								and lo_servicio = @i_servicio
								and lo_estado = 'B')
			begin	
				select @w_login = lo_login
				from cob_bvirtual..bv_login, cob_bvirtual..bv_ente 
				where lo_ente   = en_ente 
				and en_ente_mis = @i_enente
				and lo_servicio = @i_servicio
				and lo_estado = 'B'
						
				if @w_login != @i_telefono -- Se cambian a estado E los logines anteriores puesto que el num de telefono cambio
				begin
					update bv_login
					set lo_fecha_mod         = @s_date, 
						lo_hora              = getdate(), 
						lo_estado            = 'E'
					where lo_login = @w_login
					and lo_ente = @w_ente
					and lo_servicio = @i_servicio
					
					insert into ts_login(
						secuencial, cod_alterno, tipo_transaccion,
						clase, fecha, usuario,
						terminal, oficina, tabla,
						lsrv, srv, ente,
						servicio, login, clave_temp,
						clave_def, fecha_mod, tipo_vigencia, 
						dias_vigencia, renovable, hora, 
						descripcion,autorizado    --BBO 17-02-2000
						)
					  values (
						@s_ssn, 5, @t_trn,
						'E', @s_date, @s_user, 
						@s_term, @s_ofi, 'bv_login', 
						@s_lsrv, @s_srv, @w_ente, 
						@i_servicio, @w_login, @i_password, 
						@i_password, @s_date,'I',
						null, 'S', convert(varchar(8), getdate(),108), 
						@w_nombre, @w_autorizado)  --BBO 17-02-2000

					  if @@error != 0
					  begin
					  -- Error en la insercion en la tabla de servicio
						 exec cobis..sp_cerror
						  @t_from  = @w_sp_name,
						  @i_num   = 1850034
						rollback tran
						return 1
					  end			
				end
				
				if exists (select 1
					from cob_bvirtual..bv_login
					where lo_login = @i_telefono
					and lo_ente != @w_ente
					and lo_estado !='E')
				begin
				/* Login ya existe */
					exec cobis..sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 1890015
					rollback tran
					return 1890015
				end
				
				if exists (select 1
						from bv_login
						where lo_ente = @w_ente
						and lo_servicio = @i_servicio
						and lo_login = @i_telefono)					
				begin 
					update bv_login
					set lo_clave_temp        = @i_password, 
						lo_clave_def         = @i_password, 
						lo_fecha_mod         = @s_date, 
						lo_tipo_vigencia     = 'I',
						lo_dias_vigencia     = null,
						lo_renovable         = 'S', 
						lo_fecha_ult_pwd     = @s_date,
						lo_hora              = getdate(), 
						lo_descripcion       = @w_nombre, 
						lo_autorizado        = @w_autorizado,
						lo_estado            = 'A',
						lo_tipo_autorizacion = 'A', 
						lo_autoriz_imp       = 'S',
						lo_afiliador         = @s_user, 
						lo_oficina           = @s_ofi,  
						lo_cultura           = @i_cultura,
						lo_clave_mail        = 0,
						lo_tip_envio         = 'I'
					where lo_login = @i_telefono
					and lo_ente = @w_ente
					and lo_servicio = @i_servicio
					
					insert into ts_login(
						secuencial, cod_alterno, tipo_transaccion,
						clase, fecha, usuario,
						terminal, oficina, tabla,
						lsrv, srv, ente,
						servicio, login, clave_temp,
						clave_def, fecha_mod, tipo_vigencia, 
						dias_vigencia, renovable, hora, 
						descripcion,autorizado    --BBO 17-02-2000
						)
					  values (
						@s_ssn, 5, @t_trn,
						'U', @s_date, @s_user, 
						@s_term, @s_ofi, 'bv_login', 
						@s_lsrv, @s_srv, @w_ente, 
						@i_servicio, @w_login, @i_password, 
						@i_password, @s_date,'I',
						null, 'S', convert(varchar(8), getdate(),108), 
						@w_nombre, @w_autorizado)  --BBO 17-02-2000

					  if @@error != 0
					  begin
					  -- Error en la insercion en la tabla de servicio
						 exec cobis..sp_cerror
						  @t_from  = @w_sp_name,
						  @i_num   = 1850034
						rollback tran
						return 1
					  end
					  
					delete from cob_bvirtual..bv_in_login 
					where il_login = @i_telefono
					
				end
				else 
				begin
				
					insert into bv_login
					  (lo_ente, lo_servicio, lo_login,
					   lo_clave_temp, lo_clave_def, lo_fecha_reg,
					   lo_fecha_mod, lo_tipo_vigencia,lo_dias_vigencia,
					   lo_parametro,lo_renovable, lo_fecha_ult_pwd,
					   lo_hora, lo_descripcion, lo_autorizado,lo_estado,
					   lo_tipo_autorizacion, lo_motivo_reimp, lo_clave_gen, lo_clave_imp, 
					   lo_carga_pagina, lo_fecha_ult_int, lo_fecha_ult_ing, lo_empresa, 
					   lo_autoriz_imp, lo_afiliador, lo_oficina,  
					   lo_cultura,lo_clave_mail,lo_tip_envio)
					values
					  (@w_ente, @i_servicio, @i_telefono,
					   @i_password, @i_password, @s_date,
					   @s_date, 'I', null,
					   null, 'S', @s_date,
					   getdate(), @w_nombre, @w_autorizado,'A',
					   'A', '0', 0, 0, 
					   'C', null, @s_date, null, 
					   'S', @s_user, @s_ofi,  
					   @i_cultura,0,'I')

					if @@error != 0
					begin
					  /* Error en la insercion de logines */
					  rollback tran
					  exec cobis..sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 1850064
					  return 1850064
					end  
					insert into ts_login(
					  secuencial, cod_alterno, tipo_transaccion, clase, fecha,
					  usuario, terminal, oficina, tabla, 
					  lsrv, srv, ente, servicio, 
					  login, clave_temp, clave_def, fecha_reg, 
					  fecha_mod, fecha_ult_pwd, tipo_vigencia, dias_vigencia, parametro, 
					  renovable, hora, descripcion, estado, 
					  autorizado,  tipo_autorizacion,
					  motivo_reimp, num_clave_gen, num_clave_imp, carga_pagina, 
					  fecha_ult_int, empresa, sucursal,  afiliador, lenguaje)
					values (
					  @s_ssn,0,@t_trn,'I',@s_date,
					  @s_user, @s_term,@s_ofi, 'bv_login',
					  @s_lsrv, @s_srv, @o_siguiente, @i_servicio,
					  @i_telefono, @i_password, null, @s_date,
					  @s_date,  @s_date, 'I',null,null,
					  'S', convert(varchar(8),getdate(),108), @w_nombre,'A',
					  @w_autorizado, 'A', 
					  '0', 0, 0,'C', 
					  null, null, @s_ofi, @s_user, @i_cultura)

					if @@error != 0
					begin
						rollback tran
					  /*Error en la insercion en la tabla de servicio*/
					  exec cobis..sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 1850034
					  return 1850034
					end 
				end
			end	
			--------------------------------------------------------
			--insercion a la tabla  cob_bvirtual..bv_info_device
			--------------------------------------------------------
			insert into cob_bvirtual..bv_info_device (
						in_sequential, in_ente_cli,	 in_login       ,in_brand_device, in_model_device,    
						in_version_os, 	in_carrier,  in_date_register)
				values(	@s_ssn ,        @w_ente   ,  @i_telefono    ,@i_marca_telef,  @i_modelo_telef,
						@i_version_os,  @i_carrier,    getDate()    )
			if @@error != 0
			begin
			-- Error en la insercion 
				rollback tran
				exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 150000
				return 150000
			end
			--			
		end
		else
		begin	-- Cliente Nuevo
			exec cobis..sp_cseqnos
			   @i_tabla = 'bv_ente',
			   @o_siguiente = @o_siguiente out

			if @o_siguiente is null
			begin
			/* No existe tabla en tabla de secuenciales*/
				exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 2101007
				return 2101007
			end
		
			insert into bv_ente
			 (en_ente, en_nombre, en_pnombre, en_papellido, en_sapellido, en_fecha_reg,
			  en_fecha_mod ,en_fecha_nac,  en_ced_ruc,
			  en_categoria, en_tipo, en_ente_mis,
			  en_sector, en_lenguaje, en_oficina,
			  en_notificaciones, en_oficial, en_usuario,
			  en_autorizado, en_origen_ente, en_uso_convenio, 
			  en_email, en_grupo,en_segmento, en_linea_negocio,en_apoderado_legal, en_tipo_autoriza)
			values
			  (@o_siguiente, @w_nombre, @w_pnombre, @w_papellido, @w_sapellido, @s_date,
			   @s_date, @w_fechanac, @w_cedularuc ,
			   @w_categoria, @w_tipo , @i_enente,
			   @w_sector, @w_lenguaje, @w_oficina,
			   @w_notificacion, @w_oficial, @s_user,
			   @w_autorizado, @w_origen_ente, @w_uso_convenio, 
			   @w_direccion, @w_grupo,@w_segmento,@w_linea_negocio,@w_apoderado, @w_tipo_autorizacion)
			if @@error != 0
			begin
			-- Error en la insercion en bv_ente
				rollback tran
				exec cobis..sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 1850030
				return 1850030
			end
		

		select @w_fecha_ingreso = convert(varchar(10), @s_date, 101)

		insert into ts_ente (
		  secuencial, tipo_transaccion, clase,
		  fecha, usuario, terminal,
		  oficina, tabla, lsrv,
		  srv, ente, ente_mis,
		  nombre, fecha_reg, fecha_mod,
		  fecha_nac, ced_ruc, categoria,
		  tipo, sector, lenguaje,
		  oficina_ente, notificacion, oficial,
		  autorizado, origen_ente, uso_convenio, 
		  email,segmento, linea_negocio,
		  apoderado, hora, tipo_autorizacion)
		  values (
		  @s_ssn,@t_trn,'I',
		  @s_date, @s_user, @s_term,
		  @s_ofi, 'bv_ente', @s_lsrv,
		  @s_srv, @o_siguiente, @i_enente,
		  @w_nombre , @s_date, @s_date,
		  @w_fechanac, @w_cedularuc, @w_categoria,
		  @w_tipo , @w_sector, @w_lenguaje,
		  @w_oficina, @w_notificacion, @w_oficial,
		  @w_autorizado, @w_origen_ente, @w_uso_convenio, 
		  @w_direccion,@w_segmento,@w_linea_negocio,
		  @w_apoderado, getdate(), @w_tipo_autorizacion)
		  
		if @@error != 0
		begin
		 -- Error en la insercion en la tabla de servicio
		 rollback tran
			exec cobis..sp_cerror
				  @t_from  = @w_sp_name,
				  @i_num   = 1850034
			return 1850034
		end 
		
		if exists (select 1 from bv_login
				 where lo_login    = @i_telefono
				   and lo_servicio = @i_servicio
				   and lo_estado  <>  'E')
					--and @i_tipo_cliente   = 'P')
		begin
		-- Login ya existe
			-- return 0
			rollback tran
			exec cobis..sp_cerror
				@t_from       = @w_sp_name,
				@i_num        = 1850065
			return 1850065
		end	
		
		insert into bv_login
		  (lo_ente, lo_servicio, lo_login,
		   lo_clave_temp, lo_clave_def, lo_fecha_reg,
		   lo_fecha_mod, lo_tipo_vigencia,lo_dias_vigencia,
		   lo_parametro,lo_renovable, lo_fecha_ult_pwd,
		   lo_hora, lo_descripcion, lo_autorizado,lo_estado,
		   lo_tipo_autorizacion, lo_motivo_reimp, lo_clave_gen, lo_clave_imp, 
		   lo_carga_pagina, lo_fecha_ult_int, lo_fecha_ult_ing, lo_empresa, 
		   lo_autoriz_imp, lo_afiliador, lo_oficina,  
		   lo_cultura,lo_clave_mail,lo_tip_envio)
		values
		  (@o_siguiente, @i_servicio, @i_telefono,
		   @i_password, @i_password, @s_date,
		   @s_date, 'I', null,
		   null, 'S', @s_date,
		   getdate(), @w_nombre, @w_autorizado,'A',
		   'A', '0', 0, 0, 
		   'C', null, @s_date, null, 
		   'S', @s_user, @s_ofi,  
		   @i_cultura,0,'I')

		if @@error != 0
		begin
		  /* Error en la insercion de logines */
		  rollback tran
		  exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1850064
		  return 1850064
		end
		
		insert into ts_login(
		  secuencial, cod_alterno, tipo_transaccion, clase, fecha,
		  usuario, terminal, oficina, tabla, 
		  lsrv, srv, ente, servicio, 
		  login, clave_temp, clave_def, fecha_reg, 
		  fecha_mod, fecha_ult_pwd, tipo_vigencia, dias_vigencia, parametro, 
		  renovable, hora, descripcion, estado, 
		  autorizado,  tipo_autorizacion,
		  motivo_reimp, num_clave_gen, num_clave_imp, carga_pagina, 
		  fecha_ult_int, empresa, sucursal,  afiliador, lenguaje)
		values (
		  @s_ssn,0,@t_trn,'I',@s_date,
		  @s_user, @s_term,@s_ofi, 'bv_login',
		  @s_lsrv, @s_srv, @o_siguiente, @i_servicio,
		  @i_telefono, @i_password, null, @s_date,
		  @s_date,  @s_date, 'I',null,null,
		  'S', convert(varchar(8),getdate(),108), @w_nombre,'A',
		  @w_autorizado, 'A', 
		  '0', 0, 0,'C', 
		  null, null, @s_ofi, @s_user, @i_cultura)

		if @@error != 0
		begin
			rollback tran
		  /*Error en la insercion en la tabla de servicio*/
		  exec cobis..sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 1850034
		  return 1850034
		end 
		--------------------------------------------------------
		--insercion a la tabla  cob_bvirtual..bv_info_device
		--------------------------------------------------------
		insert into cob_bvirtual..bv_info_device (
					in_sequential,  in_ente_cli  ,	in_login       ,in_brand_device , in_model_device,    
					in_version_os, 	in_carrier   ,  in_date_register)
			values(	@s_ssn       ,   @o_siguiente,  @i_telefono    ,@i_marca_telef  ,  @i_modelo_telef,
					@i_version_os,     @i_carrier,    getDate()    )
		
		if @@error != 0
		begin
		-- Error en la insercion 
			rollback tran
			exec cobis..sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 150000
			return 150000
		end					
	end

	exec cob_bvirtual..sp_b2c_registro_transacciones
			@s_ssn = @s_ssn,
			@s_lsrv = @s_lsrv,
			@s_date = @s_date,
			@i_tipo_tran = @t_trn,
			@i_login = @i_telefono,
			@i_ip_origen = @i_dir_origen
	commit tran
 
return 0

go