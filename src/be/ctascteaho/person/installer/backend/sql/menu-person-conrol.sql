use cobis
go

--
delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where mo_id_parent <> 0 and md_mo_id = mo_id and md_dependency_id = mo_id_parent
and  mo_name like 'PER%'
--
delete cobis..an_role_page from cobis..an_role_page, cobis..an_page, cobis..an_label
where rp_pa_id = pa_id and pa_la_id = la_id and la_prod_name = 'M-PER'

delete cobis..an_module_group where mg_name like 'PER%'

delete cobis..an_page_zone from cobis..an_page_zone, cobis..an_label
where pz_la_id = la_id and la_prod_name = 'M-PER'

delete cobis..an_role_module from cobis..an_role_module, cobis..an_module, cobis..an_label
where rm_mo_id = mo_id and mo_la_id = la_id and la_prod_name = 'M-PER'

delete cobis..an_navigation_zone from cobis..an_navigation_zone, cobis..an_label
where nz_la_id = la_id and la_prod_name = 'M-PER'

delete cobis..an_role_component from cobis..an_role_component,cobis..an_component
where rc_co_id = co_id and co_prod_name = 'M-PER'

delete cobis..an_module from cobis..an_module, cobis..an_label
where mo_la_id = la_id and la_prod_name = 'M-PER'

delete cobis..an_component where co_prod_name = 'M-PER'
delete cobis..an_page  where pa_prod_name = 'M-PER'
delete cobis..an_label where la_prod_name = 'M-PER'
go

-- Registros para: PP.Cuentas Corrientes y Cuentas de Ahorr
print 'Registros para: PP.Cuentas Corrientes y Cuentas de Ahorr'
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Cuentas Corrientes y Cuentas de Ahorr')
begin
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol
    where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name )
    values (@w_la_id, @w_la_cod, 'Cuentas Corrientes y Ahorros', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page
    where pa_name = 'PP.Parametrización de Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.Cuentas Corrientes y Cuentas de Ahorr', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol)
    values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.Personalización   Productos
print 'Registros para: PP.Personalización   Productos'
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Personalizacion   Productos')
begin
    declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
    select @w_rol = ro_rol from   cobis..ad_rol
    where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name )
    values (@w_la_id, @w_la_cod, 'Personalizacion Cuentas a la Vista', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Cuentas Corrientes y Cuentas de Ahorr'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.Personalizacion   Productos', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.Productos1
print 'Registros para: PP.Productos1'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Productos1')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Productos', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalizacion   Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.Productos1', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.PER.FTrprobanClass
print 'Registros para: PP.PER.FTrprobanClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int, @w_parent_module varchar(100), @w_id_parent_module int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTrprobanClass')
begin
    select @w_rol = ro_rol from  cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Productos Bancarios', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FTrprobanClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    
	insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FTrproban', 'FTrprobanClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Productos Bancarios')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Productos Bancarios', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Productos Bancarios'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FTrprobaenClass
print 'Registros para: PP.PER.FTrprobaenClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTrprobaenClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mercado', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FTrprobaenClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FTrprobaen', 'FTrprobaenClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Mercado')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mercado', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Mercado'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FRangoEdadClass
print 'Registros para: PP.PER.FRangoEdadClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FRangoEdadClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rango Edad - Producto Final', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FRangoEdadClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) 
	values (@w_co_id, @w_mo_id, 'PER.FRangoEdad', 'FRangoEdadClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Rango Edad - Producto Final')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rango Edad - Producto Final', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Rango Edad - Producto Final'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FProFinClass
print 'Registros para: PP.PER.FProFinClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FProFinClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Productos Finales', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FProFinClass', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FProFin', 'FProFinClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Productos Finales')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Productos Finales', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Productos Finales'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FCatProFinalClass
print 'Registros para: PP.PER.FCatProFinalClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FCatProFinalClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Categorias por Producto Final', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FCatProFinalClass', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FCatProFinal', 'FCatProFinalClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Categorias por Producto Final')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Categorias por Producto Final', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Categorias por Producto Final'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FCapProFinalClass
print 'Registros para: PP.PER.FCapProFinalClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FCapProFinalClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Tipo de Capitalización por Producto Final', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FCapProFinalClass', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FCapProFinal', 'FCapProFinalClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Tipo de Capitalización por Producto Final')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Tipo de Capitalización por Producto Final', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Tipo de Capitalización por Producto Final'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FCicProFinalClass
print 'Registros para: PP.PER.FCicProFinalClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FCicProFinalClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Ciclos por Producto Final', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FCicProFinalClass', 'icono pagina', @w_pa_id_parent, 6, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FCicProFinal', 'FCicProFinalClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Ciclos por Producto Final')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Ciclos por Producto Final', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Ciclos por Producto Final'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FProContClass
print 'Registros para: PP.PER.FProContClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FProContClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Caracteristicas Especiales', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FProContClass', 'icono pagina', @w_pa_id_parent, 7, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FProCont', 'FProContClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Caracteristicas Especiales')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Caracteristicas Especiales', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Caracteristicas Especiales'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

