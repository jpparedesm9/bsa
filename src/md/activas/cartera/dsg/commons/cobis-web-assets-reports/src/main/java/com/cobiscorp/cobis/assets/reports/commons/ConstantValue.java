package com.cobiscorp.cobis.assets.reports.commons;

import java.io.File;

public final class ConstantValue {

	public static final String BANK_NAME = "BANCO COBIS";
	/***
	 * Path del LOGO de BANCAMIA
	 */
	protected static final String[] UNIDADES = { "", "UN ", "DOS ", "TRES ", "CUATRO ", "CINCO ", "SEIS ", "SIETE ", "OCHO ", "NUEVE ", "DIEZ ", "ONCE ", "DOCE ", "TRECE ",
			"CATORCE ", "QUINCE ", "DIECISEIS", "DIECISIETE", "DIECIOCHO", "DIECINUEVE", "VEINTE" };

	protected static final String[] DECENAS = { "VENTI", "TREINTA ", "CUARENTA ", "CINCUENTA ", "SESENTA ", "SETENTA ", "OCHENTA ", "NOVENTA ", "CIEN " };

	protected static final String[] CENTENAS = { "CIENTO ", "DOSCIENTOS ", "TRESCIENTOS ", "CUATROCIENTOS ", "QUINIENTOS ", "SEISCIENTOS ", "SETECIENTOS ", "OCHOCIENTOS ",
			"NOVECIENTOS " };

	protected static final String[] MES = { "", "ENERO ", "FEBRERO ", "MARZO ", "ABRIL ", "MAYO ", "JUNIO ", "JULIO ", "AGOSTO ", "SEPTIEMBRE ", "OCTUBRE ", "NOVIEMBRE ",
			"DICIEMBRE " };

	public static final String URL_IMAGEN = File.separator + "imagen" + File.separator + "cobiscorp.png";
	public static final String URL_IMAGEN_2 = File.separator + "imagen" + File.separator + "logo.png";
	public static final String URL_IMAGEN_TUIIO = File.separator + "imagen" + File.separator + "logo.jpg";
	public static final String URL_IMAGEN_TUIIO2 = File.separator + "imagen" + File.separator + "logoTuiio.jpg";
	public static final String URL_IMAGEN_SANTANDER = File.separator + "imagen" + File.separator + "logo.jpg";
	public static final String URL_IMAGEN_COD = File.separator + "imagen" + File.separator + "urlPathCodigo.png";
	public static final String URL_IMAGEN_PAYMENT_INFO = File.separator + "imagen" + File.separator + "infoPago.jpg";
	public static final String URL_IMAGEN_TUIIO_3 = File.separator + "imagen" + File.separator + "logo-tuiio3.jpg";
	public static final String UNDEFINED_VALUE = "--NO DEFINIDO--";
	public static final String EMPTY_VALUE = ""; 
	public static final String COPY_RIGTHS = "DERECHOS RESERVADOS SANTANDER"; 

	public static final String VALUE_TITLE_BANK_NAME = "BANCO COBIS S.A";
	public static final String VALUE_WEB_PAGE = "www.bancocobis.com";
	public static final String VALUE_PHONE_MSG = "Línea gratuita nacional - Línea Banco Cobis 018000 125100";
	public static final String VALUE_SUPPORT_EMAIL = "servicioalconsumidor@bancocobis.com";

	public static final Integer DATE_FORMAT = 103;
	/***
	 * Para todos los Reportes
	 */
	public static final String PARAM_REPORT_TITLE = "PReportTitle";
	public static final String PARAM_REPORT_LOGO = "PUrlLogo";
	public static final String PARAM_REPORT_DATE = "PReportDate";
	public static final String PARAM_TITLE_BANK_NAME = "PTittleBankName";
	public static final String PARAM_WEB_PAGE = "PWebPage";
	public static final String PARAM_PHONE_MSG = "PPhoneMsg";
	public static final String PARAM_SUPPORT_EMAIL = "PSupportEmail";
	public static final String PARAM_DATE = "PDate";
	public static final String PARAM_BANK_NUMBER = "PBankNumber";
	public static final String PARAM_SEQUENTIAL = "PSequential";
	public static final String PARAM_INFO_IMAGE = "PUrlInfoImage";

