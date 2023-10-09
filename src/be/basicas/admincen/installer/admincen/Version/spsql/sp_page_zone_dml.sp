/************************************************************************/
/*  Archivo:            sp_page_zone_dml.sp                             */
/*  Stored procedure:   sp_page_zone_dml                                */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 26-Feb-2010                                     */
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
/*  Eliminacion y Consulta sobre la tabla an_page_zone para su          */
/*  administracion desde Admin .NET                                     */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/*  26/02/2010  Sandro Soto Emision Inicial                             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_page_zone_dml')
   drop proc sp_page_zone_dml
go

create proc sp_page_zone_dml (
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
	@i_id           int          = NULL,
	@i_pa_id        int          = NULL,
	@i_zo_id        int          = NULL,
	@i_la_id        int          = NULL,
	@i_co_id        int          = NULL,
	@i_order        int          = NULL,
	@i_hor_size     int          = NULL,
	@i_ver_size     int          = NULL,
	@i_icon         varchar(40)  = NULL,
	@i_split_style  varchar(20)  = NULL,
	@i_id_parent    int          = NULL,
	@i_opt_comp     tinyint      = NULL,
	@o_id           int          = NULL output
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_id		    int

select 	@w_today = @s_date,
        @w_sp_name = 'sp_page_zone_dml',
        @s_culture = UPPER(@s_culture)


/* Determinacion del ID de Cultura, si no es provisto por el Servidor (Falta Definicion) */
if @s_culture is null
   begin 
      select @s_culture = pa_char 
        from cl_parametro
       where pa_nemonico = 'CEAN'
   end 

if ((@i_operacion = 'I' and @t_trn != 15360) or 
    (@i_operacion = 'U' and @t_trn != 15361) or
    (@i_operacion = 'D' and @t_trn != 15362) or
    (@i_operacion = 'S' and @t_trn != 15363) or
    (@i_operacion = 'H' and @t_trn != 15364) )
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

	/* Control de existencia de Zona */
	if not exists (select 1	from an_zone
			        where zo_id = @i_zo_id)
	begin
        /* La Zona no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157158
		return 157158
	end

	/* Control de existencia de Componente */
	if not exists (select 1	from an_component
			        where co_id = @i_co_id)
	begin
        /* El componente no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157109
		return 157109
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

    -- Control de @i_split_style

   
	/*
	 /* Control de Zona de Pagina Superior */
    if not exists (select 1	from an_page_zone
			        where pz_id = @i_id_parent)
       and @i_id_parent is not null
	begin
        /* La Zona de Pagina Superior no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157159
		return 157159
	end
   */
   
	 /* Si no tiene padre colocar 0 */
    if @i_id_parent is null
       select @i_id_parent = 0 

    /* Determinacion del id de zona de pagina */
	if @i_id is null
		select @w_id = isnull(max(pz_id),0) + 1
		  from an_page_zone
	else
		select @w_id = @i_id

    select @o_id = @w_id

    if not exists (select * from an_page_zone
                      where pz_id = @w_id)
         begin
            begin tran 
            insert into an_page_zone(pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, 
                                     pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional,pz_he_id)
                             values (@w_id, @i_zo_id, @i_la_id, @i_pa_id, @i_co_id, @i_order, @i_hor_size,
                                     @i_ver_size, @i_icon, @i_split_style, @i_id_parent, @i_opt_comp,0)
			
			/*Actualizacion componentes de Paginas Zonas Padre */

			update an_page_zone set pz_co_id=0 where pz_id in(select pz_id from an_page_zone 
                                                                 where pz_id in(select distinct pz_id_parent 
                                                                   from an_page_zone where pz_pa_id=@i_pa_id  
                                                                      and pz_id_parent <>0))
			/*Actualizacion componentes de Paginas Zonas Padre */

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
            /* Ya existe un registro de Zona de Pagina con ese codigo */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 157163			
            return 157163
         end
	return 0
end   
/******* FIN INSERCION *********/


/******** UPDATE *******/
if @i_operacion = 'U'
begin
    /*
	/* Control de Existencia de zona de pagina */
	if not exists (select 1	from an_page_zone
			        where pz_id = @i_id)
	begin
        /* La Zona de Pagina no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157164
		return 157164
	end
   */
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

	/* Control de existencia de Zona */
	if not exists (select 1	from an_zone
			        where zo_id = @i_zo_id)
	begin
        /* La Zona no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157158
		return 157158
	end

	/* Control de existencia de Componente */
	if not exists (select 1	from an_component
			        where co_id = @i_co_id)
	begin
        /* El componente no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157109
		return 157109
	end

	/* Control de existencia de label */
	if not exists (select 1	from an_label
			        where la_id = @i_la_id
                      and la_cod = @s_culture) --OJO Validar posteriormente
	begin
        /* La Etiqueta no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157130
		return 157130
	end

    -- Control de @i_split_style

    /*
    /* Control de Zona de Pagina Superior */
    if not exists (select 1	from an_page_zone
			        where pz_id = @i_id_parent)
       and @i_id_parent is not null
	begin
        /* La Zona de Pagina Superior no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157159
		return 157159
	end
    */
    /* Si no tiene padre colocar 0 */
    if @i_id_parent is null
       select @i_id_parent = 0 


	/* Actualizacion de la Zona de Pagina */
	update an_page_zone
       set pz_zo_id              = @i_zo_id,
           pz_la_id              = @i_la_id,
           pz_pa_id              = @i_pa_id,
           pz_co_id              = @i_co_id,
           pz_order              = @i_order,
           pz_hor_size           = @i_hor_size,
           pz_ver_size           = @i_ver_size,
           pz_icon               = @i_icon,
           pz_split_style        = @i_split_style,
           pz_id_parent          = @i_id_parent,
           pz_component_optional = @i_opt_comp
	 where pz_id = @i_id

			/*Actualizacion componentes de Paginas Zonas Padre */

			update an_page_zone set pz_co_id=0 where pz_id in(select pz_id from an_page_zone 
                                                                 where pz_id in(select distinct pz_id_parent 
                                                                   from an_page_zone where pz_pa_id=@i_pa_id  
                                                                      and pz_id_parent <>0))
			/*Actualizacion componentes de Paginas Zonas Padre */
	
	if @@error <> 0 
	begin
	    /* Existio un error en la actualizacion de la Zona de Pagina */
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 157165
		return 157165
	end
	return 0
