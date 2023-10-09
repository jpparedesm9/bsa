/************************************************************************/
/*  Archivo:            sp_module_dml.sp                                */
/*  Stored procedure:   sp_module_dml                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 18-Feb-2010                                     */
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
/*  Este programa procesa las operaciones sobre la tabla an_module para */
/*  su administracion desde Admin .NET                                  */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/*  18/02/2010  Sandro Soto Emision Inicial                             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_module_dml')
   drop proc sp_module_dml
go

create proc sp_module_dml (
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
	@i_mg_id        int          = NULL,
	@i_la_id        int          = NULL,
	@i_name         varchar(40)  = NULL,
	@i_filename     varchar(255) = '',
	@i_id_parent    int          = 0,
	@i_key_token    varchar(255) = NULL,
	@o_id           int          = NULL output
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_id			int

select 	@w_today = @s_date,
        @w_sp_name = 'sp_module_dml',
        @s_culture = UPPER(@s_culture)


/* Determinacion del ID de Cultura, si no es provisto por el Servidor (Falta Definicion) */
if @s_culture is null
   begin 
      select @s_culture = pa_char 
        from cl_parametro
       where pa_nemonico = 'CEAN'
   end 

if ((@i_operacion = 'I' and @t_trn != 15337) or 
    (@i_operacion = 'U' and @t_trn != 15338) or
    (@i_operacion = 'D' and @t_trn != 15339) or
    (@i_operacion = 'S' and @t_trn != 15340) or
    (@i_operacion = 'H' and @t_trn != 15341) )
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
                      and la_cod = @s_culture) --Validar posteriormente
	begin
        /* La Etiqueta no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157130
		return 157130
	end

    /* Control del Module Group */
	if not exists (select 1	from an_module_group
			        where mg_id = @i_mg_id)
	begin
        /* El Grupo de Modulos no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157101
		return 157101
	end

    
    /* Control de padre cero
    /* Control de Parent Module */
    if not exists (select 1	from an_module
			        where mo_id = @i_id_parent)
       and @i_id_parent is not null
	begin
        /* El Modulo Padre no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157118
		return 157118
	end
    */
    if @i_id_parent is null 
       select @i_id_parent = 0

    /* Determinacion del id de module */
	if @i_id is null or @i_id = 0
		select @w_id = isnull(max(mo_id),0) + 1
		  from an_module
	else
		select @w_id = @i_id

    select @o_id = @w_id


    if not exists (select 1 from an_module
                      where mo_id = @w_id)
         begin
            insert into an_module(mo_id, mo_mg_id, mo_la_id, mo_name,
                                  mo_filename, mo_id_parent, mo_key_token)
                          values (@w_id, @i_mg_id, @i_la_id, @i_name,
                                  @i_filename, @i_id_parent, @i_key_token)
		
            /* Existio un error al insertar el registro de modulo */
	        if @@error <> 0 
               begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 157119			
                  return 157119
               end 
         end
    else
         begin 
            /* Ya existe un registro de M=dulo con ese codigo */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 157120			
            return 157120
         end
	return 0
end   
/******* FIN INSERCION *********/


/******** UPDATE *******/
if @i_operacion = 'U'
begin
	/* Control de existencia de modulo */
	if not exists (select 1	from an_module
			        where mo_id = @i_id)
	begin
        /* El m=dulo no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157117
		return 157117
	end

    /* Control del Module Group */
	if not exists (select 1	from an_module_group
			        where mg_id = @i_mg_id)
	begin
        /* El Grupo de Modulos no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157101
		return 157101
	end

    /* Control de Parent Module */
    if @i_id = @i_id_parent
	begin
        /* El codigo del Modulo Padre no puede ser el mismo que el del modulo */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157121
		return 157121
	end

    /* Control de Parent Module 
    if not exists (select 1	from an_module
			        where mo_id = @i_id_parent)
       and @i_id_parent is not null
	begin
        /* El Modulo Padre no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157118
		return 157118
	end
	*/
    if @i_id_parent is null 
       select @i_id_parent = 0

	/* Control de existencia de etiqueta */
	if not exists (select 1	from an_label
			        where la_id = @i_la_id
                      and la_cod = @s_culture)  --OJO Validar Posteriormente
	begin
        /* La Etiqueta no se encuentra registrada */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157130
		return 157130
	end

	/* Actualizacion de Modulo */
	update an_module
       set mo_mg_id     = @i_mg_id,
           mo_la_id     = @i_la_id,
           mo_name      = @i_name,
           mo_filename  = @i_filename,
           mo_id_parent = @i_id_parent,
           mo_key_token = @i_key_token
	 where mo_id = @i_id
	
	if @@error <> 0 
	begin
	    /* Existio un error en la actualizacion del Modulo */
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 157122
		return 157122
	end
	return 0
end   
/******* FIN UPDATE *********/


