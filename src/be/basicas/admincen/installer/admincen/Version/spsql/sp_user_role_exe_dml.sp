/************************************************************************/
/*  Archivo:            sp_user_role_exe_dml.sp                         */
/*  Stored procedure:   sp_user_role_exe_dml                            */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Sandro Soto                                     */
/*  Fecha de escritura: 03-Mar-2010                                     */
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
/*  Busqueda sobre la tabla an_user_role_exe para su administracion     */
/*  desde Admin .NET                                                    */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA       AUTOR       RAZON                                       */
/*  03/03/2010  Sandro Soto Emision Inicial                             */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_user_role_exe_dml')
   drop proc sp_user_role_exe_dml
go

create proc sp_user_role_exe_dml (
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
    @i_user         varchar(30)  = NULL,
	@i_role         tinyint      = NULL,
	@i_mo_id        int          = NULL
)
as
declare
	@w_today		datetime,
	@w_return		int,
	@w_sp_name		varchar(32)

select 	@w_today = @s_date,
	    @w_sp_name = 'sp_user_role_exe_dml'

if ((@i_operacion = 'I' and @t_trn != 15382) or 
    (@i_operacion = 'D' and @t_trn != 15383) or
    (@i_operacion = 'S' and @t_trn != 15384) or
    (@i_operacion = 'H' and @t_trn != 15385) )
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
	/* Control de existencia de rol para el usuario */
	if not exists (select 1	from ad_usuario_rol
			        where ur_rol = @i_role
                      and ur_login = @i_user)
	begin
        /* rol no existe */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 151016
		return 151016
	end

    /* Control del Modulo */
	if not exists (select 1	from an_module
			        where mo_id = @i_mo_id)
	begin
        /* El modulo no se encuentra registrado */
		exec cobis..sp_cerror
	   		@t_debug = @t_debug,
	   		@t_file	 = @t_file,
	   		@t_from	 = @w_sp_name,
	   		@i_num	 = 157117
		return 157117
	end

    if not exists (select 1 from an_user_role_exe
                      where ur_user  = @i_user
                        and ur_role  = @i_role 
                        and ur_mo_id = @i_mo_id)
       begin
           insert into an_user_role_exe(ur_user, ur_role, ur_mo_id)                              
                                values (@i_user, @i_role, @i_mo_id)
 		
           /* Existio un error al autorizar el modulo para el usuario - rol */
           if @@error <> 0 
              begin
                 exec cobis..sp_cerror
                      @t_debug = @t_debug,
                      @t_file  = @t_file,
                      @t_from  = @w_sp_name,
                       @i_num   = 157199			
                 return 157199
              end 
	       return 0
       end
    else
       begin
           /* El modulo ya se encuentra autorizado al usuario - rol */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157200			
           return 157200
       end
end   
/******* FIN INSERCION *********/


/******** DELETE *******/
if @i_operacion = 'D'
begin
	/* Control de existencia de modulo autorizado al usuario - rol */
	if not exists (select 1	from an_user_role_exe
			        where ur_user  = @i_user
                      and ur_role  = @i_role
                      and ur_mo_id = @i_mo_id)
	   begin
          /* El modulo no se encuentra autorizado al usuario - rol */
		  exec cobis..sp_cerror
	   	  	   @t_debug = @t_debug,
	   		   @t_file	 = @t_file,
 	   		   @t_from	 = @w_sp_name,
	   		   @i_num	 = 157201
		  return 157201
	   end
    else
       begin
          /* Eliminacion del autorizacion modulo con usuario - rol */
          delete an_user_role_exe 
           where ur_user  = @i_user 
             and ur_role  = @i_role
             and ur_mo_id = @i_mo_id
       
          if @@error <> 0
             begin
                /* Existio un error al eliminar la autorizacion del modulo al usuario - rol */
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file	 = @t_file,
                     @t_from	 = @w_sp_name,
                     @i_num	 = 157202
                return 157202
             end
          return 0
       end
end
/******* FIN DELETE *********/


/********* SEARCH ***********/
if @i_operacion = 'S'
begin
    set rowcount 20
	if @i_modo = 0
	begin
        select 'ID'       = mo_id,
               'MODULO'   = mo_name,
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta')
          from an_module, an_user_role_exe
         where ur_mo_id = mo_id
           and ur_role  = @i_role
           and ur_user  = @i_user
         order by mo_id

        if @@rowcount = 0
           begin
              /* No existen mas modulos autorizados al usuario - rol */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157203
              return 157203
	       end
	end

	if @i_modo = 1
	begin
        select 'ID'       = mo_id,
               'MODULO'   = mo_name,
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta')
          from an_module, an_user_role_exe
         where ur_mo_id = mo_id
           and ur_role  = @i_role
           and ur_user  = @i_user
           and ur_mo_id > @i_mo_id
         order by mo_id

        if @@rowcount = 0
           begin
              /* No existen mas registros de modulo autorizados al usuario - rol */
              exec sp_cerror
                   @t_debug	= @t_debug,
                   @t_file	= @t_file,
                   @t_from	= @w_sp_name,
                   @i_num   = 157203
              return 157203
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
        select 'ID'       = mo_id,
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta')
           from an_module, an_user_role_exe
          where mo_id = rm_mo_id
            and rm_rol = @i_rol

         if @@rowcount = 0
            begin
               /* No existen mas registros de autorizados al rol */
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
               'ETIQUETA' = isnull((select la_label
                                      from an_label
                                     where la_id = an_module.mo_la_id
                                       and la_cod = @s_culture), 'No tiene Etiqueta')           
           from an_module, an_user_role_exe
          where mo_id = rm_mo_id
            and rm_rol = @i_rol
            and rm_mo_id > @i_mo_id

         if @@rowcount = 0
            begin
               /* No existen mas registros de autorizados al rol */
               exec sp_cerror
                    @t_debug	= @t_debug,
                    @t_file		= @t_file,
                    @t_from		= @w_sp_name,
                    @i_num      = 157141
               return 157141
	        end
       end
    set rowcount 0
  end
  return 0
end
/********* FIN HELP *********/
*/

go
