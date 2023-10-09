package com.cobiscorp.ecobis.clientviewer.dto;

/**
 * DTO that obtains Summary Personal Warranties
 * @author bbuendia
 *
 */
public class SummaryPersonalWarrantiesDTO {

	private String user;
	private Integer sequence;
	private Integer customer;
	private String state;
	private String product;
	private String descriptionWarranty;
	private Double currentLocalCurrency;
	private String code;

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Integer getSequence() {
		return sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDescriptionWarranty() {
		return descriptionWarranty;
	}

	public void setDescriptionWarranty(String descriptionWarranty) {
		this.descriptionWarranty = descriptionWarranty;
	}

	public Double getCurrentLocalCurrency() {
		return currentLocalCurrency;
	}

	public void setCurrentLocalCurrency(Double currentLocalCurrency) {
		this.currentLocalCurrency = currentLocalCurrency;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public SummaryPersonalWarrantiesDTO() {

	}

	public SummaryPersonalWarrantiesDTO(String user, Integer sequence,
			Integer customer, String state, String product,
			String descriptionWarranty, Double currentLocalCurrency, String code) {
		this.user = user;
		this.sequence = sequence;
		this.customer = customer;
		this.state = state;
		this.product = product;
		this.descriptionWarranty = descriptionWarranty;
		this.currentLocalCurrency = currentLocalCurrency;
		this.code = code;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + customer;
		result = prime * result + sequence;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		SummaryPersonalWarrantiesDTO other = (SummaryPersonalWarrantiesDTO) obj;
		if (customer != other.customer)
			return false;
		if (sequence != other.sequence)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "SummaryPersonalWarranties [user=" + user + ", sequence="
				+ sequence + ", customer=" + customer + ", state=" + state
				+ ", product=" + product + ", descriptionWarranty="
				+ descriptionWarranty + ", currentLocalCurrency="
				+ currentLocalCurrency + ", code=" + code + "]";
	}

}
