package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Embeddable;

/**
 * Class that contains primary keys: "sd_usuario", "sd_secuencia" and "sd_cliente"
 * from the table: cr_situacion_deudas
 * @author bbuendia
 *
 */
@Embeddable
public class SummaryId {

	private Integer customer;

	private String user;

	private Integer sequence;

	/** Default constructor */
	public SummaryId() {

	}

	/** Constructor */
	public SummaryId(Integer customer, String user, Integer sequence) {
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
		result = prime * result + customer;
		result = prime * result + sequence;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		/*if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		SummaryId other = (SummaryId) obj;
		if (customer != other.customer)
			return false;
		if (sequence != other.sequence)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;*/
		return false;
	}

	@Override
	public String toString() {
		return "SummaryId [customer=" + customer + ", user=" + user
				+ ", sequence=" + sequence + "]";
	}

	
}
