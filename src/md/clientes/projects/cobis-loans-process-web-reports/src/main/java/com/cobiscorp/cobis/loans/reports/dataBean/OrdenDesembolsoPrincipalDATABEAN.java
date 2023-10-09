package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.OrdenDesembolsoPrincipalDTO;

public class OrdenDesembolsoPrincipalDATABEAN {

	private List<OrdenDesembolsoPrincipalDTO> detallePrincipal;

	public List<OrdenDesembolsoPrincipalDTO> getDetallePrincipal() {
		return detallePrincipal;
	}

	public void setDetallePrincipal(List<OrdenDesembolsoPrincipalDTO> detallePrincipal) {
		this.detallePrincipal = detallePrincipal;
	}

}