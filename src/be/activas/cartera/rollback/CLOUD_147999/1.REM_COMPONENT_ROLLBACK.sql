use cobis
delete from an_component where co_name in ('Grupos Renovaci�n','Ingreso de Datos - Grupal Renovaci�n','Grupos Aprobar Pr�stamo Renovaci�n','Grupos Consulta Renovaci�n')

go

delete from ad_servicio_autorizado where ts_servicio = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

delete from cts_serv_catalog where csc_service_id = 'LoanGroup.GroupLoanAmountMaintenance.GetLoanAmountsRenovation'

go
