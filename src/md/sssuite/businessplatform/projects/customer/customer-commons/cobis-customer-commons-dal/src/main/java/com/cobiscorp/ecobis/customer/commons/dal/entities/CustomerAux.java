package com.cobiscorp.ecobis.customer.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "cl_ente_aux", schema = "cobis")
/**
 * Class used to access the database using JPA
 * related table: cl_ente_aux, bdd: cobis
 * @author bbuendia
 *
 */
public class CustomerAux {

	@Id
	@Column(name = "ea_ente")
	private Integer clientAux;
	
	@Column(name = "ea_estado")
	private String status;

	@OneToOne(mappedBy = "customerAux")
	private Customer customer;

	@ManyToOne
	@JoinColumn(name = "ea_apoderado_legal", referencedColumnName = "en_ente")
	private Customer legalRepresentative;

	public CustomerAux() {
	}

	public CustomerAux(Integer clientAux) {
		this.clientAux = clientAux;

	}

	public Integer getClientAux() {
		return clientAux;
	}

	public void setClientAux(Integer clientAux) {
		this.clientAux = clientAux;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public Customer getLegalRepresentative() {
		return legalRepresentative;
	}

	public void setLegalRepresentative(Customer legalRepresentative) {
		this.legalRepresentative = legalRepresentative;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((clientAux == null) ? 0 : clientAux.hashCode());
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
		CustomerAux other = (CustomerAux) obj;
		if (clientAux == null) {
			if (other.clientAux != null)
				return false;
		} else if (!clientAux.equals(other.clientAux))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CustomerAux [clientAux=" + clientAux + ", status=" + status
				+ "]";
	}

}
