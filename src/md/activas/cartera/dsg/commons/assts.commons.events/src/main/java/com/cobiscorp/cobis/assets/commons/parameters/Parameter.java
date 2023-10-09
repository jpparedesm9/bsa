package com.cobiscorp.cobis.assets.commons.parameters;

public abstract class Parameter {
	public static final String MESSAGESERVERLIST = "MESSAGESERVERLIST";
	public static final String MESSAGEVALIDATIONLIST = "MESSAGEVALIDATIONLIST";
	public static final String RESULTLIST = "RESULTLIST";
	public static final String RESULTLISTCATALOG = "RESULTLISTCATALOG";
	public static final char TYPECHARGES = 'P';

	public static final String PROCESSSEARCHREADJUSTMENT = "Loan.LoanMaintenance.ReadjustmentLoanSearch";
	public static final String PROCESSUPDATEREADJUSTMENT = "Loan.LoanMaintenance.ReadjustmentLoanUpdate";
	public static final String PROCESSDELETEREADJUSTMENT = "Loan.LoanMaintenance.ReadjustmentLoanDelete";
	public static final String PROCESSPROJECTIONQUOTA = "Loan.LoanTransaction.LoanProyectionQuota";
	public static final String PROCESSSEARCHREADJUSTMENTDETAILS = "Loan.LoanMaintenance.ReadjustmentDetalilsLoanSearch";
	public static final String PROCESSUPDATEREADJUSTMENTDETAILS = "Loan.LoanMaintenance.ReadjustmentDetalilsLoanUpdate";
	public static final String PROCESSDELETEREADJUSTMENTDETAILS = "Loan.LoanMaintenance.ReadjustmentDetalilsLoanDelete";
	public static final String PROCESSCREATERETTENTION = "Loan.LoanMaintenance.CreateRetention";
	public static final String SERVICE_SEARCH_FUND_RESOURCES = "Loan.FundManagement.SearchFundResource";
	public static final String SERVICE_FUND_INSERT = "Loan.FundManagement.CreateFundResource";
	public static final String SERVICE_FUND_UPDATE = "Loan.FundManagement.UpdateFundResource";
	public static final String PROCESS_READ_GROUP_TRAN = "Loan.GroupTransactManagement.ReadGroupTransactionInfo";
	public static final String PROCESS_SEND_COLLATERAL_MAIL = "Loan.FlowProcessManagement.SendCollateralMail";
		
		public static final String PROCESSQUERYLISTPRODUCT = "Loan.LoanMaintenance.QueryListProduct";

	public static final String PROCESSPAYCATEGORY = "Loan.LoanMaintenance.PaidCategory";

	public static final String PROCESSDELETERETTENTION = "Loan.LoanMaintenance.DeleteRetention";

	public static final String PROCESSUPDATERETTENTION = "Loan.LoanMaintenance.UpdateRetention";

	public static final String PROCESSEXTENDSQUOTA = "Loan.LoanMaintenance.LoanExtendsQuota";
	public static final String PROCESSQUERYLOANEXTENDSQUOTA = "Loan.LoanMaintenance.QueryLoanExtendsQuota";
	public static final String PROCESSCATALOGVALORDET = "Loan.GeneralInfo.CatalogValoDet";
	public static final String PROCESSSEARCHRETENTION = "Loan.LoanMaintenance.SearchRetention";

	public static final String PROCESSREFINANCELOANS = "Loan.SearchLoanRefinancing.SearchLoanRefinancing";
	public static final String PROCESSDOCUMENTPRINT = "Loan.LoanTransaction.QueryReceipPaymentInfo";
	public static final String PROCESSAMORTIZATIONTABLE = "Loan.LoansQueries.ReadLoanAmortizationTableSearch";
	public static final String PROCESSLOANSUMMARY = "Loan.LoansQueries.ReadLoanSummary";
	// FECHA VALOR
	public static final String PROCESS_LOAN_TRANSACTION_SEARCH = "Loan.LoanTransaction.LoanTransactionSearch";
	public static final String PROCESS_VALUE_DATE_TRANSACTION = "Loan.LoanTransaction.ValueDateTransaction";
	public static final String PROCESS_PAYMENT_QUERY = "Loan.OperationDataQuery.SearchPayment";
	public static final String PROCESS_TRANSACTION_QUERY = "Loan.OperationDataQuery.SearchTransactions";
	public static final String PROCESS_GENERAL_LOAN_DATA = "Loan.LoansQueries.GeneralLoanData";
	public static final String PROCESS_PAYMENT_DETAIL_QUERY = "Loan.OperationDataQuery.SearchPaymentDetail";
	public static final String PROCESS_TRANSACTION_DETAIL_QUERY = "Loan.OperationDataQuery.SearchTransactionDetail";
	public static final String PROCESS_SEARCH_LOAN_CUSTOMER = "Loan.LoanMaintenance.SearchLoanCustomer";
	public static final String PROCESS_LOAN_QUOTE_DETAIL_QUERY = "Loan.OperationDataQuery.QueryCurrentState";
	public static final String PROCESS_SEARCHREFINANCELOAN = "Loan.OperationDataQuery.SearchRefinanceLoan";
	public static final String PROCESS_OPERATION_DATA_QUERY = "Loan.OperationDataQuery.QueryPaymentConditions";
	public static final String PROCESS_QUERYENTRY = "Loan.OperationDataQuery.QueryEntry";
	public static final String PROCESS_QUERYRATE = "Loan.OperationDataQuery.QueryRate";
	public static final String PROCESS_QUERYWARRANTY = "Loan.OperationDataQuery.QueryWarranty";
	public static final String PROCESS_QUERYDEBTOR = "Loan.OperationDataQuery.QueryDebtor";

