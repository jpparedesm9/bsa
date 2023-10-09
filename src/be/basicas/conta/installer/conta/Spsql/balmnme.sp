/************************************************************************/
/*	Archivo: 		balmnme.sp    		                */
/*	Stored procedure: 	sp_balmnme   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                   .                         	*/
/*	Fecha de escritura:                     			*/
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
/*	reporte de Balance en MN y en ME                                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	16/feb/1996     O. Hoyos     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_balmnme')
	drop proc sp_balmnme    
go

create proc sp_balmnme    (
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
	@w_periodo_ano	int,
	@w_periodo1	int,
	@w_periodo2	int,
	@w_corte	int,
	@w_corte_ano	int,
	@w_corte1	int,
	@w_corte2	int,
        @w_moneda       smallint,
        @w_fecha1       datetime, /* fecha de un mes atras */
        @w_fecha_ano    datetime, /* fecha de un mes atras */
        @w_fecha2       datetime, /* fecha de dos mes atras */
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

if (@t_trn <> 6010 and (@i_operacion = 'N' or @i_operacion = 'E')) 
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
select @w_moneda = datepart(day,@i_fecha)
select @w_moneda = @w_moneda * -1
select @w_fecha1 = dateadd(day, @w_moneda,@i_fecha)
select @w_moneda = datepart(day,@w_fecha1)
select @w_moneda = @w_moneda * -1
select @w_fecha2 = dateadd(day, @w_moneda, @w_fecha1)

select @w_fecha_ano = dateadd(year,-1,@i_fecha)

/* Calcula los periodos y cortes */
select @w_corte = co_corte,
	@w_periodo = co_periodo,
	@w_estado = co_estado
from cob_conta..cb_corte
where @i_fecha between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

select @w_corte1 = co_corte,
	@w_periodo1 = co_periodo
from cob_conta..cb_corte
where @w_fecha1 between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

select @w_corte2 = co_corte,
	@w_periodo2 = co_periodo
from cob_conta..cb_corte
where @w_fecha2 between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

--print 'fecha ano %1!', @w_fecha_ano
select @w_corte_ano = isnull(co_corte,0),
	@w_periodo_ano = isnull(co_periodo,0)
from cob_conta..cb_corte
where @w_fecha_ano between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

--print 'periodo %1! corte %2!',@w_periodo_ano, @w_corte_ano
/* Validaciones generales */
select @w_moneda = em_moneda_base
  from cb_empresa
       where em_empresa = @i_empresa

if @i_operacion = 'N'
begin  
select bl_cuenta,bl_saldo_mna
from cob_conta..cb_balsuper
where bl_empresa = @i_empresa
and   bl_oficina = @i_oficina
and   bl_periodo = @w_periodo
and   bl_corte   = @w_corte
order by bl_cuenta

return 0
end

go

