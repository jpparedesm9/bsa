use cobis

delete from cobis..cl_errores  where numero between 2100000 and 2199999

insert into cl_errores values ( 2101001,  1, ' Campos NOT NULL con valores Nulos')
go 
insert into cl_errores values ( 2101002,  1, ' Registro ya existe')
go
insert into cl_errores values ( 2101003,  1, ' Registro de cotizacion de moneda extranjera no existe')
go 
insert into cl_errores values ( 2101004,  1, ' La Siguiente etapa en la ruta no existe')
go 
insert into cl_errores values ( 2101005,  1, ' Registro No existe')
go 
insert into cl_errores values ( 2101006,  1, ' Tipo de transaccion no corresponde')
go 
insert into cl_errores values ( 2101007,  1, ' No existe tabla en tabla de secuenciales')
go 
insert into cl_errores values ( 2101008,  1, ' No existen datos solicitados')
go 
insert into cl_errores values ( 2101009,  1, ' No existen mas datos solicitados')
go 
insert into cl_errores values ( 2101010,  1, ' No existe Cupo de Credito')
go 
insert into cl_errores values ( 2101011,  1, ' No existe Operacion de Credito')
go 
insert into cl_errores values ( 2101012,  1, ' Usuario No Valido en Estaciones')
go 
insert into cl_errores values ( 2101013,  1, ' Gerente del Cliente Diferente al Ingresado')
go 
insert into cl_errores values ( 2101014,  1, ' El tramite no tiene nivel de aprobacion')
go 
insert into cl_errores values ( 2101015,  1, ' Error en recuperacion de datos del cursor')
go 
insert into cl_errores values ( 2101016,  1, ' Codeudor/Avalista no definido para la operacion')
go 
insert into cl_errores values ( 2101017,  1, ' El paso asociado no corresponde a la misma ruta')
go 
insert into cl_errores values ( 2101018,  1, ' El paso a asociar no existe en la ruta')
go 
insert into cl_errores values ( 2101019,  1, ' El paso a asociar no es centralizador')
go 
insert into cl_errores values ( 2101020,  1, ' El gerente no tiene superior asignado')
go 
insert into cl_errores values ( 2101021,  1, ' El numero de operacion referenciado no existe')
go 
insert into cl_errores values ( 2101022,  1, ' El codigo de gerente no tiene correspondencia con funcionarios')
go 
insert into cl_errores values ( 2101023,  1, ' Director no tiene estacion de trabajo asignada')
go 
insert into cl_errores values ( 2101024,  1, ' Estacion del gerente no esta en la ruta del tramite')
go 
insert into cl_errores values ( 2101025,  1, ' El Cupo no tiene fecha de aprobacion')
go 
insert into cl_errores values ( 2101026,  1, ' El Cupo no tiene fecha de vencimiento o esta vencido')
go 
insert into cl_errores values ( 2101027,  1, ' El Cupo no tiene disponible para este desembolso')
go 
insert into cl_errores values ( 2101028,  1, ' Error al abrir un cursor')
go 
insert into cl_errores values ( 2101029,  1, ' Error cursor sin datos')
go 
insert into cl_errores values ( 2101030,  1, ' La estacion pertenece a otra oficina')
go 
insert into cl_errores values ( 2101031,  1, ' La estacion no tiene sustituto asignado')
go 
insert into cl_errores values ( 2101032,  1, ' No existe constante de gerente superior')
go 
insert into cl_errores values ( 2101033,  1, ' No se puede determinar la siguiente estacion de trabajo')
go 
insert into cl_errores values ( 2101034,  1, ' No existe la Linea de Credito con la Moneda indicada')
go 
insert into cl_errores values ( 2101035,  1, ' Monto distribuido excede el Total del Cupo')
go 
insert into cl_errores values ( 2101036,  1, ' Monto distribuido menor que el Monto Utilizado')
go 
insert into cl_errores values ( 2101037,  1, ' No se ha especificado Estacion destino para mover los tramites')
go 
insert into cl_errores values ( 2101038,  1, ' No se puede eliminar la distribucion por Moneda pues existe Monto Utilizado')
go 
insert into cl_errores values ( 2101039,  1, ' No se puede determinar el tipo de la Siguiente Etapa en la Ruta')
go 
insert into cl_errores values ( 2101040,  1, ' No se pudo encontrar la etapa correspondiente al Paso Actual en la Ruta')
go 
insert into cl_errores values ( 2101041,  1, ' No se puede determinar el tipo de la Etapa Anterior en la Ruta')
go 
insert into cl_errores values ( 2101042,  1, ' El limite minimo ya se encuentra definido en otro rango de tiempo')
go 
insert into cl_errores values ( 2101043,  1, ' La fecha de visita es Mayor a la fecha de ingreso de Reporte')
go 
insert into cl_errores values ( 2101044,  1, ' No tiene estacion superior asignada con el cargo correspondiente')
go 
insert into cl_errores values ( 2101045,  1, ' El limite maximo ya se encuentra definido en otro rango de tiempo')
go 
insert into cl_errores values ( 2101046,  1, ' No es posible crear reglas para un paso asociado')
go 
insert into cl_errores values ( 2101047,  1, ' La excepcion/instruccion debe ser aprobada por estacion')
go 
insert into cl_errores values ( 2101048,  1, ' La estacion debe estar en etapa de aprobacion')
go 
insert into cl_errores values ( 2101049,  1, ' La estacion debe estar definida en la etapa')
go 
insert into cl_errores values ( 2101050,  1, ' No existe una estacion que pueda aprobar el tramite')
go 
insert into cl_errores values ( 2101051,  1, ' No existe estacion que pueda aprobar la excepcion o instruccion')
go 
insert into cl_errores values ( 2101052,  1, ' No fue posible evaluar las variables del tramite')
go 
insert into cl_errores values ( 2101053,  1, ' Aun no se ha generado secuencia para aprobar el tramite.')
go 
insert into cl_errores values ( 2101054,  1, ' No existe una estacion en la secuencia que pueda aprobar la excepcion/instruccion.')
go 
insert into cl_errores values ( 2101055,  1, ' Una estacion solo puede tener una atribucion para aprobar/recomendar tramites')
go 
insert into cl_errores values ( 2101056,  1, ' El comite no tiene estacion asociada en etapa de aprobacion')
go 
insert into cl_errores values ( 2101057,  1, ' El comite se encuentra asociado a otra estacion')
go 
insert into cl_errores values ( 2101058,  1, ' Ya existe estacion con este login')
go 
insert into cl_errores values ( 2101059,  1, ' El tramite no cumple el numero minimo de firmas')
go 
insert into cl_errores values ( 2101060,  1, ' Usuario NO esta asignado a este Comite')
go 
insert into cl_errores values ( 2101061,  1, ' VALOR DE LA VARIABLE NO ES VALIDO')
go 
insert into cl_errores values ( 2101062,  1, ' No existe Linea de credito para actualizar Utilizacion')
go 
insert into cl_errores values ( 2101063,  1, ' Rango definido se cruza con el correspondiente a otra calificacion')
go 
insert into cl_errores values ( 2101064,  1, ' No cumple con todos los Requisitos Obligatorios del Tramite')
go 
insert into cl_errores values ( 2101065,  1, ' El Cupo no ha sido Distribuido')
go 
insert into cl_errores values ( 2101066,  1, ' El Cupo no tiene Disponible para el Desembolso de esta Linea de credito')
go 
insert into cl_errores values ( 2101067,  1, ' El Cupo no tiene Disponible para el Desembolso a este Cliente')
go 
insert into cl_errores values ( 2101068,  1, ' Cupo de Credito Anulado')
go 
insert into cl_errores values ( 2101069,  1, ' El Comite anterior NO esta Cerrado')
go 
insert into cl_errores values ( 2101070,  1, ' La Calificacion a Verificar no es de Reestructuracion')
go 
insert into cl_errores values ( 2101071,  1, ' La Obligacion no ha sido Reestructurada')
go 
insert into cl_errores values ( 2101072,  1, ' El Vencimiento de la Obligacion No esta dentro del rango de la Calificacion')
go 
insert into cl_errores values ( 2101073,  1, ' No ha Transcurrido el Tiempo Requerido para modificar la Calificacion')
go 
insert into cl_errores values ( 2101074,  1, ' La Calificacion a verificar no es de Concordato')
go 
insert into cl_errores values ( 2101075,  1, ' El Cliente no esta es situacion Concordatoria')
go 
insert into cl_errores values ( 2101076,  1, ' El acuerdo de acreedores del cliente no ha sido Homologado')
go 
insert into cl_errores values ( 2101077,  1, ' Los Datos de Concordato del cliente no son coherentes')
go 
insert into cl_errores values ( 2101078,  1, ' No cumple condiciones para calificar con menor riesgo')
go 
insert into cl_errores values ( 2101079,  1, ' La fecha ingresada debe ser la fecha de proceso')
go 
insert into cl_errores values ( 2101080,  1, ' Error, codigo de producto no definido')
go 
insert into cl_errores values ( 2101081,  1, ' Error, en Calculo Temporal de Coeficientes de Riesgo')
go 
insert into cl_errores values ( 2101082,  1, ' Error al Recuperar Datos de la Tabla Temporal')
go 
insert into cl_errores values ( 2101083,  1, ' Error al Recuperar datos de Resumen Diario')
go 
insert into cl_errores values ( 2101084,  1, ' Error, no existe valor de Parametro')
go 
insert into cl_errores values ( 2101085,  1, ' Error, no se encontro porcentaje a provisionar')
go 
insert into cl_errores values ( 2101086,  1, ' Error, el cliente no es miembro del grupo')
go 
insert into cl_errores values ( 2101087,  1, ' Error, el Registro de Peso ya Existe')
go 
insert into cl_errores values ( 2101088,  1, ' Error, El Tramite a Contabilizar no es Operacion Especifica ni Cupo de Credito')
go 
insert into cl_errores values ( 2101089,  1, ' Error, El Tramite ya ha sido Contabilizado')
go 
insert into cl_errores values ( 2101090,  1, ' Error, El Tramite No esta Aprobado')
go 
insert into cl_errores values ( 2101091,  1, ' Error, No Existe Cotizacion para la moneda')
go 
insert into cl_errores values ( 2101092,  1, ' Error, El tramite no ha sido Contabilizado')
go 
insert into cl_errores values ( 2101093,  1, ' Error, La informacion disponible no corresponde a la fecha de corte')
go 
insert into cl_errores values ( 2101094,  1, ' Error, No existen datos del Cliente o Codigos de Correspondencia')
go 
insert into cl_errores values ( 2101095,  1, ' Error, No existe un gerente valido para la oficina')
go 
insert into cl_errores values ( 2101096,  1, ' Error, Ya existe etapa de aprobacion en la ruta')
go 
insert into cl_errores values ( 2101097,  1, ' Error, La operacion ya esta asociada a otro tramite')
go 
insert into cl_errores values ( 2101098,  1, ' Error, La Suma de Garantias No Admisibles es Mayor a la Garantia No Admisible del Cupo, Debe Cambiar este Valor')
go 
insert into cl_errores values ( 2101099,  1, ' Error, La Linea de Credito no tiene datos en Cartera')
go 
insert into cl_errores values ( 2101100,  1, ' Error, No existe disponible para la Linea de Credito')
go 
insert into cl_errores values ( 2101101,  1, ' Error, En cupo irrevocable, no se permiten sobrepasamientos')
go 
insert into cl_errores values ( 2101102,  1, ' Error, El cupo disponible excede el porcentaje de sobrepasamientos')
go 
insert into cl_errores values ( 2101103,  1, ' Error, El cupo disponible excede el monto maximo de sobrepasamientos')
go 
insert into cl_errores values ( 2101104,  1, ' Error, Ya existe ruta de sobrepasamiento para este tipo de tramite')
go 
insert into cl_errores values ( 2101105,  1, ' Error, No existe sobrepasamiento, imposible cambiar ruta inicial, rechace y reingrese los datos')
go 
insert into cl_errores values ( 2101106,  1, ' Error, Existe sobrepasamiento, imposible cambiar ruta inicial, rechace y reingrese los datos')
go 
insert into cl_errores values ( 2101107,  1, ' Error, Tipo de ruta equivocada, no es sobrepasamiento')
go 
insert into cl_errores values ( 2101108,  1, ' Error, No existe ruta de sobrepasamiento para este tipo de tramite')
go 
insert into cl_errores values ( 2101109,  1, ' El Credito no esta al dia en los pagos')
go 
insert into cl_errores values ( 2101110,  1, ' No ha finalizado estado de Concordato')
go 
insert into cl_errores values ( 2101111,  1, ' Fecha final de estado homologado no ha sido ingresada')
go 
insert into cl_errores values ( 2101112,  1, ' Fecha final de estado homologado posterior a la fecha inicial del nuevo estado')
go 
insert into cl_errores values ( 2101113,  1, ' Fecha inicial del nuevo estado debe ser mayor a la del estado anterior')
go 
insert into cl_errores values ( 2101114,  1, ' Garantia no tiene disponible para cubrir este tramite')
go 
insert into cl_errores values ( 2101115,  1, ' Error, Excede el CEM del Cliente')
go 
insert into cl_errores values ( 2101116,  1, ' Rango definido se cruza con el correspondiente a otro ya definido')
go 
insert into cl_errores values ( 2101117,  1, ' Error, el cupo esta bloqueado')
go 
insert into cl_errores values ( 2101118,  1, ' Error, vencimiento de obligacion posterior al vencimiento del cupo')
go 
insert into cl_errores values ( 2101119,  1, ' Error, no se permiten sobrepasamientos en Cupos extraordinarios')
go 
insert into cl_errores values ( 2101120,  1, ' No existe distribucion para la Linea de credito ingresada')
go 
insert into cl_errores values ( 2101121,  1, ' Ya existe un Cupo de Sobregiro para el cliente')
go 
insert into cl_errores values ( 2101122,  1, ' No existe disponible para el Sobregiro')
go 
insert into cl_errores values ( 2101123,  1, ' Tramite sin cupo o Tramite no aprobado. Cupo Bloqueado')
go 
insert into cl_errores values ( 2101124,  1, ' La operacion sobrepasa el limite del plazo')
go 
insert into cl_errores values ( 2101125,  1, ' La operacion sobrepaso limite de la tasa')
go 
insert into cl_errores values ( 2101126,  1, ' El cupo no es de convenio')
go 
insert into cl_errores values ( 2101127,  1, ' Error, La linea excede el porcentaje de sobrepasamientos')
go 
insert into cl_errores values ( 2101128,  1, ' Error, La linea excede el monto maximo de sobrepasamientos')
go 
insert into cl_errores values ( 2101129,  1, ' Error, Se inicio Proceso de calificacion, no puede actualizar saldos')
go 
insert into cl_errores values ( 2101130,  1, ' No existe registro del concepto para provisionar')
go 
insert into cl_errores values ( 2101131,  1, ' No se ha cerrado el proceso de provision, no puede ingresar provisiones adicionales')
go 
insert into cl_errores values ( 2101132,  1, ' Se han contabilizado las provisiones adicionales, no puede modificar el registro')
go 
insert into cl_errores values ( 2101133,  1, ' No se ha ingresado el CEM para el cliente')
go 
insert into cl_errores values ( 2101134,  1, ' No se ha ingresado el CEM para el grupo')
go 
insert into cl_errores values ( 2101135,  1, ' Error, Revisar reporte de Validacion de saldos, no se puede continuar con el proceso')
go 
insert into cl_errores values ( 2101136,  1, ' Monto de cupo no debe exceder el CEM del cliente')
go 
insert into cl_errores values ( 2101137,  1, ' Sobrepasa maximo riesgo del grupo')
go 
insert into cl_errores values ( 2101138,  1, ' El porcentaje de provision es inferior al permitido por la ley')
go 
insert into cl_errores values ( 2101139,  1, ' Rango definido se cruza para el Cobrador')
go 
insert into cl_errores values ( 2101141,  1, ' Ya se realizo el Envio de la Carta Conminatoria')
go 
insert into cl_errores values ( 2101142,  1, ' Cliente no definido para la operacion')
go 
insert into cl_errores values ( 2101143,  1, ' No Existe Cupo de Sobregiro para el cliente')
go 
insert into cl_errores values ( 2101144,  1, ' Error, Tipo de Banca del Oficial del Cliente Diferente al Tipo de Banca del Oficial del Tramite')
go 
insert into cl_errores values ( 2101146,  1, ' Error, Jerarquia ciclica, no se puede asignar la estacion superior')
go 
insert into cl_errores values ( 2101147,  1, ' Error, Cliente no ha sido asignado a ninguna banca')
go 
insert into cl_errores values ( 2101148,  1, ' Funcionario no tiene autorizacion para modificar en Estado de cobranza')
go 
insert into cl_errores values ( 2101150,  1, ' No se puede Asignar Cobranzas en Estado Normalizado')
go 
insert into cl_errores values ( 2101151,  1, ' El Tipo de Carta no corresponde al Estado de Cobranza y/o dias vto.')
go 
insert into cl_errores values ( 2101152,  1, ' No existe el cliente')
go 
insert into cl_errores values ( 2101153,  1, ' No existe el gerente')
go 
insert into cl_errores values ( 2101154,  1, ' Operacion no tiene gerente')
go 
insert into cl_errores values ( 2101155,  1, ' Operacion tiene un cliente distinto')
go 
insert into cl_errores values ( 2101156,  1, ' Operacion tiene un secuencial distinto')
go 
insert into cl_errores values ( 2101157,  1, ' No existe la oficina')
go 
insert into cl_errores values ( 2101158,  1, ' Operacion tiene clase distinta')
go 
insert into cl_errores values ( 2101159,  1, ' No existe clase de cartera')
go 
insert into cl_errores values ( 2101160,  1, ' Estado contable no permitido')
go 
insert into cl_errores values ( 2101162,  1, ' Operacion estaba marcada como reestructurada')
go 
insert into cl_errores values ( 2101163,  1, ' Operacion calificada no esta reportada en el consolidador')
go 
insert into cl_errores values ( 2101164,  1, ' No se ha cerrado el proceso de calificacion, no puede continuar')
go 
insert into cl_errores values ( 2101165,  1, ' Cliente no esta castigado y operacion esta castigada')
go 
insert into cl_errores values ( 2101166,  1, ' Cliente esta castigado y operacion no tiene fecha de castigo')
go 
insert into cl_errores values ( 2101168,  1, ' Operacion esta castigada y no tiene fecha de castigo')
go 
insert into cl_errores values ( 2101169,  1, ' Trámite tipo FINAGRO y garantía no es de tipo FAG')
go 
insert into cl_errores values ( 2101170,  1, ' Tr mite tipo No FINAGRO y garant¡a es de tipo FAG')
go 
insert into cl_errores values ( 2103001,  1, ' Error en insercion de registro')
go 
insert into cl_errores values ( 2103002,  1, ' Error en insercion debe ser duplicado')
go 
insert into cl_errores values ( 2103003,  1, ' Error en insercion de transaccion de servicio')
go 
insert into cl_errores values ( 2103004,  1, ' Error en insercion de registro en tabla cr_secuencia')
go 
insert into cl_errores values ( 2103005,  1, ' No se puede ingresar el reporte de visitas en una fecha anterior a la indicada como fecha de visita')
go 
insert into cl_errores values ( 2103006,  1, ' No se puede ingresar el reporte de visitas fuera del rango establecido')
go 
insert into cl_errores values ( 2103007,  1, ' Error al registrar valores iniciales de variables')
go 
insert into cl_errores values ( 2103008,  1, ' Error en Insercion de Utilizacion de Cupo por Producto')
go 
insert into cl_errores values ( 2103009,  1, ' Error al Copiar las instrucciones del Cupo al Tramite')
go 
insert into cl_errores values ( 2103010,  1, ' Error al Copiar los codeudores del Cupo al Tramite')
go 
insert into cl_errores values ( 2103011,  1, ' Error al Copiar Datos del Cupo Original')
go 
insert into cl_errores values ( 2103012,  1, ' Error, ya se Inserto Cotizacion para esa Moneda y Fecha')
go 
insert into cl_errores values ( 2103013,  1, ' Error al Ingresar Registro en Tabla Temporal de Operaciones')
go 
insert into cl_errores values ( 2103014,  1, ' Error al Ingresar Operaciones Canceladas en la tabla Temporal')
go 
insert into cl_errores values ( 2103015,  1, ' Error al Ingresar Registro en Tabla de Operaciones Castigadas')
go 
insert into cl_errores values ( 2103016,  1, ' Error al Ingresar Codeudores de Operaciones Castigadas')
go 
insert into cl_errores values ( 2103017,  1, ' Error al Ingresar Provision de Operaciones Castigadas')
go 
insert into cl_errores values ( 2103018,  1, ' Error al Ingresar Resumen Diario de Operaciones')
go 
insert into cl_errores values ( 2103019,  1, ' Error al Ingresar/Actualizar Calificacion de un Cliente')
go 
insert into cl_errores values ( 2103020,  1, ' Error al Ingresar/Actualizar Calificacion de una Operacion')
go 
insert into cl_errores values ( 2103021,  1, ' Error, Insertando Asociacion entre Garantias y Operaciones')
go 
insert into cl_errores values ( 2103022,  1, ' Error, al Insertar Registros de Garantias a Distribuir')
go 
insert into cl_errores values ( 2103023,  1, ' Error, al Insertar peso de Rubro Capital')
go 
insert into cl_errores values ( 2103024,  1, ' Error, al Insertar Peso del Rubro Interes')
go 
insert into cl_errores values ( 2103025,  1, ' Error, al Insertar Peso del Rubro Cuentas por Cobrar')
go 
insert into cl_errores values ( 2103026,  1, ' Error al Insertar Coeficientes de Riesgo')
go 
insert into cl_errores values ( 2103027,  1, ' Error al Generar Distribucion de Garantias por Clase de Cartera')
go 
insert into cl_errores values ( 2103028,  1, ' Error Insertar Datos de Distribucion para Operaciones de Cartera')
go 
insert into cl_errores values ( 2103029,  1, ' Error al Ingresar Registro de Provision')
go 
insert into cl_errores values ( 2103030,  1, ' Error al Crear Cabecera de Transaccion de Cartera')
go 
insert into cl_errores values ( 2103031,  1, ' Error al Crear el Registro de Referencia para la Contabilizacion')
go 
insert into cl_errores values ( 2103032,  1, ' Error Insertando Destalle de Transaccion')
go 
insert into cl_errores values ( 2103033,  1, ' Error Insertando Registro en Tabla Temporal de Operaciones Castigadas')
go 
insert into cl_errores values ( 2103034,  1, ' Error pasando datos de Operaciones Castigadas a Tabla para Archivo Plano')
go 
insert into cl_errores values ( 2103035,  1, ' Error pasando datos de Operaciones Activas a Tabla para Archivo Plano')
go 
insert into cl_errores values ( 2103036,  1, ' Error, Insertando Datos en Tabla Temporal de Clientes')
go 
insert into cl_errores values ( 2103037,  1, ' Error, Insertando Datos en Tabla Temporal de Operaciones')
go 
insert into cl_errores values ( 2103038,  1, ' Error, Insertando Datos en Tabla Previa de Resultados')
go 
insert into cl_errores values ( 2103039,  1, ' Error, Insertando Datos en Tabla de Resultados')
go 
insert into cl_errores values ( 2103040,  1, ' Error, Insertando Datos en Tabla Temporal de Garantias')
go 
insert into cl_errores values ( 2103041,  1, ' Error, Insertando Datos del Deudor para Informe por Departamento')
go 
insert into cl_errores values ( 2103042,  1, ' Error, Insertando Datos de la tabla de informe por Departamento')
go 
insert into cl_errores values ( 2103043,  1, ' Error, Insertando Datos en Tabla Auxiliar')
go 
insert into cl_errores values ( 2103044,  1, ' Error, Insertando en Tabla Temporal de Informe Individual')
go 
insert into cl_errores values ( 2103045,  1, ' Error, Insertando en Tabla Definitiva de Informe Individual')
go 
insert into cl_errores values ( 2103046,  1, ' Error, Insertando en Tabla Temporal de Informe Consolidado')
go 
insert into cl_errores values ( 2103047,  1, ' Error, Insertando en Tabla Definitiva de Informe Consolidado')
go 
insert into cl_errores values ( 2103048,  1, ' Error, Monto de Cupo no puede sobrepasar CEM definido para el cliente')
go 
insert into cl_errores values ( 2103049,  1, ' Error, Insertando Datos en Tabla Temporal de Conceptos')
go 
insert into cl_errores values ( 2103050,  1, ' Error, Insertando Datos en Tabla de Respaldos')
go 
insert into cl_errores values ( 2103051,  1, ' No se Puede Adjuntar Garantias en Estado Vigente por Cancelar')
go 
insert into cl_errores values ( 2103052,  1, ' No se puede adjuntar garantia, Cliente no es propietario o amparado')
go 
insert into cl_errores values ( 2103053,  1, ' Error al insertar tabla de cotizaciones')
go 
insert into cl_errores values ( 2103054,  1, ' Error al insertar operaciones en tabla de errores')
go 
insert into cl_errores values ( 2103057,  0, ' Error en Actualizacion de Registro')
go
insert into cl_errores values ( 2103058,  1, ' Debe Ingresar los Montos')
go  
insert into cl_errores values ( 2105001,  1, ' Error en actualizacion de registro')
go 
insert into cl_errores values ( 2105002,  1, ' Error registro a actualizar no existe')
go 
insert into cl_errores values ( 2105003,  1, ' El paso a actualizar es centralizador y tiene otros pasos asociados')
go 
insert into cl_errores values ( 2105004,  1, ' Error no es posible actualizar registro (por confirmar)')
go 
insert into cl_errores values ( 2105005,  1, ' No fue posible actualizar el registro en Cartera')
go 
insert into cl_errores values ( 2105006,  1, ' No fue posible actualizar el registro con el Numero Secuencial de Cupo de Credito')
go 
insert into cl_errores values ( 2105008,  1, ' No se puede modificar el campo tipo porque la etapa se encuentra asociada a una ruta')
go 
insert into cl_errores values ( 2105009,  1, ' No se puede modificar un Costo ya Confirmado')
go 
insert into cl_errores values ( 2105010,  1, ' No se puede modificar Condiciones de una Operacion Instrumentada')
go 
insert into cl_errores values ( 2105011,  1, ' Error en actualizacion de Valores de Salida de Variables')
go 
insert into cl_errores values ( 2105012,  1, ' Error en actualizacion de Utilizacion de Cupo')
go 
insert into cl_errores values ( 2105013,  1, ' No existe registro de Microempresa')
go 
insert into cl_errores values ( 2105014,  1, ' Cliente no tiene Creditos en Estado Vigente o Cancelado')
go 
insert into cl_errores values ( 2108012,  1, ' Es obligatorio establecer la Causal del Rechazo')
go
insert into cl_errores values ( 2108013,  1, 'No se pudo insertar datos agilidad de tramite')
go
insert into cl_errores values ( 2108014,  1, 'Error en insercion de lineas de credito en historial')
go
insert into cl_errores values ( 2108015,  1, 'Error en insercion de operaciones en historial')
go
insert into cl_errores values ( 2108016,  1, 'Error en actualizacion de operaciones en historial')
go
insert into cl_errores values ( 2108017,  1, 'Error en actualizacion de operaciones en historial')
go
insert into cl_errores values ( 2108018,  1, 'Error en insercion reporte creditos vigentes')
go
insert into cl_errores values ( 2108019,  1, 'Error en insercion reporte creditos rechazados')
go
insert into cl_errores values ( 2108020,  1, 'Error en insercion reporte procedencia de créditos')
go
insert into cl_errores values ( 2108021,  1, 'Error en actualización de Microseguro')
go
insert into cl_errores values ( 2108022,  1, 'Error en actualización del estado del pago en Trámites/Cajas')
go
insert into cl_errores values ( 2108023,  1, 'Error en actualización de Seguro Exequial')
go
insert into cl_errores values ( 2108024,  0, 'El Saldo de la Fuente de Recursos seleccionada es MENOR que el monto del trámite. Seleccionar otra Fuente')
go
insert into cl_errores values ( 2108025,  0, 'Cliente debe realizar el pago.')
go
insert into cl_errores values ( 2108026,  0, 'Error en la interfaz ADMINFO.')
go
insert into cl_errores values ( 2108027,  0, 'Valores negativos no válidos.')
go
--Parámetros Variables Grupo Solidario
insert into cl_errores values ( 2109001,  1, 'NO EXISTE PARAMETRO DIAS ATRASO GRUPAL CICLO ANTERIOR')
go
insert into cl_errores values ( 2109002, 1, 'NO EXISTE PARAMETRO DIAS ATRASO GRUPAL CICLOS ANTERIORES')
go
insert into cl_errores values ( 2109003, 1, 'NO SE HA DEFINIDO EL CLIENTE PARA LA VARIABLE NUMERO DE CICLO INDIVIDUAL')
go
insert into cobis..cl_errores values (2109110, 0, 'Error al iniciar el flujo, el solicitante no tiene creditos anteriores')
go
insert into cobis..cl_errores values (2109111, 0, 'Error al iniciar el flujo, el solicitante ya cuenta con una Línea de Crédito Revolvente abierta.')
go
--Parametros Variable Experiencia Crediticia
insert into cobis..cl_errores (numero, severidad, mensaje)values (2109004, 0, 'NO EXISTE PARAMETRO DIAS CUENTAS ABIERTAS')
go
insert into cobis..cl_errores (numero, severidad, mensaje)values (2109005, 0, 'NO EXISTE PARAMETRO DIAS CUENTAS CERRADAS') 
go
insert into cobis..cl_errores (numero, severidad, mensaje)values (2109006, 0, 'Error el Porcentaje de Incremento Grupal es Menor o Igual que -100%')
go

