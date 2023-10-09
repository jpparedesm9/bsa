/**********************************************************************************************************************/
--No Bug                            : Instalador
--Título de la Historia           	: REPORTE OPERATIVO
--Fecha                           	           : 07/06/2017
--Descripción del Problema 		  	: No se muestra Menú Valores/Tasas
--Descripción de la Solución      	: Se agrega menú
--Autor                             :Sonia Rojas
--Instalador                 		: ca_menu.sql
--Ruta Instalador            		: $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
/**********************************************************************************************************************/

use cobis
go

declare @w_id_parent 	int,
		@w_old_menu 	int,
		@num			int

select @w_old_menu = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_VALUES_RATES'

delete from cobis..cew_menu_role where mro_id_menu = @w_old_menu
delete from cobis..cew_menu where me_name = 'MNU_ASSETS_VALUES_RATES'

select @w_id_parent = me_id from cobis..cew_menu where me_name= 'MNU_ASSETS_ADM'

select @num= (max(me_id)+1) from cobis..cew_menu

insert into cew_menu(me_id,me_id_parent,me_name,me_url,me_id_cobis_product)
values(@num,@w_id_parent,'MNU_ASSETS_VALUES_RATES','views/ASSTS/MNTNN/T_VALUERATESFBO_932/1.0.0/VC_VALUERATEE_334932_TASK.html',7)

insert into cobis..cew_menu_role(mro_id_menu,mro_id_role)
values(@num,3)
go