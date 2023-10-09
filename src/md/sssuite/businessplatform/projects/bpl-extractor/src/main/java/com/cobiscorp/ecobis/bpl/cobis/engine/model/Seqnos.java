package com.cobiscorp.ecobis.bpl.cobis.engine.model;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "cl_seqnos", schema = "cobis")
public class Seqnos {

	@EmbeddedId
	private IdSeqnos idSeqnos;

	@Column(name = "bdatos")
	private String bdd;

	@Column(name = "tabla")
	private String table;

	@Column(name = "siguiente")
	private Integer next;

	@Column(name = "pkey")
	private String pkey;

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

	/**
	 * @return the next
	 */
	public Integer getNext() {
		return next;
	}

	/**
	 * @param next
	 *            the next to set
	 */
	public void setNext(Integer next) {
		this.next = next;
	}

	/**
	 * @return the pkey
	 */
	public String getPkey() {
		return pkey;
	}

	/**
	 * @param pkey
	 *            the pkey to set
	 */
	public void setPkey(String pkey) {
		this.pkey = pkey;
	}

	/**
	 * @return the idSeqnos
	 */
	public IdSeqnos getIdSeqnos() {
		return idSeqnos;
	}

	/**
	 * @param idSeqnos
	 *            the idSeqnos to set
	 */
	public void setIdSeqnos(IdSeqnos idSeqnos) {
		this.idSeqnos = idSeqnos;
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
		result = prime * result + ((idSeqnos == null) ? 0 : idSeqnos.hashCode());
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
		Seqnos other = (Seqnos) obj;
		if (idSeqnos == null) {
			if (other.idSeqnos != null)
				return false;
		} else if (!idSeqnos.equals(other.idSeqnos))
			return false;
		return true;
	}

}
