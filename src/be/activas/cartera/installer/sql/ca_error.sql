/************************************************************************/
/*                                                                      */
/*                            COBIS - CARTERA                           */
/*                              ABRIL 2009                              */
/*                                                                      */
/************************************************************************/
/*                 MENSAJES DE ERROR DEL MODULO DE CARTERA              */
/************************************************************************/

use cobis
go

set nocount on

print 'cl_errores'
delete cl_errores where numero in (701000,701001,701002,701003,701004,701005,701006,701007,701008,701009,701010,
                                    701011,701012,701013,701014,701015,701016,701017,701018,701019,701020,701021,724592,724594,724590,724595,724596,724597,701220,701221,701222,701223,701224,
									70068,70069,70070,70071,70072,70073,70011018, 70076)
go

insert into cl_errores values (701220, 0, 'NO SE PUEDE REVERSAR UN PAGO QUE TIENE COMO ORIGEN UNA RENOVACION')
insert into cl_errores values (701000, 1, 'No existe Tipo de Plazo')
insert into cl_errores values (701001, 1, 'No existe Nivel de Aprobación')
insert into cl_errores values (701002, 1, 'No existe Tipo de Operación')
insert into cl_errores values (701003, 1, 'No existe Rubro')
insert into cl_errores values (701004, 1, 'No existe Rol en Operación de Cartera')
insert into cl_errores values (701005, 1, 'No existe Tipo de Vencimiento')
insert into cl_errores values (701006, 1, 'Existe referencia en Rubro por Operación')
insert into cl_errores values (701007, 1, 'Existe Referencia en Operación')
insert into cl_errores values (701008, 1, 'Numero de Cuotas debe ser diferente de 0')
insert into cl_errores values (701009, 1, 'No existe Rubro por Operación')
insert into cl_errores values (701010, 1, 'Operación no vigente, cancelada o castigada')
insert into cl_errores values (701011, 1, 'Categoria de Cuenta incorrecta')
insert into cl_errores values (701012, 1, 'No existe parametro para cheque de gerencia')
insert into cl_errores values (701013, 1, 'No existe operación activa de cartera')
insert into cl_errores values (701014, 1, 'Codigo de Transacción invalido')
insert into cl_errores values (701015, 1, 'No existe parametro para cobro honorario de abogado')
insert into cl_errores values (701016, 1, 'No existe Linea de Credito')
insert into cl_errores values (701017, 1, 'Existe referencia en Linea de Credito por Tipo de Operación')
insert into cl_errores values (701018, 1, 'No existe Tipo de Documento')
insert into cl_errores values (701019, 1, 'No existe asignación a abogado, no se puede obtener el porcentaje de honorarios')
insert into cl_errores values (701020, 1, 'No existe Tipo de Operación en Linea de Crédito')
insert into cl_errores values (701021, 1, 'No existe Renovación para Linea de Crédito dada')
insert into cl_errores values (701221, 0, 'No existen mas operaciones')
insert into cl_errores values (701222, 0, 'Para búsqueda por oficina ingresar (fecha de desembolso)')
insert into cl_errores values (701223, 0, 'Para búsqueda por oficial ingresar (fecha desembolso)')
insert into cl_errores values (701224, 0, 'Ingrese al menos un criterio de busqueda principal')
go
delete cl_errores where numero in (701022,701023,701024,701025,701026,701027,701028,701029,701030,701031,701032,701033,701034,701035,701036,
                                   701037,701038,701039,701040,701041,701042,701043,701044,701045,701046,701047,701048,701049,701050)
go
insert into cl_errores values (701022, 1, 'Existe referencia en Renovación de Linea de Crédito')
insert into cl_errores values (701023, 1, 'No existe Transacción')
insert into cl_errores values (701024, 1, 'Plazo de la operación por fuera del rango permitido por la línea de crédito')
insert into cl_errores values (701025, 1, 'Operación no existe o Estado No acepta pagos')
insert into cl_errores values (701026, 1, 'La propiedad es de garantia cerrada y ya se ha usado')
insert into cl_errores values (701027, 1, 'Monto de la operación por fuera del rango permitido por la línea de crédito')
insert into cl_errores values (701028, 1, 'No existe dato en Linea Moneda')
insert into cl_errores values (701029, 1, 'Monto Distribuido excede Monto Asignado')
insert into cl_errores values (701030, 1, 'Linea de Crédito no permite Renovaciones')
insert into cl_errores values (701031, 1, 'Existe refencia en Garantia')
insert into cl_errores values (701032, 1, 'Monto de Garantia excede valor de Propiedad')
insert into cl_errores values (701033, 1, 'No existe Referencia en Garantia')
insert into cl_errores values (701034, 1, 'No existe Oficina en ca_conversion')
insert into cl_errores values (701035, 1, 'No se puede determinar si la Linea de Crédito es para Grupo o Cliente')
insert into cl_errores values (701036, 1, 'No existe Tipo de Calificación')
insert into cl_errores values (701037, 1, 'El cliente no puede ser su propio Garante')
insert into cl_errores values (701038, 1, 'No se permite Garantia Ciclica')
insert into cl_errores values (701039, 1, 'No existe Garante para Operación')
insert into cl_errores values (701040, 1, 'No existe Documento de Garantia')
insert into cl_errores values (701041, 1, 'Monto de Operación supera Nivel de Aprobación')
insert into cl_errores values (701042, 1, 'Cuentas Corrientes no esta instalado')
insert into cl_errores values (701043, 1, 'La Cuenta no existe o no esta activa')
insert into cl_errores values (701044, 1, 'Cuentas de Ahorros no esta instalado')
insert into cl_errores values (701045, 1, 'No existe Cuenta de Ahorros')
insert into cl_errores values (701046, 1, 'Codigo de Transaccion no corresponde')
insert into cl_errores values (701047, 1, 'No existe Detalle de Producto para Operación')
insert into cl_errores values (701048, 1, 'No existe Rol')
insert into cl_errores values (701049, 1, 'No existe Operación')
insert into cl_errores values (701050, 1, 'No existe Operación Temporal')
go
delete cl_errores where numero in (701051,701052,701053,701054,701055,701056,701057,701058,701059,701060)
go
insert into cl_errores values (701051, 1, 'No existe Gerente')
insert into cl_errores values (701052, 1, 'No existe Relacion de Deudor')
insert into cl_errores values (701053, 1, 'No existe Relacion de Codeudor')
insert into cl_errores values (701054, 1, 'No existe Codigo de Cliente del Banco')
insert into cl_errores values (701055, 1, 'Error en la Determinacion de Default para Moneda')
insert into cl_errores values (701056, 1, 'Existe dependencia en Operaciones de moneda de linea de credito')
insert into cl_errores values (701057, 1, 'No existen documentos en Tabla Temporal')
insert into cl_errores values (701058, 1, 'Error al Deteminar rubro Capital')
insert into cl_errores values (701059, 1, 'No existe Codigo de Interes en Parametros Generales')
insert into cl_errores values (701060, 1, 'No existe Codigo de Capital en Parametros Generales')
go
delete cl_errores where numero in (701061,701062,701063,701064,701065,701066,701067,701068,701069,701070,
                                   701071,701072,701073,701074,701075,701076,701077,701078,701079,701080)
go
insert into cl_errores values (701061, 1, 'Error en la determinacion del plazo de Capital')
insert into cl_errores values (701062, 1, 'Error en la determinacion del plazo de Interes')
insert into cl_errores values (701063, 1, 'No existe Codigo de Garante')
insert into cl_errores values (701064, 1, 'No existe Relacion de Garante')
insert into cl_errores values (701065, 1, 'No existe Cupo asociado')
insert into cl_errores values (701066, 1, 'No existe Parametro de Documentos Descontados')
insert into cl_errores values (701067, 1, 'No se puede determinar numero de dias del anio')
insert into cl_errores values (701068, 1, 'La fecha no es laborable')
insert into cl_errores values (701069, 1, 'No existe moneda')
insert into cl_errores values (701070, 1, 'No existe cotizacion definida')
insert into cl_errores values (701071, 1, 'No existe la cuenta contable')
insert into cl_errores values (701072, 1, 'No existe Transaccion')
insert into cl_errores values (701073, 1, 'No existe Distribucion de Linea de Credito')
insert into cl_errores values (701074, 1, 'No existe cupo en Linea de Credito')
insert into cl_errores values (701075, 1, 'No hay fondos suficientes en esta cuenta')
insert into cl_errores values (701076, 1, 'Error en la determinacion de Filial')
insert into cl_errores values (701077, 1, 'No se pudo hacer Nota de Credito a Cuenta Corriente')
insert into cl_errores values (701078, 1, 'No se pudo hacer Nota de Credito a Cuenta de Ahorros')
insert into cl_errores values (701079, 1, 'No se pudo crear Comprobante Temporal')
insert into cl_errores values (701080, 1, 'No se pudo crear Asiento Temporal')
go
delete cl_errores where numero in (701081,701082,701083,701084,701085,701086,701087,701088,701089,701090,
                                   701091,701092,701093,701094,701095,701096,701097,701098,701099,701100,701101,
                                   701102,701103,701104,701105,701106,701107,701108,701109,701110,701111,701112)
go
insert into cl_errores values (701081, 1, 'No se pudo crear Comprobante Definitivo')
insert into cl_errores values (701082, 1, 'No existe Codigo de FECI en Parametros Generales')
insert into cl_errores values (701083, 1, 'Tipo de Cuota no existe o no esta en vigencia')
insert into cl_errores values (701084, 1, 'No existe Codigo de Interes de Mora en Parametros Generales')
insert into cl_errores values (701085, 1, 'No existe Valor Referencial')
insert into cl_errores values (701086, 1, 'No existe Modalidad')
insert into cl_errores values (701087, 1, 'No existe Solicitud')
insert into cl_errores values (701088, 1, 'No existe Ente')
insert into cl_errores values (701089, 1, 'No existe Comentario')
insert into cl_errores values (701090, 1, 'No existe Requisito de Etapa')
insert into cl_errores values (701091, 1, 'No existe Requisito de Solicitud')
insert into cl_errores values (701092, 1, 'No existe Calificacion')
insert into cl_errores values (701093, 1, 'No existe Problema Potencial')
insert into cl_errores values (701094, 1, 'No existe Visita')
insert into cl_errores values (701095, 1, 'El producto Depositos a Plazo no esta instalado')
insert into cl_errores values (701096, 1, 'No existe operación de Plazo Fijo')
insert into cl_errores values (701097, 1, 'No existe parametro para cuotas de vencimiento')
insert into cl_errores values (701098, 1, 'No existe balance para este cliente')
insert into cl_errores values (701099, 1, 'No existen cuentas asociadas a este tipo de balance')
insert into cl_errores values (701100, 1, 'No existe esa Cuota para esta operación')
insert into cl_errores values (701101, 1, 'No se puede cambiar los dias de gracia de cuotas en mora')
insert into cl_errores values (701102, 1, 'No existe oficina')
insert into cl_errores values (701103, 1, 'No existe dividendo')
insert into cl_errores values (701104, 1, 'Esta solicitud ha sido rechazada previamente')
insert into cl_errores values (701105, 1, 'Esta solicitud ha sido aprobada previamente')
insert into cl_errores values (701106, 1, 'Ya se ha creado Comprobante Contable de esta operación')
insert into cl_errores values (701107, 1, 'Operación ya Contabilizada')
insert into cl_errores values (701108, 1, 'Esta operación requiere ser reajustada')
insert into cl_errores values (701109, 1, 'La cuenta contable 0 no es admisible')
insert into cl_errores values (701110, 1, 'No existe default para el Tipo de Operación')
insert into cl_errores values (701111, 1, 'No existe producto - retencion definido')
insert into cl_errores values (701112, 1, 'Informacion de plazo incompleta')
go
delete cl_errores where numero in (701113,701114,701115,701116,701117,701118,701119,701120,
                                   701121,701122,701123,701124,701125,701126,701127,701128)
go
insert into cl_errores values (701113, 1, 'Cuota Analizada No Amortiza el Préstamo')
insert into cl_errores values (701114, 1, 'Datos inconsistentes')
insert into cl_errores values (701115, 1, 'Gracia es Mayor que el Plazo')
insert into cl_errores values (701116, 1, 'No existe este producto en interface contable')
insert into cl_errores values (701117, 1, 'El estado de la operación no admite Pagos.')
insert into cl_errores values (701118, 1, 'Error al consultar la Cuota')
insert into cl_errores values (701119, 1, 'No existe Registro de Abono')
insert into cl_errores values (701120, 1, 'No existe Amortizacion')
insert into cl_errores values (701121, 1, 'No existe Desembolso')
insert into cl_errores values (701122, 1, 'Valor a desembolsar supera al valor a liquidar')
insert into cl_errores values (701123, 1, 'Operación no soportada')
insert into cl_errores values (701124, 1, 'El Abono es negativo o excede el monto de Cancelacion')  
insert into cl_errores values (701125, 1, 'No existe Cabecera Contable')
insert into cl_errores values (701126, 1, 'No existe Detalle Contable')
insert into cl_errores values (701127, 1, 'No se han definido transacciones contables')
insert into cl_errores values (701128, 1, 'Abono Excede Cuota de Cancelacion')
go
delete cl_errores where numero in (701129,701130,701131,701132,701133,701134,701135,701136,701137,
                                   701138,701139,701140,701141,701142,701143,701144,701145,701146,701147,
                                   701148,701149,701150,701151,701152,701153,701154,701155,701156,701157,
                                   701158,701159,701160,701161,701162,701163,701164,701165,701166,701168,
                                   701169,701170,701171,701172,701173,701174,701175,701176,701177,701178,
                                   701179,701180,701181,701182,701183,701184,701185,701186,701187,701188)
go
insert into cl_errores values (701129, 1, 'No Existe Rubro de Capital')
insert into cl_errores values (701130, 1, 'No Existe Rubro de Interes')
insert into cl_errores values (701131, 1, 'No Existe Rubro de MORA')
insert into cl_errores values (701132, 1, 'Operación No acepta Reajustes')
insert into cl_errores values (701133, 1, 'No Existe Abono Pendiente')
insert into cl_errores values (701134, 1, 'Error En Producto de Abono Pendiente')
insert into cl_errores values (701135, 1, 'Error Liquidacion tiene Fecha Anterior a la Fecha Actual')
insert into cl_errores values (701136, 1, 'Error Liquidacion No es Retroactiva')
insert into cl_errores values (701137, 1, 'Error Vencimiento Menor a Fecha Actual, Operación No Soportada por El Sistema')
insert into cl_errores values (701138, 1, 'Error la Cuenta de Pagos no esta activa ')
insert into cl_errores values (701139, 1, 'Gracia Debe Ser Mayor Que Cero')
insert into cl_errores values (701140, 1, 'Solo se Permiten Movimientos posteriores al Ultimo Periodo Contable')
insert into cl_errores values (701141, 1, 'Error al determinar fecha de la Reversion')
insert into cl_errores values (701142, 1, 'No existe Valor a Aplicar')
insert into cl_errores values (701143, 1, 'Error en Calculo')
insert into cl_errores values (701144, 1, 'No existe cod. de departamento de Cartera definido dentro de los parametros')
insert into cl_errores values (701145, 1, 'No existe concepto seleccionado')
insert into cl_errores values (701146, 1, 'Ya existe concepto')
insert into cl_errores values (701147, 1, 'Ya existe codigo valor de concepto')
insert into cl_errores values (701148, 1, 'No existe perfil contable')
insert into cl_errores values (701149, 1, 'No existe codigo valor en perfil contable')
insert into cl_errores values (701150, 1, 'No existe codigo valor en forma de pago')
insert into cl_errores values (701151, 1, 'No existe codigo valor en producto')
insert into cl_errores values (701152, 1, 'No hay pagos pendientes para esta fecha')
insert into cl_errores values (701153, 1, 'Login/Password incorrectos')
insert into cl_errores values (701154, 1, 'Usuario no tiene autorizacion para cambio valor rubro') 
insert into cl_errores values (701155, 1, 'Registro a ingresar ya existe') 
insert into cl_errores values (701156, 1, 'Registro a actualizar no existe') 
insert into cl_errores values (701157, 1, 'Registro a eliminar no existe') 
insert into cl_errores values (701158, 1, 'Perfil contable no existe') 
insert into cl_errores values (701159, 1, 'Tipo de dividendo no definido')
insert into cl_errores values (701160, 1, 'Relacion ya existe')
insert into cl_errores values (701161, 1, 'Relacion a eliminar no existe')
insert into cl_errores values (701162, 1, 'No existe tasa a aplicar para el tipo de banca')
insert into cl_errores values (701163, 1, 'Debe eliminar el rubro para actualizarlo en una misma fecha')
insert into cl_errores values (701164, 1, 'No existe codigo de usuario')
insert into cl_errores values (701165, 1, 'Operación no permite desembolsos parciales, por ser tabla de amortizacion Manual')
insert into cl_errores values (701166, 1, 'No existe relación entre RPA y el tipo de operación. Verificar Asignacion de Perfiles por Operación')
insert into cl_errores values (701168, 1, 'No existe perfil contable para la transacción de desembolsos parciales para esta operación')
insert into cl_errores values (701169, 1, 'Esta operación ya fue enviada a colateral')
insert into cl_errores values (701170, 1, 'Esta operación no esta en colaterales')
insert into cl_errores values (701171, 1, 'Ya contabilizado en dias anteriores')
insert into cl_errores values (701172, 1, 'Ya existe un registro igual al ingresado en el detalle de Transacciones')
insert into cl_errores values (701173, 1, 'Existen operaciones asociadas al tramite de la operación de renovacion que no han sido canceladas')
insert into cl_errores values (701174, 1, 'No existen abonos pendientes')
insert into cl_errores values (701175, 1, 'No existe fecha de cierre para Cartera')
insert into cl_errores values (701176, 1, 'Ya existe Tasa Referencial')
insert into cl_errores values (701177, 1, 'No existe Tasa Referencial a la fecha')
insert into cl_errores values (701178, 1, 'No existe Tasa Referencial Seleccionada')
insert into cl_errores values (701179, 1, 'No existe Dividendo VIGENTE') /*AUMENTADO*/
insert into cl_errores values (701180, 1, 'Excede el maximo de dias de gracia para la Mora') /*AUMENTADO*/
insert into cl_errores values (701181, 1, 'Monto de Desembolso en Cartera excede el valor registrado de Credito..cr_desembolso') /*AUMENTADO*/
insert into cl_errores values (701182, 1, 'LA OPERACION ADMITE SOLO UN CAMBIO DE FECHA POR CUOTA')
insert into cl_errores values (701183, 1, 'SE SUPERO EL LIMITE DE CAMBIOS DE FECHA POR OPERACION')
insert into cl_errores values (701184, 1, 'SE SUPERO EL LIMITE DE DIAS DE CORRIMIENTO DE LA FECHA DE CORRIMIENTO')
insert into cl_errores values (701185, 1, 'ERROR EN EL PROCESO')
insert into cl_errores values (701186, 1, 'DIA DE VENCIMIENTO POR FUERA DEL RANGO PERMITIDO --> DIMIVE - DIMAVE')
insert into cl_errores values (701187, 1, 'No existe tramite para la operacion')
insert into cl_errores values (701188, 1, 'No existe Código y Fecha de Matriz o Matriz no esta Parametrizada')
go
delete cl_errores where numero in (701189,701190)
go
insert into cl_errores values (701189,1,'No se permite cambio de deudores en operaciones activas vigentes')
go                                                                                                                          
insert into cl_errores values (701190,1,'No se permite precancelar la operacion')
go                                                                                                                                                    

print 'Errores de insercion'
go
delete cl_errores where numero in (703000,703001,703003,703006,703007,703009,703011,703012,703013,703014)
go
insert into cl_errores values (703000, 1, 'Error en creacion de Tipo de Plazo')
insert into cl_errores values (703001, 1, 'Error en creacion de Nivel de Aprobacion')
insert into cl_errores values (703003, 1, 'Error rubro ya existe')
insert into cl_errores values (703006, 1, 'Error en creacion de Rubro por Operacion')
insert into cl_errores values (703007, 1, 'Error en creacion de Operacion')
insert into cl_errores values (703009, 1, 'Error en creacion de Transaccion de Servicio')
insert into cl_errores values (703011, 1, 'Error en creacion de Linea de Credito')
insert into cl_errores values (703012, 1, 'Error en creacion de Tipo de Operacion por Linea de Credito')
insert into cl_errores values (703013, 1, 'Error en creacion de la Renovacion de una Linea de Credito')
insert into cl_errores values (703014, 1, 'Error en creacion de Transicion')
go
delete cl_errores where numero in (703015,703016,703017,703018,703019,703020,703021,703022,703023,
                                   703024,703025,703026,703027,703028,703029,703030,703031,703032,
                                   703033,703034,703035,703036,703037,703038,703039,703040,703041,
                                   703042,703043,703044,703045,703046,703047,703048,703049,703050)
