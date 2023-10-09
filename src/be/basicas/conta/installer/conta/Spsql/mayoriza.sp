/************************************************************************/
/*	Archivo: 		mayoriza.sp			        */
/*	Stored procedure: 	sp_mayoriza				*/
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
/*	   Mayorizacion de asientos                                     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	25/Jul/1996	S. de la Cruz	Utilizacion tabla cb_hist_saldo */
/*	22/Jul/1997	F Salgado	Estandarizacion version 3.0	*/
/*					Manejo variables @valor FS001 	*/
/*	03/Mar/2003	D.Ayala		Tuning				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_mayoriza')
	drop proc sp_mayoriza  
go

   select *
   into #_cuentas_tmp
   from cb_cuentas_tmp
   where 1=2

   create NONCLUSTERED INDEX cuentas_tmp_Key on #_cuentas_tmp (tmp_cuenta)

--   alter table #_cuentas_tmp --lock datarows

--   alter table #_cuentas_tmp --partition 200

go

create proc sp_mayoriza (
	@s_ssn		  int = null,
	@s_date		  datetime = null,
	@s_user		  login = null,
	@s_term		  descripcion = null,
	@s_corr		  char(1) = null,
	@s_ssn_corr	  int = null,
        @s_ofi		  tinyint = null,
	@t_rty		  char(1) = null,
        @t_trn		  smallint = null,
	@t_debug	  char(1) = 'N',
	@t_file		  varchar(14) = null,
	@t_from		  varchar(30) = null,
	@i_empresa 	  tinyint = null,
        @i_fecha_tran 	  datetime = null,
	@i_cuenta 	  cuenta = null,
	@i_oficina 	  smallint  = null,
	@i_area		  smallint = null,
        @i_credito 	  money = 0,
        @i_debito  	  money = 0,
	@i_credito_me 	  money = 0,
	@i_debito_me	  money = 0,
	@p_operacion 	  int = null,
	@i_proceso	  int = null
)
as
declare @w_sp_name	varchar(32),
        @w_error	int,
        @valor		money,
	@valor_me	money,
	@w_estado	char(1),
	@w_corte	int,
	@w_periodo	int,
	@w_periodo_aux	int,
	@w_corte_max	int,
	@w_secuencia	int,
	@w_num_cuentas	int,
	@flag1		int,
	@w_fecha_aux	datetime

select @w_sp_name = 'sp_mayoriza'

if (@t_trn <> 6301)
begin
	select @w_error = 601077
	goto ERROR
end


select	@valor		= 0, @valor_me	= 0, @w_fecha_aux = null,
	@w_periodo_aux	= 0, @w_corte_max= 0


select @w_num_cuentas = count(1)
from   #_cuentas_tmp

if @i_credito <> 0
	select @valor = @i_credito * (-1) * @p_operacion
if @i_credito_me <> 0
	select @valor_me = @i_credito_me * (-1) * @p_operacion
if @i_debito <> 0
	select @valor = @valor + @i_debito * @p_operacion
if @i_debito_me <> 0
	select @valor_me = @valor_me + @i_debito_me * @p_operacion

select @w_periodo = co_periodo, @w_corte = co_corte, @w_estado = co_estado
from   cob_conta..cb_corte
where  co_empresa    = @i_empresa
and    co_fecha_ini <= @i_fecha_tran
and    co_fecha_fin >= @i_fecha_tran

select @w_fecha_aux  = @i_fecha_tran

select @w_corte_max = max(co_corte)
from   cb_corte
where  co_empresa  = @i_empresa
and    co_periodo   = @w_periodo

select @w_periodo_aux = @w_periodo


select @flag1 = 1
while @flag1 > 0
begin

	if @w_estado in ('V','C')
	begin
		update cob_conta_his..cb_hist_saldo
		set hi_saldo  = hi_saldo + @valor,
		hi_saldo_me   = hi_saldo_me + (@valor_me*tmp_multiplicador),
		hi_credito    = hi_credito + @i_credito,
		hi_debito     = hi_debito + @i_debito,
		hi_credito_me = hi_credito_me + (@i_credito_me*tmp_multiplicador),
		hi_debito_me  = hi_debito_me + (@i_debito_me*tmp_multiplicador)
		from   cob_conta_his..cb_hist_saldo, #_cuentas_tmp
		where  hi_empresa = @i_empresa
		and    hi_periodo = @w_periodo
		and    hi_corte   = @w_corte
		and    hi_oficina = @i_oficina
		and    hi_area    = @i_area
		and    hi_cuenta  = tmp_cuenta

		select @w_secuencia = @@rowcount

		if @@error <> 0
		begin	/* 'ERROR EN LA ACTUALIZACION DE SALDOS AL MAYORIZAR' */
			select @w_error = 605036
			goto ERROR
		end


		update #_cuentas_tmp set tmp_estado = 'N'
		where tmp_secuencia <= (@w_num_cuentas - @w_secuencia)
		if @@error <> 0
		begin	/* 'ERROR EN LA ACTUALIZACION DE SALDOS AL MAYORIZAR' */
			select @w_error = 605036
			goto ERROR
		end

		if (@w_num_cuentas - @w_secuencia) >= 1
		begin
			insert into cob_conta_his..cb_hist_saldo(
			hi_cuenta,	hi_oficina,	hi_area,	hi_corte,
			hi_periodo,	hi_empresa,	hi_saldo,	hi_saldo_me,
			hi_credito,	hi_debito,	hi_credito_me,	hi_debito_me)
			select 
			tmp_cuenta,	@i_oficina,	@i_area,	@w_corte,
			@w_periodo,	@i_empresa,	@valor,		@valor_me*tmp_multiplicador,   
			@i_credito,	@i_debito,	@i_credito_me*tmp_multiplicador,	@i_debito_me*tmp_multiplicador
			from #_cuentas_tmp
			where tmp_estado = 'N'
			if @@error <> 0
			begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */

