use cobis
go

delete cobis..cl_errores where numero in
(103400, 103401, 103402, 103403,103404, 103405, 103406, 103407, 103408, 601321)

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103400,0,'ERROR: LOS CAMPOS REQUERIDOS PARA TIPO DE IDENTIFICACI”N INE NO EST¡N COMPLETOS.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103401,0,'ERROR: LOS CAMPOS REQUERIDOS PARA TIPO DE IDENTIFICACI”N IFE NO EST¡ÅN COMPLETOS.')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103402,0,'ERROR: ERROR AL GUARDAR LA INFORMACI”N DE BIOM…TRICO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103403,0,'ERROR: NO EXISTE EL PARAMETRO RENCHN PARA LA CONEXI”N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103404,0,'ERROR: NO EXISTE EL PARAMETRO RENBRN PARA LA CONEXI”N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103405,0,'ERROR: NO EXISTE EL PARAMETRO RENTTP PARA LA CONEXI”N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103406,0,'ERROR: NO EXISTE EL PARAMETRO RENTI1 PARA LA CONEXI”N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103407,0,'ERROR: NO EXISTE EL PARAMETRO RENTI2 PARA LA CONEXI”N CON RENAPO')

insert into cobis..cl_errores(numero, severidad, mensaje) 
values (103408,0,'ERROR: NO SE PUDO CONSULTAR BURO PORQUE LOS CLIENTES NO HAN SIDO VALIDADOS EN RENAPO.')

insert into  cl_errores(numero, severidad, mensaje) 
values (601321, 0, 'ERROR: No existen equivalencias para el cat·logo consultado.')  

go