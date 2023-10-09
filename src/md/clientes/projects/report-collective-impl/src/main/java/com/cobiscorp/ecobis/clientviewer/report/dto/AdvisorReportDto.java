package com.cobiscorp.ecobis.clientviewer.report.dto;

import java.io.Serializable;

public class AdvisorReportDto implements Serializable {
	String collective;
	String customerName;
	Integer customerId;
	String customerAddress;
	String customerCell;
	String email;
	String asesorExterno;

	public String getCollective() {
		return collective;
	}

	public void setCollective(String collective) {
		this.collective = collective;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public String getCustomerAddress() {
		return customerAddress;
	}

	public void setCustomerAddress(String customerAddress) {
		this.customerAddress = customerAddress;
	}

	public String getCustomerCell() {
		return customerCell;
	}

	public void setCustomerCell(String customerCell) {
		this.customerCell = customerCell;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAsesorExterno() {
		return asesorExterno;
	}

	public void setAsesorExterno(String asesorExterno) {
		this.asesorExterno = asesorExterno;
	}

}
