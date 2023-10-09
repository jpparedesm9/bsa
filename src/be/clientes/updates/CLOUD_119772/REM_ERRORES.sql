use cobis
go

delete cobis..cl_errores where numero in
(2108057,2108058,2108059,2108060,2108061,2108062,
2108063, 2108064, 2108065, 2108067, 2108068, 
2108069, 2108070, 70400, 109000,109001,109002,109003,
109004, 109005)

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

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (70400,1,'ERROR: NO ESTA PARAMETRIZADO UN ASESOR PARA EL COLECTIVO INGRESADO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109000,0,'El registro ya existe.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109001,0,'El registro que se intenta eliminar no existe.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109002,0,'Error al cargar la lista de oficiales para el rol seleccionado.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109003,0,'Error: el solicitante no puede ser un cliente colectivo.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109004,0,'No existe el catálogo FIRMAS Y CUESTIONARIO COLECTIVO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (109005,0,'No existe secuencial para la tabla si_sincroniza')
go

