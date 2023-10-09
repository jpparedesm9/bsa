package com.cobiscorp.cobis.busin.flcre.commons.constants;

public interface ServiceId {
	final String SERVICEGETPROCESSEDNUMBER = "BusinessProcess.LoanRequest.CreditOperation.GetProcessedNumber";
	final String SERVICEREADAPPLICATION = "Businessprocess.Creditmanagement.ApplicationQuery.ReadNewApplication";// cob_cartera..sp_qry_oper_sol_wf,Q
	final String SERVICESEARCHITEMS = "Loan.SearchLoanItems.SearchLoanItemsSearch";
	final String SERVICEGETITEMS = "Loan.SearchLoanItems.GetLoanItemsDetails";
	final String SERVICEREADLOANGENERALDATA = "Loan.LoansQueries.ReadLoanGeneralDataTmp";// cob_cartera..sp_qr_operacion_tmp
	final String SERVICEUPDATEGENERALPARAMETERSLOAN = "Loan.LoanMaintenance.UpdateLoanParameters";
	final String SERVICEQUERYDEBTOR = "Businessprocess.Creditmanagement.DebtorsManagment.QueryDebtor";// cob_credito..sp_deudores;21413;S
	final String SERVICEREADOFFICE = "SystemConfiguration.OfficeManagement.ReadOffice";
	final String SERVICEQUERYRATINGAPPLICATION = "Businessprocess.Creditmanagement.InternalRatingCustomer.QueryRatingApplicationQuestion";
	final String SERVICEINSERTRATINGAPPLICATION = "Businessprocess.Creditmanagement.InternalRatingCustomer.CreateRatingApplication";
	final String SERVICEQUERYSCORERATINGAPPLICATION = "Businessprocess.Creditmanagement.InternalRatingCustomer.QueryScoreRatingApplication";
	final String BLACKLISTVALIDATION = "Businessprocess.Creditmanagement.InternalRatingCustomer.BlackListValidation";// cob_credito..sp_control_listas_negras,'P'
	// final String SERVICESAVELOANAPPLICATION =
	// "Businessprocess.Creditmanagement.ApplicationManagment.CreateApplication";//cob_credito..sp_tramite
	final String SERVICETRAIMTECREATELOANAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.CreateRevolvingApplication";// cob_credito..sp_tramite_cca
	final String SERVICETRAIMTESAVELOANAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateRevolvingApplication";// cob_credito..sp_tramite_cca 'U'
	final String SERVICESAVELOANAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.CreateNewApplication";// cob_cartera..sp_crear_oper_sol_wf
	final String SERVICESAVELOANAPPLICATIONIND = "Businessprocess.Creditmanagement.ApplicationManagment.CreateApplicationIndividual";// cob_cartera..sp_crear_individual
	final String SERVICEINSERTDEBTORTEMP = "Businessprocess.Creditmanagement.DebtorsManagment.CreateDebtor";// cob_credito..sp_deudores;21013;T
	public static final String SERVICE_DELETE_DEBTOR = "Businessprocess.Creditmanagement.DebtorsManagment.DeleteDebtor";
	final String SERVICEUPDATELOANAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateNewApplication";// segun el SG: cob_cartera..sp_modificar_oper_sol_wf /
																																// Lo que estaba: cob_credito..sp_tramite
	final String SERVICEUPDATELOANAPPLICATIONIND = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateApplicationIndividual";// cob_cartera..sp_modificar_individual
	final String UPDATEADITIONALINFORMATION = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateAditionalInformation"; // cob_credito..sp_tr_datos_adicionales,U
	final String SERVICEUPDATEINSTANCEPROCESS = "Workflow.Admin.WorkflowAdmin.UpdateInstanceProcess";// cob_workflow..sp_m_inst_proceso_wf
	final String SERVICESEARCHACCOUNTREQUEST = "Account.SearchAccount.SearchAccountRequest";// cob_remesas..sp_personaliza_cuenta 4072,'C'
	final String SERVICESEARCHACCOUNTBYCURRENCY = "Account.SearchAccount.SearchAccountByCurrency";// cob_cartera..sp_cuenta_cobis
	final String CRERATELOAN = "Businessprocess.Creditmanagement.LoanMaintenance.CreateLoan";// cob_credito..sp_operacion_cartera
	final String UPDATELOAN = "Loan.LoanMaintenance.UpdateLoanDataTmp";// cob_cartera..sp_modificar_operacion
	final String UPDATENEWLOAN = "Loan.LoanMaintenance.UpdateNewLoanDataTmp";// cob_cartera..sp_modificar_oper_sol_wf
	final String SERVICEREADCUSTOMER = "CustomerDataManagementService.CustomerManagement.ReadCustomerName";
	final String SERVICEREADATACUSTOMER = "CustomerDataManagementService.CustomerManagement.ReadDataCustomer";
	final String AMORTIZATIONTABLE = "Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearch";
	final String AMORTIZATIONTABLETMP = "Loan.ReadLoanAmortizationTable.ReadLoanAmortizationTableSearchTmp";
	final String PARAMETERMANAGEMENT = "SystemConfiguration.ParameterManagement.ParameterManagement";
	final String PROCESSDATE = "SystemConfiguration.ParameterManagement.ProcessDate";// cobis..sp_fechapro
	final String SERVICEMONEYEXCHANGE = "MoneyMarket.SearchExchangeRate.MoneyExchange";
	final String SERVICECREATERULE = "Businessprocess.Creditmanagement.RuleByRoleQuery.createRuleByRole";
	final String SERVICEREADRULE = "Businessprocess.Creditmanagement.RuleByRoleQuery.readRuleByRole";
	final String SERVICEUPDATELOANITEMS = "Loan.SearchLoanItems.UpdateLoanItems";
	final String SERVICESEARCHRULE = "Businessprocess.Creditmanagement.RuleByRoleQuery.searchRuleByRole";
	final String DELETETMPTABLES = "Loan.LoanMaintenance.DeleteTmpTables";// cob_cartera..sp_borrar_tmp
	final String COMMITLOANCHANGES = "Loan.LoanMaintenance.CommitLoanChanges";// cob_cartera..sp_operacion_def
	final String SERVICEGETITEMSDETAIL_BUSIN = "Loan.SearchLoanItems.GetLoanItemsDetails_busin";// cob_cartera..sp_rubro_tmp-(Q)
	final String SERVICEDELETETMPTABLES = "Loan.LoanMaintenance.DeleteTmpTables";
	final String SERVICECREATETMPTABLES = "Loan.LoanMaintenance.CreateTmpTables";// cob_cartera..sp_pasotmp
	// final String SERVICEQUERYDISFORMSINFORMATION =
	// "Loan.ReadDisbursementForm.ReadDisbursementFormSearch";//
	// cob_cartera..sp_desembolso
	// existe el servicio en otro proyecto de SG en otro paquete, para evitar
	// conflictos se crea este nuevo nombre
	final String SERVICEQUERYDISFORMSINFORMATION_BUSIN = "Loan.ReadDisbursementForm.ReadDisbursementFormSearch.Busin";// cob_cartera..sp_desembolso
	final String SERVICEQUERYCREDITLINE = "Businessprocess.Creditmanagement.LineOpCurrency.GetCreditLineData";
	final String SERVICEQUERYDISTRIBUTIONLINE = "Businessprocess.Creditmanagement.LineOpCurrency.SearchDistributionLine";
	final String SERVICESAVEDISTRIBUTIONLINE = "Businessprocess.Creditmanagement.LineOpCurrency.InsertLineOpCurrency";
	final String SERVICESAVEADITIONALLINE = "Businessprocess.Creditmanagement.LineOpCurrency.InsertLineAditionalData";
	final String SERVICEUPDATEADITIONALLINE = "Businessprocess.Creditmanagement.LineOpCurrency.UpdateLineAditionalData";
	final String SERVICEQUERYADITIONALLINE = "Businessprocess.Creditmanagement.LineOpCurrency.QueryLineAditionalData";
	final String SERVICEDISBURSELOAN = "Loan.LoanTransaction.DisburseLoan";
	final String SERVICEGETOPERATION = "Businessprocess.Creditmanagement.DataTypeOperationQuery.GetOperationType";
	final String SERVICEGETPRODUCT = "Businessprocess.Creditmanagement.DataTypeOperationQuery.GetDescriptionAndProduct";
	final String READACTIVITYBYCUSTOMER = "CustomerDataManagementService.CustomerManagement.ReadActivityByCustomer";
	final String SERVICEUPDATEDISTRIBUTION = "Businessprocess.Creditmanagement.LineOpCurrency.UpdateLineOpCurrency";
	final String SERVICEDELETEDISTRIBUTION = "Businessprocess.Creditmanagement.LineOpCurrency.DeleteLineOpCurrency";
	final String QUERYCREDITLINEBYBANK = "Businessprocess.Creditmanagement.LineOpCurrency.GetCreditLineDataByBank"; // cob_credito..sp_linea-21526-Q
	final String SEARCHITEMSDETAIL = "Loan.ReadLoanItems.ReadLoanItemsSearch";
	final String SEARCHOFFICER = "SystemConfiguration.OfficerManagement.SearchOfficer";
	final String SEARCHCOLLATERAL = "Businessprocess.Creditmanagement.CollateralApplicationQuery.SearchCollateralApplication";// cob_credito..sp_gar_propuesta
	final String SEARCHINSURANCE = "Collateral.CollateralQuery.SearchPolicy";
	final String SERVICEPOLICY = "Workflow.Admin.WorkflowAdmin.QueryRuleProcessHistory";// cob_workflow..sp_rule_process_his_wf 32285,C
	final String SEARCHLOANGENERALDATA = "Loan.LoanGeneralData.ReadLoanGeneralDataSearch"; // cob_cartera..sp_qr_operacion_busin
	final String SEARCHLOANGENERALDATABUSIN = "Loan.LoanGeneralData.ReadLoanGeneralDataSearchBusin";
	final String SUGGESTEDQUERYPOINTS = "Businessprocess.Creditmanagement.PointRateManagment.readPointApplication";
	final String QUERYHIERARCHY = "Workflow.Admin.WorkflowAdmin.QueryHierarchyLevelProcessInstance";
	final String VALIDATEINFOCRED = "Businessprocess.Creditmanagement.CreditBureauOperations.ValidateInfocred";// cob_credito..sp_infocred,21784
	final String CREATEINFOCRED = "COBISCorp.eCOBIS.Businessprocess.Creditmanagement.CreditBureauOperations.CreateInfocred";// cob_credito..sp_infocred,21784
	final String SEARCHRECORDINFOCRED = "Businessprocess.Creditmanagement.CreditBureauOperations.SearchRecordInfocred";// cob_credito..sp_infocred,21784,H
	final String SEARCHLOANSINFOCRED = "Businessprocess.Creditmanagement.CreditBureauOperations.SearchLoansInfocred";// cob_credito..sp_infocred,21784,H
	final String REGISTERINFOCRED = "Businessprocess.Creditmanagement.CreditBureauOperations.RegisterInfocred";// cob_procesador..sp_infocred,21785
	final String VALIDATEDATECICANDINFOCRED = "Businessprocess.Creditmanagement.CreditBureauOperations.ValidateDateCICAndInfocred";// cob_credito..sp_valida_cic_infocred,21188,<T,D>
	final String READCUSTOMER = "CustomerDataManagementService.CustomerManagement.ReadCustomer";
	final String READADDRESSCODE = "CustomerDataManagementService.CustomerManagement.ReadAddressCode";
	final String READADDRESS = "CustomerDataManagementService.CustomerManagement.ReadAddress";
	final String READTELEPHONE = "CustomerDataManagementService.CustomerManagement.ReadTelephone";
	final String READREFERENCE = "CustomerDataManagementService.CustomerManagement.ReadReference";
	final String UPDATECUSTOMER = "CustomerDataManagementService.CustomerManagement.UpdateCustomer";
	final String SERVICESEARCHTYPEOPERATION = "Businessprocess.Creditmanagement.DataTypeOperationQuery.SearchTypeOperation";
	final String SERVICESEARCHVARIABLEDATA = "Businessprocess.Creditmanagement.VariableDataApplicationQuery.SearchVariableData";
	final String SERVICEGETQUOTE = "Businessprocess.Creditmanagement.LineOpCurrency.GetQuote";// cob_credito..sp_divisas_credito,21860,C
	final String SERVICEGETQUOTEBUSIN = "Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteBusin";// cob_credito..sp_divisas_credito_busin,C
	final String GETQUOTEEXCHANGE = "Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteExchange";// cob_credito..sp_divisas_credito,21860,Q
	final String INDEXACTIVITYAPPLICATION = "Businessprocess.Creditmanagement.ApplicationManagment.IndexActivityApplication";
	final String SERVICESCREATECOLLATERAL = "Businessprocess.Creditmanagement.CollateralApplicationManagement.CreateCollateralApplication"; // cob_credito..sp_gar_prouesta
	final String SERVICESEARCHDOCUMENTSBYTYPE = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocumentsByType";
	final String SERVICESEARCHDOCUMENTS = "Businessprocess.Creditmanagement.DocumentsApplicationQuery.SearchDocuments";
	final String SERVICEUPDATEDOCUMENTSAPPLICATION = "Businessprocess.Creditmanagement.DocumentsApplicationManagment.CreateDocumentsApplication";
	final String ARCHDOCUMENTSAPPLICATION = "Businessprocess.Creditmanagement.DocumentsApplicationManagment.SearchDocumentsApplication";
	final String SERVICESEARCHCUSTOMEROPERATION = "Loan.LoanMaintenance.SearchCustomerOperation";
	final String SERVICESADDRENEWDATA = "Businessprocess.Creditmanagement.RenewManagement.AddRenewData";// cob_credito..sp_op_renovar
	final String SERVICESUPDATERENEWDATA = "Businessprocess.Creditmanagement.RenewManagement.UpdateRenewData";// cob_credito..sp_op_renovar
	final String SERVICESDELETERENEWDATA = "Businessprocess.Creditmanagement.RenewManagement.DeleteRenewData";
	final String SERVICEGETQUOTEDISBURSEMENT = "Businessprocess.Creditmanagement.LineOpCurrency.GetQuoteDisbursement";// cob_credito..sp_divisas_credito,21860,E
	final String SERVICEREADOPERATION = "Loan.ReadOperationCustomer.GetOperationCustomer";// cob_credito..sp_bus_oper_cliente
	final String SERVICEGETSTATUS = "Loan.Queries.GetStatus";// cob_cartera..sp_consulta_estado
	final String CREATEREVOLVINGOPAPPLICATION = "Businessprocess.CreditManagement.RevolvingManagment.CreateRevolvingOpApplication";// cob_cartera..sp_reprograma_operacion
	final String SERVICEOPERATIONSEARCH = "Businessprocess.Creditmanagement.RenewManagement.SearchRenewData";
	final String SERVICESEARCHRENEWOPERDATA = "Businessprocess.Creditmanagement.RenewManagement.SearchRenewOperData";
	final String SERVICESEARCHRENEWLOANDATA = "Businessprocess.Creditmanagement.RenewManagement.SearchRenewLoanData";
	final String SERVICESEARCHRENEWOPERDATABYCUSTOMER = "Businessprocess.Creditmanagement.RenewManagement.SearchRenewOperByCustomer";// cob_credito..sp_bus_oper_cliente,S,6
	final String SERVICESEARCHCITY = "SystemConfiguration.OfficeManagement.SearchCity";
	final String SERVICEUPDATEOFFICE = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateOfficerApplication";
	final String SERVICEWORKLOADOFFICE = "Businessprocess.Creditmanagement.WorkloadOfficerQuery.QueryOfficerWork";
	final String SERVICEAQUERYOFFICER = "Businessprocess.Creditmanagement.ApplicationManagment.QueryOfficerApplication";
	final String SERVICECREATEVARIABLEDATA = "Businessprocess.Creditmanagement.VariableDataApplicationManagment.CreateVariableData";
	// aprobacion
	final String SERVICEEXCEPTIONS = "HTM.API.HumanTask.GetApprovedExceptionsByProcessInstanceOrCode";// cob_workflow..sp_aprobaciones_aso_wf,C
	final String SERVICEACTIVITIESREQUIREMENTS = "Workflow.Admin.WorkflowAdmin.QueryActivitiesRequirements"; // cob_workflow..sp_aso_requisito_wf

