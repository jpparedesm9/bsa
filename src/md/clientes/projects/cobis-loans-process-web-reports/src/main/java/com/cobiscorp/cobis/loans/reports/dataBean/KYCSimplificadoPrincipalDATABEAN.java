package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.KYCSimplificadoDetalleDTO;

public class KYCSimplificadoPrincipalDATABEAN {

	private List<KYCSimplificadoDetalleDTO> kycSimplificadoDetalle;

	public List<KYCSimplificadoDetalleDTO> getKycSimplificadoDetalle() {
		return kycSimplificadoDetalle;
	}

	public void setKycSimplificadoDetalle(List<KYCSimplificadoDetalleDTO> kycSimplificadoDetalle) {
		this.kycSimplificadoDetalle = kycSimplificadoDetalle;
	}

}