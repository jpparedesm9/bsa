package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

/**
 * The persistent class for the wf_paso_pol database table.
 * 
 */
@Entity
@Table(name = "wf_paso_pol", schema = "cob_workflow")
public class PolicyStep implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdPolicyStep idPolicyStep;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "rl_id", insertable = false, updatable = false)
	private Rule rule;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "pa_id_paso", insertable = false, updatable = false)
	private Step step;

	public Rule getRule() {
		return rule;
	}

	public void setRule(Rule rule) {
		this.rule = rule;
	}

	public Step getStep() {
		return step;
	}

	public void setStep(Step step) {
		this.step = step;
	}

	/**
	 * @return the idPolicyStep
	 */
	public IdPolicyStep getIdPolicyStep() {
		return idPolicyStep;
	}

	/**
	 * @param idPolicyStep
	 *            the idPolicyStep to set
	 */
	public void setIdPolicyStep(IdPolicyStep idPolicyStep) {
		this.idPolicyStep = idPolicyStep;
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
		result = prime * result + ((idPolicyStep == null) ? 0 : idPolicyStep.hashCode());
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
		PolicyStep other = (PolicyStep) obj;
		if (idPolicyStep == null) {
			if (other.idPolicyStep != null)
				return false;
		} else if (!idPolicyStep.equals(other.idPolicyStep))
			return false;
		return true;
	}

}