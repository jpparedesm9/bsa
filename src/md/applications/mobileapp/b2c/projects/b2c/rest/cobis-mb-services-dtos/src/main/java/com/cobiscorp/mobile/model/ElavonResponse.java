package com.cobiscorp.mobile.model;

public class ElavonResponse {

	private String loanId;
	private String urlPayLeague;

	public String getLoanId() {
		return loanId;
	}

	public void setLoanId(String loanId) {
		this.loanId = loanId;
	}

	public String getUrlPayLeague() {
		return urlPayLeague;
	}

	public void setUrlPayLeague(String urlPayLeague) {
		this.urlPayLeague = urlPayLeague;
	}

	@Override
	public String toString() {
		return "ElavonResponse [loanId=" + loanId + ", urlPayLeague=" + urlPayLeague + "]";
	}
	
}
