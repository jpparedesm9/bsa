/************************************************************************/
/*    Archivo:            sp_navigation_zone_dml.sp                     */
/*    Base de datos:      cobis                                         */
/*    Producto:           ADMIN - Seguridades                           */
/*    Disenado por:       Cesar Guevara                                 */
/*    Fecha de escritura: 18-Feb-2010                                   */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    Cobiscorp.                                                        */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de Cobiscorp o su representante.            */
/************************************************************************/
/*                         PROPOSITO                                    */
/*  Este programa procesa las operaciones de Insercion, Modificacion,   */
/*  Eliminacion y Consulta sobre la tabla an_navigation_zone para su    */
/*  administracion desde Admin .NET                                     */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*    FECHA        AUTOR          RAZON                                 */
/*  18/02/2010         Cesar Guevara      Emision Inicia                */
/*  11/01/2012         Sandro Soto        ajustes en query              */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_navigation_zone_dml')
   drop proc sp_navigation_zone_dml
go

create proc sp_navigation_zone_dml (
    @s_ssn             int         = NULL,
    @s_user            login       = NULL,
    @s_sesn            int         = NULL,
    @s_term            varchar(32) = NULL,
    @s_date            datetime    = NULL,
    @s_srv             varchar(30) = NULL,
    @s_lsrv            varchar(30) = NULL, 
    @s_rol             smallint    = NULL,
    @s_ofi             smallint    = NULL,
    @s_org_err         char(1)     = NULL,
    @s_error           int         = NULL,
    @s_sev             tinyint     = NULL,
    @s_msg             descripcion = NULL,
    @s_org             char(1)     = NULL,
    @s_culture         varchar(10) = NULL, --OJO validar posteriormente
    @t_debug           char(1)     = 'N',
    @t_file            varchar(14) = NULL,
    @t_from            varchar(32) = NULL,
    @t_trn             smallint    = NULL,
    @i_operacion       varchar(1),
    @i_modo            smallint    = 0,
    @i_tipo            char(1)     = NULL,
    @i_id              int         = NULL,
    @i_la_id           int         = NULL,
    @i_co_id           int         = NULL,
    @i_name            varchar(40) = NULL,
    @i_icon            varchar(40) = NULL, 
    @i_order           int         = NULL,    
    @o_id              int         = NULL output
)
as
declare
    @w_today        datetime,
    @w_return        int,
    @w_sp_name        varchar(32),
    @w_id            int

select @w_today = @s_date,
       @w_sp_name = 'sp_navigation_zone_dml'

/* Determinacion del ID de Cultura, si no es provisto por el Servidor (Falta Definicion) */
if @s_culture is null
begin 
    select @s_culture = pa_char 
    from cl_parametro
    where pa_nemonico = 'CEAN'
end 

if ((@i_operacion = 'I' and @t_trn != 15377) or 
    (@i_operacion = 'U' and @t_trn != 15378) or
    (@i_operacion = 'D' and @t_trn != 15379) or
    (@i_operacion = 'S' and @t_trn != 15380) or
    (@i_operacion = 'H' and @t_trn != 15381) )
    begin    
        /* Transaccion no permitida */
        exec cobis..sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num     = 151051
        return 1
    end     


