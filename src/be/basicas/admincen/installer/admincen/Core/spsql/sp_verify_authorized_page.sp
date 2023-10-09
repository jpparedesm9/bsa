use cobis
go

if exists (select * from sysobjects where name = 'sp_verify_authorized_page')
   drop proc sp_verify_authorized_page
go

/***************************************************************/
/* ARCHIVO:        sp_verify_authorized_page.sp                */ 
/* NOMBRE LOGICO:  sp_verify_authorized_page                   */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicaci=n es parte de los paquetes bancarios pro-     */
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
/* verificar si una página esta autorizada                     */
/* 1=Autorizada, 0=No autorizada, null=no existe la página     */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                     RAZON               */
/* 09-SEP-2009   Omar Dfaz                Emision inicial      */
/* 02-Jun-2010   S. Paredes       Cambiar @i_rol y @i_culture  */
/***************************************************************/

CREATE Procedure sp_verify_authorized_page
    @s_rol         smallint = null,
    @i_pa_name     varchar(40)
    
AS

SELECT    CASE WHEN RP.rp_pa_id is null THEN 0 ELSE 1 END
FROM    an_page P
LEFT JOIN an_role_page RP ON RP.rp_rol = @s_rol AND P.pa_id = RP.rp_pa_id
WHERE    P.pa_name = @i_pa_name

return 0
go
