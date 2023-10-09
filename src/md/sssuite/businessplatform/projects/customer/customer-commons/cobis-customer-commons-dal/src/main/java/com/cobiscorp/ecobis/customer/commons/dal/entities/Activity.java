package com.cobiscorp.ecobis.customer.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "cl_actividad_ec", schema = "cobis")
@NamedQueries({ 
 @NamedQuery(name = "Activity.findDescription", query = "select a.description from Activity a where a.code = :code")
})
/**
 * Class used to access the database using JPA
 * related table: cl_actividad_ec, bdd: cobis
 *
 */
public class Activity {

	@Id
	@Column(name = "ac_codigo")
	private String code;

	@Column(name = "ac_descripcion")
	private String description;
	
	/*@OneToMany(mappedBy = "activityEc")
	private List<Customer> customer;*/

	public Activity() {
	}

	public Activity(String code, String description) {
		this.code = code;
		this.description = description;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		result = prime * result
				+ ((description == null) ? 0 : description.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Activity other = (Activity) obj;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		if (description == null) {
			if (other.description != null)
				return false;
		} else if (!description.equals(other.description))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Activity [code=" + code + ", description=" + description + "]";
	}
}
