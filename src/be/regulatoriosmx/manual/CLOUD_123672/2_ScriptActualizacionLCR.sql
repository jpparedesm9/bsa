use cob_cartera
go


select 
banco      = op_banco,
operacion  = op_operacion,
fecha_ini  = op_fecha_ini,
fecha_fin  = op_fecha_fin
into #operaciones_lcr 
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'

   
select 
fecha = dc_fecha, 
banco = dc_banco
into #operaciones_lcr_fecha
from cob_conta_super..sb_dato_cuota_pry,
#operaciones_lcr
where dc_banco = banco
group by dc_fecha, dc_banco


--drop table #operaciones_lcr_fecha
select top 1 * from #operaciones_lcr_fecha order by  banco, fecha


select *
from #operaciones_lcr_fecha,
cob_conta_super..sb_dato_cuota_pry
where dc_fecha  = fecha
and   dc_banco  = banco
and   banco     = '214790020692'
and   dc_fecha  = '02/28/2019'

select *
from #operaciones_lcr_fecha,
cob_conta_super..sb_dato_cuota_pry
where dc_fecha  = fecha
and   dc_banco  = banco
and   banco     = '214790020692'
and   dc_fecha  = '03/29/2019'


select 
fecha_proc = dc_fecha,
banco      = dc_banco,
cuota      = dc_num_cuota,
fecha_ini  = dc_fecha_ini,
fecha_fin  = dc_fecha_vto
into #comisiones_operaciones_lcr
from #operaciones_lcr_fecha,
cob_conta_super..sb_dato_cuota_pry
where dc_fecha  = fecha
and   dc_banco  = banco

select * from cob_conta_super..sb_dato_cuota_pry where dc_fecha =  '12/31/2018' and dc_banco = '233510036193'
select * from cob_conta_super..sb_dato_cuota_pry where dc_fecha =  '01/31/2019' and dc_banco = '233510036193'
select * from cob_conta_super..sb_dato_cuota_pry where dc_fecha =  '02/28/2019' and dc_banco = '233510036193'

--drop table #comisiones_operaciones_lcr


   
   select
   fecha_proc,  
   banco      = tr_banco,
   cuota      = cuota,
   comisiones =sum(case when  dtr_concepto in ('COM')      then  dtr_monto else 0 end ),
   iva_com    =sum(case when  dtr_concepto in ('IVA_COM')  then  dtr_monto else 0 end )
   into #comisiones 
   from cob_cartera..ca_transaccion,cob_cartera..ca_det_trn ,#comisiones_operaciones_lcr
   where tr_banco           = banco
   and   tr_tran            = 'DES' 
   and   dtr_concepto       in ('COM', 'IVA_COM')
   and   tr_operacion       =dtr_operacion 
   and   tr_secuencial     = dtr_secuencial
   and   tr_secuencial      >0 
   and   tr_estado         <> 'RV'
   and   ((tr_fecha_ref  >= fecha_ini and tr_fecha_ref < fecha_fin)) 
   and   tr_fecha_ref  <= fecha_proc
   group by fecha_proc, tr_banco, cuota
   
   
   select * from #comisiones  order by fecha_proc, cuota 
   
   update cob_conta_super..sb_dato_cuota_pry set
   dc_com_lcr    = comisiones,
   dc_ivacom_lcr = iva_com    
   from #comisiones
   where dc_fecha     = fecha_proc
   and dc_banco       = banco
   and dc_num_cuota   = cuota
   and   dc_aplicativo = 7 