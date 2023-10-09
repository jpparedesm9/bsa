/* SCRIPT DE VERSIONAMIENTO */

print 'VERSION ACTUAL'

select *
  from cobis..an_module_group
  where mg_name in ('CON.resources', 'CON.SharedLibrary', 'CON.Company', 'CON.ChartAccounts', 'CON.ConsolidationCompanies', 'CON.TaxTables', 'CON.AccountingInterface', 'CON.Transactions', 'CON.OnlineConsultations', 'CON.ExcelQuery', 'CON.AuxiliaryQuery', 'CON.Reports')

print 'ACTUALIZACION'

update cobis..an_module_group
  set mg_version = '4.0.6892.6601'
  where mg_name in ('CON.resources', 'CON.SharedLibrary', 'CON.Company', 'CON.ChartAccounts', 'CON.ConsolidationCompanies', 'CON.TaxTables', 'CON.AccountingInterface', 'CON.Transactions', 'CON.OnlineConsultations', 'CON.ExcelQuery', 'CON.AuxiliaryQuery', 'CON.Reports')

print 'VERSION NUEVA'

select *
  from cobis..an_module_group
  where mg_name in ('CON.resources', 'CON.SharedLibrary', 'CON.Company', 'CON.ChartAccounts', 'CON.ConsolidationCompanies', 'CON.TaxTables', 'CON.AccountingInterface', 'CON.Transactions', 'CON.OnlineConsultations', 'CON.ExcelQuery', 'CON.AuxiliaryQuery', 'CON.Reports')

go
