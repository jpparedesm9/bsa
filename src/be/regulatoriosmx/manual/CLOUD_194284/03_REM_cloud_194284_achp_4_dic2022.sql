
declare @w_fecha_ini datetime, @w_fecha_fin datetime
select @w_fecha_ini = '12/01/2022'
select @w_fecha_fin = '12/30/2022'

select 'Hora_Ini' = getdate()
/****** DIA DE PAGO  ******/--minutos
select 
banco       = do_banco , 
operacion   = do_operacion,
vencimiento = min(di_fecha_ven), 
toperacion  = do_tipo_operacion,
per_cuotas  =  (op_periodo_int ) * (select td_factor from cob_cartera..ca_tdividendo where td_tdividendo = op_tdividendo)
into #act_dia_pago_dic
from cob_conta_super..sb_dato_operacion, cob_cartera..ca_operacion, cob_cartera..ca_dividendo with (nolock)
where do_fecha between @w_fecha_ini and @w_fecha_fin
and do_operacion = di_operacion
and di_operacion = op_operacion
group by do_banco, do_operacion, do_tipo_operacion, op_periodo_int, op_tdividendo

select 'num_reg_a_act' = count(1) from #act_dia_pago_dic

update cob_conta_super..sb_dato_operacion
set do_dia_pago = case when toperacion = 'REVOLVENTE' and per_cuotas%7 = 0 
                                then 'MARTES' 
                                else (case upper(datename(weekday, vencimiento)) 
                                      when 'MONDAY'     then 'LUNES'  
                                      when 'TUESDAY'    then 'MARTES' 
                                      when 'WEDNESDAY'  then 'MIERCOLES' 
                                      when 'THURSDAY'   then 'JUEVES' 
                                      when 'FRIDAY'     then 'VIERNES' 
                                      when 'SATURDAY'   then 'SABADO'     
                                else 'DOMINGO'   end) end 
from #act_dia_pago_dic
where do_fecha between @w_fecha_ini and @w_fecha_fin
and operacion   = do_operacion

drop table #act_dia_pago_dic
print 'fin para fecha: Ini: ' + convert(varchar, @w_fecha_ini) + '-->>Fin: '+ convert(varchar, @w_fecha_fin)
select 'Hora_Fin' = getdate()
go