	// Servicios para Analisis Financiero
	final String SERVICEFINANEVAL = "FinanEval.FinanEvalQuery.FinanEval.ReadFinanEvalAvailableBalance";// cob_credito..sp_ori_saldo_disponible,S
	final String SEARCHFINANEVAL = "FinanEval.FinanEvalQuery.FinanEval.ReadFinanEvalGeneralData";// cob_credito..sp_ori_consul_eval_finan,Q
	final String SEARCHFINANCIALANALYSIS = "FinanEval.FinanEvalQuery.FinanEval.SearchFinancialAnalysis"; // cob_credito..sp_analisis_financiero,S
	final String QUERYFINANCIALANALYSIS = "FinanEval.FinanEvalQuery.FinanEval.QueryFinancialAnalysis"; // cob_credito..sp_analisis_financiero,Q
	final String SERVICESEARCHRENEWOPERDATABYOPERATION = "Businessprocess.Creditmanagement.RenewManagement.SearchRenewOperByOperation";// cob_credito..sp_bus_oper_cliente,S,7
	final String SEARCHRESCHEDULEOPERBYCUSTOMERANDOPER = "Businessprocess.Creditmanagement.RescheduleManagement.searchRescheduleOperByCustomerAndOper";// cob_credito..sp_bus_oper_cliente,S,8
	// LGU Para cargar linea de Credito Vigentes por Cliente
	final String SEARCHGETCREDITLINEDATABYCUSTOMER = "Businessprocess.Creditmanagement.LineOpCurrency.GetCreditLineDataByCustomer";
	final String VALIDATEAPPLICATIONOPERATIONS = "Businessprocess.Creditmanagement.ValidateApplicationOperations.GetValidateBalanceOper";
	// srv para validar operación en flujo
	final String SERVICESEARCHOPERATIONUSE = "Businessprocess.Creditmanagement.RenewManagement.SearchOperationUse";
	// srv para actualizar los datos de la central y nivel de endeudamiento
	final String SERVICEUPDATECREDITDATACENTRAL = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateCreditDataCentral";// cob_credito..sp_tramite
	final String SERVICEREADCURRENTVALUESBYOPERATION = "Loan.LoansQueries.ReadCurrentValuesByOperation";
	final String SERVICECREATEARREARS = "Businessprocess.Creditmanagement.ArrearsManagment.Create";
	final String SERVICEUPDATEARREARS = "Businessprocess.Creditmanagement.ArrearsManagment.UpdateArrears";
	final String SERVICEQUERYARREARS = "Businessprocess.Creditmanagement.ArrearsManagment.QueryArrears";
	final String READADITIONALINFORMATION = "Businessprocess.Creditmanagement.ApplicationQuery.ReadAditionalInformation";// cob_credito..sp_tr_datos_adicionales,S
	final String READPROCESSLAP = "Businessprocess.Creditmanagement.ApplicationQuery.ReadProcessLap";// cob_workflow..sp_instancia_proceso
	final String SERVICESEARCHRENEWBALANCEBYOPERATION = "Businessprocess.Creditmanagement.RenewManagement.SearchBalancebyOperation";// cob_credito..sp_bus_oper_cliente,S,9
	final String SERVICEGETPENALIZATIONLOAN = "Loan.LoansQueries.GetPenalizationLoan";// cob_cartera..sp_datos_castigo
	final String SERVICECREATEPENALIZATION = "Businessprocess.Creditmanagement.PenalizationManagement.InsertPenalization"; // sp_castigo_operaciones
	final String SERVICESEARCHPUNISHMENT = "Loan.LoanMaintenance.SearchPenalizationLoan"; // sp_consulta_candidata_castigo obtiene las operaciones candidatas
	final String SERVICEUPDATEPENALIZATION = "Businessprocess.Creditmanagement.PenalizationManagement.UpdatePenalization"; // sp_castigo_operaciones
	final String SERVICEGETPENALIZATIONDATA = "Businessprocess.Creditmanagement.PenalizationManagement.GetPenalizationData"; // sp_castigo_operaciones,Q
	final String SERVICEUPDATEPUNISHMENT = "Loan.LoanMaintenance.UpdatePenalizationLoan"; // cambia el estado sp_consulta_candidata_castigo
	final String SERVICEGETPENALIZATION = "Businessprocess.Creditmanagement.PenalizationManagement.GetPenalization"; // cob_credito..sp_castigo_operaciones,Q
	final String QUERYCONSOLIDATEPENALIZATIONLOAN = "Businessprocess.Creditmanagement.PenalizationManagement.QueryConsolidatePenalizationLoan";// cob_credito..sp_grupo_castigo,Q
	final String INSERTCONSOLIDATEPENALIZATIONLOAN = "Businessprocess.Creditmanagement.PenalizationManagement.InsertConsolidatePenalizationLoan";// cob_credito..sp_grupo_castigo,I
	final String UPDATECONSOLIDATEPENALIZATIONLOAN = "Businessprocess.Creditmanagement.PenalizationManagement.UpdateConsolidatePenalizationLoan";// cob_credito..sp_grupo_castigo,U
	final String CHANGESTATECONSOLIDATEPENALIZATIONLOAN = "Businessprocess.Creditmanagement.PenalizationManagement.ChangeStateConsolidatePenalizationLoan";// cob_credito..sp_grupo_castigo,C
	final String INSERTDETAILPENALIZATIONLOANTMP = "Businessprocess.Creditmanagement.PenalizationManagement.InsertDetailPenalizationLoanTmp";// cob_credito..sp_grupo_tran_castigo,T
	final String UPDATEPENALIZATIONLEGAL = "Businessprocess.Creditmanagement.PenalizationManagement.UpdatePenalizationLegal";// cob_credito..sp_grupo_castigo,A
	final String SERVICEGETSALESCOMMISSIONDATE = "Businessprocess.Creditmanagement.SalesCommissionManagment.getSalesCommissionDate";// cob_credito..sp_bono_ejecutivo,S,1,2
	final String SERVICESHEARSSALESCOMMISSION = "Businessprocess.Creditmanagement.SalesCommissionManagment.SearchSalesCommission";// cob_credito..sp_bono_ejecutivo,S,3
	final String SERVICEUPDATESALESCOMMISSION = "Businessprocess.Creditmanagement.SalesCommissionManagment.UpdateSalesCommission";// cob_credito..sp_bono_ejecutivo,U,1,2
	final String SEARCHSALESCHIEFEXECUTIVE = "Businessprocess.Creditmanagement.SalesCommissionManagment.SearchSalesChiefExecutive";// cob_credito..sp_bono_ejecutivo,S,4
	final String SERVICESEARCHRISKDATA = "Businessprocess.Creditmanagement.RiskManagement.SearchRiskData";
	final String SERVICECREATERISKDATA = "Businessprocess.Creditmanagement.RiskManagement.CreateRiskData";
	final String SERVICEUPDATERISKDATA = "Businessprocess.Creditmanagement.RiskManagement.UpdateRiskData";
	final String SERVICESEARCHCOMPANYSHEET = "CustomerDataManagementService.CustomerManagement.SearchCompanySheet";
	final String SERVICEDISBURSMENTFORM = "Loan.LoansQueries.SearchDisbursmentForm";
	final String SERVICEREADARREARSRANGE = "Loan.LoansQueries.ReadArrearsRange";
	final String SERVICECREATEBANKGUARANTEE = "Comext.Query.InternationalTradeFinance.CreateBankGuarantee"; // cob_comext..sp_apertura_tramite_op_grb
	final String SERVICEQUERYBANKGUARANTEE = "Comext.Query.InternationalTradeFinance.QueryBankGuarantee"; // cob_comext..sp_qtu_grb
	final String GETSEARCHPREVIOUSGUARANTESS = "Collateral.PreviousGuarantees.GetSearchPreviousGuarantees";// sp_gar_anteriores,S
	final String INSERTPREVIOUSGUARANTEES = "Collateral.PreviousGuarantees.InsertPreviousGuarantees";// sp_gar_anteriores,I
	final String DELETEPREVIOUSGUARANTEES = "Collateral.PreviousGuarantees.DeletePreviousGuarantee";// sp_gar_anteriores,D
	final String SERVICESEARCHTYPEBANKGUARANTEE = "Comext.Query.InternationalTradeFinance.SearchTypeBankGuarantee"; // cob_comext..sp_clase_tipo_grb
	final String SERVICEUPDATEBANKGUARANTEE = "Comext.Query.InternationalTradeFinance.UpdateBankGuarantee"; // cob_comext..sp_actualiza_tramite_op_grb
	final String SERVICEUPDATEOFFICILCOMEXT = "Comext.Query.ComextUpdate.UpdateOfficialComext"; // cob_comext..sp_cambio_oficial_operacion
	final String SERVICESTASKHISTORYFLOW = "Inbox.CommentsManager.GetRecords";// cob_workflow..sp_info_proceso_wf'
	final String SERVICESEARCHCOSTRULE = "Comext.Query.InternationalTradeFinance.SearchCostRuleBankGuarantee"; // cob_comext..sp_consulta_grp
	final String SERVICECREATECOSTBANKGUARANTE = "Comext.Query.InternationalTradeFinance.CreateCostBankGuarantee"; // cob_comext_sp_valor
	final String SERVICEUPDATECOSTBANKGUARANTE = "Comext.Query.InternationalTradeFinance.UpdateCostBankGuarantee";// cob_comext_sp_valor
	final String SERVICESEARCHCOSTBANKGUARANTE = "Comext.Query.InternationalTradeFinance.SearchCostBankGuarantee";// cob_comext..sp_consulta_com_tramite_op
	final String SERVICEREADLOANPAYMENT = "Loan.ReadLoanAmortizationTable.ReadLoanPayment";// cob_credito..sp_ori_valor_cuota,S
	final String SERVICECREATEDISBURSEMENT = "Loan.LoanMaintenance.CreateDisbursementForm";
	final String SERVICEVALIDATIONGUARANTEEPRORATED = "Businessprocess.Creditmanagement.GuaranteesFundManagment.ValidationGuaranteeProrated"; // cob_credito..sp_prorratea_gar,R
	final String SERVICEREADCUSTOMERHELP = "Businessprocess.Creditmanagement.DebtorsManagment.HelpDebtor"; // cob_credito..sp_deudores,H
	final String SERVICECOMMISSIONCALCULATE = "Comext.Query.InternationalTradeFinance.CommissionCalculationGuarantee"; // cob_comext..sp_calculo_comision_originador
	final String SERVICECREATESOURCEFUNDING = "Businessprocess.Creditmanagement.SourceFundingManagment.CreateSourceFunding"; // cob_credito..sp_fuente_financiamiento,'I'
	final String SERVICEUPDATESOURCEFUNDING = "Businessprocess.Creditmanagement.SourceFundingManagment.UpdateSourceFunding";
	final String SERVICESEARCHSOURCEFUNDING = "Businessprocess.Creditmanagement.SourceFundingManagment.SearchSourceFunding";
	final String SERVICEREADSOURCEFUNDING = "Businessprocess.Creditmanagement.SourceFundingManagment.ReadSourceFunding";
	final String SERVICEUPATESOURCEREQUEST = "Businessprocess.Creditmanagement.SourceFundingManagment.UpdateSourceFundingRequest";
	final String SERVICESEARCHACTOBJE = "Businessprocess.Creditmanagement.ActivitybyObjectQuery.searchActivitybyObject"; // cob_credito..sp_relaciona_objeto_credito,'O'
	final String SERVICESEARCHOBJEBYACT = "Businessprocess.Creditmanagement.ActivitybyObjectQuery.searchObjectbyActivity"; // cob_credito..sp_relaciona_objeto_credito,'A'
	final String SERVICEGETCURRENCYBYPRODUCT = "SystemConfiguration.CurrencyManagement.GetCurrencyByProduct";
	final String SERVICEVALIDATIONINFCUSTOMER = "Businessprocess.Creditmanagement.ApplicationManagment.ValidationInfCustomer"; // cobis..sp_valida_info_vinculacion
																																// operation='Q'
	final String SERVICEGETHOLIDAYS = "Loan.ReadHolidays.GetHolidays";// Servicio para obtener los feriados iguales o mayores a la fecha actual
	final String SERVICEUPDATEFECHACIC = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateFechaCIC"; // cob_credito..sp_consulta_planilla
																													// operacion='U'

