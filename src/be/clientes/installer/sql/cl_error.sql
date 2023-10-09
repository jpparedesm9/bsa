use cobis
go


delete cl_errores where numero between 0 and 149999
go
delete cl_errores where numero IN (901018,7300004,70011007,70011008, 70011016)
delete cl_errores where numero in(201050, 201051, 201052, 201053, 201054)



print 'Existencias de cl_errores'
/********************/
/* CLIENTES         */
/********************/

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (1, 0, 'ERROR EN EJECUCI�N DE PROCESO')
GO


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2011212, 0, 'El oficial que est� utilizando no es un funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (7210, 0, 'COMPRADOR NO FUE REGISTRADO COMO CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (100207, 0, 'Monto De Inembargabilidad No Aplica Para Naturaleza De Cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (100210, 0, 'Monto De Inembargabilidad No Aplica Para Tipo Producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (100216, 0, 'NO EXISTE SUBTIPO DE MERCADO OBJETIVO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (100218, 0, 'NO EXISTE ASOCIACION ENTRE SUBTIPO DE MERCADO OBJETIVO, MERCADO OBJETIVO Y BANCA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101000, 0, 'No existe dato en cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101001, 0, 'No existe dato solicitado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101002, 0, 'No existe filial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101003, 1, 'No existe tabla')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101004, 1, 'No existe tipo de sociedad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101005, 0, 'Abreviatura ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101010, 0, 'Departamento no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101011, 0, 'Jefe no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101012, 0, 'No existe cargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101013, 0, 'No se puede asignar Oficial porque pertenece a Banca diferente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101014, 0, 'Para b�squeda alfab�tica m�nimo 6 caracteres')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101015, 0, 'No existe naturaleza jur�dica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101016, 0, 'No existe oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101017, 0, 'No existe rol de empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101018, 0, 'No existe pa�s')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101019, 0, 'No existe profesi�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101020, 0, 'No existe estado civil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101021, 0, 'No existe tipo de persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101022, 0, 'No existe sexo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101023, 0, 'No existe tipo de referencia econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101024, 0, 'No existe ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101025, 0, 'No existe tipo de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101026, 0, 'No existe representante legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101027, 0, 'No existe actividad econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101028, 0, 'No existe sucursal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101029, 0, 'No existe tipo de tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101030, 0, 'No existe productos contratados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101031, 0, 'No existe producto moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101032, 0, 'No existe producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101033, 0, 'No existe producto oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101034, 0, 'No existe producto asociado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101035, 0, 'No existe departamento en oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101036, 0, 'No existe funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101037, 0, 'No existe barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101038, 0, 'No existe departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101039, 0, 'No existe region natural')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101040, 0, 'No existe region operativa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101041, 0, 'No existe tipo de barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101042, 0, 'No existe prospecto o c�dula incorrecta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101043, 0, 'No existe persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101044, 0, 'No existe parentesco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101045, 0, 'No existe moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101046, 0, 'Subtipo no v�lido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101047, 0, 'No existe tipo de bloqueo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101048, 0, 'No existe sector')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101049, 0, 'No existe distributivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101050, 0, 'No se puede eliminar una casilla principal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101051, 0, 'No existe vacante')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101052, 0, 'Se han borrado todas las direcciones postales, verifique la direccion postal default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101053, 0, 'No se pueden eliminar todas las direcciones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101054, 0, 'No existe estado del servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101055, 0, 'No existe posici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101056, 0, 'No existe rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101057, 0, 'Departamento superior igual a departamento inferior')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101058, 0, 'Funcionario jefe de si mismo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101059, 0, 'No existe direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101060, 1, 'No existe clase o causa de no pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101061, 1, 'NIT o Documento de identidad duplicado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101062, 0, 'Nombre de login ya ha sido asignado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101063, 0, 'Existe referencia en usuario-rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101064, 0, 'El Funcionario est� registrado en algun Nodo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101065, 0, 'Existen funcionarios asignados a departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101066, 0, 'Existe referencia en pro-moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101067, 0, 'Existe referencia en server-logico')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101068, 0, 'Existe referencia en pro-transaccion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101069, 0, 'Existe referencia en pro-rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101070, 0, 'Existe referencia en pro-oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101071, 0, 'Existe referencia en departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101072, 0, 'Existe referencia en ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101073, 0, 'Existe referencia en barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101074, 0, 'Pa�s no esta vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101075, 0, 'Departamento no esta vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101076, 0, 'Ciudad no esta vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101077, 0, 'No existe parametro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101078, 0, 'No existe dato de default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101079, 0, 'No existen datos de perfil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101080, 0, 'No existe perfil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101081, 0, 'No existe servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101082, 0, 'No existe c�digo de operacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101083, 0, 'No existe relaci�n gen�rica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101084, 0, 'No existen datos de servicios contratados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101085, 0, 'No existe par�metro en la tabla de par�metros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101086, 0, 'No existe rol prospecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101087, 0, 'No existe relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101088, 0, 'No existen registros adicionales')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101089, 0, 'No existe relaci�n entre cliente y grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101090, 0, 'Tipo debe ser [G]rupo o [E]mpresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101091, 0, 'No existe relacion entre cliente y grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101092, 0, 'Existe referencia en default de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101093, 0, 'Existe referencia en transacciones de Cuentas Corrientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101094, 0, 'Existe referencia en transacciones de Cuentas de Ahorros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101095, 0, 'Tipo de dato no corresponde a par�metro escogido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101096, 0, 'No existe rol compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101097, 0, 'No existe tablas para este producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101098, 0, 'No existe instancia de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101099, 0, 'relaci�n entre prospectos ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101100, 0, 'La fecha de concesi�n es feriado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101101, 0, 'No se ha registrado la propiedad para ese cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101102, 0, 'El c�digo de cat�logo no puede ser nulo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101103, 0, 'La descripcion de cat�logo no puede ser nula')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101104, 0, 'El c�digo para esta tabla ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101105, 0, 'NIT especificado ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101106, 0, 'No existe apartado para ente indicado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101107, 0, 'No existe prospecto o no pertenece a grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101108, 0, 'No se puede desasignar un grupo de si mismo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101109, 1, 'Error en desasignaci�n de grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101110, 0, 'No existe el producto Cuentas Corrientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101111, 0, 'No existe el producto Cuentas de Ahorros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101112, 0, 'La tabla fue creada anteriormente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101113, 0, 'par�metros incongruentes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101114, 0, 'par�metros inv�lidos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101115, 0, 'Oficial no corresponde al del grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101116, 0, 'Error en la inserci�n de ejecutivo del prospecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101117, 0, 'Error en la inserci�n de hist�rico de ejecutivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101118, 0, 'Error al eliminar ejecutivo del prospecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101119, 0, 'Ya existe grupo econ�mico con ese D.I.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101120, 0, 'No existe atributo de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101121, 0, 'Error, atributo referenciado en instancia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101122, 0, 'Este atributo ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101123, 0, 'Existe referencia en instancia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101124, 0, 'Existe referencia en atributo de instancia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101125, 0, 'No existe Tipo de Balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101126, 0, 'Tipo de Balance no est� vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101127, 0, 'No existe Cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101128, 0, 'Cuenta no esta vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101129, 0, 'No existe el cliente indicado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101130, 0, 'No existe mala referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101131, 0, 'No existe tipo de mala referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101132, 0, 'No existe Zona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101133, 0, 'Ese subsector ya existe para esa zona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101134, 0, 'Existen direcciones en esa zona y subsector')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101135, 0, 'Ya existe esa sucursal en ese departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101136, 0, 'No existe esa compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101137, 0, 'No existen estatutos de esa compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101138, 0, 'No existe objeto social de esa compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101139, 0, 'No existe ese subsector en la zona indicada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101140, 0, 'Fechas incongruentes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101141, 0, 'No existe tipo de calificaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101142, 0, 'No existe tipo de cifras')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101143, 0, 'Falta nombre de instituci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101144, 0, 'No existe ese banco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101145, 0, 'No puede quedarse un balance sin cuentas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101146, 0, 'No existe cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101147, 0, 'No existe Tipo de Sociedad de Hecho')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101148, 0, 'Ente es cliente de un producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101149, 0, 'Ente esta relacionado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101150, 0, 'Ente es lugar de trabajo de otros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101151, 0, 'Barrio ya existe en ese ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101152, 0, 'Pa�s ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101153, 0, 'Ya existe banco para remesas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101154, 0, 'No puede cambiar feriado con fecha anterior o actual')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101155, 0, 'Ya existe persona con ese pasaporte')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101156, 0, 'No existe balance para este cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101157, 0, 'No existe cuentas asociadas a este tipo de balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101158, 0, 'No existe valores en las cuentas del plan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101159, 0, 'Error en consulta de la respuesta CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101160, 0, 'No existe estado financiero')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101161, 0, 'Cuenta de balance no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101162, 0, 'No existe cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101163, 0, 'Cuenta duplicada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101164, 0, 'No existe cuenta en estado financiero')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101165, 0, 'Existe referencia en garant�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101166, 0, 'Categor�a de cuenta incorrecta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101167, 0, 'Ya existe Cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101168, 0, 'Ya existe mala referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101169, 0, 'Ya existe tipo de balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101170, 0, 'NO existe Nivel de Estudio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101171, 0, 'NO existe Tipo de Vivienda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101172, 0, 'NO existe esa Valoracion del Cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101173, 0, 'NO existe esa relaci�n con el Banco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101174, 0, 'NO existe Descripci�n de Otros Ingresos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101175, 0, 'NO existe esa relaci�n Internacional')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101176, 0, 'NO existe esa C�mara de Comercio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101177, 0, 'NO existe ese Grado de Sociedad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101178, 0, 'NO existe ese Tipo de Cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101179, 0, 'NO existe ese Tipo de Manejo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101180, 0, 'NO existe ese Clase de Tarjeta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101181, 0, 'NO existe Tabla de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101182, 0, 'NO existe Atributos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101183, 0, 'NO corresponde codig de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101184, 0, 'NO existe valor de mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101185, 0, 'NO existe Datos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101186, 0, 'YA existe ese Registro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101187, 0, 'YA existe una direcci�n como principal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101188, 0, 'Debe existir una direcci�n como principal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101189, 0, 'Miembro ya esta asignado a ese grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101190, 0, 'No existe Default para Pa�s')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101191, 0, 'No existen Otros Ingresos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101192, 0, 'Ya existe numero de C�dula o Nit con tipo de documento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101193, 0, 'Cliente pertenece a un grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101194, 0, 'No existe tipo de productor')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101195, 0, 'Ya Existe asignaci�n Banca / Mercado Objetivo para este Cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101196, 0, 'No Existe tipo Regimen Fiscal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101197, 0, 'No Existe Categor�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101198, 0, 'No Existe Grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101199, 1, 'No existe Gerente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101200, 0, 'No Existe Oficial Suplente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101201, 0, 'No Existe Referido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101202, 0, 'No Existe Situacion Cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101203, 0, 'No existe n�mero de identificaci�n para el tipo de identificaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101204, 0, 'No existe n�mero de identificaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101205, 0, 'No existe Producto para el N�mero de Identificaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101206, 0, 'No existe c�digo de Juzgado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101207, 0, 'No se pudo insertar Embargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101208, 1, 'Es necesario ingresar la Fecha del oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101209, 1, 'Es necesario ingresar el Juzgado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101210, 1, 'Es necesario ingresar el Concepto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101211, 1, 'Es necesario ingresar el Oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101212, 1, 'Es necesario ingresar el Tipo de documento del demandante')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101213, 1, 'Es necesario ingresar el N�mero del documento del demandante')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101214, 1, 'Es necesario ingresar Nombre del demandante')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101215, 1, 'Es necesario ingresar Valor del embargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101216, 1, 'Cantidad a debitar es superior a valor del embargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101217, 1, 'Naturaleza Juridica es Diferente entre Clientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101218, 1, 'Tipo Persona es Diferente entre Clientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101219, 1, 'Tipo vincultacion es Diferente entre Clientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101220, 1, 'Nuevo Cliente ya esta Asociado al Producto, Verificar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101221, 1, 'No existe Tipo de Documento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101222, 1, 'N�mero de Documento en Rango Incorrecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101223, 1, 'Longitud De Documento Incorrecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101224, 0, 'Cliente debe tener referencia tipo AR - Arrendador')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101225, 0, 'Cliente debe tener direcci�n de negocio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101226, 0, 'Cliente solo debe tener 1 direcci�n de negocio. Por favor actualizar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101227, 0, 'No existen datos con el criterio de b�squeda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101228, 0, 'No existe oficina asociada a la ciudad seleccionada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101229, 0, 'No existe accion del cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101230, 0, 'No existe estrato del cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101231, 0, 'No existe procedencia del cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101232, 0, 'Error en envio de solicitud a CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101233, 0, 'Error al obtener el mensaje de respuesta de CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101234, 0, 'Marcaci�n o desmarcaci�n no procesada CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101235, 0, 'Error en el proceso de validaci�n de identidad. Favor contactese con la mesa de ayuda.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101240, 0, 'ERROR EN LA CONSULTA, NO HAY relaciones PARA ESE CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101241, 0, 'ERROR EN LA CONSULTA, NO EXISTEN relaciones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101242, 0, 'NO EXISTEN OCURRENCIAS SOBRE ESTE CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101243, 0, 'ERROR EN LA CONSULTA, NO HAY OFICINAS CB CREADAS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101244, 0, 'ERROR AL CONSULTAR LAS OFICINAS CB')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101245, 0, 'LA OFICINA REQUERIDA YA SE ENCUENTRA ASIGNADA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101246, 0, 'LA OFICINA REQUERIDA NO EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101247, 0, 'c�digo DE CNB YA EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101249, 0, 'ALGUNOS DE LOS par�metroS NO TIENEN UN VALOR DEFINIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101250, 0, 'relaci�n CLIENTE - CB NO EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101253, 0, 'CLIENTE NO EXISTE/NO ES CB')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101254, 0, 'ERROR: par�metro NO EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101255, 0, 'LA OFICINA, NO ES OFICINA DE MOVIMIENTO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101256, 0, 'OFICINA NO ASOCIADA AL COB (CORRESPONSALES BANCARIOS)')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101257, 0, 'CLIENTE CON REGISTRO EN ESTADO NO DISPONIBLE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101258, 0, 'CLIENTE PARA REGISTRO DE INFORMACION FATCA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101259, 0, 'PREFIJO ENVIADO NO SE ENCUENTRA INGRESADO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101260, 0, 'CLIENTE FATCA YA EXISTE ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101261, 0, 'CLIENTE FATCA NO EXISTE ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101262, 0, 'ERROR, YA EXISTE UNA SOLICITUD DE TRASLADO VIGENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101263, 0, 'ERROR AL INGRESAR LA SOLICITUD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101264, 0, 'ERROR AL INSERTAR EN LA TRANSERVICIO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101265, 0, 'ERROR AL INSERTAR EL DETALLE DE LA CUENTA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101266, 0, 'NO SE ENVIARON TODOS LOS DATOS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101267, 0, 'ESTADO A ACTUALIZAR NO PERMITIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (101268, 0, 'SOLICITUD YA AUTORIZADA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103000, 1, 'Cliente no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103001, 1, 'Error en creaci�n de cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103002, 1, 'Error en creaci�n de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103003, 1, 'Error en creaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103004, 1, 'Error en creaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103005, 1, 'Error en creaci�n de transacci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103006, 1, 'Error en creaci�n de grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103007, 1, 'Error en creaci�n de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103015, 1, 'Error en creaci�n de cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103016, 1, 'Error en creaci�n de actividad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103017, 1, 'Error en creaci�n de cargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103018, 1, 'Error en creaci�n de Pa�s')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103019, 1, 'Error en creaci�n de ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103020, 1, 'Error en creaci�n de tipo de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103021, 1, 'Error en creaci�n de estado civil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103022, 1, 'Error en creaci�n de estado de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103023, 1, 'Error en creaci�n de moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103024, 1, 'Error en creaci�n de posici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103025, 1, 'Error en creaci�n de profesi�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103026, 1, 'Error en creaci�n de tipo de persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103027, 1, 'Error en creaci�n de tipo de referencia economica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103028, 1, 'Error en creaci�n de rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103029, 1, 'Error en creaci�n de tipo de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103030, 1, 'Error en creaci�n de tipo de telefono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103031, 1, 'Error en creaci�n de rol de empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103032, 1, 'Error en creaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103033, 1, 'Error en creaci�n de parentesco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103034, 1, 'Error en creaci�n de dis_seqnos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103035, 1, 'Error en creaci�n de distributivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103036, 1, 'Error en creaci�n de filial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103037, 1, 'Error en creaci�n de producto asociado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103038, 1, 'Error en creaci�n de telefono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103039, 1, 'Error en creaci�n de propiedad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103040, 1, 'Error en creaci�n de region operativa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103041, 1, 'Error en creaci�n de barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103042, 1, 'Error en creaci�n de region natural')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103043, 1, 'Error en creaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103044, 1, 'Error en creaci�n de referencia economica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103045, 1, 'Error en creaci�n de empleo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103046, 1, 'Error en creaci�n de funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103047, 1, 'Error en creaci�n de apartado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103048, 1, 'Error en creaci�n de referencia personal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103049, 1, 'Error en creaci�n de oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103050, 1, 'Error en creaci�n de detalle de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103051, 1, 'Error en creaci�n de dias laborables')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103052, 1, 'Error en creaci�n de dias sabado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103053, 1, 'Error en creaci�n de dias domingo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103054, 1, 'Error en creaci�n de par�metro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103055, 1, 'Error en creaci�n de default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103056, 1, 'Error en creaci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103057, 1, 'Error en creaci�n de atributo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103058, 1, 'Error en creaci�n de default de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103059, 1, 'Error en creaci�n de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103060, 1, 'Error en creaci�n de cat�logo-producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103061, 1, 'Error en creaci�n de instancia de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103062, 1, 'Error en creaci�n de hist�rico de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103063, 1, 'Error en creaci�n de tabla de cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103064, 1, 'Error en creaci�n de atributo de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103065, 1, 'Error en creaci�n de Tipo de Balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103066, 1, 'Error en creaci�n de Tipo de Plan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103067, 1, 'Error en inserci�n de tabla temporal de Tipo de Plan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103068, 1, 'Error en inserci�n de subsector')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103069, 1, 'Error en inserci�n de sucursal de correo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103070, 1, 'Error en inserci�n de estatutos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103071, 1, 'Error en inserci�n de objeto social')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103072, 1, 'Error en inserci�n de referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103073, 1, 'Error en creaci�n de sociedad de hecho')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103074, 1, 'Error en creaci�n de banco para remesas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103075, 1, 'Error en creaci�n de tabla temporal de balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103076, 1, 'Error en creaci�n de balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103077, 1, 'Error en creaci�n de cuentas de balances')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103078, 1, 'Error en creaci�n de plan temporal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103080, 1, 'Error en creaci�n de compan�as en liquidaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103081, 1, 'Error en creaci�n de contacto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103082, 1, 'Error en creaci�n de hijo de un cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103083, 1, 'Error en creaci�n de relaci�n internacional de un cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103084, 1, 'Error en creaci�n de Otros Ingresos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103085, 1, 'Error en inserci�n de Miembro a un GRupo econ�mico')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103086, 1, 'Error en creaci�n de Tablas Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103087, 1, 'Error en creaci�n de Atributos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103088, 1, 'Error en creaci�n de valores de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103089, 1, 'Error en creaci�n de datos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103090, 0, 'Error al insertar en CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103091, 0, 'Error al crear inconsistencia de sincronizaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103092, 0, 'Error al crear Area de Influencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103093, 0, 'Error en inserci�n consulta central riesgos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103094, 1, 'Error en ingreso de tarea')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103095, 1, 'Error en ingreso de detalle de la tarea')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103096, 0, 'Error en ejecuci�n de consulta din�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103097, 0, 'Error en inserci�n en temporal de ponderaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103098, 1, 'Referenciaci�n obligatoria no realizada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103099, 1, 'Error en actualizaci�n de la tarea')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103102, 0, 'ERROR AL INSERTAR LA relaci�n CB - CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103104, 0, 'REGISTRO DE SOSTENIBILIDAD YA EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103105, 0, 'REGISTRO DE SOSTENIBILIDAD NO EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103106, 0, 'REGISTRO DE ESCOLARIDAD YA EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103107, 0, 'REGISTRO DE ESCOLARIDAD NO EXISTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103108, 0, 'ERROR AL INGRESAR EL REGISTRO EN SOSTENIBILIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103109, 0, 'ERROR AL MODIFICAR EL REGISTRO EN SOSTENIBILIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103110, 0, 'ERROR AL CONSULTAR EL REGISTRO EN SOSTENIBILIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103111, 0, 'ERROR AL INGRESAR EL REGISTRO EN ESCOLARIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103112, 0, 'ERROR AL MODIFICAR EL REGISTRO EN ESCOLARIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103113, 0, 'ERROR AL CONSULTAR EL REGISTRO EN ESCOLARIDAD')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103115, 0, 'ERROR AL REALIZAR PROCESO DE ACTUALIZACION CLIENTES CIRCULAR 012')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103116, 0, 'YA EXISTE UNA direcci�n MARCADA COMO ENVIO EXTRACTO COSTOS FINANCIEROS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103117, 0, 'NO EXISTE DATO SOLICITADO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103118, 0, 'ERROR EN inserci�n DE DATOS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103119, 0, 'ERROR EN CARGA DE DATOS HACIA DYNAMICS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103120, 0, 'ERROR direcci�n ASOCIADA A UN PRODUCTO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103121, 0, 'LA ALIANZA SELECCIONADA NO TIENE CLIENTES ASOCIADOS')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103122, 1, 'DEBE INGRESAR UNA compan�a.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103123, 0, 'LA ALIANZA TIENE CLIENTES ASOCIADOS Y NO PERMITE MODIFICACION')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103124, 1, 'DEBE INGRESAR UNA PERSONA NATURAL')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103125, 1, 'TIPO DE DOCUMENTO DEBE SER DE PERSONA NATURAL.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103128, 0, 'Cliente en listas inhibitorias')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103130, 0, 'ERROR. NO SE ENVI� LA identificaci�n DEL CLIENTE.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103131, 0, 'ERROR. NO SE ENVI� EL TIPO DE identificaci�n DEL CLIENTE.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103132, 0, 'ERROR. NO SE ENVI� EL TIPO DE OPERADOR PARA EL NUMERO DEL CELULAR.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103133, 0, 'ERROR. NO SE ENVI� EL NUMERO DEL CELULAR.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103134, 0, 'ERROR. EL VALOR DEL TIPO DE OPERADOR NO ES V�LIDO')
GO



INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103135, 0, 'No existe par�metro para el canal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103136, 0, 'ERROR AL INSERTAR REGISTRO FATCA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103137, 0, 'Cuenta del Cliente Destinatario No Existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103138, 0, 'Identificaci�n y N�mero de cuenta del Cliente Destinatario no Coinciden')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103139, 0, 'Cuenta del Cliente Destinatario ya Inscrita')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (103140, 0, 'Inscripci�n de Cuenta Cancelada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105000, 1, 'Error en actualizaci�n de cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105001, 1, 'Error en actualizaci�n de seqnos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105002, 0, 'ERROR AL ACTUALIZAR LA relaci�n CB - CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105004, 1, 'Error en actualizaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105005, 1, 'Error en actualizaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105006, 1, 'Error en actualizaci�n de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105007, 1, 'Error en actualizaci�n de grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105016, 1, 'Error en actualizaci�n de actividad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105017, 1, 'Error en actualizaci�n de cargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105018, 1, 'Error en actualizaci�n de Pa�s')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105019, 1, 'Error en actualizaci�n de ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105020, 1, 'Error en actualizaci�n de tipo de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105021, 1, 'Error en actualizaci�n de estado civil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105022, 1, 'Error en actualizaci�n de estado de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105023, 1, 'Error en actualizaci�n de moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105024, 1, 'Error en actualizaci�n de posici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105025, 1, 'Error en actualizaci�n de profesi�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105026, 1, 'Error en actualizaci�n de tipo de persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105027, 1, 'Error en actualizaci�n de tipo de referencia econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105028, 1, 'Error en actualizaci�n de rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105029, 1, 'Error en actualizaci�n de tipo de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105030, 1, 'Error en actualizaci�n de tipo de tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105031, 1, 'Error en actualizaci�n de rol de empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105032, 1, 'Error en actualizaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105033, 1, 'Error en actualizaci�n de parentesco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105034, 1, 'Error en actualizaci�n de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105035, 1, 'Error en actualizaci�n de tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105036, 1, 'Error en actualizaci�n de propiedad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105037, 1, 'Error en actualizaci�n de regi�n operativa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105038, 1, 'Error en actualizaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105039, 1, 'Error en actualizaci�n de barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105040, 1, 'Error en actualizaci�n de regi�n natural')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105041, 1, 'Error en actualizaci�n de tipo de barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105042, 1, 'Error en actualizaci�n de empleo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105044, 1, 'Error en actualizaci�n de funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105046, 1, 'Error en actualizaci�n de referencia econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105047, 1, 'Error en actualizaci�n de apartado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105048, 1, 'Error en actualizaci�n de referencia personal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105049, 1, 'Error en actualizaci�n de oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105050, 1, 'Error en actualizaci�n de detalle de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105051, 1, 'Error en actualizaci�n de cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105052, 1, 'Error en actualizaci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105053, 1, 'Error en actualizaci�n de atributo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105054, 1, 'Error en actualizaci�n de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105055, 1, 'Error en actualizaci�n de default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105056, 1, 'Error en actualizaci�n de tabla de cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105057, 1, 'Error en actualizaci�n de atributo de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105058, 1, 'Error en actualizaci�n de Tipo de Balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105059, 1, 'Error en actualizaci�n de Tipo de Plan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105060, 1, 'Error al tomar secuencial siguiente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105061, 1, 'Error al insertar mala referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105062, 1, 'Error al eliminar mala referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105063, 1, 'Error en actualizaci�n de subsector')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105064, 1, 'Error en actualizaci�n de sucursal de correo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105065, 1, 'No puede deshacer grupo desde esta aplicaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105066, 1, 'Error en actualizaci�n de persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105067, 1, 'Error en actualizaci�n de referencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105068, 1, 'Error en actualizaci�n de sociedad de hecho')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105069, 1, 'Error en actualizaci�n de estados financieros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105070, 1, 'Error en actualizaci�n de cuentas de balances')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105071, 1, 'Error en actualizaci�n de compan�as en liquidaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105072, 1, 'Error en actualizaci�n de contactos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105073, 1, 'Error en actualizaci�n de hijos de un cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105074, 1, 'Error en actualizaci�n de relaci�n internacional')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105075, 1, 'Error en actualizaci�n de Otros Ingresos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105076, 1, 'Error en actualizaci�n de Tabla de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105077, 1, 'Error en actualizaci�n de Atributos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105078, 1, 'Error en actualizaci�n de valores de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105079, 1, 'Error en actualizaci�n de datos de Mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105080, 0, 'Error al insertar en CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105081, 0, 'El registro NO es modificable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105082, 0, 'Error en actualizaci�n de Datos Balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105083, 0, 'Error en creaci�n de cat�logo Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105084, 0, 'Error en actualizaci�n de cat�logo Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105085, 0, 'Error en eliminacion de cat�logo Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105086, 0, 'No existe cat�logo Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105087, 0, 'Error en creaci�n de Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105088, 0, 'Error en actualizaci�n de Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105089, 0, 'Error en Eliminaci�n de Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105090, 0, 'No existe Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105091, 0, 'Error ya existe Servicio de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105092, 0, 'Error en inserci�n del Cobro de Banca Domiciliaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105093, 0, 'Error en Eliminaci�n Cliente con registros contables')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105094, 0, 'ERROR,  SUBTIPO O BANCA NO CORRESPONDEN A MERCADO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105095, 0, 'Error en actualizaci�n de Banca')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105101, 1, 'Error en creaci�n de Rango de Tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105102, 1, 'Error en actualizaci�n de Rango de Tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105103, 1, 'Error en Eliminaci�n de Rango de Tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105104, 1, 'Error en b�squeda de Rangos de Tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105106, 1, 'Error en creaci�n de transacci�n de Servicio para Rango de Tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105107, 1, 'Error en creaci�n de Rango de Actividad econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105108, 1, 'Error en actualizaci�n de Rango de Actividad econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105109, 1, 'Error en Eliminaci�n de Rango de Actividad econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105110, 1, 'Error en b�squeda de Rangos de Actividad econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105112, 1, 'Error en creaci�n de transacci�n de Servicio para Rango de Act. econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105113, 1, 'Error en creaci�n de Alerta.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105114, 1, 'Error en actualizaci�n Alerta.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105115, 1, 'Error en Eliminaci�n de Alerta.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105116, 1, 'Error en b�squeda de Alertas.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105117, 1, 'No existe tipo de Empleo.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105118, 1, 'No existe tipo de Actividad econ�mica.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105119, 1, 'No existe Ente con Alerta.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105120, 1, 'No existe Tipo de Alerta.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105121, 1, 'No existe Tipo de transacci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105122, 1, 'Error en creaci�n de transacci�n de Servicio para Alertas.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105123, 1, 'No existe el Producto COBIS.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105124, 1, 'No existe Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105125, 1, 'Error en creaci�n de Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105126, 1, 'Error en actualizaci�n de Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105127, 1, 'Error en Eliminaci�n de Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105128, 1, 'Error en b�squeda de Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105129, 1, 'Error en creaci�n de transacci�n de Servicio para Forma Homologa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105130, 1, 'El Cliente Posee Tarjeta de Identidad y es Mayor de Edad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105131, 1, 'ERROR EN actualizaci�n cob_externos..ex_ente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105132, 1, 'ERROR EN LA inserci�n cobis..cl_instancia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105133, 1, 'ERROR EN LA inserci�n cobis..cl_ente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105134, 1, 'ERROR EN LA Eliminaci�n cob_externos..ex_ente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105135, 1, 'ERROR No existe par�metro OPD Oficial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105136, 1, 'ERROR No existe Actividad Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105137, 1, 'ERROR No existe Pa�s Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105138, 1, 'ERROR No existe Tipo de Compa±ia Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105139, 1, 'ERROR No existe Sector econ�mico Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105140, 1, 'ERROR No existe Tipo Sociedad Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105141, 1, 'ERROR No existe Ciudad Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105142, 1, 'ERROR No existe profesi�n Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105143, 1, 'ERROR No existe Tipo de vivienda Default para la oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105144, 1, 'ERROR No existe oficina default para tipo de cliente beneficiarios')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105145, 1, 'ERROR sp_invoca_masivo_cliext - No hay data cargada para procesar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105146, 1, 'ERROR sp_invoca_masivo_cliext el valor del subtipo de cliente es obligatorio, no se proceso ningun registro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105501, 0, 'Ya Existe Categor�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105502, 0, 'No Existe Categor�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105503, 0, 'Error en actualizaci�n de Categor�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105504, 0, 'No Corresponde c�digo de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105505, 0, 'Error en creaci�n de Categor�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105506, 0, 'No Existen Registros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105507, 1, 'Este rol no esta autorizado para realizar la operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105508, 1, 'Error en inserci�n de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105509, 1, 'Error en actualizaci�n de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105510, 1, 'Error en Eliminaci�n de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105511, 1, 'Error en b�squeda de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105512, 1, 'Error en Consulta de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105513, 1, 'Error en transacci�n de Origen de Fondos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105514, 0, 'Error en actualizaci�n de Registros Modificados por Central de Riesgo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105520, 0, 'Error en creaci�n del Proveedor en las estructuras de Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105521, 0, 'No Existe Proveedor en la Base de Clientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105522, 0, 'Error Borrando Tabla de Clientes Proveedores Interfaz Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105523, 0, 'Error identificaci�n Nula Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105524, 0, 'Error Nombre Largo Nulo Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105525, 0, 'Error Nombre Nulo Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105526, 0, 'Error No Existe direcci�n Marcada Como Principal Para Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105527, 0, 'Error No Existe Ciudad asociada a direcci�n Principal Para Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105528, 0, 'Error No Existe Departamento asociado a direcci�n Principal Para Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105529, 0, 'Error Descripci�n Perfil Tributario Nulo Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105530, 0, 'Error Tipo de compan�a Nula Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105531, 0, 'Error Tipo de Documento de identificaci�n Nulo Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (105532, 0, 'Error Actividad econ�mica Nula Proveedor Interface Dynamics')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107000, 1, 'Error en Eliminaci�n de prospecto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107001, 1, 'Error en Eliminaci�n de cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107002, 1, 'Error en Eliminaci�n de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107003, 1, 'Error en Eliminaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107004, 1, 'Error en Eliminaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107006, 1, 'Error en Eliminaci�n de grupo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107007, 1, 'Error en Eliminaci�n de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107015, 1, 'Error en Eliminaci�n de cat�logo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107016, 1, 'Error en Eliminaci�n de actividad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107017, 1, 'Error en Eliminaci�n de cargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107018, 1, 'Error en Eliminaci�n de Pa�s')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107019, 1, 'Error en Eliminaci�n de ciudad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107020, 1, 'Error en Eliminaci�n de tipo de compan�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107021, 1, 'Error en Eliminaci�n de estado civil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107022, 1, 'Error en Eliminaci�n de estado de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107023, 1, 'Error en Eliminaci�n de moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107024, 1, 'Error en Eliminaci�n de posici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107025, 1, 'Error en Eliminaci�n de profesi�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107026, 1, 'Error en Eliminaci�n de tipo de persona')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107027, 1, 'Error en Eliminaci�n de tipo de referencia econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107028, 1, 'Error en Eliminaci�n de rol')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107029, 1, 'Error en Eliminaci�n de tipo de direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107030, 1, 'Error en Eliminaci�n de tipo de tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107031, 1, 'Error en Eliminaci�n de rol de empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107032, 1, 'Error en Eliminaci�n de producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107033, 1, 'Error en Eliminaci�n de parentesco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107034, 1, 'Error en Eliminaci�n de dis_seqnos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107035, 1, 'Error en Eliminaci�n de distributivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107036, 1, 'Error en Eliminaci�n de filial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107037, 1, 'Error en Eliminaci�n de producto asociado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107038, 1, 'Error en Eliminaci�n de tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107039, 1, 'Error en Eliminaci�n de propiedad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107040, 1, 'Error en Eliminaci�n de regi�n operativa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107041, 1, 'Error en Eliminaci�n de barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107042, 1, 'Error en Eliminaci�n de regi�n natural')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107043, 1, 'Error en Eliminaci�n de departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107044, 1, 'Error en Eliminaci�n de referencia econ�mica')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107045, 1, 'Error en Eliminaci�n de empleo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107046, 1, 'Error en Eliminaci�n de funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107047, 1, 'Error en Eliminaci�n de apartado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107048, 1, 'Error en Eliminaci�n de referencia personal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107049, 1, 'Error en Eliminaci�n de oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107050, 1, 'Error en Eliminaci�n de pro-oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107051, 1, 'Error en Eliminaci�n de pro-moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107052, 1, 'Error en Eliminaci�n de default de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107053, 1, 'Error en Eliminaci�n de cat�logo-producto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107054, 1, 'Error en Eliminaci�n de instancia de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107055, 1, 'Error en Eliminaci�n de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107056, 1, 'Error en Eliminaci�n de atributo de relaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107057, 1, 'Error en Eliminaci�n de Tipo de Balance')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107058, 1, 'Error en Eliminaci�n de Tipo de Plan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107059, 1, 'Error en Eliminaci�n de Barrio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107060, 1, 'Error en Eliminaci�n de sucursal de correo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107061, 1, 'Error en Eliminaci�n de estatutos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107062, 1, 'Error en Eliminaci�n de objeto social')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107063, 1, 'Error en Eliminaci�n de sociedad de hecho')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107064, 1, 'Error en Eliminaci�n de estados financieros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107065, 1, 'Error en Eliminaci�n de cuentas de estados financieros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107066, 1, 'Error en Eliminaci�n de cuentas de balances')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107067, 1, 'Error en Eliminaci�n de compan�as en liquidaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107068, 1, 'Error en Eliminaci�n de contacto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107069, 1, 'Error en Eliminaci�n de un hijo de l cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107070, 1, 'Error en Eliminaci�n de relaci�n internacional de un cliente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107071, 1, 'Error en Eliminaci�n de tablas de mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107072, 1, 'Error en Eliminaci�n de campos de mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107073, 1, 'Error en Eliminaci�n de valores de mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107074, 1, 'Error en Eliminaci�n de datos de mercadeo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107075, 1, 'La fecha de Apertura es menor a la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107076, 1, 'La fecha de Avaluo es menor a la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107077, 1, 'La fecha de Escritura es menor a la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107078, 1, 'La fecha de Patrimonio Bruto es menor a la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107079, 1, 'La fecha de Corte es menor a la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107080, 1, 'La fecha de Apertura es menor a la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107081, 1, 'La fecha desde de la relaci�n, es menor a la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107082, 1, 'El tel�fono ya esta asociado a esta direcci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107083, 1, 'La fecha de Expedici�n es menor que la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107084, 1, 'La fecha de Expedici�n es menor que la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107085, 1, 'La fecha de Inicio es menor que la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107086, 1, 'La fecha de Inicio es menor que la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107087, 1, 'La fecha de Ingreso es menor que la fecha de nacimiento.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107088, 1, 'El cliente ya tiene conyuge asociado.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107089, 1, 'La fecha Negocios desde no puede ser menor que fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107090, 1, 'La fecha Negocios desde no puede ser menor que la fecha constituci�n de la empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107091, 1, 'La fecha referencia no puede ser menor que la fecha nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107092, 1, 'La fecha referencia no puede ser menor que la fecha constituci�n de empresa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107093, 1, 'La fecha corte no puede ser menor que la fecha de nacimiento del cliente.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107094, 1, 'La fecha de avaluo es menor a la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107095, 1, 'La fecha de Escritura es menor a la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107096, 1, 'La fecha desde es menor a la fecha de constituci�n de la empresa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107097, 0, 'Error al eliminar en CIFIN')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107098, 1, 'Este archivo ya fue cargado anteriormente. Revise la lista de archivos cargados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107099, 1, 'Error en el Manejo del Cursor Asignado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107100, 1, 'Error en la inserci�n del ente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107101, 1, 'La carga de datos tuvo errores. No se puede aplicar entes.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107102, 1, 'La Sumatoria de Porcentajes, Excede el 100.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107103, 1, 'Error en la inserci�n del Mercado Objetivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107104, 0, 'ERROR AL ELIMINAR LA relaci�n CB - CLIENTE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107106, 0, 'Representante Legal sin direcci�n y/o tel�fono')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107107, 1, 'Ente Juridico sin Representante Legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107108, 0, 'Error en Eliminaci�n de Area de Influencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107109, 1, 'El tel�fono ya est� asociado a una direcci�n.')
GO

INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
VALUES (107126, 0, 'No se pueden eliminar todos los n�meros telef�nicos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107200, 0, 'Tipo y numero de documento son obligatorios para el registro de una orden externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107201, 0, 'Error en inserci�n de la orden de consulta externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107202, 0, 'Error en inserci�n de proceso en cola de ejecuci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107203, 0, 'Trama XML no puede ser nula')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107204, 0, 'Error en paso a hist�ricos de informacion externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107205, 0, 'Error en Eliminaci�n de informacion externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107206, 0, 'Error en inserci�n de informacion externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107207, 0, 'Error en actualizaci�n de la orden de consulta externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107208, 0, 'No existe equivalencia externa para el tipo de documento ingresado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107209, 0, 'Error en inserci�n masiva de procesos en cola de ejecuci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107210, 0, 'Error en actualizaci�n masiva de ordenes de consulta externa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107211, 0, 'N�mero de tramite es obligatorio para el registro de una orden externa MIR')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107212, 0, 'Error en inserci�n en temporal de accionistas para validaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107213, 0, 'Error en inserci�n en temporal de representante legal para validaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107214, 0, 'Error en borrado de accionistas de menor porcentaje por maximo superado para validaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (107252, 0, 'No se puede eliminar. EL cliente debe tener al menos una direcci�n principal')
GO


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108000, 1, 'ERROR EN inserci�n EN BA_LOG_OPERADOR')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108001, 0, 'NO EXISTE OPERADOR AUTORIZADO!')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108002, 0, 'operaci�n INEXISTENTE!')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108003, 1, 'ERROR AL INSERTAR NEGOCIO DEL CLIENTE!')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108004, 1, 'ERROR AL ACTUALIZAR NEGOCIO DEL CLIENTE!')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108005, 1, 'ERROR AL ELIMINAR NEGOCIO DEL CLIENTE!')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108006, 0, 'NO EXISTE NEGOCIO DEL CLIENTE!')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141000, 0, 'Error en estado de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141001, 0, 'No se autoriza el pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141002, 0, 'transacci�n no corresponde a este servidor')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141003, 0, 'No existe Cuenta para oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141004, 0, 'operaci�n No Existe o no se ha reversado en la caja')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141005, 0, 'operaci�n no esta vigente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141006, 0, 'c�digo de oficina en operaci�n no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141007, 0, 'operaci�n bloqueada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141008, 0, 'No existe tipo de operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141009, 1, 'No existe informacion en cb_par�metro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141010, 0, 'operaci�n no bloqueada contra el tipo de bloqueo ingresado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141011, 0, 'Valor del MONTO no puede ser cero o menor que cero')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141012, 0, 'Datos inconsistentes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141013, 0, 'Moneda no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141014, 0, 'operaci�n con fondos en retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141015, 0, 'No existe tipo de bloqueo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141016, 0, 'Vcmto debe ser mayor a fecha actual')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141017, 0, 'Error en el Sistema de Administraci�n:  no existen servidores')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141018, 0, 'Error en c�digo de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141019, 0, 'Tipo de bloqueo no ha sido levantado previamente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141020, 0, 'No existe tipo de default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141021, 0, 'Error en tabla de fechas promedio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141022, 0, 'No existe servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141023, 0, 'Error en tabla de personalizacion default')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141024, 0, 'Error en tabla de personalizacion contratada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141025, 0, 'Error en longitud de oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141026, 0, 'Error en longitud de secuencial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141027, 0, 'Error en c�lculo del m�dulo del digito verificador')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141028, 0, 'El titular es menor de edad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141029, 0, 'operaci�n de Gerencia, Emisor debe ser el Banco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141030, 0, 'No hay m�s registros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141031, 0, 'operaci�n No Activa o Cancelada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141032, 0, 'No Existe Departamento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141033, 0, 'No Existe Banco')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141034, 0, 'Error en el Modo de la transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141035, 0, 'No Existe Oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141036, 0, 'No Existen m�s registros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141037, 0, 'Valor debe ser mayor a cero')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141038, 0, 'No existe casilla')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141039, 0, 'c�digo de transacci�n para DELETE No V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141040, 0, 'c�digo de transacci�n No V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141041, 0, 'Tipo de plazo a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141042, 0, 'c�digo de pago a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141043, 0, 'Tipo de monto a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141044, 0, 'No existe Beneficiario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141045, 0, 'Beneficiario ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141046, 0, 'No existe Casilla')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141047, 0, 'No existe Cuenta Corriente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141048, 0, 'No existe Cuenta de Ahorros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141049, 0, 'No existe direcci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141050, 0, 'No existe Ente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141051, 0, 'No existe operaci�n de Plazo Fijo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141052, 0, 'Producto No existe o No V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141053, 0, 'No existe tipo de monto. Monto no V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141054, 0, 'No existe tipo de plazo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141055, 0, 'No existe la tasa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141056, 0, 'No existe la renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141057, 0, 'No existe el cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141058, 0, 'Funcionario no relacionado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141059, 0, 'No existe cl_capitalizacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141060, 0, 'Beneficiario no se puede eliminar porque es titular')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141061, 0, 'renovaci�n ya Existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141062, 0, 'No Existe Forma de Pago/Recepci�n o est� eliminado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141063, 0, 'operaci�n de plazo fijo no posee cheques asociados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141064, 0, 'No Existe retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141065, 0, 'No Existe la pignoracion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141066, 0, 'No Existe el pr�stamo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141067, 0, 'Total a pignorar excede el Monto de la operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141068, 0, 'dep�sito se encuentra Pignorado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141069, 0, 'Monto a bloquear mayor que monto del plazo fijo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141070, 0, 'No existe Categor�a de dep�sitos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141071, 0, 'No existe periodicidad de pagos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141072, 0, 'Periodicidad de pagos no puede ser nula en pagos Peri�dicos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141073, 0, 'Rango No es V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141074, 0, 'Ya Existe la Tasa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141075, 0, 'No Existe Movimiento Monetario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141076, 0, 'No Existe Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141077, 0, 'No Existe Detalle de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141078, 0, 'Condici�n Ya Existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141079, 0, 'Detalle de Condici�n Ya Existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141080, 1, 'No se pudo insertar cabecera')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141081, 1, 'D�bitos y Cr�ditos no concuerdan')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141082, 1, 'Error al obtener clave de conta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141083, 0, 'transacci�n no acepta montos menores que Cero')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141084, 0, 'Movimiento Monetario ya fue aplicado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141085, 0, 'Movimiento Monetario incompleto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141086, 1, 'No se pudo inserta asiento contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141087, 0, 'Movimiento Monetario ya Ha sido Reversado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141088, 0, 'Monto a Debitar excede los Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141089, 0, 'dep�sito tiene intereses pagados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141090, 0, 'No existe dep�sito o no tiene estado de INGresado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141091, 0, 'c�digo de transacci�n para HELP No V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141092, 0, 'No Existe TRAN_PRODUCTO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141093, 0, 'operaci�n No tiene estado Por cancelar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141094, 0, 'Existen Movimientos de cancelacion Aplicados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141095, 0, 'No Existe Emisi�n de Cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141096, 0, 'Cheque ha sido Emitido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141097, 0, 'Dep�sito No acepta Modif. de Capitalizacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141098, 0, 'Dep�sito No acepta Nueva Forma De Pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141099, 0, 'Dep�sito No acepta Nueva Periocidad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141100, 0, 'Dep�sito No acepta Nueva Fecha de Pagode Int.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141101, 0, 'Capitalizaciones Peri�dicas Se aceptan solo en Apertura y renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141102, 0, 'Dep�sito No Acepta Cambio de D�a de Pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141103, 0, 'No Existe Cotizaci�n para Moneda')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141104, 0, 'No Existe TRAN_CONTABLE')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141105, 0, 'Existen Tipos/Dep�sitos relacionados con el plazo a eliminar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141106, 0, 'Existen Tipos/Dep�sitos relacionados con el monto a eliminar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141107, 0, 'Monto a Debitar excede Provisi�n de Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141108, 0, 'Suma de Los Montos difiere de Incremento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141109, 0, 'Dep�sito con Capitalizaci�n no acepta pago de Intereses Anticipados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141110, 0, 'Forma de Pago/Recepci�n a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141111, 0, 'No existe Forma de Pago/Recepci�n o esta eliminada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141112, 0, 'operaci�n o transacci�n no permitida')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141113, 0, 'Autorizaci�n para el funcionario a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141114, 0, 'Autorizaci�n para el funcionario no existe o est� eliminado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141115, 0, 'Tipo de Dep�sito no existe o esta deshabilitado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141116, 0, 'Tipo de Dep�sito a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141117, 0, 'Tipo de Dep�sito se encuentra en tablas relacionadas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141118, 0, 'Limite de negociaci�n a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141119, 0, 'Limite de negociaci�n no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141120, 0, 'Auxiliar de tipo de Dep�sito a crear ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141121, 0, 'Auxliar de tipo de Dep�sito no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141122, 0, 'Limite no autorizado para funcionario u oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141123, 0, 'No existe esa moneda para tipo de Dep�sito ingresado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141124, 0, 'Monto no est� dentro de uno definido para el tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141125, 0, 'Plazo no est� dentro de uno definido para el tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141126, 0, 'No hay tasa definida para tipo de Dep�sito, plazo y monto ingresados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141127, 0, 'No existe funcionario ingresado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141128, 0, 'No existe el Registro monetario asociado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141129, 0, 'El valor del detalle de los cheques excede el valor del mov. monetario asociado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141130, 0, 'El Beneficiario no existe asociado al Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141131, 0, 'Dep�sito ya tiene una accion a seguir')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141132, 0, 'No existe cancelaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141133, 0, 'Estado no V�LIDO para reverso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141134, 0, 'Funcionario no tiene Autorizaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141135, 0, 'Ya existe cancelaci�n asociada al Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141136, 0, 'Moneda no est� registrada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141137, 0, 'Debe ingresar Autorizaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141138, 0, 'renovaci�n no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141139, 1, 'renovaci�n ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141140, 0, 'No existe dato en par�metro')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141141, 0, 'Tiempo de reverso ha pasado el l�mite')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141142, 0, 'No existe cuenta relacionada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141143, 0, 'No existe oficina relacionada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141144, 0, 'No hay disponible en la cuenta')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141145, 1, 'No existe par�metro en cb_relparam')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141146, 1, 'Comprobante en compra/venta afecta ME')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141147, 1, 'N�mero de detalles no coincide ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141148, 0, 'No se puede eliminar porque existe stock')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141149, 0, 'No se puede realizar la operaci�n porque mantiene inventario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141150, 0, 'No se puede realizar esta transacci�n sobre la operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141151, 0, 'N�mero de preimpreso ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141152, 0, 'transacci�n no permitida. Se han ingresado valores en caja, deben reversarse')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141153, 0, 'Recuerde depositar los fondos en caja')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141154, 0, 'transacci�n no permitida. La fecha de activacion sobrepasa un D�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141155, 0, 'Error en ejecuci�n de sp_retiene_capital: cliente u operaci�n no existen')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141156, 0, 'Error en c�digo de cuenta contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141157, 0, 'transacci�n no permitida. operaci�n fue reversada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141158, 0, 'transacci�n no permitida. No se encuentra registro de operaci�n anterior cancelada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141159, 0, 'No Existe Valor de Tasa Variable. Comunicar al Modulo Responsable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141160, 0, 'transacci�n no permitida para este tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141161, 0, 'No existe informaci�n de cup�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141162, 0, 'No se puede reversar esta operaci�n, valores fueron aplicados en caja o cuentas corrientes/ahorros')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141163, 0, 'No se puede cancelar cup�n, se encuentra retenido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141164, 1, 'Error en estado de cup�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141165, 1, 'Error en b�squeda de tasa de retenci�n de impuestos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141166, 1, 'Error en reverso de cheques de gerencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141167, 1, 'Consuta de tasas inv�lida, tipo transacci�n no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141168, 1, 'Error al enviar la informaci�n a Servicios Bancarios')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141169, 1, 'Forma de pago no v�lida para Branch')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141170, 1, 'No se encuentra comprobante contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141171, 1, 'No se puede registrar garant�a ya que el Dep�sito se encuentra retenido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141172, 1, 'El dep�sito ya fue aprobado por el gerente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141173, 1, 'El usuario que quiere anular el DPF no es el mismo que realiz� la apertura')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141174, 1, 'Error al obtener el secuencial del n�mero preimpreso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141175, 1, 'Fecha Valor no se encuentra dentro per�odo Anio Fiscal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141176, 1, 'Bloqueo Legal no existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141177, 0, 'transacci�n no permitida. Cliente Cifrado entre propietarios.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141178, 0, 'transacci�n no permitida. Menor de Edad entre propietarios.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141179, 0, 'operaci�n esta pignorada. No se puede ingresar un propietario, menor de edad.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141180, 0, 'transacci�n no permitida.  No se ha aprobado el Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141181, 1, 'El estado de la operaci�n ha cambiado fuera de la pantalla actual')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141182, 0, 'No existen Autorizaciones pendientes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141183, 0, 'No existe la operaci�n de cartera')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141184, 0, 'No existe la tarjeta de cr�dito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141185, 0, 'La autorizaci�n ya fue utilizada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141186, 0, 'Ya existe una autorizaci�n para esta operaci�n en esta fecha')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141187, 1, 'Error en la actualizaci�n de la Autorizaci�n de spread')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141188, 0, 'No se encuentra area contable para tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141189, 0, 'La cuenta se encuentra bloqueada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141190, 0, 'No puede realizar Inc/Dis con fecha menor a la fecha de �ltimo pago de intereses o APERTURA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141191, 0, 'No est� permitida la transacci�n porque el Dep�sito posee una instrucci�n de cancelaci�n/renovaci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141194, 0, 'Monto a incrementar no corresponde a recibido en caja')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141195, 1, 'No existen registros que cumplan las Condiciones dadas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141196, 0, 'Se han aplicado movimientos monetarios antes de fecha valor')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141197, 0, 'No existen cheques devueltos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141198, 0, 'La operaci�n tuvo un incremento/disminuci�n previo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141199, 0, 'No existe la frecuencia de pago ingresada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141200, 0, 'transacci�n no permitida. La operaci�n tiene Bloqueo legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141201, 0, 'No puede cambiar la fecha valor porque realizo pago de intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141202, 0, 'No puede cambiar la fecha valor el Dep�sito esta vencido')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141203, 1, 'No existe informaci�n de la operaci�n en la tabla temporal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141204, 0, 'transacci�n no permitida. Reverso solo se permite el mismo D�a de transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141205, 0, 'No puede cambiar la fecha valor porque realizo pago de intereses anticipados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141206, 0, 'No puede cambiar la fecha valor, el Dep�sito tiene intereses pagados')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141207, 1, 'No se han definido D�as de inactivaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141208, 0, 'No existen �rdenes de pago a reversar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141209, 0, 'transacci�n no permitida. Renovaci�n ejecutada por el batch')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141210, 0, 'transacci�n no permitida. el DPF no tiene renovaciones para reversar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141211, 0, 'Transaccio no permitida. el DPF no tiene instrucciones de renovaci�n para eliminar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141212, 0, 'Tipo de Dep�sito descontinuado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141213, 0, 'La fecha de proceso es menor a la fecha valor del DPF')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141214, 0, 'No existe la operaci�n de Comercio Exterior')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141215, 0, 'No existe la operaci�n de garant�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141216, 1, 'Dep�sitos con Vuelto no pueden volver a Activarse')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141217, 0, 'Valores de Incremento en Suspenso ingresado en instrucci�n no han pasado por Caja')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141218, 0, 'No existen pagos para esta operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141219, 0, 'No se permite bloqueo legal porque el dpf pertene a un fideicomiso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141220, 0, 'No se ha Ingresado el valor enviado por el Juzgado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141221, 0, 'No se ha Ingresado el valor que el Banco Embargara')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141222, 0, 'No se ha Ingresado Un Tipo de Bloqueo V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141223, 0, 'No se ha Ingresado la Fecha del Oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141224, 0, 'No se ha Ingresado el N�mero del Oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141225, 0, 'No se ha Ingresado la Autoridad del Oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141226, 0, 'No se ha Ingresado el Funcionario que Ingresa el Oficio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141227, 0, 'No se ha Ingresado No se ha Ingresado un motivo de Embargo V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141228, 0, 'Los Titulos Capitalizables no permiten cambiar el detalle de Pago Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141229, 0, 'El monto Real a Bloquear debe ser menor o igual que el monto disponible')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141230, 0, 'Dep�sito tiene instrucci�n de cancelaci�n o renovaci�n. Por favor Levantarla')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141231, 0, 'Dep�sito no se encuentra ni activo ni vencido. Por favor revise su estado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141232, 0, 'El propietario del t�tulo es una Fundaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141233, 0, 'Debe Ingresar una Forma de Pago de intereses al T�tulo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141234, 0, 'Esa Forma de pago de Intreses no es v�lida')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141235, 0, 'No se ha Ingresado una Descripci�n del Levantamiento legal del Embargo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141236, 0, 'No Se ha ingresado el numero de bloqueo de Embargo a Levantar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141237, 0, 'Error en la creaci�n de detalle del pago de Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141238, 0, 'Error en la creaci�n del embargo Legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141239, 0, 'Error en el Levantamineto del Embargo Legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141240, 0, 'La identificaci�n del Beneficiario no es Valida')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141241, 0, 'El Monto a Embargar debe ser menor que el Disponible a ser Embargado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141242, 0, 'El Monto a Embargar debe ser igual al Disponible a ser Embargado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141243, 0, 'No Existe par�metro De forma de Pago de Intereses despues de Levantar Embargo ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141244, 0, 'No Existe par�metro De forma de Pago de Intereses para el Embargo Legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141245, 0, 'No Existe par�metro de Componente Inflaccionario anio Gravable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141246, 1, 'Se emitio la orden de cancelaci�n con una forma de pago diferente a efectivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141247, 0, 'Monto esta dentro de uno definido para el tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141248, 0, 'Plazo esta dentro de uno definido para el tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141249, 0, 'No se ha Ingresado el N�mero del T�tulo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141250, 0, 'No se ha Ingresado el c�digo del Banco del Cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141251, 0, 'No se ha Ingresado el N�mero del Cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141252, 0, 'No se ha Ingresado el Valor del Cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141253, 0, 'No existe Emision de Cheque, N�mero de Banco o N�mero de Cheque INV�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141254, 0, 'Pagos en efectivo pendientes de reversar en Branch')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141255, 0, 'Cliente NO Objetivo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141256, 0, 'Sucursal NO se encuentra ACTIVA')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (141257, 0, 'Modulo Plazo Fijo No se encuentra en estado ACTIVO para esta oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143000, 1, 'Error en inserci�n de transacci�n monetaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143001, 1, 'Error en inserci�n de operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143002, 1, 'Error en inserci�n de anulacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143003, 1, 'Error en inserci�n de reporte')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143004, 1, 'Error en inserci�n de renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143005, 1, 'Error en inserci�n de transacci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143006, 1, 'Error en inserci�n de historial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143007, 1, 'Error en inserci�n de pignoracion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143008, 1, 'Error en inserci�n de retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143009, 1, 'Error en inserci�n de beneficiario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143010, 1, 'Error en inserci�n de tasa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143012, 1, 'Error en inserci�n de monto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143013, 1, 'Error en inserci�n de retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143014, 1, 'Error en inserci�n de plazo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143016, 1, 'Error en inserci�n de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143017, 1, 'Error en inserci�n de Detalle de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143018, 1, 'Error en inserci�n de Forma de Pago/Recepci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143019, 1, 'Error en inserci�n de mov_cont')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143020, 1, 'Error en inserci�n de transacci�n monetaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143021, 1, 'Error en inserci�n de ppago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143022, 1, 'Error en inserci�n de Movimiento Monetario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143023, 1, 'Error en inserci�n de tran_prod')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143024, 1, 'Error en inserci�n de tabla preimpresos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143028, 1, 'Error en inserci�n de Condici�nTMP')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143029, 1, 'Error en inserci�n de Detalle de Condici�nTMP')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143031, 1, 'Error en inserci�n de Emision de Cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143032, 1, 'Error en inserci�n de Movimiento Pendiente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143033, 1, 'Error en inserci�n de Autorizaci�nes por Funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143034, 1, 'Error en inserci�n de Tipos de Dep�sitos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143035, 1, 'Error en inserci�n de l�mites de negociaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143036, 1, 'Error en inserci�n de Auxiliares de tipos de Dep�sitos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143037, 1, 'Error en inserci�n de Detalle de pago temporal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143038, 1, 'Error en inserci�n de Detalle de pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143039, 1, 'Error en inserci�n de cancelaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143040, 1, 'Error en inserci�n de Autorizaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143041, 1, 'Error en inserci�n de Movimiento Contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143042, 1, 'Error en inserci�n de Movimiento Monetario con Problema')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143043, 1, 'Error en inserci�n de Detalle de lote')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143044, 0, 'Error al insertar la cotizacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143045, 1, 'Error en inserci�n de Tabla de Ticket monetario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143046, 1, 'Error en inserci�n de Tabla conversion ticket')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143047, 1, 'Error en inserci�n de Tasa Variable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143048, 1, 'Error en inserci�n de Endosos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143049, 1, 'Error en inserci�n de cupones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143050, 1, 'Error al ingresar al temporal de custoD�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143051, 1, 'Error al ingresar garant�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143052, 1, 'Error en inserci�n de temporal cliente externo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143053, 1, 'Error en inserci�n de la instrucci�n especial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143054, 1, 'Error en inserci�n de relaci�n de comprobante')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143055, 1, 'Error en inserci�n de bloqueo legal')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143056, 1, 'Error en inserci�n de cliente externo definitiva')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143057, 1, 'Error en inserci�n de hist�rico de tasas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143058, 1, 'Error en inserci�n de hist�rico de tasas variables')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143059, 1, 'Error en inserci�n de firmas autorizadas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143060, 1, 'No existe orden emitida para esta operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143061, 0, 'Error ingreso Enajenacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143062, 1, 'Error Comprobante contable esta descuadrado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143063, 0, 'Error en generacion de cuotas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143064, 0, 'Error: Total Valores Enajenados mayor a Impuesto Retenido ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (143066, 1, 'Error inserccion pf_feriados_oficina')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145000, 1, 'Error en actualizaci�n de transacci�n monetaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145001, 1, 'Error en actualizaci�n de operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145002, 1, 'Error en actualizaci�n de anulacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145003, 1, 'Error en actualizaci�n de reporte')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145004, 1, 'Error en actualizaci�n de renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145005, 1, 'Error en actualizaci�n de transacci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145006, 1, 'Error en actualizaci�n de historial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145007, 1, 'Error en actualizaci�n de pignoracion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145008, 1, 'Error en actualizaci�n de retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145009, 1, 'Error en actualizaci�n de beneficiario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145010, 1, 'Error en actualizaci�n de tasa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145012, 1, 'Error en actualizaci�n de monto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145014, 1, 'Error en actualizaci�n de plazo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145015, 1, 'Error en actualizaci�n de conversi�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145016, 1, 'Error en actualizaci�n de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145018, 1, 'Error en actualizaci�n de Forma de Pago/Recepci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145019, 1, 'Error en actualizaci�n de mov_cont')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145020, 1, 'Error en actualizaci�n de mov_monet')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145021, 1, 'Error en actualizaci�n de ppago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145023, 1, 'Error en actualizaci�n de tran prod')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145031, 1, 'Error en actualizaci�n de Orden de Pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145034, 1, 'Error en actualizaci�n de tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145035, 1, 'Error en actualizaci�n de l�mite de negociaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145036, 1, 'Error en actualizaci�n de cancelaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145037, 1, 'Error en actualizaci�n de Detalle de pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145038, 1, 'Error en actualizaci�n de Detalle de RCondici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145039, 1, 'Error en actualizaci�n de pf_mov_cont')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145040, 1, 'Error en actualizaci�n de Detalle del lote')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145041, 1, 'Error en actualizaci�n de conversion ticket')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145042, 1, 'Error en actualizaci�n de secuencial ticket')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145043, 1, 'Error en actualizaci�n de cupones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145044, 0, 'Error al actualizar la cotizacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145045, 1, 'Error en actualizaci�n de instrucciones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145046, 1, 'Error en actualizaci�n de emision cheque')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145047, 1, 'Error en actualizaci�n de relaci�n de comprobantes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145048, 1, 'Error en actualizaci�n de comprobante contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145049, 1, 'Error en actualizaci�n de estado de fusion-fraccionamiento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145050, 1, ' Error en actualizaci�n de hist�rico de tasas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145051, 1, ' Error en actualizaci�n de hist�rico de tasas variables')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145052, 1, ' Error en rec�lculo de cuotas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145053, 1, 'Error en actualizaci�n de primera cuota')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145054, 1, 'Error en actualizaci�n de ultima cuota')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145055, 1, 'Error en actualizaci�n de Movimiento Monetario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145056, 1, 'Error en actualizaci�n de la instrucci�n especial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145057, 1, 'Error en actualizaci�n de Detalle de pago incremento renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145058, 1, 'Error en actualizaci�n secuencial ticket incremento renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (145115, 1, 'No Existe informaci�n en conversion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147000, 1, 'Error en Eliminaci�n de transacci�n monetaria')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147001, 1, 'Error en Eliminaci�n de operaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147002, 1, 'Error en Eliminaci�n de anulacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147003, 1, 'Error en Eliminaci�n de reporte')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147004, 1, 'Error en Eliminaci�n de renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147005, 1, 'Error en Eliminaci�n de transacci�n de servicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147006, 1, 'Error en Eliminaci�n de historial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147007, 1, 'Error en Eliminaci�n de pignoracion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147008, 1, 'Error en Eliminaci�n de retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147009, 1, 'Error en Eliminaci�n de beneficiario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147010, 1, 'Error en Eliminaci�n de tasa')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147012, 1, 'Error en Eliminaci�n de monto')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147013, 1, 'Error en Eliminaci�n de retenci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147014, 1, 'Error en Eliminaci�n de plazo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147016, 1, 'Error en Eliminaci�n de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147017, 1, 'Error en Eliminaci�n de Detalle de Condici�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147018, 1, 'Error en Eliminaci�n de Formas de Pago/Recepci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147020, 1, 'Error en Eliminaci�n de Movimiento Monetario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147021, 1, 'Error en Eliminaci�n de ppago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147023, 1, 'Error en Eliminaci�n de tran_prod')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147032, 1, 'Error en Eliminaci�n de Movimiento Pendiente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147033, 1, 'Error en Eliminaci�n de Autorizaci�n por Funcionario')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147034, 1, 'Error en Eliminaci�n de tipo de Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147035, 1, 'Error en Eliminaci�n de l�mite de negociaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147036, 1, 'Error en Eliminaci�n de Auxiliares de tipos de Dep�sitos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147038, 1, 'Error en Eliminaci�n de Detalle de pagos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147039, 1, 'Error en Eliminaci�n de Movimientos Monetarios con Problemas ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147040, 1, 'Error al eliminar la cotizaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147041, 1, 'Error al eliminar orden de pago')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147042, 1, 'Error al eliminar cupones')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147043, 1, 'Error al eliminar del temporal de custodia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (147044, 1, 'Error al eliminar instrucci�n especial')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149001, 1, 'La Suma de los Montos retenidos difiere del Monto bloq.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149002, 1, 'Error al Emitir Capitalizacion')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149003, 1, 'Error al Emitir Pago a Cuenta de Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149004, 1, 'Error al Emitir Pago Int. a Cuenta de Benef.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149005, 1, 'La Suma de porcentajes de Benef. difiere del 100%')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149006, 1, 'operaci�n Pignorada No se Puede Cancelar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149007, 1, 'operaci�n Bloqueada No se Puede Cancelar')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149008, 1, 'Error al Emitir Pago de cancelaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149009, 1, 'La Suma de los Montos a Cancelar difiere del Total')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149010, 1, 'Error al Emitir Nota Deb. Cred. en renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149011, 1, 'La Suma de los Montos en renovaci�n difiere del Total')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149012, 1, 'Error en nota C/D hacia cuentas de inversion.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149013, 1, 'Error en nota C/D hacia cuentas corrientes.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149014, 1, 'Error en nota C/D hacia Plazo Fijo')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149015, 0, 'Error Proceso Pago de Intereses')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149016, 1, 'Error Proceso de cancelaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149017, 0, 'Error Proceso renovaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149018, 1, 'Error al Emitir Nota Deb. Cred. en Apertura')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149019, 1, 'La Suma de los Montos en Apertura difiere del Total')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149020, 1, 'La Suma de los Porcentajes en Apertura difiere de 100')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149021, 1, 'transacci�n-Producto No definida')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149022, 1, 'Error en proceso de aplicaci�n de movimiento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149023, 1, 'Error en proceso de c�lculo de Intereses D�arios')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149024, 0, 'P I D: fecha de fin de D�a diferente de inicio')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149025, 0, 'P I D: fecha de inicio mayor que fecha actual')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149026, 0, 'P I D: fecha de fin D�a mayor que fecha actual')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149027, 0, 'P F D: fecha de inicio diferente de fecha proceso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149028, 0, 'P F D: fecha final mayor o igual al proceso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149029, 0, 'P F D: proceso inicio de D�a no se ha ejecutado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149030, 1, 'Error En Emision de Cheque de Gerencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149031, 1, 'Error En aplicaci�n de Mov. Pendiente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149032, 0, 'P CONT: Error al Aplicar Contabilidad')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149033, 0, 'P CONT: Error al Crear Cabecera Contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149034, 0, 'P CONT: Error al Crear Asiento Contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149035, 0, 'P CONT: Diferencias En los Totales')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149036, 0, 'P CONT: Diferencias En el N�mero de Asientos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149037, 0, 'P CONT: Error al Crear Comprobante Contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149038, 0, 'P CONT: fecha de final de D�a diferente de fecha proceso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149039, 0, 'P CONT: Proceso Ya fue Realizado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149040, 0, 'P CONT: Error En proceso Contable')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149041, 0, 'P REN AUT: Error al Aplicar renovaci�n Negociada, Esta ha de ser anulada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149042, 1, 'P INC: Suma de Montos Monetarios Difiere de Incremento')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149043, 1, 'P INC: Fecha proxima estimada difiere de la Existente')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149044, 1, 'P I D: Error al Aplicar Incremento de Capital')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149045, 1, 'P I P: Fecha No es Fin De Mes')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149046, 1, 'P I P: Proceso de Fin de D�a Ya fue Ejecutado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149047, 1, 'P I P: Proceso de Inicio de D�a Ya fue Ejecutado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149048, 1, 'P I P: Proceso Contable Ya fue Ejecutado')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149049, 0, 'P I P: Error al realizar Fin D�a')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149050, 0, 'No existe perfil contable definido para la transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149051, 0, 'No existe la cotizaci�n especifica deseada ')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149052, 1, 'Periodo de pago no es V�LIDO')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149053, 0, 'TIENE OPERACI�NES PENDIENTES')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149054, 0, 'MIEMBRO A MODIFICAR ES PARTE DE UNA DIRECTIVA EXISTENTE MODIFIQUE LOS MIEMBROS')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149055, 0, 'ES TITULAR DE LA CUENTA GRUPAL')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149056, 0, 'NO SE PUEDE MODIFICAR EL COMITE, TIENE UN TRAMITE EN CURSO')
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149058, 1, 'Relaci�n de transacci�n con perfil contable ya existe')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149064, 1, 'No existe informaci�n en cb_det_perfil')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149065, 1, 'Error en inserci�n de Autorizaci�n de spread')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149066, 0, 'El valor de la disminuci�n es mayor al monto disponible del Dep�sito')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149078, 0, 'Error no encontro c�digo de perfil definido para la transacci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149079, 0, 'Error al realizar batch de generacion de cheques de gerencia')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149080, 0, 'Este tipo de Dep�sito no permite cambios de tasa.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149081, 1, 'El documento ya tiene este estado de custoD�a.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149082, 1, 'El estado en custodia no permite esta transacci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149083, 1, 'El Dep�sito no tiene saldo disponible para retenci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149084, 1, 'Autorizaci�n: Usuario y Clave incorrecto.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149085, 1, 'Autorizaci�n: El usuario no tiene rol para esta transacci�n.')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149086, 1, 'No se logra ejecutar de manera correcta el proceso de posici�n de divisas')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149087, 1, 'Error al actualizar m�dulo de garant�as')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149088, 1, 'Error al borrar tabla movimientos de compensaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (149089, 1, 'Error al borrar tabla movimientos de compensaci�n')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (901018, 0, 'Pa�s Emisor no existe')
GO

