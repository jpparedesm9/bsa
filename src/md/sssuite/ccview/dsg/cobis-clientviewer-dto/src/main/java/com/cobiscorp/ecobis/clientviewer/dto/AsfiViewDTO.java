package com.cobiscorp.ecobis.clientviewer.dto;

import java.math.BigDecimal;

public class AsfiViewDTO {

	private String branchDepartCod;
	private String entityCode;
	private String obligatedCode;
	private String correlativeNumber;
	private Integer ente;
	private BigDecimal badDebtBalance;
	private BigDecimal contingentDebtBalance;
	private BigDecimal executionDebtBalance;
	private BigDecimal expiredDebtBalance;
	private BigDecimal currentDebtBalance;
	private BigDecimal totalBalance;
	private String debtType;
	private String calificacion;

	public AsfiViewDTO(String branchDepartCod, String entityCode,
			String obligatedCode, String correlativeNumber, Integer ente,
			BigDecimal badDebtBalance, BigDecimal contingentDebtBalance,
			BigDecimal executionDebtBalance, BigDecimal expiredDebtBalance,
			BigDecimal currentDebtBalance, BigDecimal totalBalance,
			String debtType, String calificacion) {
		this.branchDepartCod = branchDepartCod;
		this.entityCode = entityCode;
		this.obligatedCode = obligatedCode;
		this.correlativeNumber = correlativeNumber;
		this.ente = ente;
		this.badDebtBalance = badDebtBalance;
		this.contingentDebtBalance = contingentDebtBalance;
		this.executionDebtBalance = executionDebtBalance;
		this.expiredDebtBalance = expiredDebtBalance;
		this.currentDebtBalance = currentDebtBalance;
		this.totalBalance = totalBalance;
		this.debtType = debtType;
		this.calificacion = calificacion;
	}

	public String getBranchDepartCod() {
		return branchDepartCod;
	}

	public void setBranchDepartCod(String branchDepartCod) {
		this.branchDepartCod = branchDepartCod;
	}

	public String getEntityCode() {
		return entityCode;
	}

	public void setEntityCode(String entityCode) {
		this.entityCode = entityCode;
	}

	public String getObligatedCode() {
		return obligatedCode;
	}

	public void setObligatedCode(String obligatedCode) {
		this.obligatedCode = obligatedCode;
	}

	public String getCorrelativeNumber() {
		return correlativeNumber;
	}

	public void setCorrelativeNumber(String correlativeNumber) {
		this.correlativeNumber = correlativeNumber;
	}

	public Integer getEnte() {
		return ente;
	}

	public void setEnte(Integer ente) {
		this.ente = ente;
	}

	public BigDecimal getBadDebtBalance() {
		return badDebtBalance;
	}

	public void setBadDebtBalance(BigDecimal badDebtBalance) {
		this.badDebtBalance = badDebtBalance;
	}

	public BigDecimal getContingentDebtBalance() {
		return contingentDebtBalance;
	}

	public void setContingentDebtBalance(BigDecimal contingentDebtBalance) {
		this.contingentDebtBalance = contingentDebtBalance;
	}

	public BigDecimal getExecutionDebtBalance() {
		return executionDebtBalance;
	}

	public void setExecutionDebtBalance(BigDecimal executionDebtBalance) {
		this.executionDebtBalance = executionDebtBalance;
	}

	public BigDecimal getExpiredDebtBalance() {
		return expiredDebtBalance;
	}

	public void setExpiredDebtBalance(BigDecimal expiredDebtBalance) {
		this.expiredDebtBalance = expiredDebtBalance;
	}

	public BigDecimal getCurrentDebtBalance() {
		return currentDebtBalance;
	}

	public void setCurrentDebtBalance(BigDecimal currentDebtBalance) {
		this.currentDebtBalance = currentDebtBalance;
	}

	public BigDecimal getTotalBalance() {
		return totalBalance;
	}

	public void setTotalBalance(BigDecimal totalBalance) {
		this.totalBalance = totalBalance;
	}

	public String getDebtType() {
		return debtType;
	}

	public void setDebtType(String debtType) {
		this.debtType = debtType;
	}

	public String getCalificacion() {
		return calificacion;
	}

	public void setCalificacion(String calificacion) {
		this.calificacion = calificacion;
	}

}