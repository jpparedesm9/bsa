/************************************************************************/
/*  Archivo:            sp_label_dml.sp                                 */
/*  Stored procedure:   sp_label_dml                                    */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 11-Feb-2010                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                        PROPOSITO                                     */
/*  Este programa procesa las maneja la definicion de labels para       */
/*  Admin .NET                                                          */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/*  11/02/2010  Sandro Soto Emision Inicial                             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_label_dml')
   drop proc sp_label_dml
go

create proc sp_label_dml (
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
	@i_cultura      varchar(10)  = NULL,
	@i_label        varchar(64) = NULL, 
	@i_prod_name    varchar(10) = NULL,
	@o_id           int         = NULL output  
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_id			int,
    @w_label_cont   int

select 	@w_today = @s_date,
	    @w_sp_name = 'sp_label_dml'

if ((@i_operacion = 'I' and @t_trn != 15332) or 
    (@i_operacion = 'U' and @t_trn != 15333) or
    (@i_operacion = 'D' and @t_trn != 15334) or
    (@i_operacion = 'S' and @t_trn != 15335) or
    (@i_operacion = 'H' and @t_trn != 15336) )
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
      /* Control de existencia de Datos */
      if not exists (select 1 from cl_catalogo C, cl_tabla T
			           where C.tabla = T.codigo
			             and T.tabla = 'an_culture'
			             and C.codigo = @i_cultura)
         begin
            /* La Cultura no se encuentra registrada */   
		    exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file	 = @t_file,
                 @t_from	 = @w_sp_name,
                 @i_num	 = 157127
            return 157127
	     end
 
      /* Control de existencia de product name --> Por implementar hasta saber que es*/

      /* Determinacion del id de label */
      if @i_id is null or @i_id = 0
         select @w_id = isnull(max(la_id),0) + 1
           from an_label
          where la_cod = @i_cultura
      else
         select @w_id = @i_id

      select @o_id = @w_id

      if not exists (select 1 from an_label
                      where la_id = @w_id
                        and la_cod = @i_cultura)
         begin
            insert into an_label(la_id, la_cod, la_label, la_prod_name)
                         values (@w_id, @i_cultura, @i_label, @i_prod_name)

            /* Existio un error al insertar el registro de Etiqueta */
            if @@error <> 0 
               begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file	 = @t_file,
                       @t_from	 = @w_sp_name,
                       @i_num	 = 157128			
                  return 157128
               end
         end
      else
         begin 
            /* Ya existe un registro de Etiqueta con ese codigo para la Cultura correspondiente */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file	 = @t_file,
                 @t_from	 = @w_sp_name,
                 @i_num	 = 157129			
            return 157129
         end
   return 0
end   
/******* FIN INSERCION *********/


/******** UPDATE *******/
if @i_operacion = 'U'
begin
	/* Control de existencia de label en cultura */
	if not exists (select 1	from an_label
			        where la_id = @i_id
			          and la_cod = @i_cultura)
	begin
        /* La Etiqueta no se encuentra registrada*/
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157130
		return 157130
	end

	/* Actualizacion de Label */
	update an_label
       set la_label = @i_label,
           la_prod_name = @i_prod_name
	 where la_id = @i_id
	   and la_cod = @i_cultura
	
	if @@error <> 0 
	begin
	    /* Existio un error en la actualizacion de la Etiqueta */
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 157131
		return 157131
	end
	return 0
end   
/******* FIN UPDATE *********/


