use cob_credito
go

update cr_cuenta_buc_santander_job  set
cbs_intentos = 0
where cbs_intentos = 1
and cbs_estado = 'I'

go