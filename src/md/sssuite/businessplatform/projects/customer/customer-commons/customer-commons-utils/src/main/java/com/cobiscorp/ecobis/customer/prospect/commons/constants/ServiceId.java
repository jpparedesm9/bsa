package com.cobiscorp.ecobis.customer.prospect.commons.constants;

public interface ServiceId {

	// CUSTOMER SERVICES
	String SEARCH_BY_IDENTIFICATION = "CustomerDataManagementService.CustomerManagement.SearchByIdentification";
	// RELATION SERVICES
	String INSERT_NATURAL_PROSPECT_RELATION = "CustomerDataManagementService.NaturalProspectManagement.InsertRelationNaturalProspect";
	String SEARCH_RELATION = "CustomerDataManagementService.CustomerManagement.SearchRelation";
	String SEARCH_RELATION_BY_PERSON = "CustomerDataManagementService.CustomerManagement.SearchRelationPerson";
	String DELETE_RELATION_BY_PERSON = "CustomerDataManagementService.CustomerManagement.DeleteRelation";

	// PROSPECT SERVICES
	String INSERT_NATURAL_PROSPECT = "CustomerDataManagementService.NaturalProspectManagement.InsertNaturalProspect";
	String UPDATE_NATURAL_PROSPECT = "CustomerDataManagementService.NaturalProspectManagement.UpdateNaturalProspect";
	String INSERT_LEGAL_PROSPECT = "CustomerDataManagementService.LegalProspectManagement.InsertLegalProspect";
	String UPDATE_LEGAL_PROSPECT = "CustomerDataManagementService.LegalProspectManagement.InsertLegalProspect";
	String CREATE_NATURAL_PROSPECT = "CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectAndSpouse";
	String UPDATE_RENAPO_CUSTOMER = "CustomerDataManagementService.CustomerManagement.UpdateCustomerRENAPO";
	String CREATE_LEGAL_PROSPECT = "CustomerDataManagementService.LegalProspectManagement.CreateLegalProspect";
	// ADRESS SERVICES
	String CREATE_ADDRESS = "CustomerDataManagementService.CustomerManagement.CreateAddressSan";
	String UPDATEADDRESSSERVICE = "CustomerDataManagementService.CustomerManagement.UpdateAddressSan";
	String DELETE_ADDRESS = "CustomerDataManagementService.CustomerManagement.DeleteAddressSan";
	String SEARCH_ADDRESS_PROSPECT = "CustomerDataManagementService.CustomerManagement.SearchAddresProspectSan";
	String SEARCH_ZIP_POSTAL = "CustomerDataManagementService.CustomerManagement.SearchZipPostal";
	String FIND_ZIP_POSTAL = "CustomerDataManagementService.CustomerManagement.FindPostalCode";
	// GEOLOCATION SERVICES
	String CREATE_GEOLOCATION = "CustomerDataManagementService.CustomerManagement.CreateGeoreferencing";
	String UPDATE_GEOLOCATION = "CustomerDataManagementService.CustomerManagement.UpdateGeoreferencing";
	String DELETE_GEOLOCATION = "CustomerDataManagementService.CustomerManagement.UpdateGeoreferencing";
	// PHONE SERVICES
	String CREATE_PHONE = "CustomerDataManagementService.CustomerManagement.CreateTelephone";
	String UPDATE_PHONE = "CustomerDataManagementService.CustomerManagement.UpdateTelephone";
	String DELETE_PHONE = "CustomerDataManagementService.CustomerManagement.DeleteTelephone";
	String SEARCH_PHONE = "CustomerDataManagementService.CustomerManagement.SearchTelephone";
	// DOCUMENTS SERVICES
	String SEARCH_DOCUMENT_TYPES = "CustomerDataManagementService.Queries.SearchDocumentTypes";
	// LEGAL PERSON SERVICES
	String UPDATE_LEGAL_PERSON = "CustomerDataManagementService.CustomerManagement.UpdateLegalPerson";
	String FIND_LEGAL_PERSON = "CustomerDataManagementService.CustomerManagement.ReadCompany";
	// CUSTOMER BUSSINES
	String CREATE_BUSINESS = "CustomerDataManagementService.CustomerManagement.CreateCustomerBusiness";
	String UPDATE_BUSINESS = "CustomerDataManagementService.CustomerManagement.UpdateCustomerBusiness";
	String DELETE_BUSINESS = "CustomerDataManagementService.CustomerManagement.DeleteCustomerBusiness";
	String SEARCH_BUSINESS = "CustomerDataManagementService.CustomerManagement.SearchCustomerBusiness";
	String SEARCH_ADDRESSHOME = "CustomerDataManagementService.CustomerManagement.SearchAddressByHome";
	// CUSTOMER BUSSINES
	String CREATE_REFERENCES = "CustomerDataManagementService.CustomerManagement.CreateCustomerReference";
	String UPDATE_REFERENCES = "CustomerDataManagementService.CustomerManagement.UpdateCustomerReference";
	String DELETE_REFERENCES = "CustomerDataManagementService.CustomerManagement.DeleteCustomerReference";
	String SEARCH_REFERENCES = "CustomerDataManagementService.CustomerManagement.SearchCustomerReference";

