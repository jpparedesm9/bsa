/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 02/08/2016 
--Descripción del Problema	: Codigo de Producto BAncario Incorrecto
--Descripción de la Solución: se crea script de remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

------------------------------------------------------------------------
use cob_remesas
go

-- pe_parametria - l:1078

declare @w_ordinario int
declare @w_adicional int

select @w_ordinario = pb_pro_bancario from cob_remesas..pe_pro_bancario where pb_descripcion = 'APORTE SOCIAL ORDINARIO'
select @w_adicional = pb_pro_bancario from cob_remesas..pe_pro_bancario where pb_descripcion = 'APORTE SOCIAL ADICIONAL'

update cobis..cl_parametro
set pa_int = @w_ordinario
where  pa_producto = 'AHO'
and    pa_nemonico = 'PCAASO'

update cobis..cl_parametro
set pa_int = @w_adicional
where  pa_producto = 'AHO'
and    pa_nemonico = 'PCAASA'

go