	// Reporte Pago Garantía Líquida

	public static final String PARAM_FOOTER = "PIEPAGINA";
	public static final String PARAM_ENTERPRISE_NAME = "NOMBREEMPRESA";
	public static final String PARAM_INIT_DATE ="FECINICIOCREDITO";
	public static final String PARAM_CUSTOMER_NAME = "NOMBRECLIENTE";
	public static final String PARAM_EXPIRATION_DATE ="FECVIGENCIA";
	public static final String PARAM_PAYMENT_NUMBER = "NOPAGO";
	public static final String PARAM_PAYMENT_AMOUNT = "MONTOPAGO";
	public static final String PARAM_OFFICE_NAME = "SUCURSAL";
	
	//Reporte Ficha Pago
	public static final String PARAM_LOAN_ID = "PLoanId";
	public static final String PARAM_CLIENT_NAME = "PCustomerName";
	public static final String PARAM_NEXT_PAYMENT_DATE = "PNextPaymentDate";
	public static final String PARAM_AMOUNT_NO_INTERESTS = "PAmountNoInterests";
	public static final String PARAM_MINIMIUM_PAYMENT = "PMinimiumPayment";
	public static final String PARAM_SEND_MAIL = "PSendMail";
	
	/***
	 * Valores Algunos catalogos
	 */
	public static class valueConstantCatalog {
		public static final String cl_ecivil_CASADO = "CA";
		public static final String cl_ecivil_DIVORCIADO = "DI";
		public static final String cl_ecivil_SOLETERO = "SO";
		public static final String cl_ecivil_UNILIBRE = "UN";
		public static final String cl_ecivil_VIUDO = "VI";

		public static final String cl_sexo_MASCULINO = "M";
		public static final String cl_sexo_FEMEMINO = "F";

		public static final String cl_tpropiedad_FAMILIARES = "FAM";
		public static final String cl_tpropiedad_PROPIO = "PRO";
		public static final String cl_tpropiedad_RENTADO = "REN";

		public static final String cl_profesion_HOGAR = "000";
		public static final String cl_profesion_COMERCIANTE = "001";
		public static final String cl_profesion_EMPRESARIO = "002";
		public static final String cl_profesion_JUBILADO = "003";
		public static final String cl_profesion_DESEMPLEADO = "004";
		public static final String cl_profesion_ASALARIADO = "005";
		public static final String cl_profesion_ESTUDIANTE = "006";
		public static final String cl_profesion_OTRO = "007";

		public static final String cl_destino_credito_COMPRA_ACTIVO = "CA";
		public static final String cl_destino_credito_CAPITAL_TRABAJO = "CT";

		public static final String cl_recursos_credito_APOYO_FAMILIAR = "AF";
		public static final String cl_recursos_credito_ENVIO_DINERO = "ED";
		public static final String cl_recursos_credito_NEGOCIO_PROPIO = "NP";
		public static final String cl_recursos_credito_PENSION = "PE";
		public static final String cl_recursos_credito_TERCEROS = "TE";

		public static final String cr_tipo_local_PROPIO = "1";
		public static final String cr_tipo_local_RENTADO = "2";
		public static final String cr_tipo_local_MISMO_DOMICILIO = "3";
		public static final String cr_tipo_local_MERCADO = "4";
		public static final String cr_tipo_local_AMBULANTE = "5";
	}
	/***
	 * Reporte Desembolso Parcial/Liquidacion
	 */
	public static final String TITLE_LIQUIDATION = "INFORMACIÓN OBLIGACIÓN DESEMBOLSADA";
	public static final String PATH_LIQUIDATION = "/ASSETS/reports/jasper/Liquidacion-DesembolsoParcial.jasper";

