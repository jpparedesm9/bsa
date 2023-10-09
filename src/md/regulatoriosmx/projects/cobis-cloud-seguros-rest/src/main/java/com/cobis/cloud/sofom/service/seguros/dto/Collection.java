package com.cobis.cloud.sofom.service.seguros.dto;

import java.math.BigDecimal;

public class Collection {

    private Integer paymentNumber;
    private String paymentDate;
    private BigDecimal paymentAmount;

    public Integer getPaymentNumber() {
	return paymentNumber;
    }

    public void setPaymentNumber(Integer paymentNumber) {
	this.paymentNumber = paymentNumber;
    }

    public BigDecimal getPaymentAmount() {
	return paymentAmount;
    }

    public String getPaymentDate() {
	return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
	this.paymentDate = paymentDate;
    }

    public void setPaymentAmount(BigDecimal paymentAmount) {
	this.paymentAmount = paymentAmount;
    }

    @Override
    public String toString() {
	return "Collection [paymentNumber=" + paymentNumber + ", paymentDate=" + paymentDate + ", paymentAmount=" + paymentAmount + "]";
    }

}
