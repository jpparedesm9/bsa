package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Entity
@Table(name = "cl_catalogo", schema = "cobis")
@NamedQueries({ @NamedQuery(name = "Catalog.findByObservation", query = "select c from Catalog c where c.table.table = 'wf_observacion' and c.codigo= :codigo") })
public class Catalog implements Serializable {
	private static final long serialVersionUID = 1L;

	@EmbeddedId
	private IdCatalog idCatalog;

	@Column(name = "codigo")
	private String codigo;

	@Column(name = "valor")
	private String value;

	@Column(name = "estado")
	private String status;

	@Column(name = "culture")
	private String culture;

	@Column(name = "equiv_code")
	private String equivCode;

	@Column(name = "type")
	private String type;

	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "tabla", referencedColumnName = "codigo")
	private CobisTable table;

	public Catalog() {

	}

	/**
	 * @return the idCatalog
	 */
	public IdCatalog getIdCatalog() {
		return idCatalog;
	}

	/**
	 * @param idCatalog
	 *            the idCatalog to set
	 */
	public void setIdCatalog(IdCatalog idCatalog) {
		this.idCatalog = idCatalog;
	}

	/**
	 * @return the codigo
	 */
	public String getCodigo() {
		return codigo;
	}

	/**
	 * @param codigo
	 *            the codigo to set
	 */
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value
	 *            the value to set
	 */
	public void setValue(String value) {
		this.value = value;
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

	/**
	 * @return the culture
	 */
	public String getCulture() {
		return culture;
	}

	/**
	 * @param culture
	 *            the culture to set
	 */
	public void setCulture(String culture) {
		this.culture = culture;
	}

	/**
	 * @return the equivCode
	 */
	public String getEquivCode() {
		return equivCode;
	}

	/**
	 * @param equivCode
	 *            the equivCode to set
	 */
	public void setEquivCode(String equivCode) {
		this.equivCode = equivCode;
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
	 * @return the table
	 */
	public CobisTable getTable() {
		return table;
	}

	/**
	 * @param table
	 *            the table to set
	 */
	public void setTable(CobisTable table) {
		this.table = table;
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
		result = prime * result + ((idCatalog == null) ? 0 : idCatalog.hashCode());
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
		Catalog other = (Catalog) obj;
		if (idCatalog == null) {
			if (other.idCatalog != null)
				return false;
		} else if (!idCatalog.equals(other.idCatalog))
			return false;
		return true;
	}

}