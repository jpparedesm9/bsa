package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.TableGenerator;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Entity
@Table(name = "cl_tabla", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "CobisTable.findByTableName", query = "select ct from CobisTable ct where ct.table = 'wf_observacion'"),
				@NamedQuery(name = "CobisTable.findByTable", query = "select ct from CobisTable ct where ct.table = :tabla")})
public class CobisTable implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@TableGenerator(name = "cl_tabla", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "cl_tabla")
	@GeneratedValue(strategy = GenerationType.TABLE, generator = "cl_tabla")
	@Column(name = "codigo")
	private Integer idTable;

	@Column(name = "tabla")
	private String table;

	@Column(name = "descripcion")
	private String description;

	@OneToMany(fetch = FetchType.LAZY, mappedBy = "table")
	private List<Catalog> catalogList = new ArrayList<Catalog>();

	public CobisTable() {

	}

	/**
	 * @return the idTable
	 */
	public Integer getIdTable() {
		return idTable;
	}

	/**
	 * @param idTable
	 *            the idTable to set
	 */
	public void setIdTable(Integer idTable) {
		this.idTable = idTable;
	}

	/**
	 * @return the table
	 */
	public String getTable() {
		return table;
	}

	/**
	 * @param table
	 *            the table to set
	 */
	public void setTable(String table) {
		this.table = table;
	}

	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}

	/**
	 * @param description
	 *            the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}

	/**
	 * @return the catalogList
	 */
	public List<Catalog> getCatalogList() {
		return catalogList;
	}

	/**
	 * @param catalogList
	 *            the catalogList to set
	 */
	public void setCatalogList(List<Catalog> catalogList) {
		this.catalogList = catalogList;
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
		result = prime * result + ((idTable == null) ? 0 : idTable.hashCode());
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
		CobisTable other = (CobisTable) obj;
		if (idTable == null) {
			if (other.idTable != null)
				return false;
		} else if (!idTable.equals(other.idTable))
			return false;
		return true;
	}

}