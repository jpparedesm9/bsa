use cob_conta_super
go
update cob_conta_super..sb_ns_estado_cuenta
set nec_estado='P'
where nec_banco  in (
'224040030427',
'224040032308',
'210320014686',
'223790023895',
'224040032753',
'223810034493',
'233510063998',
'210530019227',
'223810030088',
'214790022889'
) 
go