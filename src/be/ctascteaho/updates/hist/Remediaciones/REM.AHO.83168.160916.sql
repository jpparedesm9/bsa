/***********************************************************************************************************/
---No historia  			: 83168
---Título del Bug			: Validación cuando se repite el registro de un deposito por servicio
---Fecha					: 16/Sep/2016 
--Descripción del Problema	: Permitía ejecutar inserción de deposito a pesar de que ya existía transacción
--Descripción de la Solución: Se agrega validación de secuencial de deposito repetido
--Autor						: Tania Baidal
/***********************************************************************************************************/

--ah_error.sql
use cobis
go
delete cl_errores where numero = 357056

insert into cl_errores (numero, severidad, mensaje) values (357056, 0, 'YA EXISTE DEPOSITO INGRESADO CON EL SECUENCIAL')