--jca
-- Registros para: PP.PER.FTra2946  
print ' CReacion de Opción del Menú --> Asociacion de Contratosto' 
                                                                                                                                                                                                                                                                                                                                                                                                          
print 'Registros para: PP.PER.FTra2946'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTra2946') 
begin                                                                                                                                                                                                                                                                                                                                                                                                                                       
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'  
select @w_la_cod = 'ES_EC'                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label   
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Asociación de contratos a productos bancarios', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                                                                           
select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page 
select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'                                                                                                                                                                                                                                                                                                                                                                                                                                               
insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FTra2946', 'icono pagina', @w_pa_id_parent, 10, 'horizontal', 'Nemonic', 'M-PER', '', null)                                                                                                                                                                                                                                                                                                                                                                    
insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
if not exists (select * from an_zone where zo_id = 1) begin  insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)  end                                                                                                                                                                                                                                                                                                                                                                                                    
if not exists (select * from cobis..an_module_group where mg_name = 'PER.Products') begin                                                                                                                                                                                                                                                                                                                                                                                                                                        
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Products', '4.0.0.1', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')                                                                                                                                                                                                                                                                                                                                               
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'                                                                                                                                                                                                                                                                                                                                                                                                                                      
if not exists (select * from cobis..an_module where mo_name = 'PER.Products') begin                                                                                                                                                                                                                                                                                                                                                                                                                                              
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)                                                                                                                                                                                                                                                                                                                                                                                                 
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'                                                                                                                                                                                                                                                                                                                                                                                                                                            
if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                    
select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FTra2946', 'FTra2946Class', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                 
insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
if not exists (select 1 from cobis..an_label where la_label = 'Asociación de Contratos a Productos Bancarios') begin                                                                                                                                                                                                                                                                                                                                                                                                                                       
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Asociación de contratos a Productos Bancarios', 'M-PER')                                                                                                                                                                                                                                                                                                                                                                                                                                           
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
else select @w_la_id = la_id from cobis..an_label where la_label = 'Asociación de Contratos a Productos Bancarios'                                                                                                                                                                                                                                                                                                                                                                                                                                         
select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
if @w_pz_id is null select @w_pz_id = 1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id) begin                                                                                                                                                                                                                                                                                                                                                                                                                        
insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)                                                                                                                                                                                                                                                                                                                                                                                                  
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
go                            



-- Registros para: PP.PER.FMantTranAutorizadaClass
print 'Registros para: PP.PER.FMantTranAutorizadaClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FMantTranAutorizadaClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Transacciones en Caja', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Productos1'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FMantTranAutorizadaClass', 'icono pagina', @w_pa_id_parent, 8, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FMantTranAutorizada', 'FMantTranAutorizadaClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Autorización de Tansacciones en Caja')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Autorización de Tansacciones en Caja', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Autorización de Tansacciones en Caja'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.Parametros
print 'Registros para: PP.Parametros'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Parametros')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametros', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalizacion   Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.Parametros', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para:     PP.PER.FTopesOfiClass
print 'Registros para: PP.PER.FTopesOfiClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTopesOfiClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Topes de Retiro por Canal', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Parametros'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FTopesOfiClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FTopesOfi', 'FTopesOfiClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Topes de Retiro por Canal')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Topes de Retiro por Canal', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Topes de Retiro por Canal'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para:     PP.PER.FParExtClass
print 'Registros para: PP.PER.FParExtClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FParExtClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametro Extracto Cuenta', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Parametros'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FParExtClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Products')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Products', '4.0.0.0', 'http://[servername]/PER.Products.Installer/PER.Products.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Products'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Products')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Products', 'COBISCorp.tCOBIS.PER.Products.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Products'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FParExt', 'FParExtClass', 'COBISCorp.tCOBIS.PER.Products', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Parametro Extracto Cuenta')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Parametro Extracto Cuenta', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Parametro Extracto Cuenta'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go


