package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class ContratoSimpleIndAutoOnboardDTO {
	private InfoLoanDTO infoLoanDTO;
	private List<ContratoSimpleIndAutoOnboardDetallePrincipalDTO> contratoCreditoInclusionIndividualDetallePrincipal;
	private List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionIndividualInfoPrevia;
	private List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionIndividualAnexoLegal;

	public InfoLoanDTO getInfoLoanDTO() {
		return infoLoanDTO;
	}

	public void setInfoLoanDTO(InfoLoanDTO infoLoanDTO) {
		this.infoLoanDTO = infoLoanDTO;
	}

	public List<ContratoSimpleIndAutoOnboardDetallePrincipalDTO> getContratoCreditoInclusionIndividualDetallePrincipal() {
		return contratoCreditoInclusionIndividualDetallePrincipal;
	}

	public void setContratoCreditoInclusionIndividualDetallePrincipal(List<ContratoSimpleIndAutoOnboardDetallePrincipalDTO> contratoCreditoInclusionIndividualDetallePrincipal) {
		this.contratoCreditoInclusionIndividualDetallePrincipal = contratoCreditoInclusionIndividualDetallePrincipal;
	}

	public List<ContratoSimpleIndAutoOnboardClausulaDTO> getContratoCreditoInclusionIndividualInfoPrevia() {
		return contratoCreditoInclusionIndividualInfoPrevia;
	}

	public void setContratoCreditoInclusionIndividualInfoPrevia(List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionIndividualInfoPrevia) {
		this.contratoCreditoInclusionIndividualInfoPrevia = contratoCreditoInclusionIndividualInfoPrevia;
	}

	public List<ContratoSimpleIndAutoOnboardClausulaDTO> getContratoCreditoInclusionIndividualAnexoLegal() {
		return contratoCreditoInclusionIndividualAnexoLegal;
	}

	public void setContratoCreditoInclusionIndividualAnexoLegal(List<ContratoSimpleIndAutoOnboardClausulaDTO> contratoCreditoInclusionIndividualAnexoLegal) {
		this.contratoCreditoInclusionIndividualAnexoLegal = contratoCreditoInclusionIndividualAnexoLegal;
	}
}
