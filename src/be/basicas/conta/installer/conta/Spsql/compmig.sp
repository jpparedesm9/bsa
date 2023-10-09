/************************************************************************/
/*	Archivo:                compmig.sp			                        */
/*	Stored procedure:       sp_compmig				                    */
/*	Base de datos:          cob_conta  				                    */
/*	Producto:               contabilidad                		        */
/*	Disenado por:                                               	    */
/*	Fecha de escritura:     30-julio-1993 				                */
/************************************************************************/
/*                       IMPORTANTE	                                    */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	copia desde las tablas temporales de comprobantes y asientos        */
/*	a las tablas definitivas, Mayorizacion de los asientos		        */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	30/Jul/1993	G Jaramillo     Emision Inicial			                */
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	            */
/*      10/Mar/1995     E Suasti        Pase Parametro de Autorizado    */
/*                                      en la Consulta por Query.       */
/*      16/Mar/1995     M.Suarez        implementacion de opcion Search */
/*                                      se implementa opcion autorizar  */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_compmig')
	drop proc sp_compmig
go
create proc sp_compmig   (
		@s_ssn		      int = null,
		@s_date		      datetime = null,
		@s_user		      login = null,
		@s_term		      descripcion = null,
		@s_corr		      char(1) = null,
		@s_ssn_corr	      int = null,
        @s_ofi		      smallint = null,
		@t_rty		      char(1) = null,
        @t_trn		      smallint = null,
		@t_debug	      char(1) = 'N',
		@t_file		      varchar(14) = null,
		@t_from		      varchar(30) = null,
		@i_operacion	  char(1) = null,
		@i_modo		      smallint = null,
		@i_empresa 	      tinyint = null, 
		@i_fecha_tran	  datetime = null,
		@i_comprobante 	  int = null,
        @i_oficina_orig   smallint= null,
		@i_mayorizar	  char(1) = null,
		@i_asiento	      smallint = null,
		@i_detalles	      smallint = null,
		@i_tot_debito	  money = null,
		@i_tot_credito    money = null,
		@i_tot_debito_me  money = null,
		@i_tot_credito_me money = null,
		@i_formato_fecha  tinyint = 1,
        @i_autorizado     char(1) = null,
        @i_autorizante    descripcion = null,
        @i_mayorizado     char(1) = 'N',
        @i_traslado       char(1) = 'N',
		@i_msg		      tinyint = 0
                --@i_consecutivo  int,
                --@i_producto     int
	)
as 
declare
	@w_today 	     char(12),  	/* fecha del corte actual */
	@w_return	     int,		/* valor que retorna */
	@w_sp_name	     varchar(32),	/* nombre del stored procedure*/
  	@w_siguiente	     int,
	@w_sig               int,
	@w_comprobante 	     int,
	@w_empresa	     tinyint,
	@w_oficina_dest      smallint,
	@w_oficina_orig      smallint,
	@w_area_orig	     smallint,
	@w_ct_oficina_orig   smallint,
	@w_ct_area_orig	     smallint,
    @w_detalles 	     int,
	@w_reversado         char(1),
	@wa_reversado	     char(1),
	@w_autorizado        char(1),
	@w_tipo_doc	         char(1),
	@wa_autorizado	     char(1),
	@w_tipo_tran	     char(1),
    @w_tot_debito 	     money,
    @w_tot_credito 	     money,
	@w_tot_debito_me     money,
	@w_tot_credito_me    money,
    @w_td_detalles 	     int,
    @w_td_debito 	     money,
    @w_td_credito 	     money,
    @flag1		     int,
	@w_fecha_tran        datetime,
	@w_asiento	     int,
    @w_cuenta            cuenta,
	@w_debito	     money,
	@w_credito	     money,
	@w_debito_me	     money,
	@w_credito_me	     money,
	@w_moneda	     tinyint,
	@w_area_dest	     smallint,
	@wa_area_orig	     smallint,
	@w_operacion         int ,
	@w_descripcion 	     char(255),
	@w_comp_tipo  	     tinyint,
	@wt_mayorizado 	     char(1),
	@w_concepto	     descripcion, 
	@w_num_reg	     int,
	@w_mayorizado	     char(1),
	@w_mayoriza	     char(1),
	@wa_oficina_orig     smallint,
	@wa_depto_orig	     tinyint,
	@wa_fecha_tran 	     datetime,
	@wa_descripcion	     char(255),
	@wa_comp_tipo	     tinyint,
	@wa_detalles	     tinyint,
	@wa_tot_debito	     money,
	@wa_tot_credito	     money,
	@wa_tot_debito_me    money,
	@wa_tot_credito_me   money,
	@wa_oficina_dest     smallint,
	@w_cotizacion	     money,
	@wa_automatico	     smallint,
	@w_automatico	     smallint,
	@w_ct_automatico     smallint

