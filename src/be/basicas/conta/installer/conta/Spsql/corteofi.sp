/************************************************************************/
/*	Archivo: 		corteofi.sp 		        */
/*	Stored procedure: 	sp_corte_corte_oficina			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:		Marta E. Segura                       	*/
/*	Fecha de escritura:     12-Enero-2001 				*/
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
/*	   Habilitacion/Deshabilitacion de corte por corte_oficinas */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_corte_oficina')
	drop proc sp_corte_oficina

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_corte_oficina   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
    @s_ofi		smallint = null,
	@t_rty		char(1) = null,
    @t_trn		smallint = 615,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_oficina 		smallint = null,
	@i_fecha		datetime = null,
	@i_formato_fecha 	tinyint = 1,
	@i_oficina1		smallint = null,	
	@i_fecha1		datetime = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa		tinyint,
	@w_oficina 		smallint,
	@w_fecha		datetime,
	@w_existe	int		/* codigo existe = 1 
			               no existe = 0 */
select @w_today = getdate()
select @w_sp_name = 'sp_corte_oficina'

/************************************************/
/*  Tipo de Transaccion =     			*/
if (@t_trn <> 6107 and @i_operacion = 'I') or
   (@t_trn <> 6108 and @i_operacion = 'D') or
   (@t_trn <> 6103 and @i_operacion = 'A')
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
		i_empresa	= @i_empresa,
		i_oficina 	= @i_oficina,
		i_fecha	= @i_fecha
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'A'
begin
	select 	@w_empresa = co_empresa,
    		@w_oficina = co_oficina,
		    @w_fecha    = co_fecha
	from cob_conta..cb_corte_oficina
	where 	co_empresa = @i_empresa and
		co_oficina = @i_oficina and
		co_fecha = @i_fecha

	if @@rowcount > 0
	begin
		select @w_existe = 1
	end
	else
	begin
		select @w_existe = 0
	end
end

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_oficina is NULL or
	   @i_fecha   is NULL
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


/* Insercion de corte_oficina */
/*************************/

if @i_operacion = 'I'
begin

	if @w_existe = 1 
	begin
		/* 'Codigo de corte_oficina ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601175
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_corte_oficina
		       (co_empresa,co_oficina,co_fecha)
		values (@i_empresa,@i_oficina,@i_fecha)

		if @@error <> 0 
		begin
			/* 'Error en insercion de corte_oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603073
			return 1
		end
	commit tran
	return 0
end

/* Eliminacion de corte_oficina  (Delete) */
/***************************************/
if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de corte_oficina  a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601174
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/
	begin tran
  		delete cob_conta..cb_corte_oficina
		where 	co_empresa = @i_empresa and
			co_oficina = @i_oficina and
			co_fecha = @i_fecha

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de corte_oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607066
			return 1
		end
	commit tran
	return 0
end

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Fecha' = convert(char(10),co_fecha,@i_formato_fecha),
			   'Oficina' = of_oficina, 
		       'Descripcion' = of_descripcion
		from cob_conta..cb_corte_oficina, cb_oficina
		where of_empresa = @i_empresa and
			  co_oficina = of_oficina and
			  co_empresa = @i_empresa
		order by co_fecha, of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen corte_oficinas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601176
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Fecha' = convert(char(10),co_fecha,@i_formato_fecha),
			   'Oficina' = of_oficina, 
		       'Descripcion' = of_descripcion
		from cob_conta..cb_corte_oficina, cb_oficina
		where of_empresa = @i_empresa and
			  co_oficina = of_oficina and
			  co_empresa = @i_empresa and
			  ((co_fecha = @i_fecha1 and
				of_oficina > @i_oficina1) or
			   (co_fecha > @i_fecha1))
		order by co_fecha, of_oficina
		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601176
			return 1
		end
		set rowcount 0
		return 0
	end
end
go
