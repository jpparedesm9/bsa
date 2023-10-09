use cobis
go
      

declare @w_prod_name			varchar(50),
        @w_role_desc 			varchar(50),
        @w_pa_name 				varchar(255),
        @w_mo_name				varchar(255),
        @w_co_name 				varchar(255),
	   @w_has_adm_cobis		     char(1),
	   @w_has_workflow		     char(1),
	   @w_has_business_trn 	     char(1),
	   @w_has_queries_prints      char(1),
		@w_has_batch			char(1),
		@w_has_inbox			char(1),
		@w_has_movil_bank		char(1),
		@w_has_fund				char(1),
		@w_has_abm_products		char(1),
		@w_page					int,
		@w_functionality 		varchar(30),
	   @w_menu				int,
        @w_submenu                 int, 
        @w_menu_pant               int 
		
		
--Roles

create table #role_functionalities(
	rf_rol_desc					varchar(50) not null,
	rf_has_admin_cobis			char(1) not null,
	rf_has_workflow				char(1) not null,
	rf_has_business_trn 		char(1) not null,
	rf_has_queries_prints   	char(1) not null,
	rf_has_batch				char(1) not null,
	rf_has_inbox				char(1) not null,
	rf_has_movil_bank			char(1) not null,
	rf_has_fund					char(1) not null,
	rf_has_abm_products			char(1) not null)

--ADMINISTRADOR
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis, rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank, rf_has_fund, rf_has_abm_products)
values ('ADMINISTRADOR', 'S', 'S', 'N', 'N', 'N', 'S', 'N', 'N', 'N')

--FUNCIONARIO OFICINA
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis,  rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank, rf_has_fund, rf_has_abm_products)
values ('FUNCIONARIO OFICINA', 'N', 'N', 'S', 'S', 'N', 'S', 'N', 'N', 'N')

--CONSULTA
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis,  rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank,rf_has_fund,rf_has_abm_products)
values ('CONSULTA', 'N', 'N', 'N', 'S', 'N', 'S', 'N', 'N', 'N')

--ASESOR
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis,  rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank, rf_has_fund, rf_has_abm_products)
values ('ASESOR', 'N', 'N', '', 'S', 'N', 'S', 'S', 'N', 'S')

--OPERADOR DE BATCH COBIS
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis,  rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank, rf_has_fund, rf_has_abm_products)
values ('OPERADOR DE BATCH COBIS', '', 'N', 'N', 'N', 'S', 'N', 'N', 'N', 'N')	
	
--OPERADOR DE BATCH COBIS
insert into #role_functionalities (rf_rol_desc, rf_has_admin_cobis,  rf_has_workflow, rf_has_business_trn, rf_has_queries_prints, rf_has_batch, rf_has_inbox,rf_has_movil_bank,rf_has_fund, rf_has_abm_products)
values ('OPERADOR SOFOM', 'N', 'N', 'N', 'N', 'S', 'S', 'N', 'S', 'N')
	
create table components_tmp(
	comp_id 	int,
	comp_name	varchar(255),
	comp_type	varchar(5),
	comp_prod	varchar(30),
	comp_funct	varchar(30)
)
	
	
--Borrar autorizaciones por rol
delete an_role_page where rp_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete an_role_component where rc_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete an_role_module where rm_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete cew_menu_role where mro_id_role in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete cew_resource_rol where rro_id_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete ad_tr_autorizada where ta_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))
delete ad_servicio_autorizado where ts_rol in (select ro_rol from ad_rol where ro_descripcion in ('ADMINISTRADOR', 'FUNCIONARIO OFICINA', 'CONSULTA', 'ASESOR', 'OPERADOR DE BATCH COBIS', 'OPERADOR SOFOM'))

select @w_role_desc = ''
	
  select @w_role_desc 			= rf_rol_desc,
		 @w_has_adm_cobis		= rf_has_admin_cobis,
		 @w_has_workflow		= rf_has_workflow,
		 @w_has_business_trn 	= rf_has_business_trn,
		 @w_has_queries_prints	= rf_has_queries_prints,
		 @w_has_batch			= rf_has_batch,
		 @w_has_inbox			= rf_has_inbox,
		 @w_has_movil_bank		= rf_has_movil_bank,
		 @w_has_fund			= rf_has_fund,
		 @w_has_abm_products	= rf_has_abm_products
    from #role_functionalities
   where rf_rol_desc 	> @w_role_desc
order by rf_rol_desc desc
	
