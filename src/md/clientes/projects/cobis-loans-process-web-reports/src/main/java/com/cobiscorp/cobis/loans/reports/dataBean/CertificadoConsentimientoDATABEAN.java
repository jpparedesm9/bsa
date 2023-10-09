package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.CertificadoConsentimientoDetalleDTO;

public class CertificadoConsentimientoDATABEAN {

	private List<CertificadoConsentimientoDetalleDTO> certificadoConsentimientoDetalle;

	public List<CertificadoConsentimientoDetalleDTO> getCertificadoConsentimientoDetalle() {
		return certificadoConsentimientoDetalle;
	}

	public void setCertificadoConsentimientoDetalle(List<CertificadoConsentimientoDetalleDTO> certificadoConsentimientoDetalle) {
		this.certificadoConsentimientoDetalle = certificadoConsentimientoDetalle;
	}

}