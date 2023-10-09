
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 118331: Auditoria Riesgos Geolocalizacion
--Fecha                      : 07/08/2019
--Descripción del Problema   : Se debe modificar catalogos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('FILSAN','PAISGE','DISGEO','RADGEO','URLGEO','PRTGEO','SERGEO')

insert into cobis..cl_parametro values ('FILIAL SANTANDER', 'FILSAN', 'I', null, null, null, 1, null, null, null, 'CRE')
insert into cobis..cl_parametro values ('PAIS DE GEOLOCALIZACION', 'PAISGE', 'C', 'SHORT_NAME:MX,TYPES:[COUNTRY', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DISTANCIA PERMITIDA GEOLOCALIZACION (METROS)', 'DISGEO', 'I', null, null, null, 10, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('RADIO MAXIMO GEOLOCALIZACION (KILOMETROS)', 'RADGEO', 'I', null, null, null, 50, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('URL GEOLOCALIZACION', 'URLGEO', 'C', 'https://192.168.31.20:', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('PUERTO GEOLOCALIZACION', 'PRTGEO', 'I', null, null, null, 6543, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('URL GEOLOCALIZACION', 'SERGEO', 'C', '/maps/api/geocode/json?', null, null, null, null, null, null, 'CLI')
go

--------------------------------------------------------------------------------------------
-- AGREGAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------

use cobis
go

if exists (select 1 from cts_serv_catalog where csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference')
    update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', csc_method_name = 'searchOfficeGeoreference', csc_description = 'GeoreferenciaOficina', csc_trn = 15388 where csc_service_id = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'
else
    insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('SystemConfiguration.OfficeManagement.SearchOfficeGeoreference', 'cobiscorp.ecobis.systemconfiguration.service.IOfficeManagement', 'searchOfficeGeoreference', 'GeoreferenciaOficina', 15388)
go

declare @w_rol int, @w_producto int

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'
	insert into cobis..ad_servicio_autorizado values('SystemConfiguration.OfficeManagement.SearchOfficeGeoreference', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado OPERACIONES'
end
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'ASESOR')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	
	delete cobis..ad_servicio_autorizado where ts_servicio = 'SystemConfiguration.OfficeManagement.SearchOfficeGeoreference'
	insert into cobis..ad_servicio_autorizado values('SystemConfiguration.OfficeManagement.SearchOfficeGeoreference', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado OPERACIONES'
end

--------------------------------------------------------------------------------------------
-- CREAR FUNCION
--------------------------------------------------------------------------------------------
use cob_credito
go

IF OBJECT_ID ('dbo.fn_CalculaDistancia') IS NOT NULL
	DROP FUNCTION dbo.fn_CalculaDistancia
GO

CREATE FUNCTION fn_CalculaDistancia(
@latitud1 float,
@longitud1 float,
@latitud2 float,
@longitud2 float
)
RETURNS float
AS
BEGIN
  --Unidad Metrica: K=kilometros  M=metros 
  DECLARE @distancia float
  
  --Radio de la tierra según WGS84
  DECLARE @radius float
  SET @radius = 6378.137 
  DECLARE @deg2radMultiplier float 
  SET @deg2radMultiplier = PI() / 180
  
  SET @latitud1 = @latitud1 * @deg2radMultiplier
  SET @longitud1 = @longitud1 * @deg2radMultiplier
  SET @latitud2 = @latitud2 * @deg2radMultiplier
  SET @longitud2 = @longitud2 * @deg2radMultiplier
    
  DECLARE @dlongitud float
  SET @dlongitud = @longitud2 - @longitud1
    
  SET @distancia = ACOS(SIN(@latitud1) * SIN(@latitud2) + COS(@latitud1) *
                         COS(@latitud2) * COS(@dlongitud)) * @radius
  
  -- Retorna distancia en Metros o Kilómetros  
  RETURN @distancia
END
GO
