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
 * The persistent class for the wf_tipo_proceso database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_proceso", schema = "cob_workflow")
public class ProcessType implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdProcessType idProcessType;

	@Column(name = "tp_tipo_proceso")
	private String processType;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tp_codigo_proceso", referencedColumnName = "pr_codigo_proceso")
	private Process process;

	public ProcessType() {

	}
	
	

	/**
	 * @return the idProcessType
	 */
	public IdProcessType getIdProcessType() {
		return idProcessType;
	}

	/**
	 * @param idProcessType
	 *            the idProcessType to set
	 */
	public void setIdProcessType(IdProcessType idProcessType) {
		this.idProcessType = idProcessType;
	}

	/**
	 * @return the process
	 */
	public Process getProcess() {
		return process;
	}

	/**
	 * @param process
	 *            the process to set
	 */
	public void setProcess(Process process) {
		this.process = process;
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
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idProcessType == null) ? 0 : idProcessType.hashCode());
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
		ProcessType other = (ProcessType) obj;
		if (idProcessType == null) {
			if (other.idProcessType != null)
				return false;
		} else if (!idProcessType.equals(other.idProcessType))
			return false;
		return true;
	}

}