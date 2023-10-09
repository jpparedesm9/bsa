-----------------------
--PARTE 1 CASO 116214
-----------------------
SELECT 'CASO 116214 ANTES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
102235,
102259,
102536,
102537,
104476,
106367
)
and bc_fecha_apertura_cuenta = '18122018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go

update cob_credito..cr_buro_cuenta
set bc_frecuencia_pagos = 'W'
WHERE bc_id_cliente IN (
102235,
102259,
102536,
102537,
104476,
106367
)
and bc_fecha_apertura_cuenta = '18122018'

SELECT 'CASO 116214 DESPUES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
102235,
102259,
102536,
102537,
104476,
106367
)
and bc_fecha_apertura_cuenta = '18122018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go

----------------------
--PARTE 2 CASO 116175
----------------------
SELECT 'CASO 116175 ANTES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
107105,
107164,
107192,
107206,
107221,
107317,
107326,
107359,
107373,
107669
)
and bc_fecha_apertura_cuenta = '21122018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go

UPDATE cob_credito..cr_buro_cuenta
set bc_indicador_tipo_responsabilidad = 'I'
WHERE bc_id_cliente IN (
107105,
107164,
107192,
107206,
107221,
107317,
107326,
107359,
107373,
107669
)
and bc_fecha_apertura_cuenta = '21122018'

SELECT 'CASO 116175 DESPUES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
107105,
107164,
107192,
107206,
107221,
107317,
107326,
107359,
107373,
107669
)
and bc_fecha_apertura_cuenta = '21122018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go


----------------------
--PARTE 3 CASO 116219
----------------------
SELECT 'CASO 116219 ANTES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'TipoContrato' = bc_tipo_contrato,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
103787,
103796,
103807,
103812,
104682,
106224
)
and bc_fecha_apertura_cuenta = '28112018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go


UPDATE cob_credito..cr_buro_cuenta
SET bc_indicador_tipo_responsabilidad = 'I',
    bc_tipo_contrato = 'PL'
WHERE bc_id_cliente IN (
103787,
103796,
103807,
103812,
104682,
106224
)
and bc_fecha_apertura_cuenta = '28112018'


SELECT 'CASO 116219 DESPUES'
SELECT distinct 
'ClienteId' = bc_id_cliente,
'FrecuenciaPago' = bc_frecuencia_pagos,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'TipoContrato' = bc_tipo_contrato,
'NombreCliente' = substring(upper(isnull(p_p_apellido, ' ')) + ' ' + upper(isnull(p_s_apellido, ' '))+' ' +
upper(isnull(en_nombre, ' ')) +' ' + upper(isnull(p_s_nombre, ' ')), 1, 30), 
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta 
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN (
103787,
103796,
103807,
103812,
104682,
106224
)
and bc_fecha_apertura_cuenta = '28112018'
and bc_id_cliente = en_ente
order by bc_id_cliente,bc_fecha_apertura_cuenta 
go