/********* DELETE  ********/
if @i_operacion = 'D'
begin
	/* Control de existencia de label */
	if not exists (select 1	from an_label
			        where la_id = @i_id
			          and la_cod = @i_cultura)
	begin
        /* La Etiqueta no se encuentra registrada en la Cultura */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157130
		return 157130
	end 

    /* Validar el uso de la etiqueta en otras tablas, al menos quede una */
    select @w_label_cont = count(1)
      from an_label
     where la_id = @i_id

    /* La Etiqueta se encuentra referenciada en una pagina */
    if exists (select 1 from an_page 
                where pa_la_id = @i_id) and @w_label_cont < 2
	begin
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157132
		return 157132
	end 

    /* La Etiqueta se encuentra referenciada en una zona de pagina */
    if exists (select 1 from an_page_zone 
                where pz_la_id = @i_id) and @w_label_cont < 2
	begin
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157133
		return 157133
	end 

    /* La Etiqueta se encuentra referenciada en una zona de navegacion */      
    if exists (select 1 from an_navigation_zone 
                where nz_la_id = @i_id) and @w_label_cont < 2
	begin
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157134
		return 157134
	end 
    
    /* La Etiqueta se encuentra referenciada en un modulo */
    if exists (select 1 from an_module 
                where mo_la_id = @i_id) and @w_label_cont < 2
	begin
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157135
		return 157135
	end 
      
    /* Eliminacion de Label */
	delete an_label
  	 where la_id = @i_id
	   and la_cod = @i_cultura

	if @@error != 0
       begin
          /* Existio un error al eliminar la Etiqueta */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 157136
          return 157136
       end
    return 0
end  
/********* FIN DELETE *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    set rowcount 20
	if @i_modo = 0
	begin
        select 'ID'          = la_id,
               'ETIQUETA'    = la_label,
               'CULTURA'     = la_cod,
               'DESCRIPCION' = substring(C.valor,1,20),
               'PRODUCTO'    = la_prod_name
          from an_label, cl_catalogo C, cl_tabla T
         where la_cod = C.codigo
           and C.tabla = T.codigo     
           and T.tabla = 'an_culture'
           and (la_id >= @i_id)
         order by la_id,la_cod 

        if @@rowcount = 0
           begin
              /* No existen mas registros de Etiqueta */

              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157137
              return 157137
	       end
	end

	if @i_modo = 1
	begin
        select 'ID'          = la_id,
               'ETIQUETA'    = la_label,
               'CULTURA'     = la_cod,
               'DESCRIPCION' = substring(C.valor,1,20),
               'PRODUCTO'    = la_prod_name
          from an_label, cl_catalogo C, cl_tabla T
         where la_cod = C.codigo
           and C.tabla = T.codigo     
           and T.tabla = 'an_culture'
           and (la_id <= @i_id)
         order by la_id,la_cod

        if @@rowcount = 0
           begin
              /* No existen mas registros de Etiqueta */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157137
              return 157137
	       end
    end

    set rowcount 0
    return 0
end
/********* FIN SEARCH *********/


/********* HELP ***********/
if @i_operacion = 'H'
begin
   if @i_tipo = 'A'
   begin
       set rowcount 20
	   if @i_modo = 0    /* los primeros 20 */
          begin 
	  	     select 'ID'    = la_id,
		            'LABEL' = la_label
                from an_label
                where la_cod =@s_culture
               order by la_id

             if @@rowcount = 0
                begin
                   /* No existen mas registros de Etiqueta */
                   exec sp_cerror
                        @t_debug	= @t_debug,
                        @t_file		= @t_file,
                        @t_from		= @w_sp_name,
                        @i_num      = 157137
                   return 157137
	            end
          end

	   if @i_modo = 1   /* los siguientes 20 */ 
          begin
		     select 'ID'    = la_id,
		            'LABEL' = la_label
               from an_label
	          where la_id > @i_id
              order by la_id

             if @@rowcount = 0
                begin
                   /* No existen mas registros de Etiqueta */
                   exec sp_cerror
                        @t_debug	= @t_debug,
                        @t_file		= @t_file,
                        @t_from		= @w_sp_name,
                        @i_num      = 157137
                   return 157137
	            end
          end
	    set rowcount 0
	    return 0
   end

   if @i_tipo = 'V'
   begin
	  select la_id,la_label
	    from an_label
	   where la_id = @i_id
	   and la_cod =@s_culture
         

	  if @@rowcount = 0
	  begin
         /* La Etiqueta no se encuentra registrada en la Cultura */
		 exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 157130
		 return 157130
	  end
  end
  return 0
end
/********* FIN HELP *********/
go

