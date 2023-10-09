package com.cobiscorp.ecobis.clientviewer.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cr_situacion_gar", schema = "cob_credito")
@IdClass(SummaryId.class)
@NamedQueries({ @NamedQuery(name = "SummaryWarranties.getSummaryWarranties", query = "SELECT 'GARANTIAS', sg.product, sg.descriptionWarranty, sg.currentLocalCurrency, sg.code, sg.state"
		+ " FROM SummaryWarranties sg"
		+ " WHERE sg.user =: user"
		+ " AND (sg.customer =: customer OR :customer = 0)"
		+ " ANd sg.sequence =: sequence"
		+ " ANd sg.state IN ('V', 'F')") })
/**
 * Class used to access the database using JPA
 * related table: cr_situacion_gar bdd: cob_credito
 * @author bbuendia
 *
 */
public class SummaryWarranties {

	@Id
	@Column(name = "sg_usuario")
	private String user;

	@Id
	@Column(name = "sg_secuencia")
	private Integer sequence;

	@Id
	@Column(name = "sg_cliente")
	private Integer customer;

	@Column(name = "sg_estado")
	private String state;

	@Column(name = "sg_producto")
	private String product;

	@Column(name = "sg_desc_gar")
	private String descriptionWarranty;

	@Column(name = "sg_valor_act_ml")
	private Double currentLocalCurrency;

	@Column(name = "sg_codigo")
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

	public SummaryWarranties() {

	}

	public SummaryWarranties(String user, Integer sequence, Integer customer,
			String state, String product, String descriptionWarranty,
			Double currentLocalCurrency, String code) {
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
		SummaryWarranties other = (SummaryWarranties) obj;
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
		return "SummaryWarranties [user=" + user + ", sequence=" + sequence
				+ ", customer=" + customer + ", state=" + state + ", product="
				+ product + ", descriptionWarranty=" + descriptionWarranty
				+ ", currentLocalCurrency=" + currentLocalCurrency + ", code="
				+ code + "]";
	}

	/*
	 * public String getType() { if (this.product.equals("")) { return ""; }
	 * else { return ""; } }
	 * 
	 * public void setType(String type) {
	 * 
	 * 
	 * }
	 */
}
