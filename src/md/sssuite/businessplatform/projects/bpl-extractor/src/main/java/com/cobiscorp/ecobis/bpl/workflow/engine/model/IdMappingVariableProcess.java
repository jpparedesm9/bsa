package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The primary key class for the wf_mapeo_var_proc database table.
 * 
 */
@Embeddable
public class IdMappingVariableProcess implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name = "mp_codigo_proceso")
	private Integer idProcess;

	@Column(name = "mp_version_proceso")
	private Short versionProcess;

	@Column(name = "mp_codigo_variable")
	private Short idVariable;

	@Column(name = "mp_tipo_mapeo_paso")
	private String mappingStepType;

	public IdMappingVariableProcess() {

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

	/**
	 * @return the idVariable
	 */
	public Short getIdVariable() {
		return idVariable;
	}

	/**
	 * @param idVariable
	 *            the idVariable to set
	 */
	public void setIdVariable(Short idVariable) {
		this.idVariable = idVariable;
	}

	/**
	 * @return the mappingStepType
	 */
	public String getMappingStepType() {
		return mappingStepType;
	}

	/**
	 * @param mappingStepType
	 *            the mappingStepType to set
	 */
	public void setMappingStepType(String mappingStepType) {
		this.mappingStepType = mappingStepType;
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
		result = prime * result + ((idVariable == null) ? 0 : idVariable.hashCode());
		result = prime * result + ((mappingStepType == null) ? 0 : mappingStepType.hashCode());
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
		IdMappingVariableProcess other = (IdMappingVariableProcess) obj;
		if (idProcess == null) {
			if (other.idProcess != null)
				return false;
		} else if (!idProcess.equals(other.idProcess))
			return false;
		if (idVariable == null) {
			if (other.idVariable != null)
				return false;
		} else if (!idVariable.equals(other.idVariable))
			return false;
		if (mappingStepType == null) {
			if (other.mappingStepType != null)
				return false;
		} else if (!mappingStepType.equals(other.mappingStepType))
			return false;
		if (versionProcess == null) {
			if (other.versionProcess != null)
				return false;
		} else if (!versionProcess.equals(other.versionProcess))
			return false;
		return true;
	}

}