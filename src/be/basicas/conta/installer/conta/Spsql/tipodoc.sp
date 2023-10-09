/************************************************************************/
/*	Archivo: 		tipodoc.sp 			        */
/*	Stored procedure: 	sp_tipo_doc      			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo                   	*/
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
/*	   Mantenimiento al catalogo de tipo de documentos              */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	27/Sep1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tipo_doc')
	drop proc sp_tipo_doc

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_tipo_doc   (
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
	@i_tipo_documento	char(1) = null,
	@i_descripcion   	descripcion = null,
	@i_estado   		char(1) = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_descripcion	descripcion,
	@w_tipo_documento char(1),
	@w_estado	char(1),
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_tipo_documento'

/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6551 and @i_operacion = 'I') or
   (@t_trn <> 6552 and @i_operacion = 'U') or
   (@t_trn <> 6553 and @i_operacion = 'D') or
   (@t_trn <> 6554 and @i_operacion = 'V') or
   (@t_trn <> 6556 and @i_operacion = 'Q') or
   (@t_trn <> 6557 and @i_operacion = 'A') 
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
		i_tipo_documento = @i_tipo_documento,
		i_descripcion	= @i_descripcion,
		i_estado 	= @i_estado
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_tipo_documento = td_tipo_doc,
		@w_descripcion = td_descripcion,
		@w_estado = td_estado 
	from cob_conta..cb_tipo_doc
	where 	td_tipo_doc = @i_tipo_documento

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

	if @i_tipo_documento is NULL or
	   @i_descripcion is NULL    
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


/* Insercion de tipo_documento */
/*************************/

if @i_operacion = 'I'
begin

	if @w_existe = 1 
	begin
		/* 'Codigo de tipo_documento ya existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601137
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_tipo_doc
		       (td_tipo_doc,td_descripcion,td_estado)
		values (@i_tipo_documento,@i_descripcion,@i_estado)

		if @@error <> 0 
		begin
			/* 'Error en insercion de tipo_documento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603052
			return 1
		end



		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_documento
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_tipo_documento,@i_descripcion,@i_estado)

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

/* Actualizacion de tipo_documento  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de tipo_documento a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605071
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_tipo_doc
		set 	td_descripcion = @i_descripcion,
			td_estado = @i_estado 
		where 	td_tipo_doc = @i_tipo_documento 

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de tipo_documento'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605072
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_documento
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_tipo_documento,@w_descripcion,@w_estado) 

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
		insert into ts_tipo_documento
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_tipo_documento,@i_descripcion,@i_estado) 

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

/* Eliminacion de tipo_documento  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de tipo_documento a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607109
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

	/* si codigo de tipo_documento esta relacionado con asientos  
	, No se puede eliminar el registro */

	select @w_tipo_documento = as_tipo_doc
	from cob_conta..cb_asiento
	where as_tipo_doc = @i_tipo_documento   

	if @@rowcount > 0
	begin
	     /*' Tipo de Operacion a eliminar relacionado con asientos'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607110
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_tipo_doc
		where 	td_tipo_doc = @i_tipo_documento

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Tipo de Operacion' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607111
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_tipo_documento
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_tipo_documento,@w_descripcion,@w_estado) 

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
/* Query de tipo_documentos      */
/****************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select 	@w_tipo_documento, @w_descripcion,@w_estado
	else
	begin
		/* 'tipo de operacion consultada no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601138
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
		select 	'Operacion' = td_tipo_doc,
			'Nombre' = substring(td_descripcion,1,25),
			'Estado' = td_estado
		from cob_conta..cb_tipo_doc

		if @@rowcount = 0
		begin
			/* 'No existen Tipos de Operacion '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601139
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'Operacion' = td_tipo_doc, 
			'Nombre' = substring(td_descripcion,1,25),
			'Estado' = td_estado
		from cob_conta..cb_tipo_doc
		where 	td_tipo_doc > @i_tipo_documento

		if @@rowcount = 0
		begin
			/* 'No existen mas tipos de operacion'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601140
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
		select @w_descripcion
	else
	begin
		/* 'Tipo de operacion consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601113
		return 1
	end
	return 0
end
go
