/**********************************************************************/
/*   Archivo:         loanGroup_services_authorization.sql            */
/*   Data base:       cobiscts_serv_catalog*/
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*           Autorizacion de los servicios de LOANGROUP               */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   23-31-2017         Ma. Jose Taco          Emision Inicial        */
/**********************************************************************/
use cobis
go


-----------------
--BORRANDO DATA
-----------------

delete cts_serv_catalog
where csc_service_id in (
'LoanGroup.GroupMaintenance.CreateGroup',
'LoanGroup.GroupLoanAmountMaintenance.CreateLoanAmount',
'LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount',
'LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount',
'LoanGroup.GroupMaintenance.SearchGroup',
'LoanGroup.GroupMaintenance.UpdateGroup',
'LoanGroup.MemberMaintenance.DeleteMember',
'LoanGroup.MemberMaintenance.QueryMember',
'LoanGroup.MemberMaintenance.SearchMember',
'LoanGroup.MemberMaintenance.UpdateMember',
'LoanGroup.MemberMaintenance.CreateMember',
'LoanGroup.MemberMaintenance.SearchDebtor',
'LoanGroup.ReportMaintenance.GroupAccountHeader',
'LoanGroup.ReportMaintenance.GroupAccount',
'LoanGroup.ReportMaintenance.GroupAccountSummary',
'LoanGroup.ReportMaintenance.SettlementSheetDetail',
'LoanGroup.ReportMaintenance.SettlementSheetHeader',
'LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader',
'LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail',
'LoanGroup.ReportMaintenance.AmortizationTableHeader',
'LoanGroup.ReportMaintenance.AmortizationTableOperationHeader',
'LoanGroup.ReportMaintenance.AmortizationTableDetail',
'LoanGroup.ReportMaintenance.DisbursementOrderHeader',
'LoanGroup.ReportMaintenance.DisbursementOrderDetail',
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 
'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf',
'LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList',
'LoanGroup.ReportMaintenance.PaymentDetail',
'LoanGroup.ReportMaintenance.SearchKYC',
'LoanGroup.GroupLoanQuerys.LoanGroupQuery',
'LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts',
'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.DeleteCustomerReference',
'CustomerDataManagementService.CustomerManagement.CreateCustomerReference',
'CustomerDataManagementService.CustomerManagement.SearchCustomerReference',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerReference',
'CustomerDataManagementService.CustomerManagement.CreateAddressSan',
'CustomerDataManagementService.CustomerManagement.DeleteAddressSan',
'CustomerDataManagementService.CustomerManagement.UpdateAddressSan',
'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan',
'CustomerDataManagementService.CustomerManagement.SearchAddressByHome',
'CustomerDataManagementService.CustomerManagement.SearchZipPostal',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData',
'OrchestrationClientValidationServiceSERVImpl.validate',
'OrchestrationClientValidationServiceSERVImpl.validateBuroClient',
'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',
'WorkflowServiceSERVImpl.executeRule',
'LoanGroup.ScannedDocuments.QueryScannedDocuments',
'LoanGroup.ScannedDocuments.UpdateScannedDocuments',
'LoanProcess.LoanReportQuery.GetLoanData',
'LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge',
'CustomerDataManagementService.CustomerManagement.SearchRelationClient',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile',
'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse',
'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer',
'CustomerDataManagementService.Queries.ReadMinimumAgeParameter',
'CustomerDataManagementService.Queries.ReadIdExpirationParameter',
'CustomerDataManagementService.Queries.SearchDocumentTypes',
'CustomerDataManagementService.Queries.ReadSpouse',
'CustomerDataManagementService.CustomerManagement.CreateGeoreferencing',
'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse',
'CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect',
'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect',
'CustomerDataManagementService.CustomerManagement.SearchRelation',
'CustomerDataManagementService.CustomerManagement.ReadCustomerInfo',
'CustomerDataManagementService.CustomerManagement.SearchRelationPerson',
'CustomerDataManagementService.CustomerManagement.UpdateCustomer',
'CustomerDataManagementService.CustomerManagement.DeleteAllRelation',
'CustomerDataManagementService.CustomerManagement.CheckRelationship',
'CustomerDataManagementService.OfficialManagement.SearchOfficials',
'CustomerDataManagementService.CountryManagement.ReadCountry',
'CustomerDataManagementService.CustomerManagement.SearchEconomicActivity',
'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness',
'LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount',
'CustomerDataManagementService.CustomerManagement.SearchPepPerson',
'CustomerDataManagementService.CustomerManagement.SearchTelephone',
'CustomerDataManagementService.CustomerManagement.CreateTelephone',
'CustomerDataManagementService.CustomerManagement.DeleteTelephone',
'CustomerDataManagementService.CustomerManagement.UpdateTelephone',
'Loan.LoanMaintenance.SearchLoanGroup',
'CustomerDataManagementService.CustomerManagement.DeleteRelation',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerCURPRFC',
'LoanGroup.GroupLoanAmountMaintenance.ReadGroupApplication',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationReferencesCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationBusinessCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationInfoCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationAddress',
'CustomerDataManagementService.CustomerManagement.ReadComplementary',
'CustomerDataManagementService.ReportsManagement.InternalExternalCreditReport',
'CustomerDataManagementService.ReportsManagement.HistoricalCreditReport',
'CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau',
'CustomerDataManagementService.ReportsManagement.UpdateBuroMistake',
'LoanGroup.ReportMaintenance.SearchConsentCertificat',
'LoanGroup.RiskLevelManagement.QueryQualificationRange', 
'LoanGroup.RiskLevelManagement.QueryRiskMatrix',
'CustomerDataManagementService.CustomerManagement.CreateReportOpeInusual',
'CustomerDataManagementService.CustomerManagement.CreateAlert',
'CustomerDataManagementService.CustomerManagement.DeleteAlert',
'CustomerDataManagementService.CustomerManagement.SearchAlert',
'CustomerDataManagementService.CustomerManagement.SearchRisk',
'CustomerDataManagementService.CustomerManagement.UpdateRisk',
'LoanProcess.LoanReportQuery.GetInfoApplication',
'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount',
'LoanGroup.ScannedDocuments.ValidateUploadedFI',
'CustomerDataManagementService.CustomerManagement.ValidateAddress',
'CustomerDataManagementService.Queries.SearchAccountPriority',
'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
'CustomerDataManagementService.CustomerManagement.SearchExclusionList',
'CustomerDataManagementService.CustomerManagement.VerifyContact'
'CustomerDataBusiness.BusinessResearch.GetFormData', 'Collective.CollectiveEntity.QueryAdvisorRole',
'Collective.CollectiveEntity.QueryOfficialByRole',
'Collective.CollectiveEntity.InsertAdvisorRole',
'Collective.CollectiveEntity.DeleteAdvisorRole',
'Collective.CollectiveEntity.UpdateProspectsFile',
'Collective.CollectiveEntity.ValidateProspectsFile',
'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection',
'CustomerBiocheck.CustomerBiocheck.SaveRegistry',
'CustomerBiocheck.CustomerBiocheck.QueryRegistry',

'CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint',
'CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken',
'OrchestrationBiometricServiceSERVImpl.renapoQueryByDetail',
'OrchestrationBiometricServiceSERVImpl.accessToken',
'OrchestrationBiometricServiceSERVImpl.opaqueToken',
'OrchestrationBiometricServiceSERVImpl.accessTokenBC',
'SystemConfiguration.EquivalenceManagement.QueryEquivalences',
'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount',
'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck',
'CustomerBiocheck.CustomerBiocheck.QueryOfficeId',
'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp'
)


