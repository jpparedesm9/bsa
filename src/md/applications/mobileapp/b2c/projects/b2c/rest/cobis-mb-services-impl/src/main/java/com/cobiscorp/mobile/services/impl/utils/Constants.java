package com.cobiscorp.mobile.services.impl.utils;

public class Constants {

	public static final String URLSE = "http://localhost:9080/ServiceExecutor/services/ServiceExecutorWS";
	public static final String SERVICE_OUTPUT_VALUES = "com.cobiscorp.cobis.cts.service.response.output";
	public static final int TIMEOUTCODEERROR = 80103;

	public static final String SERVICE = "8";
	public static final String SERVICE_MOBILE_BANKING = "8";
	public static final String CURRENCY_DOLAR_SYMBOL = "$";
	public static final String CURRENCY_DOLAR_DESCRIPTION = "DOLAR";
	public static final String CODE_CURRENCY_DOLAR = "2";
	public static final String CODE_NATIONAL_CURRENCY = "0";
	public static final String NATIONAL_CURRENCY_DESCRIPTION = "BOLIVIANOS";
	public static final String NATIONAL_CURRENCY_SYMBOL = "Bs.";
	public static final String CODE_SAVINGS_ACCOUNT = "4";
	public static final String DESCRIPTION_SAVINGS_ACCOUNT = "AHORROS";
	public static final String CODE_CURRENT_ACCOUNT = "3";
	public static final String DESCRIPTION_CURRENT_ACCOUNT = "CORRIENTES";
	public static final String CODE_PRODUCT_LOAN = "7";
	public static final String SAVINGS_ACCOUNT_TEXT = "AHO";
	public static final String CURRENT_ACCOUNT_TEXT = "CTE";
	public static final String PRODUCT_LOAN_TEXT = "CCA";
	public static final String PRODUCT_LOAN_COMPLETE_TEXT = "PRÉSTAMOS";
	public static final String CODE_LOAN_PRODUCT = "7";
	public static final String DESCRIPTION_LOAN = "PRÉSTAMOS";
	public static final String CODE_DPF_PRODUCT = "14";
	public static final String DESCRIPTION_DPF = "DEPÓSITOS A PLAZO FIJO";
	public static final String ORIGIN_ACCOUNT = "origin";
	public static final String DESTINATION_ACCOUNT = "destination";

	public static final String TRANSFERENCIA_OPER = "TRF";

	public static final String BIOMETRIC_ENROLL = "0";
	public static final String BIOMETRIC_UNENROLL = "1";
	public static final String BIOMETRIC_VERIFICATION = "2";
	public static final String BIOMETRIC_STATUS = "3";

	/** ERRORES */
	public static final String ERROR_MB_SERVICE_NOT_AVAILABLE = "MB_ERR_000001";
	public static final String ERROR_MB_DEFAULT = "MB_ERR_000002";
	public static final String ERROR_MB_UNKNOWN = "MB_ERR_000004";

	/** IDIOMAS */
	public static final String LANG_ES_EC = "ES-EC";
	public static final String LANG_EN_US = "EN-US";

	/** SESSION */
	public static final String MB_USER = "MOBILE_BANKING_USER";
	public static final String MB_ENTE_ID = "MOBILE_BANKING_ENTE_ID";
	public static final String MB_ENTE_MIS_ID = "MOBILE_BANKING_ENTE_MIS";
	public static final String MB_COMPLETE_NAME = "MOBILE_BANKING_COMPLETE_NAME";

	/** CACHE */
	public static final String MB_CONF = "MobileConfigurations";
	public static final String MB_IMAGES = "MobileImages";
	public static final String MB_FTP = "MobileFTP";
	public static final String MB_BANNER = "Banner";
	public static final String MB_AGREEMENTS = "Agreements";
	public static final String MB_PARAMS = "Parameters";

	/* Services Onboarding */
	public static final String SERV_ONBOARDING_REGISTER = "BusinessToConsumer.CustomerManagement.OnboardingRegister";
	public static final String SERV_UPDATE_PROSPECT = "BusinessToConsumer.CustomerManagement.UpdateProspect";
	public static final String SERV_CREATE_ADDRESS = "BusinessToConsumer.CustomerManagement.CreateAddress";
	public static final String SERV_SEARCH_CUSTOMER = "BusinessToConsumer.CustomerManagement.SearchCustomer";

	public static final String PROCESS_OK_CODE = "1";

	public static final String INE = "INE";
	public static final String IFE = "IFE";

}