go
insert into cl_errores values (703015, 1, 'Error en creacion de Moneda por Linea de Credito')
insert into cl_errores values (703016, 1, 'Error en creacion de Operacion Moneda')
insert into cl_errores values (703017, 1, 'Error en creacion de Garantia')
insert into cl_errores values (703018, 1, 'Error en creacion de Calificacion')
insert into cl_errores values (703019, 1, 'Error en insercion de Garante')
insert into cl_errores values (703020, 1, 'Error en creacion de Documento de Garantia')
insert into cl_errores values (703021, 1, 'Error en creacion de Linea de Credito temporal')
insert into cl_errores values (703022, 1, 'Error en creacion de Linea Moneda Temporal')
insert into cl_errores values (703023, 1, 'Error en creacion de Cliente Temporal')
insert into cl_errores values (703024, 1, 'Error en creacion de Instancia de Relacion')
insert into cl_errores values (703025, 1, 'Error en creacion de Rubro de Operacion Temporal')
insert into cl_errores values (703026, 1, 'Error en creacion de Operacion Temporal')
insert into cl_errores values (703027, 1, 'Error en creacion de Detalle de Producto')
insert into cl_errores values (703028, 1, 'Error en creacion de Cliente')
insert into cl_errores values (703029, 1, 'Error en creacion de Rubro de Operacion')
insert into cl_errores values (703030, 1, 'Error en creacion de Operacion de Linea temporal')
insert into cl_errores values (703031, 1, 'Error en creacion de Moneda de Operacion de Linea temporal')
insert into cl_errores values (703032, 1, 'Error en creacion de Operacion de Linea')
insert into cl_errores values (703033, 1, 'Error en creacion de Documento Temporal')
insert into cl_errores values (703034, 1, 'Error en creacion de Documento')
insert into cl_errores values (703035, 1, 'Error en creacion de Cupo de Gerente')
insert into cl_errores values (703036, 1, 'Error en creacion de Tabla de Amortizacion Temporal')
insert into cl_errores values (703037, 1, 'Error en creacion de Tabla Amortizacion')
insert into cl_errores values (703038, 1, 'Error en creacion de Tipo de Cuota')
insert into cl_errores values (703039, 1, 'Error en creacion de Renovacion')
insert into cl_errores values (703040, 1, 'Error en creacion de Cuenta Contable')
insert into cl_errores values (703041, 1, 'Error en creacion de Transaccion')
insert into cl_errores values (703042, 1, 'Error en creacion de Registro Diario')
insert into cl_errores values (703043, 1, 'Error en creacion de Transaccion del Dia')
insert into cl_errores values (703044, 1, 'Error en amortizacion de Rubro')
insert into cl_errores values (703045, 1, 'Error en creacion de Solicitud')
insert into cl_errores values (703046, 1, 'Error en creacion de Historico de Solicitud')
insert into cl_errores values (703047, 1, 'Error en creacion de Historico de Operacion')
insert into cl_errores values (703048, 1, 'Error en creacion de Comentario de Solicitud')
insert into cl_errores values (703049, 1, 'Error en creacion de Historial Crediticio')
insert into cl_errores values (703050, 1, 'Error en creacion de Causa de Aprobacion')
go
delete cl_errores where numero in (703051,703052,703053,703054,703055,703056,703057,703058,703059,703060,703061,
                                   703062,703063,703064,703065,703066,703067,703068,703069,703070,703071,703072)
go
insert into cl_errores values (703051, 1, 'Error en creacion de Requisto de Etapa')
insert into cl_errores values (703052, 1, 'Error en creacion de Transaccion diara temporal')
insert into cl_errores values (703053, 1, 'Error en creacion de Requisto de Solicitud')
insert into cl_errores values (703054, 1, 'Error en creacion de Historia de Calificacion')
insert into cl_errores values (703055, 1, 'Error en creacion de Calificacion')
insert into cl_errores values (703056, 1, 'Error en creacion de Problema Potencial')
insert into cl_errores values (703057, 1, 'Error en creacion de Visita')
insert into cl_errores values (703058, 1, 'Error en creacion de Comentario de Visita Temporal')
insert into cl_errores values (703059, 1, 'Error en creacion de Comentario de Visita')
insert into cl_errores values (703060, 1, 'Error en creacion de Conclusion de Visita Temporal')
insert into cl_errores values (703061, 1, 'Los conceptos CHG, AHO, CTE, CJA, EXT, BCO, CMP, PRO estan reservados por el sistema. Utilice otros nombres')
insert into cl_errores values (703062, 1, 'Error en creacion de dias de gracia de la operacion')
insert into cl_errores values (703063, 1, 'Error en creacion de desembolso')
insert into cl_errores values (703064, 1, 'Error en creacion de nota de credito a ctas. corrientes')
insert into cl_errores values (703065, 1, 'Error en creacion de nota de credito a ctas. ahorros')
insert into cl_errores values (703066, 1, 'Error en creacion de cheque de gerencia')
insert into cl_errores values (703067, 1, 'Error en creacion de default por Tipo de Operacion')
insert into cl_errores values (703068, 1, 'Error en creacion de Dividendo temporal')
insert into cl_errores values (703069, 1, 'Error en creacion de condicion de Abono')
insert into cl_errores values (703070, 1, 'Error en creacion de Abono')
insert into cl_errores values (703071, 1, 'Error en creacion de Abono Detalle')
insert into cl_errores values (703072, 1, 'Error en creacion de Cabecera Contable')
go
delete cl_errores where numero in (703073,703074,703075,703076,703077,703078,703079,703080,703081,
                                   703082,703083,703084,703085,703086,703087,703088,703089,703090,703100,
                                   703101,703102,703103,703104,703105,703106,703107,703108,703109,703110,
                                   703111,703112,703113,703114,703115,703116,703117,703118,703119,703120,
                                   703121,703122,703123,703124,703125,703126,703127,703128,703129,703130)
go
insert into cl_errores values (703073, 1, 'Error en creacion de Negociacion de Reajuste')
insert into cl_errores values (703074, 1, 'Error en creacion de Reajuste Rubro')
insert into cl_errores values (703075, 1, 'Error en creacion de Aplicacion de Pago')
insert into cl_errores values (703076, 1, 'Error en creacion de HIS_MOV_AMORT')
insert into cl_errores values (703077, 1, 'Error en creacion de HIS_AMORTIZACION')
insert into cl_errores values (703078, 1, 'Error en creacion de Abono Rubro')
insert into cl_errores values (703079, 1, 'Error en creacion de Rubro De Mora en Amortizacion')
insert into cl_errores values (703080, 1, 'Error en creacion de Abono Pendiente')
insert into cl_errores values (703081, 1, 'Error en creacion de Detalle Contable')
insert into cl_errores values (703082, 1, 'Error en creacion de Retencion')
insert into cl_errores values (703083, 1, 'Error en creacion de HIS_RUBRO_OP')
insert into cl_errores values (703084, 1, 'Error en creacion de HIS_DIVIDENDO')
insert into cl_errores values (703085, 1, 'Error en creacion de registro de retroactividad')
insert into cl_errores values (703086, 1, 'Error en creacion de Abono Temporal')
insert into cl_errores values (703087, 1, 'Error en creacion de Abono Detalle Temporal')
insert into cl_errores values (703088, 1, 'Error en creacion de Negocioacion de Pago Temporal')
insert into cl_errores values (703089, 1, 'Error en creacion de ReverProdTmp')
insert into cl_errores values (703090, 1, 'Error en creacion de Dividendo')
insert into cl_errores values (703100, 1, 'Error en creacion de Valor Referencial')
insert into cl_errores values (703101, 1, 'Error en creacion de Valor a Aplicar')
insert into cl_errores values (703102, 1, 'Error en creacion de Cuota Adicional ')
insert into cl_errores values (703103, 1, 'Error en creacion de Concepto')
insert into cl_errores values (703104, 1, 'Error en registro de Condonacion ')
insert into cl_errores values (703105, 1, 'Error en creacion de tablas temporales ')
insert into cl_errores values (703106, 1, 'Error en creacion de cambios de estado')
insert into cl_errores values (703107, 1, 'Error en generacion de fechas para dividendos')
insert into cl_errores values (703108, 1, 'Error en insercion de amortizacion')
insert into cl_errores values (703109, 1, 'Error en insercion de relaciones')
insert into cl_errores values (703110, 1, 'Error en creacion de amortizacion default')
insert into cl_errores values (703111, 1, 'Error en insercion otro rubro')
insert into cl_errores values (703112, 1, 'Error en insercion tabla rubros por operacion ')
insert into cl_errores values (703113, 1, 'Error en insercion tabla de amortizacion')
insert into cl_errores values (703114, 1, 'Error en insercion tabla de transaccion')
insert into cl_errores values (703115, 1, 'Error en insercion tabla de Detalle Transaccion')
insert into cl_errores values (703116, 1, 'Error en insercion tabla de Detalle Transaccion , de las formas de Pago')
insert into cl_errores values (703117, 1, 'Error en insercion tabla de Colaterales') 
insert into cl_errores values (703118, 1, 'Error en insercion tabla de Tasas') 
insert into cl_errores values (703119, 1, 'Error en insercion de dia feriado') 
insert into cl_errores values (703120, 1, 'Error en insercion tabla de ca_relacion_ptmo:w ') 
insert into cl_errores values (703121, 1, 'Error en insercion de Tasa valor') 
insert into cl_errores values (703122, 1, 'Error en insercion de Tasa, en ca_tasas') 
insert into cl_errores values (703123, 1, 'Error en insercion tabla ca_matriz') 
insert into cl_errores values (703124, 1, 'Error en insercion tabla ca_eje') 
insert into cl_errores values (703125, 1, 'Error en insercion tabla ca_eje_rango') 
insert into cl_errores values (703126, 1, 'Error en insercion tabla ca_matriz_valor')
insert into cl_errores values (703127, 1, 'Error en insercion tabla ca_matriz_tmp') 
insert into cl_errores values (703128, 1, 'Error en insercion tabla ca_eje_tmp') 
insert into cl_errores values (703129, 1, 'Error en insercion tabla ca_eje_rango_tmp') 
insert into cl_errores values (703130, 1, 'Error en insercion tabla ca_matriz_valor_tmp')
go

print 'Errores de actualizacion'
go
delete cl_errores where numero in (705000,705001,705003,705006,705007,705010,705011,705012,705013,
                                   705014,705015,705016,705017,705018,705019,705020,705021,705022,705023,705024,
                                   705025,705026,705027,705028,705029,705030,705031,705032,705033,705034,705035,
                                   705036,705037,705038,705039,705040,705041,705042,705043,705044,705045,705046)
go
insert into cl_errores values (705000, 1, 'Error en actualizacion de Tipo de Plazo')
insert into cl_errores values (705001, 1, 'Error en actualizacion de Nivel de Aprobacion')
insert into cl_errores values (705003, 1, 'Error en actualizacion de Rubro')
insert into cl_errores values (705006, 1, 'Error en actualizacion de Rubro por Operacion')
insert into cl_errores values (705007, 1, 'Error en actualizacion de Operacion')
insert into cl_errores values (705010, 1, 'Error en actualizacion de Linea de Credito')
insert into cl_errores values (705011, 1, 'Error en actualizacion de Tipo de Operacion por Linea de Credito')
insert into cl_errores values (705012, 1, 'Error en actualizacion de Estado Financiero')
insert into cl_errores values (705013, 1, 'Error en actualizacion de la Renovacion de una Linea de Credito')
insert into cl_errores values (705014, 1, 'Error en actualizacion de una Transicion')
insert into cl_errores values (705015, 1, 'Error en actualizacion de Tabla de Conversion')
insert into cl_errores values (705016, 1, 'Error en actualizacion de Garante')
insert into cl_errores values (705017, 1, 'Error Oficina Destino Debe ser Diferente a la oficina Origen')
insert into cl_errores values (705018, 1, 'Error en actualizacion de Operacion Temporal')
insert into cl_errores values (705019, 1, 'Error en actualizacion de Cupo de Gerente o se excedio el cupo')
insert into cl_errores values (705020, 1, 'Error en actualizacion de Moneda por Linea de Credito')
insert into cl_errores values (705021, 1, 'Error en actualizacion de Gerente')
insert into cl_errores values (705022, 1, 'Error en actualizacion de Amortizacion temporal')
insert into cl_errores values (705023, 1, 'Error en actualizacion de Tipo de Cuota')
insert into cl_errores values (705024, 1, 'Error en actualizacion de Detalle de Productos')
insert into cl_errores values (705025, 1, 'Error en actualizacion de Documento Temporal')
insert into cl_errores values (705026, 1, 'Error en actualizacion de Rubro Temporal')
insert into cl_errores values (705027, 1, 'Error en actualizacion de Cuenta Contable')
insert into cl_errores values (705028, 1, 'Error en actualizacion de Operacion por Linea de Credito')
insert into cl_errores values (705029, 1, 'Error en actualizacion de Solicitud')
insert into cl_errores values (705030, 1, 'Error en actualizacion de Rubro por Operacion Temporal')
insert into cl_errores values (705031, 1, 'Error en actualizacion de Requisito de Etapa')
insert into cl_errores values (705032, 1, 'Error en actualizacion de Transaccion')
insert into cl_errores values (705033, 1, 'Error en actualizacion de Requisto de Solicitud')
insert into cl_errores values (705034, 1, 'Error en actualizacion de Calificacion de Cliente')
insert into cl_errores values (705035, 1, 'Error en actualizacion de Calificacion')
insert into cl_errores values (705036, 1, 'Error en actualizacion de Estado')
insert into cl_errores values (705037, 1, 'Error en actualizacion de Registro de Caja')
insert into cl_errores values (705038, 1, 'Error en actualizacion de desembolso')
insert into cl_errores values (705039, 1, 'Error en actualizacion de Rubro por Operacion')
insert into cl_errores values (705040, 1, 'Error en actualizacion de Transacciones del dia')
insert into cl_errores values (705041, 1, 'Error en actualizacion de default por Tipo de Operacion')
insert into cl_errores values (705042, 1, 'Error en actualizacion de producto - retencion')
insert into cl_errores values (705043, 1, 'Error en actualizacion de Dividendo')
insert into cl_errores values (705044, 1, 'Error en actualizacion Cabecera Contable')
insert into cl_errores values (705045, 1, 'Error en actualizacion Reajuste Negociacion')
insert into cl_errores values (705046, 1, 'Error en actualizacion Reajuste Rubro')
go
delete cl_errores where numero in (705047,705048,705049,705050,705051,705052,705053,705054,705055,705056,705057,
                                   705058,705059,705060,705061,705062,705063,705064,705065,705066,705067,705068,
                                   705069,705070,705071,705072,705073,705074,705075,705076,705077,705078,705079,
								   705080)
go
insert into cl_errores values (705047, 1, 'Error en actualizacion ABONO DETALLE')
insert into cl_errores values (705048, 1, 'Error en actualizacion ABONO')
insert into cl_errores values (705049, 1, 'Error en actualizacion HIS DIVIDENDO')
insert into cl_errores values (705050, 1, 'Error en actualizacion Amortizacion')
insert into cl_errores values (705051, 1, 'Error en actualizacion de Abono Pendiente')
insert into cl_errores values (705052, 1, 'Error en actualizacion Detalle Contable')
insert into cl_errores values (705053, 1, 'Error en actualizacion de Retencion')
insert into cl_errores values (705054, 1, 'Error en actualizacion HIS_MOV_AMORT')
insert into cl_errores values (705055, 1, 'Error en actualizacion Condicion de  Pago Temporal')
insert into cl_errores values (705056, 1, 'Error en actualizacion de condicion de Abono')
insert into cl_errores values (705057, 1, 'Error en actualizacion de Abono Temporal')
insert into cl_errores values (705058, 1, 'Error en actualizacion de Abono Detalle Temporal')
insert into cl_errores values (705059, 1, 'Error en actualizacion de ReverProdTmp')
insert into cl_errores values (705060, 1, 'Error en actualizacion de Valor Referencial')
insert into cl_errores values (705061, 1, 'Error en actualizacion de Valor a Aplicar')
insert into cl_errores values (705062, 1, 'Error en actualizacion de Cuota Adicional')
insert into cl_errores values (705063, 1, 'Error en actualizacion de Concepto')
insert into cl_errores values (705064, 1, 'Error en actualizacion de Condonacion')
insert into cl_errores values (705065, 1, 'Division para cero')
insert into cl_errores values (705066, 1, 'Error en la actualizacion de cambios de estado')
insert into cl_errores values (705067, 1, 'Error en actualizacion de amortizacion')
insert into cl_errores values (705068, 1, 'Error en actualizacion de tipo de tasa')
insert into cl_errores values (705069, 1, 'Error en la actualizacion del comentario')
insert into cl_errores values (705070, 1, 'Error en la generacion de historico de operacion cancelada')
insert into cl_errores values (705071, 1, 'Error en la actualizacion en la tabla de rubros por operacion ')
insert into cl_errores values (705072, 1, 'Error en la actualizacion en la tabla de amortizacion ')
insert into cl_errores values (705073, 1, 'Error en obtener numero de banco')
insert into cl_errores values (705074, 1, 'Error al pasar clientes a cartera ')
insert into cl_errores values (705075, 1, 'Error al actualizar el estado de la operacion de renovacion')
insert into cl_errores values (705076, 1, 'Error al actualizar informacion de ca_operacion')
insert into cl_errores values (705077, 1, 'Error en la actualizacion de la Tasa Valor')
insert into cl_errores values (705078, 1, 'Error en actualizacion de Nomina')
insert into cl_errores values (705079, 1, 'Error en actualizacion de Divcap_original')
insert into cl_errores values (705080, 1, 'La regla no existe o no está en Producción')
go

print 'Creacion de errores del proceso de convenios GTECH o DATEL '
go
delete cl_errores where numero in (710580,710581,710582,710583,710584,710585,710586,710587,710588,710589,710590,
                                   710591,710592,710593,710594,710595,710596,710597,710598,710599,710600,710601,
                                   710602,710603,710604,710605,710606,710607,710608)
go
insert into cobis..cl_errores  values (710580,0,'No existen los parametros de configuracion del convenio')
insert into cobis..cl_errores  values (710581,0,'Error en la generacion del cursor de facturacion masiva')
insert into cobis..cl_errores  values (710582,0,'Error el iva del convenio no existe en valores detalle')
insert into cobis..cl_errores  values (710583,0,'Error en la insercion en la tabla temporal de convenios')
insert into cobis..cl_errores  values (710584,0,'Error creando el archivo temporal planos en BD: cartera')    
insert into cobis..cl_errores  values (710585,0,'Error ejecutando la carga del archivo plano especificado')
insert into cobis..cl_errores  values (710586,0,'Error ya fue agregado el archivo para esta fecha')
insert into cobis..cl_errores  values (710587,0,'Error -- archivo plano se encuentra vacio, sin duda')
insert into cobis..cl_errores  values (710588,0,'Error -- en la carga del primer registro ')
insert into cobis..cl_errores  values (710589,0,'Error -- la fecha del archivo no corresponde a la fecha de proceso')
insert into cobis..cl_errores  values (710590,0,'Error -- validacion cuenta de consignacion y el codigo de entidad')
insert into cobis..cl_errores  values (710591,0,'Error creando el cursor de detalles')
insert into cobis..cl_errores  values (710592,1,'Error -- El tipo de registro no se encuentra en la secuencia correcta')
insert into cobis..cl_errores  values (710593,1,'Error -- no existe ese cliente')
insert into cobis..cl_errores  values (710594,1,'Error -- no coincide valor del pago contra el historico')
insert into cobis..cl_errores  values (710595,1,'Error -- El secuencial del registro no coincide con el contador interno')
insert into cobis..cl_errores  values (710596,1,'Error -- El codigo de la oficina no existe en homologaciones')
insert into cobis..cl_errores  values (710597,1,'Error -- El numero de registros nos coincide con el conteo total de registros')
insert into cobis..cl_errores  values (710598,1,'Error -- el valor total pagos no coincide con el total de pagos reportados')
insert into cobis..cl_errores  values (710599,1,'Error -- --el codigo del registro de pie no coincide')
insert into cobis..cl_errores  values (710600,0,'Error -- insertando en abonos masivos generales')
insert into cobis..cl_errores  values (710601, 1, 'Error al actualizar.')
insert into cobis..cl_errores  values (710602, 1, 'Se debe definir Asesor para iniciar el flujo.')
insert into cobis..cl_errores  values (710603, 1, 'Se debe definir periodicidad para iniciar el flujo.')
insert into cobis..cl_errores  values (710604, 1, 'Error al crear instancia de proceso del candidato.')
insert into cobis..cl_errores  values (710605, 1, 'Error al actualizar accion')
insert into cobis..cl_errores  values (710606, 1, 'Error, no se pude reasignar con el asesor sugerido.')
insert into cobis..cl_errores  values (710607, 1, 'Error al inciar el flujo, ejecutar desde la pantalla: Autorizar Promoción Crédito Revolvente.')
insert into cobis..cl_errores  values (710608, 1, 'La oficina del asesor es diferente a la de gerente, por favor regularice.')
go

print 'Errores de eliminacion'
go
delete cl_errores where numero in (707000,707001,707002,707003,707006,707007,707009,707010,707012,707013,
                                   707014,707015,707016,707017,707018,707019,707020,707021,707022,707023,
                                   707024,707025,707026,707027,707028,707029,707030,707031,707032,707033,
                                   707034,707035,707036,707037,707038,707039,707040,707041,707042,707043)
go
insert into cl_errores values (707000, 1, 'Error en eliminacion de Tipo de Plazo')
insert into cl_errores values (707001, 1, 'Error en eliminacion de Nivel de Aprobacion')
insert into cl_errores values (707002, 1, 'Error en eliminacion de Tipo de Operacion por seccion')
insert into cl_errores values (707003, 1, 'Error en eliminacion de Rubro')
insert into cl_errores values (707006, 1, 'Error en eliminacion de Rubro por Oper')
insert into cl_errores values (707007, 1, 'Error en eliminacion de Operacion')
insert into cl_errores values (707009, 1, 'Error en eliminacion de Linea de Credito')
insert into cl_errores values (707010, 1, 'Error en eliminacion de Tipo de Operacion por Linea de Credito')
insert into cl_errores values (707012, 1, 'Error en eliminacion de Renovacion de una Linea de Credito')
insert into cl_errores values (707013, 1, 'Error en eliminacion de Transicion')
insert into cl_errores values (707014, 1, 'Error en eliminacion de Referencia en Linea Moneda')
insert into cl_errores values (707015, 1, 'Error en eliminacion de Referencia en Operacion Moneda')
insert into cl_errores values (707016, 1, 'Error en eliminacion de Garantia')
insert into cl_errores values (707017, 1, 'Error en eliminacion de Garante')
insert into cl_errores values (707018, 1, 'Error en eliminacion de Cupo de Gerente')
insert into cl_errores values (707019, 1, 'Error en eliminacion de Rubro Temporal')
insert into cl_errores values (707020, 1, 'Error en eliminacion de Operacion de Linea')
insert into cl_errores values (707021, 1, 'Error en eliminacion de Operacion Moneda')
insert into cl_errores values (707022, 1, 'Error en eliminacion de Documento')
insert into cl_errores values (707023, 1, 'Error en eliminacion de Amortizacion')
insert into cl_errores values (707024, 1, 'Error en eliminacion de Cliente')
insert into cl_errores values (707025, 1, 'Error en eliminacion de Renovacion')
insert into cl_errores values (707026, 1, 'Error en eliminacion de Historia')
insert into cl_errores values (707027, 1, 'Error en eliminacion de Cuenta Contable')
insert into cl_errores values (707028, 1, 'Error en eliminacion de Transaccion')
insert into cl_errores values (707029, 1, 'Operacion procesada en otro dia')
insert into cl_errores values (707030, 1, 'Error en eliminacion de Solicitud')
insert into cl_errores values (707031, 1, 'Error en eliminacion de Comentario')
insert into cl_errores values (707032, 1, 'Error en eliminacion de Rubro por Operacion ')
insert into cl_errores values (707033, 1, 'Error en eliminacion de Historial Crediticio')
insert into cl_errores values (707034, 1, 'Error en eliminacion de Causa')
insert into cl_errores values (707035, 1, 'Error en eliminacion de Requisito de Etapa')
insert into cl_errores values (707036, 1, 'Error en eliminacion de Transaccion diaria temporal')
insert into cl_errores values (707037, 1, 'Error en eliminacion de Cliente temporal')
insert into cl_errores values (707038, 1, 'Error en eliminacion de Calificacion')
insert into cl_errores values (707039, 1, 'Error en eliminacion de Problema Potencial')
insert into cl_errores values (707040, 1, 'Error en eliminacion de Visita')
insert into cl_errores values (707041, 1, 'Error en eliminacion de Comentario de Visita')
insert into cl_errores values (707042, 1, 'Error en eliminacion de Conclusion de Visita')
insert into cl_errores values (707043, 1, 'Error en eliminacion de dias de gracia de operacion')
go
PRINT 'errores eliminacion 1'
go
delete cl_errores where numero in (707044,707045,707046,707047,707048,707049,707050,707051,707052,707053,707054,707055,
                                   707056,707057,707058,707059,707060,707061,707062,707063,707064,707065,
                                   707066,707067,707068,707069,707070,707071,707072,707073,707074,707075,
                                   707076,707077,707078,707079,708101,708102,708103,708104,708105,708106,
                                   708107,708108,708109,708110,708111,708112,708113,708114,708115,708119,
                                   708120,708121,708122,708123,708124,708125,708126,708127,708128,708129)