delete ad_servicio_autorizado
where ts_servicio in (
'LoanGroup.GroupMaintenance.CreateGroup',
'LoanGroup.GroupLoanAmountMaintenance.CreateLoanAmount',
'LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount',
'LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount',
'LoanGroup.GroupMaintenance.SearchGroup',
'LoanGroup.GroupMaintenance.UpdateGroup',
'LoanGroup.MemberMaintenance.DeleteMember',
'LoanGroup.MemberMaintenance.QueryMember',
'LoanGroup.MemberMaintenance.SearchMember',
'LoanGroup.MemberMaintenance.UpdateMember',
'LoanGroup.MemberMaintenance.CreateMember',
'LoanGroup.MemberMaintenance.SearchDebtor',
'LoanGroup.ReportMaintenance.GroupAccountHeader',
'LoanGroup.ReportMaintenance.GroupAccount',
'LoanGroup.ReportMaintenance.GroupAccountSummary',
'LoanGroup.ReportMaintenance.SettlementSheetDetail',
'LoanGroup.ReportMaintenance.SettlementSheetHeader',
'LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader',
'LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail',
'LoanGroup.ReportMaintenance.AmortizationTableHeader',
'LoanGroup.ReportMaintenance.AmortizationTableOperationHeader',
'LoanGroup.ReportMaintenance.AmortizationTableDetail',
'LoanGroup.ReportMaintenance.DisbursementOrderHeader',
'LoanGroup.ReportMaintenance.DisbursementOrderDetail',
'LoanGroup.ReportMaintenance.SearchRecurringCharge', 
'LoanGroup.ReportMaintenance.SearchGroupCreditCover',
'LoanGroup.ReportMaintenance.SearchPromissoryNoteInf',
'LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList',
'LoanGroup.ReportMaintenance.PaymentDetail',
'LoanGroup.ReportMaintenance.SearchKYC',
'LoanGroup.GroupLoanQuerys.LoanGroupQuery',
'LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts',
'CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness',
'CustomerDataManagementService.CustomerManagement.DeleteCustomerReference',
'CustomerDataManagementService.CustomerManagement.CreateCustomerReference',
'CustomerDataManagementService.CustomerManagement.SearchCustomerReference',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerReference',
'CustomerDataManagementService.CustomerManagement.CreateAddressSan',
'CustomerDataManagementService.CustomerManagement.DeleteAddressSan',
'CustomerDataManagementService.CustomerManagement.UpdateAddressSan',
'CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan',
'CustomerDataManagementService.CustomerManagement.SearchAddressByHome',
'CustomerDataManagementService.CustomerManagement.SearchZipPostal',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData',
'OrchestrationClientValidationServiceSERVImpl.validate',
'OrchestrationClientValidationServiceSERVImpl.validateBuroClient',
'OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',
'WorkflowServiceSERVImpl.executeRule',
'LoanGroup.ScannedDocuments.QueryScannedDocuments',
'LoanGroup.ScannedDocuments.UpdateScannedDocuments',
'LoanProcess.LoanReportQuery.GetLoanData',
'LoanProcess.LoanReportQuery.GetCustomerData',
'LoanProcess.LoanReportQuery.SearchIndivCreditCover',
'LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',
'LoanProcess.LoanReportQuery.SearchLoanRecurringCharge',
'CustomerDataManagementService.CustomerManagement.SearchRelationClient',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile',
'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse',
'CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer',
'CustomerDataManagementService.Queries.ReadMinimumAgeParameter',
'CustomerDataManagementService.Queries.ReadIdExpirationParameter',
'CustomerDataManagementService.Queries.SearchDocumentTypes',
'CustomerDataManagementService.Queries.ReadSpouse',
'CustomerDataManagementService.CustomerManagement.CreateGeoreferencing',
'CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse',
'CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect',
'CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect',
'CustomerDataManagementService.CustomerManagement.SearchRelation',
'CustomerDataManagementService.CustomerManagement.ReadCustomerInfo',
'CustomerDataManagementService.CustomerManagement.SearchRelationPerson',
'CustomerDataManagementService.CustomerManagement.UpdateCustomer',
'CustomerDataManagementService.CustomerManagement.DeleteAllRelation',
'CustomerDataManagementService.CustomerManagement.CheckRelationship',
'CustomerDataManagementService.OfficialManagement.SearchOfficials',
'CustomerDataManagementService.CountryManagement.ReadCountry',
'CustomerDataManagementService.CustomerManagement.SearchEconomicActivity',
'CustomerDataManagementService.CustomerManagement.SearchAddresBusiness',
'LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount',
'CustomerDataManagementService.CustomerManagement.SearchPepPerson',
'CustomerDataManagementService.CustomerManagement.SearchTelephone',
'CustomerDataManagementService.CustomerManagement.CreateTelephone',
'CustomerDataManagementService.CustomerManagement.DeleteTelephone',
'CustomerDataManagementService.CustomerManagement.UpdateTelephone',
'Loan.LoanMaintenance.SearchLoanGroup',
'CustomerDataManagementService.CustomerManagement.DeleteRelation',
'CustomerDataManagementService.CustomerManagement.UpdateCustomerCURPRFC',
'LoanGroup.GroupLoanAmountMaintenance.ReadGroupApplication',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationReferencesCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationBusinessCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationInfoCustomer',
'LoanGroup.ReportMaintenance.LongIndividualCreditApplicationAddress',
'CustomerDataManagementService.CustomerManagement.ReadComplementary',
'CustomerDataManagementService.ReportsManagement.InternalExternalCreditReport',
'CustomerDataManagementService.ReportsManagement.HistoricalCreditReport',
'CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau',
'CustomerDataManagementService.ReportsManagement.UpdateBuroMistake'
'LoanGroup.ReportMaintenance.SearchConsentCertificat',
'LoanGroup.RiskLevelManagement.QueryQualificationRange',
'LoanGroup.RiskLevelManagement.QueryRiskMatrix',
'CustomerDataManagementService.CustomerManagement.CreateReportOpeInusual',
'CustomerDataManagementService.CustomerManagement.CreateAlert',
'CustomerDataManagementService.CustomerManagement.DeleteAlert',
'CustomerDataManagementService.CustomerManagement.SearchAlert',
'CustomerDataManagementService.CustomerManagement.SearchRisk',
'CustomerDataManagementService.CustomerManagement.UpdateRisk',
'LoanProcess.LoanReportQuery.GetInfoApplication',
'LoanGroup.ScannedDocuments.ValidateUploadedFI',
'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount',
'CustomerDataManagementService.CustomerManagement.ValidateAddress',
'CustomerDataManagementService.Queries.SearchAccountPriority',
'CustomerDataManagementService.CustomerManagement.UpdateAltairAccount',
'CustomerDataBusiness.BusinessResearch.GetFormData'
'CustomerDataManagementService.Queries.SearchAccountPriority',
'CustomerDataManagementService.CustomerManagement.CreateExclusionList',
'CustomerDataManagementService.CustomerManagement.DeleteExclusionList',
'CustomerDataManagementService.CustomerManagement.QueryExclusionList', 
'CustomerDataManagementService.CustomerManagement.SearchExclusionList',
'CustomerDataManagementService.CustomerManagement.VerifyContact'
'Collective.CollectiveEntity.QueryAdvisorRole',
'Collective.CollectiveEntity.QueryOfficialByRole',
'Collective.CollectiveEntity.InsertAdvisorRole',
'Collective.CollectiveEntity.DeleteAdvisorRole',
'Collective.CollectiveEntity.UpdateProspectsFile',
'Collective.CollectiveEntity.ValidateProspectsFile',
'CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection',
'CustomerBiocheck.CustomerBiocheck.SaveRegistry',
'CustomerBiocheck.CustomerBiocheck.QueryRegistry',
'CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint',
'CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken',
'OrchestrationBiometricServiceSERVImpl.renapoQueryByDetail',
'OrchestrationBiometricServiceSERVImpl.accessToken',
'OrchestrationBiometricServiceSERVImpl.opaqueToken',
'OrchestrationBiometricServiceSERVImpl.accessTokenBC',
'SystemConfiguration.EquivalenceManagement.QueryEquivalences',
'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount',
'CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck',
'CustomerBiocheck.CustomerBiocheck.QueryOfficeId',
'OrchestationRenapoServiceSERVImpl.renapoQueryByCurp'
)

