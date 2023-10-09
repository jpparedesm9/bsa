use cob_cartera
go

select 'ANTES '
select  tr_fecha_mov, tr_banco,tr_secuencial, tr_tran, tr_estado        
from cob_cartera..ca_transaccion 
where tr_estado = 'ING'

update cob_cartera..ca_transaccion 
set   tr_fecha_mov = convert(datetime,convert(varchar(2),datepart(mm,tr_fecha_mov)) + '/' + convert(varchar(2),datepart(dd,tr_fecha_mov)) + '/' +  convert(varchar(4),datepart(yyyy,tr_fecha_mov)))
where tr_estado = 'ING'


update cob_cartera..ca_transaccion 
set   tr_fecha_mov = '08/01/2018'
where tr_estado    = 'ING'
and   tr_fecha_mov <= '07/31/2018'
and   tr_tran      = 'RPA'


select 'DESPUES '
select  tr_fecha_mov, tr_banco,tr_secuencial, tr_tran, tr_estado        
from cob_cartera..ca_transaccion 
where tr_estado = 'ING'

go