package com.cobiscorp.cloud.notificationservice.dto.report;

public class CertConsentimientoZurichAutoOnboardSubBeneficiary {

	private Integer number;
	private String fullName;
	private String relationship;
	private String datebirth;
	private Double percentaje;

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getRelationship() {
		return relationship;
	}

	public void setRelationship(String relationship) {
		this.relationship = relationship;
	}

	public String getDatebirth() {
		return datebirth;
	}

	public void setDatebirth(String datebirth) {
		this.datebirth = datebirth;
	}

	public Double getPercentaje() {
		return percentaje;
	}

	public void setPercentaje(Double percentaje) {
		this.percentaje = percentaje;
	}

	@Override
	public String toString() {
		return "CertConsentimientoZurichAutoOnboardSubBeneficiary [number=" + number + ", fullName=" + fullName
				+ ", relationship=" + relationship + ", datebirth=" + datebirth + ", percentaje=" + percentaje + "]";
	}

}
