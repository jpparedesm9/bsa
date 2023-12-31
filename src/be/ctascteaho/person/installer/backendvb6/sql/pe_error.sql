use cobis
go

print 'cl_errores'
/**************************/
/*   PERSONALIZACION      */
/**************************/
/*  Errores de existencia */
/**************************/

go

delete cl_errores where numero between 351000 and 357599

insert into cl_errores values (351003, 1, 'NO EXISTE CARTA REMESA')
insert into cl_errores values (351011, 1, 'NO EXISTE CUENTA GIRADA')
insert into cl_errores values (351012, 1, 'NO EXISTE CUENTA')
insert into cl_errores values (351014, 1, 'NO EXISTE TRANSACCION')
insert into cl_errores values (351015, 1, 'NO EXISTE PRODUCTO BANCARIO')
insert into cl_errores values (351020, 1, 'NO EXISTE EL DEPOSITO')
insert into cl_errores values (351027, 1, 'NO EXISTEN BANCOS')
insert into cl_errores values (351028, 1, 'NO EXISTE EL BANCO')
insert into cl_errores values (351033, 1, 'NO EXISTEN MAS CHQS. DE CAMARA')
insert into cl_errores values (351034, 1, 'NO EXISTEN INGRESOS DE CAMARA')
insert into cl_errores values (351035, 1, 'NO EXISTEN MAS INGRESOS DE CAMARA')
insert into cl_errores values (351038, 1, 'CHEQUE DE CAMARA NO EXISTE')
insert into cl_errores values (351039, 1, 'NO EXISTEN CHQS. PARA TRANSMITIR')
insert into cl_errores values (351041, 1, 'NO EXISTE BANCO CORRESPONSAL')
insert into cl_errores values (351047, 1, 'REGISTRO YA EXISTENTE')
insert into cl_errores values (351048, 1, 'NO EXISTEN REGISTROS SELECCIONADOS')
insert into cl_errores values (351049, 1, 'REGISTRO NO EXISTE')
insert into cl_errores values (351054, 1, 'CHEQUE DE CAJERO INTERNO NO EXISTE')
insert into cl_errores values (351055, 1, 'CHEQUE REMESA NO EXISTE')
insert into cl_errores values (351057, 1, 'YA EXISTE TIPO DE IMPUESTO')
insert into cl_errores values (351059, 1, 'PAQUETE YA EXISTE')
insert into cl_errores values (351062, 1, 'NO EXISTE SECUENCIAL PARA LA OFICINA')
insert into cl_errores values (351066, 1, 'NO EXISTEN DATOS PENDIENTES CON ESE SECUENCIAL')
insert into cl_errores values (351067, 1, 'NO EXISTE CONVENIO DE BANCO CEDENTE')
insert into cl_errores values (351068, 1, 'NO EXISTE EL SECUENCIAL DE CABECERA INGRESADO')
insert into cl_errores values (351069, 1, 'NO EXISTE BANCO CORRESPONSAL PARA ESA RUTA')
insert into cl_errores values (351078, 1, 'NO EXISTE REGISTRO DE TIPO DE CODIGO DE BARRAS')
insert into cl_errores values (351079, 1, 'NO EXISTEN DATOS DE CODIGOS DE BARRAS')
insert into cl_errores values (351080, 1, 'NO EXISTE REGISTRO DE CODIGO DE BARRAS ASOCIADO A TIPO DE IMPUESTO')
insert into cl_errores values (351081, 1, 'NO EXISTEN DATOS DE CODIGOS DE BARRAS ASOCIADOS A IMPUESTOS')
insert into cl_errores values (351082, 1, 'NO SE PUEDE BORRAR PORQUE EXISTEN REGISTROS ASOCIADOS A TIPOS DE IMPUESTOS')
insert into cl_errores values (351083, 1, 'NO EXISTE REGISTRO DE DETALLE DE CODIGO DE BARRAS')
insert into cl_errores values (351084, 1, 'NO EXISTEN DATOS DE DETALLE DE CODIGOS DE BARRAS')
insert into cl_errores values (351086, 1, 'NO EXISTE CODIGO DE TRANSACCION EN DATOS LOCALES')
insert into cl_errores values (351092, 0, 'NO EXISTEN CARTAS REMESAS INGRESADAS HOY')
insert into cl_errores values (351097, 0, 'CUENTA DEBITO DE LA TRANSFERENCIA YA EXISTE')
insert into cl_errores values (351098, 0, 'YA EXISTE TRANSACCION PARA LA CUENTA DE LA TRASFERENCIA')
insert into cl_errores values (351501, 0, 'No existe servicio disponible')
insert into cl_errores values (351502, 0, 'No existe servicio asociado a rubro')
insert into cl_errores values (351503, 0, 'Ya existe servicio asociado a rubro')
insert into cl_errores values (351504, 0, 'No existe atributo')
insert into cl_errores values (351507, 0, 'No existe tipo de rango')
insert into cl_errores values (351508, 0, 'No existe producto bancario')
insert into cl_errores values (351509, 0, 'No existe mercado solicitado')
insert into cl_errores values (351510, 0, 'No existe moneda definida')
insert into cl_errores values (351511, 0, 'No existe mercado definido')
insert into cl_errores values (351512, 0, 'Ya existe servicio personalizable asociado')
insert into cl_errores values (351513, 0, 'No existe producto final asociado')
insert into cl_errores values (351514, 0, 'No existe variacion de servicio')
insert into cl_errores values (351515, 0, 'No existe servicio solicitado')
insert into cl_errores values (351518, 0, 'No existe producto cobis')
insert into cl_errores values (351520, 0, 'No existe valor contratado')
insert into cl_errores values (351521, 0, 'No existe tipo default')
insert into cl_errores values (351522, 0, 'No existe cuenta corriente')
insert into cl_errores values (351523, 0, 'No existe cuenta ahorro')
insert into cl_errores values (351524, 0, 'No existe servicio basico')
insert into cl_errores values (351525, 0, 'No existe signo')
insert into cl_errores values (351526, 0, 'No existe rango solicitado')
insert into cl_errores values (351527, 0, 'No existe producto final')
insert into cl_errores values (351528, 0, 'No existe subservicio')
insert into cl_errores values (351536, 0, 'Producto bancario ya existente')
insert into cl_errores values (351537, 0, 'Servicio personalizable ya existente')
insert into cl_errores values (351538, 0, 'Servicio contratado ya existente')
insert into cl_errores values (351539, 0, 'Existe costo asociado')
insert into cl_errores values (351540, 0, 'No existe servicio personalizable')
insert into cl_errores values (351541, 0, 'No existe limite')
insert into cl_errores values (351542, 0, 'No existe limite para ese servicio y categoria')
insert into cl_errores values (351546, 0, 'Ya existe servicio basico')
insert into cl_errores values (351547, 0, 'Ya existe limite para ese servicio y categoria')
insert into cl_errores values (351548, 0, 'No existe costos para el servicio y categoria dado')
insert into cl_errores values (351551, 0, 'No existe rango en el cual se encuentra el valor a actuar')
insert into cl_errores values (351552, 0, 'No existe costo')
insert into cl_errores values (351553, 0, 'No existe mercado para el producto bancario y el tipo de ente')
insert into cl_errores values (351554, 0, 'No existe valor contratado para la personalizacion dada')
insert into cl_errores values (351559, 0, 'No existe grupo de rango para el tipo ingresado')
insert into cl_errores values (351560, 0, 'Servicio ya existente')
insert into cl_errores values (351562, 0, 'No existe producto moneda')
insert into cl_errores values (351563, 0, 'Ya existe registro de cobro de comision')
insert into cl_errores values (351564, 0, 'No existe registro de cobro de comision')
insert into cl_errores values (351566, 0, 'Ya existe el tipo de capitalizacion para el producto final')
insert into cl_errores values (351568, 0, 'Ya existe el tipo de ciclo para el producto final')
insert into cl_errores values (351567, 1, 'No existe el tipo de capitalizacion para el producto final')
insert into cl_errores values (351569, 1, 'YA EXISTE REGISTRO DE PRODUCTO')
insert into cl_errores values (351570, 1, 'NO EXISTE REGISTRO DE PRODUCTO')
insert into cl_errores values (351571, 1, 'Error Existen Giros de Remesas sin aplicar')
insert into cl_errores values (351579, 0, 'EXISTE RELACIONES VIGENTE CON ESTE SUBTIPO, NO ES POSIBLE CAMBIO DE ESTADO')
insert into cl_errores values (351580, 0, 'NO EXISTE PARAMETRIZACION DE COBRO DE TRN NACIONAL')
insert into cl_errores values (352008, 1, 'YA EXISTE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
insert into cl_errores values (352011, 1, 'YA EXISTE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
insert into cl_errores values (352082, 0, 'NO EXISTEN CONCEPTOS PARAMETRIZADOS')
insert into cl_errores values (357008, 1, 'NO SE PUEDE ELIMINAR REGISTRO, EXISTEN DATOS RELACIONADOS')
insert into cl_errores values (357026, 0, 'ERROR, NO EXISTE REGISTRO A ELIMINAR')
insert into cl_errores values (357515, 1, 'YA EXISTE CATEGORIA PARA PRODUCTO FINAL')
insert into cl_errores values (357516, 0, 'YA EXISTE TOPE PARA PRODUCTO')
insert into cl_errores values (357518, 0, 'NO EXISTE REGISTRO DE TOPE PARA PRODUCTO')
insert into cl_errores values (357528, 1, 'NO EXISTE MARCA DE SERVICIO PARA LA CUENTA Y EL PRODUCTO')
insert into cl_errores values (357529, 1, 'YA EXISTE PARAMETRO PARA MANEJO DE IMPRESION')
insert into cl_errores values (357530, 1, 'NO EXISTE PARAMETRO PARA MANEJO DE IMPRESION ')
insert into cl_errores values (357534, 1, 'ERROR NO EXISTE PRODUCTO FINAL ')
insert into cl_errores values (357535, 1, 'ERROR NO EXISTE  CATEGORIA PARA PRODUCTO FINAL ')

insert into cl_errores values (351573, 1, 'Error Insertando Autorizacion de Transaccion')
insert into cl_errores values (352009, 1, 'ERROR EN INSERCION DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
insert into cl_errores values (352010, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO PARA ESTE SECUENCIAL')
insert into cl_errores values (352012, 1, 'ERROR EN INSERCION DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
insert into cl_errores values (352013, 1, 'ERROR EN INSERCION DE TRANSACCION DE SERVICIO PARA ESTE CONSECUTIVO DE PAQUETE')
insert into cl_errores values (352022, 1, 'ERROR EN INSERCION DE LIQUIDACION DE INTERESES')
insert into cl_errores values (352083, 1, 'ERROR AL INSERTAR CONCEPTO DE EXONERACION')
insert into cl_errores values (353000, 1, 'ERROR AL INSERTAR EN CARTA')
insert into cl_errores values (353001, 1, 'ERROR AL INSERTAR EN DETALLE DE CARTA')
insert into cl_errores values (353002, 1, 'Error al insertar cheque de la carta')
insert into cl_errores values (353003, 1, 'Error al insertar en linea pendiente')
insert into cl_errores values (353004, 1, 'Error al insertar en transaccion de servicio de cuentas corrientes')
insert into cl_errores values (353005, 1, 'Error al insertar en transaccion de servicio de cuentas de ahorros')
insert into cl_errores values (353006, 1, 'Error al insertar el deposito')
insert into cl_errores values (353007, 1, 'Error al insertar el cheque')
insert into cl_errores values (353008, 1, 'Error al insertar el ajuste')
insert into cl_errores values (353009, 1, 'Error al insertar el banco')
insert into cl_errores values (353010, 1, 'Error al insertar cheque remesa')
insert into cl_errores values (353011, 1, 'ERROR AL INSERTAR CHEQUE DEVUELTO')
insert into cl_errores values (353012, 1, 'ERROR AL INSERTAR CHEQUE DE CAMARA')
insert into cl_errores values (353013, 1, 'ERROR AL INSERTAR CABECERA DE CAM.')
insert into cl_errores values (353014, 1, 'ERROR AL INSERTAR OFICINA')
insert into cl_errores values (353015, 1, 'ERROR AL INSERTAR AJUSTE CAJ. INT.')
insert into cl_errores values (353016, 1, 'ERROR AL INSERTAR TRANSACCION A CONTABILIZAR')
insert into cl_errores values (353017, 1, 'ERROR AL INSERTAR VALOR DE RETENCION')
insert into cl_errores values (353018, 1, 'ERROR AL INSERTAR CAMPOS EN LA TABLA DE IMPUESTOS')
insert into cl_errores values (353019, 1, 'ERROR AL INSERTAR FORMAS DE PAGOS')
insert into cl_errores values (353020, 1, 'ERROR AL INSERTAR CAMPOS, HA EXCEDIDO EL NUMERO DE TIPO MONEY')
insert into cl_errores values (353021, 1, 'ERROR AL INSERTAR CAMPOS, HA EXCEDIDO EL NUMERO DE TIPO CATALOGO')
insert into cl_errores values (353022, 1, 'ERROR AL INSERTAR CABECERA DE BANCOS CEDENTES')
insert into cl_errores values (353023, 1, 'ERROR AL INSERTAR EL ESTADO EXTRAVIADO EN EL CHEQUE')
insert into cl_errores values (353024, 1, 'ERROR AL INSERTAR EL TIPO DE CODIGO DE BARRAS')
insert into cl_errores values (353026, 1, 'ERROR AL INSERTAR EL DETALLE DEL CODIGO DE BARRAS')
insert into cl_errores values (353027, 1, 'Error en insercion RE_CATALOGO_OFI')
insert into cl_errores values (353037, 1, 'ERROR AL INSERTAR REGISTRO DE PERSONALIZACION DE NOTA DEBITO/CREDITO')
insert into cl_errores values (353500, 1, 'Error al insertar servicios disponiblesa')
insert into cl_errores values (353501, 1, 'Error al insertar detalles de servicio')
insert into cl_errores values (353502, 1, 'Error al insertar tipo de rango')
insert into cl_errores values (353503, 1, 'Error al insertar rangos')
insert into cl_errores values (353504, 1, 'Error al insertar producto bancario')
insert into cl_errores values (353505, 1, 'Error al insertar mercado ')
insert into cl_errores values (353506, 1, 'Error al insertar producto final ')
insert into cl_errores values (353507, 1, 'Error al insertar servicios personalizable')
insert into cl_errores values (353508, 1, 'Error al insertar servicio contratado ')
insert into cl_errores values (353509, 1, 'Error al insertar valor contratado')
insert into cl_errores values (353510, 1, 'Error al insertar servicio basico')
insert into cl_errores values (353511, 1, 'Error al insertar costo')
insert into cl_errores values (353512, 1, 'Error al insertar cambio costo')
insert into cl_errores values (353513, 1, 'Error al insertar cambio de valor contratado')
insert into cl_errores values (353514, 1, 'Error al insertar limite')
insert into cl_errores values (353515, 1, 'Error al insertar transaccion de servicio')
insert into cl_errores values (353516, 1, 'Error al insertar cobro de comision')
insert into cl_errores values (353517, 1, 'Error al insertar producto Contractual')
insert into cl_errores values (357508, 1, 'ERROR AL INSERTAR REGISTRO DE MARCACION DE SERVICIO')
insert into cl_errores values (357517, 1, 'ERROR AL INSERTAR TOPE PARA PRODUCTO')
insert into cl_errores values (357521, 1, 'ERROR AL INSERTAR AUTORIZACION RETIRO')

insert into cl_errores values (351063, 1, 'ERROR EN ACTUALIZACION DE SECUENCIAL')
insert into cl_errores values (351550, 0, 'No se ha ingresado valor sobre el cual se actua')
insert into cl_errores values (351574, 1, 'Error Actualizando Autorizacion de Transaccion')
insert into cl_errores values (352001, 0, 'Error actualizar en re_oficina_canje')
insert into cl_errores values (352002, 0, 'Error Eliminar en re_oficina_canje')
insert into cl_errores values (352014, 1, 'ERROR EN ACTUALIZACION DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
insert into cl_errores values (352015, 1, 'ERROR EN ACTUALIZACION DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
insert into cl_errores values (352081, 0, 'ERROR AL ACTUALIZAR BASE EXONERACION ')
insert into cl_errores values (352084, 1, 'ERROR AL ACTUALIZAR CONCEPTO DE EXONERACION')
insert into cl_errores values (353518, 0, 'No. de Telefono asociado a Cuenta y Canal. No se puede Actualizar o Eliminar')
insert into cl_errores values (355000, 1, 'Error al actualizar en cheque')
insert into cl_errores values (355001, 1, 'Error al actualizar en carta')
insert into cl_errores values (355002, 1, 'Error al actualizar en cuenta corriente')
insert into cl_errores values (355003, 1, 'Error al actualizar en cuenta de ahorros')
insert into cl_errores values (355004, 1, 'Error al actualizar seqnos')
insert into cl_errores values (355005, 1, 'Error al actualizar caja en cuentas corrientes')
insert into cl_errores values (355006, 1, 'Error al actualizar caja en cuentas de ahorros')
insert into cl_errores values (355007, 1, 'Error al actualizar el sobregiro')
insert into cl_errores values (355008, 1, 'Error al actualizar el cupo de sobregiro del oficial')
insert into cl_errores values (355009, 1, 'Error al actualizar cheque devuelto')
insert into cl_errores values (355010, 1, 'Error al actualizar un cheque')
insert into cl_errores values (355011, 1, 'Error al actualizar un ajuste')
insert into cl_errores values (355012, 1, 'ERROR AL ACTUALIZAR CHQ TRANSFERIDO')
insert into cl_errores values (355013, 1, 'ERROR AL ACTUALIZAR CHQ. DE CAMARA')
insert into cl_errores values (355014, 1, 'ERROR AL ACTUALIZAR CABECERA DE CAM.')
insert into cl_errores values (355015, 1, 'ERROR AL ACTUALIZAR SECUENCIAL DE CHQS. DE CAMARA')
insert into cl_errores values (355016, 1, 'ERROR AL ACTUALIZAR ESTADO DEL INGRESO DE CAMARA')
insert into cl_errores values (355017, 1, 'ERROR CHEQUE CONFIRMADO ANTERIORMENTE')
insert into cl_errores values (355018, 1, 'ERROR CHEQUE RECHAZADO ANTERIORMENTE')
insert into cl_errores values (355019, 1, 'ERROR AL ACTUALIZAR DETALLE DE CARTA')
insert into cl_errores values (355020, 1, 'ERROR AL ACTUALIZAR OFICINAS DEL BANCO')
insert into cl_errores values (355021, 1, 'ERROR AL ACTUALIZAR RE_CAM_PENDIENTE')
insert into cl_errores values (355022, 1, 'ERROR AL ACTUALIZAR INGRESO DEL CHEQUE')
insert into cl_errores values (355023, 1, 'ERROR AL ACTUALIZAR VALOR DE RETENCION')
insert into cl_errores values (355024, 1, 'ERROR AL ACTUALIZAR FORMA DE PAGO DE IMPUESTO')
insert into cl_errores values (355025, 1, 'ERROR AL ACTUALIZAR CAMPO DE IMPUESTO')
insert into cl_errores values (355026, 1, 'ERROR AL ACTUALIZAR BANCO CEDENTE')
insert into cl_errores values (355027, 1, 'ERROR AL PASAR LOS DATOS AL HISTORICO')
insert into cl_errores values (355028, 1, 'ERROR AL ACTUALIZAR EL TIPO DE CODIGO DE BARRAS')
insert into cl_errores values (355029, 1, 'ERROR AL ACTUALIZAR EL REGISTRO ASOCIADO DE CODIGO DE BARRAS A IMPUESTO')
insert into cl_errores values (355030, 1, 'ERROR AL ACTUALIZAR EL DETALLE DEL CODIGO DE BARRAS')
insert into cl_errores values (355031, 1, 'ERROR AL ACTUALIZAR DE ACUSE DE CARTA REMESA')
insert into cl_errores values (355032, 1, 'ERROR EN ACTUALIZACION DE REGISTRO')
insert into cl_errores values (355041, 1, 'ERROR AL ACTUALIZAR EL REGISTRO DE PERSONALIZACION DE NOTA DEBITO/CREDITO')
insert into cl_errores values (355500, 1, 'Error en actualizacion de detalle de servicio')
insert into cl_errores values (355501, 1, 'Error en actualizacion de tipo rango')
insert into cl_errores values (355502, 1, 'Error al actualizar producto bancario')
insert into cl_errores values (355503, 1, 'Error al actualizar estado de mercado')
insert into cl_errores values (355504, 1, 'Error al actualizar estado en serv. bacico')
insert into cl_errores values (355505, 1, 'Error al actualizar mercado')
insert into cl_errores values (355506, 1, 'Error al actualizar producto final')
insert into cl_errores values (355507, 1, 'Error al actualizar servicio personalizable')
insert into cl_errores values (355508, 1, 'Error en eliminar rango')
insert into cl_errores values (355509, 1, 'Error en actualizar servicio disponible')
insert into cl_errores values (355510, 1, 'Error en actualizar valor contratado')
insert into cl_errores values (355511, 1, 'Error en actualizar cambio de valor contratado')
insert into cl_errores values (355512, 1, 'Error en actualizar servicio contratado')
insert into cl_errores values (355513, 1, 'Error en actualizar costo')
insert into cl_errores values (355514, 1, 'Error en actualizar servicio basico')
insert into cl_errores values (355515, 1, 'Error en actualizar cambio costo')
insert into cl_errores values (355516, 1, 'Error en actualizar limite')
insert into cl_errores values (355517, 1, 'Error en actualizar cuenta corriente')
insert into cl_errores values (355518, 1, 'Error en actualizar cuenta de ahorro')
insert into cl_errores values (355519, 1, 'Error en actualizacion de registro')
insert into cl_errores values (355520, 1, 'Error en actualizar producto Contractual')
insert into cl_errores values (357512, 1, 'Error al eliminar Producto Contractual')
insert into cl_errores values (357519, 1, 'ERROR AL ACTUALIZAR TOPE PARA PRODUCTO')
insert into cl_errores values (357522, 1, 'ERROR AL ACTUALIZAR AUTORIZACION RETIRO')
insert into cl_errores values (357531, 1, 'ERROR AL ACTUALIZAR PARAMETRO PARA MANEJO DE IMPRESION ')

insert into cl_errores values (352016, 1, 'ERROR EN BORRADO DE SECUENCIAL PARA ESTE TIPO DE PRODUCTO BANCARIO')
insert into cl_errores values (352017, 1, 'ERROR EN BORRADO DE CONSECUTIVO DE PAQUETE PARA ESTA CLASE Y TIPO DE IMPUESTO')
insert into cl_errores values (352085, 1, 'ERROR AL ELIMINAR CONCEPTO DE EXONERACION')
insert into cl_errores values (353025, 1, 'ERROR AL ASOCIAR EL CODIGO DE BARRAS AL TIPO DE IMPUESTO')
insert into cl_errores values (353028, 1, 'Error en eliminacion RE_CATALOGO_OFI')
insert into cl_errores values (357000, 1, 'Error al borrar la carta')
insert into cl_errores values (357001, 1, 'Error al borrar cheque de remesa')
insert into cl_errores values (357002, 1, 'Error al borrar detalle de la carta')
insert into cl_errores values (357003, 1, 'Error al borrar cheque pendiente de camara')
insert into cl_errores values (357004, 1, 'Error al borrar los bancos')
insert into cl_errores values (357005, 1, 'ERROR AL BORRAR CHEQUE DE CAMARA')
insert into cl_errores values (357006, 1, 'ERROR AL ELIMINAR REGISTRO')
insert into cl_errores values (357007, 1, 'ERROR AL ELIMINAR EL TIPO DE IMPUESTO')
insert into cl_errores values (357010, 1, 'ERROR AL BORRAR EL ESTADO DE LA REMESA')
insert into cl_errores values (357011, 1, 'ERROR AL BORRAR EL TIPO DE CODIGO DE BARRAS')
insert into cl_errores values (357012, 1, 'ERROR AL BORRAR EL TIPO DE CODIGO DE BARRAS ASOCIADO A IMPUESTO')
insert into cl_errores values (357013, 1, 'ERROR AL BORRAR EL DETALLE DEL CODIGO DE BARRAS')
insert into cl_errores values (357500, 1, 'Error al borrar servicio-Tx')
insert into cl_errores values (357501, 1, 'Error al borrar rango')
insert into cl_errores values (357502, 1, 'Error al borrar rango')
insert into cl_errores values (357503, 1, 'Error al eliminar valor contratado')
insert into cl_errores values (357504, 1, 'Error al eliminar producto final')
insert into cl_errores values (357505, 1, 'Error al eliminar servicio personalizable')
insert into cl_errores values (357506, 1, 'Error al eliminar costo')
insert into cl_errores values (357520, 1, 'ERROR AL ELIMINAR TOPE PARA PRODUCTO')
insert into cl_errores values (357527, 1, 'Error al eliminar cobro de comision')
insert into cl_errores values (357533, 1, 'ERROR AL ELIMINAR PARAMETRO PARA MANEJO DE IMPRESION ')

insert into cl_errores values (351000, 1, 'ERROR EN TABLA OFICINA BANCO')
insert into cl_errores values (351001, 1, 'ERROR EN TABLA TRANSITO')
insert into cl_errores values (351002, 1, 'DATOS INCONSISTENTES')
insert into cl_errores values (351004, 1, 'ERROR EN TABLA DE FECHA PROMEDIO')
insert into cl_errores values (351005, 1, 'ERROR EN TABLA DE FECHA PROMEDIO')
insert into cl_errores values (351006, 1, 'ERROR EN TABLA DE CUENTAS CORRIENTES')
insert into cl_errores values (351007, 1, 'ERROR EN MONEDA')
insert into cl_errores values (351008, 1, 'VALOR MAYOR QUE REMESAS')
insert into cl_errores values (351009, 1, 'VALOR MAYOR QUE REMESAS HOY')
insert into cl_errores values (351010, 1, 'ERROR EN TABLA DE CUENTAS DE AHORROS')
insert into cl_errores values (351013, 1, 'NO HAY MAS CHEQUES PENDIENTES')
insert into cl_errores values (351016, 1, 'ERROR EN CURSOR TABLA re_cheque_rem')
insert into cl_errores values (351017, 1, 'ERROR EN SECUENCIAL re_carta')
insert into cl_errores values (351018, 1, 'ERROR EN CURSOR TABLA re_carta')
insert into cl_errores values (351019, 1, 'NUMERO DE TRANSACCION NO VALIDO')
insert into cl_errores values (351021, 1, 'CUENTA INCORRECTA')
insert into cl_errores values (351022, 1, 'VALOR EN EFECTIVO INCORRECTO')
insert into cl_errores values (351023, 1, 'VALOR DE CHQS. PROPIOS INCORRECTO')
insert into cl_errores values (351024, 1, 'VALOR DE CHQS. LOCALES INCORRECTO')
insert into cl_errores values (351025, 1, 'VALOR DE CHQS. REMESAS INCORRECTO')
insert into cl_errores values (351026, 1, 'VALOR TOTAL INCORRECTO')
insert into cl_errores values (351029, 1, 'ERROR CURSOR TABLA pd_transferidos')
insert into cl_errores values (351030, 1, 'NO PUEDE REALIZAR OPERACIONES HASTA EL INICIO DE DIA')
insert into cl_errores values (351031, 1, 'CHEQUE REMESA YA REGISTRADO')
insert into cl_errores values (351032, 1, 'YA SE INGRESARON CHEQUES PARA ESE BANCO')
insert into cl_errores values (351036, 1, 'ERROR EN LA CUENTA DEL CHEQUE')
insert into cl_errores values (351037, 1, 'ERROR EN EL CURSOR')
insert into cl_errores values (351040, 1, 'YA SE INGRESO EL DEPOSITO')
insert into cl_errores values (351042, 1, 'CARTA FUERA DEL PERIODO DE CONFIRMACION')
insert into cl_errores values (351043, 1, 'FECHA PROCESO Y REVERSO DISTINTAS')
insert into cl_errores values (351044, 1, 'CORRESPONSAL SIN CARTAS REMESAS')
insert into cl_errores values (351045, 1, 'CUENTA SIN CHEQUES REMESA')
insert into cl_errores values (351046, 1, 'OFICINA SIN CHEQUES REMESA')
insert into cl_errores values (351050, 1, 'CHEQUE ENTREGADO ANTERIORMENTE')
insert into cl_errores values (351051, 1, 'CHEQUE NO ENTREGADO AL CLIENTE')
insert into cl_errores values (351052, 1, 'CHEQUE NO PUEDE SER CORREGIDO')
insert into cl_errores values (351053, 1, 'CHEQUE REPETIDO')
insert into cl_errores values (351056, 1, 'CHEQUE PROCESADO POR OFICIAL SUPERIOR')
insert into cl_errores values (351058, 1, 'YA SE ENCUENTRA DEFINIDA LA FORMA DE PAGO')
insert into cl_errores values (351060, 1, 'NO SE ENCUENTRA AUTORIZADO PARA PAGOS ELECTRONICOS')
insert into cl_errores values (351061, 1, 'FORMA DE PAGO NO PERMITIDA EN HORARIO EXTENDIDO')
insert into cl_errores values (351064, 1, 'NO SE HAN DEFINIDO CAUSALES DE DEVOLUCION')
insert into cl_errores values (351065, 1, 'ERROR EN TABLA DE CAUSALES DE DEVOLUCION')
insert into cl_errores values (351070, 0, 'EL CHEQUE YA SE ENCUENTRA EXTRAVIADO')
insert into cl_errores values (351071, 0, 'EL CHEQUE NO SE PUEDE REVERSAR')
insert into cl_errores values (351072, 0, 'EL CHEQUE NO SE ENCUENTRA')
insert into cl_errores values (351073, 0, 'El codigo ya esta asociado a la(s) oficina(s)')
insert into cl_errores values (351074, 0, 'El codigo no esta asociado a la(s) oficina(s)')
insert into cl_errores values (351075, 0, 'ERROR CAJA NO APERTURADA')
insert into cl_errores values (351076, 0, 'NO SE ENCUENTRA COMO GRAN CONTRIBUYENTE')
insert into cl_errores values (351077, 0, 'EL CLIENTE SE ENCUENTRA DEFINIDO COMO GRAN CONTRIBUYENTE')
insert into cl_errores values (351085, 1, 'TRANSACCION NO PERMITIDA EN PRUEBA DE DEPOSITO')
insert into cl_errores values (351087, 1, 'TRANSACCION DE PIT NO SE PUDO PROCESAR')
insert into cl_errores values (351088, 1, 'NO se permite cheques remesas para otros productos')
insert into cl_errores values (351089, 1, 'Compromiso de ahorro programado aun vigente')
insert into cl_errores values (351090, 1, 'txn NO permitida para chequera inicial envie txn 2715')
insert into cl_errores values (351091, 0, 'NO SE PERMITE INGRESO DE TRANSACCIONES CON FECHA DE SABADO')
insert into cl_errores values (351093, 0, 'CHEQUE NO HA SIDO BLOQUEADO')
insert into cl_errores values (351094, 1, 'CHEQUES ENVIADOS VIA INTERNA NO PUEDEN SER CONFIRMADOS MANUALMENTE')
insert into cl_errores values (351096, 0, 'LA CUENTA NO POSEE DEPOSITOS EN REMESAS')
insert into cl_errores values (351500, 0, 'Estado no definido')
insert into cl_errores values (351505, 0, 'Tipo de dato no es correcto')
insert into cl_errores values (351506, 0, 'Tipo de rango no esta vigente')
insert into cl_errores values (351516, 0, 'Transaccion no valida')
insert into cl_errores values (351517, 0, 'Mercado ya definido')
insert into cl_errores values (351519, 0, 'Servicio no esta vigente')
insert into cl_errores values (351529, 0, 'Categoria no definida')
insert into cl_errores values (351530, 0, 'Rango no definido')
insert into cl_errores values (351531, 0, 'Error en busqueda de rubros')
insert into cl_errores values (351532, 0, 'Error en busqueda de tipo de rango')
insert into cl_errores values (351533, 0, 'Error en busqueda de parametros solicitados de costo')
insert into cl_errores values (351534, 0, 'Error en codigo de operacion')
insert into cl_errores values (351535, 0, 'Error en tipo de consulta')
insert into cl_errores values (351543, 0, 'Costo no se encuentra entre limites')
insert into cl_errores values (351544, 0, 'Valor contratado no permitido')
insert into cl_errores values (351545, 0, 'Limite maximo no valido')
insert into cl_errores values (351549, 0, 'Tipo de variacion no permitido')
insert into cl_errores values (351555, 0, 'Limite inferior se encuentra dentro de un rango ya definido')
insert into cl_errores values (351556, 0, 'Limite inferior no continuo')
insert into cl_errores values (351557, 0, 'Producto Final no es de tipo Persona')
insert into cl_errores values (351561, 0, 'Producto final ya definido')
insert into cl_errores values (351572, 0, 'Codigo de Transaccion no Homologado')
insert into cl_errores values (351575, 0, 'Transaccion no autorizada para esta cuenta')
insert into cl_errores values (351576, 0, 'El valor del deposito es menor al pactado')
insert into cl_errores values (351577, 0, 'PARAMETRO SUBTIPO TARJETA ES MANDATORIO')
insert into cl_errores values (351578, 0, 'PRODUCTO BANCARIO NO PUEDE TENER UN CODIGO SUBTIPO YA UTILIZADO')
insert into cl_errores values (352000, 0, 'Error en Ingreso de oficina por tipo de canje')
insert into cl_errores values (352003, 0, 'Oficina no tiene definición de  tipo de canje')
insert into cl_errores values (352004, 0, ' La Oficina ya posee tipo de canje')
insert into cl_errores values (352005, 1, 'Registro solapado')
insert into cl_errores values (352006, 0, 'La oficina no tiene tipo de canje CEDEC')
insert into cl_errores values (352007, 0, 'La oficina no tiene tipo de canje delegado')
insert into cl_errores values (352018, 1, 'BANCO CEDENTE NO TIENE REGISTRADO UN CONVENIO CON EL BANCO AGRARIO')
insert into cl_errores values (352019, 1, 'BANCO CEDENTE YA TIENE PARA ESTA FECHA REGISTROS CARGADOS')
insert into cl_errores values (352020, 1, 'CHEQUE PROPIO CON CUENTA INCONSISTENTE')
insert into cl_errores values (352021, 1, 'BUSQUEDA FINALIZADA')
insert into cl_errores values (352025, 0, 'EL CODIGO NO PERTENECE A OFICINA')
insert into cl_errores values (352026, 1, 'ERROR LA TRANSACCION SUPERA EL MONTO DEFINIDO SEGUN TITULAR')
insert into cl_errores values (352079, 0, 'CONCEPTO DE EXONERACION ES OBLIGATORIO')
insert into cl_errores values (352087, 0, 'TIPO DE EXONERACION NO CORRESPONDE A TIPO DE PERSONA')
insert into cl_errores values (352088, 0, 'CLIENTE SOLO PUEDE MARCAR UNA CUENTA COMO EXONERADA')
insert into cl_errores values (357009, 1, 'HA TERMINADO EL HORARIO DE VISACION')
insert into cl_errores values (357014, 1, 'CHEQUE YA HA SIDO BLOQUEADO')
insert into cl_errores values (357015, 1, 'CHEQUE YA HA SIDO ACUSADO')
insert into cl_errores values (357016, 1, 'CHEQUE NO HA SIDO BLOQUEADO NI DEVUELTO')
insert into cl_errores values (357509, 1, 'LA MARCACION DEL SERVICIO DEBE SER CON SI')
insert into cl_errores values (357510, 1, 'CLIENTE NO CORRESPONDE CON EL NUMERO DE LA CUENTA')
insert into cl_errores values (357511, 1, 'LA CABECERA NO COINCIDE CON LOS DETALLES')
insert into cl_errores values (357513, 1, 'CATEGORIA SIN MARCA DE PRODUCTO ESPECIAL')
insert into cl_errores values (357514, 1, 'CAUSAL RESTRICTIVA PARA PRODUCTO, NO PERMITE ABONO A CUENTA DE AHORROS')
insert into cl_errores values (357523, 0, 'CUENTA CON FONDOS INSUFICIENTES')
insert into cl_errores values (357524, 0, 'CUENTA NO HA SUPERADO TOPE DE RETIROS')
insert into cl_errores values (357525, 0, 'CANTIDAD DE RETIROS SUPERA EL MAXIMO PERMITIDO PARA LA CUENTA. SOLICITE AUTORIZACION')
insert into cl_errores values (357526, 0, 'VALOR DEL RETIRO SUPERA EL MAXIMO PERMITIDO PARA LA CUENTA. SOLICITE AUTORIZACION')
insert into cl_errores values (357536, 0, 'ERROR SOLICITANDO GENERACION DE OTP PARA COMERCIO')
insert into cl_errores values (357537, 0, 'ERROR OBTENIENDO DATOS DE CLIENTE COMERCIO')