	// INICIO PAGOS
	public static final String PROCESS_QUERYCATALOGBANK = "Loan.ProductListCredit.QueryCatalogBank";
	public static final String PROCESS_QUERYCURRENCYLISTCREDIT = "Loan.CurrencyListCredit.CurrencyListCredit";
	public static final String PROCESS_QUERYPRODUCTLIST = "Loan.ProductListCredit.ProductListCredit";
	public static final String PROCESS_QUERYLOANPAYMENT = "Loan.ProductListCredit.QueryLoanPayment";
	public static final String PROCESS_PAYMENTENTRY = "Loan.ProductListCredit.PaymentsEntry";
	public static final String PROCESS_LOAN_PAYMENT = "Loan.ProductListCredit.QueryLoanPayment";
	public static final String PROCESS_QUOTA_DETAIL_PAYMENT = "Loan.AmortizationDetail.AmortizationDetail";
	public static final String PROCESS_QUERYPRODUCT = "Loan.ProductListCredit.ProductCredit";
	public static final String PROCESS_BANKACCOUNTLIST = "Loan.ProductListCredit.BankAccountList";
	public static final String PROCESS_CREDITDETAIL = "Loan.ProductListCredit.CreditDetail";
	// FIN PAGOS

	public static final String PROCESS_GRIDOTHERCHARGES = "Loan.LoanTransaction.TransactionOtherChargesGrid";
	public static final String PROCESS_BUTTONOTHERCHARGES = "Loan.LoanTransaction.TransactionOtherCharges";
	public static final String PROCESS_CHANGEBASECALCULATION = "Loan.LoanTransaction.TransactionOtherChargesItems";
	public static final String PROCESS_CHANGEOTHERCHARGESITEMS = "Loan.LoanTransaction.TransactionOtherChargesItems";
	public static final String PROCESS_CONCEPLOADCATALOG = "Loan.LoanTransaction.TransactionOtherCharges";
	public static final String VALIDOPERATION = "Operación Ínvalida";

	// DESEMBOLSO
	public static final String LOAN_DISBURSEMENT_INFO = "Loan.ReadDisbursementForm.ReadDisbursementFormSearch";
	public static final String READ_GLOBAL_VARIABLES = "Loan.ReadDisbursementForm.ReadGlobalVariablesSearch";
	public static final String APPLY_AMORT_TABLE_SIMULATION = "Loan.ReadDisbursementForm.ApplyAmortizacionTable";
	public static final String INSERT_DETAIL_PAY_FORM = "Loan.ReadDisbursementForm.InsertDetailPaymentForm";
	public static final String REMOVE_DETAIL_PAY_FORM = "Loan.ReadDisbursementForm.RemoveDetailPaymentForm";
	public static final String APPLY_LIQUIDATION_LOAN = "Loan.ReadDisbursementForm.ApplyLiquidationLoan";
	public static final String QUERY_COBIS_ACCOUNTS = "Loan.ReadDisbursementForm.ReadAccountsSearch";
	public static final String QUERY_LOAN_PAYFORM_CATEGORY = "Loan.ReadDisbursementForm.ReadPaymentFormSearch";
	public static final String VALIDATE_ACC_OTHER_BANKS = "Loan.ReadDisbursementForm.ValidateAccountOtherBanks";

	// VENTANA PREVIA DE RENOVACIONES
	public static final String REFINANCE_OPERATION_TYPES = "Loan.LoansQueries.RefinanceOperationTypes";
	public static final String SEARCH_REFINANCING_OPERATIOS = "Loan.LoansQueries.SearchRefinancingOperations";
	public static final String READ_OPERATIONTYPE = "Loan.LoansQueries.ReadOperationType";
	public static final String GET_REFINANCING_STATUS = "Loan.LoansQueries.GetRefinancingStatus";
	public static final String LOANREPAYMENT = "Loan.LoanTransaction.LoanRepayment";

