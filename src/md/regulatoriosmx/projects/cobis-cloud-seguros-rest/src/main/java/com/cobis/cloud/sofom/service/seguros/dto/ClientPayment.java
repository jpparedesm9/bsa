package com.cobis.cloud.sofom.service.seguros.dto;

import java.math.BigDecimal;

public class ClientPayment {
private Integer idClient;
private BigDecimal payment;
public Integer getIdClient() {
	return idClient;
}
public void setIdClient(Integer idClient) {
	this.idClient = idClient;
}

public BigDecimal getPayment() {
	return payment;
}
public void setPayment(BigDecimal payment) {
	this.payment = payment;
}
@Override
public String toString() {
	return "ClientPayment [idClient=" + idClient + ", payment=" + payment + "]";
}


}
