/************************************************************************/
/*      Archivo:                ad_err.sql                              */
/*      Base de datos:  cobis                                           */
/*      Producto:               Admin                                   */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este script crea los numeros de error del ADMIN                 */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      14-04-2016      BBO             Migracion SYB-SQL FAL           */
/************************************************************************/


use cobis
go
if exists (select * from cl_errores
           where numero between 150000 and 199999)
delete cl_errores where numero between 150000 and 199999
go

--Agregado en migracion Syb-SQL
if exists (select * from cl_errores
           where numero between 108000 and 108002)
delete cl_errores where numero between 108000 and 108002
go
--Agregado en migracion Syb-SQL

print 'Errores de Existencia '
go
insert into cl_errores values (150000, 0, 'ERROR EN INSERCION')
insert into cl_errores values (150001, 0, 'ERROR EN ACTUALIZACION')
insert into cl_errores values (150002, 0, 'ERROR - SE ACTUALIZO MAS DE UN REGISTRO')
insert into cl_errores values (150003, 0, 'ERROR, SE ELIMINO MAS DE 1 REGISTRO')
insert into cl_errores values (150004, 0, 'ERROR EN ELIMINACION')
insert into cl_errores values (150005, 0, 'PARAMETRO DE OFICINA NO ENCONTRADO')
insert into cl_errores values (150006, 0, 'PARAMETRO GENERAL NO ENCONTRADO')
insert into cl_errores values (151001, 0, 'No se llenaron todos los campos')
insert into cl_errores values (151002, 0, 'No existe equipo o no esta habilitado')
insert into cl_errores values (151003, 0, 'No existe sistema operativo')
insert into cl_errores values (151004, 0, 'No existe nodo oficina habilitado')
insert into cl_errores values (151005, 0, 'No existe usuario')
insert into cl_errores values (151006, 0, 'No existe horario')
insert into cl_errores values (151007, 0, 'No existe transaccion')
insert into cl_errores values (151008, 0, 'No existe procedimiento')
insert into cl_errores values (151009, 0, 'No existe tipo de link')
insert into cl_errores values (151010, 0, 'No existe producto rol')
insert into cl_errores values (151011, 0, 'No existe producto transaccion')
insert into cl_errores values (151012, 0, 'No existe link')
insert into cl_errores values (151013, 0, 'No existe tipo de protocolo')
insert into cl_errores values (151014, 0, 'No existe configuracion X25')
insert into cl_errores values (151015, 0, 'No existe terminal')
insert into cl_errores values (151016, 0, 'No existe Usuario rol')
insert into cl_errores values (151017, 0, 'No existe base de datos')
insert into cl_errores values (151018, 0, 'No existe Ruta Indirecta, o no existe camino desde Origen hasta Destino')
insert into cl_errores values (151019, 0, 'No existe ruta indirecta')
insert into cl_errores values (151020, 0, 'No existe Producto rol')
insert into cl_errores values (151021, 0, 'No existe X.25')
insert into cl_errores values (151022, 0, 'No existe TCP/IP')
insert into cl_errores values (151023, 0, 'No existe transaccion autorizada')
insert into cl_errores values (151024, 0, 'No existe procedure transaccion')
insert into cl_errores values (151025, 0, 'No existe server logico')
insert into cl_errores values (151026, 0, 'No existe rol')
insert into cl_errores values (151027, 0, 'No existe usuario horario')
insert into cl_errores values (151028, 1, 'No existe tabla')
insert into cl_errores values (151029, 1, 'No existe grupo')
insert into cl_errores values (151030, 1, 'No existe compania')
insert into cl_errores values (151031, 0, 'No existe producto asociado a rol')
insert into cl_errores values (151032, 0, 'No existe definicion de menu')
insert into cl_errores values (151033, 0, 'No existen transacciones para el producto, moneda y tipo ingresados')
insert into cl_errores values (151034, 0, 'No existen parametros definidos por default para la transaccion')
insert into cl_errores values (151035, 0, 'No existen parametro default')
insert into cl_errores values (151036, 0, 'Codigo de transaccion ya existe')
insert into cl_errores values (151037, 0, 'Nemonico de transaccion ya existe')
insert into cl_errores values (151038, 0, 'Severidad debe ser 1 y 0')
insert into cl_errores values (151039, 0, 'Código de error debe ser mayor a 100000')
insert into cl_errores values (151040, 0, 'No existe codigo de error solicitado')
insert into cl_errores values (151041, 0, 'No se ha asignado menu inicial')
insert into cl_errores values (151042, 0, 'Tipo de Transaccion No corresponde')
insert into cl_errores values (151043, 0, 'Codigo de Menu ya existe')
insert into cl_errores values (151044, 0, 'Codigo de Menu no existe')
insert into cl_errores values (151046, 0, 'Parametro ya existe')
insert into cl_errores values (151045, 0, 'No existen tablas de catalogo')
insert into cl_errores values (151047, 0, 'No existe tipo de horario')
insert into cl_errores values (151048, 0, 'Existen Departamentos dependientes de este')
insert into cl_errores values (151049, 0, 'La vigencia de esta tabla ha sido ingresada anteriormente')
insert into cl_errores values (151050, 0, 'No existe vigencia de esta tabla')
insert into cl_errores values (151051, 0, 'Transaccion no permitida')
insert into cl_errores values (151052, 0, 'Filial - RUC/NIT, fueron registrados anteriormente')
insert into cl_errores values (151053, 0, 'Oficina, fue registrada anteriormente')
insert into cl_errores values (151054, 0, 'Departamento fue creado anteriormente')
insert into cl_errores values (151055, 0, 'Oficina anterior no tiene departamentos')
insert into cl_errores values (151056, 0, 'Oficina nueva ya tiene departamentos')
insert into cl_errores values (151057, 0, 'No existe cargo vacante para eliminar')
insert into cl_errores values (151058, 0, 'Existen trabajadores subalternos a este')
insert into cl_errores values (151059, 0, 'Codigo de procedimiento ya existe')
insert into cl_errores values (151060, 0, 'Ya existe login para ese rol')     
insert into cl_errores values (151061, 0, 'Usuario ya tiene login en ese nodo')
insert into cl_errores values (151062, 0, 'Existen Oficinas dependientes de esta Sucursal')
insert into cl_errores values (151063, 0, 'Ya existe ciudad/localidad')
insert into cl_errores values (151064, 0, 'Ya existe Producto Moneda')
insert into cl_errores values (151065, 0, 'Ya existe enlace x25 para ese nodo')
insert into cl_errores values (151066, 0, 'Ya existe enlace tcp para ese nodo')
insert into cl_errores values (151067, 0, 'Ya existe link')                     
insert into cl_errores values (151068, 0, 'Ya existe ruta directa')             
insert into cl_errores values (151069, 0, 'Ya existe ruta indirecta')           
insert into cl_errores values (151070, 0, 'Ya existe codigo de error')          
insert into cl_errores values (151071, 0, 'Ya existe bases de datos')          
insert into cl_errores values (151072, 0, 'Ya existe producto transaccion')    
insert into cl_errores values (151073, 0, 'Ya existe provincia')               
insert into cl_errores values (151074, 0, 'Ya existe servidor logico')         
insert into cl_errores values (151075, 1, 'Ya existe descripcion de rol')
insert into cl_errores values (151076, 0, 'La clave debe ser creada por personas diferentes') 
insert into cl_errores values (151170, 0, 'No existen vistas para el producto')
insert into cl_errores values (151171, 0, 'No existen más vistas para el producto') 
insert into cl_errores values (151172, 0, 'No existen registros') 
insert into cl_errores values (151173, 0, 'No existen más registros')  
insert into cl_errores values (151174, 0, 'Producto ya está relacionado a Oficina')  
insert into cl_errores values (157092, 0, 'No existe Parroquia')
insert into cl_errores values (157095, 0, 'Barrio ya existe en esta ciudad')
insert into cl_errores values (157097, 0, 'No existe Barrio')
insert into cl_errores values (157098, 0, 'Distrito ya existe en este Cantón')
insert into cl_errores values (157930, 1, 'El servicio ya está asociado a esa oficina')
insert into cl_errores values (157931, 1, 'El servicio financiero no esta asociado a la oficina')
insert into cl_errores values (157932, 1, 'Código de servicio financiero incorrecto')
insert into cl_errores values (157933, 0, 'El supervisor ya esta asociado a esa oficina')
insert into cl_errores values (157934, 0, 'No existen supervisores asociados a la oficina')
insert into cl_errores values (157935, 0, 'El supervisor no existe')
insert into cl_errores values (157936, 0, 'No existen mas supervisores asociados a la oficina')
insert into cl_errores values (157937, 1, 'No existen servicios financieros asociados a la oficina')
insert into cl_errores values (157938, 1, 'No existen más servicios financieros asociados a la oficina')
insert into cl_errores values (157939, 0, 'Ya existe departamento')
insert into cl_errores values (157940, 1 ,'No existe el municipio')
insert into cl_errores values (157941, 1 ,'Ya existe el municipio')
insert into cl_errores values (157942, 1 ,'Código de provincia incorrecto')
insert into cl_errores values (157943, 1 ,'Provincia no vigente')
insert into cl_errores values (157944, 1 ,'No existen más municipios')
insert into cl_errores values (157945, 1 ,'No existen municipios')
insert into cl_errores values (157946, 1 ,'Código de cantón incorrecto')
insert into cl_errores values (157947, 1 ,'El canton ya existe')
insert into cl_errores values (157948, 1 ,'No existe el canton')
insert into cl_errores values (157949, 1, 'Existen Puntos de Atención dependientes de esta Agencia')
insert into cl_errores values (157950, 1, 'No existe tipo de ambito')
insert into cl_errores values (157951, 1, 'No existe ambito')
insert into cl_errores values (157952, 1, 'Ya existe el ambito')
insert into cl_errores values (157953, 1, 'El cargo ya tiene un ambito creado')
insert into cl_errores values (157954, 1, 'Codigo de ambito incorrecto')
insert into cl_errores values (157955, 1, 'No existen registros de ambito')
insert into cl_errores values (157956, 1, 'No existe ambito para el cargo del trabajador')

