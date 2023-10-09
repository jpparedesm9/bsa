


use cob_cartera 
go 


update ca_operacion set op_oficina = 3345 where op_banco = '233450005522'
update ca_operacion set op_oficina = 3348 where op_banco = '233480011929'
update ca_operacion set op_oficina = 3348 where op_banco = '233480014742'

update ca_operacion set op_oficina = 3348 where op_banco = '233480007415'
update ca_operacion set op_oficina = 3348 where op_banco = '233480014122'
update ca_operacion set op_oficina = 3348 where op_banco = '233480015152'
update ca_operacion set op_oficina = 3351 where op_banco = '233510005272'

go


use cob_conta_super 
go 


update sb_dato_operacion  set do_oficina = 3345  where do_banco = '233450005522' and do_fecha >= '08/08/2018'
update sb_dato_operacion  set do_oficina = 3348  where do_banco = '233480011929' and do_fecha >= '08/08/2018'
update sb_dato_operacion  set do_oficina = 3348  where do_banco = '233480014742' and do_fecha >= '08/08/2018'


update sb_dato_operacion  set do_oficina = 3348  where do_banco = '233480007415' and do_fecha >= '08/08/2018'
update sb_dato_operacion  set do_oficina = 3348  where do_banco = '233480014122' and do_fecha >= '08/08/2018'
update sb_dato_operacion  set do_oficina = 3348  where do_banco = '233480015152' and do_fecha >= '08/08/2018'
update sb_dato_operacion  set do_oficina = 3351  where do_banco = '233510005272' and do_fecha >= '08/08/2018'


go

