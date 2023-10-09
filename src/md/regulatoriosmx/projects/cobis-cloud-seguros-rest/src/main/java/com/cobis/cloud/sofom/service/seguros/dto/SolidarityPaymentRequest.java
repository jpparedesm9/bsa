package com.cobis.cloud.sofom.service.seguros.dto;

import java.math.BigDecimal;
import java.util.List;


public class SolidarityPaymentRequest {
	private String groupOperation;
	private List<ClientPayment> payments; 
    private BigDecimal totalValue; 
    private Integer paymentChannel;
    
	public String getGroupOperation() {
		return groupOperation;
	}
	public void setGroupOperation(String groupOperation) {
		this.groupOperation = groupOperation;
	}
	public List<ClientPayment> getPayments() {
		return payments;
	}
	public void setPayments(List<ClientPayment> payments) {
		this.payments = payments;
	}
	public BigDecimal getTotalValue() {
		return totalValue;
	}
	public void setTotalValue(BigDecimal totalValue) {
		this.totalValue = totalValue;
	}
	public Integer getPaymentChannel() {
		return paymentChannel;
	}
	public void setPaymentChannel(Integer paymentChannel) {
		this.paymentChannel = paymentChannel;
	}
	@Override
	public String toString() {
		return "SolidarityPaymentRequest [groupOperation=" + groupOperation + ", payments=" + payments + ", totalValue=" + totalValue + ", paymentChannel=" + paymentChannel + "]";
	}
    
    
    
}