	// CUSTOMER SYNC
	String CUSTOMER_SYNC = "MobileManagement.SyncManagement.CustomerSync";

	// SPOUSE PROSPECT SERVICES
	String INSERT_SPOUSE_PROSPECT = "CustomerDataManagementService.NaturalProspectManagement.CreateNaturalProspectSpouse";
	String SEARCH_SPOUSE_PROSPECT = "CustomerDataManagementService.CustomerManagement.SearchSpouseCustomer";

	// REPORT BUREAU
	String QUERY_REPORT_BUREAU = "CustomerDataManagementService.NaturalProspectManagement.QueryReportBureau";

	// TRANSFER CUSTOMER
	String SEARCH_CUSTOMER = "CustomerDataManagementService.CustomerManagement.SearchCustomerByOfficial";
	String SEARCH_OFFICE = "CustomerDataManagementService.CustomerManagement.SearchOfficeTransfer";
	String SEARCH_OFFICIAL = "CustomerDataManagementService.CustomerManagement.SearchOfficialTransfer";
	String CREATE_REQUEST_TRANSFER = "CustomerDataManagementService.CustomerManagement.CreateRequestTransfer";
	String SEARCH_REQUEST_TRANSFER = "CustomerDataManagementService.CustomerManagement.SearchRequestTransfer";
	String AUTH_REQUEST_TRANSFER = "CustomerDataManagementService.CustomerManagement.AuthorizationTransfer";
	String AUTH_TRANSFER_DETAIL = "CustomerDataManagementService.CustomerManagement.AuthorizationTransferDetail";
	String REFU_REQUEST_TRANSFER = "CustomerDataManagementService.CustomerManagement.RefuseTransfer";

	// CUSTOMER BUSSINES
	String CREATE_ALERT = "CustomerDataManagementService.CustomerManagement.CreateAlert";
	String DELETE_ALERT = "CustomerDataManagementService.CustomerManagement.DeleteAlert";
	String SEARCH_ALERT = "CustomerDataManagementService.CustomerManagement.SearchAlert";
	String UPDATE_RISK = "CustomerDataManagementService.CustomerManagement.UpdateRisk";
	String SEARCH_RISK = "CustomerDataManagementService.CustomerManagement.SearchRisk";

	// OPERATION INUSUAL SERVICES
	String CREATE_REPORT_OPERATION_INISUAL = "CustomerDataManagementService.CustomerManagement.CreateReportOpeInusual";

	// CONSULTA ACTIVACION DEL CLIENTE
	String QUERY_ACTIVATION = "CustomerDataManagementService.NaturalProspectManagement.QueryActivationsClients";

	// CUSTOMER BUSSINES
	String UPDATE_ALTAIR = "CustomerDataManagementService.CustomerManagement.UpdateAltairAccount";

	String VALIDATE_ADDRESS = "CustomerDataManagementService.CustomerManagement.ValidateAddress";

	// PRELACION CUENTAS
	String ACCOUNT_PRIORITY = "CustomerDataManagementService.Queries.SearchAccountPriority";
	
	// ACTUALIZACION ESTADO MODIFICACION PANTALLA DIRECCIONES
	String UPDATE_STATE = "CustomerDataManagementService.CustomerManagement.SearchState";
	
	// REFERENCIA SOCIO COMERCIAL
	String QUERY_PURCHASE_REFERENCE = "CustomerDataManagementService.BusinessPartnerReference.QueryReference";
	String VALIDATE_REFERENCE = "CustomerDataManagementService.BusinessPartnerReference.ValidateReference";
	String EXECUTE_PURCHASE_CONFIRMATION = "CustomerDataManagementService.BusinessPartnerReference.PurchaseConfirmation";
}
