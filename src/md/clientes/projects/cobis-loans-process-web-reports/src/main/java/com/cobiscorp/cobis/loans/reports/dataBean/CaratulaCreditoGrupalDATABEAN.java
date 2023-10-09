package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;

public class CaratulaCreditoGrupalDATABEAN {
	private List<CreditPaymentsDTO> listaPagos;

	public List<CreditPaymentsDTO> getListaPagos() {
		return listaPagos;
	}

	public void setListaPagos(List<CreditPaymentsDTO> listaPagos) {
		this.listaPagos = listaPagos;
	}
}
