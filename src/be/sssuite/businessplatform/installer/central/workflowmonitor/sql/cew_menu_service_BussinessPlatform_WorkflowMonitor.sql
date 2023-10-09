/*************************************************** WorkflowMonitor ***************************************************/
use cobis
go

declare @w_id_menu int,@w_moneda tinyint, @w_id_producto int,@w_tipo varchar(20)
select @w_id_menu 	= me_id from cobis..cew_menu where me_name = 'MNU_WORKFLOW_STATISTICS'
select @w_id_producto	= pd_producto from cobis..cl_producto where pd_abreviatura='CWF'
select @w_tipo		= 'R'
select @w_moneda   	= 0

print 'Workflow Stadistics'

insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.GetActivitySummary',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.GetOfficeByUser',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.GetProcessVersions',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.GetSummaryByProcessId',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.ObtenerResumen',@w_id_producto,@w_tipo,@w_moneda)
insert into cew_menu_service values(@w_id_menu,'WFMonitor.Proceso.QueryActivities',@w_id_producto,@w_tipo,@w_moneda)

insert into cew_menu_service values(@w_id_menu,'CEW.Preferences.getUserPreferences',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                           
insert into cew_menu_service values(@w_id_menu,'CEW.Official.GetOfficialInfo',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                                 
insert into cew_menu_service values(@w_id_menu,'CEW.Favorites.getUserFavorites',@w_id_producto,@w_tipo,@w_moneda)                                                                                                                                               

go
