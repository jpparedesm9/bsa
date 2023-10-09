use cobis
Go

set nocount on
go

delete cl_ttransaccion
where tn_trn_code in (728,729,730,731,4000,4001,4002,4003,4004,4005,4006,4007,4008,4009
,4010,4011,4012,4013,4014,4015,4016,4017,4018,4019,4020,4021,4022
,4023,4024,4025,4026,4027,4028,4029,4030,4031,4032,4033,4034,4035
,4036,4037,4038,4039,4040,4041,4042,4043,4044,4045,4046,4047,4048
,4049,4050,4051,4052,4053,4054,4055,4056,4057,4058,4059,4060,4061
,4062,4063,4064,4065,4066,4067,4068,4069,4070,4071,4072,4073,4074
,4075,4076,4077,4078,4079,4080,4081,4082,4083,4084,4085,4086,4087
,4088,4089,4090,4091,4092,4093,4094,4095,4096,4097,4098,4099,4100
,4101,4102,4103,4104,4105,4106,4107,4108,4109,4110,4111,4112,4113
,4114,4115,4116,4117,4118,4119,4120,4121,4122,4123,4124,4125,4126
,4127,4128,4129,4130,4131,4132,4133,4134,4135,4136,4137,4138,4139
,4140,4141,4142,4143,4144,4145,4146,4148,4149,4150,4151,4152,4153
,4154,4155,4156,4157,4158,4159,4162,4163,4164,4165,4166,4167)
go

