/***********************************************************************/
/*      Archivo:                 depreci.sp                            */
/*      Stored procedure:        sp_depreci                            */
/*      Base de Datos:           cob_conta                             */
/*      Producto:                Contabilidad                          */
/*      Disenado por:            Marta Elena Segura                    */
/*      Fecha de Escritura:      14-Octubre-1997                       */
/***********************************************************************/
/*                               PROPOSITO                             */
/*      Este programa procesa las transacciones de:                    */
/*      generacion de las transacciones de depreciacion y ajuste por   */
/*      inflacion de las cuentas contables                             */
/***********************************************************************/
/*                            MODIFICACIONES                           */
/***********************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_depreci')
	drop proc sp_depreci
go

create proc sp_depreci(
	@s_ssn			int		= null,
	@s_date			datetime	= null,
	@s_user			login		= null,
	@s_term			descripcion	= null,
	@s_corr			char(1)		= null,
	@s_ssn_corr		int		= null,
	@s_ofi			smallint	= null,
	@t_rty			char(1)		= null,
	@t_trn			smallint	= null,
	@t_debug		char(1)		= 'N',
	@t_file			varchar(14)	= null,
	@t_from			varchar(30)	= null,
	@i_operacion		char(1)		= null,
	@i_modo			smallint	= null,
	@i_empresa 		tinyint		= null,
	@i_descripcion		varchar(30)	= null,
	@i_formato_fecha	tinyint		= 1,
	@i_valor_dif		money		= 0,
	@i_fecha_inicio		datetime	= null,
	@i_fecha_final		datetime	= null,
	@i_saldo_dias		smallint	= null,
	@i_am_acum_aju          money		= 0,
	@i_ajus_infl_deprec     money		= 0,
	@i_amorti_acum_ajus     money		= 0,
	@i_dias_base		smallint	= null,
	@i_dias_amortizados     smallint	= null,
	@i_concepto		varchar(10)	= null,
	@i_comprobante		int		= null,
	@i_fecha_reg		datetime	= null, 
	@i_valor_dia		money		= null,
        @i_ajus_infl_acum       money		= 0,
        @i_ajus_infl_diferido   money		= 0,
	@i_fecha_ult_proc	datetime	= null,
	@i_control		char(1)		= null,
	@i_paag			float		= null,
	@i_depre_acum		money		= null,
	@i_asiento		int		= null,
        @i_cuenta               cuenta		= null,
        @i_oficina_orig 	smallint	= null,
        @i_oficina_conta 	smallint	= null,
	@i_fecha_conta  	datetime	= null,
	@o_valor_gasto          money		= null out,
        @o_diferido_ajustado    money		= null out
)
as
declare	@w_sp_name		varchar(32),
	@w_numerror		int,
	@w_dias_amortizados	smallint,
	@w_amort_acum		money,
	@w_amorti_saldo		money,
	@w_valor_mes_sig 	money,
	@w_fecha_ult_proc	datetime,
	@w_valor_dia		money,
	@w_pagado		char(1),
	@w_ajus_infl		money,
	@w_cost_ajus		money,
	@w_depr_mes		money,
	@w_am_depr_acum		money,
	@w_ajus_infl_deprec     money,
	@w_amorti_acum_ajus     money,
	@w_amorti_acum          money,
	@w_activo_neto          money,
        @w_ajus_infl_acum       money,
        @w_diferido_ajustado    money,
        @w_ajus_infl_diferido   money,
	@w_dias_anterior	smallint,
        @w_dias_menos           smallint,
        @w_dias_saldo           smallint,
	@w_opcion               smallint

select @w_sp_name = 'sp_depreci', @w_numerror = 0

if      (@t_trn <> 6617 and @i_operacion = 'I') or
	(@t_trn <> 6617 and @i_operacion = 'Q') or
	(@t_trn <> 6617 and @i_operacion = 'U') or
	(@t_trn <> 6617 and @i_operacion = 'A') or
	(@t_trn <> 6617 and @i_operacion = 'S')
begin	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
	t_file		= @t_file,
	t_from		= @t_from,
	i_operacion	= @i_operacion,
	i_empresa	= @i_empresa,
	i_modo		= @i_modo, 
	i_descripcion   = @i_descripcion,
	i_formato_fecha = @i_formato_fecha,
	i_valor_dif     = @i_valor_dif,
	i_fecha_inicio  = @i_fecha_inicio,
	i_fecha_final   = @i_fecha_final,
	i_saldo_dias    = @i_saldo_dias,
	i_dias_base     = @i_dias_base,
	i_concepto      = @i_concepto,
	i_comprobante   = @i_comprobante,
	i_valor_dia     = @i_valor_dia,
	i_fecha_ult_proc= @i_fecha_ult_proc,
	i_control       = @i_control,
	i_paag		= @i_paag,
	i_depre_acum	= @i_depre_acum,
	i_asiento       = @i_asiento
	exec cobis..sp_end_debug
end


if @i_operacion = 'Q'
begin
	select cu_categoria
	from cb_cuenta
	where cu_empresa = @i_empresa
	and cu_cuenta = @i_cuenta
end 


if @i_operacion = 'I'
begin
	/* Dias Amortizados */
	select @w_dias_amortizados = 0

	/* Amortizacion Acumulada */
	select @w_amort_acum = 0

	/* Saldo por amortizar */
	select @w_amorti_saldo = @i_valor_dif

	/* Valor diario  */
	select @w_valor_dia = 0

	/* Valor Amortizar mes siguiente */
	select @w_valor_mes_sig = 0

	/* Pagado */
	select @w_pagado = 'N'

	/* Ajuste por Inflacion del Costo */
	select @w_ajus_infl = 0

	/* Depreciacion del mes */
	select @w_depr_mes = 0

	/* Costo Ajustado */
	select @w_am_depr_acum = @i_valor_dif

	select  @w_fecha_ult_proc = fc_fecha_cierre
	from cobis..ba_fecha_cierre
        where fc_producto = 6

	/* Ajuste por Inflacion Depreciacion */
	select @w_ajus_infl_deprec = 0

	/* Depreciacion Acumulada Ajustada */
	select @w_amorti_acum_ajus = 0

	begin tran
	insert into cb_diferidos(
		di_empresa,di_comprobante,di_fecha_reg,di_oficina_orig,
		di_descripcion,di_valor_dif,di_fecha_inicio,di_fecha_final,
		di_saldo_dias,di_dias_base,di_concepto,di_dias_amortizados,
		di_amorti_acum,di_amorti_saldo,di_valor_mes_sig,di_fecha_ult_proc,
		di_valor_dia,di_control,di_estado,di_ajus_infl,di_depr_mes,
		di_am_acum_aju,di_asiento,di_ajus_infl_deprec,di_amorti_acum_ajus,
		di_ajus_infl_acum,di_ajus_infl_diferido,di_oficina_conta,di_fecha_conta)
	values(
		@i_empresa,@i_comprobante,@i_fecha_reg,@i_oficina_orig,
		@i_descripcion,@i_valor_dif,@i_fecha_inicio,@i_fecha_final,
		@i_saldo_dias,@i_dias_base,@i_concepto,@w_dias_amortizados,
		@w_amort_acum,@w_amorti_saldo,@w_valor_mes_sig,@i_fecha_reg,
		@w_valor_dia,@i_control,@w_pagado,@w_ajus_infl,@w_depr_mes,
		@w_am_depr_acum,@i_asiento,@w_ajus_infl_deprec,@w_amorti_acum_ajus,
		0,0,@i_oficina_conta,@i_fecha_conta)
	if @@error <> 0
	begin
		select @w_numerror = 603062
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = @w_numerror
	end
	commit tran

	select
	@w_dias_amortizados,          --Dias Depreciados
	@w_depr_mes,                  --Depreciacion del mes efectuada
	@w_amort_acum,                --Depreciacion Acumulada
	@w_ajus_infl_deprec,          --Ajuste por Inflacion de la Depreciacion
	@w_amorti_acum_ajus,          --Depreciacion Acumulada Ajustada
	@w_ajus_infl,                 --Ajuste por Inflacion del Costo
	@w_am_depr_acum,              --Costo Ajustado por Inflacion
	@w_amorti_saldo,              --Activo Neto
        convert(char(10),@i_fecha_reg,103) --Fecha Actualizacion
