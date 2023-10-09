select *
from cob_credito..cr_buro_cuenta
where bc_id_cliente in (100951, 101645, 101659, 101807, 103752, 109824)
and bc_fecha_apertura_cuenta = '07062018'

update cob_credito..cr_buro_cuenta
set bc_frecuencia_pagos = 'M'
where bc_id_cliente in (100951, 101645, 101659, 101807, 103752, 109824)
and bc_fecha_apertura_cuenta = '07062018'

select *
from cob_credito..cr_buro_cuenta
where bc_id_cliente in (100951, 101645, 101659, 101807, 103752, 109824)
and bc_fecha_apertura_cuenta = '07062018'