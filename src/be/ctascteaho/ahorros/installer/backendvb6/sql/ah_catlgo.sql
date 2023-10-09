/************************************************************************/
/*      Archivo:            ah_catlgo.sql                                */
/*      Base de datos:      cob_ahorros                                 */
/*      Producto:           Cuentas de Ahorros                          */
/*      Disenado por:       Ignacio Yupa                                */
/*      Fecha de escritura: 09/Mayo/2016                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa realiza la creacion de catalogos                  */
/*      para el modulo de cuentas de ahorros                            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*    09/Mayo/2016      Ignacio Yupa    Migración a CEN                 */
/************************************************************************/
use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_capitalizacion', 'ah_trn_offline', 'ah_talonarios', 'ah_causa_nc_data',
                 'ah_causa_nd_data', 're_titularidad', 'ah_causa_nc', 'ah_causa_nd',
                 'ah_causa_nc_caja', 'ah_causa_nd_caja', 'ah_categoria', 'ah_estado_cta',
                 'ah_ciclo', 'ah_tpromedio', 'ah_tbloqueo', 'ah_causa_bloqueo_val',
                 'ah_causa_bloqueo_mov', 'ah_causa_cierre', 'ah_caulev_blqva', 'ah_causa_canje',
                 'ah_motivo_levbloq_mov', 'ah_tanula_lib', 'ah_tipocta', 'ah_cla_cliente',
                 'ah_cuota_navidad', 'ah_producto_funcionario', 'ah_estados_marcacion_gmf', 'ah_estados_desmarcacion_gmf',
                 'ah_cau_nc_gmf_ba', 'ah_canal_relcta', 'ah_prodbanc_blq', 're_canal_enroll',
                 're_canal_act', 're_id_enroll', 'ws_tran_canales', 'pe_comision_td',
                 'pe_lt_origen', 'pe_lt_especie', 'pe_tx_topes_oficina', 'ah_titularidad',
                 're_equivalencias', 're_eq_tabla','cc_tipo_solicitud','cl_direccion_ec')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ah_capitalizacion', 'ah_trn_offline', 'ah_talonarios', 'ah_causa_nc_data',
                 'ah_causa_nd_data', 're_titularidad', 'ah_causa_nc', 'ah_causa_nd',
                 'ah_causa_nc_caja', 'ah_causa_nd_caja', 'ah_categoria', 'ah_estado_cta',
                 'ah_ciclo', 'ah_tpromedio', 'ah_tbloqueo', 'ah_causa_bloqueo_val',
                 'ah_causa_bloqueo_mov', 'ah_causa_cierre', 'ah_caulev_blqva', 'ah_causa_canje',
                 'ah_motivo_levbloq_mov', 'ah_tanula_lib', 'ah_tipocta', 'ah_cla_cliente',
                 'ah_cuota_navidad', 'ah_producto_funcionario', 'ah_estados_marcacion_gmf', 'ah_estados_desmarcacion_gmf',
                 'ah_cau_nc_gmf_ba', 'ah_canal_relcta', 'ah_prodbanc_blq', 're_canal_enroll',
                 're_canal_act', 're_id_enroll', 'ws_tran_canales', 'pe_comision_td',
                 'pe_lt_origen', 'pe_lt_especie', 'pe_tx_topes_oficina', 'ah_titularidad',
                 're_equivalencias', 're_eq_tabla','cc_tipo_solicitud','cl_direccion_ec')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('ah_capitalizacion', 'ah_trn_offline', 'ah_talonarios', 'ah_causa_nc_data',
                 'ah_causa_nd_data', 're_titularidad', 'ah_causa_nc', 'ah_causa_nd',
                 'ah_causa_nc_caja', 'ah_causa_nd_caja', 'ah_categoria', 'ah_estado_cta',
                 'ah_ciclo', 'ah_tpromedio', 'ah_tbloqueo', 'ah_causa_bloqueo_val',
                 'ah_causa_bloqueo_mov', 'ah_causa_cierre', 'ah_caulev_blqva', 'ah_causa_canje',
                 'ah_motivo_levbloq_mov', 'ah_tanula_lib', 'ah_tipocta', 'ah_cla_cliente',
                 'ah_cuota_navidad', 'ah_producto_funcionario', 'ah_estados_marcacion_gmf', 'ah_estados_desmarcacion_gmf',
                 'ah_cau_nc_gmf_ba', 'ah_canal_relcta', 'ah_prodbanc_blq', 're_canal_enroll',
                 're_canal_act', 're_id_enroll', 'ws_tran_canales', 'pe_comision_td',
                 'pe_lt_origen', 'pe_lt_especie', 'pe_tx_topes_oficina', 'ah_titularidad',
                 're_equivalencias', 're_eq_tabla','cc_tipo_solicitud','cl_direccion_ec')
go

declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'

select @w_codigo= @w_codigo + 1
print 'Tipo de Solicitud'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_direccion_ec', 'Direccion para estado de cuenta')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C', 'ENVIAR A CASILLA POSTAL DEL CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'D', 'DIRECCION DE CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'R', 'RETENER EN SUCURSAL DEL BANCO', 'V')

select @w_codigo = @w_codigo + 1
print 'Periodo de Capitalizacion'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_capitalizacion', 'Periodo de Capitalizacion')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'D', 'DIARIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'M', 'MENSUAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'T', 'TRIMESTRAL', 'V')

