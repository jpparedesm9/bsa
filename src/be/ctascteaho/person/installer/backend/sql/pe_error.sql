use cobis
go

print 'cl_errores'
go

set nocount on
go

print 'cl_errores'
/**************************/
/*   PERSONALIZACION      */
/**************************/
/*  Errores de existencia */
/**************************/

go

delete cl_errores where numero in (	351500, 351501, 351502, 351503, 351504, 351505, 351506,
									351507, 351508, 351509, 351510, 351511, 351512, 351513,
									351514, 351515, 351516, 351517, 351518, 351519, 351520,
									351521, 351522, 351523, 351524, 351525, 351526, 351527,
									351528, 351529, 351530, 351531, 351532, 351533, 351534,
									351535, 351536, 351537, 351538, 351539, 351540, 351541,
									351542, 351543, 351544, 351545, 351546, 351547, 351548,
									351549, 351550, 351551, 351552, 351553, 351554, 351555,
									351556, 351557, 351559, 351560, 351561, 351562, 351563,
									351564, 351569, 351570, 351571, 353500, 353501, 353502,
									353503, 353504, 353505, 353506, 353507, 353508, 353509,
									353510, 353511, 353512, 353513, 353514, 353515, 353516,
									353517, 355500, 355501, 355502, 355503, 355504, 355505,
									355506, 355507, 355508, 355509, 355510, 355511, 355512,
									355513, 355514, 355515, 355516, 355517, 355518, 355519,
									355520, 357500, 357501, 357502, 357503, 357504, 357505,
									357506, 357508, 357509, 357510, 357511, 357512, 357513,
									357514, 357515, 357526, 357527, 357550, 357560, 357561,
									357562, 357563, 357564, 357565, 357566, 357567, 357568,
									357569, 357570, 357571, 357572,351566,357529,351134)

insert into cl_errores values (351500, 0,  'Estado no definido')
insert into cl_errores values (351501, 0,  'No existe servicio disponible')
insert into cl_errores values (351502, 0,  'No existe servicio asociado a rubro')
insert into cl_errores values (351503, 0,  'Ya existe servicio asociado a rubro')
insert into cl_errores values (351504, 0,  'No existe atributo')
insert into cl_errores values (351505, 0,  'Tipo de dato no es correcto')
insert into cl_errores values (351506, 0,  'Tipo de rango no esta vigente')
insert into cl_errores values (351507, 0,  'No existe tipo de rango')
insert into cl_errores values (351508, 0,  'No existe producto bancario')
insert into cl_errores values (351509, 0,  'No existe mercado solicitado')
insert into cl_errores values (351510, 0,  'No existe moneda definida')
insert into cl_errores values (351511, 0,  'No existe mercado definido')
insert into cl_errores values (351512, 0,  'Ya existe servicio personalizable asociado')
insert into cl_errores values (351513, 0,  'No existe producto final asociado')
insert into cl_errores values (351514, 0,  'No existe variacion de servicio')
insert into cl_errores values (351515, 0,  'No existe servicio solicitado')
insert into cl_errores values (351516, 0,  'Transaccion no valida')
insert into cl_errores values (351517, 0,  'Ya existe codigo de Producto Final')
insert into cl_errores values (351518, 0,  'No existe producto cobis')
insert into cl_errores values (351519, 0,  'Servicio no esta vigente')
insert into cl_errores values (351520, 0,  'No existe valor contratado')
insert into cl_errores values (351521, 0,  'No existe tipo default')
insert into cl_errores values (351522, 0,  'No existe cuenta corriente')
insert into cl_errores values (351523, 0,  'No existe cuenta ahorro')
insert into cl_errores values (351524, 0,  'No existe servicio basico')
insert into cl_errores values (351525, 0,  'No existe signo')
insert into cl_errores values (351526, 0,  'No existe rango solicitado')
insert into cl_errores values (351527, 0,  'No existe producto final')
insert into cl_errores values (351528, 0,  'No existe subservicio')
insert into cl_errores values (351529, 0,  'Categoria no definida')
insert into cl_errores values (351530, 0,  'Rango no definido')
insert into cl_errores values (351531, 0,  'Error en busqueda de rubros')
insert into cl_errores values (351532, 0,  'Error en busqueda de tipo de rango')
insert into cl_errores values (351533, 0,  'Error en busqueda de parametros solicitados de costo')
insert into cl_errores values (351534, 0,  'Error en codigo de operacion')
insert into cl_errores values (351535, 0,  'Error en tipo de consulta')
insert into cl_errores values (351536, 0,  'Producto bancario ya existente')
insert into cl_errores values (351537, 0,  'Servicio personalizable ya existente')
insert into cl_errores values (351538, 0,  'Servicio contratado ya existente')
insert into cl_errores values (351539, 0,  'Existe costo asociado')
insert into cl_errores values (351540, 0,  'No existe servicio personalizable')
insert into cl_errores values (351541, 0,  'No existe limite')
insert into cl_errores values (351542, 0,  'No existe limite para ese servicio y categoria')
insert into cl_errores values (351543, 0,  'Costo no se encuentra entre limites')
insert into cl_errores values (351544, 0,  'Valor contratado no permitido')
insert into cl_errores values (351545, 0,  'Limite maximo no valido')
insert into cl_errores values (351546, 0,  'Ya existe servicio basico')
insert into cl_errores values (351547, 0,  'Ya existe limite para ese servicio y categoria')
insert into cl_errores values (351548, 0,  'No existe costos para el servicio y categoria dado')
insert into cl_errores values (351549, 0,  'Tipo de variacion no permitido')
insert into cl_errores values (351550, 0,  'No se ha ingresado valor sobre el cual se actua')
insert into cl_errores values (351551, 0,  'No existe rango en el cual se encuentra el valor a actuar')
insert into cl_errores values (351552, 0,  'No existe costo')
insert into cl_errores values (351553, 0,  'No existe mercado para el producto bancario y el tipo de ente')
insert into cl_errores values (351554, 0,  'No existe valor contratado para la personalizacion dada')
insert into cl_errores values (351555, 0,  'Limite inferior se encuentra dentro de un rango ya definido')
insert into cl_errores values (351556, 0,  'Limite inferior no continuo')
insert into cl_errores values (351557, 0,  'Producto Final no es de tipo Persona')
insert into cl_errores values (351559, 0,  'No existe grupo de rango para el tipo ingresado')
insert into cl_errores values (351560, 0,  'Servicio ya existente')
insert into cl_errores values (351561, 0,  'Producto final ya definido')
insert into cl_errores values (351562, 0,  'No existe producto moneda')
insert into cl_errores values (351563, 0,  'Ya existe registro de cobro de comision')
insert into cl_errores values (351564, 0,  'No existe registro de cobro de comision')

