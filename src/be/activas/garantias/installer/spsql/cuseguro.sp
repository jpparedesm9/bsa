/***********************************************************************/
/*	Archivo:		cuseguro.sp                            */
/*	Stored procedure:	sp_valor_resp_garantia                 */
/*	Base de Datos:		cob_custodia                  	       */
/*	Producto:		Garantias	                       */
/*	Disenado por:		Milena Gonzalez            	       */
/*	Fecha de Documentacion: 20/Ene/2004                            */
/***********************************************************************/
/*			IMPORTANTE		       		       */
/*	Este programa es parte de los paquetes bancarios propiedad de  */
/*	"MACOSA"                                                       */
/*	Su uso no autorizado queda expresamente prohibido asi como     */
/*	cualquier autorizacion o agregado hecho por alguno de sus      */
/*	usuario sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante	       */
/***********************************************************************/
/*			PROPOSITO				       */
/*	Este stored procedure permite conocer el valor distribuido de  */
/*      la garantia                                                    */
/*	Garantias por operacion                                        */
/***********************************************************************/
/*			MODIFICACIONES				       */
/*	FECHA		AUTOR			RAZON		       */
/***********************************************************************/

use cob_custodia
go

if exists (select 1 from sysobjects where name = 'sp_valor_resp_garantia')
    drop proc sp_valor_resp_garantia
go
create proc sp_valor_resp_garantia(
   @i_tramite		 int,
   @i_tipo_garantia      varchar(64)

	
)
as

declare
   @w_return             int,          /* VALOR QUE RETORNA  */
   @w_sp_name            varchar(32),  /* NOMBRE STORED PROC */
   @w_porctram     	 float,
   @w_tramite		 int, 
   @w_garantia		 varchar(20),
   @w_disponible         money,
   @w_monto_tram         money,
   @w_monto_gar          money,
   @w_monto_ori          money,
   @w_porctramite     	 float,
   @w_tipo_tra           char(1),
   @w_op_operacion 	 int,
   @w_op_moneda	 	 int,
   @w_op_fecha_ult_proceso	datetime,
   @w_saldo_oper	 money,
   @w_moneda_local       	    smallint,
   @w_cot_mn                        money ,
   @w_saldo_operacion	 money ,
   @w_estado_gar	 char(1),
   @w_respaldo           money

select @w_sp_name = 'sp_valor_resp_garantia'

if @i_tipo_garantia is null
   begin
      --select @o_retorno_respaldo = 0
      return 0
   end
if @i_tramite is not null
   begin
   	select @w_tipo_tra = tr_tipo  
	from cob_credito..cr_tramite 
	where tr_tramite = @i_tramite
   end
   else
   begin
	print 'cuseguro.sp El numero de tramite no existe'
    	return 1
   end	


-- CONSULTA CODIGO DE MONEDA LOCAL
select @w_moneda_local = pa_tinyint
from   cobis..cl_parametro
WHERE  pa_nemonico = 'MLO'
AND    pa_producto = 'ADM'
set transaction isolation level read uncommitted


/*create table #temporal (
tramite int null,
garantia varchar(64) null,
respaldo money null,
sesion int null)*/


if @w_tipo_tra = 'O' or @w_tipo_tra = 'R'
begin
	select @w_op_operacion 	        = op_operacion,
	       @w_op_moneda	 	= op_moneda,
	       @w_op_fecha_ult_proceso	= op_fecha_ult_proceso
	from cob_cartera..ca_operacion 
	where op_tramite 		= @i_tramite
 
        select @w_saldo_oper = sum(am_cuota + am_gracia - am_pagado)
        from   cob_cartera..ca_amortizacion, cob_cartera..ca_rubro_op
        where  ro_operacion  = @w_op_operacion
        and    ro_tipo_rubro = 'C'
        and    am_operacion  = @w_op_operacion
        and    am_estado <> 3
        and    am_concepto   = ro_concepto

        
		

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
  	        if @w_return <> 0
	           begin
		      PRINT 'cuseguro.sp Error ejecutando cob_cartera..sp_conversion_moneda' 
                      return 1
                   end     		


      ---PRINT 'cuseguro.sp @w_saldo_oper %1! - @w_saldo_operacion %2!' + @w_saldo_oper + @w_saldo_operacion

       select @w_monto_tram = @w_saldo_operacion

		if @w_monto_tram is null
  		begin
  			print 'cuseguro.sp Error en la conversiond el monto ' + cast(@w_saldo_oper as varchar)
  			return 1
  		end

   		select @w_monto_ori = isnull(@w_monto_tram ,0)
   		select @w_porctram  = 0

	
	declare cur_distribucion cursor for
     	select 	gp_tramite, 
		gp_garantia, 
		cu_acum_ajuste,
		(cu_acum_ajuste / @w_monto_tram)
	from cob_credito..cr_gar_propuesta, cob_custodia..cu_custodia, cob_credito..cr_tramite
	where  gp_tramite = @i_tramite
        and gp_tramite = @i_tramite
        and gp_tramite = tr_tramite
        and tr_tipo in ('O','R','M')   -- Tipo de Tramite Normalizacion
	and gp_garantia = cu_codigo_externo
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
             
	           select @w_monto_gar = @w_disponible
	           select @w_porctram = 100 - (@w_monto_tram / @w_monto_ori ) * 100 - @w_porctram 
	           select @w_disponible = 0
                   end
 
           end
           else
	   begin
	           select @w_disponible  = @w_disponible  - @w_monto_tram
	           select @w_porctram = (@w_monto_tram / @w_monto_ori ) * 100 
	           select @w_monto_gar = @w_monto_tram
	           select @w_monto_tram = 0

           end
           ---PRINT 'cuseguro.sp va a insertar en  cob_cartera..ca_tmp_seguro'
           insert into cob_cartera..ca_tmp_seguro
           values (@w_tramite,@w_garantia,@w_monto_gar,@@spid)

	select 	@w_estado_gar = cu_estado
 	from 	cu_custodia
	where 	cu_codigo_externo = @w_garantia 
	

	
	fetch cur_distribucion into   
	@w_tramite,
	@w_garantia,
	@w_disponible,
	@w_porctramite
   	end

   	close cur_distribucion
   	deallocate cur_distribucion


/*select @w_respaldo = sum(respaldo)
from   #temporal,cob_custodia..cu_custodia,cob_credito..cr_gar_propuesta
where  cu_codigo_externo = garantia
and    cu_codigo_externo = gp_garantia
and    cu_tipo = @i_tipo_garantia
and    gp_tramite = @i_tramite*/

--select @o_retorno_respaldo = isnull(@w_respaldo,0)

/*delete #temporal
where sesion = @@spid*/

end
return 0
go