--Inicio Errores que provienen de MobileIntegration/Backend/sql/si_errores.sql
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109100, 1, 'ERROR AL INSERTAR MOVIL DEL OFICIAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109101, 1, 'NO EXISTE MOVIL DEL OFICIAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109102, 1, 'ERROR AL ACTUALIZAR MOVIL DEL OFICIAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109103, 1, 'ERROR AL ELIMINAR MOVIL DEL OFICIAL')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109104, 1, 'ERROR AL DESCARGAR LA ENTIDAD, EL FORMATO XML NO ES COMPATIBLE CON LA ESTRUCTURA DE LA ENTIDAD SOLICITADA')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109105, 1, 'EL OFICIAL YA CUENTA CON UN DISPOSITIVO ACTIVO')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109107, 1, 'No existe el registro que desea actualizar')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2109108, 1, 'Error al actualizar el registro de sincronización')
insert into cobis.dbo.cl_errores (numero, severidad, mensaje)
values (2109109, 1, 'Ocurrió un error en la sincronizacion de un oficial');
insert into cobis.dbo.cl_errores (numero, severidad, mensaje)
values (2109112, 1, 'Existe una sincronización en proceso para el Oficial seleccionado.');
insert into cobis.dbo.cl_errores (numero, severidad, mensaje)
values (2109113, 1, 'La última sincronización de este dispositivo fue hecha el {ult_sync}. El plazo mínimo de días entre sincronización es {min_days}.');
insert into cobis..cl_errores (numero, severidad, mensaje)
values (2109114, 1, 'El estado no permite sincronizar');
insert into cl_errores (numero, severidad, mensaje)
values (2109115, 1, 'El Oficial ya tiene asignado este móvil')
insert into cl_errores (numero, severidad, mensaje)
values (2109116, 1, 'Un Oficial ya tiene asignado este móvil')

