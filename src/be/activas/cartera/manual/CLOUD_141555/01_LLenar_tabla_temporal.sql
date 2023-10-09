use cob_cartera
go


--Obetenr universo con dos desplazamientos
select de_operacion, desplazamiento = count(1)
into #dos_desplazamiento
from cob_cartera..ca_desplazamiento,
     cob_cartera..ca_operacion
where de_estado = 'A'
and   de_operacion = op_operacion
and   op_estado in (1,2)
group by de_operacion
having count(1)>1

--Dos diviendos afectado
select di_operacion, registros = count(1)
into #operaciones
from #dos_desplazamiento,
      cob_cartera..ca_dividendo
where de_operacion = di_operacion   
and    di_dias_cuota >20   
group by di_operacion
having count(1) > 1


--Obtener las fecha inicial y fecha final del desplazamiento

select operacion = tr_operacion, min_fecha_ref = min(tr_fecha_ref), max_fecha_ref = max(tr_fecha_ref)
into #operaciones_fecha_ref
from cob_cartera..ca_transaccion, #operaciones
where tr_operacion = di_operacion
and   tr_secuencial >0
and   tr_estado <> 'RV'
and   tr_tran     = 'DSP'
group by tr_operacion

-- elimiar registros con pagos realizados entre el primer desplazamiento y el ultimo desplazamiento
delete #operaciones_fecha_ref
from   cob_cartera..ca_transaccion
where operacion     = tr_operacion
and   tr_secuencial > 0 
and   tr_estado     <> 'RV'
and   tr_tran       = 'PAG'
and   tr_fecha_ref  > min_fecha_ref
and   tr_fecha_ref  <max_fecha_ref


-- Obtener los dividendos que ya fueron cancelados
select operacion_can = operacion, numero = count(1), dividendo_ini = min(di_dividendo), dividendo_fin= max(di_dividendo)
into #operaciones_div_can
from #operaciones_fecha_ref,
     cob_cartera..ca_dividendo
where operacion     = di_operacion
and   di_dias_cuota > 20
and   di_estado     = 3  
group by operacion
having count(1) >1


select count(1)
from #operaciones_div_can

--eliminar de la tabla los dividendos cancelados
delete #operaciones_fecha_ref
from #operaciones_div_can
where operacion = operacion_can


select operacion, banco = t.tr_banco, fecha_mov = t.tr_fecha_mov, fecha_ref = t.tr_fecha_ref, secuencial= t.tr_secuencial
into rev_operaciones_desplazamiento
from #operaciones_fecha_ref,
     cob_cartera..ca_transaccion t
where operacion     = tr_operacion
and   max_fecha_ref = tr_fecha_ref
and   tr_tran       = 'DSP'
and   tr_estado    <> 'RV'
and   tr_secuencial > 0


--drop table rev_operaciones_desplazamiento