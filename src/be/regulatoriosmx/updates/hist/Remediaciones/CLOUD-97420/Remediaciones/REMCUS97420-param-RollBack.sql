use cobis
go
delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_motivo_traspaso', 'cr_estado_traspaso')
and codigo = cp_tabla

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_motivo_traspaso', 'cr_estado_traspaso')
  and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('cr_motivo_traspaso', 'cr_estado_traspaso')

--Creacion de parámetros

delete cobis..cl_parametro
where pa_nemonico in('TDI', 'TDF', 'VGT')
  and pa_producto = 'CLI'
go

--Mensaje de error
delete cobis..cl_errores
 where numero in (108008, 108009, 108010, 108011, 108012)
go

--Ingreso de datos en seqnos
delete cobis..cl_seqnos
where tabla = 'cl_solicitud_traspaso'
go

--BORRADO DE REGISTROS

delete from  cobis..ad_procedure
 where pd_procedure in (8250)
   and pd_base_datos = 'cobis'
go

print' Creacion de transacciones'

--BORRADO DE REGISTROS
delete cobis..cl_ttransaccion
 where tn_trn_code in(8250, 8251,8252,8253,8254,8255)
go

------------------------------------
----------- COORDINADOR ------------
------------------------------------


--BORRADO DE REGISTROS
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_resurce int

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'COORDINADOR' 
   and ro_filial = 1

 delete cobis..ad_pro_transaccion
 where pt_producto = 1
   and pt_moneda   = @w_moneda
   and pt_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol
go

------------------------------------
------- GERENTE DE SUCURSAL---------
------------------------------------

--BORRADO DE REGISTROS
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_resurce int

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'GERENTE DE SUCURSAL' 
   and ro_filial = 1

 delete cobis..ad_pro_transaccion
 where pt_producto = 1
   and pt_moneda   = @w_moneda
   and pt_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol
go

------------------------------------
-------- GERENTE REGIONAL ----------
------------------------------------

--BORRADO DE REGISTROS
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_resurce int

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'GERENTE REGIONAL' 
   and ro_filial = 1

 delete cobis..ad_pro_transaccion
 where pt_producto = 1
   and pt_moneda   = @w_moneda
   and pt_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol
go

-------------------------------
--------- GERENTE DE SUCURSAL ---------
-------------------------------

--BORRADO DE REGISTROS
declare @w_rol     smallint,
        @w_moneda  tinyint,
		@w_resurce int

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MESA DE OPERACIONES'
   and ro_filial = 1

 delete cobis..ad_pro_transaccion
 where pt_producto = 1
   and pt_moneda   = @w_moneda
   and pt_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol
go


use cobis
GO
    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateRequestTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateRequestTransfer'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchRequestTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchRequestTransfer'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransfer'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail'

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.RefuseTransfer')
	delete cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.RefuseTransfer'

--------------------------------------------------------------------------------------------
-- Crear CATALOGO
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_catalogo.sql

use cobis
go


delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('ca_param_notif')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ca_param_notif')                                              
and cl_tabla.codigo = cl_catalogo.tabla
go
                               
delete cl_tabla                          
 where cl_tabla.tabla in ('ca_param_notif')                                    
go
