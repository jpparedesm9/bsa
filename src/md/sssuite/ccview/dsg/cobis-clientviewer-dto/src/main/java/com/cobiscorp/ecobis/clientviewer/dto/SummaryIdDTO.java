package com.cobiscorp.ecobis.clientviewer.dto;

/**
 * DTO which is used in the method getQueryConsolidatedPosition
 * @author bbuendia
 *
 */
public class SummaryIdDTO {

	private Integer customer;
	private String user;
	private Integer sequence;

	public SummaryIdDTO() {
	}

	public SummaryIdDTO(Integer customer, String user, Integer sequence) {
		super();
		this.customer = customer;
		this.user = user;
		this.sequence = sequence;
	}

	public Integer getCustomer() {
		return customer;
	}

	public void setCustomer(Integer customer) {
		this.customer = customer;
	}

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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((customer == null) ? 0 : customer.hashCode());
		result = prime * result
				+ ((sequence == null) ? 0 : sequence.hashCode());
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		return false;
	}

	@Override
	public String toString() {
		return "SummaryIdDTO [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + "]";
	}
}