	// SERVICIOS BPL
	final String BPL_FINDRULEACTIVEBYACRONYM = "Bpl.Rules.Engine.Query.RuleQueryManager.FindRuleActiveByAcronym";
	final String BPL_GENERATE = "Bpl.Rules.Engine.RuleManager.Generate";

	// SOLO PARA REGLAS
	final String RULE_QUERYVALUESFORRATECREDITLINE = "Businessprocess.Creditmanagement.RuleExecutionManagement.QueryValuesForRateCreditLine";// cob_credito..sp_regla_tasa_int_estandar,S
	final String RULE_QUERYVALUESFORSCORETYPE = "Businessprocess.Creditmanagement.RuleExecutionManagement.QueryValuesForScoreType";// cob_credito..sp_regla_tipo_calificacion,S
	final String RULE_QUERY_CREDIT_SECTOR = "Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleCreditSector";// cob_credito..sp_regla_sector_credito_a,
																																// S

	// TABLA DE AMORTIZACIÓN MANUAL
	final String SERVICEMANUALAMORTIZACION = "Loan.LoanMaintenance.ManualTable";// cob_cartera..sp_decodificador

	// SERVICIOS APF
	final String SERVICELATESHISTORICAL = "FPM.Operation.GetLatestHistorical";
	final String SERVICEECONOMICDESTINATION = "FPM.Portfolio.Administration.GetEconomicDestinationHistoricalLog";
	final String SERVICEACTIVITYDESTINATION = "FPM.Portfolio.Administration.GetEconomicActivityHistoricalLog";
	final String SERVICBANKINGPRODUCTSECTOR = "FPM.Operation.GetBankingProductSector";
	final String SERVICEGETCATALOGBYNAME = "FPM.Catalogs.GetCatalogsByName";
	final String SERVICEGETGENERALPARAMETERCATALOG = "FPM.Operation.FindGeneralParameterValuesDescription";
	final String SERVICEGETBANKINGPRODUCTSBYMODULE = "FPM.Operation.GetBankinProductsLatestByModule";
	final String SERVICEGETBANKINGPRODUCTBYMODULE = "FPM.Operation.FindBankingProductByModule";
	final String SERVICEGETBANKINGPRODUCTBASICINFORMATIONBYID = "FPM.Operation.GetBankingProductBasicInformationById";
	final String SERVICEINSERTLISTFIELDBYPRODUCT = "FPM.Operation.InsertListFieldByProductValues";

