/************************************************************************/
/*	Archivo: 		categori.sp 			        */
/*	Stored procedure: 	sp_categoria   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     27-Septiembre-1994			*/
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
/*	   Mantenimiento al catalogo de categorias                      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/Sep1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_categoria')
	drop proc sp_categoria

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_categoria   (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = 615,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_categoria		char(1) = null,
	@i_nombre   		descripcion = null,
	@i_signo   		char(1) = null,
	@i_error		smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_nombre	descripcion,
	@w_categoria	char(1),
	@w_signo	char(1),
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_categoria'

/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6521 and @i_operacion = 'I') or
   (@t_trn <> 6522 and @i_operacion = 'U') or
   (@t_trn <> 6523 and @i_operacion = 'D') or
   (@t_trn <> 6524 and @i_operacion = 'V') or
   (@t_trn <> 6526 and @i_operacion = 'Q') or
   (@t_trn <> 6527 and @i_operacion = 'A') 
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
		i_categoria	= @i_categoria,
		i_nombre	= @i_nombre,
		i_signo 	= @i_signo
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_categoria = ca_categoria,
		@w_nombre = ca_nombre,
		@w_signo = ca_signo 
	from cob_conta..cb_categoria
	where 	ca_categoria = @i_categoria

	if @@rowcount > 0
		select @w_existe = 1
	else
		select @w_existe = 0
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_categoria is NULL or
	   @i_nombre is NULL or 
	   @i_signo is NULL 
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end
end
/**** Integridad Referencial *****/
/*********************************/


/* Insercion de categoria */
/*************************/

if @i_operacion = 'I'
begin

	if @w_existe = 1 
	begin
		/* 'Codigo de categoria ya existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601004
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_categoria
		       (ca_categoria,ca_nombre,ca_signo)
		values (@i_categoria,@i_nombre,@i_signo)

		if @@error <> 0 
		begin
			/* 'Error en insercion de categoria' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603002
			return 1
		end



		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_categoria
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_categoria,@i_nombre,@i_signo)

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

/* Actualizacion de categoria  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de categoria a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605003
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_categoria
		set 	ca_nombre = @i_nombre,
			ca_signo = @i_signo 
		where 	ca_categoria = @i_categoria 

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Categoria'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605004
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_categoria
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_categoria,@w_nombre,@w_signo) 

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
		insert into ts_categoria
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_categoria,@i_nombre,@i_signo) 

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

/* Eliminacion de categoria  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de categoria a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607006
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

	/* si codigo de categoria esta relacionado con cuentas      
	, No se puede eliminar el registro */

	select @w_categoria = cu_categoria
	from cob_conta..cb_cuenta
	where cu_categoria = @i_categoria   

	if @@rowcount > 0
	begin
	     /*'Categoria a eliminar relacionado con cuentas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607007
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_categoria
		where 	ca_categoria = @i_categoria

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607008
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_categoria
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_categoria,@w_nombre,@w_signo) 

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

/****************************/
/* Query de categorias      */
/****************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select 	@w_categoria, @w_nombre,@w_signo
	else
	begin
		/* 'categoria consultada no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601008
		return 1
	end
end

/*  All */
/********/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Categoria' = ca_categoria,
			'Nombre' = substring(ca_nombre,1,30),
			'Signo' = ca_signo
		from cob_conta..cb_categoria
		order by ca_categoria
		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Categorias '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601009
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'Categoria' = ca_categoria, 
			'Nombre' = substring(ca_nombre,1,30),
			'Signo' = ca_signo
		from cob_conta..cb_categoria
		where 	ca_categoria > @i_categoria
		order by ca_categoria

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin   
			/* 'No existen Categorias'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601009
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
end

/**** Value  ****/
/****************/

if @i_operacion = 'V'
begin
	if @w_existe = 1
		select @w_nombre
	else
	begin
		/* 'Categoria consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601008
		return 1
	end
	return 0
end
go
