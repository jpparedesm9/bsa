/************************************************************************/
/*  Archivo:            sp_role_component_dml.sp                        */
/*  Stored procedure:   sp_role_component_dml                           */
/*  Base de datos:      cobis                                           */
/*  Producto:           ADMIN - Seguridades                             */
/*  Disenado por:       Cesar Guevara                                   */
/*  Fecha de escritura: 18-Feb-2010                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                       PROPOSITO                                      */
/*  Este programa procesa las operaciones de Insercion, Eliminacion     */
/*  y Consulta sobre la tabla an_rol_component para su administracion   */
/*  desde Admin .NET                                                    */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR         RAZON                                     */
/*  18/02/2010  Cesar Guevara Emision Inicial                           */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_role_component_dml')
   drop proc sp_role_component_dml
go

create proc sp_role_component_dml (
  @s_ssn        int         = NULL,
  @s_user       login       = NULL,
  @s_sesn       int         = NULL,
  @s_term       varchar(32) = NULL,
  @s_date       datetime    = NULL,
  @s_srv        varchar(30) = NULL,
  @s_lsrv       varchar(30) = NULL, 
  @s_rol        smallint    = NULL,
  @s_ofi        smallint    = NULL,
  @s_org_err    char(1)     = NULL,
  @s_error      int         = NULL,
  @s_sev        tinyint     = NULL,
  @s_msg        descripcion = NULL,
  @s_org        char(1)     = NULL,
  @t_debug      char(1)     = 'N',
  @t_file       varchar(14) = NULL,
  @t_from       varchar(32) = NULL,
  @t_trn        smallint    = NULL,
  @i_operacion  varchar(1),
  @i_modo       smallint    = 0,
  @i_tipo       char(1)     = NULL,
  @i_co_id      int         = NULL,
  @i_rol        tinyint     = NULL    
)
as
declare
@w_today      datetime,
@w_return     int,
@w_sp_name    varchar(32)

select @w_today = @s_date,
       @w_sp_name = 'sp_role_component_dml'

if ((@i_operacion = 'I' and @t_trn != 15365) or 
    (@i_operacion = 'D' and @t_trn != 15366) or
    (@i_operacion = 'S' and @t_trn != 15367) )
   begin 
      /* Transaccion no permitida */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 151051
      return 151051
   end   


/******** INSERCION *******/
if @i_operacion = 'I'
begin
  /* Control de existencia de rol */
  if not exists (select 1 from ad_rol
                  where ro_rol = @i_rol)
      begin
           /* rol no existe */
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
          @t_from    = @w_sp_name,
          @i_num     = 151026
         return 151026
      end

  /* Control de existencia de Componente */
  if not exists (select 1 from an_component
                  where co_id = @i_co_id)
      begin
           /* El Componente no se encuentra registrado */
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157109
       return 157109
      end
  else
  
  if not exists (select 1 from an_role_component
                  where rc_co_id = @i_co_id 
                    and rc_rol = @i_rol)
     begin
        insert into an_role_component(rc_co_id,rc_rol)
                              values (@i_co_id, @i_rol)
    
        /* Existio un error al autorizar el Componente al Rol */
        if @@error<>0 
           begin
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 157170
              return 157170
           end
     end
  else
     begin 
        /* El Componente ya se encuentra autorizado para el Rol */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 157171
        return 157171
    end
  return 0
end   
/******* FIN INSERCION *********/


/********* DELETE  ********/
if @i_operacion = 'D'
begin
  /* Control de existencia de autorizacion del Componente al Rol*/
  if not exists (select 1 from an_role_component
                  where rc_co_id = @i_co_id
                    and rc_rol = @i_rol)
     begin
        /* El Componente no se encuentra autorizado al Rol */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 157172
        return 157172
     end

     /* Eliminacion de la autorizacion del componente al Rol */
     delete an_role_component
      where rc_co_id = @i_co_id
        and rc_rol = @i_rol  
                
     if @@error != 0
        begin
          /* Existio un error al eliminar la autorizacion del Componente al Rol */
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 157174
          return 157174
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
       select 'ID'      = RC.rc_co_id,
              'NOMBRE'  = C.co_name
        from an_role_component RC,an_component C
        where C.co_id = RC.rc_co_id 
          and rc_rol = @i_rol
        order by rc_co_id
  
       if @@rowcount = 0
          begin
             /* No existen Componentes autorizados al Rol */
             exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file    = @t_file,
                  @t_from    = @w_sp_name,
                  @i_num     = 157175
             return 157175
          end
     end

  if @i_modo = 1
     begin
       select 'ID'     = RC.rc_co_id,
             'NOMBRE'  = C.co_name
        from an_role_component RC,an_component C
        where C.co_id = RC.rc_co_id 
            and rc_co_id > @i_co_id 
            and rc_rol = @i_rol
        order by rc_co_id
 
       if @@rowcount = 0
          begin
             /* No existen mas Componentes autorizados al Rol */
             exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file    = @t_file,
                  @t_from    = @w_sp_name,
                  @i_num     = 157175
             return 157175
          end

     end
     set rowcount 0
     return 0
end
/********* FIN SEARCH *********/
go
