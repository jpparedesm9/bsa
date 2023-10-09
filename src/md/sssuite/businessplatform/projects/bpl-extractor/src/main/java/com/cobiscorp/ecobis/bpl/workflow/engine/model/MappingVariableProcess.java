package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

/**
 * The persistent class for the wf_mapeo_var_proc database table.
 * 
 */
@Entity
@Table(name = "wf_mapeo_var_proc", schema = "cob_workflow")
public class MappingVariableProcess implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdMappingVariableProcess idMappingVariableProcess;

	@Column(name = "mp_codigo_proceso")
	private Integer idProcess;

	@Column(name = "mp_version_proceso")
	private Short versionProcess;

	@Column(name = "mp_tipo_mapeo_paso")
	private String mappingStepType;

	@Column(name = "mp_cod_proc_hijo")
	private Integer idChildProcess;

	@Column(name = "mp_ver_proc_hijo")
	private Short childVersionProcess;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mp_cod_var_hijo")
	private Variable childVariable;

	@Column(name = "mp_tipo_mapeo_var")
	private String mappingVariableType;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "mp_codigo_variable", referencedColumnName = "vb_codigo_variable")
	private Variable variable;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "mp_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "mp_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	public MappingVariableProcess() {

	}

	/**
	 * @return the idMappingVariableProcess
	 */
	public IdMappingVariableProcess getIdMappingVariableProcess() {
		return idMappingVariableProcess;
	}

	/**
	 * @param idMappingVariableProcess
	 *            the idMappingVariableProcess to set
	 */
	public void setIdMappingVariableProcess(IdMappingVariableProcess idMappingVariableProcess) {
		this.idMappingVariableProcess = idMappingVariableProcess;
	}

	/**
	 * @return the idChildProcess
	 */
	public Integer getIdChildProcess() {
		return idChildProcess;
	}

	/**
	 * @param idChildProcess
	 *            the idChildProcess to set
	 */
	public void setIdChildProcess(Integer idChildProcess) {
		this.idChildProcess = idChildProcess;
	}

	/**
	 * @return the childVersionProcess
	 */
	public Short getChildVersionProcess() {
		return childVersionProcess;
	}

	/**
	 * @param childVersionProcess
	 *            the childVersionProcess to set
	 */
	public void setChildVersionProcess(Short childVersionProcess) {
		this.childVersionProcess = childVersionProcess;
	}

	/**
	 * @return the childVariable
	 */
	public Variable getChildVariable() {
		return childVariable;
	}

	/**
	 * @param childVariable
	 *            the childVariable to set
	 */
	public void setChildVariable(Variable childVariable) {
		this.childVariable = childVariable;
	}

	/**
	 * @return the variable
	 */
	public Variable getVariable() {
		return variable;
	}

	/**
	 * @param variable
	 *            the variable to set
	 */
	public void setVariable(Variable variable) {
		this.variable = variable;
	}

	/**
	 * @return the processVersion
	 */
	public ProcessVersion getProcessVersion() {
		return processVersion;
	}

	/**
	 * @param processVersion
	 *            the processVersion to set
	 */
	public void setProcessVersion(ProcessVersion processVersion) {
		this.processVersion = processVersion;
	}

	/**
	 * @return the mappingVariableType
	 */
	public String getMappingVariableType() {
		return mappingVariableType;
	}

	/**
	 * @param mappingVariableType
	 *            the mappingVariableType to set
	 */
	public void setMappingVariableType(String mappingVariableType) {
		this.mappingVariableType = mappingVariableType;
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
		result = prime * result + ((idMappingVariableProcess == null) ? 0 : idMappingVariableProcess.hashCode());
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
		MappingVariableProcess other = (MappingVariableProcess) obj;
		if (idMappingVariableProcess == null) {
			if (other.idMappingVariableProcess != null)
				return false;
		} else if (!idMappingVariableProcess.equals(other.idMappingVariableProcess))
			return false;
		return true;
	}

}