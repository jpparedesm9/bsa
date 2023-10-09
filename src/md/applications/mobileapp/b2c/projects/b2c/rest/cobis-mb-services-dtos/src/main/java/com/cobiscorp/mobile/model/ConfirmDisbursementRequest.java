package com.cobiscorp.mobile.model;

public class ConfirmDisbursementRequest {

	private String otp;
	private String loanId;
	private String isBusinessPartner;

	public ConfirmDisbursementRequest() {
		super();
	}

	public ConfirmDisbursementRequest(String code) {
		super();
		this.otp = code;
	}

	public ConfirmDisbursementRequest(String code, String loanId) {
		super();
		this.otp = code;
		this.loanId = loanId;
	}

	public String getOtp() {
		return otp;
	}

	public void setOtp(String confirmation) {
		this.otp = confirmation;
	}

	/**
	 * @return the loanId
	 */
	public String getLoanId() {
		return loanId;
	}

	/**
	 * @param loanId
	 *            the loanId to set
	 */
	public void setLoanId(String loanId) {
		this.loanId = loanId;
	}

	public String getIsBusinessPartner() {
		return isBusinessPartner;
	}

	public void setIsBusinessPartner(String isBusinessPartner) {
		this.isBusinessPartner = isBusinessPartner;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ConfirmDisbursementRequest [loanId=");
		builder.append(loanId);
		builder.append(", isBusinessPartner=");
		builder.append(isBusinessPartner);
		builder.append("]");
		return builder.toString();
	}

}
