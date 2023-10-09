/************************************************************************/
/*	Archivo: 		dinamica.sp			        */
/*	Stored procedure: 	sp_dinamica				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	   Mantenimiento al catalogo de Empresas                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_dinamica')
	drop proc sp_dinamica  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_dinamica   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_cuenta     	cuenta = null,
	@i_secuencial   smallint  = null,
	@i_tipo_dinamica char(1)= null ,
	@i_texto	char(255) = null,
	@i_disp_legal	descripcion = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
	@w_secuencial	smallint,
	@w_tipo_dinamica	char(1),
	@w_texto	char(255),
	@w_disp_legal	descripcion,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_dinamica'




/************************************************/
/*  Tipo de Transaccion = 620X 			*/

if (@t_trn <> 6201 and @i_operacion = 'I') or
   (@t_trn <> 6202 and @i_operacion = 'U') or
   (@t_trn <> 6203 and @i_operacion = 'D') or
   (@t_trn <> 6205 and @i_operacion = 'S') or
   (@t_trn <> 6206 and @i_operacion = 'Q')
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
		i_cuenta     	= @i_cuenta ,
		i_secuencial 	= @i_secuencial,
		i_tipo_dinamica = @i_tipo_dinamica,
		i_texto		= @i_texto,
		i_disp_legal	= @i_disp_legal
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = di_empresa,
		@w_cuenta = di_cuenta,
		@w_secuencial = di_secuencial,
		@w_tipo_dinamica = di_tipo_dinamica,
		@w_texto = convert(varchar(255),di_texto),
		@w_disp_legal = di_disp_legal
	from cb_dinamica
	where 	di_empresa = @i_empresa and
		di_cuenta   = @i_cuenta and
		di_secuencial = @i_secuencial and
		di_tipo_dinamica = @i_tipo_dinamica

	if @@rowcount <> 0
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

	if	@i_empresa is NULL or 
		@i_cuenta  is NULL or
		@i_tipo_dinamica is NULL or
		@i_secuencial is NULL or
		@i_texto is NULL
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


/* Insercion de dinamica */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Codigo de dinamica ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601036
		return 1
	end

	if NOT EXISTS (select * from cb_empresa
		where em_empresa = @i_empresa)
	begin
		/* 'Codigo de tipo de plan NO existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

	if NOT EXISTS (select * from cb_cuenta
		where cu_empresa = @i_empresa and
			cu_cuenta = @i_cuenta)
	begin
		/* 'Codigo de  cuenta NO existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601026
		return 1
	end

	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into cob_conta..cb_dinamica
		values (@i_empresa,@i_cuenta,@i_secuencial,@i_tipo_dinamica,
			@i_texto,@i_disp_legal)
		if @@error <> 0 
		begin
			/* 'Error en insercion de Dinamica de una Cuenta' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603012
			return 1
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_dinamica 
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_cuenta,@i_secuencial,@i_tipo_dinamica,
			@i_texto,@i_disp_legal)

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

/* Actualizacion de dinamica  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0
	begin
		/* 'Dinamica de Cuenta  a actualizar NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605021
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_dinamica
		set 	di_texto = @i_texto,
			di_disp_legal = @i_disp_legal
		where 	di_empresa = @i_empresa and
			di_cuenta = @i_cuenta and    
			di_secuencial = @i_secuencial and
			di_tipo_dinamica = @i_tipo_dinamica

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Dinamica de Cuenta'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605022

			return 1
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_dinamica
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_cuenta,@w_secuencial,@w_tipo_dinamica,
			@w_texto,@w_disp_legal)

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
		insert into ts_dinamica
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_cuenta,@i_secuencial,@i_tipo_dinamica,
			@i_texto,@i_disp_legal)
			

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

/* Eliminacion de dinamica  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Nivel de Cuenta a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607028
		return 1
	end

/**** Integridad referencial ****/
/********************************/


	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_dinamica
		where 	di_empresa = @i_empresa and
			di_cuenta = @i_cuenta and
			di_secuencial = @i_secuencial and
			di_tipo_dinamica = @i_tipo_dinamica

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Dinamica' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607043
			return 1
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_dinamica
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_cuenta,@w_secuencial,@w_tipo_dinamica,
			@w_texto,@w_disp_legal)

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
/* Query de Dinamica de Ctas */
/****************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select @w_empresa,@w_cuenta,@w_secuencial,
		@w_tipo_dinamica,@w_texto,@w_disp_legal
	else
	begin
		/* 'Dinamica de cuenta consultada no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601050
		return 1
	end
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Secuencial' = di_secuencial,
			'Tipo' = di_tipo_dinamica,
			'Texto' = convert(varchar(255),di_texto),
			'Disp. Legal' = di_disp_legal
		from cob_conta..cb_dinamica
		where di_empresa = @i_empresa and
			di_cuenta = @i_cuenta
		order by di_empresa,di_cuenta,di_tipo_dinamica,di_secuencial

		if @@rowcount = 0
		begin
			/* 'No existen Dinamicas de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601051
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Secuencial' = di_secuencial,
			'Tipo' = di_tipo_dinamica,
			'Texto' = convert(varchar(255),di_texto),
			'Disp. Legal' = di_disp_legal
		from cob_conta..cb_dinamica
		where di_empresa = @i_empresa and
			di_cuenta = @i_cuenta and
			di_secuencial > @i_secuencial
		order by di_empresa,di_cuenta,di_tipo_dinamica,di_secuencial
		if @@rowcount = 0
		begin
			/* 'No existen Dinamicas de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601051
			return 1
		end
		set rowcount 0
		return 0
	end
end
go
