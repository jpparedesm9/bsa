/************************************************************************/
/*	Archivo: 		valmigcb.sp  			        */
/*	Stored procedure: 	sp_valida_conta_mig			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marcelo Poveda     	        	*/
/*	Fecha de escritura:    	Marzo 2002				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*									*/
/*				PROPOSITO				*/
/*	Validar la integridad de comprobantes y asientos como:	 	*/
/*	- Valida si las cuentas de los asientos pertenecen a las ctas	*/
/*	  de plan general						*/
/*	- Validación del valor de la base de retención			*/
/*	- Validación del código del cliente asociado a la cuenta 	*/
/*	  e igualmente el tipo de documento y número corresponsan	*/
/*									*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/************************************************************************/

use cob_conta
go

if exists (select 1 from sysobjects where name = "sp_valida_conta_mig")
   drop proc sp_valida_conta_mig
go

create proc sp_valida_conta_mig
as
declare
@w_sp_name		varchar(30),
@w_sam_comprobante	int,
@w_sam_area_dest	smallint,
@w_sam_cuenta		varchar(15),
@w_sam_oficina_dest	smallint,
@w_sam_credito		money,
@w_sam_debito		money,
@w_sam_credito_me	money,
@w_sam_debito_me	money,
@w_sam_tipo_tercero	varchar(2),
@w_sam_id_tercero	varchar(15),
@w_sam_ente		int,
@w_sam_proceso		smallint,
@w_sam_empresa		tinyint,
@w_sam_asiento		smallint,
@w_sam_con_impuesto	varchar(10),
@w_sam_base		money,
@w_existe		tinyint,
@w_comprobante		int,
@w_tot_debito		money,
@w_tot_credito		money,
@w_tot_debito_me	money,
@w_tot_credito_me	money,
@w_base      		money,
@w_base_ini    		money,
@w_base_fin    		money,
@w_porcentaje		float,
@w_afectacion		char(1),
@w_retencion_aux	money,
@w_delta		float,
@w_dato			varchar(250),
@w_tipo_tercero		varchar(2),
@w_id_tercero		varchar(15),
@w_desc_impto           varchar(15),
@w_comp_origen		int,
@w_fecha_tran		datetime,
@w_scm_oficina_orig	smallint,
@w_scm_area_orig	smallint,
@w_desc_origen_error	varchar(160)


/*Inicializacion de variables*/
select @w_sp_name = "sp_valida_conta_mig"
select @w_existe  = 1  		--0 Si existe, 1 No existe
select @w_tot_debito = 0,
       @w_tot_credito = 0,
       @w_tot_debito_me = 0,
       @w_tot_credito_me = 0
select @w_delta = 0

declare cursor_asiento cursor for
select 
sam_comprobante,	sam_area_dest,			sam_cuenta,
sam_oficina_dest,	sam_credito,			sam_debito,
sam_tipo_tercero,	sam_id_tercero,	sam_ente,
sam_proceso_cuenta,	sam_empresa,			sam_asiento,
sam_credito_me,		sam_debito_me,			sam_con_impuesto,
sam_base,		scm_comp_origen,		scm_fecha_tran,
scm_oficina_orig,	scm_area_orig
from cob_conta..cb_sasiento_mig,cob_conta..cb_scomprobante_mig
where   scm_comprobante = sam_comprobante

open cursor_asiento

fetch cursor_asiento into
@w_sam_comprobante,	@w_sam_area_dest,		@w_sam_cuenta,
@w_sam_oficina_dest,	@w_sam_credito,			@w_sam_debito,
@w_sam_tipo_tercero,	@w_sam_id_tercero,		@w_sam_ente,
@w_sam_proceso,		@w_sam_empresa,			@w_sam_asiento,
@w_sam_credito_me,	@w_sam_debito_me,		@w_sam_con_impuesto,
@w_sam_base,		@w_comp_origen,			@w_fecha_tran,
@w_scm_oficina_orig,	@w_scm_area_orig
select @w_comprobante = @w_sam_comprobante

