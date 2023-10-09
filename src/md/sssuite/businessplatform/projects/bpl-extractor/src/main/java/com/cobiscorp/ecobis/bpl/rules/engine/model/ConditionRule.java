package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the bpl_condition_rule database table.
 * 
 */
@Entity
@Table(name = "bpl_condition_rule", schema = "cob_pac")
public class ConditionRule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name = "cr_id")
	private int id;

	@Column(name = "cr_is_last_son")
	private boolean isLastSon;

	@Column(name = "cr_max_value")
	private String maxValue;

	@Column(name = "cr_min_value")
	private String minValue;

	@Column(name = "cr_operator")
	private String operador;
	
	@Column(name = "cr_id_result")
	private int idResult;

	// bi-directional many-to-one association to ConditionRule
	@ManyToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "cr_parent")
	private ConditionRule conditionRuleParent;
	
	
	@ManyToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "cr_last_parent_condition")
	private ConditionRule conditionRuleLastParent;

	// bi-directional many-to-one association to ConditionRule
	@OneToMany(mappedBy = "conditionRuleParent", cascade = { CascadeType.ALL })
	private List<ConditionRule> conditionRulesSons;

	// bi-directional many-to-one association to RulesVersion
	@ManyToOne(cascade = CascadeType.MERGE)
	@JoinColumn(name = "rv_id")
	private RuleVersion ruleVersion;

	// bi-directional many-to-one association to VariableDefinition
	@ManyToOne
	@JoinColumn(name = "vd_id")
	private Variable variable;
	
	@javax.persistence.Transient
	private List<RuleException> ruleExceptions;

	public ConditionRule() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean getIsLastSon() {
		return this.isLastSon;
	}

	public void setIsLastSon(boolean isLastSon) {
		this.isLastSon = isLastSon;
	}

	public String getMaxValue() {
		return this.maxValue;
	}

	public void setMaxValue(String maxValue) {
		this.maxValue = maxValue;
	}

	public String getMinValue() {
		return this.minValue;
	}

	public void setMinValue(String minValue) {
		this.minValue = minValue;
	}

	public String getOperador() {
		return this.operador;
	}

	public void setOperador(String operador) {
		this.operador = operador;
	}

	public ConditionRule getConditionRuleParent() {
		return this.conditionRuleParent;
	}

	public void setConditionRuleParent(ConditionRule conditionRuleParent) {
		this.conditionRuleParent = conditionRuleParent;
	}


	public RuleVersion getRulesVersion() {
		return this.ruleVersion;
	}

	public void setRulesVersion(RuleVersion rulesVersion) {
		this.ruleVersion = rulesVersion;
	}

	public void setVariable(Variable variable) {
		this.variable = variable;
	}

	public Variable getVariable() {
		return variable;
	}

	public void setConditionRulesSons(List<ConditionRule> conditionRulesSons) {
		this.conditionRulesSons = conditionRulesSons;
	}

	public List<ConditionRule> getConditionRulesSons() {
		return conditionRulesSons;
	}

	
	public int getIdResult() {
		return idResult;
	}

	public void setIdResult(int idResult) {
		this.idResult = idResult;
	}

	public ConditionRule getConditionRuleLastParent() {
		return conditionRuleLastParent;
	}

	public void setConditionRuleLastParent(ConditionRule conditionRuleLastParent) {
		this.conditionRuleLastParent = conditionRuleLastParent;
	}

	public List<RuleException> getRuleExceptions() {
		return ruleExceptions;
	}

	public void setRuleExceptions(List<RuleException> ruleExceptions) {
		this.ruleExceptions = ruleExceptions;
	}

}