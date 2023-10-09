package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeClausulaDTO;
import com.cobiscorp.cobis.loans.reports.dto.ContratoCreditoRevolventeDetallePrincipalDTO;

public class ContratoCreditoRevolventePrincipalDATABEAN {

	private List<ContratoCreditoRevolventeDetallePrincipalDTO> contratoCreditoRevolventeDetallePrincipal;
	private List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeClausula; // Solo para poner el texto
	private List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeInfoPrevia; // Solo para poner el texto
	private List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeAnexoLegal; // Solo para poner el texto

	public List<ContratoCreditoRevolventeDetallePrincipalDTO> getContratoCreditoRevolventeDetallePrincipal() {
		return contratoCreditoRevolventeDetallePrincipal;
	}

	public void setContratoCreditoRevolventeDetallePrincipal(List<ContratoCreditoRevolventeDetallePrincipalDTO> contratoCreditoRevolventeDetallePrincipal) {
		this.contratoCreditoRevolventeDetallePrincipal = contratoCreditoRevolventeDetallePrincipal;
	}

	public List<ContratoCreditoRevolventeClausulaDTO> getContratoCreditoRevolventeClausula() {
		return contratoCreditoRevolventeClausula;
	}

	public void setContratoCreditoRevolventeClausula(List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeClausula) {
		this.contratoCreditoRevolventeClausula = contratoCreditoRevolventeClausula;
	}

	public List<ContratoCreditoRevolventeClausulaDTO> getContratoCreditoRevolventeInfoPrevia() {
		return contratoCreditoRevolventeInfoPrevia;
	}

	public void setContratoCreditoRevolventeInfoPrevia(List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeInfoPrevia) {
		this.contratoCreditoRevolventeInfoPrevia = contratoCreditoRevolventeInfoPrevia;
	}

	public List<ContratoCreditoRevolventeClausulaDTO> getContratoCreditoRevolventeAnexoLegal() {
		return contratoCreditoRevolventeAnexoLegal;
	}

	public void setContratoCreditoRevolventeAnexoLegal(List<ContratoCreditoRevolventeClausulaDTO> contratoCreditoRevolventeAnexoLegal) {
		this.contratoCreditoRevolventeAnexoLegal = contratoCreditoRevolventeAnexoLegal;
	}

}