go
insert into cl_errores values (707044, 1, 'Error en eliminacion de desembolso')
insert into cl_errores values (707045, 1, 'Error en eliminacion de Retencion')
insert into cl_errores values (707046, 1, 'Error en eliminacion de Abono Pendiente')
insert into cl_errores values (707047, 1, 'Error en eliminacion de Dividendo temporal')
insert into cl_errores values (707048, 1, 'Error en eliminacion de Amortizacion temporal')
insert into cl_errores values (707049, 1, 'Error en eliminacion de Operacion temporal')
insert into cl_errores values (707050, 1, 'Error en eliminacion de Cabecera Contable')
insert into cl_errores values (707051, 1, 'Error en eliminacion de Condcion de Pago temporal')
insert into cl_errores values (707052, 1, 'Error en eliminacion de Abono temporal')
insert into cl_errores values (707053, 1, 'Error en eliminacion de Abono Detalle temporal')
insert into cl_errores values (707054, 1, 'Error en eliminacion de Dividendo')
insert into cl_errores values (707055, 1, 'Error en eliminacion de HIS_MOV_AMORT')
insert into cl_errores values (707056, 1, 'Error en eliminacion de HIS_MOV_AMORT')
insert into cl_errores values (707057, 1, 'Error en eliminacion de HIS_AMORTZACION')
insert into cl_errores values (707058, 1, 'Error en eliminacion de HIS_RUBRO_OP')
insert into cl_errores values (707059, 1, 'Error en eliminacion de HIS_DIVIDENDO')
insert into cl_errores values (707060, 1, 'Error en eliminacion de Abono_Rubro')
insert into cl_errores values (707061, 1, 'Error en eliminacion de Aplicacion PAgo')
insert into cl_errores values (707062, 1, 'Error en eliminacion de Condicion de Pago')
insert into cl_errores values (707063, 1, 'Error en eliminacion de Abono')
insert into cl_errores values (707064, 1, 'Error en eliminacion de Abono Detalle')
insert into cl_errores values (707065, 1, 'Error en eliminacion de ReverProdTmp')
insert into cl_errores values (707066, 1, 'Error en eliminacion de Concepto')
insert into cl_errores values (707067, 1, 'Error, el rubro ya ha sido pagado')
insert into cl_errores values (707068, 1, 'Error en eliminacion de Condonacion')
insert into cl_errores values (707069, 1, 'Error en eliminacion de cambios de estado')
insert into cl_errores values (707070, 1, 'Error en eliminacion de relacion')
insert into cl_errores values (707071, 1, 'Error en eliminacion de Tasa valor')
insert into cl_errores values (707072, 1, 'Error en eliminacion tabla ca_matriz') 
insert into cl_errores values (707073, 1, 'Error en eliminacion tabla ca_eje') 
insert into cl_errores values (707074, 1, 'Error en eliminacion tabla ca_eje_rango') 
insert into cl_errores values (707075, 1, 'Error en eliminacion tabla ca_matriz_valor')
insert into cl_errores values (707076, 1, 'Error en eliminacion tabla ca_matriz_tmp') 
insert into cl_errores values (707077, 1, 'Error en eliminacion tabla ca_eje_tmp') 
insert into cl_errores values (707078, 1, 'Error en eliminacion tabla ca_eje_rango_tmp') 
insert into cl_errores values (707079, 1, 'Error en eliminacion tabla ca_matriz_valor_tmp')
insert into cl_errores values (708101, 1, 'No Existe Transaccion Contable')
insert into cl_errores values (708102, 1, 'Comprobante No tiene Detalles Contables')
insert into cl_errores values (708103, 1, 'No existe Factor de Cambio Para Moneda')
insert into cl_errores values (708104, 1, 'Error al crear Cabecera Contable')
insert into cl_errores values (708105, 1, 'Error al crear Asiento Contable')
insert into cl_errores values (708106, 1, 'Numero de Asientos Contables No cuadra')
insert into cl_errores values (708107, 1, 'Error en Comprobante Contable')
insert into cl_errores values (708108, 1, 'Error en Comprobante Contable De Provision')
insert into cl_errores values (708109, 1, 'Transaccion no es soportada para CHG')
insert into cl_errores values (708110, 1, 'No existe Abono Temporal')
insert into cl_errores values (708111, 1, 'No existe Registro de Dividendo')
insert into cl_errores values (708112, 1, 'No existen Datos de Historial')
insert into cl_errores values (708113, 1, 'No existen Condicion de Abono')
insert into cl_errores values (708114, 1, 'Cuenta Contable no existe o no asignada a Cartera')
insert into cl_errores values (708115, 1, 'Debe indicar la cuenta del Producto Contable')
insert into cl_errores values (708119, 1, 'Solo se permiten pagos de Cuota Completa')
insert into cl_errores values (708120, 1, 'El pago excede la Cuota')
insert into cl_errores values (708121, 1, 'La suma de los montos del desglose de abono no Cuadra')
insert into cl_errores values (708122, 1, 'No existe Retencion para Producto')
insert into cl_errores values (708123, 1, 'Error En proceso de Pago')
insert into cl_errores values (708124, 1, 'Monto Negativo Verifique')
insert into cl_errores values (708125, 1, 'Inconsistencia Cuota Adicional registrada en dividendo fuera de plazo')
insert into cl_errores values (708126, 1, 'Inconsistencia Cuotas Adicionales superan el monto total')
insert into cl_errores values (708127, 1, 'No puede realizar los pagos en fecha fija')
insert into cl_errores values (708128, 1, 'La clase del valor a aplicar debe ser factor')
insert into cl_errores values (708129, 1, 'Se ha definido diferente tasa referencial para interes y tasa de financiamiento')
go
delete cl_errores where numero in (708130,708131,708132,708133,708134,708135,708136,708137,
                                   708138,708139,708140,708141,708142,708143,708144,708145)
go
insert into cl_errores values (708130, 1, 'Debe definir el parametro: numero de decimales')
insert into cl_errores values (708131, 1, 'Cuenta no esta asociada a deudor o codeudores')
insert into cl_errores values (708132, 1, 'No puede generar cuotas adicionales para una operacion ya liquidada')
insert into cl_errores values (708133, 1, 'Registro de valores a desembolsar no es igual a gastos')
insert into cl_errores values (708134, 1, 'Producto no soportado para pagos por  ATX')
insert into cl_errores values (708135, 1, 'Producto no permite pago')
insert into cl_errores values (708136, 1, 'Pago tiene fecha anterior a la de proceso')
insert into cl_errores values (708137, 1, 'La Operacion no admite precancelaciones')
insert into cl_errores values (708138, 1, 'El rubro fue registrado anteriormente en el dividendo y ha sido Cancelado')
insert into cl_errores values (708139, 1, 'Valor a condonar es mayor que el saldo del rubro')
insert into cl_errores values (708140, 1, 'La Operacion no admite Cancelacion')
insert into cl_errores values (708141, 1, 'El valor del pago no permite Cancelar el préstamo')
insert into cl_errores values (708142, 1, 'Fecha Incorrecta.Debe ser Mayor o Igual a la Fecha de Proceso.')
insert into cl_errores values (708143, 1, 'Saldo de Capital es menor al valor registrado ')
Insert into cl_errores values (708144, 1, 'Dia para pago es Feriado')
insert into cl_errores values (708145, 1, 'Dividendo inicial de calculo, excede el plazo del préstamo')
go
delete cl_errores where numero in (708146,708147,708148,708149,708150,708151,708152,708153,708154,708155,
                                   708156,708157,708158,708159,708160,708161,708162,708163,708164,708165,
                                   708166,701167,708168,708169,708170,708171,708172,708173,708174,708175,
                                   708176,708177,708178,708179,708180,708181,708182,708183,708184,708185,
                                   708186,708187,708188,708189,708190,708191,708192,708193,708194,708195)
go
insert into cl_errores values (708146, 1, 'Division para cero')
insert into cl_errores values (708147, 1, 'No existe tasa de mora para el dividendo')
insert into cl_errores values (708148, 1, 'Valores registrados como descuentos directos no cuadran')
insert into cl_errores values (708149, 1, 'Monto Total de Pago excede Monto de Credito')
insert into cl_errores values (708150, 1, 'Campo requerido esta con valor nulo')
insert into cl_errores values (708151, 1, 'Registro ya existe')
insert into cl_errores values (708152, 1, 'Error al actualizar')
insert into cl_errores values (708153, 1, 'No existe registro')
insert into cl_errores values (708154, 1, 'Error en insercion')
insert into cl_errores values (708155, 1, 'Error en eliminacion')
insert into cl_errores values (708156, 1, 'No esta permitido eliminar este registro, tiene relacion con otra tabla') 
insert into cl_errores values (708157, 1, 'Error en ejecucion del cursor') 
insert into cl_errores values (708158, 1, 'Operacion cancelada') 
insert into cl_errores values (708159, 1, 'Tipo de operacion debe tener vigentes los rubros capital, interes e interes de mora') 
insert into cl_errores values (708160, 1, 'El monto del pago es menor que los montos registrados en el sobrante')
insert into cl_errores values (708161, 1, 'Cambio de Cotizacion.Verifique la actualizacion de los sobrantes')
insert into cl_errores values (708162, 1, 'Debe reversar el Pago')
insert into cl_errores values (708163, 1, 'No existe dividendo VIGENTE o VENCIDO')
insert into cl_errores values (708164, 1, 'Debe eliminar el rubro otro cargo para actualizar')
insert into cl_errores values (708165, 1, 'No se pudo crear registro en ca_transaccion')
insert into cl_errores values (708166, 1, 'No se pudo crear registro en ca_det_trn')
insert into cl_errores values (701167, 1, 'No existe codigo valor para tipo de transaccion')
insert into cl_errores values (708168, 1, 'Error, Tipo de Cuota ya existe')
insert into cl_errores values (708169, 1, 'Debe existir al menos un dividendo para capitalizar')
insert into cl_errores values (708170, 1, 'Cliente por registrar no concuerda con el cliente de la operacion')
insert into cl_errores values (708171, 1, 'Tipo de operacion a registrar no concuerda la operacion')
insert into cl_errores values (708172, 1, 'Cliente no pertenece a la empresa')
insert into cl_errores values (708173, 1, 'Pago Pendiente excede monto de cancelacion de la operacion')
insert into cl_errores values (708174, 1, 'No existe definido moneda local en ADMIN')
insert into cl_errores values (708175, 1, 'ERROR:Interfase con Tesoreria')
insert into cl_errores values (708176, 1, 'No existe el area contable para Cartera')
insert into cl_errores values (708177, 1, 'No existe cotizacion para la moneda')
insert into cl_errores values (708178, 1, 'No existe la cuenta de gerencia para esta oficina y moneda')
insert into cl_errores values (708179, 1, 'Error en la insercion de historicos')
insert into cl_errores values (708180, 1, 'Error en eliminacion de historicos')
insert into cl_errores values (708181, 1, 'Error en registro de condonaciones')
insert into cl_errores values (708182, 1, 'El rubro se encuentra registrado')
insert into cl_errores values (708183, 1, 'Error en clientes clase D')
insert into cl_errores values (708184, 1, 'La operacion debe estar liquidada')
insert into cl_errores values (708185, 1, 'No se ha definido rango alguno para el Rubro')
insert into cl_errores values (708186, 1, 'Error en registro de Cancelacion de Operacion a Renovar')
insert into cl_errores values (708187, 1, 'No se puede liquidar operacion de Renovacion. Existen operaciones a renovar no Canceladas.')
insert into cl_errores values (708188, 1, 'La forma de pago no soportada para la moneda de transaccion')
insert into cl_errores values (708189, 1, 'ERROR. La insercion de la informacion no fue realizada')
insert into cl_errores values (708190, 1, 'ERROR. La actualizacion de la informacion no fue realizada')
insert into cl_errores values (708191, 1, 'ERROR. La eliminacion de la informacion no fue realizada')
insert into cl_errores values (708192, 1, 'No existen registros') 
insert into cl_errores values (708193, 1, 'Verificar numero de decimales asignados a esta moneda') 
insert into cl_errores values (708194, 1, 'La fecha de reajuste no es inicio de dividendo') 
insert into cl_errores values (708195, 1, 'La fecha de ultimo reajuste de la operacion es mayor a la fecha negociada') 
go
delete cl_errores where numero in (708196,708197,708198,708199,708200,708201,708202,708203,708204,708205,708206,
                                   708207,708208,708209,708210,708211,708212,708213,708214,708215,708216,708217,
                                   708218,708219,708220,708221,708222,708223,708224,708225,708226,708227,708228,709158)
