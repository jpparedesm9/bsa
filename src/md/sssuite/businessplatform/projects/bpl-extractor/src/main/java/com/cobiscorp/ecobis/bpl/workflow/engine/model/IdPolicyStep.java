package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_paso_pol database table.
 * 
 */
@Embeddable
public class IdPolicyStep implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "rl_id")
	private Integer idRule;

	@Column(name = "pa_id_paso")
	private Integer idStep;

	public IdPolicyStep() {
	}

	public IdPolicyStep(Integer idRule, Integer idStep) {
		super();
		this.idRule = idRule;
		this.idStep = idStep;
	}

	/**
	 * @return the idRule
	 */
	public Integer getIdRule() {
		return idRule;
	}

	/**
	 * @param idRule
	 *            the idRule to set
	 */
	public void setIdRule(Integer idRule) {
		this.idRule = idRule;
	}

	/**
	 * @return the idStep
	 */
	public Integer getIdStep() {
		return idStep;
	}

	/**
	 * @param idStep
	 *            the idStep to set
	 */
	public void setIdStep(Integer idStep) {
		this.idStep = idStep;
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
		result = prime * result + ((idRule == null) ? 0 : idRule.hashCode());
		result = prime * result + ((idStep == null) ? 0 : idStep.hashCode());
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
		IdPolicyStep other = (IdPolicyStep) obj;
		if (idRule == null) {
			if (other.idRule != null)
				return false;
		} else if (!idRule.equals(other.idRule))
			return false;
		if (idStep == null) {
			if (other.idStep != null)
				return false;
		} else if (!idStep.equals(other.idStep))
			return false;
		return true;
	}

}