insert into cl_errores values (351569, 1,  'YA EXISTE REGISTRO DE PRODUCTO')
insert into cl_errores values (351570, 1,  'NO EXISTE REGISTRO DE PRODUCTO')
insert into cl_errores values (351571, 1,  'Error Existen Giros de Remesas sin aplicar')

insert into cl_errores values (353500, 1,  'Error al insertar servicios disponiblesa')
insert into cl_errores values (353501, 1,  'Error al insertar detalles de servicio')
insert into cl_errores values (353502, 1,  'Error al insertar tipo de rango')
insert into cl_errores values (353503, 1,  'Error al insertar rangos')
insert into cl_errores values (353504, 1,  'Error al insertar producto bancario')
insert into cl_errores values (353505, 1,  'Error al insertar mercado ')
insert into cl_errores values (353506, 1,  'Error al insertar producto final ')
insert into cl_errores values (353507, 1,  'Error al insertar servicios personalizable')
insert into cl_errores values (353508, 1,  'Error al insertar servicio contratado ')
insert into cl_errores values (353509, 1,  'Error al insertar valor contratado')
insert into cl_errores values (353510, 1,  'Error al insertar servicio basico')
insert into cl_errores values (353511, 1,  'Error al insertar costo')
insert into cl_errores values (353512, 1,  'Error al insertar cambio costo')
insert into cl_errores values (353513, 1,  'Error al insertar cambio de valor contratado')
insert into cl_errores values (353514, 1,  'Error al insertar limite')
insert into cl_errores values (353515, 1,  'Error al insertar transaccion de servicio')
insert into cl_errores values (353516, 1,  'Error al insertar cobro de comision')
insert into cl_errores values (353517, 1,  'Error al insertar producto Contractual')

insert into cl_errores values (355500, 1,  'Error en actualizacion de detalle de servicio')
insert into cl_errores values (355501, 1,  'Error en actualizacion de tipo rango')
insert into cl_errores values (355502, 1,  'Error al actualizar producto bancario')
insert into cl_errores values (355503, 1,  'Error al actualizar estado de mercado')
insert into cl_errores values (355504, 1,  'Error al actualizar estado en serv. bacico')
insert into cl_errores values (355505, 1,  'Error al actualizar mercado')
insert into cl_errores values (355506, 1,  'Error al actualizar producto final')
insert into cl_errores values (355507, 1,  'Error al actualizar servicio personalizable')
insert into cl_errores values (355508, 1,  'Error en eliminar rango')
insert into cl_errores values (355509, 1,  'Error en actualizar servicio disponible')
insert into cl_errores values (355510, 1,  'Error en actualizar valor contratado')
insert into cl_errores values (355511, 1,  'Error en actualizar cambio de valor contratado')
insert into cl_errores values (355512, 1,  'Error en actualizar servicio contratado')
insert into cl_errores values (355513, 1,  'Error en actualizar costo')
insert into cl_errores values (355514, 1,  'Error en actualizar servicio basico')
insert into cl_errores values (355515, 1,  'Error en actualizar cambio costo')
insert into cl_errores values (355516, 1,  'Error en actualizar limite')
insert into cl_errores values (355517, 1,  'Error en actualizar cuenta corriente')
insert into cl_errores values (355518, 1,  'Error en actualizar cuenta de ahorro')
insert into cl_errores values (355519, 1,  'Error en actualizacion de registro')
insert into cl_errores values (355520, 1,  'Error en actualizar producto Contractual')

