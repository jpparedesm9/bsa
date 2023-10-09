/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 31/08/2016 
--Descripción del Problema	: Creación Categorias para Aporte Social y Campo para Capitalización ProFinal
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

use cobis
go

-------------------------------------------------
-- CAMPO ca_dias_plazo en ah_cuenta_aux -- ah_table.sql
-------------------------------------------------

use cob_ahorros
go
print '====> cob_ahorros..ah_cuenta_aux'

if exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ah_cuenta_aux' AND COLUMN_NAME = 'ca_dias_capi') 
BEGIN
      ALTER TABLE cob_ahorros..ah_cuenta_aux 
	  DROP COLUMN ca_dias_capi          
end  
go

if NOT exists(select 1 from INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ah_cuenta_aux' AND COLUMN_NAME = 'ca_dias_plazo') 
BEGIN
      ALTER TABLE cob_ahorros..ah_cuenta_aux 
	  add ca_dias_plazo int  null          
end  
go

