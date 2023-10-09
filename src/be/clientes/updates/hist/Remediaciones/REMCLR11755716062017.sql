/**********************************************************************************************************************/
--No Bug                                : NA
--Título de la Historia           : CGS-R117557 Modificaciones - Demo 1
--Fecha                                      : 16/06/2017
--Descripción del Problema   :  No existe el servicio, agregado y modificación de catalogos
--Descripción de la Solución :  Agregar el servicio
--Autor                                        : Paúl Ortiz Vera
--Instalador                 : cl_services_authorization.sql    -      4_sta_catalogo.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

---------------AGREGADO DE CAMPO

use cobis
    GO

--Agregando nuevos campos a Direcciones

IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME = 'di_nro_interno' AND TABLE_NAME = 'cl_direccion')
BEGIN
    ALTER TABLE cl_direccion ADD di_nro_interno INT NULL
END




---------------SERVICIO

use cobis
    GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchAddressByHome', csc_description = '', csc_trn = 1712 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchAddressByHome', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddressByHome', '', 1712)
      GO
      
USE cobis

GO
declare @w_rol int, @w_producto int
	  
      select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
      select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	  
      
      DELETE cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.SearchAddressByHome'
      INSERT INTO cobis..ad_servicio_autorizado values('CustomerDataManagementService.CustomerManagement.SearchAddressByHome', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
        print 'insert en ad_servicio_autorizado'

		
		
		
		
---------------- CATALOGOS

use cobis
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CLI'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in  ('cl_referencia_tiempo', 'cl_fuente_ingreso', 'cr_tipo_local')
go

--/////////////////////////////
delete cl_catalogo
  from cl_tabla
 where cl_tabla.codigo = cl_catalogo.tabla
  and cl_tabla.tabla in  ('cl_referencia_tiempo', 'cl_fuente_ingreso', 'cr_tipo_local')
--/////////////////////////////
delete cl_tabla                          
 where cl_tabla.tabla in    ('cl_referencia_tiempo', 'cl_fuente_ingreso', 'cr_tipo_local')
go


------------------------------------
-- catalogo: cl_fuente_ingreso
------------------------------------  
print 'cl_fuente_ingreso'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla
insert into cl_tabla values (@w_tabla,'cl_fuente_ingreso','Fuentes de Ingreso')

insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'NP','NEGOCIO PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'TE','TERCEROS','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'ED','ENVIO DE DINERO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'AF','APOYO FAMILIAR','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'PE','PENSION','V')
go
	
------------------------------------
-- catalogo: cl_referencia_tiempo
------------------------------------  
print 'cl_referencia_tiempo'
declare @w_tabla smallint
select @w_tabla = max(codigo)+ 1 from cl_tabla

insert into cl_tabla values (@w_tabla,'cl_referencia_tiempo','TIEMPO REFERENCIAL')


insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1', '1', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2', '2', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '3', '3', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '4', '4', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '5', '5 O MAS', 'V')
go



declare @w_tabla smallint
select @w_tabla = max(codigo)+1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_tipo_local', ' TIPO DE LOCAL                                                    ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','MISMO DE DOMICILIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','MERCADO','V')
go


------------------------------------------------
-- Actualizacion secuencial tabla de catalogos
------------------------------------------------
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in (
	 'cl_referencia_tiempo',
	 'cl_fuente_ingreso',
	 'cr_tipo_local'
   )
go




