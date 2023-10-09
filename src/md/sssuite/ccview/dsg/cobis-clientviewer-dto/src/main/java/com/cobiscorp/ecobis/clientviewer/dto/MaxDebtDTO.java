package com.cobiscorp.ecobis.clientviewer.dto;

/**
 * DTO which is used to obtain Maximum Debts of Customer or Economic Group
 * 
 * @author bbuendia
 * 
 */
public class MaxDebtDTO {

	private String exceedsLimit;

	private String okProcess;

	private Integer errorCode;

	private String errorDescription;

	private Double debtAmount;

	private Float limit;

	private Double limitDebt;

	private Double available;

	public String getExceedsLimit() {
		return exceedsLimit;
	}

	public void setExceedsLimit(String exceedsLimit) {
		this.exceedsLimit = exceedsLimit;
	}

	public String getOkProcess() {
		return okProcess;
	}

	public void setOkProcess(String okProcess) {
		this.okProcess = okProcess;
	}

	public Integer getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(Integer errorCode) {
		this.errorCode = errorCode;
	}

	public String getErrorDescription() {
		return errorDescription;
	}

	public void setErrorDescription(String errorDescription) {
		this.errorDescription = errorDescription;
	}

	public Double getDebtAmount() {
		return debtAmount;
	}

	public void setDebtAmount(Double debtAmount) {
		this.debtAmount = debtAmount;
	}

	public Float getLimit() {
		return limit;
	}

	public void setLimit(Float limit) {
		this.limit = limit;
	}

	public Double getLimitDebt() {
		return limitDebt;
	}

	public void setLimitDebt(Double limitDebt) {
		this.limitDebt = limitDebt;
	}

	public Double getAvailable() {
		return available;
	}

	public void setAvailable(Double available) {
		this.available = available;
	}

}
