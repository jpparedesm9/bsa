/************************************************************************/
/*	Archivo: 		cb_ctaspuente.sp                        */
/*	Stored procedure: 	sp_cuentas_puente     			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:              				*/
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
/*	consulta las cuentas puente asociadas a los                     */
/*      diferentes m¢dulos COBIS.                                       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*                                                                      */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cuentas_puente')
	drop proc sp_cuentas_puente
go

create proc sp_cuentas_puente (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		char(15) = null,
	@s_term		char(255) = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_debug		char(1) = 'N',
	@t_trn			int = null,
	@t_file			varchar(14) = null,
        @t_from			varchar(30)	= null,
	@i_operacion		char(1)  = null,
	@i_empresa		tinyint = null,
	@i_modo			tinyint = null,
	@i_fecha		datetime = null,
	@i_oficina		smallint = null,
	@i_oficina1		smallint	= null,
	@i_area			smallint	= null,
	@i_cuenta       	cuenta		= null,
	@i_producto		tinyint		= null,
	@i_comprobante		int		= null,
	@i_asiento		int		= null
)

as
declare
	@w_sp_name		varchar(32),
	@w_corte		int,
	@w_estado_corte		char(1),
	@w_periodo  		int,
        @w_saldo        	money,
        @w_saldo1       	money


select @w_sp_name = 'sp_cuentas_puente'



if (@t_trn <> 6083 and @i_operacion = 'Q') or
   (@t_trn <> 6083 and @i_operacion = 'S') or
   (@t_trn <> 6084 and @i_operacion = 'O') or
   (@t_trn <> 6084 and @i_operacion = 'T') or
   (@t_trn <> 6085 and @i_operacion = 'A')
begin
	/* Tipo de transaccion no corresponde */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
	@i_num   = 6000009
	return 1 
end

select 	@w_corte = co_corte,
	@w_periodo = co_periodo,
	@w_estado_corte = co_estado
  from 	cob_conta..cb_corte
where 	co_empresa = @i_empresa and
      	co_fecha_ini <= @i_fecha and
      	co_fecha_fin >= @i_fecha

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_modo		= @i_modo
	exec cobis..sp_end_debug
end

if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select distinct 
		"CUENTA" = cu_cuenta, 
		"NOMBRE" = cu_nombre
		from cob_conta..cb_cuenta
		where cu_cuenta > ''
                and cu_empresa = @i_empresa
		and cu_nivel_cuenta = 6
		and cu_movimiento = 'S'
--		order by cu_empresa, cu_cuenta
			
	end
	else
	begin
		select distinct 
		"CUENTA" = cu_cuenta, 
		"NOMBRE" = cu_nombre
		from cob_conta..cb_cuenta
		where cu_cuenta > @i_cuenta
                and cu_empresa = @i_empresa
		and cu_nivel_cuenta = 6
		and cu_movimiento = 'S'
--		order by cu_empresa, cu_cuenta

	end
	set rowcount 0
	return 0
end

