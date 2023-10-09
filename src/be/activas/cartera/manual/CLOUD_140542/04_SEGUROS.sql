
--REESTRUTURACIONES 
--GRUPOS 12169,1968 ,11847,2880,4799
--12384  7618 7610 12400 12395

use cob_cartera 
go 

declare 
@w_banco         cuenta ,
@w_msg           varchar(255) ,
@w_operacion     int,
@w_error         int ,
@w_valor_seguro  money ,
@w_div_inicio    int,
@w_div_fin       int,
@w_dividendo     int,
@w_oficina       int, 
@w_moneda        int, 
@w_toperacion    catalogo,
@w_monto_cobrar  money ,
@w_fecha_proceso datetime 




select @w_valor_seguro = isnull(pa_money,48) from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'
select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso 


select 
operacion  = op_operacion,
banco      = op_banco ,
oficina    = op_oficina,
moneda     = op_moneda,
toperacion = op_toperacion
into #operaciones 
from ca_operacion 
where op_banco in ( 

'213450000698',
'213450000715',
'213450000756',
			 
'233510108308',
'233510108316',

'214790071571',
'214790071589',
			 
'214790071803',
'214790071811',
'214790071829',
'214790071837',
'214790071845',
'214790071878',
		 
'214800070705',
'214800070754',



'213270008443',	
'213270008450',	
'213270008468',	
'213270008476',	
'213270008484',	
'213270008491',	
'213270008500',	
'213270008518',	



'210860031843',	

'211380027733',	
'211380027741',	
'211380027758',	
'211380027766',	
'211380027774',	
'211380027782',	

'213100007722',	
'213100007730',	
'213100007748',	
'213100007755',	
'213100007763',	
'213100007771',	
'213100007789',	
'213100007796',	

'214810030624',	
'214810030632',	
'214810030640',	
'214810030657',	
'214810030665',	
'214810030673',	
'214810030681')


select @w_operacion = 0

while (1 = 1) begin  --while de las operaciones 



   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco 
   from #operaciones
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 
   
   select @w_div_inicio = di_dividendo
   from ca_dividendo
   where di_operacion = @w_operacion
   and di_estado = 1
   
   select @w_div_fin = max(di_dividendo)
   from ca_dividendo
   where di_operacion = @w_operacion
   
   select @w_dividendo = @w_div_inicio
   
   select @w_monto_cobrar = round(@w_valor_seguro/(@w_div_fin -@w_dividendo+1),2)
   
   
   
   
   while @w_dividendo <= @w_div_fin begin
		
      if (@w_dividendo = @w_div_fin) select @w_monto_cobrar = @w_valor_seguro - (@w_monto_cobrar * (@w_div_fin -@w_div_inicio))
      
      exec @w_error=sp_otros_cargos	
      @s_date           = @w_fecha_proceso,
      @s_user	 	    = 'segad_covid19',
      @s_term  		    = 'consola',
      @s_ofi	       	= @w_oficina,
      @i_banco      	= @w_banco,
      @i_moneda      	= @w_moneda,
      @i_operacion		= 'I',
      @i_toperacion	    = @w_toperacion,
      @i_desde_batch	= 'N',
      @i_en_linea		= 'N',
      @i_tipo_rubro	    = 'O',
      @i_concepto		= 'SEGAD',
      @i_monto		    = @w_monto_cobrar,
      @i_div_desde	    = @w_dividendo,
      @i_div_hasta	    = @w_dividendo,
      @i_generar_trn	= 'N',
      @i_comentario	    = 'Generado por reestructuracion SEGAD'
   
      select @w_dividendo = @w_dividendo +1
   
   end --fin del while de otros cargos 
   
   
 
   
  Siguiente:
   
   
end 


select am_operacion, am_concepto, sum(am_cuota) from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in('SEGAD')
group by am_operacion , am_concepto



drop table #operaciones
go 