go

--Fin Errores que provienen de MobileIntegration/Backend/sql/si_errores.sql
insert into cobis..cl_errores (numero, severidad, mensaje) values (2100001,  0, 'ERROR EN PROCESO BATCH.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108028,  0, 'FECHA NO ES UN DIA HABIL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108029,  0, 'ESTADO DE CARTERA NO PARAMETRIZADO.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108030,  0, 'ERROR AL INGRESAR EN TABLA TEMPORAL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108031,  0, 'ERROR AL ACTUALIZAR EN TABLA TEMPORAL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108032,  0, 'ERROR AL ELIMINAR EN TABLA TEMPORAL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108033,  0, 'NO EXISTEN DATOS DE PORCENTAJE DE PROVISIONES.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108034,  0, 'NO EXISTE TRAMITE.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108035,  0, 'NO EXISTE TRAMITE GRUPAL.')
insert into cobis..cl_errores (numero, severidad, mensaje) values (2108036,  0, 'NO EXISTE TABLA DE AMORTIZACION PARA ESTE TRAMITE.')

insert into cl_errores values(2101140, 0, 'ERROR AL INSERTAR/ACTUALIZAR DATOS EN LA TABLA CR_ESTADO_CTA_ENVIADO')
insert into cl_errores values(2101149, 0, 'ERROR AL ENVIAR LA NOTIFICACION DEL REPORTE ESTADO DE CUENTA')