end   
/******* FIN UPDATE *********/


/******** DELETE *******/
if @i_operacion = 'D'
begin
    /* Control de Existencia de zona de pagina */
	if not exists (select 1	from an_page_zone
			        where pz_id = @i_id)
	begin
        /* La Zona de Pagina no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157164
		return 157164
	end
   
    /* Control que no sea una Zona de Pagina Superior a otra */
    if exists (select 1	from an_page_zone
                    where pz_id_parent = @i_id)
	begin
        /* No es posible eliminar pues esta zona de pagina es superior a otra  */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157166
		return 157166
	end

    /* Eliminacion de la zona de pagina */
    delete an_page_zone 
     where pz_id = @i_id

	if @@error != 0
       begin
          /* Existio un error al eliminar la Zona de Pagina */
          print 'Existio un error al eliminar la Zona de Pagina'
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 157167
          return 157167
       end
    return 0
end
/******* FIN DELETE *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    set rowcount 20
	if @i_modo = 0
	begin
        select 'ID'          = PZ.pz_id,
               'ID PAGINA'   = PZ.pz_pa_id,
               'PAGINA'      = P.pa_name,
               'ID ZONA'     = PZ.pz_zo_id,
               'ZONA'        = Z.zo_name,
               'ID ETIQUETA' = PZ.pz_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = PZ.pz_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID COMPON.'  = PZ.pz_co_id,           
               'COMPONENTE'  = C.co_name,
               'ORDEN'       = PZ.pz_order,
               'HOR. SIZE'   = PZ.pz_hor_size,
               'VER. SIZE'   = PZ.pz_ver_size,
               'ICONO'       = PZ.pz_icon,
               'ESTILO DIV.' = PZ.pz_split_style,
               'ID SUP'      = isnull(PZ.pz_id_parent, 0),
               'COMP. OPT.'  = PZ.pz_component_optional
          from an_page_zone PZ, an_page P, an_zone Z, an_component C
         where PZ.pz_pa_id = P.pa_id 
           and PZ.pz_zo_id = Z.zo_id
           and PZ.pz_co_id = C.co_id
           and pz_pa_id=@i_pa_id
         order by PZ.pz_id_parent, PZ.pz_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de Zonas de Pagina */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157168
              return 157168
	       end
	end

	if @i_modo = 1
	begin
        select 'ID'          = PZ.pz_id,
               'ID PAGINA'   = PZ.pz_pa_id,
               'PAGINA'      = P.pa_name,
               'ID ZONA'     = PZ.pz_zo_id,
               'ZONA'        = Z.zo_name,
               'ID ETIQUETA' = PZ.pz_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = PZ.pz_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID COMPON.'  = PZ.pz_co_id,           
               'COMPONENTE'  = C.co_name,
               'ORDEN'       = PZ.pz_order,
               'HOR. SIZE'   = PZ.pz_hor_size,
               'VER. SIZE'   = PZ.pz_ver_size,
               'ICONO'       = PZ.pz_icon,
               'ESTILO DIV.' = PZ.pz_split_style,
               'ID SUP'      = isnull(PZ.pz_id_parent, 0),
               'COMP. OPT.'  = PZ.pz_component_optional
          from an_page_zone PZ, an_page P, an_zone Z, an_component C
         where PZ.pz_pa_id = P.pa_id 
           and PZ.pz_zo_id = Z.zo_id
           and PZ.pz_co_id = C.co_id
          and (PZ.pz_id_parent > @i_id_parent or (PZ.pz_id_parent = @i_id_parent))
          and pz_pa_id=@i_pa_id
         order by PZ.pz_id_parent, PZ.pz_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de Zonas de Paginas */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157168
              return 157168
	       end
	end
    set rowcount 0
    return 0
end
/******* FIN SEARCH *********/

/*
/********* HELP ***********/
if @i_operacion = 'H'
begin
  if @i_tipo = 'A'
  begin
    set rowcount 20
	if @i_modo = 0
 	   begin
         select 'ID'     = pa_id, 
                'NOMBRE' = pa_name
           from an_page
       order by pa_id

         if @@rowcount = 0
            begin
               /* No existen mas registros de Paginas */
               print 'No existen mas registros de Paginas'
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 151121
               return 151121
	        end
       end

	if @i_modo = 1
 	   begin
         select 'ID'     = pa_id, 
                'NOMBRE' = pa_name
           from an_page
          where pa_id > @i_id
       order by pa_id

         if @@rowcount = 0
            begin
               /* No existen mas registros de Paginas */
               print 'No existen mas registros de Paginas'
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 151121
               return 151121
	        end
       end
    set rowcount 0
  end

  if @i_tipo = 'V'
  begin
	 select pa_name
	   from an_page
	  where pa_id = @i_id

	 if @@rowcount = 0
	 begin
         /* La pagina no se encuentra registrada */
         print 'La pagina no se encuentra registrada'
		 exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 151026
		 return 151026
	 end
  end
  return 0
end
/********* FIN HELP *********/
*/

go