while @@rowcount > 0
begin
		print '@w_role_desc: '+@w_role_desc
		print '@w_has_adm_cobis: '			+ @w_has_adm_cobis		
		print '@w_has_workflow: '		    + @w_has_workflow		
		print '@w_has_business_trn: ' 	    + @w_has_business_trn 	
		print '@w_has_queries_prints:' 	    + @w_has_queries_prints	
		print '@w_has_batch:' 			    + @w_has_batch			
		print '@w_has_inbox:'			    + @w_has_inbox			
		print '@w_has_movil_bank:'		    + @w_has_movil_bank
		print '@w_has_fund:'				+ @w_has_fund
		print '@w_has_abm_products:'		+ @w_has_abm_products
	
	--Parametrización de COBIS:
	if @w_has_adm_cobis = 'S'	
	begin
				
		print 'w_has_adm_cobis'
		--Páginas
		
		if not exists ( select 1 from components_tmp where comp_funct = 'PARAM_COBIS')
		begin
			print '1.1'
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 'ADM', 'PARAM_COBIS'
			  from an_page 
			 where pa_la_id in (select la_id 
								 from an_label 
								where la_label = 'Administración del Sistema')
		 
			select @w_page = 0
			
		
	  
			while exists (select 1
			                from an_page 
						   where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P') 
							 and pa_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P'))
			begin
				insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
				select pa_id, pa_name, 'P', 'ADM', 'PARAM_COBIS'
				  from an_page 
				 where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P') 
				   and pa_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P')
			
			end
		
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 'ADM', 'PARAM_COBIS'
			from an_component 
			where upper(co_name) like upper('%ADM.RED%')
			   or upper(co_name) like upper('%ADM.Prod%')
			   or upper(co_name) like upper('%ADM.Ref%')
			   or upper(co_name) like upper('%ADM.Seg%')
	
				
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'ADM', 'PARAM_COBIS'
			from an_module 
			where upper(mo_name) like upper('%ADM.RED%')
			   or upper(mo_name) like upper('%ADM.Prod%')
			   or upper(mo_name) like upper('%ADM.Ref%')
			   or upper(mo_name) like upper('%ADM.Seg%')
			
			
			--Administración
			--Páginas
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 
			       case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				   end,
				   'PARAM_COBIS'
			  from an_page 
			 where pa_id_parent in (select pa_id 
			                         from an_page 
									where pa_la_id in (select la_id 
														from an_label 
													   where la_label = 'Administración'
								                         and la_prod_name = 'M-CCA'))
			and pa_name  <> 'CCA.ADM.VisualBatch'  
		 
	  
			while exists (select 1 
			                from an_page 
						   where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P') 
							 and pa_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P'))
			begin
				insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
				select pa_id, pa_name, 'P', 
					   case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				       end,
					   'PARAM_COBIS'
				  from an_page 
				 where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P') 
				   and pa_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'P')
	
			
			end
			
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'ADM', 'PARAM_COBIS'
			from an_module 
			where upper(mo_name) like upper('%CON.ConsolidationCompanies%')
			   or upper(mo_name) like upper('%CON.TaxTables%')
			   or upper(mo_name) like upper('%CON.ChartAccounts%')
			   or upper(mo_name) like upper('%CON.AccountingInterface%')
			   or upper(mo_name) like upper('%CON.Company%')
			   or upper(mo_name) like upper('%CON.resources%')
			   or upper(mo_name) like upper('%CON.SharedLibrary%')	
			   or upper(mo_name) like upper('%PER.Products%')
			   or upper(mo_name) like upper('%PER.SharedLibrary%')
			   or upper(mo_name) like upper('%PER.Resources%')
			   or upper(mo_name) like upper('%PFI.Management%')
			   or upper(mo_name) like upper('%CTA.Ahos.AccountingAdmAccounts%')
			   or upper(mo_name) like upper('%CTA.FTran%')
			   or upper(mo_name) like upper ('%CTA.Ahos.Admin%')
			
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 
				   case substring(co_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(co_prod_name, 3, 3)
				   end,
				   'PARAM_COBIS'
			from an_component 
			where co_mo_id in (select mo_id
								from an_module 
								where upper(mo_name) like upper('%CON.ConsolidationCompanies%')
								   or upper(mo_name) like upper('%CON.TaxTables%')
								   or upper(mo_name) like upper('%CON.ChartAccounts%')
								   or upper(mo_name) like upper('%CON.AccountingInterface%')
								   or upper(mo_name) like upper('%CON.Company%')
								   or upper(mo_name) like upper('%CON.resources%')
								   or upper(mo_name) like upper('%CON.SharedLibrary%')	
								   or upper(mo_name) like upper('%PER.Products%')
								   or upper(mo_name) like upper('%PER.SharedLibrary%')
								   or upper(mo_name) like upper('%PER.Resources%')
								   or upper(mo_name) like upper('%PFI.Management%')
								   or upper(mo_name) like upper('%CTA.Ahos.AccountingAdmAccounts%')
								   or upper(mo_name) like upper('%CTA.Ahos.Admin%'))	
			or upper(co_name) like upper('%CON.ConsolidationCompanies%')
			or upper(co_name) like upper('%CON.TaxTables%')
			or upper(co_name) like upper('%CON.ChartAccounts%')
			or upper(co_name) like upper('%CON.AccountingInterface%')
			or upper(co_name) like upper('%CON.Company%')
			or upper(co_name) like upper('%CON.resources%')
			or upper(co_name) like upper('%CON.SharedLibrary%')	
			or upper(co_name) like upper('%PER.Products%')
			or upper(co_name) like upper('%PER.SharedLibrary%')
			or upper(co_name) like upper('%PER.Resources%')
			or upper(co_name) like upper('%PFI.Management%')
			or upper(co_name) like upper('%CTA.Ahos.AccountingAdmAccounts%')
			or upper(co_name) like upper('%CTA.FTran%')
			
		
		    --Contenedor	
		    insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		    select me_id, me_name, 'MNU', 
		           'ADM',
		    	   'PARAM_COBIS'
		    from cew_menu 
		    where me_name = 'MNU_ADMIN'

			
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		    select me_id, me_name, 'MNU', 
		           'ADM',
		    	   'PARAM_COBIS'
		    from cew_menu 
		    where me_id_parent = ( select me_id from cew_menu where me_name = 'MNU_ADMIN')
		
			
			
		    while exists (select 1
			                   from cew_menu 
						      where me_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'MNU') 
							    and me_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'MNU'))
		    begin
		    	insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
		    	select me_id, me_name, 'MNU', 'ADM',  'PARAM_COBIS'
		    	  from cew_menu 
				 where me_id_parent in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'MNU') 
				   and me_id not in (select comp_id from components_tmp where comp_funct = 'PARAM_COBIS' and comp_type	= 'MNU')
				
		    end
		end		
		
		exec add_functionality_role
			@w_role_desc		= @w_role_desc,
			@w_prod_name		= 'CCA',
			@w_nav_name	    	= 'NavigationPageZone, FavoritesZone, HelpZone',
			@w_functionality	= 'PARAM_COBIS'
			
		
	end
	
	------------------------------------ABM Productos--------------------------------------------
	if @w_has_abm_products = 'S'
	begin
		print 'ABM Productos'
		insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		select me_id, me_name, 'MNU', 
		       'CCA',
			   'ABM'
		from cew_menu 
		where me_name in ('MNU_OPER', 'MNU_ADMIN', 'MNU_CUSTOMER_OPER', 'MNU_CUSTOMER_ADM', 'MNU_GROUP_ADM')
		
		insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
		select me_id, me_name, 'MNU', 
		       'CCA',
			   'ABM'
		from cew_menu 
		where me_id_parent in (SELECT me_id FROM cobis..cew_menu WHERE me_name in ('MNU_CUSTOMER_OPER', 'MNU_CUSTOMER_ADM', 'MNU_GROUP_ADM'))		
		
		
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'CCA',
			 @w_functionality	= 'ABM'
	end
	
	
	------------------------------------Manejo de Fondos --------------------------------------------
	if @w_has_fund = 'S'
	begin
		print 'Fondos'
		insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		select me_id, me_name, 'MNU', 
		       'CCA',
			   'FUND'
		from cew_menu 
		where me_name in ('MNU_OPER', 'MNU_ASSETS', 'MNU_FUND')
		
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'CCA',
			 @w_functionality	= 'FUND'
	end
	
	-------------------------------------Administración de Workflow--------------------------------
	if @w_has_workflow = 'S'
	begin
		print '@w_has_workflow'
		if not exists (select 1 from components_tmp where comp_funct = 'WKF')
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 'CWF', 'WKF'
			  from an_page 
			 where pa_name in ('WKF.Editor','WKF.Estadisticas')
		
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'CWF', 'WKF'
			from an_module 
			where upper(mo_name) like upper('%WKF.Editor%')
			   or upper(mo_name) like upper('%WKF.Estadisticas%')
			   or upper(mo_name) like upper('%POL.SistemasSubtipos%')
			   or upper(mo_name) like upper('%POL.VariablesProgramas%')
	
				
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 'CWF', 'WKF'
			from an_component 
			where co_mo_id in (select mo_id
								from an_module 
								where upper(mo_name) like upper('%WKF.Editor%')
								   or upper(mo_name) like upper('%WKF.Estadisticas%')
								   or upper(mo_name) like upper('%POL.SistemasSubtipos%')
								   or upper(mo_name) like upper('%POL.VariablesProgramas%'))
		end
	
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'WKF',
			 @w_nav_name	    = 'NavigationPageZone, FavoritesZone, HelpZone',
			 @w_functionality	= 'WKF'
	end
	
	
	------------------------------------------Transacciones de Negocio------------------------------------
	if @w_has_business_trn = 'S'
	begin
		print '@w_has_business_trn'
		if not exists (select 1 from components_tmp where comp_funct = 'BUSIN-TRN')
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 
			       case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				   end,
				   'BUSIN-TRN'
			from an_page 
			where pa_id_parent in (select pa_id 
			                         from an_page 
									where pa_la_id in (select la_id 
														from an_label 
													   where la_label = 'Operaciones'
								                         and la_prod_name = 'M-CCA'))
			and pa_name  <> 'CCA.OP.VisualBatch'
		 
	  
			while exists (select 1 
						    from an_page 
						   where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'P') 
							 and pa_id not in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'P'))
			begin
				insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
				select pa_id, pa_name, 'P', 
					   case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				       end, 
					   'BUSIN-TRN'
				 from an_page 
			    where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'P') 
				  and pa_id not in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'P')
			
			end
		
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 
				   'CCA',
				   'BUSIN-TRN'
			from an_module 
			where upper(mo_name) like upper('%CON.Transactions%')
			   or upper(mo_name) like upper('%CON.resources%')
			   or upper(mo_name) like upper('%CON.SharedLibrary%')		
			   or upper(mo_name) like upper('%PFI.Operation%')	
			   or upper(mo_name) like upper('%PFI.Resources%')
			   or upper(mo_name) like upper('%PFI.SharedLibrary%')								
			   or upper(mo_name) like upper('%CTA.Resources%')
			   or upper(mo_name) like upper('%CTA.SharedLibrary%')			   
			   or upper(mo_name) like upper('%CTA.Ahos.Correspondents%')
			   or upper(mo_name) like upper('%CTA.Ahos.ExchangeAdmCenters%')
			   or upper(mo_name) like upper('%CTA.Ahos.RemittanceProcess%')
			   or upper(mo_name) like upper('%CTA.Ahos.AccountsAdmCatalogs%')
			   or upper(mo_name) like upper('%CTA.Ahos.CausalAdmAccounts%')
			   or upper(mo_name) like upper('%CTA.Ahos.BackOfficeProcesses%')
			   or upper(mo_name) like upper('%CTA.Ahos.CustService%')
			   or upper(mo_name) like upper('%CTA.Ahos.Admin%')
			   or upper(mo_name) like upper('%CTA.FTran216%')
				
			
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 
			       case substring(co_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(co_prod_name, 3, 3)
				   end
				   ,'BUSIN-TRN'
			from an_component 
			where upper(co_name) like upper('%CON.Transactions%')
			   or upper(co_name) like upper('%CON.resources%')
			   or upper(co_name) like upper('%CON.SharedLibrary%')		
			   or upper(co_name) like upper('%PFI.Operation%')	
			   or upper(co_name) like upper('%PFI.Resources%')
			   or upper(co_name) like upper('%PFI.SharedLibrary%')								
			   or upper(co_name) like upper('%CTA.Resources%')
			   or upper(co_name) like upper('%CTA.SharedLibrary%')
			   or upper(co_name) like upper('%CTA.Ahos.Correspondents%')
			   or upper(co_name) like upper('%CTA.Ahos.ExchangeAdmCenters%')
			   or upper(co_name) like upper('%CTA.Ahos.RemittanceProcess%')
			   or upper(co_name) like upper('%CTA.Ahos.AccountsAdmCatalogs%')
			   or upper(co_name) like upper('%CTA.Ahos.CausalAdmAccounts%')
			   or upper(co_name) like upper('%CTA.Ahos.BackOfficeProcesses%')
			   or upper(co_name) like upper('%CTA.Ahos.CustService%')
			   or upper(co_name) like upper('%CTA.Ahos.Admin%')
			   or upper(co_name) like upper('%CTA.FTran%')
			   or co_mo_id in (select mo_id 
			                     from an_module 
								where upper(mo_name) like upper('%CON.Transactions%')
								   or upper(mo_name) like upper('%CON.resources%')
								   or upper(mo_name) like upper('%CON.SharedLibrary%')		
								   or upper(mo_name) like upper('%PFI.Operation%')	
								   or upper(mo_name) like upper('%PFI.Resources%')
								   or upper(mo_name) like upper('%PFI.SharedLibrary%')								
								   or upper(mo_name) like upper('%CTA.Resources%')
								   or upper(mo_name) like upper('%CTA.SharedLibrary%')
								   or upper(mo_name) like upper('%CTA.Ahos.Correspondents%')
								   or upper(mo_name) like upper('%CTA.Ahos.ExchangeAdmCenters%')
								   or upper(mo_name) like upper('%CTA.Ahos.RemittanceProcess%')
								   or upper(mo_name) like upper('%CTA.Ahos.AccountsAdmCatalogs%')
								   or upper(mo_name) like upper('%CTA.Ahos.CausalAdmAccounts%')
								   or upper(mo_name) like upper('%CTA.Ahos.BackOfficeProcesses%')
								   or upper(mo_name) like upper('%CTA.Ahos.CustService%')
								   or upper(mo_name) like upper('%CTA.Ahos.Admin%')
								   or upper(mo_name) like upper('%CTA.FTran216%'))
		end
		
		
		--Contenedor	
		insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		select me_id, me_name, 'MNU', 
		       'GAR',
			   'BUSIN-TRN'
		from cew_menu 
		where me_name = 'MNU_OPER'

		insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		select me_id, me_name, 'MNU', 
		       'GAR',
			   'BUSIN-TRN'
		from cew_menu 
		where me_id_parent = ( select me_id from cew_menu where me_name = 'MNU_OPER')
		
	  
		while exists (select 1 
		                   from cew_menu 
						  where me_id_parent in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'MNU') 
							and me_id not in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'MNU'))
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
			select me_id, me_name, 'MNU', 'CCA',  'BUSIN-TRN'
			  from cew_menu 
		     where me_id_parent in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'MNU') 
			   and me_id not in (select comp_id from components_tmp where comp_funct = 'BUSIN-TRN' and comp_type	= 'MNU')
		end
		
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'CCA',
			 @w_nav_name	    = 'NavigationPageZone, FavoritesZone, HelpZone',
			 @w_functionality	= 'BUSIN-TRN'

	end
	
	
	-----------------------------------Consultas e Impresiones----------------------------------------
	if @w_has_queries_prints = 'S'
	begin
		print '@w_has_queries_prints'
		if not exists (select 1 from components_tmp where comp_funct = 'QUERIES')
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 
			       case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				   end,
				   'QUERIES'
			 from an_page 
			where pa_id_parent in (select pa_id 
			                         from an_page 
									where pa_la_id in (select la_id 
														from an_label 
													   where la_label = 'Consultas'
								                         and la_prod_name = 'M-CCA'))
			and pa_name  <> 'CCA.QRY.VisualBatchQueries'
			  
		  
			
			while exists (select 1 
						    from an_page 
						   where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'P') 
							 and pa_id not in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'P'))
			begin
				insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
				select pa_id, pa_name, 'P', 
				      case substring(pa_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(pa_prod_name, 3, 3)
				      end,
					 'QUERIES'
				  from an_page 
			     where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'P')
				   and pa_id not in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'P')
			
			end
	
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'CCA', 'QUERIES'
			from an_module 
			where upper(mo_name) like upper('%CON.ExcelQuery%')
			   or upper(mo_name) like upper('%CON.OnlineConsultations%')
			   or upper(mo_name) like upper('%CON.Reports%')
			   or upper(mo_name) like upper('%CON.resources%')
			   or upper(mo_name) like upper('%CON.TaxTables%')
			   or upper(mo_name) like upper('%CON.SharedLibrary%')
			   or upper(mo_name) like upper('%PFI.Resources%')
			   or upper(mo_name) like upper('%PFI.SharedLibrary%')
			   or upper(mo_name) like upper('%PFI.Query%')
			   or upper(mo_name) like upper('%PFI.Reportes%')
			   or upper(mo_name) like upper('%CTA.Resources%')
			   or upper(mo_name) like upper('%CTA.SharedLibrary%')
			   or upper(mo_name) like upper('%CTA.Ahos.Query%')
			   or upper(mo_name) like upper('%CTA.Ahos.QueryBackOffice%')
			   or upper(mo_name) like upper('%CTA.Ahos.QueryBalances%')
			   or upper(mo_name) like upper('%CTA.Ahos.QueryMovements%')
			   or upper(mo_name) like upper('%CTA.FTran%')
			   or upper(mo_name) like upper('%CTA.Ahos.CustService%')
			   or upper(mo_name) like upper('%CON.AuxiliaryQuery%')
				
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 
			       case substring(co_prod_name, 3, 3) 
						when 'CON' then 'CCA'
						else substring(co_prod_name, 3, 3)
				   end,
				   'QUERIES'
			from an_component 
			where upper(co_name) like upper('%CON.ExcelQuery%')
			   or upper(co_name) like upper('%CON.OnlineConsultations%')
			   or upper(co_name) like upper('%CON.Reports%')
			   or upper(co_name) like upper('%CON.resources%')
			   or upper(co_name) like upper('%CON.SharedLibrary%')
			   or upper(co_name) like upper('%CON.TaxTables%')
			   or upper(co_name) like upper('%CON.AuxiliaryQuery%')
			   or upper(co_name) like upper('%PFI.Resources%')
			   or upper(co_name) like upper('%PFI.SharedLibrary%')
			   or upper(co_name) like upper('%PFI.Query%')
			   or upper(co_name) like upper('%PFI.Reportes%')
			   or upper(co_name) like upper('%CTA.Resources%')
			   or upper(co_name) like upper('%CTA.SharedLibrary%')
			   or upper(co_name) like upper('%CTA.Ahos.Query%')
			   or upper(co_name) like upper('%CTA.Ahos.CustService%')
			   or upper(co_name) like upper('%CTA.Ahos.QueryBackOffice%')
			   or upper(co_name) like upper('%CTA.Ahos.QueryBalances%')
			   or upper(co_name) like upper('%CTA.Ahos.QueryMovements%')
			   or upper(co_name) like upper('%CTA.FTran%')
			   or co_mo_id IN ( select mo_id 
			                      from an_module 
								 where upper(mo_name) like upper('%CON.ExcelQuery%')
			                        or upper(mo_name) like upper('%CON.OnlineConsultations%')
			                        or upper(mo_name) like upper('%CON.Reports%')
			                        or upper(mo_name) like upper('%CON.resources%')
			                        or upper(mo_name) like upper('%CON.SharedLibrary%')
									or upper(mo_name) like upper('%CON.TaxTables%')
			                        or upper(mo_name) like upper('%PFI.Resources%')
			                        or upper(mo_name) like upper('%PFI.SharedLibrary%')
			                        or upper(mo_name) like upper('%PFI.Query%')
			                        or upper(mo_name) like upper('%PFI.Reportes%')
			                        or upper(mo_name) like upper('%CTA.Resources%')
			                        or upper(mo_name) like upper('%CTA.SharedLibrary%')
			                        or upper(mo_name) like upper('%CTA.Ahos.Query%')
									or upper(mo_name) like upper('%CTA.Ahos.CustService%')
			                        or upper(mo_name) like upper('%CTA.Ahos.QueryBackOffice%')
			                        or upper(mo_name) like upper('%CTA.Ahos.QueryBalances%')
			                        or upper(mo_name) like upper('%CTA.Ahos.QueryMovements%')
			                        or upper(mo_name) like upper('%CTA.FTran%')
									or upper(mo_name) like upper('%CON.AuxiliaryQuery%'))
									
	        --Contenedor	
		    insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		    select me_id, me_name, 'MNU', 
		           'CCA',
		    	   'QUERIES'
		    from cew_menu 
		    where me_name = 'MNU_QUERY'

			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
		    select me_id, me_name, 'MNU', 
		           'CCA',
		    	   'QUERIES'
		    from cew_menu 
		    where me_id_parent = ( select me_id from cew_menu where me_name = 'MNU_QUERY')
			
	  
		    while exists (select 1
			                   from cew_menu 
		                      where me_id_parent in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'MNU') 
			                    and me_id not in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'MNU'))
		    begin
		    	insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
		    	select me_id, me_name, 'MNU', 'CCA',  'QUERIES'
		    	  from cew_menu 
		         where me_id_parent in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'MNU') 
			       and me_id not in (select comp_id from components_tmp where comp_funct = 'QUERIES' and comp_type	= 'MNU')
		    end

			
			
		end
		
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'CCA',
			 @w_nav_name	    = 'NavigationPageZone, FavoritesZone, HelpZone',
			 @w_functionality	= 'QUERIES'
        
	end       
	
	----------------------------------Ejecución de Procesos Batch--------------------------------------
	if @w_has_batch = 'S'
	begin
		print '@w_has_batch'
		if not exists (select 1 from components_tmp where comp_funct = 'VBA')
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 'BAT', 'VBA'
			  from an_page 
			 where pa_id_parent in (select pa_id 
			                          from an_page 
									 where pa_name in ('CCA.ADM.VisualBatch', 'CCA.OP.VisualBatch', 'CCA.QRY.VisualBatchQueries'))
	
	  
			while exists (select 1 
			                from an_page 
						   where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'VBA' and comp_type	= 'P') 
							 and pa_id not in (select comp_id from components_tmp where comp_funct = 'VBA' and comp_type	= 'P'))
			               
			begin
				insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)
				select pa_id, pa_name, 'P', 'BAT', 'VBA'
				  from an_page 
				 where pa_id_parent in (select comp_id from components_tmp where comp_funct = 'VBA' and comp_type	= 'P') 
				   and pa_id not in (select comp_id from components_tmp where comp_funct = 'VBA' and comp_type	= 'P')
			
			end
	
	
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'BAT', 'VBA'
			from an_module 
			where upper(mo_name) like upper('%ADMVBA.Execution%')
			   or upper(mo_name) like upper('%ADMVBA.Administration%')
			   or upper(mo_name) like upper('%ADMVBA.Aux%')
			   or upper(mo_name) like upper('%ADMVBA.Resources%')
			   or upper(mo_name) like upper('%ADMVBA.SharedLibrary%')
			   or upper(mo_name) like upper('%ADMVBA.Administration%')
			   or upper(mo_name) like upper('%ADMVBA.Security%')
			   or upper(mo_name) like upper('%ADMVBA.Execution%')
			   or upper(mo_name) like upper('%ADMVBA.Query%')
				
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 'BAT' , 'VBA'
			from an_component 
			where co_mo_id in (select mo_id
								from an_module 
								where upper(mo_name) like upper('%ADMVBA.Execution%')
								   or upper(mo_name) like upper('%ADMVBA.Administration%')
								   or upper(mo_name) like upper('%ADMVBA.Aux%')
								   or upper(mo_name) like upper('%ADMVBA.Resources%')
								   or upper(mo_name) like upper('%ADMVBA.SharedLibrary%')
								   or upper(mo_name) like upper('%ADMVBA.Administration%')
								   or upper(mo_name) like upper('%ADMVBA.Security%')
								   or upper(mo_name) like upper('%ADMVBA.Execution%')
								   or upper(mo_name) like upper('%ADMVBA.Query%'))
			  or upper(co_name) like upper('%ADMVBA.Execution%')
			  or upper(co_name) like upper('%ADMVBA.Administration%')
			  or upper(co_name) like upper('%ADMVBA.Aux%')
			  or upper(co_name) like upper('%ADMVBA.Resources%')
			  or upper(co_name) like upper('%ADMVBA.SharedLibrary%')
			  or upper(co_name) like upper('%ADMVBA.Administration%')
			  or upper(co_name) like upper('%ADMVBA.Security%')
			  or upper(co_name) like upper('%ADMVBA.Execution%')
			  or upper(co_name) like upper('%ADMVBA.Query%')
		end
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'BAT',
			 @w_nav_name	    = 'NavigationPageZone, FavoritesZone, HelpZone',
		     @w_functionality	= 'VBA'
	                        
	end
	--------------------------Inbox-----------------------------------------
	if @w_has_inbox = 'S'
	begin
		print '@w_has_inbox'
		if not exists (select 1 from components_tmp where comp_funct = 'IBX')
		begin
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select pa_id, pa_name, 'P', 'CRE', 'IBX'
			  from an_page 
			 where pa_name in ('IBX.Inbox','IBX.Consultas', 'IBX.InboxOficial', 'IBX.ReimpresionDocumentos')
		
			--Módulos
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select mo_id, mo_name, 'M', 'CRE', 'IBX'
			from an_module 
			where upper(mo_name) like upper('%IBX.Consultas%')
			   or upper(mo_name) like upper('%IBX.InboxOficial%')
			   or upper(mo_name) like upper('%IBX.ReimpresionDocumentos%')
			   or upper(mo_name) like upper('%POL.SistemasSubtipos%')
			   or upper(mo_name) like upper('%POL.VariablesProgramas%')
	
				
			--Componentes
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select distinct(co_id), co_name, 'C', 'CRE', 'IBX'
			  from an_component 
			 where co_mo_id in (select mo_id
								from an_module 
								where upper(mo_name) like upper('%IBX.Consultas%')
								   or upper(mo_name) like upper('%IBX.InboxOficial%')
								   or upper(mo_name) like upper('%IBX.ReimpresionDocumentos%')
								   or upper(mo_name) like upper('%POL.SistemasSubtipos%')
								   or upper(mo_name) like upper('%POL.VariablesProgramas%'))
			   and co_prod_name not in ('WF', 'WFD')
			   
			insert into components_tmp (comp_id, comp_name, comp_type, comp_prod, comp_funct)		
			select me_id, me_name, 'MNU', 
		           'CRE',
		    	   'IBX'
		    from cew_menu 
			where me_name in ('MNU_OPER','MNU_INBOX', 'MNU_CONTAINER_INBOX_FF')
		end
	
		exec add_functionality_role
			 @w_role_desc		= @w_role_desc,
			 @w_prod_name		= 'IBX',
			 @w_nav_name	    = 'NavigationPageZone, FavoritesZone, HelpZone',
			 @w_functionality	= 'IBX'
		
	end
	
	------------------------------------Banca Móvil Funcionarios--------------------------------------- 
	--if @w_has_movil_bank = 'S'
	--begin
	--	--por definir
	--end
	
	select @w_role_desc 			= rf_rol_desc,
		 @w_has_adm_cobis		= rf_has_admin_cobis,
		 @w_has_workflow		= rf_has_workflow,
		 @w_has_business_trn 	= rf_has_business_trn,
		 @w_has_queries_prints	= rf_has_queries_prints,
		 @w_has_batch			= rf_has_batch,
		 @w_has_inbox			= rf_has_inbox,
		 @w_has_movil_bank		= rf_has_movil_bank,
		 @w_has_fund			= rf_has_fund,
		 @w_has_abm_products	= rf_has_abm_products
    from #role_functionalities
   where rf_rol_desc 	> @w_role_desc
