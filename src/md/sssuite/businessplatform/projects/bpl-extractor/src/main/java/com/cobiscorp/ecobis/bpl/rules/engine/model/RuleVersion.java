package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.Calendar;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;


/**
 * The persistent class for the bpl_rules_version database table.
 * 
 */
@Entity
@Table(name="bpl_rule_version", schema="cob_pac")
public class RuleVersion implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="rv_id")
	private int id;

	@Column(name="rv_date_finish")
	private Calendar dateFinish;

	@Column(name="rv_date_start")
	private Calendar dateStart;

	@Column(name="rv_status")
	private String status;

	@Column(name="rv_version")
	private int version;

	//bi-directional many-to-one association to ConditionRule
	@OneToMany(mappedBy="ruleVersion", cascade=CascadeType.ALL)
	private List<ConditionRule> conditionRules;

	//bi-directional many-to-one association to Rule
    @ManyToOne(cascade={CascadeType.DETACH,CascadeType.MERGE})
	@JoinColumn(name="rl_id")
	private Rule rule;

    public RuleVersion() {
    }

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Calendar getDateFinish() {
		return this.dateFinish;
	}

	public void setDateFinish(Calendar dateFinish) {
		this.dateFinish = dateFinish;
	}

	public Calendar getDateStart() {
		return this.dateStart;
	}

	public void setDateStart(Calendar dateStart) {
		this.dateStart = dateStart;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public int getVersion() {
		return this.version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public List<ConditionRule> getConditionRules() {
		return this.conditionRules;
	}

	public void setConditionRules(List<ConditionRule> conditionRules) {
		this.conditionRules = conditionRules;
	}

	
	public Rule getRule() {
		return this.rule;
	}

	public void setRule(Rule rule) {
		this.rule = rule;
	}
	
}