
--REESTRUTURACIONES 
--GRUPOS 12169,1968 ,11847,2880,4799
--12384  7618 7610 12400 12395

use cob_cartera 
go 

declare 
@w_banco cuenta ,
@w_msg   varchar(255) ,
@w_operacion int,
@w_error  int 



select 
operacion = op_operacion,
banco     = op_banco 
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

while (1 = 1) begin 



   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco 
   from #operaciones
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 




   exec  @w_error = cob_cartera..sp_reestructuracion_covid19
   @i_banco                  = @w_banco,
   @i_cuotas_adicionales     = 8,
   @o_msg                    = @w_msg out 
   
   if @w_error <> 0 begin 
      select 'error', @w_error, 'banco',@w_banco
      goto Siguiente 
   end 
   
   Siguiente:
   
   
end 



--PUNTO DE CONTROL 


select tr_tran, tr_banco, tr_estado,tr_secuencial,* from ca_transaccion 
where tr_banco 
in ( select banco from #operaciones)
and tr_tran = 'RES'


select di_operacion , count(di_dividendo) 
from ca_dividendo 
where di_operacion  in ( select operacion from #operaciones)
group by di_operacion 

select am_operacion, am_concepto, sum(am_cuota) from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA','IVA_ESPERA','SEGAD')
group by am_operacion , am_concepto

select operacion = am_operacion , cuota = sum(am_cuota) into #verificaciones from ca_amortizacion 
where am_operacion in ( select operacion from #operaciones)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto


select operacion, cuota, de_int_dsp from 
#verificaciones , ca_desplazamiento 
where de_operacion = operacion
and de_estado = 'A'

drop table #operaciones
drop table #verificaciones
go