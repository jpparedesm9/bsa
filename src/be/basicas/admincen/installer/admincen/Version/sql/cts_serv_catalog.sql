use cobis
go
delete from cts_serv_catalog 
where csc_service_id like 'Admin.AdminCEN.%' or
      csc_service_id like 'AdminCEN.ComponentConfigService.%' or
      csc_service_id like 'AdminCEN.LabelConfigService.%' or
      csc_service_id like 'AdminCEN.ModuleConfigService.%'
go

insert into cts_serv_catalog values('Admin.AdminCEN.ModuleConfigService.QueryModuleAll','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','queryModuleAll','Busqueda de todos los modulos',15341, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleConfigService.QueryModuleId','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','queryModuleId','Busqueda de modulos por el ID',15341, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleConfigService.SearchModule','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','searchModule','Busqueda de modulos',15340, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.DeleteModuleGroup','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','deleteModuleGroup','Eliminacion de grupo de modulos',15329, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.InsertModuleGroup','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','insertModuleGroup','Ingreso de grupo de modulos',15327, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.QueryModuleGroupAll','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','queryModuleGroupAll','Busqueda de todos los grupo de modulos',15331, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.QueryModuleGroupId','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','queryModuleGroupId','Busqueda de Grupo de modulos por ID',15331, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.SearchModuleGroup','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','searchModuleGroup','Busqueda de Grupo de modulos',15330, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.ModuleGroupConfigService.UpdateModuleGroup','cobiscorp.ecobis.admin.admincen.service.IModuleGroupConfigService','updateModuleGroup','Actualizacion de Grupos de modulos',15328, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.NavigationZoneConfigService.DeleteNavigationZone','cobiscorp.ecobis.admin.admincen.service.INavigationZoneConfigService','deleteNavigationZone','Eliminacion de Zonas de navegacion',15379, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.NavigationZoneConfigService.InsertNavigationZone','cobiscorp.ecobis.admin.admincen.service.INavigationZoneConfigService','insertNavigationZone','Ingreso de zonas de navegacion',15377, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.NavigationZoneConfigService.SearchNavigationZone','cobiscorp.ecobis.admin.admincen.service.INavigationZoneConfigService','searchNavigationZone','Busqueda de Zonas de Navegacion',15380, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.NavigationZoneConfigService.UpdateNavigationZone','cobiscorp.ecobis.admin.admincen.service.INavigationZoneConfigService','updateNavigationZone','Actualizacion de Zonas de Navegacion',15378, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.DeletePage','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','deletePage','Eliminacion de paginas',15379, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.InsertPage','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','insertPage','Ingreso de paginas',15377, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.QueryPageAll','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','queryPageAll','Busqueda de todas las paginas',15359, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.QueryPageId','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','queryPageId','Busqueda de paginas por ID',15359, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.SearchPage','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','searchPage','Busqueda de paginas',15380, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageConfigService.UpdatePage','cobiscorp.ecobis.admin.admincen.service.IPageConfigService','updatePage','Actualizacion de paginas',15378, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageZoneConfigService.DeletePageZone','cobiscorp.ecobis.admin.admincen.service.IPageZoneConfigService','deletePageZone','Eliminacion de Zonas de pagina',15362, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageZoneConfigService.InsertPageZone','cobiscorp.ecobis.admin.admincen.service.IPageZoneConfigService','insertPageZone','Ingreso de Zonas de Pagina',15360, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageZoneConfigService.SearchPageZone','cobiscorp.ecobis.admin.admincen.service.IPageZoneConfigService','searchPageZone','Busqueda de Zonas de Pagina',15363, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PageZoneConfigService.UpdatePageZone','cobiscorp.ecobis.admin.admincen.service.IPageZoneConfigService','updatePageZone','Actualizacion de Zonas de PAgina',15361, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PrereqPageConfigService.DeletePrereqPage','cobiscorp.ecobis.admin.admincen.service.IPrereqPageConfigService','deletePrereqPage','Eliminacion de Prerequisitos de pagina',15371, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PrereqPageConfigService.InsertPrereqPage','cobiscorp.ecobis.admin.admincen.service.IPrereqPageConfigService','insertPrereqPage','Ingresar prerequisitos de pagina',15369, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.PrereqPageConfigService.SearchPrereqPage','cobiscorp.ecobis.admin.admincen.service.IPrereqPageConfigService','searchPrereqPage','Busqueda de prerequisitos de pagina',15372, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.DeleteRolComponent','cobiscorp.ecobis.admin.admincen.service.IRolComponentConfigService','deleteRolComponent','Eliminacion de componente por rol',15366, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.DeleteRolModule','cobiscorp.ecobis.admin.admincen.service.IRolModuleConfigService','deleteRolModule','Eliminacion de Rol module',15348, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.DeleteRolNavigationZone','cobiscorp.ecobis.admin.admincen.service.IRolNavigationZoneConfigService','deleteRolNavigationZone','Eliminacion de Roles de zonas de navegacion',15352, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.DeleteRolPage','cobiscorp.ecobis.admin.admincen.service.IRolPageConfigService','deleteRolPage','Eliminacion de roles de pagina',15374, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.InsertRolComponent','cobiscorp.ecobis.admin.admincen.service.IRolComponentConfigService','insertRolComponent','Ingreso de componentes por Rol',15365, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.InsertRolModule','cobiscorp.ecobis.admin.admincen.service.IRolModuleConfigService','insertRolModule','Ingreso de Rol module',15347, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.InsertRolNavigationZone','cobiscorp.ecobis.admin.admincen.service.IRolNavigationZoneConfigService','insertRolNavigationZone','Ingreso de roles de zonas de navegacion',15351, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.InsertRolPage','cobiscorp.ecobis.admin.admincen.service.IRolPageConfigService','insertRolPage','Ingreso de roles de pagina',15373, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.QueryRolAll','cobiscorp.ecobis.admin.admincen.service.IRolConfigService','queryRolAll','Busqueda de todos los roles',15043, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.QueryRolId','cobiscorp.ecobis.admin.admincen.service.IRolConfigService','queryRolId','busqueda de roles por ID',15043, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.SearchRolComponent','cobiscorp.ecobis.admin.admincen.service.IRolComponentConfigService','searchRolComponent','Busqueda de componentes por rol',15367, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.SearchRolModule','cobiscorp.ecobis.admin.admincen.service.IRolModuleConfigService','searchRolModule','Busqueda de rol module',15349, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.SearchRolNavigationZone','cobiscorp.ecobis.admin.admincen.service.IRolNavigationZoneConfigService','searchRolNavigationZone','Busqueda de roles de zonas de navegacion',15353, null, null, 'Y')
go
insert into cts_serv_catalog values('Admin.AdminCEN.RolComponentConfigService.SearchRolPage','cobiscorp.ecobis.admin.admincen.service.IRolPageConfigService','searchRolPage','Busqueda de roles de pagina',15375, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.DeleteComponent','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','deleteComponent','Eliminacion de Componentes',15344, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.InsertComponent','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','insertComponent','Ingreso de Componentes',15342, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.QueryComponentAll','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','queryComponentAll','Busqueda de todos los componentes',15346, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.QueryComponentId','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','queryComponentId','Busqueda de componentes por ID',15346, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.SearchComponent','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','searchComponent','Busqueda de componentes',15345, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ComponentConfigService.UpdateComponent','cobiscorp.ecobis.admin.admincen.service.IComponentConfigService','updateComponent','Actualización de componentes',15343, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.DeleteLabel','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','deleteLabel','Eliminacion de Etiquetas',15334, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.InsertLabel','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','insertLabel','Ingreso de Etiquetas',15332, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.QueryLabelAll','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','queryLabelAll','Busqueda de todas las Etiquetas',15336, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.QueryLabelId','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','queryLabelId','Busqueda de Etiquetas por ID',15336, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.SearchLabel','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','searchLabel','Busqueda de Etiquetas',15335, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.LabelConfigService.UpdatetLabel','cobiscorp.ecobis.admin.admincen.service.ILabelConfigService','updatetLabel','Actualización de Etiquetas',15333, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ModuleConfigService.DeleteModule','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','deleteModule','Eliminacion de Modulos',15339, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ModuleConfigService.InsertModule','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','insertModule','Ingreso de Modulos',15337, null, null, 'Y')
go
insert into cts_serv_catalog values('AdminCEN.ModuleConfigService.UpdateModule','cobiscorp.ecobis.admin.admincen.service.IModuleConfigService','updateModule','Actualizacion de Modulos',15338, null, null, 'Y')
go
