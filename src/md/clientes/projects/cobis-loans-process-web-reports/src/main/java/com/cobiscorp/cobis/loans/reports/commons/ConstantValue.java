package com.cobiscorp.cobis.loans.reports.commons;

import java.io.File;

public class ConstantValue {

	public static class Params {
		public static final String BANK = "numBanco"; // Num del banco
		public static final String APPLICATION = "idTramite"; // Num Tramite
		public static final String CUSTOMER = "idCliente"; // Num Cliente
		public static final String REPORTNEMONIC = "nemonicoReporte";
		public static final String URLIMAG = File.separator + "tuiioSantander2.png";// "logoSantander.jpg";
		public static final String URLIMAG2 = File.separator + "tuiioSantander2.png"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_CERTIF = File.separator + "asusrant.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_FUNERARIA = File.separator + "funeararia.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_firmaNF1CCI = File.separator + "firmaNF1CCI.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_firmaNF2CCI = File.separator + "firmaNF2CCI.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_firmaNB1CCI = File.separator + "firmaNB1CCI.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_firmaNB2CCI = File.separator + "firmaNB2CCI.jpg"; // File.separator + "imagen" + File.separator
		public static final String URLIMAG_WHATSAPP = File.separator + "whatsapp.png";// "whatsapp.png";
		public static final String INDIVIDUAL = "INDIVIDUAL";
		public static final String GROUP = "GRUPAL";
		public static final Integer FORMAT_DATE = 103;
		public static final String AMOUNT_REQUESTED = "amountRequested";
		public static final String TERM_REQUESTED = "termRequested";
		public static final String NAME_REQUESTED = "nameRequested";

	}

	public static class valueConstant {
		// public static final String haveInsuranceInt = "STSI";
		public static final String GROUP_INFORMATION = "GROUP_INFORMATION";
		public static final String ADDITIONAL_GROUP_INFORMATION = "ADDITIONAL_GROUP_INFORMATION";

		public static final String CUSTOMER_INFORMATION = "CUSTOMER_INFORMATION";
		public static final String ADD_CUSTOMER_INFORMATION = "ADD_CUSTOMER_INFORMATION";

		public static final String DF_YYYYMMDD = "yyyy/MM/dd";
		public static final String DF_MMDDYYYY = "MM/dd/yyyy";
		public static final String DF_DDMMYYYY = "dd/MM/yyyy";
		public static final String list1 = "listFirm1";
		public static final String list2 = "listFirm2";
		public static final String TOPERATION_IND = "INDIVIDUAL";
		public static final String TOPERATION_GROUP = "GRUPAL";
		public static final int MODE_0 = 0;

		// parametros reporte seguros y medicina
		public static final String TITLE_SECURE_CONSENT = "Consentimiento de seguros TUIIO Seguro";
		public static final String TITLE_SECURE_CONSENT_MEDICAL = "Consentimiento de seguros TUIIO Seguro + M�dico";
		public static final String PARAM_REPORT_TITLE_BASE = "titTleReport";
		public static final String UNDEFINED_VALUE = "";
		public static final String IDENTIFICATIONCLIENT = "identificationClient";
		public static final String CONSTANT_I = "I";
		public static final String CONSTANT_B = "B";
		public static final String CONSTANT_S = "S";
		public static final String CONSTANT_Q = "Q";
		public static final String EXTENDIDO = "EXTENDIDO";
		public static final String BASICA = "BASICO";
		public static final String PARAMETERCERTNSECURITYNAME = "certificationSecurityName";
		public static final String PARAMETERCERTNSECURITYNAMEMEDICAL = "certificationSecurityNameMedical";		
		public static final String CERCONIND = "CERCONIND";//Nemonico Certificado de Consentimiento Individual
		public static final String CEASFUIND = "CEASFUIND";//Nemonico Certificado Asistencia Funeraria
	}

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

	public static class Table {
		public static final String NAME_TABLE_CIVIL_STATUS = "cl_ecivil";
		// public static final String NAME_TABLE_DEST_PROD_CTO =
		// "cr_destino_productivo_cto";
	}

	public static class Value {
		// public static final String DEPENDENTE = "507"; //
		// cobis..cl_catalogo
	}

	public static class ServiceName {

