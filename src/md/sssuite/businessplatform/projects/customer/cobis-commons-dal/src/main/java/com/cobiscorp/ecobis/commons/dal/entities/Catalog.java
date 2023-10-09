package com.cobiscorp.ecobis.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name = "cl_catalogo", schema = "cobis")
@IdClass(CatalogId.class)
@NamedQueries({
		@NamedQuery(name = "Catalog.findValidCatalogsByTableName", query = "select new  com.cobiscorp.ecobis.commons.dal.entities.Catalog(c.code, c.value, c.status, c.culture) from Catalog c where c.catalogTable.tableName = :tableName and c.status = 'V'"),
		@NamedQuery(name = "Catalog.countCatalogsByTableName", query = "Select count(c.code) from Catalog  c where c.catalogTable.tableName = :tableName"),
		@NamedQuery(name = "Catalog.getValue", query = "select c.value from Catalog c where c.code = :code and c.catalogTable.tableName = :tableName") })
/**
 * Class used to access the database using JPA
 * related table: cl_catalogo, bdd: cobis
 * @author bbuendia
 *
 */
public class Catalog {

	@Id
	@Column(name = "codigo")
	private String code;
	@Column(name = "valor")
	private String value;
	@Column(name = "estado")
	private String status;
	private String culture;
	@Id
	@ManyToOne
	@JoinColumn(name = "tabla", referencedColumnName = "codigo")
	private CatalogTable catalogTable;

	public Catalog() {
	}

	public Catalog(String code, String value, String status, String culture) {
		this.code = code.trim();
		this.value = value.trim();
		this.status = status;
		this.culture = culture;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCulture() {
		return culture;
	}

	public void setCulture(String culture) {
		this.culture = culture;
	}

	public CatalogTable getCatalogTable() {
		return catalogTable;
	}

	public void setCatalogTable(CatalogTable catalogTable) {
		this.catalogTable = catalogTable;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((catalogTable == null) ? 0 : catalogTable.hashCode());
		result = prime * result + ((code == null) ? 0 : code.hashCode());
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
		Catalog other = (Catalog) obj;
		if (catalogTable == null) {
			if (other.catalogTable != null)
				return false;
		} else if (!catalogTable.equals(other.catalogTable))
			return false;
		if (code == null) {
			if (other.code != null)
				return false;
		} else if (!code.equals(other.code))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Catalog [code=" + code + ", value=" + value + ", status="
				+ status + ", culture=" + culture + "]";
	}

}