insert into cl_errores values (157961, 0, 'El rol ya esta asociado al supervisor')
insert into cl_errores values (157962, 0, 'El Supervisor no tiene roles asociados')
insert into cl_errores values (157963, 0, 'No hay Supervisores Autorizantes Parametrizados')
go


print 'Errores de Actualizacion '
go
insert into cl_errores values (155000, 1, 'Campo no puede ser actualizado')
insert into cl_errores values (155001, 1, 'Error en actualizacion de nodo')
insert into cl_errores values (155002, 1, 'Error en actualizacion sis operativo')
insert into cl_errores values (155003, 1, 'Error en actualizacion de nodo oficina')
insert into cl_errores values (155004, 1, 'Error en actualizacion de terminal')
insert into cl_errores values (155005, 1, 'Error en actualizacion de usuario')
insert into cl_errores values (155006, 1, 'Error en actualizacion de rol')
insert into cl_errores values (155007, 1, 'Error en actualizacion de usuario rol')
insert into cl_errores values (155008, 1, 'Error en actualizacion de horario')
insert into cl_errores values (155009, 1, 'Error en actualizacion de transaccion')
insert into cl_errores values (155060, 1, 'Error en actualizacion de base de datos')
insert into cl_errores values (155011, 1, 'Error en actualizacion de tipo de link')
insert into cl_errores values (155012, 1, 'Error en actualizacion de link')
insert into cl_errores values (155013, 1, 'Error en actualizacion de protocolo')
insert into cl_errores values (155014, 1, 'Error en actualizacion de configuracion X25')
insert into cl_errores values (155015, 1, 'Error en actualizacion de ruta directa')
insert into cl_errores values (155016, 1, 'Error en actualizacion de ruta indirecta')
insert into cl_errores values (155017, 1, 'Error en actualizacion de stored procedure')
insert into cl_errores values (155018, 1, 'Error en actualizacion de ruta')
insert into cl_errores values (155019, 1, 'Error en actualizacion de default de transaccion')
insert into cl_errores values (155020, 1, 'Error en actualizacion de error')
insert into cl_errores values (155021, 1, 'Error en actualizacion de instancia')
insert into cl_errores values (155022, 1, 'Menu a actualizar no existe        ')
insert into cl_errores values (155023, 1, 'Error en actualizacion de Menu')
insert into cl_errores values (155024, 1, 'Error en actualizacion de Parametro')
insert into cl_errores values (155025, 1, 'Error en actualizacion de secuencial de Horario')
insert into cl_errores values (155026, 1, 'Error en actualizacion de Tipo de Horario')
insert into cl_errores values (155027, 1, 'Error en actualizacion de Vigencia de la Tabla')
insert into cl_errores values (157096, 0, 'Error en actualización de Barrio')
insert into cl_errores values (157214, 0, 'Error en actualización de municipio')
insert into cl_errores values (157219, 0, 'Error en creación de transacción de actualización de municipio')
insert into cl_errores values (157220, 0, 'Error en creación de transacción de actualización de canton')
insert into cl_errores values (157221, 0, 'Error en actualización de canton')
insert into cl_errores values (157222, 0, 'Exite referencia en Ciudad')
insert into cl_errores values (157223, 0, 'No se puede relacionar con una sucursal')
insert into cl_errores values (157224, 0, 'Error en acutalizacion de ambito')

