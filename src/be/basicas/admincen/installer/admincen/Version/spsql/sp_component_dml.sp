/************************************************************************/
/*  Archivo:            sp_component_dml.sp                             */
/*  Stored procedure:   sp_component_dml                                */
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
/*  y eliminaci=n de la tabla an_component para su utilizaci=n en Admin */
/*  CEN                                                                 */ 
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA       AUTOR         RAZON                                     */
/*  18/02/2010  Cesar Guevara Emision Inicial                           */
/*  26/07/2011  Sandro Soto   Uso de error 157142 en Op. 'S', Modo 1    */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_component_dml')
   drop proc sp_component_dml
go

create proc sp_component_dml (
  @s_ssn          int             = NULL,
  @s_user         login           = NULL,
  @s_sesn         int             = NULL,
  @s_term         varchar(30)     = NULL,
  @s_date         datetime        = NULL,
  @s_srv          varchar(30)     = NULL,
  @s_lsrv         varchar(30)     = NULL, 
  @s_rol          smallint        = NULL,
  @s_ofi          smallint        = NULL,
  @s_org_err      char(1)         = NULL,
  @s_error        int             = NULL,
  @s_sev          tinyint         = NULL,
  @s_msg          descripcion     = NULL,
  @s_org          char(1)         = NULL,
  @t_debug        char(1)         = 'N',
  @t_file         varchar(14)     = NULL,
  @t_from         varchar(32)     = NULL,
  @t_trn          smallint        = NULL,
  @i_operacion    varchar(1),
  @i_modo         smallint        = 0,
  @i_tipo         char(1)         = NULL,
  @i_id           int             = NULL,
  @i_mo_id        int             = NULL,
  @i_name         varchar(255)    = NULL, 
  @i_class        varchar(255)     = NULL,
  @i_namespace    varchar(255)    = NULL, 
  @i_ct_id        char(10)        = NULL, 
  @i_arguments    varchar(255)    = NULL,
  @i_prod_name    varchar(10)     = NULL,  
  @o_id           int             = NULL output
)
as
declare
@w_today    datetime,
@w_return   int,
@w_sp_name  varchar(32),
@w_id       int

select @w_today = @s_date,
       @w_sp_name = 'sp_component_dml'

if ((@i_operacion = 'I' and @t_trn != 15342) or 
    (@i_operacion = 'U' and @t_trn != 15343) or
    (@i_operacion = 'D' and @t_trn != 15344) or
    (@i_operacion = 'S' and @t_trn != 15345) or
    (@i_operacion = 'H' and @t_trn != 15346) )
begin 
   /*'Transaccion no permitida'*/
      exec cobis..sp_cerror
           @t_debug  = @t_debug,
           @t_file   = @t_file,
           @t_from   = @w_sp_name,
           @i_num    = 151051
      return 151051
end   

/******** INSERCION *******/
if @i_operacion = 'I'
begin
    /* Control de existencia de Datos */
    if  not exists (select 1 from an_module M 
                     where M.mo_id = @i_mo_id)
    begin
       /*El Modulo no se encuentra registrado*/
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157117
       return 157117
    end

    /* Control de existencia en catalogo an_component_type */
    if not exists (select 1 from cl_tabla T, cl_catalogo C
                    where T.codigo =  C.tabla
                      and T.tabla    = 'an_component_type'
                      and C.codigo   = @i_ct_id )
     begin
        /*El Tipo de Componente no se encuentra registrado*/
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 157106
        return 157106
    end

    /* Control de existencia en catalogo an_product */
    if not exists (select 1 from cl_tabla T, cl_catalogo C
                    where T.codigo =  C.tabla
                      and T.tabla    = 'an_product'
                      and C.codigo   = @i_prod_name )
     begin
        /* El Producto CEN no se encuentra registrado */
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 157148
        return 157148
    end
  
    /* Determinacion del id de Componente */
    if @i_id is null or @i_id = 0
       select @w_id = isnull(max(co_id),0) + 1 from an_component 
    else
       select @w_id = @i_id

    select @o_id = @w_id

    if not exists (select 1 from an_component where co_id = @w_id)
       begin
          insert into an_component(co_id, co_mo_id, co_name, co_class, co_namespace,
                                   co_ct_id, co_arguments, co_prod_name)
                           values (@w_id, @i_mo_id, @i_name, @i_class, @i_namespace,
                                   @i_ct_id, @i_arguments, @i_prod_name)
    
          /* Error en insercion de Componente */
          if @@error<>0  
             begin
                /* Existio un error al insertar el registro de Componente */
                exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file  = @t_file,
                     @t_from  = @w_sp_name,
                     @i_num   = 157107    
                return 157107
             end          
       end
    else
       begin    
           /* Ya existe un registro de Componente con este codigo */
           exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157108    
            return 157108
       end  
    return 0