	// SERVICIO SPQUERYDINAMICO
	final String SERVICE_NAME = "Busin.Service.GetCatalogByStoredProcedure";

	// GARANTIAS
	final String SERVICEALLWARRANTIESTYPES = "Collateral.CollateralQuery.SearchCollateralType";
	final String SERVICEGETQUERYTYPEGUARANTEEDATA = "Collateral.TypeGuarantee.GetQueryTypeGuaranteeData";
	final String SERVICEGETCOVERAGECUSTODY = "Collateral.TypeGuarantee.GetCoverageCustody";
	final String SERVICEUPDATECOLLATERAL = "Collateral.CollateralMaintenance.UpdateCollateral";
	final String SERVICEINSERTCOLLATERAL = "Collateral.CollateralMaintenance.InsertCollateral";
	final String SERVICESHAREDENTITYWARRANTY = "Collateral.SharedEntities.InsertSharedEntities";
	final String SERVICEINSERTCUSTOMERCOLLATERAL = "Collateral.CollateralMaintenance.InsertCustomerCollateral";
	final String SERVICESEARCHDEPOSTIBYENTE = "Collateral.SearchDeposit.SearchDeposit"; // cob_pfijo..sp_consop: S,14806
	final String SERVICESEARCHACCOUNTBYENTE = "Collateral.SearchDeposit.SearchAccount"; // cob_ahorros..sp_query_nom_ctahorro: S,0
	final String SERVICEGETQUERYDEPOSIT = "Collateral.SearchDeposit.QueryDeposit";// cob_pfijo..sp_consop: Q,14806
	final String SERVICEGETQUERYACCOUNT = "Collateral.SearchDeposit.QueryAccount";// cob_ahorros....sp_tr_con_ahr_mon: 220
	final String SERVICE_SEARCH_ALL_POLICIES = "Collateral.CollateralQuery.SearchAllPolicy";// cob_custodia..sp_poliza: V,19103
	final String SERVICEREADPOLICY = "Collateral.CollateralQuery.ReadPolicy";// cob_custodia..sp_poliza: V,19103

