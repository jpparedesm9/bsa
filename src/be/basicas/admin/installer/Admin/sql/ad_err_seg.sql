/************************************************************************/
/*	Archivo:		ad_err_seg.sql			                            */
/*	Base de datos:	cobis					                            */
/*	Producto:		Admin					                            */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	'COBISCORP'                                                         */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de COBISCORP o su representante.		        */
/*				PROPOSITO				                                */
/*	Este script ingresa los mensajes de error de existencia para ADMIN	*/
/*				MODIFICACIONES				                            */
/*      FECHA           AUTOR     RAZON                                 */
/*      2016-04-14      BBO       Migracion SYB-SQL FAL                 */
/*      28/06/2016     J.Hdez    Ajuste Vesion Falabella funcionario    */
/************************************************************************/
use cobis
go
delete cl_errores where numero 
	between 0 and 149999
go

print '=====> INGRESO DE MENSAJES DE ERROR DE EXISTENCIA'

insert into cl_errores values (101000, 0, 'NO EXISTE DATO EN CATALOGO')
insert into cl_errores values (101001, 0, 'NO EXISTE DATO SOLICITADO')
insert into cl_errores values (101002, 0, 'NO EXISTE FILIAL')
insert into cl_errores values (101003, 1, 'NO EXISTE TABLA')
insert into cl_errores values (101010, 0, 'DEPARTAMENTO NO EXISTE')
insert into cl_errores values (101011, 0, 'JEFE NO EXISTE')
insert into cl_errores values (101012, 0, 'NO EXISTE CARGO')
insert into cl_errores values (101016, 0, 'NO EXISTE OFICINA')
insert into cl_errores values (101017, 0, 'NO EXISTE ROL DE EMPRESA')
insert into cl_errores values (101018, 0, 'NO EXISTE PAIS')
insert into cl_errores values (101024, 0, 'NO EXISTE DISTRITO')
insert into cl_errores values (101027, 0, 'NO EXISTE ACTIVIDAD ECONOMICA')
insert into cl_errores values (101028, 0, 'NO EXISTE SUCURSAL')
insert into cl_errores values (101031, 0, 'NO EXISTE PRODUCTO MONEDA')
insert into cl_errores values (101032, 0, 'NO EXISTE PRODUCTO')
insert into cl_errores values (101033, 0, 'NO EXISTE PRODUCTO OFICINA')
insert into cl_errores values (101034, 0, 'NO EXISTE PRODUCTO ASOCIADO')
insert into cl_errores values (101035, 0, 'NO EXISTE DEPARTAMENTO EN OFICINA')
insert into cl_errores values (101036, 0, 'NO EXISTE FUNCIONARIO')
insert into cl_errores values (101038, 0, 'NO EXISTE DEPARTAMENTO')
insert into cl_errores values (101039, 0, 'NO EXISTE REGION NATURAL')
insert into cl_errores values (101040, 0, 'NO EXISTE REGION OPERATIVA')
insert into cl_errores values (101041, 0, 'NO EXISTE TIPO DE BARRIO')
insert into cl_errores values (101045, 0, 'NO EXISTE MONEDA')
insert into cl_errores values (101046, 0, 'SUBTIPO NO VALIDO')
insert into cl_errores values (101049, 0, 'NO EXISTE DISTRIBUTIVO')
insert into cl_errores values (101051, 0, 'NO EXISTE VACANTE')
insert into cl_errores values (101056, 0, 'NO EXISTE ROL')
insert into cl_errores values (101057, 0, 'DEPARTAMENTO SUPERIOR IGUAL A DEPARTAMENTO INFERIOR')
insert into cl_errores values (101058, 0, 'TRABAJADOR JEFE DE SI MISMO')
insert into cl_errores values (101062, 0, 'NOMBRE DE LOGIN YA HA SIDO ASIGNADO')
insert into cl_errores values (101063, 0, 'EXISTE REFERENCIA EN USUARIO-ROL')
insert into cl_errores values (101064, 0, 'EL TRABAJADOR ESTA REGISTRADO EN ALGUN NODO')
insert into cl_errores values (101065, 0, 'EXISTEN TRABAJADORES ASIGNADOS A DEPARTAMENTO')
insert into cl_errores values (101067, 0, 'EXISTE REFERENCIA EN SERVER-LOGICO')
insert into cl_errores values (101068, 0, 'EXISTE REFERENCIA EN PRO-TRANSACCION')
insert into cl_errores values (101069, 0, 'EXISTE REFERENCIA EN PRO-ROL')
insert into cl_errores values (101070, 0, 'EXISTE REFERENCIA EN PRO-OFICINA')
insert into cl_errores values (101071, 0, 'EXISTE REFERENCIA EN DEPARTAMENTO')
insert into cl_errores values (101072, 0, 'EXISTE REFERENCIA EN DISTRITO')
insert into cl_errores values (101073, 0, 'EXISTE REFERENCIA EN BARRIO')
insert into cl_errores values (101074, 0, 'PAIS NO ESTA VIGENTE')
insert into cl_errores values (101075, 0, 'DEPARTAMENTO NO ESTA VIGENTE')
insert into cl_errores values (101076, 0, 'DISTRITO NO ESTA VIGENTE')
insert into cl_errores values (101077, 0, 'NO EXISTE PARAMETRO')
insert into cl_errores values (101078, 0, 'NO EXISTE DATO DE DEFAULT')
insert into cl_errores values (101092, 0, 'EXISTE REFERENCIA EN DEFAULT DE TRANSACCION')
insert into cl_errores values (101095, 0, 'TIPO DE DATO NO CORRESPONDE A PARAMETRO ESCOGIDO')
insert into cl_errores values (101102, 0, 'EL CODIGO DE CATALOGO NO PUEDE SER NULO') 
insert into cl_errores values (101103, 0, 'LA DESCRIPCION DE CATALOGO NO PUEDE SER NULA') 
insert into cl_errores values (101104, 0, 'EL CODIGO PARA ESTA TABLA YA EXISTE') 
insert into cl_errores values (101105, 0, 'NIT ESPECIFICADO YA EXISTE') 
insert into cl_errores values (101112, 0, 'LA TABLA FUE CREADA ANTERIORMENTE') 
insert into cl_errores values (101114, 0, 'PARAMETROS INVALIDOS') 
insert into cl_errores values (101132, 0, 'NO EXISTE ZONA') 
insert into cl_errores values (101135, 0, 'YA EXISTE ESA SUCURSAL EN ESE DEPARTAMENTO') 
insert into cl_errores values (101151, 0, 'BARRIO YA EXISTE EN ESE DISTRITO')
insert into cl_errores values (101152, 0, 'PAIS YA EXISTE')       
insert into cl_errores values (101154, 0, 'NO PUEDE CAMBIAR FERIADO CON FECHA ANTERIOR O ACTUAL')
insert into cl_errores values (107201, 0, 'LOGIN PERTENECE A UN OFICIAL, UTILICE EL BUZON PAR DESBLOQUEAR')
insert into cl_errores values (107202, 0, 'USUARIO TIENE SESIONES DE BUZON ACTIVAS')
insert into cl_errores values (107203, 0, 'EL USUARIO NO TIENE SESION BLOQUEADA')
go


