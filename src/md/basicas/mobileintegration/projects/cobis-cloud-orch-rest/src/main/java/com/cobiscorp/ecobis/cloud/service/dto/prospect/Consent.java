package com.cobiscorp.ecobis.cloud.service.dto.prospect;

public class Consent {

	private String state;
	private String privacyNotice;
	private String termsConditions;

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPrivacyNotice() {
		return privacyNotice;
	}

	public void setPrivacyNotice(String privacyNotice) {
		this.privacyNotice = privacyNotice;
	}

	public String getTermsConditions() {
		return termsConditions;
	}

	public void setTermsConditions(String termsConditions) {
		this.termsConditions = termsConditions;
	}
}
