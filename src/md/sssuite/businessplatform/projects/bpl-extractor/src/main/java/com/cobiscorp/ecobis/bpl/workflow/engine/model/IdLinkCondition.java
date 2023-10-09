package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_cond_enlace_proc database table.
 * 
 */
@Embeddable
public class IdLinkCondition implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "ce_id_enlace")
	private Integer idLink;

	public IdLinkCondition() {

	}

	public IdLinkCondition(Integer idLink) {
		super();
		this.idLink = idLink;
	}

	/**
	 * @return the idLink
	 */
	public Integer getIdLink() {
		return idLink;
	}

	/**
	 * @param idLink
	 *            the idLink to set
	 */
	public void setIdLink(Integer idLink) {
		this.idLink = idLink;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object other) {
		if (this == other) {
			return true;
		}
		if (!(other instanceof IdLinkCondition)) {
			return false;
		}
		IdLinkCondition castOther = (IdLinkCondition) other;
		return (this.idLink.compareTo(castOther.idLink) == 0);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.idLink.intValue();

		return hash;
	}

}