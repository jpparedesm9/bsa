------------------------------------------
----- REMEDIACION CUENTAS CONTABLES ------
----- REQUERIMIENTO : 114104 -------------
use cob_conta
go


update cb_relparam
set re_clave = replace(re_clave, 'INTERCICLO', 'INDIVIDUAL')
where re_clave like '%INTERCICLO%'

go
