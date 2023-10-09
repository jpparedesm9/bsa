
---------------------------------------------------------------------
--remediacion II fase
use cob_cartera 
go 

--remediacion para contabilizar nuevamente 

update ca_transaccion set tr_estado = 'ING',tr_fecha_mov='05/02/2018' where tr_operacion = 199 and tr_secuencial = 5   --cliente 60
update ca_transaccion set tr_estado = 'ING',tr_fecha_mov='05/02/2018' where tr_operacion = 208 and tr_secuencial = 5   --cliente 66
update ca_transaccion set tr_estado = 'ING',tr_fecha_mov='05/02/2018' where tr_operacion = 211 and tr_secuencial = 5   --cliente 80
update ca_transaccion set tr_estado = 'ING',tr_fecha_mov='05/02/2018' where tr_operacion = 214 and tr_secuencial = 5   --cliente 110
update ca_transaccion set tr_estado = 'ING',tr_fecha_mov='05/02/2018' where tr_operacion = 220 and tr_secuencial = 5   --cliente 123


--remediacion por transacciones de vencimientos incorrectas
---GRUPO 29

select * into #trn   from ca_transaccion where 1= 2 
select * into #det   from ca_det_trn     where 1= 2 


insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1367
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1370
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1373
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1376
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1379
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1382
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1385
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1388


insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1367
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1370
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1373
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1376
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1379
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1382
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1385
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1388




---GRUPO 31

insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1343
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1346
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1349
insert into #trn select * from ca_transaccion where tr_secuencial = 117 and tr_operacion = 1352
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1355
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1358
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1361
insert into #trn select * from ca_transaccion where tr_secuencial = 115 and tr_operacion = 1364


insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1343
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1346
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1349
insert into #det select * from ca_det_trn where dtr_secuencial = 117 and dtr_operacion = 1352
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1355
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1358
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1361
insert into #det select * from ca_det_trn where dtr_secuencial = 115 and dtr_operacion = 1364

--
update #trn set 
tr_estado      = 'ING',
tr_secuencial  = tr_secuencial*-1,
tr_fecha_mov   = '05/31/2018',
tr_usuario     = 'usrbatch',
tr_terminal    = 'consola'


update #det set 
dtr_secuencial = dtr_secuencial*-1

insert into ca_transaccion select * from #trn
insert into ca_det_trn     select * from #det


update ca_transaccion  set 
tr_estado = 'RV', 
tr_observacion = 'REVERSO POR CAMBIO DE ESTADO ERRONEO'
from ca_transaccion a, #trn b
where a.tr_operacion  = b.tr_operacion 
and   a.tr_secuencial = b.tr_secuencial*-1 

go

drop table #trn
drop table #det
go


update ca_transaccion 
set tr_ofi_usu = tr_ofi_oper
where tr_ofi_usu in (9001, 9002)
and tr_estado  = 'ING'
go 