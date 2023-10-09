/***********************************************************************************************************/
---No Bug					: Bug 84254:BUG: 
---Título del Bug			: Solicitud de Apertura de Cuentas
---Fecha					: 14/09/2016 
--Descripción del Problema	: Inconvenientes en pantalla de Solicutud y apertura
--Descripción de la Solución: Remediación para eliminación de data faltante
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-- pe_error.sql
if not exists (select 1 from cobis..cl_errores where numero = 357563)	
begin  
	insert into cobis..cl_errores values (357563, 0, 'CLIENTE NO POSEE CUENTA CON PRODUCTO BANCARIO DEPENDIENTE ACTIVA')
	print 'Se inserta error 357563'
end

go    