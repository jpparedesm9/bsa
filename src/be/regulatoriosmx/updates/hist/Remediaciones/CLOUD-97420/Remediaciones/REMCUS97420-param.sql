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


declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_motivo_traspaso                     ', ' MOTIVO TRASPASO                                                      ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'EMPLEADO DE BAJA', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'ZONIFICACION', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'INCAPACIDAD', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'EXPANSION DE OFICINAS', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'BALANCEO DE PORTAFOLIO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'PRODUCTIVIDAD', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '7', 'OTRO', 'V') 
GO

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cr_estado_traspaso                     ', ' ESTADO TRASPASO                                                      ') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'V', 'VIGENTE', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'VENCIDO', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'A', 'AUTORIZADA', 'V') 

GO

--Creacion de parámetros

delete cobis..cl_parametro
where pa_nemonico in('TDI', 'TDF', 'VGT')
  and pa_producto = 'CLI'
go

insert into cobis..cl_parametro (
pa_parametro,     pa_nemonico,     pa_tipo,        pa_char,       pa_tinyint,     pa_smallint,    pa_int,      pa_money,    pa_datetime,    pa_float,       pa_producto)
values(
'TRASLADO DIA INICIO','TDI','S', null, null, 1, null, null,null, null, 'CLI')

insert into cobis..cl_parametro (
pa_parametro,     pa_nemonico,     pa_tipo,        pa_char,       pa_tinyint,     pa_smallint,    pa_int,      pa_money,    pa_datetime,    pa_float,       pa_producto)
values(
'TRASLADO DIA FIN','TDF','S',null, null, 7, null, null, null, null, 'CLI')
go

insert into cobis..cl_parametro (
pa_parametro,     pa_nemonico,     pa_tipo,        pa_char,       pa_tinyint,     pa_smallint,    pa_int,      pa_money,    pa_datetime,    pa_float,       pa_producto)
values(
'VIGENCIA TRASLADO - HORAS','VGT','S',null, null, 48, null, null, null, null, 'CLI')
go

--Mensaje de error
delete cobis..cl_errores
 where numero in (108008, 108009, 108010, 108011, 108012, 108013)
go


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108008 , 0, 'No existe Día inicio de Traspaso en Parametros Generales')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108009 , 0, 'No existe Día fin de Traspaso en Parametros Generales')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108010 , 0, 'La fecha actual no se encuentra dentro del intervalo para realizar traspasos')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108011 , 0, 'No se pudo ingresar la solicitud de transpaso')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108012 , 0, 'No existen solicitudes de traspaso para la oficina seleccionada')
GO

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (108013 , 0, 'Uno de los clientes está asociado a un grupo y se encuentra en estado vigente')
GO

--Ingreso de datos en seqnos
delete cobis..cl_seqnos
where tabla = 'cl_solicitud_traspaso'
go

insert into cobis..cl_seqnos(bdatos, tabla, siguiente, pkey)
values ('cobis', 'cl_solicitud_traspaso', 0, 'st_solicitud')
go

--BORRADO DE REGISTROS

delete from  cobis..ad_procedure
 where pd_procedure in (8250)
   and pd_base_datos = 'cobis'
go

insert into ad_procedure values ( 8250,  'sp_traspaso',        'cobis',  'V', getdate(), 'sp_traspaso.sp')


print' Creacion de transacciones'

select * from cl_ttransaccion
where tn_trn_code in(8250, 8251, 8252, 8253, 8254, 8255)
--BORRADO DE REGISTROS

delete cobis..cl_ttransaccion
 where tn_trn_code in(8250, 8251,8252,8253,8254,8255)
go

--INSERCION DE TRANSACCIONES
insert into cl_ttransaccion values ( 8250,  'Consulta Clientes/Grupos traspaso',     '8250',        'CONSULTA CLIENTES\GRUPOS TRASPASO')
insert into cl_ttransaccion values ( 8251,  'Consulta solicitudes traspaso',     '8251',        'CONSULTA SOLICITUDES TRASPASO')
insert into cl_ttransaccion values ( 8252,  'Autorizacion solicitudes traspaso',     '8252',        'AUTORIZACION SOLICITUDES TRASPASO')
insert into cl_ttransaccion values ( 8253,  'Consulta oficinas traspaso',     '8253',        'CONSULTA OFICINAS TRASPASO')
insert into cl_ttransaccion values ( 8254,  'Consulta oficiales traspaso',     '8254',        'CONSULTA OFICIALES TRASPASO')
insert into cl_ttransaccion values ( 8255,  'Creacion de solicitudes traspaso',     '8255',        'CREACION DE SOLICITUDES TRASPASO')