----------------- Script Loand Group ----------------------

delete from cl_errores 
where numero in (208901, 208902, 208903, 208904, 208905, 208906, 208907,208908, 208909,208910,208911, 208912, 208913, 208914, 208915,208916,208917,208918,208919,208920,208921,208922,208923,208925,208926,208933, 208934, 208935,208937,
208938,208939,208940,208941,208942,208943,208944)
go
insert into cobis..cl_errores values (208901, 0, 'YA EXISTE EL NOMBRE DEL GRUPO')
go
insert into cobis..cl_errores values (208902, 0, 'ERROR EN INGRESO DEL MIEMBRO DE GRUPO')
go
insert into cobis..cl_errores values (208903, 0, 'YA EXISTE EL MIEMBRO EN EL GRUPO')
go
insert into cobis..cl_errores values (208904, 0, 'NO EXISTE EL MIEMBRO EN EL GRUPO')
go
insert into cobis..cl_errores values (208905, 0, 'ERROR EN LA ACTUALIZACI�N DEL GRUPO EN EL MIEMBRO')
go
insert into cobis..cl_errores values (208906, 0, 'ERROR EN LA ACTUALIZACI�N DEL MIEMBRO')
go
insert into cobis..cl_errores values (208907, 0, 'NO EXISTE EL MIEMBRO')
go
insert into cobis..cl_errores values (208908, 0, 'YA EXISTE EL MIEMBRO EN OTROS GRUPOS')
go
insert into cobis..cl_errores values (208909, 0, 'YA EXISTE UN MIEMBRO CON LUGAR DE REUNI�N')
go
insert into cobis..cl_errores values (208910, 0, 'NO SE PUEDE ELIMINAR direcci�n YA QUE SE ENCUENTRA REFERENCIADA POR UN PRODUCTO')
go
insert into cobis..cl_errores values (208911, 1, 'EL CLIENTE NO TIENE LA DIRECCI�N POR FAVOR INGRESE LA DIRECCI�N')
go
insert into cobis..cl_errores values (208912, 0, 'DEBE DE EXISTIR UN SOLO PRESIDENTE')
go
insert into cobis..cl_errores values (208913, 0, 'DEBE DE EXISTIR UN SOLO TESORERO')
go
insert into cobis..cl_errores values (208914, 0, 'PRESIDENTE YA EXISTE EN EL GRUPO')
go
insert into cobis..cl_errores values (208915, 0, 'TESORERO YA EXISTE EN EL GRUPO')
go
insert into cobis..cl_errores values (208916, 0, 'VALIDAR N�MERO M͍NIMO Y M�XIMO DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208917, 0, 'VALIDAR PARENTESCO DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208918, 0, 'VALIDAR CR�DITOS VIGENTES DE INTEGRANTES.')
go
insert into cobis..cl_errores values (208919, 0, 'VALIDAR INTEGRANTES COMO C�NYUGES.')
go
insert into cobis..cl_errores values (208920, 0, 'VALIDAR N�MERO DE MUJERES.')
go
insert into cobis..cl_errores values (208921, 0, 'EL GRUPO DEBE TENER UN PRESIDENTE')
go
insert into cobis..cl_errores values (208922, 0, 'EL GRUPO DEBE TENER UN TESORERO')
go
insert into cobis..cl_errores values (208923, 0, 'VALIDAR N�MERO DE EMPRENDEDORES')
go
insert into cobis..cl_errores values (208925, 0, 'VALIDACION COMITE')
go
insert into cobis..cl_errores values (208926, 0, 'EL GRUPO DEBE TENER UN SECRETARIO')
go
insert into cl_errores (numero, severidad, mensaje) values (70011007, 0, 'Ya existe una persona con esta identificaci�n. CURP')
go
insert into cl_errores (numero, severidad, mensaje) values (70011008, 0, 'Ya existe una persona con esta identificaci�n. RFC')
go
insert into cl_errores (numero, severidad, mensaje) values (7300004, 0, 'Error en la creaci�n del cliente')
go