declare @w_rol int,
        @w_rol2 int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_rol2 = ro_rol from cobis..ad_rol where ro_descripcion = 'ASESOR'

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'


-------------------------
--SERVICIO CreateGroup
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('LoanGroup.GroupMaintenance.CreateGroup', 'cobiscorp.ecobis.loangroup.service.IGroupMaintenance', 'createGroup', '', 800)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('LoanGroup.GroupMaintenance.CreateGroup',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-----------------------------
--SERVICIO CreateLoanAmount
-----------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.GroupLoanAmountMaintenance.CreateLoanAmount', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'createLoanAmount', 'Crea Montos de prestamos en el grupo', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.GroupLoanAmountMaintenance.CreateLoanAmount', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------
--SERVICIO ListLoanAmount
-----------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'listLoanAmount', 'Consulta los montos del grupo', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------
--SERVICIO UpdateLoanAmount
-----------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'updateLoanAmount', 'Actualiza los montos del grupo', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO SearchGroup
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.GroupMaintenance.SearchGroup', 'cobiscorp.ecobis.loangroup.service.IGroupMaintenance', 'searchGroup', 'Busqueda de grupos', 800, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.GroupMaintenance.SearchGroup', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO UpdateGroup
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.GroupMaintenance.UpdateGroup', 'cobiscorp.ecobis.loangroup.service.IGroupMaintenance', 'updateGroup', 'Actualizacion de grupos', 800, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.GroupMaintenance.UpdateGroup', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO DeleteMember
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.DeleteMember', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'deleteMember', 'eliminar miembros del grupo', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.DeleteMember', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO QueryMember
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.QueryMember', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'queryMember', 'Consulta informacion del cliente del grupo', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.QueryMember', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO SearchMember
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.SearchMember', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'searchMember', 'Buscar los miembros del grupo', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.SearchMember', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO UpdateMember
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.UpdateMember', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'updateMember', 'Actualizar miembros del grupo', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.UpdateMember', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO CreateMember
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.MemberMaintenance.CreateMember', 'cobiscorp.ecobis.loangroup.service.IMemberMaintenance', 'createMember', 'Creacion de Miembros', 810, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.MemberMaintenance.CreateMember', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------------
--SERVICIO GroupAccountHeader
------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.GroupAccountHeader'   , 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'groupAccountHeader',   '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.GroupAccountHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

------------------------
--SERVICIO GroupAccount
------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.GroupAccount', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'groupAccountPayment', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.GroupAccount', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------------
--SERVICIO GroupAccountSummary
-------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.GroupAccountSummary','cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'groupAccountSummary', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.GroupAccountSummary', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

---------------------------------
--SERVICIO SettlementSheetDetail
---------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.SettlementSheetDetail', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'settlementSheetDetail', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.SettlementSheetDetail', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

---------------------------------
--SERVICIO SettlementSheetHeader
---------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.SettlementSheetHeader', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'settlementSheetHeader',   '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.SettlementSheetHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------------------------
--SERVICIO AccountStatusConsolidatedHeader
-------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'accountStatusConsolidatedHeader', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------------------------
--SERVICIO AccountStatusConsolidatedDetail
-------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'accountStatusConsolidatedDetail', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------------------------
--SERVICIO AmortizationTableHeader
-------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.AmortizationTableHeader', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'amortizationTableHeader',   '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.AmortizationTableHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------------------------
--SERVICIO AmortizationTableOperationHeader
-------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.AmortizationTableOperationHeader', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'amortizationTableOperationHeader',   '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.AmortizationTableOperationHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO AmortizationTableDetail
-----------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.AmortizationTableDetail', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'amortizationTableDetail', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.AmortizationTableDetail', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO DisbursementOrderHeader
-----------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.DisbursementOrderHeader', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'disbursementOrderHeader', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.DisbursementOrderHeader', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO DisbursementOrderDetail
-----------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.DisbursementOrderDetail', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'disbursementOrderDetail', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.DisbursementOrderDetail', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO PaymentDetail
-----------------------------------
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ReportMaintenance.PaymentDetail','cobiscorp.ecobis.loangroup.service.IReportMaintenance','paymentDetail', '',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.ReportMaintenance.PaymentDetail', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate() )
-----------------------------------
--SERVICIO CreateCustomerBusiness
-----------------------------------
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createCustomerBusiness', '', 1709, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO SearchCustomerBusiness
-----------------------------------    
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchCustomerBusiness', '', 1712, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO UpdateCustomerBusiness
-----------------------------------  
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerBusiness', '', 1709, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO DeleteCustomerBusiness
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteCustomerBusiness', '', 1711, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO CreateCustomerReference
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.CreateCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createCustomerReference', '', 177, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.CreateCustomerReference', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO DeleteCustomerReference
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.DeleteCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteCustomerReference', '', 1130, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteCustomerReference', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO SearchCustomerReference
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.SearchCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchCustomerReference', '', 136, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchCustomerReference', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO UpdateCustomerReference
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerReference', '', 178, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerReference', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-----------------------------------
--SERVICIO CreateAddressSan
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.CreateAddressSan', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createAddressSan', '', 109, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.CreateAddressSan', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-----------------------------------
--SERVICIO deleteAddressSan
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.DeleteAddressSan', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteAddressSan', '', 1226, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteAddressSan', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-----------------------------------
--SERVICIO updateAddressSan
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateAddressSan', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateAddressSan', '', 110, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateAddressSan', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-----------------------------------
--SERVICIO SearchAddresProspectSan
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddresProspectSan', '', 1227, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())