while @@fetch_status =0 
begin
	/*Inicializacion de variables*/
	select @w_base =0
	select @w_porcentaje  = 0
	select @w_retencion_aux = 0
	select @w_desc_origen_error = 'Comp ' + convert(varchar,@w_comp_origen) 
	select @w_desc_origen_error = @w_desc_origen_error + ' Asiento ' + convert(varchar,@w_sam_asiento)
	select @w_desc_origen_error = @w_desc_origen_error + ' Fecha ' + convert(varchar,@w_fecha_tran,101)
	select @w_desc_origen_error = @w_desc_origen_error + ' Ofc.Orig ' + convert(varchar,@w_scm_oficina_orig)
	select @w_desc_origen_error = @w_desc_origen_error + ' Area.Orig ' + convert(varchar,@w_scm_area_orig)
	select @w_desc_origen_error = @w_desc_origen_error + ' Ofc.Dest ' + convert(varchar,@w_sam_oficina_dest)
	select @w_desc_origen_error = @w_desc_origen_error + ' Area.Dest ' + convert(varchar,@w_sam_area_dest)
	select @w_desc_origen_error = @w_desc_origen_error + ' Cuenta ' + rtrim(@w_sam_cuenta)

	
	/* *  * * * * * * * * * PLAN GENERAL  * * * * * * * * * * * * * * * * 	*/
	/*    Valida si las cuentas de los asientos pertenecen al plan general	*/
   	/*    verificando que las cuentas esten asociadas por area y oficina	*/
   	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *  */ 
	select @w_existe = 1

	select @w_existe = 0
	from cob_conta..cb_plan_general
	where pg_empresa = @w_sam_empresa
	and   pg_oficina = @w_sam_oficina_dest
	and   pg_area    = @w_sam_area_dest
	and   pg_cuenta  = @w_sam_cuenta

	if @w_existe = 1 
	begin
		select @w_dato = "Empresa:" + convert(varchar(5),@w_sam_empresa) + " Ofi Dest.: " + convert(varchar(5),@w_sam_oficina_dest) + " Area Dest.: " +
		convert(varchar(5),@w_sam_area_dest) + " Cuenta: " + @w_sam_cuenta

		update cob_conta..cb_sasiento_mig
		set    sam_error = 1
		where  sam_comprobante = @w_sam_comprobante
		and    sam_asiento     = @w_sam_asiento

		exec  sp_migra_log_errores
		@i_fuente       = @w_desc_origen_error,
		@i_fila         = @w_sam_asiento,
		@i_campo        = ' 10',
		@i_dato         = @w_dato,
		@i_referencia   = 600300,
		@i_operacion    = @w_sam_comprobante,
		@i_producto     = 6

		select @w_dato = ''
	end
	
	/* * * * * * * * *        BASE RETENCION     * * * * * * * * * * * * * * * * * * */	
	/*   Validar Base de Retencion para las cuentas de Tercero Tributario (6095)	*/
	/*   Si el proceso es  4 y naturaleza de la cuenta es I  (Iva Retenido)		*/
	/*   Si el proceso es  20 y naturaleza de la cuenta es V  (Iva Cobrado )		*/
	/*   Si el proceso es  5 y naturaleza de la cuenta es C  (Ica)			*/
	/*   Si el proceso es  6 y naturaleza de la cuenta es P  (Iva Pagado)		*/
	/*   Si el proceso es  7 y naturaleza de la cuenta es T  (Timbre)		*/
	/*   Si el proceso es  8 y naturaleza de la cuenta es R  (Retencion)		*/
	/*   Si el proceso es  21 y naturaleza de la cuenta es E  (Deptales)		*/
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * **/		 
	
	select @w_existe = 1
        
        --borrar print 'proceso %1!', @w_sam_proceso
       
	if @w_sam_proceso in (4,5,6,7,8,20,21) 
	begin

      	if @w_sam_con_impuesto = '' or @w_sam_base = 0 
	begin
		if @w_sam_con_impuesto <> '9999'
		begin
			select @w_dato = "IMPTO" 

