package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;

/**
 * The persistent class for the wf_tipo_req_act database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_req_act", schema = "cob_workflow")
public class ActivityRequirement implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdActivityRequirement idRequirementActivity;

	@Column(name = "tr_desc_regla")
	private String ruleDescription;

	@Column(name = "tr_es_mandatorio")
	private byte mandatory;

	@Column(name = "tr_referencia")
	private String reference;

	@Column(name = "tr_texto")
	private String text;

	@Column(name = "tr_excepcionable")
	private Integer excepcionable;

	@Transient
	// @ManyToOne(fetch = FetchType.EAGER )
	// @JoinColumn(name = "tr_id_regla")
	private Rule rule;

	@Column(name = "tr_id_regla")
	private int idRule;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "tr_codigo_tipo_doc", referencedColumnName = "td_codigo_tipo_doc", insertable = false, updatable = false)
	private Requirement requirement;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "tr_id_paso", insertable = false, updatable = false)
	private Step step;

	public ActivityRequirement() {

	}

	/**
	 * @return the idRequirementActivity
	 */
	public IdActivityRequirement getIdRequirementActivity() {
		return idRequirementActivity;
	}

	/**
	 * @param idRequirementActivity
	 *            the idRequirementActivity to set
	 */
	public void setIdRequirementActivity(IdActivityRequirement idRequirementActivity) {
		this.idRequirementActivity = idRequirementActivity;
	}

	/**
	 * @return the ruleDescription
	 */
	public String getRuleDescription() {
		return ruleDescription;
	}

	/**
	 * @param ruleDescription
	 *            the ruleDescription to set
	 */
	public void setRuleDescription(String ruleDescription) {
		this.ruleDescription = ruleDescription;
	}

	/**
	 * @return the mandatory
	 */
	public byte getMandatory() {
		return mandatory;
	}

	/**
	 * @param mandatory
	 *            the mandatory to set
	 */
	public void setMandatory(byte mandatory) {
		this.mandatory = mandatory;
	}

	/**
	 * @return the reference
	 */
	public String getReference() {
		return reference;
	}

	/**
	 * @param reference
	 *            the reference to set
	 */
	public void setReference(String reference) {
		this.reference = reference;
	}

	/**
	 * @return the text
	 */
	public String getText() {
		return text;
	}

	/**
	 * @param text
	 *            the text to set
	 */
	public void setText(String text) {
		this.text = text;
	}

	/**
	 * @return the rule
	 */
	public Rule getRule() {
		return rule;
	}

	/**
	 * @param rule
	 *            the rule to set
	 */
	public void setRule(Rule rule) {
		this.rule = rule;
	}

	/**
	 * @return the requirement
	 */
	public Requirement getRequirement() {
		return requirement;
	}

	/**
	 * @param requirement
	 *            the requirement to set
	 */
	public void setRequirement(Requirement requirement) {
		this.requirement = requirement;
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

	public int getIdRule() {
		return idRule;
	}

	public void setIdRule(int idRule) {
		this.idRule = idRule;
	}

	public Integer getExcepcionable() {
		return excepcionable;
	}

	public void setExcepcionable(Integer excepcionable) {
		this.excepcionable = excepcionable;
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
		result = prime * result + ((idRequirementActivity == null) ? 0 : idRequirementActivity.hashCode());
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
		ActivityRequirement other = (ActivityRequirement) obj;
		if (idRequirementActivity == null) {
			if (other.idRequirementActivity != null)
				return false;
		} else if (!idRequirementActivity.equals(other.idRequirementActivity))
			return false;
		return true;
	}

}