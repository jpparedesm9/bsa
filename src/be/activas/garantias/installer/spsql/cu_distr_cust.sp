/*cr_distr_cust**********************************************************************/
/*	Archivo:			cr_distr_cust.sp               */
/*	Stored procedure:		sp_distr_cust                  */
/*	Base de Datos:			cob_credito                    */
/*	Producto:			Credito	                       */
/*	Disenado por:			Ivonne Ordonez                 */
/*	Fecha de Documentacion: 	03/Sep/2001                    */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA",representantes exclusivos para el Ecuador de la       */
/*	AT&T							       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Este stored procedure permite distribuir el valor de las       */
/*	Garantias por operacion                                        */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/*	03/Sep/2001	Pablo Gaibor		Emision Inicial	       */
/***********************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_distr_cust')
    drop proc sp_distr_cust
go
create proc sp_distr_cust (
   @i_tramite		 int = null,
   @i_tipo_tram          char(1) = null,
   @i_mensaje		 char(1) = "S"
	
)
as

declare
   @w_today              datetime,     /* FECHA DEL DIA      */ 
   @w_return             int,          /* VALOR QUE RETORNA  */
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC */
   @w_existe             tinyint,      /* EXISTE EL REGISTRO */
   @w_codigo             varchar(10),
   @w_valor              money,
   @w_tipo               char(1),
   @w_cont               tinyint,
   @w_tipo_gar           catalogo,
   @o_codigo             varchar(10),
   @o_tipo               char(1),
   @w_porctram     	 float,
   @w_tramite		 int, 
   @w_garantia		 varchar(20),
   @w_disponible         money,
   @w_monto_tram         money,
   @w_monto_gar          money,
   @w_monto_ori          money,
   @w_porctramite     	 float,
   @w_cobertura 	 float,
   @w_num_dec		 int,
   @w_op_operacion 	 int,
   @w_op_moneda	 	 int,
   @w_op_fecha_ult_proceso	datetime,
   @w_saldo_oper	 money,
   @w_estado         	 int,
   @w_calificacion       	  catalogo, 
   @w_clase_cartera      char(1) ,
   @w_moneda_local       	    smallint,
   @w_cot_mn                        money ,
   @w_saldo_operacion	 money ,
   @w_estado_gar	 char(1)

select @w_sp_name = 'sp_distr_cust'

if @i_tramite is  null
   begin
	   print 'El numero de tramite no existe'
    	return 1
   end	

if @i_tipo_tram = 'O' or @i_tipo_tram = 'R'
begin
	select 	@w_op_operacion 	= op_operacion,
		@w_op_moneda	 	= op_moneda,
		@w_op_fecha_ult_proceso	= op_fecha_ult_proceso,
		@w_estado		= op_estado,
                @w_calificacion       	= op_calificacion,                 
                @w_clase_cartera       	= op_clase 
	from cob_cartera..ca_operacion 
	where op_tramite 		= @i_tramite

	exec @w_return  = cob_cartera..sp_decimales
		@i_moneda       = @w_op_moneda,
		@o_decimales    = @w_num_dec out


		exec @w_return = cob_cartera..sp_calcula_saldo
		@i_operacion   = @w_op_operacion,
		@i_tipo_pago   = 'A',
		@o_saldo       = @w_saldo_oper out

		select	@w_monto_tram = @w_saldo_oper 



                select @w_saldo_oper = isnull(@w_saldo_oper,0)

                

		exec @w_return = cob_cartera..sp_conversion_moneda
		@s_date             = @w_op_fecha_ult_proceso,
     		@i_opcion           = 'L',
     		@i_moneda_monto     = @w_op_moneda,
     		@i_moneda_resultado = @w_moneda_local,
     		@i_monto            = @w_saldo_oper,
     		@i_fecha            = @w_op_fecha_ult_proceso,
     		@o_monto_resultado  = @w_saldo_operacion out,
     		@o_tipo_cambio      = @w_cot_mn out

                select @w_monto_tram = @w_saldo_operacion 

		if @w_monto_tram is null and @i_mensaje = 'S'
  		begin
  			print 'El monto error'
  			return 1
  		end

   		select @w_monto_ori = isnull(@w_monto_tram ,0)
   		select @w_porctram  = 0


        if @w_monto_tram = 0 select @w_monto_tram = 1 /*emg Marzo28*/
	
	declare cur_distribucion cursor for
     	select 	dg_tramite, 
		dg_garantia, 
		cu_acum_ajuste,
		(cu_acum_ajuste / @w_monto_tram)
	from cob_custodia..cu_distr_garantia, cob_custodia..cu_custodia, cob_credito..cr_tramite
	where  dg_tramite = @i_tramite
        and dg_tramite = @i_tramite
        and dg_tramite = tr_tramite
        and tr_tipo in ('O','R','M')  -- CCA 436 Normalizacion
	and dg_garantia = cu_codigo_externo
        and cu_acum_ajuste > 0
        and cu_clase_custodia <> 'O'
        order by  cu_clase_custodia asc, cu_abierta_cerrada desc, cu_agotada desc, cu_acum_ajuste desc
        for read only

	open cur_distribucion
	fetch cur_distribucion into 
	@w_tramite,
	@w_garantia,
	@w_disponible,
	@w_porctramite

	while @@fetch_status = 0
        begin
	      	if @@fetch_status = -1
		begin
		close cur_distribucion
		deallocate cur_distribucion                        
                rollback
		return 1
		end


           if @w_disponible  = 0
	   begin
	           select @w_porctram = 0
	           select @w_monto_gar = 0
	           select @w_monto_tram = 0

           end


           if @w_monto_tram - @w_disponible  >= 0
           begin

                   begin





	           select @w_monto_tram = @w_monto_tram - @w_disponible
                   if @w_monto_tram< 0
	           select @w_monto_tram = 0
             

                   if @w_monto_ori = 0 select @w_monto_ori = @w_monto_tram /*emg Marzo28*/

	           select @w_monto_gar = @w_disponible
	           select @w_porctram = 100 - (@w_monto_tram / @w_monto_ori ) * 100 - @w_porctram 
	           select @w_disponible = 0
                   end

 
           end
           else
	   begin

	           select @w_disponible  = @w_disponible  - @w_monto_tram

                   if @w_monto_ori = 0 select @w_monto_ori = @w_monto_tram /*emg Marzo28*/

	           select @w_porctram = (@w_monto_tram / @w_monto_ori ) * 100 
	           select @w_monto_gar = @w_monto_tram
	           select @w_monto_tram = 0

           end



          update cob_custodia..cu_custodia 
           set cu_acum_ajuste = @w_disponible 
	   where cu_codigo_externo = @w_garantia 


	select 	@w_estado_gar = cu_estado
 	from 	cu_custodia
	where 	cu_codigo_externo = @w_garantia 
	


           update cob_custodia..cu_distr_garantia  
           set 	  dg_monto_exceso= @w_monto_tram, 
               	  dg_porcentaje = @w_porctram,
               	  dg_valor_resp_garantia = @w_monto_gar
	   where  dg_garantia = @w_garantia 
           and    dg_tramite = @i_tramite 
   
	
	fetch cur_distribucion into   
	@w_tramite,
	@w_garantia,
	@w_disponible,
	@w_porctramite
   	end

   	close cur_distribucion
   	deallocate cur_distribucion

	select 	@w_cobertura = sum(dg_porcentaje)
        from 	cob_custodia..cu_distr_garantia  
	where 	dg_tramite = @i_tramite 

end
return 0
go