order by rf_rol_desc desc
	
end


SELECT * FROM components_tmp
TRUNCATE TABLE components_tmp
DROP TABLE components_tmp
DROP TABLE #role_functionalities
go

------------------------------------AUTORIZACION DE ROLES --------------------------------------- 

declare @w_rol int,  @w_rol_menu int, @w_menu				int,        @w_submenu                 int,         @w_menu_pant               int  

select @w_rol_menu = ro_rol from cobis..ad_rol where ro_descripcion ='MENU POR PROCESOS'

--Rol 1
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='ADMINISTRADOR'
if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end

--Rol 2
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='OPERADOR DE BATCH COBIS'

if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end


--Rol 10
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='CONSULTA'

if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end

/*Autorizar el menu operaciones el los sub menu del inbox y el oficial del inbox*/
select @w_menu = me_id from cobis..cew_menu where me_name ='MNU_OPER'

select @w_submenu = me_id from cobis..cew_menu where me_name ='MNU_INBOX' and me_id_parent = @w_menu 

select @w_menu_pant = me_id from cobis..cew_menu where me_name ='MNU_CONTAINER_INBOX_FF' and me_id_parent = @w_submenu 

if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu and mro_id_role = @w_rol)
insert into cobis..cew_menu_role (mro_id_menu,mro_id_role) values(@w_menu,@w_rol)

