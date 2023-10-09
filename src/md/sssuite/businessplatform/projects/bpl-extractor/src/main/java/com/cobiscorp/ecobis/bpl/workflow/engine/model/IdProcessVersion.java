package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_version_proceso database table.
 * 
 */
@Embeddable
public class IdProcessVersion implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "vp_codigo_proceso")
	private Integer idProcess;

	@Column(name = "vp_version_proceso")
	private Short versionProcess;

	public IdProcessVersion() {
	}

	public IdProcessVersion(Integer idProcess, Short versionProcess) {
		super();
		this.idProcess = idProcess;
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the idProcess
	 */
	public Integer getIdProcess() {
		return idProcess;
	}

	/**
	 * @param idProcess
	 *            the idProcess to set
	 */
	public void setIdProcess(Integer idProcess) {
		this.idProcess = idProcess;
	}

	/**
	 * @return the versionProcess
	 */
	public Short getVersionProcess() {
		return versionProcess;
	}

	/**
	 * @param versionProcess
	 *            the versionProcess to set
	 */
	public void setVersionProcess(Short versionProcess) {
		this.versionProcess = versionProcess;
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
		result = prime * result + ((idProcess == null) ? 0 : idProcess.hashCode());
		result = prime * result + ((versionProcess == null) ? 0 : versionProcess.hashCode());
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
		IdProcessVersion other = (IdProcessVersion) obj;
		if (idProcess == null) {
			if (other.idProcess != null)
				return false;
		} else if (!idProcess.equals(other.idProcess))
			return false;
		if (versionProcess == null) {
			if (other.versionProcess != null)
				return false;
		} else if (!versionProcess.equals(other.versionProcess))
			return false;
		return true;
	}

}