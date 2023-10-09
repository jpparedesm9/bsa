package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;


public class ContratoCreditoInclusionPrincipalDATABEAN {

	private List<ContratoCreditoInclusionDetallePrincipalDTO> contratoCreditoInclusionDetallePrincipal;

	public List<ContratoCreditoInclusionDetallePrincipalDTO> getContratoCreditoInclusionDetallePrincipal() {
		return contratoCreditoInclusionDetallePrincipal;
	}

	public void setContratoCreditoInclusionDetallePrincipal(List<ContratoCreditoInclusionDetallePrincipalDTO> contratoCreditoInclusionDetallePrincipal) {
		this.contratoCreditoInclusionDetallePrincipal = contratoCreditoInclusionDetallePrincipal;
	}
}