/************************************************************************/
/*      Archivo:                cbsalfecha.sp                           */
/*      Stored procedure:       sp_cob_minuta                           */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Maria Claudia Morales M                 */
/*      Fecha de escritura:     17-Octubre-1997                         */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa muestra los saldos a las fechas de entrada con    */
/*      su variacion absoluta y relativa. Reporte EXCEL                 */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/************************************************************************/
use cob_conta
go

if exists (select 1 from sysobjects where name = 'sp_cob_salfech')
	drop proc sp_cob_salfech  

go
create proc sp_cob_salfech   (
	@s_ssn		  int = null,
	@s_date		  datetime = null,
	@s_user		  login = null,
	@s_term		  descripcion = null,
	@s_corr		  char(1) = null,
	@s_ssn_corr	  int = null,
    @s_ofi		  smallint = null,
	@t_rty		  char(1) = null,
    @t_trn		  smallint,
	@t_debug      char(1) = 'N',
	@t_file       varchar(14) = null,
	@t_from       varchar(30) = null,
	@i_cuenta     cuenta,
    @i_area       smallint,
    @i_oficina    smallint,
	@i_empresa    tinyint,
    @i_fecha      datetime,
    @i_fecha_ant  datetime
)
as 
declare
	@w_hoy          datetime,
	@w_return       int,
	@w_sp_name      varchar(32),
    @w_estado       char(1),
    @w_online       char(1),
    @w_empresa      tinyint,
    @w_tipo         char(1),
    @w_valor_hoy    money,
    @w_corte_h      char(1),
    @w_corte_a      char(1),
    @w_corte_num_h  int,
    @w_corte_num_a  int,
    @w_periodo_h    int,
    @w_periodo_a    int,
    @w_valor_ayer   money,
    @w_absoluta     money,
    @w_relativa     float
	
select @w_sp_name = 'sp_cob_salfech'

if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file          = @t_file,
		t_from          = @t_from,
		i_cuenta        = @i_cuenta,       
		i_empresa       = @i_empresa,
        i_fecha         = @i_fecha,
        i_area          = @i_area,
        i_oficina       = @i_oficina,
        i_fecha_ant     = @i_fecha
	exec cobis..sp_end_debug
end

/*  Tipo de Transaccion = 			*/
if @t_trn <> 6975 
begin
   /* 'Tipo de transaccion no corresponde' */
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file	 = @t_file,
   @t_from	 = @w_sp_name,
   @i_num	 = 601077
   return 1
end

/****************************************************/
/* verifica existencia de la cuenta en la tabla     */
/* cb_cuenta                                        */
/****************************************************/
select 1 from cb_cuenta
where cu_cuenta = @i_cuenta
and cu_empresa = @i_empresa

if @@rowcount = 0 begin
   /* 'Cuenta no existe   ' */
   select @w_valor_hoy  = 0 
   select @w_valor_ayer  = 0 
   select @w_absoluta  = 0 
   select @w_relativa   = 0
   select @w_valor_hoy, @w_valor_ayer, @w_absoluta, @w_relativa
   return 1
end
/****************************************************/
/* Saca periodo y corte para la fecha actual        */
/****************************************************/
select @w_corte_h     = co_estado,
       @w_periodo_h   = co_periodo,
       @w_corte_num_h = co_corte
from cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @i_fecha
and co_fecha_fin >= @i_fecha

/****************************************************/
/* Saca periodo y corte para la fecha anterior      */
/****************************************************/
select @w_periodo_a   = co_periodo,
       @w_corte_num_a = co_corte
from cb_corte
where co_empresa = @i_empresa
and co_fecha_ini <= @i_fecha_ant
and co_fecha_fin >= @i_fecha_ant

/****************************************************/
/* Extracta el saldo a esa fecha de entrada         */ 
/****************************************************/
if @w_corte_h = 'A'
   select @w_valor_hoy   = sum(sa_saldo)
   from cb_saldo
   where sa_cuenta  = @i_cuenta
   and sa_empresa = @i_empresa 
   and sa_periodo = @w_periodo_h
   and sa_corte   = @w_corte_num_h
   and sa_oficina in (select je_oficina from cb_jerarquia
                      where je_empresa = @i_empresa and
                      (je_oficina_padre = @i_oficina or
                      je_oficina = @i_oficina))
   and sa_area in (select ja_area from cb_jerararea
                   where ja_empresa = @i_empresa and
                   (ja_area_padre = @i_area or
                   ja_area = @i_area))
else
   select @w_valor_hoy   = sum(hi_saldo)
   from cob_conta_his..cb_hist_saldo
   where hi_cuenta  = @i_cuenta
   and hi_empresa = @i_empresa 
   and hi_periodo = @w_periodo_h
   and hi_corte   = @w_corte_num_h
   and hi_oficina in (select je_oficina from cb_jerarquia
                      where je_empresa = @i_empresa and
                      (je_oficina_padre = @i_oficina or
                      je_oficina = @i_oficina))
   and hi_area in (select ja_area from cb_jerararea
                   where ja_empresa = @i_empresa and
                   (ja_area_padre = @i_area or
                   ja_area = @i_area))
/******************************************************/
/* Extracta saldo a la fecha de entrada menos un dia  */
/******************************************************/
select @w_valor_ayer   = sum(hi_saldo)
from cob_conta_his..cb_hist_saldo
where hi_cuenta  = @i_cuenta
and hi_empresa = @i_empresa 
and hi_periodo = @w_periodo_a
and hi_corte   = @w_corte_num_a
and hi_oficina in (select je_oficina from cb_jerarquia
                   where je_empresa = @i_empresa and
                   (je_oficina_padre = @i_oficina or
                   je_oficina = @i_oficina))
and hi_area in (select ja_area from cb_jerararea
                where ja_empresa = @i_empresa and
                (ja_area_padre = @i_area or
                ja_area = @i_area))
/********************************************************/
/* Calcula variacion absoluta y relativa                */
/********************************************************/
select @w_absoluta = @w_valor_hoy - @w_valor_ayer
select @w_relativa = (@w_absoluta / @w_valor_ayer) / 100

select @w_valor_hoy, @w_valor_ayer, @w_absoluta, @w_relativa
go
