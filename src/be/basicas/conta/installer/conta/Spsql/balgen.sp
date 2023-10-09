/************************************************************************/
/*	Archivo: 		balgen.sp    		                */
/*	Stored procedure: 	sp_balgen   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           O. Hoyos F.                         	*/
/*	Fecha de escritura:     19-Febrero-1996				*/
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
/*	Este programa reporta los saldos a excell para emitir el        */
/*	reporte de saldos diarios de captaciones y encaje interno       */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	16/feb/1996     O. Hoyos     Emision Inicial			*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_balgen')
	drop proc sp_balgen
go

create proc sp_balgen    (
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
	@i_empresa	tinyint  = null,
	@i_cuenta     	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_fecha	datetime = null,
        @i_indicador    tinyint  = 0, --indicador 0=solo ctas M.E 1=todas
        @i_dolar        tinyint  = 2  -- Codigo de la moneda deseada (dolar)
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
	@w_operador	int,
	@w_tipo_dinamica char(1),
	@w_signo	smallint,
	@w_nombre	descripcion,
	@w_disp_legal	char(255),
	@w_periodo	int,
        @w_periodommant	int,
	@w_periodo_ano	int,
	@w_periodo_mes	int,
	@w_periodo1	int,
	@w_periodo2	int,
	@w_corte	int,
        @w_cortemmant	int,
	@w_corte_ano	int,
	@w_corte_mes	int,
	@w_corte1	int,
	@w_corte2	int,
        @w_moneda       smallint,
        @w_fecha1       datetime, /* fecha de un mes atras */
        @w_fecha_ano    datetime, /* fecha de un mes atras */
        @w_fecha_mes    datetime, /* fecha de un mes atras */
        @w_fecha2       datetime, /* fecha de dos mes atras */
        @w_fechammant   datetime,
	@w_existe	tinyint,	/* codigo existe = 1 
				               no existe = 0 */
        @w_valor1       money,
        @w_cotiz1       money,
        @w_valor2       money,
        @w_cotiz2       money,
	@w_estado     	char(1),
        @w_valor3       money,
        @w_cotiz3       money

select @w_today = getdate()
select @w_sp_name = 'sp_balgen'

/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6010 and (@i_operacion = 'S' or @i_operacion = 'Q' or @i_operacion = 'C' or @i_operacion = 'N' or @i_operacion = 'E')) 
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
		i_cuenta     	= @i_cuenta,
		i_oficina	= @i_oficina
	exec cobis..sp_end_debug
end

/* Calcula los 2 periodos anteriores */
select @w_fecha1 = dateadd(day, -datepart(day,@i_fecha), @i_fecha)
select @w_fecha2 = dateadd(day, -datepart(day,@w_fecha1), @w_fecha1)

if @i_indicador = 0
begin
	select @w_fecha_ano = dateadd(mm, -datepart(mm,@i_fecha) + 1, @i_fecha)
	select @w_fecha_ano = dateadd(dd, -datepart(dd,@w_fecha_ano), @w_fecha_ano)
end
else
begin
	select @w_fecha_ano = dateadd(dd, -datepart(dd,@i_fecha), @i_fecha)
end

/* Calcula los periodos y cortes */
select  @w_corte = co_corte,
	@w_periodo = co_periodo,
	@w_estado = co_estado
from cob_conta..cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @i_fecha
and co_fecha_fin >= @i_fecha

select  @w_corte1 = co_corte,
	@w_periodo1 = co_periodo
from cob_conta..cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @w_fecha1
and co_fecha_fin >= @w_fecha1

select @w_corte2 = co_corte,
	@w_periodo2 = co_periodo
from cob_conta..cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @w_fecha2
and co_fecha_fin >= @w_fecha2

select @w_corte_ano = isnull(co_corte,0),
	@w_periodo_ano = isnull(co_periodo,0)
from cob_conta..cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @w_fecha_ano
and co_fecha_fin >= @w_fecha_ano

/* Validaciones generales */
select @w_moneda = em_moneda_base
from cb_empresa
where em_empresa = @i_empresa

if @i_operacion = 'S'
begin  
	select @w_nombre = 'NO ASOCIADA A LA OFICINA'
	select 	@w_nombre = cu_nombre
	from  cb_cuenta
	where  cu_empresa = @i_empresa
	and cu_cuenta  = @i_cuenta

	if @w_estado = 'A'
	begin
		select	@w_valor1=isnull(sa_saldo,0)
		from    cb_saldo
		where   sa_empresa = @i_empresa and
		        sa_periodo = @w_periodo and
			sa_corte   = @w_corte  and
			sa_oficina = @i_oficina and
			sa_area    = @i_area and
			sa_cuenta  = @i_cuenta

		select 	@w_valor2=isnull(hi_saldo,0)
		from    cob_conta_his..cb_hist_saldo
		where   hi_empresa = @i_empresa and
		        hi_periodo = @w_periodo_ano and
			hi_corte   = @w_corte_ano  and
			hi_oficina = @i_oficina and
			hi_area    = @i_area and
			hi_cuenta  = @i_cuenta
	end
	else
	begin
		select 	@w_valor1=isnull(hi_saldo,0)
		from    cob_conta_his..cb_hist_saldo
		where   hi_empresa = @i_empresa and
		        hi_periodo = @w_periodo and
			hi_corte   = @w_corte  and
			hi_oficina = @i_oficina and
			hi_area    = @i_area and
			hi_cuenta  = @i_cuenta

		select  @w_valor2 = 0
		select 	@w_valor2=isnull(hi_saldo,0)
		from    cob_conta_his..cb_hist_saldo
		where   hi_empresa = @i_empresa and
		        hi_periodo = @w_periodo_ano and
			hi_corte   = @w_corte_ano  and
			hi_oficina = @i_oficina and
			hi_area    = @i_area and
			hi_cuenta  = @i_cuenta
	end

	select @w_nombre, @w_valor2, @w_valor1