end



if @i_operacion = 'U'
begin
begin tran 
	if exists (select 1 from  cb_diferidos
		where di_empresa     = @i_empresa 
		and   di_comprobante = @i_comprobante
		and   di_fecha_reg   = @i_fecha_reg
		and   di_asiento     = @i_asiento
		and   di_oficina_orig = @i_oficina_orig
		and   di_control     = @i_control)
		goto LABEL1
	else
	begin
		exec cobis..sp_cerror
		@t_debug    = @t_debug,
		@t_file     = @t_file,
		@t_from     = @w_sp_name,
		@i_num      = 605085
		return 1
	end      

LABEL1:
	update cb_diferidos
	set	di_fecha_final = @i_fecha_final,               -- Fecha Final de la Depreciacion
		di_saldo_dias = @i_saldo_dias                  -- Nro Total de Dias
	where di_empresa     = @i_empresa
	and   di_comprobante = @i_comprobante
	and   di_fecha_reg   = @i_fecha_reg
	and   di_asiento     = @i_asiento
	and   di_oficina_orig = @i_oficina_orig
	and   di_control     = @i_control
	if @@error <> 0
	begin
		select @w_numerror = 605086
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = @w_numerror
	end
commit tran
end




if @i_operacion = 'S'
begin
	select
	di_comprobante,                      	-- Numero del Comprobante
	convert(char(10),di_fecha_reg,103),  	-- Fecha contable elaboracion comprobante
	di_descripcion,                      	-- Descripcion de la Depreciacion
	di_valor_dif,                        	-- Valor a Depreciar
	convert(char(10),di_fecha_inicio,103),  -- Fecha Inicio de la Depreciacion
	convert(char(10),di_fecha_final,103),   -- Fecha Final de la Depreciacion
	di_dias_base,          			-- Nro de DIas Base(360)
	di_saldo_dias,         			-- Nro Total de Dias
	di_dias_amortizados,   			-- Dias Depreciados
	di_depr_mes,           			-- Depreciacion del Mes Efectuada
	di_amorti_acum,        			-- Depreciacion Acumulada
	di_ajus_infl_deprec,   			-- Ajuste por Inflacion de la Depreciacion
	di_amorti_acum_ajus,   			-- Depreciacion Acumulada Ajustada
	di_ajus_infl,          			-- Ajuste por Inflacion del Costo 
	di_am_acum_aju,        			-- Costo Ajustado por Inflacion
	di_amorti_saldo,       			-- Activo Neto
	convert(char(10),di_fecha_ult_proc,103) -- Fecha Actualizacion
	from   cob_conta..cb_diferidos
	where  di_empresa     = @i_empresa
	and    di_comprobante = @i_comprobante
	and    di_fecha_reg   = @i_fecha_reg
	and    di_asiento     = @i_asiento
	and    di_oficina_orig = @i_oficina_orig
	and    di_control     = @i_control