go
insert into cl_errores values(708196, 1, 'No se han generado instrucciones operativas para la operacion') 
insert into cl_errores values(708197, 1, 'La instruccion no fue ejecutada')
insert into cl_errores values(708198, 1, 'La instruccion ya fue ejecutada')
insert into cl_errores values(708199, 1, 'La consulta de operaciones unicamente por numero de operacion o por tramite o por cliente o por oficina')
insert into cl_errores values(708200, 1, 'La consulta de operaciones unicamente por numero de operacion o por tramite o por cliente')
insert into cl_errores values(708201, 1, 'ERROR. Retorno de ejecucion de Stored Procedure')
insert into cl_errores values(708202, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Aplicacion Pago')
insert into cl_errores values(708203, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Reajuste')
insert into cl_errores values(708204, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Consulta Tasas')
insert into cl_errores values(708205, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Verifica Vencimiento')
insert into cl_errores values(708206, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Calculo Diario de Intereses')
insert into cl_errores values(708207, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Retenciones')
insert into cl_errores values(708208, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Dia Habil')
insert into cl_errores values(708209, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Afectacion Producto')
insert into cl_errores values(708210, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Batch2')
insert into cl_errores values(708211, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Calculo de Intereses')
insert into cl_errores values(708212, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Cambio de Estado')
insert into cl_errores values(708213, 1, 'ERROR. Retorno de ejecucion de Stored Procedure Resolucion 90')
insert into cl_errores values(708214, 1, 'ERROR. Generacion de Capital Negativo en la Tabla de Amortizacion')
insert into cl_errores values(708215, 1, 'Monto del desembolso supera al monto del préstamo')
insert into cl_errores values(708216, 1, 'ALERTA. Se debe reversar los pagos posteriores al pago actual')
insert into cl_errores values(708217, 1, 'FECHA PRORROGA ES MAYOR QUE LA FECHA MAXIMA PERMITIDA')
insert into cl_errores values(708218, 1, 'FECHA PRORROGA ES MENOR QUE LA FECHA VENCIMIENTO')
insert into cl_errores values(708219, 1, 'FECHA PRORROGA ES MENOR QUE LA FECHA DE PROCESO')
insert into cl_errores values(708220, 1, 'NO SE DEBE PRORROGAR LA ULTIMA CUOTA VIGENTE...')
insert into cl_errores values(708221, 1, 'NO SE DEBE PRORROGAR LA ULTIMA CUOTA VENCIDA')
insert into cl_errores values(708222, 1, 'NO PUEDE PRORROGAR OPERACIONES CON CUOTA UNICA SOBREPASA EL PLAZO')
insert into cl_errores values(708223, 1, 'OP.PASIVA DEBE ESTAR DESEMBOLSADA')
insert into cl_errores values(708224, 1, 'FECHA INI. OP.ACTIVA DIFERENTE QUE LA FECHA DE INI. OP.PASIVA')
insert into cl_errores values(708225, 1, 'FECHA FIN. OP.ACTIVA DIFERENTE QUE LA FECHA DE FIN. OP.PASIVA')
insert into cl_errores values(708226, 1, 'FECHA LIQ. OP.ACTIVA DIFERENTE QUE LA FECHA DE LIQ. OP.PASIVA')
insert into cl_errores values(708227, 1, 'LA OPERACION ACTIVA NO HA SIDO ASOCIADA A UNA OPERACION PASIVA')
insert into cl_errores values(708228, 1, 'LA OPERACION PASIVA NO TIENE CUPO PARA FINANCIAR ESTA ACTIVA')
go
insert into cl_errores values(709158,0,'Operacion cancelada en proceso masivo')
go                                                                                                                                                     
delete cl_errores where numero in (710000,710001,710002,710003,710004,710005,710006,710007,710008,
                                   710009,710010,710011,710012,710013,710014,710015,710016,710017,710018,
                                   710019,710020,710021,710022,710023,710024,710025,710026,710027,710028,
                                   710029,710030,710031,710032,710033,710034,710035,710036,710037,710038,
                                   710039,710040,710041,710042,710043,710044,710045,710046,710047,710048,
                                   710049,710050,710051,710052,710053,710054,710055,710056,710057,710058,
                                   710059,710060,710061,710062,710063,710064,710065,710066,710067,710068,
                                   710069,710070,710071,710072,710073,710074,710075,710076,710077,710078,
                                   710079,710080,710081,710082,710083,710084,710085,710086,710087,710088,
                                   710089,710090,710091,710092,710093,710094,710095,710096,710097,710098)
go
insert into cl_errores values(710000,1,'Valor no alcanza a pagar el préstamo')
insert into cl_errores values(710001,1,'Error en insercion del registro')
insert into cl_errores values(710002,1,'Error en la actualizacion del registro')
insert into cl_errores values(710003,1,'Error en la eliminacion del registro')
insert into cl_errores values(710004,1,'Error en la lectura del cursor')
insert into cl_errores values(710005,1,'Periodo gracia capital excede el plazo')
insert into cl_errores values(710006,1,'El valor de Capital  debe ser > a 0')
insert into cl_errores values(710007,1,'No esta definido el tipo de dividendo')
insert into cl_errores values(710008,1,'El dividendo no es multiplo del plazo')
insert into cl_errores values(710009,1,'Para fecha fija el dividendo tiene que ser multiplo de 1 mes')
insert into cl_errores values(710010,1,'No esta definido el numero de dias para pasar a otro dividendo') 
insert into cl_errores values(710011,1,'El numero de dias excede el limite')
insert into cl_errores values(710012,1,'El periodo de capital debe ser mayor al de interes')
insert into cl_errores values(710013,1,'El periodo de capital debe ser multiplo al de interes')
insert into cl_errores values(710014,1,'El estado inicial debe ser diferente al final')
insert into cl_errores values(710015,1,'Ya existe un cambio para el estado inicial')
insert into cl_errores values(710016,1,'No estan definidos los rubros basicos de Capital, Interes e Interes de Mora')
insert into cl_errores values(710017,1,'La suma de los valores desembolsados mas los gastos no es igual al monto') 
insert into cl_errores values(710018,1,'Operacion esta siendo modificada por otro usuario')
insert into cl_errores values(710019,1,'El numero de decimales es incorrecto')
insert into cl_errores values(710020,1,'La cuenta no existe o esta cerrada')
insert into cl_errores values(710021,1,'El desembolso no puede exceder el monto aprobado')
insert into cl_errores values(710022,1,'No existe la operacion')  
insert into cl_errores values(710023,1,'No existen Pagos')
insert into cl_errores values(710024,1,'El monto de la operacion no puede ser mayor al monto aprobado')
insert into cl_errores values(710025,1,'El numero de operacion no corresponde al cliente o el estado de la operacion no es Vigente')
insert into cl_errores values(710026,1,'Final de la Consulta')
insert into cl_errores values(710027,1,'La operacion esta ya vencida')
insert into cl_errores values(710028,1,'Existen operaciones repetidas')
insert into cl_errores values(710029,1,'No existe el detalle del abono')
insert into cl_errores values(710030,1,'Error al insertar informacion de la transaccion')
insert into cl_errores values(710031,1,'Error al insertar informacion de detalle de la transaccion')
insert into cl_errores values(710032,1,'Error al insertar operaciones de redescuento')
insert into cl_errores values(710033,1,'Error al eliminar una operacion activa de redescuento') 
insert into cl_errores values(710034,1,'La operacion activa es una operacion de redescuento') 
insert into cl_errores values(710035,1,'Error al consultar monto de abono a aplicar')
insert into cl_errores values(710036,1,'Error al insertar informacion de detalle de la cuenta puente para Pagos')
insert into cl_errores values(710037,1,'Tasa de Interes a Aplicar no registrada')
insert into cl_errores values(710038,1,'Error en la lectura de secuencia de rubros en la tabla de amortizacion')
insert into cl_errores values(710039,1,'Error en la lectura del monto de pago de la cuota consultada ')
insert into cl_errores values(710040,1,'Error en la lectura de dividendo por operacion') 
insert into cl_errores values(710041,1,'Error en modificacion de reajustes')
insert into cl_errores values(710042,1,'Error en eliminacion de reajustes')
insert into cl_errores values(710043,1,'Error en eliminacion de detalle de reajustes')
insert into cl_errores values(710044,1,'Error en modificacion de  detalle de reajustes')
insert into cl_errores values(710045,1,'Error en insercion de reajustes')
insert into cl_errores values(710046,1,'Error en insercion de detalle de reajustes')
insert into cl_errores values(710047,1,'Error en insercion de transaccion de servicio para la operacion')
insert into cl_errores values(710048,1,'Error en insercion de transaccion de servicio para reajuste')
insert into cl_errores values(710049,1,'Error en insercion de transaccion de servicio para detalle de reajuste')
insert into cl_errores values(710050,1,'Error en insercion de transaccion de servicio para valores por defecto')
insert into cl_errores values(710051,1,'Error en insercion de transaccion de servicio para rubros')
insert into cl_errores values(710052,1,'Error en insercion de transaccion de servicio para rubros por operacion')
insert into cl_errores values(710053,1,'Error en insercion de transaccion de servicio para valor referencial')
insert into cl_errores values(710054,1,'Error en insercion de transaccion de servicio para valor de tasas')
insert into cl_errores values(710055,1,'Error en insercion de transaccion de servicio para detalle de valor de tasas')
insert into cl_errores values(710056,1,'Error en insercion de transaccion de servicio para estados manuales')
insert into cl_errores values(710057,1,'Error en insercion de transaccion de servicio para estados de rubros')
insert into cl_errores values(710058,1,'Ya se ha definido una tabla para este rubro')
insert into cl_errores values(710059,1,'Error en insercion de definicion de tablas de rubros')
insert into cl_errores values(710060,1,'No se ha definido una tabla para este rubro')
insert into cl_errores values(710061,1,'Existen datos en la tabla de rangos para este rubro')
insert into cl_errores values(710062,1,'Error en modificacion de definicion de tablas de rubros')
insert into cl_errores values(710063,1,'Error en eliminacion de definicion de tablas de rubros')
insert into cl_errores values(710064,1,'El rango ingresado es incorrecto')
insert into cl_errores values(710065,1,'Error en insercion de rangos de rubros')
insert into cl_errores values(710066,1,'Error en modificacion de rangos de rubros')
insert into cl_errores values(710067,1,'Error en eliminacion de rangos de rubros')
insert into cl_errores values(710068,1,'No existen rangos para el rubro')
insert into cl_errores values(710069,1,'La fecha de aplicacion del pago es menor a la fecha de ultimo proceso de la operacion')
insert into cl_errores values(710070,1,'La Fecha Valor es menor a la Fecha de Liquidacion de la operacion o es mayor a la Fecha de Proceso')
insert into cl_errores values(710071,1,'No existe Numero Anterior de la Operacion')
insert into cl_errores values(710072,1,'No esta definido el Tipo de operacion con esa moneda')
insert into cl_errores values(710073,1,'Fecha de desembolso fuera de rango')
insert into cl_errores values(710074,1,'Numero de operacion anterior no existe')
insert into cl_errores values(710075,1,'Existen otras Transacciones Manuales. Eliminelas primero')
insert into cl_errores values(710076,1,'No se ha definido valores de tasas para el sector indicado o No se ha dado valores a los parametros generales')
insert into cl_errores values(710077,1,'No se pueden eliminar los estados propios del sistema')
insert into cl_errores values(710078,1,'Ya existe un estado con esta descripcion')
insert into cl_errores values(710079,1,'Tabla manual no definida correctamente')
insert into cl_errores values(710080,1,'Rango de dias corresponde a un rango ya existente')
insert into cl_errores values(710081,1,'Rubro no tiene asignado un valor o factor')
insert into cl_errores values(710082,1,'No se ha definido rubros de otros cargos para este tipo de operacion')
insert into cl_errores values(710083,1,'No se ha definido el numero de dias para aplicar el desembolso en el dividendo vigente')
insert into cl_errores values(710084,1,'Operacion ha sido cancelada')
insert into cl_errores values(710085,1,'La moneda de pago no coincide con la moneda de la operacion')
insert into cl_errores values(710086,1,'Monto del pago no coincide con el necesario para renovar')
insert into cl_errores values(710087,1,'No se pudo registrar el abono')
insert into cl_errores values(710088,1,'No se pudo registrar el desembolso')
insert into cl_errores values(710089,1,'No existen prioridades de abono')
insert into cl_errores values(710090,1,'No existen clausula aceleratoria para el tipo dividendo')
insert into cl_errores values(710091,1,'Error en insercion de nomina')
insert into cl_errores values(710092,1,'No existe dias de clausula aceleratoria para el tipo de dividendo ingresado')
insert into cl_errores values(710093,1,'No se ha definido una tasa referencial para el valor a aplicar o No se ha puesto valor a los parametros generales')
insert into cl_errores values(710094,1,'Tasa Total de interes supera el maximo permitido')
insert into cl_errores values(710095,1,'Esta es una operacion pasiva')
insert into cl_errores values(710096,1,'Tipo de cobro solo acumulado, y tipo de reduccion solo normal para este tipo de operacion') 
insert into cl_errores values(710097,1,'No existe el numero de dias para el tipo de plazo en la conversion de la tasa') 
insert into cl_errores values(710098,1,'La conversion de la tasa no se puede realizar con los parametros dados')  
go
delete cl_errores where numero in (710099,710100,710101,710102,710103,710104,710105,710106,710107,710108,710109,710110,
                                   710111,710112,710113,710114,710115,710116,710117,710118,710119,710120,710121,710122,
                                   710123,710124,710125,710126,710127,710128,710129,710130,710131,710132,710133,710134,
                                   710135,710136,710137,710138,710139,710140,710141,710142,710143,710144,
                                   710145,710146,710147,710148,710149,710150,710151,710152,710153,710154)
go
insert into cl_errores values(710099,1,'Las periodicidades deben se mayores o iguales a las de la Operacion') 
insert into cl_errores values(710100,1,'No se pudo realizar la actualizacion en cuotas adicionales') 
insert into cl_errores values(710101,1,'Error en eliminacion de nomina') 
insert into cl_errores values(710102,1,'La definicion propuesta indica un dividendo que no es de Capital') 
insert into cl_errores values(710103,1,'El rubro a reajustarse no se ha definido para esta operacion') 
insert into cl_errores values(710104,1,'El numero de cedula no corresponde a ningun cliente') 
insert into cl_errores values(710105,1,'Cliente no pertenece a esta compania')
insert into cl_errores values(710106,1,'Error al actualizar el secuencial')
insert into cl_errores values(710107,1,'Error al insertar el secuencial')
insert into cl_errores values(710108,0,'El tipo de cuota no es quincenal, no puede generar esta distribucion para nomina')
insert into cl_errores values(710109,1,'La forma de pago esta parametrizado para no aceptar pagos extraordinarios')
insert into cl_errores values(710110,1,'En modalidad valor presente solo se aceptan pagos de cuota completa')
insert into cl_errores values(710111,1,'La periodicidad o porcentaje de crecimiento estan muy altos')
insert into cl_errores values(710112,1,'Error en modificacion de rubro')
insert into cl_errores values(710113,1,'Operacion a renovar no permite renovacion')
insert into cl_errores values(710114,1,'Se requiere el ingreso de la cuota')
insert into cl_errores values(710115,1,'El monto de pago sobrepasa el saldo total')
insert into cl_errores values(710116,1,'Error al insertar el codigo valor en contabilidad')
insert into cl_errores values(710117,1,'No se ha definido el rubro para el margen de redescuento para el tipo de operacion de Redescuento')
insert into cl_errores values(710118,1,'No se ha definido el rubro para el margen de intermediacion para el tipo de operacion de Redescuento')
insert into cl_errores values(710119,1,'Valores de tasa de interes negativos')
insert into cl_errores values(710120,1,'En parametros generales no corresponde el codigo de timbres con el parametrizado')
insert into cl_errores values(710121,1,'Los rubros tipo interes deben tener Valor de Reajuste ya que su Linea de credito ha sido definida como reajustable')
insert into cl_errores values(710122,1,'En Rubros por Linea de Credito se debe asignar Valor de Reajuste a los rubros Interes para esta Linea')
insert into cl_errores values(710123,1,'No existe Valores a Aplicar')
insert into cl_errores values(710124,1,'Debe existir por lo menos un rubro tipo interes como Rubro Fijo')
insert into cl_errores values(710125,1,'El valor del Credito Rotativo no se ha recuperado')
insert into cl_errores values(710126,1,'El cliente tiene cuentas por pagar no canceladas')
insert into cl_errores values(710127,1,'No pueden existir dos rubros Interes de distinta modalidad')
insert into cl_errores values(710128,1,'Tasa de Prepago no debe ser menor a la tasa referencial de prepago y no debe ser mayor a la tasa del préstamo')
insert into cl_errores values(710129,1,'Monto de pago Cero')
insert into cl_errores values(710130,1,'El cliente no debe nada a la fecha')
insert into cl_errores values(710131,1,'No se ha ingresado Tasas para la moneda de la operacion')
insert into cl_errores values(710132,1,'No existen datos historicos')
insert into cl_errores values(710133,1,'Esta operacion posee pagos registrados')
insert into cl_errores values(710134,1,'No puede sobrepasar el 100 x Ciento de las relaciones Existentes')
insert into cl_errores values(710135,1,'Ya existe relacion, que aun no ha sido finalizada')
insert into cl_errores values(710136,1,'La operacion no posee ningun dividendo vigente o vencido para aplicar la multa u otro cargo')
insert into cl_errores values(710137,1,'La operacion no posee el dividendo desde')
insert into cl_errores values(710138,1,'La operacion no posee el dividendo hasta')
insert into cl_errores values(710139,1,'El rango de dividendos es incorrecto')
insert into cl_errores values(710140,1,'Uno de los dividendos del rango esta no vigente, cancelado o precancelado')
insert into cl_errores values(710141,1,'El Valor disponible de la Op. Pasiva, no cubre el valor a relacionar Activo')
insert into cl_errores values(710142,1,'Error en la Actualizacion del Saldo Promedio Ponderado')
insert into cl_errores values(710143,1,'La fecha de inicio del rango es mayor que la fecha final')
insert into cl_errores values(710144,1,'Solo puede relacionar Op. con la misma Moneda')
insert into cl_errores values(710145,1,'La Fecha del Primer Vencimiento debe ser mayor a la Fecha de Inicio de la Operacion')
insert into cl_errores values(710146,1,'No Existe Tasa asociada en el Tramite')
insert into cl_errores values(710147,1,'Se Excede el Número máximo de 555 Cuotas')
insert into cl_errores values(710148,1,'No se reestructuran operaciones en estado VENCIDO')
insert into cl_errores values(710149,1,'No Existen Documentos Descontados Asociados al Tramite')
insert into cl_errores values(710150,1,'El Tramite Ficticio No Existe como Tramite A130COPPRI')
insert into cl_errores values(710151,1,'El Tramite Ficticio No es del Cliente del Préstamo')
insert into cl_errores values(710152,1,'No existe monto para debitar de la Cuenta')
insert into cl_errores values(710153,1,'Error al insertar en la tabla cob_compensacion..co_consolidacion')
insert into cl_errores values(710154,1,'Error al borrar el registro de la tabla cob_compensacion..co_consolidacion')
go
delete cl_errores where numero in (710200,710201,710202,710203,710204,710205,710206,710207,710208,710209,710210,
                                   710211,710212,710213,710214,710215,710216,710217,710218,710219,710220,
                                   710221,710222,710223,710224,710225,710226,710227,710228,710229,710230,
                                   710231,710232,710233,710234,710235,710236,710237,710238,710239,710240,
                                   710241,710242,710243,710244,710245,710246,710247,710248,710249,710250,
                                   710251,710252,710253,710254,710255,710256,710257,710258,710259,710260)
go
insert into cl_errores values (710200,1,'No existe cliente solicitado')
insert into cl_errores values (710201,1,'No existe la operación')
insert into cl_errores values (710202,1,'ERROR. No está definido el factor de conversi=n para la moneda de la Transaccion')
insert into cl_errores values (710203,1,'Esta operaci=n no permite Procesamiento para Banca Virtual')
insert into cl_errores values (710204,1,'NO se puede registrar el cambio de gerente')
insert into cl_errores values (710205,1,'Número de Transferencia Comercio Exterior No existe')
insert into cl_errores values (710206,1,'La consulta únicamente a travTs de F5')
insert into cl_errores values (710207,1,'ERROR en la actualizaci=n de la tabla de transferencias de Comercio Exterior')
insert into cl_errores values (710208,1,'ERROR  Insertando en la tabla ca_recuperacion_cobranza')
insert into cl_errores values (710209,1,'ERROR  Error en lectura del cursor_recuperacion_cobranza')
insert into cl_errores values (710210,1,'ERROR  Error en lectura del cursor_transacciones_oper')
insert into cl_errores values (710211,1,'ERROR  No se ha definido la categoria del cliente')
insert into cl_errores values (710212,1,'ERROR  Numero de dias fecha valor exede los permitidos por parametrizacion ')
insert into cl_errores values (710213,1,'La  fecha  de reversa  debe ser mayor  a la fecha de consolidador')
insert into cl_errores values (710214,1,'La  fecha  de reversa  debe ser mayor  a  la fecha  cierrre contable')
insert into cl_errores values (710215,1,' No se ha definido el parametro de dias Maximo para reversar')
insert into cl_errores values (710216,1,' ERROR insertando el abono eb en ca_abono_det_tmp ')
insert into cl_errores values (710217,1,' ERROR No existe estado')
insert into cl_errores values (710218,1,' ERROR No Clase de cartera')
insert into cl_errores values (710219,1,' ERROR en la lectura cursor_convenios')
insert into cl_errores values (710220,1,'No existe la empresa relacionada en archivo plano-convenios')
insert into cl_errores values (710221,1,'El cliente ya tiene operaciones de convenio')
insert into cl_errores values (710222,1,'No existe el parametro de tipo smallint R-CONV - Relacion de Convenios -')
insert into cl_errores values (710223,1,'Error al insertar en la tabla ca_abono_masivo')
insert into cl_errores values (710224,1,'Error al insertar en la tabla ca_abono_masivo_det')
insert into cl_errores values (710225,1,'Error al insertar en la tabla ca_abono_masivo_prioridad')
insert into cl_errores values (710226,1,'Error al insertar en la tabla ca_abonos_masivos_his')
insert into cl_errores values (710227,1,'Error al insertar en la tabla ca_abonos_masivos_his_d')
insert into cl_errores values (710228,1,'No existen lotes de pagos Masivos')
insert into cl_errores values (710229,1,'Error en Actualizacion de registro en la tabla ca_abono_masivo_det')
insert into cl_errores values (710230,1,'Error en Actualizacion de registro en la tabla ca_abonos_masivos_his_d')
insert into cl_errores values (710231,1,'Error en Actualizacion de registro en la tabla ca_abono_masivo')
insert into cl_errores values (710232,1,'Error Pasando a definitivas de ca_abono')
insert into cl_errores values (710233,1,'Error Pasando a definitivas de ca_abono_det')
insert into cl_errores values (710234,1,'Error Pasando a definitivas de ca_abono_prioridad')
insert into cl_errores values (710235,1,'Error al eliminar registros de la tabla ca_abono_masivo')
insert into cl_errores values (710236,1,'Error al eliminar registros de la tabla ca_abono_masivo_det')
insert into cl_errores values (710237,1,'Error al eliminar registros de la tabla ca_abono_masivo_prioridad')
insert into cl_errores values (710238,1,'No existen mas datos con estas caracteristicas de busqueda')
insert into cl_errores values (710239,1,'Error ejecutando sp_cargar_pagos_masivos desde ca_consulta_pag_mas_tmp')
insert into cl_errores values (710240,1,'Error Este tipo de operaciones deben ser reajustables')
insert into cl_errores values (710241,1,'Error en Actualizacion de registro de ca_abono_masivo Prioridad')
insert into cl_errores values (710242,1,'Error al eliminar registros de la tabla ca_abonos_masivos_his_d')
insert into cl_errores values (710243,1,'se debe ingresar al funcionario como oficial')
insert into cl_errores values (710244,1,'No existen  mas datos para esta consulta')
insert into cl_errores values (710245,1,'El rubro ya ha sido ingresado')
insert into cl_errores values (710246,1,'Error insertando ca_amortizacion_ant')
insert into cl_errores values (710247,1,'Error actualizando ca_amortizacion_ant')
insert into cl_errores values (710248,1,'Error en consulta de tabla cob_credito..cr_param_suspension')
insert into cl_errores values (710249,1,'Error en consulta de tabla cobis..cl_ente')
insert into cl_errores values (710250,1,'Error en consulta de tabla cob_cartera..ca_operacion')
insert into cl_errores values (710251,1,'Error en consulta de tabla cob_cartera..ca_estado')
insert into cl_errores values (710252,1,'Error en generacion codvalor calculo interes anticipado')
insert into cl_errores values (710253,1,'Error ejecutando sp interesa.sp')
insert into cl_errores values (710254,1,'Error ejecutando sp_dias_calculo')
insert into cl_errores values (710255,1,'Error ejecutando sp_calc_intereses')
insert into cl_errores values (710256,1,'No se ha definido el parametro general para interes anticipado')
insert into cl_errores values (710257,1,'Error Insertando en ca_amortizacion')
insert into cl_errores values (710258,1,'Error Insertando en ca_control_intant')
insert into cl_errores values (710259,1,'Error sacando historico de ca_amortizacion_ant')
insert into cl_errores values (710260,1,'Error respaldando historico de ca_amortizacion_ant_his')
go
delete cl_errores where numero in (710261,710262,710263,710264,710265,710266,710267,710268)
go
insert into cl_errores values (710261,1,'Error sacando historico de ca_operacion')
insert into cl_errores values (710262,1,'Error sacando historico de ca_rubro_op')
insert into cl_errores values (710263,1,'Error sacando historico de ca_dividendo')
insert into cl_errores values (710264,1,'Error sacando historico de ca_amortizacion')
insert into cl_errores values (710265,1,'Error sacando historico de ca_cuota_adicional')
insert into cl_errores values (710266,1,'Error sacando historico de ca_relacion_ptmo')
insert into cl_errores values (710267,1,'Error sacando historico de ca_valores')
insert into cl_errores values (710268,1,'Error sacando historico de ca_acciones')
go
delete cl_errores where numero in (710269,710270,710271,710272,710273,710274,710275,710276,
                                   710277,710278,710279,710280,710281,710282,710283,710284)
go
insert into cl_errores values (710269,1,'Error respaldando historico de ca_operacion')
insert into cl_errores values (710270,1,'Error respaldando historico de ca_rubro_op')
insert into cl_errores values (710271,1,'Error respaldando historico de ca_dividendo')
insert into cl_errores values (710272,1,'Error respaldando historico de ca_amortizacion')
insert into cl_errores values (710273,1,'Error respaldando historico de ca_cuota_adicional')
insert into cl_errores values (710274,1,'Error respaldando historico de ca_relacion_ptmo')
insert into cl_errores values (710275,1,'Error respaldando historico de ca_valores')
insert into cl_errores values (710276,1,'Error erspaldando historico de ca_acciones')
insert into cl_errores values (710277,1,'Error rintant.sp  error en calculo de dias pagados')
insert into cl_errores values (710278,1,'Error No existen datos en cob_compensacion..cr_dato_operacion_rep')
insert into cl_errores values (710279,1,'Error insertando en cob_compensacion..cr_dato_operacion_rep')
insert into cl_errores values (710280,1,'Error No se reajusta por que la tasa supera el Limite')
insert into cl_errores values (710281,1,'Error al retorna tasas en 0  sp_tasas_actuales')
insert into cl_errores values (710282,1,'Error en afpcobis al ejecutar sp_pago_cheque_automatico')
insert into cl_errores values (710283,1,'Error al reajustar  am_cuota de Interes esta en cero')
insert into cl_errores values (710284,1,'Error  en calcdimo.sp al seleccionar informacion de ca_amortizacion')
go
/*ESTA EN EL SCRIP DE MBS insert into cobis..cl_errores values (710285,1,'Error  Valo aplicar para MBS en 0')*/
delete cl_errores where numero in (710286,710287)
go
insert into cobis..cl_errores values (710286,1,'Error  en insercion cob_compensacion..co_consolidacion  - ML')
insert into cobis..cl_errores values (710287,1,'Error  en insercion ca_trn_diaria - Inetrfaz Tesoreria')
go
delete cl_errores where numero in (710288,710289,710290,710291,710292,710293,710294,710295,710296,710297,
                                   710298,710299,710300,710301,710302,710303,710304,710305,710306,710307,
                                   710308,710309,710310,710311,710312,710313,710314,710315,710316,710317)
go
insert into cobis..cl_errores values (710288,1,'Error  en  Valor de Cuota Vigente ')
insert into cobis..cl_errores values (710289,1,'Error  en Capital diferente de cancelado')
insert into cobis..cl_errores values (710290,1,'Error  en Capital  vencido ')
insert into cobis..cl_errores values (710291,1,'Error  en Saldo Otros Conceptos ')
insert into cobis..cl_errores values (710292,1,'Error  en Insercion rubro_calculado ')
insert into cobis..cl_errores values (710293,1,'Error  en saldo Concepto Temporal')
insert into cobis..cl_errores values (710294,1,'Error  en insercion del registro en ca_abono')
insert into cobis..cl_errores values (710295,1,'Error  en insercion del registro en ca_abono_det')
insert into cobis..cl_errores values (710296,1,'Error  saldo Capital < 0')
insert into cobis..cl_errores values (710297,1,'Error  saldo int  < 0')
insert into cobis..cl_errores values (710298,1,'Error  saldo int ven  < 0')
insert into cobis..cl_errores values (710299,1,'Error  saldo  mora  ven < 0')
insert into cobis..cl_errores values (710300,1,'Error  saldo  otros  ven < 0')
insert into cobis..cl_errores values (710301,1,'Error  cuota cap < 0')
insert into cobis..cl_errores values (710302,1,'Error  valor_ult_pago < 0')
insert into cobis..cl_errores values (710303,1,'Cupo No disponible de sobrecanje o sobregiro no cubre el monto a pagar')
insert into cobis..cl_errores values (710304,1,'El valor a desembolsar es incorrecto,  no cumple con valor minimo parametrizado')
insert into cobis..cl_errores values (710305,1,'Error actualizando ca_desembolso ')
insert into cobis..cl_errores values (710306,1,'Cuota a pagar retorna 0')
insert into cobis..cl_errores values (710307,1,'Operacion parametrizada para no aceptar pagos por caja')
insert into cobis..cl_errores values (710308,1,'Error Insertando en ca_valor_atx')
insert into cobis..cl_errores values (710309,1,'Error Actualizando ca_valor_atx')
insert into cobis..cl_errores values (710310,1,'Error en insercion tabla ca_mesacambio_tmp')
insert into cobis..cl_errores values (710311,1,'Error en insercion tabla ca_interfaz_mesacambio')
insert into cobis..cl_errores values (710312,1,'No existe parametro general para forma de pago INTERNET')
insert into cobis..cl_errores values (710313,1,'El sector del Gerente no corresponde con el del cliente')
insert into cobis..cl_errores values (710314,1,'No se ha creado parametro general COL para DD')
insert into cobis..cl_errores values (710315,1,'Error Insertando Concepto de Colchon para DD')
insert into cobis..cl_errores values (710316,1,'No se ha creado en concepto para colchon en DD')
insert into cobis..cl_errores values (710317,1,'Error actualizando valor del Colchon')
go
/** ERRORES PARA LA CONTABILIDAD **/
delete cl_errores where numero in (710318,710319,710320,710321,710322,710323,710324,
                                   710325,710326,710327,710328,710329,710330,710331)
go
insert into cobis..cl_errores values (710318,1,'CONTABILIDAD: No existe la operacion')
insert into cobis..cl_errores values (710319,1,'CONTABILIDAD: No existe parametrizado el area contable')
insert into cobis..cl_errores values (710320,1,'CONTABILIDAD: No esta definida el area contable para Gerente')
insert into cobis..cl_errores values (710321,1,'CONTABILIDAD: Error en la insercion de #asiento')
insert into cobis..cl_errores values (710322,1,'CONTABILIDAD: Error en la insercion de ca_asiento_contable')
insert into cobis..cl_errores values (710323,1,'CONTABILIDAD: Error en la actualizacion de #asiento')
insert into cobis..cl_errores values (710324,1,'CONTABILIDAD: No cuadra debito con credito')
insert into cobis..cl_errores values (710325,1,'CONTABILIDAD: Error en generacion de comprobante contable')
insert into cobis..cl_errores values (710326,1,'CONTABILIDAD: Error en generacion de asiento contable')
insert into cobis..cl_errores values (710327,1,'CONTABILIDAD: Error en actualizacion de ca_det_trn')
insert into cobis..cl_errores values (710328,1,'CONTABILIDAD: Error en actualizacion de ca_transaccion')
insert into cobis..cl_errores values (710329,1,'CONTABILIDAD: Error en insercion de ca_mesacambio_tmp')
insert into cobis..cl_errores values (710330,1,'CONTABILIDAD: Error en la insercion de #asiento_prv')
insert into cobis..cl_errores values (710331,1,'CONTABILIDAD: Error en la actualizacion de #asiento_prv')
go
delete cl_errores where numero in (710332,710333,710334,710335,710336,710337,710338,710339)
go
insert into cobis..cl_errores values (710332,1,'Error no se ha creado parametro para DEVOLUCION ML')
insert into cobis..cl_errores values (710333,1,'Error no se ha creado parametro para DEVOLUCION ME')
insert into cobis..cl_errores values (710334,1,'Operacion ya esta CANCELADA')
insert into cobis..cl_errores values (710335,1,'No se ha creado el parametro general de CxP DD de SIDAC')
insert into cobis..cl_errores values (710336,1,'Error Ejecutando sp_cuentaxpagar de SIDAC')
insert into cobis..cl_errores values (710337,1,'Error No se actualizo el registro fa_con_respon en cr_facturas')
insert into cobis..cl_errores values (710338,1,'CONTABILIDAD: No existe perfil contable para la Trn. o la trn. no es contable')
insert into cobis..cl_errores values (710339,1,'CONTABILIDAD: Error. No existe valor contable para la parte variable')
go
delete cl_errores where numero in (710340,710341,710342,710343,710344,710345,710346,710347,710348,710349)
go
insert into cobis..cl_errores values (710340,0,'Error en actualizacion de cupo de credito en tramite')
insert into cobis..cl_errores values (710341,1,'Error no existe el parametro general para renovacion ME')
insert into cobis..cl_errores values (710342,1,'Error no existe el parametro general para renovacion ML')
insert into cobis..cl_errores values (710343,1,'Aun no se ha cerrado la calificacion definitivamente')
insert into cobis..cl_errores values (710344,1,'Error no existe forma de pago')
insert into cobis..cl_errores values (710345,1,'Error No se ha parametrizado Forma de pago para Reversa')
insert into cobis..cl_errores values (710346,1,'CONTABILIDAD: Error. No existe definido el perfil contable') 
insert into cobis..cl_errores values (710347,1,'No se ha definifo forma de pago para Categoria') 
insert into cobis..cl_errores values (710348,1,'No se envio el avalista en archivo plano') 
insert into cobis..cl_errores values (710349,1,'No existe Historico de Fin de Mes  (transaccion HFM)') 
go
delete cl_errores where numero in (710350,710351,710352,710353,710354,710355,710356,710357,710358,710359,710360)
go
insert into cobis..cl_errores values (710350,1,'Error insertando en ca_control_trn_manual') 
insert into cobis..cl_errores values (710351,1,'Transacciones Manuales Pendientes') 
insert into cobis..cl_errores values (710352,1,'Cliente no esta en situación de Castigo') 
insert into cobis..cl_errores values (710353,1,'Cliente no esta en situación de Suspenso') 
insert into cobis..cl_errores values (710354,1,'Error cargando tabla ca_interfaz_ndc') 
insert into cobis..cl_errores values (710355,1,'Error No se ha definido parametro general AMOTOT para Dtos.D')
insert into cobis..cl_errores values (710356,1,'Error No se ha definido concepto AMOTOT para Dtos.D')
insert into cobis..cl_errores values (710357,1,'Error No se ha definido parametro general TRAMO para Dtos.D')
insert into cobis..cl_errores values (710358,1,'Error No se ha definido concepto TRAMO para Dtos.D')
insert into cobis..cl_errores values (710359,1,'Error No se ha definido parametro general DESDML para Dtos.D')
insert into cobis..cl_errores values (710360,1,'Error No se ha definido parametro general DESDME para Dtos.D')
go
delete cl_errores where numero in (710361,710362,710363,710364,710365,710366,710367,710368,710369,710370,
                                   710371,710372,710374,710375,710377,710378,710379,710380,710381,710382,710383)
go
insert into cobis..cl_errores values (710361,1 ,'Error No se ha definido parametro general AUTOFV para proyecciones')
insert into cobis..cl_errores values (710362,1 , 'Error No se ha definido parametro general para IVA')
insert into cobis..cl_errores values (710363,1 , 'Error No se ha definido parametro general para TIMBRE')
insert into cobis..cl_errores values (710364,1 , 'Error No se ha definido el concepto para TIMBRE ')
insert into cobis..cl_errores values (710365,1 , 'Error No se ha asociado el valor para TIMBRE ')
insert into cobis..cl_errores values (710366,1 , 'Error No permite actualizar la llave en historico  ')
insert into cobis..cl_errores values (710367,1 , 'Error No se ha definido parametro general forma de pago reconocimiento FAG')
insert into cobis..cl_errores values (710368,1 , 'Error No se ha definido parametro de reconocimiento FAG para Garantias')
insert into cobis..cl_errores values (710369,1 , 'Error No se ingreso el tipo de productor para la tabla de comisones FAG ')
insert into cobis..cl_errores values (710370,1 , 'Error No se ha definido el parametro general de comisones FAG ')
insert into cobis..cl_errores values (710371,1 , 'Error No existen datos para el tipo de garantia ')
insert into cobis..cl_errores values (710372,1 , 'Error el periodo de calculo del rubro  no es multiplo del de interes ')
insert into cobis..cl_errores values (710374,1 , 'Error No se ha definido parametro general ESTCJP')
insert into cobis..cl_errores values (710375,1 , 'Error No se ha definido parametro general CODPJU ')
insert into cobis..cl_errores values (710377,1 , 'Error No se ha definido margen de redescuento')
insert into cobis..cl_errores values (710378,1 , 'Error Insertando registros prepagos pasivas juridicos')
insert into cobis..cl_errores values (710379,1 , 'Error en Cursor prepagos juridicos ')
insert into cobis..cl_errores values (710380,1 , 'Error Actualizando registros prepagos pasivas juridicos ')
insert into cobis..cl_errores values (710381,1 , 'Error No se ha definido el parametro general FPPP')
insert into cobis..cl_errores values (710382,1 , 'Error No se ha creado la forma de pago para pasivas ')
insert into cobis..cl_errores values (710383,1 , 'Error en procedimiento almacenado sp_conversion_moneda ')
go
delete cl_errores where numero in (710384,710385,710386,710387,710388)
go
insert into cobis..cl_errores values (710384,1,'No se ha definido el parametro de lineas de credito con desembolsos masivos') --JCQ
insert into cobis..cl_errores values (710385,1,'No existe abono extraordinario para esta operacion')
insert into cobis..cl_errores values (710386,1,'Error No se ha definido una tasa para el rubro en catalogo')
insert into cobis..cl_errores values (710387,1,'Error No existe tasa para el seguro')
insert into cobis..cl_errores values (710388,1,'Error No existe el valor IPC')
go
delete cl_errores where numero in (710389,710390,710391,710392,710393,710394)
go
insert into cobis..cl_errores values (710389,1,'Error insertando en la tabla ca_cxc_no_cartera') 
insert into cobis..cl_errores values (710390,1,'Error No existe el valor inicial de UVR') 
insert into cobis..cl_errores values (710391,1,'Error No existen datos para el tramite enviado') 
insert into cobis..cl_errores values (710392,1,'Error Insertando prepagos pasivos por Consolidacion de pasivos') 
insert into cobis..cl_errores values (710393,1,'Error No existe operacion en CARTERA  con la llave de redescuento enviada') 
insert into cobis..cl_errores values (710394,1,'Error No se ha definido parametro general CODPCO para prepagos pasivas')
go
delete cl_errores where numero in (710395,710396,710397,710398,710399)
go
insert into cobis..cl_errores values (710395,1,'Error en generacion de cursor extracto_cliente')
insert into cobis..cl_errores values (710396,1,'Error insertando en la tabla ca_extracto_linea_tmp')
insert into cobis..cl_errores values (710397,1,'Error insertando en la tabla ca_detalles_garantia_deudor')
insert into cobis..cl_errores values (710398,1,'Error en generacion de cursor deudas indirectas')
insert into cobis..cl_errores values (710399,1,'Error insertando en la tabla ca_extracto_linea_tmp')
go
delete cl_errores where numero in (710400,710401,710402,710403,710404)
go
insert into cobis..cl_errores values (710400,1,'Error No se ha creado parametro general DEVSEG')
insert into cobis..cl_errores values (710401,1,'Error No se ha creado concepto para devolucion de seguros')
insert into cobis..cl_errores values (710402,1,'Error Factor es mayor que la Tasa Referencial')
insert into cobis..cl_errores values (710403,1,'Error El porcentaje es mayor que 100')
insert into cobis..cl_errores values (710404,1,'Error Insertando ca_abono_rubro la forma de pago')
go
delete cl_errores where numero in (710405,710406,710407,710408,710409,710410)
go
insert into cobis..cl_errores values (710405,1,'Error No se ha definido a¤o gravable en parametros generales')
insert into cobis..cl_errores values (710406,1,'Error No se ha definido inter‚s m ximo deducible en parametros generales')
insert into cobis..cl_errores values (710407,1,'Error No se ha definido el decreto reglamentario en parametros generales')
insert into cobis..cl_errores values (710408,1,'Error de lectura en cursor de pagos anuales')
insert into cobis..cl_errores values (710409,1,'Error insertando en la tabla de pagos anuales')
insert into cobis..cl_errores values (710410,1,'Los d¡as ingresados sobrepasan la fecha de vencimiento')
go
delete cl_errores where numero in (710411,710412,710413,710414,710415,710416,710417,710418,710419,710420,
                                   710421,710422,710423,710424,710425,710426,710427,710428,710429,710430)
go
insert into cobis..cl_errores values (710411,1,'Error Dividendo de capitalizacion tiene gracia de CAPITAL')
insert into cobis..cl_errores values (710412,1,'Error Dividendo origen de CAPITALIZACION  esta CANCELADO')
insert into cobis..cl_errores values (710413,1,'Error Dividendo destino de CAPITALIZACION  esta CANCELADO')
insert into cobis..cl_errores values (710414,1,'Error La tabla de amortizaci¢n proyectada no fue creada')
insert into cobis..cl_errores values (710415,1,'Error al Insertar en la tabla ca_abonos_masivos_generales')
insert into cobis..cl_errores values (710416,1,'Forma de Pago no definida en ca_producto')
insert into cobis..cl_errores values (710417,1,'Tipo de Aplicacion No Definida C=Rubro-FAG, D=Dividendo, P=Rubro Proporcional')
insert into cobis..cl_errores values (710418,1,'Tipo de Reducci¢n No Definida N=Normal, C=Reduccion Cuota, T=Reduccion Tiempo')
insert into cobis..cl_errores values (710419,1,'Prioridad de Concepto No definida')
insert into cobis..cl_errores values (710420,1,'Aplicacion Rubro Proporcional sin priodidad de Concepto')
insert into cobis..cl_errores values (710421,1,'Error. No se ha definido el  parametro general para devolucion de seguros')
insert into cobis..cl_errores values (710422,1,'Error. No se ha definido el  parametro NCAHO para devolucion seguros')
insert into cobis..cl_errores values (710423,1,'Error. No se ha definido el  parametro NCCC para devolucion seguros')
insert into cobis..cl_errores values (710424,1,'Error. No se ha definido la forma de pago para devolucion seguros')
insert into cobis..cl_errores values (710425,1,'Error. No se ha definido la forma de pago para devolucion de Intereses')
insert into cobis..cl_errores values (710426,1,'Error. No se ha definido parametro general para devolicion de intereses')
insert into cobis..cl_errores values (710427,1,'Error. Lectura del cursor de conciliacion mensual Z2')
insert into cobis..cl_errores values (710428,1,'Error. No se ha definido parametro de INT')
insert into cobis..cl_errores values (710429,1,'Error. No se ha definido parametro de CAP')
insert into cobis..cl_errores values (710430,1,'Error. Operacion pasiva ya esta marcada para prepago COBRO JURIDICO')
go
delete cl_errores where numero in (710431,710432,710433,710434,710435,710436,710437,710438,710439,710440,710441,710442,
                                   710443,710444,710445,710446,710447,710448,710449,710450,710451,710452,710453)
go
insert into cobis..cl_errores values (710431,1,'Codigo de Prepago no existe')
insert into cobis..cl_errores values (710432,1,'Error al Actualizar codigo prepago')
insert into cobis..cl_errores values (710433,1,'Error al Insertar codigo prepago')
insert into cobis..cl_errores values (710434,1,'Codigo  de Prepago ya Existe')
insert into cobis..cl_errores values (710435,1,'Operacion parametrizada para no aceptar Anticipos')
insert into cobis..cl_errores values (710436,1,'No se ha creado parámetro general para forma de pago pasivas')
insert into cobis..cl_errores values (710437,1,'No se ha creado la forma de pago pasivas')
insert into cobis..cl_errores values (710438,1,'Datos para validacion de Tasas Maximas en null')
insert into cobis..cl_errores values (710439,1,'Error.. Monto Calculado No es Igual al Monto Le¡do del Registro de Cabecera')              
insert into cobis..cl_errores values (710440,1,'Error.. Total Registros Calculado No es Igual al Total Registros del Registro de Cabecera') 
insert into cobis..cl_errores values (710441,1,'Error.. No se Puede Insertar en Tabla Cabecera')                                            
insert into cobis..cl_errores values (710442,1,'El monto de pago sobrepasa el saldo total del rubro')     
insert into cobis..cl_errores values (710443,1,'No existe tasa corriente para  la fecha y el dividendo vencido')
insert into cobis..cl_errores values (710444,1,'Error en definici¢n del perfil, existe un par metro no programado')
insert into cobis..cl_errores values (710445,1,'Error en contabilizacion de transaccion, alg£n valor no pudo ser resuelto en el perfil')
insert into cobis..cl_errores values (710446,1,'Error en contabilizacion de transaccion, alg£n valor no pudo ser resuelto en el perfil paso 0')
insert into cobis..cl_errores values (710447,1,'Error No se ha definido el parametro genera LAVACT')
insert into cobis..cl_errores values (710448,1,'Error Pago Realizado en Fecha Errada Prepagos Pasivas')
insert into cobis..cl_errores values (710449,1,'Error en actualizacion de tasas para IVA parametro general CONIVA sin valor')
insert into cobis..cl_errores values (710450,1,'Error en actualizacion de tasas para TIMBRE parametro general CONTIM sin valor')
insert into cobis..cl_errores values (710451,1,'Error en actualizacion de tasas para IVA parametro general TASIVA no definido')
insert into cobis..cl_errores values (710452,1,'Error en actualizacion de tasas para TIMBRE parametro general TASTIM no definido')
insert into cobis..cl_errores values (710453,1,'Error en fecha maxima TMM..vercaibc.sp')
go
PRINT 'Errores Varios'
go
delete cl_errores where numero in (710454,710455,710456,710457,710458,710459,710460,710461,710462,710463,710464)
go
insert into cobis..cl_errores values (710454,1,'EL CLIENTE NO SE ACTUALIZARA PORQUE TIENE REGISTROS EN EL CONSOLIDADOR')
insert into cobis..cl_errores values (710455,1,'Error en actualizacion de tabla ca_abonos_masivos_generales  Pagos PIT ')
insert into cobis..cl_errores values (710456,1,' Error en actualizacion de tabla ca_abonos_masivos_cabecera Pagos PIT')
insert into cobis..cl_errores values (710457,1,' Error ejecutando  cob_conta..sp_exenciu')
insert into cobis..cl_errores values (710458,1,' Error, C¢digo Externo Nulo en Operacion Pasiva')    
insert into cobis..cl_errores values (710459,1,' Error, C¢digo Externo Nulo en Operacion Activa')    
insert into cobis..cl_errores values (710460,1,' Error, Margen Redescuento <= 0 en Operacion Pasiva')
insert into cobis..cl_errores values (710461,1,' Error, Margen Redescuento <= 0 en Operacion Activa')
insert into cobis..cl_errores values (710462,1,' Error, Forma de Pago no valida para sobrante')
insert into cobis..cl_errores values (710463,1,' Error, PREPAGO DESDE LA VIGENTE SOLO ES PARA LAS LINEAS DE REDESCUENTO FINAGRO')
insert into cobis..cl_errores values (710464,1,' Error, LA OPERACION PASIVA TIENE CUOTAS VENCIDAS, PAGARLAS PARA PODER GENERAR EL PREPAGO')
go
delete cl_errores where numero in (710465,710466,710467,710468,710469,710470,710471,710472,710473,710474,
                                   710475,710476,710477,710478,710479,710480,710481,710482,710483,710484,
                                   710485,710486,710487,710488,710489,710490,710491,710492,710493,710494,
                                   710495,710496,710497,710498,710499,710500,710501,710502,710503,710504,
                                   710505,710506,710507,710508,710509,710510,710511,710512,710513,710514,
                                   710515,710516,710517,710518,710519,710520,710521,710522,710523,710524,
                                   710525,710526,710527,710528,710529,710530,710531,710532,710533,710534,
                                   710535,710536,710537,710538,710539,710540,710541,710542,710543,710544,
                                   710545,710546,710547,710548,710549,710550,710551,710552,710553,710554,
                                   710555,710556,710557,710558,710559,710560,710561,710562,710563,710564)
go
insert into cobis..cl_errores values (710465,1,' Error, La fecha de aplicacion del prepago no debe ser feriado')
insert into cobis..cl_errores values (710466,1,' Error, El cambio de est. de SUSPENSO a VIGENTE es automatico al pagar revisar la situación del cliente')
insert into cobis..cl_errores values (710467,1,' Error, La llave de redescuento enviada ya existe')
insert into cobis..cl_errores values (710468,1,' Atencion La moneda de la operacion no acepta decimales')
insert into cobis..cl_errores values (710469,1,' Error! Hay errores en conexion y paso a temporales..debe hacerse log off y log on')
insert into cobis..cl_errores values (710470,1,' Error! El archivo plano ya fue cargado')
insert into cobis..cl_errores values (710471,1,' Error! La Fecha de Creacion es Feriado para el BAC')
insert into cobis..cl_errores values (710472,1,' Error! La Oficina de la cabecera no es la misma del detalle')
insert into cobis..cl_errores values (710473,1,' Error! Operacion con registro de desembolso, no permite modificaciones')
insert into cobis..cl_errores values (710474,1,' Error! El codigo digitado no existe en la Base de Datos Cobis o no es tipo Empresa')
insert into cobis..cl_errores values (710475,1,' Error extrayendo la oficina de la transaccion TCO')
insert into cobis..cl_errores values (710476,1,' Error en monto contabilizado en transaccion CMO o PRV')
insert into cobis..cl_errores values (710477,1,' Error afectando la cuenta')
insert into cobis..cl_errores values (710478,1,' La ultima transaccion de la obligación no es CMO')
insert into cobis..cl_errores values (710479,1,' No existe parametro general 3XMCCA')
insert into cobis..cl_errores values (710480,1,' No existe parametro general para manejo de cheques propios')
insert into cobis..cl_errores values (710481,1,' No existe parametro general MMDC')
insert into cobis..cl_errores values (710482,1,' No existe parametro general PCAR')
insert into cobis..cl_errores values (710483,1,' Dividendo Vigente de la Activa diferente del Dividendo Vigente de la Pasiva')
insert into cobis..cl_errores values (710484,1,' Esta L¡nea de Cr‚dito esta parametrizada para NO aceptar Reestructuraciones')
insert into cobis..cl_errores values (710485,1,' Faltan transacciones por contabilizar. El cierre definitivo queda pendiente')
insert into cobis..cl_errores values (710486,1,' Error no existe ralacion activa pasiva en ca_relacion_ptmo')
insert into cobis..cl_errores values (710487,1,' Error no se genera archivo de redescuento por que no hay relacion de la linea en T17')
insert into cobis..cl_errores values (710488,1,' Error en lectura del cursor que actualiza garantias distriga.sp')
insert into cobis..cl_errores values (710489,1,' Error Tipo de Garantia Vehicular y no tiene definido clase de vehiculo para el calculo del SEGURO')
insert into cobis..cl_errores values (710490,1,' No hay Informacion para el calculo de seguro vehicular, Revisar Poliza,Tipo de Garantia y clse de vechiculo')
insert into cobis..cl_errores values (710491,1,' Todas las garantias deben estar en futuros creditos para el calculo del rubro')
insert into cobis..cl_errores values (710492,1,' Error Insertando  o Modificando en ca_transaccion  sp corrmon.sp')
insert into cobis..cl_errores values (710493,1,' MENSAJE INFORMATIVO: La regeneracion del Seguro Por Distribucion de Garantias dio 0, Revisar si es Correcto')
insert into cobis..cl_errores values (710494,1,' Error No existe tranasccion para aplicar la fecha valor')
insert into cobis..cl_errores values (710495,1,' Error La obligacion Pasiva se Reestructura Automaticamente')
insert into cobis..cl_errores values (710496,1,' Error La obligaciones  no reciben pagos de cuota completa en fechas diferentes al vencimiento')
insert into cobis..cl_errores values (710497,1,' MENSAJE INFORMATIVO. Se realizo un cambio de garantia que afecta el calculo de rubros en cartera')
insert into cobis..cl_errores values (710498,1,' Error No se definio el valor en pesos  en credito cr_tramite..tr_monto_desembolsop')
insert into cobis..cl_errores values (710499,1,' Error Este tipo de rubro no puede ser actualizado por esta funcionalidad')
insert into cobis..cl_errores values (710500,1,' Error Monto de Obligacion requiere cobro de impuesto de timbre, Registrar el concepto del porque no se le cobra')
insert into cobis..cl_errores values (710501,1,' Error insertando en la tabla de registro de moneda nacional')
insert into cobis..cl_errores values (710502,1,' Error actualizando en la tabla de registro de moneda nacional')
insert into cobis..cl_errores values (710503,1,' Error, Solo se deben seleccionar rubros cuyo calculo dependa de una garantia')
insert into cobis..cl_errores values (710504,1,' Error, La Operacion Activa no ha sido creada')
insert into cobis..cl_errores values (710505,1,' Error, La Operacion Activa no esta en estado de desembolso (NO VIGENET)')
insert into cobis..cl_errores values (710506,1,' Error, Tipo de Linea de Operacion Pasiva Diferente a la Operaci¢n Activa')
insert into cobis..cl_errores values (710507,1,' ATENCION, con transacciones en PVA no se puede hacer Fecha Valor o Reverso')
insert into cobis..cl_errores values (710508,1,' Error actualizando ca_transaccion a estado ING')
insert into cobis..cl_errores values (710509,1,' Error actualizando ca_det_trn el valor tr_monto_cont')
insert into cobis..cl_errores values (710510,1,' Error actualizando ca_transaccion a estado CON')
insert into cobis..cl_errores values (710511,1,' Error Obligacion Pasiva no Permite Sobrante por pago mayor al saldo')
insert into cobis..cl_errores values (710512,1,' Error Transaccion sin cotizacion ')
insert into cobis..cl_errores values (710513,1,' Error El tipo de cobro no acepta condonaciones')
insert into cobis..cl_errores values (710514,1,' Error Valor a condonar mayor que valor acumulado')
insert into cobis..cl_errores values (710515,1,' ATENCION, Se rechaza un prepago por que el valor del abono Voluntario es superior a saldo de cancelacion')
insert into cobis..cl_errores values (710516,1,' ATENCION, El valor del PREPAGO para  aplicar a CAPITAL excede el saldo de rubro CAP')
insert into cobis..cl_errores values (710517,1,' ATENCION, Para esta busqueda es necesario el No. de Operacion')
insert into cobis..cl_errores values (710518,1,' Error, El No. de lote Digitado No existe')
insert into cobis..cl_errores values (710519,1,' Error, El No. de lote Digitado Ya fue procesado y los pagos aplicados, No se puede eliminar')
insert into cobis..cl_errores values (710520,1,' Atencion, El No. de Lote digitado ya fue eliminado')
insert into cobis..cl_errores values (710521,1,' Atencion, Este pago  genero una Obligacion alterna, debe ser reversada y ANULADA')
insert into cobis..cl_errores values (710522,1,' Error en ejecución de programa externo')
insert into cobis..cl_errores values (710523,1,' Error en HC No se resolvieron todos los saldos de ca_saldos_cartera')
insert into cobis..cl_errores values (710524,1,' No existe registro en la tabla ca_valor_atx')
insert into cobis..cl_errores values (710525,1,' ANTES DE REALIZAR LA PRORROGA... DEBE CANCELAR LOS RUBROS DIFERENTES A CAPITAL E INTERES')
insert into cobis..cl_errores values (710526,1,' ANTES DE REALIZAR LA PRORROGA...DEBE COLOCAR LA OBLIGACION EN VIGENTE')
insert into cobis..cl_errores values (710527,1,' LA SITUACION DEL CLIENTE DEBE SER DIFERENTE A SUSPENSION MANUAL')
insert into cobis..cl_errores values (710528,1,' NO PUEDE PRORROGAR OPERACIONES CON CUOTA UNICA...SOBREPASA EL PLAZO')
insert into cobis..cl_errores values (710529,1,' NO PUEDE PRORROGAR LA ULTIMA CUOTA ESTO SE MANEJA POR REESTRUCTURACION')
insert into cobis..cl_errores values (710530,1,' NO PUEDE PRORROGAR LA ULTIMA CUOTA VENCIDA ')
insert into cobis..cl_errores values (710531,1,' Error insertando registro en ca_prorroga ')
insert into cobis..cl_errores values (710532,1,' Error No se encontro la operacion pasiva de la operacion activa que se esta prorrogando')
insert into cobis..cl_errores values (710533,1,' ANTES DE REALIZAR LA REESTRUCTURACION...DEBE COLOCAR LA OBLIGACION EN VIGENTE')
insert into cobis..cl_errores values (710534,1,' Atencion, Reversar primero las ultimas transacciones')
insert into cobis..cl_errores values (710535,1,' ANTES DE REALIZAR LA REESTRUCTURACION...DEBE COLOCAR LA OBLIGACION PASIVA EN VIGENTE')
insert into cobis..cl_errores values (710536,1,' La obligación activa y pasiva deben estar a la misma fecha de proceso, por favor hacer fecha valor')
insert into cobis..cl_errores values (710537,1,' NO EXISTEN SALDOS ANTERIORES PARA LA GENERACION DE CERTIFICADOS ANUALES')
insert into cobis..cl_errores values (710538,1,' Error, Debe existir al menos un rubro tipo Interes que con Causa  = S')
insert into cobis..cl_errores values (710539,1,' Error, las condiciones del credito no concuerdan con el pago')
insert into cobis..cl_errores values (710540,1,' Error, el crédito debe ser corregido antes de la aplicacion del pago')
insert into cobis..cl_errores values (710541,1,' Error, El reverso del pago no se ejecuto correctamente, RPA no revertido')
insert into cobis..cl_errores values (710542,1,' Error, Solo se pueden revertir pagos en estado Aplicado')
insert into cobis..cl_errores values (710543,1,' Error, El reverso del pago no se ejecuto correctamente, PAG no revertido')
--Errores para N.R prepago pasivas
insert into cobis..cl_errores values (710544,1,' Error, en Cursor de Impresion masiva de prepagos pasivas')
insert into cobis..cl_errores values (710545,1,' No existen datos solicitados de prepagos pasivas')
insert into cobis..cl_errores values (710546,1,' No existe esta condicion de busqueda')
insert into cobis..cl_errores values (710547,1,' La operacion digitada no se puede rechazar')
insert into cobis..cl_errores values (710548,1,' Error Insertando Obligaciones para castigar')
insert into cobis..cl_errores values (710549,1,' No se cargaron registros para Castigar')
insert into cobis..cl_errores values (710550,1,' Error Eliminando Obligaciones para castigar')
insert into cobis..cl_errores values (710551,1,' Error: Liquidar Nuevamente la obligacion, no se registraron los detalles completamente')
insert into cobis..cl_errores values (710552,1,' El saldo a girar para esta cuenta es 0, No se puede hacer el debito')
insert into cobis..cl_errores values (710553,1,' Error! En este momento no se puede hacer fecha valor,Por favor informar de este mensaje a los tecnicos')
insert into cobis..cl_errores values (710554,1,' Error! No se pudo hacer el reverso de transacciones,Por favor informar de este mensaje a los tecnicos')
insert into cobis..cl_errores values (710555,1,' Error! Revisar los pagos de la obligacion Anterior, Estan aplicados Debrian ser Reversados y Eliminados')
insert into cobis..cl_errores values (710556,1,' Error! El valor de los descuentos es mayor que el valor del credito')
insert into cobis..cl_errores values (710557,1,' Error! El el rubro seleccionado no ha tenido pago')
insert into cobis..cl_errores values (710558,1,' Error! Insertando en ca_datos_carta_redes')
insert into cobis..cl_errores values (710559,1,' ATENCION!!! Operacion No existe o ya fue renovada por favor revisar la Anterior y la nueva y sus respectivas transacciones')
insert into cobis..cl_errores values (710560,1,' ATENCION!!! Ya existe mensaje para este rango de fechas')
insert into cobis..cl_errores values (710561,1,' ATENCION!!! Fallo el paso a temporales de los rubros, por favor llamar a Los tecnicos')
insert into cobis..cl_errores values (710562,1,' Error faltan rubros basicos en la operacion  revisar por actualizacion')
insert into cobis..cl_errores values (710563,1,' ATENCION!!! El estado de esta obligacion no permite ingresar transacciones')
insert into cobis..cl_errores values (710564,1,' ATENCION!!! Favor ingrese el rubro COMISION, porque la obligacion tiene GARANTIA ESPECIAL')
--req.012
delete cl_errores where numero in (710565,710566,710567,710568,710569,710570,710571,710572,710573,710574,710575,710576,710577,710578,710579)
go
insert into cobis..cl_errores values (710565,1,'ATENCION!!! Debe cambiar la Fecha Inicial o la Fecha Final, porque ya existen registros para esas fechas')
go
insert into cobis..cl_errores values (710566,1,'Error en la insercion del registro, Revisar los datos!!!')
go
insert into cobis..cl_errores values (710567,1,'Error en la eliminacion del registro!!! ')
go
insert into cobis..cl_errores values (710568,1,'Error en la Actualizacion del registro!!! ')
go
insert into cobis..cl_errores values (710569,1,'Error en codigo de la zona no es Valido!!! ')
go
insert into cobis..cl_errores values (710570,1,'Error en codigo de la regional no es Valido!!! ')
go

insert into cobis..cl_errores values (710571,1,'Error  No existe Tasa referencial para la fecha de liquidacion!!! ')
go
insert into cobis..cl_errores values (710572,1,'Error la operacion tiene rubros Anticipados que no han sido pagados en  la cuota 1 No se reestructurara')
go
insert into cobis..cl_errores values (710573,1,'No existen datos para imprimir')
go
insert into cobis..cl_errores values (710574,1,'No se han cargado las cartas, Por favor solicitar ejecucion de esta carga')
go
insert into cobis..cl_errores values (710575,1,'Error en recuperacion de datos, transaccion No existosa')
go
insert into cobis..cl_errores values (710576,1,'Error al finalizar la reestructruacion, transaccion No existosa')
go
insert into cobis..cl_errores values (710577,1,'Error al finalizar la prorroga, transaccion No existosa')
go
insert into cobis..cl_errores values (710578,1,'Error al finalizar el cambio de estado, transaccion No existosa')
go
insert into cobis..cl_errores values (710579,1,'Error respaldando historico de ca_diferidos')
go

-- Errores para Traslado de Intereses IFJ NR379 de 711000 a 711007
delete cl_errores where numero in (711000,711001,711002,711003,711004,711005,711006,711007)
go
insert into cobis..cl_errores values(711000,1,'No existe Operacion para traslado de intereses')
insert into cobis..cl_errores values(711001,1,'Fecha de Ultimo Proceso es igual a la fecha de vencimiento')
insert into cobis..cl_errores values(711002,1,'La cuota de Origen es menor o igual que el dividendo')
insert into cobis..cl_errores values(711003,1,'La cuota de Origen es menor que la cuota de destino')
insert into cobis..cl_errores values(711004,1,'Ya existe la operacion con traslado de intereses en estado P')
insert into cobis..cl_errores values(711005,1,'Error respaldando historico de ca_traslado_intereses')
insert into cobis..cl_errores values(711006,1,'Error sacando historico de ca_traslado_intereses')
insert into cobis..cl_errores values(711007,1,'No se puede reducir la tabla antes de un traslado de intereses')
go

delete cl_errores where numero in (711008,711009,711010,711011,711012,711013,711014,711015,711016,
                                   711017,711018,711019,711020,711021,711022,711023,711024,711025)
go
--ERRORES REQ. 322. FECHA VALOR MASIVA
insert into cobis..cl_errores values(711008,1,'Error en la insercion de registro en fecha valor masivo')
insert into cobis..cl_errores values(711009,1,'Error al eliminar registro en fecha valor masivo')
go
--ERRORES NR 433
insert into cobis..cl_errores values(711010,1,'Error, La moneda de la operacion No debe tener Garantias Especiales asociadas')


--ERRORES NR 500
insert into cobis..cl_errores values(711011,1,'Error, La cuota Iniail debe ser Mayor a la cuota VIGENTE')

--CREDITO CONSTRUCTOR
insert into cobis..cl_errores values(711012,1,'Error, Crear la forma de Pago Automatica para Credito Constructor')
insert into cobis..cl_errores values(711013,1,'Error, Crear Parametro GEneral Para forma de Pago Automatica para Credito Constructor')
insert into cobis..cl_errores values(711014,1,'Error,Primero reversar el pago originado por este desembolso al Credito Constructor')
insert into cobis..cl_errores values(711015,1,'Error,Primero reversar el pago originado por este desembolso al Credito Constructor')
insert into cobis..cl_errores values(711016,1,'Error,No se ha definido el parametro de traslado de intereses CXCINTES')
insert into cobis..cl_errores values(711017,1,'Error,No se ha definido el rubro de traslado de intereses CXCINTES')

-- NR 293
insert into cobis..cl_errores values(711018,1,'El credito debe tener periodicidad de cuota M y ser exclusivamente mensual')
insert into cobis..cl_errores values(711019,1,'El credito no puede superar el monto de capital de la obligacion anterior')
go

--DEF- 5426 - 5861 BRANCH
insert into cobis..cl_errores values(711020,1,'Transaccion no Exitosa em el Central')
go

--NR 379
insert into cobis..cl_errores values(711021,1,'Error Insertando rubro en ca_rubro_op or traslado de Intereses')
go

--DEF -5970
insert into cobis..cl_errores values(711022,1,'Error en la aplicacion de pago, Capital no se afecto correctamente')
go

--NR - 479 
insert into cobis..cl_errores values(711023,1,'Por favor defeinir el parametro general nemonico PDPOG ')
go
insert into cobis..cl_errores values(711024,1,'Por favor defeinir el area para pagos  depositos en garantia ')
go

---REQ 237 CONTROL PARA LAVADO DE ACTIVOS
insert into cobis..cl_errores values(711025,1,'No se ha creado el parametro general MONTOL para lavado de activos')
go


---REQ 296 DESEMBOLSOS PARCIALES
delete cl_errores where numero in (711026,711027,711028,711029,711030,711031,711032,711033,711034,711035)
go
insert into cobis..cl_errores values(711026,1,'No se ha creado el parametro general MONTOL para lavado de activos')
insert into cobis..cl_errores values(711027,1,'Error Actualizando ca_operacion.op_monto en desembolso parcial')
insert into cobis..cl_errores values(711028,1,'Error Actualizando ca_rubro_op.ro_valor en desembolso parcial')
insert into cobis..cl_errores values(711029,1,'Error en saldo de operacion para desembolso parcial')
insert into cobis..cl_errores values(711030,1,'Error Actualizando ca_transaccion en desembolso parcial')
insert into cobis..cl_errores values(711031,1,'Error No se ha definido el parametro general para cancelacion de Credito rotativo')
insert into cobis..cl_errores values(711032,1,'Error No se ha definido forma de pago para cancelar credito rotativo')
insert into cobis..cl_errores values(711033,1,'Error Liberando monto para credito rotativo')
insert into cobis..cl_errores values(711034,1,'Error Los desembolsos de Operaciones Linea Rotativa deben hacerse en linea')
go

--NR - 479 
insert into cobis..cl_errores values(711035,1,'Error No existe consecutivo de pago en Sidac para hacer el reverso')
go

---DEF 6247 PREPOS PASIVAS
delete cl_errores where numero in (711036,711037,711038,711039,711040,711041,711042)
go
insert into cobis..cl_errores values(711036,1,'Error Actualizando la fecha de aplicacion del prepagos')
insert into cobis..cl_errores values(711037,1,'Error Actualizando la cotizacion de aplicacion del prepagos')
insert into cobis..cl_errores values(711038,1,'Error Eliminando prepago')
insert into cobis..cl_errores values(711039,1,'Error autorizando el pago de los prepagos')
insert into cobis..cl_errores values(711040,1,'Error Rechazando el Prepago')
insert into cobis..cl_errores values(711041,1,'Error Habilitando un Rechazo')
insert into cobis..cl_errores values(711042,1,'Error No se puede hacer cambio de ganantia mientras existan CGR pendientes de contabilizar')

go

---REQ 296 DESEMBOLSOS PARCIALES
delete cl_errores where numero in (711043,711044,711045,711046,711047,711048,711049)
go
insert into cobis..cl_errores values(711043,1,'Error creando dividendo en desembolso parcial')
insert into cobis..cl_errores values(711044,1,'Error creando detalle ca_amortizacion en desembolso parcial')
insert into cobis..cl_errores values(711045,1,'Error agrupando detalle ca_amortizacion en desembolso parcial')
insert into cobis..cl_errores values(711046,1,'Error Elimiando canceladas en ca_amortizacion en desembolso parcial')
insert into cobis..cl_errores values(711047,1,'Error Elimiando canceladas en ca_dividendo en desembolso parcial')
insert into cobis..cl_errores values(711048,1,'Error actualizando canceladas en ca_dividendo en desembolso parcial')
insert into cobis..cl_errores values(711049,1,'Error actualizando canceladas en ca_amortizacion en desembolso parcial')


---def 6753
delete cl_errores where numero in (711050,711051,711052,711053,711054,711055,711056,711057)
go
insert into cobis..cl_errores values(711050,1,'Error Operacion esta atrazada por este motivo no hace debito automatico')

---REQ 296 DESEMBOLSOS PARCIALES
insert into cobis..cl_errores values(711051,1,'Error actualizando dividendo ca_dividendo desembolso parciales')
insert into cobis..cl_errores values(711052,1,'Error actualizando dividendo ca_amortizacion desembolso parciales')
insert into cobis..cl_errores values(711053,1,'Error actualizando fecha_fin ca_operacion desembolso parciales')
insert into cobis..cl_errores values(711054,1,'Atencion!!!... Para hacer esta utilizacion la Obligacion debe estar al Dia')
insert into cobis..cl_errores values(711055,1,'Atencion!!!... Utilizacion no permitida El cupo esta Vencido')

--Credito constructor
insert into cobis..cl_errores values(711056,1,'Atencion!!!... Antes de reversar  el desembolso, reversar o eliminar pago de operacion realacionada')
--error para FACTORING
insert into cobis..cl_errores values(711057,1,'Atencion!!!...Los pagos de  Operaciones Factoring unicamente se reciben por plataforma')

--Error pagos
delete cl_errores where numero in (711058,711059,711060,711061)
go
insert into cobis..cl_errores values(711058,1,'Atencion!!!...Para la aplicacion de este pago la Operacion debe estar VENCIDA TOTALMENTE')
insert into cobis..cl_errores values(711059,1,'Atencion!!!...Dividendo Cancelado con Valores Pendientes de Pago')
insert into cobis..cl_errores values(711060,1,'Atencion!!!...Despues del pago existe mas de un dividendo VIGENTE Revisar')
insert into cobis..cl_errores values(711061,1,'Atencion!!!...Operacion debe  capital en cutoa CANELADA')
PRINT 'fin de instalacion codigos de erroes cartera'

--Error para controles de la generacion del maestro
delete cl_errores where numero in (711062,711063,711064,711065,711066,711067,711068,
                                   711069,711070,711071,711072,711073,711074,711075,711076)
go
insert into cobis..cl_errores values(711062,1,'Atencion!!!...REPROCESAR MAESTRO FALTARON PASO DE OPERACIONES')
insert into cobis..cl_errores values(711063,1,'Operacion no cargada en Herramienta de cuadre')
go

insert into cobis..cl_errores values(711064,1,'sp_cambio_estado_cobranza: ERROR al actualizar el registro en ca_operacion')
go

insert into cobis..cl_errores values(711065,1,'sp_cambio_estado_cobranza: ERROR al actualizar el registro en ca_operacion_his')
go

insert into cobis..cl_errores values(711066,1,'sp_cambio_estado_cobranza: ERROR al actualizar el registro en cob_cartera_his..ca_operacion_his')
go

insert into cobis..cl_errores values(711067,1,'sp_revisa_prepago_pasiva: ERROR al insertar registro en ca_prepagos_pasivas')
go

insert into cobis..cl_errores values(711068,1,'Se esta superando el monto aprobado con esta Utilizacion, Verificar el valor')
go
insert into cobis..cl_errores values(711069,1,'No se ha parametrizado la forma de pago en la tabla T80 de Correspondencias y proceso')
go
insert into cobis..cl_errores values(711070,1,'Dia de vencimiento de cuota queda mas de un dividendo VIGENTE Revisar')
go
insert into cobis..cl_errores values(711071,1,'No existe Historico de Migracion, Revisar Transaccion MIG')
go
insert into cobis..cl_errores values(711072,1,'Error no se ha creado el parametro general para desembolso end Renovacion nemonico FDESRE')
go
insert into cobis..cl_errores values(711073, 1, 'Cliente posee mas de una Operacion')
go
insert into cobis..cl_errores values(711074, 1, 'Cliente NO posee Operaciones')
go
insert into cobis..cl_errores values(711075, 1, 'Forma pago NO soportada por este proceso')
go
insert into cobis..cl_errores values(711076, 1, 'Estado de la Operacion no Acepta Pagos')
go
delete cl_errores where numero in (720201,720202,720203,720204,720205,720301,
                                   720302,720307,720308,720309,720310,720311,720401,720402,720403,720404,
                                   720405,720407,720408,720409,720501,720502,720503,720601,720602,720603,
                                   720604,720701,720702,720703,720704,720705,720801,720802,720803,720804,
                                   720805,720806,720807,720808,720809,720901,720902,720903,720904,720905,
                                   720906,721001,721002,721003,721004,721005,721006,721007,721101,721201,
                                   721202,721203,721204,721205,721206,721301,721302,721601,721602,721603,
                                   721604,721605,721606,721607,721608,721609,721610,721701,721901,722001,
                                   722002,722003,722004,722005,722006,722101,722102,722103,722104,722105,
                                   722106,722107,722108,722109,722201,722202,722203,722204,722501,723901,
                                   724301,724401,724402,724403,724404,724405,724406,724407,724408,724409,
                                   724410,724411,724501,724502,724503,724504,724505,724506,724507,724508,
                                   724509,724510,724511,724512,724513,724514,724515,724516,724517,724518, 
                                   724576, 724577, 724578, 724579, 724580, 724581, 724582, 724583, 724584, 
                                   724585,724586, 724587,720303,720304,720305,720306,721908,724588)
go
insert into cobis..cl_errores values (720201,0,'No se encontro el registro en ca_amortizacion para aplicar el pago')
go                                                                                                                        
insert into cobis..cl_errores values (720202,0,'El monto a aplicar supera el monto proyectado')
go                                                                                                                                             
insert into cobis..cl_errores values (720203,0,'El monto a aplicar supera el monto acumulado')
go                                                                                                                                              
insert into cobis..cl_errores values (720204,0,'Error aplicando pago en el rubro de la tabla de amortizacion')
go                                                                                                                              
insert into cobis..cl_errores values (720205,0,'Error insertando el detalle de transacci=n durante la aplicaci=n')
go                                                                                                                          
insert into cobis..cl_errores values (720301,0,'No se encontro el registro de detalle de conceptos a renovar')
go                                                                                                                              
insert into cobis..cl_errores values (720302,0,'No se encontro informaci=n del tramite de renovaci=n')
go                                                                                                                                      
insert into cobis..cl_errores values (720303,0,'Fecha de inicio de  la operacion nueva es diferente a la de ultimo proceso de la vieja REVISAR')
go                                                                                            
insert into cobis..cl_errores values (720304,0,'Error creando la transaccion de pago de renovaci=n')
go                                                                                                                                        
insert into cobis..cl_errores values (720305,0,'Error grave en ejecuci=n de sp_decimales')
go                                                                                                                                                  
insert into cobis..cl_errores values (720306,0,'El estado de la obligaci=n no permite su renovaci=n')
go                                                                                                                                       
insert into cobis..cl_errores values (720307,0,'Error en actualizaci=n del valor disponible de la garantia')
go                                                                                                                                
insert into cobis..cl_errores values (720308,0,'Error en actualizaci=n del estado de agotada de la garantfa')
go                                                                                                                               
insert into cobis..cl_errores values (720309,0,'Error en llamada para utilizaci=n del cupo')
go                                                                                                                                                
insert into cobis..cl_errores values (720310,0,'Error preparando valores de la renovaci=n')
go                                                                                                                                                 
insert into cobis..cl_errores values (720311,0,'Error La cancelacion total no fue exitosa Revisar')
go                                                                                                                                         
insert into cobis..cl_errores values (720401,0,'No se encontro el registro de detalle de conceptos a condonar')
go                                                                                                                             
insert into cobis..cl_errores values (720402,0,'No se encontro la obligaci=n a condonar')
go                                                                                                                                                   
insert into cobis..cl_errores values (720403,0,'Estado de la obligaci=n no valido para condonaciones')
go                                                                                                                                      
insert into cobis..cl_errores values (720404,0,'Error en la determinaci=n del numero de decimales de la moneda de la obligacion')
go                                                                                                           
insert into cobis..cl_errores values (720405,0,'Error en la registro de la transaccion de condonacion')
go                                                                                                                                     
insert into cobis..cl_errores values (720407,0,'Error en actualizaci=n del valor disponible de la garantfa')
go                                                                                                                                
insert into cobis..cl_errores values (720408,0,'Error en actualizaci=n del estado de agotada de la garantfa')
go                                                                                                                               
insert into cobis..cl_errores values (720409,0,'Error en llamada para utilizaci=n del cupo')
go                                                                                                                                                
insert into cobis..cl_errores values (720501,0,'No se encontro la obligaci=n a pagar')
go                                                                                                                                                      
insert into cobis..cl_errores values (720502,0,'Estado de la obligaci=n no valido para pagar')
go                                                                                                                                              
insert into cobis..cl_errores values (720503,0,'Error en el pago, valores pagados exceden la deuda')
go                                                                                                                                        
insert into cobis..cl_errores values (720601,0,'Error registrando la informacion del extracto')
go                                                                                                                                             
insert into cobis..cl_errores values (720602,0,'El cliente no existe en la base de clientes')
go                                                                                                                                               
insert into cobis..cl_errores values (720603,0,'La obligaci¢n no tiene registro de direcci¢n o esta errado')
go                                                                                                                                
insert into cobis..cl_errores values (720604,0,'La obligaci¢n no tiene oficina o departamento asociado')
go                                                                                                                                    
insert into cobis..cl_errores values (720701,0,'Concepto de Sidac  debe ser parametrizado en Sidac catalogo ac_conceptos_cxp')
go                                                                                                              
insert into cobis..cl_errores values (720702,0,'Ya fue parametrizado este Rubro, por favor revisar')
go                                                                                                                                        
insert into cobis..cl_errores values (720703,0,'Error Insertando en ca_rubro_planificador, Por favor revisar los datos existentes')
go                                                                                                         
insert into cobis..cl_errores values (720704,0,'Error Eliminando Registro de ca_rubro_planificador')
go                                                                                                                                        
insert into cobis..cl_errores values (720705,0,'Error Insertando transaccion de servicio')
go                                                                                                                                                  
insert into cobis..cl_errores values (720801,0,'No existe la obligacion solicitada')
go                                                                                                                                                        
insert into cobis..cl_errores values (720802,0,'La obligacion solicitada no pertenece al cliente indicado, por favor revise')
go                                                                                                               
insert into cobis..cl_errores values (720803,0,'Error pasando datos temporales a definitivos, no se puede ejecutar la transaccion en este momento')
go                                                                                         
insert into cobis..cl_errores values (720804,0,'Error cambiando de estado a los registros T, no se puede ejecutar la transaccion en este momento')
go                                                                                          
insert into cobis..cl_errores values (720805,0,'Error limpiando detalle temporal de renovacion, no se puede ejecutar la transaccion en este momento')
go                                                                                       
insert into cobis..cl_errores values (720806,0,'Error registrando detalle temporal de condonacion, no se puede ejecutar la transaccion en este momento')
go                                                                                    
insert into cobis..cl_errores values (720807,0,'No se hallaron solicitudes de condonación, por favor revise los datos ingresados')
go                                                                                                          
insert into cobis..cl_errores values (720808,0,'Error registrando condiciones de la condonación')
go                                                                                                                                           
insert into cobis..cl_errores values (720809,0,'Error registrando detalle de la condonación')
go                                                                                                                                               
insert into cobis..cl_errores values (720901,0,'Error Insertando datos para pago de Planificador')
go                                                                                                                                          
insert into cobis..cl_errores values (720902,0,'Error La obligacion ya tiene una Planificacion Ingresada, Revisar')
go                                                                                                                         
insert into cobis..cl_errores values (720903,0,'Error Eliminando datos de Planificador')
go                                                                                                                                                    
insert into cobis..cl_errores values (720904,0,'Error Actualizando datos de Planificador')
go                                                                                                                                                  
insert into cobis..cl_errores values (720905,0,'Error cuenta ahorros no existe o no pertenece al cliente seleccionado')
go                                                                                                                     
insert into cobis..cl_errores values (720906,0,'Error cuenta corriente no existe o no pertenece al cliente seleccionado')
go                                                                                                                   
insert into cobis..cl_errores values (721001,0,'Error Ejecutando programa cob_sidac..sp_cuentaxpagar modo I')
go                                                                                                                               
insert into cobis..cl_errores values (721002,0,'Error verificando el cliente de la obligacion')
go                                                                                                                                             
insert into cobis..cl_errores values (721003,0,'El estado de la obligaci=n no acepta pagos')
go                                                                                                                                                
insert into cobis..cl_errores values (721004,0,'Error en la inserci=n de la cabecera del abono')
go                                                                                                                                            
insert into cobis..cl_errores values (721005,0,'Error en la inserci=n del detalle del abono')
go                                                                                                                                               
insert into cobis..cl_errores values (721006,0,'Error en la inserci=n del detalle del abono')
go                                                                                                                                               
insert into cobis..cl_errores values (721007,0,'Error definir parametro con nemonico AROFCE Arae para oficina centralizadora ')
go                                                                                                             
insert into cobis..cl_errores values (721101,0,'La obligacion ya tiene Ingresada una Planificacion')
go                                                                                                                                        
insert into cobis..cl_errores values (721201,0,'Error Ejecutando programa sp_interfaz_planificador')
go                                                                                                                                        
insert into cobis..cl_errores values (721202,0,'Error Ejecutando programa cob_conta..sp_exenciu')
go                                                                                                                                           
insert into cobis..cl_errores values (721203,0,'Error No existe parametro general CONIVA')
go                                                                                                                                                  
insert into cobis..cl_errores values (721204,0,'Error No existe parametro general TASIVA')
go                                                                                                                                                  
insert into cobis..cl_errores values (721205,0,'Error tasa para el iva no definida en cob_cartera..ca_valor_det')
go                                                                                                                           
insert into cobis..cl_errores values (721206,0,'Error FOrma de pago mal parametrizada para pago a planificadores')
go                                                                                                                          
insert into cobis..cl_errores values (721301,0,'No existe parametrizacion en tablas de rubros un rangos  para este concepto')
go                                                                                                               
insert into cobis..cl_errores values (721302,0,'No existe parametrizacion en tablas de rubros dos rangos  para este concepto')
go                                                                                                              
insert into cobis..cl_errores values (721601,0,'Error Revisar en tabla de dos rangos Plazo meses Vs % cobertura Garantia')
go                                                                                                                  
insert into cobis..cl_errores values (721602,0,'Error No existen datos de garantia para el calculo del rubro')
go                                                                                                                              
insert into cobis..cl_errores values (721603,0,'Error Revisar en tabla de dos rangos Plazo meses Vs % Gracia Capital')
go                                                                                                                      
insert into cobis..cl_errores values (721604,0,'Error Revisar en tabla de un rangos Para  rangos validacion  concepto TIMBRE')
go                                                                                                              
insert into cobis..cl_errores values (721605,0,'Error Parametrizar en tablas de un rango  y programar este desarrollo')
go                                                                                                                     
insert into cobis..cl_errores values (721606,0,'Error Parametrizar en tablas de dos rango  y programar este desarrollo')
go                                                                                                                    
insert into cobis..cl_errores values (721607,0,'Error Parametrizar para el rubro el numero de rangos')
go                                                                                                                                      
insert into cobis..cl_errores values (721608,0,'Error no existe tasa en tabla de dos rangos para esta fecha del credito')
go                                                                                                                   
insert into cobis..cl_errores values (721609,0,'Error no existe tipo superior para el tipo de garantia enviado')
go                                                                                                                            
insert into cobis..cl_errores values (721610,0,'Error El sistema no tiene definido el calculo del rubro con mas de una garantia del mismo tipo')
go                                                                                            
insert into cobis..cl_errores values (721701,0,'Atencion  Obligacion  no puede ser seleccionada por que tiene una renovacion no Finalizada')
go                                                                                                
insert into cobis..cl_errores values (721901,0,'Error en la consulta del saldo acumulado de la obligaci=n')
go                                                                                                                                 
insert into cobis..cl_errores values (721908,1,'Documento a Imprimir no Parametrizado')
go                                                                                                                                 
insert into cobis..cl_errores values (722001,0,'Error La operacion no tiene definido rubro tipo Interes')
go                                                                                                                                   
insert into cobis..cl_errores values (722002,0,'Error en la insersion de registro tabla ca_ultima_tasa_op ')
go                                                                                                                                
insert into cobis..cl_errores values (722003,0,'Error No existen condiciones de tasa para la operacion')
go                                                                                                                                    
insert into cobis..cl_errores values (722004,0,'Error No existe referencial para esta operacion, REVISAR')
go                                                                                                                                  
insert into cobis..cl_errores values (722005,0,'Error No existe fecha referencial para esta operacion, REVISAR')
go                                                                                                                            
insert into cobis..cl_errores values (722006,0,'Error No existe variable @w_signo para esta operacion, REVISAR')
go                                                                                                                            
insert into cobis..cl_errores values (722101,0,'No se pudieron cargar los datos de la tasa pactada de la obligaci=n')
go                                                                                                                       
insert into cobis..cl_errores values (722102,0,'La tasa pactada no puede ser tipo TLU o TMM')
go                                                                                                                                               
insert into cobis..cl_errores values (722103,0,'No se encontro conversion y tasa efectiva esta en null')
go                                                                                                                                    
insert into cobis..cl_errores values (722104,0,'No se encontro conversion y tasa nominal esta en null')
go                                                                                                                                     
insert into cobis..cl_errores values (722105,0,'Error buscano la max fecha TLU')
go                                                                                                                                                            
insert into cobis..cl_errores values (722106,0,'Error buscano el sec de la fecha TLU')
go                                                                                                                                                      
insert into cobis..cl_errores values (722107,0,'Error buscano la tasa  TLU')
go                                                                                                                                                                
insert into cobis..cl_errores values (722108,0,'Error buscano la tasa  ut_referencial en ca_valor_referencial')
go                                                                                               
insert into cobis..cl_errores values (722109, 1, 'Cliente NO ha realizado el pago requerido')
go           
insert into cobis..cl_errores values (722201,0,'Error obteniendo el valor de la tasa')
go                                                                                                                                                      
insert into cobis..cl_errores values (722202,0,'Error obteniendo los parametros de la tasa')
go                                                                                                                                                
insert into cobis..cl_errores values (722203,0,'Error con el tipo de puntos solicitado')
go                                                                                                                                                    
insert into cobis..cl_errores values (722204,0,'Error no existe tasa referencial para la fecha de busqueda')
go                                                                                                                                
insert into cobis..cl_errores values (722501,0,'Error en las fechas, parecen invertidas')
go                                                                                                                                                   
insert into cobis..cl_errores values (723901,0,'Error Insertando detalle para crédito rotativo')
go                                                                                                                                            
insert into cobis..cl_errores values (724301,0,'El estado de la operación no procesa o clausula ya fue aplicada, Revisar')
go                                                                                                                  
insert into cobis..cl_errores values (724401,0,'Error actualizando ca_amortización')
go                                                                                                                                                        
insert into cobis..cl_errores values (724402,0,'Error limpiando tabla capital')
go                                                                                                                                                             
insert into cobis..cl_errores values (724403,0,'Error limpiando tabla ca_cuota_adicional')
go                                                                                                                                                  
insert into cobis..cl_errores values (724404,0,'Error limpiando tabla ca_amortizacion dividendos no vigentes')
go                                                                                                                              
insert into cobis..cl_errores values (724405,0,'Error limpiando tabla ca_dividendo dividendos no vigentes')
go                                                                                                                                 
insert into cobis..cl_errores values (724406,0,'Error actualizando ca_dividendo')
go                                                                                                                                                           
insert into cobis..cl_errores values (724407,0,'Error actualizando ca_operacion')
go                                                                                                                                                           
insert into cobis..cl_errores values (724408,0,'Error actualizando ca_dividendo despues de aplicar clausula')
go                                                                                                                               
insert into cobis..cl_errores values (724409,0,'Error actualizando ca_rubro_op despues de aplicar clausula')
go                                                                                                                                
insert into cobis..cl_errores values (724410,0,'Error Insertando la transaccion ACE')
go                                                                                                                                                       
insert into cobis..cl_errores values (724411,0,'Error La clausula no se puede aplicadar, revisar el credito')
go                                                                                                                               
insert into cobis..cl_errores values (724501,0,'Error No se encontro informacion de la operación en la tabla ca_operacion')
go                                                                                                                 
insert into cobis..cl_errores values (724502,0,'Error No se encontro identificacion del cliente en la tabla de clientes')
go                                                                                                                   
insert into cobis..cl_errores values (724503,0,'Error al registrar informacion en cob_cartera..ca_interfaz_mm_pygint')
go            
insert into cobis..cl_errores values (724504,0,'Error en Generacion de Consolidador')
go       
insert into cobis..cl_errores values (724505,0,'Dividendo supera máximo de dias permitidos')
go              
insert into cobis..cl_errores values (724506,0,'Dividendo inferior a mínimo de dias permitidos')
go                                                                                              
insert into cobis..cl_errores values (724507,0,'El desembolso se debe realizar por la pantalla de Renovacion')
go     
insert into cobis..cl_errores values (724508,0,'Error al insertar en tabla de comisiones de recuados')
go     
insert into cobis..cl_errores values (724509,0,'Error IvaComision No corresponde con Comision recibida')
go  
insert into cobis..cl_errores values (724510,0,'Error Fecha de proceso de la Operación diferente a del sistema')
go 
insert into cobis..cl_errores values (724511,0,'Error Valor nueva cuota supera al porcentaje de la inicialmente pactada')
go         
insert into cobis..cl_errores values (724512,1,'Fecha de proceso de las operaciones a renovar debe ser la del sistema')
go
insert into cobis..cl_errores values (724513,1,'El monto de la renovación no cubre el valor a renovar')
go
insert into cobis..cl_errores values (724514,0,'No existe trámite de renovación pendiente de desembolso')
go
insert into cobis..cl_errores values (724515,1,'Error en actualizacion de estado de la renovación en credito')
go
insert into cobis..cl_errores values (724516,1,'Para re-desembolsar una operación que renueva es necesario reversar los pagos de renovación anteriores')
go
insert into cobis..cl_errores values (724517,1,'Operación Fecha de pago superior a fecha de proceso o inferior a dias permitidos para fecha valor')
go
insert into cobis..cl_errores values (724518,1,'Archivo de recaudo ya fue cargado')
go

insert into cobis..cl_errores (numero, severidad, mensaje) values (724576, 0, 'ERROR EN EL REAJUSTE DE OPERACIONES')
go

insert into cobis..cl_errores (numero, severidad, mensaje) values (724577, 0, 'FALTA PARAMETROS PARA BCP DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724578, 0, 'NO EXISTE ARCHIVO PARA BCP DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724579, 0, 'ERROR EN BCP DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724580, 0, 'NO HAY REGISTROS EN BCP DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724581, 0, 'ERROR AL INGRESAR CABECERA DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724582, 0, 'ERROR AL INGRESAR DETALLE DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724583, 0, 'ERROR AL VALIDAR CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724584, 0, 'ERROR AL ACTUALIZAR DATOS DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724585, 0, 'ERROR AL ACTUALIZAR DETALLE DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724586, 0, 'NO HAY NUEVOS REGISTROS EN REEJECUCION DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724587, 0, 'ERROR AL ACTUALIZAR CABECERA DE CLIENTES EMPROBLEMADOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724588, 1, 'Error sacando historico de ca_comision_diferida')
go

insert into cobis..cl_errores (numero, severidad, mensaje) values (724592, 0, 'error. no se ha definido parametro de imo')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724594, 0, 'NO SE HA DEFINIDO PARAMETRO DE PORCENTAJE CAPITAL RENOVAR')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724590, 0, 'NO SE HA DEFINIDO PARAMETRO DE PORCENTAJE RENOVACION REESTRUCTURACION')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724595, 0, 'ERROR AL INSERTAR DIAS DE MORA EN LA TABLA CA_OPERACION_EXT')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724596, 0, 'NO FUE POSIBLE GUARDAR HISTORICOS DE DIAS MORA')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724597, 0, 'NO FUE POSIBLE RECUPERAR HISTORICOS DE DIAS MORA')
go

delete from cobis..cl_errores where numero in (724598, 724599, 724600, 724601, 724602, 724603, 724604, 724605, 724606,
 724607, 724608,724609, 724610, 724611, 724612, 724613, 724614, 724615, 724616, 724617, 724618, 724619, 724620, 724621)

insert into cobis..cl_errores (numero, severidad, mensaje) values (724598, 0, 'NO SE HA DEFINIDO PARAMETRO PARA IDENTIFICAR MICROCREDITOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724599, 0, 'ERROR AL INSERTAR EN LA TABLA CA_OPERACION_TMP')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724600, 0, 'ERROR ES NECESARIO EL NUMERO DE OPERACION PARA REGISTRAR EN CA_OPERACION_EXT_TMP')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724601, 0, 'ERROR ES NECESARIO EL NOMBRE DE LA COLUMNA PARA REGISTRAR EN CA_OPERACION_EXT_TMP')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724602, 0, 'ERROR AL INSERTAR EN LA TABLA CA_OPERACION_EXT_TMP')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724603, 0, 'ERROR AL ELIMINAR DE LA TABLA CA_OPERACION_EXT')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724604, 0, 'ERROR AL CONSULTAR DATOS DEL PROCESO EN EL FLUJO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724605, 0, 'ERROR AL CONSULTAR DATOS DEL GRUPO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724606, 0, 'VALOR DEL PORCENTAJE DE GARANTIAS EXCEDE AL DISPONIBLE DE CUENTA GRUPAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724607, 0, 'NO EXISTE PARAMETRO SAPP')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724608, 0, 'ERROR AL INSERTAR EN TEMPORALES LOS PAGOS RECIBIDOS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724609, 0, 'MONTO APROBADO ES MENOR O SUPERIOR AL PERMITIDO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724610, 0, 'MONTO NUEVO DEL FONDO DEBE SER MAYOR O IGUAL AL MONTO UTILIZADO DEL FONDO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724611, 0, 'MONTO DE LA TRANSACCION SUPERA EL DISPONIBLE DEL FONDO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724612, 0, 'NO SE ADMITE FECHA DE VIGENCIA MENOR A LA FECHA PROCESO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724613, 0, 'LA FECHA PROCESO SUPERA LA FECHA DE VIGENCIA DEL FONDO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724614, 0, 'NOMBRE DEL FONDO YA EXISTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724615, 0, 'FONDO NO EXISTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724616, 0, 'FONDO SE ENCUENTRA BLOQUEADO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724617, 0, 'NO EXISTEN EXISTEN DATOS DE LAS OPERACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724618, 0, 'UNA O VARIAS OPERACIONES NO SE ENCUENTRAN A LA FECHA PROCESO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724619, 0, 'EL PRESTAMO NO TIENE SALDO EXIGIBLE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724620, 0, 'VALOR DE GARANTIA INSUFICIENTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724621, 0, 'VALOR DEBE SER MAYOR A CERO')


delete from cobis..cl_errores where numero in (724622, 724623, 724624, 724625, 724626, 724627, 724628, 724629, 724630, 724631, 724632, 724633,
724636, 724637, 724638, 724639, 724640, 724650, 724642, 724643, 724644, 724645, 724646, 724647, 724648, 724649, 724651, 724652, 724653, 724654, 724655,
724656, 724657)

insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724622, 0, 'ERROR: FUNCIONARIO NO TIENE CORREO DE NOTIFICACION')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724623, 0, 'ERROR: NO EXISTE PARAMETRO RAXPC')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724624, 0, 'ERROR: NO EXISTE PARAMETRO NAXPC')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724625, 0, 'ERROR: AL GENERAR ARCHIVO XML')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724626, 0, 'ERROR: AL EJECUTAR ENVIO DE NOTIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724627, 0, 'ERROR: NO EXISTE PARAMETRO RBATN')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724628, 0, 'ERROR: NO EXISTE CATALOGO ca_param_notif')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724629, 0, 'ERROR: NO EXISTE PARAMETRO ISSUER')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724630, 0, 'ERROR: AL ELIMINAR LA TABLA TEMPORALES DE PAGOS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724631, 0, 'ERROR: AL INGRESAR LA TABLA TEMPORALES DE PAGOS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724632, 0, 'ERROR: AL INGRESAR LA TABLA TEMPORALES DE PAGOS NOTIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724633, 0, 'ERROR: AL ACTUALIZAR LA TABLA TEMPORALES DE PAGOS NOTIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724636, 0, 'ERROR: NO EXISTE RUTA DE SALIDA PARA EL XML EN EL BATCH')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724637, 0, 'ERROR: NO EXISTE DATOS EN EL PROCESO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724638, 0, 'ERROR: OPCION NO PERMITIDA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724639, 0, 'ERROR: NO EXISTE PARAMETRO GARPER')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724640, 0, 'ERROR: AL GENERAR LA INFORMACION PRINCIPAL DE DEUDAS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724642, 0, 'ERROR: AL GENERAR LOS MONTOS DE LAS DEUDAS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724643, 0, 'ERROR: AL GENERAR LA INFORMACION DE OFICIALES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724644, 0, 'ERROR: AL BORRAR LA DATA EXISTENTE DEL REPORTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724645, 0, 'ERROR: AL INGRESAR LA DATA DEL REPORTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724646, 0, 'ERROR: AL CONSULTAR NOMBRE DE LA EMPRESA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724647, 0, 'ERROR: NO EXISTE PARAMETRO MDWNA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724648, 0, 'ERROR: NO EXISTE PARAMETRO MDQNA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724649, 0, 'ERROR: NO EXISTE PARAMETRO MDMNA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724650, 0, 'ERROR: AL GENERAR LA INFORMACION DE GARANTIAS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724651, 0, 'ERROR: NO EXISTE PARAMETRO CODIGO DEL RUBRO SEGURO DEUDORES VENCIDO: SEDEVE ')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724652, 0, 'ERROR: NO EXISTE PARAMETRO RUBRO IVA INTERES: IVAINT')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724653, 0, 'ERROR: NO EXISTE PARAMETRO LOOPA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724654, 0, 'ERROR: NO EXISTE PARAMETRO FFOPA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724655, 0, 'ERROR: NO EXISTE PARAMETRO LMOPA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724656, 0, 'TOTAL DE VALORES DEL DETALLE NO COINCIDE CON EL MONTO TOTAL DEL PAGO SOLIDARIO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724657, 0, 'EL MONTO TOTAL DEL PAGO NO COINCIDE CON EL MONTO EXIGIBLE DE LA OPERACIÓN')
go

delete from cobis..cl_errores where numero in (724658, 724659, 724660, 724661, 724662, 724663, 724664, 724665, 724666, 724667, 724668, 724669, 724670, 724671, 724672)

insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724658, 0, 'ERROR: AL EJECUTAR EL SP sp_codeudor_tmp')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724659, 0, 'ERROR: AL EJECUTAR EL SP sp_crear_operacion')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724660, 0, 'ERROR: AL OBTENER LA INFORMACION DEL PRESTAMO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724661, 0, 'ERROR: AL EJECUTAR EL SP sp_modificar_operacion')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724662, 0, 'ERROR: AL INGRESAR EN LA TABLA RESULTADO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724663, 0, 'ERROR: AL ACTUALIZAR EL CAPITAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724664, 0, 'ERROR: AL ACTUALIZAR EL INTERES')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724665, 0, 'ERROR: AL ACTUALIZAR EL IVA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724666, 0, 'ERROR: AL ACTUALIZAR OTROS RURBROS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724667, 0, 'ERROR: AL ACTUALIZAR EL TOTAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724668, 0, 'ERROR: AL ACTUALIZAR EL SALDO CAPITAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724669, 0, 'ERROR: AL OBTENER LA TASA')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724670, 0, 'ERROR: AL OBTENER MOSTRAR LA INFORMACION')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724671, 0, 'ERROR: AL ELIMINAR EL PRESTAMOS TEMPORAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724672, 0, 'ERROR: CARACTERISTICAS DEL PRESTAMO GRUPAL INCORRECTAS')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (724680, 0, 'ESTA SOLICITUD NO PUEDE SER PROMOCIÓN')
go