		public static final String GROUP_ACCOUNT_HEADER = "LoanGroup.ReportMaintenance.GroupAccountHeader";// cob_cartera..sp_estado_cta_grupal
																											// - opcion
																											// C
		public static final String GROUP_ACCOUNT_SUMMARY = "LoanGroup.ReportMaintenance.GroupAccountSummary";// cob_cartera..sp_estado_cta_grupal
																												// -
																												// opcion
																												// R
		public static final String GROUP_ACCOUNT_PAYMENT = "LoanGroup.ReportMaintenance.GroupAccount";// cob_cartera..sp_estado_cta_grupal
																										// - opcion D
		public static final String SETTLEMENT_SHEET_HEADER = "LoanGroup.ReportMaintenance.SettlementSheetHeader";// cob_cartera..sp_hoja_liquidacion_sa
																													// operacion
																													// Q
		public static final String SETTLEMENT_SHEET_DETAIL = "LoanGroup.ReportMaintenance.SettlementSheetDetail";// cob_cartera..sp_hoja_liquidacion_sa
																													// peracion
																													// S
		public static final String CONSOLIDATED_ACCOUNT_STATUS_HEADER = "LoanGroup.ReportMaintenance.AccountStatusConsolidatedHeader";// cob_cartera..sp_estado_cta_consol
																																		// -
																																		// opcion
																																		// C
		public static final String CONSOLIDATED_ACCOUNT_STATUS_DETAIL = "LoanGroup.ReportMaintenance.AccountStatusConsolidatedDetail";// cob_cartera..sp_estado_cta_consol
																																		// -
																																		// opcion
																																		// D
		public static final String AMORTIZATION_TABLE_DETAIL = "LoanGroup.ReportMaintenance.AmortizationTableDetail";// cob_cartera..sp_imp_tabla_grupo
																														// -Operacion
																														// T
		public static final String AMORTIZATION_TABLE_HEADER = "LoanGroup.ReportMaintenance.AmortizationTableHeader";// cob_cartera..sp_imp_tabla_grupo
																														// -Operacion
																														// C
		public static final String AMORTIZATION_TABLE_OPER_HEADER = "LoanGroup.ReportMaintenance.AmortizationTableOperationHeader";
		public static final String DISBURSEMENT_ORDER_HEADER = "LoanGroup.ReportMaintenance.DisbursementOrderHeader";// cob_cartera..sp_orden_desembolso_gru
																														// opcion
																														// =
																														// C
		public static final String DISBURSEMENT_ORDER_DETAIL = "LoanGroup.ReportMaintenance.DisbursementOrderDetail";// cob_cartera..sp_orden_desembolso_gru
																														// opcion
																														// =
																														// D
		public static final String LOAN_GROUP_QUERY = "LoanGroup.GroupLoanQuerys.LoanGroupQuery";// cob_credito..sp_info_grupal_sol
																									// operacion Q
		public static final String SEARCH_GROUP = "LoanGroup.GroupMaintenance.SearchGroup";
		public static final String GROUP_MEMBERS = "LoanGroup.MemberMaintenance.SearchMember";// cob_pac..sp_miembro_grupo_busin
																								// operacion S
		public static final String LOAN_MEMBERS_AMOUNT = "LoanGroup.GroupLoanQuerys.LoanGroupMembersAmounts";// cob_credito..sp_info_grupal_sol
																												// operacion
																												// S
		public static final String GROUP_CREDIT_VOCER = "LoanGroup.ReportMaintenance.SearchGroupCreditCover";// cob_credito..sp_datos_reportes_miembro
																												// operacion
																												// Q2
		public static final String GRP_PROMISSORY_NOTE = "LoanGroup.ReportMaintenance.SearchPromissoryNoteInf";

		public static final String RECURRING_CHARGE_GROUP = "LoanGroup.ReportMaintenance.SearchRecurringCharge"; // cob_credito..sp_datos_reportes_miembro
																													// operacion
																													// Q
		public static final String GRP_CRDT_PAYMENTS_LIST = "LoanGroup.ReportMaintenance.SearchGroupCreditPaymentList";
		public static final String INDIVIDUAL_CREDIT_VOCER = "LoanProcess.LoanReportQuery.SearchIndivCreditCover"; // cob_credito..sp_datos_credito
																													// Operacion
																													// Q
		public static final String IND_CRDT_PAYMENTS_LIST = "LoanProcess.LoanReportQuery.SearchIndivCreditPaymentList";
		public static final String GET_CUSTOMER_DATA = "LoanProcess.LoanReportQuery.GetCustomerData";// cob_credito..sp_datos_credito
																										// -- operacion
																										// C
		public static final String LOAN_REC_CHARGE = "LoanProcess.LoanReportQuery.SearchLoanRecurringCharge";// cob_credito..sp_datos_credito
																												// operacion
																												// Q2
		public static final String GET_LOAN_DATA = "LoanProcess.LoanReportQuery.GetLoanData"; // cob_credito..sp_datos_credito
																								// operacion T
		public static final String GET_INFO_APPLICATION = "LoanProcess.LoanReportQuery.GetInfoApplication"; // cob_credito..sp_datos_credito
		public static final String PAYMENT_DETAIL = "LoanGroup.ReportMaintenance.PaymentDetail";// cob_cartera..sp_reportes
																								// operacion = 'Q'
																								// opcion = 1

