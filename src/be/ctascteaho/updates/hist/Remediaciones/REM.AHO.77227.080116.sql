/***********************************************************************************************************/
---No historia  			: 77227
---Título del Bug			: Sarta inicio de dia
---Fecha					: 28/Jul/2016 
--Descripción del Problema	: Existen actualmente 2 sartas para ahorros, las demás no deberían existir
--Descripción de la Solución: Se eliminan las sartas
--Autor						: Tania Baidal
/***********************************************************************************************************/

use cobis
go

--No se incluye en instalador ah_batch
delete from cobis..ba_sarta where sa_producto=4 and sa_sarta in (7,4004,4005,4100,4102,4103,4201,4202,4203,4204,26001)

go

