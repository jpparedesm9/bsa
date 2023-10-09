package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@IdClass(TranOperationId.class)
@Table(name = "ca_trn_oper", schema = "cob_cartera")
@NamedQueries({ @NamedQuery(name = "TranOperation.findAllByOperation", query = "select to from  TranOperation to where to.operation=:operation") })
public class TranOperation {

	/** Banking Product Id. */
	@Id
	@Column(name = "to_toperacion")
	private String operation;
	/** TransactionType Id. */
	@Id
	@Column(name = "to_tipo_trn")
	private String type;
	/** Profile Id. */
	@Column(name = "to_perfil")
	private String profile;
	/** Filial Id. */
	// @Id
	// @Column(name = "to_filial")
	@Transient
	private Integer filial;

	/**
	 * Default Constructor.
	 */
	public TranOperation() {
	}

	/**
	 * Constructor
	 * 
	 * @param operation
	 * @param type
	 * @param profile
	 * @param filial
	 */
	public TranOperation(String operation, String type, String profile, Integer filial) {
		this.operation = operation;
		this.type = type;
		this.profile = profile;
		this.filial = filial;
	}

	/**
	 * Get Operation
	 * 
	 * @return the operation
	 */
	public String getOperation() {
		return operation;
	}

	/**
	 * Set Operation
	 * 
	 * @param operation
	 *            the operation to set
	 */
	public void setOperation(String operation) {
		this.operation = operation;
	}

	/**
	 * Get Type
	 * 
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * Set Type
	 * 
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * Get Profile
	 * 
	 * @return the profile
	 */
	public String getProfile() {
		return profile;
	}

	/**
	 * Set Profile
	 * 
	 * @param profile
	 *            the profile to set
	 */
	public void setProfile(String profile) {
		this.profile = profile;
	}

	/**
	 * Get Filial
	 * 
	 * @return the filial
	 */
	public Integer getFilial() {
		return filial;
	}

	/**
	 * Set Filial
	 * 
	 * @param filial
	 *            the filial to set
	 */
	public void setFilial(Integer filial) {
		this.filial = filial;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((operation == null) ? 0 : operation.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
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
		TranOperation other = (TranOperation) obj;
		if (operation == null) {
			if (other.operation != null)
				return false;
		} else if (!operation.equals(other.operation))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}

	public String toString() {
		return "TranOperation [operation=" + operation + ", type=" + type + ", profile=" + profile + ", filial=" + filial + "]";
	}

}
