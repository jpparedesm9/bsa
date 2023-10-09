package com.cobiscorp.cobis.mbile.commons.parameters;

public abstract class Parameter {

	public static final String MESSAGESERVERLIST = "MESSAGESERVERLIST";
	public static final String MESSAGEVALIDATIONLIST = "MESSAGEVALIDATIONLIST";
	public static final String RESULTLIST = "RESULTLIST";
	public static final String RESULTLISTCATALOG = "RESULTLISTCATALOG";

	public static final String PROCESSUPDATECUSTOMERS = "CustomerDataManagementService.CustomerManagement.UpdateCustomer";
	public static final String PROCESSLOADCOUNTY = "CustomerDataManagementService.CountryManagement.ReadCountry";
	public static final String SEARCH_DOCUMENT_TYPES = "CustomerDataManagementService.Queries.SearchDocumentTypes";
	public static final String SEARCH_OFFICIALS = "CustomerDataManagementService.OfficialManagement.SearchOfficials";
	public static final String READ_SPOUSE = "CustomerDataManagementService.Queries.ReadSpouse";
	public static final String READ_MINIMUM_AGE = "CustomerDataManagementService.Queries.ReadMinimumAgeParameter";
	public static final String READ_ID_EXPIRATION = "CustomerDataManagementService.Queries.ReadIdExpirationParameter";

	public static final String EMPTY_VALUE = "";

	public static final char OPERATION_SEARCH = 'S';
	public static final char OPERATION_QUERY = 'Q';
	public static final char OPERATION_HELP = 'H';
	public static final char OPERATION_INSERT = 'I';
	public static final char OPERATION_UPDATE = 'U';
	public static final char OPERATION_DELETE = 'D';

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

}
