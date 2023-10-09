/**********************************************************************************************************************/
--No Bug                            : Instalador
--Título de la Historia           	: REPORTE OPERATIVO
--Fecha                           	           : 07/06/2017
--Descripción del Problema 		  	: Reorganización menú Garantías
--Descripción de la Solución      	: Actualización menús
--Autor                             : Sonia Rojas
--Instalador                 		: cu_menu.sql
--Ruta Instalador            		: $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
/**********************************************************************************************************************/

use cobis
go

declare @w_id_parent 	int


select @w_id_parent = me_id from cobis..cew_menu where me_name= 'MNU_WARR_MANT'

if @w_id_parent is not null
begin
update cobis..cew_menu
   set me_id_parent = @w_id_parent
 where  me_name='MNU_WARR_MANT_CREATION'

update cobis..cew_menu
   set me_id_parent = @w_id_parent
 where  me_name='MNU_WARR_MANT_MODIFICATION'
 
end


select @w_id_parent = me_id from cobis..cew_menu where me_name= 'MNU_QUERY'
if @w_id_parent is not null
begin

update cobis..cew_menu
   set me_id_parent = @w_id_parent
 where  me_name='MNU_WARRANTIESQUERY'
end



select @w_id_parent = me_id from cobis..cew_menu where me_name= 'MNU_WARRANTIESQUERY'
if @w_id_parent is not null
begin

update cobis..cew_menu
   set me_id_parent = @w_id_parent
 where  me_name='MNU_WARRANTIESQUERY_GENERAL'
end

go