-----------------------------------
--SERVICIO SearchAddresByHome
----------------------------------- 
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchAddressByHome', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddressByHome', '', 1712, null, null, 'N')

insert into cobis..ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchAddressByHome', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO SearchZipPostal
----------------------------------- 
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchZipPostal',  'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchZipPostal', '', 0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchZipPostal', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----------------------------------------------------------------------------------
-- SERVICIO VerifyContact
-- Se realiza el caso 203621 en 193221 verificacion de Celular/Correo
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
VALUES ('CustomerDataManagementService.CustomerManagement.VerifyContact', 
	'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'verifyContact', '', 0)

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.VerifyContact', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----------------------------------
--SERVICIO SearchRecurringCharge
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchRecurringCharge',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchRecurringCharge','searchRecurringCharge', 21274, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchRecurringCharge', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchGroupCreditCover
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditCover',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditCover','searchGroupCreditCover', 21274, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditCover', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchGroupCreditPaymentList
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchGroupCreditPaymentList','searchGroupCreditPaymentList', 21274, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchPromissoryNoteInf
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf',  'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchPromissoryNoteInf','searchPromissoryNoteInf', 21274, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.ReportMaintenance.SearchPromissoryNoteInf', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchKYC
----------------------------------- 
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.ReportMaintenance.SearchKYC','cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchKYC', '', 1718, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.SearchKYC',@w_rol, @w_producto,'R',0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO LoanGroupQuery
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.GroupLoanQuerys.LoanGroupQuery',  'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', 'loanGroupQuery','loanGroupQuery', 21821, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanQuerys.LoanGroupQuery', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO LoanGroupMembersAmounts
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts',  'cobiscorp.ecobis.loangroup.service.IGroupLoanQuerys', 'loanGroupMembersAmounts','loanGroupMembersAmounts', 21821, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validate
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validate','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validate',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validate',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())




----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClient
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroClient','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateBuroClient',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClient',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())