/******** INSERCION *******/
if @i_operacion = 'I'
begin
    
    /* Control de existencia de Datos del Label*/
    if not exists (select 1 from an_label
                   where la_id = @i_la_id
                       and la_cod = @s_culture) --OJO Validar posteriormente 
    begin
        /* La Etiqueta no se encuentra registrada en la Cultura*/
        exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 157130
        return 157130
    end
    
    /* Control de existencia de Datos del component*/
    if not exists (select 1 from an_component
                   where co_id = @i_co_id)
    begin
        /*El Componente no esta registrado*/
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num     = 157109
        return 157109
    end

    /* Control de existencia de Componente y Orden de la zona de Navegacion*/
    if exists (select 1 from an_navigation_zone
               where nz_co_id = @i_co_id and nz_order = @i_order)
    begin
        /*Ya existe una zona de navegación con el mismo orden*/
        exec cobis..sp_cerror
             @t_debug    = @t_debug,
             @t_file     = @t_file,
             @t_from     = @w_sp_name,
             @i_num      = 157176
        return 157176
    end
    
    else

        /* Determinacion del id de Zona de Navegacion */
        if @i_id is null
            select @w_id = isnull(max(nz_id),0) + 1
            from an_navigation_zone
             
        else
            select @w_id = @i_id
 
    select @o_id = @w_id

    if not exists (select 1 from an_navigation_zone
                   where nz_id = @w_id)
    begin
        insert into an_navigation_zone(nz_id,nz_la_id,nz_co_id,
                                       nz_name,nz_icon,nz_order)
        values (@w_id,@i_la_id,@i_co_id,@i_name,
                                       @i_icon,@i_order )
    
        if @@error<>0 
        begin
            /*Existio un error al insertar el registro de Zona de Navegacion*/
            exec cobis..sp_cerror
                @t_debug    = @t_debug,
                @t_file     = @t_file,
                @t_from     = @w_sp_name,
                @i_num      = 157177
            return 157177
        end
    end

    else
    begin 
        /* Ya existe un registro de Zona de Navegacion con este codigo*/
        exec cobis..sp_cerror
            @t_debug   = @t_debug,
            @t_file    = @t_file,
            @t_from    = @w_sp_name,
            @i_num     = 157178
        return 157178
    end
    return 0
end   
/******* FIN INSERCION *********/

/******** UPDATE *******/
if @i_operacion = 'U'
begin
    /* Control de existencia de Zona de Navegacion */
    if not exists (select 1    from an_navigation_zone
                    where nz_id = @i_id)
    begin
        /*La Zona Navegacion no esta registrada*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157179
        return 157179
    end

    /* Control de existencia de Datos del Label*/
    if not exists (select 1 from an_label
                   where la_id = @i_la_id
                       and la_cod = @s_culture) --OJO Validar posteriormente
    begin
        /*El Label no esta registrado*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157130
        return 157130
    end

    /* Control de existencia de Datos del Component*/
    if not exists (select 1 from an_component
                   where co_id = @i_co_id)
    begin
        /*El Componente no esta registrado*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157109
        return 157109
    end

    /* Actualizacion de Zona de Navegacion*/
    update an_navigation_zone
    set nz_la_id   = @i_la_id,
        nz_co_id   = @i_co_id,
        nz_name    = @i_name,
        nz_icon    = @i_icon,
        nz_order   = @i_order
    where nz_id = @i_id
       
    if @@error<>0 
    begin
        /*Existio un error al actualizar la Zona de Navegacion*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157180
        return 157180
    end
    return 0
end   
/******* FIN UPDATE *********/


