use cobis
go

if exists (select * from sysobjects where name = 'sp_get_authorized_agents')
   drop proc sp_get_authorized_agents
go

/***************************************************************/
/* ARCHIVO:        sp_get_authorized_agents.sp                 */ 
/* NOMBRE LOGICO:  sp_get_authorized_agents                    */
/* PRODUCTO:       COBISExplorerNet                            */
/***************************************************************/
/*                       IMPORTANTE                            */
/* Esta Aplicaci¢n es parte de los paquetes bancarios pro-     */
/* piedad de COBISCORP.                                        */
/* Su uso no autorizado queda expresamente prohibido as¡ como  */
/* cualquier alteraci¢n o agregado hecho por alguno de sus     */
/* usuarios sin el debido consentimiento por escrito de COBIS  */
/* CORP.                                                       */
/* Este Programa esta protegido por la Ley de derechos de autor*/
/* y por las convenciones internacionales de propiedad inte-   */
/* lectual. Su uso no autorizado dara derecho a COBISCORP para */
/* obtener ordenes de secuestro o retencion y para perseguir   */
/* penalmente a los autores de cualquier infraccion.           */
/***************************************************************/
/*                         PROPOSITO                           */
/* Recuperar los agentes authorizados para un rol              */
/*                                                             */
/***************************************************************/
/*                        MODIFICACINES                        */
/* FECHA         AUTOR                     RAZON               */
/* 22-mar-2010   Stalin Calderon         Emision Inicial       */
/* 02-Jun-2010   S. Paredes       Cambiar @i_rol y @i_culture  */
/* 04/Nov/2013   M. Cabay         @w_servername para el        */
/*                                el tipo de Distrib por branch*/ 
/***************************************************************/

create procedure sp_get_authorized_agents
        @s_srv          varchar(30)     = NULL,
        @s_rol          smallint = null,
        @s_culture      varchar(10)= null,
        @s_ofi          smallint    = NULL,
        @i_last_id      int = NULL,
        @o_num_reg      int = NULL OUTPUT
as
                                                                                                                                                                                                                                                               
declare @w_str varchar(500),   
        @w_servername varchar(40)        

--Se recupera el nombre del servidor en base a la oficina
  exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output
              
select @o_num_reg = 0,
       @s_culture = UPPER(@s_culture)

                    
   select         
                AG.ag_id,
                AG.ag_name,            
                isnull(L.la_label,'No existe Label') la_label,
                RA.ra_order,
                C.co_id,                                
                C.co_name,
                C.co_class,  
                convert (varchar(255), isnull(replace (C.co_namespace,'[servername]',@w_servername),'')) co_namespace,
                C.co_mo_id,
                C.co_ct_id,
                C.co_arguments
   into #tmp_resultados                      
   from an_agent AG
        inner join an_component C ON C.co_id = AG.ag_co_id 
        inner join an_role_component RC ON C.co_id = RC.rc_co_id
        inner join an_module M ON M.mo_id = C.co_mo_id 
        inner join an_role_module RM ON M.mo_id = RM.rm_mo_id 
        inner join an_role_agent RA ON RA.ra_ag_id = AG.ag_id 
        left join an_label L ON AG.ag_la_id=L.la_id AND L.la_cod = @s_culture
  where RC.rc_rol = @s_rol AND
        RM.rm_rol = @s_rol AND
        RA.ra_rol = @s_rol           
   order by RA.ra_order          
                                                                                                                                                                                                                                     
   if @i_last_id = -1
      select * from #tmp_resultados
   else
   begin         
      execute('alter table #tmp_resultados add idn numeric(18,0) identity')
      select @w_str = 'set rowcount 20 select * from #tmp_resultados where idn > ' + convert(varchar(20),isnull(@i_last_id,-1)) + ' order by idn'
      execute (@w_str)
   end

   select @o_num_reg = @@rowcount
return 0
go
