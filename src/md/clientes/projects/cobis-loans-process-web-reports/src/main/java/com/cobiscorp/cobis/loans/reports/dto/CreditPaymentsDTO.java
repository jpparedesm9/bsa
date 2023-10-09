package com.cobiscorp.cobis.loans.reports.dto;


public class CreditPaymentsDTO {
	private Integer numberSeq;
	private String amount;

	private String dueDate;
	public Integer getNumberSeq() {
		return numberSeq;
	}
	public void setNumberSeq(Integer numberSeq) {
		this.numberSeq = numberSeq;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getDueDate() {
		return dueDate;
	}
	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}
	
	
}