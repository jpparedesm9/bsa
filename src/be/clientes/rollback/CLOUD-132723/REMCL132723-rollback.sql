/**********************************************************************************************************************/
--Título Incidencia          : Requerimiento #132723: Cambio de Cuenta de Ahorros
--Fecha                      : 08/01/2020
--Descripción del Problema   : Se requiere permisos para servicio nuevo
--Descripción de la Solución : Agregar permisos de registro para el nuevo servicio
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- BORRAR AUTORIZACION DE SERVICIO
--------------------------------------------------------------------------------------------

delete cobis..cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.Queries.SearchAccountPriority'

delete cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.Queries.SearchAccountPriority'

--------------------------------------------------------------------------------------------
-- Rollback de Prelacion Cuentas
--------------------------------------------------------------------------------------------

truncate table cob_credito..cr_prelacion_cuenta

insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01', '0025', 'N5')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01', '0055', 'N2')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('01', '0056', 'N3')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('10', '0060', 'N6')
insert into cob_credito..cr_prelacion_cuenta (pc_producto, pc_subproducto, pc_nivel) values ('17', '0060', 'N4')
go