	public static final String TITLE_RECEIPT_PAYMENT = "RECIBO DE PAGO";
	public static final String PATH_RECEIPT_PAYMENT = "/ASSETS/reports/jasper/ReciboDePago.jasper";
	public static final String PATH_RECEIPT_PAYMENT_UVR = "/ASSETS/reports/jasper/ReciboDePagoUvr.jasper";

	public static final String TITLE_PAYMENT_TABLE = "TABLA DE AMORTIZACIÓN";
	public static final String PATH_PAYMENT_TABLE = "/ASSETS/reports/jasper/TablaDeAmortizacion.jasper";

	public static final String TITLE_PROMISSORY_NOTE = "PAGARÉ A LA ORDEN";
	public static final String PATH_PROMISSORY_NOTE = "/ASSETS/reports/jasper/PagareOrden.jasper";
	public static final String TITLE_CREDIT_AGREEMENT = "CONTRATO DE APERTURA DE CRÉDITO";
	public static final String PATH_CREDIT_AGREEMENT = "/ASSETS/reports/jasper/ContratoAperturaCredito.jasper";

	public static final String TITLE_COLLATERAL_PAYMENT = "PAGO DE GARANTÍA LÍQUIDA";
	public static final String PATH_COLLATERAL_PAYMENT = "/ASSETS/reports/jasper/GarantiasLiquidas.jasper";
	
	public static final String TITLE_PRECANCELLATION = "REFERENCIA DE PRECANCELACIÓN";
	public static final String PATH_PRECANCELLATION = "/ASSETS/reports/jasper/ReferenciaPreCancelacion.jasper";

	public static final String TITLE_CORRESPONSAL_PAYMENT = "FICHA DE PAGO";
	public static final String PATH_CORRESPONSAL_PAYMENT = "/ASSETS/reports/jasper/PagoCorresponsal.jasper";
	public static final String PATH_CORRESPONSAL_PAYMENT_IND = "/ASSETS/reports/jasper/PagoCorresponsalInd.jasper";
	
	public static final String TITLE_ACCOUNT_STATUS = "ESTADO DE CUENTA";
	public static final String PATH_ACCOUNT_STATUS = "/ASSETS/reports/jasper/AccountStatus.jasper";

	public static final String TITLE_PAYMENT_CARD = "FICHA DE PAGO";
	public static final String PATH_PAYMENT_CARD = "/ASSETS/reports/jasper/PaymentCard.jasper";
	
	// Solicitud Pre-llenada
	public static final String PREFINANCED_RENEWAL_APPLICATION = "/ASSETS/reports/jasper/solicitudCreditoRenovFinanPrellenada.jasper";
	public static final String PREFINANCED_GRUPAL_APPLICATION = "/ASSETS/reports/jasper/solicitudCreditoGrupalPrellenada.jasper";
	
	// Consulta de Ficha de Pago Generica
	public static final String PATH_GENERICPAYMENTSLIP = "/ASSETS/reports/jasper/fichaPagoGenerica.jasper";

	// Parametros
	public static final String NUM_OPERATION = "numOperation";
	public static final String LIQUIDATION_SEQUENTIAL = "secLiquidation";
	public static final String LIQUIDATION_CURRENCY = "currencyLiquidation";
	public static final String PAYMENT_TABLE_SEQUENTIAL = "secPayment";
	public static final String RPAYMENT_NAME_USER = "nameUser";
	public static final String PAYMENT_TABLE_HIST = "paymentTableHis";
	public static final String NUM_TRAN = "numTran";
	public static final String CLIENTID = "clientID";
	public static final String AMOUNTPRE = "amountPRE";
	public static final String SEND_MAIL = "sendMail";
	public static final String BANK = "bank";
	public static final String IS_GRUOP = "isGroup";
	public static final String IS_RENOVATION= "isItaRenovation";
	public static final String ID_TRAMITE= "idTramite";
	public static final String OPERATION_TYPE= "operationType";
	public static final String INDIVIDUAL= "INDIVIDUAL";
	
