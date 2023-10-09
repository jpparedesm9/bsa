package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_observacion_actividad database table.
 * 
 */
@Embeddable
public class IdActivityObservation implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "oa_id_paso")
	private Integer idStep;

	@Column(name = "oa_codigo_observacion")
	private String idObservation;

	public IdActivityObservation() {
	}

	public IdActivityObservation(Integer idStep, String idObservation) {
		super();
		this.idStep = idStep;
		this.idObservation = idObservation;
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

	/**
	 * @return the idObservation
	 */
	public String getIdObservation() {
		return idObservation;
	}

	/**
	 * @param idObservation
	 *            the idObservation to set
	 */
	public void setIdObservation(String idObservation) {
		this.idObservation = idObservation;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idObservation == null) ? 0 : idObservation.hashCode());
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
		IdActivityObservation other = (IdActivityObservation) obj;
		if (idObservation == null) {
			if (other.idObservation != null)
				return false;
		} else if (!idObservation.equals(other.idObservation))
			return false;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}
}