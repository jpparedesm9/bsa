package com.cobiscorp.cobis.loans.reports.dataBean;

import java.util.List;

import com.cobiscorp.cobis.loans.reports.dto.CreditPaymentsDTO;
import com.cobiscorp.cobis.loans.reports.dto.MemberChargesDTO;

public class CargoRecurrenteIndividualDATABEAN {
	private List<MemberChargesDTO> listaMiembros;

	public List<MemberChargesDTO> getListaMiembros() {
		return listaMiembros;
	}

	public void setListaMiembros(List<MemberChargesDTO> listaMiembros) {
		this.listaMiembros = listaMiembros;
	}
}
