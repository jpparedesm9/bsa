/************************************************************************/
/*  Archivo:            sp_role_module_dml.sp                           */
/*  Stored procedure:   sp_role_module_dml                              */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 22-Feb-2010                                     */
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
/*  Este programa procesa las operaciones de Insercion, Eliminacion y   */ 
/*  busqueda sobre la tabla an_role_module para su administracion desde */
/*  Admin .NET                                                          */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/*  22/02/2010  Sandro Soto Emision Inicial                             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_role_module_dml')
   drop proc sp_role_module_dml
go

create proc sp_role_module_dml (
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
    @s_culture       varchar(10)  = NULL, --OJO, falta definicion
	@t_debug        char(1)      = 'N',
	@t_file         varchar(14)  = NULL,
	@t_from         varchar(32)  = NULL,
	@t_trn          smallint     = NULL,
	@i_operacion    varchar(1),
	@i_modo         smallint     = 0,
	@i_tipo         char(1)      = NULL,
	@i_mo_id        int          = NULL,
	@i_rol          tinyint      = NULL,
	@o_id        int             = NULL output
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32),
	@w_id			int

select 	@w_today = @s_date,
	    @w_sp_name = 'sp_role_module_dml'

if ((@i_operacion = 'I' and @t_trn != 15347) or 
    (@i_operacion = 'D' and @t_trn != 15348) or
    (@i_operacion = 'S' and @t_trn != 15349) or
    (@i_operacion = 'H' and @t_trn != 15350) )
	begin	
        /* Transaccion no permitida */
		exec cobis..sp_cerror
	   	@t_debug = @t_debug,
	   	@t_file	 = @t_file,
	   	@t_from	 = @w_sp_name,
	   	@i_num	 = 151051
		return 151051
	end 	

/* Determinacion del ID de Cultura, si no es provisto por el Servidor (Falta Definicion) */
if @s_culture is null
   begin 
      select @s_culture = pa_char 
        from cl_parametro
       where pa_nemonico = 'CEAN'
   end 

/******** INSERCION *******/
if @i_operacion = 'I'
begin
	/* Control de existencia de rol */
	if not exists (select 1	from ad_rol
			        where ro_rol = @i_rol)
	begin
        /* rol no existe */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151026
		return 151026
	end

    /* Control del Modulo */
	if not exists (select 1	from an_module
			        where mo_id = @i_mo_id)
	begin
        /* El módulo no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157117
		return 157117
	end

    insert into an_role_module(rm_mo_id, rm_rol)                              
                       values (@i_mo_id, @i_rol)
		
    /* Existio un error al registrar el modulo para el rol */
    if @@error <> 0 
       begin
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 157138			
          return 157138
       end 
	return 0
end   
/******* FIN INSERCION *********/


/******** DELETE *******/
if @i_operacion = 'D'
begin
	/* Control de existencia de modulo asociado al rol */
	if not exists (select 1	from an_role_module
			        where rm_mo_id  = @i_mo_id
                      and rm_rol = @i_rol)
	begin
        /* El modulo no se encuentra asociado al rol */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157139
		return 157139
	end

     /* Eliminacion del modulo */
    delete an_role_module 
     where rm_mo_id = @i_mo_id
       and rm_rol   = @i_rol

	if @@error != 0
       begin
          /* Existio un error al eliminar la asociacion rol - modulo */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file	 = @t_file,
               @t_from	 = @w_sp_name,
               @i_num	 = 157140
          return 157140
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
        select 'ID'       = mo_id,
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta'),
               'PADRE'    = mo_id_parent
          from an_module, an_role_module
         where rm_mo_id = mo_id
           and rm_rol   = @i_rol
         order by mo_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de modulos asociados al rol */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157141
              return 157141
	       end
	end

	if @i_modo = 1
	begin
        select 'ID'       = mo_id,
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta'),
               'PADRE'    = mo_id_parent
          from an_module, an_role_module
         where rm_mo_id = mo_id
           and rm_rol   = @i_rol
           and rm_mo_id > @i_mo_id
         order by mo_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de modulo asociados al rol */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file		= @t_file,
                   @t_from		= @w_sp_name,
                   @i_num      = 157141
              return 157141
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
        select 'ID'     = mo_id,
               'MODULO' = mo_name
           from an_module, an_role_module
          where mo_id = rm_mo_id
            and rm_rol = @i_rol

         if @@rowcount = 0
            begin
               /* No existen mas registros de asociados al rol */
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 157141
               return 157141
	        end
       end
	if @i_modo = 1
 	   begin
        select 'ID'       = mo_id,
               'MODULO' = mo_name      
           from an_module, an_role_module
          where mo_id = rm_mo_id
            and rm_rol = @i_rol
            and rm_mo_id > @i_mo_id
/*
         if @@rowcount = 0
            begin
               /* No existen mas registros de asociados al rol */
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 157141
               return 157141
	        end
*/
       end
    set rowcount 0
  end
  return 0
end
/********* FIN HELP *********/

go