print '=====> INGRESO DE MENSAJES DE ERROR DE ACTUALIZACION'
go

insert into cl_errores values (105000, 1, 'ERROR EN ACTUALIZACION DE CATALOGO')
insert into cl_errores values (105001, 1, 'ERROR EN ACTUALIZACION DE SEQNOS')
insert into cl_errores values (105004, 1, 'ERROR EN ACTUALIZACION DE DEPARTAMENTO')
insert into cl_errores values (105005, 1, 'ERROR EN ACTUALIZACION DE PRODUCTO')
insert into cl_errores values (105018, 1, 'ERROR EN ACTUALIZACION DE PAIS')
insert into cl_errores values (105019, 1, 'ERROR EN ACTUALIZACION DE DISTRITO')
insert into cl_errores values (105023, 1, 'ERROR EN ACTUALIZACION DE MONEDA')
insert into cl_errores values (105028, 1, 'ERROR EN ACTUALIZACION DE ROL')
insert into cl_errores values (105032, 1, 'ERROR EN ACTUALIZACION DE PRODUCTO')
insert into cl_errores values (105035, 1, 'ERROR EN ACTUALIZACION DE TELEFONO')
insert into cl_errores values (105038, 1, 'ERROR EN ACTUALIZACION DE DEPARTAMENTO')
insert into cl_errores values (105039, 1, 'ERROR EN ACTUALIZACION DE BARRIO')
insert into cl_errores values (105040, 1, 'ERROR EN ACTUALIZACION DE REGION NATURAL')
insert into cl_errores values (105044, 1, 'ERROR EN ACTUALIZACION DE TRABAJADOR')
insert into cl_errores values (105049, 1, 'ERROR EN ACTUALIZACION DE OFICINA')
insert into cl_errores values (105055, 1, 'ERROR EN ACTUALIZACION DE DEFAULT')
insert into cl_errores values (105056, 1, 'ERROR EN ACTUALIZACION DE TABLA DE CATALOGO')
insert into cl_errores values (105064, 1, 'ERROR EN ACTUALIZACION DE SUCURSAL DE CORREO')
go

print '=====> INGRESO DE MENSAJES DE ERROR DE CREACION'


