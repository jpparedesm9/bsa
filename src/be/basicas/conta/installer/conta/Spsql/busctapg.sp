/************************************************************************/
/*	Archivo: 		busctapg.sp			        */
/*	Stored procedure: 	sp_busctapg				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo                   	*/
/*	Fecha de escritura:     30-Sep-1994 				*/
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
/*	   Busquedas especiales del plan general para ingreso en 	*/
/*	   cuenta proceso          					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Sep/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_busctapg')
	drop proc sp_busctapg 
go
create proc sp_busctapg  (
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
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_cuenta	cuenta = null,
	@i_oficina	smallint= null,
	@i_area   	smallint= null 

)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_oficina 	smallint,
	@w_area		smallint

select @w_today = getdate()
select @w_sp_name = 'sp_busctapg'



/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6538 and @i_operacion = 'E') or
   (@t_trn <> 6539 and @i_operacion = 'F') 
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
		i_empresa 	= @i_empresa,
		i_cuenta	= @i_cuenta,
		i_oficina	= @i_oficina,
		i_area		= @i_area
	exec cobis..sp_end_debug
end


if @i_operacion = 'E'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select distinct pg_oficina,of_descripcion
		from cob_conta..cb_plan_general,cob_conta..cb_oficina
		where pg_empresa = @i_empresa and
		      pg_cuenta  = @i_cuenta and
		      pg_empresa = of_empresa and
		      pg_oficina = of_oficina
		order by pg_oficina

		if @@rowcount = 0
		begin
			/* 'Cuenta no esta relacionada con oficinas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601158
			return 1
		end
	end
	else begin
		select distinct pg_oficina,of_descripcion
		from cob_conta..cb_plan_general,cob_conta..cb_oficina
		where pg_empresa = @i_empresa and
		      pg_cuenta  = @i_cuenta and
		      pg_oficina > @i_oficina and
		      pg_empresa = of_empresa and
		      pg_oficina = of_oficina

		if @@rowcount = 0
		begin
			/* 'Cuenta no esta relacionada con oficinas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601158
			return 1
		end
	end
	return 0
end

if @i_operacion = 'F'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select pg_area,ar_descripcion
		from cob_conta..cb_plan_general,cob_conta..cb_area
		where pg_empresa = @i_empresa
		and   pg_cuenta  = @i_cuenta
		and   pg_oficina = @i_oficina
		and   pg_empresa = ar_empresa
		and   pg_area    = ar_area
    		order by pg_area

		if @@rowcount = 0
		begin
			/* 'Cuenta no esta relacionada con areas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601158
			return 1
		end
	end
	else begin
		select pg_area,ar_descripcion
		from cob_conta..cb_plan_general,cob_conta..cb_area
		where pg_empresa = @i_empresa
		and   pg_cuenta  = @i_cuenta
		and   pg_oficina = @i_oficina
		and   pg_area    > @i_area
		and   pg_empresa = ar_empresa
		and   pg_area    = ar_area
    		order by pg_area

		if @@rowcount = 0
		begin
			/* 'Cuenta no esta relacionada con areas' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601158
			return 1
		end
	end
	return 0
end

go

