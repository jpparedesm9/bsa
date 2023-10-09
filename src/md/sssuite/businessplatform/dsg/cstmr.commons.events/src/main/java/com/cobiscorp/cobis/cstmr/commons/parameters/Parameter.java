package com.cobiscorp.cobis.cstmr.commons.parameters;

public abstract class Parameter {

	public static final String MESSAGESERVERLIST = "MESSAGESERVERLIST";
	public static final String MESSAGEVALIDATIONLIST = "MESSAGEVALIDATIONLIST";
	public static final String RESULTLIST = "RESULTLIST";
	public static final String RESULTLISTCATALOG = "RESULTLISTCATALOG";

	public static final String PROCESSUPDATECUSTOMERS = "CustomerDataManagementService.CustomerManagement.UpdateCustomer";
	public static final String PROCESSUPDATECUSTOMERS_CURPRFC = "CustomerDataManagementService.CustomerManagement.UpdateCustomerCURPRFC";
	public static final String PROCESSLOADCOUNTY = "CustomerDataManagementService.CountryManagement.ReadCountry";
	public static final String SEARCH_DOCUMENT_TYPES = "CustomerDataManagementService.Queries.SearchDocumentTypes";
	public static final String SEARCH_OFFICIALS = "CustomerDataManagementService.OfficialManagement.SearchOfficials";
	public static final String READ_SPOUSE = "CustomerDataManagementService.Queries.ReadSpouse";
	public static final String READ_MINIMUM_AGE = "CustomerDataManagementService.Queries.ReadMinimumAgeParameter";
	public static final String READ_ID_EXPIRATION = "CustomerDataManagementService.Queries.ReadIdExpirationParameter";
	public static final String PROCESSUPDATECUSTOMERS_COMPLEMENTARYDATA = "CustomerDataManagementService.CustomerManagement.UpdateCustomerComplementaryData";

	public static final String EMPTY_VALUE = "";

	public static final char OPERATION_SEARCH = 'S';
	public static final char OPERATION_QUERY = 'Q';
	public static final char OPERATION_HELP = 'H';
	public static final char OPERATION_INSERT = 'I';
	public static final char OPERATION_UPDATE = 'U';
	public static final char OPERATION_DELETE = 'D';

	public static final String INACTIVE = "N";
	public static final String ACTIVE = "S";
	
	public static final String RENAPO_INACTIVE = "N";
	public static final String RENAPO_ACTIVE = "S";
	public static final String RENAPO_VALIDATED = "S";
	public static final String RENAPO_PENDING = "N";
	public static final String RENAPO_ERROR_AT_GETTING_DATA = "I";
	public static final String RENAPO_CONNECTION_ERROR = "E";

	public static final String RENAPO_ERROR_MSG = "CSTMR.MSG_CSTMR_NOEXISTAA_14779";
	public static final String RENAPO_ERROR_MSG_1 = "ERROR: Sin conexión o servicio, validación de CURP no exitosa.";
	public static final String RENAPO_ERROR_MSG_2 = "ERROR: No se encontraron datos en RENAPO, favor de validar los datos.";
	
	public static final String WEB_CHANNEL = "4";

	public enum TYPEEXECUTION {
		UPDATE, DELETE, SEARCH
	}

	public enum TYPESEUDOCATALOG {
		COUNTRY, NATIONALITY
	}

	public enum LEVELDEBUG {
		ERROR, DEBUG, INFO
	}

	public enum MODECUSTOMER {
		TOTAL, INFOGENERAL, DEMOGRAPHIC, ECONOMIC
	}

	public static final String SUCCESSFUL_TRANSACTION = "CSTMR.LBL_CSTMR_LATRANSZA_43084";
	public static final String MISSING_RECORDS = "CSTMR.LBL_CSTMR_NOEXISTSN_20137";

	public static final String DATEFORMAT = "dd/MM/yyyy";
	public static final String DATEFORMATDB = "yyyy/MM/dd";
	public static final String STATE = "STATE";
	public static final String LINKED = "LINKED";
	public static final String CURP = "CURP";
	public static final String RFC = "RFC";
	public static final String LISTBLACK = "LISTBLACK";
	
	public static final String MAIL_TYPE = "MAIL";
	public static final String SMS_TYPE = "SMS";

}
