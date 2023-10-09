package com.cobiscorp.ecobis.commons.dal.entities;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "cl_tabla", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "CatalogTable.findByTableName", query = "select ct from CatalogTable ct where ct.tableName = :tableName") })
/**
 * Class used to access the database using JPA
 * related table: cl_tabla, bdd: cobis
 * @author bbuendia
 *
 */
public class CatalogTable {

	@Id
	@Column(name = "codigo")
	private int code;
	@Column(name = "tabla")
	private String tableName;
	@Column(name = "descripcion")
	private String description;
	@OneToMany(mappedBy = "catalogTable")
	private List<Catalog> catalogs;

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<Catalog> getCatalogs() {
		return catalogs;
	}

	public void setCatalogs(List<Catalog> catalogs) {
		this.catalogs = catalogs;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + code;
		result = prime * result
				+ ((tableName == null) ? 0 : tableName.hashCode());
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
		CatalogTable other = (CatalogTable) obj;
		if (code != other.code)
			return false;
		if (tableName == null) {
			if (other.tableName != null)
				return false;
		} else if (!tableName.equals(other.tableName))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "CatalogTable [code=" + code + ", tableName=" + tableName
				+ ", description=" + description + "]";
	}
}