-- Registros para: PP.Rangos
print 'Registros para: PP.Rangos'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Rangos')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rangos', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalizacion   Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.Rangos', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.PER.FTipRangoClass
print 'Registros para: PP.PER.FTipRangoClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FTipRangoClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Tipo Rango', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Rangos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FTipRangoClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Range')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Range', '4.0.0.0', 'http://[servername]/PER.Range.Installer/PER.Range.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Range'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Range')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Range', 'COBISCorp.tCOBIS.PER.Range.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Range'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FTipRango', 'FTipRangoClass', 'COBISCorp.tCOBIS.PER.Range', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Tipo Rango')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Tipo Rango', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Tipo Rango'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FRangoClass
print 'Registros para: PP.PER.FRangoClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FRangoClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rango', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Rangos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FRangoClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Range')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Range', '4.0.0.0', 'http://[servername]/PER.Range.Installer/PER.Range.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Range'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Range')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Range', 'COBISCorp.tCOBIS.PER.Range.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Range'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FRango', 'FRangoClass', 'COBISCorp.tCOBIS.PER.Range', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
    if not exists (select 1 from cobis..an_label where la_label = 'Rango')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rango', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Rango'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.Servicios
print 'Registros para: PP.Servicios'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Servicios')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalizacion   Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.Servicios', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.PER.FCreaServClass
print 'Registros para: PP.PER.FCreaServClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FCreaServClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios Disponibles', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Servicios'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FCreaServClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end
    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Service')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Service', '4.0.0.0', 'http://[servername]/PER.Service.Installer/PER.Service.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Service'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Service')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Service', 'COBISCorp.tCOBIS.PER.Service.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Service'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FCreaServ', 'FCreaServClass', 'COBISCorp.tCOBIS.PER.Service', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Servicios Disponibles')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios Disponibles', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Servicios Disponibles'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FVarServClass
print 'Registros para: PP.PER.FVarServClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FVarServClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rubros de Servicios', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Servicios'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FVarServClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)

    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Service')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Service', '4.0.0.0', 'http://[servername]/PER.Service.Installer/PER.Service.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Service'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Service')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Service', 'COBISCorp.tCOBIS.PER.Service.dll', 0, null)
    end
    else
        select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Service'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FVarServ', 'FVarServClass', 'COBISCorp.tCOBIS.PER.Service', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Rubros de Servicios')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Rubros de Servicios', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Rubros de Servicios'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FRubrosClass
print 'Registros para: PP.PER.FRubrosClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FRubrosClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios Personalizables', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Servicios'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FRubrosClass', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Service')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Service', '4.0.0.0', 'http://[servername]/PER.Service.Installer/PER.Service.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Service'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Service')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Service', 'COBISCorp.tCOBIS.PER.Service.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Service'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FRubros', 'FRubrosClass', 'COBISCorp.tCOBIS.PER.Service', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Servicios Personalizables')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Servicios Personalizables', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Servicios Personalizables'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go


