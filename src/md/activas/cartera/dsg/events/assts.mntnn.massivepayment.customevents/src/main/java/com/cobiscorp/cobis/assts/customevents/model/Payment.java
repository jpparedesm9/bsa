package com.cobiscorp.cobis.assts.customevents.model;

public class Payment {
	private int rowNumber;
	private String amount;
	private String paymentDate;
	private String internalCode;
	private String reference;
	private String paymentMethod;
	
	
	public Payment() {
		super();
	}

	public Payment(int rowNumber, String amount, String paymentDate, String internalCode,String reference,String paymentMethod) {
		super();
		this.rowNumber = rowNumber;
		this.amount = amount;
		this.paymentDate = paymentDate;
		this.internalCode = internalCode;
		this.reference=reference;
		this.paymentMethod = paymentMethod;
		
	}
	
	
	
	public String getPaymentMethod() {
		return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
		this.paymentMethod = paymentMethod;
	}

	public String getReference() {
		return reference;
	}

	public void setReference(String reference) {
		this.reference = reference;
	}

	public int getRowNumber() {
		return rowNumber;
	}
	public void setRowNumber(int rowNumber) {
		this.rowNumber = rowNumber;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public String getInternalCode() {
		return internalCode;
	}
	public void setInternalCode(String internalCode) {
		this.internalCode = internalCode;
	}

	@Override
	public String toString() {
		return "Payment [rowNumber=" + rowNumber + ", amount=" + amount + ", paymentDate=" + paymentDate
				+ ", internalCode=" + internalCode + ", reference=" + reference + ", paymentMethod=" + paymentMethod
				+ "]";
	}

	

	
	
}
