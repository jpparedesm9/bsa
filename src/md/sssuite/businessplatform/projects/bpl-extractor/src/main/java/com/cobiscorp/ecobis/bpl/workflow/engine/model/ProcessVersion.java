package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;

/**
 * The persistent class for the wf_version_proceso database table.
 * 
 */
/**
 * @author acarrillo
 * 
 */
@Entity
@Table(name = "wf_version_proceso", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "ProcessVersion.findProcessVersionById", query = "select pv from ProcessVersion pv where pv.idProcessVersion.idProcess=:idProcess and pv.idProcessVersion.versionProcess=:versionProcess") })
public class ProcessVersion implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdProcessVersion idProcessVersion;

	@Column(name = "vp_estado")
	private String status;

	@Column(name = "vp_fecha_activacion")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar activationDate;

	@Column(name = "vp_fecha_creacion")
	@Temporal(TemporalType.TIMESTAMP)
	private Calendar creationDate;

	@Column(name = "vp_info_historica")
	private byte historyInformation;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "vp_codigo_proceso", referencedColumnName = "pr_codigo_proceso")
	private Process process;

	@Column(name = "vp_version_proceso")
	private Short versionProcess;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<ProcessVariable> processVariableList = new ArrayList<ProcessVariable>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<Step> stepList = new ArrayList<Step>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion")
	private List<Link> linkList = new ArrayList<Link>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<MappingVariableProcess> mappingVariableProcessList = new ArrayList<MappingVariableProcess>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<Hierarchy> hierarchyList = new ArrayList<Hierarchy>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<Addressee> addresseeList = new ArrayList<Addressee>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<ProcessActivity> processActivityList = new ArrayList<ProcessActivity>();

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "processVersion", cascade = CascadeType.ALL)
	private List<TaskView> taskViewList = new ArrayList<TaskView>();

	public ProcessVersion() {
	}

	public ProcessVersion(Short versionProcess) {
		this.versionProcess = versionProcess;
	}

	/**
	 * @return the idProcessVersion
	 */
	public IdProcessVersion getIdProcessVersion() {
		return idProcessVersion;
	}

	/**
	 * @param idProcessVersion
	 *            the idProcessVersion to set
	 */
	public void setIdProcessVersion(IdProcessVersion idProcessVersion) {
		this.idProcessVersion = idProcessVersion;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
	}

	/**
	 * @return the activationDate
	 */
	public Calendar getActivationDate() {
		return activationDate;
	}

	/**
	 * @param activationDate
	 *            the activationDate to set
	 */
	public void setActivationDate(Calendar activationDate) {
		this.activationDate = activationDate;
	}

	/**
	 * @return the creationDate
	 */
	public Calendar getCreationDate() {
		return creationDate;
	}

	/**
	 * @param creationDate
	 *            the creationDate to set
	 */
	public void setCreationDate(Calendar creationDate) {
		this.creationDate = creationDate;
	}

	/**
	 * @return the historyInformation
	 */
	public byte getHistoryInformation() {
		return historyInformation;
	}

	/**
	 * @param historyInformation
	 *            the historyInformation to set
	 */
	public void setHistoryInformation(byte historyInformation) {
		this.historyInformation = historyInformation;
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
	 * @return the processVariableList
	 */
	public List<ProcessVariable> getProcessVariableList() {
		return processVariableList;
	}

	/**
	 * @param processVariableList
	 *            the processVariableList to set
	 */
	public void setProcessVariableList(List<ProcessVariable> processVariableList) {
		this.processVariableList = processVariableList;
	}

	/**
	 * @return the linkList
	 */
	public List<Link> getLinkList() {
		return linkList;
	}

	/**
	 * @param linkList
	 *            the linkList to set
	 */
	public void setLinkList(List<Link> linkList) {
		this.linkList = linkList;
	}

	/**
	 * @return the mappingVariableProcessList
	 */
	public List<MappingVariableProcess> getMappingVariableProcessList() {
		return mappingVariableProcessList;
	}

	/**
	 * @param mappingVariableProcessList
	 *            the mappingVariableProcessList to set
	 */
	public void setMappingVariableProcessList(List<MappingVariableProcess> mappingVariableProcessList) {
		this.mappingVariableProcessList = mappingVariableProcessList;
	}

	/**
	 * @return the hierarchyList
	 */
	public List<Hierarchy> getHierarchyList() {
		return hierarchyList;
	}

	/**
	 * @param hierarchyList
	 *            the hierarchyList to set
	 */
	public void setHierarchyList(List<Hierarchy> hierarchyList) {
		this.hierarchyList = hierarchyList;
	}

	/**
	 * @return the stepList
	 */
	public List<Step> getStepList() {
		return stepList;
	}

	/**
	 * @param stepList
	 *            the stepList to set
	 */
	public void setStepList(List<Step> stepList) {
		this.stepList = stepList;
	}

	/**
	 * @return the addresseeList
	 */
	public List<Addressee> getAddresseeList() {
		return addresseeList;
	}

	/**
	 * @param addresseeList
	 *            the addresseeList to set
	 */
	public void setAddresseeList(List<Addressee> addresseeList) {
		this.addresseeList = addresseeList;
	}

	/**
	 * @return the processActivityList
	 */
	public List<ProcessActivity> getProcessActivityList() {
		return processActivityList;
	}

	/**
	 * @param processActivityList
	 *            the processActivityList to set
	 */
	public void setProcessActivityList(List<ProcessActivity> processActivityList) {
		this.processActivityList = processActivityList;
	}

	/**
	 * @return the taskViewList
	 */
	public List<TaskView> getTaskViewList() {
		return taskViewList;
	}

	/**
	 * @param taskViewList
	 *            the taskViewList to set
	 */
	public void setTaskViewList(List<TaskView> taskViewList) {
		this.taskViewList = taskViewList;
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
		result = prime * result + ((idProcessVersion == null) ? 0 : idProcessVersion.hashCode());
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
		ProcessVersion other = (ProcessVersion) obj;
		if (idProcessVersion == null) {
			if (other.idProcessVersion != null)
				return false;
		} else if (!idProcessVersion.equals(other.idProcessVersion))
			return false;
		return true;
	}

}