package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 * The persistent class for the wf_cond_enlace_proc database table.
 * 
 */
@Entity
@Table(name = "wf_cond_enlace_proc", schema = "cob_workflow")
public class LinkCondition implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdLinkCondition idLinkCondition;

	@Column(name = "ce_codigo_proceso")
	private Integer idProcess;

	@Column(name = "ce_version_proceso")
	private Short versionProcess;

	@Column(name = "ce_condicion")
	private String condition;

	@Column(name = "ce_num_firmas")
	private byte signatureNumber;

	@Column(name = "ce_requisito")
	private String requirement;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ce_id_enlace", referencedColumnName = "en_id_enlace")
	private Link link;

	public LinkCondition() {

	}

	/**
	 * @return the idLinkCondition
	 */
	public IdLinkCondition getIdLinkCondition() {
		return idLinkCondition;
	}

	/**
	 * @param idLinkCondition
	 *            the idLinkCondition to set
	 */
	public void setIdLinkCondition(IdLinkCondition idLinkCondition) {
		this.idLinkCondition = idLinkCondition;
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
	 * @return the condition
	 */
	public String getCondition() {
		return condition;
	}

	/**
	 * @param condition
	 *            the condition to set
	 */
	public void setCondition(String condition) {
		this.condition = condition;
	}

	/**
	 * @return the signatureNumber
	 */
	public byte getSignatureNumber() {
		return signatureNumber;
	}

	/**
	 * @param signatureNumber
	 *            the signatureNumber to set
	 */
	public void setSignatureNumber(byte signatureNumber) {
		this.signatureNumber = signatureNumber;
	}

	/**
	 * @return the requirement
	 */
	public String getRequirement() {
		return requirement;
	}

	/**
	 * @param requirement
	 *            the requirement to set
	 */
	public void setRequirement(String requirement) {
		this.requirement = requirement;
	}

	/**
	 * @return the link
	 */
	public Link getLink() {
		return link;
	}

	/**
	 * @param link
	 *            the link to set
	 */
	public void setLink(Link link) {
		this.link = link;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((idLinkCondition == null) ? 0 : idLinkCondition.hashCode());
		return result;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		LinkCondition other = (LinkCondition) obj;
		if (idLinkCondition == null) {
			if (other.idLinkCondition != null)
				return false;
		} else if (!idLinkCondition.equals(other.idLinkCondition))
			return false;
		return true;
	}

}