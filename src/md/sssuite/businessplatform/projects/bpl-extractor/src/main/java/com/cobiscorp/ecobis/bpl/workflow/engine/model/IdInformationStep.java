package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_info_paso database table.
 * 
 */
@Embeddable
public class IdInformationStep implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "li_id_paso")
	private Integer idStep;

	/**
	 * @return the idStep
	 */
	public Integer getIdStep() {
		return idStep;
	}

	/**
	 * @param idStep
	 *            the idStep to set
	 */
	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
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
		result = prime * result + ((idStep == null) ? 0 : idStep.hashCode());
		return result;
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
		IdInformationStep other = (IdInformationStep) obj;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}

}