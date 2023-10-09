package com.cobiscorp.cobis.assets.reports.dto;

import java.util.List;

public class AccountStatusDTO {

	private List<AccountStatusAmortizationTableDTO> amortizationTable;
	private List<AccountStatusMovementDTO> movement;

	public List<AccountStatusAmortizationTableDTO> getAmortizationTable() {
		return amortizationTable;
	}

	public void setAmortizationTable(List<AccountStatusAmortizationTableDTO> amortizationTable) {
		this.amortizationTable = amortizationTable;
	}

	public List<AccountStatusMovementDTO> getMovement() {
		return movement;
	}

	public void setMovement(List<AccountStatusMovementDTO> movement) {
		this.movement = movement;
	}

}