/********* DELETE  ********/
if @i_operacion = 'D'
begin
    /* Control de existencia de Zona de Navegacion */
    if not exists (select 1    from an_navigation_zone
                   where nz_id = @i_id)
    begin
        /*La Zona de Navegacion no esta registrada*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157179
        return 157179
    end

    /* Control de existencia de Datos de Rol de una Zona de Navegacion */
    if  exists (select 1 from an_role_navigation_zone  
                where rn_nz_id = @i_id)
    begin
        /*La Zona de Navegacion se encuentra asociada a un Rol de Zona de Navegacion*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157181
        return 157181
    end

    /* Eliminacion de Zona de Navegacion*/
    delete an_navigation_zone
    where nz_id = @i_id

    if @@error != 0
    begin
        /*Existio un error al eliminar la Zona de Navegacion*/
        exec cobis..sp_cerror
            @t_debug    = @t_debug,
            @t_file     = @t_file,
            @t_from     = @w_sp_name,
            @i_num      = 157182
        return 157182
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
        select 'ID'       = nz_id,
            'ID ETIQUETA' = NZ.nz_la_id,
            'LABEL'       = isnull((select la_label 
                                    from an_label
                                    where la_id = NZ.nz_la_id
                                        and upper(la_cod) = upper(@s_culture)), 'No tiene Etiqueta'),
            'CO ID'       = C.co_id, 
            'COMPONENTE'  = C.co_name,
            'NOMBRE'      = nz_name,
            'ICONO'       = nz_icon,
            'ORDEN'       = nz_order
        from an_navigation_zone NZ,
             an_label L,
             an_component C
        where L.la_id = NZ.nz_la_id 
            and C.co_id = NZ.nz_co_id
            and upper(la_cod) = upper(@s_culture)
        order by nz_co_id,nz_order
    end

    if @i_modo = 1
    begin
        select 'ID'       = nz_id,
            'ID ETIQUETA' = NZ.nz_la_id,
            'LABEL'       = isnull((select la_label 
                                    from an_label
                                    where la_id = NZ.nz_la_id
                                        and upper(la_cod) = upper(@s_culture)), 'No tiene Etiqueta'), 
            'CO ID'       = C.co_id, 
            'COMPONENTE'  = C.co_name,
            'NOMBRE'      = nz_name,
            'ICONO'       = nz_icon,
            'ORDEN'       = nz_order
        from an_navigation_zone NZ,
            an_label L,
            an_component C
        where L.la_id = NZ.nz_la_id 
            and C.co_id = NZ.nz_co_id
            and (NZ.nz_co_id > @i_co_id or (NZ.nz_co_id = @i_co_id and nz_order > @i_order ))
            and upper(la_cod) = upper(@s_culture)
        order by nz_co_id, nz_order
    
        if @@rowcount = 0
        begin
            /*No existen mas registros de Zona de Navegacion*/
            exec sp_cerror
                 @t_debug       = @t_debug,
                 @t_file        = @t_file,
                 @t_from        = @w_sp_name,
                 @i_num         = 157183
            return 157183
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
            select 'ID'       = nz_id,
                'ID ETIQUETA' = NZ.nz_la_id,
                'LABEL'       = isnull((select la_label 
                                        from an_label
                                        where la_id = NZ.nz_la_id
                                            and upper(la_cod) = upper(@s_culture)), 'No tiene Etiqueta'), 
                'COMPONENTE'  = C.co_name,
                'NOMBRE'      = nz_name,
                'ICONO'       = nz_icon,
                'ORDEN'       = nz_order
            from an_navigation_zone NZ,
                an_label L,
                an_component C
            where L.la_id = NZ.nz_la_id
                and C.co_id = NZ.nz_co_id    
            order by nz_co_id,nz_order

            if @@rowcount = 0
            begin
                /*No existen mas registros de Zona de Navegacion*/
                exec sp_cerror
                    @t_debug   = @t_debug,
                    @t_file    = @t_file,
                    @t_from    = @w_sp_name,
                    @i_num     = 157183
                return 157183
            end
        end

        if @i_modo = 1   /* los siguientes 20 */
        begin
            select 'ID'       = nz_id,
                'ID ETIQUETA' = NZ.nz_la_id,
                'LABEL'       = isnull((select la_label 
                                        from an_label
                                        where la_id = NZ.nz_la_id
                                            and upper(la_cod) = upper(@s_culture)), 'No tiene Etiqueta'), 
                'COMPONENTE'  = C.co_name,
                'NOMBRE'      = nz_name,
                'ICONO'       = nz_icon,
                'ORDEN'       = nz_order
            from an_navigation_zone NZ,
                an_label L,
                an_component C
            where L.la_id = NZ.nz_la_id
                and C.co_id = NZ.nz_co_id
                and nz_id > @i_id 
            order by nz_co_id,nz_order

            if @@rowcount = 0
            begin
                /*No existen mas registros de Zona de Navegacion*/
                exec sp_cerror
                    @t_debug    = @t_debug,
                    @t_file     = @t_file,
                    @t_from     = @w_sp_name,
                    @i_num      = 157183
                return 157183
            end
        end
        set rowcount 0
        return 0
    end

    if @i_tipo = 'V'
    begin     
        select nz_id,
            NZ.nz_la_id,
            isnull((select la_label 
                    from an_label
                    where la_id = NZ.nz_la_id
                        and upper(la_cod) = upper(@s_culture)), 'No tiene Etiqueta'), 
            C.co_name,
            nz_name,
            nz_icon,
            nz_order
        from an_navigation_zone NZ,
            an_label L,
            an_component C
        where L.la_id = NZ.nz_la_id 
            and C.co_id = NZ.nz_co_id
            and nz_id > @i_id 
        order by nz_co_id,nz_order
            
        if @@rowcount = 0
        begin
            /* La Zona de Navegacion no se encuentra registrada */
            exec sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 157179
            return 157179
        end
    end
    return 0
end
/********* FIN HELP *********/
go