select @w_codigo = @w_codigo + 1
print 'Tipo de Solicitud'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cc_tipo_solicitud', 'Tipo de Solicitud')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'AP', 'APROBADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'NE', 'NEGADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'PR', 'ABIERTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'SO', 'SOLICITADA', 'V')

select @w_codigo = @w_codigo + 1
print 'TRANSACCIONES AHO SOPORTADAS FUERA DE LINEA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_trn_offline', 'TRANSACCIONES AHO SOPORTADAS FUERA DE LINEA')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '211', 'BLOQUEO DE MOVIMIENTOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '212', 'LEVANTAMIENTO BLQS MOVIMIENTOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '217', 'BLOQUEO DE VALORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '218', 'LEVANTAMIENTO BLQS VALORES', 'V')

select @w_codigo = @w_codigo + 1
print 'Numero de talonarios'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_talonarios', 'Numero de talonarios')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'TALONARIO VEINTICINCO CUPONES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'TALONARIO DE AHORROS DE VEINTE CUPONES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'TALONARIO AHORROS DE VEINTICINCO CUPONES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'TALONARIOS RIESGONACION', 'V')

select @w_codigo = @w_codigo + 1
print 'Causas NC ahorros DATA ENTRY'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nc_data', 'Causas NC ahorros DATA ENTRY')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '212', 'REINTEGRO COMISION TRASLADO SEBRA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '427', 'REVERSO COMISIONES TARJETA DEBITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '440', 'ABONO POR PAGO DE CONVENIOS', 'V')

select @w_codigo = @w_codigo + 1
print 'Causas ND ahorros DATA ENTRY'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nd_data', 'Causas ND ahorros DATA ENTRY')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '413', 'ND REV NC DEVOL GIROS CONVENIOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '472', 'CARGO REINTEGRO DOBLE VEZ CONVENIO', 'V')