		public static final String GET_KYCSimplificado = "LoanGroup.ReportMaintenance.SearchKYC";// sp_reporte_kyc
																									// operacion = S

		public static final String PARAMETERMANAGEMENT = "SystemConfiguration.ParameterManagement.ParameterManagement";

		public static final String LONG_INDIVIDUAL_CREDIT_APPLICATION_INFO_CUSTOMER = "LoanGroup.ReportMaintenance.LongIndividualCreditApplicationInfoCustomer"; //cob_credito..sp_reporte_sol_complementaria
		public static final String LONG_INDIVIDUAL_CREDIT_APPLICATION_ADDRESS = "LoanGroup.ReportMaintenance.LongIndividualCreditApplicationAddress";
		public static final String LONG_INDIVIDUAL_CREDIT_APPLICATION_REFERENCE_CUSTOMER = "LoanGroup.ReportMaintenance.LongIndividualCreditApplicationReferencesCustomer";
		public static final String LONG_INDIVIDUAL_CREDIT_APPLICATION_BUSINESS_CUSTOMER = "LoanGroup.ReportMaintenance.LongIndividualCreditApplicationBusinessCustomer";

		public static final String SERVICES_CATALOG = "SystemConfiguration.CatalogManagement.Search"; // cobis..sp_catalogo

		public static final String GET_CERTIFICADO = "LoanGroup.ReportMaintenance.SearchConsentCertificate";// sp_reporte_consentimiento
																											// operacion
																											// = S

		// servicios de consentimiento seguro
		public static final String SERVICEID_REPORTSAFEINFORMATION = "Sales.Cloud.ConsultingReportSales.ReportSafeInformation";// operation
																																// I
		public static final String SERVICEID_REPORTSAFEBENEFITS = "Sales.Cloud.ConsultingReportSales.ReportSafeBenefits";// operacion
																															// B
		public static final String SERVICEID_REPORTSAFEDECLARATION = "Sales.Cloud.ConsultingReportSales.ReportSafeDeclaration";// operacion
																																// S
		// servicios de consentimiento seguro medico
		public static final String SERVICEID_REPORTSAFEINFORMATION_MEDICAL = "Sales.Cloud.ConsultingReportMedical.ReportMedicalInformation";// operacion
																																			// I
		public static final String SERVICEID_REPORTSAFEBENEFITS_MEDICAL = "Sales.Cloud.ConsultingReportMedical.ReportMedicalBenefits";// operacion I
		public static final String SERVICEID_REPORTSAFEDECLARATION_MEDICAL = "Sales.Cloud.ConsultingReportMedical.ReportMedicalDeclaration";// operacion
																																			// I
		public static final String SERVICEID_REPORTZURICH_INFORMATION = "Sales.Cloud.ConsultingReportZurich.ReportZurichInformation";// operacion Q
		/// servicio de consulta de clientes de un grupo
		public static final String SERVICEID_REPORTSAFECONSULTINGCLIENTTEAM = "Sales.Cloud.ConsultingClientsTeams.ConsultingClients";

		// Servicio de generacion de tabla de simulacion
		public static final String SERVICEID_GENERATE_SIMULATE_TABLE = "LoanGroup.CreditRenovation.SimulationCreditRenovation";
	}

	public static class RequestName {
		public static final String IN_REPORT_REQUEST = "inReportRequest";
		public static final String IN_GROUP_REQUEST = "inGroupRequest";
		public static final String IN_MEMBER_REQUEST = "inMemberRequest";
		public static final String IN_GRP_LOAN_AMNT_REQST = "inGroupLoanAmountRequest";
		public static final String IN_IND_LOAN_AMNT_REQST = "inLoanRequest";
		public static final String IN_IND_LOAN_DATA_REQST = "inLoanDataRequest";
		public static final String INPARAMETERREQUEST = "inParameterRequest";
		public static final String IN_TABLE_REQUEST = "inTableRequest";
		// consentimiento medico y seguro
		public static final String IN_REPORTSAFEREQUEST = "inReportSafeRequest";
		public static final String IN_REPORTZURICHINFORMATIONREQUEST = "inReportZurichInformationRequest";
		// conseultar miembrod e un grupo
		public static final String IN_CONSULTINGCLIENTTEAMREQUEST = "inConsultingClientTeamRequest";
		public static final String IN_SIMULATION_GENERATE = "inSimulationCreditRenovationRequest";
	}

