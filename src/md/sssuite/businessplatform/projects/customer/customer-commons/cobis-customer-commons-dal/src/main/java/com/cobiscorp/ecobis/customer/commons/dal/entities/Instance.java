package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name = "cl_instancia", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "Instance.findCustomerCouple", query = "SELECT new com.cobiscorp.ecobis.customer.commons.dal.entities.Instance(cd.fullName,r.description) FROM Instance i INNER JOIN i.relation r INNER JOIN i.customerLeft  cl INNER JOIN i.customerRight cd WHERE cl.code = :customerCode ") })
public class Instance {

	@Column(name = "in_ente_i")
	private Integer idRelation;

	@ManyToOne
	@JoinColumn(name = "in_relacion", referencedColumnName = "re_relacion")
	private Relation relation;

	@Column(name = "in_ente_i")
	private Integer idCustomerLeft;

	@ManyToOne
	@JoinColumn(name = "in_ente_i", referencedColumnName = "en_ente")
	private Customer customerLeft;

	@Column(name = "in_ente_d")
	private Integer idCustomerRight;

	@ManyToOne
	@JoinColumn(name = "in_ente_d", referencedColumnName = "en_ente")
	private Customer customerRight;

	@Column(name = "in_lado")
	private String side;

	@Column(name = "in_fecha")
	private Date date;

	@Transient
	private String fullNameCouple;

	@Transient
	private String relationName;

	public Instance() {
	}

	public Instance(String fullNameCouple, String relationName) {
		this.fullNameCouple = fullNameCouple;
		this.relationName = relationName;
	}

	/**
	 * @return the idCustomerLeft
	 */
	public Integer getIdCustomerLeft() {
		return idCustomerLeft;
	}

	/**
	 * @param idCustomerLeft
	 *            the idCustomerLeft to set
	 */
	public void setIdCustomerLeft(Integer idCustomerLeft) {
		this.idCustomerLeft = idCustomerLeft;
	}

	/**
	 * @return the customerLeft
	 */
	public Customer getCustomerLeft() {
		return customerLeft;
	}

	/**
	 * @param customerLeft
	 *            the customerLeft to set
	 */
	public void setCustomerLeft(Customer customerLeft) {
		this.customerLeft = customerLeft;
	}

	/**
	 * @return the idCustomerRight
	 */
	public Integer getIdCustomerRight() {
		return idCustomerRight;
	}

	/**
	 * @param idCustomerRight
	 *            the idCustomerRight to set
	 */
	public void setIdCustomerRight(Integer idCustomerRight) {
		this.idCustomerRight = idCustomerRight;
	}

	/**
	 * @return the customerRight
	 */
	public Customer getCustomerRight() {
		return customerRight;
	}

	/**
	 * @param customerRight
	 *            the customerRight to set
	 */
	public void setCustomerRight(Customer customerRight) {
		this.customerRight = customerRight;
	}

	/**
	 * @return the side
	 */
	public String getSide() {
		return side;
	}

	/**
	 * @param side
	 *            the side to set
	 */
	public void setSide(String side) {
		this.side = side;
	}

	/**
	 * @return the date
	 */
	public Date getDate() {
		return date;
	}

	/**
	 * @param date
	 *            the date to set
	 */
	public void setDate(Date date) {
		this.date = date;
	}

	/**
	 * @return the idRelation
	 */
	public Integer getIdRelation() {
		return idRelation;
	}

	/**
	 * @param idRelation
	 *            the idRelation to set
	 */
	public void setIdRelation(Integer idRelation) {
		this.idRelation = idRelation;
	}

	/**
	 * @return the relation
	 */
	public Relation getRelation() {
		return relation;
	}

	/**
	 * @param relation
	 *            the relation to set
	 */
	public void setRelation(Relation relation) {
		this.relation = relation;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idCustomerLeft == null) ? 0 : idCustomerLeft.hashCode());
		result = prime * result + ((idCustomerRight == null) ? 0 : idCustomerRight.hashCode());
		result = prime * result + ((idRelation == null) ? 0 : idRelation.hashCode());
		return result;
	}

	/**
	 * @return the fullNameCouple
	 */
	public String getFullNameCouple() {
		return fullNameCouple;
	}

	/**
	 * @param fullNameCouple
	 *            the fullNameCouple to set
	 */
	public void setFullNameCouple(String fullNameCouple) {
		this.fullNameCouple = fullNameCouple;
	}

	/**
	 * @return the relationName
	 */
	public String getRelationName() {
		return relationName;
	}

	/**
	 * @param relationName
	 *            the relationName to set
	 */
	public void setRelationName(String relationName) {
		this.relationName = relationName;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Instance other = (Instance) obj;
		if (idCustomerLeft == null) {
			if (other.idCustomerLeft != null)
				return false;
		} else if (!idCustomerLeft.equals(other.idCustomerLeft))
			return false;
		if (idCustomerRight == null) {
			if (other.idCustomerRight != null)
				return false;
		} else if (!idCustomerRight.equals(other.idCustomerRight))
			return false;
		if (idRelation == null) {
			if (other.idRelation != null)
				return false;
		} else if (!idRelation.equals(other.idRelation))
			return false;
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Instance [idRelation=" + idRelation + ", relation=" + relation + ", idCustomerLeft=" + idCustomerLeft + ", customerLeft="
				+ customerLeft + ", idCustomerRight=" + idCustomerRight + ", customerRight=" + customerRight + ", side=" + side + ", date=" + date
				+ "]";
	}

}
