/************************************************************************/
/*	Archivo: 		scodi.sp	    		        */
/*	Stored procedure: 	sp_scodi   				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Edgar Suasti Cardenas               	*/
/*	Fecha de escritura:     10-Abril-1995 				*/
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
/*	Este programa procesa la transaccion de:			*/
/*	   Saldos consolidados diarios (JM-521) para la superbanco      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	10/Abr/1995	E Suasti C.     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_scodi')
	drop proc sp_scodi    











go
create proc sp_scodi    (
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
	@i_cuenta1    	cuenta = null,
	@i_oficina 	smallint = null,
	@i_area		smallint = null,
	@i_periodo      int  = null,
	@i_fecha_fin	datetime = null,
	@i_formato_fecha	tinyint = 1
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
	@w_tipo_dinamica	char(1),
	@w_categoria	char(10),
	@w_texto	char(255),
	@w_disp_legal	char(255),
	@w_periodo	int,
	@w_corte	int,
	@w_estado_corte	char(1),
	@w_existe	tinyint		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_scodi'


/************************************************/
/*  Tipo de Transaccion =     			*/

if @t_trn <> 6736 and @i_operacion = 'S' 
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


if @i_operacion = 'S'
begin
	set rowcount 20
	
	select 	@w_corte = co_corte,
		@w_periodo = co_periodo,
		@w_estado_corte = co_estado
	  from 	cob_conta..cb_corte
	 where  @i_fecha_fin between co_fecha_ini 
	   and  co_fecha_fin 
	   and  co_empresa = @i_empresa

	select @w_categoria = substring(@i_cuenta,1,1)

	if @w_categoria in ('2','3','4') 
		
		select @w_operador = -1
	else
		select @w_operador = 1


	if @i_modo = 0
	begin
		if @w_estado_corte = 'A'
		begin
			select 	'Codigo'       = sa_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Valor'        = sum(sa_saldo * @w_operador)
			  from  cb_cuenta_proceso,
		     		cb_saldo,
				cb_jerarquia,
				cb_jerararea,
		     		cb_cuenta
			 where sa_empresa   = @i_empresa
                  	   and sa_empresa   = cu_empresa
                  	   and sa_cuenta    = cu_cuenta
                 	   and sa_periodo   = @w_periodo
                  	   and sa_corte     = @w_corte
                 	   and sa_oficina   = @i_oficina
                 	   and sa_area      = @i_area 
               	  	   and sa_empresa   = cp_empresa
                  	   and sa_cuenta    = cp_cuenta
                  	   and sa_oficina   = cp_oficina
                  	   and sa_area      = cp_area
			   and ja_empresa   = @i_empresa
			   and ja_area_padre = @i_area
			   and ja_area      = sa_area
   			   and je_empresa   = @i_empresa
			   and je_oficina_padre = @i_oficina
			   and je_oficina   = sa_oficina
                  	   and cp_proceso   = 6100 
			 group by sa_cuenta,
				  cu_nombre
                	 order by sa_cuenta 
 
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
			select 	'Codigo'       = hi_cuenta,
				'Nombre Cuenta'= cu_nombre,
				'Valor'        = sum(hi_saldo * @w_operador)
			  from  cb_cuenta_proceso,
		     		cob_conta_his..cb_hist_saldo,
				cb_jerarquia,
				cb_jerararea,
		     		cb_cuenta
			 where hi_empresa   = @i_empresa
                  	   and hi_empresa   = cu_empresa
                  	   and hi_cuenta    = cu_cuenta
                 	   and hi_periodo   = @w_periodo
                  	   and hi_corte     = @w_corte
                 	   and hi_oficina   = @i_oficina
                 	   and hi_area      = @i_area 
               	  	   and hi_empresa   = cp_empresa
                  	   and hi_cuenta    = cp_cuenta
                  	   and hi_oficina   = cp_oficina
                  	   and hi_area      = cp_area
			   and ja_empresa   = @i_empresa
			   and ja_area_padre = @i_area
			   and ja_area      = hi_area
   			   and je_empresa   = @i_empresa
			   and je_oficina_padre = @i_oficina
			   and je_oficina   = hi_oficina
                  	   and cp_proceso   = 6100 
			 group by hi_cuenta,
				  cu_nombre
                	 order by hi_cuenta 
 
			if @@rowcount = 0
			begin
			/* 'No existen Saldos para la Cuenta Especificada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601065
			end
		end
	
	end
return 0
end
go

