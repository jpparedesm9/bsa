package com.cobiscorp.ecobis.bpl.rules.engine.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * The persistent class for the bpl_rule_rol database table.
 * 
 */
@Entity
@Table(name = "bpl_system_rule", schema = "cob_pac")
@NamedQuery(name = "SystemRule.getAllSystems", query = "select new com.cobiscorp.ecobis.bpl.rules.engine.model.SystemRule(sr.id, sr.acronym, sr.name, sr.description, sr.module)"
		+ " from SystemRule sr")
public class SystemRule implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "sr_id")
	private int id;

	@Column(name = "sr_acronym")
	private String acronym;

	@Column(name = "sr_name")
	private String name;

	@Column(name = "sr_modulo_cobis")
	private String module;

	@Column(name = "sr_description")
	private String description;

	public SystemRule(int id, String acronym, String name, String description, String module) {
		this.id = id;
		this.acronym = acronym;
		this.name = name;
		this.description = description;
		this.module = module;
	}

	@OneToMany(mappedBy = "system", cascade = CascadeType.REMOVE)
	private List<SubTypeRule> subtype;

	public SystemRule() {
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAcronym() {
		return acronym;
	}

	public void setAcronym(String acronym) {
		this.acronym = acronym;
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

	public List<SubTypeRule> getSubtype() {
		return subtype;
	}

	public void setSubtype(List<SubTypeRule> subtype) {
		this.subtype = subtype;
	}

	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}
}