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
 * The persistent class for the wf_info_paso database table.
 * 
 */
@Entity
@Table(name = "wf_info_paso", schema = "cob_workflow")
public class InformationStep implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdInformationStep idInformationStep;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "li_id_paso")
	private Step step;

	@Column(name = "li_asunto")
	private String subject;

	@Column(name = "li_cod_proc_lanzado")
	private Integer launcherProcess;

	@Column(name = "li_codigo_proceso")
	private Integer idProcess;

	@Column(name = "li_version_proceso")
	private Short idVersionProcess;

	@Column(name = "li_mensaje")
	private String message;

	@Column(name = "li_notification_id")
	private Integer idNotification1;

	@Column(name = "li_tipo_actividad")
	private String activityType;

	@Column(name = "li_use_email")
	private String useEmail1;

	@Column(name = "li_use_sms")
	private String useSms1;

	@Column(name = "notification_id")
	private Integer idNotification2;

	@Column(name = "use_email")
	private String useEmail2;

	@Column(name = "use_sms")
	private String useSms2;

	public InformationStep() {

	}

	/**
	 * @return the idInformationStep
	 */
	public IdInformationStep getIdInformationStep() {
		return idInformationStep;
	}

	/**
	 * @param idInformationStep
	 *            the idInformationStep to set
	 */
	public void setIdInformationStep(IdInformationStep idInformationStep) {
		this.idInformationStep = idInformationStep;
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
	 * @return the subject
	 */
	public String getSubject() {
		return subject;
	}

	/**
	 * @param subject
	 *            the subject to set
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}

	/**
	 * @return the launcherProcess
	 */
	public Integer getLauncherProcess() {
		return launcherProcess;
	}

	/**
	 * @param launcherProcess
	 *            the launcherProcess to set
	 */
	public void setLauncherProcess(Integer launcherProcess) {
		this.launcherProcess = launcherProcess;
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
	 * @return the idVersionProcess
	 */
	public Short getIdVersionProcess() {
		return idVersionProcess;
	}

	/**
	 * @param idVersionProcess
	 *            the idVersionProcess to set
	 */
	public void setIdVersionProcess(Short idVersionProcess) {
		this.idVersionProcess = idVersionProcess;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * @param message
	 *            the message to set
	 */
	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * @return the idNotification1
	 */
	public Integer getIdNotification1() {
		return idNotification1;
	}

	/**
	 * @param idNotification1
	 *            the idNotification1 to set
	 */
	public void setIdNotification1(Integer idNotification1) {
		this.idNotification1 = idNotification1;
	}

	/**
	 * @return the activityType
	 */
	public String getActivityType() {
		return activityType;
	}

	/**
	 * @param activityType
	 *            the activityType to set
	 */
	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}

	/**
	 * @return the useEmail1
	 */
	public String getUseEmail1() {
		return useEmail1;
	}

	/**
	 * @param useEmail1
	 *            the useEmail1 to set
	 */
	public void setUseEmail1(String useEmail1) {
		this.useEmail1 = useEmail1;
	}

	/**
	 * @return the useSms1
	 */
	public String getUseSms1() {
		return useSms1;
	}

	/**
	 * @param useSms1
	 *            the useSms1 to set
	 */
	public void setUseSms1(String useSms1) {
		this.useSms1 = useSms1;
	}

	/**
	 * @return the idNotification2
	 */
	public Integer getIdNotification2() {
		return idNotification2;
	}

	/**
	 * @param idNotification2
	 *            the idNotification2 to set
	 */
	public void setIdNotification2(Integer idNotification2) {
		this.idNotification2 = idNotification2;
	}

	/**
	 * @return the useEmail2
	 */
	public String getUseEmail2() {
		return useEmail2;
	}

	/**
	 * @param useEmail2
	 *            the useEmail2 to set
	 */
	public void setUseEmail2(String useEmail2) {
		this.useEmail2 = useEmail2;
	}

	/**
	 * @return the useSms2
	 */
	public String getUseSms2() {
		return useSms2;
	}

	/**
	 * @param useSms2
	 *            the useSms2 to set
	 */
	public void setUseSms2(String useSms2) {
		this.useSms2 = useSms2;
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
		result = prime * result + ((idInformationStep == null) ? 0 : idInformationStep.hashCode());
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
		InformationStep other = (InformationStep) obj;
		if (idInformationStep == null) {
			if (other.idInformationStep != null)
				return false;
		} else if (!idInformationStep.equals(other.idInformationStep))
			return false;
		return true;
	}

}