	public static class ReturnName {
		public static final String RETURN_REPORT_RESPONSE = "returnReportResponse";
		public static final String RETURN_LOAN_INFO_APPLICATION = "returnLoanInfoApplicationResponse";
		public static final String RETURN_LOAN_GROUP_RESPONSE = "returnLoanGroupResponse";
		public static final String RETURN_ADDITIONAL_DATA_GROUP = "returnAdditionalDataGroupResponse";
		public static final String RETURN_GROUP_RESPONSE = "returnGroupResponse";
		public static final String RETURN_MEMBER_RESPONSE = "returnMemberResponse";
		public static final String RETURN_GRP_LOAN_INF_RESP = "returnGroupLoanInfResponse";
		public static final String RETURN_IND_LOAN_INF_RESP = "returnLoanInfResponse";
		public static final String RETURN_IND_SIMULATION_RESP = "returnSimulationCreditRenovatioResponse";
		public static final String RETURN_IND_SIMULATION_RESP_HEAD = "returnSimulationCreditRenovatioHeaderResponse";
		public static final String RETURN_LOAN_CUST_RESP = "returnLoanCustomerResponse";
		public static final String RETURN_LOAN_CUST_BUSS_RESP = "returnLoanCustomerBussiness";
		public static final String RETURN_PARAMETER_RESPONSE = "returnParameterResponse";

		public static final String REPORT_LONG_IND_CREDIT_GEN_INFO_CUSTOMER_RESPONSE = "returnReportLongIndCreditGenInfoCustomerResponse";
		public static final String REPORT_LONG_IND_CREDIT_GEN_ADDRESS_CUSTOMER_RESPONSE = "returnReportLongIndCreditGenAddressCustomerResponse";
		public static final String REPORT_LONG_IND_CREDIT_GEN_BUSINESS_CUSTOMER_RESPONSE = "returnReportLongIndCreditGenBusinessCustomerResponse";
		public static final String REPORT_LONG_IND_CREDIT_GEN_REFERENS_CUSTOMER_RESPONSE = "returnReportLongIndCreditGenReferensCustomerResponse";
		public static final String REPORT_LONG_IND_CREDIT_GEN_RELATIONSHIP_CUSTOMER_RESPONSE = "returnReportLongIndCreditGenRelationshipCustomerResponse";
		public static final String RETURN_CATALOG = "returnCatalogResponse";

		public static final String RETURN_CERTIFICATE_RESPONSE = "returnConsentCertificateResponse";

		// consentimiento medico y seguro
		public static final String RETURN_CLIENTSAFERESPONSE = "returnClientSafeResponse";
		public static final String RETURN_CLIENTSAFEBENEFITSRESPONSE = "returnClientSafeBenefitsResponse";
		public static final String RETURN_CLIENTINFORMATIONBENEFISRESPONSE = "returnClientInformationBenefisResponse";
		public static final String RETURN_REPORTZURICHINFORMATIONRESPONSE = "returnReportZurichInformationResponse";

		public static final String RETURN_CONSULTINGCLIENTTEAMRESPONSE = "returnConsultingClientTeamResponse";

	}

	public static class DebtorType {
		public static final String DEBTOR = "D";
		public static final String ENDORSEMENT = "G";

	}

        public static class Member {
		public static final String PRESIDENT = "P";// PRESIDENTE
		public static final String TREASURER = "T";// TESORERO
		public static final String SECRETARY = "S";// SECRETARIO
		public static final String MEMBER = "M";// INTEGRANTE
	}

	public static class JasperPath {
		public static final String ESTADO_CUENTA_GRUPAL = "/LOANS-GROUP/reports/jasper/estadoCuentaGrupal.jasper";
		public static final String ESTADO_CUENTA_GRUPAL_SR_RESUMEN_CREDIT = "/LOANS-GROUP/reports/jasper/estadoCuentaGrupal_SR_ResumenCredit.jasper";
		public static final String ESTADO_CUENTA_GRUPAL_SR_PLAN_PAGOS = "/LOANS-GROUP/reports/jasper/estadoCuentaSolicitado_SR_PlanPagos.jasper";