if not exists(select 1 from cl_errores where numero = 157225)
insert into cl_errores values (157225, 1, 'Error en eliminacion de ambito')
go


print 'Errores de Insercion '
go
insert into cl_errores values (153000, 1, 'Error en creacion de sis_operativo')
insert into cl_errores values (153001, 1, 'Error en creacion de nodo')
insert into cl_errores values (153002, 1, 'Error en creacion de nodo oficina')
insert into cl_errores values (153003, 1, 'Error en creacion de terminal')
insert into cl_errores values (153004, 1, 'Error en creacion de usuario')
insert into cl_errores values (153005, 1, 'Error en creacion de rol')
insert into cl_errores values (153006, 1, 'Error en creacion de usuario rol')
insert into cl_errores values (153007, 1, 'Error en creacion de horario')
insert into cl_errores values (153008, 1, 'Error en creacion de producto rol')
insert into cl_errores values (153009, 1, 'Error en creacion de producto transaccion')
insert into cl_errores values (153010, 1, 'Error en creacion de transaccion autorizada')
insert into cl_errores values (153011, 1, 'Error en creacion de procedure transaccion ')
insert into cl_errores values (153012, 1, 'Error en creacion de server logico')
insert into cl_errores values (153013, 1, 'Error en creacion de base de datos')
insert into cl_errores values (153014, 1, 'Error en creacion de tipo link')
insert into cl_errores values (153015, 1, 'Error en creacion de link')
insert into cl_errores values (153016, 1, 'Error en creacion de protocolo')
insert into cl_errores values (153017, 1, 'Error en creacion de x25')
insert into cl_errores values (153018, 1, 'Error en creacion de configuracion X25')
insert into cl_errores values (153019, 1, 'Error en creacion de ruta directa')
insert into cl_errores values (153020, 1, 'Error en creacion de ruta indirecta')
insert into cl_errores values (153021, 1, 'Error en creacion de stored procedure')
insert into cl_errores values (153022, 1, 'Error en creacion de tcp/ip')
insert into cl_errores values (153023, 1, 'Error en creacion de transaccion de servicio')
insert into cl_errores values (153024, 1, 'Error en creacion de usuario horario')
insert into cl_errores values (153025, 1, 'Error en creacion de error')
insert into cl_errores values (153026, 1, 'Error en creacion de menu')
insert into cl_errores values (153027, 1, 'Error en creacion de transaccion de servicio financiero')
insert into cl_errores values (153028, 1, 'Error en creacion de Tipo de Horario')
insert into cl_errores values (153029, 1, 'Error en creacion de Tipo de Horario en Tabla Temporal')
insert into cl_errores values (153030, 1, 'Error en creacion de Horario en Tabla Temporal')
insert into cl_errores values (153031, 1, 'Error en creacion de Vigencia de Tabla')
insert into cl_errores values (153039, 1, 'Error en creacion de día feriado, fecha menor o igual a la fecha actual')
insert into cl_errores values (153071, 0, 'Error en creacion de Servicio Financiero')
insert into cl_errores values (157094, 0, 'Error en creacion de Barrio')
insert into cl_errores values (153095, 0, 'Error en creacion de Asociacion supervisor oficina')
insert into cl_errores values (153096, 0, 'Error en creacion de Transaccion supervior oficina')
insert into cl_errores values (153097, 0, 'Error en creacion de municipio')
insert into cl_errores values (153098, 0, 'Error en creacion de transaccion de inserción de municipio')
insert into cl_errores values (153099, 0, 'Error en creacion de canton')
insert into cl_errores values (153100, 0, 'Error en creacion de transaccion de insercion canton')
insert into cl_errores values (153101, 1, 'Error en insercion de ambito')
insert into cl_errores values (153102, 0, 'Error en transaccion de servicio de ambito')