delete from cobis..cl_errores where numero in (724634, 724635,724641, 70122, 70123, 70124, 70125,70126,70127, 70128, 70129,70130,70131,70132,70133)

insert into cobis..cl_errores (numero, severidad, mensaje) values (724634, 0, 'EL ARCHIVO CARGADO YA FUE PROCESADO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724635, 0, 'ERROR AL INSERTAR LOS REGISTROS DEL ARCHIVO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (724641, 0, 'NO SE PERMITEN CONSULTAS MENOS A LA FECHA DE ACTUAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70122, 0, 'NO EXISTE PARAMETRO PARA DIAS DE VENCIMIENTO EN LA OPERACION GRUPAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70123, 0, 'CARACTER NO ENCONTRADO EN LA CADENA DE TEXTO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70124, 0, 'CADENA DE TEXTO ESTÁ VACÍA')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70125, 0, 'CAMPO REQUERIDO ESTA CON VALOR NULO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70126, 0, 'PAGO SOLIDARIO DEL GRUPO YA HA SIDO INGRESADO PARA LA FECHA PROCESO ACTUAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70127, 0, 'NO EXISTE SOLICITUD DE PAGO SOLIDARIO PENDIENTE DE PROCESAR')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70128, 0, 'NO SE ENCONTRÓ CLIENTE EN EL TRÁMITE GRUPAL')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70129, 0, 'ERROR AL INSERTAR REGISTRO')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70130, 0, 'ERROR AL CONSULTAR DATOS DEL TRÁMITE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70131, 0, 'CORREO ANTERIOR AÚN SE ENCUENTRA VIGENTE')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70132, 0, 'EXISTE UN ENVÍO DE CORREO PENDIENTE DE PROCESAR')
insert into cobis..cl_errores (numero, severidad, mensaje) VALUES (70133, 0, 'GARANTÍA LÍQUIDA NO TIENE PAGO PENDIENTE')

