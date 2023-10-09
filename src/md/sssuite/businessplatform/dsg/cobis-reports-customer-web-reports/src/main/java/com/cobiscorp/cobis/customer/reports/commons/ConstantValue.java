package com.cobiscorp.cobis.customer.reports.commons;

import java.io.File;

public class ConstantValue {

	public static class Params {
		public static final String BANK = "numBanco";
		public static final String APPLICATION = "idApplication";
		public static final String ID_CUSTOMER = "idCustomer";
		public static final String URLIMAG = File.separator + "logo.jpg"; // File.separator + "imagen" + File.separator
		public static final String BURO_REPORT_HISTORICO="006.pdf";
		public static final String BURO_REPORT_INTERNO="007.pdf";
		public static final String ROOT_FOLDER_CUSTOMER = "Customer";
	}

	public static class valueConstant {
		public static final String DF_YYYYMMDD = "yyyy/MM/dd";
		public static final String DF_MMDDYYYY = "MM/dd/yyyy";
		public static final String DF_DDMMYYYY = "dd/MM/yyyy";
		public static final Integer FORMAT_DATE = 103;
	}

	public static class serviceName {
		public static final String BURO_CREDIT_INTERNAL_EXTERNAL_CREDIT_REPORT = "CustomerDataManagementService.ReportsManagement.InternalExternalCreditReport";
		public static final String BURO_CREDIT_HISTORY_REPORT = "CustomerDataManagementService.ReportsManagement.HistoricalCreditReport";
		public static final String SCANNED_DOCUMENTS= "LoanGroup.ScannedDocuments.UpdateScannedDocuments";
		public static final String UPDATE_BURO_MISTAKE = "CustomerDataManagementService.ReportsManagement.UpdateBuroMistake";
		public static final String BURO = "";
	}

	public static class requestName {
		public static final String REPORT_REQUEST = "inReportRequest";
		public static final String SCANNED_DOCUMENTS_REQUEST= "inScannedDocumentsRequest";
	}

	public static class returnName {
		public static final String REPORT_IE_ACCOUNTCLIENT_RESPONSE = "returnReportIEAccountClientResponse";
		public static final String REPORT_IE_ADDRESS_RESPONSE = "returnReportIEAddressResponse";
		public static final String REPORT_IE_CUSTOMER_RESPONSE = "returnReportIECustomerResponse";
		public static final String REPORT_IE_LOAN_RESPONSE = "returnReportIELoanResponse";

		public static final String REPORT_HIST_CUSTOMER_RESPONSE = "returnReportHistCustomerResponse";
		public static final String REPORT_HIST_EMPLOYEE_HOME_RESPONSE = "returnReportHistEmployeeHomeResponse";
		public static final String REPORT_HIST_DETAIL_THECREDITS_RESPONSE = "returnReportHistDetailTheCreditsResponse";
		public static final String REPORT_HIST_CREDITS_SUMMARY_RESPONSE = "returnReportHistCreditsSummaryResponse";
		public static final String REPORT_HIST_CREDITS_SUMMARY_PRINCIPAL_RESPONSE = "returnReportHistCreditsSummaryPrincipalResponse";
		public static final String REPORT_HIST_DETAIL_CONSULTATIONS_RESPONSE = "returnReportHistDetailConsultationsResponse";
		public static final String REPORT_HIST_SCORE_BURO_RESPONSE = "returnReportHistScoreBuroResponse";

	}

	public static class jasperPath {

	}
}
