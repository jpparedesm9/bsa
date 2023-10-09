/***********************************************************************/
--No Bug:
--Título del Bug: crear nuevo parametro
--Fecha:2017-06-15
--Descripción del Problema:
--crear nuevo parametro para controlar multiplo de 500
--Descripción de la Solución: crear campos
--Autor:LGU
/***********************************************************************/

/* CARGA PARAMETROS CARTERA */

use cob_cartera
go

/* PARAMETROS GENERALES */

delete cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico in ('MUL500')
go
insert into cobis..cl_parametro values('MULTIPLO PARA MONTOS GRUPALES', 'MUL500', 'M', null, null, null, null, 500, null, null,'CCA')

GO

SELECT * FROM cobis..cl_parametro
 where pa_producto = 'CCA'
   and pa_nemonico in ('MUL500')
go

go



