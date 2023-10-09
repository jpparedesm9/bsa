use cobis
go

-- -------------------------------------------
-- ELIMINACIÓN
-- ----------------------------------------------

-- Dependencias
delete cobis..an_module_dependency from cobis..an_module_dependency, cobis..an_module
where md_mo_id = mo_id 
and mo_name like 'CTA.%'
go

-- Modulos
delete cobis..an_role_page from cobis..an_role_page, cobis..an_page, cobis..an_label where rp_pa_id = pa_id and pa_la_id = la_id and la_prod_name = 'M-CTA'
delete cobis..an_module_group where mg_name like 'CTA%'
delete cobis..an_page_zone from cobis..an_page_zone, cobis..an_label where pz_la_id = la_id and la_prod_name = 'M-CTA'
delete cobis..an_role_module from cobis..an_role_module, cobis..an_module, cobis..an_label where rm_mo_id = mo_id and mo_la_id = la_id and la_prod_name = 'M-CTA'
delete cobis..an_navigation_zone from cobis..an_navigation_zone, cobis..an_label where nz_la_id = la_id and la_prod_name = 'M-CTA'
delete cobis..an_role_component from cobis..an_role_component,cobis..an_component where rc_co_id = co_id and co_prod_name = 'M-CTA'
delete cobis..an_module from cobis..an_module, cobis..an_label where mo_la_id = la_id and la_prod_name = 'M-CTA'
delete cobis..an_component where co_prod_name = 'M-CTA'
delete cobis..an_page  where pa_prod_name = 'M-CTA'
delete cobis..an_label where la_prod_name = 'M-CTA'
go


