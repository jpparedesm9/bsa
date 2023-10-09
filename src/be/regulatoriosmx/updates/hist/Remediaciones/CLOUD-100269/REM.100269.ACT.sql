

/*Remediacion caso #100269 */
use cob_cartera 
go 
--ca_operacion
select 'ANTES',op_estado, * from ca_operacion where op_operacion in ( 1367,1370,1373,1376,1379,1382,1385,1388)
go

update ca_operacion
set op_estado = 3 
where op_operacion in ( 1367,1370,1373,1376,1379,1382,1385,1388)
go

select 'DESPUES', op_estado, * from ca_operacion where op_operacion in ( 1367,1370,1373,1376,1379,1382,1385,1388)
go


select  * into #trn_prv 
from  ca_transaccion_prv
where tp_fecha_mov = '05/24/2018'
and tp_operacion in ( select dc_operacion from ca_det_ciclo where dc_grupo = 29) 
go

update #trn_prv
set tp_monto       = tp_monto*-1,
    tp_estado      = 'ING',
	tp_comprobante = 0
go	
	
	
select 'ANTES',* from ca_transaccion_prv 
where tp_fecha_mov = '05/24/2018'
and tp_operacion in ( select dc_operacion from ca_det_ciclo where dc_grupo = 29) 


insert into ca_transaccion_prv
select * from #trn_prv
go

select 'DESPUES',* from ca_transaccion_prv 
where tp_fecha_mov = '05/24/2018'
and tp_operacion in ( select dc_operacion from ca_det_ciclo where dc_grupo = 29) 
go


drop table #trn_prv 
go