insert into cobis..cl_errores VALUES(107351,0, 'El cliente no tiene registrada una direcci�n')
go

insert into cobis..cl_errores VALUES(107352,0, 'Residencia es requerida para verificar Buro')
go

insert into cobis..cl_errores values (208932, 0, 'POR FAVOR INGRESE EL LUGAR DE REUNION')
go

insert into cobis..cl_errores values (208933, 0, 'EL GRUPO NO CUENTA CON LUGAR DE REUNION, POR FAVOR INGRESE')
go

insert into cobis..cl_errores values (208934, 0, 'FECHA DE ASOCIACION MAYOR A FECHA PROCESO')
go

insert into cobis..cl_errores values (208935, 0, 'SECRETARIO YA EXISTE EN EL GRUPO')

go
insert into cobis..cl_errores values (208937, 0, 'No existe cotizacion para la Fecha del Servidor')
go

insert into cobis..cl_errores values (208939, 0, 'ERROR AL INSERTAR LA OPERACION INTERNA PREOCUPANTE O INUSUAL ')
go

insert into cobis..cl_errores values (208940, 0, 'NO EXISTE REGISTRO CON EL ID DE ALERTA')
go

insert into cobis..cl_errores values (208941, 0, 'ERROR AL BUSCAR DATOS DE LA ALERTA')
go

