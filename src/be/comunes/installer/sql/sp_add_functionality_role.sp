use cobis
go


if exists (select 1 from sysobjects where name = 'add_functionality_role')
   drop proc add_functionality_role
go

CREATE proc add_functionality_role(
	@w_role_desc		varchar(255),
	@w_prod_name 		varchar(50)  = null,
	@w_nav_name			varchar(255) = null,
	@w_functionality	varchar(30)
)

AS
begin
	declare @w_component_id			int,
			@w_component_name		varchar(255),
			@w_module_id			int,
			@w_page_id				int,
			@w_nav_zone_id			int,
			@w_role				    int,
			@w_trn					int,
			@w_service				varchar(255),
			@w_id_producto			tinyint,
			@w_tipo					char(1),
			@w_moneda				int,
			@w_estado				char(1),
			@w_menu_id				int,
			@w_resource				int
			

	select @w_role 		  = ro_rol
	  from ad_rol
	 where ro_descripcion = @w_role_desc
	 

	--select @w_id_producto	= pd_producto 
	--  from cobis..cl_producto 
	-- where pd_abreviatura 	= @w_prod_name
	 
	select @w_tipo		= 'R'
	select @w_moneda   	= 0
	select @w_estado 	= 'V'

	if @w_role is not null 
	begin
				
		--Autorización componentes por rol, servicios y transacciones
		select @w_component_id = 0
		
		
		select @w_component_id 	=  comp_id, 
			   @w_id_producto   =  (select isnull(pd_producto,0) from cl_producto where pd_abreviatura = comp_prod)
		  from components_tmp
		 where comp_type  		= 'C'
		   and comp_funct 		= @w_functionality
		   and comp_id    		> @w_component_id
	  order by comp_id desc
 
	
		while @@rowcount > 0
		begin
			print '@w_component_id: ' + convert(varchar, @w_component_id) + ', @w_id_producto: ' + convert(varchar, @w_id_producto)
			if @w_component_id is not null and @w_component_id <> 0
			begin
				if not exists (select 1 from an_role_component where rc_co_id = @w_component_id and rc_rol = @w_role)
				begin
					insert into an_role_component (rc_co_id, rc_rol)
					values (@w_component_id, @w_role)
				end
				
				select @w_trn = 0
				select @w_trn		  = tc_tn_trn_code
				  from an_transaction_component
				 where tc_co_id  	  = @w_component_id
				   and tc_tn_trn_code > @w_trn
			  order by tc_tn_trn_code desc
				
				while @@rowcount > 0
				begin
					if not exists (select 1 from ad_tr_autorizada where ta_rol = @w_role and ta_transaccion = @w_trn and ta_moneda = @w_moneda)
					begin
						insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
						values (@w_id_producto, @w_tipo, @w_moneda, @w_trn, @w_role, getdate(), 1, @w_estado, getdate())
					end
					select @w_trn		  = tc_tn_trn_code
					  from an_transaction_component
					 where tc_co_id  	  = @w_component_id
					   and tc_tn_trn_code > @w_trn
				  order by tc_tn_trn_code desc
				
				end
				
				select @w_service = 0
				
				select @w_service 			= sc_csc_service_id
				  from an_service_component
				 where sc_co_id 			= @w_component_id
				   and sc_csc_service_id 	> @w_service
			  order by sc_csc_service_id desc
			
				while @@rowcount > 0
				begin
					if not exists (select 1 from ad_servicio_autorizado where ts_servicio = @w_service and ts_rol = @w_role and ts_moneda = @w_moneda)
					begin
						insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
						values (@w_service, @w_role, @w_id_producto, @w_tipo, @w_moneda, getdate(), @w_estado, getdate())
					end
					
					select @w_service 			= sc_csc_service_id
					  from an_service_component
					 where sc_co_id 			= @w_component_id
					   and sc_csc_service_id 	> @w_service
				  order by sc_csc_service_id desc
				
				end
				
			end
			
			select @w_component_id 	=  comp_id,
				   @w_id_producto   =  (select isnull(pd_producto,0) from cl_producto where pd_abreviatura = comp_prod)
		      from components_tmp
		     where comp_type  		= 'C'
			   and comp_funct 		= @w_functionality
		       and comp_id    		> @w_component_id
	      order by comp_id desc
					
		end
	
		--Autorización módulo por rol
		select @w_module_id = 0
		
		select @w_module_id 	=  comp_id
		  from components_tmp
		 where comp_type  		= 'M'
		   and comp_funct 		= @w_functionality
		   and comp_id    		> @w_module_id
	  order by comp_id desc
	   
  
		while @@rowcount > 0
		begin
			
			if @w_module_id is not null and @w_module_id <> 0
			begin
				if not exists (select 1 from an_role_module where rm_mo_id = @w_module_id and rm_rol = @w_role)
				begin
					insert into an_role_module (rm_mo_id, rm_rol)
					values (@w_module_id, @w_role)
				end
			end
			
			select @w_module_id 	=  comp_id
		      from components_tmp
		     where comp_type  		= 'M'
			   and comp_funct 		= @w_functionality
		       and comp_id    		> @w_module_id
	      order by comp_id desc
		  
		end
	
		--Autorización páginas por rol
	--	select @w_page_id		= pa_id
    --      from an_page
	--     where pa_name 	    	in (select page_id from @w_tpages
	--       and pa_id			> @w_page_id
    --  order by pa_id desc

		select @w_page_id = 0
		
		select @w_page_id 		=  comp_id
		  from components_tmp
		 where comp_type  		= 'P'
		   and comp_funct 		= @w_functionality
		   and comp_id    		> @w_page_id
	  order by comp_id desc
	  
		while @@rowcount > 0
		begin
		
			if @w_page_id is not null and @w_page_id <> 0
			begin
				if not exists (select 1 from an_role_page where rp_pa_id = @w_page_id and rp_rol = @w_role)
				begin
					insert into an_role_page (rp_pa_id, rp_rol)
					values (@w_page_id, @w_role)
				end
			end
				
			select @w_page_id 		=  comp_id
		      from components_tmp
		     where comp_type  		= 'P'
			   and comp_funct 		= @w_functionality
		       and comp_id    		> @w_page_id
	      order by comp_id desc	
		end
	
		--Autorización zonas de navegación por rol
		select @w_nav_zone_id = 0
		select @w_nav_zone_id					= nz_id
          from an_navigation_zone
         where charindex(nz_name, @w_nav_name) 	> 0
	       and nz_id 							> @w_nav_zone_id
      order by nz_id  desc
  
		while @@rowcount > 0
		begin
		
			if @w_nav_zone_id is not null and @w_nav_zone_id <> 0
			begin
				if not exists (select 1 from an_role_navigation_zone where rn_nz_id = @w_nav_zone_id and rn_rol = @w_role)
				begin
					insert into an_role_navigation_zone (rn_rol, rn_nz_id)
					values (@w_role, @w_nav_zone_id)
				end
			end	
			
			select @w_nav_zone_id					= nz_id
			  from an_navigation_zone
			 where charindex(nz_name, @w_nav_name) 	> 0
			   and nz_id 							> @w_nav_zone_id
		  order by nz_id  desc	
		end
		
		--Autorización Menú Contenedor por rol
		select @w_menu_id = 0
		
		select @w_menu_id 		=  comp_id--,
			   --@w_id_producto   =  (select isnull(pd_producto,0) from cl_producto where pd_abreviatura = comp_prod)
		  from components_tmp
		 where comp_type  		= 'MNU'
		   and comp_funct 		= @w_functionality
		   and comp_id    		> @w_menu_id
	  order by comp_id desc
	  
		while @@rowcount > 0
		begin
		
			if @w_menu_id is not null and @w_menu_id <> 0
			begin
				if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_role)
				begin
					insert into cew_menu_role (mro_id_menu, mro_id_role)
					values ( @w_menu_id, @w_role)
				end
			end
			
			select @w_resource = 0
			
			select @w_resource 		= mr_id_resource
			  from cew_menu_resource
			 where mr_id_menu 		= @w_menu_id
			   and mr_id_resource 	> @w_resource
		  order by mr_id_resource desc
		  
			while @@rowcount >0
			begin
				if not exists(select 1 from cew_resource_rol where rro_id_resource = @w_resource and rro_id_rol = @w_role)
				begin
					insert into cew_resource_rol (rro_id_resource, rro_id_rol)
					values (@w_resource, @w_role)
				end
				
				select @w_resource 		= mr_id_resource
			      from cew_menu_resource
			     where mr_id_menu 		= @w_menu_id
			       and mr_id_resource 	> @w_resource
		      order by mr_id_resource desc
			  
			end
			
			--Servicios por menu contenedor
			select @w_service = ''
			
			select @w_service 		= ms_servicio,
				   @w_id_producto 	= ms_producto
			  from cew_menu_service
			 where ms_id_menu 	= @w_menu_id
			   and ms_servicio 	> @w_service
		  order by ms_servicio desc
			 
			while @@rowcount > 0
			begin
				if not exists (select 1 from ad_servicio_autorizado where ts_rol = @w_role and ts_servicio = @w_service and ts_moneda = @w_moneda)
				begin
					insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
					values (@w_service, @w_role, @w_id_producto, 'R', 0, getdate(),'V',getdate())
				end
				select @w_service 		= ms_servicio,
					   @w_id_producto 	= ms_producto
			      from cew_menu_service
			     where ms_id_menu 	= @w_menu_id
			       and ms_servicio 	> @w_service
		      order by ms_servicio desc
			
			end
			
			--Transacciones por menú contenedor			
			select @w_trn = 0
			
			select @w_trn 			= mt_transaccion,
			       @w_id_producto 	= mt_producto
			  from cew_menu_transaccion
			 where mt_id_menu 		= @w_menu_id
			   and mt_transaccion 	> @w_trn
		  order by mt_transaccion desc
			 
			while @@rowcount > 0
			begin
				if not exists (select 1 from ad_tr_autorizada where ta_rol = @w_role and ta_transaccion = @w_trn and ta_moneda = @w_moneda)
				begin
					insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
					values (@w_id_producto, @w_tipo, @w_moneda, @w_trn, @w_role, getdate(), 1, @w_estado, getdate())
				end
				
				select @w_trn 			= mt_transaccion,
				       @w_id_producto 	= mt_producto
			      from cew_menu_transaccion
			     where mt_id_menu 		= @w_menu_id
			       and mt_transaccion 	> @w_trn
		      order by mt_transaccion desc
			
			end
			
			select @w_menu_id 		=  comp_id,
			       @w_id_producto   =  (select isnull(pd_producto,0) from cl_producto where pd_abreviatura = comp_prod)
		      from components_tmp
		     where comp_type  		= 'MNU'
		       and comp_funct 		= @w_functionality
		       and comp_id    		> @w_menu_id
	      order by comp_id desc
		end
		
		-------------------------------------
		-- FUNCIONALIDADES BASICAS DEL CEN --
		-------------------------------------
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1556 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,1556,@w_role,getdate(),1,'V',getdate())		
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1564 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,1564,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1574 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,1574,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1577 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,1577,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1579 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,1579,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15001 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15001,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15031 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15031,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15153 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15153,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15168 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15168,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15301 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15301,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15302 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15302,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15315 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15315,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15316 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15316,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15317 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15317,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15318 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15318,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15319 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15319,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15320 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15320,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15913 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15913,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 568 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,568,@w_role,getdate(),1,'V',getdate())
		if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15098 and ta_rol = @w_role)
			insert into  ad_tr_autorizada values(1,'R',0,15098, @w_role,getdate(),1,'V',getdate())		
		
		----------------------------------------------
		--AUTORIZACION DE MODULE WEB PAGE CONTAINER---
		----------------------------------------------
		select @w_module_id = mo_id
		from an_module
		where mo_name		 = 'COBISExplorer.Container.WebPageContainer'
		
		
		if not exists (select 1 from an_role_module where rm_mo_id = @w_module_id and rm_rol = @w_role)
		begin
			insert into an_role_module values(@w_module_id, @w_role)
		end
		
		select @w_module_id = mo_id
		from an_module
		where mo_name		 = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage'
		
		if not exists (select 1 from an_role_module where rm_mo_id = @w_module_id and rm_rol = @w_role)
		begin
			insert into an_role_module values(@w_module_id, @w_role)
		end
		
		select @w_module_id = mo_id
		from an_module
		where mo_name		 = 'COBISCorp.eCOBIS.COBISExplorer.Help'
		
		if not exists (select 1 from an_role_module where rm_mo_id = @w_module_id and rm_rol = @w_role)
		begin
			insert into an_role_module values(@w_module_id, @w_role)
		end
		----------------------------------------------
		--AUTORIZACION DE COMPONENTES COBISExplorer---
		----------------------------------------------
		select @w_component_id = co_id
		from an_component
		where co_name		 = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISNavigationPageView'
		
		if not exists (select 1 from an_role_component where rc_co_id = @w_component_id and rc_rol = @w_role)
		begin
			insert into an_role_component values(@w_component_id, @w_role)
		end
		
		select @w_component_id = co_id
		from an_component
		where co_name		 = 'COBISCorp.eCOBIS.COBISExplorer.Container.NavigationPage.COBISFavoritesView'
		
		if not exists (select 1 from an_role_component where rc_co_id = @w_component_id and rc_rol = @w_role)
		begin
			insert into an_role_component values(@w_component_id, @w_role)
		end
		
		select @w_component_id = co_id
		from an_component
		where co_name		 = 'COBISCorp.eCOBIS.COBISExplorer.Help.View.COBISHelpView'
		
		if not exists (select 1 from an_role_component where rc_co_id = @w_component_id and rc_rol = @w_role)
		begin
			insert into an_role_component values(@w_component_id, @w_role)
		end
		
		
		-------------------------------------------
		-- FUNCIONALIDADES BASICAS DEL CONTENEDOR --
		-------------------------------------------
			
		if not exists (select 1 from ad_servicio_autorizado where ts_rol = @w_role and ts_servicio = 'CEW.Menu.getMenuByRole' and ts_moneda = @w_moneda)
		begin
			insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
			values ('CEW.Menu.getMenuByRole', @w_role, 1, 'R', 0, getdate(),'V',getdate())
		end
		
		if not exists (select 1 from ad_servicio_autorizado where ts_rol = @w_role and ts_servicio = 'CEW.Official.GetOfficialInfo' and ts_moneda = @w_moneda)
		begin
			insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
			values ('CEW.Official.GetOfficialInfo', @w_role, 1, 'R', 0, getdate(),'V',getdate())
		end
		
		if not exists (select 1 from ad_servicio_autorizado where ts_rol = @w_role and ts_servicio = 'CEW.Favorites.getUserFavorites' and ts_moneda = @w_moneda)
		begin
			insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
			values ('CEW.Favorites.getUserFavorites', @w_role, 1, 'R', 0, getdate(),'V',getdate())
		end
		
		if not exists (select 1 from ad_servicio_autorizado where ts_rol = @w_role and ts_servicio = 'CEW.Preferences.getUserPreferences' and ts_moneda = @w_moneda)
		begin
			insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
			values ('CEW.Preferences.getUserPreferences', @w_role, 1, 'R', 0, getdate(),'V',getdate())
		end
		
	end
	
	
	return 0
end
go
