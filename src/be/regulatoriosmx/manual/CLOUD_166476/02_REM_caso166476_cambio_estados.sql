use cob_conta_super
go

update cob_conta_super..sb_ns_estado_cuenta
set nec_estado = 'P'
where nec_estado = 'D'
go

update cob_conta_super..sb_ns_estado_cuenta
set in_estado_pdf = 'P'
where in_estado_pdf = 'T'
go

update cob_conta_super..sb_ns_estado_cuenta
set in_estado_correo = 'P'
where in_estado_correo = 'T'

go