go

insert into cobis..cl_errores VALUES(208924,0, 'Error de Conexión con Buró')
go
--Parámetros para validacion de reglas grupales e individuales
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208927, 0, 'Existen préstamos  que superan el incremento permitido')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208928, 0, 'Existen préstamos con monto superior al monto Máximo')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208929, 0, 'Existen préstamos con monto inferior al monto Mínimo')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208930, 0, 'Monto del préstamo es superior al monto Máximo')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (208931, 0, 'Monto del préstamo es inferior al monto Mínimo')
GO
--Parametros para errores al  generar  de reportes
insert into cobis..cl_errores (numero, severidad, mensaje)values (2108046, 0, 'Error generando Reporte de Provisiones')
insert into cobis..cl_errores (numero, severidad, mensaje)values (2108048, 0, 'Error generando Archivo de Cabeceras')
insert into cobis..cl_errores (numero, severidad, mensaje)values (2108049, 0, 'Error generando Archivo de Lineas mas cabeceras')

insert into cobis..cl_errores (numero, severidad, mensaje) values (2108051, 0, 'LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR')
go

delete from cobis..cl_errores where numero in (2108051, 21008)

insert into cobis..cl_errores(numero, severidad, mensaje) values(2108051,0,'LOS INTEGRANTES DEL COMITE DEBEN PARTICIPAR')
insert into cobis..cl_errores(numero, severidad, mensaje) values(21008,0,'ERROR AL EJECUTAR LAS VALIDACIONES DE GRUPO')