----------------------------------------------------------------------------------
-- Instalacion de: OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService',
       'validateBuroClientGroup',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('OrchestrationClientValidationServiceSERVImpl.validateBuroClientGroup',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: WorkflowServiceSERVImpl.executeRule
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog 
      (csc_service_id,                                    csc_class_name,                                                                
       csc_method_name,                                   csc_description,
       csc_trn,                                           csc_support_offline,
       csc_component,                                     csc_procedure_validation)
values('WorkflowServiceSERVImpl.executeRule','com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IWorkflowService',
       'executeRule',                                      'Description',  
       null,                                                 null,
       null,                                              'N')   

insert into cobis..ad_servicio_autorizado
(ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values
('WorkflowServiceSERVImpl.executeRule',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: LoanGroup.ScannedDocuments.QueryScannedDocuments
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ScannedDocuments.QueryScannedDocuments','cobiscorp.ecobis.loangroup.service.IScannedDocuments',
'queryScannedDocuments','Consulta de documentos por miembros del grupo',21365,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.ScannedDocuments.QueryScannedDocuments',@w_producto,'R',0,getdate(),@w_rol,'V',getdate())


----------------------------------------------------------------------------------
-- Instalacion de: LoanGroup.ScannedDocuments.UpdateScannedDocuments
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.ScannedDocuments.UpdateScannedDocuments','cobiscorp.ecobis.loangroup.service.IScannedDocuments',
'updateScannedDocuments','Actualización de documentos por miembros del grupo',21365,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.ScannedDocuments.UpdateScannedDocuments',@w_producto,'R',0,getdate(),@w_rol,'V',getdate())

----------------------------------------------------------------------------------
-- Instalacion de: 'LoanGroup.MemberMaintenance.SearchDebtor'
----------------------------------------------------------------------------------

insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values ('LoanGroup.MemberMaintenance.SearchDebtor','cobiscorp.ecobis.loangroup.service.IMemberMaintenance',
'searchDebtor','',810,null,null,'N')

insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.MemberMaintenance.SearchDebtor',@w_producto,'R',0,getdate(),@w_rol,'V',getdate())

-----------------------------------
--SERVICIO GetLoanData
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.GetLoanData',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'getLoanData','getLoanData', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.GetLoanData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-----------------------------------
--SERVICIO GetCustomerData
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.GetCustomerData',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'getCustomerData','getCustomerData', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.GetCustomerData', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchIndivCreditCover
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditCover',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditCover','searchIndivCreditCover', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditCover', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchIndivCreditPaymentList
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchIndivCreditPaymentList','searchIndivCreditPaymentList', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-----------------------------------
--SERVICIO SearchLoanRecurringCharge
----------------------------------- 
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation )
values('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge',  'cobiscorp.ecobis.loanprocess.service.ILoanReportQuery', 'searchLoanRecurringCharge','searchLoanRecurringCharge', 21275, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('LoanProcess.LoanReportQuery.SearchLoanRecurringCharge', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

----------------------------------------------------
--Servicio searchRelationClient
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchRelationClient', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRelationClient', 'Obtiene el RFC de la relacion de un cliente', 7067120, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchRelationClient', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio UpdateCustomerMobile
----------------------------------------------------
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerMobile', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerMobile', '', 104, null, null, 'N')

----------------------------------------------------
--Servicio Create Spouse
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'createNaturalProspectSpouse', 'Crea el conyuge de un cliente', 73935, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio Search Spouse
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchSpouseCustomer', 'Busca el conyuge de un cliente', 132, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

--------------------
--Nuevos registros
---------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.Queries.ReadMinimumAgeParameter', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'readMinimumAgeParameter', 'readMinimumAgeParameter', 1579, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.Queries.ReadMinimumAgeParameter',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.Queries.ReadIdExpirationParameter', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'readIdExpirationParameter', 'readIdExpirationParameter', 1579, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.Queries.ReadIdExpirationParameter',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

---

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.Queries.SearchDocumentTypes', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'searchDocumentTypes', 'searchDocumentTypes', 1445, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.Queries.SearchDocumentTypes',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----

INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.Queries.ReadSpouse', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'readSpouse', 'readSpouse', 1304, NULL, NULL, NULL)

INSERT INTO dbo.ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.Queries.ReadSpouse',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
---------------------

---
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateGeoreferencing', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createGeoreferencing', '', 1608, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateGeoreferencing',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


---
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'createNaturalProspectAndSpouse', '', 0, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'updateNaturalProspect', ' ', 1288, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'insertRelationNaturalProspect', ' ', 1367, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
---
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchRelation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRelation', '', 0, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchRelation',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
----
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.ReadCustomerInfo', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'readCustomerInfo', '', 132, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.ReadCustomerInfo',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
-----
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchRelationPerson', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRelationPerson', '', 139, NULL, NULL, NULL)

INSERT INTO ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchRelationPerson',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-----
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.UpdateCustomer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomer', 'updateCustomer', 104, NULL, NULL, NULL)

INSERT INTO dbo.ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.UpdateCustomer',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----------------------------------------------------
--Servicio DeleteAllRelation
----------------------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteAllRelation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteAllRelation', 'deleteAllRelation', 1368, NULL, NULL, NULL)

INSERT INTO dbo.ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteAllRelation',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----------------------------------------------------
--Servicio CheckRelationship
----------------------------------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.CheckRelationship', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'checkRelationship', 'checkRelationship', 1367, NULL, NULL, NULL)

INSERT INTO dbo.ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CheckRelationship',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
----------------------------------------------------
--Servicio SearchOfficials
----------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('CustomerDataManagementService.OfficialManagement.SearchOfficials', 'cobiscorp.ecobis.customerdatamanagementservice.service.IOfficialManagement', 'searchOfficials', 'searchOfficials', 15153, NULL, NULL, NULL)

insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('CustomerDataManagementService.OfficialManagement.SearchOfficials',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio ReadCountry
----------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('CustomerDataManagementService.CountryManagement.ReadCountry', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICountryManagement', 'readCountry', 'readCountry', 1553, NULL, NULL, NULL)

insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('CustomerDataManagementService.CountryManagement.ReadCountry',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio SearchEconomicActivity
----------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.SearchEconomicActivity', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchEconomicActivity', '', 2436, NULL, NULL, NULL)

insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('CustomerDataManagementService.CustomerManagement.SearchEconomicActivity',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----------------------------------------------------
--Servicio SearchAddresBusiness
----------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('CustomerDataManagementService.CustomerManagement.SearchAddresBusiness', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAddresBusiness', '', 1227, NULL, NULL, NULL)

insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('CustomerDataManagementService.CustomerManagement.SearchAddresBusiness',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


----------------------------------------------------
--Servicio SearchAddresBusiness
----------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount', 'cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance', 'calcLoanAmount', '', 0, NULL, NULL, NULL)

insert into ad_servicio_autorizado 
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.GroupLoanAmountMaintenance.CalcLoanAmount',@w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
----------------------------------------------------
--Servicio SearchPepPerson
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchPepPerson', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchPepPerson', 'busca si el cliente es una persona PEP',21318, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchPepPerson', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio SearchTelephone
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.SearchTelephone', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchTelephone', 'busca los telefonos de una direccion',147, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchTelephone', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio CreateTelephone
----------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.CreateTelephone', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createTelephone', '', 111)

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.CreateTelephone', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio DeleteTelephone
----------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.DeleteTelephone', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteTelephone', '', 148)

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteTelephone', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio UpdateTelephone
----------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.UpdateTelephone', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateTelephone', '', 112)
 
insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateTelephone', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO CreateGroup
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('Loan.LoanMaintenance.SearchLoanGroup','cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'searchLoanGroup', '', 0)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('Loan.LoanMaintenance.SearchLoanGroup',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())


----------------------------------------------------
--Servicio DeleteRelation
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.DeleteRelation', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteRelation', 'busca si el cliente es una persona PEP',1368, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteRelation', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio DeleteRelation
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerCURPRFC', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerCURPRFC', 'Actualizacion de CURP y RFC',104, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerCURPRFC', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio ReadGroupApplication
----------------------------------------------------
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_component, csc_support_offline, csc_procedure_validation)
values ('LoanGroup.GroupLoanAmountMaintenance.ReadGroupApplication','cobiscorp.ecobis.loangroup.service.IGroupLoanAmountMaintenance','readGroupApplication', 'Consulta Tramite Grupal Sincroniza',0, null, null, null)

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values ('LoanGroup.GroupLoanAmountMaintenance.ReadGroupApplication', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio LongIndividualCreditApplicationReferencesCustomer
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationReferencesCustomer', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'longIndividualCreditApplicationReferencesCustomer', 'Informacion Report SolicitudIndividual Larga Info Refrencias',0, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationReferencesCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio LongIndividualCreditApplicationBusinessCustomer
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationBusinessCustomer', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'longIndividualCreditApplicationBusinessCustomer', 'Informacion Report SolicitudIndividual Larga Info Negocios',0, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationBusinessCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio LongIndividualCreditApplicationInfoCustomer
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationInfoCustomer', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'longIndividualCreditApplicationInfoCustomer', 'Informacion Report SolicitudIndividual Larga Info Cliente',0, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationInfoCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio LongIndividualCreditApplicationAddress
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationAddress', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'longIndividualCreditApplicationAddress', 'Informacion Report SolicitudIndividual Larga Info Direccion',0, null, null, 'N')

insert into ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.LongIndividualCreditApplicationAddress', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio UpdateCustomerComplementaryData
----------------------------------------------------
INSERT INTO cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
VALUES ('CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCustomerComplementaryData', '', 104)

insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio ReadComplementary
----------------------------------------------------
insert into cts_serv_catalog 
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.ReadComplementary', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'readComplementary', '', 132)

insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.ReadComplementary', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio QueryBureau
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau', 'cobiscorp.ecobis.customerdatamanagementservice.service.INaturalProspectManagement', 'queryReportBureau', 'Determinar impresion de reporte',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio HistoricalCreditReport
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.ReportsManagement.HistoricalCreditReport', 'cobiscorp.ecobis.customerdatamanagementservice.service.IReportsManagement', 'historicalCreditReport', 'Reporte Buro Historico',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.ReportsManagement.HistoricalCreditReport', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio InternalExternalCreditReport
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.ReportsManagement.InternalExternalCreditReport', 'cobiscorp.ecobis.customerdatamanagementservice.service.IReportsManagement', 'internalExternalCreditReport', 'Reporte de Buro Interno',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.ReportsManagement.InternalExternalCreditReport', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

----------------------------------------------------
--Servicio UpdateBuroMistake
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.ReportsManagement.UpdateBuroMistake', 'cobiscorp.ecobis.customerdatamanagementservice.service.IReportsManagement', 'updateBuroMistake', 'Actualiza campo para buro auxilar',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.ReportsManagement.UpdateBuroMistake', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())
		

----------------------------------------------------
--Servicio SearchConsentCertificat
----------------------------------------------------
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ReportMaintenance.SearchConsentCertificat', 'cobiscorp.ecobis.loangroup.service.IReportMaintenance', 'searchConsentCertificate', 'Obtiene informacion para Reportes',0, null, null, 'N')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ReportMaintenance.SearchConsentCertificat', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO QueryQualificationRange
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('LoanGroup.RiskLevelManagement.QueryQualificationRange', 'cobiscorp.ecobis.loangroup.service.IRiskLevelManagement', 'queryQualificationRange', '', 800)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('LoanGroup.RiskLevelManagement.QueryQualificationRange',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO QueryQualificationRange
-------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('LoanGroup.RiskLevelManagement.QueryRiskMatrix', 'cobiscorp.ecobis.loangroup.service.IRiskLevelManagement', 'queryRiskMatrix', '', 800)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('LoanGroup.RiskLevelManagement.QueryRiskMatrix',@w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO CreateReportOpeInusual
-------------------------
insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.CreateReportOpeInusual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

insert into cobis..ad_servicio_autorizado 
values('CustomerDataManagementService.CustomerManagement.CreateReportOpeInusual', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
-------------------------
--SERVICIO createAlert
-------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataManagementService.CustomerManagement.CreateAlert', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createAlert', '', 1713)
 
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.CreateAlert', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
 
 -------------------------
--SERVICIO deleteAlert
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.DeleteAlert', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteAlert', '', 1714)

insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.DeleteAlert', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

 -------------------------
--SERVICIO searchAlert
-------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.SearchAlert', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchAlert', '', 1715)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchAlert', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

 -------------------------
--SERVICIO searchRisk
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.SearchRisk', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'searchRisk', '', 1716)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.SearchRisk', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

 -------------------------
--SERVICIO updateRisk
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.UpdateRisk', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateRisk', '', 1717)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateRisk', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO GetInfoApplication
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn)
values ('LoanProcess.LoanReportQuery.GetInfoApplication','cobiscorp.ecobis.loanprocess.service.ILoanReportQuery','getInfoApplication', '',21275)

insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values ('LoanProcess.LoanReportQuery.GetInfoApplication', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate() )

-------------------------
--SERVICIO ValidateUploadedFI
-------------------------	
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('LoanGroup.ScannedDocuments.ValidateUploadedFI',  'cobiscorp.ecobis.loangroup.service.IScannedDocuments', 'validateUploadedFI', '', 0, null, null, 'N')
 
insert into ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('LoanGroup.ScannedDocuments.ValidateUploadedFI', @w_producto, 'R', @w_moneda, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO UpdateAltairAccount
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.UpdateAltairAccount', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateAltairAccount', '', 104)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateAltairAccount', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO ValidateAddress
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CustomerManagement.ValidateAddress', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'validateAddress', '', 1227)

	  	
-------------------------
--SERVICIO SearchAccountPriority
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.Queries.SearchAccountPriority', 'cobiscorp.ecobis.customerdatamanagementservice.service.IQueries', 'searchAccountPriority', '', 0)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataManagementService.Queries.SearchAccountPriority', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO CreateExclusionList
-------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'createExclusionList', 'createExclusionList', 610, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.CreateExclusionList', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())


-------------------------
--SERVICIO DeleteExclusionList
-------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'deleteExclusionList', 'deleteExclusionList', 611, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.DeleteExclusionList',  @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO QueryExclusionList
-------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.QueryExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'queryExclusionList', 'queryExclusionList', 613, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.QueryExclusionList', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO SearchExclusionList
-------------------------
INSERT INTO dbo.cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchExclusionList', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'queryExclusionList', 'searchExclusionList', 612, NULL, NULL, NULL)
INSERT INTO dbo.ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES ('CustomerDataManagementService.CustomerManagement.SearchExclusionList', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())

-------------------------
--SERVICIO GetFormData
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.BusinessResearch.GetFormData', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'getFormData', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataBusiness.BusinessResearch.GetFormData', @w_rol2,@w_producto,'R',0,getdate(),'V',getdate())

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.BusinessResearch.GetAnswers', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'getAnswers', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataBusiness.BusinessResearch.GetAnswers', @w_rol2,@w_producto,'R',0,getdate(),'V',getdate())

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.CustomerResearch.getCustomerByProcess', 'cobiscorp.ecobis.customerdatabusiness.service.ICustomerResearch', 'getCustomerByProcess', '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataBusiness.CustomerResearch.getCustomerByProcess', @w_rol2,@w_producto,'R',0,getdate(),'V',getdate())

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn )
values ('CustomerDataBusiness.BusinessResearch.SaveAnswer', 'cobiscorp.ecobis.customerdatabusiness.service.IBusinessResearch', 'saveAnswer',, '', 130500)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerDataBusiness.BusinessResearch.SaveAnswer', @w_rol2,@w_producto,'R',0,getdate(),'V',getdate())


