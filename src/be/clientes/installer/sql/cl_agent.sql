use cobis
go

delete cobis..an_role_component
where rc_co_id = (select co_id from cobis..an_component where co_name = 'BCLI.Resources')

delete cobis..an_role_module
where rm_mo_id = (select mo_id from cobis..an_module where mo_name = 'BCLI.Resources')

delete cobis..an_role_agent
where ra_ag_id = (select ag_id from cobis..an_agent where ag_name   = 'BCLI.Resources')

delete cobis..an_agent
where ag_name   = 'BCLI.Resources'

delete cobis..an_component
where co_name = 'BCLI.Resources'

delete cobis..an_module
where mo_name = 'BCLI.Resources'

delete cobis..an_module_group
where mg_name = 'BCLI.Resources'

delete cobis..an_label
where la_label = 'Recursos de Clientes'
go


print 'Insercion de valores en estructuras an_'
declare @id_component int,
        @id_module int,
        @id_module_group int,
        @id_label  int,
        @id_agent int,
        @w_rol int,        
        @sql varchar(1000)
        
select @w_rol = min(ro_rol)
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'      
    
select @id_label = isnull(max(la_id),0) + 1 from an_label
insert into an_label (la_id,la_cod,la_label,la_prod_name) values (@id_label,'ES_EC','Recursos de Clientes','M-MIS') 

select @id_module_group = isnull(max(mg_id),0) + 1 from an_module_group 
insert into an_module_group (mg_id,mg_name,mg_version,mg_location,mg_store_name) values (@id_module_group,'BCLI.Resources','4.0.0.0','http://[servername]/BCLI.Resources.Installer/BCLI.Resources.Installer.application','COBISExplorer')

select @id_module = isnull(max(mo_id),0) + 1 from an_module 
insert into an_module (mo_id,mo_mg_id,mo_la_id,mo_name,mo_filename,mo_id_parent,mo_key_token) values (@id_module, @id_module_group,@id_label,'BCLI.Resources','COBISCorp.tCOBIS.BCLI.Resources.dll',0,'')

select @id_component = isnull(max(co_id),0) + 1 from an_component 
insert into an_component (co_id,co_mo_id,co_name,co_class,co_namespace,co_ct_id,co_arguments,co_prod_name) values (@id_component,@id_module,'BCLI.Resources','FBuscarClienteClass','COBISCorp.tCOBIS.BClientes','A','','M-MIS')

select @id_agent = isnull(max(ag_id),0) + 1 from an_agent
insert into an_agent (ag_id,ag_co_id,ag_name,ag_la_id) values (@id_agent,@id_component,'BCLI.Resources',@id_label)

print 'Permisos para Rol'

insert into an_role_component values (@id_component,@w_rol)
insert into an_role_module values (@id_module,@w_rol)
insert into an_role_agent (ra_ag_id,ra_rol,ra_order) values (@id_agent,@w_rol,1)
go


