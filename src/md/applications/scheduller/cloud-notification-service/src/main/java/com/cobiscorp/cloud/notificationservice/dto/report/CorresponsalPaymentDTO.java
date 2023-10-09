package com.cobiscorp.cloud.notificationservice.dto.report;


import java.util.List;

import com.cobiscorp.cloud.notificationservice.dto.CorresponsalPayment;

public class CorresponsalPaymentDTO {
	
	CorresponsalPayment.Payment payment;
	List<CorresponsalPayment.Payment.Referencia> referencias;
	
	public CorresponsalPaymentDTO() {
	}
	public CorresponsalPaymentDTO(CorresponsalPayment.Payment payment, List<CorresponsalPayment.Payment.Referencia> referencias) {
		super();
		this.payment = payment;
		this.referencias = referencias;
	}
	public CorresponsalPayment.Payment getPayment() {
		return payment;
	}
	public void setPayment(CorresponsalPayment.Payment payment) {
		this.payment = payment;
	}
	public List<CorresponsalPayment.Payment.Referencia> getReferencias() {
		return referencias;
	}
	public void setReferencias(List<CorresponsalPayment.Payment.Referencia> referencias) {
		this.referencias = referencias;
	}

	
	

}
