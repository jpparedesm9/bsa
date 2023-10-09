package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionIndividualDeclaracionDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoInclusionIndividualDetallePrincipalDTO;
import com.cobiscorp.cobis.loans.reports.dto.LoanGroupDetail;

public class SolicitudCreditoGrupalDATABEAN {
	private List<LoanGroupDetail> loanGroupDetail;
	private List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> contratoCreditoInclusionIndividualDetallePrincipal;
	private List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionClausula; // Solo para poner el texto
	private List<ContratoCreditoInclusionIndividualDeclaracionDTO> contratoCreditoInclusionDeclaracion;
	private List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionIndividualInfoPrevia; // Solo para poner el texto
	private List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionIndividualAnexoLegal; // Solo para poner el texto

	public List<LoanGroupDetail> getLoanGroupDetail() {
		return loanGroupDetail;
	}

	public void setLoanGroupDetail(List<LoanGroupDetail> loanGroupDetail) {
		this.loanGroupDetail = loanGroupDetail;
	}

	public List<ContratoCreditoInclusionClausulaDTO> getContratoCreditoInclusionClausula() {
		return contratoCreditoInclusionClausula;
	}

	public void setContratoCreditoInclusionClausula(List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionClausula) {
		this.contratoCreditoInclusionClausula = contratoCreditoInclusionClausula;
	}

	public List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> getContratoCreditoInclusionIndividualDetallePrincipal() {
		return contratoCreditoInclusionIndividualDetallePrincipal;
	}

	public void setContratoCreditoInclusionIndividualDetallePrincipal(
			List<ContratoCreditoInclusionIndividualDetallePrincipalDTO> contratoCreditoInclusionIndividualDetallePrincipal) {
		this.contratoCreditoInclusionIndividualDetallePrincipal = contratoCreditoInclusionIndividualDetallePrincipal;
	}

	public List<ContratoCreditoInclusionIndividualDeclaracionDTO> getContratoCreditoInclusionDeclaracion() {
		return contratoCreditoInclusionDeclaracion;
	}

	public void setContratoCreditoInclusionDeclaracion(List<ContratoCreditoInclusionIndividualDeclaracionDTO> contratoCreditoInclusionDeclaracion) {
		this.contratoCreditoInclusionDeclaracion = contratoCreditoInclusionDeclaracion;
	}

	public List<ContratoCreditoInclusionClausulaDTO> getContratoCreditoInclusionIndividualInfoPrevia() {
		return contratoCreditoInclusionIndividualInfoPrevia;
	}

	public void setContratoCreditoInclusionIndividualInfoPrevia(List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionIndividualInfoPrevia) {
		this.contratoCreditoInclusionIndividualInfoPrevia = contratoCreditoInclusionIndividualInfoPrevia;
	}

	public List<ContratoCreditoInclusionClausulaDTO> getContratoCreditoInclusionIndividualAnexoLegal() {
		return contratoCreditoInclusionIndividualAnexoLegal;
	}

	public void setContratoCreditoInclusionIndividualAnexoLegal(List<ContratoCreditoInclusionClausulaDTO> contratoCreditoInclusionIndividualAnexoLegal) {
		this.contratoCreditoInclusionIndividualAnexoLegal = contratoCreditoInclusionIndividualAnexoLegal;
	}
}
