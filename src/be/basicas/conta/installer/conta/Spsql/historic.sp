/************************************************************************/
/*      Archivo: 		historico.sp	              		*/
/*	Stored procedure: 	sp_historico  				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Ma.del Pilar Vizuete                   	*/
/*	Fecha de escritura:     17-Julio-1995				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Genera los cortes de un periodo de acuerdo al tipo           */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	17/Jul/1995	M.Vizuete     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_historico')
	drop proc sp_historico      

go
create proc sp_historico (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
        @i_operacion    char(1) = null,
	@i_empresa    	tinyint = null,
	@i_fecha	datetime = null,
	@i_cuenta	cuenta = null
)
as 

declare
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
        @w_corte        int,
        @w_periodo      int,
	@w_estado	char(1),
        @w_ayer         int,
        @w_saldo        int

select @w_sp_name = 'sp_historico'


if (@t_trn <> 6842 and @i_operacion = 'S')
begin
     /* Tipo de transaccion no corresponde */
     exec cobis..sp_cerror
     @t_debug = @t_debug,
     @t_file  = @t_file,
     @t_from  = @w_sp_name,
     @i_num   = 607017
     return 1
end


select @w_corte = co_corte,
	@w_estado = co_estado,
       @w_periodo = co_periodo
from cb_corte
where co_empresa = @i_empresa
  and co_fecha_ini <= @i_fecha
  and co_fecha_fin >= @i_fecha


if @i_operacion = 'S'
begin
	if @w_estado = 'A'
    		select cu_nombre,sa_saldo
    		from cb_saldo,cb_cuenta,cb_cuenta_proceso,cb_oficina
    		where sa_empresa = @i_empresa
      		and sa_periodo = @w_periodo
      		and sa_corte = @w_corte
      		and sa_cuenta= cu_cuenta
      		and sa_empresa=cu_empresa
      		and sa_cuenta = cp_cuenta
      		and of_oficina>=10 and of_oficina<=17
      		and cp_proceso = 6029
      		and of_empresa = sa_empresa
	else
    		select cu_nombre,hi_saldo
    		from cob_conta_his..cb_hist_saldo,cb_cuenta,cb_cuenta_proceso,cb_oficina
    		where hi_empresa = @i_empresa
      		and hi_periodo = @w_periodo
      		and hi_corte = @w_corte
      		and hi_cuenta= cu_cuenta
      		and hi_empresa=cu_empresa
      		and hi_cuenta = cp_cuenta
      		and of_oficina>=10 and of_oficina<=17
      		and cp_proceso = 6029
      		and of_empresa = hi_empresa

    if @@rowcount = 0
    begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601065
	return 1
    end
    return 0
end

if @i_operacion = 'C'
begin
    select @w_ayer= @w_corte -1
	if @w_estado = 'A'
    		select cu_nombre,sa_saldo
           	/*select @w_saldo = round(sa_saldo/1000000,0)*/
    		from cb_saldo,cb_cuenta,cb_cuenta_proceso,cb_oficina
    		where sa_empresa = @i_empresa
      		and sa_periodo = @w_periodo
      		and sa_corte = @w_ayer
      		and sa_cuenta= cu_cuenta
      		and sa_empresa=cu_empresa
      		and sa_cuenta = cp_cuenta
      		and of_oficina>=10 and of_oficina<=17
      		and cp_proceso = 6029
      		and of_empresa = sa_empresa
	else
    		select cu_nombre,hi_saldo
           	/*select @w_saldo = round(hi_saldo/1000000,0)*/
    		from cob_conta_his..cb_hist_saldo,cb_cuenta,cb_cuenta_proceso,cb_oficina
    		where hi_empresa = @i_empresa
      		and hi_periodo = @w_periodo
      		and hi_corte = @w_ayer
      		and hi_cuenta= cu_cuenta
      		and hi_empresa=cu_empresa
      		and hi_cuenta = cp_cuenta
      		and of_oficina>=10 and of_oficina<=17
      		and cp_proceso = 6029
      		and of_empresa = hi_empresa

    if @@rowcount = 0
    begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601065
	return 1
    end
    return 0
end
go
