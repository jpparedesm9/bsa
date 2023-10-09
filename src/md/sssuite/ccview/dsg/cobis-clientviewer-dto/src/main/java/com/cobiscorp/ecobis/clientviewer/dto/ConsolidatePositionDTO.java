package com.cobiscorp.ecobis.clientviewer.dto;

import java.util.Date;

import com.google.common.primitives.Doubles;

/**
 * DTO that obtains query consolidated position by customer
 * 
 * @author bbuendia
 * 
 */
public class ConsolidatePositionDTO {

	private String type;
	private String product;
	private String name;
	private Double amount;
	private String number;
	private String status;
	private Date cancellation;
	private String office;
	private Double avaliable;
	private String tradeMark;

	public ConsolidatePositionDTO() {

	}

	public ConsolidatePositionDTO(String type, String product, String name,
			Double amount, String number, String status, Date cancellation,
			String office) {
		this.type = type;
		this.product = product;
		this.name = name;
		this.amount = amount;
		this.number = number;
		this.status = status;
		this.cancellation = cancellation;
		this.office = office;
	}

	public ConsolidatePositionDTO(String type, String product, String name,
			Double amount, String number, String status) {
		this.type = type;
		this.product = product;
		this.name = name;
		this.amount = amount;
		this.number = number;
		this.status = status;
	}

	public ConsolidatePositionDTO(String type, String product, String name,
			Double amount, String number, String status, Double avaliable, String tradeMark) {
		this.type = type;
		this.product = product;
		this.name = name;
		this.amount = amount;
		this.number = number;
		this.status = status;
		this.avaliable = avaliable;
		this.tradeMark = tradeMark;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Double getAmount() {
		return amount;
	}

	public void setAmount(Double amount) {
		this.amount = amount;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Date getCancellation() {
		return cancellation;
	}

	public void setCancellation(Date cancellation) {
		this.cancellation = cancellation;
	}

	public String getOffice() {
		return office;
	}

	public void setOffice(String office) {
		this.office = office;
	}

	public Double getAvaliable() {
		return avaliable;
	}

	public void setAvaliable(Double avaliable) {
		this.avaliable = avaliable;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((amount == null) ? 0 : amount.hashCode());
		result = prime * result + ((name == null) ? 0 : name.hashCode());
		result = prime * result + ((number == null) ? 0 : number.hashCode());
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((status == null) ? 0 : status.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		result = prime * result
				+ ((cancellation == null) ? 0 : cancellation.hashCode());
		result = prime * result + ((office == null) ? 0 : office.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ConsolidatePositionDTO other = (ConsolidatePositionDTO) obj;
		if (amount == null) {
			if (other.amount != null)
				return false;
		} else if (!amount.equals(other.amount))
			return false;
		if (name == null) {
			if (other.name != null)
				return false;
		} else if (!name.equals(other.name))
			return false;
		if (number == null) {
			if (other.number != null)
				return false;
		} else if (!number.equals(other.number))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (status == null) {
			if (other.status != null)
				return false;
		} else if (!status.equals(other.status))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		if (cancellation == null) {
			if (other.cancellation != null)
				return false;
		} else if (!cancellation.equals(other.cancellation))
			return false;
		if (office == null) {
			if (other.office != null)
				return false;
		} else if (!office.equals(other.office))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "ConsolidatePositionDTO [type=" + type + ", product=" + product
				+ ", name=" + name + ", amount=" + amount + ", number="
				+ number + ", status=" + status + ", cancellation="
				+ cancellation + ", office=" + office + "]";
	}

	public String getTradeMark() {
		return tradeMark;
	}

	public void setTradeMark(String tradeMark) {
		this.tradeMark = tradeMark;
	}

}
