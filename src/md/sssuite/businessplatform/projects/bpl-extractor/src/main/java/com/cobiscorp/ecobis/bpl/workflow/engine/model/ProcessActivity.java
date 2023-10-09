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

/**
 * The persistent class for the wf_actividad_proc database table.
 * 
 */
@Entity
@Table(name = "wf_actividad_proc", schema = "cob_workflow")
public class ProcessActivity implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdProcessActivity idProcessActivity;

	@Column(name = "ar_ayuda_operativa")
	private String operativeHelp;

	@Column(name = "ar_costo_act_proc")
	private Double cost;

	@Column(name = "ar_func_asociada")
	private String associatedFunction;

	@Column(name = "ar_inst_exce")
	private String instaceExecution;

	@Column(name = "ar_margen_tolerancia")
	private Double toleranceMargin;

	@Column(name = "ar_suspendida")
	private byte suspend;

	@Column(name = "ar_tiempo_efectivo")
	private Integer effectiveTime;

	@Column(name = "ar_tiempo_estandar")
	private Integer standardTime;

	@Column(name = "ar_codigo_proceso")
	private Integer idProcess;

	@Column(name = "ar_version_proceso")
	private Short versionProcess;

	@Column(name = "ar_codigo_actividad")
	private Integer idActivity;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "ar_codigo_actividad", referencedColumnName = "ac_codigo_actividad", insertable = false, updatable = false)
	private Activity activity;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "ar_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "ar_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	public ProcessActivity() {

	}

	/**
	 * @return the idProcessActivity
	 */
	public IdProcessActivity getIdProcessActivity() {
		return idProcessActivity;
	}

	/**
	 * @param idProcessActivity
	 *            the idProcessActivity to set
	 */
	public void setIdProcessActivity(IdProcessActivity idProcessActivity) {
		this.idProcessActivity = idProcessActivity;
	}

	/**
	 * @return the operativeHelp
	 */
	public String getOperativeHelp() {
		return operativeHelp;
	}

	/**
	 * @param operativeHelp
	 *            the operativeHelp to set
	 */
	public void setOperativeHelp(String operativeHelp) {
		this.operativeHelp = operativeHelp;
	}

	/**
	 * @return the cost
	 */
	public Double getCost() {
		return cost;
	}

	/**
	 * @param cost
	 *            the cost to set
	 */
	public void setCost(Double cost) {
		this.cost = cost;
	}

	/**
	 * @return the associatedFunction
	 */
	public String getAssociatedFunction() {
		return associatedFunction;
	}

	/**
	 * @param associatedFunction
	 *            the associatedFunction to set
	 */
	public void setAssociatedFunction(String associatedFunction) {
		this.associatedFunction = associatedFunction;
	}

	/**
	 * @return the instaceExecution
	 */
	public String getInstaceExecution() {
		return instaceExecution;
	}

	/**
	 * @param instaceExecution
	 *            the instaceExecution to set
	 */
	public void setInstaceExecution(String instaceExecution) {
		this.instaceExecution = instaceExecution;
	}

	/**
	 * @return the toleranceMargin
	 */
	public Double getToleranceMargin() {
		return toleranceMargin;
	}

	/**
	 * @param toleranceMargin
	 *            the toleranceMargin to set
	 */
	public void setToleranceMargin(Double toleranceMargin) {
		this.toleranceMargin = toleranceMargin;
	}

	/**
	 * @return the suspend
	 */
	public byte getSuspend() {
		return suspend;
	}

	/**
	 * @param suspend
	 *            the suspend to set
	 */
	public void setSuspend(byte suspend) {
		this.suspend = suspend;
	}

	/**
	 * @return the effectiveTime
	 */
	public Integer getEffectiveTime() {
		return effectiveTime;
	}

	/**
	 * @param effectiveTime
	 *            the effectiveTime to set
	 */
	public void setEffectiveTime(Integer effectiveTime) {
		this.effectiveTime = effectiveTime;
	}

	/**
	 * @return the standardTime
	 */
	public Integer getStandardTime() {
		return standardTime;
	}

	/**
	 * @param standardTime
	 *            the standardTime to set
	 */
	public void setStandardTime(Integer standardTime) {
		this.standardTime = standardTime;
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
	 * @return the activity
	 */
	public Activity getActivity() {
		return activity;
	}

	/**
	 * @param activity
	 *            the activity to set
	 */
	public void setActivity(Activity activity) {
		this.activity = activity;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idProcessActivity == null) ? 0 : idProcessActivity.hashCode());
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
		ProcessActivity other = (ProcessActivity) obj;
		if (idProcessActivity == null) {
			if (other.idProcessActivity != null)
				return false;
		} else if (!idProcessActivity.equals(other.idProcessActivity))
			return false;
		return true;
	}

}