	// VALORES Y TASAS A APLICAR
	public static final String SEARCH_TYPE_RATES = "Loan.RatesManagement.SearchRates";
	public static final String SEARCH_VALUES_RATES = "Loan.RatesManagement.SearchValuesRate";
	public static final String CREATE_TYPE_RATE = "Loan.RatesManagement.CreateTypeRate";
	public static final String REFERENCE_VALUE_LIST = "Loan.RatesManagement.ReferenceValueList";
	public static final String GET_REFERENCE_VALUE = "Loan.RatesManagement.GetReferenceValue";
	public static final String DELETE_VALUES_RATE = "Loan.RatesManagement.DeleteValuesRate";
	
	// Estado de Cuenta
	public static final String CREATE_STATE_ACCOUNT = "Loan.LoanMaintenance.CreateStateAccount";
	public static final String EXECUTION_OPTIONS = "Loan.StateAccount.ExecutionOptions";

	// CONSULTA AHORRO INDIVIDUAL
	public static final String SEARCHDETAILSACCOUNTS = "Loan.SearchLoanItems.SearchDetailsAho";
	// ADMINISTRACION DE FONDOS
	public static final String SEARCH_FUND_RESOURCES = "Loan.FundManagement.SearchFundResource";

	public static final String DATEFORMAT = "dd/MM/yyyy";
	public static final int CODEDATEFORMAT = 103;
	public static final int VALIDATIONYEAR = 1900;

	public static final String DATEFORMATDB = "yyyy/MM/dd";
	public static final int CODEDATEFORMATDB = 111;
	public static final int DAYS = 60;
	public static final String NUMPROCEDURE = "numProcedure";
	public static final String OFFICEID = "officeID";
	public static final String OFFICERID = "officerID";
	public static final String EMPTY = "";
	public static final Integer NUM_REG_TR_MON = 0;
	public static final Integer NUM_REGISTRO = 0;

	public static final char QUERYTYPEA = 'A';
	public static final Integer QUERYTYPE1 = 1;

	public static final String OPERATIONI = "I";
	public static final String OPERATIONQ = "Q";
	public static final String OPERATIONA = "A";
	public static final String OPERATIONH = "H";
	public static final String OPERATIOND = "D";
	public static final String OPERATIONV = "V";
	public static final String OPERATIONC = "C";
	
	public static final String STRING_V = "V";

	public static final String MODEA = "A";
	public static final String MODEB = "B";
	public static final Integer MODE0 = 0;

	public static final String APPLY_OPTION = "APLICAR";

	public static final String OPERATION_ACH = "E";

	public static final String MODULE_PRODUCT = "CCA";
	public static final String T_QUOTATION = "COT";

	public static final String EXTENSION = "PRORROGA";
	public static final String FUSION = "FUSION";
	public static final String NONE = "NINGUNO";
	public static final String PRESENT_VALUE = "VALOR PRESENTE";
	public static final String ACCUMULATED_VALUES = "VALORES ACUMULADOS";
	public static final String PROJECTED_VALUES = "VALORES PROYECTADOS";
	public static final String ADVANCE_QUOTAS = "ADELANTO DE CUOTAS";
	public static final String REDUCTION_TIME = "REDUCCION DE TIEMPO";
	public static final String REDUCTION_QUOTA = "REDUCCION DE CUOTA";
	public static final String FRENCH = "FRANCESA";
	public static final String GERMAN = "ALEMANA";
	public static final String FIXED_FEE = "CUOTA FIJA";
	public static final String CONSTANT_CAPITAL = "CAPITAL CONSTANTE";
	public static final String MANUAL = "MANUAL";
	public static final String REAL = "REAL";
	public static final String COMMERCIAL = "COMERCIAL";
	public static final String YES = "SI";
	public static final String NO = "NO";
    private static String[] PRODUCTVALIDTYPEA;
    private static String[] PRODUCTVALIDTYPEB;
    
	public static void setProductValidTypeA() {
		PRODUCTVALIDTYPEA = new String[] { "NCAH", "NCCC", "NDAH", "NDCC", "ACHC", "CHGE" };
	}

	public static String[] getProductValidTypeA() {
		return PRODUCTVALIDTYPEA;
	}

	public static void setProductValidTypeB() {
		PRODUCTVALIDTYPEA = new String[] { "CHLO" };
	}

	public static String[] getProductValidTypeB() {
	        return PRODUCTVALIDTYPEB;
	} 
	
	public static final String DATEFORMATMMDDYYYY = "MM/dd/yyyy";

