/************************************************************************/
/*	Archivo: 		buscapro.sp			        */
/*	Stored procedure: 	sp_buscapro      			*/
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
/*	   Busqueda de procesos en los que interviene una cuenta        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	7/ene/1994	G Jaramillo     Emision Inicial                 */
/*      10/Feb/1999     F Cardona       Especificaci¢n T‚cnica Corfinsura*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_buscapro')
	drop proc sp_buscapro

go
create proc sp_buscapro (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 622,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_cuenta	cuenta  = null ,
	@i_proceso	smallint = null,
	@i_tipo		char(2) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta	cuenta,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_buscapro'


/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6228 and @i_operacion = 'C') or
   (@t_trn <> 6229 and @i_operacion = 'T') 
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
		i_cuenta	= @i_cuenta ,
		i_proceso	= @i_proceso
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/



/* Search */
/**********/

if @i_operacion = 'C'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	DISTINCT 'Proceso'= cp_proceso,
			'Descripcion' = ba_nombre 
		from cob_conta..cb_cuenta_proceso, cobis..ba_batch
		where 	cp_empresa = @i_empresa and
			cp_cuenta = @i_cuenta and
			cp_proceso = ba_batch

		if @@rowcount = 0
		begin
		   if @@rowcount = 0
		   begin
			/* 'Cuenta no esta asociada a ningun proceso'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		   end

		end
		set rowcount 0
		return 0
	end
	else
	begin
		select 	DISTINCT 'Proceso'= cp_proceso,
			'Descripcion' = ba_nombre 
		from cob_conta..cb_cuenta_proceso,cobis..ba_batch
		where 	cp_empresa = @i_empresa and
			cp_cuenta = @i_cuenta and
			cp_proceso > @i_proceso

		if @@rowcount = 0
		begin
			/* 'la cuenta no esta relacionada a mas procesos'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
end


if @i_operacion = 'T'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select DISTINCT 'Proceso'= ca_proceso,
			'Descripcion' = ba_nombre 
		from cob_conta..cb_cuenta_asociada, cobis..ba_batch
		where 	ca_empresa = @i_empresa and
			ca_cta_asoc = @i_cuenta and    -- F Cardona 
			ca_proceso = ba_batch

		if @@rowcount = 0
		begin
		   if @@rowcount = 0
		   begin
			/* 'Cuenta no esta asociada a ningun proceso'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		   end

		end
		set rowcount 0
		return 0
	end
	else
	begin
		select DISTINCT	'Proceso'= ca_proceso,
			'Descripcion' = ba_nombre 
		from cob_conta..cb_cuenta_asociada,cobis..ba_batch
		where 	ca_empresa = @i_empresa and
			ca_cta_asoc = @i_cuenta and
			ca_proceso > @i_proceso and
			ca_proceso = ba_batch

		if @@rowcount = 0
		begin
			/* 'la cuenta no esta relacionada a mas procesos'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
end

go