		public static final String ESTADO_CUENTA_CONSOLIDADO = "/LOANS-GROUP/reports/jasper/estadoCuentaConsolidado.jasper";
		public static final String ESTADO_CUENTA_SR_DETALLE = "/LOANS-GROUP/reports/jasper/estadoCuentaConsolidado_SR_Detalle.jasper";

		public static final String HOJA_LIQUIDACION = "/LOANS-GROUP/reports/jasper/hojaLiquidacion.jasper";
		public static final String HOJA_LIQUIDACION_SR_DETALLE = "/LOANS-GROUP/reports/jasper/hojaLiquidacion_SR_Detalle.jasper";

		public static final String ORDEN_DESEMBOLSO = "/LOANS-GROUP/reports/jasper/ordenDesembolso.jasper";
		public static final String ORDEN_DESEMBOLSO_SR_DETALLE_DESEM = "/LOANS-GROUP/reports/jasper/ordenDesembolso_SR_DetalleDesem.jasper";

		public static final String TABLA_AMORTIZACION = "/LOANS-GROUP/reports/jasper/tablaAmortizacion.jasper";
		public static final String TABLA_SIMULACION = "/LOANS-GROUP/reports/jasper/tablaSimulacion.jasper";
		public static final String TABLA_AMORTIZACION_RENOV = "/LOANS-GROUP/reports/jasper/tablaAmortizacionRenov.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_2 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subreport2.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_01 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla01.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_02 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla02.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_03 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla03.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_04 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla04.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_05 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla05.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_06 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla06.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_07 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla07.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_08 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla08.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_09 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla09.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_10 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla10.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_11 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla11.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_12 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla12.jasper";
		public static final String TABLA_AMORTIZACION_SUB_REPORT_TABLA_13 = "/LOANS-GROUP/reports/jasper/tablaAmortizacion_subReporteTabla13.jasper";

		public static final String SOLICTUD_CREDITO_GRUPAL = "/LOANS-GROUP/reports/jasper/solicitudCreditoGrupal.jasper";
		public static final String SOLICTUD_CREDITO_INDIVIDUAL = "/LOANS-GROUP/reports/jasper/solicitudCreditoIndividual.jasper";
		public static final String DETALLE_GRUPAL = "/LOANS-GROUP/reports/jasper/detalleGrupal.jasper";

		public static final String AVISO_PRIVACIDAD_MAIN = "/LOANS-GROUP/reports/jasper/avisoPrivacidadMain.jasper";
		public static final String AVISO_PRIVACIDAD_GRUPAL = "/LOANS-GROUP/reports/jasper/avisoPrivacidadGrupal.jasper";

		public static final String CARGO_RECURRENTE_MAIN = "/LOANS-GROUP/reports/jasper/cargoRecurrenteMain.jasper";
		public static final String CARGO_RECURRENTE_GRUPAL = "/LOANS-GROUP/reports/jasper/cargoRecurrenteGrupal.jasper";

		public static final String CARAT_CREDIT_MAIN = "/LOANS-GROUP/reports/jasper/caratulaCreditoGrupal.jasper";
		public static final String CARAT_CREDIT_RENOV = "/LOANS-GROUP/reports/jasper/caratulaCreditoGrupalRenov.jasper";
		public static final String CARAT_CREDIT_REV = "/LOANS-GROUP/reports/jasper/caratulaCreditoRevolvente.jasper";
		public static final String CARAT_CREDIT_GRUPAL = "/LOANS-GROUP/reports/jasper/detallePagosCredito.jasper";

		public static final String REGLAMENTO_INTERNO = "/LOANS-GROUP/reports/jasper/reglamentoInternoParent.jasper";
		public static final String CONTRATO_INCLUSION = "/LOANS-GROUP/reports/jasper/contratoInclusion.jasper";
		public static final String CONTRATO_INCLUSION_GRUPAL = "/LOANS-GROUP/reports/jasper/contratoInclusionGrupal.jasper";
		
