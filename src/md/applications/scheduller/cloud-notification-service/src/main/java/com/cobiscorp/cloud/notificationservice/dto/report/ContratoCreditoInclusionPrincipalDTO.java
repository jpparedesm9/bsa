package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ContratoCreditoInclusionPrincipalDTO {

	private List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionInfoPrevia;
	private List<ContratoCreditoInclusionDetallePrincipalDTO> contratoCreditoInclusionDetallePrincipal;
	private List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionAnexoLegal;

	public List<ContratoSimpleIndAutoOnboardClausulaDTO> getContratoCreditoInclusionInfoPrevia() {
		return contratoCreditoInclusionInfoPrevia;
	}

	public void setContratoCreditoInclusionInfoPrevia(List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionInfoPrevia) {
		this.contratoCreditoInclusionInfoPrevia = contratoCreditoInclusionInfoPrevia;
	}

	public List<ContratoCreditoInclusionDetallePrincipalDTO> getContratoCreditoInclusionDetallePrincipal() {
		return contratoCreditoInclusionDetallePrincipal;
	}

	public void setContratoCreditoInclusionDetallePrincipal(List<ContratoCreditoInclusionDetallePrincipalDTO> contratoCreditoInclusionDetallePrincipal) {
		this.contratoCreditoInclusionDetallePrincipal = contratoCreditoInclusionDetallePrincipal;
	}

	public List<ContratoSimpleIndAutoOnboardClausulaDTO> getContratoCreditoInclusionAnexoLegal() {
		return contratoCreditoInclusionAnexoLegal;
	}

	public void setContratoCreditoInclusionAnexoLegal(List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionAnexoLegal) {
		this.contratoCreditoInclusionAnexoLegal = contratoCreditoInclusionAnexoLegal;
	}
}