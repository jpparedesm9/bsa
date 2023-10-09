/**********************************************************************************************************************/
--Incidencia                 : SI
--Título de la Historia      : Incidencia Numero #84134 Campo Nivel de Riesgo
--Fecha                      : 07/08/2017
--Descripción del Problema   : Buscar la calificacion del cliente de la cl_ente
--Descripción de la Solución : Creación de Servicio para encontrar la calificacion del cliente de la cl_ente
--Autor                      : Patricio Samueza
--Instalador                 : cl_services_authorization.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_services_authorization.sql
/**********************************************************************************************************************/
USE cobis 
GO

declare @w_rol int,
        @w_producto int

select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

delete cts_serv_catalog
where csc_service_id in ('LoanGroup.MemberMaintenance.QueryCustomer')
delete ad_servicio_autorizado
where ts_servicio in ('LoanGroup.MemberMaintenance.QueryCustomer')

----------------------------------------------------
--Servicio que  Busca la calificacion de un cliente
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.QueryCustomer', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'queryCustomer', 'Consulta la aclificacion individual de un cliente', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.QueryCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

