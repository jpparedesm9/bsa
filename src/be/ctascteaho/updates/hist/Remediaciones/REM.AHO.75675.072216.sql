/***********************************************************************************************************/
---No Historia				: 75675
---Título del Bug			: Sqrs migrados
---Fecha					: 06/07/2016 
--Descripción del Problema	: 
--Descripción de la Solución: se crea script de remediación con los errores para los sqrs: ah_ahinitbl.sp, ahvaltmp.sp,ah_errbatch.sp,ahenvioctadtn.sp 
--Autor						: Pedro Montenegro / Tania Baidal
/***********************************************************************************************************/

--Ahorros/Backend/sql/ah_error.sql

use cobis
go

delete from cobis..cl_errores where numero in (357020, 357021, 357022, 357023, 357024, 357025)

insert into cl_errores (numero, severidad, mensaje) 
values (357020, 1, 'ERROR AL CREAR UNA TABLA')

insert into cl_errores (numero, severidad, mensaje) 
values (357021, 1, 'ERROR AL ELIMINAR UNA TABLA')

insert into cl_errores (numero, severidad, mensaje) 
values (357022, 1, 'ERROR AL CONSULTAR EXISTENCIA DE OBJETO')

insert into cl_errores (numero, severidad, mensaje) 
values (357023, 1, 'ERROR AL EJECUTAR EL BCP')

insert into cl_errores (numero, severidad, mensaje) 
values (357024, 1, 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE')

insert into cl_errores (numero, severidad, mensaje) 
values (357025, 1, 'NO EXISTE SENTENCIA A EJECUTAR')

GO