if @i_operacion = 'T'
begin
	select of_oficina, of_descripcion
	from cob_conta..cb_oficina
	where of_empresa = @i_empresa
	and of_oficina = @i_oficina
	--and of_movimiento = "S"
	if @@rowcount = 0
	begin	/* 'Oficina no existe o no es de movimiento' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 6000017
		return 1
	end
	return 0
end


if @i_operacion = 'S'
begin

	set rowcount 20
	if @i_modo = 0
	begin
		if @w_estado_corte = 'A'
		begin

			select 	"OFICINA"    =  sa_oficina,
				"CUENTA"     =  sa_cuenta,
		       		"SALDO MN"   =  sum(isnull(sa_saldo,0)),
		       		"SALDO ME"   = sum(isnull(sa_saldo_me,0))
			from cob_conta..cb_saldo
			where sa_empresa = @i_empresa
			and sa_periodo = @w_periodo
			and sa_corte = @w_corte
			and sa_cuenta = @i_cuenta
			and sa_oficina 	in (	select je_oficina from cob_conta..cb_jerarquia
					where je_empresa = @i_empresa
					and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina))
			group by sa_oficina,sa_cuenta
			order by sa_oficina
	

		end
		else
		begin
			select 	"OFICINA"    =  hi_oficina,
				"CUENTA"     =  hi_cuenta,
		       		"SALDO MN"   =  sum(isnull(hi_saldo,0)),
		       		"SALDO ME"   =  sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte = @w_corte
			and   hi_cuenta = @i_cuenta
			and   hi_oficina in (	select je_oficina from cob_conta..cb_jerarquia
					where je_empresa = @i_empresa
					and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina))
			group by hi_oficina,hi_cuenta
			order by hi_oficina
	

		end
	end


	if @i_modo = 1
	begin
		if @w_estado_corte = 'A'
		begin

			select 	"OFICINA"    =  sa_oficina,
				"CUENTA"     =  sa_cuenta,
		       		"SALDO MN"   =  sum(isnull(sa_saldo,0)),
		       		"SALDO ME"   = sum(isnull(sa_saldo_me,0))
			from cob_conta..cb_saldo
			where sa_empresa = @i_empresa
			and sa_periodo = @w_periodo
			and sa_corte = @w_corte
			and sa_cuenta = @i_cuenta
			and sa_oficina 	in (	select je_oficina from cob_conta..cb_jerarquia
					where je_empresa = @i_empresa
					and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina))
			and sa_oficina > @i_oficina1
			group by sa_oficina,sa_cuenta
			order by sa_oficina
	

		end
		else
		begin
			select 	"OFICINA"    =  hi_oficina,
				"CUENTA"     =  hi_cuenta,
		       		"SALDO MN"   =  sum(isnull(hi_saldo,0)),
		       		"SALDO ME"   =  sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte = @w_corte
			and   hi_cuenta = @i_cuenta
			and   hi_oficina in (	select je_oficina from cob_conta..cb_jerarquia
					where je_empresa = @i_empresa
					and   (je_oficina = @i_oficina or je_oficina_padre = @i_oficina))
			and   hi_oficina > @i_oficina1
			group by hi_oficina,hi_cuenta
			order by hi_oficina
	

		end
	end

	if @i_modo = 2
	begin
		if @w_estado_corte = 'A'
		begin

			select 	"OFICINA"    =  of_oficina,
				"CUENTA"     =  sa_cuenta,
		       		"SALDO MN"   =  sum(isnull(sa_saldo,0)),
		       		"SALDO ME"   = sum(isnull(sa_saldo_me,0))
			from cob_conta..cb_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia
			where sa_empresa = @i_empresa
			and sa_periodo = @w_periodo
			and sa_corte = @w_corte
			and sa_cuenta = @i_cuenta
			and of_empresa = @i_empresa
			and of_oficina = je_oficina_padre
			and je_empresa = @i_empresa
			and of_oficina = @i_oficina 
  			and sa_oficina = je_oficina
			group by of_oficina,sa_cuenta

	

		end
		else
		begin
			select 	"OFICINA"    =  of_oficina,
				"CUENTA"     =  hi_cuenta,
		       		"SALDO MN"   =  sum(isnull(hi_saldo,0)),
		       		"SALDO ME"   =  sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte = @w_corte
			and   hi_cuenta = @i_cuenta
			and   of_empresa = @i_empresa
			and   of_oficina = je_oficina_padre
			and   je_empresa = @i_empresa
			and   of_oficina = @i_oficina 
  			and   hi_oficina = je_oficina
			group by of_oficina,hi_cuenta

		end
	end


	if @i_modo = 3
	begin
		if @w_estado_corte = 'A'
		begin

			select 	"OFICINA"    =  of_oficina,
				"CUENTA"     =  sa_cuenta,
		       		"SALDO MN"   =  sum(isnull(sa_saldo,0)),
		       		"SALDO ME"   = sum(isnull(sa_saldo_me,0))
			from cob_conta..cb_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia
			where sa_empresa = @i_empresa
			and sa_periodo = @w_periodo
			and sa_corte = @w_corte
			and sa_cuenta = @i_cuenta
			and of_empresa = @i_empresa
			and of_oficina = je_oficina_padre
			and je_empresa = @i_empresa
			and of_oficina = @i_oficina 
  			and sa_oficina = je_oficina
			and sa_oficina > @i_oficina1
			group by of_oficina,sa_cuenta

	

		end
		else
		begin
			select 	"OFICINA"    =  of_oficina,
				"CUENTA"     =  hi_cuenta,
		       		"SALDO MN"   =  sum(isnull(hi_saldo,0)),
		       		"SALDO ME"   =  sum(isnull(hi_saldo_me,0))
			from cob_conta_his..cb_hist_saldo,cob_conta..cb_oficina,cob_conta..cb_jerarquia
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte = @w_corte
			and   hi_cuenta = @i_cuenta
			and   of_empresa = @i_empresa
			and   of_oficina = je_oficina_padre
			and   je_empresa = @i_empresa
			and   of_oficina = @i_oficina 
  			and   hi_oficina = je_oficina
			and   hi_oficina > @i_oficina1
			group by of_oficina,hi_cuenta

		end
	end


	set rowcount 0
	return 0
end


if @i_operacion = 'O'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Oficina' = of_oficina, 'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where of_empresa = @i_empresa
		order by of_oficina
		if @@rowcount = 0
		begin	/* 'Oficina no existe o no es de movimiento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 6000017
			return 1
		end
		set rowcount 0
		return 0
	end

	if @i_modo = 1
	begin
		select 'Oficina' = of_oficina, 'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where 	of_empresa = @i_empresa
		and of_oficina > @i_oficina
		order by of_oficina
		if @@rowcount = 0
		begin	/* 'Oficina no existe o no es de movimiento' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 6000017
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	        select 
		"PRODUCTO"   = sa_producto,
		"COMP."      = sa_comprobante,
		"ASIENTO"    = sa_asiento,
		"AREA"       = sa_area_dest,
		"DEBITO"     = sa_debito,
		"CREDITO"    = sa_credito,
		"DEBITO ME"  =sa_debito_me,
		"CREDITO ME" =sa_credito_me
	        from cob_conta_tercero..ct_sasiento,cob_conta_tercero..ct_scomprobante
	        where sa_empresa = @i_empresa
		and   sa_producto > 0
		and   sa_fecha_tran = @i_fecha
		and   sa_comprobante > 0
                and   sa_asiento > 0
                and   sa_cuenta  = @i_cuenta
		and   sa_oficina_dest = @i_oficina
                and   sc_empresa = sa_empresa
                and   sc_producto = sa_producto
                and   sc_fecha_tran = sa_fecha_tran
                and   sc_comprobante = sa_comprobante
                and   sc_estado = 'P'
		order by sa_producto,sa_comprobante,sa_asiento
	end
	else
	begin
	        select 
		"PRODUCTO"   = sa_producto,
		"COMP."      = sa_comprobante,
		"ASIENTO"    = sa_asiento,
		"AREA"       = sa_area_dest,
		"DEBITO"     = sa_debito,
		"CREDITO"    = sa_credito,
		"DEBITO ME"  =sa_debito_me,
		"CREDITO ME" =sa_credito_me
	        from cob_conta_tercero..ct_sasiento,cob_conta_tercero..ct_scomprobante
	        where sa_empresa = @i_empresa
		and   sa_producto > 0
		and   sa_fecha_tran = @i_fecha
		and   sa_comprobante > 0
                and   sa_asiento > 0
                and   sa_cuenta  = @i_cuenta
		and   sa_oficina_dest = @i_oficina
                and   sc_empresa = sa_empresa
                and   sc_producto = sa_producto
                and   sc_fecha_tran = sa_fecha_tran
                and   sc_comprobante = sa_comprobante
                and   sc_estado = 'P'
		and   (
			(sa_producto > @i_producto) or
			(sa_producto = @i_producto and sa_comprobante > @i_comprobante) or
                        (sa_producto = @i_producto and sa_comprobante = @i_comprobante and sa_asiento > @i_asiento) 
		      )
		order by sa_producto,sa_comprobante,sa_asiento

	end
	set rowcount 0

end
go