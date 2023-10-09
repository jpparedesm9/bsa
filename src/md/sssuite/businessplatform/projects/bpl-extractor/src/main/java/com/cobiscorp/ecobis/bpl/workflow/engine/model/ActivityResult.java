package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_resultado_actividad database table.
 * 
 */
@Entity
@Table(name = "wf_resultado_actividad", schema = "cob_workflow")
public class ActivityResult implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdActivityResult idActivityResult;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ra_codigo_resultado", referencedColumnName = "rs_codigo_resultado", insertable = false, updatable = false)
	private Result result;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ra_id_paso", insertable = false, updatable = false)
	private Step step;

	@Column(name = "ra_codigo_proceso")
	private Integer idProcess;

	@Column(name = "ra_version_proceso")
	private Short versionProcess;

	public ActivityResult() {

	}

	public ActivityResult(Integer idProcess, Short versionProcess) {
		super();
		this.idProcess = idProcess;
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the idActivityResult
	 */
	public IdActivityResult getIdActivityResult() {
		return idActivityResult;
	}

	/**
	 * @param idActivityResult
	 *            the idActivityResult to set
	 */
	public void setIdActivityResult(IdActivityResult idActivityResult) {
		this.idActivityResult = idActivityResult;
	}

	/**
	 * @return the result
	 */
	public Result getResult() {
		return result;
	}

	/**
	 * @param result
	 *            the result to set
	 */
	public void setResult(Result result) {
		this.result = result;
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

	public Integer getIdProcess() {
		return idProcess;
	}

	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	public Short getVersionProcess() {
		return versionProcess;
	}

	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idActivityResult == null) ? 0 : idActivityResult.hashCode());
		result = prime * result + ((idProcess == null) ? 0 : idProcess.hashCode());
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
		ActivityResult other = (ActivityResult) obj;
		if (idActivityResult == null) {
			if (other.idActivityResult != null)
				return false;
		} else if (!idActivityResult.equals(other.idActivityResult))
			return false;
		if (idProcess == null) {
			if (other.idProcess != null)
				return false;
		} else if (!idProcess.equals(other.idProcess))
			return false;
		return true;
	}

}