delete from cobis..cl_errores where numero in (724673, 724674, 724675)

INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (724673, 0, 'ERROR: NO EXISTE PARAMETRO CANGAR')
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (724674, 0, 'ERROR: EL TRAMITE NO SE ENCUENTRA EN LA ACTIVIDAD DE ESPERA DE CANCELACIÓN DE GARANTÍA. SE REVERSA EL PAGO.')
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (724675, 0, 'ERROR: AL LIMPIAR EL PATH DE LOS ARCHIVOS XML ESTADO DE CUENTA')


go

delete from cobis..cl_errores where numero in (70134, 70135, 70136, 70137, 70138, 70139, 70140, 70141, 70142, 70143, 70144, 70145, 70146)

insert into cobis..cl_errores (numero, severidad, mensaje) values (70134, 0, 'ERROR: NO EXISTE PARAMETRIA DEL BATCH')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70135, 0, 'ERROR: NO EXISTE PARAMETRO PCPREP')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70136, 0, 'ERROR: NO EXISTE CORTE')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70137, 0, 'ERROR: NO EXISTE DATOS DE CUENTAS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70138, 0, 'ERROR: NO EXISTE INFORMACION DE SALDOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70139, 0, 'ERROR: NO EXISTE INFORMACION DE CONSOLIDADOR')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70140, 0, 'ERROR: AL ACTUALIZAR CALIFICACIONES DE PROVISIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70141, 0, 'ERROR: AL ACTUALIZAR INFORMACION DE PROVISIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70142, 0, 'ERROR: AL ACTUALIZAR INFORMACION CUENTA DE PROVISIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70143, 0, 'ERROR: BORRAR LA TABLA TEMPORAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70144, 0, 'ERROR: INGRESAR TITULOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70145, 0, 'ERROR: INGRESAR INFORMACION DE REPORTE A0411')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70146, 0, 'ERROR: GENERAR LISTADO')
GO

