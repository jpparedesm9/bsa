/***********************************************************************************************************/
---No Bug					: 77500
---Título del Bug			: Operaciones superiores a un monto en cuentas de ahorros
---Fecha					: Julio/18/2016 
--Descripción del Problema	: No se habilita botón Imprimir
--Descripción de la Solución: se crea script de remediación
--Autor						: Tania Baidal
/***********************************************************************************************************/

--Ahorros\Backend\sql\ah_param.sql 
--Nota: Se modifica el valor del parámetro solo para pruebas

use cobis
go

if exists (  select  1  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'VPSA')
begin
  update cobis..cl_parametro set pa_money = 400
    where  pa_producto = 'AHO'
     and pa_nemonico = 'VPSA'
end