		//Se cambiar el individual por el de onbarding porque es el mismo producto.
		//public static final String CARAT_CREDIT_MAIN_IND = "/LOANS-GROUP/reports/jasper/caratulaCreditoIndividual.jasper";		
		public static final String CARAT_CREDIT_MAIN_IND_ONB = "/LOANS-GROUP/reports/jasper/caratulaCreditoSimpleAutoOnboard.jasper";
		public static final String KYC_SIMP_IND_ONB = "/LOANS-GROUP/reports/jasper/kYCAutoOnboard.jasper";
		//public static final String TABLA_AMORTIZACION_IND = "/LOANS-GROUP/reports/jasper/tablaAmortizacionInd.jasper";		
		public static final String TABLA_AMORTIZACION_IND_ONB = "/LOANS-GROUP/reports/jasper/tablaAmortizacionSimpleIndAutoOnboard.jasper";
		//public static final String CONTRATO_INCLUSION_INDIVIDUAL = "/LOANS-GROUP/reports/jasper/contratoInclusionIndividual.jasper";
		public static final String CONTRATO_INCLUSION_INDIVIDUAL_ONB = "/LOANS-GROUP/reports/jasper/contratoCredSimpleIndividualAutoOnboard.jasper";

		public static final String AUTORIZACION_AVAL_IND = "/LOANS-GROUP/reports/jasper/formatAutorizacionAvalInd.jasper";
		public static final String CARGO_RECURRENTE_INDIV = "/LOANS-GROUP/reports/jasper/cargoRecurrenteIndiv.jasper";

		public static final String FORMATO_PAGARE_MAIN = "/LOANS-GROUP/reports/jasper/formatPagareMain.jasper";

		public static final String PAGARE_INDIVIDUAL = "/LOANS-GROUP/reports/jasper/pagareIndividual.jasper";

		public static final String PAGARE = "/LOANS-GROUP/reports/jasper/pagare.jasper";

		public static final String KYC_SIMP = "/LOANS-GROUP/reports/jasper/kYCSimplificado.jasper";
		public static final String KYC_SIMP_LCR = "/LOANS-GROUP/reports/jasper/kYCSimplificadoLCR.jasper";
		public static final String CONTRATO_CREDITO_INCLUSION = "/LOANS-GROUP/reports/jasper/contratoCreditoInclusion.jasper";
		public static final String CONTRATO_CREDITO_RENOVACION = "/LOANS-GROUP/reports/jasper/contratoCreditoGrupalRenovacion.jasper";

		public static final String SOLICITUD_INDIVIDUAL_CREDITO_LARGA = "/LOANS-GROUP/reports/jasper/solicitudCreditoIndividualLarga.jasper";
		public static final String CONTRATO_CREDITO_REVOLVENTE = "/LOANS-GROUP/reports/jasper/contratoCreditoRevolvente.jasper";
		public static final String SOLICITUD_CREDITO_REVOLVENTE = "/LOANS-GROUP/reports/jasper/solicitudCreditoRevolvente.jasper";
		public static final String SOLICITUD_CREDITO_GRUPAL_RENOVACION = "/LOANS-GROUP/reports/jasper/solicitudCreditoGrupalRenov.jasper";

		public static final String CERTIFICADO = "/LOANS-GROUP/reports/jasper/certificadoConsentimiento.jasper";
		public static final String CERTIFICADOZURICH = "/LOANS-GROUP/reports/jasper/ConsentimientoZurich.jasper";
		public static final String AUTORIZACION = "/LOANS-GROUP/reports/jasper/autorizacionCargo.jasper";
		public static final String FUNERARIA = "/LOANS-GROUP/reports/jasper/asistenciaFuneraria.jasper";

		// reporte consentimiento seguro
		public static final String PATH_SECURE_CONSENT = "/LOANS-GROUP/reports/jasper/consentOfsegurityTuiio.jasper";
		public static final String PATH_SECURE_CONSENT_PRU = "/LOANS-GROUP/reports/jasper/ConsentSecurityBasic.jasper";
		public static final String PATH_SECURE_CONSENT_PRU_IND = "/LOANS-GROUP/reports/jasper/ConsentSecurityBasicInd.jasper";
		public static final String PATH_SECURE_CONSENT_PRU_GRU = "/LOANS-GROUP/reports/jasper/ConsentSecurityBasicGru.jasper";
		public static final String PATH_SECURE_CONSENT_PRU_REN = "/LOANS-GROUP/reports/jasper/ConsentSecurityBasicRen.jasper";

		// reprote consentimiento seguro+medico
		public static final String PATH_SECURE_CONSENT_MEDICAL = "/LOANS-GROUP/reports/jasper/consentOfsegurityTuiioMedical.jasper";
		public static final String PATH_SECURE_CONSENT_MEDICAL_PRU = "/LOANS-GROUP/reports/jasper/ConsentSecurityFull.jasper";

	}

}