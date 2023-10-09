use cobis
go


-- alter table an_label disable trigger
-- alter table an_page  disable trigger
-- alter table an_module_group  disable trigger
-- alter table an_module  disable trigger
-- alter table an_component  disable trigger
-- alter table an_zone  disable trigger
-- alter table an_page_zone  disable trigger
-- alter table an_role_module  disable trigger
-- alter table an_navigation_zone disable trigger
-- alter table an_role_navigation_zone disable trigger
-- alter table an_role_component disable trigger
-- alter table an_role_page disable trigger
-- go

delete an_role_page from an_role_page, an_page, an_label where rp_pa_id = pa_id and pa_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_module_group where mg_name like ('MENUPRIN%') or mg_name like ('CEN%') or mg_name like ('COBISCorp.%') and mg_name not in ('COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage','COBISCorp.eCOBIS.COBISExplorer.Help') 
delete an_page_zone from an_page_zone, an_label where pz_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_role_module from an_role_module, an_module, an_label where rm_mo_id = mo_id and mo_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_navigation_zone from an_navigation_zone, an_label where nz_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_role_component from an_role_component,an_component where rc_co_id = co_id and co_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_module from an_module, an_label where mo_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_component where co_prod_name in ('M-MENUPRIN','M-CEN')
delete an_page from an_page, an_label where pa_la_id = la_id and la_prod_name in ('M-MENUPRIN','M-CEN')                                                                                                              
delete an_label where la_prod_name in ('M-MENUPRIN','M-CEN')
go
-------
truncate table an_zone
-------
--truncate table an_role_navigation_zone
--------
go

print ''
print '==> CREANDO ROL MENU POR PROCESOS'
print ''
go

declare @w_max_rol int

if not exists (select 1 from ad_rol where ro_descripcion = 'MENU POR PROCESOS' and ro_filial = 1)
begin
   select @w_max_rol = isnull(max(ro_rol), 0) + 1 
   from ad_rol

   if @w_max_rol = null select @w_max_rol = 1
   
   insert into ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, 
                              ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
                      values (@w_max_rol, 1, 'MENU POR PROCESOS', getdate(),
                              1, 'V', getdate(),900)

   update cl_seqnos
   set siguiente = @w_max_rol
   where tabla = 'ad_rol'
end
go

print ''
print '==> CREANDO MENU PRINCIPAL'
print ''
go

declare @w_la_id int,    @w_la_cod varchar(10),        @w_la_prod_name varchar(10),
        @w_pa_id int,    @w_pa_icon varchar(40),       @w_pa_id_parent int, 
        @w_pa_order int, @w_pa_splitter varchar(20),   @w_pa_nemonic varchar(40),
        @w_pa_he_id int, @w_pa_arguments varchar(255), @w_rol int,
        @w_mg_id int,    @w_mo_id int,                 @w_co_id int, 
        @w_nz_id int,    @w_nz_order int

select @w_la_cod       = 'ES_EC',
       @w_la_prod_name = 'M-MENUPRIN',
       @w_pa_icon      = 'icono pagina',
       @w_pa_id_parent = 0, 
       @w_pa_order     = 0,
       @w_pa_splitter  = 'horizontal',
       @w_pa_nemonic   = 'Nemonic',
       @w_pa_arguments = null,
       @w_pa_he_id     = null

select @w_rol = ro_rol
from   ad_rol
where  ro_descripcion = 'MENU POR PROCESOS'

