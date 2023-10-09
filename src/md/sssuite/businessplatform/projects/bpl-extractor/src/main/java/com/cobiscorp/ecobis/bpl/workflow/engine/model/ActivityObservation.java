package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cobiscorp.ecobis.bpl.cobis.engine.model.Catalog;

/**
 * The persistent class for the wf_observacion_actividad database table.
 * 
 */
@Entity
@Table(name = "wf_observacion_actividad", schema = "cob_workflow")
public class ActivityObservation implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdActivityObservation idActivityObservation;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "oa_codigo_observacion", referencedColumnName = "codigo", insertable = false, updatable = false)
	private Catalog catalog;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "oa_id_paso", insertable = false, updatable = false)
	private Step step;

	public ActivityObservation() {

	}

	/**
	 * @return the catalog
	 */
	public Catalog getCatalog() {
		return catalog;
	}

	/**
	 * @param catalog
	 *            the catalog to set
	 */
	public void setCatalog(Catalog catalog) {
		this.catalog = catalog;
	}

	/**
	 * @return the step
	 */
	public Step getStep() {
		return step;
	}

	/**
	 * @param step
	 *            the step to set
	 */
	public void setStep(Step step) {
		this.step = step;
	}

	/**
	 * @return the idActivityObservation
	 */
	public IdActivityObservation getIdActivityObservation() {
		return idActivityObservation;
	}

	/**
	 * @param idActivityObservation
	 *            the idActivityObservation to set
	 */
	public void setIdActivityObservation(IdActivityObservation idActivityObservation) {
		this.idActivityObservation = idActivityObservation;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idActivityObservation == null) ? 0 : idActivityObservation.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ActivityObservation other = (ActivityObservation) obj;
		if (idActivityObservation == null) {
			if (other.idActivityObservation != null)
				return false;
		} else if (!idActivityObservation.equals(other.idActivityObservation))
			return false;
		return true;
	}

}