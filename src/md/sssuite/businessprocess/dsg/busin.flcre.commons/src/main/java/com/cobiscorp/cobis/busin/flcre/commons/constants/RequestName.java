package com.cobiscorp.cobis.busin.flcre.commons.constants;

public interface RequestName {
	final String INPROCESSEDNUMBER = "inProcessedNumber";
	final String INAPPLICATIONREQUEST = "inApplicationRequest";
	final String INREADAPPLICATIONREQUEST = "inReadApplicationRequest";
	final String INAPPLICATIONNEWREQUEST = "inApplicationNewRequest";
	final String INITEMSREQUEST = "inReadLoanItemsRequest";
	final String INLOANREQUEST = "inLoanRequest";
	final String INLOANOPTIONREQUEST = "inLoanOptionRequest";
	final String INDEBTORREQUEST = "inDebtorRequest";
	final String INOFFICEREQUEST = "inOfficeRequest";
	final String INRATINGAPPLICATIONREQUEST = "inRatingApplicationRequest";
	final String INCUSTOMER = "inCustomer";
	final String INPROCESSINSTDTO = "inInstanceProcess";
	final String INCUSTOMEREQUEST = "inCustomerRequest";
	final String INLOANAMORTIZATIONTABLEREQUEST = "inReadLoanAmortizationTableRequest";
	final String INPARAMETERREQUEST = "inParameterRequest";
	final String INEXCHANGERATEREQUEST = "inExchangeRateRequest";
	final String INRULEREQUEST = "inRuleRequest";
	final String INUPDATELOANITEMS = "inUpdateLoanItems";
	final String INREADLOANDITEMSREQUEST = "inReadLoanItemsRequest";
	final String INDISBURSEMENTFORM = "inReadDisbursementFormRequest";
	final String INDISTRIBUTIONLINE = "inLineOpCurrencyData";
	final String INADITIONALLINE = "inLineAditionalData";
	final String INDATATYPEOPERATION = "inDataTypeOperationRequest";
	final String INECONOMICACTIVITYREQUEST = "inEconomicActivityRequest";
	final String INOFFICERREQUEST = "inOfficerRequest";
	final String INCOLLATERALAPPLICATION = "inCollateralApplicationRequest";
	final String ININSURANCE = "inPolicyRequest";
	final String INLOANGENERALDATA = "inReadLoanGeneralDataRequest";
	final String INPOINTREDUCTIONAPPLICATIONREQUEST = "inPointReductionApplicationRequest";
	final String INHIERARCHYROLE = "inHierarchyRole";
	final String ININFOCRED = "inInfocred";
	final String INCONTEXTREQUEST = "inContextRequest";
	final String INFOCREDREQUEST = "inInfocredRequest";
	final String INCUSTOMERREQUEST = "inCustomerRequest";
	final String INADDRESSREQUEST = "inAddressRequest";
	final String INTELEPHONEREQUEST = "inTelephoneRequest";
	final String INREFERENCEREQUEST = "inReferenceRequest";
	final String INVARIABLEDATAREQUEST = "inVariableDataRequest";
	final String INFINANEVALREQUEST = "inFinanEvalRequest";
	final String INQUOTEREQUEST = "inQuoteRequest";
	final String INRENEWDATAREQUEST = "inRenewDataRequest";
	final String INREADOPERATION = "inReadOperationCustomerRequest";
	final String INREVOLVINGREQUEST = "inRevolvingRequest";
	final String INRENEWLOANREQUEST = "inRenewLoanRequest";
	final String INACTIVITYPROCESS = "inRuleProcessHistory";
	final String INCITYREQUEST = "inCityRequest";
	final String INWORKLOADOFFICERREQUEST = "inWorkloadOfficerRequest";
	final String INDATEREQUEST = "inDateRequest";
	final String INARREARSREQUEST = "inArrearsRequest";
	final String INPENALIZATIONREQUEST = "inPenalizationRequest";
	final String INCONSOLIDATEPENALIZATIONREQUEST = "inConsolidatePenalizationRequest";
	final String INSALESCOMMISSIONREQUEST = "inSalesCommissionRequest";
	final String INRISKDATAREQUEST = "inRiskDataRequest";
	final String INBANKGUARANTEEREQUEST = "inBankGuaranteeRequest";
	final String INTYPEBANKGUARANTEEREQUEST = "inTypeBankGuaranteeRequest";
	final String INGUARANTEEINFORMATION = "inGuaranteeInformation";
	final String INCOMMONPARAMS = "inCommonParams";
	final String INDOCUMENTSREQUEST = "inDocumentsRequest";
	final String INDOCUMENTSAPPLICATIONREQUEST = "inDocumentsApplicationRequest";
	final String INOFFICIALCOMEXTREQUEST = "inOfficialComextRequest";
	final String INRULEBANKGUARANTEEREQUEST = "inRuleBankGuaranteeRequest";
	final String INREADLOANPAYMENTREQUEST = "inReadLoanPaymentrequest";
	final String INPRORATEDREQUEST = "inProratedRequest";
	final String INCOMMISSIONCALCULATIONREQUEST = "inCommissionCalculationRequest";
	final String INSOURCEFUNDINGREQUEST = "inSourceFundingRequest";
	final String INACTIVITYREQUEST = "inActivityRequest";
	final String INPROCESSREQUEST = "inProcessRequest";
	final String INCURRENCYREQUEST = "inCurrencyRequest";
	final String INCOLLATERALTYPEREQUEST = "inCollateralTypeRequest";
	final String INTYPEGUARANTEEINFORMATION = "inTypeGuaranteeInformation";
	final String INCOVERAGECUSTODYREQUEST = "inCoverageCustodyRequest";
	final String INUPDATECOLLATERALREQUEST = "inUpdateCollateralRequest";
	final String INSHAREDREQUEST = "inSharedEntityRequest";
	final String INCUSTOMERCOLLATERALREQUEST = "inCustomerCollateralRequest";
	final String INCUSTODYINFORMATION = "inCustodyInformation";
	final String INCCOMMONPARAMS = "inCommonParams";

