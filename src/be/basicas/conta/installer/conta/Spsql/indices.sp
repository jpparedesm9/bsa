/************************************************************************/
/*	Archivo: 		indices.sp  		                */
/*	Stored procedure: 	sp_indices    				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           N.Maldonado C.                      	*/
/*	Fecha de escritura:     12-mayo-1995 				*/
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
/*	Estado Analitico de Perdidas y Ganancias                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	18/May/95	N.Maldonado  	Emision Inicial			*/
/*	26/Jun/97	F.Salgado	Estandarizacion version 3.0	*/
/*					Manejo campo cu_categoria	*/
/************************************************************************/
use cob_conta
go

set ansi_nulls off
go

if exists (select 1 from sysobjects where name = 'sp_indices')
	drop proc sp_indices
go
create proc sp_indices    (
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
	@i_periodo      int  = null,
	@i_corte        smallint  = null,
	@i_secuencial   smallint  = null,
	@i_fecha	datetime = null,
        @i_proceso      smallint = 6024,
	@i_formato_fecha tinyint = 1
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
	@w_categoria	char(10),
	@w_texto	char(255),
	@w_disp_legal	char(255),
	@w_periodo	int,
	@w_periodo1	int,
	@w_periodo2	int,
	@w_corte	int,
        @w_moneda       smallint,
	@w_existe	tinyint		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_indices'


/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6705 and @i_operacion = 'S') 
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
		i_oficina	= @i_oficina,
		i_periodo    	= @i_periodo
	exec cobis..sp_end_debug
end

/* Calcula el periodo y corte */    
select @w_corte = co_corte,
	@w_periodo = co_periodo
from cob_conta..cb_corte
where @i_fecha between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

/* Validaciones generales */
if @i_operacion = 'S'
begin   
	set rowcount 20
	if @i_modo = 0
	begin
              select @w_existe = count(*) from cb_cuenta_proceso
                where cp_empresa = @i_empresa and
                      cp_proceso = @i_proceso
	      if @@rowcount = 0
		begin
		/* 'Existe definida mas de una condicion en Cuenta Proceso ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603061
			return 1
                end
              select 	'Secuencia' = ca_secuencial,
                        'Cuenta' = ca_cta_asoc,
			'Nombre Cuenta' = substring(cu_nombre,1,32),
			'Saldo' = bl_saldo_mna,
                        'Categoria' = cu_categoria,
                        'condicion' = ca_condicion,
                        'operacion' = ca_debcred
		from cb_cuenta, cb_cuenta_asociada             
        left outer join cb_balsuper
        on ca_cta_asoc = bl_cuenta  
		where   ca_empresa = @i_empresa and
                ca_proceso = @i_proceso and
                cu_cuenta   = ca_cta_asoc and
                cu_empresa = @i_empresa and
                bl_empresa = @i_empresa and
			bl_oficina = @i_oficina and
		        bl_periodo = @w_periodo and
			bl_corte   = @w_corte   

                order by ca_secuencial
		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065
			return 1
		end
	end
	else
	begin
                select 	'Secuencia' = ca_secuencial,
		       	'Cuenta' = ca_cta_asoc,
			'Nombre Cuenta' = substring(cu_nombre,1,32),
			'Saldo' = bl_saldo_mna,
                        'Categoria' = cu_categoria,
                        'condicion' = ca_condicion,
                        'operacion' = ca_debcred
		from cb_cuenta, cb_cuenta_asociada             
        left outer join cb_balsuper
        on ca_cta_asoc = bl_cuenta 
		where   ca_empresa = @i_empresa and
                        ca_proceso = @i_proceso and
                        ca_secuencial > @i_secuencial and
                        cu_cuenta   = ca_cta_asoc and
                        cu_empresa = @i_empresa and
                        bl_empresa = @i_empresa and
			bl_oficina = @i_oficina and
		        bl_periodo = @w_periodo and
			bl_corte   = @w_corte
                order by ca_secuencial
		if @@rowcount = 0
		begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065
			return 1
		end
	end
return 0
end
go