-- Registros para: PP.PER.FParComClass
print 'Registros para: PP.PER.FParComClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FParComClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cobro de Comisiones', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Servicios'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FParComClass', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Service')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Service', '4.0.0.0', 'http://[servername]/PER.Service.Installer/PER.Service.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Service'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Service')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
        values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Service', 'COBISCorp.tCOBIS.PER.Service.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Service'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name)
    values (@w_co_id, @w_mo_id, 'PER.FParCom', 'FParComClass', 'COBISCorp.tCOBIS.PER.Service', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Cobro de Comisiones')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Cobro de Comisiones', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Cobro de Comisiones'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id)
        values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go



-- Registros para: PP.Valores
print 'Registros para: PP.Valores'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Valores')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Valores', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalizacion   Productos'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.Valores', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.Valor de Servicio
print 'Registros para: PP.Valor de Servicio'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Valor de Servicio')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Valor de Servicio', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valores'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.Valor de Servicio', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.PER.FMantenimientoClass
print 'Registros para: PP.PER.FMantenimientoClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FMantenimientoClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
    values (@w_pa_id, @w_la_id, 'PP.PER.FMantenimientoClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
        values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FMantenimiento', 'FMantenimientoClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FMantenLineaClass
print 'Registros para: PP.PER.FMantenLineaClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FMantenLineaClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento en Linea', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FMantenLineaClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FMantenLinea', 'FMantenLineaClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento en Linea')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento en Linea', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento en Linea'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FMantenLinea2Class
print 'Registros para: PP.PER.FMantenLinea2Class'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FMantenLinea2Class')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Masivo', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FMantenLinea2Class', 'icono pagina', @w_pa_id_parent, 3, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FMantenLinea2', 'FMantenLinea2Class', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Mantenimiento Masivo')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Mantenimiento Masivo', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Mantenimiento Masivo'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FConsValClass
print 'Registros para: PP.PER.FConsValClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FConsValClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Próximos Valores Vigentes', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FConsValClass', 'icono pagina', @w_pa_id_parent, 4, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FConVal', 'FConsValClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta Próximos Valores Vigentes')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta Próximos Valores Vigentes', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta Próximos Valores Vigentes'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FConsulMasClass
print 'Registros para: PP.PER.FConsulMasClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FConsulMasClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Valores en Línea', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FConsulMasClass', 'icono pagina', @w_pa_id_parent, 5, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FConsulMas', 'FConsulMasClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Valores en Línea')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Valores en Línea', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Valores en Línea'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FConsulMas2Class
print 'Registros para: PP.PER.FConsulMas2Class'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FConsulMas2Class')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Próximos Valores en Línea', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FConsulMas2Class', 'icono pagina', @w_pa_id_parent, 6, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FConsulMas2', 'FConsulMas2Class', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Próximos Valores en Línea')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Próximos Valores en Línea', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Próximos Valores en Línea'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FconVarCostoClass
print 'Registros para: PP.PER.FconVarCostoClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FconVarCostoClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta histórica de Costos y Tasas', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valor de Servicio'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FconVarCostoClass', 'icono pagina', @w_pa_id_parent, 7, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FconVarCosto', 'FconVarCostoClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta histórica de Costos y Tasas')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta histórica de Costos y Tasas', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta histórica de Costos y Tasas'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.Personalización de Valores
print 'Registros para: PP.Personalización de Valores'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.Personalización de Valores')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Personalización de Valores', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Valores'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.Personalización de Valores', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
end
go

-- Registros para: PP.PER.FPersoCuentaClass
print 'Registros para: PP.PER.FPersoCuentaClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FPersoCuentaClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Personalización de Cuenta', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalización de Valores'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FPersoCuentaClass', 'icono pagina', @w_pa_id_parent, 1, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FPersoCuenta', 'FPersoCuentaClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Personalización de Cuenta')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Personalización de Cuenta', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Personalización de Cuenta'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

-- Registros para: PP.PER.FConsultaPerClass
print 'Registros para: PP.PER.FConsultaPerClass'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
if not exists (select 1 from cobis..an_page where pa_name = 'PP.PER.FConsultaPerClass')
begin
    select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
    select @w_la_cod = 'ES_EC'
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Personalización', 'M-PER')
    select @w_pa_id  = isnull(max(pa_id), 0) + 1 from   cobis..an_page
    select @w_pa_id_parent = pa_id from cobis..an_page where pa_name = 'PP.Personalización de Valores'
    insert into cobis..an_page (pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id) values (@w_pa_id, @w_la_id, 'PP.PER.FConsultaPerClass', 'icono pagina', @w_pa_id_parent, 2, 'horizontal', 'Nemonic', 'M-PER', '', null)
    insert into cobis..an_role_page (rp_pa_id,rp_rol) values (@w_pa_id, @w_rol)
    if not exists (select 1 from an_zone where zo_id = 1)
    begin
        insert into cobis..an_zone (zo_id,zo_name,zo_pin_visible,zo_close_visible,zo_title_visible,zo_pin_value) values (1, 'Zona 1', 1, 1, 1, 1)
    end

    if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Cost')
    begin
        select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
        insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.Cost', '4.0.0.0', 'http://[servername]/PER.Cost.Installer/PER.Cost.Installer.application', 'COBISExplorer')
    end
    else
        select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_module where mo_name = 'PER.Cost')
    begin
        select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
        insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Cost', 'COBISCorp.tCOBIS.PER.Cost.dll', 0, null)
    end
        else

    select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Cost'

    if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
        insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

    select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
    insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'PER.FConsultaPer', 'FConsultaPerClass', 'COBISCorp.tCOBIS.PER.Cost', 'SV', '', 'M-PER')
    insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)

    if not exists (select 1 from cobis..an_label where la_label = 'Consulta de Personalización')
    begin
        select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
        insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, @w_la_cod, 'Consulta de Personalización', 'M-PER')
    end
    else
        select @w_la_id = la_id from cobis..an_label where la_label = 'Consulta de Personalización'

    select @w_pz_id = isnull(max(pz_id), 0) + 1 from   cobis..an_page_zone
    if @w_pz_id is null select @w_pz_id = 1
    if not exists (select 1 from cobis..an_page_zone where pz_pa_id = @w_pa_id and pz_co_id = @w_co_id)
    begin
        insert into cobis..an_page_zone (pz_id,pz_zo_id,pz_la_id,pz_pa_id,pz_co_id,pz_order,pz_hor_size,pz_ver_size,pz_icon,pz_split_style,pz_id_parent,pz_component_optional,pz_he_id) values (@w_pz_id, 1, @w_la_id, @w_pa_id, @w_co_id, 1, 100, 100,'Ninguno','horizontal',0,1,null)
    end
