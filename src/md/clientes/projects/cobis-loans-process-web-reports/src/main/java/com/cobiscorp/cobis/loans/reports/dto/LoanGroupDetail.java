package com.cobiscorp.cobis.loans.reports.dto;

import java.math.BigDecimal;

public class LoanGroupDetail {
	private Integer sequential;
	private Integer customerId;
	private String role;
	private String customerName;
	private String cicle;
	private BigDecimal requestAmount;
	private BigDecimal authorizedAmount;
	private BigDecimal voluntarySaving;
	public Integer getSequential() {
		return sequential;
	}
	public void setSequential(Integer sequential) {
		this.sequential = sequential;
	}
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCicle() {
		return cicle;
	}
	public void setCicle(String cicle) {
		this.cicle = cicle;
	}
	public BigDecimal getRequestAmount() {
		return requestAmount;
	}
	public void setRequestAmount(BigDecimal requestAmount) {
		this.requestAmount = requestAmount;
	}
	public BigDecimal getAuthorizedAmount() {
		return authorizedAmount;
	}
	public void setAuthorizedAmount(BigDecimal authorizedAmount) {
		this.authorizedAmount = authorizedAmount;
	}
	public BigDecimal getVoluntarySaving() {
		return voluntarySaving;
	}
	public void setVoluntarySaving(BigDecimal voluntarySaving) {
		this.voluntarySaving = voluntarySaving;
	}
	
	
}
