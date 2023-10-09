/************************************************************************/
/*	Archivo: 		saldoexc.sp	    		        */
/*	Stored procedure: 	sp_saldo_exc   				*/
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
/*	   Seleccion de Rgistros de Saldos para Excel                   */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	01/Dic/1997	MV.Garay       Comentar mensajes de error para  */ 
/*                                     excel MVG                        */ 
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_saldo_exc')
	drop proc sp_saldo_exc    
go
create proc sp_saldo_exc    (
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
	@i_fecha_fin	datetime = 0,
	@i_nivel_igual  tinyint  = 0,
	@i_nivel_menor  tinyint  = 0,
	@i_formato_fecha smallint = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_cuenta  	cuenta,
	@w_operador	int,
	@w_tipo_dinamica	char(1),
	@w_periodo	int,
	@w_corte	int,
	@w_estado       char(1),
        @w_nombre_cta   char(20), 
        @w_saldomn      money,
        @w_saldome      money,
        @w_categoria    char(1),
	@w_existe	tinyint		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_saldo'

/*
/************************************************/
/*  Tipo de Transaccion =     			*/

if (@t_trn <> 6813 and @i_operacion = 'C') or
   (@t_trn <> 6812 and @i_operacion = 'S') 
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
*/

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


/*print 'fecha fin %1! ', @i_fecha_fin*/

select  @w_corte = co_corte,
	@w_periodo = co_periodo,
	@w_estado = co_estado
from cob_conta..cb_corte
where @i_fecha_fin between co_fecha_ini and co_fecha_fin and
	co_empresa = @i_empresa

if @i_operacion = 'S'
begin

	set rowcount 20
	
	if @w_estado = 'A'
        begin
		if @i_modo = 0
		begin
			select 	'CUENTA' = sa_cuenta,
			        'NOMBRE CUENTA' = cu_nombre,
			        'SALDO MN' = sa_saldo, 
			        'SALDO ME' = sa_saldo_me /*,
                                @w_categoria = cu_categoria */
			from cob_conta..cb_saldo, cb_cuenta
	        	where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
		      		sa_empresa = @i_empresa and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_oficina = @i_oficina and
				sa_area    = @i_area and
				sa_cuenta like @i_cuenta and
				cu_cuenta = sa_cuenta 


			 /*if @@rowcount = 0
			begin
			/* 'No existen Saldos para la Cuenta Especificada' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/ 
		end
		else
		begin
			set rowcount 20

			select 	'CUENTA' = sa_cuenta,
				'NOMBRE CUENTA' = cu_nombre,
				'SALDO MN' = sa_saldo, 
				'SALDO ME' = sa_saldo_me/*,
                                @w_categoria = cu_categoria*/
			from cob_conta..cb_saldo, cb_cuenta
			where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				sa_empresa = @i_empresa and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_oficina = @i_oficina and
				sa_area = @i_area and
				sa_cuenta like @i_cuenta and
				sa_cuenta > @i_cuenta1 and
				sa_cuenta = cu_cuenta
	
	/*		if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/ 
		end
	end
	else
	begin
		if @i_modo = 0
		begin

			select 	'CUENTA' = hi_cuenta,
				'NOMBRE CUENTA' = cu_nombre,
				'SALDO MN' = hi_saldo, 
				'SALDO ME' = hi_saldo_me/*,
                                @w_categoria = cu_categoria */
			from cob_conta_his..cb_hist_saldo, cb_cuenta
	        	where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
		      		hi_empresa = @i_empresa and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_oficina = @i_oficina and
				hi_area    = @i_area and
				hi_cuenta like @i_cuenta and
				cu_cuenta = hi_cuenta 

		  /*	if @@rowcount = 0
			begin
				/* 'No existen Saldos para la Cuenta Especificada' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/ 
		end
		else
		begin
			set rowcount 20
			select 	'CUENTA' = hi_cuenta,
				'NOMBRE CUENTA' = cu_nombre,
				'SALDO MN' = hi_saldo, 
				'SALDO ME' = hi_saldo_me /*,
                                @w_categoria = cu_categoria*/
			from cob_conta_his..cb_hist_saldo, cb_cuenta
			where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				hi_empresa = @i_empresa and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_oficina = @i_oficina and
				hi_area = @i_area and
				hi_cuenta like @i_cuenta and
				hi_cuenta > @i_cuenta1 and
				hi_cuenta = cu_cuenta
	
			 /*if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/ 
	
		end
	end
return 0
end

if @i_operacion = 'C'  /* SELECCION DE SALDOS CONSOLIDADOS */
begin
	set rowcount 20
	if @w_estado = 'A'
        begin
		if @i_modo = 0
		begin

		select 	'CUENTA' = sa_cuenta,
                        'NOMBRE CUENTA' = cu_nombre,
                        'SALDO MN' = sum(sa_saldo),
                        'SALDO ME' = sum(sa_saldo_me )/*,
                        @w_categoria = cu_categoria*/
		from cb_jerarquia, cb_jerararea,cb_cuenta,cb_saldo
	        	where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
		      		sa_empresa = je_empresa and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_oficina = je_oficina and
				sa_area    = ja_area and
				sa_cuenta like @i_cuenta and
				sa_cuenta = cu_cuenta 
			group by sa_cuenta, cu_nombre

		/*if @@rowcount = 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end */
		end
		else
		begin
			set rowcount 20
			select 	'CUENTA' = sa_cuenta,
                                'NOMBRE CUENTA' = cu_nombre,
                                'SALDO MN' = sum(sa_saldo),
                                'SALDO ME' = sum(sa_saldo_me)/*,
                                @w_categoria = cu_categoria*/
			from cb_jerarquia, cb_jerararea,cb_saldo, cb_cuenta
			where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				sa_empresa = je_empresa and
				sa_periodo = @w_periodo and
				sa_corte = @w_corte and
				sa_oficina = je_oficina and
				sa_area = ja_area and
				sa_cuenta like @i_cuenta and
				sa_cuenta > @i_cuenta1 and
				sa_cuenta = cu_cuenta
		       	group by sa_cuenta, cu_nombre


			/*if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/
		end
	end
	else
	begin
		if @i_modo = 0
		begin

			select 	'CUENTA' = hi_cuenta,
                                'NOMBRE CUENTA' = cu_nombre,
                                'SALDO MN' = sum(hi_saldo),
                                'SALDO ME' = sum(hi_saldo_me)/*,
                                @w_categoria = cu_categoria */
			from cb_jerarquia, cb_jerararea,
			     cob_conta_his..cb_hist_saldo, cb_cuenta
	        	where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
		      		hi_empresa = @i_empresa and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_oficina = je_oficina and
				hi_area    = ja_area and
				hi_cuenta like @i_cuenta and
				hi_cuenta = cu_cuenta 
			group by hi_cuenta, cu_nombre

			/* if @@rowcount = 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065 
				return 1
			end */
		end
		else
		begin
		   set rowcount 20

		   select 'CUENTA' = hi_cuenta,
                          'NOMBRE CUENTA' = cu_nombre,
                       'SALDO MN' = sum(hi_saldo),
                       'SALDO ME' = sum(hi_saldo_me)/*,
                       @w_categoria = cu_categoria*/
		   from cb_jerarquia, cb_jerararea,cb_cuenta,
			     cob_conta_his..cb_hist_saldo
		   where   cu_empresa = @i_empresa and
			       (cu_nivel_cuenta = @i_nivel_igual or 
				  @i_nivel_igual = 0) and
			       (cu_nivel_cuenta <= @i_nivel_menor or
			          @i_nivel_menor = 0) and
				je_empresa = @i_empresa and
				je_oficina_padre = @i_oficina and
				ja_empresa = je_empresa and
				ja_area_padre = @i_area and
				hi_empresa = je_empresa and
				hi_periodo = @w_periodo and
				hi_corte = @w_corte and
				hi_oficina = je_oficina and
				hi_area = ja_area and
				hi_cuenta like @i_cuenta and
				hi_cuenta > @i_cuenta1 and
				hi_cuenta = cu_cuenta
			group by hi_cuenta, cu_nombre	

			/*if @@rowcount = 0
			begin
				/* 'No existen mas Saldos para la Cuenta Especificada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601065
				return 1
			end*/ 
	
		end
	end
return 0
end

go

