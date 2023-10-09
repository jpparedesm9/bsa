/************************************************************************/
/*	Archivo: 		estcam.sp    		                */
/*	Stored procedure: 	sp_estcam   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           M.Suarez I.                         	*/
/*	Fecha de escritura:     19-abril-1995 				*/
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
/*	19/feb/96	L. A. Alvarez   Emision Inicial			*/
/*	26/Jun/97	F. Salgado	Estandarizacion version 3.0	*/
/*					Manejo campo cu_categoria	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_estcam')
	drop proc sp_estcam    

go
create proc sp_estcam    (
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
	@w_periodo1	int,
	@w_periodo2	int,
	@w_corte	int,
	@w_corte1	int,
	@w_corte2	int,
        @w_moneda       smallint,
        @w_fecha1       datetime, /* fecha de un mes atras */
        @w_fecha2       datetime, /* fecha de dos mes atras */
	@w_existe	tinyint,	/* codigo existe = 1 
				               no existe = 0 */
        @w_valor1       money,
        @w_cotiz1       money,
        @w_valor2       money,
        @w_cotiz2       money,
        @w_valor3       money,
        @w_cotiz3       money

select @w_today = getdate()
select @w_sp_name = 'sp_estcam'

/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6702 and @i_operacion = 'S') 
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


/* Calcula los periodos y cortes */
select @w_corte = co_corte,
	@w_periodo = co_periodo
from cob_conta..cb_corte
where @i_fecha between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

/* Validaciones generales */
if @i_operacion = 'S'
begin  
                select @w_signo = (ascii(cu_categoria) - ascii('C')) +
                                  (ascii(cu_categoria) - ascii('D'))
                  from cb_cuenta
                 where cu_empresa = @i_empresa
                   and cu_cuenta  = @i_cuenta

                select cu_nombre,
                       sum(sa_saldo)
                  from cb_cuenta, cb_jerarquia, cb_jerararea, cb_saldo
                 where cu_empresa = @i_empresa
                   and cu_cuenta = @i_cuenta
                   and je_empresa = @i_empresa
                   and je_oficina_padre = @i_oficina
                   and ja_empresa = @i_empresa
                   and ja_area_padre = @i_area
                   and sa_empresa = @i_empresa
                   and sa_periodo = @w_periodo
                   and sa_corte = @w_corte
                   and je_oficina = sa_oficina
                   and ja_area = sa_area
                   and cu_cuenta = sa_cuenta
                 group by cu_nombre


return 0
end
go