if not exists (select 1 from an_component where co_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISNavigationPageView')
begin
   if not exists (select 1 from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage')
   begin
      select @w_mg_id = isnull(max(mg_id), 0) + 1 from an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      insert into an_module_group values (@w_mg_id,  'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage', '4.0.0', 'Ninguno',null)
   end
   else 
      select @w_mg_id = mg_id from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage'

   if not exists (select 1 from an_label where la_label = 'Paginas' and la_prod_name = 'M-CEN')
   begin
      select @w_la_id = isnull(max(la_id),0) + 1 from an_label 
      insert into an_label values (@w_la_id, @w_la_cod, 'Paginas', 'M-CEN')
   end
   else
      select @w_la_id = la_id from an_label where la_label = 'Paginas' and la_prod_name = 'M-CEN'

   if not exists (select 1 from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage')
   begin
      select @w_mo_id = isnull(max(mo_id), 0) + 1 from an_module
      insert into an_module values (@w_mo_id, @w_mg_id, @w_la_id, 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage',
                                           'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.dll',0,'9b8bba00b1313138')
      insert into an_role_module values (@w_mo_id, @w_rol)                                           
   end
   else
      select @w_mo_id = mo_id from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage'

   select @w_co_id  = isnull(max(co_id), 0) + 1 from an_component                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
   insert into an_component values (@w_co_id, @w_mo_id, 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISNavigationPageView',
                                           'COBISNavigationPageView', 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage', 'V', ' ', 'M-CEN')

   select @w_nz_id = isnull(max(nz_id), 0) + 1 from an_navigation_zone
   select @w_nz_order = isnull(max(nz_order), 0) + 1 from an_navigation_zone
   insert into an_navigation_zone values (@w_nz_id, @w_la_id, @w_co_id, 'NavigationPageZone', '', @w_nz_order)

   insert into an_role_component values (@w_co_id, @w_rol)
   insert into an_role_navigation_zone values(@w_rol, @w_nz_id)
end

if not exists (select 1 from an_component where co_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISFavoritesView')
begin
   if not exists (select 1 from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage')
   begin
      select @w_mg_id = isnull(max(mg_id), 0) + 1 from an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      insert into an_module_group values (@w_mg_id,  'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage', '4.0.0', 'Ninguno',null)
   end
   else 
      select @w_mg_id = mg_id from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage'

   if not exists (select 1 from an_label where la_label = 'Favoritos' and la_prod_name = 'M-CEN')
   begin
      select @w_la_id = isnull(max(la_id),0) + 1 from an_label 
      insert into an_label values (@w_la_id, @w_la_cod, 'Favoritos', 'M-CEN')
   end
   else
      select @w_la_id = la_id from an_label where la_label = 'Favoritos' and la_prod_name = 'M-CEN'

   if not exists (select 1 from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage')
   begin
      select @w_mo_id = isnull(max(mo_id), 0) + 1 from an_module
      insert into an_module values (@w_mo_id, @w_mg_id, @w_la_id, 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage',
                                           'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.dll',0,'9b8bba00b1313138')
      insert into an_role_module values (@w_mo_id, @w_rol)                                                
   end
   else
      select @w_mo_id = mo_id from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage'

   select @w_co_id  = isnull(max(co_id), 0) + 1 from an_component                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
   insert into an_component values (@w_co_id, @w_mo_id, 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISFavoritesView',
                                           'COBISFavoritesView', 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage', 'V', ' ', 'M-CEN')

   select @w_nz_id = isnull(max(nz_id), 0) + 1 from an_navigation_zone
   select @w_nz_order = isnull(max(nz_order), 0) + 1 from an_navigation_zone
   insert into an_navigation_zone values (@w_nz_id, @w_la_id, @w_co_id, 'FavoritesZone', '', @w_nz_order)
   
   insert into an_role_component values (@w_co_id, @w_rol)
   insert into an_role_navigation_zone values (@w_rol, @w_nz_id)
end

if not exists (select 1 from an_component where co_name = 'COBISCorp.eCOBIS.COBISExplorer.Help.View.COBISHelpView')
begin
   if not exists (select 1 from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Help')
   begin
      select @w_mg_id = isnull(max(mg_id), 0) + 1 from an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
      insert into an_module_group values (@w_mg_id,  'COBISCorp.eCOBIS.COBISExplorer.Help', '4.0.0', 'Ninguno',null)
   end
   else 
      select @w_mg_id = mg_id from an_module_group where mg_name = 'COBISCorp.eCOBIS.COBISExplorer.Help'

   if not exists (select 1 from an_label where la_label = 'Ayuda' and la_prod_name = 'M-CEN')
   begin
      select @w_la_id = isnull(max(la_id),0) + 1 from an_label 
      insert into an_label values (@w_la_id, @w_la_cod, 'Ayuda', 'M-CEN')
   end
   else
      select @w_la_id = la_id from an_label where la_label = 'Ayuda' and la_prod_name = 'M-CEN'

   if not exists (select 1 from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Help')
   begin
      select @w_mo_id = isnull(max(mo_id), 0) + 1 from an_module
      insert into an_module values (@w_mo_id, @w_mg_id, @w_la_id, 'COBISCorp.eCOBIS.COBISExplorer.Help',
                                           'COBISCorp.eCOBIS.COBISExplorer.Help.dll',0,'9b8bba00b1313138')
      insert into an_role_module values (@w_mo_id, @w_rol)                                                                                     
   end
   else
      select @w_mo_id = mo_id from an_module where mo_name = 'COBISCorp.eCOBIS.COBISExplorer.Help'

   select @w_co_id  = isnull(max(co_id), 0) + 1 from an_component                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
   insert into an_component values (@w_co_id, @w_mo_id, 'COBISCorp.eCOBIS.COBISExplorer.Help.View.COBISHelpView',
                                           'COBISHelpView', 'COBISCorp.eCOBIS.COBISExplorer.Help.View', 'V', ' ', 'M-CEN')

   select @w_nz_id = isnull(max(nz_id), 0) + 1 from an_navigation_zone
   select @w_nz_order = isnull(max(nz_order), 0) + 1 from an_navigation_zone
   insert into an_navigation_zone values (@w_nz_id, @w_la_id, @w_co_id, 'HelpZone', '', @w_nz_order)
   
   insert into an_role_component values (@w_co_id, @w_rol)
   insert into an_role_navigation_zone values (@w_rol, @w_nz_id)
end

if not exists (select 1 from an_label where la_label = 'Atención al Cliente' and la_prod_name = @w_la_prod_name)
begin
   select @w_la_id = isnull(max(la_id), 0) + 1 
   from   an_label
   
   insert into an_label values (@w_la_id, @w_la_cod, 'Atención al Cliente', @w_la_prod_name)

   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AC.Atención al Cliente', @w_pa_icon, @w_pa_id_parent,
                                   @w_pa_order, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
   
   /* OPCIONES DE ATENCION AL CLIENTE */
   /****** SE ELIMINA CREACION DE VISTA CONSOLIDADA YA QUE LA MISMA SERA CREADA POR CLIENTES ******
   insert into an_label values (@w_la_id+1, @w_la_cod, 'Posición Consolidada - Vista 360', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+1, 'AC.Posición Consolidada', @w_pa_icon, @w_pa_id-1,
                                   @w_pa_order+1, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
   ****** SE ELIMINA CREACION DE VISTA CONSOLIDADA YA QUE LA MISMA SERA CREADA POR CLIENTES ******/
   
   insert into an_label values (@w_la_id+2, @w_la_cod, 'Aperturas y Originaciones', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+2, 'AC.Aperturas y Originaciones', @w_pa_icon, @w_pa_id-1, --@w_pa_id-2
                                   @w_pa_order+1, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, --@w_pa_order+2
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)

   insert into an_label values (@w_la_id+3, @w_la_cod, 'Servicios Bancarios', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+3, 'AC.Servicios Bancarios1', @w_pa_icon, @w_pa_id-2,     --@w_pa_id-3
                                   @w_pa_order+2, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, --@w_pa_order+3
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)

   insert into an_label values (@w_la_id+4, @w_la_cod, 'Consultas y Reportes', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+4, 'AC.Consultas y Reportes', @w_pa_icon, @w_pa_id-3,     --@w_pa_id-4
                                   @w_pa_order+3, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, --@w_pa_order+4
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)   
end


if not exists (select 1 from an_label where la_label = 'Procesos Back Office' and la_prod_name = @w_la_prod_name)
begin
   select @w_la_id = isnull(max(la_id), 0) + 1
   from   an_label

   insert into an_label values (@w_la_id, @w_la_cod, 'Procesos Back Office', @w_la_prod_name)
  
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PI.Procesos Internos', @w_pa_icon, @w_pa_id_parent,
                                   @w_pa_order, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
   
   /* OPCIONES DE BACK OFFICE */
   /****** SE ELIMINA CREACION DE MENU CREDITO YA QUE LA MISMA SERA CREADA EN CARTERA ******
   insert into an_label values (@w_la_id+1, @w_la_cod, 'Crédito', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+1, 'PI.Operativo - Crédito', @w_pa_icon, @w_pa_id-1,
                                   @w_pa_order+1, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
   ****** SE ELIMINA CREACION DE MENU CREDITO YA QUE LA MISMA SERA CREADA EN CARTERA ******/
end

/****** SE ELIMINA CREACION DE MENU CREDITO YA QUE LA MISMA SERA CREADA EN CAJAS ******
if not exists (select 1 from an_label where la_label = 'Caja' and la_prod_name = @w_la_prod_name)
begin
   select @w_la_id = isnull(max(la_id), 0) + 1
   from   an_label

   insert into an_label values (@w_la_id, @w_la_cod, 'Caja', @w_la_prod_name)

   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'CJ.Caja', @w_pa_icon, @w_pa_id_parent,
                                   @w_pa_order, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
   
   -- CAJA
   
   insert into an_label values (@w_la_id+1, @w_la_cod, 'Administración de Cajas', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+1, 'CJ.Administracion de Cajas', @w_pa_icon, @w_pa_id-1,
                                   @w_pa_order+1, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)

   insert into an_label values (@w_la_id+2, @w_la_cod, 'Atx', @w_la_prod_name)
   
   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id+2, 'CJ.ATX', @w_pa_icon, @w_pa_id-2,
                                   @w_pa_order+2, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
end
****** SE ELIMINA CREACION DE MENU CREDITO YA QUE LA MISMA SERA CREADA EN CAJAS ******/

if not exists (select 1 from an_label where la_label = 'Creación / Mantenimiento de Productos' and la_prod_name = @w_la_prod_name)
begin
   select @w_la_id = isnull(max(la_id), 0) + 1
   from   an_label

   insert into an_label values (@w_la_id, @w_la_cod, 'Creación / Mantenimiento de Productos', @w_la_prod_name)

   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.Parametrización de Productos', @w_pa_icon, @w_pa_id_parent,
                                   @w_pa_order, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
end


if not exists (select 1 from an_label where la_label = 'Administración del Sistema' and la_prod_name = @w_la_prod_name)
begin
   select @w_la_id = isnull(max(la_id), 0) + 1
   from   an_label

   insert into an_label values (@w_la_id, @w_la_cod, 'Administración del Sistema', @w_la_prod_name)

   select @w_pa_id  = isnull(max(pa_id), 0) + 1
   from   an_page

   insert into an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'AS.Administración del Sistema', @w_pa_icon, @w_pa_id_parent,
                                   @w_pa_order, @w_pa_splitter, @w_pa_nemonic, @w_la_prod_name, @w_pa_arguments, 
                                   @w_pa_he_id)

   insert into an_role_page values (@w_pa_id, @w_rol)
end

go

-- alter table an_label enable trigger
-- alter table an_page  enable trigger
-- alter table an_module_group  enable trigger
-- alter table an_module  enable trigger
-- alter table an_component  enable trigger
-- alter table an_zone  enable trigger
-- alter table an_page_zone  enable trigger
-- alter table an_role_module  enable trigger
-- alter table an_navigation_zone enable trigger
-- alter table an_role_navigation_zone enable trigger
-- alter table an_role_component enable trigger
-- go