delete cobis..cl_errores where numero in (2108055, 2108056, 2108057,2108058,2108059,2108060,2108061,2108062,2108063,2108064, 2108065,2108067,2108068,2108069)

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108055,0,'ERROR: EL GRUPO NO SE ENCUENTRA EN LA ETAPA DE ESPERA AUTOMÁTICA DE GARANTÍA LÍQUIDA.')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108056,0,'ERROR: NO EXISTE REGISTRO EN EL BURO PARA EL CLIENTE.')
--COLECTIVOS
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108057,0,'ERROR: NO EXISTE REGISTRO EN LA TABLA cr_cuenta_buc_santander_job PARA EL TRAMITE')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108058,0,'ERROR: NO EXISTE REGISTRO EN LA TABLA cr_buro_ln_nf_job PARA EL TRAMITE')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108059,0,'ERROR AL INSERTAR EL REGISTRO EN LA TABLA cr_buro_ln_nf_job')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108060,0,'ERROR: NO EXISTE ENTE/TRAMITE ASOCIADO A LA INSTANCIA DE PROCESO')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108061,0,'ERROR: ERROR AL INSERTAR EL REGISTRO EN LA TABLA cr_cuenta_buc_santander_job')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108062,0,'ERROR: ERROR AL INSERTAR EL REGISTRO EN LA TABLA cr_interface_buro')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108063,0,'ERROR: NO EXISTE EL PARÁMETRO ETACFC')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108064,0,'ERROR: NO SE HA ASIGNADO ASESOR EXTERNO AL CLIENTE')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108065,0,'ERROR: NO EXISTE EL PARÁMETRO ETAFCC: FIRMAS Y CUESTIONARIO')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108067,0,'ERROR: NO EXISTE LA COLONIA INGRESADA')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108068,0,'ERROR: LA COLONIA INGRESADA NO COINCIDE CON EL CODIGO POSTAL')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108069,0,'ERROR: NO EXISTE TRAMITE ASOCIADO A LA INSTANCIA DE PROCESO')
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (2108070,0,'ERROR: NO EXISTE CLIENTE ASOCIADO A LA INSTANCIA DE PROCESO')