/******** DELETE *******/
if @i_operacion = 'D'
begin
    /* Control de existencia de modulo */
    if not exists (select 1	from an_module
                    where mo_id = @i_id)
	begin
        /* El m=dulo no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157117
		return 157117
	end

    /* Control que no sea un Modulo Padre de otro modulo */
    if exists (select 1	from an_module
                    where mo_id_parent = @i_id)
	begin
        /* No es posible eliminar pues el m=dulo es padre de otro m=dulo */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157123
		return 157123
	end

   /* Control que el modulo no este asociado a un rol */
   if exists (select 1 from an_role_module
               where rm_mo_id = @i_id)
   begin
        /* No es posible eliminar pues el modulo esta asociado a un rol */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157124
		return 157124
   end

    /* Eliminacion del modulo */
    delete an_module 
     where mo_id = @i_id

	if @@error != 0
       begin
          /* Existio un error al eliminar el modulo */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 157125
          return 157125
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
        select 'ID'          = M.mo_id,
               'ID ETIQUETA' = M.mo_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = M.mo_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID GRUPO'    = M.mo_mg_id,
               'GRUPO'       = G.mg_name,
               'NOMBRE'      = M.mo_name,
               'ID PADRE'    = isnull(P.mo_id, 0),
               'PADRE'       = isnull(P.mo_name, ''),
               'ARCHIVO'     = M.mo_filename,
               'KEY TOKEN'   = M.mo_key_token
          from an_module M
               left outer join an_module P on (M.mo_id_parent = P.mo_id ),
               an_module_group G 
         where M.mo_mg_id = G.mg_id
         order by M.mo_mg_id, M.mo_id


        if @@rowcount = 0
           begin
              /* No existen mas registros de Modulos */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file		= @t_file,
                   @t_from		= @w_sp_name,
                   @i_num      = 157126
              return 157126
	       end
	end

	if @i_modo = 1
	begin
        select 'ID'          = M.mo_id,
               'ID ETIQUETA' = M.mo_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = M.mo_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID GRUPO'    = M.mo_mg_id,
               'GRUPO'       = G.mg_name,
               'NOMBRE'      = M.mo_name,
               'ID PADRE'    = isnull(P.mo_id, 0),
               'PADRE'       = isnull(P.mo_name, ''),
               'ARCHIVO'     = M.mo_filename,
               'KEY TOKEN'   = M.mo_key_token
          from an_module M
               left outer join an_module P on (M.mo_id_parent = P.mo_id ),
               an_module_group G 
         where M.mo_mg_id = G.mg_id
           and (M.mo_mg_id > @i_mg_id or (M.mo_mg_id = @i_mg_id and M.mo_id > @i_id ))
         order by M.mo_mg_id, M.mo_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de Modulos */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file		= @t_file,
                   @t_from		= @w_sp_name,
                   @i_num      = 157126
              return 157126
	       end
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
        select 'ID'          = M.mo_id,
               'ID ETIQUETA' = M.mo_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = M.mo_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID GRUPO'    = M.mo_mg_id,
               'GRUPO'       = G.mg_name,
               'NOMBRE'      = M.mo_name,
               'ID PADRE'    = isnull(P.mo_id, 0),
               'PADRE'       = isnull(P.mo_name, ''),
               'ARCHIVO'     = M.mo_filename,
               'KEY TOKEN'   = M.mo_key_token
          from an_module M
               left outer join an_module P on (M.mo_id_parent = P.mo_id ),
               an_module_group G 
         where M.mo_mg_id = G.mg_id
         order by M.mo_mg_id, P.mo_id, M.mo_id

         if @@rowcount = 0
            begin
               /* No existen mas registros de Modulos */
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 157126
               return 157126
	        end
       end

	if @i_modo = 1
 	   begin
        select 'ID'          = M.mo_id,
               'ID ETIQUETA' = M.mo_la_id,
               'ETIQUETA'    = isnull((select la_label 
                                         from an_label
                                        where la_id = M.mo_la_id
                                          and la_cod = @s_culture), 'No tiene Etiqueta'),  --OJO Validar posteriormente
               'ID GRUPO'    = M.mo_mg_id,
               'GRUPO'       = G.mg_name,
               'NOMBRE'      = M.mo_name,
               'ID PADRE'    = isnull(P.mo_id, 0),
               'PADRE'       = isnull(P.mo_name,''), 
               'ARCHIVO'     = M.mo_filename,
               'KEY TOKEN'   = M.mo_key_token
          from an_module M
               left outer join an_module P on (M.mo_id_parent = P.mo_id ),
               an_module_group G 
         where M.mo_mg_id = G.mg_id
           and ( M.mo_mg_id > @i_mg_id or 
                (M.mo_mg_id = @i_mg_id and P.mo_id > @i_id_parent) or 
                (M.mo_mg_id = @i_mg_id and P.mo_id = @i_id_parent and M.mo_id > @i_id ))
         order by M.mo_mg_id, P.mo_id, M.mo_id

         if @@rowcount = 0
            begin
               /* No existen mas registros de Modulos */
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 157126
               return 157126
	        end
       end
    set rowcount 0
  end

  if @i_tipo = 'V'
  begin
	 select mo_id, mo_name
	   from an_module
	  where mo_id = @i_id

	 if @@rowcount = 0
	 begin
         /* El modulo no se encuentra registrado */
         print 'El modulo no se encuentra registrado'
		 exec sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 157117
		 return 157117
	 end
  end
  return 0
end
/********* FIN HELP *********/

go