select @w_today = convert(char(12),co_fecha_ini,@i_formato_fecha)
from   cb_corte
where  co_empresa = @i_empresa
  and  co_estado  = 'A' 

select @w_sp_name = 'sp_compmig'


/************************************************/
/*  Tipo de Transaccion = 611X 			*/

if (@t_trn <> 6342 and @i_operacion = 'I') or
   (@t_trn <> 6112 and @i_operacion = 'U') or
   (@t_trn <> 6116 and @i_operacion = 'Q') or
   (@t_trn <> 6114 and @i_operacion = 'S') or
   (@t_trn <> 6117 and @i_operacion = 'A') 
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
		i_fecha_tran	= @i_fecha_tran,
		i_comprobante	= @i_comprobante 
	exec cobis..sp_end_debug
end


select 	@w_operacion = 1,
	@wt_mayorizado = 'N'

if @i_operacion = 'I' 
begin
	/********* LEE CABECERA DEL COMPROBANTE  ****/
	select 	@w_detalles 	= @i_detalles,
 		@w_tot_debito 	= ct_tot_debito,
		@w_tot_credito	= ct_tot_credito,
		@w_tot_debito_me = ct_tot_debito_me,
		@w_tot_credito_me = ct_tot_credito_me,
		@w_fecha_tran 	= ct_fecha_tran ,
		@w_descripcion	= ct_descripcion,
		@w_comp_tipo	= ct_comp_tipo,
		@w_mayoriza	= ct_mayoriza ,
		@w_automatico	= ct_automatico,
		@w_oficina_orig = ct_oficina_orig,
		@w_area_orig	= ct_area_orig,
		@w_reversado	= ct_reversado,
		@w_autorizado	= ct_autorizado
	from cob_conta..cb_tcomprobante
	where 	ct_fecha_tran 	= @i_fecha_tran and
		ct_comprobante 	= @i_comprobante and
		ct_empresa 	= @i_empresa and
                ct_oficina_orig = @i_oficina_orig

	if @@rowcount <> 1 
	begin
           print 'Codigo de Comprobante NO existe o esta duplicado en tabla temporal'
	/*'Codigo de Comprobante NO existe o esta duplicado en tabla temporal'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601062
		return 1
	end
  
	/******** LEE DATOS DE LOS DETALLES *****/
	/* 1) TOTAL DE DEBITOS Y CREDITOS       */
	/* 2) NUMERO DE DETALLES                */

	select 	@w_td_debito 	= sum(ta_debito),
       		@w_td_credito 	= sum(ta_credito),
		    @w_td_detalles 	= count(*)
	from cb_tasiento
	where 	ta_fecha_tran = @i_fecha_tran and
		ta_comprobante = @i_comprobante and
		ta_empresa = @i_empresa and
                ta_oficina_orig = @i_oficina_orig

	/******** COMPARA CON DATOS DE CABECERA ********/

	if @i_detalles <> @w_td_detalles 
	begin
	/* 'Numero de detalles diferente al total registrado en tabla temporal' */
                print '@i_detalles %1! @w_td_detalles'+@i_detalles+@w_td_detalles
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601057
		return 1
	end

	if rtrim(convert(varchar(30),round(@i_tot_debito,2))) <> rtrim(convert(varchar(30),round(@i_tot_credito,2)))
	begin
	/* 'Total de Debitos diferente al total registrado en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601056
		return 1
	end

	if rtrim(convert(varchar(30),round(@i_tot_debito,2))) <> rtrim(convert(varchar(30),round(@w_td_debito,2)))
	begin
	/* 'Total de Debitos diferente al total registrado en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601058
		return 1
	end

	if rtrim(convert(varchar(30),round(@i_tot_credito,2))) <> rtrim(convert(varchar(30),round(@w_td_credito,2)))
	begin
	/* 'Total de Creditos diferente al total registrado en tabla temporal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601059
		return 1
	end

begin tran 
	/******** GRABA LA CABECERA DEL COMPROBANTE *******/
	select  @wa_descripcion = co_descripcion,
		@wa_comp_tipo	= co_comp_tipo,
		@wa_detalles 	= co_detalles,
		@wa_tot_debito	= co_tot_debito,
		@wa_tot_credito	= co_tot_credito,
		@wa_tot_debito_me = co_tot_debito_me,
		@wa_tot_credito_me = co_tot_credito_me ,
		@wa_automatico	= co_automatico,
		@wa_oficina_orig = co_oficina_orig,
		@wa_area_orig = co_area_orig,
		@wa_reversado = co_reversado,
		@wa_autorizado = co_autorizado
	from cob_conta..cb_comprobante
	where 	co_fecha_tran = @i_fecha_tran and
		co_comprobante = @i_comprobante and
		co_empresa = @i_empresa and
                co_oficina_orig = @i_oficina_orig


	if @@rowcount > 0
	begin   /******* update   comprobante   *******/

		update cob_conta..cb_comprobante
  		set co_descripcion 	= ct_descripcion,
		    co_fecha_dig 	= ct_fecha_dig, 
		    co_fecha_mod 	= ct_fecha_mod, 
		    co_digitador 	= ct_digitador,
		    co_mayorizado 	= @wt_mayorizado,
		    co_comp_tipo 	= ct_comp_tipo,
		    co_detalles		= ct_detalles,
		    co_tot_debito	= @i_tot_debito,
		    co_tot_credito	= @i_tot_credito,
		    co_tot_debito_me    = @i_tot_debito_me,
		    co_tot_credito_me	= @i_tot_credito_me ,
		    co_automatico 	= ct_automatico,
		    co_oficina_orig	= ct_oficina_orig,
		    co_area_orig	= ct_area_orig,
		    co_reversado	= ct_reversado,
		    co_autorizado	= ct_autorizado
		from cob_conta..cb_comprobante,cob_conta..cb_tcomprobante
		where 	co_fecha_tran	= @i_fecha_tran and	
			co_comprobante 	= @i_comprobante and
			co_empresa	= @i_empresa and
                        co_oficina_orig = @i_oficina_orig and
			ct_fecha_tran	= @i_fecha_tran and
			ct_comprobante 	= @i_comprobante and
			ct_empresa	= @i_empresa and
                        ct_oficina_orig = @i_oficina_orig

		if @@error <> 0
		begin
		/* 'error en actualizacion de comprobante' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605037

			delete cob_conta..cb_tasiento
			where  	ta_fecha_tran = @i_fecha_tran and
				ta_comprobante = @i_comprobante and
				ta_empresa = @i_empresa and
                                ta_oficina_orig = @i_oficina_orig

			delete cob_conta..cb_tcomprobante
			where 	ct_fecha_tran = @i_fecha_tran and
				ct_comprobante = @i_comprobante and
				ct_empresa = @i_empresa and
                                ct_oficina_orig = @i_oficina_orig


			return 1
		end

		delete cob_conta..cb_asiento
		where 	as_fecha_tran = @i_fecha_tran and
			as_comprobante = @i_comprobante and
			as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig
	end
	else
	begin
                -- Obtiene el numero secuencial definitivo
                exec @w_return = cob_conta..sp_cseqcomp
                     @i_empresa = @i_empresa,
                     @i_fecha   = @i_fecha_tran,
                     @i_tabla   = 'cb_comprobante',
                     @i_modulo  = 6,
                     @i_modo    = 3,
                     @i_oficina = @w_oficina_orig,
                     @o_siguiente = @w_siguiente out

                if @w_return <> 0
                begin
                  return @w_return
                end                  

		insert into cob_conta..cb_comprobante
	              (	co_comprobante,co_empresa,co_fecha_tran,
			co_oficina_orig,co_area_orig,co_fecha_dig,
			co_fecha_mod,co_digitador,co_descripcion,
			co_mayorizado,co_comp_tipo,co_detalles,
			co_tot_debito,co_tot_credito,co_tot_debito_me,
			co_tot_credito_me,co_automatico,co_reversado,
			--co_autorizado,co_autorizante,co_traslado, co_consecutivo)
			co_autorizado,co_autorizante,co_traslado)
		select 	@w_siguiente,ct_empresa,ct_fecha_tran,
			ct_oficina_orig,ct_area_orig,ct_fecha_dig,
			ct_fecha_mod,ct_digitador,ct_descripcion,
			@wt_mayorizado,ct_comp_tipo,@i_detalles,
			@i_tot_debito,@i_tot_credito,@i_tot_debito_me,
			@i_tot_credito_me,ct_automatico,ct_reversado,
			--ct_autorizado,ct_autorizante,@i_traslado , @w_sig
			ct_autorizado,ct_autorizante,@i_traslado
		from cob_conta..cb_tcomprobante
		where 	ct_fecha_tran	= @i_fecha_tran and
			ct_comprobante 	= @i_comprobante and
			ct_empresa 	= @i_empresa and
                        ct_oficina_orig = @i_oficina_orig
		
		if @@error <> 0
		begin
			/* 'Error en insercion de comprobante' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603025

			delete cob_conta..cb_tasiento
			where  	ta_fecha_tran = @i_fecha_tran and
				ta_comprobante = @i_comprobante and
				ta_empresa = @i_empresa and
                                ta_oficina_orig = @i_oficina_orig

			delete cob_conta..cb_tcomprobante
			where 	ct_fecha_tran = @i_fecha_tran and
				ct_comprobante = @i_comprobante and
				ct_empresa = @i_empresa and
                                ct_oficina_orig = @i_oficina_orig

			return 1
		end

		select @w_siguiente

	end
	/******** MAYORIZA Y GRABA CADA UNO DE LOS ASIENTOS *****/ 
	select @flag1 = 1
        select @w_asiento = 1
	while @flag1 > 0
	begin
		select 	@w_empresa	= ta_empresa,
			@w_oficina_dest = ta_oficina_dest,
			@w_area_dest	= ta_area_dest,
			@w_cuenta 	= ta_cuenta,
			@w_credito 	= ta_credito,
			@w_debito 	= ta_debito,
			@w_credito_me	= ta_credito_me,
			@w_debito_me	= ta_debito_me,
			@w_cotizacion	= ta_cotizacion,
			@w_mayorizado	= ta_mayorizado,
			@w_tipo_doc	= ta_tipo_doc,
			@w_tipo_tran	= ta_tipo_tran,
			@w_concepto	= ta_concepto,
			@w_moneda	= ta_moneda
		from cob_conta..cb_tasiento
		where	ta_fecha_tran	= @i_fecha_tran and
			ta_comprobante  = @i_comprobante and
			ta_empresa	= @i_empresa and
                        ta_oficina_orig = @i_oficina_orig and
			ta_asiento 	= @w_asiento 

		if @@rowcount > 0
		begin
			if @w_mayoriza = 'S'
			begin  /*********** Mayoriza el asiento *******/
   				exec @w_return = cob_conta..sp_mayoriza 
				    null,null,null,null,null,null,null,null,
				    6301,'N',null,null,
				    @i_empresa,
                 		    @w_fecha_tran,
				    @w_cuenta,
				    @w_oficina_dest,
				    @w_area_dest,
				    @w_credito,
				    @w_debito,
				    @w_credito_me,
				    @w_debito_me,
				    @w_operacion 
				if @w_return <> 0
				begin
					/*'Error al mayorizar' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 603021

					delete cob_conta..cb_tasiento
					where  ta_fecha_tran = @i_fecha_tran and
					       ta_empresa = @i_empresa and
					       ta_comprobante = @i_comprobante and
                                	       ta_oficina_orig = @i_oficina_orig

					delete cob_conta..cb_tcomprobante
					where ct_fecha_tran = @i_fecha_tran and 
					      ct_empresa = @i_empresa and
					      ct_comprobante = @i_comprobante and
                                	      ct_oficina_orig = @i_oficina_orig

					return 1
				end
				select @wt_mayorizado = 'S'
			end

     			insert cb_asiento (as_fecha_tran,as_comprobante,
				as_empresa,as_asiento,as_cuenta,as_oficina_dest,
				as_area_dest,as_credito,as_debito,as_concepto,
				as_credito_me,as_debito_me,as_cotizacion,
				as_mayorizado,as_tipo_doc,as_tipo_tran,
				as_moneda,as_opcion,as_fecha_est,as_detalle,
				as_consolidado,as_oficina_orig)
			select  ta_fecha_tran,@w_siguiente,
				ta_empresa,ta_asiento,ta_cuenta,ta_oficina_dest,
				ta_area_dest,ta_credito,ta_debito,ta_concepto,
				ta_credito_me,ta_debito_me,ta_cotizacion,
				ta_mayorizado,ta_tipo_doc,ta_tipo_tran,
				ta_moneda,ta_opcion,ta_fecha_est,ta_detalle,
				ta_consolidado,ta_oficina_orig
			from cb_tasiento
			where	ta_fecha_tran 	= @i_fecha_tran and
				ta_comprobante 	= @i_comprobante and
				ta_empresa	= @i_empresa and
				ta_oficina_orig = @i_oficina_orig and
				ta_asiento 	= @w_asiento 


			if @@error <> 0
			begin
				/*'Error al mayorizar' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603020

				delete cob_conta..cb_tasiento
				 where  ta_fecha_tran = @i_fecha_tran and
				        ta_empresa = @i_empresa and
					ta_comprobante = @i_comprobante and
					ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where ct_fecha_tran = @i_fecha_tran and 
				      ct_empresa = @i_empresa and
				      ct_comprobante = @i_comprobante and
                                      ct_oficina_orig = @i_oficina_orig

				return 1
			end


			select  @w_asiento = @w_asiento + 1
        		
		end
		else select @flag1 = 0
	end /* while */

	/********** Actualizacion de status de mayorizados **********/ 
	if @w_mayoriza = 'S' and @wt_mayorizado = 'S'
	begin
		update cob_conta..cb_comprobante
		set co_mayorizado = @wt_mayorizado,
			co_autorizado = 'S'
		where 	co_fecha_tran = @i_fecha_tran and
			co_comprobante = @w_siguiente and
			co_empresa = @i_empresa and
                        co_oficina_orig = @i_oficina_orig

		if @@error <> 0
		begin
			/* 'Error en actualizacion de codigo mayorizado o no)'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603022
			
			delete cob_conta..cb_tasiento
			where  	ta_fecha_tran = @i_fecha_tran and
				ta_comprobante = @i_comprobante and
				ta_empresa = @i_empresa and
                                ta_oficina_orig = @i_oficina_orig

			delete cob_conta..cb_tcomprobante
			where 	ct_fecha_tran = @i_fecha_tran and
				ct_comprobante = @i_comprobante and
				ct_empresa = @i_empresa and
                                ct_oficina_orig = @i_oficina_orig

			return 1
		end

		update cb_asiento
		set as_mayorizado = @wt_mayorizado
			/*as_autorizado = 'S'*/
		where   as_fecha_tran = @i_fecha_tran and
			as_comprobante = @w_siguiente and
			as_empresa = @i_empresa and
                        as_oficina_orig = @i_oficina_orig

		if @@error <> 0
		begin
			/* 'Error en actualizacion de codigo mayorizado o no)'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603022

			delete cob_conta..cb_tasiento
			where   ta_fecha_tran = @i_fecha_tran and
				ta_comprobante = @i_comprobante and
				ta_empresa = @i_empresa and
                                ta_oficina_orig = @i_oficina_orig

			delete cob_conta..cb_tcomprobante
			where 	ct_fecha_tran = @i_fecha_tran and
				ct_comprobante = @i_comprobante and
				ct_empresa = @i_empresa and
                                ct_oficina_orig = @i_oficina_orig

			return 1
		end
       	end

    /****************************************/
    /* Grabacion de datos para conciliacion */
    /****************************************/
