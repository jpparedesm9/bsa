package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ContratoSimpleIndAutoOnboardDetallePrincipalDTO {

	private List<ContratoSimpleIndAutoOnboardDeclaracionDTO> contratoCreditoInclusionDeclaracion;
	private List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionClausula;

	public List<ContratoSimpleIndAutoOnboardDeclaracionDTO> getContratoCreditoInclusionDeclaracion() {
		return contratoCreditoInclusionDeclaracion;
	}

	public void setContratoCreditoInclusionDeclaracion(List<ContratoSimpleIndAutoOnboardDeclaracionDTO> contratoCreditoInclusionDeclaracion) {
		this.contratoCreditoInclusionDeclaracion = contratoCreditoInclusionDeclaracion;
	}

	public List<ContratoSimpleIndAutoOnboardClausulaDTO> getContratoCreditoInclusionClausula() {
		return contratoCreditoInclusionClausula;
	}

	public void setContratoCreditoInclusionClausula(List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionClausula) {
		this.contratoCreditoInclusionClausula = contratoCreditoInclusionClausula;
	}

}