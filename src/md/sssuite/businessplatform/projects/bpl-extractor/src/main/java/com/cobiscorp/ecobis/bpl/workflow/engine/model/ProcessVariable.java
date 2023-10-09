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

import com.cobiscorp.ecobis.bpl.rules.engine.model.Programa;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Variable;

/**
 * The persistent class for the wf_variable_proceso database table.
 * 
 */
@Entity
@Table(name = "wf_variable_proceso", schema = "cob_workflow")
public class ProcessVariable implements Serializable {

	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdProcessVariable idProcessVariable;

	@Column(name = "vr_guardar_log")
	private byte saveLog;

	@Column(name = "vr_codigo_proceso")
	private Integer idProcess;

	@Column(name = "vr_version_proceso")
	private Short versionProcess;

	@Column(name = "vr_codigo_variable")
	private int idVariable;

	@Column(name = "vr_id_programa")
	private int idPrograma;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vr_codigo_variable", referencedColumnName = "vb_codigo_variable", insertable = false, updatable = false)
	private Variable variable;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vr_id_programa", insertable = false, updatable = false)
	private Programa program;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "vr_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "vr_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	@Column(name = "vr_valor_inicial")
	private String initialValue;

	public ProcessVariable() {

	}

	/**
	 * @return the idProcessVariable
	 */
	public IdProcessVariable getIdProcessVariable() {
		return idProcessVariable;
	}

	/**
	 * @param idProcessVariable
	 *            the idProcessVariable to set
	 */
	public void setIdProcessVariable(IdProcessVariable idProcessVariable) {
		this.idProcessVariable = idProcessVariable;
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
	 * @return the saveLog
	 */
	public byte getSaveLog() {
		return saveLog;
	}

	/**
	 * @param saveLog
	 *            the saveLog to set
	 */
	public void setSaveLog(byte saveLog) {
		this.saveLog = saveLog;
	}

	/**
	 * @return the program
	 */
	public Programa getProgram() {
		return program;
	}

	/**
	 * @param program
	 *            the program to set
	 */
	public void setProgram(Programa program) {
		this.program = program;
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
	 * @return the initialValue
	 */
	public String getInitialValue() {
		return initialValue;
	}

	/**
	 * @param initialValue
	 *            the initialValue to set
	 */
	public void setInitialValue(String initialValue) {
		this.initialValue = initialValue;
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
	 * @return the idVariable
	 */
	public int getIdVariable() {
		return idVariable;
	}

	/**
	 * @param idVariable
	 *            the idVariable to set
	 */
	public void setIdVariable(int idVariable) {
		this.idVariable = idVariable;
	}

	/**
	 * @return the idPrograma
	 */
	public int getIdPrograma() {
		return idPrograma;
	}

	/**
	 * @param idPrograma
	 *            the idPrograma to set
	 */
	public void setIdPrograma(int idPrograma) {
		this.idPrograma = idPrograma;
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
		result = prime * result + ((idProcessVariable == null) ? 0 : idProcessVariable.hashCode());
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
		ProcessVariable other = (ProcessVariable) obj;
		if (idProcessVariable == null) {
			if (other.idProcessVariable != null)
				return false;
		} else if (!idProcessVariable.equals(other.idProcessVariable))
			return false;
		return true;
	}

}