	final String SERVICEREADCOLLATERAL = "Collateral.CollateralQuery.ReadCollateral";// cob_pfijo..sp_consop: Q,14806
	// VALIDACION DE IMPRESIONES
	final String SERVICE_VALIDATION_PRINT = "Credit.Report.Validation.ValidationService.GetValidation";

	// POLIZAS
	final String SERVICE_INSERT_POLICY = "Collateral.CollateralQuery.InsertNewPolicy";

	// Consulta Vinculacion Cliente
	final String SERVICEQUERYENTAILMENTCUSTOMER = "BusinessProcess.Customers.QueryCustomer.QueryCustomerEntailment";

	// Rechazo
	final String SERVICEREJECTTRANSACT = "Businessprocess.Creditmanagement.ApplicationManagment.RejectTransact";

	// Busqueda Actividad economica
	final String SERVICEECONOMICACTIVITY = "Businessprocess.Creditmanagement.EconomicActivityQuery.SearchEconomicActivityData";
	final String SERVICEECONOMICACTIVITYDESCRIPTION = "Businessprocess.Creditmanagement.EconomicActivityQuery.ReadEconomicActivityDescription";
	final String SERVICEECONOMICACTIVITYLASTLEVEL = "Businessprocess.Creditmanagement.EconomicActivityQuery.SearchEconomicActivityLastLevel";