select @w_codigo = @w_codigo + 1
print 'Titularidad '
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_titularidad', 'Titularidad ')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'I', 'INDIVIDUAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'M', 'CONJUNTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'S', 'ALTERNA', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa de Nota de Credito AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nc', 'Causa de Nota de Credito AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'CIERRE DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100', 'CREDITO ORIGINADO POR EMPRESA ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '101', 'CREDITO ORIGINADO POR CIASA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '102', 'TRANSFERENCIA ENTRE CUENTAS BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '103', 'TRANSFERENCIA ENTRE CUENTAS BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '104', 'TRANSFERENCIA ENTRE CUENTAS ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '105', 'ADELANTO DE EFECTIVO TARJETA DE CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '106', 'TRANSFERENCIA LOCAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '107', 'DEVOLUCION GMF', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '108', 'DEVOLUCION RETENCION EN LA FUENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '109', 'CAMPAÑA AHORROS EMPLEADOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'TRANSFERENCIA EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '110', 'TRANSFERENCIA DE CUENTAS OTROS BANCOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '111', 'ABONO COMISION LIQUIDADA PARA CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '112', 'NOTA CREDITO DEVOLUCION CUOTA DE MANEJO TD', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '113', 'NOTA CREDITO DEVOLUCION GMF', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '114', 'NOTA CREDITO DEVOLUCION SOBRANTE PAGOS CLIENTES', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '115', 'NOTA CREDITO PAGO INCENTIVO AL MICROCREDITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '116', 'NOTA CREDITO AJUSTE TRANSACCION ATM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '117', 'NOTA CREDITO AJUSTE TRANSACCION POS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '118', 'NOTA CREDITO AJUSTE COMISION ATM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'CANCELACION  DEPOSITOS PLAZO FIJO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'TRANSFERENCIA CLIENTE ALIADO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'ABONO DE CONVENIOS EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'REVERSA COMISION TRANSACCION RETIRO Y POS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'REVERSA TRANSACCION RETIRO Y POS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '163', 'N/C AJUSTE PAGO OBLIGACION BM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '164', 'N/C AJUSTE RECARGA BM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'TRANSFERENCIA DE SALDOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '170', 'NC Ajuste 50 RBM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '171', 'NC Ajuste 56 RBM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'N/C PLANILLA EMPRESARIAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'ABONO NOMINA EMPLEADOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'REINTEGRO DE GMF', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '200', 'CORRECCION DE DEPOSITOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '201', 'N/C DPTO COMERCIO EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '202', 'DEPTO SIDAC', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '203', 'DEPTO CONTABILIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '204', 'TRANSFERENCIA AL EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'PAGO A PROVEEDORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '206', 'DEPTO DEPOSITO A PLAZO FIJO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '207', 'REVERSA CARGO COPIAS ESTADO DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '208', 'CONFIRMACION DE SALDO PARA AUDITORES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '209', 'INVESTIGACIONES DE TRANSACCIONES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'DESEMBOLSO DE CREDITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '210', 'REVERSA ANUALIDAD DE CAJILLAS DE SEGURIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '211', 'ITBM CAJILLAS DE SEGURIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '212', 'VENTA DE BOLSAS NOCTURNAS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '213', 'REVERSA COMISION COPIA DE CHEQUES, SLIP DE RETIROS Y DEPOSITOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '214', 'DEPTO.TARJETA DEBITO CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '215', 'TRANSFERENCIA ACH BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '216', 'DEPTO. BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '217', 'CENTRO DE TARJETAS VISA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '218', 'ABONO MANUAL DE INTERESES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '219', 'DEPTO. TRANSITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'ABONO NOMINA SISTEMATIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '220', 'DEPTO. ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '221', 'REVERSA COMISION CHEQUE DEVUELTO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '222', 'REVERSA TRANSACCION RETIRO Y POS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '223', 'REVERSA COMISION TRANSACCION RETIRO Y POS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '224', 'DESEMBOLSO DE CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '225', 'REINTEGRO TRANSACCIONES ILICITAS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '226', 'TRANSFERENCIA DE SALDOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '227', 'DEPTO PRESTAMOS CONSUMO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '228', 'DEPTO PRESTAMOS CORPORATIVO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '229', 'AJUSTE POR ERROR EN NUMERO DE CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'ABONO PAGO DE VIATICOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '230', 'CENTRO DE TARJETAS CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '231', 'RECHAZO TRANSACCION ACH CB', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '232', 'ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '233', 'VENTA DE GIROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '234', 'VENTA DE CHEQUE DE GERENCIA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '235', 'REVERSA CARGO POR VENTA DE CHEQUES VIAJEROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '236', 'DEPTO TESORERIA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '237', 'CAMARA Y REMESAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '238', 'BCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '239', 'TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'ACH RED', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '240', 'REVERSA COMISION MENSUAL PROCESAMIENTO ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '241', 'PAGO PROVEEDORES BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '242', 'POR GIRO WESTERN UNION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '243', 'ANULACION COMPRA POS NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '244', 'ANULACION COMPRA POS INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '245', 'REINTEGRO POR AJUSTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '246', 'REINTEGRO GMF POR AJUSTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'REVERSO MEMBRESIA ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '260', 'AUMENTO CUPO TRANSACCION POR CANAL CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '261', 'AJUSTE NC CUENTA CUPO CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'REVERSA TRANSFERENCIA ACH BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '28', 'N/C REVERSO DEBITO DPTO COMERCIO EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '29', 'SIDAC', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'REVERSO DE APERTURA DEPOSITOS PLAZO FIJO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '31', 'REDENCION DE PUNTOS REFERIDOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '39', 'DEPOSITO A CUENTA POR CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'DEVOLUCION COMISION REMESAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40', 'PLANILLA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '41', 'DEVOLUCION DE MONTO DE PLANILLA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '42', 'REAPERTURA DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '43', 'REVERSA COMISION VENTA CHQ GERENCIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '44', 'REVERSA CARGO POR VENTA DE GIROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '45', 'VENTA DE CHEQUES DE VIAJERO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '46', 'TRANSFERENCIA LOCAL PENDIENTE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '47', 'ABONO INTERESES RECALCULADOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '48', 'REINTEGRO PAGO DE CARTERA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '49', '*** POR DEFINIR ENTREGA MONTO MIN INEMBARGABLE ***', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'ABONO PENSIONADOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'BENEFICIO MUJERES AHORRADORAS EN ACCCION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '51', 'NC REGISTRO DE CUPO CB ADMIN', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '52', 'NC AUMENTO DE CUPO CB ADMIN', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'CONFIRMACION CH REMESAS COB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'REVERSO POR COMPRA DE CHEQUE VIAJERO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'TRANSFERENCIA LOCAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '85', 'TRANSFERENCIA ENTRE CUENTAS DESDE BANCAMOVIL (CREDITO)', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '86', 'CREDITO POR RETIRO DESDE COMERCIO BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '87', 'CREDITO POR COMPRA DESDE COMERCIO BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '88', 'ANULACION DE COMPRA DESDE COMERCIO BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'SUSTITUCION DE DOCUMENTOS', 'E')