insert into cl_errores values (153104, 0, 'Error en creacion de Asociacion rol supervisor')

go


print 'Errores de Eliminacion '
go
insert into cl_errores values (157000, 1, 'Existe referencia en nodo oficina')
insert into cl_errores values (157001, 1, 'Error en eliminacion de Nodo')
insert into cl_errores values (157002, 1, 'Error en eliminacion de Sistema operativo')
insert into cl_errores values (157003, 1, 'Existe referecia de ruta directa')
insert into cl_errores values (157004, 1, 'Existe referencia de ruta indirecta')
insert into cl_errores values (157005, 1, 'Existe referencia de base de datos')
insert into cl_errores values (157006, 1, 'Existe referencia de link')
insert into cl_errores values (157007, 1, 'Existe referencia de usuario')
insert into cl_errores values (157008, 1, 'Existe referencia de nodo en terminal')
insert into cl_errores values (157009, 1, 'Existe referencia de server logico')
insert into cl_errores values (157010, 1, 'Error en eliminacion de Nodo oficina')
insert into cl_errores values (157011, 1, 'Error en eliminacion de terminal')
insert into cl_errores values (157012, 1, 'Existe referencia de Usuario rol')
insert into cl_errores values (157013, 1, 'Error en eliminacion de Usuario')
insert into cl_errores values (157014, 1, 'Existe referencia de producto rol')
insert into cl_errores values (157015, 1, 'Error en eliminacion de rol')
insert into cl_errores values (157016, 1, 'Error en eliminacion de usuario rol')
insert into cl_errores values (157017, 1, 'Error en eliminacion de horario')
insert into cl_errores values (157018, 1, 'Existe referencia de transaccion autorizada')
insert into cl_errores values (157019, 1, 'Error en eliminacion de producto rol')
insert into cl_errores values (157020, 1, 'Existe referencia de producto transaccion')
insert into cl_errores values (157021, 1, 'Error en eliminacion de transaccion')
insert into cl_errores values (157022, 1, 'Error en eliminacion de producto transaccion')
insert into cl_errores values (157023, 1, 'Existe referencia de procedure transaccion')
insert into cl_errores values (157024, 1, 'Error en eliminacion de procedure')
insert into cl_errores values (157025, 1, 'Error en eliminacion de transaccion autorizada')
insert into cl_errores values (157026, 1, 'Error en eliminacion de procedure transaccion ')
insert into cl_errores values (157027, 1, 'Error en eliminacion de server logico')
insert into cl_errores values (157028, 1, 'Error en eliminacion de base de datos')
insert into cl_errores values (157029, 1, 'Existe referencia de tipo de link')
insert into cl_errores values (157030, 1, 'Existe referencia de interface')
insert into cl_errores values (157031, 1, 'Error en eliminacion de link')
insert into cl_errores values (157032, 1, 'Error en eliminacion de protocolo')
insert into cl_errores values (157033, 1, 'Existe referencia de Aplicacion')
insert into cl_errores values (157034, 1, 'Error en eliminacion X.25')
insert into cl_errores values (157035, 1, 'Error en eliminacion TCP / IP')
insert into cl_errores values (157036, 1, 'Error en eliminacion de ruta directa')
insert into cl_errores values (157037, 1, 'Error en eliminacion de ruta indirecta')
insert into cl_errores values (157038, 1, 'Error en eliminacion de configuracion X25')
insert into cl_errores values (157039, 1, 'Error en eliminacion de tipo de link')
insert into cl_errores values (157040, 1, 'Existe referencia de usuario horario')
insert into cl_errores values (157041, 1, 'Error en eliminacion de usuario')
insert into cl_errores values (157042, 1, 'Error en eliminacion de error')
insert into cl_errores values (157043, 1, 'Menu a eliminar no existe')
insert into cl_errores values (157044, 1, 'Menu tiene opciones, no puede ser eliminado')
insert into cl_errores values (157045, 1, 'Error en eliminacion de menu')
insert into cl_errores values (157046, 1, 'Error en eliminacion de Tipo de Horario')
insert into cl_errores values (157047, 1, 'Existe referencia en ad_horario')
insert into cl_errores values (157048, 1, 'Existe referencia en configuracion')
insert into cl_errores values (157049, 1, 'Error en eliminacion de Vigencia de Tablas')
insert into cl_errores values (157050, 1, 'Error en eliminacion de distributivo')
insert into cl_errores values (157211, 1, 'Error en eliminacion de Servicio Financiero')
insert into cl_errores values (157212, 1, 'Error en eliminacion de Asociacion Servicio Financiero')
insert into cl_errores values (157213, 1, 'Error en eliminacion de Asociacion supervisor oficina')
insert into cl_errores values (157215, 1, 'Error en eliminacion de municipio')
insert into cl_errores values (157216, 1, 'Error en eliminacion de Servicio Financiero')
insert into cl_errores values (157217, 1, 'Error en creacion de transacción de eliminacion de municipio')
insert into cl_errores values (157218, 1, 'Exite referencia en Cantón')

insert into cl_errores values (157227, 0, 'Error en eliminacion de Asociacion rol supervisor')
insert into cl_errores values (157229, 1, 'Existe referencia de oficina horario')
insert into cl_errores values (157230, 1, 'Error en autorizacion de componentes')
insert into cl_errores values (157231, 1, 'Error en autorizacion de modulos')
insert into cl_errores values (157232, 1, 'Error en autorizacion de paginas')
insert into cl_errores values (157233, 1, 'Error en autorizacion de zonas de navegacion')

