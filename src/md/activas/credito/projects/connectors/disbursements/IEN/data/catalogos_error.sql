USE cobis
GO

SET NOCOUNT ON
GO

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall')
  and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
where cl_tabla.tabla in ('cr_resultado_cobro', 'cr_resultado_desembolso_format', 'cr_resultado_desembolso_detall')
go

PRINT 'cr_resultado_cobro'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_cobro', 'Resultado de proceso de Cobro')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '00', 'EXITOSO-COBRADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'CUENTA INEXISTENTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'CUENTA BLOQUEADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'CUENTA CANCELADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '04', 'CUENTA CON INSUFICIENCIA DE FONDOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '05', 'CUENTA EN OTRA DIVISA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '06', 'CUENTA NO PERTENECE AL BANCO RECEPTOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '07', 'TRANSACCIÓN DUPLICADA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'POR ORDEN DEL CLIENTE: ORDEN DE NO PAGAR A ESE EMISOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '09', 'POR ORDEN DEL CLIENTE: IMPORTE MAYOR AL AUTORIZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '10', 'POR ORDEN DEL CLIENTE: CANCELACIÓN DEL SERVICIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '11', 'CLIENTE NO TIENE AUTORIZADO EL SERVICIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', 'VENCIMIENTO DE LA ORDEN DE PAGO EN VENTANILLA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '13', 'CLIENTE DESCONOCE EL CARGO', 'V')
GO


PRINT 'cr_resultado_desembolso_formato'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_desembolso_format', 'Resultado de formato de archivo de Desembolso')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '00', 'FORMATO VALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '01', 'ERROR AL IDENTIFICAR FORMATO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '31', 'FORMATO DE FECHA DE TRANSFERENCIA INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '41', 'FORMATO INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '47', 'SE ENCONTRÓ DOBLE ENCABEZADO SIN UN SUMARIO PREVIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '52', 'FORMATO DE FECHA DE PRESENTACIÓN INICIAL INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '54', 'SE ENCONTRO DETALLE SIN ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '55', 'SE ENCONTRO SUMARIO SIN ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '91', 'FALLÓ OBLIGATORIEDAD EN UN CAMPO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '97', 'LONGITUD DEL REGISTRO INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '98', 'TIPO DE REGISTRO INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99', 'CUENTA CORRECTA, EN PROCESO DE ACTIVACIÓN', 'V')
GO


PRINT 'cr_resultado_desembolso_detalle'
DECLARE @w_tabla SMALLINT
SELECT @w_tabla = MAX(codigo) + 1 FROM cl_tabla
INSERT INTO cobis..cl_tabla VALUES (@w_tabla, 'cr_resultado_desembolso_detall', 'Resultado de detalle de archivo de Desembolso')
INSERT INTO cl_catalogo_pro VALUES ('CRE', @w_tabla)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '02', 'ERROR EN DATOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '03', 'SERVICIO NO AUTORIZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '08', 'REINTENTOS CONSUMIDOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '15', 'FECHA DE PRESENTACION INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '16', 'HORARIO DE PRESENTACIÓN INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '22', 'NUMERO DE SECUENCIA INCORRECTA EN EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '23', 'SENTIDO INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '24', 'NÚMERO DE SECUENCIA INCORRECTA EN EL SUMARIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '25', 'TOTAL DE OPERACIONES INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '26', 'IMPORTE TOTAL DE OPERACIONES INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '27', 'CODIGO DE OPERACIÓN INVALIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '29', 'NÚMERO DE SECUENCIA EN EL DETALLE INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '32', 'FECHA DE TRANSFERENCIA NO PERMITIDA (DÍA INHÁBIL)', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '35', 'BANCO ORIGEN NO ES SANTANDER', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '36', 'BANCO RECEPTOR CON FORMATO INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '37', 'IMPORTE INVALIDO, DEBE SER MAYOR A CERO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '38', 'BANCO RECEPTOR NO ESTA EN CATALOGO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '40', 'TIPO DE CUENTA DEL ORDENANTE INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '41', 'FORMATO DE FECHA DE APLICACIÓN INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '42', 'FORMATO INVALIDO DEL CAMPO NUMERO DE CUENTA ORDENANTE', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '43', 'MODALIDAD INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '44', 'NUMERO DE BLOQUE ENCABEZADO ES DISTINTO AL SUMARIO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '45', 'TIPO DE CUENTA DEL RECEPTOR INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '46', 'FORMATO INVALIDO DEL CAMPO NUMERO DE CUENTA RECEPTOR', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '51', 'MOTIVO DE DEVOLUCIÓN INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '56', 'CAMPO DE RECHAZO DE BLOQUE NO ES CERO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '63', 'FECHA DE TRANSFERENCIA MAYOR A LA FECHA DE APLICACIÓN', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '64', 'FECHA DE TRANSFERENCIA MENOR A LA FECHA DE PROCESO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '68', 'FECHA DE APLICACIÓN NO PERMITIDA (DÍA INHÁBIL)', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '69', 'DIVISA NO PERMITIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '71', 'FECHA DE PRESENTACIÓN INICIAL DIFERENTE A FECHA DE PRESENTACIÓN', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '74', 'NOMBRE DEL ORDENANTE INVÁLIDO, CONTIENE ESPACIOS', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '79', 'REFERENCIA DEL SERVICIO EMISOR INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '80', 'NOMBRE DEL TITULAR DEL SERVICIO INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '81', 'FORMATO INVALIDO DEL CAMPO IMPORTE IVA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '83', 'CÓDIGO DE OPERACIÓN DEL SUMARIO INCONSISTENTE CON EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '85', 'TIPO DE OPERACIÓN INVÁLIDO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '86', 'PRODUCTO SIN EMAIL A BENEFICIARIOS ACTIVADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '88', 'PEND CONFIRMACION OTRO BANCO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '90', 'CÓDIGO DE DIVISA INCONSISTENTE CON EL ENCABEZADO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '93', 'FORMATO EMAIL INCORRECTO', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '98', 'REFERENCIA DEL CLIENTE INVALIDA', 'V')
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '99', 'CUENTA BENEFICIARIA DADA DE ALTA O YA EXISTENTE', 'V')


update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

SET NOCOUNT OFF
GO
