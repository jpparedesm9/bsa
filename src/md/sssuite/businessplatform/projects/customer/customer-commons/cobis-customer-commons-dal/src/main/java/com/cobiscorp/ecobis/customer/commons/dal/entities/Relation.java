package com.cobiscorp.ecobis.customer.commons.dal.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "cl_relacion", schema = "cobis")
public class Relation {

	@Id
	@Column(name = "re_relacion")
	private Integer idRelation;

	@Column(name = "re_descripcion")
	private String description;

	@Column(name = "re_izquierda")
	private String left;

	@Column(name = "re_derecha")
	private String right;

	@Column(name = "re_tabla")
	private Integer table;

	@Column(name = "re_catalogo")
	private String catalog;

	@Column(name = "re_atributo")
	private byte attribute;

	public Relation() {
	}

	/**
	 * @return the idRelation
	 */
	public Integer getIdRelation() {
		return idRelation;
	}

	/**
	 * @param idRelation
	 *            the idRelation to set
	 */
	public void setIdRelation(Integer idRelation) {
		this.idRelation = idRelation;
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
	 * @return the left
	 */
	public String getLeft() {
		return left;
	}

	/**
	 * @param left
	 *            the left to set
	 */
	public void setLeft(String left) {
		this.left = left;
	}

	/**
	 * @return the right
	 */
	public String getRight() {
		return right;
	}

	/**
	 * @param right
	 *            the right to set
	 */
	public void setRight(String right) {
		this.right = right;
	}

	/**
	 * @return the table
	 */
	public Integer getTable() {
		return table;
	}

	/**
	 * @param table
	 *            the table to set
	 */
	public void setTable(Integer table) {
		this.table = table;
	}

	/**
	 * @return the catalog
	 */
	public String getCatalog() {
		return catalog;
	}

	/**
	 * @param catalog
	 *            the catalog to set
	 */
	public void setCatalog(String catalog) {
		this.catalog = catalog;
	}

	/**
	 * @return the attribute
	 */
	public byte getAttribute() {
		return attribute;
	}

	/**
	 * @param attribute
	 *            the attribute to set
	 */
	public void setAttribute(byte attribute) {
		this.attribute = attribute;
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
		result = prime * result + ((idRelation == null) ? 0 : idRelation.hashCode());
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
		Relation other = (Relation) obj;
		if (idRelation == null) {
			if (other.idRelation != null)
				return false;
		} else if (!idRelation.equals(other.idRelation))
			return false;
		return true;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		return "Relation [idRelation=" + idRelation + ", description=" + description + ", left=" + left + ", right=" + right + ", table=" + table
				+ ", catalog=" + catalog + ", attribute=" + attribute + "]";
	}

}
