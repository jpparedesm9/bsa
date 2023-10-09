/*************************************************************************/
/*      Archivo:                sp_authorized_navigation_zone.sp         */
/*      Stored procedure:       sp_authorized_navigation_zone            */
/*      Disenado por:           Cobiscorp Ecuador                        */
/*      Fecha de escritura:     Abril de 2013                            */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "COBISCORP S.A.".                                                */
/*      Su uso no autorizado queda expresamente prohibido                */
/*      asi como cualquier alteracion o agregado hecho por alguno de     */
/*      sus usuarios sin el debido consentimiento por escrito de la      */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/*************************************************************************/
/*                              PROPOSITO                                */
/*      Este sp consulta todas las zonas de navegación autorizadas       */
/*      para un rol determinado                                          */
/*                                                                       */
/*************************************************************************/
/*                              MODIFICACIONES                           */
/*      FECHA        NOMBRE             PROPOSITO                        */
/* Nov/04/2013  Mariela Cabay      @serverName Distrib por branch        */
/* ABR/15/2016  BBO                  Migracion SYB-SQL FAL               */
/*************************************************************************/
use cobis
go

/************************************************************************/
/*   Elimina el procedimiento almacenado sp_authorized_navigation_zone  */
/************************************************************************/

if exists (select * from sysobjects where name = 'sp_authorized_navigation_zone')
    drop  proc sp_authorized_navigation_zone
go

/************************************************************************/
/*    Crea el procedimiento almacenado sp_authorized_navigation_zone    */
/************************************************************************/

create proc sp_authorized_navigation_zone (
	@s_srv            varchar(30)     = NULL,
    @s_ofi            smallint = null,
	@i_tipo           char(1) = null,
    @i_culture        varchar(30) = null   
)
as
 
declare @w_sp_name    varchar(32),
		@w_servername varchar(40)
		
select @w_sp_name = 'sp_authorized_navigation_zone',
       @i_culture = UPPER(@i_culture)
	   
--Se recupera el nombre del servidor en base a la oficina
exec sp_get_server_name @i_server  = @s_srv, @i_ofi  =@s_ofi, @o_servername = @w_servername output
--select @w_servername  = os_srv_name from an_office_srv where os_office_id = @s_ofi

if @i_tipo = 'A'
begin

    if not exists(select rn_rol from an_role_navigation_zone)
    begin
        --raiserror 101001 'No existe dato solicitado'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existe dato solicitado')  --migracion SYB-SQL 15042016
    end
    else 
        select min(rn_rol) from an_role_navigation_zone    
end

if @i_tipo = 'B'
begin
    select distinct rn_nz_id, 
        rn_rol, 
        nz_name,  
        nz_icon, 
        nz_order, 
        la_label=isnull(la_label, 'No existe Label')
    from 
        an_navigation_zone LEFT OUTER JOIN an_label ON nz_la_id = la_id and la_cod = @i_culture, 
        ad_rol, 
        an_role_navigation_zone,  
        an_component
    where nz_id=rn_nz_id 
        and ro_rol=rn_rol 
        and co_id=nz_co_id 
    order by rn_rol asc
    
    if @@rowcount =  0
    begin
         --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end
end

if @i_tipo = 'C'
begin
    select nz_id, 
        nz_co_id, 
        co_mo_id, 
        nz_name,  
        nz_icon, 
        nz_order, 
        la_label=isnull(la_label, 'No existe Label'),  
        co_name, 
        co_class,  
        convert (varchar(255), isnull(replace (co_namespace,'[servername]',@w_servername),'')) co_namespace, 
        co_ct_id 
    from an_navigation_zone LEFT OUTER JOIN an_label ON nz_la_id = la_id and la_cod = @i_culture, 
        an_component, 
        an_module   
    where co_id=nz_co_id  
        and mo_id= co_mo_id 
    order by nz_co_id
     
     if @@rowcount =  0
     begin
         --raiserror 101001 'No existen datos solicitados'
        RAISERROR ('%d %s', 16, 1, 101001, 'No existen datos solicitados')  --migracion SYB-SQL 15042016
    end

end
return 0                                                                                                                                                                                                                                                                                                                                                                                                                                               
go