insert into cobis..cl_errores values (208942, 0, 'ERROR AL ACTUALIZAR DATOS DE LA ALERTA')
go

insert into cobis..cl_errores values (208943, 0, 'ERROR AL BUSCAR DATOS DE LA ALERTA')
go

insert into cobis..cl_errores values (208944, 0, 'ERROR AL ELIMINAR DATOS DE LA ALERTA')
go
--/////////////////////////////////////////////////////////////////////////////////////////////

use cobis
go
delete cobis..cl_errores
where numero in (107363, 107284, 107287, 103141, 103142, 103143, 103144, 103145, 103146, 103147,103149, 
                 103150, 103151, 103152, 103153, 103154, 103155, 103156,103157,70011016, 103158, 103159,
                 103161, 103162, 103163, 103164, 103165, 103176, 103177, 103190,208946, 103192, 103193, 
                 103194, 103195, 103197, 103198, 103178, 103179, 103180,103200,103201,103202,103203,109000,109001,109002)

insert into cobis..cl_errores
values (107363, 0, 'ERROR AL INGRESAR, ACTIVIDAD ECONOMICA DEL CLIENTE YA EXISTE')


insert into cobis..cl_errores
values (107284, 0, 'No se puede tener mas de una Actividad como principal')


insert into cobis..cl_errores
values (107287, 0, 'No se puede eliminar un Actividad Principal')


