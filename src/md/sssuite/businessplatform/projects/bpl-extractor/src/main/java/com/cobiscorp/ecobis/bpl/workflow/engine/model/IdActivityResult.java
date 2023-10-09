package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_resultado_actividad database table.
 * 
 */
@Embeddable
public class IdActivityResult implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "ra_codigo_resultado")
	private Integer idResult;

	@Column(name = "ra_id_paso")
	private Integer idStep;

	public IdActivityResult() {

	}

	public IdActivityResult(Integer idResult, Integer idStep) {
		super();
		this.idResult = idResult;
		this.idStep = idStep;
	}

	/**
	 * @return the idResult
	 */
	public Integer getIdResult() {
		return idResult;
	}

	/**
	 * @param idResult
	 *            the idResult to set
	 */
	public void setIdResult(Integer idResult) {
		this.idResult = idResult;
	}

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
		result = prime * result + ((idResult == null) ? 0 : idResult.hashCode());
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
		IdActivityResult other = (IdActivityResult) obj;
		if (idResult == null) {
			if (other.idResult != null)
				return false;
		} else if (!idResult.equals(other.idResult))
			return false;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}

}