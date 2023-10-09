package com.cobiscorp.ecobis.business.commons.platform.utils;

public interface ServiceId {

	// OFFICER
	String SEARCHOFFICER = "SystemConfiguration.OfficerManagement.SearchOfficer";
	// PARAMETERS
	String PARAMETERMANAGEMENT = "SystemConfiguration.ParameterManagement.ParameterManagement";

	// SERVICIO SPQUERYDINAMICO
	String GETCATALOG_BY_STOREDPROCEDURE = "Busin.Service.GetCatalogByStoredProcedure";

	String GENERATE_MATRIX = "CustomerDataManagementService.CustomerManagement.GenerateMatrix";
	// OFFICER
	String SEARCHOFFICEGEO = "SystemConfiguration.OfficeManagement.SearchOfficeGeoreference";

	// Biometrico
	String RENAPO_QUERY_BY_DETAIL = "OrchestationRenapoServiceSERVImpl.renapoQueryByDetail";
	String QUERY_EQUIVALENCES = "SystemConfiguration.EquivalenceManagement.QueryEquivalences"; //cob_conta_super..sp_equivalencias
	String RENAPO_QUERY_BY_CURP = "OrchestationRenapoServiceSERVImpl.renapoQueryByCurp";

	/*INSURANCE*/
	String QUERY_INSURANCE = "LoansBusiness.Insurance.QueryInsurance";
	String MAINTAIN_INSURANCE = "LoansBusiness.Insurance.MaintainInsurance";
	String GET_CLIENT_INSURANCE = "LoansBusiness.Insurance.GetClientInsurance";
}