insert into cl_errores values (357500, 1,  'Error al borrar servicio-Tx')
insert into cl_errores values (357501, 1,  'Error al borrar rango')
insert into cl_errores values (357502, 1,  'Error al borrar rango')
insert into cl_errores values (357503, 1,  'Error al eliminar valor contratado')
insert into cl_errores values (357504, 1,  'Error al eliminar producto final')
insert into cl_errores values (357505, 1,  'Error al eliminar servicio personalizable')
insert into cl_errores values (357506, 1,  'Error al eliminar costo')

insert into cl_errores values (357508, 1,  'ERROR AL INSERTAR REGISTRO DE MARCACION DE SERVICIO')
insert into cl_errores values (357509, 1,  'LA MARCACION DEL SERVICIO DEBE SER CON SI')
insert into cl_errores values (357510, 1,  'CLIENTE NO CORRESPONDE CON EL NUMERO DE LA CUENTA')
insert into cl_errores values (357511, 1,  'LA CABECERA NO COINCIDE CON LOS DETALLES')
insert into cl_errores values (357512, 1,  'Error al eliminar Producto Contractual')
insert into cl_errores values (357513, 1,  'CATEGORIA SIN MARCA DE PRODUCTO ESPECIAL')
insert into cl_errores values (357514, 1,  'CAUSAL RESTRICTIVA PARA PRODUCTO')
insert into cl_errores values (357515, 1,  'YA EXISTE CATEGORIA PARA PRODUCTO FINAL')

insert into cl_errores values (357526, 0,  'VALOR DEL RETIRO SUPERA EL MAXIMO PERMITIDO PARA LA CUENTA. SOLICITE AUTORIZACION')
insert into cl_errores values (357527, 1,  'Error al eliminar cobro de comision')
insert into cl_errores values (357550, 0, 'Debe ingresar una cuenta diferente a estado Ingresado')
insert into cl_errores values (357560, 0, 'NO EXISTE RANGO DE FECHA')

insert into cl_errores values (357561, 0, 'ERROR - DEPENDENCIA CIRCULAR EN PRODUCTO FINAL')
insert into cl_errores values (357562, 0, 'PRODUCTO BANCARIO NO PERMITE BLOQUEO DE MOVIMIENTOS')
insert into cl_errores values (357563, 0, 'CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA')
insert into cl_errores values (357564, 0, 'NO EXISTE PRODUCTO FINAL DEPENDIENTE')
insert into cl_errores values (357565, 0, 'NO EXISTE MERCADO PARA PRODUCTO FINAL DEPENDIENTE')
insert into cl_errores values (357566, 0, 'NO EXISTE PRODUCTO BANCARIO DEPENDIENTE')
insert into cl_errores values (357567, 0, 'PRODUCTO BANCARIO NO PERMITE ACTIVACION')
insert into cl_errores values (357568, 0, 'MONTO DE APORTE SOCIAL NO EXISTE')
insert into cl_errores values (357569, 0, 'MONTO DEPOSITADO ES SUPERIOR A MONTO MÁXIMO ESTABLECIDO')
insert into cl_errores values (357570, 0, 'PRODUCTO APORTE SOCIAL NO PUEDE SER MAYOR A MONTO APORTE SOCIAL')
insert into cl_errores values (357571, 0, 'CLIENTE POSEE CREDITOS VIGENTES CON BLOQUEOS')
insert into cl_errores values (357572, 0, 'NO SE PUDO REALIZAR BLOQUEO EN CUENTA DE APORTE SOCIAL')
insert into cl_errores values (351566, 0, 'Ya existe el tipo de capitalización para el producto final')
insert into cl_errores values (357529, 1, 'EL CONTRATO YA SE ENCUENTRA REGISTRADO PARA PRODUCTO BANCARIO')
INSERT INTO cl_errores VALUES (351134, 0, 'El registro no tuvo modificacciones')

go