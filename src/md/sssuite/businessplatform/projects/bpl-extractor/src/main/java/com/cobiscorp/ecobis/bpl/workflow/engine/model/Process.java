package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the wf_proceso database table.
 * 
 */
@Entity
@Table(name = "wf_proceso", schema = "cob_workflow")
public class Process implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_proceso", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_proceso")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_proceso")
	@Column(name = "pr_codigo_proceso")
	private Integer idProcess;

	@Column(name = "pr_codigo_empresa")
	private Short idCompany;

	@Column(name = "pr_console")
	private String console;

	@Column(name = "pr_costo_proceso")
	private Double cost;

	@Column(name = "pr_desc_proceso")
	private String description;

	@Column(name = "pr_email")
	private String email;

	@Column(name = "pr_es_plantilla")
	private byte template;

	@Column(name = "pr_es_subproceso")
	private byte thread;

	@Column(name = "pr_estado")
	private String status;

	@Column(name = "pr_modo_regreso")
	private String returnMode;

	@Column(name = "pr_nombre_proceso")
	private String name;

	@Column(name = "pr_notificacion")
	private String notification;

	@Column(name = "pr_producto")
	private String product;

	@Column(name = "pr_sms")
	private String sms;

	@Column(name = "pr_tiempo_efectivo")
	private Integer effectiveTime;

	@Column(name = "pr_tiempo_estandar")
	private Integer standardTime;

	@Column(name = "pr_version_prd")
	private Short version;

	@Column(name = "pr_nemonico")
	private String nemonic;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "process", cascade = CascadeType.ALL)
	private List<ProcessVersion> listProcessVersion = new ArrayList<ProcessVersion>();

	// OneToOne
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "process", cascade = CascadeType.ALL)
	private List<ProcessType> processTypeList = new ArrayList<ProcessType>();

	public Process() {
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
	 * @return the idCompany
	 */
	public Short getIdCompany() {
		return idCompany;
	}

	/**
	 * @param idCompany
	 *            the idCompany to set
	 */
	public void setIdCompany(Short idCompany) {
		this.idCompany = idCompany;
	}

	/**
	 * @return the console
	 */
	public String getConsole() {
		return console;
	}

	/**
	 * @param console
	 *            the console to set
	 */
	public void setConsole(String console) {
		this.console = console;
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
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}

	/**
	 * @param email
	 *            the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}

	/**
	 * @return the template
	 */
	public byte getTemplate() {
		return template;
	}

	/**
	 * @param template
	 *            the template to set
	 */
	public void setTemplate(byte template) {
		this.template = template;
	}

	/**
	 * @return the thread
	 */
	public byte getThread() {
		return thread;
	}

	/**
	 * @param thread
	 *            the thread to set
	 */
	public void setThread(byte thread) {
		this.thread = thread;
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
	 * @return the returnMode
	 */
	public String getReturnMode() {
		return returnMode;
	}

	/**
	 * @param returnMode
	 *            the returnMode to set
	 */
	public void setReturnMode(String returnMode) {
		this.returnMode = returnMode;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the notification
	 */
	public String getNotification() {
		return notification;
	}

	/**
	 * @param notification
	 *            the notification to set
	 */
	public void setNotification(String notification) {
		this.notification = notification;
	}

	/**
	 * @return the product
	 */
	public String getProduct() {
		return product;
	}

	/**
	 * @param product
	 *            the product to set
	 */
	public void setProduct(String product) {
		this.product = product;
	}

	/**
	 * @return the sms
	 */
	public String getSms() {
		return sms;
	}

	/**
	 * @param sms
	 *            the sms to set
	 */
	public void setSms(String sms) {
		this.sms = sms;
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
	 * @return the version
	 */
	public Short getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(Short version) {
		this.version = version;
	}

	/**
	 * @return the listProcessVersion
	 */
	public List<ProcessVersion> getListProcessVersion() {
		return listProcessVersion;
	}

	/**
	 * @param listProcessVersion
	 *            the listProcessVersion to set
	 */
	public void setListProcessVersion(List<ProcessVersion> listProcessVersion) {
		this.listProcessVersion = listProcessVersion;
	}

	/**
	 * @return the processTypeList
	 */
	public List<ProcessType> getProcessTypeList() {
		return processTypeList;
	}

	/**
	 * @param processTypeList
	 *            the processTypeList to set
	 */
	public void setProcessTypeList(List<ProcessType> processTypeList) {
		this.processTypeList = processTypeList;
	}

	/**
	 * @return the nemonic
	 */
	public String getNemonic() {
		return nemonic;
	}

	/**
	 * @param nemonic
	 *            the nemonic to set
	 */
	public void setNemonic(String nemonic) {
		this.nemonic = nemonic;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdProcess() == null ? super.hashCode() : this.getIdProcess().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof Process)) {
			return false;
		}
		Process entity = (Process) object;
		if ((this.getIdProcess() == null && entity.getIdProcess() != null)
				|| (this.getIdProcess() != null && !this.getIdProcess().equals(entity.getIdProcess()))) {
			return false;
		}
		return true;
	}

}