delete from cobis..cl_errores where numero in (70148, 70149, 70150, 70151, 70152, 70153, 70154, 70155, 70156, 70157, 70158, 70159, 70160, 
                                                70161, 70162, 70163, 70164, 70165, 70166, 70167, 70168, 70169, 70170, 70171,70172, 70173,
                                                70174)

insert into cobis..cl_errores (numero, severidad, mensaje) values (70148, 0, 'ERROR: NO EXISTE PARAMETRO CFN')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70149, 0, 'ERROR: NO EXISTE PERIODO FIN DE MES (ACTUAL)')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70150, 0, 'ERROR: NO EXISTE PERIODO FIN DE MES (ANTERIOR)')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70151, 0, 'ERROR: AL CONSULTAR PROVISIONES DEL MES ANTERIOR')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70152, 0, 'ERROR: AL CONSULTAR PROVISIONES DEL MES ACTUAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70153, 0, 'ERROR: NO EXISTE INFORMACION DE PROVISIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70154, 0, 'ERROR: AL CONSULTAR MOVIMIENTOS DE QUITAS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70155, 0, 'ERROR: AL ACTUALIZAR MOVIMIENTOS DE QUITAS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70156, 0, 'ERROR: AL INGRESAR MOVIMIENTOS DE QUITAS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70157, 0, 'ERROR: AL CONSULTAR MOVIMIENTOS DE CASTIGOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70158, 0, 'ERROR: AL ACTUALIZAR MOVIMIENTOS DE CASTIGOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70159, 0, 'ERROR: AL INGRESAR MOVIMIENTOS DE CASTIGOS')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70160, 0, 'ERROR: AL CONSULTAR MOVIMIENTOS DE BONIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70161, 0, 'ERROR: AL ACTUALIZAR MOVIMIENTOS DE BONIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70162, 0, 'ERROR: AL INGRESAR MOVIMIENTOS DE BONIFICACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70163, 0, 'ERROR: AL CONSULTAR MOVIMIENTOS DE DACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70164, 0, 'ERROR: AL ACTUALIZAR MOVIMIENTOS DE DACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70165, 0, 'ERROR: AL INGRESAR MOVIMIENTOS DE DACIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70166, 0, 'ERROR: AL CONSULTAR MOVIMIENTOS DE VARIACION CAMB')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70167, 0, 'ERROR: AL ACTUALIZAR MOVIMIENTOS DE VARIACION CAMB')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70168, 0, 'ERROR: AL INGRESAR MOVIMIENTOS DE VARIACION CAMB')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70169, 0, 'ERROR: AL ACTUALIZAR EL VALOR DE LAS PROVISIONES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70170, 0, 'ERROR: AL GENERAR DATOS DEL REPORTE')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70171, 0, 'ERROR: AL GENERAR EL ARCHIVO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70172, 0, 'GRUPO SE ENCUENTRA EN 2 PROCESOS DEL FLUJO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70173, 0, 'GARANTÍA NO TIENE PAGOS PENDIENTES')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70174, 0, 'CLIENTE NO TIENE REGISTRADA CUENTA DE AHORRO')

