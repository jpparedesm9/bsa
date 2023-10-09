--Remediacion caso 108578

cob_credito
GO

UPDATE cr_prelacion_cuenta
SET pc_nivel = 'N5'
WHERE pc_subproducto = '0025'
AND pc_producto = '01'

UPDATE cr_prelacion_cuenta
SET pc_nivel = 'N6'
WHERE pc_subproducto = '0056'
AND pc_producto = '01'

UPDATE cr_prelacion_cuenta
SET pc_nivel = 'N4'
WHERE pc_subproducto = '0060'
AND pc_producto = '10'

UPDATE cr_prelacion_cuenta
SET pc_nivel = 'N3'
WHERE pc_subproducto = '0060'
AND pc_producto = '17'

UPDATE cr_prelacion_cuenta
SET pc_nivel = 'N2'
WHERE pc_subproducto = '0055'
AND pc_producto = '01'

go

