package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the wf_enlace database table.
 * 
 */
@Entity
@Table(name = "wf_enlace", schema = "cob_workflow")
public class Link implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	// @TableGenerator(name = "wf_enlace", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla",
	// valueColumnName = "siguiente", pkColumnValue = "wf_enlace")
	// @GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_enlace")
	@Column(name = "en_id_enlace")
	private Integer idLink;

	@Column(name = "en_codigo_proceso", insertable = false, updatable = false)
	private Integer idProcess;

	@Column(name = "en_version_proceso", insertable = false, updatable = false)
	private Short version;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "en_id_paso_fin", insertable = false, updatable = false)
	private Step finalStep;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "en_id_paso_ini", insertable = false, updatable = false)
	private Step initialStep;

	@JoinColumn(name = "en_id_paso_fin")
	private Integer idFinalStep;

	@JoinColumn(name = "en_id_paso_ini")
	private Integer idInitialStep;

	@Column(name = "en_nombre_enlace")
	private String name;

	@Column(name = "en_puntos_enlace")
	private String points;

	@Column(name = "en_retorno_enlace")
	private String returnLink;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumns(value = { @JoinColumn(name = "en_codigo_proceso", referencedColumnName = "vp_codigo_proceso"),
			@JoinColumn(name = "en_version_proceso", referencedColumnName = "vp_version_proceso") })
	private ProcessVersion processVersion;

	// OneToOne
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "link", cascade = CascadeType.ALL)
	private List<LinkCondition> linkConditionList = new ArrayList<LinkCondition>();

	public Link() {

	}

	/**
	 * @return the idLink
	 */
	public Integer getIdLink() {
		return idLink;
	}

	/**
	 * @param idLink
	 *            the idLink to set
	 */
	public void setIdLink(Integer idLink) {
		this.idLink = idLink;
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
	 * @return the finalStep
	 */
	public Step getFinalStep() {
		return finalStep;
	}

	/**
	 * @param finalStep
	 *            the finalStep to set
	 */
	public void setFinalStep(Step finalStep) {
		this.finalStep = finalStep;
	}

	/**
	 * @return the initialStep
	 */
	public Step getInitialStep() {
		return initialStep;
	}

	/**
	 * @param initialStep
	 *            the initialStep to set
	 */
	public void setInitialStep(Step initialStep) {
		this.initialStep = initialStep;
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
	 * @return the points
	 */
	public String getPoints() {
		return points;
	}

	/**
	 * @param points
	 *            the points to set
	 */
	public void setPoints(String points) {
		this.points = points;
	}

	/**
	 * @return the returnLink
	 */
	public String getReturnLink() {
		return returnLink;
	}

	/**
	 * @param returnLink
	 *            the returnLink to set
	 */
	public void setReturnLink(String returnLink) {
		this.returnLink = returnLink;
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
	 * @return the linkConditionList
	 */
	public List<LinkCondition> getLinkConditionList() {
		return linkConditionList;
	}

	/**
	 * @param linkConditionList
	 *            the linkConditionList to set
	 */
	public void setLinkConditionList(List<LinkCondition> linkConditionList) {
		this.linkConditionList = linkConditionList;
	}

	/**
	 * @return the idFinalStep
	 */
	public Integer getIdFinalStep() {
		return idFinalStep;
	}

	/**
	 * @param idFinalStep
	 *            the idFinalStep to set
	 */
	public void setIdFinalStep(Integer idFinalStep) {
		this.idFinalStep = idFinalStep;
	}

	/**
	 * @return the idInitialStep
	 */
	public Integer getIdInitialStep() {
		return idInitialStep;
	}

	/**
	 * @param idInitialStep
	 *            the idInitialStep to set
	 */
	public void setIdInitialStep(Integer idInitialStep) {
		this.idInitialStep = idInitialStep;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		return getIdLink() == null ? super.hashCode() : this.getIdLink().intValue();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object object) {
		if (!(object instanceof Link)) {
			return false;
		}
		Link entity = (Link) object;
		if ((this.getIdLink() == null && entity.getIdLink() != null) || (this.getIdLink() != null && !this.getIdLink().equals(entity.getIdLink()))) {
			return false;
		}
		return true;
	}

}