--CGS-138982 Pagos Referenciados

delete cobis..cl_errores where numero between 70177 and 70215

insert into cobis..cl_errores (numero, severidad, mensaje) values (70177, 0, 'ERROR: EL FORMATO DE LA FECHA DE PAGO ES INCORRECTO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70178, 0, 'ERROR: LA FECHA DE PAGO ES MAYOR A LA FECHA DE PROCESO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70179, 0, 'ERROR: EL PAGO TIENE MÁS DE 60 DÍAS DE ANTIGUEDAD.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70180, 0, 'ERROR: DÍGITO VERIFICADOR DE LA REFERENCIA NO CORRESPONDE.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70181, 0, 'ERROR: LA LONGITUD DE REFERENCIA NO ES VÁLIDA.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70182, 0, 'ERROR: EL MONTO DE PAGO NO ES VALIDO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70183, 0, 'ERROR: EL GRUPO DE LA REFERENCIA NO EXISTE.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70184, 0, 'ERROR: NO EXISTE TRAMITE GRUPAL EN CURSO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70185, 0, 'ERROR: EL MONTO DE PAGO DEBE SER POSITIVO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70186, 0, 'ERROR: NO EXISTE EL CRÉDITO RELACIONADO A LA REFERENCIA O NO ACEPTA PAGOS.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70187, 0, 'ERROR: EL TIPO DE LA REFERENCIA ES INCORRECTO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70188, 0, 'ERROR: NO EXISTE PARAMETRO CNVGAR.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70189, 0, 'ERROR: NO EXISTE PARAMETRO CNVPRE.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70190, 0, 'ERROR: EL VALOR DEL MONTO PAGADO ES NULO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70191, 0, 'ERROR: NO EXISTE PARAMETRO REFOP.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70192, 0, 'ERROR: NO EXISTE PARAMETRO REFSTD.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70193, 0, 'ERROR: NO EXISTE TRAMITE INGRESADO PARA EL GRUPO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70194, 0, 'ERROR: NO EXISTE REGISTRO DEL TRAMITE GRUPAL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70195, 0, 'ERROR: NO EXISTE OFICINA DEL TRAMITE INGRESADO PARA EL GRUPO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70196, 0, 'ERROR: NO EXISTE OFICIAL DEL TRAMITE INGRESADO PARA EL GRUPO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70197, 0, 'ERROR: NO EXISTE PRÉSTAMO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70198, 0, 'ERROR: CORRESPONSAL NO REGISTRADO COMO FORMA DE PAGO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70199, 1, 'NO EXISTE PARAMETRO PARA DIAS DE VENCIMIENTO EN LA OPERACION REVOLVENTE')
--Errores para Interfactura
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70200, 0, 'ERROR EN INGRESO DE INTERFACTURA')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70201, 0, 'ERROR EN INGRESO DE ESTADO DE CUENTA')
--Errores OXXO
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70203, 0, 'ERROR: OPERACIÓN NO VÁLIDA')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70204, 0, 'ERROR: TIPO DE TRANSACCIÓN NO VÁLIDA')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70205, 0, 'ERROR: ID DE GRUPO O NÚMERO DE CRÉDITO INDIVIDUAL NO VÁLIDO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70206, 0, 'ERROR: NO SE PUDO CONSULTAR EL SP DEL CORRESPONSAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70207, 0, 'ERROR: ERROR AL EJECUTAR EL SP DEL CORRESPONSAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70208, 0, 'ERROR: ID DE REFERENCIA NO VÁLIDO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70209, 0, 'ERROR: EL CORRESPONSAL NO ESTÁ REGISTRADO O ESTÁ INACTIVO')
--Errores Pagos Masivos
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70212, 0, 'ERROR: YA EXISTE UN ARCHIVO DE PAGO CON EL MISMO NOMBRE')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70213, 0, 'ERROR: NO SE PUDO INSERTAR EL REGISTRO DE LA REFERENCIA ')
--Errores OXXO Sucursal
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70214, 0, 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70215, 0, 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO')
go
--Errores para SMS
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) VALUES(70011018,1,'Error: No existe plantilla para envío de sms.')


USE cobis
GO
DELETE cobis..cl_errores WHERE numero =  701191
-- para controlar la reversa del pago que tiene sobrante
INSERT INTO cobis..cl_errores VALUES (701191, 0, 'No puede reversar esta transaccion')

go

DELETE cobis..cl_errores WHERE numero =  701192
INSERT INTO cobis..cl_errores VALUES (701192, 1, 'La Fecha valor es mayor a la fecha proceso')
go

delete from cobis..cl_errores where numero = 724589

insert into cl_errores (numero, severidad, mensaje)
                values (724589, 0        , 'No se puede reversar transaccion, contiene pagos con sobrantes')
go


delete from cobis..cl_errores where numero = 724591

insert into cl_errores (numero, severidad, mensaje)
                values (724591, 0        , 'No se puede reversar transaccion de operaciones canceladas')
               
go

delete cl_errores where numero in (70320,70321,70322,70323, 70324)
insert into cobis..cl_errores (numero, severidad, mensaje) values (70320, 1, 'No existen préstamos asociados a la operación grupal.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70321, 1, 'No existe operación para el préstamo ingresado.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70322, 1, 'No existe garantía líquida para el trámite ingresado.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70323, 1, 'AVISO: Este grupo/persona no tiene cuentas pendientes de cobro')
insert into cobis..cl_errores (numero, severidad, mensaje) values (70324, 1, 'ERROR: Ocurrió un error al consultar las operaciones del grupo/persona')

go

delete cobis..cl_errores where numero in (70301, 70302, 70303,70304, 70305, 70306, 70307)
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70301, 0, 'ERROR: NO EXISTE PRESTAMO GRUPAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70302, 0, 'ERROR: NO EXISTE PRESTAMO INDIVIDUAL')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70303, 0, 'ERROR: NO EXISTE CONFIGURACION PARA LIMITES DE PAGO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70304, 0, 'ERROR: TOKEN NO COINCIDE')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70305, 0, 'ERROR: NO EXISTE EL CORREPONSAL PARAMETRIZADO')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70306, 0, 'ERROR: ERROR AL CONSULTAR ESTADOS DE CARTERA')
insert into cobis..cl_errores  (numero, severidad, mensaje)values (70307, 0, 'ERROR: EXISTE MAS DE UN REGISTRO A REVERSAR CON EL FOLIO INGRESADO.')
go

delete cl_errores where numero in (6900070)
insert into cl_errores (numero, severidad, mensaje) values (6900070, 0        , 'Producto bancario deshabilitado')
go

delete cl_errores where numero in (710610,710611)
insert into cl_errores values(710610,1,'ESTA FORMA DE PAGO NO APLICA PARA PAGOS GRUPALES')
insert into cl_errores values(710611,1,'ERROR AL APLICAR EL PAGO')

insert into cobis..cl_errores values (70068, 0,'NO ES LCR')
insert into cobis..cl_errores values (70069, 0,'LCR ya está vencida')
insert into cobis..cl_errores values (70070, 0,'No se permite cancelar anticipadamente una LCR con saldo pendiente de cobro')
insert into cobis..cl_errores values (70071, 0,'No se permite cancelar una LCR con transacciones pendientes de aplicación')
insert into cobis..cl_errores values (70072, 0,'ERROR AL CREAR LA TRANSACCION CLC')
insert into cobis..cl_errores values (70073, 0,'No se actualizo la fecha de vencimiento')

go


delete cl_errores where numero in (720312)
insert into cobis..cl_errores (numero, severidad, mensaje) values (720312, 0, 'ERROR PAGO DUPLICADO')
go
--Erores para pagos Grupales Solidarios
use cobis
go

delete from cobis..cl_errores
where numero in (720313,720314,720315,720316,720317,720318,720319,720320)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720313, 0, 'EL CONTRATO NO CORRESPONDE A UN CREDITO AGRUPADOR ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720314, 0, 'EL MONTO TOTAL NO ES IGUAL A LA SUMA DE LOS MONTOS INDIVIDUALES ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720315, 0, 'EL ID DE CANAL DEL PAGO NO EXISTE EN COBIS ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720316, 0, 'EL MONTO INGRESADO NO CORRESPONDE AL MONTO REGISTRADO EN COBIS ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720317, 0, 'ALGUNO DE LOS CLIENTES NO PERTENECE  AL GRUPO ')
go


insert into cobis..cl_errores (numero, severidad, mensaje)
values (720318, 0, 'LOS MONTOS DE LOS CLIENTES DEBE SER MAYOR A CERO ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720319, 0, 'EL NUMERO DE DECIMALES DE LOS MONTOS INDIVIDUALES DEBE SER HASTA 2 ')
go

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720320, 0, 'EL ID DE CANAL DEL PAGO NO CORRESPONDE AL CREDITO AGRUPADOR ')
go

-------------------------------------------------
-----------       COLECTIVOS       --------------
-------------------------------------------------
  
delete cl_errores where numero in (70400)
insert into cl_errores values(70400,1,'ERROR: NO ESTA PARAMETRIZADO UN ASESOR PARA EL COLECTIVO INGRESADO')
go

--DESPLAZAMIENTOS
delete cobis..cl_errores where numero in (720330,720331,720332)
insert into cobis..cl_errores (numero, severidad, mensaje)
values (720330, 1, 'NO SE ENCONTRO EL ARCHIVO')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720331, 1, 'PROCESADO ANTERIORMENTE')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (720332, 1, 'NO EXISTE LA RUTA DEL ARCHIVO')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (720333, 0, 'ERROR: LOS VALORES DEL SEGURO NO HA SIDO PAGADOS')

-------------------------------------------------
----------- VENTA DE SEGUROS       --------------
-------------------------------------------------

delete cobis..cl_errores where numero in (724681,724682)

insert into cl_errores (numero, severidad, mensaje) values (724681, 0, 'ERROR EN ACUALIZAR LOS SEGUROS')
insert into cl_errores (numero, severidad, mensaje) values (724682, 0, 'ERROR EN INSERTAR LOS SEGUROS')
go
----CAMBIOS LCR
delete from cl_errores where numero in (724683,724684,724685,724686, 724687)

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724683, 0, 'El grupo del cliente ha cubierto el porcentaje aceptable de otorgamiento')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724684, 0, 'El desbloqueo debe ser autorizado')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724685, 0, 'Se deben tener al menos # pagos') --- se reemplaza 2 por #

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724686, 0, 'No cumple con las condiciones de pagos para incremento')

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (724687, 0, 'No hay folio asociado')

go


delete cobis..cl_errores where numero = 701195
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701195, 0, 'La fecha de pago no debe ser feriado o fines de semana')

delete cobis..cl_errores where numero = 701196
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701196, 0, 'Verifica tu día de Pago')

delete cobis..cl_errores where numero = 701197
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701197, 0, 'La fecha de pago es menor a la fecha de desembolso')

delete cobis..cl_errores where numero = 701198
insert into cobis..cl_errores (numero, severidad, mensaje)
values (701198, 0, 'Fecha generada inválida para día de pago')

---->>>>PorCaso#19322
insert into cl_errores (numero, severidad, mensaje) values (70076, 0, 'Error al registrar información de la simulación')
