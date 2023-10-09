/***********************************************************************************************************/
---No Bug					: Bug 82879:Bug 
---Título del Bug			: De moviminetos - registros duplicados
---Fecha					: 14/09/2016 
--Descripción del Problema	: Data inconsistente en el ambiente de pruebas que duplica registros en la pantalla
--                            de busqueda de cuentas, se analizó con PO, pero se desconoce el motivo
--Descripción de la Solución: Remediación para eliminación de data erronea
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-- no se modifica archivo alguno porque es error de DATA
if exists (select 1 from cobis..cl_cliente where cl_cliente = 101 and cl_det_producto in (127))	
begin  
	delete from cobis..cl_cliente where cl_cliente = 101 and cl_det_producto in (127)
	print 'Se limina cl_cliente 101 Prodcuto 127'
end

if exists (select 1 from cobis..cl_det_producto where dp_cuenta = '702004000017' and dp_det_producto = 127)	
begin  
	delete from cobis..cl_det_producto where dp_cuenta = '702004000017' and dp_det_producto = 127
	print 'Se elimina cl_det_producto cuenta 702004000017 y producto 127'
end

go    