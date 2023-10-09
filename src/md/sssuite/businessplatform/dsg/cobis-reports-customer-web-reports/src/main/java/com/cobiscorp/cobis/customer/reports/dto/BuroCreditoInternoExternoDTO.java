package com.cobiscorp.cobis.customer.reports.dto;

import java.util.List;

public class BuroCreditoInternoExternoDTO {

	private List<BuroCreditoInternoExternoDTODom> domicilios;
	private List<BuroCreditoInternoExternoDTOHis> historico;
	private List<BuroCreditoInternoExternoDTOSisFin> sisFinanciero;

	public List<BuroCreditoInternoExternoDTODom> getDomicilios() {
		return domicilios;
	}

	public void setDomicilios(List<BuroCreditoInternoExternoDTODom> domicilios) {
		this.domicilios = domicilios;
	}

	public List<BuroCreditoInternoExternoDTOHis> getHistorico() {
		return historico;
	}

	public void setHistorico(List<BuroCreditoInternoExternoDTOHis> historico) {
		this.historico = historico;
	}

	public List<BuroCreditoInternoExternoDTOSisFin> getSisFinanciero() {
		return sisFinanciero;
	}

	public void setSisFinanciero(List<BuroCreditoInternoExternoDTOSisFin> sisFinanciero) {
		this.sisFinanciero = sisFinanciero;
	}

}
