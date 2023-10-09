
/***********************************************************************************************************/

---Fecha					: 01/01/2016 
--Descripción del Problema	: codigo error 351517
--Descripción de la Solución: se crea script de remediación
--Autor						: Karen Meza
/***********************************************************************************************************/

------------------------------------------------------------------------

use cobis
go

----pe_error.sql------
delete cl_errores where numero =351517
insert into cl_errores values (351517, 0,  'Ya existe codigo de Producto Final')

go

