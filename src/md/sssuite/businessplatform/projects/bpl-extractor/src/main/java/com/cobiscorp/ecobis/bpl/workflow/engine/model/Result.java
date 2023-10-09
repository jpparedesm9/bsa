package com.cobiscorp.ecobis.bpl.workflow.engine.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

/**
 * The persistent class for the wf_resultado database table.
 * 
 */
@Entity
@Table(name = "wf_resultado", schema = "cob_workflow")
@NamedQueries({ @NamedQuery(name = "Result.findByAll", query = "select r from Result r"),
		@NamedQuery(name = "Result.findByName", query = "select r from Result r where UPPER(r.name)= UPPER(:name)") })
public class Result implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
//	@TableGenerator(name = "wf_resultado", initialValue = 100, allocationSize = 100, schema = "cobis", table = "cl_seqnos", pkColumnName = "tabla", valueColumnName = "siguiente", pkColumnValue = "wf_resultado")
//	@GeneratedValue(strategy = GenerationType.TABLE, generator = "wf_resultado")
	@Column(name = "rs_codigo_resultado")
	private Integer idResult;

	@Column(name = "rs_nombre_resultado")
	private String name;

	public Result() {

	}

	/**
	 * @return the idResult
	 */
	public Integer getIdResult() {
		return idResult;
	}

	/**
	 * @param idResult
	 *            the idResult to set
	 */
	public void setIdResult(Integer idResult) {
		this.idResult = idResult;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name
	 *            the name to set
	 */
	public void setName(String name) {
		this.name = name;
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
		result = prime * result + ((idResult == null) ? 0 : idResult.hashCode());
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
		Result other = (Result) obj;
		if (idResult == null) {
			if (other.idResult != null)
				return false;
		} else if (!idResult.equals(other.idResult))
			return false;
		return true;
	}

}