	// Las de Crꥩto
	final String SERVICEDELETEDISTIBUTIONLINE = "CreditFacility.DistributionLineServices.DeleteDistribution";
	final String SERVICEUPDATEDISTRIBUTIONLINE = "CreditFacility.DistributionLineServices.UpdateDistribution";
	final String SERVICECREATEDISTRIBUTIONLINE = "CreditFacility.DistributionLineServices.CreateDistribution";
	// Validacion Cuentas Ahorros
	final String SERVICEVALIDATEAMOUNTSAVINGACCOUNTS = "Account.ValidateAmounts.ValidateAmountSavingAccounts";
	// Numero de Ciclo Cliente
	final String SERVICEGETCUSTOMERCYCLENUMBER = "CustomerDataManagementService.CustomerManagement.GetCustomerCycleNumber";

	// Obtener Entidades Granantia Compartida
	final String SERVICEGETSHAREDENTITIES = "Collateral.SharedEntities.GetEntities";

	final static String SEARCH_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.ListLoanAmount";
	final static String UPDATE_AMOUNT = "LoanGroup.GroupLoanAmountMaintenance.UpdateLoanAmount";
	final static String SEARCH_GROUP = "LoanGroup.GroupMaintenance.SearchGroup";
	final static String SEARCH_MEMBER = "LoanGroup.MemberMaintenance.SearchMember";// cob_pac..sp_miembro_grupo_busin - opcion S
	final static String SEARCH_DEBTOR = "LoanGroup.MemberMaintenance.SearchDebtor";