end   
/******* FIN INSERCION *********/


/******** UPDATE *******/
if @i_operacion = 'U'
begin
   /* Control de existencia de Datos de modulo */
   if  not exists (select 1 from an_module M 
                    where M.mo_id = @i_mo_id)
       begin
          /* Modulo no se encuentra esta registrado */
          exec cobis..sp_cerror
               @t_debug  = @t_debug,
               @t_file   = @t_file,
               @t_from   = @w_sp_name,
               @i_num    = 157117
          return 157117
       end

   /* Control de existencia de Datos de componente */
   if  not exists (select 1 from an_component  
                    where co_id = @i_id)
       begin
          /*El Componente no se encuentra registrado*/
          exec cobis..sp_cerror
               @t_debug = @t_debug,
               @t_file  = @t_file,
               @t_from  = @w_sp_name,
               @i_num   = 157109
          return 157109
       end

   /* Control de existencia en catalogo an_component_type */
   if not exists (select 1 from cl_tabla T, cl_catalogo C
                   where T.codigo =  C.tabla
                     and T.tabla    = 'an_component_type'
                     and C.codigo   = @i_ct_id )
      begin
         /*El Tipo de Componente no se encuentra registrado*/
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 157106
         return 157106
      end

   /* Control de existencia en catalogo an_product */
   if not exists (select 1 from cl_tabla T, cl_catalogo C
                   where T.codigo =  C.tabla
                     and T.tabla    = 'an_product'
                     and C.codigo   = @i_prod_name )
   begin
       /* El Producto CEN no se encuentra registrado */
       exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 157148
       return 157148
   end
    
   /* Actualizacion de Componente */
   update an_component
      set co_mo_id     = @i_mo_id, 
          co_name      = @i_name,
          co_class     = @i_class, 
          co_namespace = @i_namespace,
          co_ct_id     = @i_ct_id,
          co_arguments = @i_arguments, 
          co_prod_name = @i_prod_name 
    where co_id     = @i_id
      
   if @@error<>0  
      begin
         /*Existio un error al actualizar el Componente*/
         exec cobis..sp_cerror
              @t_debug  = @t_debug,
              @t_file   = @t_file,
              @t_from   = @w_sp_name,
              @i_num    = 157110
          return 157110
      end
   return 0
end   
/******* FIN UPDATE *********/