insert into cl_ttransaccion values(728,'INGRESO DE TRANSACCIONES AUTORIZADAS','730','INGRESO DE TRANSACCIONES AUTORIZADAS EN CAJA')
insert into cl_ttransaccion values(729,'ACTUALIZA DE TRANSACCIONES AUTORIZADAS CAJA','730','ACTUALIZACION DE TRANSACCIONES AUTORIZADAS EN CAJA')
insert into cl_ttransaccion values(730,'CONSULTA DE TRANSACCIONES AUTORIZADAS CAJA','730','CONSULTA DE TRANSACCIONES AUTORIZADAS EN CAJA')
insert into cl_ttransaccion values(731,'CONSULTA DE TRANSACCIONES CAJA','730','CONSULTA DE TRANSACCIONES CAJA')
insert into cl_ttransaccion values(4000,'INSERCION DE PRODUCTO BANCARIO','IPRB','INSERCION DE PRODUCTOS BANCARIOS')
insert into cl_ttransaccion values(4001,'ACTUALIZACION DE PRODUCTO BANCARIO','APRB','ACTUALIZACION DE PRODUCTO BANCARIO')
insert into cl_ttransaccion values(4002,'BUSQUEDA DE PRODUCTOS BANCARIOS','BPRB','BUSQUEDA DE PRODUCTOS BANCARIOS')
insert into cl_ttransaccion values(4003,'CONSULTA DE PRODUCTO BANCARIO','CPRB','CONSULTA DE UN PRODUCTO BANCARIO SOLICITADO')
insert into cl_ttransaccion values(4004,'INSERCION DE PRODUCTO MERCADO','IPRM','INSERCION DE PRODUCTO BANCARIO-ENTE')
insert into cl_ttransaccion values(4005,'ACTUALIZACION DE PRODUCTO MERCADO','APRM','ACTUALIZACION DE PRODUCTO BANCARIO ENTE')
insert into cl_ttransaccion values(4006,'BUSQUEDA DE PRODUCTO MERCADO','BPRM','BUSQUEDA DE PRODUCTOS BANCARIOS ENTES')
insert into cl_ttransaccion values(4007,'CONSULTA DE PRODUCTO MERCADO','CPRM','CONSULTA DE PRODUCTO BANCARIO ENTES')
insert into cl_ttransaccion values(4008,'INSERCION DE PRODUCTO FINAL','IPRF','INSERCION DE PRODUCTO FINAL')
insert into cl_ttransaccion values(4009,'ACTUALIZACION DE PRODUCTO FINAL','APRF','ACTUALIZACION DE PRODUCTO FINAL')
go
insert into cl_ttransaccion values(4010,'ELIMINACION DE PRODUCTO FINAL','EPRF','ELIMINACION DEL PRODUCTO FINAL')
insert into cl_ttransaccion values(4011,'BUSQUEDA DE PRODUCTO FINAL','BPRF','BUSQUEDA DE PRODUCTO FINALES')
insert into cl_ttransaccion values(4012,'CONSULTA DE PRODUCTO FINAL','CPRF','CONSULTA DE PRODUCTO FINALES')
insert into cl_ttransaccion values(4013,'BUSQUEDA DE SUBSERVICIOS','BSUB','BUSQUEDA DE SUBSERVICIOS ASOCIADOS')
insert into cl_ttransaccion values(4014,'CONSULTA DE SUBSERVICIO','CSUB','CONSULTA DE UN SUBSERVICIO SOLICITADO')
insert into cl_ttransaccion values(4015,'INSERCION DE SERVICIO PERSONALIZABLE','ISPE','INGRESO DE SERVICIO PERSONALIZABLE')
insert into cl_ttransaccion values(4016,'ELIMINACION DE SERVICIO PERSONALIZABLE','ESPE','ELIMINACION DE SERVICIO PERSONALIZABLE')
insert into cl_ttransaccion values(4017,'BUSQUEDA DE SERVICIOS PERSONALIZABLES','BSPE','BUSQUEDA DE SERVICIOS PERSONALIZABLES')
insert into cl_ttransaccion values(4018,'CONSULTA DE SERVICIO PERSONALIZABLE','CSPE','CONSULTA DE UN SERVICIO PERSONALIZABLE')
insert into cl_ttransaccion values(4019,'INSERCION DE SERVICIO CONTRATADO','ISCO','INSERCION DE SERVICIO CONTRATADO')
go
insert into cl_ttransaccion values(4020,'ACTUALIZACION DE SERVICIO CONTRATADO','ASCO','ACTUALIZACION DE SERVICIO CONTRATADO')
insert into cl_ttransaccion values(4021,'BUSQUEDA DE SERVICIOS CONTRATADOS','BSCOR','BUSQUEDA DE SERVICIOS CONTRATADOS')
insert into cl_ttransaccion values(4022,'CONSULTA DE SERVICIO CONTRATADO','CSCO','CONSULTA DE SERVICIO CONTRATADO')
insert into cl_ttransaccion values(4023,'AYUDA DE PRODUCTO MERCADO','APRM','AYUDA DEL PRODUCTO MERCADOS')
insert into cl_ttransaccion values(4024,'AYUDA DE SERVICIOS PERSONALIZADOS','ASPE','AYUDA DE SERVICIOS PERSONALIZADOS')
insert into cl_ttransaccion values(4025,'INSERCION DE DETALLES DE SERVICIO','IDSR','INSERCION DE DETALLES DE SERVICIO DISPONIBLES')
insert into cl_ttransaccion values(4026,'ACTUALIZACION DE DETALLES DE SERVICIO','ADSR','ACTUALIZACION DE DETALLES DE SERVICIO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4027,'INSERCION DE SERVICIOS DISPONIBLES','ISDI','INSERCION DE SERVICIO DISPONIBLES PARA PERSONALIZACION')
insert into cl_ttransaccion values(4028,'ACTUALIZACION DE SERVICIOS DISPONIBLES','ASDI','ACTUALIZACION DE SERVICIO DISPONIBLES PARA PERSONALIZACION')
insert into cl_ttransaccion values(4029,'CONSULTA DE SERVICIOS DISPONIBLES','CSDI','CONSULTA DE SERVICIOS DISPONIBLES PARA PERSONALIZACION')
go
insert into cl_ttransaccion values(4030,'QUERY DE CONSULTA A SERVICIOS DISPONIBLES','QSDI','QUERY DE CONSULTA DE SERVICIOS DISPONIBLES PARA PERSONALIZACION')
insert into cl_ttransaccion values(4031,'HELP DE CONSULTA DE SERVICIOS DISPONIBLES','HSDI','HELP DE CONSULTA DE SERVICIOS DISPONIBLES PARA PERSONALIZACION')
insert into cl_ttransaccion values(4032,'INSERCION DE TIPO DE RANGO','ITRA','INSERCION DE TIPO DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4033,'ACTUALIZACION DE TIPO DE RANGO','ATRA','ACTUALIZACION DE TIPO DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4034,'CONSULTA DE TIPO DE RANGO','CTRA','CONSULTA DE TIPO DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4035,'INSERCION DE RANGO','IRAN','INSERCION DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4036,'ACTUALIZACION DE RANGOS','ARAN','ACTUALIZACION DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4037,'CONSULTA DE RANGOS','CRAN','CONSULTA DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4038,'HELP DE CONSULTA DE RANGOS','HRAN','HELP DE CONSULTA DE RANGO PARA PERSONALIZACION')
insert into cl_ttransaccion values(4039,'HELP DE CONSULTA DE SUBSERVICIOS','HRAN','HELP DE CONSULTA DE SUBSERVICIO')
go
insert into cl_ttransaccion values(4040,'INSERCION DE PRODUCTOS BASICOS','IPRB','INSERCION DE PRODUCTOS BASICOS')
insert into cl_ttransaccion values(4041,'CONSULTA DE PRODUCTOS BASICOS','CPRB','CONSULTA DE PRODUCTOS BASICOS')
insert into cl_ttransaccion values(4042,'ACTUALIZACION DE PRODUCTOS BASICOS','APRB','ACTUALIZACION DE PRODUCTOS BASICOS')
insert into cl_ttransaccion values(4043,'CONSULTA DE PRODUCTO COBIS','CPRO','CONSULTA DE PRODUCTO COBIS')
insert into cl_ttransaccion values(4044,'CONSULTA DE MONEDA','CMON','CONSULTA DE MONEDAS')
insert into cl_ttransaccion values(4045,'QUERY DE PRODUCTOS FINALES','QPRF','QUERY DE PRODUCTOS FINALES')
insert into cl_ttransaccion values(4046,'AYUDA DE SERVICIOS PERSONALIZABLES','ASPE','AYUDA DE SERVICIOS PERSONALIZABLES')
insert into cl_ttransaccion values(4047,'QUERY DE RANGOS','QRAN','QUERY DE RANGOS')
insert into cl_ttransaccion values(4048,'AYUDA DE RANGOS','ARAN','AYUDA DE RANGOS')
insert into cl_ttransaccion values(4049,'INSERCION DE COSTOS','ICOS','INSERCION DE COSTOS')
go
insert into cl_ttransaccion values(4050,'ACTUALIZACION DE COSTOS','ACOS','ACTUALIZACION DE COSTOS')
insert into cl_ttransaccion values(4051,'ELIMINACION DE COSTOS','ECOS','ELIMINACION DE COSTOS')
insert into cl_ttransaccion values(4052,'CONSULTA DE COSTOS','CCOS','CONSULTA DE COSTOS')
insert into cl_ttransaccion values(4053,'INSERCION DE VALORES CONTRATADOS','IVCO','INSERCION DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4054,'ACTUALIZACION DE VALORES CONTRATADOS','AVCO','ACTUALIZACION DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4055,'ELIMINACION DE VALORES CONTRATADOS','EVCO','ELIMINACION DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4056,'SEARCH DE VALORES CONTRATADOS','SVCO','SEARCH DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4057,'QUERY DE VALORES CONTRATADOS','QVCO','QUERY DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4058,'CONSULTA DE PARAMETROS DE COSTO','CPCO','CONSULTA DE PARAMETROS DE COSTO')
insert into cl_ttransaccion values(4059,'CONSULTA GENERAL DE COSTO','CGCO','CONSULTA GENERAL DE COSTO')
go
insert into cl_ttransaccion values(4060,'CONSULTA GENERAL DE COSTO','CGCO','CONSULTA GENERAL DE COSTO')
insert into cl_ttransaccion values(4061,'INS. ACT DE VALOR CONTRATADO','CGCO','INS. ACT. DE VALOR CONTRATADO')
insert into cl_ttransaccion values(4062,'INSERCION DE LIMITE','CGCO','INSERCION DE LIMITE')
insert into cl_ttransaccion values(4063,'ACTUALIZACION DE LIMITE','CGCO','ACTUALIZACION DE LIMITE')
insert into cl_ttransaccion values(4064,'SEARCH DE LIMITE','CGCO','SEARCH DE LIMITE')
insert into cl_ttransaccion values(4065,'QUERY DE LIMITE','CGCO','QUERY DE LIMITE')
insert into cl_ttransaccion values(4066,'QUERY DE SERVICIO-TIPO ATRIBUTO','QSTA','QUERY DE SERVICIO-TIPO ATRIBUTO')
insert into cl_ttransaccion values(4067,'CONSULTA DE SERVICIO-TIPO ATRIBUTO','CSTA','CONSULTA DE SERVICIO-TIPO ATRIBUTO')
insert into cl_ttransaccion values(4068,'INSERCION/ACTUALIZACION DE VALOR CONTRATADO','IAVC','INSERCION/ACTUALIZACION DE VALOR CONTRATADO')
insert into cl_ttransaccion values(4069,'CONSULTA DE SERVICIOS CONTRATADOS','COSC','CONSULTA DE SERVICIOS CONTRATADOS')
go
insert into cl_ttransaccion values(4070,'CONSULTA DE VALORES CONTRATADOS','COVC','CONSULTA DE VALORES CONTRATADOS')
insert into cl_ttransaccion values(4071,'ACTUALIZACION DE PERSONALIZACION DE CUENTA','APCT','ACTUALIZACION DE PERSONALIZACION DE CUENTA')
insert into cl_ttransaccion values(4072,'CONSULTA DE CUENTAS POR TITULAR','CCPT','CONSULTA DE CUENTAS POR TITULAR')
insert into cl_ttransaccion values(4073,'CONSULTA DE VALOR CONTRATADO POR CUENTA','CVCC','CONSULTA DE VALOR CONTRATADO POR CUENTA')
insert into cl_ttransaccion values(4074,'AYUDA DE DETALLE DE SERVICIO','ADSE','AYUDA DE DETALLE DE SERVICIO')
insert into cl_ttransaccion values(4075,'AYUDA DE PRODUCTO MONEDA','ADPM','AYUDA DE PRODUCTO MONEDA')
insert into cl_ttransaccion values(4076,'QUERY DE PRODUCTO MONEDA','QDPM','QUERY DE PRODUCTO MONEDA')
insert into cl_ttransaccion values(4077,'HELP DE PRODUCTO FINAL','HDPF','HELP DE PRODUCTO FINAL')
insert into cl_ttransaccion values(4078,'QUERY DE SUCURSAL','QSUC','QUERY DE SUCURSAL')
insert into cl_ttransaccion values(4079,'HELP DE SUCURSAL','HSUC','HELP DE SUCURSAL')
go
insert into cl_ttransaccion values(4080,'SEARCH DE RANGO MASIVO','SERM','SEARCH DE RANGO MASIVO')
insert into cl_ttransaccion values(4081,'QUERY DE RANGO MASIVO','QURM','QUERY DE RANGO MASIVO')
insert into cl_ttransaccion values(4082,'MANTENIMIENTO MASIVO DE COSTOS','MMCS','MANTENIMIENTO MASIVO DE COSTOS')
insert into cl_ttransaccion values(4083,'CONSULTA EL COSTO TOTAL ONLINE','CCOL','CONSULTA EL COSTO TOTAL ONLINE')
insert into cl_ttransaccion values(4084,'CONSULTA EL COSTO TOTAL OFFLINE','CCTO','CONSULTA EL COSTO TOTAL OFFLINE')
insert into cl_ttransaccion values(4085,'APROBACION PROXIMOS VALORES DE SERVICIOS','APVDS','APROBACION PROXIMOS VALORES DE SERVICIOS')
insert into cl_ttransaccion values(4086,'CONSULTA DE COSTOS ESPECIALES','CCES','CONSULTA DE COSTOS ESPECIALES')
insert into cl_ttransaccion values(4087,'INGRESO DE COSTOS ESPECIALES','INES','INGRESO DE COSTOS ESPECIALES')
insert into cl_ttransaccion values(4088,'ACTUALIZACION DE COSTOS ESPECIALES','ACES','ACTUALIZACION DE COSTOS ESPECIALES')
insert into cl_ttransaccion values(4089,'CONSULTA DE COSTOS ESPECIALES PERSONALIZADOS','CCEP','CONSULTA DE COSTOS ESPECIALES PERSONALIZADOS')
go
insert into cl_ttransaccion values(4090,'INGRESO DE COSTOS ESPECIALES PERSONALIZADOS','INEP','INGRESO DE COSTOS ESPECIALES PERSONALIZADOS')
insert into cl_ttransaccion values(4091,'CONSULTA DE COSTOS ESPECIALES VIGENTES','CCEV','CONSULTA DE COSTOS ESPECIALES VIGENTES')
insert into cl_ttransaccion values(4092,'APROBACION/ELIMINACION DE COSTOS ESPECIALES','CCEV','APROBACION/ELIMINACION DE COSTOS ESPECIALES')
insert into cl_ttransaccion values(4093,'BUSCAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES','4093','BUSCAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4094,'CREAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES','4094','CREAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4095,'ACTUALIZAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES','4095','ACTUALIZAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4096,'ELIMINAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES','4096','ELIMINAR TIPO DE CAPITALIZACION POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4097,'BUSCAR CICLO POR PRODUCTOS FINALES','4097','BUSCAR CICLO POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4098,'CREAR CICLO POR PRODUCTOS FINALES','4098','CREAR CICLO POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4099,'ACTUALIZAR CICLO POR PRODUCTOS FINALES','4099','ACTUALIZAR CICLO POR PRODUCTOS FINALES')
go
insert into cl_ttransaccion values(4100,'ELIMINAR CICLO POR PRODUCTOS FINALES','4100','ELIMINAR CICLO POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4101,'CATEGORIA POR PRODUCTOS FINALES','4101','CATEGORIA POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4102,'INGRESO CONCEPTO GMF',     'IGMF', 'INGRESO CONCEPTO EXENCION GMF')
insert into cl_ttransaccion values(4103,'ACTUALIZACION CONCEPTO GMF', 'AGMF','ACTUALIZACION CONCEPTO EXENCION GMF')
insert into cl_ttransaccion values(4104,'ELIMINACION CONCEPTO GMF', 'EGMF', 'ELIMINACION CONCEPTO EXENCION GMF')
insert into cl_ttransaccion values(4105,'CONSULTA DE CUENTAS EXENTAS','CCEX', 'CONSULTA DE CUENTAS EXENTAS')
insert into cl_ttransaccion values(4106,'ACTUALIZACION DE CUENTAS EXENTAS', 'ACEX', 'ACTUALIZACION DE CUENTAS EXENTAS')
insert into cl_ttransaccion values(4107, 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES', 'MCTRN', 'MANTENIMIENTO DE CONCEPTOS PARA TRANSACCIONES')
insert into cl_ttransaccion values(4108,'CONSULTA CONCEPTO GMF','CGMF', 'CONSULTA CONCEPTO EXENCION GMF')
insert into cl_ttransaccion values(4109,'CONSULTA PARAM. COBR.COMIS.','CPCC','CONSULTA PARAMETRIZACIÓN DE COBRO DE COMISIONES')
go
insert into cl_ttransaccion values(4110,'INSERCION PARAM. COBR.COMIS.','IPCC','INSERCION PARAMETRIZACIÓN DE COBRO DE COMISIONES')
insert into cl_ttransaccion values(4111,'MODIFICACION PARAM. COBR.COMIS.','MPCC','MODIFICACION PARAMETRIZACIÓN DE COBRO DE COMISIONES')
insert into cl_ttransaccion values(4112,'ELIMINACION PARAM. COBR.COMIS.','EPCC','ELIMINACION PARAMETRIZACIÓN DE COBRO DE COMISIONES')
insert into cl_ttransaccion values(4113,'CREAR CATEGORIA POR PRODUCTOS FINALES', '4113', '(PARA SEGURIDAD BOTON) CREAR CATEGORIA POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4114,'ACTUALIZAR CATEGORIA POR PRODUCTOS FINALES', '4114', '(PARA SEGURIDAD BOTON) ACTUALIZAR CATEGORIA POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4115,'ELIMINAR CATEGORIA POR PRODUCTOS FINALES', '4115', '(PARA SEGURIDAD BOTON) ELIMINAR CATEGORIA POR PRODUCTOS FINALES')
insert into cl_ttransaccion values(4116,'BUSCAR MANTENIMIENTOS EN LINEA', '4116', '(PARA SEGURIDAD MENU) BUSCAR MANTENIMIENTOS EN LINEA')
insert into cl_ttransaccion values(4117,'INGRESAR MANTENIMIENTO EN LINEA', '4117', '(PARA SEGURIDAD BOTON) INGRESAR MANTENIMIENTO EN LINEA')
insert into cl_ttransaccion values(4118,'CONSULTA DE PROXIMOS VALORES VIGENTES', '4118', '(PARA SEGURIDAD MENU) CONSULTA DE PROXIMOS VALORES VIGENTES')
insert into cl_ttransaccion values(4119,'IMPRIMIR CONSULTA HISTORICA DE COSTOS Y TASAS', '4119', '(PARA SEGURIDAD BOTON) IMPRIMIR CONSULTA HISTORICA DE COSTOS Y TASAS')
go
insert into cl_ttransaccion values(4120,'CONSULTA DE COSTOS', '4120', '(PARA SEGURIDAD BOTON) CONSULTA DE COSTOS')
insert into cl_ttransaccion values(4121,'CREAR COSTOS', '4121', '(PARA SEGURIDAD BOTON) CREAR COSTOS')
insert into cl_ttransaccion values(4122,'CONSULTA PRODUCTOS FINALES', '4122', '(PARA SEGURIDAD BOTON) CONSULTA PRODUCTOS FINALES')  
insert into cl_ttransaccion values(4123, 'CONSULTA PARAMETROS PRODUCTO CONTRACTUAL',  'CPPC  ', 'CONSULTA PARAMETROS PRODUCTO CONTRACTUAL')
insert into cl_ttransaccion values(4124, 'MODIFICION PARAMETROS PRODUCTO CONTRACTUAL', 'MPPC', 'MODIFICACION PARAMETROS PRODUCTO CONTRACTUAL')
insert into cl_ttransaccion values(4125, 'INSERCION PARAMETROS PRODUCTO CONTRACTUAL',   'IPPC', 'CREACION PARAMETROS PRODUCTO CONTRACTUAL')
insert into cl_ttransaccion values(4126, 'BORRADO PARAMETROS PRODUCTO CONTRACTUAL',    'BPPC', 'BORRADO PARAMETROS PRODUCTO CONTRACTUAL')
insert into cl_ttransaccion values(4127, 'SEARCH PARAMETROS PRODUCTO CONTRACTUAL',     'SPPC', 'SEARCH PARAMETROS PRODUCTO CONTRACTUAL')
insert into cl_ttransaccion values(4128, 'INGRESO TOPES POR OFICINA',     '4128', 'INGRESO TOPES POR OFICINA')
insert into cl_ttransaccion values(4129, 'CONSULTA TOPES POR OFICINA',     '4129', 'CONSULTA TOPES POR OFICINA')
go

insert into cl_ttransaccion values(4130,'CAMBIO DE CATEGORIA','4130','CAMBIO DE CATEGORIA PARA UNA CUENTA')
insert into cl_ttransaccion values(4131,'INGRESO AUTORIZACION RETIRO POR OFICINA','4131','INGRESO AUTORIZACION RETIRO POR OFICINA')
insert into cl_ttransaccion values(4132,'BLOQUEO AUTORIZACION RETIRO POR OFICINA','4132','BLOQUEO AUTORIZACION RETIRO POR OFICINA')
insert into cl_ttransaccion values(4133,'CONSULTA AUTORIZACION RETIRO POR OFICINA','4133','CONSULTA AUTORIZACION RETIRO POR OFICINA')
insert into cl_ttransaccion values(4134,'QUERY AUTORIZACION RETIRO POR OFICINA','4134','QUERY AUTORIZACION RETIRO POR OFICINA')
insert into cl_ttransaccion values(4135,'INCUMPLIMIENTOS AHO CONTRACTUAL','4135','MARCA INCUMPLIMIENTO AHO CONTRACTUAL')
insert into cl_ttransaccion values(4136,'INSERCION PARAMETROS EXTRACTO','IPEX','CREACION PARAMETROS EXTRACTO')
insert into cl_ttransaccion values(4137,'MODIFICION PARAMETROS EXTRACTO','MPEX','MODIFICACION PARAMETROS EXTRACTO')
insert into cl_ttransaccion values(4138,'CONSULTA PARAMETROS EXTRACTO','CPEX','CONSULTA PARAMETROS EXTRACTO')
insert into cl_ttransaccion values(4139,'BORRADO PARAMETROS EXTRACTO','BPEX','BORRADO PARAMETROS EXTRACTO')
go
insert into cl_ttransaccion values(4140,'SEARCH PARAMETROS EXTRACTO','SPEX','SEARCH PARAMETROS EXTRACTO')
insert into cl_ttransaccion values(4141,'MANEJO CONTROL EXTRACTO','MAEX','MANEJO CONTROL EXTRACTO')
insert into cl_ttransaccion values(4142,'TRANSACCION MARCACION GMF','MGMF','EJECUTA PROCESO MARCACION GMF')
insert into cl_ttransaccion values(4143,'Personalizacion/Productos/Caracteristicas_Especiales','4143','Personalizacion/Productos/Caracteristicas_Especiales')
insert into cl_ttransaccion values(4144,'C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial','4144','C. de Ahorros/Cuentas/Activacion Cuentas sin Deposito Inicial')
insert into cl_ttransaccion values(4145,'ACTIVACION DE CUENTAS SIN DEPOSITO INCIAL','4145','ACTIVACION DE CUENTAS SIN DEPOSITO INCIAL')
insert into cl_ttransaccion values(4146,'ANULACION DE CUENTAS SIN DEPOSITO INCIAL','4146','ANULACION DE CUENTAS SIN DEPOSITO INCIAL')
insert into cl_ttransaccion values(4148,'TRANSACCION DESMARCACION GMF','DGMF','EJECUTA PROCESO DESMARCACION GMF')
insert into cl_ttransaccion values(4149,'MENU / MANTENIMIENTO CUPO CB','4149','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4150,'MENU / CONSULTA DE CUPO','4150','CORRESPONSAL BANCARIO RED POSICIONADO')
go
insert into cl_ttransaccion values(4151,'MENU / CONSULTA DE MOVIMIENTOS','4151','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4152,'MENU / DEVOLUCION DE VALORES','4152','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4153,'MENU / GESTION DE CUENTAS','4153','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4154,'MENU / CONSOLIDADO DE REDES','4154','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4155,'MENU / MANTENIMIENTO CB','4155','CORRESPONSAL BANCARIO RED POSICIONADO')
insert into cl_ttransaccion values(4156,'MANTENIMIENTO LIMITES ORIGEN-ESPECIE','MLOE','MANTENIMIENTO LIMITES ORIGEN-ESPECIE')
insert into cl_ttransaccion values(4157,'MANTENIMIENTO CAUSALES ORIGEN-ESPECIE','MCOE','MANTENIMIENTO CAUSALES ORIGEN-ESPECIE')
insert into cl_ttransaccion values(4158,'MANTENIMIENTO SUBTIPO TD','MANSTD','TRANSACCION MANTENIMIENTO SUBTIPO TD')
insert into cl_ttransaccion values(4159,'CONSULTA SUBTIPO TD','MANSTD','TRANSACCION CONSULTA SUBTIPO TD')
insert into cl_ttransaccion values(4162,'CONSULTA DE TRASLADO','4162','CONSULTA DE TRASLADO')
go
insert into cl_ttransaccion values(4163,'MENU MANTENIMIENTO EQUIVALENCIAS','4163','MENU MANTENIMIENTO EQUIVALENCIAS')
insert into cl_ttransaccion values(4164,'BUSQUEDA EQUIVALENCIAS','4164','BUSQUEDA EQUIVALENCIAS')
insert into cl_ttransaccion values(4165,'INSERCION EQUIVALENCIAS','4165','INSERCION EQUIVALENCIAS')
insert into cl_ttransaccion values(4166,'MODIFICACION EQUIVALENCIAS','4166','MODIFICACION EQUIVALENCIAS')
insert into cl_ttransaccion values(4167,'ELIMINACION EQUIVALENCIAS','4167','ELIMINACION EQUIVALENCIAS')