--ERRORES FLUJO DE RENOVACIÓN
delete cl_errores where numero in (2108080, 2108081, 2108082, 2108083, 2108084, 2108085, 2108086)
insert into cl_errores(numero, severidad, mensaje) 
values (2108080,0,'ERROR: EL GRUPO NO TIENE UNA OPERACION VIGENTE')
insert into cl_errores(numero, severidad, mensaje) 
values (2108081,0,'ERROR: NO HA TRANSCURRIDO EL TIEMPO REQUERIDO PARA LA OPERACION A RENOVAR')
insert into cl_errores(numero, severidad, mensaje) 
values (2108082,0,'ERROR: NO HA CUBIERTO EL CAPITAL REQUERIDO PARA LA OPERACION A RENOVAR')
insert into cl_errores(numero, severidad, mensaje) 
values (2108083,0,'ERROR: EL GRUPO TIENE DIAS DE ATRASO EN LA CUOTA ACTUAL')
insert into cl_errores(numero, severidad, mensaje) 
values (2108084,0,'ERROR: EL GRUPO TIENE MAS DIAS DE ATRASO DE LOS PERMITIDOS')
insert into cl_errores(numero, severidad, mensaje) 
values (2108085,0,'ERROR: EL GRUPO NO SE ENCUENTRA EN EL CICLO PERMITIDO')
insert into cl_errores(numero, severidad, mensaje) 
values (2108086,0,'ERROR: LA OPERACION TIENE UNA SOLICITUD DE CRÉDITO EN EJECUCIÓN')

delete cl_errores where numero in (2108087)
--ERRORES SINCRONIZACION
insert into cl_errores(numero, severidad, mensaje) 
values (2108087,0,'ERROR: YA EXISTE UNA SINCRONIZACION CON ESTE SECUENCIAL')

insert into cl_errores(numero, severidad, mensaje) 
values (2108088,0,'ERROR: El cliente no puede ser Aval')
go

--ERRORES LCR V2.0
delete cl_errores where numero in (2108089)
insert into cl_errores(numero, severidad, mensaje) 
values (2108089,0,'ERROR: LA SOLICITUD TIENE OTRO OFICIAL DIFERENTE AL DEL CLIENTE')

-----------***********-----------***********-----------***********
-- Caso#200142 AplicaciOn Cuestionario
-----------***********-----------***********-----------***********
delete from cobis..cl_errores where numero in (2101172)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (2101172, 1, 'No Existen etapa APLICAR CUESTIONARIO parametrizada')

-----------***********-----------***********-----------***********
go