	// Datos del servicio liquidacion
	public static final String SERVICE_LIQUIDATION_REPORT = "Loan.LoanTransaction.QueryLiquidation";
	public static final String IN_REPORT_LIQUIDATION_REPORT = "inReportLiquidationRequest";
	public static final String RETURN_REPORT_OPERATION = "returnReportOperation";
	public static final String RETURN_REPORT_ENTRY = "returnReportEntry";
	public static final String RETURN_REPORT_OUTLAY_DETAIL = "returnReportOutlayDetail";

	// Datos del servicio de info cliente
	public static final String SERVICE_DEBTOR_REPORT = "Loan.LoanTransaction.QueryDebtorInformation";
	public static final String RETURN_REPORT_DEBTOR_INFO = "returnReportDebtorInformation";

	// Datos del servicio de recibo de pago
	public static final String SERVICE_RECEIPT_PAYMENT = "Loan.LoanTransaction.QueryReceiptPayment";
	public static final String IN_RECEIPT_PAYMENT_REQUEST = "inQueryReceiptPaymentRequest";
	public static final String RETURN_RECEIPT_PAYMENT_HEAD = "returnQueryReceiptPaymentHead";
	public static final String RETURN_RECEIPT_PAYMENT_ACCOUNTANT = "returnQueryReceiptPaymentAccountant";
	public static final String RETURN_RECEIPT_PAYMENT_AMOUNT = "returnQueryReceiptPaymentAmount";
	public static final String RETURN_RECEIPT_PAYMENT_WAYTOPAY = "returnQueryReceiptPaymentWayToPay";

	// Datos adicionales para pagare a la orden
	public static final String SERVICEID_RECEIPT_PROMISSURENOTE = "Loan.LoanTransaction.QueryPromissoryNote";
	public static final String IN_RECEIPT_PROMISSURENOTE = "inReportPromissoryNoteRequest";
	public static final String RETURN_PROMISSURENOTE = "returnReportPromissoryNote";

	// Datos adicionales para detalle del recibo de pago
	public static final String SERVICE_RECEIPT_PAYMENT_INFO = "Loan.LoanTransaction.QueryReceipPaymentInfo";

	// Tabla de amortizacion
	public static final String SERVICE_PAYMENT_TABLE_DETAIL = "Loan.LoanTransaction.QueryPaymentTableDetail";
	public static final String SERVICE_PAYMENT_TABLE_HEAD = "Loan.LoanTransaction.QueryPaymentTableHead";
	public static final String IN_PAYMENT_TABLE_REQUEST = "inQueryPaymentTableRequest";
	public static final String RETURN_PAYMENT_TABLE_HEAD = "returnQueryPaymentTableHead";

	public static final String SERVICE_OFFICE = "Loan.LoanTransaction.QueryOffice";
	public static final String SERVICE_PROCESSING_DATE = "Loan.LoanTransaction.QueryProcessingDate";
	public static final String IN_REPORT_OFFICE_REQUEST = "inReportOfficeRequest";
	public static final String RETURN_REPORT_OFFICE_RESPONSE = "returnReportOfficeResponse";

	// Tabla de amortizacion DETALLES
	public static final String RETURN_PAY_TABLE_CAPITAL = "returnQueryPaymentTableDetail";
	public static final String RETURN_PAY_TABLE_INTERES = "returnQueryPaymentTableDetail2";
	public static final String RETURN_PAY_TABLE_OTROS = "returnQueryPaymentTableDetail3";
	public static final String RETURN_PAY_TABLE_ABONOS = "returnQueryPaymentTableDetail4";
	public static final String RETURN_PAY_TABLE_ESTADO = "returnQueryPaymentTableDetail5";
	public static final String RETURN_PAY_TABLE_MIPYMES = "returnQueryPaymentTableDetail6";
	public static final String RETURN_PAY_TABLE_IVA_MIPYMES = "returnQueryPaymentTableDetail7";
	public static final String RETURN_PAY_TABLE_COMISION = "returnQueryPaymentTableDetail8";
	public static final String RETURN_PAY_TABLE_IVA_COMISION = "returnQueryPaymentTableDetail9";
	public static final String RETURN_PAY_TABLE_SEGURO = "returnQueryPaymentTableDetail10";
	public static final String RETURN_PAY_TABLE_INTERES_MORA = "returnQueryPaymentTableDetail11";
	public static final String RETURN_PAY_TABLE_INTERES_SEGUROS = "returnQueryPaymentTableDetail12";
	public static final String RETURN_PAY_TABLE_INTERES_CAPIT = "returnQueryPaymentTableDetail13";
	public static final String RETURN_PAY_TABLE_DISPONIBLES = "returnQueryPaymentTableDetail14";

