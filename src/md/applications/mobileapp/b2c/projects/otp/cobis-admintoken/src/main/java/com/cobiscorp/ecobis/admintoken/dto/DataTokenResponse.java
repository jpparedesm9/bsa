package com.cobiscorp.ecobis.admintoken.dto;

public class DataTokenResponse {
	
	private String tokenNumber;
	private Message message;
	private Boolean success;
	private int channel;
	private String login;
	
	public String getTokenNumber() {
		return tokenNumber;
	}
	public void setTokenNumber(String tokenNumber) {
		this.tokenNumber = tokenNumber;
	}
	public Message getMessage() {
		return message;
	}
	public void setMessage(Message message) {
		this.message = message;
	}
	public Boolean getSuccess() {
		return success;
	}
	public void setSuccess(Boolean success) {
		this.success = success;
	}
	@Override
	public String toString() {
		return "DataTokenOut [tokenNumber=" + tokenNumber + ", message="
				+ message + ", success=" + success + "]";
	}
	public int getChannel() {
		return channel;
	}
	public void setChannel(int channel) {
		this.channel = channel;
	}
	public String getLogin() {
		return login;
	}
	public void setLogin(String login) {
		this.login = login;
	}

}
