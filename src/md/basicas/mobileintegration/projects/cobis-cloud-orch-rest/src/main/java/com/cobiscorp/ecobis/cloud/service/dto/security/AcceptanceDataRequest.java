package com.cobiscorp.ecobis.cloud.service.dto.security;

import java.util.Calendar;

public class AcceptanceDataRequest {
	private String acceptanceType;
	private String result;
	private Integer clientId;
	private String dateAcceptance;
	
	

	public String getDateAcceptance() {
		return dateAcceptance;
	}

	public void setDateAcceptance(String dateAcceptance) {
		this.dateAcceptance = dateAcceptance;
	}

	public AcceptanceDataRequest() {
	}

	public String getAcceptanceType() {
		return acceptanceType;
	}

	public void setAcceptanceType(String acceptanceType) {
		this.acceptanceType = acceptanceType;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

}