end



if @i_operacion = 'A'
begin
	select  @w_fecha_ult_proc = @i_fecha_ult_proc

	/* En la variable @w_opcion queda 1 si es el primer mes a depreciar,
	o si la fecha inicial y final de depreciacion tienen el mismo mes
	y el mismo ano.
	2 si es el ultimo mes a depreciar o 3 si es cualquier mes diferente
	al primero o al ultimo */

	if (datepart(mm,@i_fecha_inicio) = datepart(mm,@i_fecha_final)) and (datepart(yy,@i_fecha_inicio) = datepart(yy,@i_fecha_final))
		select @w_opcion = 1
	else
	if (datepart(mm,@i_fecha_inicio) = datepart(mm,@w_fecha_ult_proc)) and (datepart(yy,@i_fecha_inicio) = datepart(yy,@w_fecha_ult_proc))
		select @w_opcion = 1
	else
	if (datepart(mm,@i_fecha_final) = datepart(mm,@w_fecha_ult_proc)) and (datepart(yy,@i_fecha_final) = datepart(yy,@w_fecha_ult_proc))
		select @w_opcion = 2
	else
		select @w_opcion = 3


	/******** Si es el primer mes a depreciar ********/
	/****** Inicio @w_opcion = 1  *******/
	if @w_opcion = 1
	begin
		/* Valor Diario */
		select @w_valor_dia = @i_am_acum_aju / @i_saldo_dias

		/* Dias Amortizados */
		if (datepart(mm,@i_fecha_inicio) = datepart(mm,@i_fecha_final)) and 
		(datepart(yy,@i_fecha_inicio) = datepart(yy,@i_fecha_final))
		begin
			select @w_dias_amortizados = datepart(dd,@i_fecha_final)

			if @w_dias_amortizados > 30
				select @w_dias_amortizados = 30

			select @w_dias_amortizados = @w_dias_amortizados - datepart(dd,@i_fecha_inicio)

			if @w_dias_amortizados < 0
				select @w_dias_amortizados = 0
		end
		else
		begin
			select @w_dias_amortizados = 30 - datepart(dd,@i_fecha_inicio)
			if @w_dias_amortizados < 0
				select @w_dias_amortizados = 0
		end

		/* Si la Depreciacion esta suspendida se calcula los dias que afecta */
		select @w_dias_menos = 0

		/* Dias Amortizados */
		select @w_dias_amortizados = @w_dias_amortizados - @w_dias_menos

		/* Depreciacion del mes efectuada */
		select @w_depr_mes = round(@w_valor_dia * @w_dias_amortizados,2) --ccr

		/* Depreciacion Acumulada */
		select @w_amorti_acum = @i_depre_acum + @w_depr_mes

		/* Depreciacion Acumulada Ajustada */
		select @w_amorti_acum_ajus = @w_amorti_acum

		/* Activo Neto */
		select @w_activo_neto = @i_am_acum_aju - @w_amorti_acum_ajus

		/* Actualizacion del estado */
		if (datepart(mm,@i_fecha_inicio) = datepart(mm,@i_fecha_final)) and (datepart(yy,@i_fecha_inicio) = datepart(yy,@i_fecha_final))
			select @w_pagado = 'P'
		else
			select @w_pagado = 'N'

		/* Actualizacion de la tabla de diferidos con los datos anteriores */
		begin tran
		update cb_diferidos
		set	di_dias_amortizados = @w_dias_amortizados,
			di_amorti_acum = @w_amorti_acum,
			di_amorti_saldo = @w_activo_neto,
			di_fecha_ult_proc = @w_fecha_ult_proc,
			di_valor_dia = @w_valor_dia,
			di_estado = @w_pagado,
			di_depr_mes = @w_depr_mes,
			di_amorti_acum_ajus = @w_amorti_acum_ajus
		where di_empresa     = @i_empresa
		and   di_comprobante = @i_comprobante
		and   di_fecha_reg   = @i_fecha_reg
		and   di_asiento     = @i_asiento
		and   di_oficina_orig = @i_oficina_orig
		and   di_asiento     = @i_asiento
		and   di_control     = @i_control
		if @@error <> 0
		begin	-- Error en insercion de diferido
			select @w_numerror = 605084
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = @w_numerror
		end


		if @w_pagado = 'P'
		begin
			update cb_comprobante
			set co_estado = 'P'
			where co_empresa = @i_empresa
			and co_fecha_tran  = @i_fecha_reg
			and co_comprobante = @i_comprobante
			and co_oficina_orig = @i_oficina_orig
			if @@error <> 0
			begin	-- Error en insercion de diferido
				select @w_numerror = 603025
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = @w_numerror
			end
		end

		select @o_valor_gasto = @w_depr_mes, @o_diferido_ajustado = 0
		commit tran
	end
	/****** Fin @w_opcion = 1  *******/




	/******* Si es el ultimo mes a depreciar  ********/
	/****** Inicio @w_opcion = 2  *******/
	if @w_opcion = 2
	begin
		/* Dias Amortizados */
		select @w_dias_amortizados = datepart(dd,@i_fecha_final)

		if @w_dias_amortizados > 30
			select @w_dias_amortizados = 30

		/* Si la Depreciacion esta suspendida se calcula los dias que afecta */
		select @w_dias_menos = 0

		/* Dias Amortizados */
		select @w_dias_amortizados = @w_dias_amortizados - @w_dias_menos

		/* Ajuste por Inflacion del Costo */
		select @w_ajus_infl = (@i_am_acum_aju * @i_paag) /100

		/* Ajuste por Inflacion Acumulado */
		select @i_ajus_infl_acum = isnull(@i_ajus_infl_acum,0)
		select @w_ajus_infl = isnull(@w_ajus_infl,0)
		select @w_ajus_infl_acum = @i_ajus_infl_acum + @w_ajus_infl
		select @i_ajus_infl_diferido = isnull(@i_ajus_infl_diferido,0)
		select @w_diferido_ajustado =  @w_ajus_infl_acum  - @i_ajus_infl_diferido
		select @w_ajus_infl_diferido = @i_ajus_infl_diferido + @w_diferido_ajustado

		/* Costo Ajustado */
		select @w_cost_ajus = @i_am_acum_aju + @w_ajus_infl

		/* Ajuste por Inflacion de la Depreciacion */
		select @w_ajus_infl_deprec = @i_amorti_acum_ajus * @i_paag /100

		/* Depreciacion Acumulada Ajustada */
		select @w_amorti_acum_ajus = @i_amorti_acum_ajus + @w_ajus_infl_deprec

		/* Depreciacion del mes efectuada */
		select @w_depr_mes = @w_cost_ajus

		/* Depreciacion Acumulada */
		select @w_amorti_acum = @i_depre_acum + @w_depr_mes

		/* Depreciacion Acumulada Ajustada */
		select @w_amorti_acum_ajus = @w_amorti_acum_ajus + @w_depr_mes

		/* Activo Neto */
		select @w_activo_neto = @w_cost_ajus - @w_amorti_acum_ajus

		/* Estado de la Depreciacion */
		select @w_pagado = 'P'

		/* Actualizacion de la tabla de diferidos con los datos anteriores */
		begin tran
		update cb_diferidos
		set	di_dias_amortizados = @i_dias_amortizados + @w_dias_amortizados,
			di_amorti_acum = @w_amorti_acum,
			di_amorti_saldo = di_amorti_saldo - @w_depr_mes,
			di_fecha_ult_proc = @w_fecha_ult_proc,
			di_estado = @w_pagado,
			di_ajus_infl = @w_ajus_infl,
			di_depr_mes = @w_depr_mes,
			di_ajus_infl_deprec = @w_ajus_infl_deprec,
			di_amorti_acum_ajus = @w_amorti_acum_ajus,
			di_ajus_infl_acum = @w_ajus_infl_acum,
			di_ajus_infl_diferido = @w_ajus_infl_diferido,
			di_valor_dia = @w_depr_mes / @w_dias_amortizados
		where di_empresa     = @i_empresa
		and   di_comprobante = @i_comprobante
		and   di_fecha_reg   = @i_fecha_reg
		and   di_asiento     = @i_asiento
		and   di_oficina_orig = @i_oficina_orig
		and   di_control     = @i_control
		if @@error <> 0
		begin
			select @w_numerror = 605084
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = @w_numerror
		end

		update cb_comprobante
		set co_estado = 'P'
		where co_empresa = @i_empresa
		and co_fecha_tran  = @i_fecha_reg
		and co_comprobante = @i_comprobante
		and co_oficina_orig = @i_oficina_orig
		if @@error <> 0
		begin
			select @w_numerror = 603025
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = @w_numerror
		end

		select @o_valor_gasto = @w_depr_mes, @o_diferido_ajustado = 0
		commit tran
	
	end
	/****** Fin @w_opcion = 2  *******/





	/****** Si el mes a depreciar es diferente al primero o al ultimo *******/
	/****** Inicio @w_opcion = 3  *******/
	if @w_opcion = 3
	begin
		/* Ajuste por Inflacion del Costo */
		select @w_ajus_infl = (@i_am_acum_aju * @i_paag) /100  

		/* Ajuste por Inflacion Acumulado */
		select @i_ajus_infl_acum = isnull(@i_ajus_infl_acum,0)
		select @w_ajus_infl = isnull(@w_ajus_infl,0)
		select @w_ajus_infl_acum = @i_ajus_infl_acum + @w_ajus_infl

		/* Ajuste por Inflacion Diferido */
		select @w_ajus_infl_acum = isnull(@w_ajus_infl_acum,0)
		select @i_ajus_infl_diferido = isnull(@i_ajus_infl_diferido,0)
		select @w_diferido_ajustado = @w_ajus_infl_acum - @i_ajus_infl_diferido
		select @w_dias_saldo = @i_saldo_dias - @i_dias_amortizados
		select @w_diferido_ajustado = round((@w_diferido_ajustado / @w_dias_saldo) * 30,2)
		select @w_ajus_infl_diferido = @i_ajus_infl_diferido + @w_diferido_ajustado

		/* Costo Ajustado */
		select @w_cost_ajus = @i_am_acum_aju + @w_ajus_infl 

		/* Ajuste por Inflacion de la Depreciacion */
		select @w_ajus_infl_deprec = @i_amorti_acum_ajus * @i_paag /100

		/* Valor Diario */
		select @w_valor_dia = @w_cost_ajus / (@i_saldo_dias - @i_dias_amortizados)

		/* Dias Amortizados */
		select @w_dias_amortizados = 30

		/* Si la Depreciacion esta suspendida se calcula los dias que afecta */
		select @w_dias_menos = 0

		/* Dias Amortizados */
		select @w_dias_amortizados = @w_dias_amortizados - @w_dias_menos

		/* Depreciacion del mes efectuada */
		select @w_depr_mes = round(@w_valor_dia * @w_dias_amortizados,2) --ccr

		/* Depreciacion Acumulada */
		select @w_amorti_acum = @i_depre_acum + @w_depr_mes

		/* Depreciacion Acumulada Ajustada */
		select @w_amorti_acum_ajus = @i_amorti_acum_ajus + @w_depr_mes + @w_ajus_infl_deprec

		/* Activo Neto */
		select @w_activo_neto = @w_cost_ajus - @w_amorti_acum_ajus

		/* Actualizacion de la tabla de diferidos con los datos anteriores */
		begin tran
		update cb_diferidos
		set	di_dias_amortizados = @i_dias_amortizados + @w_dias_amortizados,
			di_amorti_acum = @w_amorti_acum,
			di_amorti_saldo = di_amorti_saldo - @w_depr_mes,
			di_fecha_ult_proc = @w_fecha_ult_proc,
			di_valor_dia = @w_valor_dia,
			di_ajus_infl = @w_ajus_infl,
			di_depr_mes = @w_depr_mes,
			di_ajus_infl_deprec = @w_ajus_infl_deprec,
			di_amorti_acum_ajus = @w_amorti_acum_ajus,
			di_ajus_infl_acum = @w_ajus_infl_acum,
			di_ajus_infl_diferido = @w_ajus_infl_diferido
		where di_empresa     = @i_empresa
		and   di_comprobante = @i_comprobante
		and   di_fecha_reg   = @i_fecha_reg
		and   di_asiento     = @i_asiento
		and   di_oficina_orig = @i_oficina_orig
		and   di_control     = @i_control
		if @@error <> 0
		begin
			select @w_numerror = 605084
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = @w_numerror
		end

		select @o_valor_gasto = @w_depr_mes, @o_diferido_ajustado = 0
		commit tran
	end	/****** Fin @w_opcion = 3  *******/
end
/************************* FIN OPERACION A ************************/


return 0

go