/*
			update cob_conta..cb_sasiento_mig
			set    sam_error = 1
			where  sam_comprobante = @w_sam_comprobante
			and    sam_asiento     = @w_sam_asiento
					
			exec  sp_migra_log_errores
			@i_fuente       = @w_desc_origen_error,
			@i_fila         = @w_sam_asiento,
			@i_campo        = '',
			@i_dato         = @w_dato, 
			@i_referencia   = 600304,
			@i_operacion    = @w_sam_comprobante,
			@i_producto     = 6
*/
		end
       end
	else
	begin
         if @w_sam_con_impuesto <> '9999'
	 begin
		if @w_sam_debito<> 0
			select @w_afectacion = 'D'
		else
			select @w_afectacion = 'C'

      		if @w_sam_proceso = 4 
		begin
			select @w_base = 0,
			@w_porcentaje = iva_porcentaje
			from cob_conta..cb_iva
			where iva_empresa = @w_sam_empresa
		        and   iva_codigo  = @w_sam_con_impuesto
			--and   iva_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DIVA"
			and   pa_producto = "CON" 

			select @w_desc_impto = 'IVA RETENIDO'
		end

      		if @w_sam_proceso = 20
		begin
			select @w_base = isnull (iva_base,0),
			@w_porcentaje = iva_des_porcen
			from cob_conta..cb_iva
			where iva_empresa = @w_sam_empresa
		        and   iva_codigo  = @w_sam_con_impuesto
			--and   iva_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DIVA"
			and   pa_producto = "CON" 

			select @w_desc_impto = 'IVA COBRADO'

		end

      		if @w_sam_proceso = 21
		begin
			select @w_base_ini = isnull (id_base_ini,0),
			       @w_base_fin = isnull (id_base_fin,0),
			       @w_porcentaje = id_porcentaje
			from cob_conta..cb_imptos_deptales
			where id_empresa = @w_sam_empresa
		        and   id_codigo  = @w_sam_con_impuesto
			--and   id_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DEST"
			and   pa_producto = "CON" 
			
			select @w_desc_impto = 'DEPTALES'

		end

      
		if @w_sam_proceso = 5
		begin
	        	select @w_base = ic_base,
			@w_porcentaje = ic_porcentaje
			from cob_conta..cb_ica
			where ic_empresa = @w_sam_empresa
			and   ic_codigo  = @w_sam_con_impuesto
			--and   ic_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DICA"
			and   pa_producto = "CON"

			select @w_desc_impto = 'ICA'
		end

		if @w_sam_proceso = 6 
		begin
			select @w_base = ip_base,
			@w_porcentaje = ip_porcentaje
			from cob_conta..cb_iva_pagado
			where ip_empresa = @w_sam_empresa
			and   ip_codigo  = @w_sam_con_impuesto
			--and   ip_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DIVAP"
			and   pa_producto = "CON"

			select @w_desc_impto = 'IVA PAGADO'
		end
	
		if @w_sam_proceso = 7 
		begin
			select @w_base = cr_base,
			@w_porcentaje = cr_porcentaje
			from cob_conta..cb_conc_retencion
			where cr_empresa = @w_sam_empresa
			and   cr_codigo  = @w_sam_con_impuesto
			and   cr_tipo    = 'T'
			--and   cr_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DREN"
			and   pa_producto = "CON"

			select @w_desc_impto = 'TIMBRE'

		end

		if @w_sam_proceso = 8 
		begin
			select @w_base = cr_base,
			@w_porcentaje  = cr_porcentaje
			from cob_conta..cb_conc_retencion
			where cr_empresa = @w_sam_empresa
			and   cr_codigo  = @w_sam_con_impuesto
			and   cr_tipo    = 'R'
			--and   cr_debcred = @w_afectacion

			select @w_delta = pa_float
			from cobis..cl_parametro
			where pa_nemonico = "DTIM"
			and   pa_producto = "CON"

			select @w_desc_impto = 'RETEFUENTE'

	      end		
	      
              if  @w_sam_proceso = 5
              begin
		   select @w_retencion_aux = (@w_porcentaje * isnull(@w_sam_base,0)) / 1000
	      end    
	      else
	      begin 
	      	   select @w_retencion_aux = (@w_porcentaje * isnull(@w_sam_base,0)) / 100
	       end 		       		
	       
		-- borrar print 'retencion aux  %1!', @w_retencion_aux
		-- borrar print 'base archivo plano %1!', @w_sam_base
		-- borrar print 'base bd %1!', @w_base 
		-- borrar print 'credito %1!', @w_sam_credito
		-- borrar print 'difiva %1!', @w_delta
		if  @w_sam_proceso <> 21
		begin
			if  @w_sam_proceso <> 5
			begin
				if @w_afectacion = "C" 
				begin
					if @w_sam_base >= @w_base and @w_sam_base <> 0
					begin
						if (abs(@w_retencion_aux - @w_sam_credito)) > @w_delta
						begin	    				
							select @w_dato = "PORC." + @w_desc_impto + ' CTA ' + @w_sam_cuenta			

							update cob_conta..cb_sasiento_mig
							set    sam_error = 1
							where  sam_comprobante = @w_sam_comprobante
							and    sam_asiento     = @w_sam_asiento
					
							exec  sp_migra_log_errores
							@i_fuente       = @w_desc_origen_error,
							@i_fila         = @w_sam_asiento,
							@i_campo        = '',
							@i_dato         = @w_dato, 
							@i_referencia   = 600304,
							@i_operacion    = @w_sam_comprobante,
							@i_producto     = 6
						end	
					end 
					else 
					begin
						select @w_dato = "BASE." + @w_desc_impto  + ' CTA ' + @w_sam_cuenta			

						update cob_conta..cb_sasiento_mig
						set    sam_error = 1
						where  sam_comprobante = @w_sam_comprobante
						and    sam_asiento     = @w_sam_asiento
	
						exec  sp_migra_log_errores
						@i_fuente       = @w_desc_origen_error,
						@i_fila         = @w_sam_asiento,
						@i_campo        = ' 26',
						@i_dato         = @w_dato, 
						@i_referencia   = 600137,
						@i_operacion    = @w_sam_comprobante,
						@i_producto     = 6
					end	
				end
    				else 
    				begin
    					if @w_sam_base >= @w_base and @w_sam_base <> 0
					begin
						if (abs(@w_retencion_aux - @w_sam_debito)) > @w_delta
						begin    	
							select @w_dato = "PORC." + @w_desc_impto + ' CTA ' + @w_sam_cuenta
			
							update cob_conta..cb_sasiento_mig
							set    sam_error = 1
							where  sam_comprobante = @w_sam_comprobante
							and    sam_asiento     = @w_sam_asiento
	
							exec  sp_migra_log_errores
							@i_fuente       = @w_desc_origen_error,
							@i_fila         = @w_sam_asiento,
							@i_campo        = '',
							@i_dato         = @w_dato, 
							@i_referencia   = 600304,
							@i_operacion    = @w_sam_comprobante,
							@i_producto     = 6
						end	
					end 		  			 
					else 
					begin
						select @w_dato = "BASE." + @w_desc_impto  + ' CTA ' + @w_sam_cuenta			
						update cob_conta..cb_sasiento_mig
						set    sam_error = 1
						where  sam_comprobante = @w_sam_comprobante
						and    sam_asiento     = @w_sam_asiento

						exec  sp_migra_log_errores
						@i_fuente       = @w_desc_origen_error,
						@i_fila         = @w_sam_asiento,
						@i_campo        = ' 26',
						@i_dato         = @w_dato, 
						@i_referencia   = 600137,
						@i_operacion    = @w_sam_comprobante,
						@i_producto     = 6
					end	
				end
			end
		end
		else /* IMPUESTOS DEPTALES = 21 */
		begin
				if @w_afectacion = "C" 
				begin
					if @w_sam_base >= @w_base_ini and @w_sam_base <= @w_base_fin and @w_sam_base <> 0
					begin
						if (abs(@w_retencion_aux - @w_sam_credito)) > @w_delta
						begin	    				
							select @w_dato = "PORC." + @w_desc_impto + ' CTA ' + @w_sam_cuenta			

							update cob_conta..cb_sasiento_mig
							set    sam_error = 1
							where  sam_comprobante = @w_sam_comprobante
							and    sam_asiento     = @w_sam_asiento
					
							exec  sp_migra_log_errores
							@i_fuente       = @w_desc_origen_error,
							@i_fila         = @w_sam_asiento,
							@i_campo        = '',
							@i_dato         = @w_dato, 
							@i_referencia   = 600304,
							@i_operacion    = @w_sam_comprobante,
							@i_producto     = 6
						end	
					end 
					else 
					begin
						select @w_dato = "BASE." + @w_desc_impto  + ' CTA ' + @w_sam_cuenta			

						update cob_conta..cb_sasiento_mig
						set    sam_error = 1
						where  sam_comprobante = @w_sam_comprobante
						and    sam_asiento     = @w_sam_asiento
	
						exec  sp_migra_log_errores
						@i_fuente       = @w_desc_origen_error,
						@i_fila         = @w_sam_asiento,
						@i_campo        = ' 26',
						@i_dato         = @w_dato, 
						@i_referencia   = 600137,
						@i_operacion    = @w_sam_comprobante,
						@i_producto     = 6
					end	
				end
    				else 
    				begin
    					if @w_sam_base >= @w_base_ini and @w_sam_base <= @w_base_fin and @w_sam_base <> 0
					begin
						if (abs(@w_retencion_aux - @w_sam_debito)) > @w_delta
						begin    	
							select @w_dato = "PORC." + @w_desc_impto + ' CTA ' + @w_sam_cuenta
			
							update cob_conta..cb_sasiento_mig
							set    sam_error = 1
							where  sam_comprobante = @w_sam_comprobante
							and    sam_asiento     = @w_sam_asiento
	
							exec  sp_migra_log_errores
							@i_fuente       = @w_desc_origen_error,
							@i_fila         = @w_sam_asiento,
							@i_campo        = '',
							@i_dato         = @w_dato, 
							@i_referencia   = 600304,
							@i_operacion    = @w_sam_comprobante,
							@i_producto     = 6
						end	
					end 		  			 
					else 
					begin
						select @w_dato = "BASE." + @w_desc_impto  + ' CTA ' + @w_sam_cuenta			
						update cob_conta..cb_sasiento_mig
						set    sam_error = 1
						where  sam_comprobante = @w_sam_comprobante
						and    sam_asiento     = @w_sam_asiento

						exec  sp_migra_log_errores
						@i_fuente       = @w_desc_origen_error,
						@i_fila         = @w_sam_asiento,
						@i_campo        = ' 26',
						@i_dato         = @w_dato, 
						@i_referencia   = 600137,
						@i_operacion    = @w_sam_comprobante,
						@i_producto     = 6
					end	
				end

		end
	end
  	end
	end 

	/** * * * * * * *  Valida existencia de clientes  * * * * * * * * * * *   **/
	/** * * * * *    en Ctas de Tercero Gral y  Ctas de Tercero Tributario    **/
	
   	select @w_existe = 1

	if @w_sam_proceso in (2,3,4,5,6,7,8,20,21)
	begin	
		/* Valida existencia de cliente */
		select  @w_existe = 0,
        	@w_tipo_tercero = en_tipo_ced,
		@w_id_tercero = en_ced_ruc
		from cobis..cl_ente
		--where en_ente = @w_sam_ente  
		where en_tipo_ced = @w_sam_tipo_tercero
		and   en_ced_ruc  = rtrim(ltrim(@w_sam_id_tercero))
		
     		-- print 'ente %1!, tipodoc %2!, numeroid %3!, ente %4! cuenta %5!',@w_sam_ente,@w_sam_tipo_tercero,@w_sam_id_tercero,@w_sam_ente,@w_sam_cuenta
     
		if @w_existe = 1
		begin
			select @w_dato = "ENTE: " + @w_sam_tipo_tercero + ' ' + @w_sam_id_tercero  + ' ' + convert(varchar(10),@w_sam_ente)
	  
			update cob_conta..cb_sasiento_mig
			set    sam_error = 1
			where  sam_comprobante = @w_sam_comprobante
			and    sam_asiento     = @w_sam_asiento

			exec  sp_migra_log_errores
			@i_fuente       = @w_desc_origen_error,
			@i_fila         = @w_sam_asiento,
			@i_campo        = '',
			@i_dato         = @w_dato,
			@i_referencia   = 600302,
			@i_operacion    = @w_sam_comprobante,
			@i_producto     = 6
		end	   
      		else
      		begin 									
	    		if (@w_tipo_tercero != @w_sam_tipo_tercero) or (@w_id_tercero != rtrim(ltrim(@w_sam_id_tercero)))
			begin
				select @w_dato = "ENTETIPIDEN: " + @w_sam_tipo_tercero + ' ' + @w_sam_id_tercero  + ' ' + convert(varchar(10),@w_sam_ente)
			
	            		update cob_conta..cb_sasiento_mig
	        		set    sam_error = 1
	        	    	where  sam_comprobante = @w_sam_comprobante
        	    		and    sam_asiento     = @w_sam_asiento

			        exec  sp_migra_log_errores
        			@i_fuente       = @w_desc_origen_error,
				@i_fila         = @w_sam_asiento,
	            		@i_campo        = '',
	        	    	@i_dato         = @w_dato,
        	    	    	@i_referencia   = 600303,
            		    	@i_operacion    = @w_sam_comprobante,
		        	@i_producto     = 6		
	    		end 
      		end      
	end
   fetch cursor_asiento into
   @w_sam_comprobante,	@w_sam_area_dest,	@w_sam_cuenta,
   @w_sam_oficina_dest,	@w_sam_credito,		@w_sam_debito,
   @w_sam_tipo_tercero,	@w_sam_id_tercero,	@w_sam_ente,
   @w_sam_proceso,	@w_sam_empresa,		@w_sam_asiento,
   @w_sam_credito_me,	@w_sam_debito_me,	@w_sam_con_impuesto,
   @w_sam_base,		@w_comp_origen,		@w_fecha_tran,
   @w_scm_oficina_orig,	@w_scm_area_orig
end
close cursor_asiento
deallocate cursor_asiento

return 0
go
