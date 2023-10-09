use cobis
delete from an_component where co_name in ('Grupos Renovación','Ingreso de Datos - Grupal Renovación','Grupos Aprobar Préstamo Renovación','Grupos Consulta Renovación')

go

delete from ad_servicio_autorizado where ts_servicio = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

delete from cts_serv_catalog where csc_service_id = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

go
