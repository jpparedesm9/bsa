/************************************************************************/
/*                                                                      */
/*    Archivo:              sp_authorized_zone.sp                       */
/*    Stored procedure:     sp_authorized_zone                          */
/*    Base de datos:        cobis                                       */
/*    Producto:             COBIS Explorer . Net                        */
/*                                                                      */
/************************************************************************/
/*                IMPORTANTE                                            */
/*    Este programa es parte de los paquetes bancarios propiedad de     */
/*    'MACOSA'.                                                         */
/*    Su uso no autorizado queda expresamente prohibido asi como        */
/*    cualquier alteracion o agregado hecho por alguno de sus           */
/*    usuarios sin el debido consentimiento por escrito de la           */
/*    Presidencia Ejecutiva de MACOSA o su representante.               */
/************************************************************************/
/*                                                                      */
/*                PROPOSITO                                             */
/*   Este sp consulta todas las zonas de p ginas autorizadas            */
/*        para un rol determinado                                       */
/*                                                                      */
/************************************************************************/
/*            MODIFICACIONES                                            */
/*    FECHA        AUTOR        RAZON                                   */
/*    3-jun-2010      S. Paredes      Cambiar pz_zo_id por pz_id        */
/*    28-jul-2010     B. Cuenca       Se a¤adio los @s, parametro       */
/*                                    @i_pa_id y se a¤ade tipo'H'       */
/*    22-Dec-2010     B. Cuenca       Se hace las consultas por @s_rol  */
/*    04/Nov/2013     M.Cabay         Ingreso @w_servername para Distrib*/
/*                                    por branch                        */
/*    15/Abr/2016     BBO             Migracion SYB-SQL FAL             */
/************************************************************************/

use cobis
go

/************************************************************************/
/*   Elimina el procedimiento almacenado sp_authorized_zone             */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_authorized_zone')
    drop  proc sp_authorized_zone
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_authorized_zone               */
/************************************************************************/

create proc sp_authorized_zone   
(
     @s_srv         varchar(30)     = NULL,
     @s_rol         smallint = null,
     @s_culture     varchar(10) = null,
     @s_ofi         smallint = null,
     @i_pa_id       int = null,
     @i_tipo        char(1) = null
)
as
declare @w_sp_name    varchar(32),
        @w_servername varchar(40),
        @w_url_page   varchar(255)

select @w_sp_name = 'sp_authorized_zone',
       @s_culture = UPPER(@s_culture)

 --Se recupera el nombre del servidor en base a la oficina
 exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output

if @i_tipo = 'A'
begin
    select min(rc_rol) 
    from an_role_component 
    
    if @@rowcount =  0
    begin
         --raiserror 101001 'No existe dato solicitado'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
    end
end

if @i_tipo = 'B'
begin
        
    select distinct rc_co_id,
        rc_rol, 
        co_name, 
        co_class,  
        convert (varchar(255), isnull(replace (co_namespace,'[servername]',@w_servername),'')) co_namespace, 
        co_mo_id,
        co_ct_id,
        co_arguments
    from  ad_rol,  
        an_role_component, 
        an_role_module,
        an_component, 
        an_module,
        an_label
    where ((co_mo_id = mo_id or co_mo_id is null) and mo_id  = rm_mo_id)
            and mo_la_id = la_id  
            and la_cod = @s_culture    
            and rc_rol= @s_rol
            and rm_rol= @s_rol
            and ro_rol=rc_rol 
            and ro_rol=rm_rol
            and co_id=rc_co_id
    order  by rc_rol asc
    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end

if @i_tipo = 'C'
begin  
    select min(pz_pa_id) 
    from an_page_zone
    
     if @@rowcount =  0
     begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end  

if @i_tipo = 'D'
begin

    select 
    distinct pz_id, 
         pz_id_parent, 
         pz_co_id, 
         pz_pa_id,  
         pz_component_optional, 
         zo_name, 
         zo_pin_visible, 
         zo_close_visible, 
         zo_title_visible,  
         zo_pin_value, 
         'zo_close_value'=0, 
          pz_split_style, 
         la_label, 
         pz_order,  
         pz_hor_size, 
         pz_ver_size, 
         pz_icon,
         an_page.pa_arguments
     from an_page, 
         an_zone, 
         an_page_zone LEFT OUTER JOIN an_component ON pz_co_id = co_id, 
         an_label,
         an_role_page,
         ad_rol          
     where pz_pa_id = pa_id 
         and pz_zo_id = zo_id  
         and pz_la_id = la_id  
         and la_cod = @s_culture
         and pa_id=rp_pa_id 
         and ro_rol=rp_rol
         and rp_rol = @s_rol
     order by pz_pa_id    

    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end 

if @i_tipo = 'H'
begin    
    -- URL Page
    
    select 
    @w_url_page = he_url
    from an_page, an_help
    where pa_id = @i_pa_id
    and pa_he_id = he_id 
        
    --URL Zonas Hijas
    select  pa_id,
        pz_id,
        convert (varchar(100), isnull(replace (@w_url_page,'[servername]',isnull(@w_servername,'')),'')) he_url_Page,    
        convert (varchar(100), isnull(replace (he_url,'[servername]',isnull(@w_servername,'')),'')) he_url_Zone
    from an_page, 
        an_page_zone 
        LEFT OUTER JOIN an_help ON pz_he_id = he_id 
        LEFT OUTER JOIN an_component ON pz_co_id = co_id
    where pa_id = @i_pa_id
        and pz_pa_id = @i_pa_id
    order by pz_order    
end
return 0
go
