package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class KYCAutoOnboardDTO {

	private List<KYCAutoOnboardSubDTO> kycSimplificadoDetalle;

	public List<KYCAutoOnboardSubDTO> getKycSimplificadoDetalle() {
		return kycSimplificadoDetalle;
	}

	public void setKycSimplificadoDetalle(List<KYCAutoOnboardSubDTO> kycSimplificadoDetalle) {
		this.kycSimplificadoDetalle = kycSimplificadoDetalle;
	}

}