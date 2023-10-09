/***********************************************************************************************************/
---No Bug					: 78240
---Título del Bug			: Consulta de Solicitudes de Apertura
---Fecha					: Julio/20/2016 
--Descripción del Problema	: No se presentan datos en Territorial
--Descripción de la Solución: se crea script de remediación
--Autor						: Tania Baidal
/***********************************************************************************************************/

--Dependencias\sql\adm_oficina.sql 

use cobis
go

update cl_oficina set of_bloqueada = 'N'
where of_subtipo in ( 'R','Z')
and of_bloqueada is null