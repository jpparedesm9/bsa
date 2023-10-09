use cob_cartera
go
DECLARE 
@w_fecha_proceso  DATETIME,
@w_error          INT,
@w_secuencial     INT,
@w_secuencial_des INT,
@w_secuencial_ing INT,
@w_banco          VARCHAR(32),
@w_grupo          INT,
@w_oficina        INT,
@w_ab_estado      VARCHAR(10),
@w_operacion      int,
@w_fecha_valor    datetime,
@w_secuencial_pago int

select @w_operacion   = 217305,
       @w_fecha_valor = '05/28/2019'

select @w_banco    = op_banco,
       @w_oficina  = op_oficina   
from cob_cartera..ca_operacion
where op_operacion = @w_operacion


select @w_secuencial_pago = tr_secuencial
from cob_cartera..ca_transaccion
where tr_operacion = 217305
and   tr_tran      = 'DES'
and   tr_fecha_ref = '05/28/2019'
and   tr_estado <> 'RV'
and   tr_secuencial > 0


select *
from cob_cartera..ca_transaccion
where tr_operacion = 217305
and   tr_tran      = 'DES'
and   tr_fecha_ref = '05/28/2019'
and   tr_estado   <> 'RV'
and   tr_secuencial > 0

select *
from cob_cartera..ca_desembolso
where dm_operacion = @w_operacion
and   dm_secuencial = @w_secuencial_pago


select  *
from cob_cartera..ca_santander_orden_deposito
where sod_banco       = @w_banco
and   sod_fecha_valor = '05/28/2019'
and   sod_tipo        = 'DES'

update cob_cartera..ca_santander_orden_deposito
set   sod_secuencial  = @w_secuencial_pago
where sod_banco       = @w_banco
and   sod_fecha_valor = '05/28/2019'
and   sod_tipo        = 'DES'


select  *
from cob_cartera..ca_santander_orden_deposito
where sod_banco       = @w_banco
and   sod_fecha_valor = '05/28/2019'
and   sod_tipo        = 'DES'