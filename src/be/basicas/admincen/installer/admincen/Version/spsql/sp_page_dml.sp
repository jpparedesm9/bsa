/************************************************************************/
/*  Archivo:            sp_page_dml.sp                                  */
/*  Stored procedure:   sp_page_dml                                     */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 23-Feb-2010                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus usuarios    */
/*  sin el debido consentimiento por escrito de la Presidencia          */
/*  Ejecutiva de Cobiscorp o su representante.                          */
/************************************************************************/
/*                       PROPOSITO                                      */
/*  Este programa procesa las operaciones de Insercion, Modificacion,   */
/*  Eliminacion y Consulta sobre la tabla an_page para su administracion*/
/*  desde Admin .NET                                                    */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR           RAZON                                   */
/*  23/02/2010  Sandro Soto     Emision Inicial                         */
/*  09/06/2010  Cesar Guevara   Opcion de busqueda opcion 4 ingresada en*/ 
/*                              la operacion S.                         */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_page_dml')
   drop proc sp_page_dml
go

create proc sp_page_dml (
	        @s_ssn          int          = NULL,
		@s_user         login        = NULL,
		@s_sesn         int          = NULL,
		@s_term         varchar(32)  = NULL,
		@s_date         datetime     = NULL,
		@s_srv          varchar(30)  = NULL,
		@s_lsrv         varchar(30)  = NULL, 
		@s_rol          smallint     = NULL,
		@s_ofi          smallint     = NULL,
		@s_org_err      char(1)      = NULL,
		@s_error        int          = NULL,
		@s_sev          tinyint      = NULL,
		@s_msg          varchar(64)  = NULL,
		@s_org          char(1)      = NULL,
		@t_debug        char(1)      = 'N',
	        @s_culture      varchar(10)  = NULL, --OJO validar posteriormente
		@t_file         varchar(14)  = NULL,
		@t_from         varchar(32)  = NULL,
		@t_trn          smallint     = NULL,
		@i_operacion    varchar(1),
		@i_modo         smallint     = 0,
		@i_tipo         char(1)      = NULL,
		@i_pa_id        int          = NULL,
		@i_la_id        int          = NULL,
		@i_name         varchar(40)  = NULL,
		@i_icon         varchar(40)  = NULL,
		@i_id_parent    int          = NULL,
		@i_order        int          = NULL,
		@i_splitter     varchar(20)  = NULL,
		@i_nemonic      varchar(40)  = NULL,
		@i_prod_name    varchar(10)  = NULL, 
	    @i_arguments    varchar(255) = NULL,
	    @i_co_id        int          = NULL,
		@o_pa_id        int          = NULL output
	)
	as
	declare
		@w_today		datetime,
		@w_return		int,
		@w_sp_name		varchar(32),
		@w_pa_id		int,
	        @w_pz_id                int,
	        @w_counter              int 
	
	
	select 	@w_today = @s_date,
		    @w_sp_name = 'sp_page_dml'
        select @i_co_id=0
	
	select @s_culture=Upper(@s_culture)

	/* Determinacion del ID de Cultura, si no es provisto por el Servidor (Falta Definicion) */
	if @s_culture is null
	   begin 
	      select @s_culture = pa_char 
	        from cl_parametro
	       where pa_nemonico = 'CEAN'
	   end 
	
	if ((@i_operacion = 'I' and @t_trn != 15355) or 
	    (@i_operacion = 'U' and @t_trn != 15356) or
	    (@i_operacion = 'D' and @t_trn != 15357) or
	    (@i_operacion = 'S' and @t_trn != 15358) or
	    (@i_operacion = 'H' and @t_trn != 15359) )
	   begin	
	        /* Transaccion no permitida */
			exec cobis..sp_cerror
		   	@t_debug = @t_debug,
		   	@t_file	 = @t_file,
		   	@t_from	 = @w_sp_name,
		   	@i_num	 = 151051
			return 151051
	   end 	
	
	
	/******** INSERCION *******/
	if @i_operacion = 'I'
	begin
		/* Control de existencia de label */
		if not exists (select 1	from an_label
				        where la_id = @i_la_id
	                      and la_cod = @s_culture) --OJO Validar posteriormente
		begin
	        /* La Etiqueta no se encuentra registrada en la cultura*/
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157130
			return 157130
		end
	
	    /* Control de nombre de pagina no este utilizado */
	    if  exists (select 1 from an_page
				        where pa_name = @i_name)
		begin
	        /* Este nombre de Pagina ya ha sido utilizado */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157173
			return 157173
		end
		
	
	
	    /* Control de numero de pagina zona creadas */
	    select @w_counter=(count(pz_id)) from an_page_zone 
	                                    where pz_pa_id=@i_pa_id
	    if @w_counter > 7
	    	begin
		        /* Este nombre de Pagina ya ha sido utilizado */
				exec cobis..sp_cerror
			   		@t_debug = @t_debug,
			   		@t_file	 = @t_file,
			   		@t_from	 = @w_sp_name,
			   		@i_num	 = 157173
				return 157173
		end
	
	
	    /*Control de Pagina Superior (padre) Eliminado
	    /* Control de Pagina Superior (padre) */
	    if not exists (select 1	from an_page
				        where pa_id = @i_id_parent)
	       and @i_id_parent is not null
		begin
	        /* La Pagina Superior no se encuentra registrada */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157147
			return 157147
		end
	     */
	    /* Control de Orden de la Pagina */
	    if exists (select 1 from an_page 
	                where pa_id_parent = @i_id_parent
	                  and pa_order = @i_order)
	       and @i_order is not null
	       begin
	          /* Ya existe una Pagina con el mismo orden dentro de la Pagina Superior */
		      exec cobis..sp_cerror
		   	       @t_debug = @t_debug,
		   		   @t_file	 = @t_file,
		   		   @t_from	 = @w_sp_name,
		   		   @i_num	 = 157160
			  return 157160    
	       end 
	    else /* Calcular el orden correspondiente */ 
	       begin
	         select @i_order = isnull(max(pa_order), 0) + 1
	           from an_page 
	          where pa_id_parent = @i_id_parent
	       end
	
	    /* Si no tiene padre colocar 0 */
	    if @i_id_parent is null
	       select @i_id_parent = 0 
	
	    /* Control de existencia de product name */
	    if not exists (select 1 from cl_catalogo C, cl_tabla T
				         where C.tabla = T.codigo
				           and T.tabla = 'an_product'
				           and C.codigo = @i_prod_name)
	       begin
	          /* El Producto CEN no se encuentra registrado */   
			  exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file	 = @t_file,
	               @t_from	 = @w_sp_name,
	               @i_num	 = 157148
	          return 157148
		   end
	     
	    /* Control de existencia del componente */
	   if  not exists (select 1 from an_component  
	                    where co_id = @i_co_id)
	       begin
	          /*El Componente no se encuentra registrado*/
	          exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file  = @t_file,
	               @t_from  = @w_sp_name,
	               @i_num   = 157109
	          return 157109
	       end
	
	    /* Determinacion del id de pagina */
		if @i_pa_id is null
			select @w_pa_id = isnull(max(pa_id),0) + 1
			  from an_page
		else
			select @w_pa_id = @i_pa_id
	
	    select @o_pa_id = @w_pa_id
	
	    if not exists (select 1 from an_page
	                      where pa_id = @w_pa_id)
	         begin
	            select @w_pz_id = isnull(max(pz_id),0) + 1
			      from an_page_zone
	
	            begin tran
	            /* Inserta el registro de pagina */
	            insert into an_page(pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
	                                pa_splitter, pa_nemonic, pa_prod_name, pa_arguments,pa_he_id)
	                        values (@w_pa_id, @i_la_id, @i_name, @i_icon, @i_id_parent, @i_order,
	                                @i_splitter, @i_nemonic, @i_prod_name, @i_arguments,0)
	
	            	
	            /* Existio un error al insertar el registro de pagina */
		        if @@error <> 0 
	               begin
	                  exec cobis..sp_cerror
	                       @t_debug = @t_debug,
	                       @t_file  = @t_file,
	                       @t_from  = @w_sp_name,
	                       @i_num   = 157149			
	                  return 157149
	               end 
	
	            /* Inserta el registro de Zona de Pagina por defecto con el mismo label */
	          
	            insert into an_page_zone(pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, 
	                                     pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
	                             values (@w_pz_id, 1, @i_la_id, @w_pa_id, @i_co_id, 1, 100,
	                                     100, null, 'horizontal', 0, 1)
			
	            /* Existio un error al insertar el registro de Zona de Pagina */
		        if @@error <> 0 
	               begin
	                  exec cobis..sp_cerror
	                       @t_debug = @t_debug,
	                       @t_file  = @t_file,
	                       @t_from  = @w_sp_name,
	                       @i_num   = 157162			
	                  return 157162
	               end 
	
	            commit tran
	         end
	    else
	         begin 
	            /* Ya existe un registro de Pagina con ese codigo */
	            exec cobis..sp_cerror
	                 @t_debug = @t_debug,
	                 @t_file  = @t_file,
	                 @t_from  = @w_sp_name,
	                 @i_num   = 157150			
	            return 157150
	         end
		return 0
	end   
	/******* FIN INSERCION *********/
	
	
	/******** UPDATE *******/
	if @i_operacion = 'U'
	begin
		/* Control de existencia de pagina */
		if not exists (select 1	from an_page
				        where pa_id = @i_pa_id)
		begin
	        /* La Pagina no se encuentra registrada */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157151
			return 157151
		end
	
		/* Control de existencia de label */
		if not exists (select 1	from an_label
				        where la_id = @i_la_id
	                      and la_cod = @s_culture) --OJO Validar posteriormente
		begin
	        /* La Etiqueta no se encuentra registrada en la cultura */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157130
			return 157130
		end
	
	    /* Control de nombre de pagina no este utilizado */
	    if  exists (select 1 from an_page
				        where pa_name = @i_name
	                      and pa_id <> @i_pa_id)
		begin
	        /* Este nombre de Pagina ya ha sido utilizado */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157173
			return 157173
		end
	
	    /* Control de Pagina Superior (padre) */
	    if not exists (select 1	from an_page
				        where pa_id = @i_id_parent)
	       and @i_id_parent is not null
		begin
	        /* La Pagina Superior no se encuentra registrada */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157147
			return 157147
		end
	
	    /* Si no tiene padre colocar 0 */
	    if @i_id_parent is null
	       select @i_id_parent = 0 
	
	    /* Control de existencia de product name */
	    if not exists (select 1 from cl_catalogo C, cl_tabla T
				         where C.tabla = T.codigo
				           and T.tabla = 'an_product'
				           and C.codigo = @i_prod_name)
	       begin
	          /* El Producto CEN no se encuentra registrado */   
			  exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file	 = @t_file,
	               @t_from	 = @w_sp_name,
	               @i_num	 = 157148
	          return 157148
		   end
	
		/* Actualizacion de la Pagina */
		update an_page
	       set pa_la_id     = @i_la_id,
	           pa_name      = @i_name,
	           pa_icon      = @i_icon,
	           pa_id_parent = @i_id_parent,
	           pa_order     = @i_order,
	           pa_splitter  = @i_splitter,
	           pa_nemonic   = @i_nemonic,
	           pa_prod_name = @i_prod_name,
	           pa_arguments = @i_arguments
		 where pa_id = @i_pa_id
		
		if @@error <> 0 
		begin
		    /* Existio un error en la actualizacion de la Pagina */
			exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 157152
			return 157152
		end
		return 0
	end   
	/******* FIN UPDATE *********/
	
	
	/******** DELETE *******/
	if @i_operacion = 'D'
	begin
		/* Control de existencia de pagina */
		if not exists (select 1	from an_page
				        where pa_id = @i_pa_id)
		begin
	        /* La Pagina no se encuentra registrada */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157151
			return 157151
		end
	
	    /* Control que no sea una Pagina Superior de otra pagina */
	    if exists (select 1	from an_page
	                    where pa_id_parent = @i_pa_id)
		begin
	        /* No es posible eliminar pues esta pagina es superior a otra pagina */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157153
			return 157153
		end
	
	   /* Control que la pagina no este asociada a un rol */
	   if exists (select 1 from an_role_page
	               where rp_pa_id = @i_pa_id)
	   begin
	        /* No es posible eliminar pues la pagina esta asociada a un rol */
			exec cobis..sp_cerror
		   		@t_debug = @t_debug,
		   		@t_file	 = @t_file,
		   		@t_from	 = @w_sp_name,
		   		@i_num	 = 157154
			return 157154
	   end
	
	   begin tran  
	   /* Eliminacion de la(s) zona(s) de pagina asociadas */
	   delete from an_page_zone
	    where pz_pa_id = @i_pa_id
	
	   if @@error != 0
	       begin
	          /* Existio un error al eliminar las zonas asociadas a la pagina */
	          exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file	 = @t_file,
	               @t_from	 = @w_sp_name,
	               @i_num	 = 157155
	          return 157155
	       end
	
	   /* Eliminacion de la pagina */
	   delete from an_page 
	    where pa_id = @i_pa_id
	
	   if @@error != 0
	       begin
	          /* Existio un error al eliminar la pagina */
	          exec cobis..sp_cerror
	               @t_debug = @t_debug,
	               @t_file	 = @t_file,
	               @t_from	 = @w_sp_name,
	               @i_num	 = 157156
	          return 157156
	       end
	
	   commit tran 
	   return 0
	end
	/******* FIN DELETE *********/
	
	
	/********* SEARCH ***********/
	if @i_operacion = 'S'
	begin	    
	   if @i_modo = 0
	   begin
                set rowcount 15
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = 'ADMIN',
	               'PRODUCTO'    = 'ADMINISTRACION',
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id )
                   and P.pa_id > 0    
	         order by P.pa_id_parent, P.pa_id
			/*
	        if @@rowcount = 0
	           begin
	              /* No existen mas registros de Paginas */
	              exec sp_cerror
	                   @t_debug	= @t_debug,
	                   @t_file	= @t_file,
	                   @t_from	= @w_sp_name,
	                   @i_num   = 157157
	              return 157157
		       end
			*/
             set rowcount 0
	end
	
	if @i_modo = 1
	begin
            set rowcount 15
	    select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = 'ADMIN',
	               'PRODUCTO'    = 'ADMINISTRACION',
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id )
	         where (P.pa_id_parent > @i_id_parent or (P.pa_id_parent = @i_id_parent and P.pa_id > @i_pa_id ))
                   and P.pa_id > 0
	         order by P.pa_id_parent, P.pa_id
	        /*
	        if @@rowcount = 0
	           begin
	              /* No existen mas registros de Paginas */
	              exec sp_cerror
	                   @t_debug	= @t_debug,
	                   @t_file	= @t_file,
	                   @t_from	= @w_sp_name,
	                   @i_num   = 157157
	              return 157157
		       end
			*/
                set rowcount 0
	end
        set rowcount 20
	    
	    if @i_modo = 2
		begin
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = C.codigo,
	               'PRODUCTO'    = C.valor,
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id ),
	               cl_tabla T, cl_catalogo C
	         where T.codigo = C.tabla
	           and T.tabla = 'an_product'
	           and C.codigo = P.pa_prod_name
			   and P.pa_id_parent=0	   
	         order by P.pa_id,P.pa_id_parent 
	
	        /*if @@rowcount = 0
	           begin
	              /* No existen mas registros de Paginas */
	              exec sp_cerror
	                   @t_debug	= @t_debug,
	                   @t_file	= @t_file,
	                   @t_from	= @w_sp_name,
	                   @i_num   = 157157
	              return 157157
		       end*/
		end
		
		if @i_modo = 3
		begin
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = 'ADMIN',
	               'PRODUCTO'    = 'ADMINISTRACION',
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id )
	         where P.pa_id > @i_pa_id
			   and P.pa_id_parent<>0	 
	         order by P.pa_id_parent,P.pa_id
	
	        /*if @@rowcount = 0
	           begin
	              /* No existen mas registros de Paginas */
	              exec sp_cerror
	                   @t_debug	= @t_debug,
	                   @t_file	= @t_file,
	                   @t_from	= @w_sp_name,
	                   @i_num   = 157157
	              return 157157
		       end*/
		end
	/* Opcion de busqueda opcion 4*/
	if @i_modo = 4
		begin
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = 'ADMIN',
	               'PRODUCTO'    = 'ADMINISTRACION',
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id )
	         where P.pa_id = @i_pa_id
	         order by P.pa_id,P.pa_id_parent
	
	        /*if @@rowcount = 0
	           begin
	              /* No existen mas registros de Paginas */
	              exec sp_cerror
	                   @t_debug	= @t_debug,
	                   @t_file	= @t_file,
	                   @t_from	= @w_sp_name,
	                   @i_num   = 157157
	              return 157157
		       end*/
		end
	
	
	if @i_modo = 5
			begin
		        select 'ID'          = P.pa_id,
			       'ID ETIQUETA' = P.pa_la_id,
			       'ETIQUETA'    = isnull((select la_label 
			                                   from an_label
				                             where la_id = P.pa_la_id
				                               and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
				'NOMBRE'      = P.pa_name,           
				'ID SUP'      = isnull(P.pa_id_parent, 0), 
				'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
				'ICONO'       = P.pa_icon,
				'ORDEN'       = P.pa_order,
				'DIVISOR'     = P.pa_splitter,
				'NEMONICO'    = P.pa_nemonic,
		               'COD. PROD.'  = 'ADMIN',
		               'PRODUCTO'    = 'ADMINISTRACION',
				'ARGUMENTOS'  = P.pa_arguments  
		          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id )
			    where P.pa_id_parent=@i_id_parent	 
	                     order by P.pa_id_parent,P.pa_id
		
		        /*if @@rowcount = 0
		           begin
		              /* No existen mas registros de Paginas */
		              exec sp_cerror
		                   @t_debug	= @t_debug,
		                   @t_file	= @t_file,
		                   @t_from	= @w_sp_name,
		                   @i_num   = 157157
		              return 157157
			       end*/
		end
	
	
		set rowcount 0
	    return 0
	end
	/******* FIN SEARCH *********/
	
	
	/********* HELP ***********/
	if @i_operacion = 'H'
	begin
	  if @i_tipo = 'A'
	  begin
	    set rowcount 20
		if @i_modo = 0
	 	   begin
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = C.codigo,
	               'PRODUCTO'    = C.valor,
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id ),
	               cl_tabla T, cl_catalogo C
	         where T.codigo = C.tabla
	           and T.tabla = 'an_product'
	           and C.codigo = P.pa_prod_name   
                   and P.pa_id > 0
	         order by P.pa_prod_name, P.pa_id_parent, P.pa_id
	        /*
	         if @@rowcount = 0
	            begin
	               /* No existen mas registros de Paginas */
	               exec sp_cerror
	                    @t_debug	= @t_debug,
	                    @t_file		= @t_file,
	                    @t_from		= @w_sp_name,
	                    @i_num      = 157157
	               return 157157
		        end
		        */
	       end
	
		if @i_modo = 1
	 	   begin
	        select 'ID'          = P.pa_id,
	               'ID ETIQUETA' = P.pa_la_id,
	               'ETIQUETA'    = isnull((select la_label 
	                                         from an_label
	                                        where la_id = P.pa_la_id
	                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
	               'NOMBRE'      = P.pa_name,           
	               'ID SUP'      = isnull(P.pa_id_parent, 0), 
	               'SUPERIOR'    = isnull(S.pa_name,'No tiene Superior'), 
	               'ICONO'       = P.pa_icon,
	               'ORDEN'       = P.pa_order,
	               'DIVISOR'     = P.pa_splitter,
	               'NEMONICO'    = P.pa_nemonic,
	               'COD. PROD.'  = C.codigo,
	               'PRODUCTO'    = C.valor,
	               'ARGUMENTOS'  = P.pa_arguments  
	          from an_page P left outer join an_page S on (P.pa_id_parent = S.pa_id ),
	               cl_tabla T, cl_catalogo C
	         where T.codigo = C.tabla
	           and T.tabla = 'an_product'
	           and C.codigo = P.pa_prod_name   
                   and P.pa_id > 0
	           and ( (P.pa_prod_name > @i_prod_name) or
	                 (P.pa_prod_name = @i_prod_name and P.pa_id_parent > @i_id_parent) or
	                 (P.pa_prod_name = @i_prod_name and P.pa_id_parent = @i_id_parent and P.pa_id > @i_pa_id ))
	         order by P.pa_prod_name, P.pa_id_parent, P.pa_id
			/*
	         if @@rowcount = 0
	            begin
	               /* No existen mas registros de Paginas */
	               exec sp_cerror
	                    @t_debug	= @t_debug,
	                    @t_file		= @t_file,
	                    @t_from		= @w_sp_name,
	                    @i_num      = 157157
	               return 157157
		        end
		        */
	       end
	    set rowcount 0
	  end
	
	  if @i_tipo = 'V'
	  begin
		 select pa_id, L.la_label
		 	   from an_page P,an_label L
		 	  where L.la_id = P.pa_la_id
			and  P.pa_id = @i_pa_id
	     /*
		 if @@rowcount = 0
		 begin
	         /* La pagina no se encuentra registrada */
			 exec sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 157157
			 return 157157
		 end
		 */
	  end
	  return 0
	end
	
	/********* FIN HELP *********/
go

