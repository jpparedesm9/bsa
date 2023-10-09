package com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto;

public class RenapoMessage {
	private String code;
	private String message;

	public RenapoMessage() {

	}

	public RenapoMessage(String code, String message) {
		super();
		this.code = code;
		this.message = message;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
