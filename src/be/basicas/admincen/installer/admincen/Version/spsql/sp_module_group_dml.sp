/************************************************************************/
/*  Archivo:            sp_module_group_dml.sp                          */
/*  Stored procedure:   sp_module_group_dml                             */
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
/*  Este programa realiza las tareas de ingreso,busqueda, modificacion  */
/*  y eliminaci=n de la tabla an_module_group para su utilizaci=n en    */
/*  Admin CEN                                                           */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR         RAZON                                     */
/*  18/02/2010  Cesar Guevara Emision Inicial                           */
/*  07/06/2010  Sandro Soto   Inclusion de campo an_store_name          */
/*  29/11/2010  Cesar Guevara Se agregó Store Name en las busquedas 'S' */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_module_group_dml')
   drop proc sp_module_group_dml
go

create proc sp_module_group_dml (
  @s_ssn         int             = NULL,
  @s_user        login           = NULL,
  @s_sesn        int             = NULL,
  @s_term        varchar(32)     = NULL,
  @s_date        datetime        = NULL,
  @s_srv         varchar(30)     = NULL,
  @s_lsrv        varchar(30)     = NULL, 
  @s_rol         smallint        = NULL,
  @s_ofi         smallint        = NULL,
  @s_org_err     char(1)         = NULL,
  @s_error       int             = NULL,
  @s_sev         tinyint         = NULL,
  @s_msg         descripcion     = NULL,
  @s_org         char(1)         = NULL,
  @t_debug       char(1)         = 'N',
  @t_file        varchar(14)     = NULL,
  @t_from        varchar(32)     = NULL,
  @t_trn         smallint        = NULL,
  @i_operacion   varchar(1),
  @i_modo        smallint        = 0,
  @i_tipo        char(1)         = NULL,
  @i_id          int             = NULL,
  @i_name        varchar(64)     = NULL,
  @i_version     varchar(15)     = NULL,
  @i_location    varchar(255)    = NULL,
  @i_store_name  varchar(40)     = NULL, --CGU Compo nuevo de tabla stored Name 
  @o_id          int             = NULL output
)
as
declare
@w_today    datetime,
@w_return   int,
@w_sp_name  varchar(32),
@w_id       int

select  @w_today = @s_date,
      @w_sp_name = 'sp_module_group_dml'

if ((@i_operacion = 'I' and @t_trn != 15327) or 
    (@i_operacion = 'U' and @t_trn != 15328) or
    (@i_operacion = 'D' and @t_trn != 15329) or
    (@i_operacion = 'S' and @t_trn != 15330) or
    (@i_operacion = 'H' and @t_trn != 15331) )
begin 
/*'Transaccion no permitida'*/
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
    /* Determinacion del id de module group */
    if @i_id is null or @i_id = 0
        select @w_id = isnull(max(mg_id),0) + 1
            from an_module_group
     
    else
    select @w_id = @i_id

       select @o_id = @w_id

     if not exists (select 1 from an_module_group
                       where mg_id = @w_id)
        begin
            insert into an_module_group(mg_id, mg_name, 
                                        mg_version,mg_location, mg_store_name)
                                values (@w_id, @i_name, 
                                        @i_version,@i_location, @i_store_name)
            /*Existio un error al insertar el registro de Grupo de Modulos*/
            if @@error<>0 
               begin
                  exec cobis..sp_cerror
                       @t_debug = @t_debug,
                       @t_file  = @t_file,
                       @t_from  = @w_sp_name,
                       @i_num   = 157099    
                  return 157099
               end
        end
     else
        begin
        /*Ya existe un registro de Grupo de Modulos con este codigo*/
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 157100     
          return 157100
       end
  return 0
end   
/******* FIN INSERCION *********/
/******** UPDATE *******/
if @i_operacion = 'U'
   begin
       /* Control de existencia de module group */
       if not exists (select 1 from an_module_group
                         where mg_id = @i_id)
          begin
           /*El Grupo de Modulos no se encuentra registrado*/
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 157101
            return 157101
          end
  
       /* Actualizacion de Module group */
       update an_module_group
            set mg_name       = @i_name,
                mg_version    = @i_version,
                mg_location   = @i_location, 
                mg_store_name = @i_store_name
          where mg_id = @i_id
       if @@error<>0 
          begin
            /*Existio un error al actualizar el Grupo de Modulos*/
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 157102
            return 157102
          end
  return 0