select @w_codigo = @w_codigo + 1
print 'Causa de Nota de Debito AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nd', 'Causa de Nota de Debito AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CARGO SOLICITUD ESTADO DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'COMISION GASTO CORRESPONSAL CHEQUE REMESA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100', 'COMISION TRANSACCIONES ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '101', 'DEBITO ORIGINADO POR EMPRESA ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '102', 'DEBITO ORIGINADO POR CIASA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '103', 'PAGO TARJETA DE CREDITO MASTER CARD ORIGINADO POR TELERED', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '104', 'PAGO PRESTAMO POR TELERED', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '105', 'COBRO MEMBRESIA ACH', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '106', 'TRANSFERENCIA ENTRE CUENTAS BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '107', 'PAGO TARJETA DE CREDITO VISA POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '108', 'PAGO LUZ POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '109', 'PAGO TELEFONIA FIJA POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'COMISION REFERENCIAS BANCARIAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '110', 'PAGO AGUA POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '111', 'PAGO TELEFONIA CELULAR POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '112', 'PAGO TELEVISION POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '113', 'PAGO A TERCEROS POR BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '114', 'COMISION CHEQUE DE GERENCIA BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '115', 'COMISION TRANSFERENCIA INTERNACIONAL B.EN L.', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '116', 'PAGO PRESTAMO POR BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '117', 'TRANSFERENCIA ACH BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '118', 'COMISION POR USO DE CANAL BANCA EN LINEA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '119', 'TRANSFERENCIA ENTRE CUENTAS BANCA X TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'COMISION CIERRE DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '120', 'PAGO TARJETA DE CREDITO MASTER CARD ORIGINADO POR TELERED', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '121', 'PAGO LUZ POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '122', 'PAGO TELEFONIA CELULAR POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '123', 'PAGO AGUA POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '124', 'PAGO TELEVISION POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '125', 'PAGO TELEVISION BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '126', 'PAGO A TERCEROS POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '127', 'COMISION POR USO DE CANAL BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '128', 'ACTUALIZACION CUENTA TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '129', 'ACTUALIZACION CCC TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'COMISION SOLICITUD EXTRACTO CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '130', 'ACTUALIZACION CUPOS DE RETIRO TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '131', 'EMISION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '132', 'EMISION TARJETA CLAVE INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '133', 'COBRO MEMBRESIA TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '134', 'REELABORACION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '135', 'REPOSICION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '136', 'PEPOSICION PIN TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '137', 'REPOSICION TARJETA CLAVE INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '138', 'REELABORACION TARJETA CLAVE INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '139', 'RETIRO ATM NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'TRANSFERENCIA DE SALDOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '140', 'RETIRO ATM INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '141', 'COMISION TRANSACCION ATM NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '142', 'COMISION TRANSACCION ATM INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '143', 'COMPRA POS NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '144', 'PREPAGO Y DONACIONES POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '145', 'PAGO LUZ POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '146', 'PAGO AGUA POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '147', 'PAGO TELEFONO POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '148', 'PAGO TARJETA CREDITO POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '149', 'PAGO PRESTAMOS POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'POR COMISION DEPOSITO SIN LIBRETA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '150', 'PAGO A TERCEROS POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '151', 'DEBITO AUTOMATICO PAGO TARJETA CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '152', 'COMISION CONSULTA SALDO BANCA MOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '153', 'COMISION MEMBRESIA A BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '154', 'COMISION POR REIMPRESION CONTRASE-A B. VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '155', 'PAGO TARJETA DE CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '156', 'COMISION POR PIN INVALIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '157', 'COMISION CONSULTA POS NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '158', 'COMISION CONSULTA POS INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '159', 'COMISION PERDIDA DETERIORO TARJ DEBITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'VENTA DE CHEQUE DE GERENCIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '160', 'COMISION RETIRO OFICINA TARJ DEBITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '161', 'COMISION FONDOS INSUFICIENTES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '162', 'COMISISON CONSULTA DE MOVIMIENTOS BANCA MOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '163', 'PAGO OBLIGACIONES BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '164', 'RECARGA CELULAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '165', 'AJUSTE TRANSACCION ATM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '166', 'AJUSTE TRANSACCION POS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '167', 'ND EXCEDE MONTO DIARIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '168', 'ND EXCEDE NUMERO DE USOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'TRANSFERENCIA AL EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '170', 'AJUSTE 51 DEBITO POR COMPENSACION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '171', 'AJUSTE 57 DEBITO POR COMPENSACION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'VENTA DE GIROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '180', 'PAGO DE CREDITO MASTER CARD POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '181', 'PAGO TELEFONIA FIJA POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '182', 'RETENCION EN LA FUENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '183', 'PORTES POR DEVOLUCION CHEQUE REMESA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '184', 'VENTA INSTRUMENTO SBA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '185', 'COMISION TRANSFERENCIA ENTRE CUENTAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'VENTA DE CHEQUES VIAJEROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CARGO RETENCION ESTADO DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'TRANSFERENCIA LOCAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '204', 'PAGO DE CHEQUES DE OVERSEAS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'CORRECCION DE DEPOSITOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '206', 'DEPTO SERVICIOS BANCARIOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '207', 'DEPTO SIDAC', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '208', 'N/D REVERSO CREDITO DEPTO COMERCIO EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '209', 'TRANSFERENCIA ENVIADA EXTEROR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'COMPRA DE CHEQUES VIAJEROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '210', 'APERTURA DE DEPOSITOS A PLAZO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '211', 'REVERSO DE CANCELACI-N', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '212', 'REVERSO DE PAGO DE INTERESES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '213', 'AUMENTO EN RENOVACION CDT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '214', 'REVERSION DEPOSITOS A PLAZO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '215', 'CARGO COPIAS ESTADO DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '216', 'CONFIRMACION DE SALDO PARA AUDITORES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '217', 'INVESTIGACIONES DE TRANSACCIONES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '218', 'ANUALIDAD DE CAJILLAS DE SEGURIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '219', 'ITBM CAJILLAS DE SEGURIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'TRANSFERENCIA LOCAL PENDIENTE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '220', 'VENTA DE BOLSAS NOCTURNAS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '221', 'COMISION COPIA DE CHEQUES, SLIP DE RETIROS Y DEPOSITOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '222', 'DEBITO TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '223', 'DEPTO BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '224', 'DEPTO BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '225', 'PAGO TARJETA DE CREDITO VISA POR BANCA POR TELEFONO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '226', 'PRESTAMOS CONSUMO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '227', 'PRESTAMOS CORPORATIVO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '228', 'COMISIONES PRESTAMOS CORPORATIVOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '229', 'DEPTO. TRANSITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'SUSTITUCION DE DOCUMENTOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '230', 'COMISION ACH BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '231', 'COMISION RETIRO ATM NACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '232', 'COMISION RETIRO ATM INTERNACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '233', 'COMISION CONSULTA ATM NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '234', 'COMISION CONSULTA ATM INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '236', 'AJUSTE POR ERROR EN CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '237', 'NOTA DEBITO PROVEEDORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '238', 'COMISION CUOTA DE MANEJO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'CONSTITUCION CDT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '240', 'DEPTO. COBROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '242', 'RECHAZO TRANSACCION ACH RED', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '244', 'COMISION ENVIO DEL CHEQUE AL COBRO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '245', 'CHEQUE PROPIO DEVUELTO ENTRANTE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '246', 'CHEQUE DEVUELTO EXTRANJERO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '247', 'PAGO PROVEEDORES BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '248', 'TRANSFERENCIAS A OTRAS CUENTAS OTROS BANCOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'CIERRE DE CUENTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'PAGO DE PRESTAMOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '260', 'DISMINUCION CUPO TRANSACCION POR CANAL CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '261', 'AJUSTE ND CUENTA CUPO CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'CARGO PORTES CHEQUES REMESAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '28', 'COMISION CHEQUES REMESAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '29', 'TRANSFERENCIA CLIENTE ALIADO DESEMBOLSO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CARGO ENVIO ESTADO DE CUENTA CORREO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'COMISION TRANSACCION NACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '31', 'COMISION RETIRO POR VENTANILLA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '32', 'GRAVAMEN MOVIMIENTO FINANCIERO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '33', 'IVA IMPUESTO A LAS VENTAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '34', 'REVERSO CANCELACION  DEPOSITOS PLAZO FIJO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '35', 'COMISION POR VENTA CHEQUE GERENCIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '36', 'COMISION TRANSFERENCIA MASIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '37', 'COMISION DE TRANSACCION POR CANAL CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '38', 'RETIRO DE CUENTA POR CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '39', 'COMISION COBRO RECARGA BANCA MOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CARGO CHEQUE DEVUELTO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '44', 'PAGO DE PRESTAMOS - PROCESO MASIVO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '46', 'COMISION NO USO DEL CANAL BANCA MOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'LIBERACION ANTICIPADA DE FONDOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'ND DISMINUCION DEL CUPO CB ADMIN', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '51', 'GASTOS LEGALES MINUTA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '52', 'GASTOS LEGALES ACTAS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '53', 'GASTOS LEGALES PAPEL SELLADO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '54', 'GASTOS LEGALES PAGOS A TERCEROS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '55', 'GASTOS LEGALES PAPEL NOTARIAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '56', 'GASTOS TIMBRES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '57', 'COMISION INACTIVIDAD', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '58', 'COMISION SALDO MINIMO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '59', 'N/D PLANILLA EMRPESARIAL BANCA VIRTUAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'COMISION CHEQUE PROPIO DEVUELTO ENTRANTE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '60', 'ACTUALIZACION CUENTA TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '61', 'ACTUALIZACION CCC TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '62', 'ACTUALIZACION CUPOS DE RETIRO TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '63', 'EMISION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '64', 'EMISION TARJETA CLAVE INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '65', 'COBRO MEMBRESIA TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '66', 'REELABORACION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '67', 'REPOSICION TARJETA CLAVE PERSONALIZADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '68', 'PEPOSICION PIN TARJETA CLAVE', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '69', 'REPOSICION CLAVE TARJETA INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'COMISION CHEQUE REMESA RECIBIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '70', 'REELABORACION TARJETA CLAVE INMEDIATA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '71', 'RETIRO ATM NACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '72', 'RETIRO ATM INTERNACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '73', 'COMISION TRANSACCION ATM NACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '74', 'COMISION TRANSACCION ATM INTERNACIONAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '75', 'COMPRA POS INTERNACIONAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '76', 'PREPAGO Y DONACIONES POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '77', 'PAGO LUZ POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '78', 'PAGO AGUA POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '79', 'PAGO TELEFONO POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'DIFERENCIA EN DEPOSITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '80', 'PAGO TARJETA CREDITO POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '81', 'PAGO PRESTAMOS POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '82', 'PAGO A TERCEROS POR ATM', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '83', 'DEBITO AUTOMATICO PAGO TARJETA CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '84', 'N/D DPTO COMERCIO EXTERIOR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '85', 'TRANSFERENCIA ENTRE CUENTAS DESDE BANCAMOVIL (DEBITO)', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '86', 'RETIRO DESDE COMERCIO BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '87', 'COMPRA DESDE COMERCIO BANCAMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '88', 'DEBITO POR ANULACION DE COMPRA DESDE COMERCIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'EMBARGO DE CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '90', 'COMISION TRANSACCIONES EJECUTADAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '91', 'RECALCULO DE INTERESES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '92', 'COMISION ESTADO DE CUENTA DE AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '93', 'REINTEGRO DESEMBOLSO CARTERA', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa de Nota de Credito AH para caja'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nc_caja', 'Causa de Nota de Credito AH para caja')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '107', 'DEVOLUCION GMF', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '109', 'CAMPAÑA AHORROS EMPLEADOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '200', 'CORRECCION DE DEPOSITOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'PAGO A PROVEEDORES', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '229', 'AJUSTE POR ERROR EN NUMERO DE CUENTA', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa de Nota de Debito AH para caja'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_nd_caja', 'Causa de Nota de Debito AH para caja')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'CORRECCION DE DEPOSITOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '236', 'AJUSTE POR ERROR EN NUMERO DE CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '237', 'NOTA DEBITO PROVEEDORES', 'E')

