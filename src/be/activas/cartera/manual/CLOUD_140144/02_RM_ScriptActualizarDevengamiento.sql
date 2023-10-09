use cob_cartera
go
declare 
@w_operacion      int     ,
@w_registro       int     ,
@w_fecha_proceso  datetime,
@w_fecha_inicio   datetime,
@w_fecha_fin      datetime,
@w_dias_aplaza    int,
@w_dias_transcu   int,
@w_interes        money,
@w_moneda         int,
@w_num_dec        int,
@w_valor_prov     money,
@w_valor_acum     money,
@w_error          int   


select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

exec sp_decimales
   @i_moneda       = 0,
   @o_decimales    = @w_num_dec out
   

select @w_operacion = 0, @w_registro = 0

while 1 = 1
begin
   select @w_registro = @w_registro +1
   

   select top 1 
   @w_operacion    = operacion,
   @w_fecha_inicio = fecha_inicio,
   @w_dias_aplaza  = dias_aplaza,
   @w_dias_transcu = dias_transcu,
   @w_moneda       = moneda
   from ca_desplazamiento_138837
   where operacion > @w_operacion
   and   procesado = 'N'
   order by operacion  
   
   if @@rowcount = 0 break
   
   if not exists(select 1 from cob_cartera..ca_amortizacion where am_operacion = @w_operacion and am_concepto = 'INT_ESPERA')
   begin
     insert into ca_procesamiento_138837 values(@w_operacion, 'Operacion Sin Rubros Desplazamiento')
     goto Siguiente
   end    

   select @w_valor_acum = sum(am_acumulado),
          @w_interes    = sum(am_cuota)
   from cob_cartera..ca_amortizacion 
   where am_operacion = @w_operacion 
   and am_concepto = 'INT_ESPERA'
   
   select @w_valor_prov = round((@w_interes * @w_dias_transcu) /@w_dias_aplaza, @w_num_dec)
   select @w_valor_prov = @w_valor_prov - @w_valor_acum
      
 
   if @w_valor_prov <= 0 
   begin
      update ca_desplazamiento_138837 set
      procesado = 'S',
      mensaje   = 'Operacion Devengado: ' + convert(varchar,@w_operacion) + ' @w_valor_prov:' + convert(varchar,@w_valor_prov)
      where operacion = @w_operacion
      
      goto Siguiente
   end
   
        
   print '@w_operacion:' + convert(varchar,@w_operacion) + ' @w_dias_aplaza:'+ convert(varchar,@w_dias_aplaza) + ' @w_dias_transcu: ' + convert(varchar,@w_dias_transcu)
   print '@w_interes:' + convert(varchar,@w_interes) +' @w_valor_prov: ' + convert(varchar,@w_valor_prov) + ' @w_valor_acum:' + convert(varchar,@w_valor_acum)
    
  
   exec  @w_error = sp_calculo_diario_int_des
         @s_user               = 'usrbatch',
         @s_term               = 'CTSSRV',
         @s_date               = @w_fecha_proceso,
         @i_fecha_proceso      = @w_fecha_proceso,
         @i_operacionca        = @w_operacion,
         @i_monto_int          = @w_valor_prov
         
   if @w_error = 0
   begin
      update ca_desplazamiento_138837 set
      procesado = 'S',
      mensaje   = 'Operacion Procesada' 
      where operacion  = @w_operacion
   end
   
   
   Siguiente: 
end