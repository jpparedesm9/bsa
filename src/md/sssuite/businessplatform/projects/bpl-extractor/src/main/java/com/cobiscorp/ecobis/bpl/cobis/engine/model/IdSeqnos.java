package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

/**
 * The persistent class for the wf_actividad database table.
 * 
 */
@Embeddable
public class IdSeqnos implements Serializable {
	private static final long serialVersionUID = 1L;

	@Column(name = "bdatos")
	private String bdd;

	@Column(name = "tabla")
	private String table;

	public IdSeqnos() {

	}

	/**
	 * @return the bdd
	 */
	public String getBdd() {
		return bdd;
	}

	/**
	 * @param bdd
	 *            the bdd to set
	 */
	public void setBdd(String bdd) {
		this.bdd = bdd;
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

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((bdd == null) ? 0 : bdd.hashCode());
		result = prime * result + ((table == null) ? 0 : table.hashCode());
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
		IdSeqnos other = (IdSeqnos) obj;
		if (bdd == null) {
			if (other.bdd != null)
				return false;
		} else if (!bdd.equals(other.bdd))
			return false;
		if (table == null) {
			if (other.table != null)
				return false;
		} else if (!table.equals(other.table))
			return false;
		return true;
	}

}