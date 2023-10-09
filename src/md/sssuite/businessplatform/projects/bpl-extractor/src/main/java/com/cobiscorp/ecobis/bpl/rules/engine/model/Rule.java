package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the bpl_rule database table.
 * 
 */
@Entity
@Table(name = "bpl_rule", schema = "cob_pac")
public class Rule implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "rl_id")
	private int id;

	@Column(name = "rl_name")
	private String name;

	@Column(name = "rl_acronym")
	private String acronym;

	@Column(name = "rl_type")
	private String type;

	@Column(name = "rl_system")
	private String systemRuleId;
	
	@Column(name = "rl_subtype")
	private String subTypeId;
	
	@Column(name = "rl_description")
	private String description;

	// bi-directional many-to-one association to RulesVersion
	@OneToMany(mappedBy = "rule", cascade = CascadeType.ALL)
	private List<RuleVersion> ruleVersions;

	@javax.persistence.Transient
	private SystemRule systemRule;

	@javax.persistence.Transient
	private List<SubTypeRule> subType;

	public Rule() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAcronym() {
		return acronym;
	}

	public void setAcronym(String acronym) {
		this.acronym = acronym;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getSystemRuleId() {
		return systemRuleId;
	}

	public void setSystemRuleId(String systemRuleId) {
		this.systemRuleId = systemRuleId;
	}

	public String getSubTypeId() {
		return subTypeId;
	}

	public void setSubTypeId(String subTypeId) {
		this.subTypeId = subTypeId;
	}

	public List<RuleVersion> getRuleVersions() {
		return ruleVersions;
	}

	public void setRuleVersions(List<RuleVersion> ruleVersions) {
		this.ruleVersions = ruleVersions;
	}

	public SystemRule getSystemRule() {
		return systemRule;
	}

	public void setSystemRule(SystemRule systemRule) {
		this.systemRule = systemRule;
	}

	public List<SubTypeRule> getSubType() {
		return subType;
	}

	public void setSubType(List<SubTypeRule> subType) {
		this.subType = subType;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	

}