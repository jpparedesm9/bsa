use cob_cartera
go

declare 
@w_fecha_corte datetime, 
@w_fecha_desembolso datetime,
@w_operacion int

select
operacion  = op_operacion,
banco      = op_banco,
tdividendo = op_tdividendo,
periodo    = op_periodo_int
into #prestamos
from ca_operacion
where op_toperacion = 'REVOLVENTE'

delete #prestamos
where operacion not in (select tr_operacion from ca_transaccion where tr_operacion = operacion and tr_tran = 'DES' and tr_estado <> 'RV')

select 
operacion  = di_operacion,
fecha_ven  = min(di_fecha_ven),
fecha_calc = convert(datetime, null),
cuotas     = count(1),
periodo    = convert(int, null),
tdividendo = convert(varchar(10), null),
fecha_des  = convert(datetime, null)
into #prestamos2
from cob_cartera..ca_dividendo, #prestamos
where operacion = di_operacion
group by di_operacion

update p2 set
p2.periodo    = p1.periodo,
p2.tdividendo = p1.tdividendo
from #prestamos2 p2, #prestamos p1
where p1.operacion = p2.operacion 


select @w_operacion = 0

while(1=1)
begin
   select top 1
   @w_operacion = operacion
   from #prestamos2
   where operacion > @w_operacion
   and cuotas = 1
   order by operacion

   if @@rowcount = 0 break


   select @w_fecha_desembolso = isnull(min(tr_fecha_ref), '01/01/1900')
   from ca_transaccion
   where tr_operacion = @w_operacion
   and tr_tran = 'DES'
   and tr_estado <> 'RV'
   
   if @w_fecha_desembolso <>  '01/01/1900' 
      exec sp_lcr_calc_corte @i_operacionca = @w_operacion, @i_fecha_proceso = @w_fecha_desembolso, @o_fecha_corte = @w_fecha_corte out
   else
      select @w_fecha_corte = '01/01/1900'

   update #prestamos2 set 
   fecha_calc = @w_fecha_corte,
   fecha_des  = @w_fecha_desembolso 
   where operacion = @w_operacion

end

select 'antes',op_operacion, op_fecha_pri_cuot
from ca_operacion, #prestamos2
where op_operacion = operacion

update ca_operacion
set op_fecha_pri_cuot = fecha_ven
from #prestamos2
where op_operacion = operacion
and cuotas >= 2

update ca_operacion
set op_fecha_pri_cuot = fecha_calc
from #prestamos2
where op_operacion = operacion
and cuotas = 1

select 'despues',op_operacion, op_fecha_pri_cuot
from ca_operacion, #prestamos2
where op_operacion = operacion

go

drop table #prestamos
drop table #prestamos2
go
