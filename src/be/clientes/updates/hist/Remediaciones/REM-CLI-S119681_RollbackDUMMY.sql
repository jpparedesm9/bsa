/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : CGS-S119681 Impresi�n de Documentos - Documentos (3) - II Parte - Flujo Grupal
--Fecha                      : 11/07/2017
--Descripci�n del Problema   : Pagina DUMMY para prueba de Reporte Grupales
--Descripci�n de la Soluci�n : Borrar Pagina DUMMY
--                             y registro de pantalla DUMMY
--Autor                      : Walther Toledo
--Instalador                 : NA
--Ruta Instalador            : NA
/**********************************************************************************************************************/
use cobis
go
-- BORRANDO LA PANTALLA DUMMY

declare @w_secuencial int, @w_rol int
select @w_secuencial = me_id from cobis..cew_menu where me_name = 'MNU_RPT_GRUPALES'
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion='MENU POR PROCESOS'

delete from cobis..cew_menu where me_name = 'MNU_RPT_GRUPALES'
delete from cobis..cew_menu_role where mro_id_menu = @w_secuencial

go