go

print 'Errores de Oficiales '
go
insert into cl_errores values (151091, 0, 'No existe Oficial')         
insert into cl_errores values (151092, 0, 'El Trabajador ya esta definido como Oficial')         
insert into cl_errores values (151089, 0, 'No puede cambiar el nivel de oficial a uno menor o igual')         
insert into cl_errores values (151090, 0, 'Oficial tiene subordinados, no puede eliminarse')
insert into cl_errores values (157068, 1, 'Error en eliminacion de Oficial')
insert into cl_errores values (155042, 1, 'Error en actualizacion de Oficial')
insert into cl_errores values (153038, 1, 'Error en creacion de Oficial')
go


print 'Errores de Servidores de Distribucion '
go
insert into cl_errores values (153040, 1, 'ERROR EN CREACION DE SERVIDOR DE DISTRIBUCION')
insert into cl_errores values (151093, 0, 'NO EXISTE SERVIDOR DE DISTRIBUCION')
insert into cl_errores values (157069, 1, 'ERROR EN ELIMINACION DE SERVIDOR DE DISTRIBUCION')
insert into cl_errores values (151099, 0, 'NO EXISTE TABLA EN DI_SEQNOS')
go


print 'Errores de Medios Electronicos '
go
insert into cl_errores values (153041, 1, 'ERROR EN CREACION DE MEDIO ELECTRONICO PARA DEPARTAMENTO')
insert into cl_errores values (153042, 1, 'ERROR EN CREACION DE MEDIO ELECTRONICO PARA TRABAJADOR')
insert into cl_errores values (153043, 1, 'ERROR EN CREACION DE MEDIO ELECTRONICO PARA OFICINA')
insert into cl_errores values (157070, 1, 'ERROR EN ELIMINACION DE MEDIO ELECTRONICO PARA DEPARTAMENTO')
insert into cl_errores values (157071, 1, 'ERROR EN ELIMINACION DE MEDIO ELECTRONICO PARA TRABAJADOR')
insert into cl_errores values (157072, 1, 'ERROR EN ELIMINACION DE MEDIO ELECTRONICO PARA OFICINA')
insert into cl_errores values (155043, 1, 'ERROR EN ACTUALIZACION DE MEDIO ELECTRONICO PARA DEPARTAMENTO')
insert into cl_errores values (155044, 1, 'ERROR EN ACTUALIZACION DE MEDIO ELECTRONICO PARA TRABAJADOR')
insert into cl_errores values (155045, 1, 'ERROR EN ACTUALIZACION DE MEDIO ELECTRONICO PARA OFICINA')
insert into cl_errores values (151094, 0, 'NO EXISTE MEDIO ELECTRONICO PARA DEPARTAMENTO')
insert into cl_errores values (151095, 0, 'NO EXISTE MEDIO ELECTRONICO PARA TRABAJADOR')
insert into cl_errores values (151096, 0, 'NO EXISTE MEDIO ELECTRONICO PARA OFICINA')
insert into cl_errores values (151097, 0, 'NO EXISTE EL TIPO DE MEDIO ELECTRONICO ESPECIFICADO')
insert into cl_errores values (151098, 0, 'NO EXISTE EL ESTADO ESPECIFICADO PARA EL MEDIO ELECTRONICO')
go


print 'Errores Siguientes'
go
insert into cl_errores values (151121, 1, 'NO EXISTEN MAS DATOS')
go

/********** TASAS REFERENCIALES **********/
/* ARO : 4 de Julio del 2000 */

