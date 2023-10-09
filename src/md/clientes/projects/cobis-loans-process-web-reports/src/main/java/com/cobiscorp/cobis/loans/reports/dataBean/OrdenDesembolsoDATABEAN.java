package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.OrdenDesembolsoDTO;

public class OrdenDesembolsoDATABEAN {

	private List<OrdenDesembolsoDTO> moneyDescription;

	public List<OrdenDesembolsoDTO> getMoneyDescription() {
		return moneyDescription;
	}

	public void setMoneyDescription(List<OrdenDesembolsoDTO> moneyDescription) {
		this.moneyDescription = moneyDescription;
	}
}