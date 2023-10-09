package com.cobiscorp.ecobis.admintoken.dto;

public class DataTokenRequest {
	private String login;
	private String token;
	private String bankName;
	private Integer channel;
	private String originMail;
	private String destinationMail;
	private Integer clientId;
	private String smsFlag;
	private String clientPhoneNumber;
	private String culture;
	private String sendingType;
	private String operation;

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public Integer getChannel() {
		return channel;
	}

	public void setChannel(Integer channel) {
		this.channel = channel;
	}

	public String getOriginMail() {
		return originMail;
	}

	public void setOriginMail(String originMail) {
		this.originMail = originMail;
	}

	public String getDestinationMail() {
		return destinationMail;
	}

	public void setDestinationMail(String destinationMail) {
		this.destinationMail = destinationMail;
	}

	public Integer getClientId() {
		return clientId;
	}

	public void setClientId(Integer clientId) {
		this.clientId = clientId;
	}

	public String getSmsFlag() {
		return smsFlag;
	}

	public void setSmsFlag(String smsFlag) {
		this.smsFlag = smsFlag;
	}

	public String getClientPhoneNumber() {
		return clientPhoneNumber;
	}

	public void setClientPhoneNumber(String clientPhoneNumber) {
		this.clientPhoneNumber = clientPhoneNumber;
	}

	public String getCulture() {
		return culture;
	}

	public void setCulture(String culture) {
		this.culture = culture;
	}

	public String getSendingType() {
		return sendingType;
	}

	public void setSendingType(String sendingType) {
		this.sendingType = sendingType;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}
}
