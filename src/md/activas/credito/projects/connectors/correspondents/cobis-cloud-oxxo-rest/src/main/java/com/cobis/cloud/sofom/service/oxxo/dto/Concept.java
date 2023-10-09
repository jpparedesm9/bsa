package com.cobis.cloud.sofom.service.oxxo.dto;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

@XmlRootElement
@XmlType(propOrder = { "description", "amount", "operation"})
public class Concept {
	private String description;
	private Integer amount;
	private String operation;
	
	public Integer getAmount() {
		return amount;
	}

	public void setAmount(Integer amount) {
		this.amount = amount;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getOperation() {
		return operation;
	}

	public void setOperation(String operation) {
		this.operation = operation;
	}

	@Override
	public String toString() {
		return "Concept [description=" + description + ", amount=" + amount
				+ ", operation=" + operation + "]";
	}
	
	

}