select @w_codigo = @w_codigo + 1
print 'Categoria de CAH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_categoria', 'Categoria de CAH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'N', 'NORMAL', 'V')

select @w_codigo = @w_codigo + 1
print 'Estado de Cuenta de Ahorros'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_estado_cta', 'Estado de Cuenta de Ahorros')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'A', 'ACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C', 'CANCELADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'G', 'INGRESADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'I', 'INACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'N', 'NO PERFECCIONADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'T', 'TRASLADADA-INACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'X', 'TRASLADADA-CANCELADA', 'V')

select @w_codigo = @w_codigo + 1
print 'Ciclo de la cuenta AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_ciclo', 'Ciclo de la cuenta AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', '10 DE CADA MES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', '20 DE CADA MES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', '30 DE CADA MES', 'V')

select @w_codigo = @w_codigo + 1
print 'Tipo de Promedio AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_tpromedio', 'Tipo de Promedio AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'M', 'MENSUAL', 'V')

select @w_codigo = @w_codigo + 1
print 'Tipo de Bloqueo AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_tbloqueo', 'Tipo de Bloqueo AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CONTRA DEPOSITO O CREDITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CONTRA RETIRO O DEBITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CONTRA CREDITO Y DEBITO', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa de Bloqueo  de Valores AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_bloqueo_val', 'Causa de Bloqueo  de Valores AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '0', 'MIGRACION', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'ENTIDAD JUDICIAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'PIGNORACION PRESTAMO PERSONAL', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'PIGNORACION PRESTAMO CORPORATIVO', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'DEPTO. COBROS', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'RESERVA PYME', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'RETENCION CONSUMO', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'DECISION DEL BANCO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'ORDEN AUTORIDAD COMPETENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'ORDEN SUPERINTENDENCIA DE BANCOS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CONGELAMIENTO DE FONDOS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'SOLICITUD DE CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'PIGNORACION DE FONDOS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'PIGNORACION LINEA DE CREDITO', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'PIGNORACION CARTA PROMESA DE PAGO/CARTA DE GARANTIA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'PIGNORACION CARTA DE CREDITO', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'PIGNORACION TARJETA CREDITO', 'C')

