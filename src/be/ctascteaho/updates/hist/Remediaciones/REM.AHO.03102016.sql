/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 03/10/2016 
--Descripción del Problema	: Actualización de Parametro PAP
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-- ah_param.sql

update cobis..cl_parametro 
set pa_tinyint = 0
where pa_nemonico = 'PAP'
and pa_producto = 'AHO'

go