insert into cl_errores values (103003, 1, 'ERROR EN CREACION DE PRODUCTO')
insert into cl_errores values (103004, 1, 'ERROR EN CREACION DE DEPARTAMENTO')
insert into cl_errores values (103005, 1, 'ERROR EN CREACION DE TRANSACCION DE SERVICIO')
insert into cl_errores values (103015, 1, 'ERROR EN CREACION DE CATALOGO')
insert into cl_errores values (103017, 1, 'ERROR EN CREACION DE CARGO')
insert into cl_errores values (103018, 1, 'ERROR EN CREACION DE PAIS')
insert into cl_errores values (103019, 1, 'ERROR EN CREACION DE DISTRITO')
insert into cl_errores values (103023, 1, 'ERROR EN CREACION DE MONEDA')
insert into cl_errores values (103028, 1, 'ERROR EN CREACION DE ROL')
insert into cl_errores values (103032, 1, 'ERROR EN CREACION DE PRODUCTO')
insert into cl_errores values (103034, 1, 'ERROR EN CREACION DE DIS_SEQNOS')
insert into cl_errores values (103035, 1, 'ERROR EN CREACION DE DISTRIBUTIVO')
insert into cl_errores values (103036, 1, 'ERROR EN CREACION DE FILIAL')
insert into cl_errores values (103037, 1, 'ERROR EN CREACION DE PRODUCTO ASOCIADO')
insert into cl_errores values (103038, 1, 'ERROR EN CREACION DE TELEFONO')
insert into cl_errores values (103040, 1, 'ERROR EN CREACION DE REGION OPERATIVA')
insert into cl_errores values (103041, 1, 'ERROR EN CREACION DE BARRIO')
insert into cl_errores values (103042, 1, 'ERROR EN CREACION DE REGION NATURAL')
insert into cl_errores values (103043, 1, 'ERROR EN CREACION DE DEPARTAMENTO')
insert into cl_errores values (103046, 1, 'ERROR EN CREACION DE TRABAJADOR')
insert into cl_errores values (103049, 1, 'ERROR EN CREACION DE OFICINA')
insert into cl_errores values (103051, 1, 'ERROR EN CREACION DE DIAS LABORABLES')
insert into cl_errores values (103052, 1, 'ERROR EN CREACION DE DIAS SABADO')
insert into cl_errores values (103053, 1, 'ERROR EN CREACION DE DIAS DOMINGO')
insert into cl_errores values (103054, 1, 'ERROR EN CREACION DE PARAMETRO')
insert into cl_errores values (103055, 1, 'ERROR EN CREACION DE DEFAULT')
insert into cl_errores values (103058, 1, 'ERROR EN CREACION DE DEFAULT DE TRANSACCION')
insert into cl_errores values (103060, 1, 'ERROR EN CREACION DE CATALOGO-PRODUCTO')
insert into cl_errores values (103063, 1, 'ERROR EN CREACION DE TABLA DE CATALOGO')
insert into cl_errores values (103069, 1, 'ERROR EN INSERCION DE SUCURSAL DE CORREO')
go


print '=====> INGRESO DE MENSAJES DE ERROR DE ELIMINACION'
go

insert into cl_errores values (107003, 1, 'ERROR EN ELIMINACION DE PRODUCTO')
insert into cl_errores values (107004, 1, 'ERROR EN ELIMINACION DE DEPARTAMENTO')
insert into cl_errores values (107015, 1, 'ERROR EN ELIMINACION DE CATALOGO')
insert into cl_errores values (107016, 1, 'ERROR EN ELIMINACION DE ACTIVIDAD')
insert into cl_errores values (107017, 1, 'ERROR EN ELIMINACION DE CARGO')
insert into cl_errores values (107018, 1, 'ERROR EN ELIMINACION DE PAIS')
insert into cl_errores values (107019, 1, 'ERROR EN ELIMINACION DE DISTRITO')
insert into cl_errores values (107023, 1, 'ERROR EN ELIMINACION DE MONEDA')
insert into cl_errores values (107028, 1, 'ERROR EN ELIMINACION DE ROL')
insert into cl_errores values (107032, 1, 'ERROR EN ELIMINACION DE PRODUCTO')
insert into cl_errores values (107034, 1, 'ERROR EN ELIMINACION DE DIS_SEQNOS')
insert into cl_errores values (107035, 1, 'ERROR EN ELIMINACION DE DISTRIBUTIVO')
insert into cl_errores values (107036, 1, 'ERROR EN ELIMINACION DE FILIAL')
insert into cl_errores values (107037, 1, 'ERROR EN ELIMINACION DE PRODUCTO ASOCIADO')
insert into cl_errores values (107038, 1, 'ERROR EN ELIMINACION DE TELEFONO')
insert into cl_errores values (107042, 1, 'ERROR EN ELIMINACION DE REGION NATURAL')
insert into cl_errores values (107043, 1, 'ERROR EN ELIMINACION DE DEPARTAMENTO')
insert into cl_errores values (107046, 1, 'ERROR EN ELIMINACION DE TRABAJADOR')
insert into cl_errores values (107049, 1, 'ERROR EN ELIMINACION DE OFICINA')
insert into cl_errores values (107050, 1, 'ERROR EN ELIMINACION DE PRO-OFICINA')
insert into cl_errores values (107051, 1, 'ERROR EN ELIMINACION DE PRO-MONEDA')
insert into cl_errores values (107052, 1, 'ERROR EN ELIMINACION DE DEFAULT DE TRANSACCION')
insert into cl_errores values (107053, 1, 'ERROR EN ELIMINACION DE CATALOGO-PRODUCTO')
insert into cl_errores values (107060, 1, 'ERROR EN ELIMINACION DE SUCURSAL DE CORREO')
go
