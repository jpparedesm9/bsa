/************************************************************************/
/*      Archivo:                desempar.sp                             */
/*      Stored procedure:       sp_liquidacion_parcial                   */
/*      Base de datos:          cob_cartera                             */
/*      Producto:               Cartera                                 */
/*      Disenado por:           R Garces   		                        */
/*      Fecha de escritura:     Jul. 1997                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.							                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                              PROPOSITO                               */
/*      Generacion de un desembolso parcial para la operacion indicada  */
/************************************************************************/
/*      FECHA          AUTOR          CAMBIO                            */
/*      ABR-2006    Elcira Pelaez      NR-296                           */
/************************************************************************/  

use cob_cartera
go

if exists (select 1 from sysobjects where name = 'sp_liquidacion_parcial')
	drop proc sp_liquidacion_parcial
go

create proc sp_liquidacion_parcial
   @s_user                login        = null,
   @s_date                datetime     = null,
   @s_ofi                 int          = null,
   @s_term                varchar (30) = null,
   ---@i_opcion              tinyint,       
	@i_banco		           cuenta       = null,
   @i_monto_des           money,
   @i_num_dec             smallint     = 0,
   @i_en_linea            char(1)      = 'S',
   @i_fecha_proceso       datetime,
   @i_concepto_cap        catalogo    = 'CAP',
   @i_operacionca         int
        
	  
as
declare @w_sp_name         descripcion,
	@w_error                int,
   @w_tipo_producto        catalogo,
   @w_saldo                money,
   @w_di_dividendo         int,
   @w_cap                  money,
   @w_saldo_total          money,
   @w_valor_cuota          money,
   @w_max_cuota             int,
   @w_cuotas                int,
   @w_concepto_cap          catalogo,
   @w_capital_total         money,
   @w_pagado_vigente        money,
   @w_diff                  money,
   @w_total_distribuido     money
   
   

        

---- CARGAR VALORES INICIALES 
select @w_sp_name = 'sp_liquidacion_parcial'



begin

   if @i_monto_des <= 0
   Begin
      PRINT 'desempar.sp el valor de desembolso parcial  es 0'
      return 0
   end

   
   --Actualizacion de la operacion
   
   update ca_operacion
   set op_monto = op_monto + @i_monto_des
   where op_operacion = @i_operacionca

   if @@error !=0 
         return 711027

   update ca_rubro_op
   set ro_valor = ro_valor + @i_monto_des
   where ro_operacion = @i_operacionca
   and ro_concepto = @i_concepto_cap

   if @@error !=0 
         return 711028


   select @w_concepto_cap  = pa_char
   from   cobis..cl_parametro
   where  pa_producto = 'CCA'
   and    pa_nemonico = 'CAP'
   set transaction isolation level read uncommitted
   
   select @w_cuotas = count(1)
   from ca_dividendo
   where  di_operacion = @i_operacionca
   and    di_estado in (0, 1)
   
   select @w_max_cuota = max(di_dividendo)
   from ca_dividendo
   where  di_operacion = @i_operacionca
