package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Embeddable
public class IdCatalog implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "codigo")
	private String codigo;

	@Column(name = "tabla")
	private Integer idTable;

	public IdCatalog() {

	}

	public IdCatalog(String codigo, Integer idTable) {
		this.codigo = codigo;
		this.idTable = idTable;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((codigo == null) ? 0 : codigo.hashCode());
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
		IdCatalog other = (IdCatalog) obj;
		if (codigo == null) {
			if (other.codigo != null)
				return false;
		} else if (!codigo.equals(other.codigo))
			return false;
		if (idTable == null) {
			if (other.idTable != null)
				return false;
		} else if (!idTable.equals(other.idTable))
			return false;
		return true;
	}

}