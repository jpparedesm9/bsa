package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_tipo_documento database table.
 * 
 */
@Entity
@Table(name = "wf_tipo_documento", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Requirement.findByAll", query = "select rq from Requirement rq"),
		@NamedQuery(name = "Requirement.findByName", query = "select rq from Requirement rq where rq.name= :name") })
public class Requirement implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
//	@TableGenerator(name = "wf_tipo_documento", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_tipo_documento")
//	@GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_tipo_documento")
	@Column(name = "td_codigo_tipo_doc")
	private Integer idRequirement;

	@Column(name = "td_categoria_doc")
	private String category;

	@Column(name = "td_nombre_tipo_doc")
	private String name;

	@Column(name = "td_tipo_doc")
	private String type;

	@Column(name = "td_vigencia_doc")
	private String status;

	public Requirement() {
	}

	/**
	 * @return the idRequirement
	 */
	public Integer getIdRequirement() {
		return idRequirement;
	}

	/**
	 * @param idRequirement
	 *            the idRequirement to set
	 */
	public void setIdRequirement(Integer idRequirement) {
		this.idRequirement = idRequirement;
	}

	/**
	 * @return the category
	 */
	public String getCategory() {
		return category;
	}

	/**
	 * @param category
	 *            the category to set
	 */
	public void setCategory(String category) {
		this.category = category;
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
	 * @return the type
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 *            the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the status
	 */
	public String getStatus() {
		return status;
	}

	/**
	 * @param status
	 *            the status to set
	 */
	public void setStatus(String status) {
		this.status = status;
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
		result = prime * result + ((idRequirement == null) ? 0 : idRequirement.hashCode());
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
		Requirement other = (Requirement) obj;
		if (idRequirement == null) {
			if (other.idRequirement != null)
				return false;
		} else if (!idRequirement.equals(other.idRequirement))
			return false;
		return true;
	}

}