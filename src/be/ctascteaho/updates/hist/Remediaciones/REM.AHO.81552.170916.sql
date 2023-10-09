/***********************************************************************************************************/
---No historia  			: 81552
---Título del Bug			: Errores no existentes de carga masiva en ambiente de sustaining 
---Fecha					: 16/Sep/2016 
--Descripción del Problema	: Errores no existentes de carga masiva en ambiente de sustaining
--Descripción de la Solución: Se insertan errores de carga masiva de transacciones
--Autor						: Tania Baidal
/***********************************************************************************************************/

--ah_error.sql
use cobis
go

delete cl_errores where numero in (
357027,357028,357029,357030,357031,357032,357033,357034,357035,357036,
357037,357038,357039,357040,357041,357042,357043,357044,357045,357046,
357047,357048,357049,357050,357051,357052,357053,357054,357055,357056
)
go
insert into cl_errores (numero, severidad, mensaje) values (357027, 0, 'TRANSACCION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357028, 0, 'CUENTA COBIS Y CUENTA MIGRADA TIENEN VALORES NULOS')
insert into cl_errores (numero, severidad, mensaje) values (357029, 0, 'CUENTA MIGRADA NO ESTÁ RELACIONADA CON CUENTA COBIS')
insert into cl_errores (numero, severidad, mensaje) values (357030, 0, 'CHEQUE NO CORRESPONDE A TRANSACCION VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357031, 0, 'VALOR DE LA TRANSACCION NO VALIDO')
insert into cl_errores (numero, severidad, mensaje) values (357032, 0, 'VALOR DE CHEQUES NO COINCIDE CON LA SUMA DEL DETALLE DE CHEQUES')
insert into cl_errores (numero, severidad, mensaje) values (357033, 0, 'CAUSA ES MANDATORIA  PARA N/D Y N/C')
insert into cl_errores (numero, severidad, mensaje) values (357034, 0, 'MONTO EN CHEQUE NO ES VALIDO PARA LAS TRANSACCIONES: RETIRO, ND Y NC')
insert into cl_errores (numero, severidad, mensaje) values (357035, 0, 'ERROR AL INSERTAR EN EL LOG DE ERRORES')
insert into cl_errores (numero, severidad, mensaje) values (357036, 0, 'ERROR AL ACTUALIZAR ESTADO DE UNO O VARIOS REGISTROS')
insert into cl_errores (numero, severidad, mensaje) values (357037, 0, 'CODIGO DEL BANCO NO ES VALIDO')
insert into cl_errores (numero, severidad, mensaje) values (357038, 0, 'ERROR AL INSERTAR EL NUMERO DE CUENTA COBIS EN EL REGISTRO')
insert into cl_errores (numero, severidad, mensaje) values (357039, 0, 'FECHA DE EMISION NO VALIDA')
insert into cl_errores (numero, severidad, mensaje) values (357040, 0, 'CHEQUE REPETIDO')
insert into cl_errores (numero, severidad, mensaje) values (357041, 0, 'ORIGEN DE REMESAS NO ES VALIDO. VALIDAR CATALOGO')
insert into cl_errores (numero, severidad, mensaje) values (357042, 0, 'ORIGEN DE REMESAS ES VALIDO SOLO PARA DEPOSITOS EN EFECTIVO')
insert into cl_errores (numero, severidad, mensaje) values (357043, 0, 'ERROR AL INSERTAR DATOS DE LA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357044, 0, 'PARAMETRO TOTAL DE DEPOSITO NO COINCIDE CON SUMA DE VALORES ENVIADOS')
insert into cl_errores (numero, severidad, mensaje) values (357045, 0, 'PARAMETRO FECHA ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357046, 0, 'PARAMETRO FILIAL ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357047, 0, 'PARAMETRO SECUENCIAL Y SECUENCIAL BRANCH SON MANDATORIOS')
insert into cl_errores (numero, severidad, mensaje) values (357048, 0, 'NO EXISTEN CHEQUES VALIDOS PARA ESTA TRANSACCION')
insert into cl_errores (numero, severidad, mensaje) values (357049, 0, 'PARAMETRO SECUENCIAL DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357050, 0, 'PARAMETRO CODIGO DE BANCO DEL CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357051, 0, 'PARAMETRO CUENTA DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357052, 0, 'PARAMETRO NUMERO DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357053, 0, 'PARAMETRO FECHA DE EMISION DE CHEQUE ES MANDATORIO')
insert into cl_errores (numero, severidad, mensaje) values (357054, 0, 'NO EXISTE DEPOSITO CORRESPONDIENTE AL SECUENCIAL')
insert into cl_errores (numero, severidad, mensaje) values (357055, 0, 'ERROR AL EJECUTAR INTERFASE')
insert into cl_errores (numero, severidad, mensaje) values (357056, 0, 'YA EXISTE DEPOSITO INGRESADO CON SECUENCIAL')
go