end
go

--------------------------------------------------------------------------
--CREACION Resources
--------------------------------------------------------------------------
-- Registros para: PER.Resources
 print 'Registros para: PER.Resources'
 declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
 begin
     select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'
     if not exists(select 1 from an_label where la_label = 'PER.Resources')
     begin
         select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
         insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name )
         values (@w_la_id, 'ES_EC', 'PER.Resources', 'M-PER')
     end
     else
         select @w_la_id = la_id from an_label where la_label = 'PER.Resources'

     if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Resources')
     begin
         select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
         insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
         values (@w_mg_id, 'PER.Resources', '0.0.0.0', 'http://[servername]/PER.Resources.Installer/PER.Resources.Installer.application', 'COBISExplorer')
     end
     else
         select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Resources'

     if not exists (select 1 from cobis..an_module where mo_name = 'PER.Resources')
     begin
         select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
         insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token)
         values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Resources', 'COBISCorp.tCOBIS.PER.Resources.dll', 0, null)
     end
     else
         select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Resources'

     if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol)
         insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
 end
 go


--------------------------------------------------------------------------
--CREACION PER QUERY
--------------------------------------------------------------------------
-- Registros para: PER.Query
print 'Registros para: PER.Query'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'PER.Query')
begin
    select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
    insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'PER.Query', 'M-PER')
end
else
    select @w_la_id = la_id from an_label where la_label = 'PER.Query'

if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.Query')
begin
    select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
    insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name)
    values (@w_mg_id, 'PER.Query', '4.0.0.0', 'http://[servername]/PER.Query.Installer/PER.Query.Installer.application', 'COBISExplorer')
end
else
    select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.Query'

if not exists (select 1 from cobis..an_module where mo_name = 'PER.Query') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.Query', 'COBISCorp.tCOBIS.PER.Query.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.Query'

if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)

if not exists (select 1 from cobis..an_component where co_class = 'FCatalogoServClass')begin
 select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
 insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'FCatalogoServ', 'FCatalogoServClass', 'COBISCorp.tCOBIS.PER.Query', 'SV', '', 'M-PER')
 insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end

if not exists (select 1 from cobis..an_component where co_class = 'FConsultaCtaClass')begin
 select @w_co_id  = isnull(max(co_id), 0) + 1 from   cobis..an_component
 insert into cobis..an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@w_co_id, @w_mo_id, 'FConsultaCta', 'FConsultaCtaClass', 'COBISCorp.tCOBIS.PER.Query', 'SV', '', 'M-PER')
 insert into cobis..an_role_component (rc_co_id,rc_rol) values (@w_co_id, @w_rol)
end
go

--------------------------------------------------------------------------
--CREACION SharedLibrary
--------------------------------------------------------------------------
-- Registros para: PER.SharedLibrary
print 'Registros para: PER.SharedLibrary'
declare @w_rol int, @w_la_cod varchar(10), @w_la_id int, @w_pa_id  int, @w_pa_id_parent int, @w_mg_id int, @w_mo_id int, @w_co_id int, @w_pz_id int
select @w_rol = ro_rol from   cobis..ad_rol where  ro_descripcion = 'MENU POR PROCESOS'