/*
   ---En esta opcion se actualiza la tabla de amortizacion para cualquier desembolso
   --parcial en el mismo tiempo inicialmente pactado
   if @i_opcion = 0
   begin
         select @w_saldo_total = 0
      
         select @w_saldo_total = isnull(sum(am_acumulado - am_pagado),0)
         from   ca_amortizacion, ca_dividendo
         where  am_operacion = @i_operacionca
         and    am_concepto = @w_concepto_cap
         and    di_operacion = @i_operacionca
         and    di_estado    in (0, 1)
         and    am_dividendo = di_dividendo
         
         if @w_saldo <= 0
          return 710442
          
         --El valor pagado de la cuota vigente debe ir en el saldo para la distribucion
         select @w_pagado_vigente = 0
         select @w_pagado_vigente = isnull(sum(am_pagado),0)
         from   ca_amortizacion, ca_dividendo
         where  am_operacion = @i_operacionca
         and    am_concepto = @w_concepto_cap
         and    di_operacion = @i_operacionca
         and    di_estado    = 1
         and    am_dividendo = di_dividendo
         
        
         select  @w_capital_total = @i_monto_des + @w_saldo_total + @w_pagado_vigente
         
          select @w_valor_cuota = round(@w_capital_total / @w_cuotas, @i_num_dec)
         

        
        
         select @w_cap = 0 
         declare
            cur_dividendo cursor
            for 
                select di_dividendo
                from   ca_dividendo,
                       ca_amortizacion
                where  di_operacion = @i_operacionca
                and    di_estado in (0, 1)
                and    di_operacion = am_operacion
                and    di_dividendo = am_dividendo
                and    am_concepto = 'CAP'
      
                
                order  by di_dividendo
            for read only
         
         open cur_dividendo
         
         fetch cur_dividendo
         into  @w_di_dividendo
         
         --while @@fetch_status not in (-1,0)
         while @@fetch_status = 0
         begin
      
            -- CALCULAR SALDO DE LA OPERACION
       
            --La ultima va por diferencia
            if @w_di_dividendo = @w_max_cuota
               select @w_valor_cuota =  round(@w_capital_total -   @w_cap,@i_num_dec)
      
            
            update ca_amortizacion
            set    am_cuota =  @w_valor_cuota,
                   am_acumulado =  @w_valor_cuota
            where  am_operacion = @i_operacionca
            and    am_dividendo = @w_di_dividendo
            and    am_concepto  = @i_concepto_cap
            
            if @@error !=0  or @@rowcount = 0
               begin
                  close cur_dividendo
                  deallocate cur_dividendo
                  return 711030
               end
      
               select @w_cap = @w_cap + @w_valor_cuota
      
            
            ---
            fetch cur_dividendo
            into  @w_di_dividendo
         end
         
         close cur_dividendo
         deallocate cur_dividendo
   
  end ---opcion 0
             
  ---En sta opcion se actualiza para credito rotativo
  ---despues de la distribucion del tiempo en la tabla de amortizacion 
  
  if @i_opcion = 1
  begin*/
   
     select @w_valor_cuota = round(@i_monto_des / @w_cuotas, @i_num_dec)
 
     
     
     update ca_amortizacion
     set am_cuota = am_cuota + @w_valor_cuota,
         am_acumulado = am_acumulado + @w_valor_cuota
     from ca_amortizacion,
         ca_dividendo
     where am_operacion = @i_operacionca
     and   di_operacion = @i_operacionca
     and   am_dividendo = di_dividendo
     and   am_concepto =  @w_concepto_cap
     and   di_estado in (1,0)

     if @@error !=0  or @@rowcount = 0
        return 711030
 
 
      --Validar redondeo por diferencia 
      
      select @w_total_distribuido = @w_valor_cuota * @w_cuotas
      select @w_diff = round(@w_total_distribuido -@i_monto_des,@i_num_dec)
      if @w_diff >= 1
      begin
         ---PRINT 'desempar.sp valor cuota %1! @w_diff con utilizacion %2!',@w_valor_cuota,@w_diff
         update ca_amortizacion
         set am_cuota = am_cuota - @w_diff,
             am_acumulado = am_acumulado - @w_diff
         from ca_amortizacion
         where am_operacion = @i_operacionca
         and   am_concepto =  @w_concepto_cap
         and am_dividendo = @w_max_cuota

        if @@error !=0  or @@rowcount = 0
           return 711030
         
      end
  ---end ---opcion 1
  
   ---REAJSUTAR LA TABLA EN INTERESES
   
         exec @w_error = sp_reajuste_interes 
           @s_user           = @s_user,
           @s_term           = @s_term,
           @s_date           = @s_date,
           @s_ofi            = @s_ofi,
           @i_operacionca    = @i_operacionca,   
           @i_fecha_proceso  = @i_fecha_proceso,
           @i_banco          = @i_banco,
           @i_en_linea       = @i_en_linea,
           @i_des_parcial    = 'S'
      
      if @w_error != 0  
         return @w_error

   -- RECALCULO DE RUBROS SOBRE VALOR INSOLUTO
   if exists (select 1 from ca_amortizacion,ca_rubro_op
              where am_operacion = @i_operacionca
              and am_operacion = ro_operacion
              and am_concepto = ro_concepto
              and ro_saldo_insoluto = 'S'
              and am_estado != 3)
   begin           
     exec @w_error = sp_recalculo_seguros_sinsol
          @i_operacion = @i_operacionca
   
     if @w_error != 0
         return @w_error
   end   

end



return 0


go




