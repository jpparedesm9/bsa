
SELECT  'antes' , 
'ClienteId' = bc_id_cliente,
'NombreCliente' = substring(upper(isnull(p_p_apellido, '')) + ' ' + upper(isnull(p_s_apellido, ''))+' ' +
					upper(isnull(en_nombre, '')) +' ' + upper(isnull(p_s_nombre, '')),1,30), 
'NombreOtorgante' = bc_nombre_otorgante,
'TipoCuenta' = bc_tipo_cuenta,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'TipoContrato' = bc_tipo_contrato,
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta,
'FrecuenciaPago' = bc_frecuencia_pagos,
'Cr?ditoM?ximo' = bc_credito_maximo,
'SaldoActual' = bc_saldo_actual,
'FechaActualizacion' = bc_fecha_actualizacion
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN 
(
111301  
)
and bc_fecha_apertura_cuenta = '28092018'
and bc_credito_maximo = 8000
and bc_id_cliente = en_ente
order by en_ente
GO


update cob_credito..cr_buro_cuenta set 
	bc_credito_maximo = 30000
FROM cobis..cl_ente
WHERE bc_id_cliente IN 
(
111301 
)
and bc_fecha_apertura_cuenta = '28092018'
and bc_credito_maximo = 8000
and bc_id_cliente = en_ente
GO





SELECT 'despues', 
'ClienteId' = bc_id_cliente,
'NombreCliente' = substring(upper(isnull(p_p_apellido, '')) + ' ' + upper(isnull(p_s_apellido, ''))+' ' +
					upper(isnull(en_nombre, '')) +' ' + upper(isnull(p_s_nombre, '')),1,30), 
'NombreOtorgante' = bc_nombre_otorgante,
'TipoCuenta' = bc_tipo_cuenta,
'IndicadorTipoResponsabilidad' = bc_indicador_tipo_responsabilidad,
'TipoContrato' = bc_tipo_contrato,
'FechaAperturaCuenta' = bc_fecha_apertura_cuenta,
'FrecuenciaPago' = bc_frecuencia_pagos,
'Cr?ditoM?ximo' = bc_credito_maximo,
'SaldoActual' = bc_saldo_actual,
'FechaActualizacion' = bc_fecha_actualizacion
FROM cob_credito..cr_buro_cuenta, cobis..cl_ente
WHERE bc_id_cliente IN 
(
111301 
)
and bc_fecha_apertura_cuenta = '28092018'
and bc_credito_maximo = 8000
and bc_id_cliente = en_ente
order by en_ente
GO

