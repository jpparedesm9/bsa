package com.cobiscorp.cloud.notificationservice.dto.report;

import java.awt.image.BufferedImage;

public class FichaDePagoSubDTO {

	private String institucion;
	private BufferedImage barCode;
	private String referencia;
	private String nroConvenio;
	
	public String getInstitucion() {
		return institucion;
	}
	public void setInstitucion(String institucion) {
		this.institucion = institucion;
	}
	public BufferedImage getBarCode() {
		return barCode;
	}
	public void setBarCode(BufferedImage barCode) {
		this.barCode = barCode;
	}
	public String getReferencia() {
		return referencia;
	}
	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}
	public String getNroConvenio() {
		return nroConvenio;
	}
	public void setNroConvenio(String nroConvenio) {
		this.nroConvenio = nroConvenio;
	}
	
	@Override
	public String toString() {
		return "FichaDePagoSubDTO [institucion=" + institucion + ", barCode=" + barCode + ", referencia=" + referencia + ", nroConvenio=" + nroConvenio + "]";
	}

}
