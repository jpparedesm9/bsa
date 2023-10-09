

USE cob_conta
go

SELECT * FROM cb_relparam
WHERE re_producto=7
AND re_clave LIKE '%INTERCICLO%'


--16 REGISTROS
UPDATE cb_relparam
SET re_clave = '2.9.99.INDIVIDUAL'
WHERE re_producto = 7
AND re_clave      = '2.9.99.INTERCICLO'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.A1'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.A1'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.A2'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.A2'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.B1'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.B1'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.B2'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.B2'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.B3'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.B3'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.C1'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.C1'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.C2'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.C2'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.D'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.D'

--1 REGISTRO
UPDATE cb_relparam
SET re_clave = 'INDIVIDUAL.E'
WHERE re_producto = 7
AND re_clave      = 'INTERCICLO.E'


SELECT * FROM cb_relparam
WHERE re_producto = 7
AND re_clave LIKE '%INDIVIDUAL%'

GO