insert into cl_errores values (151100, 0, 'TR: LA TASA REFERENCIAL NO EXISTE')
insert into cl_errores values (151101, 0, 'TR: LA CARACTERISTICA DE TASA YA EXISTE')
insert into cl_errores values (151102, 0, 'TR: LA CARACTERISTICA DE TASA NO EXISTE')
insert into cl_errores values (151103, 0, 'TR: EL CODIGO DE LA TASA REFERENCIAL YA EXISTE')
insert into cl_errores values (151104, 0, 'TR: NO EXISTEN DATOS DE OTRAS REFERENCIAS')
insert into cl_errores values (151105, 0, 'TR: LOS DATOS DE PIZARRA YA EXISTEN PARA EL RANGO DE FECHAS Y RANGO DE DIAS DADO')
insert into cl_errores values (151106, 0, 'TR: NO EXISTEN LOS DATOS EN PIZARRA')
insert into cl_errores values (151107, 0, 'TR: PARA ESTA REFERENCIA (RANGO UNICO) SOLO SE ACEPTA UN DATO EN UN RANGO DE FECHAS PREVIAMENTE INGRESADO')
insert into cl_errores values (151108, 0, 'TR: Las Tasas Coap ya existe para la fechas y rango de monto y días dados')
insert into cl_errores values (151109, 0, 'TR: NO EXISTE LA TASA COAP ESPECIFICADA')
insert into cl_errores values (151110, 0, 'TR: NO EXISTEN REGISTROS EN LINEAMIENTOS DEL COAP CON ESAS CARACTERISTICAS ESPECIFICAS')
insert into cl_errores values (151111, 0, 'TR: La Cotización de la divisa ya existe')
insert into cl_errores values (151112, 0, 'TR: No existen datos de Cotización de Divisas')
insert into cl_errores values (151113, 0, 'TR: EL DATO DE DIVISA FUTURA YA EXISTE PARA ESE RANGO DE FECHAS')
insert into cl_errores values (151114, 0, 'TR: EL DATO DE DIVISA FUTURA NO EXISTE')
insert into cl_errores values (151115, 0, 'TR: NO EXISTEN DATOS DE COTIZACIONES FUTURAS')
insert into cl_errores values (151116, 0, 'TR: NO SE ENCONTRO UNO DE DE LOS PARAMETROS INICIALES')
insert into cl_errores values (151117, 0, 'TR: EL DATO DE RELACION CON EL DOLAR YA EXISTE PARA ESE RANGO DE FECHAS')
insert into cl_errores values (151118, 0, 'TR: NO EXISTEN DATO DE RELACION CON EL DOLAR')
insert into cl_errores values (151180, 0, 'Usuario no autorizado para consultar Tasas')
insert into cl_errores values (151181, 0, 'Usuario no autorizado para modificar Tasas')
insert into cl_errores values (151182, 0, 'Usuario no autorizado para crear Tasas ')
insert into cl_errores values (151183, 0, 'Usuario no autorizado para eliminar Tasas ')
insert into cl_errores values (151184, 0, 'Usuario no autorizado para autorizar Tasas')
insert into cl_errores values (151185, 0, 'Tasa ya fue autorizada')
insert into cl_errores values (151186, 0, 'Tasa no se pudo autorizar')
insert into cl_errores values (153044, 1, 'TR: ERROR EN CREACION DE TASA REFERENCIAL')
insert into cl_errores values (153045, 1, 'TR: ERROR EN CREACION DE CARACTERISTICAS DE TASAS')
insert into cl_errores values (153046, 1, 'TR: ERROR EN CREACION DE DATOS DE PIZARRA')
insert into cl_errores values (153047, 1, 'TR: ERROR EN CREACION DE TASA COAP')
insert into cl_errores values (153048, 1, 'TR: ERROR EN CREACION DE COTIZACION DE DIVISA')
insert into cl_errores values (153049, 1, 'TR: ERROR EN CREACION DE DIVISA FUTURA')
insert into cl_errores values (153050, 1, 'TR: ERROR EN CREACION DE RELACION CON EL DOLAR')
insert into cl_errores values (155046, 1, 'TR: ERROR EN MODIFICACION DE TASA REFERENCIAL')
insert into cl_errores values (155047, 1, 'TR: ERROR EN MODIFICACION DE CARACTERISTICAS DE TASA')
insert into cl_errores values (155048, 1, 'TR: ERROR EN MODIFICACION DE PIZARRA')
insert into cl_errores values (155049, 1, 'TR: ERROR EN MODIFICACION DE TASAS COAP')
insert into cl_errores values (155050, 1, 'TR: ERROR EN MODIFICACION DE COTIZACION DE DIVISAS')
insert into cl_errores values (155051, 1, 'TR: ERROR EN MODIFICACION DE DIVISAS FUTURAS')
insert into cl_errores values (155052, 1, 'TR: ERROR EN MODIFICACION DE RELACION CON DOLAR')
insert into cl_errores values (157073, 1, 'TR: ERROR EN ELIMINACION DE PIZARRA')
insert into cl_errores values (157074, 1, 'TR: ERROR EN ELIMINACION DE TASA COAP')
insert into cl_errores values (157075, 1, 'TR: ERROR EN ELIMINACION DE DIVISAS FUTURAS')
insert into cl_errores values (157076, 1, 'TR: ERROR EN ELIMINACION DE RELACION CON EL DOLAR')
go

/****** FIN DE TASAS REFERENCIALES *******/


/*** Manejo de Passwords ***/
/** ARO: 16 de Noviembre del 2000 **/

insert into cl_errores values (151122, 1, 'NO EXISTE PARAMETRO DE TAMANIO MINIMO DE PASSWORD')
insert into cl_errores values (151123, 1, 'TAMANIO DE PASSWORD INCORRECTO')
insert into cl_errores values (151124, 1, 'NO EXISTE PARAMETRO DE NUMERO DE PASSWORDS PARA CONTROL HISTORICO (NPCH)')
insert into cl_errores values (151125, 1, 'ESTE  PASSWORD YA HA SIDO USADO ANTERIORMENTE')
insert into cl_errores values (151126, 1, 'NO EXISTE PARAMETRO DE TAMANIO MINIMO DE LOGIN (TML)')
insert into cl_errores values (151127, 1, 'TAMANIO DE LOGIN INCORRECTO')
insert into cl_errores values (153051, 1, 'ERROR EN CREACION DE HISTORICO DE CLAVES')
go

/**** Fin Manejo de Tasas Referenciales *****/


/********* NUEVO ESQUEMA DE ENCRIPTAMIENTO DE PASSWORDS *******/
/*** ARO:23/01/2001 ****/
insert into cl_errores values (151128, 0, 'NO EXISTE EL TRABAJADOR')
insert into cl_errores values (151129, 0, 'EL PASSWORD INGRESADO ES INCORRECTO')
go

/********* FIN NUEVO ESQUEMA DE ENCRIPTAMIENTO DE PASSWORDS *******/

