/************************************************************************/
/*	Archivo: 		ctapresu.sp  			        */
/*	Stored procedure: 	sp_cuenta_presu				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo  	        	*/
/*	Fecha de escritura:     11-Octubre-1994				*/
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
/*	   Mantenimiento al catalogo de Cuentas de Presupuesto          */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	11/Oct/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cuenta_presu')
	drop proc sp_cuenta_presu  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cuenta_presu (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		tinyint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa              tinyint = null,
	@i_cuenta   		cuenta = null,
	@i_cuenta_padre   	cuenta= null,
	@i_nombre		descripcion = null,
	@i_descripcion  	descripcion= null,
	@i_estado       	char(1) = null ,
	@i_movimiento		char(1) = null,
	@i_nivel_cuenta		tinyint = null,
	@i_categoria		char(10) = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_cuenta   		char(16),
	@w_cuenta_padre   	char(16),
	@w_moneda_base		tinyint ,
	@w_movimiento2		char(1),
	@w_estado_ant		char(1), 
	@w_flag1		int,
	@w_menor		tinyint,
	@w_empresa		tinyint,
	@w_nomemp		descripcion,
	@w_nombre		descripcion,
	@w_nivel_cuenta		tinyint,
	@w_categoria		char(10),
	@w_descripcion		descripcion,
	@w_estado		char(1),
	@w_estado_padre		char(1),
	@w_movimiento		char(1),
	@w_existe		int		/* codigo existe = 1 
						no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_cuenta_presu'


/************************************************/
/*  Tipo de Transaccion = 601X 			*/

if (@t_trn <> 6561 and @i_operacion = 'I') or
   (@t_trn <> 6562 and @i_operacion = 'U') or
   (@t_trn <> 6563 and @i_operacion = 'D') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end
/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa 	= @i_empresa,
		i_cuenta   	= @i_cuenta ,
		i_cuenta_padre  = @i_cuenta_padre ,
		i_nombre	= @i_nombre ,
		i_descripcion  	= @i_descripcion,
		i_estado       	= @i_estado, 
		i_movimiento	= @i_movimiento,
		i_nivel_cuenta	= @i_nivel_cuenta,
		i_categoria	= @i_categoria 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select  @w_empresa = cup_empresa,
		@w_cuenta = cup_cuenta,
		@w_cuenta_padre = cup_cuenta_padre,
		@w_nombre = cup_nombre,
		@w_descripcion = cup_descripcion,
		@w_estado = cup_estado,
		@w_movimiento = cup_movimiento,
		@w_nivel_cuenta = cup_nivel_cuenta,
		@w_categoria = cup_categoria 
	from cob_conta..cb_cuenta_presupuesto
	where 	cup_empresa = @i_empresa and 
		cup_cuenta = @i_cuenta

	if @@rowcount > 0
	begin
		select @w_existe = 1,
			@w_estado_ant = @w_estado 
	end
	else
		select @w_existe = 0

end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin

	/* Validacion de datos */
	/***********************/

	if 	@i_empresa is null or @i_cuenta is null or 
		@i_nombre  is null or 
		@i_estado  is null  or 
		@i_nivel_cuenta is null or @i_categoria is null 
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

/**** Integridad Referencial *****/
/*********************************/
	if @i_nivel_cuenta > 1 
	begin
		select @w_movimiento2 = cup_movimiento,
			@w_estado_padre = cup_estado
		from cb_cuenta_presupuesto
		where cup_empresa  = @i_empresa and
			cup_cuenta = @i_cuenta_padre

		if @@rowcount = 0
		begin
			/* 'No existe Nivel Superior de cuenta especificado' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601023
			return 1
		end
	end
	else
		select @w_estado_padre = @i_estado
	
        if NOT EXISTS (select * from cob_conta..cb_empresa
			where  em_empresa = @i_empresa)
	begin
		/* 'No existe empresa' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

        if NOT EXISTS (select * from cb_nivel_presupuesto
			where  np_empresa   = @i_empresa and
				np_nivel_presupuesto = @i_nivel_cuenta
			)
	begin
		/* 'No existe Nivel de Cuenta  especificado' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601034
		return 1
	end
end


/* Insercion de cuenta */
/*************************/

if @i_operacion = 'I'
begin

	if @w_existe = 1 
	begin
		/* 'Codigo de cuenta de presupuesto ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601141
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cob_conta..cb_cuenta_presupuesto
		(cup_empresa,cup_cuenta,cup_cuenta_padre,cup_nombre,
		cup_descripcion, cup_estado,cup_movimiento,cup_nivel_cuenta,
		cup_categoria )
		values (@i_empresa,@i_cuenta,@i_cuenta_padre,
			@i_nombre, @i_descripcion, @w_estado_padre,
			@i_movimiento, @i_nivel_cuenta,
			@i_categoria
			)
		if @@error <> 0 
		begin
			/* 'Error en insercion de Cuenta de presupuesto ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603053
			return 1
		end

	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_cuenta_presupuesto
	values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		@i_empresa,@i_cuenta,@i_descripcion,@i_estado,
		@i_movimiento,@i_categoria)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end
	/****************************************/


	update cob_conta..cb_cuenta_presupuesto
	set cup_movimiento = 'N'
	where cup_empresa = @i_empresa and
		cup_cuenta = @i_cuenta_padre

	if @@error <> 0
	begin
		/* 'Error en actualizacion de movimiento en cuenta superior' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603042
		return 1
	end



	commit tran
	return 0
end

/* Actualizacion de cuenta  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de Cuenta a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605013
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/
	if @i_movimiento = 'S' 
	begin
		if exists(select * from cb_cuenta_presupuesto
			 where cup_cuenta_padre = @i_cuenta)
		begin
		/* 'Cuenta No puede ser de movimiento'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605064
			return 1
		end
	end


	begin tran
		update cob_conta..cb_cuenta_presupuesto
		set 	cup_cuenta_padre = @i_cuenta_padre,
			cup_nombre = @i_nombre,
			cup_descripcion = @i_descripcion,
			cup_estado = @i_estado,
			cup_nivel_cuenta = @i_nivel_cuenta,
			cup_categoria = @i_categoria,
			cup_movimiento = @i_movimiento
		where  	cup_empresa = @i_empresa and
			cup_cuenta = @i_cuenta

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Cuenta  de presupuesto'*/ 
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605073
			return 1
		end

		if @w_estado_ant <> @i_estado
		begin
			if @w_estado_padre = 'C' and @i_estado <> 'C'
			begin
				/* 'Nivel Superior de Cuenta esta Cancelado '*/ 
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 605033
				return 1
			end
			update cob_conta..cb_cuenta_presupuesto
			set cup_estado = @i_estado
			where cup_cuenta like @i_cuenta + '%'

			if @@error <> 0
			begin
			/* 'Error en la actualizacion de estado en niveles inferiores de la cueta'*/ 
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 605034
				return 1
			end

		end

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Cuenta de presupuesto'*/ 
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605073
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_presupuesto
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_cuenta,@w_descripcion,@w_estado,
			@w_movimiento,@w_categoria)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
		insert into ts_cuenta_presupuesto 
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_cuenta,@i_descripcion,@i_estado,
			@i_movimiento,@i_categoria)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end

	commit tran
	return 0