if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_submenu and mro_id_role = @w_rol)
insert into cobis..cew_menu_role (mro_id_menu,mro_id_role) values(@w_submenu,@w_rol)

if not exists (select 1 from cobis..cew_menu_role where mro_id_menu = @w_menu_pant and mro_id_role = @w_rol)
insert into cobis..cew_menu_role (mro_id_menu,mro_id_role) values(@w_menu_pant,@w_rol)



--Rol 11
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='FUNCIONARIO OFICINA'

if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end

--Rol 12
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='ASESOR'

if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end


--Rol 13
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion ='OPERADOR SOFOME'

if exists (select 1 from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto))
begin 
   insert into ad_tr_autorizada
   select ta_producto,ta_tipo,ta_moneda,ta_transaccion,@w_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod from cobis..ad_tr_autorizada t1 where ta_rol = @w_rol_menu  
   and ta_transaccion not in (select ta_transaccion  t2 from cobis..ad_tr_autorizada t2 where ta_rol = @w_rol and t1.ta_producto  = t2.ta_producto)
end 
if exists (select 1 from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol ))
begin 
   insert into cobis..ad_servicio_autorizado
   select ts_servicio, @w_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod from cobis..ad_servicio_autorizado t1 where ts_rol = @w_rol_menu 
   and ts_servicio not in (select ts_servicio t2 from cobis..ad_servicio_autorizado t2 where ts_rol = @w_rol )
end

go

