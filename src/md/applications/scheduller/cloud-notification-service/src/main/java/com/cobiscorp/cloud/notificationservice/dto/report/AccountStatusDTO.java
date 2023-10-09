package com.cobiscorp.cloud.notificationservice.dto.report;

import java.util.List;

public class AccountStatusDTO {

	private AccountStatusHeaderDTO accountStatusHeader;
	private AccountStatusInformationDTO accountStatusInformation;
	private AccountStatusMovementTotalDTO accountStatusMovementTotalDTO;
	private List<AccountStatusMovementDTO> movement;
	private List<AccountStatusAmortizationTableDTO> amortizationTable;
	private List<PagoObjetadoDTO> pagoObjetadoTable;
        private List<AccountStatusObjectedChargesTableDTO> objectedChargesTable;

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

	public AccountStatusHeaderDTO getAccountStatusHeader() {
		return accountStatusHeader;
	}

	public void setAccountStatusHeader(AccountStatusHeaderDTO accountStatusHeader) {
		this.accountStatusHeader = accountStatusHeader;
	}

	public List<AccountStatusObjectedChargesTableDTO> getObjectedChargesTable() {
		return objectedChargesTable;
	}

	public void setObjectedChargesTable(List<AccountStatusObjectedChargesTableDTO> objectedChargesTable) {
		this.objectedChargesTable = objectedChargesTable;
	}

	public AccountStatusInformationDTO getAccountStatusInformation() {
		return accountStatusInformation;
	}

	public void setAccountStatusInformation(AccountStatusInformationDTO accountStatusInformation) {
		this.accountStatusInformation = accountStatusInformation;
	}

	public AccountStatusMovementTotalDTO getAccountStatusMovementTotalDTO() {
		return accountStatusMovementTotalDTO;
	}

	public void setAccountStatusMovementTotalDTO(AccountStatusMovementTotalDTO accountStatusMovementTotalDTO) {
		this.accountStatusMovementTotalDTO = accountStatusMovementTotalDTO;
	}

	public List<PagoObjetadoDTO> getPagoObjetadoTable() {
		return pagoObjetadoTable;
	}

	public void setPagoObjetadoTable(List<PagoObjetadoDTO> pagoObjetadoTable) {
		this.pagoObjetadoTable = pagoObjetadoTable;
	}
}
