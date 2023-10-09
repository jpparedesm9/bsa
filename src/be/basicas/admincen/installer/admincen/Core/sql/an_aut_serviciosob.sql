/************************************************************************/
/*                                                                      */
/*    Archivo:         Auth_serviciosOB.sql                             */
/*    Script:          Registro de Servicios OffBanking-CTS             */
/*    Base de datos:   cobis                                            */
/*    Producto:        CTS                                              */
/*                                                                      */
/************************************************************************/
/*                         IMPORTANTE                                   */
/* Esta aplicacion es parte de los paquetes bancarios propiedad         */
/* de COBIS Corporation.                                                */
/* Su uso no  autorizado queda  expresamente prohibido asi como         */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus         */
/* usuarios sin el debido consentimiento por escrito de COBIS           */
/* Corp. Este programa esta protegido por la ley de derechos de         */
/* autor y por las  convenciones  internacionales de  propiedad         */
/* intelectual.  Su uso no  autorizado dara  derecho a COBIS            */
/* Corp. para obtener  ordenes de  secuestro o retencion y para         */
/* perseguir penalmente a los autores de cualquier infraccion.          */
/************************************************************************/
/*                                                                      */
/*                PROPOSITO                                             */
/*    Script para registrar los servicios                               */
/*    que serian ejecutados desde Office                                */
/*    Banking a        COBIS TS                                         */
/*                                                                      */
/*                                                                      */
/************************************************************************/
/*                      MODIFICACIONES                                  */
/* FECHA                   AUTOR            RAZON                       */
/* Mayo 10 2011 1:39 PM    bcuenca         Emision Inicial              */
/************************************************************************/

--REGISTRO DE SERVICIOS QUE UTILIZA OfficeBanking-CTS

use cobis
go
print 'Registro de servicio de Consulta de Páginas Web Autorizadas por Rol'
go
if(select count(*) from cts_serv_catalog where csc_service_id='GetAuthorizedPagesWeb')=0
begin
    insert into cts_serv_catalog 
        (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn) 
    values('GetAuthorizedPagesWeb','cobiscorp.ecobis.officebanking.commons.admin.service.IOfficeMenu','getAuthorizedPagesWeb','Servicio de Páginas Web Autorizadas de OfficeBanking - CTS',null)
end
go

print 'Registro de servicio de Consulta de Roles Vigentes para Office Banking'
go
if(select count(*) from cts_serv_catalog where csc_service_id='GetRoles')=0
begin
    insert into cts_serv_catalog 
        (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn) 
    values('GetRoles','cobiscorp.ecobis.officebanking.commons.admin.service.IProfile','getRoles','Servicio de Roles para Office Banking - CTS',null)
end

go

--REGISTRO DE SERVICIOS QUE UTILIZA Admin-CTS

print 'Registro de servicio de Autenticacion'
go
if(select count(*) from cts_serv_catalog where csc_service_id='authenticate')=0
begin
    insert into cts_serv_catalog 
         (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn) 
    values('authenticate','cobiscorp.ecobis.admin.security.services.ICOBISService','authenticate','Servicio de Autenticacion',null)       
end
go

print 'Registro de servicio de Iniciar Sesion'
go
if(select count(*) from cts_serv_catalog where csc_service_id='initializeSession')=0
begin
    insert into cts_serv_catalog 
        (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn) 
    values('initializeSession','cobiscorp.ecobis.admin.security.services.ICOBISService','initializeSession','Servicio de Iniciar Sesion',null)       
end
go

print 'Registro de servicio de Finalizar Sesion'
go
if(select count(*) from cts_serv_catalog where csc_service_id='finalizeSession')=0
begin
    insert into cts_serv_catalog 
        (csc_service_id,csc_class_name,csc_method_name,csc_description,csc_trn) 
    values('finalizeSession','cobiscorp.ecobis.admin.security.services.ICOBISService','finalizeSession','Servicio de Finalizar Sesion',null)       
end
go
