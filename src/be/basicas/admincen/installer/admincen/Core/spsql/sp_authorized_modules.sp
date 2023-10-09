/*************************************************************************/
/*   Archivo:              sp_authorized_modules.sp                      */
/*   Stored Procedure:     sp_authorized_modules                         */
/*   Disenado por:         Cobiscorp Ecuador                             */
/*   Fecha de Escritura:   Abril de 2013                                 */
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
/*   Este sp consulta todos los modulos autorizados para un rol          */
/*   determinado                                                         */
/*************************************************************************/
/*                         MODIFICACIONES                                */
/*   Fecha      Nombre               Proposito                           */
/* ABR/03/2013  Cobiscorp Ecuador    Emision Inicial                     */
/* Nov/04/2013  Mariela Cabay        @w_servername para el tipo de       */
/*                                   Distrib por branch                  */
/* ABR/15/2016  BBO                  Migracion SYB-SQL FAL               */
/*************************************************************************/

use cobis
go

/************************************************************************/
/*   Elimina el procedimiento almacenado sp_authorized_modules          */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_authorized_modules')
    drop  proc sp_authorized_modules
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_authorized_modules            */
/************************************************************************/

create proc sp_authorized_modules (
    @s_srv             varchar(30)     = NULL,
    @s_ofi             smallint = null,
    @i_tipo            char(1) = null,
    @s_culture         varchar(30) = null,
    @s_rol             smallint = null
)
as
declare @w_sp_name    varchar(32),
        @w_servername varchar(40)
select @w_sp_name = 'sp_authorized_modules',
       @s_culture = UPPER(@s_culture)

 --Se recupera el nombre del servidor en base a la oficina
 exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output

if @i_tipo = 'A'
begin       
    select min(rm_rol) from an_role_module 
    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existe dato solicitado'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
    end
end
if @i_tipo = 'B'
begin
    select distinct rm_mo_id, 
        rm_rol, 
        mo_name, 
        mo_filename,  
        convert (varchar(255), isnull(replace (mg_location,'[servername]',@w_servername),'')) mg_location, 
        mo_key_token , 
        la_label, 
        mo_id_parent, 
        mg_name,
        mg_version,
        mg_store_name
    from an_module, 
        ad_rol, 
        an_role_module, 
        an_label, 
        an_module_group 
    where mg_id= mo_mg_id 
        and  la_id = mo_la_id 
        and mo_id=rm_mo_id 
        and ro_rol=rm_rol 
        and  la_cod = @s_culture
        and rm_rol= @s_rol
    order by rm_rol asc 
        
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end

if @i_tipo = 'C'
begin
    select min(mo_id_parent) from an_module
    
    if @@rowcount =  0
    begin
         --raiserror 101001 'No existen datos solicitados'
         RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
    end
end  
if @i_tipo = 'D'
begin
    select mo_id,  
        mo_id_parent, 
        mo_name, 
        mo_filename, 
        convert (varchar(255), isnull(replace (mg_location,'[servername]',@w_servername),'')) mg_location,  
        mo_key_token ,
        la_label, 
        mg_name,
        mg_version,
        mg_store_name
    from an_module, 
        an_label, 
        an_module_group, 
        ad_rol,
        an_role_module
    where mg_id = mo_mg_id 
        and la_id = mo_la_id 
        and mo_id=rm_mo_id 
        and ro_rol=rm_rol        
        and la_cod = @s_culture 
        and rm_rol= @s_rol        
    order by mo_id_parent

    
    if @@rowcount =  0
    begin
        --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end 
return 0                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
go
