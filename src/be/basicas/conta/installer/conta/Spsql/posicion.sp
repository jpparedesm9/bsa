/************************************************************************/
/*	Archivo: 		posicion.sp			        */
/*	Stored procedure: 	sp_posicion				*/
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
/*	copia desde las tablas temporales de comprobantes y asientos    */
/*	a las tablas definitivas, Mayorizacion de los asientos		*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	24-Feb-1999	Juan C. G¢mez	Modificaciones	JCG10		*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_posicion')
	drop proc sp_posicion
go
create proc sp_posicion   (
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
		@i_operacion	char(1) = null,
		@i_modo		smallint = 0,
		@i_empresa 	tinyint = null, 
		@i_fecha_tran	datetime = null,
		@i_comprobante 	int = null  ,
                @i_oficina_orig smallint = null,
		@i_detalles	smallint = null,
		@i_control	tinyint = 0,
                @i_moneda_base  tinyint = 0
	)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_comprobante 	int,
	@w_empresa	tinyint,
	@w_oficina_orig smallint,
	@w_area_orig    smallint,
	@w_tipo_doc	char(1),
	@w_tipo_tran	char(1),
	@w_asiento	smallint,
        @w1_cta_asoc    cuenta,
        @w2_cta_asoc    cuenta,
	@w_debito	money,
	@w_credito	money,
	@w_debito_me	money,
	@w_credito_me	money,
	@w_moneda	tinyint,
	@w1_area     	smallint,
	@w2_area     	smallint,
	@w_concepto	descripcion, 
	@w_contador  	smallint,
	@w_filas	int,
	@w_auxiliar	smallint,
	@wa_fecha_tran	datetime,
	@wa_comprobante int,
	@wa_empresa	tinyint,
	@wa_tipo_doc	char(1),
	@wa_tipo_tran	char(1),
	@wa_moneda	tinyint,
	@wa_debito	money,
	@wa_credito	money,
	@wa_debito_me	money,
	@wa_credito_me 	money,
	@w_valor 	money,
	@w_cuenta	cuenta,	--JCG10 
	@w_cotizacion	money		--JCG10

select @w_today = getdate()
select @w_sp_name = 'sp_posicion'


/************************************************/
/*  Tipo de Transaccion = 611X 			*/

if (@t_trn <> 6701 and @i_operacion = 'I') 
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



