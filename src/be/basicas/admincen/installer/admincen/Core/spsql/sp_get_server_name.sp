/*************************************************************************/
/*   Archivo:              sp_get_server_name .sp                        */
/*   Stored Procedure:     sp_get_server_name                            */
/*   Disenado por:         Cobiscorp Ecuador                             */
/*   Fecha de Escritura:   Noviembre del 2013                            */
/*************************************************************************/
/*                         IMPORTANTE                                    */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "COBISCORP S.A.".                                                   */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                         PROPOSITO                                     */
/*   Obtiene el servidor para una url definada con el prefijo [servername]*/
/*   en base a la parametrización realizada en la tabla cl_parámetro     */
/*************************************************************************/
/*                         MODIFICACIONES                                */
/*   Fecha      Nombre               Proposito                           */
/* NOV/04/2013  Cobiscorp Ecuador    Emision Inicial                     */
/* ABR/21/2016  BBO                  Migracion SYB-SQL FAL               */
/*************************************************************************/

use cobis
go

SET ANSI_NULLS OFF
go
/************************************************************************/
/*   Elimina el procedimiento almacenado sp_get_server_name             */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_get_server_name')
    drop  proc sp_get_server_name
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_get_server_name               */
/************************************************************************/

create proc sp_get_server_name (
    @i_server         varchar(30) = null,
    @i_ofi            smallint = null,
    @o_servername     varchar(30)= null output,
	@o_cts_servername varchar(30)= null output
)
as
declare @w_sp_name    varchar(32),
        @w_servername varchar(64),
        @w_type       char(2)
        
select @w_sp_name = 'sp_get_server_name'

--Se recupera el tipo de parametrización implementada para recuperar las direcciones web
select @w_type = pa_char from cobis..cl_parametro where pa_nemonico = 'CTDSW' 

if @w_type = 'OF'  --Se recupera el nombre del servidor en base a la oficina
      
    begin    
        select @w_servername  = os_srv_name 
        from an_office_srv
        where os_office_id = @i_ofi
      if @w_servername is null
         begin
            select @w_servername  = os_srv_name 
            from an_office_srv
            where os_office_id = -1
         end
      end
  if @w_type = 'SC' --Se recupera el ip del servidor en base al nombre del servidor
  begin
        select @w_servername  = cw_webserver
        from an_cobisserver_webserver
        where cw_cobisserver = @i_server
        if @w_servername is null
          begin
            select @w_servername  = cw_webserver 
            from an_cobisserver_webserver
            where UPPER(cw_cobisserver) = 'DEFAULT'
          end
     end
   if @w_servername is null --Por algun motivo no pudo recuperar el servidor se devuelve  la cadena servername
      select @w_servername = 'servername'

	select @o_servername=@w_servername
	
	set @w_servername = null
	select @w_servername = cw_webserver from an_cobisserver_webserver where cw_cobisserver = 'CTS_SERVERNAME'
	if @w_servername is null
		begin
			select @w_servername  = cw_webserver from an_cobisserver_webserver where cw_cobisserver = @i_server
		end
	if @w_servername is null
		select @w_servername = 'cts_servername'
	
   select @o_cts_servername=@w_servername
return 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
go
