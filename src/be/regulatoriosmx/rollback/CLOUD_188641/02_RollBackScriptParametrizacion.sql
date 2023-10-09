use cob_conta_super
go

delete sb_equivalencias where eq_catalogo = 'FREC_PAGOS' and eq_valor_cat= '2W'

select * from sb_equivalencias where eq_catalogo = 'FREC_PAGOS'