select @w_codigo = @w_codigo + 1
print 'Causa de Bloqueo  de Movimientos AH'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_bloqueo_mov', 'Causa de Bloqueo  de Movimientos AH')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '0', 'MIGRACION', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'PROBLEMAS EN LA CUENTA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'CLIENTE PERSONA JURIDICA CON FORMATO PRERUT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'SOLICITUD COMITE SARLAFT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CLIENTE FALLECIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'SECUESTRO/EMBARGO JUDICIAL', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'ENTIDAD JUDICIAL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'TARJETA EXTRAVIADA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'DECISION DEL BANCO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'CUENTA INACTIVA REPORTADA SUPERINTEDENCIA DE BANCOS', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'DECISION DEL CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'ORDEN AUTORIDAD COMPETENTE', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa Cierre AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_cierre', 'Causa Cierre AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'DECISION CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'POR PROCESO AUTOMATICO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'POR ORDEN DE AUTORIDAD COMPETENTE', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'SALDAR CUENTAS INACTIVAS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'INACTIVIDAD', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'MAL MANEJO', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'ENTIDAD JUDICIAL', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'CLIENTE FALLECIDO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'DECISION DEL BANCO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'POR ORDEN DE SUPERINTENDENCIA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'POR ORDEN DE ORGANISMOS POLICIALES', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'PROTESTO', 'C')

select @w_codigo = @w_codigo + 1
print 'Causa lev blq valor AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_caulev_blqva', 'Causa lev blq valor AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '0', 'MIGRACION', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'POR CIERRE DE CUENTA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'DEPTO COBROS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'ORDEN SUPERINTENDENCIA DE BANCOS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'POR ORDEN DEL CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'POR ORDEN DEL BANCO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'POR ORDEN DE AUTORIDAD COMPETENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'ENTIDAD JUDICIAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CARTA PROMESA DE PAGO/CARTA DE GARANTIA', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'LINEA DE SOBREGIRO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'LINEA DE CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'TARJETA CREDITO', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'PRESTAMO CORPORATIVO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'PRESTAMO PERSONAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'SECUESTRO/EMBARGO JUDICIAL', 'V')

select @w_codigo = @w_codigo + 1
print 'Causas canje de libreta'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_causa_canje', 'Causas canje de libreta')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'DETERIORO DE LA LIBRETA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'TERMINACION DE LA LIBRETA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'DATOS ERRADOS', 'C')

select @w_codigo = @w_codigo + 1
print 'Motivo de levantamiento de bloqueo de movimientos'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_motivo_levbloq_mov', 'Motivo de levantamiento de bloqueo de movimientos')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'POR ORDEN DE AUDITORIA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'POR ORDEN DEL CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'POR ORDEN DEL BANCO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'POR CANCELACION DE DEUDA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'SECUESTRO  EMBARGO JUDICIAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'ORDEN AUTORIDAD COMPETENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'POR CIERRE DE CUENTA', 'V')

