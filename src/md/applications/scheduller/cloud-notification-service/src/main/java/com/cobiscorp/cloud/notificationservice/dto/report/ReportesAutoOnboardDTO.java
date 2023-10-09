package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.Date;

public class ReportesAutoOnboardDTO {

	private Integer customerId;
	private String customerName;
	private String bank;
	private Integer operation;
	private Integer application;
	private String documentCode;
	private String documenteName;
	private String email;
	private String buc;
	private Date proccessDate;
	/*
	 * private Integer processInst;
	 */
	private Integer groupId;
	private String folder;
	private String docName;

	// Codigo
	private static String codContrato = "100";// contratoSimpleAutoOnboard
	private static String codTablaAmortizacion = "101";// tablaAmortizacionSimpleAutoOnboard
	private static String codCaratula = "102";// caratulaSimpleAutoOnboard
	private static String codConsentimiento = "103"; // consentimientoZurichSimpleAutoOnboar
	private static String codKyc = "104"; // kycSimpleAutoOnboard
	private static String codAutorizacion = "105"; // autorizacionBuroSimpleAutoOnboard
	private static String codFichaPagoGrupal = "113"; // FichaPagoGrupal
	private static String codFichaPagoIndividual = "121"; // FichaPagoIndividual
	private static String codContratoGrupal = "122"; // ContratoGrupal
	private static String codCaratulaCreditoGrupal = "123"; // CaratulaCreditoGrupal
	private static String codTablaAmortizacionGrupal = "124"; // TablaAmortizacionGrupal
	private static String codFormularioKYC = "125"; // FormularioKYC
	private static String codCertConsentimiento = "126"; // CertificadoConsentimiento
	private static String codCertAsistenciaMedica = "127"; // CertificadoAsistenciaMedica
	private static String codCertAsistenciaFuneraria = "128"; // CertificadoAsistenciaFuneraria

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getBank() {
		return bank;
	}

	public void setBank(String bank) {
		this.bank = bank;
	}

	public Integer getOperation() {
		return operation;
	}

	public void setOperation(Integer operation) {
		this.operation = operation;
	}

	public Integer getApplication() {
		return application;
	}

	public void setApplication(Integer application) {
		this.application = application;
	}

	public String getDocumentCode() {
		return documentCode;
	}

	public void setDocumentCode(String documentCode) {
		this.documentCode = documentCode;
	}

	public String getDocumenteName() {
		return documenteName;
	}

