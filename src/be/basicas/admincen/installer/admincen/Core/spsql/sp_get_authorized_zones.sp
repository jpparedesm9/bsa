/***************************************************************/
/* ARCHIVO:        sp_get_authorized_zones.sp                  */
/* NOMBRE LOGICO:  sp_get_authorized_zones                     */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicacion es parte de los paquetes bancarios pro-     */
/* piedad de COBISCORP.                                        */
/* Su uso no autorizado queda expresamente prohibido asf como  */
/* cualquier alteraci=n o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de COBIS  */
/* CORP.                                                       */
/* Este Programa esta protegido por la Ley de derechos de autor*/
/* y por las convenciones internacionales de propiedad inte-   */
/* lectual. Su uso no autorizado dara derecho a COBISCORP para */
/* obtener ordenes de secuestro o retencion y para perseguir   */
/* penalmente a los autores de cualquier infraccion.           */
/***************************************************************/
/*                         PROPOSITO                           */
/* Recuperar las zonas autorizadas para un rol determinado     */
/*                                                             */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                    RAZON                */
/* 22-ABR-2009   Ma.Augusta Villavicencio Emision inicial      */
/* 02-SEP-2009   Omar Dfaz                Alias                */
/* 25-FEB-2010   Sandro Soto      Se usa un alias en lugar del */
/*                                campo zo_close_value, para   */
/*                                devolver cero.               */
/* 12-Feb-2010   Tecnologia       Incorpora pa_arguments       */
/* 02-Jun-2010   S. Paredes       Cambiar @i_rol y @i_culture  */
/* 03-jun-2010   S. Paredes       Cambiar pz_zo_id por pz_id   */
/* 8-Jun-2010    Carlos.M.Echeverria Optimizacion de sp        */
/* 04-Nov-2014   M. Cabay         serveName distrib por branch */
/***************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_get_authorized_zones')
   drop proc sp_get_authorized_zones
go
 

CREATE Procedure sp_get_authorized_zones
    @s_srv       varchar(30)     = NULL,
    @s_rol       smallint = null,
    @s_culture   varchar(10) = null,
    @s_ofi       smallint = NULL,    
    @i_pa_id     int,
    @i_pa_name   varchar(40) = NULL,
    @i_last_id   int = NULL,
    @o_num_reg   int = NULL OUTPUT
AS

declare @w_str varchar(500),
@w_servername varchar(40),
@w_url_page varchar(255)

select @o_num_reg = 0

--Se recuepra el nombre del servidor en base a la oficina
exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output


if @i_pa_name Is Not Null
begin
    select @i_pa_id = pa_id from an_page where pa_name = @i_pa_name            
end

select 
    P.pa_name,  
    PZ.pz_id,
    PZ.pz_id_parent,
    isnull(P.la_label,'No existe Label') pa_la_label,
    PZ.pz_component_optional,
    Z.zo_pin_visible,
    Z.zo_close_visible,
    Z.zo_title_visible,
    Z.zo_pin_value,
    'zo_close_value' = 0, 
    P.pa_splitter,
    isnull(L.la_label,'No existe Label') pz_la_label,
    P.pa_order,
    PZ.pz_hor_size,
    PZ.pz_ver_size,
    P.pa_nemonic,    
    C.co_id,        
    C.co_name, 
    C.co_class,  
    convert (varchar(255), isnull(replace (C.co_namespace,'[servername]',@w_servername),'')) co_namespace, 
    C.co_mo_id,
    C.co_ct_id,
    C.co_arguments,
    P.pa_id,
    PZ.pz_la_id,    
    PZ.pz_order,    
    PZ.pz_split_style,  
    P.pa_la_id,
    P.pa_arguments,
    isnull((select 1 from an_role_component 
            where C.co_id = rc_co_id
                and   rc_rol  = @s_rol),0) as AutorizedComponent,
    isnull((select 1 from an_role_module 
            where C.co_mo_id = rm_mo_id 
                and   rm_rol  = @s_rol),0) as AutorizedModule
    INTO    #tmp_resultados     
from an_component C, 
    (select pz_pa_id 
    ,pz_id 
    ,pz_co_id
    ,pz_zo_id
    ,pz_id_parent 
    ,pz_component_optional
    ,pz_hor_size
    ,pz_ver_size
    ,pz_icon
    ,pz_la_id    
    ,pz_order    
    ,pz_split_style 
    FROM    an_page_zone 
    where pz_pa_id = @i_pa_id)  PZ LEFT OUTER JOIN an_label L ON PZ.pz_la_id=L.la_id and upper(L.la_cod) = upper(@s_culture), 
    (
    select 
    pa_name,
    pa_splitter,
    pa_la_id,
    pa_arguments,
    pa_order,
    pa_id,
    pa_nemonic,
    PL.la_label
    from an_page LEFT OUTER JOIN an_label PL ON pa_la_id=PL.la_id and upper(PL.la_cod) = upper(@s_culture) 
    where pa_id = @i_pa_id) P, 
    an_zone Z
where C.co_id   = PZ.pz_co_id
    and P.pa_id = PZ.pz_pa_id
    and Z.zo_id = PZ.pz_zo_id
ORDER BY PZ.pz_order 


--Consulta para sacar la URL del Path de ayuda

-- URL Page
select 
    @w_url_page = he_url
from an_page, an_help
where pa_id = @i_pa_id
    and pa_he_id = he_id 

--URL Zonas Hijas
select 
    pa_name,
    pa_id,
    convert (varchar(100), isnull(replace (@w_url_page,'[servername]',isnull(@w_servername,'')),'')) he_url_Page,
    pz_id,
    convert (varchar(100), isnull(replace (he_url,'[servername]',isnull(@w_servername,'')),'')) he_url_Zone
    INTO #tmp_url
from an_page, an_page_zone LEFT OUTER JOIN an_help ON pz_he_id  = he_id
where pa_id = @i_pa_id
    and pz_pa_id = @i_pa_id
ORDER BY pz_order 

IF @i_last_id = -1
BEGIN
    SELECT * FROM #tmp_resultados
    SELECT * FROM #tmp_url 
END
ELSE
BEGIN   
    execute('alter table #tmp_resultados add idn numeric(18,0) identity')
    select @w_str = 'set rowcount 20 select * from #tmp_resultados where idn > ' + convert(varchar(20),isnull(@i_last_id,-1)) + ' order by idn'
    execute (@w_str)
    
    execute('alter table #tmp_url  add idn numeric(18,0) identity')
    select @w_str = 'set rowcount 20 select * from #tmp_url  where idn > ' + convert(varchar(20),isnull(@i_last_id,-1)) + ' order by idn'
    execute (@w_str)
END

select @o_num_reg = @@rowcount

return 0
go
