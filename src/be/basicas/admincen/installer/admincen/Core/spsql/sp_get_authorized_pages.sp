use cobis
go

if exists (select * from sysobjects where name = 'sp_get_authorized_pages')
   drop proc sp_get_authorized_pages
go

/***************************************************************/
/* ARCHIVO:        sp_getauthorizedpages.sp                    */ 
/* NOMBRE LOGICO:  sp_get_authorized_pages                     */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicaci¢n es parte de los paquetes bancarios pro-     */
/* piedad de COBISCORP.                                        */
/* Su uso no autorizado queda expresamente prohibido as¡ como  */
/* cualquier alteraci¢n o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de COBIS  */
/* CORP.                                                       */
/* Este Programa esta protegido por la Ley de derechos sde autor*/
/* y por las convenciones internacionales de propiedad inte-   */
/* lectual. Su uso no autorizado dara derecho a COBISCORP para */
/* obtener ordenes de secuestro o retencion y para perseguir   */
/* penalmente a los autores de cualquier infraccion.           */
/***************************************************************/
/*                         PROPOSITO                           */
/* Recuperar las paginas autorizadas para un rol determinado   */
/*                                                             */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                     RAZON               */
/* 02-SEP-2009   Omar D¡az           Emision inicial           */
/* 15-ene-2010   Stalin Calderon     Corregir orden paginas    */
/* 02-Jun-2010   S. Paredes       Cambiar @i_rol y @i_culture  */
/***************************************************************/

CREATE Procedure sp_get_authorized_pages
    @s_rol          smallint = null,
    @s_culture      varchar(10) = null,
    @i_parent_id    int = NULL,
    @i_last_id      int = NULL,
    @o_num_reg      int = NULL OUTPUT    
AS

declare @w_str varchar(500)
select @o_num_reg = 0
SELECT    
    RP.rp_rol,
    P.pa_id,
    P.pa_order,
    isnull(L.la_label,'No existe Label') la_label,
    P.pa_icon,
    P.pa_name,
    0 has_childs,
    P.pa_nemonic,
    P.pa_splitter,
    P.pa_id_parent
INTO    #tmp_resultados    
FROM    an_page P
left join an_label L ON P.pa_la_id = L.la_id AND UPPER(L.la_cod) = UPPER(@s_culture)
inner join an_role_page RP ON P.pa_id = RP.rp_pa_id
WHERE    
    RP.rp_rol = @s_rol AND
    P.pa_id = RP.rp_pa_id and
    P.pa_visible = 1
order by P.pa_order    

while @@rowcount>0
begin 
    insert into #tmp_resultados    
    SELECT    
        @s_rol rp_rol,
        P.pa_id,
        P.pa_order,
        isnull(L.la_label,'No existe Label') la_label,
        P.pa_icon,
        P.pa_name,
        0 has_childs,
        P.pa_nemonic,
        P.pa_splitter,
        P.pa_id_parent
    FROM    an_page P
    left join an_label L ON P.pa_la_id = L.la_id AND UPPER(L.la_cod) = UPPER(@s_culture)
    WHERE
        P.pa_id in (select pa_id_parent from #tmp_resultados)
        and P.pa_id not in (select pa_id from #tmp_resultados)
        and P.pa_visible = 1
    order by P.pa_order    
end

update #tmp_resultados set has_childs = 1
where pa_id in (select pa_id_parent from #tmp_resultados)

delete #tmp_resultados where pa_id_parent <> @i_parent_id

IF @i_last_id = -1
    SELECT * FROM #tmp_resultados ORDER BY pa_order
ELSE
BEGIN
   select * into #tmp_resul
   from #tmp_resultados
   order by pa_order

   execute('alter table #tmp_resul add idn numeric(18,0) identity')
   select @w_str = 'set rowcount 20 select * from #tmp_resul where idn > ' + convert(varchar(20),isnull(@i_last_id,-1)) + 'order by idn'
   execute (@w_str)
END
select @o_num_reg = @@rowcount

set rowcount 0

return 0
go
