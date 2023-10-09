package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the bpl_rule_rol database table.
 * 
 */
@Entity
@Table(name = "bpl_subtype_rule", schema = "cob_pac")
@NamedQuery(name = "SubTypeRule.getAllSubTypes", query = "select st from SubTypeRule st where st.system.id = :id")
public class SubTypeRule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "su_id")
	private int id;

	@Column(name = "sr_id")
	private int idSystemRule;

	@ManyToOne
	@JoinColumn(name = "sr_id", insertable = false, updatable = false)
	private SystemRule system;

	@Column(name = "su_name")
	private String name;

	@Column(name = "su_description")
	private String description;

	@Column(name = "su_acronym")
	private String acronym;

	public SubTypeRule() {
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public SystemRule getSystem() {
		return system;
	}

	public void setSystem(SystemRule system) {
		this.system = system;
	}

	public String getAcronym() {
		return acronym;
	}

	public void setAcronym(String acronym) {
		this.acronym = acronym;
	}

	/**
	 * @return the idSystemRule
	 */
	public int getIdSystemRule() {
		return idSystemRule;
	}

	/**
	 * @param idSystemRule
	 *            the idSystemRule to set
	 */
	public void setIdSystemRule(int idSystemRule) {
		this.idSystemRule = idSystemRule;
	}

	@Override
	public String toString() {
		return "SubTypeRule [id=" + id + ", system=" + system.getId() + ", name=" + name + ", description=" + description + "]";
	}

}