/* *************************************************************************  */
/*  Archivo:            3.loan_service.sql                                    */
/*  Base de datos:      3.loan_service.sql									  */
/* ************************************************************************** */
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/* ************************************************************************** */
/*              PROPOSITO                                                     */
/*  Insercion para la creacion del servicio de consulta de prestamos          */
/* ************************************************************************** */
/*              MODIFICACIONES                                                */
/* ************************************************************************** */
/* FECHA        VERSION       AUTOR              RAZON                        */
/* ************************************************************************** */
/* 27-AGO-2019                JSDV            Emision Inicial B2C             */
/* ************************************************************************** */

use cobis
go

-- Obtener Prestamos del cliente 
declare @w_rol smallint, @w_moneda tinyint
   
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'CMNAC' and pa_producto = 'ADM'

if exists (select * from cts_serv_catalog where csc_service_id = 'BusinessToConsumer.OperationsInfo.QueryLoans')
	update cts_serv_catalog set csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', csc_method_name = 'queryLoans', csc_description = '', csc_trn = 9999 where csc_service_id = 'BusinessToConsumer.OperationsInfo.QueryLoans'
else
    insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
	values ('BusinessToConsumer.OperationsInfo.QueryLoans', 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', 'queryLoans', '', 9999)

	
if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.OperationsInfo.QueryLoans')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.OperationsInfo.QueryLoans'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.OperationsInfo.QueryLoans', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 

-- ======================== BusinessToConsumer.OperationsInfo.ApplyPayment ========================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'BusinessToConsumer.OperationsInfo.ApplyPayment')
  UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', csc_method_name = 'applyPayment', csc_description = '', csc_trn = 9999 WHERE csc_service_id = 'BusinessToConsumer.OperationsInfo.ApplyPayment'
ELSE
  INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('BusinessToConsumer.OperationsInfo.ApplyPayment', 'cobiscorp.ecobis.businesstoconsumer.service.IOperationsInfo', 'applyPayment', '', 9999)

if exists (SELECT * FROM ad_servicio_autorizado where ts_servicio = 'BusinessToConsumer.OperationsInfo.ApplyPayment')
	update ad_servicio_autorizado set ts_rol = @w_rol, ts_producto =18 , ts_tipo = 'R', ts_moneda=@w_moneda, ts_fecha_aut=getdate(), ts_estado='V', ts_fecha_ult_mod=getdate() where ts_servicio = 'BusinessToConsumer.OperationsInfo.ApplyPayment'
else
	insert into cobis..ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto ,ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod) 
	values('BusinessToConsumer.OperationsInfo.ApplyPayment', @w_rol, 18, 'R', @w_moneda, getdate(), 'V', getdate()) 

go