if not exists(select 1 from an_label where la_label = 'PER.SharedLibrary')begin
select @w_la_id = isnull(max(la_id), 0) + 1 from   cobis..an_label
insert into cobis..an_label (la_id,la_cod,la_label,la_prod_name ) values (@w_la_id, 'ES_EC', 'PER.SharedLibrary', 'M-PER')
end else select @w_la_id = la_id from an_label where la_label = 'PER.SharedLibrary'

if not exists (select 1 from cobis..an_module_group where mg_name = 'PER.SharedLibrary') begin
select @w_mg_id  = isnull(max(mg_id), 0) + 1 from   cobis..an_module_group
insert into cobis..an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@w_mg_id, 'PER.SharedLibrary', '4.0.0.0', 'http://[servername]/PER.SharedLibrary.Installer/PER.SharedLibrary.Installer.application', 'COBISExplorer')
end else select @w_mg_id = mg_id from cobis..an_module_group where mg_name = 'PER.SharedLibrary'

if not exists (select 1 from cobis..an_module where mo_name = 'PER.SharedLibrary') begin
select @w_mo_id  = isnull(max(mo_id), 0) + 1 from   cobis..an_module
insert into cobis..an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@w_mo_id, @w_mg_id, @w_la_id, 'PER.SharedLibrary', 'COBISCorp.tCOBIS.PER.SharedLibrary.dll', 0, null)
end else select @w_mo_id = mo_id from cobis..an_module where mo_name = 'PER.SharedLibrary'

if not exists (select 1 from cobis..an_role_module where rm_mo_id = @w_mo_id and rm_rol = @w_rol) insert into cobis..an_role_module (rm_mo_id,rm_rol) values (@w_mo_id, @w_rol)
go

-------------------------------------------------------------------------------
--Dependencias Per
-------------------------------------------------------------------------------

use cobis
go

declare @w_prod_name varchar(20), @w_module_group varchar(50)
, @w_module varchar(50), @w_parent_module varchar(50),
@w_id_parent_module int, @w_id_module int

select @w_prod_name = 'M-PER',
@w_module_group = 'PER.SharedLibrary',
@w_module = 'PER.SharedLibrary',
@w_parent_module = 'PER.Resources'
delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where md_mo_id = mo_id
and mo_name like 'PER.%'

declare @codigo int, @codigoDep int,
    @codigoDep2 int
    
select @codigoDep = 0
select @codigo = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Resources.dll'

if (@codigoDep is not null and @codigo is not null)
    if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo)
    begin
       print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Resources.dll'
    end
    else
    begin
       insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo)
       print 'Dependencia registrada COBISCorp.tCOBIS.PER.Resources.dll'
    end
else
    print 'NO EXISTE CODIGO DE MODULO O DEPENDENCIA'

--select @codigo = @codigoDep

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.SharedLibrary.dll'

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.SharedLibrary.dll'
print 'codigo: ' + convert(nvarchar, @codigoDep) + ' - ' + convert(nvarchar, @codigo)
if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.SharedLibrary.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.SharedLibrary.dll'
end

select @codigo = @codigoDep

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.Query.dll'

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Query.dll'

if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Query.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.Query.dll'
end

select @codigo = @codigoDep

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.Cost.dll'

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Cost.dll'


if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Cost.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.Cost.dll'
end

select @codigo = @codigoDep

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.Products.dll'

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.Range.dll'

update cobis..an_module
set mo_id_parent = @codigo
where mo_filename = 'COBISCorp.tCOBIS.PER.Service.dll'

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Products.dll'


if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Products.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.Products.dll'
end

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Range.dll'


if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Range.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.Range.dll'
end

select @codigoDep = 0
select @codigoDep = mo_id
from cobis..an_module
where mo_filename = 'COBISCorp.tCOBIS.PER.Service.dll'


if exists(select 1 from cobis..an_module_dependency where md_mo_id = @codigoDep and md_dependency_id = @codigo )
begin
    print 'Ya existe dependencia registrada COBISCorp.tCOBIS.PER.Service.dll'
end
else
begin
    insert cobis..an_module_dependency  (md_mo_id, md_dependency_id ) values (@codigoDep, @codigo )
    print 'Dependencia registrada COBISCorp.tCOBIS.PER.Service.dll'
end
go