/*
     	insert into cob_conta..cb_val_item (vi_empresa,vi_opcion,vi_debcred,
			    vi_item,vi_fecha_tran,vi_comprobante,vi_asiento,
			    vi_valor)
	select   ti_empresa,ti_opcion,ti_debcred,ti_item,ti_fecha_tran,
		 ti_comprobante,ti_asiento,ti_valor 
	from cb_tval_item
	where	ti_fecha_tran 	= @i_fecha_tran and
		ti_comprobante 	= @i_comprobante and
		ti_empresa	= @i_empresa 

	if @@error <> 0
	begin
		/* 'Error en insercion de datos de conciliacion' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607121

		delete cob_conta..cb_tasiento
		where  	ta_fecha_tran = @i_fecha_tran and
			ta_comprobante = @i_comprobante and
			ta_empresa = @i_empresa 

		delete cob_conta..cb_tcomprobante
		where 	ct_fecha_tran = @i_fecha_tran and
			ct_comprobante = @i_comprobante and
			ct_empresa = @i_empresa 
		return 1
	end
*/

	delete cob_conta..cb_tasiento
	where   ta_fecha_tran = @i_fecha_tran and
		ta_comprobante = @i_comprobante and
		ta_empresa = @i_empresa and
                ta_oficina_orig = @i_oficina_orig

	delete cob_conta..cb_tcomprobante
	where 	ct_fecha_tran = @i_fecha_tran and
		ct_comprobante = @i_comprobante and
		ct_empresa = @i_empresa and
                ct_oficina_orig = @i_oficina_orig