if @i_operacion = 'I' 
begin

   begin tran 
	
     if @i_modo = 0
     begin
	 insert into cob_conta..cb_posicion
	 (po_fecha_tran,po_comprobante,po_empresa,po_tipo_doc,
	  po_tipo_tran,po_moneda,po_oficina,po_area,po_debito,po_credito,po_debito_me,	
	  po_credito_me,po_contador,po_cuenta,po_oficina_orig
         )
         select ta_fecha_tran,ta_comprobante,ta_empresa,ta_tipo_doc,
	  	ta_tipo_tran,ta_moneda,ta_oficina_dest,ta_area_dest,sum(ta_debito),sum(ta_credito),	
	  	sum(ta_debito_me), sum(ta_credito_me),0, ta_cuenta, ta_oficina_orig
	 from cb_tasiento
	 where ta_empresa     = @i_empresa and
               ta_fecha_tran  = @i_fecha_tran and
	       ta_comprobante = @i_comprobante and
               ta_oficina_orig = @i_oficina_orig and
	       ta_tipo_doc in ('C','V') and
	       ta_moneda     <> @i_moneda_base and
	       substring(ta_cuenta,1,1) NOT IN ('6','7','8')			
	 group by ta_empresa,ta_fecha_tran,ta_comprobante,ta_tipo_doc,
	          ta_tipo_tran,ta_moneda, ta_cuenta,ta_oficina_dest, ta_area_dest, ta_oficina_orig
     end
     else  
     begin
	
	 insert into cob_conta..cb_posicion
	 (po_fecha_tran,po_comprobante,po_empresa,po_tipo_doc,
	  po_tipo_tran,po_moneda,po_oficina,po_area,po_debito,po_credito,po_debito_me,	
	  po_credito_me,po_contador, po_cuenta, po_oficina_orig)
	 select ta_fecha_tran,ta_comprobante,ta_empresa,ta_tipo_doc,
	  	ta_tipo_tran,ta_moneda,ta_oficina_dest,ta_area_dest,ta_debito,ta_credito,	
	  	ta_debito_me, ta_credito_me,0, ta_cuenta, ta_oficina_orig
	 from cb_tasiento
	 where ta_empresa     = @i_empresa
           and ta_fecha_tran  = @i_fecha_tran 
           and ta_comprobante = @i_comprobante
           and ta_oficina_orig = @i_oficina_orig
           and ta_moneda     <> @i_moneda_base
	   and substring(ta_cuenta,1,1) NOT IN ('6','7','8')			
     end

     if @@error <> 0
        begin
	  exec cobis..sp_cerror
	   @t_debug = @t_debug,
	   @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 603077
	  return 1
        end

     select @w_auxiliar = count(*) from cb_posicion
     where po_empresa     = @i_empresa
       and po_fecha_tran  = @i_fecha_tran 
       and po_comprobante = @i_comprobante 
       and po_oficina_orig = @i_oficina_orig	    

     if @i_control = 1
     begin 
         select count(*),
	      sum(ta_debito),
       	      sum(ta_credito),
	      sum(ta_debito_me),
	      sum(ta_credito_me)
         from cb_tasiento
         where ta_empresa = @i_empresa 
           and ta_fecha_tran = @i_fecha_tran
           and ta_comprobante = @i_comprobante 
           and ta_oficina_orig = @i_oficina_orig

       return 0
     end

     if @w_auxiliar = 0
     begin
	  select count(*),
		 sum(ta_debito),
       		 sum(ta_credito),
		 sum(ta_debito_me),
	 	 sum(ta_credito_me)
	  from cb_tasiento
	  where ta_empresa = @i_empresa 
            and ta_fecha_tran = @i_fecha_tran
	    and ta_comprobante = @i_comprobante 
            and ta_oficina_orig = @i_oficina_orig

	   return 0
     end
     else 
     begin
	   select @w_concepto = 'ASIENTO AUTOMATICO POSICION MONEDA EXTRANJERA'
     end
     select @w_filas = 1,
            @w_contador = 1,
	    @w_asiento = @i_detalles

     while @w_filas = 1 
     begin

		select 	@w_tipo_doc  = po_tipo_doc,
			@w_tipo_tran = po_tipo_tran,
			@w_moneda    = po_moneda,
                        @w_oficina_orig = po_oficina,
                        @w_area_orig = po_area,
			@w_debito    = po_debito,
			@w_credito   = po_credito,
			@w_debito_me = po_debito_me,
			@w_credito_me = po_credito_me,
			@w_cuenta     = po_cuenta		
		from cob_conta..cb_posicion
		where   po_fecha_tran = @i_fecha_tran and
		   	po_comprobante = @i_comprobante and
			po_empresa = @i_empresa and
                        po_oficina_orig = @i_oficina_orig and
			po_contador = 0

		if @@rowcount = 0
		begin

			select @w_filas = 0

		end
		
		else 
                begin	

			update cob_conta..cb_posicion
			set po_contador = @w_contador
			where 	po_fecha_tran  = @i_fecha_tran and
			     	po_comprobante = @i_comprobante and
				po_empresa     = @i_empresa and
                                po_oficina_orig = @i_oficina_orig and
				po_tipo_doc    = @w_tipo_doc and
				po_tipo_tran   = @w_tipo_tran and
				po_moneda      = @w_moneda and
                                po_oficina     = @w_oficina_orig and
                                po_area        = @w_area_orig and
                                po_debito      = @w_debito and
                                po_credito     = @w_credito and
                                po_debito_me   = @w_debito_me and
                                po_credito_me  = @w_credito_me and
                                po_cuenta      = @w_cuenta

		        if @@error <> 0
		           begin
			     exec cobis..sp_cerror
		   	     @t_debug = @t_debug,
	                     @t_file  = @t_file,
	   		     @t_from  = @w_sp_name,
	   		     @i_num   = 603078
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig

				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig
	  		     return 1
        		   end
			
                        if @w_debito <> 0 and @w_credito <> 0
                           begin
                           select @w_valor = @w_debito - @w_credito
                           if @w_valor > 0 
                              select @w_debito = @w_valor, @w_credito = 0
                           else
                              select @w_credito = @w_valor * -1, @w_debito = 0
                        end

			select @w_contador = @w_contador + 1



                        select @w2_cta_asoc = ca_cta_asoc ,
			       @w2_area     = ca_area_destino
			from cb_cuenta_asociada
			where ca_proceso = 6001 and
			      ca_cuenta  = @w_cuenta and	
			      ca_condicion = 1 and      	
                              ca_empresa   = @i_empresa         

			if @@rowcount = 0
			begin
	                        print 'no existe asociacion con condicion1 para %1!'+ @w_cuenta

				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603056
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig

				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig
				return 1
			end

			select @w1_cta_asoc = ca_cta_asoc,
			       @w1_area     = ca_area_destino
			from cb_cuenta_asociada
			where ca_proceso = 6001 and
			      ca_cuenta = @w_cuenta and		
			      ca_condicion = 2	and		
                              ca_empresa   = @i_empresa        


			if @@rowcount = 0
			begin
                                print 'no existe asociacion con condicion2 para %1!'+ @w_cuenta

				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603056
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig

				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig
				return 1
			end



			if not exists (	select pg_empresa 
					 from cb_plan_general
                       			where pg_empresa = @i_empresa
                         		  and pg_cuenta  = @w2_cta_asoc
                         		  and pg_oficina = @w_oficina_orig
                         		  and pg_area    = @w_area_orig
					)

			begin

                          print '@w2_cta_asoc %1! @w_oficina_orig %2! @w_area_orig %3!'+@w2_cta_asoc+@w_oficina_orig+@w_area_orig

           		  exec cobis..sp_cerror
                  	  @t_debug = @t_debug,
                          @t_file  = @t_file,
               		  @t_from  = @w_sp_name,
                	  @i_num   = 601109
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig



				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig


			  return 1
			end


			if not exists (	select pg_empresa 
					 from cb_plan_general
                       			where pg_empresa = @i_empresa
                         		  and pg_cuenta  = @w1_cta_asoc
                         		  and pg_oficina = @w_oficina_orig
                         		  and pg_area    = @w_area_orig
					)

			begin

                          print '@w1_cta_asoc %1! @w_oficina_orig %2! @w_area_orig %3!'+@w1_cta_asoc+@w_oficina_orig+@w_area_orig

           		  exec cobis..sp_cerror
                  	  @t_debug = @t_debug,
                          @t_file  = @t_file,
               		  @t_from  = @w_sp_name,
                	  @i_num   = 601109
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig



				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig


			  return 1
			end




		        select @w_asiento = @w_asiento + 1

			if @w_credito_me <> 0
				select @w_cotizacion = @w_credito / @w_credito_me
			else
				if @w_debito_me <> 0
					select @w_cotizacion = @w_debito / @w_debito_me
			else
				select @w_cotizacion = 0

		        insert into cb_tasiento
			   (ta_fecha_tran,ta_comprobante,ta_empresa,
			    ta_asiento,ta_cuenta,ta_oficina_dest,
			    ta_area_dest,ta_credito,ta_debito,
			    ta_credito_me,ta_debito_me,ta_tipo_doc,
			    ta_tipo_tran,ta_moneda,ta_concepto,ta_mayorizado,
			    ta_cotizacion,ta_oficina_orig)
		        values
			   (@i_fecha_tran,@i_comprobante,@i_empresa,
			    @w_asiento,@w2_cta_asoc,@w_oficina_orig,
			    @w_area_orig,@w_debito,@w_credito,@w_debito_me,
			    @w_credito_me,@w_tipo_doc,@w_tipo_tran,@w_moneda,
			    @w_concepto,'N',@w_cotizacion,@i_oficina_orig)	--JCG10

		        if @@error <> 0
		           begin
			     exec cobis..sp_cerror
		   	     @t_debug = @t_debug,
	                     @t_file  = @t_file,
	   		     @t_from  = @w_sp_name,
                	        @i_num   = 603020
				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig

				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig
			        return 1
        		   end




		        select @w_asiento = @w_asiento + 1


		        insert into cb_tasiento
			   (ta_fecha_tran,ta_comprobante,ta_empresa,
			    ta_asiento,ta_cuenta,ta_oficina_dest,
			    ta_area_dest,ta_credito,ta_debito,
			    ta_credito_me,ta_debito_me,ta_tipo_doc,
			    ta_tipo_tran,ta_moneda,ta_concepto,ta_mayorizado,
			    ta_cotizacion,ta_oficina_orig)
		        values
			   (@i_fecha_tran,@i_comprobante,@i_empresa,
			    @w_asiento,@w1_cta_asoc,@w_oficina_orig,
			    @w_area_orig,@w_credito,@w_debito,0,0,@w_tipo_doc,
			    @w_tipo_tran,0,@w_concepto,'N',0,@i_oficina_orig)	

			if @@error <> 0
		           begin
			     exec cobis..sp_cerror
		   	     @t_debug = @t_debug,
	                     @t_file  = @t_file,
	   		     @t_from  = @w_sp_name,
                	        @i_num   = 603020

				delete cob_conta..cb_tasiento
				where	ta_empresa = @i_empresa and
			       		ta_fecha_tran = @i_fecha_tran and
					ta_comprobante = @i_comprobante and
                                        ta_oficina_orig = @i_oficina_orig

				delete cob_conta..cb_tcomprobante
				where	ct_empresa = @i_empresa and
			      		ct_fecha_tran = @i_fecha_tran and
					ct_comprobante = @i_comprobante and
                                        ct_oficina_orig = @i_oficina_orig

				delete cb_posicion
				where
	      				po_fecha_tran = @i_fecha_tran and
	      				po_comprobante = @i_comprobante and
	      				po_empresa = @i_empresa and
                                        po_oficina_orig = @i_oficina_orig
			        return 1
        		   end


		end 
	end 	    
                
	select 	count(*),
		sum(ta_debito),
       		sum(ta_credito),
		sum(ta_debito_me),
		sum(ta_credito_me)
	from cb_tasiento
	where 	ta_fecha_tran = @i_fecha_tran and
		ta_comprobante = @i_comprobante and
		ta_empresa = @i_empresa and
                ta_oficina_orig = @i_oficina_orig
   commit tran
   return 0
end
go
