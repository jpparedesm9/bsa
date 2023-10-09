	/************************************************************************/
	/*   Archivo:            sp_role_page_dml.sp                            */
	/*   Stored procedure:   sp_role_page_dml                               */
	/*   Base de datos:      cobis                                          */
	/*   Producto:           ADMIN - Seguridades                            */
	/*   Disenado por:       Cesar Guevara                                  */
	/*   Fecha de escritura: 18-02-2010                                     */
	/************************************************************************/
	/*                           IMPORTANTE                                 */
	/*   Este programa es parte de los paquetes bancarios propiedad de      */
	/*   Cobiscorp.                                                         */
	/*   Su uso no autorizado queda expresamente prohibido asi como         */
	/*   cualquier alteracion o agregado hecho por alguno de sus            */
	/*   usuarios sin el debido consentimiento por escrito de la            */
	/*   Presidencia Ejecutiva de Cobiscorp o su representante.             */
	/************************************************************************/
	/*                           PROPOSITO                                  */
	/*   Este programa procesa las operaciones de Insercion, Eliminacion    */
	/*   y Consulta sobre las páginas, componentes, y transacciones         */
	/*   autorizadas a varios roles.                                        */
	/************************************************************************/
	/*                           OPERACIONES                                */
	/*   OPER. OPCION                     DESCRIPCION                       */
	/*     I              Asociaci=n de páginas,componentes y operacione a  */
	/*                    roles                                             */
	/*     U     L        Actualizaci=n de label                            */
	/*     D              Asociaci=n de páginas,componentes y operacione a  */
	/*                    roles                                             */
	/*     S              Listado de de páginas,componentes y operacione a  */
	/*                    roles                                             */
	/*     H              Listado de componentes asociados en mas de un     */
	/*                    producto CEN                                      */
	/************************************************************************/
	/*                           MODIFICACIONES                             */
	/*     FECHA         AUTOR               RAZON                          */
	/*   18-02-2010  Cesar Guevara   Emision Inicial                        */
	/*   15-04-2012  E. Carri=n      Actualizaci=n para versi=n ADMIN UNICO */
	/*   05-06-2012  F. LOPEZ        Reestructuracion, Optimizacion, ...    */
	/*   08-11-2012  F. LOPEZ        Soporte xa items de menu no visibles   */
	/*   16-01-2013  F. LOPEZ        Soporte Pags con +1 mismo Componente   */
	/*   07-02-2013  F. LOPEZ        Asociacion automatic roles a productos */
	/*   22/07/2013  J. Tagle        Inserción automática de TRN básicas CEN*/
	/*   12/08/2013  J. Tagle        HSBC 25513 - Ref. Orden de Paginas     */
	/*   13/08/2013  J. Tagle        REQ 25166 Autorizacion de Servicios    */
	/*   30/01/2014  J. Tagle        REQ 27153 Consulta Rol Siguientes      */
	/*   08/04/2015  J. Tagle        FIE ADM-H013 Clase en Trans. Servicio  */
	/*   19/05/2016  BBO             Migracion SYB-SQL FAL                  */
	/*   01/07/2016  J. Hernandez    Ajuste version  FAL                    */
	/************************************************************************/
	use cobis
	go

	if exists (select * from sysobjects where name = 'sp_role_page_dml')
	   drop proc sp_role_page_dml
	go

	create proc sp_role_page_dml (
	   @s_ssn           int           = NULL,
	   @s_user          login         = NULL,
	   @s_sesn          int           = NULL,
	   @s_term          varchar(32)   = NULL,
	   @s_date          datetime      = NULL,
	   @s_srv           varchar(30)   = NULL,
	   @s_lsrv          varchar(30)   = NULL,
	   @s_rol           smallint      = NULL,
	   @s_ofi           smallint      = NULL,
	   @s_org_err       char(1)       = NULL,
	   @s_error         int           = NULL,
	   @s_sev           tinyint       = NULL,
	   @s_msg           descripcion   = NULL,
	   @s_org           char(1)       = NULL,
	   @s_culture       varchar(10)   = NULL,
	   @t_debug         char(1)       = 'N',
	   @t_file          varchar(14)   = NULL,
	   @t_from          varchar(32)   = NULL,
	   @t_trn           smallint      = NULL,
	   @i_operacion     varchar(1),
	   @i_modo          smallint      = 0,
	   @i_tipo          char(1)       = NULL,
	   --------------------------------------------------------
	   -- Variables de páginas, componentes, operaciones por rol
	   --------------------------------------------------------
	   @t_show_version  bit           = 0,           -- Mostrar la version del programa  --(PRMR STANDAR)
	   @i_pa_id         int           = NULL,        -- Id de Página
	   @i_rol           int           = NULL,        -- Id de Rol
	   @i_roles         varchar(100)  = NULL,        -- Ids de Roles seleccionados
	   --@i_pages         varchar(10000) = NULL,        -- Ids de Páginas seleccionadas
	   --@i_components    varchar(10000) = NULL,        -- Ids de Componentes seleccionados
	   --@i_operations    varchar(10000) = NULL,        -- Ids de Operaciones seleccionadas
	   --@i_prod_names    varchar(10000)  = NULL,        -- C=digos de Productos CEN seleccionados
	   @i_pages         varchar(max) = NULL,        -- Ids de Páginas seleccionadas             --migracion SYB-SQL FAL 
	   @i_components    varchar(max) = NULL,        -- Ids de Componentes seleccionados         --migracion SYB-SQL FAL 
	   @i_operations    varchar(max) = NULL,        -- Ids de Operaciones seleccionadas         --migracion SYB-SQL FAL 
	   @i_prod_names    varchar(max)  = NULL,        -- C=digos de Productos CEN seleccionados  --migracion SYB-SQL FAL    
	   @i_la_id         int           = NULL,        -- Id del label
	   @i_label         varchar(100)  = NULL,        -- Descripci=n del label
	   @i_co_id         int           = NULL,        -- Id del componente
	   @o_id            int           = NULL output
	 )
	as
	declare
	   @w_today        datetime,
	   @w_return       int,
	   @w_sp_name      varchar(32),
	   ------------------------------------------------------------------
	   -- Variables de trabajo páginas, componentes, operaciones por rol
	   ------------------------------------------------------------------
	   @w_pa_id         int,
	   @w_co_id         int,
	   @w_mo_id         int,
	   @w_ro_id         int,
	   @w_ro_rol        int,
	   @w_mo_id_parent  int,
	   @w_position      int,
	   @w_position1     int,
	   @w_roles         varchar(100),
	   @w_pages         varchar(2000),
	   @w_components    varchar(4000),
	   @w_operations    varchar(8000),
	   @w_prod_names    varchar(255),
	   @w_oc_llave      varchar(255),
	   @w_trn_code      int,
	   @w_query         varchar(350),
	   @w_error         varchar(255),
	   @w_intento       int,
	   @w_limite        int,
	   @w_ciclos        int,
	   @w_mod_web_page  int,
	   @w_label 		varchar(200)   --FIE
	   
	-----------------------------------------
	--Inicializacion de Variables
	-----------------------------------------
	select @w_today = @s_date,
		   @w_sp_name = 'sp_role_page_dml',
		   @s_culture = UPPER(@s_culture),
		   @w_limite  = 5000, --Retornar error si el numero de resultados supera los 5000 regs
		   @w_ciclos  = 20

	/***Mostrar versionamiento del sp ***/--(PRMR STANDAR)
	if @t_show_version = 1
	begin
		print 'Stored procedure ' + @w_sp_name + ' Version 4.0.0.9' 
		return 0
	end
	-----------------------------------------
	--Control Transacciones vs. Operaciones
	-----------------------------------------
	if  ((@i_operacion = 'I' and @t_trn != 15373) or
		(@i_operacion  = 'U' and @t_trn not in (15386,15387)) or
		(@i_operacion  = 'D' and @t_trn != 15374) or
		(@i_operacion  = 'S' and @t_trn != 15375) or
		(@i_operacion  = 'H' and @t_trn != 15375) or
		(@i_operacion  = 'L' and @t_trn != 15375) or
		(@i_operacion  = 'E' and @t_trn != 15376))
	begin
	   select @w_return = 151051   --Transaccion no permitida
	   goto error
	end

	--Determinacion del ID de Cultura, si no es provisto por el Servidor
	if @s_culture is null
	begin
			select @s_culture = pa_char
			from cl_parametro
			where pa_nemonico = 'CEAN'
	end


	if @i_operacion in ('I','D','H')
	begin
			--Tabla temporal de asociaciones al rol seleccionado
			create table #tmp_pages_comp_oper (
						id varchar(20),
						id_parent int null,
						tipo char
						)

			create table #tmp_pages_comp_oper_label (   --FIE
				id varchar(20),
				id_parent int null,
				tipo char,
				label varchar(200) null
				)
				
			create table #trnaut(tc_tn_trn_code int, ta_transaccion int null)
			create table #trnaut1(tc_tn_trn_code1 int, ta_transaccion int null)
			create table #servaut(sc_csc_service_id varchar(500), ts_servicio varchar(500) null) --JTA
			create table #modules (mod int)
			create table #modules1 (mod1 int)
			create table #modaut (mod int,rol int null)

			
			if @i_operacion = 'D'
			begin
					--tabla temporal para identificar las autorizaciones de modulos a eliminar
					create table #moddel (mo_id int, borrar char(1))
					create table #dataprod (prodname catalogo, num int)
			end

			if @i_operacion in ('I','D')
			begin
					create table #prodaut(producto tinyint,   tipo char(1),   moneda tinyint)
			end
			--Obtenci=n de Ids de páginas
			select @w_pages = @i_pages
			select @w_position = CHARINDEX( ';', @w_pages )
			while @w_position <> 0
			begin
					
					
					insert into #tmp_pages_comp_oper values(LEFT(@w_pages, @w_position -1),null,'P')

					select @w_label = pa_prod_name + ' - ' + pa_name from an_page where pa_id = convert(int,LEFT(@w_pages, @w_position -1)) --FIE
					insert into #tmp_pages_comp_oper_label values(LEFT(@w_pages, @w_position -1),null,'P',@w_label)
			
					select @w_pages = stuff( @w_pages, 1, @w_position, null)
					select @w_position = CHARINDEX( ';', @w_pages )
			end

			
			--Obtenci=n de Ids de componentes
			select @w_components = @i_components

			select @w_position = CHARINDEX( ';', @w_components)
			while @w_position <> 0
			begin
					
					insert into #tmp_pages_comp_oper values(LEFT(@w_components, @w_position -1),null,'C')
					
					select @w_label = co_prod_name + ' - ' + co_name from an_component where co_id = convert(int,LEFT(@w_components, @w_position -1)) --FIE
					insert into #tmp_pages_comp_oper_label values(LEFT(@w_components, @w_position -1),null,'C',@w_label)

					select @w_components = stuff( @w_components, 1, @w_position, null)
					select @w_position = CHARINDEX( ';', @w_components )
			end

			--Obtenci=n de Ids de operaciones
			select @w_operations = @i_operations
			select @w_position = CHARINDEX( ';', @w_operations)
			while @w_position <> 0
			begin
					select @w_oc_llave = LEFT( @w_operations, @w_position -1)
					select @w_position1 = CHARINDEX( '|', @w_oc_llave)
					insert into #tmp_pages_comp_oper values(RIGHT( @w_oc_llave, len(@w_oc_llave) - @w_position1), convert(int, LEFT( @w_oc_llave, @w_position1 - 1)),'O')
					if @@error != 0
					begin
							select @w_error  = 'Error en la obtenci=n de ids de operaciones.',
							@w_return = 1
							goto error
					end
									
					select @w_label = RIGHT( @w_oc_llave, len(@w_oc_llave) - @w_position1) + ' - ' + co_prod_name + ' - ' + co_name from an_component where co_id = convert(int, LEFT( @w_oc_llave, @w_position1 - 1)) --FIE
					insert into #tmp_pages_comp_oper_label values(RIGHT( @w_oc_llave, len(@w_oc_llave) - @w_position1), convert(int, LEFT( @w_oc_llave, @w_position1 - 1)),'O',@w_label)
					
					select @w_operations = stuff( @w_operations, 1, @w_position, null)
					select @w_position = CHARINDEX( ';', @w_operations )
			end

			if @@error != 0
			begin
					select @w_error  = 'Error en la obtencion de ids',
					@w_return = 1
					goto error
			end
	end


	--Grabar Transacciones de Servicio
	if @i_operacion in ('I','D')
	begin
			begin tran
			
			insert into ts_adm_seguridades (secuencia,    tipo_transaccion,    clase,       fecha,             oficina_s,
										  usuario,      terminal_s,          srv,         lsrv,
										  tipo_objeto,         id_objeto,   id_objeto_padre,   rol_autorizado)

			select @s_ssn,    @t_trn,    
			case @i_operacion 
						  when 'I' then 'N'
						  when 'D' then 'B'
						  end,
					@s_date,  
					@s_ofi,
					@s_user,   @s_term,    @s_srv,    @s_lsrv,

					tipo,      id,         label, @i_rol
			from #tmp_pages_comp_oper_label

			--  'I'  15373  --> N
			--  'D'  15374  --> B

			if @@error != 0
			begin
				select @w_return = 153023  -- Existio un error al crear la tx
				goto error
			end			
	end


	if @i_operacion = 'I'
	begin
		--begin tran en bloque anterior de ts
		  --Autorizar por defecto todas las zonas de navegacion, componentes y modules relacionados
		  --NOTA: Si existiese necesidad de administrar que zonas se autorizan o no, se debe implementar dicha funcionalidad
		  --      a nivel de FrontEnd de Administracion Centralizada de Autorizaciones COBIS y eliminar los siguientes 3 inserts
		  insert into cobis..an_role_navigation_zone
		  select distinct @i_rol, nz_id
		  from cobis..an_navigation_zone nz
		  where not exists(select 1 from cobis..an_role_navigation_zone
						   where rn_rol = @i_rol and rn_nz_id = nz.nz_id)
		  if @@error <> 0
		  begin
			 select @w_return = 157207  -- Existio un error al autorizar la zona de navegacion
			 goto error
		  end

		  insert into cobis..an_role_module
		  select distinct co_mo_id, @i_rol
		  from cobis..an_navigation_zone, cobis..an_component c
		  where nz_co_id = co_id
			and not exists(select 1 from cobis..an_role_module
						   where rm_rol = @i_rol and rm_mo_id = c.co_mo_id)
		  if @@error <> 0
		  begin
			 select @w_return = 157138  -- Existio un error al autorizar el Module
			 goto error
		  end

		  insert into cobis..an_role_component
		  select distinct nz_co_id, @i_rol
		  from cobis..an_navigation_zone nz
		  where not exists(select 1 from cobis..an_role_component
						   where rc_rol = @i_rol and rc_co_id = nz.nz_co_id)
		  if @@error <> 0
		  begin
			 select @w_return = 157170  -- Existio un error al autorizar el componente
			 goto error
		  end

		  --Autorizar las páginas pendientes al rol
		  insert into #modaut
		  select convert(int,id), rp_rol
			from #tmp_pages_comp_oper left outer join an_role_page      --migracion syb-sql 19052016
			 on convert(int,id) = rp_pa_id    
			 and rp_rol          =  @i_rol                             --migracion syb-sql 19052016
		  --from #tmp_pages_comp_oper, an_role_page  --migracion syb-sql 19052016
		  --where convert(int,id) *= rp_pa_id        --migracion syb-sql 19052016
			 where tipo            =  'P'
			
		  insert into an_role_page (rp_pa_id, rp_rol)
		  select distinct mod, @i_rol
		  from #modaut where rol is null

		  if @@error <> 0
		  begin
			 select @w_return = 157192  -- Existio un error al autorizar la Pagina al Rol
			 goto error
		  end

		  --Autorizar los modulos de los componentes recursivamente
		  insert into #modules
		  select mo_id
		  from #tmp_pages_comp_oper, an_component, an_module
		  where tipo  = 'C'
			and co_id = convert(int,id)
			and mo_id = co_mo_id
			
		  --Agregar modulos dependientes para autorizar
		  while 1=1
		  begin         
			 insert into #modules
			 select distinct md_dependency_id 
			 from an_module_dependency, #modules
			 where md_mo_id = mod
			   and md_dependency_id not in (select mod from #modules)
		  
			 if @@rowcount = 0 break
		  end

		  delete from #modaut

		  insert into #modaut
		  select mod, null
		  from #modules left outer join an_role_module     --migracion syb-sql 19052016
			on mod = rm_mo_id                 --migracion syb-sql 19052016
		  --from #modules, an_role_module     --migracion syb-sql 19052016
		  --where mod    *= rm_mo_id          --migracion syb-sql 19052016
		  where rm_rol <>  @i_rol            --migracion syb-sql 19052016

		  insert into #modules1
		  select mod
		  from #modules left outer join an_role_module     --migracion syb-sql 19052016
			on mod = rm_mo_id                 --migracion syb-sql 19052016
		  where rm_rol = 1

		  delete #modaut
		  from #modules1
		  where mod1 = mod

		  insert into an_role_module
		  select distinct mod, @i_rol
		  from #modaut where rol is null
		  
		  if @@error <> 0
		  begin
			 select @w_return = 157138  --Existio un error al autorizar el modulo para el rol
			 goto error
		  end

		  delete from #modaut

		  --Autorizar los componentes pendientes al rol
		  insert into #modaut
		  select convert(int,id), rc_rol
		  from #tmp_pages_comp_oper left outer join an_role_component      --migracion syb-sql 19052016
			on convert(int,id) = rc_co_id 
			and rc_rol          =  @i_rol --migracion syb-sql 19052016
		  --from #tmp_pages_comp_oper, an_role_component      --migracion syb-sql 19052016
		  --where convert(int,id) *= rc_co_id                 --migracion syb-sql 19052016
		  --where rc_rol          =  @i_rol                     --migracion syb-sql 19052016
			where tipo            =  'C'

		  insert into an_role_component(rc_co_id,rc_rol)
		  select distinct mod, @i_rol
		  from #modaut where rol is null

		  if @@error <> 0
		  begin
			 select @w_return = 157170  --Existio un error al autorizar el Componente al Rol
			 goto error
		  end

		  -----------------------------------
		  /* AUTORIZACION DE Transacciones */
		  -----------------------------------
		  --Autorizar transacciones base de los componentes autorizados anteriormente
		  delete #trnaut1

		  insert into #trnaut1 
		  select tc_tn_trn_code, ta_transaccion
		  --inicio migracion fal 05192016
		  from an_transaction_component
			   left outer join ad_tr_autorizada on ta_transaccion = tc_tn_trn_code
			   inner join an_component on tc_oc_nemonic  = co_prod_name
			   inner join #modaut on mod = co_id
		 where tc_co_id       = 0              --componentes base
		   and ta_rol         =  @i_rol
		  
		  delete #trnaut

		   insert into #trnaut 
		   	  select tc_tn_trn_code,null
		  from an_transaction_component
			   inner join an_component on tc_oc_nemonic  = co_prod_name
			   inner join #modaut on mod = co_id
		 where tc_co_id       = 0              --componentes base

		 delete #trnaut 
		 from #trnaut1 
		 where tc_tn_trn_code = tc_tn_trn_code1 

		  --from #modaut,
			   --an_component,
			   --an_transaction_component,
			   --ad_tr_autorizada
		  --where mod            = co_id
			--and tc_oc_nemonic  = co_prod_name
			--and ta_transaccion =* tc_tn_trn_code
			--and tc_co_id       = 0              --componentes base
			--and ta_rol         =  @i_rol
			--fin migracion fal 05192016

		  insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
		  select distinct pt_producto,pt_tipo, pt_moneda, pt_transaccion,@i_rol, getdate(), 1, pt_estado, getdate()
		  from #trnaut,
			   ad_pro_transaccion
		  where ta_transaccion is null
			and pt_transaccion  =  tc_tn_trn_code

		  if @@error <> 0
		  begin
			 select @w_return = 153010   --Existio un error en creacion de transaccion autorizada
			 goto error
		  end

		  --Autorizar las transacciones de las operaciones de los componentes
		  delete #trnaut

		  insert into #trnaut
		  select tc_tn_trn_code, ta_transaccion
		  --inicio migracion fal 05192016      
		  from an_transaction_component
			   left outer join ad_tr_autorizada on ta_transaccion = tc_tn_trn_code and ta_rol =  @i_rol
			   inner join #tmp_pages_comp_oper on id_parent = tc_co_id
											  and id = isnull(tc_oc_nemonic,'BASE')
		 where tipo           =  'O'
		   
		  
		  --from #tmp_pages_comp_oper,
			   --an_transaction_component,
			   --ad_tr_autorizada
		  --where tipo           =  'O'
			--and id             =  isnull(tc_oc_nemonic,'BASE')
			--and ta_rol         =  @i_rol
			--and ta_transaccion =* tc_tn_trn_code
			--and id_parent      = tc_co_id
			--fin migracion fal 05192016

		  insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
		  select distinct pt_producto,pt_tipo, pt_moneda, pt_transaccion,@i_rol, getdate(), 1, pt_estado, getdate()
		  from #trnaut,
			   ad_pro_transaccion
		  where ta_transaccion is null
			and pt_transaccion  =  tc_tn_trn_code

		  if @@error <> 0
		  begin
			 select @w_return = 153010   --Existio un error en creacion de transaccion autorizada
			 goto error
		  end
		  
		  --Autorizar las transacciones de los componentes
		  delete #trnaut

		  insert into #trnaut
		  select tc_tn_trn_code, ta_transaccion
		--inicio migracion fal 05192016      
		  from an_transaction_component
			   left outer join ad_tr_autorizada on ta_transaccion = tc_tn_trn_code
			   inner join #tmp_pages_comp_oper on tc_co_id = convert(int,id)
			   inner join an_component on convert(int,id)  = co_id
		  where tipo           =  'C'
			and ta_rol         =  @i_rol
			   
		  --from #tmp_pages_comp_oper,
			   --an_component,
			   --an_transaction_component,
			   --ad_tr_autorizada
		  --where tipo           =  'C'
			--and convert(int,id)  = co_id
			--and tc_co_id = convert(int,id)
			--and ta_transaccion =* tc_tn_trn_code
			--and ta_rol         =  @i_rol
		 --fin migracion fal 05192016

		  insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
		  select distinct pt_producto,pt_tipo, pt_moneda, pt_transaccion,@i_rol, getdate(), 1, pt_estado, getdate()
		  from #trnaut,
			   ad_pro_transaccion
		  where ta_transaccion is null
			and pt_transaccion  =  tc_tn_trn_code

		  if @@error <> 0
		  begin
			 select @w_return = 153010   --Existio un error en creacion de transaccion autorizada
			 goto error
		  end
			-------------------------------------
			-- FUNCIONALIDADES BASICAS DEL CEN --
			-------------------------------------
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1556 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,1556,@i_rol,getdate(),1,'V',getdate())		
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1564 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,1564,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1574 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,1574,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1577 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,1577,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 1579 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,1579,@i_rol,getdate(),1,'V',getdate())

			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15001 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15001,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15031 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15031,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15153 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15153,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15168 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15168,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15301 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15301,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15302 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15302,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15315 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15315,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15316 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15316,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15317 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15317,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15318 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15318,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15319 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15319,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15320 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15320,@i_rol,getdate(),1,'V',getdate())
			if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15913 and ta_rol = @i_rol)
				insert into  ad_tr_autorizada values(1,'R',0,15913,@i_rol,getdate(),1,'V',getdate())
				
		 ----------------------------------------------
		 --AUTORIZACION DE MODULE WEB PAGE CONTAINER---
		 ----------------------------------------------
		 select @w_mod_web_page=mo_id
		 from an_module
		 where mo_name='COBISExplorer.Container.WebPageContainer'
		 
		 if not exists (select 1 from an_role_module where rm_mo_id=@w_mod_web_page and rm_rol=@i_rol)
		 begin
			insert into an_role_module values(@w_mod_web_page,@i_rol)
		 end

		 -------------------------------
		  /* AUTORIZACION DE SERVICIOS */
		  -------------------------------
		   --Autorizar servicios base de los componentes autorizados anteriormente
		 delete #servaut                           
		 
		  insert into #servaut                      
		  select sc_csc_service_id,ts_servicio      
		  --inicio migracion fal 05192016
		  from an_service_component
			   left outer join ad_servicio_autorizado on ts_servicio = sc_csc_service_id 
			   inner join an_component on sc_oc_nemonic  =  co_prod_name      
			   inner join #modaut on mod = co_id 
		 where sc_co_id       =  0                  --componentes base
		   and ts_rol         =  @i_rol   			
		   and sc_csc_service_id in (select csc_service_id from cts_serv_catalog)  --ECA  Control de existencia en tabla padre

		  --from #modaut,  
			--   an_component,
			--   an_service_component,       --25166         
			--   ad_servicio_autorizado              
		  --where mod            =  co_id 
			--and sc_oc_nemonic  =  co_prod_name      
			--and ts_servicio    =* sc_csc_service_id 
			--and sc_co_id       =  0                  --componentes base
			--and ts_rol         =  @i_rol   			
			--and sc_csc_service_id in (select csc_service_id from cts_serv_catalog)  --ECA  Control de existencia en tabla padre
			--fin migracion fal 05192016

		  insert into ad_servicio_autorizado (ts_servicio, ts_producto,ts_tipo,ts_moneda,ts_rol,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		  select distinct sc_csc_service_id, 1,'R',0,@i_rol,getdate(),'V',getdate()
		  from #servaut                              --jta  #trnaut
		  where ts_servicio is null                  --jta  ta_transaccion is null                
			
		  if @@error <> 0
		  begin
			 select @w_return = 153010   --Existio un error en creacion de transaccion autorizada
			 goto error
		  end

		  --Autorizar las servicios de las operaciones de los componentes
		  delete #servaut                            

		  insert into #servaut                       
		  select sc_csc_service_id, ts_servicio     
		  --inicio migracion fal 05192016
		  from an_service_component        
			   left outer join ad_servicio_autorizado on ts_servicio = sc_csc_service_id 
			   inner join #tmp_pages_comp_oper on id = convert(varchar(20),sc_co_id)
		  where tipo           =  'C'  --servicios estan ligados a un componente
			and ts_rol         =  @i_rol            
			and sc_csc_service_id in (select csc_service_id from cts_serv_catalog)  --ECA  Control de existencia en tabla padre
			   
		  --from #tmp_pages_comp_oper,
			--   an_service_component,        --25166        
			--   ad_servicio_autorizado               
		  --where tipo           =  'C'  --servicios estan ligados a un componente
			--and id             =  convert(varchar(20),sc_co_id)
			--and ts_rol         =  @i_rol            
			--and ts_servicio    =* sc_csc_service_id 
			--and sc_csc_service_id in (select csc_service_id from cts_serv_catalog)  --ECA  Control de existencia en tabla padre
			--fin migracion fal 05192016
						
		  insert into ad_servicio_autorizado (ts_servicio,ts_producto,ts_tipo,ts_moneda,ts_rol,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
		  select distinct sc_csc_service_id ,1,'R',0,@i_rol,getdate(),'V',getdate()
		  from #servaut                            
		  where ts_servicio is null    	  	    
			
		  if @@error <> 0
		  begin
			 select @w_return = 153010   --Existio un error en creacion de transaccion autorizada
			 goto error
		  end
	 
	   --tx continua para sincronizar prod rol
	end



	if @i_operacion = 'U'
	begin
	   if @i_tipo = 'L'
	   begin
		  begin tran
			 insert into ts_label (secuencia,    tipo_transaccion,    clase,       fecha,             oficina_s,
								   usuario,      terminal_s,          srv,         lsrv,
								   id_label,     label,               cultura)
			 values( @s_ssn,    @t_trn,     'N',       @s_date,     @s_ofi,
					 @s_user,   @s_term,    @s_srv,    @s_lsrv,
					 @i_la_id,  @i_label,   @s_culture)

			 if @@error != 0
			 begin
				select @w_return = 153023  -- Existio un error al crear la tx
				goto error
			 end
			 --Control de existencia del Label
			  if not exists (select 1 from an_label
							 where la_id = @i_la_id and la_cod = @s_culture)
			 begin
				select @w_return = 157923   --Label no existe
				goto error
			 end
			 --Actualizaci=n del Label
			 update an_label set la_label = @i_label where la_id = @i_la_id and la_cod = @s_culture

			 if @@error <> 0
			 begin
				select @w_return = 157924  --Existio un error al actuializar el label
				goto error
			 end
		  commit tran
		  return 0
	   end  
	   
	   if @i_tipo = 'A'
	   begin
		  create table #tmp_agente ( id int identity, agente int )
		  --Obtencion de Ids de Agentes en el orden que se deben autorizar
		  select @w_components = @i_components
		  
		  select @w_position = CHARINDEX( ';', @w_components)
		  while @w_position <> 0 and len(@w_components) > 1
		  begin
			 insert into #tmp_agente values(convert(int,LEFT(@w_components, @w_position -1)))
			 select @w_components = stuff( @w_components, 1, @w_position, null)
			 select @w_position = CHARINDEX( ';', @w_components )
		  end
		  
		  --Insertando autorizaciones de componentes de Agentes
			 insert into cobis..an_role_component
				select distinct ag_co_id, @i_rol
				from cobis..an_agent a
				where not exists(select 1 from cobis..an_role_component
						   where rc_rol = @i_rol and rc_co_id = a.ag_co_id)
				  if @@error <> 0
				  begin
					 select @w_return = 157170  -- Existio un error al autorizar el componente
					 goto error
				  end
			--Insertando autorizaciones de módulos de Agentes
			 insert into cobis..an_role_module
				select distinct co_mo_id, @i_rol
				from cobis..an_component c
				where co_id in (select ag_co_id from cobis..an_agent) 
				and not exists(select 1 from cobis..an_role_module
						   where rm_rol = @i_rol and rm_mo_id = c.co_mo_id)
				  if @@error <> 0
				  begin
					 select @w_return = 157199  -- Existio un error al autorizar el modulo
					 goto error
				  end
				  
			--Insertando modulos dependientes
			 insert into cobis..an_role_module
				select distinct md_dependency_id, @i_rol
					from an_module_dependency md
					where md_mo_id in (select co_mo_id
										from cobis..an_component c
										where co_id in (select ag_co_id from cobis..an_agent))
					and not exists(select 1 from cobis..an_role_module
									where rm_rol = @i_rol and rm_mo_id = md.md_dependency_id)
					  if @@error <> 0
					  begin
						 select @w_return = 157199  -- Existio un error al autorizar el modulo
						 goto error
					  end
		  
		  begin tran
			 delete an_role_agent where ra_rol = @i_rol
			 
			 if @@error <> 0
			 begin
				select @w_return = 157924  --Existio un error al eliminar los agentes del rol
				goto error
			 end
		  
			 insert into an_role_agent (ra_ag_id,ra_rol,ra_order)
			 select agente, @i_rol, id
			 from #tmp_agente order by id
			 
			 if @@error <> 0
			 begin
				select @w_return = 157924  --Existio un error al autorizar los agentes al rol
				goto error
			 end
		  commit tran
		  
		  select @i_operacion = 'L' --Retornar definiciones actuales
	   end
	end



	if @i_operacion = 'D'
	begin
	   --begin tran en bloque anterior de ts
		  --Eliminaci=n de autorizaciones a Paginas
		  delete an_role_page from an_role_page,#tmp_pages_comp_oper
		  where rp_pa_id = convert(int,id)
			and tipo     = 'P'
			and rp_rol   = @i_rol

		  if @@error <> 0
		  begin
			 select @w_return = 157196   --Existio un error al eliminar la autorizacion de la Pagina
			 goto error
		  end

		  insert into #modules
		  select mo_id
		  from #tmp_pages_comp_oper, an_component, an_module
		  where tipo  = 'C'
			and co_id = convert(int,id)
			and mo_id = co_mo_id
			
		  --Agregar modulos dependientes para autorizar
		  --while 1=1
		  --begin         
			 --insert into #modules
			 --select distinct md_dependency_id 
			 --from an_module_dependency, #modules
			 --where md_mo_id = mod
			   --and md_dependency_id not in (select mod from #modules)
		  
			 --if @@rowcount = 0 break
		  --end

		  --Eliminaci=n de las autorizaciones de los componentes
		  delete an_role_component
		  from #tmp_pages_comp_oper
		  where rc_co_id = convert(int,id)
			and tipo     = 'C'
			and rc_rol   = @i_rol

		  if @@error <> 0
		  begin
			 select @w_return = 157174  --Existio un error al desautorizar el Componente al Rol
			 goto error
		  end

		  --Eliminar autorizaciones de modulos que no tienen componentes autorizados al rol (depura incluso data inconsistente)
		  insert into #moddel
		  select mo_id, 'S'
		  from an_module, an_role_module
		  where mo_id = rm_mo_id
			and rm_rol = @i_rol

		  update #moddel
		  set borrar = 'N'
		  from an_component, an_role_component
		  where co_id    = rc_co_id
			and co_mo_id = mo_id
			and rc_rol   = @i_rol

		  --No eliminar autorizaciones de modulos con dependencias
		  --while 1=1
		  --begin
		  --	 update #moddel
	--		 set borrar = 'N'
		---	 from an_module_dependency
			-- where mo_id    =  md_dependency_id
			 --  and borrar   =  'S'
			  -- and md_mo_id in (select mo_id from #moddel where borrar = 'N')
		  
		--	 if @@rowcount = 0 break
		  --end
			
		  delete an_role_module
		  --from #moddel
		  from #modules
		  --where mo_id  = rm_mo_id
		  where mod  = rm_mo_id
			and rm_rol = @i_rol
			--and borrar = 'S'

		  if @@error <> 0
		  begin
			 select @w_return = 157140  --Existio un error al desautorizar el modulo para el rol
			 goto error
		  end

		  --Determinar que prodnames no tienen ningun componente autorizado
		  insert into #dataprod
		  select c.codigo, (select count(1)
							from cobis..an_role_component, cobis..an_component
							where rc_co_id = co_id and rc_rol = @i_rol and co_prod_name = c.codigo)
		  from cobis..cl_tabla t, cobis..cl_catalogo c
		  where t.codigo = c.tabla
			and t.tabla  = 'an_product'
		  -------------------------------
		  /* AUTORIZACION DE TRANSACCS */
		  -------------------------------
		  --Determinar que transacciones no se deben eliminar por ser compartidas con otros componentes/operaciones
		  -- Las transacciones compartidas solo seran controladas a nivel de Base ProdName y Base Componente
		  -- a nivel de Operacion de un componente las transacciones no deben ser compartidas entre componentes para garantizar
		  -- la integridad y la administracion de seguridades.
		  insert into #trnaut
		  select tc_tn_trn_code, null --tx base de prodname que no se deben eliminar x tener componentes autorizados
		  from #dataprod, an_transaction_component
		  where prodname = tc_oc_nemonic
			and tc_co_id = 0
			and num      > 0
		  union
		  select tc_tn_trn_code, null --tx base de componentes autorizados y que no se deben eliminar
		  from cobis..an_role_component, cobis..an_transaction_component
		  where rc_co_id      = tc_co_id
			and tc_oc_nemonic is null
			and tc_co_id      > 0
			and rc_rol        = @i_rol

		  --Eliminar autorizaciones de transacciones
		  delete ad_tr_autorizada
		  from an_transaction_component, #tmp_pages_comp_oper
		  where tc_co_id       = id_parent
			and tc_tn_trn_code = ta_transaccion
			and id             = isnull(tc_oc_nemonic,'BASE')
			and tipo           = 'O'
			and ta_rol         = @i_rol
			and ta_transaccion not in (select tc_tn_trn_code from #trnaut)
			and tc_tn_trn_code not in (1556,1564,1574,1577,1579,15001,15031,15153,15168,
									   15301,15302,15315,15316,15317,15318,15319,15320)--Funcionalidades Basicas de Cen
		  if @@error <> 0
		  begin
			 select @w_return = 157025   --Error en eliminacion de transaccion autorizada
			 goto error
		  end
		  
		  --Elimina transacciones base x Modulo cuando no existan componentes autorizados de un prodName
		  delete ad_tr_autorizada
		  from #dataprod, an_transaction_component
		  where prodname       = tc_oc_nemonic
			and tc_tn_trn_code = ta_transaccion
			and num            = 0
			and tc_co_id       = 0
			and ta_rol         = @i_rol
			and ta_transaccion not in (select tc_tn_trn_code from #trnaut)
			and tc_tn_trn_code not in (1556,1564,1574,1577,1579,15001,15031,15153,15168,
									   15301,15302,15315,15316,15317,15318,15319,15320)--Funcionalidades Basicas de Cen

		  if @@error <> 0
		  begin
			 select @w_return = 157025   --Error en eliminacion de transaccion autorizada
			 goto error
		  end

		  -------------------------------
		  /* AUTORIZACION DE SERVICIOS */
		  -------------------------------
		  --Determinar que SERVICIOS no se deben eliminar por ser compartidas con otros componentes/operaciones
		  -- Los servios compartidas solo seran controladas a nivel de Base ProdName y Base Componente
		  -- a nivel de Operacion de un componente los servicios no deben ser compartidas entre componentes para garantizar
		  -- la integridad y la administracion de seguridades.
		 insert into #servaut                  
		  select sc_csc_service_id, null       
		  from #dataprod, an_service_component
		  where prodname = sc_oc_nemonic       
			and sc_co_id = 0                   
			and num      > 0
		  union
		  select distinct sc_csc_service_id, null       --tx base de componentes autorizados y que no se deben eliminar
		  from cobis..an_role_component, cobis..an_service_component sc
		  where rc_co_id      = sc.sc_co_id      
			and sc_csc_service_id in (select sc_csc_service_id from an_service_component 
															   where sc_co_id in (select convert(int, id) from #tmp_pages_comp_oper  
																										  where tipo           =  'C' ))
			--and sc_oc_nemonic is null
			and sc.sc_co_id      > 0   
			and rc_rol        = @i_rol
					
		  --Eliminar autorizaciones de transacciones
		  delete ad_servicio_autorizado              
		  from an_service_component, #tmp_pages_comp_oper 
		  where tipo           =  'C'   
			and ts_rol         =  @i_rol      
			and id             =  convert(varchar(20),sc_co_id)
			and ts_servicio    = sc_csc_service_id         
			and ts_servicio  not in (select sc_csc_service_id from #servaut) 
			
		  if @@error <> 0
		  begin
			 select @w_return = 157025   --Error en eliminacion de transaccion autorizada
			 goto error
		  end

		  --Elimina transacciones base x Modulo cuando no existan componentes autorizados de un prodName
		  delete ad_servicio_autorizado		     
		  from #dataprod, an_service_component   
		  where prodname       = sc_oc_nemonic  
			and sc_csc_service_id = ts_servicio  
			and num            = 0
			and sc_co_id       = 0              
			and ts_rol         = @i_rol         
			and ts_servicio not in (select sc_csc_service_id from #servaut) 

		  if @@error <> 0
		  begin
			 select @w_return = 157025   --Error en eliminacion de transaccion autorizada
			 goto error
		  end
	  
		  
		  --Eliminar autorizaciones a Zonas de Navegacion cuando un rol no tenga modulos asociados
		  if not exists(select 1 from cobis..an_role_module
						where rm_rol = @i_rol
						  and rm_mo_id not in (select co_mo_id from cobis..an_navigation_zone, cobis..an_component
											   where nz_co_id = co_id))
		  begin
			 delete cobis..an_role_navigation_zone
			 where rn_rol = @i_rol

			 if @@error <> 0
			 begin
				select @w_return = 157145  -- Existio un error al desautorizar la zona de navegacion
				goto error
			 end

			 delete cobis..an_role_module
			 from cobis..an_navigation_zone, cobis..an_component
			 where nz_co_id = co_id
			   and rm_mo_id = co_mo_id
			   and rm_rol = @i_rol

			 if @@error <> 0
			 begin
				select @w_return = 157140  -- Existio un error al desautorizar el Module
				goto error
			 end

			 delete cobis..an_role_component
			 from cobis..an_navigation_zone
			 where rc_co_id = nz_co_id
			   and rc_rol = @i_rol

			 if @@error <> 0
			 begin
				select @w_return = 157174  -- Existio un error al autorizar el componente
				goto error
			 end
		  end
	   --tx continua para sincronizar prod rol
	end


	--Sincronizar asociacion de roles a productos (en operaciones I y D)
	if @i_operacion in ('I','D')
	begin
	   insert into #prodaut(producto,tipo,moneda)
	   select ta_producto, ta_tipo, ta_moneda
	   from cobis..ad_tr_autorizada
	   where ta_rol = @i_rol
	   group by ta_producto, ta_tipo, ta_moneda
	   
	   --Desasocia Rol Prod
	   update cobis..ad_pro_rol
	   set pr_estado        = 'I',
		   pr_fecha_ult_mod = getdate(),
		   pr_autorizante   = 1
	   from cobis..ad_pro_rol pr
	   where pr_rol = @i_rol
		 and not exists ( select 1 from #prodaut
						 where producto = pr.pr_producto
						   and tipo     = pr.pr_tipo
						   and moneda   = pr.pr_moneda)

	   if @@error <> 0
	   begin
		  select @w_return = 157019  -- Existio un error al desasociar producto a rol
		  goto error
	   end
	   
	   --Asocia Rol Prod
	   update cobis..ad_pro_rol
	   set pr_estado        = 'V',
		   pr_fecha_ult_mod = getdate(),
		   pr_autorizante   = 1
	   from cobis..ad_pro_rol pr
	   where pr_rol = @i_rol
		 and    exists ( select 1 from #prodaut
						 where producto = pr.pr_producto
						   and tipo     = pr.pr_tipo
						   and moneda   = pr.pr_moneda)

	   if @@error <> 0
	   begin
		  select @w_return = 157019  -- Existio un error al desasociar producto a rol
		  goto error
	   end
	   
	   --Asocia Rol Prod 
	   insert into ad_pro_rol 
		   (pr_rol, pr_producto, pr_tipo, pr_moneda, pr_fecha_crea, pr_autorizante, pr_estado, pr_fecha_ult_mod, pr_menu_inicial)
	   select @i_rol,  producto, tipo, moneda, @s_date,       1,              'V',       getdate(),          null
	   from #prodaut p
	   where not exists (select 1 from cobis..ad_pro_rol
						 where pr_rol      = @i_rol
						   and pr_producto = p.producto
						   and pr_tipo     = p.tipo
						   and pr_moneda   = p.moneda)
	   
	   if @@error <> 0
	   begin
		  select @w_return = 153008  -- Existio un error al asociar producto a rol
		  goto error
	   end
	   
	   commit tran
	   return 0
	end

	if @i_operacion in ('S','H') and @i_modo = 0
	begin
	   --Tabla temporal que almacena los roles que se van a evaluar
	   create table #tmp_rol ( tmp_id tinyint identity, tmp_rol int )

	   --Tabla temporal que almacena los productos CEN que se van a evaluar
	   create table #tmp_prod_name ( tmp_prod_name varchar(10) )

	   --Tabla temporal de autorizaciones
	   create table #an_menu_role_page_tmp(
		  indice       int            identity,
		  --id           varchar(255),   --jta
		  id           varchar(500),
		  id_etiqueta  int,
		  etiqueta     varchar(100),
		  id_sup       varchar(255),
		  prod_name    varchar(10),
		  tipo         char(1),
		  id_own       varchar(20),
		  id_sup_own   int            null,
		  rol1         tinyint        default 1,
		  rol2         tinyint        default 1,
		  rol3         tinyint        default 1,
		  rol4         tinyint        default 1,
		  rol5         tinyint        default 1,
		  rol6         tinyint        default 1,
		  rol7         tinyint        default 1,
		  rol8         tinyint        default 1,
		  rol9         tinyint        default 1,
		  rol10        tinyint        default 1,
		  rol11        tinyint        default 1,
		  rol12        tinyint        default 1,
		  rol13        tinyint        default 1,
		  rol14        tinyint        default 1,
		  rol15        tinyint        default 1,
		  rol16        tinyint        default 1,
		  rol17        tinyint        default 1,
		  rol18        tinyint        default 1,
		  rol19        tinyint        default 1,
		  rol20        tinyint        default 1,
		  visible      char(1)        null
	   )

	   create table #an_menu_role_page_aux (
		  id           varchar(255),
		  id_etiqueta  int,
		  etiqueta     varchar(100),
		  id_sup       varchar(255),
		  prod_name    varchar(10),
		  tipo         varchar(1),
		  id_own       varchar(20),
		  visible      char(1)      null
	   )
	end

	if @i_operacion = 'S'
	begin
	   set rowcount 0

	   if @i_modo = 0
	   begin
		  --Obtencion de los Ids de productos CEN seleccionados en el Frontend
		  if (@i_prod_names is not null)
		  begin
			 select @w_prod_names = @i_prod_names
			 select @w_position = CHARINDEX( ';', @w_prod_names)
			 while @w_position <> 0
			 begin
				insert into #tmp_prod_name(tmp_prod_name) values (LEFT(@w_prod_names, @w_position -1))
				if @@error != 0
				begin
				   select @w_error = 'Error en la obtencion de ids de productos CEN.'
				   goto error
				end
				select @w_prod_names  = stuff(@w_prod_names, 1, @w_position, null)
				select @w_position = CHARINDEX( ';', @w_prod_names )
			 end
		  end

		  --Obtiene los primeros 20 roles que estan asociados al producto CEN
		  if (@i_roles is null)
		  begin
				set rowcount 20
				insert into #tmp_rol (tmp_rol)
				select distinct(rp_rol) from an_page,#tmp_prod_name,an_role_page,an_label,ad_rol
				where pa_prod_name = tmp_prod_name
				   and rp_pa_id = pa_id
				   and la_id = pa_la_id
				   and la_cod = @s_culture
				   and rp_rol = ro_rol
				   and rp_rol > isnull(@i_rol,0)
				--order by rp_rol	 --migracion sybase-sql 19052016
				set rowcount 0
		  end
		  else
		  begin
			 select @w_roles = RTRIM(@i_roles)
			 select @w_position = CHARINDEX( ';', @w_roles)
			 --Obtencion de los Ids de roles seleccionados en el Frontend
			 while @w_position <> 0
			 begin
				insert into #tmp_rol (tmp_rol) values (convert(int,LEFT(@w_roles, @w_position -1)))
				if @@error != 0
				begin
				   select @w_error = 'Error en la obtencion de ids de roles.'
				   goto error
				end
				select @w_roles = stuff(@w_roles, 1, @w_position, null)
				select @w_position = CHARINDEX( ';', @w_roles )
			 end
			 --Obtiene los todos los productos CEN que estan asociados a los roles seleccionados
			 if (@i_prod_names is null)
			 begin
				insert into #tmp_prod_name
				select distinct(pa_prod_name) from an_page, an_role_page,#tmp_rol, cl_tabla T, cl_catalogo C
				where rp_pa_id = pa_id
				   and rp_rol = tmp_rol
				   and T.codigo = C.tabla
				   and T.tabla = 'an_product'
				   and C.codigo = pa_prod_name
			 end
		  end

		  --Carga todas las páginas que pertenecen a los productos CEN seleccionados
		  insert into #an_menu_role_page_aux (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible )
		  select convert(varchar,P.pa_id),
			 P.pa_la_id,
			 isnull(la_label, 'No tiene Etiqueta'),
			 convert(varchar,isnull(P.pa_id_parent, 0)),
			 P.pa_prod_name,
			 'P',
			 convert(varchar,P.pa_id),
			 case when P.pa_visible = 1 then 'S' else 'N' end
		   --inicio mig syb-sql 18042016   
		  from an_page P 
			   left outer join an_page S on P.pa_id_parent = S.pa_id
			   left outer join an_label on P.pa_la_id = la_id
			   inner join cl_catalogo C on C.codigo = P.pa_prod_name
			   inner join cl_tabla T on T.tabla = 'an_product' 
									and T.codigo = C.tabla
		 where la_cod = @s_culture       
		   and P.pa_prod_name in (select tmp_prod_name from #tmp_prod_name)
		  order by  P.pa_id

		  --COMENTADO POR MIGRACION
		  --from an_page P, an_page S, an_label , cl_tabla T, cl_catalogo C
		  --where P.pa_id_parent *= S.pa_id
			 --and la_cod = @s_culture
			 --and P.pa_la_id *= la_id
			 --and T.codigo = C.tabla
			 --and T.tabla = 'an_product'
			 --and C.codigo = P.pa_prod_name
			 --and P.pa_prod_name in (select tmp_prod_name from #tmp_prod_name)
		  --order by  P.pa_id
		  --fin mig syb-sql 18042016                  
		  

		  --FLO - Agregar Padres Faltantes hasta nivel 0
		  select @w_intento = 0
		  while 1=1
		  begin
			 insert into #an_menu_role_page_aux  (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible )
			 select convert(varchar,pa_id),
					pa_la_id,
					isnull(la_label, 'No tiene Etiqueta'),
					convert(varchar,isnull(pa_id_parent, 0)),
					pa_prod_name,
					'P',
					convert(varchar,pa_id),
					case when pa_visible = 1 then 'S' else 'N' end
			  --inicio migracion SYB-SQL FAL 19052016
			   from an_page
					left outer join an_label on pa_la_id = la_id
					inner join #an_menu_role_page_aux m on not exists(select 1 from #an_menu_role_page_aux where id = m.id_sup)
			 where la_cod       = @s_culture           
			   and tipo         = 'P'           
			   and id_sup       <> '0'
			   and pa_id        = convert(int,id_sup)
			 order by pa_id
			  
			 --COMENTADO migracion SYB-SQL FAL 19052016                
			 --from an_page, an_label, #an_menu_role_page_aux m
			 --where la_cod       = @s_culture 
			   --and pa_la_id    *= la_id         
			   --and not exists(select 1 from #an_menu_role_page_aux where id = m.id_sup)         
			   --and tipo         = 'P'           
			   --and id_sup       <> '0'
			   --and pa_id        = convert(int,id_sup)
			 --order by pa_id
			  --fin migracion SYB-SQL FAL 19052016                

			 if @@rowcount = 0 break
			 if @w_intento > @w_ciclos break    --control para evitar ciclo infinito x data inconsistente
			 if (select count(1) from #an_menu_role_page_aux) > @w_limite
			 begin
				select @w_return = 157925   --Parametrizaci=n Inconsistente
				goto error
			 end
			 select @w_intento = @w_intento +1
		  end

	 /*  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible)
		  select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible
		  from #an_menu_role_page_aux
		  order by convert(int,id_sup), convert(int,id) 
	*/	  
			------------------------------------------- JTA 25513
			-- inserta los id_sup = 0
			insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible)
			select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible
			from #an_menu_role_page_aux
			where id_sup = '0'
				 
			create table #id_sup (id varchar(20) null)
			insert into #id_sup (id)
			select distinct id
			from #an_menu_role_page_aux
			where id_sup = '0'

			--inserta los del hijo de id_sup = 0
			insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible)
			select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible
			from #an_menu_role_page_aux
			where id_sup in (select id from #id_sup)

			--inserta los demas
			--MIGRACION SYB-SQL FAL 19052016
			select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible, 
			id_sup_int = convert(int,id_sup), id_int = convert(int,id)   --migracion syb-sql FAL
			into #tmp_mrole_page_orderby                                 --migracion syb-sql FAL
			from #an_menu_role_page_aux
			where  id_sup <> '0'
			and id_sup not in (select id from #id_sup)
			order by convert(int,id_sup), convert(int,id)
			--MIGRACION SYB-SQL FAL 19052016
			
			insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible)
			select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible
			from #tmp_mrole_page_orderby                                 --migracion syb-sql FAL
			
			-------------------------------------------	  
		  
		  --Carga todos los componentes que pertenecen a las páginas anteriormente cargadas
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo, id_own, id_sup_own  )
		  select convert(varchar,pz_pa_id) + '_' + convert(varchar,pz_id) + '-'+ convert(varchar,co_id),
			 pz_la_id,
			 isnull(la_label, 'No tiene Etiqueta'),
			 convert(varchar,isnull(pz_pa_id, 0)),
			 co_prod_name,
			 'C',
			 convert(varchar,co_id),
			 pz_pa_id
		  --inicio migracion syb-sql 19052016
		  from an_page_zone
			   inner join an_component on co_id = pz_co_id
									  and co_prod_name in (select tmp_prod_name from #tmp_prod_name)
			   left outer join an_label on pz_la_id = la_id
			   inner join #an_menu_role_page_tmp on convert(int,id_own) = pz_pa_id
			   inner join cl_catalogo C on C.codigo = co_prod_name
			   inner join cl_tabla T on T.tabla = 'an_product'
									and T.codigo = C.tabla
		 where la_cod = @s_culture
		 order by co_id

		  --COMENTADO MIGRACION FAL
		  --from an_page_zone, an_component, an_label, #an_menu_role_page_tmp, cl_tabla T, cl_catalogo C
		  --where co_id = pz_co_id
			--and convert(int,id_own) = pz_pa_id
			--and la_cod = @s_culture
			--and pz_la_id *= la_id
			--and T.codigo = C.tabla
			--and T.tabla = 'an_product'
			--and C.codigo = co_prod_name
			--and co_prod_name in (select tmp_prod_name from #tmp_prod_name)
		  --order by co_id
		  --fin migracion syb-sql 19052016
		  
		  --Carga todos los modulos referenciados de forma recursiva
		  select @w_intento = 0
		  while 1=1
		  begin
			 insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
			 select A.id + '-' +convert(varchar,rc_child_co_id),
				rc_la_id,
				isnull(la_label, 'No tiene Etiqueta'),
				A.id,
				A.prod_name,
				'R',
				convert(varchar,rc_child_co_id),
				A.id_sup_own
			--inicio migracion syb-sql 19052016            
			 from an_referenced_components rc
				  left outer join an_label on rc_la_id = la_id
				  inner join #an_menu_role_page_tmp A on rc_parent_co_id = convert(int,A.id_own)
			where la_cod = @s_culture
			   and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
			   and A.tipo in ('C','R')
			   and rc_child_co_id in (select cr_child_co_id from an_cust_referenced_components where cr_co_id = rc.rc_parent_co_id and cr_pa_id = A.id_sup_own)
			 order by  rc_parent_co_id, rc_child_co_id
			
			 --from an_referenced_components rc, an_label, #an_menu_role_page_tmp A
			 --where rc_parent_co_id = convert(int,A.id_own)
			   --and la_cod = @s_culture
			   --and rc_la_id *= la_id
			   --and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
			   --and A.tipo in ('C','R')
			   --and rc_child_co_id in (select cr_child_co_id from an_cust_referenced_components where cr_co_id = rc.rc_parent_co_id and cr_pa_id = A.id_sup_own)
			 --order by  rc_parent_co_id, rc_child_co_id
			--fin migracion syb-sql 19052016

			 insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
			 select A.id + '-' +convert(varchar,rc_child_co_id),
					rc_la_id,
					isnull(la_label, 'No tiene Etiqueta'),
					A.id,
					A.prod_name,
					'R',
					convert(varchar,rc_child_co_id),
					A.id_sup_own
			--inicio migracion syb-sql 19052016                     
			   from an_referenced_components rc
					left outer join an_label on rc_la_id = la_id
					inner join #an_menu_role_page_tmp A on rc_parent_co_id = convert(int,A.id_own)
			  where la_cod = @s_culture
				and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
				and A.tipo in ('C','R')
				and not exists (select 1 from an_cust_referenced_components where cr_co_id = rc.rc_parent_co_id and cr_pa_id = A.id_sup_own)
			  order by  rc_parent_co_id, rc_child_co_id
			 
			 --from an_referenced_components rc, an_label, #an_menu_role_page_tmp A
			 --where rc_parent_co_id = convert(int,A.id_own)
			   --and la_cod = @s_culture
			   --and rc_la_id *= la_id
			   --and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
			   --and A.tipo in ('C','R')
			   --and not exists (select 1 from an_cust_referenced_components where cr_co_id = rc.rc_parent_co_id and cr_pa_id = A.id_sup_own)
			 --order by  rc_parent_co_id, rc_child_co_id
			 --fin migracion syb-sql 19052016 

			 if @@rowcount = 0 break
			 if @w_intento > @w_ciclos break
			 if (select count(1) from #an_menu_role_page_tmp) > @w_limite
			 begin
				select @w_return = 157925   --Parametrizaci=n Inconsistente
				goto error
			 end
			 select @w_intento = @w_intento +1
		  end

		  --Carga operacion BASE para los componentes cargados anteriormente
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
		  select distinct (B.id + '-BASE'),
							0,      --label id
							'Base',
							B.id,
							B.prod_name,
							'O',
							'BASE',
							tc_co_id
		  from  an_transaction_component,
			#an_menu_role_page_tmp B
		  where (tc_oc_nemonic is null and tc_co_id = convert(int,B.id_own))
			and B.tipo in ('C','R')

			
		  --Carga todas las operaciones que pertenecen a los componentes anteriormente cargados
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
		  select distinct (B.id + '-' + oc_nemonic),
						 oc_la_id,
						 isnull(la_label,'No tiene Etiqueta'),
						 B.id,
						 B.prod_name,
						 'O',
						 oc_nemonic,
						 oc_co_id
		  --inicio migracion fal 05192016         
		  from  an_operation_component A
				left outer join an_label on la_id = oc_la_id	  
				inner join #an_menu_role_page_tmp B on oc_co_id = convert(int,B.id_own)
												   and B.tipo in ('C','R')
				inner join an_transaction_component on (oc_nemonic = tc_oc_nemonic and tc_co_id = convert(int,B.id_own))		

		  --from  an_operation_component A,
			--    an_transaction_component,
			--	an_label,
			--	#an_menu_role_page_tmp B
		  --where la_id       =*  oc_la_id	  
			 --and (oc_nemonic = tc_oc_nemonic and tc_co_id = convert(int,B.id_own))
			 --and oc_co_id   =  convert(int,B.id_own)
			 --and B.tipo     in ('C','R')
		  --fin migracion fal 05192016


		  --Si se necesita filtrar por alguna parte del label
		  if(LEN(RTRIM(@i_label)) > 0)
		  begin
			 create table #tmp_menu1 (
				id varchar(255),
				id_sup varchar(255),
			 )
			 --Obtiene todos los registros cuyos labels cumplen con la condici=n
			 insert into #tmp_menu1
			 select    id,id_sup
			 from #an_menu_role_page_tmp
			 where etiqueta like '%'+ @i_label + '%'
			 --FLO - Obtiene los hijos del label de forma recursiva
			 while 1=1
			 begin
				insert into #tmp_menu1
				select distinct A.id, A.id_sup
				from #an_menu_role_page_tmp A,#tmp_menu1 B
				where B.id = A.id_sup
				   and A.id not in (select id from #tmp_menu1)
				if @@rowcount = 0 break
			 end
			 --Obtiene los padres del label de forma recursiva
			 while 1=1
			 begin
				insert into #tmp_menu1
				select    distinct A.id,
				   A.id_sup
				from #an_menu_role_page_tmp A,#tmp_menu1 B
				where A.id = B.id_sup
				   and A.id not in (select id from #tmp_menu1)
				if @@rowcount = 0 break
			 end
			 --Borra todos los demas registros que no cumplen con la condici=n
			 delete from #an_menu_role_page_tmp where id not in (select id from #tmp_menu1)
		  end

		  --Obtiene la asociacion por cada rol a las páginas, componentes y operaciones
		  declare cur_roles cursor
			 for select tmp_id, tmp_rol from #tmp_rol
		  for read only
		  open cur_roles
		  fetch cur_roles into @w_ro_id, @w_ro_rol
		  --while @@sqlstatus = 0
		  while @@fetch_status = 0  --migracion syb-sql 19052016
		  begin
			 --Actualiza a 0 donde el rol no este asociado a la página
			 select @w_query ='update #an_menu_role_page_tmp set rol'+ convert(varchar,@w_ro_id) + ' = 0 from #an_menu_role_page_tmp LEFT JOIN an_role_page ON convert(int,id_own) = rp_pa_id and rp_rol = ' +  convert(varchar,@w_ro_rol) + ' where tipo = ''P'' and rp_pa_id is null'
			 execute(@w_query)

			 --Actualiza a 0 donde el rol no este asociado al componente
			 select @w_query = 'update #an_menu_role_page_tmp set rol'+ convert(varchar,@w_ro_id) + ' = 0 from #an_menu_role_page_tmp LEFT JOIN an_role_component ON convert(int,id_own) = rc_co_id and rc_rol = ' +  convert(varchar,@w_ro_rol) + ' where tipo in (''C'',''R'')  and rc_co_id is null'
			 execute(@w_query)

			 --Actualiza a 0 donde el rol no este asociado a todas las transaciones pertenecientes al componente
			 select @w_query = 'update #an_menu_role_page_tmp set rol'+ convert(varchar,@w_ro_id) + ' = 0 from an_transaction_component LEFT JOIN ad_tr_autorizada ON tc_tn_trn_code = ta_transaccion and ta_rol = ' + convert(varchar,@w_ro_rol) + ' where tipo = ''O'' and ta_transaccion is null and id_own = isnull(tc_oc_nemonic,''BASE'') and tc_co_id = id_sup_own'
			 execute(@w_query)

			 fetch cur_roles into @w_ro_id, @w_ro_rol
		  end
		  close cur_roles
		  --deallocate cursor cur_roles     --migracion syb-sql 19052016
		  deallocate  cur_roles     --migracion syb-sql 19052016

		  --Actualizar los datos generados en tabla fisica
		  delete an_menu_role_page_tmp where usuario = @s_user

		  select @w_query = 'insert into an_menu_role_page_tmp select ''' + @s_user + ''',* from #an_menu_role_page_tmp order by indice'
		  execute(@w_query)

	   end
	   --Selecciona los 10 registros de páginas,componentes, operaciones asociados como maximo a los 20 primeros roles
	   set rowcount 10
	   select   'INDICE'        = indice,
				'ID'            = id,
				'ID ETIQUETA'   = id_etiqueta,
				'ETIQUETA'      = etiqueta,
				'ID SUP'        = id_sup,
				'PROD_NAME'     = prod_name,
				'TIPO'          = tipo,
				'ID PROPIO'     = id_own,
				'ROL1'          = rol1,
				'ROL2'          = rol2,
				'ROL3'          = rol3,
				'ROL4'          = rol4,
				'ROL5'          = rol5,
				'ROL6'          = rol6,
				'ROL7'          = rol7,
				'ROL8'          = rol8,
				'ROL9'          = rol9,
				'ROL10'         = rol10,
				'ROL11'         = rol11,
				'ROL12'         = rol12,
				'ROL13'         = rol13,
				'ROL14'         = rol14,
				'ROL15'         = rol15,
				'ROL16'         = rol16,
				'ROL17'         = rol17,
				'ROL18'         = rol18,
				'ROL19'         = rol19,
				'ROL20'         = rol20,
				'VISIBLE'       = visible
	   from an_menu_role_page_tmp
	   where indice  > @i_pa_id
		 and usuario = @s_user
	   order by indice

	   set rowcount 0

	   --Devuelve los roles seleccionados al Front end
	   if @i_modo = 0
	   begin
		  select 'CODIGO' = ro_rol,
				 'ROL'    = ro_descripcion
		  from ad_rol, #tmp_rol
		  where ro_rol = tmp_rol
		  and ro_rol > isnull(@i_rol,0)	  
	   end
	   return 0
	end

	/* ** help ** */
	if @i_operacion = 'H'
	begin
	   set rowcount 0
	   if @i_modo = 0
	   begin
		  create table #compref (idcomp int)
		  create table #comptmp (idcomp int)
		  create table #comptmp1 (idcomp int)

		  insert into #compref --values (convert(int,@i_components))
		  select convert(int,id) from #tmp_pages_comp_oper

		  insert into #comptmp
		  select * from #compref

		  select @w_intento = 0
		  while 1 = 1
		  begin
			 insert into #comptmp1
			 select rc_parent_co_id
			 from an_referenced_components, #comptmp
			 where rc_child_co_id = idcomp

			 if @@rowcount = 0 break

			 delete #comptmp

			 insert into #comptmp
			 select * from #comptmp1

			 insert into #compref
			 select * from #comptmp1

			 delete #comptmp1

			 if @w_intento > @w_ciclos break
			 if (select count(1) from #comptmp1) > @w_limite
			 begin
				select @w_return = 157925   --Parametrizaci=n Inconsistente
				goto error
			 end
			 select @w_intento = @w_intento +1
		  end

		  --Busca paginas que vinculen el componente a desautorizar
		  insert into #an_menu_role_page_aux
		  select convert(varchar,pa_id),
				 pa_la_id,
				 isnull(la_label, 'No tiene Etiqueta'),
				 convert(varchar,isnull(pa_id_parent, 0)),
				 pa_prod_name,
				 'P',
				 convert(varchar,pa_id),
				 case when pa_visible = 1 then 'S' else 'N' end
			--inicio migracion syb-sql 19052016               
		  from an_page           
			   left outer join an_label on pa_la_id = la_id
			   inner join an_page_zone on pz_pa_id = pa_id
			   inner join an_role_page on pz_pa_id = rp_pa_id
			   inner join #compref on pz_co_id = idcomp
		 where la_cod   = @s_culture
		   and rp_rol   = @i_rol
			
		  --COMENTADO MIGRACION FAL 19052016
		  --from an_page_zone, an_role_page, an_page, an_label, #compref
		  --where pz_pa_id = rp_pa_id
			--and pz_pa_id = pa_id
			--and pa_la_id *= la_id
			--and la_cod   = @s_culture
			--and rp_rol   = @i_rol
			--and pz_co_id = idcomp
			--fin migracion syb-sql 19052016  

		  --Construye las rutas completas de paginas
		  select @w_intento = 0
		  while 1=1
		  begin
			 insert into #an_menu_role_page_aux  (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible )
			 select convert(varchar,pa_id),
					pa_la_id,
					isnull(la_label, 'No tiene Etiqueta'),
					convert(varchar,isnull(pa_id_parent, 0)),
					pa_prod_name,
					'P',
					convert(varchar,pa_id),
					case when pa_visible = 1 then 'S' else 'N' end
			--inicio migracion syb-sql 19052016                 
			   from an_page
					left outer join an_label on pa_la_id = la_id
					inner join #an_menu_role_page_aux m on pa_id = convert(int,id_sup)
			 where la_cod       = @s_culture
			   and tipo         = 'P'
			   and not exists(select 1 from #an_menu_role_page_aux where id = m.id_sup)
			   and id_sup       <> '0'
			 order by pa_id
					
			--COMENTADO MIGRACINO FAL 19052016
			 --from an_page, an_label, #an_menu_role_page_aux m
			 --where la_cod       = @s_culture
			   --and pa_la_id     *= la_id
			   --and tipo         = 'P'
			   --and not exists(select 1 from #an_menu_role_page_aux where id = m.id_sup)
			   --and id_sup       <> '0'
			   --and pa_id        = convert(int,id_sup)
			 --order by pa_id
			--fin migracion syb-sql 19052016                  

			 if @@rowcount = 0 break
			 if @w_intento > @w_ciclos break    --control para evitar ciclo infinito x data inconsistente
			 if (select count(1) from #an_menu_role_page_aux) > @w_limite
			 begin
				select @w_return = 157925   --Parametrizaci=n Inconsistente
				goto error
			 end
			 select @w_intento = @w_intento +1
		  end
			
		  --Migracion SYB-SQL FAL
		  select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible,
		  id_int = convert(int,id), id_sup_int = convert(int,id_sup)   
		  into #tmp_mrole_page_aux_orderby
		  from #an_menu_role_page_aux
		  order by convert(int,id), convert(int,id_sup)
		  --Migracion SYB-SQL FAL
		  
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible)
		  select distinct id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, visible
		  from #tmp_mrole_page_aux_orderby  --migracion syb-sql FAL

		  --Inserta componentes a Desautorizar/Autorizar
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo, id_own, id_sup_own  )
		  select convert(varchar,pz_pa_id) + '_' + convert(varchar,pz_id) + '-'+ convert(varchar,co_id),
				 pz_la_id,
				 isnull(la_label, 'No tiene Etiqueta'),
				 convert(varchar,isnull(pz_pa_id, 0)),
				 co_prod_name,
				 'C',
				 convert(varchar,co_id),
				 pz_pa_id
			--inicio migracion syb-sql 19052016              
			from an_page_zone
				 left outer join an_label on pz_la_id = la_id
				 inner join an_role_page on pz_pa_id = rp_pa_id
				 inner join an_page on pz_pa_id = pa_id
				 inner join an_component on pz_co_id = co_id
				 inner join #compref on pz_co_id = idcomp
		   where la_cod   = @s_culture
			 and rp_rol   = @i_rol
			
		  --COMENTADO MIGRACION FAL 19052016
		  --from an_page_zone, an_role_page, an_page, an_label, an_component, #compref
		  --where pz_pa_id = rp_pa_id
			--and pz_pa_id = pa_id
			--and pz_la_id *= la_id
			--and pz_co_id = co_id
			--and la_cod   = @s_culture
			--and rp_rol   = @i_rol
			--and pz_co_id = idcomp
			--fin migracion syb-sql 19052016 

		  --Carga todos los modulos referenciados de forma recursiva
		  select @w_intento = 0
		  while 1=1
		  begin
			 insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
			 select A.id + '-' +convert(varchar,rc_child_co_id),
					rc_la_id,
					isnull(la_label, 'No tiene Etiqueta'),
					A.id,
					A.prod_name,
					'R',
					convert(varchar,rc_child_co_id),
					A.id_sup_own
			--inicio migracion syb-sql 19052016             
			   from an_referenced_components
					left outer join an_label on rc_la_id = la_id
					inner join #an_menu_role_page_tmp A on rc_parent_co_id = convert(int,A.id_own)
			  where la_cod = @s_culture
				and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
				and A.tipo in ('C','R')
			  order by rc_parent_co_id, rc_child_co_id
			
			 --COMENTADO MIGRACION FAL 19052016
			 --from an_referenced_components, an_label, #an_menu_role_page_tmp A
			 --where rc_parent_co_id = convert(int,A.id_own)
			   --and la_cod = @s_culture
			   --and rc_la_id *= la_id
			   --and A.id + '-' + convert(varchar,rc_child_co_id) not in (select id from #an_menu_role_page_tmp where tipo in ('C','R'))
			   --and A.tipo in ('C','R')
			 --order by  rc_parent_co_id, rc_child_co_id
			 --fin migracion syb-sql 19052016 

			 if @@rowcount = 0 break
			 if @w_intento > @w_ciclos break
			 if (select count(1) from #an_menu_role_page_tmp) > @w_limite
			 begin
				select @w_return = 157925   --Parametrizaci=n Inconsistente
				goto error
			 end
			 select @w_intento = @w_intento +1
		  end

		  --Carga operacion BASE para los componentes cargados anteriormente
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
		  select distinct (B.id + '-BASE'),
				 0,      --label id
				 'Base',
				 B.id,
				 B.prod_name,
				 'O',
				 'BASE',
			 tc_co_id
		  from an_transaction_component,
			   #an_menu_role_page_tmp B
		  where (tc_oc_nemonic is null  and tc_co_id = convert(int,B.id_own))
				and B.tipo        in ('C','R')

		  --Carga todas las operaciones que pertenecen a los componentes anteriormente cargados
		  insert into #an_menu_role_page_tmp (id,id_etiqueta, etiqueta ,id_sup ,prod_name , tipo , id_own, id_sup_own )
		  select distinct (B.id + '-' + oc_nemonic),
				 oc_la_id,
				 isnull(la_label, 'No tiene Etiqueta'),
				 B.id,
				 B.prod_name,
				 'O',
				 oc_nemonic,
				 oc_co_id
		--inicio migracion fal 05192016             
		  from  an_operation_component A
				left outer join an_label on la_id = oc_la_id 
				inner join #an_menu_role_page_tmp B on oc_co_id = convert(int,B.id_own)
												   and B.tipo in ('C','R')
				inner join an_transaction_component on (oc_nemonic = tc_oc_nemonic and tc_co_id = convert(int,B.id_own))
				
		  --from  an_operation_component A,
				--an_transaction_component,  
				--an_label,
				--#an_menu_role_page_tmp B
		  --where la_id       =*  oc_la_id 
			--and (oc_nemonic =  tc_oc_nemonic and tc_co_id = convert(int,B.id_own))
			 --and oc_co_id   =  convert(int,B.id_own)
			 --and B.tipo     in ('C','R')
		--fin migracion fal 05192016         

		 delete an_menu_role_page_tmp where usuario = @s_user

		  if (select count(1) from #an_menu_role_page_tmp where tipo in ('C','R')) > (select count(1) from #tmp_pages_comp_oper)
			 insert into an_menu_role_page_tmp
			 select @s_user,* from #an_menu_role_page_tmp
	   end

	   set rowcount 10
	   
	   select 'INDICE'        = indice,
			  'ID'            = id,
			  'ID ETIQUETA'   = id_etiqueta,
			  'ETIQUETA'      = etiqueta,
			  'ID SUP'        = id_sup,
			  'PROD_NAME'     = prod_name,
			  'TIPO'          = tipo,
			  'ID PROPIO'     = id_own,
			  'VISIBLE'       = visible
	   from an_menu_role_page_tmp
	   where indice  > @i_pa_id
		 and usuario = @s_user
	   order by indice
	end

	/* Eliminar Autorizaciones de Agentes*/
	if @i_operacion = 'E' 
	begin
		--create table #tmp_agentes ( id int identity, agente int )
		--  --Obtencion de Ids de Agentes en el orden que se deben autorizar
		--  select @w_components = @i_components
		--  
		--  select @w_position = CHARINDEX( ';', @w_components)
		--  while @w_position <> 0 and len(@w_components) > 1
		--  begin
		--     insert into #tmp_agentes values(convert(int,LEFT(@w_components, @w_position -1)))
		--     select @w_components = stuff( @w_components, 1, @w_position, null)
		--     select @w_position = CHARINDEX( ';', @w_components )
		--  end
	   --Eliminando Autorizaciones para modulos de Agentes 
	   delete from an_role_module where rm_mo_id in (select distinct co_mo_id
													from cobis..an_component c
													where co_id in (select ag_co_id from cobis..an_agent) 
													and exists	   (select 1 from cobis..an_role_module
																	where rm_rol = @i_rol and rm_mo_id = c.co_mo_id))
									and rm_rol = @i_rol
		if @@error <> 0
			 begin
				select @w_return = 157924  --Existio un error al eliminar los agentes del rol
				goto error
			 end
	   --Eliminando Autorizaciones para modulos dependientes de Agentes que no hayan sido autorizados por menu
	   select co_id from an_component c2 
	   where c2.co_mo_id in ( 
			select md_mo_id from an_module_dependency m where m.md_dependency_id in (select distinct md_dependency_id from an_module_dependency md
																		 where md.md_mo_id in (select co_mo_id from cobis..an_component c
																							   where c.co_id in (select ag_co_id from cobis..an_agent))
																		 and exists(select 1 from cobis..an_role_module r where r.rm_rol = @i_rol and r.rm_mo_id = md.md_dependency_id))
											and m.md_mo_id not in (select distinct md_mo_id from an_module_dependency mdd
																   where mdd.md_mo_id in (select co_mo_id from cobis..an_component c1
																						  where c1.co_id in (select ag_co_id from cobis..an_agent))
																   and exists(select 1 from cobis..an_role_module rm
																			  where rm.rm_rol = @i_rol and rm.rm_mo_id = mdd.md_dependency_id)))
		and c2.co_id in (select pz_co_id from an_page_zone)
		if @@rowcount = 0 
		begin
			delete from an_role_module where rm_mo_id in   (select distinct md_dependency_id
															from an_module_dependency md
															where md.md_mo_id in (select co_mo_id from cobis..an_component c
																			   where co_id in (select ag_co_id from cobis..an_agent))
															and exists(select 1 from cobis..an_role_module rm
																	   where rm.rm_rol = @i_rol and rm.rm_mo_id = md.md_dependency_id))
									   and rm_rol = @i_rol
			if @@error <> 0
			 begin
				select @w_return = 157924  --Existio un error al eliminar los agentes del rol
				goto error
			 end												
		end	
		
		
		
	   --Eliminacion de Autorizacones de Agentes
	   delete an_role_agent where ra_rol = @i_rol
	   if @@error <> 0
	   begin
		select @w_return = 157924  --Existio un error al eliminar los agentes del rol
			goto error
		end
		
		
		select @i_operacion = 'L' --Retornar definiciones actuales
	end

	/* Listar Agentes*/
	if @i_operacion = 'L' 
	begin
	   select ag_id, la_label, 'N' as ag_autorized, convert(int,0) as ag_order
	   into #agentes
	   from an_agent, an_label
	   where ag_la_id      = la_id
		 and upper(la_cod) = @s_culture
	   
	   update #agentes
	   set ag_autorized = 'S',
		   ag_order     = ra_order
	   from an_role_agent
	   where ag_id  = ra_ag_id
		 and ra_rol = @i_rol
	   
	   set rowcount 10
	   
	   select 'ID'         = ag_id, 
			  'ETIQUETA'   = la_label, 
			  'AUTORIZADO' = ag_autorized, 
			  'ORDEN'      = ag_order
	   from #agentes
	   where ag_id > isnull(@i_co_id,0)
	   order by ag_id
	end

	goto FIN
	error:
	   exec cobis..sp_cerror
			@t_debug  = @t_debug,
			@t_file   = @t_file,
			@t_from   = @w_sp_name,
			@i_num    = @w_return,
			@i_msg    = @w_error

	   while @@trancount > 0 rollback --Temporal mientras se revisan todas las transacciones asociadas

	   return @w_return
	FIN:

	go