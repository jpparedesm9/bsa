use cob_cartera
go

declare 
@w_di_dividendo_fin int,
@w_int_espera       money,
@w_dividendo        int,
@w_di_dividendo     int,
@w_num_dec          int,
@w_monto_espera     money,
@w_error            int,
@w_moneda           int,
@w_oficina          int,
@w_fecha_proceso    datetime,
@w_banco            cuenta,
@w_toperacion       varchar(24),
@w_concepto_esp     catalogo,
@w_fecha_desembolso datetime,
@w_operacionca      int,
@w_secuencial_des   int

select @w_num_dec = 2
SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso
select @w_fecha_desembolso = '05/28/2020' --Fecha desde la cual las operaciones desplazadas tiene problemas 

select @w_concepto_esp = ru_concepto
from   ca_rubro 
where ru_toperacion = 'GRUPAL'
and   ru_concepto   = 'INT_ESPERA'


   
select *
into #operacion_140389
from cob_cartera..ca_operacion
where op_fecha_ini >= @w_fecha_desembolso
and   op_estado in (1 , 2)
and   op_operacion in (select op_operacion from ca_operaciones_140389)

select *
from #operacion_140389


select @w_operacionca = 0

while 1 = 1 begin

   SELECT top 1
   @w_operacionca  = op_operacion,
   @w_moneda       = op_moneda,
   @w_oficina      = op_oficina,
   @w_banco        = op_banco,
   @w_toperacion   = op_toperacion
   FROM #operacion_140389 
   WHERE op_operacion > @w_operacionca
   order by op_operacion asc
   
   if @@rowcount = 0 break 
   
   --DIVIDENDO NO VIGENTE FINAL
   
   select @w_di_dividendo_fin = max(di_dividendo) 
   from ca_dividendo 
   where di_operacion = @w_operacionca
      
   select 
   @w_di_dividendo  = di_dividendo 
   from ca_dividendo 
   where di_operacion   = @w_operacionca
   and   di_dividendo   = 1     
   
   --SE CAPTURAL VALOR DE INTERES ESPERA 
   select @w_int_espera = de_int_dsp
   from ca_desplazamiento
   where de_operacion  = @w_operacionca
   and   de_estado     = 'A'
   
   if isnull(@w_int_espera ,0) = 0 begin
     goto Siguiente
   end 
   
   select @w_dividendo = @w_di_dividendo   
   select @w_monto_espera = round(@w_int_espera/(@w_di_dividendo_fin -@w_dividendo +1),@w_num_dec)
   
   while @w_dividendo <= @w_di_dividendo_fin  begin 
   
      if (@w_dividendo = @w_di_dividendo_fin)  select @w_monto_espera = @w_int_espera -(@w_monto_espera*(@w_di_dividendo_fin-@w_di_dividendo))
    
      exec @w_error     = sp_otros_cargos
      @s_date           = @w_fecha_proceso,
      @s_user           = '140389',
      @s_term           = 'consola-corr',
      @s_ofi            = @w_oficina,
      @i_banco          = @w_banco,
      @i_moneda         = @w_moneda, 
      @i_operacion      = 'I',
      @i_toperacion     = @w_toperacion,
      @i_desde_batch    = 'N',   
      @i_en_linea       = 'N',
      @i_tipo_rubro     = 'O',
      @i_concepto       = @w_concepto_esp , 
      @i_monto          = @w_monto_espera,      
      @i_div_desde      = @w_dividendo,      
      @i_div_hasta      = @w_dividendo,
      @i_generar_trn    = 'N',
      @i_comentario     = 'GENERADO POR: Caso 140389' 
      
      if @w_error <> 0 begin     
         goto Siguiente
      end 
      
      
      select 
      @w_dividendo = @w_dividendo +1
   end 
   
   select @w_secuencial_des = tr_secuencial
   from ca_transaccion
   where tr_operacion = @w_operacionca
   and   tr_tran      = 'DES'
   and   tr_estado <> 'RV'
   and   tr_secuencial > 0
    
   
   ---eliminar rubros HISTORICO ESPERA
   insert into ca_amortizacion_his
   select @w_secuencial_des, * 
   from ca_amortizacion
   where  am_operacion = @w_operacionca
   and    am_concepto  like '%ESPERA%'
   
   if exists (select 1 from cob_cartera_his..ca_amortizacion_his where amh_secuencial = @w_secuencial_des and amh_operacion = @w_operacionca)
   begin
      insert into  cob_cartera_his..ca_amortizacion_his
      select @w_secuencial_des, * 
      from ca_amortizacion
      where  am_operacion = @w_operacionca
      and    am_concepto  like '%ESPERA%'   
   end
   
    Siguiente:  
end  
          


select op_operacion, op_fecha_ini, de_int_dsp, int_amortizacion = convert(money, null)
into  #operacion_140389es_comple
from cob_cartera..ca_operacion,
     cob_cartera..ca_desplazamiento
where op_operacion     = de_operacion
and   op_estado   in (1,2)
and   op_fecha_ini >= @w_fecha_desembolso
and   de_estado     = 'A'
and   op_operacion in (select op_operacion from ca_operaciones_140389)


select am_operacion, am_concepto, am_cuota= sum(am_cuota)
into #amortizacion
from #operacion_140389es_comple,
     ca_amortizacion
where am_operacion =  op_operacion
and   am_concepto  = 'INT_ESPERA'
group by am_operacion , am_concepto


update #operacion_140389es_comple set
int_amortizacion = am_cuota
from #amortizacion
where op_operacion = am_operacion


select *
from #operacion_140389es_comple
where int_amortizacion -de_int_dsp  > 1


drop table #operacion_140389
go

