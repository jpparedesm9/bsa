use cobis
go
if exists(select 1 from sysobjects where name like 'sp_cen_catalogar')
   drop proc sp_cen_catalogar
go
create proc sp_cen_catalogar (
    @i_debug                char(1)      = 'N',     --S/N
    @i_opcion               char(10),    --MODGRP,MOD,PAGE,ZONE,COMP,PAGZONE,    AGE
    @i_role                 int          = 0,         --id ROLE
    @i_prod_name            varchar(10), --Identify to Product
    @i_module_group         varchar(50), --Name of Module Group
    @i_version              varchar(15)  = '1.0.0.0', --package Version to Distrib
    @i_localizacion         varchar(255) = 'NA',--path localization of package(http://localhost/Package.Installer/Package.installer.application)
    @i_store_name           varchar(40)  = 'COBISExplorer', --name folder to install Packages
    @i_culture              varchar(10)  = 'ES_EC',
    @i_module               varchar(50)  = null, 
    @i_label_module         varchar(50)  = null,
    @i_filename_module      varchar(255) = null,
    @i_parent_module        varchar(50)  = null, 
    @i_page                 varchar(40)  = null,
    @i_label_page           varchar(100) = null,
    @i_parent_page          varchar(40)  = null,
    @i_args_page            varchar(255) = null,
    @i_zone                 varchar(50)  = null,
    @i_hor_size             int          = 100,
    @i_ver_size             int          = 100,
    @i_name_component       varchar(255) = null,
    @i_class_component      varchar(255)  = null,
    @i_namespace_component  varchar(255) = null,
    @i_args_component       varchar(255) = null,
    @i_type                 varchar(10)  = 'SV',
    @i_name_agent           varchar(50)  = null,
    @i_label_agent          varchar(100) = null,
    @i_nemonico             varchar(40)  = 'Nemonic'
)  
as
declare @id_module_group   int,
        @id_label_module   int,
        @id_module         int,
        @id_parent_module  int,
        @id_page           int,
        @id_parent_page    int,
        @id_label_page     int,
        @id_order_page     int,
        @id_pz             int,
        @id_zone           int,
        @id_component      int,
        @id_page_zone      int,
        @id_pz_order       int,
        @id_agent          int,
        @id_label_agent    int,
        @w_error           varchar(255)

begin tran

--Find general data to use in the program
select @id_module_group = mg_id 
from an_module_group 
where mg_name = @i_module_group

select @id_zone = zo_id 
from an_zone 
where zo_name = @i_zone

select @id_component = co_id 
from an_component 
where co_name = @i_name_component 
      and co_class = @i_class_component
      
select @id_page = pa_id 
from an_page 
where pa_name = @i_page

select @id_module = mo_id 
from an_module 
where mo_name = @i_module

select @id_parent_module = mo_id 
from an_module 
where mo_name = @i_parent_module

select @id_label_page = la_id 
from an_label 
where la_label = @i_label_page 
      and la_prod_name = @i_prod_name

select @id_agent = ag_id 
from an_agent 
where ag_name = @i_name_agent

select @id_label_agent = la_id 
from an_label 
where la_label = @i_label_agent

--Overload of input parameters
select @i_debug = 'N'

select @i_role = ri_role
from an_role_install
where ri_prod_name = @i_prod_name
   
if @@rowcount = 0
begin
    select @w_error = 'NO EXISTE DEFINIDO ROL PARA EL PRODUCTO -> an_role_install'
    goto error
end

if @i_opcion = 'ZONE'
begin --Zone   
    if @id_zone is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
            
        select @id_zone = isnull(max(zo_id),1)+1 
        from an_zone

        insert into an_zone
        values(@id_zone,@i_zone,1,0,1,1)
    end
    if @i_debug = 'S' 
        select zone = @id_zone, @i_zone
end

if @i_opcion in ('MODGRP','MOD')
begin --Module Group   
    if @id_module_group is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
        
        select @id_module_group = isnull(max(mg_id),1)+1 
        from an_module_group

        insert into an_module_group 
        values (@id_module_group,@i_module_group,@i_version,@i_localizacion,@i_store_name)
    end
    if @i_debug = 'S' 
        select module_group = @id_module_group,@i_module_group
end

if @i_opcion = 'MOD'
begin --Label Module
    select @id_label_module = la_id 
    from an_label 
    where la_label = @i_label_module
    
    if @id_label_module is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'

        select @id_label_module = isnull(max(la_id),1)+1 
        from an_label
   
        insert into an_label
        values (@id_label_module,@i_culture,@i_label_module,@i_prod_name)
    end
    if @i_debug = 'S' 
        select label_module = @id_label_module,@i_label_module

    --Module   
    if @id_module is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
        
        select @id_module = isnull(max(mo_id),1)+1 
        from an_module
   
        if @i_filename_module is null 
            select @i_filename_module = @i_namespace_component + '.dll'
      
        if @id_parent_module is null 
            select @id_parent_module = 0
      
        insert into an_module
        values (@id_module,@id_module_group,@id_label_module,@i_module,@i_filename_module,@id_parent_module,null)
      
        if isnull(@id_parent_module,0) > 0
        begin 
            insert into an_module_dependency
            values (@id_module,@id_parent_module)
        end
    end
    if not exists (select * from an_role_module where rm_mo_id = @id_module and rm_rol = @i_role)
        insert into an_role_module 
        values (@id_module,@i_role)

    if @i_debug = 'S' 
        select module = @id_module,@i_module,@i_filename_module
end

if @i_opcion = 'COMP'
begin --Component   
    if @id_component is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
        
        select @id_component = isnull(max(co_id),1)+1 
        from an_component
   
        if @id_component is null 
            select  @id_component = 1
      
        insert into an_component
        values(@id_component,@id_module,@i_name_component,@i_class_component,@i_namespace_component,@i_type,isnull(@i_args_component,''),@i_prod_name)
    end
    if not exists (select * from an_role_component where rc_co_id = @id_component and rc_rol = @i_role)
        insert into an_role_component
        values (@id_component,@i_role)

    if @i_debug = 'S' 
        select component = @id_component,@i_name_component,@i_class_component,@i_namespace_component
end

if @i_opcion = 'AGE'
begin --Agent   
    if @id_agent is null begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
        
        select @id_agent = isnull(max(ag_id),1)+1 
        from an_agent
   
        --Label  Page   
        if @id_label_agent is null
        begin
            if @i_debug = 'S' 
                print '   *** Inserta ***'
            
            select @id_label_agent = isnull(max(la_id),1)+1 
            from an_label
   
            insert into an_label
            values (@id_label_agent,@i_culture,@i_label_agent,@i_prod_name)
        end
      
        if @i_debug = 'S' 
            select label_agent = @id_label_agent,@i_label_agent
      
        if @id_agent is null 
            select  @id_agent = 1
      
        insert into an_agent
        values(@id_agent,@id_component,@i_name_agent,@id_label_agent)
    end
    if not exists (select * from an_role_agent where ra_ag_id = @id_agent and ra_rol = @i_role)
        insert into an_role_agent
        values (@id_agent,@i_role,1)

    if @i_debug = 'S' 
        select agent = @id_agent,@i_name_agent
end

if @i_opcion in ('PAGE')
begin --Parent Page
    if not @i_parent_page is null
    begin
        if @i_debug = 'S'
            print '   *** Inserta ***'
        
        select @id_parent_page = pa_id 
        from an_page 
        where pa_name = @i_parent_page
      
        if @id_parent_page is null
        begin
            select @w_error = 'No Existe parent_page [' + @i_parent_page + ']'
            goto error
        end
   
        select @id_order_page = max(pa_order)+1 
        from an_page 
        where pa_id_parent = @id_parent_page
        
        if @id_order_page is null
            select @id_order_page  = 1
   
        if @i_debug = 'S' 
            select parent_page = @id_parent_page,@i_parent_page
    end
    else
    begin
        select @id_parent_page = 0,
               @id_order_page  = 0 
    end
      
    --Page   
    if @id_page is null
    begin
        if @i_debug = 'S' 
            print '   *** Inserta ***'
        
        --Label  Page   
        if @id_label_page is null
        begin
            if @i_debug = 'S'
                print '   *** Inserta ***'
         
            select @id_label_page = isnull(max(la_id),1)+1 
            from an_label
   
            insert into an_label
            values (@id_label_page,@i_culture,@i_label_page,@i_prod_name)
        end
        
        if @i_debug = 'S' 
        select label_page = @id_label_page,@i_label_page
   
        select @id_page = isnull(max(pa_id),1)+1 
        from an_page
   
        insert into an_page(pa_id,pa_la_id,pa_name,pa_icon,pa_id_parent,pa_order,pa_splitter,pa_nemonic,pa_prod_name,pa_arguments,pa_he_id)
        values (@id_page,@id_label_page,@i_page,'icono pagina',@id_parent_page,@id_order_page,'horizontal',@i_nemonico,@i_prod_name,@i_args_page,null)   
    end
    if not exists (select * from an_role_page where rp_pa_id = @id_page and rp_rol = @i_role)
        insert into an_role_page 
        values (@id_page,@i_role)

    if @i_debug = 'S' 
        select page = @id_page,@i_page, order_page = @id_order_page, label_page= @id_label_page, @i_label_page
end

if @i_opcion in ('PAGZONE')
begin --Page Zone
    select @id_page_zone = pz_zo_id 
    from an_page_zone 
    where pz_zo_id = @id_zone and pz_pa_id = @id_page and pz_co_id = @id_component
    
    if @id_page_zone is null
    begin
        if @i_debug = 'S'
            print '   *** Inserta ***'
      
        --Label  Page   
        if @id_label_page is null 
        begin
            if @i_debug = 'S' 
                print '   *** Inserta ***'
            
            select @id_label_page = isnull(max(la_id),1)+1 
            from an_label
   
            insert into an_label
            values (@id_label_page,@i_culture,@i_label_page,@i_prod_name)
        end
        if @i_debug = 'S' 
            select label_page = @id_label_page,@i_label_page

        select @id_pz = max(pz_id) + 1 
        from cobis..an_page_zone
      
        if @id_pz is null 
            select @id_pz = 1
      
        select @id_pz_order = max(pz_order) + 1 
        from an_page_zone 
        where pz_zo_id = @id_zone and 
              pz_pa_id = @id_page and 
              pz_co_id = @id_component
        
        if @id_pz_order is null 
            select @id_pz_order = 1
      
        insert into an_page_zone
        values(@id_pz,@id_zone,@id_label_page,@id_page,@id_component,@id_pz_order,@i_hor_size,@i_ver_size,'Ninguno','horizontal',0,1,null)
    end
    if @i_debug = 'S' 
        select page_zone = @id_zone,@id_label_page,@id_page,@id_component
end

debug:
if @i_debug = 'S' begin
    print '' print '' print '' print '============== DEBUG ================='
    if exists (select * from an_page where pa_id = @id_page) 
        select * 
        from an_page 
        where pa_id = @id_page
        
    if exists (select * from an_page where pa_id_parent = @id_parent_page) 
        select * 
        from an_page 
        where pa_id_parent = @id_parent_page
        
    if exists (select * from an_role_module where rm_mo_id = @id_module) 
        select * 
        from an_role_module 
        where rm_mo_id = @id_module
        
    if exists (select * from an_role_page where rp_pa_id = @id_page) 
        select * 
        from an_role_page 
        where rp_pa_id = @id_page
        
    if exists (select * from an_zone where zo_id = @id_zone) 
        select * 
        from an_zone 
        where zo_id = @id_zone
    
    if exists (select * from an_component where co_id = @id_component) 
        select * 
        from an_component 
        where co_id = @id_component
        
    if exists (select * from an_page_zone where pz_zo_id = @id_zone and pz_pa_id = @id_page and pz_co_id = @id_component) 
        select * 
        from an_page_zone 
        where pz_zo_id = @id_zone and 
              pz_pa_id = @id_page and 
              pz_co_id = @id_component
end


goto fin
error:
   print ''
   print '=============== ERROR ================='
   print @w_error
   rollback tran
fin:
   commit tran
   --rollback tran
go
