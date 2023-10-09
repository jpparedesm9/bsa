/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S143427 Consulta de operaciones Grupales
--Fecha                      : 08/11/2017
--Descripción del Problema   : Se agrega un sp nuevo por lo que no tiene las respectivas autorizaciones y registros
--Descripción de la Solución : Generar el script para registrar el sp en las tablas respectivas
--Autor                      : Ma. Jose Taco
/**********************************************************************************************************************/

use cobis
go

delete cts_serv_catalog
where csc_service_id = 'Loan.LoanMaintenance.SearchLoanGroup'

delete ad_servicio_autorizado
where ts_servicio = 'Loan.LoanMaintenance.SearchLoanGroup'


declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


-------------------------
--SERVICIO CreateGroup
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('Loan.LoanMaintenance.SearchLoanGroup','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'searchLoanGroup', '', 0)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Loan.LoanMaintenance.SearchLoanGroup',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())
GO


