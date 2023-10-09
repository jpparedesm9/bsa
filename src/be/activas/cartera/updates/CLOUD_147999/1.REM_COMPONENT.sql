use cobis
delete from an_component where co_name in ('Grupos Renovación','Ingreso de Datos - Grupal Renovación','Grupos Aprobar Préstamo Renovación','Grupos Consulta Renovación')

declare @w_id int

select @w_id = max(co_id) + 1 from an_component

INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id, 73216, 'Grupos Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=INGRESO&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+1, 18, 'Ingreso de Datos - Grupal Renovación', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=GRUPAL&Tipo=R', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, 'WF')

INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+2, 73216, 'Grupos Aprobar Préstamo Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=APROBAR&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

INSERT INTO cobis..an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
VALUES (@w_id+3, 86018, 'Grupos Consulta Renovación', 'VC_GROUPCOMOS_387974_TASK.html?mode=2&Etapa=CONSULTA&Tipo=R', 'views/LOANS/GROUP/T_GROUPCOMPOIET_974/1.0.0/', 'I', NULL, 'WF')

go

delete from ad_servicio_autorizado where ts_servicio = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

delete from cts_serv_catalog where csc_service_id = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'getAmountRenovation', 'Consulta los montos del grupo renovacion', 0, NULL, NULL, 'N')


INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 1, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 2, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 3, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 4, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 5, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 6, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 7, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 8, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 10, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 11, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 12, 19, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 13, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 14, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 19, 2, 'R', 0, getDate(), 'V', getDate())
GO

INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation', 29, 2, 'R', 0, getDate(), 'V', getDate())
GO

