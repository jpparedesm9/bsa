
/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : NA
--Fecha                      : 01/09/2017
--Descripci�n del Problema   : No existen errores
--Descripci�n de la Soluci�n : Agregar errores faltantes
--Autor                      : Pa�l Ortiz Vera
/**********************************************************************************************************************/

use cobis
go

--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql

delete cl_errores where numero IN (107352,208924)

insert into cobis..cl_errores VALUES(107352,0, 'Residencia es requerida para verificar Buro')
go

--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_errores.sql

insert into cobis..cl_errores VALUES(208924,0, 'Error al ejecutar Bur�, no existen todos los par�metros requeridos para el cliente')
go

--Corregir para que no aparezca en el menu

if exists (select 1 from cobis..cew_menu where me_name = 'MNU_MOBILE_DIVICE_POP')
begin
	
	delete cobis..cew_menu_role
	WHERE mro_id_menu = (select me_id from cobis..cew_menu where me_name = 'MNU_MOBILE_DIVICE_POP')

	delete cobis..cew_menu
	WHERE me_name = 'MNU_MOBILE_DIVICE_POP'
	
end