return 0
end



if @i_operacion = 'M'
begin  
	select  @w_corte = co_corte,
		@w_periodo = co_periodo,
		@w_estado = co_estado
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @i_fecha
	and co_fecha_fin >= @i_fecha

	select @w_fecha_mes = dateadd(dd, -datepart(dd,@i_fecha), @i_fecha)

	select  @w_corte_mes   = isnull(co_corte,0),
		@w_periodo_mes = isnull(co_periodo,0)
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @w_fecha_mes
	and co_fecha_fin >= @w_fecha_mes

	set rowcount 20
	if @i_indicador = 0
		if @w_estado = 'A'
		begin

			select sa_cuenta,cu_nombre,sum(sa_saldo)
			from cob_conta..cb_saldo,cob_conta..cb_cuenta
			where sa_empresa = @i_empresa
			and   sa_periodo = @w_periodo
			and   sa_corte   = @w_corte
                	and   cu_empresa = sa_empresa
			and   cu_cuenta  = sa_cuenta
                	and   cu_cuenta  > @i_cuenta
			group by sa_cuenta,cu_nombre, sa_saldo
			order by sa_cuenta
		end
		else
		begin
			select hi_cuenta,cu_nombre,sum(hi_saldo)
			from cob_conta_his..cb_hist_saldo,cob_conta..cb_cuenta
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte   = @w_corte
                	and   cu_empresa = hi_empresa
			and   cu_cuenta  = hi_cuenta
                	and   cu_cuenta  > @i_cuenta
			group by hi_cuenta,cu_nombre, hi_saldo
			order by hi_cuenta



		end
	else
	begin
		select @w_valor1 = isnull(sum(hi_saldo),0)
		from cob_conta_his..cb_hist_saldo
		where hi_empresa = @i_empresa
		and   hi_periodo = @w_periodo_mes
		and   hi_corte   = @w_corte_mes
                and   hi_cuenta  = @i_cuenta

		select @w_valor1

	end
	set rowcount 0

return 0
end


if @i_operacion = 'A'
begin  
	select  @w_corte = co_corte,
		@w_periodo = co_periodo,
		@w_estado = co_estado
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @i_fecha
	and co_fecha_fin >= @i_fecha

	select @w_fecha_ano = dateadd(mm, -datepart(mm,@i_fecha) + 1, @i_fecha)
	select @w_fecha_ano = dateadd(dd, -datepart(dd,@w_fecha_ano), @w_fecha_ano)

	select  @w_corte_ano   = isnull(co_corte,0),
		@w_periodo_ano = isnull(co_periodo,0)
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @w_fecha_ano
	and co_fecha_fin >= @w_fecha_ano

	set rowcount 20
	if @i_indicador = 0
		if @w_estado = 'A'
		begin

			select sa_cuenta,cu_nombre,sum(sa_saldo)
			from cob_conta..cb_saldo,cob_conta..cb_cuenta
			where sa_empresa = @i_empresa
			and   sa_periodo = @w_periodo
			and   sa_corte   = @w_corte
                	and   cu_empresa = sa_empresa
			and   cu_cuenta  = sa_cuenta
                	and   cu_cuenta  > @i_cuenta
			group by sa_cuenta,cu_nombre, sa_saldo
			order by sa_cuenta
		end
		else
		begin
			select hi_cuenta,cu_nombre,sum(hi_saldo)
			from cob_conta_his..cb_hist_saldo,cob_conta..cb_cuenta
			where hi_empresa = @i_empresa
			and   hi_periodo = @w_periodo
			and   hi_corte   = @w_corte
                	and   cu_empresa = hi_empresa
			and   cu_cuenta  = hi_cuenta
                	and   cu_cuenta  > @i_cuenta
			group by hi_cuenta,cu_nombre,hi_saldo
			order by hi_cuenta



		end
	else
	begin
		select @w_valor1 = isnull(sum(hi_saldo),0)
		from cob_conta_his..cb_hist_saldo
		where hi_empresa = @i_empresa
		and   hi_periodo = @w_periodo_ano
		and   hi_corte   = @w_corte_ano
                and   hi_cuenta  = @i_cuenta

		select @w_valor1

	end
	set rowcount 0

return 0
end