	// Tabla de amortizacion historico
	public static final String SERVICE_PAYMENT_TABLE_DETAILS_HIS = "Loan.LoanTransaction.QueryPaymentTableDetailsHis";
	public static final String SERVICE_PAYMENT_TABLE_HEAD_HIS = "Loan.LoanTransaction.QueryPaymentTableHeadHis";

	// Datos del Contrato de Apertura
	public static final String SERVICE_GENERAL_LOAN_DATA = "Loan.LoansQueries.GeneralLoanData";
	public static final String SERVICE_CREDIT_STUDY = "Loan.LoanTransaction.QueryCreditStudy";
	public static final String SERVICE_SWORN_STATEMENT = "Loan.LoanTransaction.QuerySwornStatement";
	public static final String SERVICE_CREDIT_AGREEMENT = "Loan.LoanTransaction.QueryCreditAgreement";

	public static final String IN_GENERAL_LOAN_DATA_REQUEST = "inLoanRequest";
	public static final String IN_CREDIT_STUDY_REQUEST = "inQueryCreditStudyRequest";
	public static final String IN_CREDIT_SWORN_STATEMENT = "inQueryCreditStudyRequest";
	public static final String IN_CREDIT_AGREEMENT_REQUEST = "inReportCreditAgreementRequest";

	public static final String RETURN_DATA_RESPONSE = "returnGeneralDataResponse";
	public static final String RETURN_DATA_MARKET = "returnGeneralDataMarket";
	public static final String RETURN_DATA_CURRENCY = "returnGeneralDataCurrency";

	public static final String RETURN_CREDIT_STUDY_CLIENT = "returnQueryCreditStudyClient";
	public static final String RETURN_CREDIT_STUDY_ADDRESS = "returnQueryCreditStudyAddress";
	public static final String RETURN_CREDIT_STUDY_MICROENTERPRISE = "returnQueryCreditStudyMicroenterprise";
	public static final String RETURN_CREDIT_STUDY_REFERENCE = "returnQueryCreditStudyReference";
	public static final String RETURN_CREDIT_SWORN_STATEMENT = "returnSwornDeclarationCredit";

	public static final String RETURN_CREDIT_AGREEMENT = "returnReportCreditAgreement";
	public static final String RETURN_CREDIT_AGREEMENT_CLIENT = "returnReportCreditAgreementClient";

	public static final Integer SWORN_QUERY_LENGTH = 8;

	// Servicio Consulta Pago de Garantías Líquidas
	public static final String SERVICE_READ_LIQUID_COLLATERAL = "Loan.GroupTransactManagement.ReadCollateralGroupInfo";
	public static final String RETURN_GROUP_INFO_RESPONSE = "returnGroupInfoResponse";
	public static final String IN_GROUP_PAYMENT_REQUEST = "inGroupPaymentRequest";
	public static final String RETURN_PAYMENT_DET_GAR_RESPONSE = "returnPaymentDetGarResponse";
	
	//Servicio de Consulta de Referencia de Precancelación de Préstamos
	public static final String SERVICE_READ_PRECANCELLATION = "Loan.LoanMaintenance.PdfPreCancellationReference";
	public static final String RETURN_PRECANCELLATION_RESPONSE = "returnPreCancellationResponse";
	public static final String RETURN_REFERENCE_RESPONSE = "returnReferenceResponse";
	public static final String IN_LOAN_REQUEST = "inLoanRequest";

	// Servicio de Consulta de Ficha de Pago Generica
	public static final String SERVICE_GENERIC_PAYMENT_SLIP = "Loan.LoanMaintenance.PdfGenericPaymentSlip";
	public static final String RETURN_GENERICPAYMENTSLIP_RESPONSE = "returnGenericPaymentSlipResponse";