commit tran
--commit tran

return 0  
end

  
/****************** UPDATE (APROBAR) *****************/
   
if @i_operacion = 'U'
begin
	select co_autorizado
	from cob_conta..cb_comprobante
	where 	co_fecha_tran = @i_fecha_tran and
		co_comprobante = @i_comprobante and
		co_empresa = @i_empresa and
                co_oficina_orig = @i_oficina_orig

	if @@rowcount > 0
	begin   
            begin tran
		update cob_conta..cb_comprobante
  		set 
		    co_fecha_mod 	= getdate(),
		    co_autorizado	= @i_autorizado,
		    co_autorizante      = @i_autorizante
		where 	co_fecha_tran	= @i_fecha_tran and	
			co_comprobante 	= @i_comprobante and
			co_empresa	= @i_empresa and
                        co_oficina_orig = @i_oficina_orig

		/*update cob_conta..cb_asiento
		set 
		    as_autorizado	= @i_autorizado
		where 	as_fecha_tran	= @i_fecha_tran and	
			as_comprobante 	= @i_comprobante and
			as_empresa	= @i_empresa */

		if @@error <> 0
		begin
		/* 'error en actualizacion de comprobante' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605037
			return 1
		end

               commit tran
               return 0
          end
          else begin
		/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			 @t_file = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			return 1
	end
end
   
/********************** ALL   SEARCH ********************/