end

/* Eliminacion de cuenta  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de Cuenta a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607021
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

       	/* Si codigo de cuenta existe en catalogo Plan General
	   No se puede eliminar la cuenta */

     	if EXISTS (select pgp_cuenta
		from cob_conta..cb_plan_general_presupuesto
		where pgp_cuenta = @i_cuenta 
		)
	begin
		/* 'Codigo de Cuenta relacionada con Plan General Presupuesto'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607112
		return 1
	end


	/* Si codigo de cuenta a eliminar es padre de una cuenta
	   existente, No se la puede eliminar */

	select @w_cuenta = cup_cuenta
	from cob_conta..cb_cuenta_presupuesto
	where cup_cuenta_padre = @i_cuenta

	if @@rowcount > 0 
	begin
		/* 'Cuenta a eliminar es Nivel Superior de Cuentas existentes'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607045
		return 1
	end


	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_cuenta_presupuesto
		where 	cup_empresa = @i_empresa and
			cup_cuenta = @i_cuenta

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Cuenta de presupuesto' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607113
			return 1
		end
	/****************************************/
	/* TRANSACCION DE SERVICIO		*/

	insert into ts_cuenta_presupuesto
	values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		@w_empresa,@w_cuenta,@w_descripcion,@w_estado,
		@w_movimiento,@w_categoria)

	if @@error <> 0
	begin
		/* 'Error en insercion de transaccion de servicio' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603032
		return 1
	end
	/****************************************/

         commit tran
	 return 0
end

go