	//Servicio de Consulta de Referencia de Pagos corresponsal
	public static final String SERVICE_READ_CORRESPONSAL_PAYMENT = "Loan.LoanMaintenance.ReadCorresponsalPayment";
	public static final String SERVICE_READ_CORRESPONSAL_PAYMENT_IND = "Loan.LoanMaintenance.ReadCorresponsalPaymentInd";
	public static final String RETURN_CORRESPONSAL_PAYMENT_RESPONSE = "returnCorresponsalPaymentResponse";
	public static final String IN_CORRESPONSAL_PAYMENT_REQUEST = "inCorresponsalPaymentRequest";

	//Servicio de Estado de Cuenta
	public static final String SERVICE_SEARCH_DET_AMORTIZATION = "Loan.StateAccount.SearchDetailAmortizacion";//cob_conta_super..sp_cons_estado_cuenta -- "T1"
	public static final String SERVICE_SEARCH_DET_MOVEMENTS = "Loan.StateAccount.SearchDetailMovements";//cob_conta_super..sp_cons_estado_cuenta -- "M1"
	public static final String SERVICE_SEARCH_LOAN_INFORMATION = "Loan.StateAccount.SearchLoanInformation";//cob_conta_super..sp_cons_estado_cuenta --"I1"
	public static final String SERVICE_SEARCH_STATE_ACCOUNT_HEADER = "Loan.StateAccount.SearchStateSccountHeadboard";//SearchStateAccountHeadboard //cob_conta_super..sp_cons_estado_cuenta --"C1"
	public static final String SERVICE_SEARCH_TOTAL_MOVEMENTS = "Loan.StateAccount.SearchMovementsTotal";//cob_conta_super..sp_cons_estado_cuenta -- "M2"
	public static final String SERVICE_EXECUTE_OPTION = "Loan.StateAccount.ExecutionOptions";//cob_conta_super..sp_cons_estado_cuenta -- "A"
	
	//Servicio Consulta Pie de Página
	public static final String SERVICE_READ_FOOTER_PAGE = "Loan.LoansQueries.ReadPageFooter";
	public static final String RETURN_FOOTERPAGE_RESPONSE = "returnFooterRespose";
	
	public static final String IN_ACCOUNT_STATUS= "inAccountStatusRequest";
	public static final String RETURN_ACCOUNT_STATUS= "returnAccountStatusResponse";
	public static final String RETURN_HEADER_STATE_ACCOUNT = "returnHeaderStateAccountResponse";
	public static final String RETURN_DETAIL_MOVEMENTS = "returnDetailMovementsResponse";
	public static final String RETURN_TOTAL_MOVEMENTS = "returnTotalMovementsResponse";
	public static final String RETURN_LOAN_INFORMATION = "returnLoanInformationResponse";
	public static final String RETURN_ACCOUNT_AMORTIZACION = "returnAccountAmortizacion";
	
	//Servicio Ficha de Pago
	public static final String SERVICE_READ_PAYMENT_CARD = "Loan.PaymentApplication.ReadPaymentCard";
	public static final String RETURN_PAYMENT_CARD_HEADER = "returnPaymentCardHeaderResponse";
	public static final String RETURN_PAYMENT_CARD_DETAIL = "returnPaymentCardDetailResponse";
	public static final String IN_PAYMENT_CARD = "inPaymentCardRequest";
	
	//servicio de catalogos
	final static String GETCATALOG_SERVICE_ID = "Loan.GeneralInfo.GetCatalog";
	
	//Servicio solicitud prellenada
	public static final String SERVICE_SEARCH_PREFILLEDAPLICATION = "Loan.ReportMaintenance.PreFilledApplication";
	public static final String IN_PREFILLEDAPLICATION = "inPreFilledApplicationRequest";
	public static final String RETURN_PREFILLEDAPLICATION = "returnPreFilledApplicationResponse";

	private ConstantValue() {
	}

}