print '*** INSERCION %1! %2! -- %3!'+cast(@w_secuencia as varchar)+'   '+cast(@w_num_cuentas as varchar)+'   '+cast(@i_proceso as varchar)
print '************* %1! %2! %3!'+cast(@i_oficina as varchar)+'   '+cast(@i_area as varchar)+'   '+cast(@w_corte as varchar)
select * from #_cuentas_tmp
				select @w_error = 603024
				goto ERROR
			end
		end
	end

	if @w_estado = 'A'
	begin
		update cb_saldo
		set sa_saldo  = sa_saldo + @valor,
		sa_saldo_me   = sa_saldo_me + (@valor_me*tmp_multiplicador),
		sa_credito    = sa_credito + @i_credito,
		sa_debito     = sa_debito + @i_debito,
		sa_credito_me = sa_credito_me + (@i_credito_me*tmp_multiplicador),
		sa_debito_me  = sa_debito_me + (@i_debito_me*tmp_multiplicador)
		from   cb_saldo, #_cuentas_tmp
		where  sa_empresa = @i_empresa
		and    sa_periodo = @w_periodo
		and    sa_corte   = @w_corte
		and    sa_oficina = @i_oficina
		and    sa_area    = @i_area
		and    sa_cuenta  = tmp_cuenta

		select @w_secuencia = @@rowcount

		if @@error <> 0
		begin	/* 'ERROR EN LA ACTUALIZACION DE SALDOS AL MAYORIZAR' */
			select @w_error = 605036
			goto ERROR
		end

		update #_cuentas_tmp set tmp_estado = 'N'
		where tmp_secuencia <= (@w_num_cuentas - @w_secuencia)
		if @@error <> 0
		begin	/* 'ERROR EN LA ACTUALIZACION DE SALDOS AL MAYORIZAR' */
			select @w_error = 605036
			goto ERROR
		end


		if (@w_num_cuentas - @w_secuencia) >= 1
		begin
			insert into cb_saldo(
			sa_cuenta,	sa_oficina,	sa_area,	sa_corte,
			sa_periodo,	sa_empresa,	sa_saldo,	sa_saldo_me,
			sa_credito,	sa_debito,	sa_credito_me,	sa_debito_me)
			select 
			tmp_cuenta,	@i_oficina,	@i_area,	@w_corte,
			@w_periodo,	@i_empresa,	@valor,		@valor_me*tmp_multiplicador,
			@i_credito,	@i_debito,	@i_credito_me*tmp_multiplicador,
			@i_debito_me*tmp_multiplicador
			from #_cuentas_tmp
			where tmp_estado = 'N'

			if @@error <> 0
			begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
				select @w_error = 603024
				goto ERROR
			end
		end
	end


	/* INSERTA UN CORTE ADICIONAL CADA FIN DE PERIODO (AÑO) */
	if (@w_periodo_aux = @w_periodo) and (@w_corte_max = @w_corte)
	begin
		update cob_conta_his..cb_hist_saldo
		set    hi_saldo = hi_saldo + @valor,
		hi_saldo_me = hi_saldo_me + (@valor_me*tmp_multiplicador),
		hi_credito  = hi_credito + @i_credito,
		hi_debito   = hi_debito + @i_debito,
		hi_credito_me = hi_credito_me + (@i_credito_me*tmp_multiplicador),
		hi_debito_me  = hi_debito_me + (@i_debito_me*tmp_multiplicador)
		from   cob_conta_his..cb_hist_saldo, #_cuentas_tmp
		where  hi_empresa = @i_empresa
		and    hi_periodo = @w_periodo
		and    hi_corte  = @w_corte_max + 1
		and    hi_oficina = @i_oficina
		and    hi_area    = @i_area
		and    hi_cuenta = tmp_cuenta
		and    tmp_estado = 'U'
		if @@error <> 0
		begin	/* 'ERROR EN LA ACTUALIZACION DE SALDOS AL MAYORIZAR' */
			select @w_error = 605036
			goto ERROR
		end

		insert into cob_conta_his..cb_hist_saldo(
		hi_cuenta,	hi_oficina,	hi_area,	hi_corte,
		hi_periodo,	hi_empresa,	hi_saldo,
		hi_saldo_me,	hi_credito,	hi_debito,	hi_credito_me,
		hi_debito_me)
		select
		tmp_cuenta,	@i_oficina,	@i_area,	@w_corte_max + 1,
		@w_periodo,	@i_empresa,	@valor,		@valor_me*tmp_multiplicador,
		@i_credito,	@i_debito,	@i_credito_me*tmp_multiplicador,
		@i_debito_me*tmp_multiplicador
		from #_cuentas_tmp
		where tmp_estado = 'N'
		if @@error <> 0
		begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
print 'X ACA---------------'
			select @w_error = 603024
			goto ERROR
		end
	end


	if @w_periodo_aux <> @w_periodo
	begin
		select @w_corte_max = max(co_corte)
		from   cb_corte
		where  co_empresa  = @i_empresa
		and    co_periodo   = @w_periodo

		select @w_periodo_aux = @w_periodo
	end


	/** ACTUALIZAR ESTADO DE CUENTAS **/
	update #_cuentas_tmp set tmp_estado = 'U'
	if @@error <> 0
	begin	/* 'ERROR EN INSERCION DE SALDOS AL MAYORIZAR' */
		select @w_error = 603024
		goto ERROR
	end


	select @w_fecha_aux  = dateadd(dd,1,@w_fecha_aux)

	select @w_periodo = co_periodo, @w_corte = co_corte, @w_estado = co_estado
	from   cob_conta..cb_corte
	where  co_empresa    = @i_empresa
	and    co_fecha_ini <= @w_fecha_aux
	and    co_fecha_fin >= @w_fecha_aux


	if @w_estado not in ('A','V','C')
		select @flag1 = 0

end	--while @flag1 > 0


return 0

ERROR:

print 'ERROR en sp_mayoriza'
/*** 
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = @w_error
***/
   return @w_error

go

