use cob_conta_super
go

update sb_equivalencia_cuentas set
sb_cod_estado_altair = '03'
where sb_cuenta_cobis in ('136190010101', '136190010201', '136190030101')