print' Creacion de transacciones por producto'

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

insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8250,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8251,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8252,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8253,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8254,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8255,  'V', getdate(),   8250, null)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8250,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8251,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8252,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8253,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8254,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8255,            @w_moneda, getdate(),  1,'V', getdate())

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol

insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values(@w_resurce, @w_rol)
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

insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8250,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8251,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8252,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8253,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8254,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8255,  'V', getdate(),   8250, null)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8250,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8251,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8252,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8253,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8254,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8255,            @w_moneda, getdate(),  1,'V', getdate())

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol

insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values(@w_resurce, @w_rol)
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

insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8250,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8251,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8252,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8253,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8254,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8255,  'V', getdate(),   8250, null)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8250,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8251,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8252,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8253,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8254,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8255,            @w_moneda, getdate(),  1,'V', getdate())

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol

insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values(@w_resurce, @w_rol)
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

insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8250,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8251,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8252,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8253,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8254,  'V', getdate(),   8250, null)
insert into ad_pro_transaccion values ( 1, 'R', @w_moneda,  8255,  'V', getdate(),   8250, null)

delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
   and ta_transaccion in (8250, 8251, 8252, 8253, 8254, 8255)

insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8250,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8251,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8252,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8253,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8254,            @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)  
values ( 1,           'R',  @w_rol, 8255,            @w_moneda, getdate(),  1,'V', getdate())

/* Permisos a recursos */
select @w_resurce = re_id from cew_resource where re_pattern like '%/CSTMR/.*%'
delete cobis..cew_resource_rol 
where rro_id_resource = @w_resurce
and   rro_id_rol = @w_rol

insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
values(@w_resurce, @w_rol)
go

use cobis
GO
    
     IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateRequestTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'createRequestTransfer', csc_description = '', csc_trn = 8255 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.CreateRequestTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.CreateRequestTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createRequestTransfer', '', 8255)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchCustomerByOfficial', csc_description = '', csc_trn = 8250 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchCustomerByOfficial', '', 8250)
      GO

	  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchRequestTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchRequestTransfer', csc_description = '', csc_trn = 8251 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchRequestTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchRequestTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRequestTransfer', '', 8251)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchOfficeTransfer', csc_description = '', csc_trn = 8253 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchOfficeTransfer', '', 8253)
      GO
    
      IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'searchOfficialTransfer', csc_description = '', csc_trn = 8254 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchOfficialTransfer', '', 8254)
      GO
          
	  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'authorizationTransfer', csc_description = '', csc_trn = 8252 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.AuthorizationTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'authorizationTransfer', '', 8252)
      GO
	  
	  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'authorizationTransferDetail', csc_description = '', csc_trn = 8252 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'authorizationTransferDetail', '', 8252)
      GO

	  IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.RefuseTransfer')
        UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'refuseTransfer', csc_description = '', csc_trn = 8252 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.RefuseTransfer'
      ELSE
        INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.RefuseTransfer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'refuseTransfer', '', 8252)
      GO



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


declare @w_tabla int
select @w_tabla = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_param_notif', 'PARAMETROS NOTIFICACIONES CARTERA')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NXML', 'gruposvencigerent.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NJAS', 'GrupoVenciGeren.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NPDF', 'GrupoVenciGeren_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NXML', 'gruposvencicoord.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NJAS', 'GrupoVenciCoord.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NPDF', 'GrupoVenciCoord_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NXML', 'vencicuotas.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NJAS', 'AvisoVencCuotas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NPDF', 'AvisoVencCuotas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NXML', 'IncumplimientoAval.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NJAS', 'IncumplimientoAvalista.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NPDF', 'IncumplimientoAvalista_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NXML', 'pagogaraliq.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NJAS', 'GarantiasLiquidas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NPDF', 'GarantiasLiquidas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NXML', 'NotificacionGeneral.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NJAS', 'NotificacionGeneral.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NPDF', 'NotificacionGeneral_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NXML', 'ReferenciaPreCancelacion.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NJAS', 'ReferenciaPreCancelacion.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NPDF', 'ReferenciaPreCancelacion', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NXML', 'AccountStatus.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NJAS', 'AccountStatus.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NPDF', 'EstadoCuenta_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TRSPS_NXML', 'Traspaso.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TRSPS_NJAS', 'Traspaso.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'TRSPS_NPDF', 'Traspaso_', 'V')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'

insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('ca_param_notif')

go