select @w_codigo = @w_codigo + 1
print 'Causa Anulacion de libretas AHO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_tanula_lib', 'Causa Anulacion de libretas AHO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'DETERIORO DE LIBRETA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CAMBIO A ESTADO DE CUENTA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'PERDIDA DE LA LIBRETA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'ROBO DE LA LIBRETA', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'SOLICITUD DEL CLIENTE', 'C')

select @w_codigo = @w_codigo + 1
print 'Tipo de Cuenta de Ahorros'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_tipocta', 'Tipo de Cuenta de Ahorros')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'VENTA CRUZADA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'RADIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'TELEVISION', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'PRENSA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '13', 'PERIFONEO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '14', 'VOLANTEO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'INTERNET', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '16', 'LLEGO SOLO A LA OFICINA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '17', 'REFERIDO POLL PROMOTORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '18', 'REFERIDO POR UN COLABORADOR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'REFERIDO POR OTRO CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'VOLUNTAD PROPIA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'CALL CENTER', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '21', 'ALIANZAS COMERCIALES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '22', 'CORRESPONSALES BANCARIOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'PROFUNDIZACION RESPONSABLE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '24', 'DESEMBOLSO DE CREDITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'BUENAS REFERENCIAS DE BANCAMIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26', 'GESTION DE CAMPAÑA COMERCIAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '27', 'PRODUCTO DE VISITAS DE LOS COLABORADORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'PRESTAMO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'REFERIDO POR OTRO CLIENTE', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'REFERIDO COLABORADOR', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'PUBLICIDAD RADIAL', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'PERIFONEO TOMA DE PRUEBAS', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'BUEN SERVICIO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'EMBARGO JUDICIAL', 'B')

select @w_codigo = @w_codigo + 1
print 'Clasificacion Clientes Ahorros'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_cla_cliente', 'Clasificacion Clientes Ahorros')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'PERSONA NATURAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'AHORRO NAVIDAD', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'PERSONA JURIDICA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'COOPERATIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'ENTIDADES SIN FINES DE LUCRO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'FINANCIERAS Y CIAS DE SEGUROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'ENTIDADES AUTONOMAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'BANCOS', 'V')

select @w_codigo = @w_codigo + 1
print 'Cuota Semanal Cuentas de Navidad'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_cuota_navidad', 'Cuota Semanal Cuentas de Navidad')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'CUOTA SEMANAL $10.00 QUINCENAL $24.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '100', 'CUOTA SEMANAL $100.00 QUINCENAL $240.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '15', 'CUOTA SEMANAL $15.00 QUINCENAL $36.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CUOTA SEMANAL $2.00 QUINCENAL $4.80', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '20', 'CUOTA SEMANAL $20.00 QUINCENAL $48.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '25', 'CUOTA SEMANAL $25.00 QUINCENAL $60.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CUOTA SEMANAL $3.00 QUINCENAL $7.20', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '30', 'CUOTA SEMANAL $30.00 QUINCENAL $72.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '35', 'CUOTA SEMANAL $35.00 QUINCENAL $84.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'CUOTA SEMANAL $4.00 QUINCENAL $9.60', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '40', 'CUOTA SEMANAL $40.00 QUINCENAL $96.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'CUOTA SEMANAL $5.00 QUINCENAL $12.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'CUOTA SEMANAL $50.00 QUINCENAL $120.00', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'CUOTA SEMANAL $6.00 QUINCENAL $14.40', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'CUOTA SEMANAL $7.00 QUINCENAL $16.80', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'CUOTA SEMANAL $8.00 QUINCENAL $19.20', 'C')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'CUOTA SEMANAL $9.00 QUINCENAL $21.60', 'C')

select @w_codigo = @w_codigo + 1
print 'Productos de cuentas de funcionarios'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_producto_funcionario', 'Productos de cuentas de funcionarios')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '0', 'PLANILLA/COLABORADORES', 'V')

select @w_codigo = @w_codigo + 1
print 'ESTADOS QUE PERMITEN MARCACION GMF'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_estados_marcacion_gmf', 'ESTADOS QUE PERMITEN MARCACION GMF')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'A', 'ACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'G', 'INGRESADA', 'V')

select @w_codigo = @w_codigo + 1
print 'ESTADOS QUE PERMITEN DESMARCACION GMF'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_estados_desmarcacion_gmf', 'ESTADOS QUE PERMITEN DESMARCACION GMF')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'A', 'ACTIVA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'C', 'CANCELADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'G', 'INGRESADA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'N', 'NO PERFECCIONADA', 'V')

select @w_codigo = @w_codigo + 1
print 'CAUSAS NC COBRAN GMF A BANCAMIA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_cau_nc_gmf_ba', 'CAUSAS NC COBRAN GMF A BANCAMIA')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '114', 'DEVOLUCION SOBRANTE PAGOS CLIENTES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '115', 'PAGO INCENTIVO AL MICROCREDITO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '19', 'PAGO DE NOMINA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '205', 'PAGO A PROVEEDORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '23', 'PAGO DE VIATICOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '31', 'REDENCION DE PUNTOS REFERIDOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '50', 'BENEFICIO MUJERES AHORRADORAS EN ACCION', 'V')

select @w_codigo = @w_codigo + 1
print 'CANAL RELACION CTA CANAL'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_canal_relcta', 'CANAL RELACION CTA CANAL')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'CB', 'CORRESPONSAL BANCARIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'TAR', 'TARJETA DEBITO', 'V')