	public void setDocumenteName(String documenteName) {
		this.documenteName = documenteName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBuc() {
		return buc;
	}

	public void setBuc(String buc) {
		this.buc = buc;
	}

	public Date getProccessDate() {
		return proccessDate;
	}

	public void setProccessDate(Date proccessDate) {
		this.proccessDate = proccessDate;
	}

	public static String getCodContrato() {
		return codContrato;
	}

	public static void setCodContrato(String codContrato) {
		ReportesAutoOnboardDTO.codContrato = codContrato;
	}

	public static String getCodTablaAmortizacion() {
		return codTablaAmortizacion;
	}

	public static void setCodTablaAmortizacion(String codTablaAmortizacion) {
		ReportesAutoOnboardDTO.codTablaAmortizacion = codTablaAmortizacion;
	}

	public static String getCodCaratula() {
		return codCaratula;
	}

	public static void setCodCaratula(String codCaratula) {
		ReportesAutoOnboardDTO.codCaratula = codCaratula;
	}

	public static String getCodConsentimiento() {
		return codConsentimiento;
	}

	public static void setCodConsentimiento(String codConsentimiento) {
		ReportesAutoOnboardDTO.codConsentimiento = codConsentimiento;
	}

	public static String getCodKyc() {
		return codKyc;
	}

	public static void setCodKyc(String codKyc) {
		ReportesAutoOnboardDTO.codKyc = codKyc;
	}

	public static String getCodAutorizacion() {
		return codAutorizacion;
	}

	public static void setCodAutorizacion(String codAutorizacion) {
		ReportesAutoOnboardDTO.codAutorizacion = codAutorizacion;
	}

	public static String getCodFichaPagoGrupal() {
		return codFichaPagoGrupal;
	}

	public static void setCodFichaPagoGrupal(String codFichaPagoGrupal) {
		ReportesAutoOnboardDTO.codFichaPagoGrupal = codFichaPagoGrupal;
	}

	public static String getCodFichaPagoIndividual() {
		return codFichaPagoIndividual;
	}

	public static void setCodFichaPagoIndividual(String codFichaPagoIndividual) {
		ReportesAutoOnboardDTO.codFichaPagoIndividual = codFichaPagoIndividual;
	}

	public static String getCodContratoGrupal() {
		return codContratoGrupal;
	}

	public static void setCodContratoGrupal(String codContratoGrupal) {
		ReportesAutoOnboardDTO.codContratoGrupal = codContratoGrupal;
	}

	public static String getCodCaratulaCreditoGrupal() {
		return codCaratulaCreditoGrupal;
	}

	public static void setCodCaratulaCreditoGrupal(String codCaratulaCreditoGrupal) {
		ReportesAutoOnboardDTO.codCaratulaCreditoGrupal = codCaratulaCreditoGrupal;
	}

	public static String getCodTablaAmortizacionGrupal() {
		return codTablaAmortizacionGrupal;
	}

	public static void setCodTablaAmortizacionGrupal(String codTablaAmortizacionGrupal) {
		ReportesAutoOnboardDTO.codTablaAmortizacionGrupal = codTablaAmortizacionGrupal;
	}

	public static String getCodFormularioKYC() {
		return codFormularioKYC;
	}

	public static void setCodFormularioKYC(String codFormularioKYC) {
		ReportesAutoOnboardDTO.codFormularioKYC = codFormularioKYC;
	}

	public static String getCodCertConsentimiento() {
		return codCertConsentimiento;
	}

	public static void setCodCertConsentimiento(String codCertConsentimiento) {
		ReportesAutoOnboardDTO.codCertConsentimiento = codCertConsentimiento;
	}

	public static String getCodCertAsistenciaMedica() {
		return codCertAsistenciaMedica;
	}

	public static void setCodCertAsistenciaMedica(String codCertAsistenciaMedica) {
		ReportesAutoOnboardDTO.codCertAsistenciaMedica = codCertAsistenciaMedica;
	}

	public static String getCodCertAsistenciaFuneraria() {
		return codCertAsistenciaFuneraria;
	}

	public static void setCodCertAsistenciaFuneraria(String codCertAsistenciaFuneraria) {
		ReportesAutoOnboardDTO.codCertAsistenciaFuneraria = codCertAsistenciaFuneraria;
	}

	/*
	 * 
	 * public Integer getProcessInst() { return processInst; }
	 * 
	 * public void setProcessInst(Integer proccessInst) { this.processInst = proccessInst; }
	 * 
	 * 
	 * 
	 */

	public Integer getGroupId() {
		return groupId;
	}

	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ReportesAutoOnboardDTO [customerId=");
		builder.append(customerId);
		builder.append(", customerName=");
		builder.append(customerName);
		builder.append(", bank=");
		builder.append(bank);
		builder.append(", operation=");
		builder.append(operation);
		builder.append(", application=");
		builder.append(application);
		builder.append(", documentCode=");
		builder.append(documentCode);
		builder.append(", documenteName=");
		builder.append(documenteName);
		builder.append(", email=");
		builder.append(email);
		builder.append(", buc=");
		builder.append(buc);
		builder.append(", proccessDate=");
		builder.append(proccessDate);
		builder.append(", groupId=");
		builder.append(groupId);
		builder.append(", folder=");
		builder.append(folder);
		builder.append(", docName=");
		builder.append(docName);
		builder.append("]");
		return builder.toString();
	}

}
