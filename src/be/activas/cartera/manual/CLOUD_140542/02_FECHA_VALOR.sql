use cob_cartera
go


--FECHAS VALOR MASIVO
--GRUPOS 12169,1968 ,11847,2880,4799
--12384  7618 7610 12400 12395


declare 
@w_operacion           int = 0,
@w_cliente             int,
@w_num_div             int,
@w_monto_int_desp      money,
@w_int_espera          varchar(15),
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_moneda              int,
@w_oficina             int,
@w_toperacion          varchar(10),
@w_error               int,
@w_cuotas_a_desplazar  int,
@w_fecha_desp          datetime,
@w_fecha_ini           datetime,
@w_secuencial_des      int,
@w_fecha_desembolso    datetime,
@w_fecha_res           datetime 

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso

select @w_fecha_res = '05/28/2020' --Fecha desde la cual las operaciones desplazadas tiene problemas 

select 
operacion    = op_operacion,
banco        = op_banco,
moneda       = op_moneda,
oficina      = op_oficina,
cliente      = op_cliente
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

while 1 = 1 begin

   select  top 1
   @w_operacion    = operacion,
   @w_banco        = banco,
   @w_moneda       = moneda,
   @w_oficina      = oficina,
   @w_cliente      = cliente
   from #operaciones 
   where operacion > @w_operacion
   order by operacion asc
   
   if @@rowcount = 0 break 
   
   
   ----Llevar operaciones a fecha de inicio   
   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = @w_oficina,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_res   ,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'            
       
   if @w_error <> 0 begin 
      select @w_error ,@w_banco
      goto Siguiente
  end 
   
   Siguiente:   
end




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



select op_fecha_ult_proceso, *
from cob_cartera..ca_operacion
where op_operacion in (select operacion from #operaciones )


drop table #operaciones



go
