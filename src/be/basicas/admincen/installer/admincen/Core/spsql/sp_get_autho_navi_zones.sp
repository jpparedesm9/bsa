use cobis
go

if exists (select * from sysobjects where name = 'sp_get_autho_navi_zones')
   drop proc sp_get_autho_navi_zones
go

/***************************************************************/
/* ARCHIVO:        sp_get_autho_navi_zones.sp                  */ 
/* NOMBRE LOGICO:  sp_get_autho_navi_zones                     */
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
/* Recuperar las zonas de navegaci=n autorizadas para          */
/* un rol determinado                                          */
/*                                                             */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                     RAZON               */
/* 04-SEP-2009   Omar Dfaz        Emision inicial              */
/* 02-Jun-2010   S. Paredes       Cambiar @i_rol y @i_culture  */
/* 04/Nov/2013   M. Cabay         @w_servername para el        */
/*                                el tipo de Distrib por branch*/ 
/***************************************************************/

CREATE Procedure sp_get_autho_navi_zones
    @s_srv          varchar(30)     = NULL,
    @s_rol          smallint = null,
    @s_culture      varchar(10) = null,
    @s_ofi          smallint    = NULL,
    @i_last_id      int = NULL,
    @o_num_reg      int = NULL OUTPUT
AS

declare @w_str varchar(500),
        @w_servername varchar(40)
select @o_num_reg = 0,
       @s_culture = UPPER(@s_culture)
--Se recupera el nombre del servidor en base a la oficina
  exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output

SELECT    RNZ.rn_rol,
    NZ.nz_id,
    NZ.nz_name,
    NZ.nz_icon,
    NZ.nz_order,
    la_label=isnull(L.la_label,'No existe Label'),
    C.co_id,
    C.co_name,
    C.co_class,
    convert (varchar(255), isnull(replace (C.co_namespace,'[servername]',@w_servername),'')) co_namespace,
    M.mo_id,
    C.co_ct_id,
    C.co_arguments 
INTO    #tmp_resultados
FROM     an_navigation_zone NZ LEFT OUTER JOIN an_label L ON NZ.nz_la_id = L.la_id and L.la_cod = @s_culture, an_role_navigation_zone RNZ, an_component C, an_module M
WHERE   RNZ.rn_rol = @s_rol AND
    NZ.nz_id = RNZ.rn_nz_id AND
    NZ.nz_co_id = C.co_id AND
    M.mo_id = C.co_mo_id 
ORDER BY NZ.nz_order    


IF @i_last_id = -1
    SELECT * FROM #tmp_resultados
ELSE
BEGIN
    execute('alter table #tmp_resultados add idn numeric(18,0) identity')
    select @w_str = 'set rowcount 20 select * from #tmp_resultados where idn > ' + convert(varchar(20),isnull(@i_last_id,-1)) + ' order by idn'
    execute (@w_str)
END
select @o_num_reg = @@rowcount
return 0
go