go


-------------------------
--SERVICIO Collective.CollectiveEntity.ProcessCollectiveEntity
-------------------------
	
select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from cts_serv_catalog where csc_service_id = 'Collective.CollectiveEntity.ProcessCollectiveEntity'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) values ('Collective.CollectiveEntity.ProcessCollectiveEntity', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'processCollectiveEntity', '', 0)
	
delete from ad_servicio_autorizado where ts_servicio = 'Collective.CollectiveEntity.ProcessCollectiveEntity' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.ProcessCollectiveEntity', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer'
-------------------------

select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ASESOR MOVIL' 

delete from cts_serv_catalog where csc_service_id = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'updateCollectiveCustomer', 'updateCollectiveCustomer', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.UpdateCollectiveCustomer', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
go
-------------------------
--SERVICIO OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander
-------------------------


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ADMINISTRADOR' 

delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateAccountAndBucFromSantander', 'validateAccountAndBucFromSantander', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationClientValidationServiceSERVImpl.validateAccountAndBucFromSantander', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO Collective.CollectiveEntity.UpdateProspectsFile
-------------------------
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('Collective.CollectiveEntity.UpdateProspectsFile', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'updateProspectsFile', 'updateProspectsFile', 0,null)
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.UpdateProspectsFile',@w_producto,'R',0,getdate(), @w_rol,'V',getdate())