end   
/******* FIN UPDATE *********/


/********* DELETE  ********/
if @i_operacion = 'D'
begin
  /* Control de existencia de Module Group */
  if not exists (select 1 from an_module_group
                     where mg_id = @i_id)
      begin
        /*El Grupo de Modulos no esta registrado*/
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 157101
        return 157101
     end
/* Control de existencia de Datos de asignados en un Modulo */
if  exists (select 1 from an_module  
              where mo_mg_id = @i_id)
    begin
       /*No es posible eliminar, existen Modulos asociados al Grupo de Modulos*/
       exec cobis..sp_cerror
               @t_debug   = @t_debug,
               @t_file    = @t_file,
               @t_from    = @w_sp_name,
               @i_num     = 157103
       return 157103
    end

    /* Eliminacion de Module Group */
    delete an_module_group
         where mg_id = @i_id

    if @@error != 0
        begin
           /*Existio un error en la eliminacion de Grupo de Modulos*/
           exec cobis..sp_cerror
                @t_debug  = @t_debug,
                @t_file   = @t_file,
                @t_from   = @w_sp_name,
                @i_num    = 157104
           return 157104
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
        select 'ID'      = mg_id,
               'NOMBRE'  = mg_name,
               'VERSION' = mg_version,
               'URL'     = mg_location,
               'STORED'  = mg_store_name
           from an_module_group
          order by mg_id
        
        if @@rowcount = 0
           begin
             /*No existen mas registros de Grupo de Modulos*/
             exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 157105
             return 157105
           end     
      end

   if @i_modo = 1
      begin
        select 'ID'      = mg_id,
               'NOMBRE'  = mg_name,
               'VERSION' = mg_version,
               'URL'     = mg_location,
               'STORED'  = mg_store_name
           from an_module_group
           where mg_id > @i_id
          order by mg_id
      
        if @@rowcount = 0
           begin
             /*No existen mas registros de Grupo de Modulos*/
             exec sp_cerror
                  @t_debug = @t_debug,
                  @t_file  = @t_file,
                  @t_from  = @w_sp_name,
                  @i_num   = 157105
             return 157105
           end
           
      end
      set rowcount 0
  return 0
end
/********* FIN SEARCH *********/

/********* HELP ***********/
if @i_operacion = 'H'
begin
   set rowcount 20
   if @i_tipo = 'A'
      begin
        if @i_modo = 0    /* los primeros 20 */
           begin
              select 'ID'      = mg_id,
                     'NOMBRE'  = mg_name           
                  from an_module_group
                  order by mg_id
            
              if @@rowcount = 0
                 begin
                   /*No existen mas registros de Grupo de Modulos*/
                   exec sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 157105
                   return 157105
                 end
           end   
           if @i_modo = 1   /* los siguientes 20 */
              begin
                  select 'ID'     = mg_id,
                         'NOMBRE' = mg_name        
                     from an_module_group
                     where mg_id > @i_id   
                     order by mg_id 

                  if @@rowcount = 0
                     begin
                       /*No existen mas registros de Grupo de Modulos*/
                       exec sp_cerror
                            @t_debug = @t_debug,
                            @t_file  = @t_file,
                            @t_from  = @w_sp_name,
                            @i_num   = 157105
                       return 157105
                     end
               end
           set rowcount 0
      end
             
   if @i_tipo = 'V'
      begin
         select mg_id, mg_name       
              from an_module_group
              where mg_id  = @i_id
         if @@rowcount = 0
            begin
              /*El Grupo de Modulos no esta registrado*/
              exec cobis..sp_cerror
                   @t_debug = @t_debug,
                   @t_file  = @t_file,
                   @t_from  = @w_sp_name,
                   @i_num   = 157101
              return 157101
            end
      end
   return 0
end
/********* FIN HELP *********/
go