if @i_operacion = 'C'
begin
	select @w_nombre = 'No asociada a la empresa'
	if @w_estado = 'A'
	begin
	     select  @w_nombre = cu_nombre,
	             @w_valor1 =(sum(sa_saldo))
	       from  cb_saldo,
	             cb_cuenta,
	             cb_jerararea,
	             cb_jerarquia
	      where  sa_empresa = @i_empresa
	             and sa_periodo = @w_periodo
	             and sa_corte   = @w_corte
	             and cu_empresa = @i_empresa
	             and cu_cuenta  = @i_cuenta
	             and sa_cuenta  = cu_cuenta
	             and je_empresa = @i_empresa
	             and je_oficina_padre = @i_oficina
	             and je_oficina = sa_oficina
		     and ja_area_padre = @i_area
	             and ja_area = sa_area
		group by cu_cuenta, cu_nombre, sa_saldo
	end
	else
	begin
	     select  @w_nombre = cu_nombre,         
	             @w_valor1 =(sum(hi_saldo))           
	       from  cob_conta_his..cb_hist_saldo,                    
	             cb_cuenta,
	             cb_jerararea ,
	             cb_jerarquia                   
	      where  hi_empresa = @i_empresa
	             and hi_periodo = @w_periodo
	             and hi_corte   = @w_corte
	             and cu_empresa = @i_empresa
	             and cu_cuenta  = @i_cuenta
	             and hi_cuenta  = cu_cuenta
	             and je_empresa = @i_empresa
	             and je_oficina_padre = @i_oficina
	             and je_oficina = hi_oficina
		     and ja_area_padre = @i_area
	             and ja_area = hi_area
		group by cu_cuenta, cu_nombre, hi_saldo
	end
	select @w_nombre , @w_valor1 , @w_valor2
return 0
end


if @i_operacion = 'Q'
begin  
	select 	sa_saldo
	from cob_conta..cb_saldo
	where   sa_empresa = @i_empresa and
	        sa_periodo = @w_periodo and
		sa_corte   = @w_corte  and
		sa_oficina = @i_oficina and
		sa_area    > 0 and
		sa_cuenta  = @i_cuenta
	return 0
end


if @i_operacion = 'N'
begin
	select @w_fechammant = dateadd(mm,-1,@i_fecha)
	
	select  @w_cortemmant = co_corte,
		@w_periodommant = co_periodo
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_fecha_ini <= @w_fechammant
	and co_fecha_fin >= @w_fechammant

	set rowcount 20
	if @i_modo = 0
	begin
		select bl_cuenta,cu_nombre
		from cob_conta..cb_balsuper,cb_cuenta
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   cu_empresa = bl_empresa
		and   cu_cuenta  = bl_cuenta
		order by bl_cuenta
	end

	if @i_modo = 1
	begin
		select bl_cuenta,cu_nombre
		from cob_conta..cb_balsuper,cb_cuenta
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   cu_empresa = bl_empresa
		and   cu_cuenta  = bl_cuenta
		and   bl_cuenta  > @i_cuenta
		order by bl_cuenta
	end

	if @i_modo = 2
	begin
		select bl_saldo_mna,bl_debito,bl_credito
		from cob_conta..cb_balsuper
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   bl_cuenta  = @i_cuenta
		order by bl_cuenta
	end


	if @i_modo = 3
	begin
		select bl_saldo_mna,bl_debito,bl_credito
		from cob_conta..cb_balsuper
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodommant
		and   bl_corte   = @w_cortemmant
		and   bl_cuenta  = @i_cuenta
		order by bl_cuenta
	end
	set rowcount 0
return 0
end


if @i_operacion = 'E'
begin  
	select @w_fechammant = dateadd(mm,-1,@i_fecha)
	select  @w_cortemmant = co_corte,
		@w_periodommant = co_periodo
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and @w_fechammant between co_fecha_ini and co_fecha_fin


	set rowcount 20
	if @i_modo = 0
	begin
		select bl_cuenta,cu_nombre
		from cob_conta..cb_balsuper,cb_cuenta
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   cu_empresa = bl_empresa
		and   cu_cuenta  = bl_cuenta
		order by bl_cuenta
	end

	if @i_modo = 1
	begin
		select bl_cuenta,cu_nombre
		from cob_conta..cb_balsuper,cb_cuenta
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   cu_empresa = bl_empresa
		and   cu_cuenta  = bl_cuenta
		and   bl_cuenta  > @i_cuenta
		order by bl_cuenta
	end

	if @i_modo = 2
	begin
		select bl_saldo_dol,bl_debito_me,bl_credito_me
		from cob_conta..cb_balsuper
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodo
		and   bl_corte   = @w_corte
		and   bl_cuenta  = @i_cuenta
		order by bl_cuenta
	end


	if @i_modo = 3
	begin
		select bl_saldo_dol,bl_debito_me,bl_credito_me
		from cob_conta..cb_balsuper
		where bl_empresa = @i_empresa
		and   bl_oficina = @i_oficina
		and   bl_periodo = @w_periodommant
		and   bl_corte   = @w_cortemmant
		and   bl_cuenta  = @i_cuenta
		order by bl_cuenta
	end
	set rowcount 0
	return 0
end

go