insert into cobis..cl_errores (numero, severidad, mensaje)
values (103141, 0, 'No existe un grupo con ese c�digo ')


insert into cobis..cl_errores (numero, severidad, mensaje)
values (103142, 0, ' No se puede convertir en cliente porque no tiene cuenta Santander y/o no se encuentra Activo ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103143, 0, ' No se puede insertar porque el integrante no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103144, 0, ' Error al iniciar el flujo, el solicitante no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103145, 0, ' Error al iniciar el flujo, un integrante del grupo no es un Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103146, 0, ' Error al crear relaci�n: Por favor regularice el estado civil del Conyuge ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103147, 0, ' Error al iniciar el flujo, el grupo no esta vigente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103149, 0, ' No existe el registro que desea actualizar ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103150, 0, ' Error al actualizar la seccion del cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103151, 0, ' Error al actualizar Prospecto a Cliente ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103152, 0, ' Error al insertar Notificaci�n General ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103153, 0, ' Error al insertar estado de Notificaci�n General ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103154, 0, ' Por favor guarde el Cliente antes de Continuar ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103155, 0, ' Revisar el estado civil de las personas relacionadas. ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103156, 0, ' Error el grupo tiene un tr�mite en ejecuci�n. ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103157, 1, 'Existe un Cliente casado y sin datos de Conyugue')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje) 
VALUES(70011016,0,'Error: No se puede crear una solicitud de un grupo con solicitud previa rechazada')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103158, 1, 'Error, uno de los integrantes del grupo es Vinculado.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103159, 1, 'Error, el cliente es Vinculado.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103160, 0, 'El cliente tiene una operaci�n activa.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103161, 0, 'El Segundo Nombre es requerido')

