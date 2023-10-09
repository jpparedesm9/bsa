package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_tipo_proceso database table.
 * 
 */
@Embeddable
public class IdProcessType implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "tp_codigo_proceso")
	private int idProcess;

	@Column(name = "tp_tipo_proceso")
	private String processType;

	public IdProcessType() {

	}

	public IdProcessType(int idProcess, String processType) {
		super();
		this.idProcess = idProcess;
		this.processType = processType;
	}

	/**
	 * @return the idProcess
	 */
	public int getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(int idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the processType
	 */
	public String getProcessType() {
		return processType;
	}

	/**
	 * @param processType
	 *            the processType to set
	 */
	public void setProcessType(String processType) {
		this.processType = processType;
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
		if (!(other instanceof IdProcessType)) {
			return false;
		}
		IdProcessType castOther = (IdProcessType) other;
		return (this.idProcess == castOther.idProcess) && this.processType.equals(castOther.processType);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int hash = 17;
		hash = hash * prime + this.idProcess;
		hash = hash * prime + this.processType.hashCode();

		return hash;
	}
}