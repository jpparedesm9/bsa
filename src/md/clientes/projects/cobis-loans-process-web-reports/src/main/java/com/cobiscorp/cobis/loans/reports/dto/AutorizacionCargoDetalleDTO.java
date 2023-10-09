package com.cobiscorp.cobis.loans.reports.dto;

public class AutorizacionCargoDetalleDTO {

	private String policy;
	private String certificateNumber;
	private String name;
	private String birthdate;
	private String address;
	private String rfc;
	private String startValidity;
	private String termValidity;
	private String insuranceCost;
	private String account;

	public String getPolicy() {
		return policy;
	}

	public void setPolicy(String policy) {
		this.policy = policy;
	}

	public String getCertificateNumber() {
		return certificateNumber;
	}

	public void setCertificateNumber(String certificateNumber) {
		this.certificateNumber = certificateNumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirthdate() {
		return birthdate;
	}

	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	public String getStartValidity() {
		return startValidity;
	}

	public void setStartValidity(String startValidity) {
		this.startValidity = startValidity;
	}

	public String getTermValidity() {
		return termValidity;
	}

	public void setTermValidity(String termValidity) {
		this.termValidity = termValidity;
	}

	public String getInsuranceCost() {
		return insuranceCost;
	}

	public void setInsuranceCost(String insuranceCost) {
		this.insuranceCost = insuranceCost;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}
}