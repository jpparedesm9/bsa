package com.cobiscorp.ecobis.clientviewer.dto;

import java.util.Date;

public class ClienteCalificacionDTO {


	private Double scoreCustomer;
	private String customerType;
	private Integer idCustomer;
	private Date date;

	public ClienteCalificacionDTO(Double scoreCustomer, String customerType, Integer idCustomer, Date date) {
		super();
		this.scoreCustomer = scoreCustomer;
		this.customerType = customerType;
		this.idCustomer = idCustomer;
		this.date = date;
	}

	public Double getScoreCustomer() {
		return scoreCustomer;
	}

	public void setScoreCustomer(Double scoreCustomer) {
		this.scoreCustomer = scoreCustomer;
	}

	public String getCustomerType() {
		return customerType;
	}

	public void setCustomerType(String customerType) {
		this.customerType = customerType;
	}

	public Integer getIdCustomer() {
		return idCustomer;
	}

	public void setIdCustomer(Integer idCustomer) {
		this.idCustomer = idCustomer;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

}
