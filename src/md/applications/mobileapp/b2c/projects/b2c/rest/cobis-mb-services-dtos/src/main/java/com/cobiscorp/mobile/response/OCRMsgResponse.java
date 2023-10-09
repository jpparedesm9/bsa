package com.cobiscorp.mobile.response;

import java.util.List;

public class OCRMsgResponse{

	private String idExpediente;
	private String idValidas;
	private String documentType;
	private List<Ocr> ocr = null;

	private Integer triesNumber;

	public String getIdExpediente() {
		return idExpediente;
	}
	public void setIdExpediente(String idExpediente) {
		this.idExpediente = idExpediente;
	}

	public String getIdValidas() {
		return idValidas;
	}
	public void setIdValidas(String idValidas) {
		this.idValidas = idValidas;
	}

	public String getDocumentType() {
		return documentType;
	}
	public void setDocumentType(String documentType) {
		this.documentType = documentType;
	}

	public List<Ocr> getOcr() {
		return ocr;
	}
	public void setOcr(List<Ocr> ocr) {
		this.ocr = ocr;
	}

	public Integer getTriesNumber() {
		return triesNumber;
	}
	public void setTriesNumber(Integer triesNumber) {
		this.triesNumber = triesNumber;
	}

	@Override
	public String toString() {
		return "SCORESMsgResponse [idExpediente=" + idExpediente + ", idValidas=" + idValidas + ", documentType="
				+ documentType + ", triesNumber=" + triesNumber + ", ocr=" + ocr + "]";
	}

}