	public enum TYPEEXECUTION {
		UPDATE, DELETE, SEARCH
	}

	public enum TYPEDATEFORMAT {
		DDMMYYYY, YYYYMMDD, MMDDYYYY
	}

	public enum LEVELDEBUG {
		ERROR, DEBUG, INFO
	}

	public enum AMORTIZATION_STATUS {
		CANCELADO, VENCIDO, VIGENTE, NO_VIGENTE, OTHER;

		public static AMORTIZATION_STATUS getValue(String value) {
			for (AMORTIZATION_STATUS status : AMORTIZATION_STATUS.values()) {
				if (status.name().equals(value)) {
					return valueOf(value);
				}
			}
			return AMORTIZATION_STATUS.OTHER;
		}
	}

	public enum ARREARS_CODES {
		CAP, INT, IMO, OTHER;

		public static ARREARS_CODES getValue(String value) {
			for (ARREARS_CODES arrear : ARREARS_CODES.values()) {
				if (arrear.name().equals(value)) {
					return valueOf(value);
				}
			}
			return ARREARS_CODES.OTHER;
		}
	}

	public static final int REGISTERS_FOR_PAGE = 20;
	public static final int REGISTERS_PAYMENT = 17;

	public static final int REGISTERS_FOR_CATALOG = 0;
	public static final int DIVIDEND = 0;

	// STATUS
	public static final String CANCEL_STATUS = "CANCELADO";

	public static final String EMPTY_VALUE = "";
	public static final int MONEY = 0;
	public static final int CALCULATEVALUE = 0;

	public static final String PAYMENT_OPERATION = "A";
	public static final String PAYMENT_DET_OPERATION = "D";
	public static final String REFINANCED_LOAN_OPERATION = "N";
	public static final String PAYMENT_DETAIL_OPERATION = "D";
	public static final String LOAN_QUOTE_DETAIL = "L";
	public static final String LIST_ITEMS_LOAN_OPERATION = "R";
	public static final String LIST_RATES_LOAN_OPERATION = "T";
	public static final String LIST_WARRANTIES_LOAN_OPERATION = "G";
	public static final String LIST_DEBTORS_LOAN_OPERATION = "E";
	public static final Integer ZERO_VALUE = 0;
	public static final Integer ONE_VALUE = 1;

	public static final char PARAMETER_DISBURSEMENT = 'N';
	public static final char PARAMETER_DISBURSEMENT_S = 'S';

	public static final String SUCCESSFUL_TRANSACTION = "ASSTS.MSG_ASSTS_LATRANSLO_19347";
	public static final String MISSING_RECORDS = "ASSTS.LBL_ASSTS_NOEXISTEG_69517";
	public static final String REFINANCE = "refinance";
	
	// PAGOS SOLIDARIO
	public static final String READ_SOLIDARITY = "Loan.SolidarityPayment.ReadSolidarity";
	public static final String SEARCH_SOLIDARITY_DETAIL = "Loan.SolidarityPayment.SearchSolidarityDetail";
	public static final String UPDATE_SOLIDARITY_DETAIL = "Loan.SolidarityPayment.UpdateSolidarityDetail";

	// OFICIAL
	public static final String SEARCHOFFICER = "SystemConfiguration.OfficerManagement.SearchOfficer";
	public static final String INOFFICERREQUEST = "inOfficerRequest";
	public static final String RETURNOFFICERRESPONSE = "returnOfficerResponse";

	// ACCOUNT STATE
	public static final String ACCOUNT_STATUS_REQUEST = "inAccountStatusRequest";

	// REFERENCIA LIQUIDACION ANTICIPADA DE PRESTAMOS
	public static final String SEARCH_PRECANCELLATION = "Loan.LoanMaintenance.SearchPrecancellationReference";
	public static final String MAIL_PRECANCELLATION = "Loan.LoanMaintenance.MailPreCancellationReference";

	// ACTUALIZACION DE LA OPERACION GRUPAL
	public static final String PROCESSUPDATELOANGROUP = "Loan.LoanMaintenance.UpdateLoanGroup";

	// Account Status
	public static final String SEARCHACCOUTSTATUS = "Loan.LoanMaintenance.SearchAccountStatus";
	public static final String ACCOUNT_RESPONSE = "returnAccountStatusResponse";

	// Rejected Dispersions
	public static final String SEARCHDISPERSIONS = "Loan.RejectedDispersions.SearchRejectedDispersions";
	public static final String ACTIONDISPERSIONS = "Loan.RejectedDispersions.DispersionActions";
	public static final String DISPERSIONS_REQUEST = "inRejectedDispersionsRequest";
	public static final String DISPERSIONS_RESPONSE = "returnRejectedDispersionsResponse";
}