/* Operacion search retorna comprobantes no mayorizados y 
   no autorizados grabados en el dia */
if @i_operacion = 'S' 
begin
	set rowcount 20
	if @i_modo = 0
	begin
	select 'No.Comp.'  = co_comprobante,
               'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
               'Aut.'      = co_autorizado,
               'May.'      = co_mayorizado,
               'Digitado'  = convert(char(10),co_fecha_dig,@i_formato_fecha),
               'Digitador' = co_digitador,
               'Revisado'= co_autorizante
        	from cob_conta..cb_comprobante, cob_conta..cb_control
		where co_empresa = @i_empresa 
             	--and convert(char(12),co_fecha_tran,@i_formato_fecha) = @w_today
                  and co_mayorizado = 'N'
                  and co_autorizado = 'N'
                  and co_empresa = cn_empresa
                  and cn_login = @s_user
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
   		order by co_comprobante, co_fecha_tran, co_digitador
		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			 @t_file = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
	select 'No.Comp.' = co_comprobante,
               'Fecha'     = convert(char(10),co_fecha_tran,@i_formato_fecha),
               'Aut.'      = co_autorizado,
               'May.'      = co_mayorizado,
               'Digitado'  = convert(char(12),co_fecha_dig,@i_formato_fecha),
               'Digitador' = co_digitador,
               'Revisado'= co_autorizante
        	from cob_conta..cb_comprobante, cob_conta..cb_control
		where co_empresa = @i_empresa 
                  --and convert(char(12),co_fecha_tran,@i_formato_fecha) = @w_today
                  and co_mayorizado = 'N' 
                  and co_autorizado = 'N'
                  and co_comprobante > @i_comprobante
                  and cn_login = @s_user
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
   		order by co_comprobante, co_fecha_tran, co_digitador

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end

	if  @i_modo = 2
	    begin
	    select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha),
               co_oficina_orig, co_area_orig
            from cob_conta..cb_comprobante
	         where co_empresa = @i_empresa 
                   and co_comprobante = @i_comprobante

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end

	if  @i_modo = 3
	    begin
	    set rowcount 1
	    select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha)
            from cob_conta..cb_comprobante, cob_conta..cb_control
	         where co_empresa = @i_empresa 
                  and convert(char(12),co_fecha_tran,@i_formato_fecha) = @w_today
                  and co_mayorizado = 'N' 
                  and co_comprobante > @i_comprobante
                  and cn_login = @s_user
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
                  order by co_comprobante 

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end

	if  @i_modo = 4
	    begin
	    set rowcount 1
	    select co_comprobante,
               convert(char(10),co_fecha_tran,@i_formato_fecha),
               co_mayorizado,
               convert(char(12),co_fecha_dig,@i_formato_fecha),
               convert(char(12),getdate(),@i_formato_fecha)
            from cob_conta..cb_comprobante, cob_conta..cb_control
	         where co_empresa = @i_empresa 
                  and convert(char(12),co_fecha_tran,@i_formato_fecha) = @w_today
                  and co_mayorizado = 'N' 
                  and co_comprobante < @i_comprobante
                  and cn_login = @s_user
                  and co_oficina_orig = cn_oficina
                  and co_area_orig    = cn_area
                  order by co_comprobante desc

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
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
		select convert(char(12),co_fecha_tran,@i_formato_fecha),
			co_comprobante
        	from cob_conta..cb_comprobante
		where co_empresa = @i_empresa
   		order by co_fecha_tran,co_comprobante

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			 @t_file = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
		select convert(char(12),co_fecha_tran,@i_formato_fecha),
			co_comprobante
		from cob_conta..cb_comprobante
		where 	co_empresa = @i_empresa and
			co_comprobante > @i_comprobante 
		order by co_fecha_tran,co_comprobante

		if @@rowcount = 0
		begin
			/* 'No existen Comprobantes ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601060
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end

/********* Query *******/
if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0 
	begin
		select 	co_oficina_orig,co_area_orig,
			co_comprobante,co_descripcion,
			convert(char(12),co_fecha_tran,@i_formato_fecha),
			co_mayorizado,
			co_comp_tipo,co_tot_debito,
			co_tot_credito, co_tot_debito_me, co_tot_credito_me,
		 	of_descripcion,ar_descripcion, co_autorizado
			from 	cob_conta..cb_comprobante,cob_conta..cb_oficina,
			cb_area
		where 	co_fecha_tran = @i_fecha_tran and
			co_empresa = @i_empresa and
			co_comprobante = @i_comprobante and
			of_empresa = @i_empresa and
			of_oficina = co_oficina_orig and
			ar_empresa = @i_empresa and
			ar_area = co_area_orig 
                        

		if @@rowcount = 0
		begin
			/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601061
			return 1
		end

		select  as_oficina_dest,as_area_dest,as_cuenta,
			as_tipo_doc,as_debito,as_credito,as_debito_me,
			as_credito_me,as_cotizacion,as_tipo_tran,
			as_concepto,as_moneda
		from cob_conta..cb_asiento
		where 	as_fecha_tran = @i_fecha_tran and
			as_comprobante = @i_comprobante and
			as_empresa = @i_empresa 
		order by as_asiento

	end
	else begin
		select  as_oficina_dest,as_area_dest,as_cuenta,
			as_tipo_doc,as_debito,as_credito,as_debito_me,
			as_credito_me,as_cotizacion,as_tipo_tran,
			as_concepto,as_moneda
		from cob_conta..cb_asiento
		where 	as_fecha_tran = @i_fecha_tran and
			as_comprobante = @i_comprobante and
			as_empresa = @i_empresa and
			as_asiento > @i_asiento
		order by as_asiento
		
		if @@rowcount = 0
		begin
			/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601061
			return 1
		end
	end
	return 0
end

go
