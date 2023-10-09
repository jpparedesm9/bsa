USE cobis
GO

DELETE FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.OnBoarding.SimulationTableAmortization'

DELETE FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.OnBoarding.SimulationTableAmortization'
GO

DELETE FROM cts_serv_catalog WHERE csc_service_id = 'IndividualLoan.DisbursementManagement.DisbursementOperation'

DELETE FROM ad_servicio_autorizado where ts_servicio = 'IndividualLoan.DisbursementManagement.DisbursementOperation'
GO