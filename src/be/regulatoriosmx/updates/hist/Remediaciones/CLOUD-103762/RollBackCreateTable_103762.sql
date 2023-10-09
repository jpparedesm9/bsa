use cob_conta_super
go

print '*****  sb_equivalencia_cuentas'
if not object_id('sb_equivalencia_cuentas') is null
drop table sb_equivalencia_cuentas
go
