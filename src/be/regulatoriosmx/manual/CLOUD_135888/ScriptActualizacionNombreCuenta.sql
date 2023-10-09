use cob_conta
go


select *
from cob_conta..cb_cuenta
where cu_cuenta  in ('64920305')

update cob_conta..cb_cuenta set
cu_nombre = 'APORT ANTBSM'
where cu_cuenta  = '64920305'

select *
from cob_conta..cb_cuenta
where cu_cuenta  in ('64920305')

select *
from cob_conta..cb_cuenta
where cu_cuenta  in ('2401100804')

update cob_conta..cb_cuenta set
cu_nombre = 'APORT ANTBSM'
where cu_cuenta  = '2401100804'

select *
from cob_conta..cb_cuenta
where cu_cuenta  in ('2401100804')
