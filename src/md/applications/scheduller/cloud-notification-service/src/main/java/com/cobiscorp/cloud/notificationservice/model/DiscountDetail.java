package com.cobiscorp.cloud.notificationservice.model;

import java.math.BigDecimal;

public class DiscountDetail {
	private String customerName;
	private BigDecimal amount;
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	@Override
	public String toString() {
		return "DiscountDetail [customerName=" + customerName + ", amount=" + amount + "]";
	}
	
	
}