/********* DELETE  ********/
if @i_operacion = 'D'
   begin
      /* Control de existencia de componente */
      if not exists (select 1 from an_component 
                       where co_id = @i_id)
         begin
            /*El Componente no se encuentra registrado*/
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157109
            return 157109
         end

      /* Verificar que el componente no se encuentra asociado en una Zona de Pagina */
      if  exists (select 1 from an_page_zone  
                    where pz_co_id = @i_id)
         begin
            /*No es posible eliminar, el Componente se encuentra asociado a una Zona de Pagina*/
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157112
            return 157112
         end

      /* Verificar que el componente no se encuentra asociado a una Zona de Navegacion */
      if  exists (select 1 from an_navigation_zone  
                     where nz_co_id = @i_id)
         begin
            /* No es posible eliminar, el Componente se encuentra asociado a una Zona de Navegacion */
            exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157113
            return 157113
         end

      /* Verificar que el componente no se encuentra autorizado a un Rol */
      if  exists (select 1 from an_role_component  
                     where rc_co_id = @i_id)
         begin
            /*No es posible elminar, el Componente se encuentra asociado a un Rol */
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 157114
            return 157114
         end

      /* Eliminacion de Component */
      delete an_component 
       where co_id = @i_id
   
      if @@error != 0
         begin
            /*Existio un error al eliminar el Componente*/
            exec cobis..sp_cerror
                 @t_debug = @t_debug,
                 @t_file  = @t_file,
                 @t_from  = @w_sp_name,
                 @i_num   = 157115
            return 157115
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
         select 'ID'         = co_id,
                'MODULE'     = co_mo_id, 
                'NOMBRE'     = co_name, 
                'CLASE'      = co_class,
                'NAMESPACE'  = co_namespace, 
                'COMPONENTE' = co_ct_id, 
                'ARGUMENTOS' = co_arguments,
                'PRODUCTO'   = co_prod_name 
           from an_component 
          order by co_id

         if @@rowcount = 0               
            begin
               /*No existen registros de Componentes*/
               exec sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 157116
               return 157116
            end
      end

   if @i_modo = 1
      begin
         select 'ID'         = co_id,
                'MODULE'     = co_mo_id, 
                'NOMBRE'     = co_name, 
                'CLASE'      = co_class,
                'NAMESPACE'  = co_namespace, 
                'COMPONENTE' = co_ct_id, 
                'ARGUMENTOS' = co_arguments,
                'PRODUCTO'   = co_prod_name 
           from an_component
          where co_id > @i_id
          order by co_id

         if @@rowcount = 0               
            begin
               /*SSO 26/07/2011, Busqueda de componentes ha finalizado*/
               exec sp_cerror
                    @t_debug  = @t_debug,
                    @t_file   = @t_file,
                    @t_from   = @w_sp_name,
                    @i_num    = 157142
               return 157142
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
               select 'ID'     = co_id,
                      'NOMBRE' = co_name, 
                      'PROD.'  = isnull(co_prod_name, 'Ninguno')
                 from an_component
                order by co_prod_name, co_id

               if @@rowcount = 0               
                  begin
                     /*No existen registros de Componentes*/
                     exec sp_cerror
                          @t_debug  = @t_debug,
                          @t_file   = @t_file,
                          @t_from   = @w_sp_name,
                          @i_num    = 157116
                     return 157116
                  end
            end

         if @i_modo = 1    /* Siguientes 20 */
            begin
               select 'ID'     = co_id,
                      'NOMBRE' = co_name, 
                      'PROD.'  = isnull(co_prod_name, 'Ninguno')
                 from an_component
                where (co_prod_name >= @i_prod_name and co_id > @i_id)
                order by co_prod_name, co_id
/*
               if @@rowcount = 0               
                  begin
                     /*No existen mas registros de Componentes*/
                     exec sp_cerror
                          @t_debug  = @t_debug,
                          @t_file   = @t_file,
                          @t_from   = @w_sp_name,
                          @i_num    = 157116
                     return 157116
                  end
*/
            end
         set rowcount 0
      end

   if @i_tipo = 'V'
      begin
         select co_id, co_name 
           from an_component
          where co_id = @i_id

         if @@rowcount = 0
            begin
               /*El Componente no se encuentra registrado*/
               exec sp_cerror
                    @t_debug = @t_debug,
                    @t_file  = @t_file,
                    @t_from  = @w_sp_name,
                    @i_num   = 157109 
               return 157109
            end
      end
   return 0
end
/********* FIN HELP *********/
go

