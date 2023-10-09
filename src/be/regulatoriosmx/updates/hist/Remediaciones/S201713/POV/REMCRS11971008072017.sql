
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S119710 Validación de Cancelación de Crédito Vigente - Flujo Grupal
--Fecha                      : 05/07/2017
--Descripción del Problema   : No existen el registro del servicio y no existe catalogo
--Descripción de la Solución : Agregar los registros y catalogo
--Autor                      : Paúl Ortiz Vera
--Instalador                 : cr_parametro.sql 
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
/**********************************************************************************************************************/


use cobis
GO

  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', csc_method_name = 'queryCustomerApplication', csc_description = '', csc_trn = 22555 WHERE csc_service_id = 'Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication'
  ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication', 'cobiscorp.ecobis.businessprocess.creditmanagement.service.IApplicationManagment', 'queryCustomerApplication', '', 22555)
  GO
    



USE cobis

GO
declare @w_rol int, @w_producto int
	  
      select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
      select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
	  
      
      DELETE cobis..ad_servicio_autorizado where ts_servicio = 'Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication'
      INSERT INTO cobis..ad_servicio_autorizado values('Businessprocess.Creditmanagement.ApplicationManagment.QueryCustomerApplication', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
        print 'insert en ad_servicio_autorizado'

GO


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_flujo_grp')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_flujo_grp')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cr_flujo_grp')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cr_flujo_grp', 'Flujos Grupales')


--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'PROC4', 'PROCESO 4', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'CREGRP', 'CREDITO GRUPAL', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'SOLCRGRSTD', 'SANTANDER CREDITO GRUPAL', 'V', NULL, NULL, NULL)


INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'GRGYE', 'GRUPAL GUAYAQUIL', 'V', NULL, NULL, NULL)
GO