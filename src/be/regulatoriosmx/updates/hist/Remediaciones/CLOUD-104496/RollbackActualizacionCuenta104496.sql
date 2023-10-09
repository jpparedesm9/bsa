use cob_conta_super
go

select *
from sb_equivalencia_cuentas
where sb_cuenta_altair ='231107040101000'

update sb_equivalencia_cuentas
set sb_cuenta_altair= '2311-07-04-01-01-000'
where sb_cuenta_altair ='231107040101000'

select *
from sb_equivalencia_cuentas
where sb_cuenta_altair ='2311-07-04-01-01-000'