/****************************** ADMIN WEB *********************************/
/**** ARO:12 de Marzo del 2001 ****/
insert into cl_errores values (151130, 0, 'NO EXISTE LA FUNCIONALIDAD PADRE REFERENCIADA')
insert into cl_errores values (151131, 0, 'NO EXISTE LA FUNCIONALIDAD REFERENCIADA')
insert into cl_errores values (151132, 0, 'EXISTEN DEPENDENCIAS DE OTRAS FUNCIONALIDADES CON ESTA FUNCIONALIDAD')
insert into cl_errores values (151133, 0, 'NO EXISTE EL GRUPO DE FUNCIONALIDADES REFERENCIADO')
insert into cl_errores values (151134, 0, 'LA TRANSACCION YA HA SIDO ASIGNADA A LA FUNCIONALIDAD')
insert into cl_errores values (151135, 0, 'LA TRANSACCION NO HA SIDO ASIGNADA A LA FUNCIONALIDAD')
insert into cl_errores values (151136, 0, 'NO EXISTE LA AYUDA PARA LA FUNCIONALIDAD REFERENCIADA')
insert into cl_errores values (151137, 0, 'NO EXISTE EL IDIOMA REFERENCIADO')
insert into cl_errores values (151138, 0, 'NO EXISTE LA ETIQUETA PARA LA FUNCIONALIDAD REFERENCIADA')
insert into cl_errores values (151139, 0, 'NO EXISTE EL CONTEXTO PARA LA FUNCIONALIDAD REFERENCIADA')
insert into cl_errores values (151140, 0, 'NO EXISTE EL CONTEXTO REFERENCIADO')
insert into cl_errores values (151141, 0, 'NO EXISTE LA AYUDA PARA CONTEXTO REFERENCIADA')
insert into cl_errores values (151142, 0, 'NO EXISTE EL NOMBRE DE CONTEXTO REFERENCIADO')
insert into cl_errores values (151143, 0, 'NO EXISTE LA HERRAMIENTA REFERENCIADA')
insert into cl_errores values (151144, 0, 'NO EXISTE LA AYUDA DE HERRAMIENTA REFERENCIADA')
insert into cl_errores values (151145, 0, 'NO EXISTE EL NOMBRE DE HERRAMIENTA REFERENCIADO')
insert into cl_errores values (151146, 0, 'NO EXISTE EL PREREQUISITO')
insert into cl_errores values (151147, 0, 'NO EXISTE EL PREREQUISITO ASOCIADO A LA FUNCIONALIDAD')
insert into cl_errores values (151148, 0, 'NO EXISTE ASOCIACIÓN ENTRE EL ROL Y LA FUNCIONALIDAD')
insert into cl_errores values (151149, 0, 'EXISTE UN NOMBRE ASOCIADO AL CONTEXTO')
insert into cl_errores values (151150, 0, 'EXISTE UNA AYUDA ASOCIADA AL CONTEXTO')
insert into cl_errores values (151151, 0, 'EXISTE UN NOMBRE ASOCIADO A LA HERRAMIENTA')
insert into cl_errores values (151152, 0, 'EXISTE UNA AYUDA ASOCIADO A LA HERRAMIENTA')
insert into cl_errores values (151153, 0, 'LA HERRAMIENTA YA HA SIDO ASIGNADA AL ROL')
insert into cl_errores values (151154, 0, 'LA HERRAMIENTA NO HA SIDO ASIGNADA AL ROL')
insert into cl_errores values (151155, 0, 'EXISTEN AYUDAS ASOCIADAS A LA FUNCIONALIDAD')
insert into cl_errores values (151156, 0, 'EXISTEN ETIQUETAS ASOCIADAS A LA FUNCIONALIDAD')
insert into cl_errores values (151157, 0, 'EXISTEN CONTEXTOS ASOCIADAS A LA FUNCIONALIDAD')
insert into cl_errores values (151158, 0, 'EXISTEN PREREQUISITOS ASOCIADOS A LA FUNCIONALIDAD')
insert into cl_errores values (151159, 0, 'EXISTEN TRANSACCIONES ASOCIADAS A LA FUNCIONALIDAD')
insert into cl_errores values (153052, 1, 'ERROR EN CREACION DE FUNCIONALIDAD')
insert into cl_errores values (153053, 1, 'ERROR EN ASIGNACION DE TRANSACCION A FUNCIONALIDAD')
insert into cl_errores values (153054, 1, 'ERROR EN CREACION DE AYUDA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (153055, 1, 'ERROR EN CREACION DE ETIQUETA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (153056, 1, 'ERROR EN CREACION DE CONTEXTO PARA UNA FUNCIONALIDAD')
insert into cl_errores values (153057, 1, 'ERROR EN CREACION DE CONTEXTO')
insert into cl_errores values (153058, 1, 'ERROR EN CREACION DE AYUDA PARA CONTEXTO')
insert into cl_errores values (153059, 1, 'ERROR EN CREACION DE NOMBRE PARA CONTEXTO')
insert into cl_errores values (153060, 1, 'ERROR EN CREACION DE HERRAMIENTA')
insert into cl_errores values (153061, 1, 'ERROR EN CREACION DE AYUDA PARA HERRAMIENTA')
insert into cl_errores values (153062, 1, 'ERROR EN CREACION DE NOMBRE PARA HERRAMIENTA')
insert into cl_errores values (153063, 1, 'ERROR EN CREACION DE PREREQUISITO PARA UNA FUNCIONALIDAD')
insert into cl_errores values (153064, 1, 'ERROR EN ASIGNACION DE FUNCIONALIDAD A ROL')
insert into cl_errores values (153065, 1, 'ERROR EN ASIGNACION DE HERRAMIENTA A ROL')
insert into cl_errores values (153066, 1, 'ERROR EN CREACION DE REGISTROS EN TABLA TEMPORAL #aw_func_procesada')
insert into cl_errores values (153067, 1, 'ERROR EN CREACION DE REGISTROS EN TABLA TEMPORAL #aw_tran_rol')
insert into cl_errores values (155061, 1, 'ERROR EN ACTUALIZACION DE FUNCIONALIDAD')
insert into cl_errores values (155062, 1, 'ERROR EN ACTUALIZACION DE AYUDA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (155063, 1, 'ERROR EN ACTUALIZACION DE ETIQUETA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (155064, 1, 'ERROR EN ACTUALIZACION DE CONTEXTO')
insert into cl_errores values (155065, 1, 'ERROR EN ACTUALIZACION DE AYUDA PARA CONTEXTO')
insert into cl_errores values (155066, 1, 'ERROR EN ACTUALIZACION DE NOMBRE PARA CONTEXTO')
insert into cl_errores values (155067, 1, 'ERROR EN ACTUALIZACION DE HERRAMIENTA')
insert into cl_errores values (155068, 1, 'ERROR EN ACTUALIZACION DE AYUDA PARA HERRAMIENTA')
insert into cl_errores values (155069, 1, 'ERROR EN ACTUALIZACION DE NOMBRE PARA HERRAMIENTA')
insert into cl_errores values (157077, 1, 'ERROR EN ELIMINACION DE FUNCIONALIDAD')
insert into cl_errores values (157078, 1, 'ERROR EN DESASIGNACION DE TRANSACCION A FUNCIONALIDAD')
insert into cl_errores values (157079, 1, 'ERROR EN ELIMINACION DE AYUDA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (157080, 1, 'ERROR EN ELIMINACION DE ETIQUETA PARA UNA FUNCIONALIDAD')
insert into cl_errores values (157081, 1, 'ERROR EN ELIMINACION DE CONTEXTO PARA UNA FUNCIONALIDAD')
insert into cl_errores values (157082, 1, 'ERROR EN ELIMINACION DE CONTEXTO')
insert into cl_errores values (157083, 1, 'ERROR EN ELIMINACION DE AYUDA PARA CONTEXTO')
insert into cl_errores values (157084, 1, 'ERROR EN ELIMINACION DE NOMBRE PARA CONTEXTO')
insert into cl_errores values (157085, 1, 'ERROR EN ELIMINACION DE HERRAMIENTA')
insert into cl_errores values (157086, 1, 'ERROR EN ELIMINACION DE AYUDA PARA HERRAMIENTA')
insert into cl_errores values (157087, 1, 'ERROR EN ELIMINACION DE NOMBRE PARA HERRAMIENTA')
insert into cl_errores values (157088, 1, 'ERROR EN ELIMINACION DE PREREQUISITO PARA UNA FUNCIONALIDAD')
insert into cl_errores values (157089, 1, 'ERROR EN DESASIGNACIÓN DE FUNCIONALIDAD A ROL')
insert into cl_errores values (157090, 1, 'ERROR EN DESASIGNACION DE TRANSACCION A ROL')
go

/****************************** FIN ADMIN WEB *********************************/


/***************************** NUEVO ESQUEMA BATCH **************************/
insert into cl_errores values (108000, 1, 'ERROR EN INSERCION EN BA_LOG_OPERADOR')
insert into cl_errores values (108001, 0, 'NO EXISTE OPERADOR AUTORIZADO!')
insert into cl_errores values (108002, 0, 'OPERACION INEXISTENTE!')
insert into cl_errores values (151160, 0, 'No existe usuario o usuario no está vigente')
insert into cl_errores values (151161, 0, 'No existe parámetro de rol de operador de batch')
insert into cl_errores values (151162, 0, 'El usuario no posee rol de operador de batch')
insert into cl_errores values (151163, 0, 'Ya existe operador de batch')
insert into cl_errores values (151164, 0, 'No existe operador de batch')
insert into cl_errores values (153068, 0, 'Error en insercion de operador de batch')
insert into cl_errores values (155070, 0, 'Error en actualización de operador de batch')
insert into cl_errores values (157091, 0, 'Error en eliminación de operador de batch')
go 

/***************************** FIN DE NUEVO ESQUEMA BATCH ********************/


/***************************** Personalización BANCO **************************/
insert into cl_errores values (189000, 0, 'No se puede borrar feriado pues es feriado nacional')
insert into cl_errores values (189001, 0, 'La fecha de caducidad de rol no puede ser menor a la actual')
go 

/***************************** FIN: Personalización BANCO **************************/


---------------------------------------- HSBC ----------------------------------------
insert into cl_errores values (189002, 0, 'La fecha de inicio de rol no puede ser mayor a la actual')
insert into cl_errores values (189003, 1, 'Número de empleado excede del límite 2,147,483,647')
go

insert into cl_errores values (157207, 1,'Existió un error al autorizar la zona de navegación')
insert into cl_errores values (157138, 1,'Existió un error al autorizar el módulo')
insert into cl_errores values (157170, 1,'Existió un error al autorizar el componente')
insert into cl_errores values (157192, 1,'Existió un error al autorizar la página')
insert into cl_errores values (157196, 1,'Existió un error al desautorizar la página')
insert into cl_errores values (157174, 1,'Existió un error al desautorizar el componente')
insert into cl_errores values (157140, 1,'Existió un error al desautorizar el módulo')
insert into cl_errores values (157145, 1,'Existió un error al desautorizar la zona de navegación')
insert into cl_errores values (157923, 1,'No existe la etiqueta')
insert into cl_errores values (157924, 1,'Error en la actualización de la etiqueta')
insert into cl_errores values (157925, 0,'Proceso interrumpido por exceder límite de resultados, seleccione un grupo menor de funcionalidades o revise la parametrización')
insert into cl_errores values (157926, 1,'Error al eliminar las autorizaciones de Agentes del Rol')
insert into cl_errores values (157927, 1,'Error al procesar las autorizaciones de Agentes al Rol')
--Caso 21594
insert into cl_errores values (157929, 0,'Ya existe el Medio Electrónico para otra oficina')
insert into cl_errores values (157958, 1,'La oficina de conexion no tiene Regional')
go
