/******************************************************/
--Fecha Creación del Script: 2016/Jul/08               */
--Historial  Dependencias:                             */
--   Creacion de Vistas                                */
--   Insercion de Errores                              */
--Modulo :MIS CTA_AHO                                  */
/******************************************************/

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
-- cc_view.sql
use cob_cuentas
go

IF OBJECT_ID ('ts_cta_cons_bco') IS NOT NULL
                DROP VIEW ts_cta_cons_bco
go
create view ts_cta_cons_bco (
        secuencial,    tipo_tran,           oficina,         usuario,       terminal,
        origen,        nodo,                fecha,           tipo,          banco,
        referencia,    operacion
) as
select  ts_secuencial, ts_tipo_transaccion, ts_oficina,      ts_usuario,    ts_terminal,
        ts_origen,     ts_nodo,             ts_tsfecha,      ts_tipo,       ts_banco,
        ts_referencia, ts_clase
  from  cc_tran_servicio
 where  ts_tipo_transaccion in (696, 697) 
go
 
--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------
--cc_error.sql
use cobis
go
   
delete from cl_errores where numero in (
351003,351011,351012,351014,351015,351020,351027,351028,351033,351034,351035,351038,351039,351041,351047,351048,351049,351054,351055,351057,351059,
351062,351066,351067,351068,351069,351078,351079,351080,351081,351082,351083,351084,351086,351092,351097,351098,351501,351502,351503,351504,351507,
351508,351509,351510,351511,351512,351513,351514,351515,351518,351520,351521,351522,351523,351524,351525,351526,351527,351528,351536,351537,351538,
351539,351540,351541,351542,351546,351547,351548,351551,351552,351553,351554,351559,351560,351562,351563,351564,351566,351568,351567,351569,351570,
351571,351579,351580,352008,352011,352082,357008,357026,357515,357516,357518,357528,357529,357530,357534,357535,351573,352009,352010,352012,352013,
352022,352083,353000,353001,353002,353003,353004,353005,353006,353007,353008,353009,353010,353011,353012,353013,353014,353015,353016,353017,353018,
353019,353020,353021,353022,353023,353024,353026,353027,353037,353500,353501,353502,353503,353504,353505,353506,353507,353508,353509,353510,353511,
353512,353513,353514,353515,353516,353517,357508,357517,357521,351063,351550,351574,352001,352002,352014,352015,352081,352084,353518,355000,355001,
355002,355003,355004,355005,355006,355007,355008,355009,355010,355011,355012,355013,355014,355015,355016,355017,355018,355019,355020,355021,355022,
355023,355024,355025,355026,355027,355028,355029,355030,355031,355032,353035,355039,355041,355500,355501,355502,355503,355504,355505,355506,355507,
355508,355509,355510,355511,355512,355513,355514,355515,355516,355517,355518,355519,355520,357512,357519,357522,357531,352016,352017,352085,353025,
353028,357000,357001,357002,357003,357004,357005,357006,357007,357010,357011,357012,357013,357500,357501,357502,357503,357504,357505,357506,357520,
357527,357533,351000,351001,351002,351004,351005,351006,351007,351008,351009,351010,351013,351016,351017,351018,351019,351021,351022,351023,351024,
351025,351026,351029,351030,351031,351032,351036,351037,351040,351042,351043,351044,351045,351046,351050,351051,351052,351053,351056,351058,351060,
351061,351064,351065,351070,351071,351072,351073,351074,351075,351076,351077,351085,351087,351088,351089,351090,351091,351093,351094,351096,351500,
351505,351506,351516,351517,351519,351529,351530,351531,351532,351533,351534,351535,351543,351544,351545,351549,351555,351556,351557,351561,351572,
351575,351576,351577,351578,352000,352003,352004,352005,352006,352007,352018,352019,352020,352021,352025,352026,352079,352087,352088,357009,357014,
357015,357016,357509,357510,357511,357513,357514,357516,357523,357524,357525,357526,357536,357537
)
go
insert into cl_errores values (351003, 1, 'NO EXISTE CARTA REMESA')
go
insert into cl_errores values (351011, 1, 'NO EXISTE CUENTA GIRADA')
go
insert into cl_errores values (351012, 1, 'NO EXISTE CUENTA')
go
insert into cl_errores values (351014, 1, 'NO EXISTE TRANSACCION')
go
insert into cl_errores values (351015, 1, 'NO EXISTE PRODUCTO BANCARIO')
go
insert into cl_errores values (351020, 1, 'NO EXISTE EL DEPOSITO')
go
insert into cl_errores values (351027, 1, 'NO EXISTEN BANCOS')
go
insert into cl_errores values (351028, 1, 'NO EXISTE EL BANCO')
go
insert into cl_errores values (351033, 1, 'NO EXISTEN MAS CHQS. DE CAMARA')
go
insert into cl_errores values (351034, 1, 'NO EXISTEN INGRESOS DE CAMARA')
go
insert into cl_errores values (351035, 1, 'NO EXISTEN MAS INGRESOS DE CAMARA')
go
insert into cl_errores values (351038, 1, 'CHEQUE DE CAMARA NO EXISTE')
go
insert into cl_errores values (351039, 1, 'NO EXISTEN CHQS. PARA TRANSMITIR')
go
insert into cl_errores values (351041, 1, 'NO EXISTE BANCO CORRESPONSAL')
go
insert into cl_errores values (351047, 1, 'REGISTRO YA EXISTENTE')
go
insert into cl_errores values (351048, 1, 'NO EXISTEN REGISTROS SELECCIONADOS')
go
insert into cl_errores values (351049, 1, 'REGISTRO NO EXISTE')
go
insert into cl_errores values (351054, 1, 'CHEQUE DE CAJERO INTERNO NO EXISTE')
go
insert into cl_errores values (351055, 1, 'CHEQUE REMESA NO EXISTE')
go
insert into cl_errores values (351057, 1, 'YA EXISTE TIPO DE IMPUESTO')
go
insert into cl_errores values (351059, 1, 'PAQUETE YA EXISTE')
go
insert into cl_errores values (351062, 1, 'NO EXISTE SECUENCIAL PARA LA OFICINA')
go
insert into cl_errores values (351066, 1, 'NO EXISTEN DATOS PENDIENTES CON ESE SECUENCIAL')
go
insert into cl_errores values (351067, 1, 'NO EXISTE CONVENIO DE BANCO CEDENTE')
go
insert into cl_errores values (351068, 1, 'NO EXISTE EL SECUENCIAL DE CABECERA INGRESADO')
go
insert into cl_errores values (351069, 1, 'NO EXISTE BANCO CORRESPONSAL PARA ESA RUTA')
go
insert into cl_errores values (351078, 1, 'NO EXISTE REGISTRO DE TIPO DE CODIGO DE BARRAS')
go
insert into cl_errores values (351079, 1, 'NO EXISTEN DATOS DE CODIGOS DE BARRAS')
go
insert into cl_errores values (351080, 1, 'NO EXISTE REGISTRO DE CODIGO DE BARRAS ASOCIADO A TIPO DE IMPUESTO')
go
insert into cl_errores values (351081, 1, 'NO EXISTEN DATOS DE CODIGOS DE BARRAS ASOCIADOS A IMPUESTOS')
go
insert into cl_errores values (351082, 1, 'NO SE PUEDE BORRAR PORQUE EXISTEN REGISTROS ASOCIADOS A TIPOS DE IMPUESTOS')
go
insert into cl_errores values (351083, 1, 'NO EXISTE REGISTRO DE DETALLE DE CODIGO DE BARRAS')
go
insert into cl_errores values (351084, 1, 'NO EXISTEN DATOS DE DETALLE DE CODIGOS DE BARRAS')
go
insert into cl_errores values (351086, 1, 'NO EXISTE CODIGO DE TRANSACCION EN DATOS LOCALES')
go
insert into cl_errores values (351092, 0, 'NO EXISTEN CARTAS REMESAS INGRESADAS HOY')
go
insert into cl_errores values (351097, 0, 'CUENTA DEBITO DE LA TRANSFERENCIA YA EXISTE')
go
insert into cl_errores values (351098, 0, 'YA EXISTE TRANSACCION PARA LA CUENTA DE LA TRASFERENCIA')
go
insert into cl_errores values (351501, 0, 'No existe servicio disponible')
go
insert into cl_errores values (351502, 0, 'No existe servicio asociado a rubro')
go
insert into cl_errores values (351503, 0, 'Ya existe servicio asociado a rubro')
go
insert into cl_errores values (351504, 0, 'No existe atributo')
go
insert into cl_errores values (351507, 0, 'No existe tipo de rango')
go
insert into cl_errores values (351508, 0, 'No existe producto bancario')
go
insert into cl_errores values (351509, 0, 'No existe mercado solicitado')
go
insert into cl_errores values (351510, 0, 'No existe moneda definida')
go
insert into cl_errores values (351511, 0, 'No existe mercado definido')
go
insert into cl_errores values (351512, 0, 'Ya existe servicio personalizable asociado')
go
insert into cl_errores values (351513, 0, 'No existe producto final asociado')
go
insert into cl_errores values (351514, 0, 'No existe variacion de servicio')
go
insert into cl_errores values (351515, 0, 'No existe servicio solicitado')
go
insert into cl_errores values (351518, 0, 'No existe producto cobis')
go
insert into cl_errores values (351520, 0, 'No existe valor contratado')
go
insert into cl_errores values (351521, 0, 'No existe tipo default')
go
insert into cl_errores values (351522, 0, 'No existe cuenta corriente')
go
insert into cl_errores values (351523, 0, 'No existe cuenta ahorro')
go
insert into cl_errores values (351524, 0, 'No existe servicio basico')
go
insert into cl_errores values (351525, 0, 'No existe signo')
go
insert into cl_errores values (351526, 0, 'No existe rango solicitado')
go
insert into cl_errores values (351527, 0, 'No existe producto final')
go
insert into cl_errores values (351528, 0, 'No existe subservicio')
go
insert into cl_errores values (351536, 0, 'Producto bancario ya existente')
go
insert into cl_errores values (351537, 0, 'Servicio personalizable ya existente')
go
insert into cl_errores values (351538, 0, 'Servicio contratado ya existente')
go
insert into cl_errores values (351539, 0, 'Existe costo asociado')
go
insert into cl_errores values (351540, 0, 'No existe servicio personalizable')
go
insert into cl_errores values (351541, 0, 'No existe limite')
go
insert into cl_errores values (351542, 0, 'No existe limite para ese servicio y categoria')
go
insert into cl_errores values (351546, 0, 'Ya existe servicio basico')
go
insert into cl_errores values (351547, 0, 'Ya existe limite para ese servicio y categoria')
go
insert into cl_errores values (351548, 0, 'No existe costos para el servicio y categoria dado')
go
insert into cl_errores values (351551, 0, 'No existe rango en el cual se encuentra el valor a actuar')
go
insert into cl_errores values (351552, 0, 'No existe costo')
go
insert into cl_errores values (351553, 0, 'No existe mercado para el producto bancario y el tipo de ente')
go
insert into cl_errores values (351554, 0, 'No existe valor contratado para la personalizacion dada')
go
insert into cl_errores values (351559, 0, 'No existe grupo de rango para el tipo ingresado')
go
insert into cl_errores values (351560, 0, 'Servicio ya existente')
go
insert into cl_errores values (351562, 0, 'No existe producto moneda')
go
insert into cl_errores values (351563, 0, 'Ya existe registro de cobro de comision')
go
insert into cl_errores values (351564, 0, 'No existe registro de cobro de comision')
go
insert into cl_errores values (351566, 0, 'Ya existe el tipo de capitalizacion para el producto final')
go
insert into cl_errores values (351568, 0, 'Ya existe el tipo de ciclo para el producto final')
go
insert into cl_errores values (351567, 1, 'No existe el tipo de capitalizacion para el producto final')
go
insert into cl_errores values (351569, 1, 'YA EXISTE REGISTRO DE PRODUCTO')
go
insert into cl_errores values (351570, 1, 'NO EXISTE REGISTRO DE PRODUCTO')
go
insert into cl_errores values (351571, 1, 'Error Existen Giros de Remesas sin aplicar')
go
insert into cl_errores values (351579, 0, 'EXISTE RELACIONES VIGENTE CON ESTE SUBTIPO, NO ES POSIBLE CAMBIO DE ESTADO')
go
insert into cl_errores values (351580, 0, 'NO EXISTE PARAMETRIZACION DE COBRO DE TRN NACIONAL')
go
insert into cl_errores values (352008, 1, 'YA EXISTE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
go
insert into cl_errores values (352011, 1, 'YA EXISTE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
go
insert into cl_errores values (352082, 0, 'NO EXISTEN CONCEPTOS PARAMETRIZADOS')
go
insert into cl_errores values (357008, 1, 'NO SE PUEDE ELIMINAR REGISTRO, EXISTEN DATOS RELACIONADOS')
go
insert into cl_errores values (357026, 0, 'ERROR, NO EXISTE REGISTRO A ELIMINAR')
go
insert into cl_errores values (357515, 1, 'YA EXISTE CATEGORIA PARA PRODUCTO FINAL')
go
insert into cl_errores values (357516, 0, 'YA EXISTE TOPE PARA PRODUCTO')
go
insert into cl_errores values (357518, 0, 'NO EXISTE REGISTRO DE TOPE PARA PRODUCTO')
go
insert into cl_errores values (357528, 1, 'NO EXISTE MARCA DE SERVICIO PARA LA CUENTA Y EL PRODUCTO')
go
insert into cl_errores values (357529, 1, 'YA EXISTE PARAMETRO PARA MANEJO DE IMPRESION')
go
insert into cl_errores values (357530, 1, 'NO EXISTE PARAMETRO PARA MANEJO DE IMPRESION ')
go
insert into cl_errores values (357534, 1, 'ERROR NO EXISTE PRODUCTO FINAL ')
go
insert into cl_errores values (357535, 1, 'ERROR NO EXISTE  CATEGORIA PARA PRODUCTO FINAL ')
go
insert into cl_errores values (351573, 1, 'Error Insertando Autorizacion de Transaccion')
go
insert into cl_errores values (352009, 1, 'ERROR EN INSERCION DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
go
insert into cl_errores values (352010, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO PARA ESTE SECUENCIAL')
go
insert into cl_errores values (352012, 1, 'ERROR EN INSERCION DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
go
insert into cl_errores values (352013, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO PARA ESTE CONSECUTIVO DE PAQUETE')
go
insert into cl_errores values (352022, 1, 'ERROR EN INSERCION DE LIQUIDACION DE INTERESES')
go
insert into cl_errores values (352083, 1, 'ERROR AL INSERTAR CONCEPTO DE EXONERACION')
go
insert into cl_errores values (353000, 1, 'ERROR AL INSERTAR EN CARTA')
go
insert into cl_errores values (353001, 1, 'ERROR AL INSERTAR EN DETALLE DE CARTA')
go
insert into cl_errores values (353002, 1, 'Error al insertar cheque de la carta')
go
insert into cl_errores values (353003, 1, 'Error al insertar en linea pendiente')
go
insert into cl_errores values (353004, 1, 'Error al insertar en transaccion de servicio de cuentas corrientes')
go
insert into cl_errores values (353005, 1, 'Error al insertar en transaccion de servicio de cuentas de ahorros')
go
insert into cl_errores values (353006, 1, 'Error al insertar el deposito')
go
insert into cl_errores values (353007, 1, 'Error al insertar el cheque')
go
insert into cl_errores values (353008, 1, 'Error al insertar el ajuste')
go
insert into cl_errores values (353009, 1, 'Error al insertar el banco')
go
insert into cl_errores values (353010, 1, 'Error al insertar cheque remesa')
go
insert into cl_errores values (353011, 1, 'ERROR AL INSERTAR CHEQUE DEVUELTO')
go
insert into cl_errores values (353012, 1, 'ERROR AL INSERTAR CHEQUE DE CAMARA')
go
insert into cl_errores values (353013, 1, 'ERROR AL INSERTAR CABECERA DE CAM.')
go
insert into cl_errores values (353014, 1, 'ERROR AL INSERTAR OFICINA')
go
insert into cl_errores values (353015, 1, 'ERROR AL INSERTAR AJUSTE CAJ. INT.')
go
insert into cl_errores values (353016, 1, 'ERROR AL INSERTAR TRANSACCION A CONTABILIZAR')
go
insert into cl_errores values (353017, 1, 'ERROR AL INSERTAR VALOR DE RETENCION')
go
insert into cl_errores values (353018, 1, 'ERROR AL INSERTAR CAMPOS EN LA TABLA DE IMPUESTOS')
go
insert into cl_errores values (353019, 1, 'ERROR AL INSERTAR FORMAS DE PAGOS')
go
insert into cl_errores values (353020, 1, 'ERROR AL INSERTAR CAMPOS, HA EXCEDIDO EL NUMERO DE TIPO MONEY')
go
insert into cl_errores values (353021, 1, 'ERROR AL INSERTAR CAMPOS, HA EXCEDIDO EL NUMERO DE TIPO CATALOGO')
go
insert into cl_errores values (353022, 1, 'ERROR AL INSERTAR CABECERA DE BANCOS CEDENTES')
go
insert into cl_errores values (353023, 1, 'ERROR AL INSERTAR EL ESTADO EXTRAVIADO EN EL CHEQUE')
go
insert into cl_errores values (353024, 1, 'ERROR AL INSERTAR EL TIPO DE CODIGO DE BARRAS')
go
insert into cl_errores values (353026, 1, 'ERROR AL INSERTAR EL DETALLE DEL CODIGO DE BARRAS')
go
insert into cl_errores values (353027, 1, 'Error en insercion RE_CATALOGO_OFI')
go
insert into cl_errores values (353037, 1, 'ERROR AL INSERTAR REGISTRO DE PERSONALIZACION DE NOTA DEBITO/CREDITO')
go
insert into cl_errores values (353500, 1, 'Error al insertar servicios disponiblesa')
go
insert into cl_errores values (353501, 1, 'Error al insertar detalles de servicio')
go
insert into cl_errores values (353502, 1, 'Error al insertar tipo de rango')
go
insert into cl_errores values (353503, 1, 'Error al insertar rangos')
go
insert into cl_errores values (353504, 1, 'Error al insertar producto bancario')
go
insert into cl_errores values (353505, 1, 'Error al insertar mercado ')
go
insert into cl_errores values (353506, 1, 'Error al insertar producto final ')
go
insert into cl_errores values (353507, 1, 'Error al insertar servicios personalizable')
go
insert into cl_errores values (353508, 1, 'Error al insertar servicio contratado ')
go
insert into cl_errores values (353509, 1, 'Error al insertar valor contratado')
go
insert into cl_errores values (353510, 1, 'Error al insertar servicio basico')
go
insert into cl_errores values (353511, 1, 'Error al insertar costo')
go
insert into cl_errores values (353512, 1, 'Error al insertar cambio costo')
go
insert into cl_errores values (353513, 1, 'Error al insertar cambio de valor contratado')
go
insert into cl_errores values (353514, 1, 'Error al insertar limite')
go
insert into cl_errores values (353515, 1, 'Error al insertar transaccion de servicio')
go
insert into cl_errores values (353516, 1, 'Error al insertar cobro de comision')
go
insert into cl_errores values (353517, 1, 'Error al insertar producto Contractual')
go
insert into cl_errores values (357508, 1, 'ERROR AL INSERTAR REGISTRO DE MARCACION DE SERVICIO')
go
insert into cl_errores values (357517, 1, 'ERROR AL INSERTAR TOPE PARA PRODUCTO')
go
insert into cl_errores values (357521, 1, 'ERROR AL INSERTAR AUTORIZACION RETIRO')
go
insert into cl_errores values (351063, 1, 'ERROR EN ACTUALIZACION DE SECUENCIAL')
go
insert into cl_errores values (351550, 0, 'No se ha ingresado valor sobre el cual se actua')
go
insert into cl_errores values (351574, 1, 'Error Actualizando Autorizacion de Transaccion')
go
insert into cl_errores values (352001, 0, 'Error actualizar en re_oficina_canje')
go
insert into cl_errores values (352002, 0, 'Error Eliminar en re_oficina_canje')
go
insert into cl_errores values (352014, 1, 'ERROR EN ACTUALIZACION DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
go
insert into cl_errores values (352015, 1, 'ERROR EN ACTUALIZACION DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
go
insert into cl_errores values (352081, 0, 'ERROR AL ACTUALIZAR BASE EXONERACION ')
go
insert into cl_errores values (352084, 1, 'ERROR AL ACTUALIZAR CONCEPTO DE EXONERACION')
go
insert into cl_errores values (353518, 0, 'No. de Telefono asociado a Cuenta y Canal. No se puede Actualizar o Eliminar')
go
insert into cl_errores values (355000, 1, 'Error al actualizar en cheque')
go
insert into cl_errores values (355001, 1, 'Error al actualizar en carta')
go
insert into cl_errores values (355002, 1, 'Error al actualizar en cuenta corriente')
go
insert into cl_errores values (355003, 1, 'Error al actualizar en cuenta de ahorros')
go
insert into cl_errores values (355004, 1, 'Error al actualizar seqnos')
go
insert into cl_errores values (355005, 1, 'Error al actualizar caja en cuentas corrientes')
go
insert into cl_errores values (355006, 1, 'Error al actualizar caja en cuentas de ahorros')
go
insert into cl_errores values (355007, 1, 'Error al actualizar el sobregiro')
go
insert into cl_errores values (355008, 1, 'Error al actualizar el cupo de sobregiro del oficial')
go
insert into cl_errores values (355009, 1, 'Error al actualizar cheque devuelto')
go
insert into cl_errores values (355010, 1, 'Error al actualizar un cheque')
go
insert into cl_errores values (355011, 1, 'Error al actualizar un ajuste')
go
insert into cl_errores values (355012, 1, 'ERROR AL ACTUALIZAR CHQ TRANSFERIDO')
go
insert into cl_errores values (355013, 1, 'ERROR AL ACTUALIZAR CHQ. DE CAMARA')
go
insert into cl_errores values (355014, 1, 'ERROR AL ACTUALIZAR CABECERA DE CAM.')
go
insert into cl_errores values (355015, 1, 'ERROR AL ACTUALIZAR SECUENCIAL DE CHQS. DE CAMARA')
go
insert into cl_errores values (355016, 1, 'ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA')
go
insert into cl_errores values (355017, 1, 'ERROR CHEQUE CONFIRMADO ANTERIORMENTE')
go
insert into cl_errores values (355018, 1, 'ERROR CHEQUE RECHAZADO ANTERIORMENTE')
go
insert into cl_errores values (355019, 1, 'ERROR AL ACTUALIZAR DETALLE DE CARTA')
go
insert into cl_errores values (355020, 1, 'ERROR AL ACTUALIZAR OFICINAS DEL BANCO')
go
insert into cl_errores values (355021, 1, 'ERROR AL ACTUALIZAR RE_CAM_PENDIENTE')
go
insert into cl_errores values (355022, 1, 'ERROR AL ACTUALIZAR INGRESO DEL CHEQUE')
go
insert into cl_errores values (355023, 1, 'ERROR AL ACTUALIZAR VALOR DE RETENCION')
go
insert into cl_errores values (355024, 1, 'ERROR AL ACTUALIZAR FORMA DE PAGO DE IMPUESTO')
go
insert into cl_errores values (355025, 1, 'ERROR AL ACTUALIZAR CAMPO DE IMPUESTO')
go
insert into cl_errores values (355026, 1, 'ERROR AL ACTUALIZAR BANCO CEDENTE')
go
insert into cl_errores values (355027, 1, 'ERROR AL PASAR LOS DATOS AL HISTORICO')
go
insert into cl_errores values (355028, 1, 'ERROR AL ACTUALIZAR EL TIPO DE CODIGO DE BARRAS')
go
insert into cl_errores values (355029, 1, 'ERROR AL ACTUALIZAR EL REGISTRO ASOCIADO DE CODIGO DE BARRAS A IMPUESTO')
go
insert into cl_errores values (355030, 1, 'ERROR AL ACTUALIZAR EL DETALLE DEL CODIGO DE BARRAS')
go
insert into cl_errores values (355031, 1, 'ERROR AL ACTUALIZAR DE ACUSE DE CARTA REMESA')
go
insert into cl_errores values (355032, 1, 'ERROR EN ACTUALIZACION DE REGISTRO')
go
insert into cl_errores VALUES (353035, 1, 'ERROR AL INSERTAR REGISTRO DE AUTORIZACION DE NOTA CREDITO / NOTA DEBITO')
go
insert into cl_errores VALUES (355039, 1, 'ERROR AL ACTUALIZAR EL ESTADO DE LA TRANSACCION POR AUTORIZAR')
go
insert into cl_errores values (355041, 1, 'ERROR AL ACTUALIZAR EL REGISTRO DE PERSONALIZACION DE NOTA DEBITO/CREDITO')
go
insert into cl_errores values (355500, 1, 'Error en actualizacion de detalle de servicio')
go
insert into cl_errores values (355501, 1, 'Error en actualizacion de tipo rango')
go
insert into cl_errores values (355502, 1, 'Error al actualizar producto bancario')
go
insert into cl_errores values (355503, 1, 'Error al actualizar estado de mercado')
go
insert into cl_errores values (355504, 1, 'Error al actualizar estado en serv. bacico')
go
insert into cl_errores values (355505, 1, 'Error al actualizar mercado')
go
insert into cl_errores values (355506, 1, 'Error al actualizar producto final')
go
insert into cl_errores values (355507, 1, 'Error al actualizar servicio personalizable')
go
insert into cl_errores values (355508, 1, 'Error en eliminar rango')
go
insert into cl_errores values (355509, 1, 'Error en actualizar servicio disponible')
go
insert into cl_errores values (355510, 1, 'Error en actualizar valor contratado')
go
insert into cl_errores values (355511, 1, 'Error en actualizar cambio de valor contratado')
go
insert into cl_errores values (355512, 1, 'Error en actualizar servicio contratado')
go
insert into cl_errores values (355513, 1, 'Error en actualizar costo')
go
insert into cl_errores values (355514, 1, 'Error en actualizar servicio basico')
go
insert into cl_errores values (355515, 1, 'Error en actualizar cambio costo')
go
insert into cl_errores values (355516, 1, 'Error en actualizar limite')
go
insert into cl_errores values (355517, 1, 'Error en actualizar cuenta corriente')
go
insert into cl_errores values (355518, 1, 'Error en actualizar cuenta de ahorro')
go
insert into cl_errores values (355519, 1, 'Error en actualizacion de registro')
go
insert into cl_errores values (355520, 1, 'Error en actualizar producto Contractual')
go
insert into cl_errores values (357512, 1, 'Error al eliminar Producto Contractual')
go
insert into cl_errores values (357519, 1, 'ERROR AL ACTUALIZAR TOPE PARA PRODUCTO')
go
insert into cl_errores values (357522, 1, 'ERROR AL ACTUALIZAR AUTORIZACION RETIRO')
go
insert into cl_errores values (357531, 1, 'ERROR AL ACTUALIZAR PARAMETRO PARA MANEJO DE IMPRESION ')
go
insert into cl_errores values (352016, 1, 'ERROR EN BORRADO DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
go
insert into cl_errores values (352017, 1, 'ERROR EN BORRADO DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
go
insert into cl_errores values (352085, 1, 'ERROR AL ELIMINAR CONCEPTO DE EXONERACION')
go
insert into cl_errores values (353025, 1, 'ERROR AL ASOCIAR EL CODIGO DE BARRAS AL TIPO DE IMPUESTO')
go
insert into cl_errores values (353028, 1, 'Error en eliminacion RE_CATALOGO_OFI')
go
insert into cl_errores values (357000, 1, 'Error al borrar la carta')
go
insert into cl_errores values (357001, 1, 'Error al borrar cheque de remesa')
go
insert into cl_errores values (357002, 1, 'Error al borrar detalle de la carta')
go
insert into cl_errores values (357003, 1, 'Error al borrar cheque pendiente de camara')
go
insert into cl_errores values (357004, 1, 'Error al borrar los bancos')
go
insert into cl_errores values (357005, 1, 'ERROR AL BORRAR CHEQUE DE CAMARA')
go
insert into cl_errores values (357006, 1, 'ERROR AL ELIMINAR REGISTRO')
go
insert into cl_errores values (357007, 1, 'ERROR AL ELIMINAR EL TIPO DE IMPUESTO')
go
insert into cl_errores values (357010, 1, 'ERROR AL BORRAR EL ESTADO DE LA REMESA')
go
insert into cl_errores values (357011, 1, 'ERROR AL BORRAR EL TIPO DE CODIGO DE BARRAS')
go
insert into cl_errores values (357012, 1, 'ERROR AL BORRAR EL TIPO DE CODIGO DE BARRAS ASOCIADO A IMPUESTO')
go
insert into cl_errores values (357013, 1, 'ERROR AL BORRAR EL DETALLE DEL CODIGO DE BARRAS')
go
insert into cl_errores values (357500, 1, 'Error al borrar servicio-Tx')
go
insert into cl_errores values (357501, 1, 'Error al borrar rango')
go
insert into cl_errores values (357502, 1, 'Error al borrar rango')
go
insert into cl_errores values (357503, 1, 'Error al eliminar valor contratado')
go
insert into cl_errores values (357504, 1, 'Error al eliminar producto final')
go
insert into cl_errores values (357505, 1, 'Error al eliminar servicio personalizable')
go
insert into cl_errores values (357506, 1, 'Error al eliminar costo')
go
insert into cl_errores values (357520, 1, 'ERROR AL ELIMINAR TOPE PARA PRODUCTO')
go
insert into cl_errores values (357527, 1, 'Error al eliminar cobro de comision')
go
insert into cl_errores values (357533, 1, 'ERROR AL ELIMINAR PARAMETRO PARA MANEJO DE IMPRESION ')
go
insert into cl_errores values (351000, 1, 'ERROR EN TABLA OFICINA BANCO')
go
insert into cl_errores values (351001, 1, 'ERROR EN TABLA TRANSITO')
go
insert into cl_errores values (351002, 1, 'DATOS INCONSISTENTES')
go
insert into cl_errores values (351004, 1, 'ERROR EN TABLA DE FECHA PROMEDIO')
go
insert into cl_errores values (351005, 1, 'ERROR EN TABLA DE FECHA PROMEDIO')
go
insert into cl_errores values (351006, 1, 'ERROR EN TABLA DE CUENTAS CORRIENTES')
go
insert into cl_errores values (351007, 1, 'ERROR EN MONEDA')
go
insert into cl_errores values (351008, 1, 'VALOR MAYOR QUE REMESAS')
go
insert into cl_errores values (351009, 1, 'VALOR MAYOR QUE REMESAS HOY')
go
insert into cl_errores values (351010, 1, 'ERROR EN TABLA DE CUENTAS DE AHORROS')
go
insert into cl_errores values (351013, 1, 'NO HAY MAS CHEQUES PENDIENTES')
go
insert into cl_errores values (351016, 1, 'ERROR EN CURSOR TABLA re_cheque_rem')
go
insert into cl_errores values (351017, 1, 'ERROR EN SECUENCIAL re_carta')
go
insert into cl_errores values (351018, 1, 'ERROR EN CURSOR TABLA re_carta')
go
insert into cl_errores values (351019, 1, 'NUMERO DE TRANSACCION NO VALIDO')
go
insert into cl_errores values (351021, 1, 'CUENTA INCORRECTA')
go
insert into cl_errores values (351022, 1, 'VALOR EN EFECTIVO INCORRECTO')
go
insert into cl_errores values (351023, 1, 'VALOR DE CHQS. PROPIOS INCORRECTO')
go
insert into cl_errores values (351024, 1, 'VALOR DE CHQS. LOCALES INCORRECTO')
go
insert into cl_errores values (351025, 1, 'VALOR DE CHQS. REMESAS INCORRECTO')
go
insert into cl_errores values (351026, 1, 'VALOR TOTAL INCORRECTO')
go
insert into cl_errores values (351029, 1, 'ERROR CURSOR TABLA pd_transferidos')
go
insert into cl_errores values (351030, 1, 'NO PUEDE REALIZAR OPERACIONES HASTA EL INICIO DE DIA')
go
insert into cl_errores values (351031, 1, 'CHEQUE REMESA YA REGISTRADO')
go
insert into cl_errores values (351032, 1, 'YA SE INGRESARON CHEQUES PARA ESE BANCO')
go
insert into cl_errores values (351036, 1, 'ERROR EN LA CUENTA DEL CHEQUE')
go
insert into cl_errores values (351037, 1, 'ERROR EN EL CURSOR')
go
insert into cl_errores values (351040, 1, 'YA SE INGRESO EL DEPOSITO')
go
insert into cl_errores values (351042, 1, 'CARTA FUERA DEL PERIODO DE CONFIRMACION')
go
insert into cl_errores values (351043, 1, 'FECHA PROCESO Y REVERSO DISTINTAS')
go
insert into cl_errores values (351044, 1, 'CORRESPONSAL SIN CARTAS REMESAS')
go
insert into cl_errores values (351045, 1, 'CUENTA SIN CHEQUES REMESA')
go
insert into cl_errores values (351046, 1, 'OFICINA SIN CHEQUES REMESA')
go
insert into cl_errores values (351050, 1, 'CHEQUE ENTREGADO ANTERIORMENTE')
go
insert into cl_errores values (351051, 1, 'CHEQUE NO ENTREGADO AL CLIENTE')
go
insert into cl_errores values (351052, 1, 'CHEQUE NO PUEDE SER CORREGIDO')
go
insert into cl_errores values (351053, 1, 'CHEQUE REPETIDO')
go
insert into cl_errores values (351056, 1, 'CHEQUE PROCESADO POR OFICIAL SUPERIOR')
go
insert into cl_errores values (351058, 1, 'YA SE ENCUENTRA DEFINIDA LA FORMA DE PAGO')
go
insert into cl_errores values (351060, 1, 'NO SE ENCUENTRA AUTORIZADO PARA PAGOS ELECTRONICOS')
go
insert into cl_errores values (351061, 1, 'FORMA DE PAGO NO PERMITIDA EN HORARIO EXTENDIDO')
go
insert into cl_errores values (351064, 1, 'NO SE HAN DEFINIDO CAUSALES DE DEVOLUCION')
go
insert into cl_errores values (351065, 1, 'ERROR EN TABLA DE CAUSALES DE DEVOLUCION')
go
insert into cl_errores values (351070, 0, 'EL CHEQUE YA SE ENCUENTRA EXTRAVIADO')
go
insert into cl_errores values (351071, 0, 'EL CHEQUE NO SE PUEDE REVERSAR')
go
insert into cl_errores values (351072, 0, 'EL CHEQUE NO SE ENCUENTRA')
go
insert into cl_errores values (351073, 0, 'El codigo ya esta asociado a la(s) oficina(s)')
go
insert into cl_errores values (351074, 0, 'El codigo no esta asociado a la(s) oficina(s)')
go
insert into cl_errores values (351075, 0, 'ERROR CAJA NO APERTURADA')
go
insert into cl_errores values (351076, 0, 'NO SE ENCUENTRA COMO GRAN CONTRIBUYENTE')
go
insert into cl_errores values (351077, 0, 'EL CLIENTE SE ENCUENTRA DEFINIDO COMO GRAN CONTRIBUYENTE')
go
insert into cl_errores values (351085, 1, 'TRANSACCION NO PERMITIDA EN PRUEBA DE DEPOSITO')
go
insert into cl_errores values (351087, 1, 'TRANSACCION DE PIT NO SE PUDO PROCESAR')
go
insert into cl_errores values (351088, 1, 'NO se permite cheques remesas para otros productos')
go
insert into cl_errores values (351089, 1, 'Compromiso de ahorro programado aun vigente')
go
insert into cl_errores values (351090, 1, 'txn NO permitida para chequera inicial envie txn 2715')
go
insert into cl_errores values (351091, 0, 'NO SE PERMITE INGRESO DE TRANSACCIONES CON FECHA DE SABADO')
go
insert into cl_errores values (351093, 0, 'CHEQUE NO HA SIDO BLOQUEADO')
go
insert into cl_errores values (351094, 1, 'CHEQUES ENVIADOS VIA INTERNA NO PUEDEN SER CONFIRMADOS MANUALMENTE')
go
insert into cl_errores values (351096, 0, 'LA CUENTA NO POSEE DEPOSITOS EN REMESAS')
go
insert into cl_errores values (351500, 0, 'Estado no definido')
go
insert into cl_errores values (351505, 0, 'Tipo de dato no es correcto')
go
insert into cl_errores values (351506, 0, 'Tipo de rango no esta vigente')
go
insert into cl_errores values (351516, 0, 'Transaccion no valida')
go
insert into cl_errores values (351517, 0, 'Mercado ya definido')
go
insert into cl_errores values (351519, 0, 'Servicio no esta vigente')
go
insert into cl_errores values (351529, 0, 'Categoria no definida')
go
insert into cl_errores values (351530, 0, 'Rango no definido')
go
insert into cl_errores values (351531, 0, 'Error en busqueda de rubros')
go
insert into cl_errores values (351532, 0, 'Error en busqueda de tipo de rango')
go
insert into cl_errores values (351533, 0, 'Error en busqueda de parametros solicitados de costo')
go
insert into cl_errores values (351534, 0, 'Error en codigo de operacion')
go
insert into cl_errores values (351535, 0, 'Error en tipo de consulta')
go
insert into cl_errores values (351543, 0, 'Costo no se encuentra entre limites')
go
insert into cl_errores values (351544, 0, 'Valor contratado no permitido')
go
insert into cl_errores values (351545, 0, 'Limite maximo no valido')
go
insert into cl_errores values (351549, 0, 'Tipo de variacion no permitido')
go
insert into cl_errores values (351555, 0, 'Limite inferior se encuentra dentro de un rango ya definido')
go
insert into cl_errores values (351556, 0, 'Limite inferior no continuo')
go
insert into cl_errores values (351557, 0, 'Producto Final no es de tipo Persona')
go
insert into cl_errores values (351561, 0, 'Producto final ya definido')
go
insert into cl_errores values (351572, 0, 'Codigo de Transaccion no Homologado')
go
insert into cl_errores values (351575, 0, 'Transaccion no autorizada para esta cuenta')
go
insert into cl_errores values (351576, 0, 'El valor del deposito es menor al pactado')
go
insert into cl_errores values (351577, 0, 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO')
go
insert into cl_errores values (351578, 0, 'PRODUCTO BANCARIO NO PUEDE TENER UN CODIGO SUBTIPO YA UTILIZADO')
go
insert into cl_errores values (352000, 0, 'Error en Ingreso de oficina por tipo de canje')
go
insert into cl_errores values (352003, 0, 'Oficina no tiene definición de  tipo de canje')
go
insert into cl_errores values (352004, 0, ' La Oficina ya posee tipo de canje')
go
insert into cl_errores values (352005, 1, 'Registro solapado')
go
insert into cl_errores values (352006, 0, 'La oficina no tiene tipo de canje CEDEC')
go
insert into cl_errores values (352007, 0, 'La oficina no tiene tipo de canje delegado')
go
insert into cl_errores values (352018, 1, 'BANCO CEDENTE NO TIENE REGISTRADO UN CONVENIO CON EL BANCO AGRARIO')
go
insert into cl_errores values (352019, 1, 'BANCO CEDENTE YA TIENE PARA ESTA FECHA REGISTROS CARGADOS')
go
insert into cl_errores values (352020, 1, 'CHEQUE PROPIO CON CUENTA INCONSISTENTE')
go
insert into cl_errores values (352021, 1, 'BUSQUEDA FINALIZADA')
go
insert into cl_errores values (352025, 0, 'EL CODIGO NO PERTENECE A OFICINA')
go
insert into cl_errores values (352026, 1, 'ERROR LA TRANSACCION SUPERA EL MONTO DEFINIDO SEGUN TITULAR')
go
insert into cl_errores values (352079, 0, 'CONCEPTO DE EXONERACION ES OBLIGATORIO')
go
insert into cl_errores values (352087, 0, 'TIPO DE EXONERACION NO CORRESPONDE A TIPO DE PERSONA')
go
insert into cl_errores values (352088, 0, 'CLIENTE SOLO PUEDE MARCAR UNA CUENTA COMO EXONERADA')
go
insert into cl_errores values (357009, 1, 'HA TERMINADO EL HORARIO DE VISACION')
go
insert into cl_errores values (357014, 1, 'CHEQUE YA HA SIDO BLOQUEADO')
go
insert into cl_errores values (357015, 1, 'CHEQUE YA HA SIDO ACUSADO')
go
insert into cl_errores values (357016, 1, 'CHEQUE NO HA SIDO BLOQUEADO NI DEVUELTO')
go
insert into cl_errores values (357509, 1, 'LA MARCACION DEL SERVICIO DEBE SER CON SI')
go
insert into cl_errores values (357510, 1, 'CLIENTE NO CORRESPONDE CON EL NUMERO DE LA CUENTA')
go
insert into cl_errores values (357511, 1, 'LA CABECERA NO COINCIDE CON LOS DETALLES')
go
insert into cl_errores values (357513, 1, 'CATEGORIA SIN MARCA DE PRODUCTO ESPECIAL')
go
insert into cl_errores values (357514, 1, 'CAUSAL RESTRICTIVA PARA PRODUCTO, NO PERMITE ABONO A CUENTA DE AHORROS')
go
insert into cl_errores values (357516, 0, 'YA EXISTE TOPE PARA PRODUCTO')
go
insert into cl_errores values (357523, 0, 'CUENTA CON FONDOS INSUFICIENTES')
go
insert into cl_errores values (357524, 0, 'CUENTA NO HA SUPERADO TOPE DE RETIROS')
go
insert into cl_errores values (357525, 0, 'CANTIDAD DE RETIROS SUPERA EL MAXIMO PERMITIDO PARA LA CUENTA. SOLICITE AUTORIZACION')
go
insert into cl_errores values (357526, 0, 'VALOR DEL RETIRO SUPERA EL MAXIMO PERMITIDO PARA LA CUENTA. SOLICITE AUTORIZACION')
go
insert into cl_errores values (357536, 0, 'ERROR SOLICITANDO GENERACION DE OTP PARA COMERCIO')
go
insert into cl_errores values (357537, 0, 'ERROR OBTENIENDO DATOS DE CLIENTE COMERCIO')
go
