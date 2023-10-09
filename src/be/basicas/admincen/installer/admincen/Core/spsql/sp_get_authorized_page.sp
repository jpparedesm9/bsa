use cobis
go

if exists (select * from sysobjects where name = 'sp_get_authorized_page')
   drop proc sp_get_authorized_page
go

/***************************************************************/
/* ARCHIVO:        sp_getauthorizedpage.sp                     */ 
/* NOMBRE LOGICO:  sp_get_authorized_page                      */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicación es parte de los paquetes bancarios pro-     */
/* piedad de COBISCORP.                                        */
/* Su uso no autorizado queda expresamente prohibido así como  */
/* cualquier alteración o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de COBIS  */
/* CORP.                                                       */
/* Este Programa esta protegido por la Ley de derechos de autor*/
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
/* 04-SEP-2009   Omar Diaz                Emision inicial      */
/* 8-Jun-2010    Carlos.M.Echeverria      Optimizacion de SP   */
/***************************************************************/

CREATE Procedure sp_get_authorized_page
    @i_rol        tinyint,
    @i_pa_id      int,
    @i_culture    varchar(10)    
    
AS

select @i_culture = UPPER(@i_culture)

select 
   @i_rol,    
   P.pa_id,
   P.pa_order,
   isnull(L.la_label,'No existe Label') la_label,
   P.pa_icon,
   P.pa_name,
   CASE WHEN exists (select 1 from an_page P2 where P2.pa_id_parent=P.pa_id) THEN 1 ELSE 0 END has_childs,
   P.pa_nemonic,
   P.pa_splitter
from an_page P LEFT OUTER JOIN an_label L ON P.pa_la_id = L.la_id and upper(L.la_cod) = @i_culture
where pa_id              = @i_pa_id
and   exists (select 1 from an_role_page
          where rp_pa_id = P.pa_id 
          and   rp_rol   = @i_rol)

return 0
go
