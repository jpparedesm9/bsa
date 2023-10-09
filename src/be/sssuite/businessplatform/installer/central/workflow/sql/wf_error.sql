set nocount on
go

-- Codigos de Error de Cobis WorkFlow.
use cobis
go

-- Elimino registros de error.
print 'Elimino registros de error.'
delete cl_errores
 where numero >= 3107500
   and numero <= 3205000
go

-- Creo los registros de error.
print 'Creo los registros de error.'
insert into cl_errores values (3107500, 1, 'NO ESTA AUTORIZADO PARA EJECUTAR ESTE PROCEDIMIENTO.')
go
insert into cl_errores values (3107501, 1, 'REGISTRO NO EXISTE.')
go
insert into cl_errores values (3107502, 1, 'REGISTRO YA EXISTE EN LA BASE DE DATOS.')
go
insert into cl_errores values (3107503, 1, 'NO EXISTE TABLA EN LA TABLA DE SECUENCIALES.')
go
insert into cl_errores values (3107504, 1, 'ERROR EN LA INSERCION DEL REGISTRO.')
go
insert into cl_errores values (3107505, 1, 'ERROR EN LA ELIMINACION DEL REGISTRO.')
go
insert into cl_errores values (3107506, 1, 'ERROR EN LA ACTUALIZACION DEL REGISTRO.')
go
insert into cl_errores values (3107507, 1, 'ENTIDAD ASOCIADA A UN PROCESO, NO SE PUEDE ELIMINAR.')
go
insert into cl_errores values (3107508, 1, 'ROL NO PUEDE SER ELIMINADO, ES UN ROL SUPERVISOR.')
go
insert into cl_errores values (3107509, 1, 'USUARIO NO PUEDE SER ELIMINADO, ES UN USUARIO SUSTITUTO')
go
insert into cl_errores values (3107511, 1, 'ERROR EN LA ELIMINACION DEL PROCESO.')
go
insert into cl_errores values (3107512, 1, 'REQUERIMIENTO ASOCIADO A INSTANCIA DE PROCESO, DESASOCIELO.')
go
insert into cl_errores values (3107513, 1, 'ERROR EN LA ELIMINACION DEL REQUERIMIENTO.')
go
insert into cl_errores values (3107514, 1, 'ERROR EN LA ELIMINACION DEL ACTIVIDAD.')
go
insert into cl_errores values (3107515, 1, 'ERROR EN LA ELIMINACION DE LA VERSION DEL PROCESO.')
go
insert into cl_errores values (3107516, 1, 'ERROR EN LA ACTUALIZACION DE LA VERSION DEL PROCESO.')
go
insert into cl_errores values (3107517, 1, 'NO ES POSIBLE ASIGNAR EL RESULTADO DEBIDO A QUE LA ACTIVIDAD ESTA SUSPENDIDA.')
go
insert into cl_errores values (3107518, 1, 'NO ES POSIBLE ASIGNAR EL RESULTADO DEBIDO A QUE EL PROCESO ESTA SUSPENDIDO, CANCELADO O TERMINADO.')
go
insert into cl_errores values (3107519, 1, 'ERROR EN EJECUCION DE OPERACION.')
go
insert into cl_errores values (3107520, 1, 'NO ES POSIBLE ASIGNAR, YA QUE FUE ASOCIADO PREVIAMENTE CON LA MISMA INFORMACION.')
go
insert into cl_errores values (3107521, 1, 'PROCESO TERMINADO.')
go
insert into cl_errores values (3107522, 1, 'NO EXISTE ENLACE ASOCIADO A LA ACTIVIDAD.')
go
insert into cl_errores values (3107523, 1, 'NO EXISTE ACTIVIDAD ASOCIADA.')
go
insert into cl_errores values (3107524, 1, 'USUARIO NO ESTA LOGEADO AL SISTEMA.')
go
insert into cl_errores values (3107525, 1, 'FALTA PARAMETRO PARA INICIALIZAR EL PROCESO CORRECTAMENTE.')
go
insert into cl_errores values (3107526, 1, 'NO SE PUDO ASIGNAR LA ACTIVIDAD A NINGUN ROL.')
go
insert into cl_errores values (3107527, 1, 'EL NOMBRE DEL PROCESO ES UNICO POR EMPRESA.')
go
insert into cl_errores values (3107528, 1, 'EL NOMBRE DE EXCEPCION ES UNICO.')
go
insert into cl_errores values (3107529, 1, 'EL NOMBRE DE INSTRUCCION ES UNICO.')
go
insert into cl_errores values (3107530, 1, 'EL NOMBRE DE RESULTADO ES UNICO.')
go
insert into cl_errores values (3107531, 1, 'EL NOMBRE DE VARIABLE ES UNICO.')
go
insert into cl_errores values (3107532, 1, 'EN ESTE PROCESO NO APLICA LA ASIGNACION MANUAL PUES TIENE MAS DE UN ENLACE QUE PARTE DE SU INICIO.')
go
insert into cl_errores values (3107533, 1, 'NO ES POSIBLE ELIMINAR ENLACE PORQUE TIENE UNA CONDICION ASOCIADA')
go
insert into cl_errores values (3107534, 1, 'USTED NO TIENE ATRIBUCIONES PARA REALIZAR LA OPERACION SOLICITADA')
go
insert into cl_errores values (3107535, 1, 'AUN NO CUMPLE CON ALGUN REQUISITO MANDATORIO')
go
insert into cl_errores values (3107536, 1, 'NO ES POSIBLE INICIAR PROCESO DEBIDO A QUE ESTA MARCADO PARA CAMBIO DE VERSION, POR FAVOR ESPERE UN MOMENTO')
go
insert into cl_errores values (3107537, 1, 'NO ES POSIBLE AVANZAR DEBIDO A QUE ESTA MARCADO PARA CAMBIO DE VERSION, POR FAVOR ESPERE UN MOMENTO')
go
insert into cl_errores values (3107538, 1, 'PROCESO MAL PARAMETRIZADO, FAVOR COMUNICARSE CON ADMINISTRADOR PARA QUE REVISE DEFINICION DEL MISMO')
go
insert into cl_errores values (3107539, 1, 'PROBLEMA EN ACTUALIZACION DE REGISTRO SECUENCIAL.')
go
insert into cl_errores values (3107540, 1, 'PROBLEMA EN ACTUALIZACION DE REGISTRO SECUENCIAL.  SECUENCIAL LLEGO AL LIMITE')
go
insert into cl_errores values (3107541, 1, 'NO CUMPLE NINGUNA CONDICION PARA SALIR DE LA ACTIVIDAD')
go
insert into cl_errores values (3107542, 1, 'NO SE PUDO OBTERNER EL DETALLE DEL TRAMITE')
go
insert into cl_errores values (3107543, 1, 'NO ES POSIBLE RUTEAR, LA ACTIVIDAD YA FUE TERMINADA')
go
insert into cl_errores values (3107544, 1, 'EL NOMBRE DE LA ACTIVIDAD ES UNICO.')
go
insert into cl_errores values (3107545, 1, 'EL NOMBRE DE LA ATRIBUCION ES UNICO.')
go
insert into cl_errores values (3107546, 1, 'EL NOMBRE DEL ATRIBUTO ES UNICO.')
go
insert into cl_errores values (3107547, 1, 'EL NOMBRE DE COLA ES UNICO.')
go
insert into cl_errores values (3107548, 1, 'EL NOMBRE DE DISTRIBUCION DE CARGA ES UNICO.')
go
insert into cl_errores values (3107549, 1, 'EL NOMBRE DE PROGRAMA ES UNICO.')
go
insert into cl_errores values (3107550, 1, 'EL NOMBRE DE ROL ES UNICO.')
go
insert into cl_errores values (3107551, 1, 'EL NOMBRE DE TIPO DOCUMENTO ES UNICO.')
go
insert into cl_errores values (3107552, 1, 'EL NOMBRE DE OBSERVACION ES UNICO.')
go
insert into cl_errores values (3107553,	1,	'EL USUARIO NO PUEDE INICIAR ESTE PROCESO')
go
insert into cl_errores values (3107554,	1,	'ERROR AL ACTUALIZAR EL VALOR DE LA VARIABLE')
go
insert into cl_errores values (3107555,	1,	'NO EXISTE MANEJADOR DE PROCESOS PARA CONFIGURAR')
go
insert into cl_errores values (3107556,	1,	'EXISTE MAS DE 1 MANEJADOR DE PROCESOS')
go
insert into cl_errores values (3107557,	1,	'EL PRODUCTO NO TIENE UN PROCESO ASOCIADO O LA CONFIGURACION ESTA INCOMPLETA')
go
insert into cl_errores values (3107558,	1,	'ERROR AL COMPLETAR LA ACTIVIDAD')
go
insert into cl_errores values (3107559,	1,	'ERROR EN LA ELIMINACION DEL REGISTRO, EL REGISTRO YA TIENE UN ENLACE ASOCIADO')
go
insert into cl_errores values (3107560,	1,	'EL OFICIAL SELECCIONADO, NO ES UN USUARIO WORKFLOW')
go
insert into cl_errores values (3107561,	1,	'EL PROCESO NO PUEDE EJECUTARSE PORQUE NO SE ENCUENTRA EN PRODUCCIÓN')
go
insert into cl_errores values (3107562,	1,	'ERROR AL EVALUAR LA JERARQUIA, NO EXISTE ROL A ASIGNAR')
go
insert into cl_errores values (3107563,	1,	'EL NOMBRE DE LA JERARQUIA YA EXISTE PARA ESTE PROCESO')
go
insert into cl_errores values (3107564,	1,	'EL PROCESO NO PUEDE EJECUTARSE PORQUE NO SE ENCUENTRA ACTIVO')
go
insert into cl_errores values (3107575,	1,	'EL USUARIO NO PUEDE INICIAR ESTE PROCESO, PORQUE NO ES UN USUARIO DE WORKFLOW')
go
insert into cl_errores values (3107576,	1,	'EL USUARIO NO PUEDE REALIZAR ESTE PROCESO, PORQUE OTRO USUARIO LO ESTA EJECUTANDO')
go
insert into cl_errores values (3107577,	1,	'EL USUARIO NO PUEDE REALIZAR ESTA REGLA, PORQUE EL ROL NO LO PERMITE')
go
insert into cl_errores values (3107578,	1,	'NO EXISTEN DATOS DE DESVIACION DE INDICADORES')
go
insert into cl_errores values (3107579,	1,	'NO ESTA DEFINIDA LA PLANTILLA DESINDWF EN LA TABLA COBIS..ADM_PLANTILLA')
go
insert into cl_errores values (3107580,	1,	'ERROR EN LA INSERCION EN LA TABLA TEMPORAL COBIS..ADM_NOTIFICACION')
go
insert into cl_errores values (3107581,	1,	'ERROR EN LA INSERCION EN LA TABLA COB_BVIRTUAL..BV_NOTIFICACIONES_DESPACHO')
go
insert into cl_errores values (3107582,	1,	'ERROR EN LA EVALUACION DE POLITICAS EN LA ACTIVIDAD')
go
insert into cl_errores values (3107583,	1,	'LOS VALORES DE LAS VARIABLES NO CUMPLEN CON LAS EXPRESIONES DE VALIDACION')
go
insert into cl_errores values (3107584,	1,	'NEMONICO CORRESPONDE A OTRO PROCESO')
go
insert into cl_errores values (3107585,	1,	'SE DEBE REALIZAR LA VALIDACION DE POLITICAS ANTES DE REALIZAR ESTA ACCION')
go
insert into cl_errores values (3107586,	1,	'NO EXISTE UN PROGRAMA EN LA BASE DE DATOS')
go
insert into cl_errores values (3107587,	1,	'NO ES POSIBLE EJECUTAR ESTA TAREA, PORQUE SE ENCUENTRA REASIGNADA A OTRO USUARIO')
go
insert into cl_errores values (3107588,	1,	'EXISTEN POR APROBAR INSTRUCCIONES/EXCEPCIONES EN EL PROCESO')
go
insert into cl_errores values (3107589,	1,	'NO EXISTE UN NIVEL DE JERARQUIA PARA PODER ASIGNAR')
go
insert into cl_errores values (3107590,	1,	'NO CUMPLE LA CONDICION DE LA JERARQUIA DE USUARIOS')
go
insert into cl_errores values (3107591,	1,	'NO TIENE AL MENOS UNA CONDICION EN LA JERARQUIA DE ITEMS')
go
insert into cl_errores values (3107592,	1,	'EL USUARIO NO PUEDE INICIAR ESTE PROCESO POR QUE SE ENCUENTRA INACTIVO')
go
insert into cl_errores values (3107593,	1,	'NO EXISTE UN DESTINATARIO PARA ASIGNAR ESTA TAREA')
go
insert into cl_errores values (3107594,	1,	'NO SE PARAMETRIZO EL TIEMPO EFECTIVO EN ESTA TAREA')
go
insert into cl_errores values (3107595,	1,	'NO ES POSIBLE EJECUTAR ESTA TAREA, PORQUE EL USUARIO SE ENCUENTRA INACTIVO O EL USUARIO NO TIENE SUSTITUTO')
go
insert into cl_errores values (3107596,	1,	'NO ES POSIBLE EJECUTAR ESTA TAREA, PORQUE NO EXISTE EL USUARIO PARA EL DISTRIBUIDOR DE CARGA CONFIGURADO EN LA ACTIVIDAD')
go
insert into cl_errores values (3107597,	1,	'NO ES POSIBLE EJECUTAR ESTA TAREA, PORQUE EL USUARIO NO PERTENECE A NINGUN NODO DEL ARBOL DE JERARQUIA DE USUARIOS')
go
insert into cl_errores values (3107598,	1,	'NO ES POSIBLE EJECUTAR ESTA TAREA, PORQUE EL USUARIO DE LA JERARQUIA DE USUARIOS NO PUEDE SER SU PROPIO SUPERVISOR')
go
insert into cl_errores values (3107599,	1,	'NO ES POSIBLE MODIFICAR LA OPCIÓN EXCEPCIONABLE PUESTO QUE TIENE INFORMACIÓN ASOCIADA EN LAS APROBACIONES')
go
insert into cl_errores values (3107600,	1,	'NO ES POSIBLE ELIMINAR EL REQUISITO PUESTO QUE TIENE INFORMACIÓN ASOCIADA EN LA APROBACIÓN DE EXCEPCIONES')
go
insert into cl_errores values (3107601,	1,	'NO ES POSIBLE ELIMINAR LA JERARQUÍA PUESTO QUE TIENE INFORMACIÓN ASOCIADA EN UN FLUJO')
go
insert into cl_errores values (3107602,	1,	'NO ES POSIBLE ELIMINAR EL REQUISITO PUESTO QUE TIENE USUARIOS ASOCIADOS')
go
insert into cl_errores values (3107603,	1,	'NO ES POSIBLE ELIMINAR EL PROGRAMA PORQUE TIENE DEPENDENCIAS EN VARIABLES')
go
insert into cl_errores values (3107604,	1,	'NO ES POSIBLE ELIMINAR EL PROGRAMA PORQUE TIENE DEPENDENCIAS EN DESTINATARIOS')
go


delete from cobis..cl_errores where numero = 7300000
delete from cobis..cl_errores where numero = 7300001
delete from cobis..cl_errores where numero = 7300002
delete from cobis..cl_errores where numero = 3107565
go

insert into cobis..cl_errores (numero, severidad, mensaje) values(7300000,0,'No existe Parametrizacion Base - Catalogo: bpl_type_dependence')
insert into cobis..cl_errores (numero, severidad, mensaje) values(7300001,0,'Error en la creación de dependencias de reglas')
insert into cobis..cl_errores (numero, severidad, mensaje) values(7300002,0,'Error en el borrado de dependencias de reglas')
insert into cobis..cl_errores (numero, severidad, mensaje) values(3107565,0,'Existe una variable que no esta siendo guardada al evaluar las reglas')



go