-------------------------
--SERVICIO Collective.CollectiveEntity.ValidateProspectsFile
-------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
VALUES ('Collective.CollectiveEntity.ValidateProspectsFile', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'validateProspectsFile', 'validateProspectsFile', 0,null)
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.ValidateProspectsFile',@w_producto,'R',0,getdate(), @w_rol,'V',getdate())

-------------------------
--SERVICIO OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander
-------------------------


select @w_rol = ro_rol 
from ad_rol 
where ro_descripcion ='ADMINISTRADOR' 

delete from cts_serv_catalog where csc_service_id = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander'
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) values ('OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander', 'com.cobiscorp.ecobis.cobiscloudorchestration.bsl.serv.bsl.IOrchestrationClientValidationService', 'validateBuroFromSantander', 'validateBuroFromSantander', NULL, 'N')
	
delete from ad_servicio_autorizado where ts_servicio = 'OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander' and ts_rol = @w_rol
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationClientValidationServiceSERVImpl.validateBuroFromSantander', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


-------------------------
--SERVICIO Collective.CollectiveEntity.QueryAdvisorRole
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('Collective.CollectiveEntity.QueryAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryAdvisorRole', '', 1720)
	
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.QueryAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO Collective.CollectiveEntity.QueryOfficialByRole
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('Collective.CollectiveEntity.QueryOfficialByRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'queryOfficialByRole', '', 1720)
	
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.QueryOfficialByRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO Collective.CollectiveEntity.InsertAdvisorRole
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('Collective.CollectiveEntity.InsertAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'insertAdvisorRole', '', 1720)
	
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.InsertAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())


-------------------------
--SERVICIO Collective.CollectiveEntity.DeleteAdvisorRole
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('Collective.CollectiveEntity.DeleteAdvisorRole', 'cobiscorp.ecobis.collective.service.ICollectiveEntity', 'deleteAdvisorRole', '', 1720)
	
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('Collective.CollectiveEntity.DeleteAdvisorRole', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

-------------------------
--SERVICIO CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICollectiveManagement', 'queryCollectiveByVirtualDirection', '', 1140)
	
insert into ad_servicio_autorizado(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CollectiveManagement.QueryCollectiveByVirtualDirection', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())



-------------------------
--SERVICIO SaveRegistry BIOCHECK
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerBiocheck.CustomerBiocheck.SaveRegistry', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'saveRegistry', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.SaveRegistry', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
-------------------------
--SERVICIO QueryRegistry BIOCHECK
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerBiocheck.CustomerBiocheck.QueryRegistry', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'queryRegistry', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.QueryRegistry', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
-------------------------
--SERVICIO GetWithoutFingerprint BIOCHECK
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'getWithoutFingerprint', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.GetWithoutFingerprint', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
-------------------------
--SERVICIO GetDataToOpaqueToken BIOCHECK
-------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values ('CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'getDataToOpaqueToken', '', 18000)
insert into cobis..ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.GetDataToOpaqueToken', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
-------------------------

--------------------------------------------
--- SERVICIO INVOCAR A RENAPO          -----
--------------------------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestationRenapoServiceSERVImpl.renapoQueryByDetail', 'com.cobiscorp.ecobis.cobiscloudrenapo.bsl.serv.bsl.IOrchestationRenapoService', 'renapoQueryByDetail', 'Consultar Servicio RENAPO', NULL, 'N')
	
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByDetail', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


--------------------------------------------
--- SERVICIO PARA OBTENER ACCESS TOKEN -----
--------------------------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.accessToken', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'accessToken', 'Obtener Access Token', NULL, 'N')
	
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.accessToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


--------------------------------------------
--- SERVICIO PARA OBTENER TOKEN OPACO  -----
--------------------------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.opaqueToken', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'opaqueToken', 'Obtener Token Opaco', NULL, 'N')

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.opaqueToken', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


----------------------------------------------
-- SERVICIO PARA OBTENER NUEVO ACCESS TOKEN --
----------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestrationBiometricServiceSERVImpl.accessTokenBC', 'com.cobiscorp.ecobis.cobiscloudbiometric.bsl.serv.bsl.IOrchestationBiometricService', 'accessTokenBC', 'Obtener Nuevo Access Token', NULL, 'N')

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestrationBiometricServiceSERVImpl.accessTokenBC', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())


--------------------------------------------
--- SERVICIO PARA OBTENER EQUIVALENCIAS-----
--------------------------------------------

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('SystemConfiguration.EquivalenceManagement.QueryEquivalences', 'cobiscorp.ecobis.systemconfiguration.service.IEquivalenceManagement', 'queryEquivalences', 'Obtener Equivalencias', NULL, 'N')
	
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('SystemConfiguration.EquivalenceManagement.QueryEquivalences', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-------------------------------------------
--- SERVICIO LCR BIOMETRICO           -----
-------------------------------------------

declare 
@w_producto              int,
@w_tn_trn_code           int,
@w_pd_procedure          int

declare @w_roles table (
   rol       int
)

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

select 
@w_tn_trn_code  = 18001,
@w_pd_procedure = 18001

insert into @w_roles
select ro_rol
from ad_rol
where ro_descripcion in (
'ADMINISTRADOR',
'FUNCIONARIO OFICINA',
'CONSULTA',
'ASESOR',
'GERENTE REGIONAL',
'MESA DE OPERACIONES',
'NORMATIVO',
'GERENTE OFICINA',
'AUDITORIA'
)


delete cts_serv_catalog where csc_service_id = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'

insert into cts_serv_catalog values ('CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheckLCR','getCustomerAmount','',@w_tn_trn_code,null, null, null)

delete ad_servicio_autorizado  where ts_servicio = 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount'

insert into ad_servicio_autorizado 
select 'CustomerBiocheck.CustomerBiocheckLCR.GetCustomerAmount',rol, @w_producto, 'R', 0, getdate(), 'V', getdate()
from @w_roles
go

--------------------------------------------
--- SERVICIO PARA OBTENER INFORMACION REPORTE SOLICITUD PRE-LLENADA -----
--------------------------------------------
insert into cts_serv_catalog(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) 
values('Loan.ReportMaintenance.PreFilledApplication','cobiscorp.ecobis.assets.cloud.service.IReportMaintenance', 'preFilledApplication', '', 0)

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('Loan.ReportMaintenance.PreFilledApplication', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

go
-- ==============================================
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'purchaseConfirmation', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'purchaseConfirmation', '', 0)
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'queryReference', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.QueryReference'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.QueryReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'queryReference', '', 0)
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', csc_method_name = 'validateReference', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'CustomerDataManagementService.BusinessPartnerReference.ValidateReference'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.BusinessPartnerReference.ValidateReference', 'cobiscorp.ecobis.customerdatamanagementservice.service.IBusinessPartnerReference', 'validateReference', '', 0)
-- ======
SELECT @w_rol = ro_rol FROM ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.BusinessPartnerReference.QueryReference', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.BusinessPartnerReference.ValidateReference', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())

-- ==============================================
go

DECLARE
	@w_rol_admin			INT,
	@w_rol_fun_oficina		INT,
	@w_rol_menu_procesos	INT,
	@w_rol_corresponsal		INT,	
    @w_producto				INT


SELECT @w_rol_fun_oficina = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'FUNCIONARIO OFICINA'
SELECT @w_rol_admin = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'ADMINISTRADOR'
SELECT @w_rol_menu_procesos = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'MENU POR PROCESOS'
SELECT @w_rol_corresponsal = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'CORRESPONSAL NO BANCARIO'
SELECT @w_producto = pd_producto FROM cl_producto WHERE pd_abreviatura = 'CRE'  -- CREDITO

----------------------------------------------------------------------------------
-- OrchestrationBiocheckServiceRestImpl.error
----------------------------------------------------------------------------------
INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation) 
VALUES('CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'validateErrorBiocheck', 'Description', null,'N')

INSERT INTO ad_servicio_autorizado (ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
VALUES('CustomerBiocheck.CustomerBiocheck.ValidateErrorBiocheck', @w_rol_admin, @w_producto, 'R', 0, GETDATE(), 'V', GETDATE())

----------------------------------------------------------------------------------
-- CustomerBiocheck.CustomerBiocheck.QueryOfficeId
----------------------------------------------------------------------------------
insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('CustomerBiocheck.CustomerBiocheck.QueryOfficeId', 'cobiscorp.ecobis.customerbiocheck.service.ICustomerBiocheck', 'queryOfficeId', 'Obtener el ID de la oficina', 18000, 'N')

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('CustomerBiocheck.CustomerBiocheck.QueryOfficeId', @w_rol_admin, @w_producto, 'R', 0, getdate(), 'V', getdate())

----------------------------------------------------------------------------------
-- Se realiza el caso 203621 en 193221 RENAPO POR CURP
----------------------------------------------------------------------------------
use cobis
go

declare @w_rol int,
        @w_producto int

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CLIENTES'

insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_procedure_validation ) 
values ('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', 'com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl.IOrchestationRenapoService', 'renapoQueryByCurp', 'Consultar Servicio RENAPO POR CURP', NULL, 'N')

------>>>>>>	
select @w_rol = ro_rol from ad_rol where ro_descripcion ='ASESOR'

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
------>>>>>>
select @w_rol = ro_rol from ad_rol where ro_descripcion ='ASESOR MOVIL' 

insert into ad_servicio_autorizado(ts_servicio, ts_rol, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_estado, ts_fecha_ult_mod)
values('OrchestationRenapoServiceSERVImpl.renapoQueryByCurp', @w_rol, @w_producto, 'R', 0, getdate(), 'V', getdate())
go
