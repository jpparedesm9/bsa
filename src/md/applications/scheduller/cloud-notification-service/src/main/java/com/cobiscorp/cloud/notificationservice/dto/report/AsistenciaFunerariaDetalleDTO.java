package com.cobiscorp.cloud.notificationservice.dto.report;

public class AsistenciaFunerariaDetalleDTO {
	private String certificateNumber;
	private String name;
	private String rfc;

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

	public String getRfc() {
		return rfc;
	}

	public void setRfc(String rfc) {
		this.rfc = rfc;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("AsistenciaFunerariaDetalleDTO [certificateNumber=");
		builder.append(getCertificateNumber());
		builder.append(", name=");
		builder.append(getName());
		builder.append(", rfc=");
		builder.append(getRfc());
		builder.append("]");

		return builder.toString();
	}
}