	// Verificacion de Datos
	final static String DATA_VERIFICATION_CREATE = "Businessprocess.Creditmanagement.DataVerification.CreateVerification";// cob_pac..sp_verificacion_datos - opcion I
	final static String DATA_VERIFICATION_SEARCH = "Businessprocess.Creditmanagement.DataVerification.SearchVerification";// cob_pac..sp_verificacion_datos - opcion Q
	final static String DATA_VERIFICATION_UPDATE = "Businessprocess.Creditmanagement.DataVerification.UpdateVerification";// cob_pac..sp_verificacion_datos - opcion U

	// Sincronizacion
	final static String CREATE_SYNCHRONIZATION = "Businessprocess.Creditmanagement.Synchronization.CreateSynchronizationActivity";// cob_credito sp_actividad_sincroniza - opcion I
	final static String QUERY_SYNCHRONIZATION = "Businessprocess.Creditmanagement.Synchronization.QuerySynchronizationActivity";// cob_credito sp_actividad_sincroniza - opcion Q
	final static String UPDATE_SYNCHRONIZATION = "Businessprocess.Creditmanagement.Synchronization.UpdateSynchronizationActivity";// cob_credito sp_actividad_sincroniza - opcion U
	final static String XML_QUESTIONNAIRE = "Businessprocess.Creditmanagement.Synchronization.XMLQuestionnaire";// cob_credito..sp_xml_cuestionario
	final static String XML_GRUPAL = "Businessprocess.Creditmanagement.Synchronization.XMLIngresoGrupal"; // cob_credito..sp_grupal_xml
	final static String XML_INDIVIDUAL = "Businessprocess.Creditmanagement.Synchronization.XMLIngresoIndividual"; // cob_credito..sp_individual_xml

	// servicio de BusinessCommonsPlatform
	final static String GETCATALOG_BY_STOREDPROCEDURE = "Busin.Service.GetCatalogByStoredProcedure";

	// servicio de Regla Monto Maximo
	final static String SERVICE_RULE_AMOUNT_MAX = "Businessprocess.Creditmanagement.RuleExecutionManagement.QueryRuleAmountMaxInd";// cob_credito..sp_individual_reglas

	// GROUP SYNC
	final static String GROUP_SYNC = "MobileManagement.SyncManagement.GroupSync";

	final static String UPDATE_FIEL_FIVE = "Businessprocess.Creditmanagement.ApplicationManagment.UpdateFieldFive";// cob_credito..sp_up_tr_solicitud

	// Consulta Documentos Personales
	final static String QUERY_DOCUMENTS_IND = "Loan.QueryDocuments.QueryDocumentsInd";// cob_credito..sp_busca_doc opcion=P

}