insert into cobis..cl_errores (numero, severidad, mensaje) 
values (103162, 0, 'Error al actualizar resultado de riesgo')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103163, 0, 'Error al ejecutar la regla')

insert into cobis..cl_errores (numero, severidad, mensaje) 
values (103164, 0, 'Informaci�n Incompleta para Generar Matriz')

insert into cobis..cl_errores (numero, severidad, mensaje) 
values (103165, 0, 'No se encontro el Sub-Producto del cliente')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103176, 0, 'Error al iniciar el flujo, el solicitante no es un Grupo.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103177, 0, 'Error al iniciar el flujo, el solicitante debe ser Persona Natural.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103190, 1, 'Error, el nro de documento ya existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (208946, 0, 'ERROR GRUPO NO CUMPLE EL MINIMO DE INTEGRANTES')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103192, 1, 'Error el Par�metro NOMBRE DE LA ETAPA INGRESO DE SOLICITUD no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103193, 1, 'Error el Par�metro NOMBRE DE LA ETAPA APLICAR CUESTIONARIO - GRUPAL no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103194, 1, 'Error el Par�metro NOMBRE DE LA ETAPA REVISAR Y VALIDAR INFORMACI�N no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103195, 1, 'Error el Par�metro NOMBRE DE LA ETAPA CAPTURAR FIRMAS Y DOCUMENTOS no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103196, 0, 'Error, el cliente tiene un tr�mite en ejecuci�n.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103198, 0, 'La solicitud tiene un oficial diferente al del cliente.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103178, 0, 'Prospecto rechazado por deterioro crediticio')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103179, 0, 'El grupo excede los CONDICIONADOS, se recomienda eliminar X personas con esta prioridad <lista>')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103180, 0, 'El grupo excede los CONDICIONADOS, se debe revisar X personas con esta prioridad <lista>')

-----------------------------------------------------------
-------------             ELAVON         ------------------
-----------------------------------------------------------

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103200, 1, 'Tipo no coincide para un Cliente o Grupo.')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103201, 1, 'El criterio de b�squeda debe tener m�nimo 5 caracteres.'

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103202, 1,'No se encontraron coincidencias para el criterio de b�squeda.')	

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103203, 1,'Error el Par�metro DIAS MAXIMO PARA PRECANCELACION no existe')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103197, 0, 'No se puede modificar el Grupo si la solicitud no se encuentra en la etapa de Ingreso')

-----------------------------------------------------------
-------------           COLECTIVOS       ------------------
-----------------------------------------------------------

---Pantalla de Rol Asesor
insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109000,0,'El registro ya existe.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109001,0,'El registro que se intenta eliminar no existe.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109002,0,'Error al cargar la lista de oficiales para el rol seleccionado.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109003,0,'Error: el solicitante no puede ser un cliente colectivo.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109004,0,'No existe el cat�logo FIRMAS Y CUESTIONARIO COLECTIVO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109005,0,'No existe secuencial para la tabla si_sincroniza')

go

---Requerimiento 119655: Cambios WEB APP Auditor�a
delete cobis..cl_errores where numero in (101269)

insert into cobis..cl_errores values (101269, 0, 'El correo electr�nico ingresado ya fue registrado')
go


delete from cobis..cl_errores where numero = 70074
insert into cobis..cl_errores values (70074, 0,'Es necesario actualizar el correo electr�nico')

go

delete from cobis..cl_errores where numero = 70075
insert into cobis..cl_errores values (70075, 0,'Es necesario ingresar el campo REFERENCIAS en la Direcci�n de Negocio/Domicilio del cliente')

go
delete from cl_errores 
where numero in (70326,70327,70328,70329,70330,70331,70332,70333,
				 70334,70335,70336,70337,70338,70339,70340,70341)

insert into cl_errores values(70326,1,'No existen respuestas del cliente')
insert into cl_errores values(70327,1,'Error en al insertar datos en la tabla cl_neg_cliente')
insert into cl_errores values(70328,1,'No existe un formulario vigente')
insert into cl_errores values(70329,1,'Existen m�s de un formulario con estado Activo')
insert into cl_errores values(70330,1,'No existe secciones para el formulario')
insert into cl_errores values(70331,1,'No exiten preguntas del formulario')
insert into cl_errores values(70332,1,'No exiten preguntas tipo tabla para el formulario')
insert into cl_errores values(70333,1,'No existe respuesta relacionadas al formulario')
insert into cl_errores values(70334,1,'No existe informacion relacionada a la pregunta')
insert into cl_errores values(70335,1,'La suma de los ingresos semanales del cliente no esta en el rango permitido')
insert into cl_errores values(70336,1,'La suma de los gastos semanales del cliente no esta en el rango permitido')
insert into cl_errores values(70337,1,'Las diferencia entre ingresos y gastos, es muy peque�a, no llegan a los')
insert into cl_errores values(70338,1,'Falta capturar (digitalizar) Comprobante de ingreso tipo <tipo del ingreso>')
insert into cl_errores values(70339,1,'El valor a solicitar debe ser m�ltiplo de 100 pesos.')
insert into cl_errores values(70340,1,'La periodicidad seleccionada no es v�lida en este ciclo.')
insert into cl_errores values(70341,1,'El plazo seleccionado no es v�lida en este ciclo.')

go

--Reportes
delete cobis..cl_errores
where numero in (17048,17049, 17050)
go
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17048 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CA_COBRANZA_BATCH')
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17049 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO')
INSERT INTO cl_errores(numero, severidad, mensaje) VALUES(17050 ,0, 'ERROR AL INSERTAR REGISTRO EN TABLA CR_BURO_DIARIO')
go

--MTA Exclusion de Clientes
--CREACION DE ERRORES
if exists(select 1 from cl_errores where numero IN (201050, 201051, 201052, 201053, 201054))
   delete cl_errores where numero in(201050, 201051, 201052, 201053, 201054)
   
insert into cl_errores (numero, severidad, mensaje)
values(201050, 0, 'ERROR AL INSERTAR EL CLIENTE EN LA LISTA DE EXCLUSION')   
go

insert into cl_errores (numero, severidad, mensaje)
values(201051, 0, 'ERROR AL BUSCAR DATOS DEL CLIENTE EN LA LISTA DE EXCLUSION')   
GO

insert into cl_errores (numero, severidad, mensaje)
values(201052, 0, 'ERROR AL ELIMINAR DEL CLIENTE EN LA LISTA DE EXCLUSION')   
go

insert into cl_errores (numero, severidad, mensaje)
values(201053, 0, 'ERROR YA EXISTE EL CLIENTE EN LA LISTA DE EXCLUSION')   
go


-- BIOMETRICOS

delete cobis..cl_errores where numero in
(103400, 103401, 103402, 103403,103404, 103405, 103406, 103407,103408)

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103400,0,'ERROR: LOS CAMPOS REQUERIDOS PARA TIPO DE IDENTIFICACI�N INE NO EST�N COMPLETOS.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103401,0,'ERROR: LOS CAMPOS REQUERIDOS PARA TIPO DE IDENTIFICACI�N IFE NO EST��N COMPLETOS.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103402,0,'ERROR: ERROR AL GUARDAR LA INFORMACI�N DE BIOM�TRICO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103403,0,'ERROR: NO EXISTE EL PARAMETRO RENCHN PARA LA CONEXI�N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103404,0,'ERROR: NO EXISTE EL PARAMETRO RENBRN PARA LA CONEXI�N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103405,0,'ERROR: NO EXISTE EL PARAMETRO RENTTP PARA LA CONEXI�N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103406,0,'ERROR: NO EXISTE EL PARAMETRO RENTI1 PARA LA CONEXI�N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103407,0,'ERROR: NO EXISTE EL PARAMETRO RENTI2 PARA LA CONEXI�N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103408,0,'ERROR: NO SE PUDO CONSULTAR BURO PORQUE LOS CLIENTES NO HAN SIDO VALIDADOS EN RENAPO.') 

go

-- ACTUALIZACI�N CODIGO SANTANDER Y CUENTAS
delete from cobis..cl_errores where numero in (109006, 109007, 109008)

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109006,0,'El C�digo Santander ya se encuentra registrado')

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109007,0,'La cuenta ya se encuentra registrada')

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109008,0,'Ingresar solo n�meros para la Cuenta y el C�digo Santander')
go

--RENOVACIONES
delete cobis..cl_errores where numero in (103410)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103410, 0, ' ERROR EL GRUPO NO TIENE UNA OPERACION VIGENTE.')

go
-- TIPO MERCADO Y NIVEL DE CLIENTE
delete from cobis..cl_errores where numero in (103411,103412)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103411, 0, 'CODIGO DE TIPO DE MERCADO INCORRECTO')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103412, 0, 'CODIGO DE NIVEL DE CLIENTE INCORRECTO')

go


-- ONBOARDING REQUERIMIENTO 168293

delete from cobis..cl_errores where numero in (103413,103414,103415)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103413, 0, 'DATOS DEL CLIENTE INSUFICIENTES')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103414, 0, 'ERROR AL REALIZAR AUTO ONBOARDING')

insert into cl_errores (numero, severidad, mensaje)
values (103415, 0, 'ERROR AL GUARDAR EL ID DEL EXPEDIENTE')

go


-- REQ 193221- B2B Grupal Digital
delete from cobis..cl_errores where numero in (103199)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103199, 0, 'NECESITA VERIFICAR SU CORREO')

delete from cobis..cl_errores where numero in (103204)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103204, 0, 'NECESITA VERIFICAR SU TELEFONO CELULAR')

go
