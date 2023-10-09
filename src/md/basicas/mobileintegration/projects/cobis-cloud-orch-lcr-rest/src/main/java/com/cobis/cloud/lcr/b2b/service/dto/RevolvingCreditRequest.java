package com.cobis.cloud.lcr.b2b.service.dto;


public class RevolvingCreditRequest {
	private int customerCode;
	private String curp;
	private String paymentFrecuency;
	private int office;
	private int officer;
	private int processInstance;
	private int applicationCode;

	// Colectivos
	private String collectiveClientLevel;
	private Double monthlyIncome;

	public int getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(int customerCode) {
		this.customerCode = customerCode;
	}

	public String getPaymentFrecuency() {
		return paymentFrecuency;
	}

	public void setPaymentFrecuency(String paymentFrecuency) {
		this.paymentFrecuency = paymentFrecuency;
	}

	public int getOffice() {
		return office;
	}

	public void setOffice(int office) {
		this.office = office;
	}

	public int getOfficer() {
		return officer;
	}

	public void setOfficer(int officer) {
		this.officer = officer;
	}

	public String getCurp() {
		return curp;
	}

	public void setCurp(String curp) {
		this.curp = curp;
	}

	public int getProcessInstance() {
		return processInstance;
	}

	public void setProcessInstance(int processInstance) {
		this.processInstance = processInstance;
	}

	public int getApplicationCode() {
		return applicationCode;
	}

	public void setApplicationCode(int applicationCode) {
		this.applicationCode = applicationCode;
	}

	public String getCollectiveClientLevel() {
		return collectiveClientLevel;
	}

	public void setCollectiveClientLevel(String collectiveClientLevel) {
		this.collectiveClientLevel = collectiveClientLevel;
	}

	public Double getMonthlyIncome() {
		return monthlyIncome;
	}

	public void setMonthlyIncome(Double monthlyIncome) {
		this.monthlyIncome = monthlyIncome;
	}

}
