package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_destinatario database table.
 * 
 */
@Embeddable
public class IdAddressee implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "de_codigo_actividad")
	private Integer idActivity;

	@Column(name = "de_codigo_proceso")
	private Integer idProcess;

	@Column(name = "de_version_proceso")
	private Short versionProcess;

	public IdAddressee() {

	}

	public IdAddressee(Integer idProcess, Short versionProcess, Integer idActivity) {
		super();
		this.idActivity = idActivity;
		this.idProcess = idProcess;
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the idActivity
	 */
	public Integer getIdActivity() {
		return idActivity;
	}

	/**
	 * @param idActivity
	 *            the idActivity to set
	 */
	public void setIdActivity(Integer idActivity) {
		this.idActivity = idActivity;
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
		result = prime * result + ((idActivity == null) ? 0 : idActivity.hashCode());
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
		IdAddressee other = (IdAddressee) obj;
		if (idActivity == null) {
			if (other.idActivity != null)
				return false;
		} else if (!idActivity.equals(other.idActivity))
			return false;
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