select @w_codigo = @w_codigo + 1
print 'PRODUCTOS BANCARIOS BLOQUEADOS PARA CANALES'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_prodbanc_blq', 'PRODUCTOS BANCARIOS BLOQUEADOS PARA CANALES')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'SONANDO JUNTOS', 'V')

select @w_codigo = @w_codigo + 1
print 'RELACION CANAL ROL'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_canal_enroll', 'RELACION CANAL ROL')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'TAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'BMOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'IVR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'INTERNET', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'INTER', 'V')

select @w_codigo = @w_codigo + 1
print 'ACTUALIZACION DE CANAL PARA ENROLAMIENTO'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_canal_act', 'ACTUALIZACION DE CANAL PARA ENROLAMIENTO')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CB', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'TAR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'BANCAMOVIL', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'IVR', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'INTERNET', 'E')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'INTER', 'E')

select @w_codigo = @w_codigo + 1
print 'RELACION IDENTIFICACION ROL'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_id_enroll', 'RELACION IDENTIFICACION ROL')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'N', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'TI', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'PA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'CE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'NU', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'NI', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'U', 'V')

select @w_codigo = @w_codigo + 1
print 'TRANSACCIONES REALIZADAS POR CANALES'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ws_tran_canales', 'TRANSACCIONES REALIZADAS POR CANALES')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26502', 'PAGO DE PRESTAMO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26503', 'CONSULTA DE CLIENTE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26504', 'CONSULTA DE CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26506', 'CONSULTA DE SALDOS CB EN OFICINA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26508', 'RECAUDO CB EN OFICINA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26513', 'ACTUALIZACION DE DATOS CB', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26518', 'CONSULTA DE SALDO AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26519', 'RETIRO A CUENTA AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26520', 'DEPOSITO A CUENTA AHORROS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26523', 'COMPRA POR POS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '26524', 'ANULACION DE COMPRA POR POS', 'V')

select @w_codigo = @w_codigo + 1
print 'SERVICIOS PARA COMISIONES TD POR TRN EN OFICINA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'pe_comision_td', 'SERVICIOS PARA COMISIONES TD POR TRN EN OFICINA')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '230', 'CSTD', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '263', 'CNTD', 'V')

select @w_codigo = @w_codigo + 1
print 'ORIGEN TRANSACCION'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'pe_lt_origen', 'ORIGEN TRANSACCION')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'OFICINA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CORRESPONSAL BANCARIO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'TARJETA DEBITO ATM', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'TARJETA DEBITO POS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'BANCA MOVIL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'INTERNET', 'V')

select @w_codigo = @w_codigo + 1
print 'ESPECIE TRANSACCION'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'pe_lt_especie', 'ESPECIE TRANSACCION')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'EFECTIVO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'COMPRAS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'PAGOS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'TRANSFERENCIAS BANCAMIA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'TRANSFERENCIAS OTROS BANCOS', 'V')

select @w_codigo = @w_codigo + 1
print 'TRANSACCIONES SIN TOPES DE OFICINA'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'pe_tx_topes_oficina', 'TRANSACCIONES SIN TOPES DE OFICINA')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '263', 'RETIRO', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '371', 'RETIRO AUTORIZADO EN FUERA DE LINEA', 'B')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '380', 'RETIRO AHORROS CHEQUE', 'B')

select @w_codigo = @w_codigo + 1
print 'Titularidad en Canales'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_titularidad', 'Titularidad en Canales')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'I', 'INDIVIDUAL', 'V')

select @w_codigo = @w_codigo + 1
print 'TABLAS DE EQUIVALENCIAS COB_REMESAS'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_equivalencias', 'TABLAS DE EQUIVALENCIAS COB_REMESAS')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'CANAL', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'CATPRODUC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'CAUSACIERRE', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'DOCPROVCC', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'DOCPROVEEDORES', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'ROLDEUDOR', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 'TIPCONCEPT', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'TIPTRANS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'RPADEPTO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'RPACARGO', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'COMTRNA', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'CAUSCOND', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, 'COMTRNA', 'COMISION TRNA ASOCIACION RUBRO TRX', 'V')

select @w_codigo = @w_codigo + 1
print 'TABLAS DE EQUIVALENCIAS-CATALOGO COB_REMESAS'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_eq_tabla', 'TABLAS DE EQUIVALENCIAS-CATALOGO COB_REMESAS')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '1', 'cl_canal', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '2', 'cl_categoria', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '3', 'ah_causa_cierre', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '4', 'cl_tipo_documento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '5', 'cl_tipo_documento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '6', 'cr_rol_deudor', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '7', 're_concepto_contable', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '8', 'TIPTRANS', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '9', 'cl_departamento', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '10', 'cl_cargo', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '11', 'cl_trn_central_local', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_codigo, '12', 'ah_causa_nd', 'V')

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

go

use cobis
go



declare @w_codigo integer

select @w_codigo = codigo from cobis..cl_tabla where tabla LIKE 'ah_capitalizacion'


delete from cobis..cl_default where tabla = @w_codigo and oficina = 1


INSERT INTO cobis..cl_default (tabla, oficina, codigo, valor, srv)
VALUES (@w_codigo, 1, 'M', 'MENSUAL', 'ClOUDSRV')
go