	final String INAPPROVALASSOCIATION = "inApprovalAssociation";
	final String ININSTANCEACTIVITY = "inInstanceActivity";
	final String INFIXEDTERMINFORMATION = "inFixedTermInformation";

	final String INACCOUNTINFORMATION = "inAccountInformation";

	// SOLO PARA REGLAS
	final String RULE_RATEREQUEST = "inRuleRateRequest";
	final String RULE_SCOREREQUEST = "inRuleScoreRequest";
	final String RULE_CREDIT_SECTOR_REQUEST = "inRuleCreditSectorRequest";

	// Para validacion de impresion
	final String IN_VALIDATION_REQUEST_PRINT = "inValidationRequest";

	// Para rechazo de operaciones
	final String INREJECTTRANSACTREQUEST = "inRejectRequest";

	// Polizas de una garantia
	final String INPOLICYINFORMATION = "inPolicyAllInformation";

	// Busqueda actividad economica
	final String INECONOMICACTIVITYDATA = "inEconomicActivityDataRequest";

	final static String AMOUNT_REQUEST = "inGroupLoanAmountRequest";
	final static String GROUP_REQUEST = "inGroupRequest";
	final static String MEMBER_REQUEST = "inMemberRequest";

	// Verificacion de Datos
	final static String DATA_VERIFICATION_REQUEST = "inDataVerificationRequest";

	// Sincronizacion
	final static String DATA_SYNCHRONIZATION_REQUEST = "inSynchronizationRequest";

	// Sincronizacion Grupo
	final static String GRPOUP_SYNC_REQUEST = "inGroupSyncRequest";

	// Consulta de Documentos
	final static String QUERY_DOCUMENTS_REQUEST = "inQueryDocumentsRequest";

}
