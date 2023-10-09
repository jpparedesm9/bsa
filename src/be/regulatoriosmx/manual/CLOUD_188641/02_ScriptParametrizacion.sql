use cob_conta_super
go

select * from sb_equivalencias where eq_catalogo = 'FREC_PAGOS'

insert into sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
values ('FREC_PAGOS', '2W', 'K', 'Catorcenal', 'V')

select * from sb_equivalencias where eq_catalogo = 'FREC_PAGOS'