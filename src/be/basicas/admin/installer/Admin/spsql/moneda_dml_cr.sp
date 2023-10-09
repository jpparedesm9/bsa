/*************************************************************************/
/*	Archivo:		moneda_dml_cr.sql	                 */
/*	Stored procedure:	sp_moneda_dml_cr	                 */
/*	Base de datos:		cobis                                    */
/*	Producto: 	        CLIENTES                                 */
/*	Disenado por:  	        Pedro Rafael Montenegro Rosales          */
/*	Fecha de escritura:	09/Ago/2012                              */
/*********************************************************************** */
/*				IMPORTANTE                               */
/*********************************************************************** */
/*	Este programa es parte de los paquetes bancarios propiedad de    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la        */
/*	"NCR CORPORATION".			                         */
/*	Su uso no autorizado queda expresamente prohibido asi como       */
/*	cualquier alteracion o agregado hecho por alguno de sus          */
/*	usuarios sin el debido consentimiento por escrito de la          */
/*	Presidencia Ejecutiva de MACOSA o su representante.              */
/*********************************************************************** */
/*				PROPOSITO	                         */
/*********************************************************************** */
/*	Este stored procedure es un sp interceptor para las acciones de	 */
/*	creacion de un cliente, para verificar su estado de acuerdo a su */
/*	nacionalidad y especificar si tiene o no malas referencias       */
/*				MODIFICACIONES                           */
/*	FECHA		AUTOR		RAZON		NEMONICO         */
/*  11-04-2016  BBO          Migracion Sybase-Sqlserver FAL             */
/*************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_moneda_dml_cr')
   drop proc sp_moneda_dml_cr
go

create proc sp_moneda_dml_cr
(
	@s_ssn			int 		= NULL,
	@s_user			login 		= NULL,
	@s_sesn			int 		= NULL,
	@s_term			varchar(32) 	= NULL,
	@s_date			datetime 	= NULL,
	@s_srv			varchar(30) 	= NULL,
	@s_lsrv			varchar(30) 	= NULL, 
	@s_rol			smallint 	= NULL,
	@s_ofi			smallint 	= NULL,
	@s_org_err		char(1) 	= NULL,
	@s_error		int 		= NULL,
	@s_sev			tinyint 	= NULL,
	@s_msg			descripcion 	= NULL,
	@s_org			char(1) 	= NULL,
	@t_debug		char(1) 	= 'N',
	@t_file			varchar(14) 	= null,
	@t_from			varchar(32) 	= null,
	@t_trn			smallint 	= NULL,

	@t_show_version		bit         	= 0, -- Mostrar la version del programa  --(PRMR STANDAR)

        @i_operacion		varchar(2),
        @i_modo			tinyint 	= null,
        @i_tipo			varchar(2) 	= null,
        @i_moneda		tinyint 	= null,
        @i_descripcion   	descripcion 	= null,
        @i_pais			smallint 	= null,
        @i_estado		estado 		= null,
        @i_decimales     	varchar(1) 	= null,
	@i_simbolo		varchar (10) 	= null,
	@i_nemonico		varchar (10) 	= null,
        @i_central_transmit     varchar(1) 	= null, 
        @i_cod_ctaunico		char(1) 	= null
)
as
declare @w_codigo		int,
	@w_sp_name		varchar(32),
	@w_descripcion		descripcion,
	@w_pais 		smallint,
	@w_estado		estado,
        @w_decimales    	varchar(1),
        @w_return		int,	
        @w_simbolo		varchar(10),	
	@v_descripcion  	descripcion,
	@v_pais 		smallint,
	@v_estado		estado,
        @v_decimales    	varchar(1),
        @v_simbolo		varchar(10),	
	@o_moneda		tinyint,
	@w_codigo_c		varchar(10), 
	@w_bandera		varchar(1), 
        @w_cmdtransrv   	varchar(60),
	@w_server_logico    	varchar(10),
	@w_nt_nombre        	varchar(30),
	@w_num_nodos    	smallint,    
	@w_contador     	smallint,
	@w_clave		int,
	@w_cod_ctaunico		char(1),
	@v_cod_ctaunico		char(1)

	select @w_sp_name = 'sp_moneda_dml_cr'
	select @w_bandera = 'N'

	/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
	if @t_show_version = 1
	begin
		print 'Stored procedure ' +  @w_sp_name + '  Version 4.0.0.0'
		return 0
	end
	

/* ** Insert ** */
if @i_operacion = 'I'
begin
	if @t_trn = 1511
	begin
  		begin tran
	
		/* Update de moneda Insertada cl_moneda */
		update cobis..cl_moneda 
			set mo_cod_ctaunico = @i_cod_ctaunico
			where mo_moneda = @i_moneda

     		/* si no se puede insertar, error */
     		if @@error != 0 or @@rowcount = 0
     		begin
			/* 'Error en creacion de moneda'*/
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 101045
			return 101045
     		end

     		/* update en transaccion servicio - moneda */
     		update ts_moneda 
			set mo_cod_ctaunico =  @i_cod_ctaunico
			where secuencia = @s_ssn
			and tipo_transaccion = 1511
			and moneda = @i_moneda

     		/* si no se puede insertar transaccion de servicio, error */
     		if @@error != 0
     		begin
	  		/* 'Error en creacion de transaccion de servicios'*/
	  		exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 103005
	  		return 103005
     		end

  		select @w_bandera = 'S'
  		commit tran
 
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
		return 151051
	end
end


/* ** Update ** */
if @i_operacion = 'U'
begin
	if @t_trn = 1512
	begin
  
		/* guardar los datos que se modificaran */
		select @w_cod_ctaunico	= mo_cod_ctaunico
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
		       return 101045
		end

		select @v_cod_ctaunico = @w_cod_ctaunico
  
		if @w_cod_ctaunico = @i_cod_ctaunico
			select @w_cod_ctaunico = null, @v_cod_ctaunico = null
		else
			select @w_cod_ctaunico = @i_cod_ctaunico
  
		begin tran
     		/* Update moneda */
		update cobis..cl_moneda 
			set mo_cod_ctaunico = @i_cod_ctaunico
			where mo_moneda = @i_moneda

		/* si no se puede modificar, error */
		if @@error != 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 105023
				/* 'Error en actualizacion de moneda'*/
			return 105023
     		end

     		/* update transaccion servicios - moneda */
      		update ts_moneda 
			set mo_cod_ctaunico =  @i_cod_ctaunico
			where secuencia = @s_ssn
			and tipo_transaccion = 1512
			and clase = 'P'
			and moneda = @i_moneda

     		/* si no se puede insertar, error */
     		if @@error != 0
     		begin
			/* 'Error en creacion de transaccion de servicios'*/
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 103005
			return 103005
     		end

     		/* transaccion servicio - moneda */
 		/* update transaccion servicios - moneda */
      		update ts_moneda 
			set mo_cod_ctaunico =  @i_cod_ctaunico
			where secuencia = @s_ssn
			and tipo_transaccion = 1512
			and clase = 'A'
			and moneda = @i_moneda

     		/* si no se puede insertar, error */
     		if @@error != 0
		begin
			exec sp_cerror
				@t_debug	= @t_debug,
				@t_file		= @t_file,
				@t_from		= @w_sp_name,
				@i_num		= 103005
			/* 'Error en creacion de transaccion de servicios'*/
			return 103005
		end

		select @w_bandera = 'S'
		commit tran

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
		return 151051
	end
end
go
