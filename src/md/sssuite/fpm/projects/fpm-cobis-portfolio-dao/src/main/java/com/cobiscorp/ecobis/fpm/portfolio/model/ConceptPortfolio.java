package com.cobiscorp.ecobis.fpm.portfolio.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * Item Entity for portfolio table ca_concepto.
 * 
 * @author bron
 */
@Entity
@Table(name = "ca_concepto", schema = "cob_cartera")
@NamedQueries({ @NamedQuery(name = "ConceptPortfolio.findNextCodeItem", query = "Select max(c.code) from ConceptPortfolio c") })
public class ConceptPortfolio {

	/** Item Id. */
	@Id
	@Column(name = "co_concepto")
	private String concept;

	/** Description. */
	@Column(name = "co_descripcion")
	private String description;

	/** Code. */
	@Column(name = "co_codigo")
	private int code;

	/** ItemByProduct related list. */
	@Column(name = "co_categoria")
	private String group;

	/**
	 * Default constructor.
	 */
	public ConceptPortfolio() {

	}

	/**
	 * Constructor
	 * 
	 * @param concept
	 * @param description
	 * @param code
	 * @param group
	 */
	public ConceptPortfolio(String concept, String description, Integer code,
			String group) {
		this.concept = concept;
		this.description = description;
		this.code = code;
		this.group = group;
	}
	
	/**
	 * @return the concept
	 */
	public String getConcept() {
		return concept;
	}

	/**
	 * @param concept the concept to set
	 */
	public void setConcept(String concept) {
		this.concept = concept;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the code
	 */
	public int getCode() {
		return code;
	}

	/**
	 * @param code the code to set
	 */
	public void setCode(int code) {
		this.code = code;
	}

	/**
	 * @return the group
	 */
	public String getGroup() {
		return group;
	}

	/**
	 * @param group the group to set
	 */
	public void setGroup(String group) {
		this.group = group;
	}

	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((concept == null) ? 0 : concept.hashCode());
		return result;
	}

	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ConceptPortfolio other = (ConceptPortfolio) obj;
		if (concept == null) {
			if (other.concept != null)
				return false;
		} else if (!concept.equals(other.concept))
			return false;
		return true;
	}

	/**
	 * Obtain a string with a comma separated fields.
	 * 
	 * @return the string
	 */
	public String toString() {
		return "ConceptPortfolio [concept=" + concept + ", description="
				+ description + ", code=" + code + ", group=" + group +"]";
	}
}
